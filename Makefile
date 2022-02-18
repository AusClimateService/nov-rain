.PHONY: help format-obs process-forecast independence-test bias-correction similarity-test analysis

include ${CONFIG}

## format-obs : txt to nc
format-obs : ${OBS_NC_DATA}
${OBS_NC_DATA} : ${OBS_TXT_DATA}
	python bom_txt_to_nc.py $< ${VAR} ${OBS_URL} $@ 

## process-forecast : preprocessing of CAFE forecast ensemble
process-forecast : ${FCST_ENSEMBLE_FILE}
${FCST_ENSEMBLE_FILE} :
	fileio ${FCST_DATA} $@ --forecast $< ${IO_OPTIONS} --reset_times --output_chunks lead_time=50 --dask_config ${DASK_CONFIG}

## independence-test : independence test for different lead times
independence-test : ${INDEPENDENCE_PLOT}
${INDEPENDENCE_PLOT} : ${FCST_ENSEMBLE_FILE}
	independence $< ${VAR} $@

## bias-correction : bias corrected forecast data using observations
bias-correction : ${FCST_BIAS_FILE}
${FCST_BIAS_FILE} : ${FCST_ENSEMBLE_FILE} ${OBS_NC_DATA}
	bias_correction $< $(word 2,$^) ${VAR} ${BIAS_METHOD} $@ --base_period ${BASE_PERIOD} --rounding_freq A --min_lead ${MIN_LEAD}

## similarity-test : similarity test between observations and bias corrected forecast
similarity-test : ${SIMILARITY_FILE}
${SIMILARITY_FILE} : ${FCST_BIAS_FILE} ${OBS_NC_DATA}
	similarity $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD}

## analysis : do the final analysis
analysis : analysis_${MODEL}.ipynb
analysis_${MODEL}.ipynb : analysis.ipynb ${OBS_NC_DATA} ${FCST_ENSEMBLE_FILE} ${FCST_BIAS_FILE} ${SIMILARITY_FILE} ${INDEPENDENCE_PLOT}
	papermill -p bom_file $(word 2,$^) -p model_file $(word 3,$^) -p model_bc_file $(word 4,$^) -p fidelity_file $(word 5,$^) -p independence_plot $(word 6,$^) -p model_name ${MODEL} -p min_lead ${MIN_LEAD} $< $@

## help : show this message
help :
	@echo 'make [target] [-Bnf] CONFIG=config_file.mk'
	@echo ''
	@echo 'valid targets:'
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'
