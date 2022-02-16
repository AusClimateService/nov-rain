.PHONY: help format-obs process-forecast independence-test

include ${CONFIG}

#PLOT_PARAMS=plotparams_publication.yml


## format-obs : txt to nc
format-obs : ${OBS_NC_DATA}
${OBS_NC_DATA} : ${OBS_TXT_DATA}
	python bom_txt_to_nc.py $< ${VAR} ${OBS_URL} $@ 

## process-forecast : preprocessing of CAFE forecast ensemble
process-forecast : ${FCST_ENSEMBLE_FILE}
${FCST_ENSEMBLE_FILE} : ${FCST_METADATA}
	fileio ${FCST_DATA} $@ --forecast --metadata_file $< ${IO_OPTIONS} --reset_times --output_chunks lead_time=50 --dask_config ${DASK_CONFIG}

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

## final-analysis : do the final analysis
#final-analysis : ag_analysis_${SUB_REGION}.ipynb
#ag_analysis_${SUB_REGION}.ipynb : ag_analysis.ipynb    
#	papermill -p agcd_file ${OBS_PROCESSED_FILE} -p cafe_file ${FCST_ENSEMBLE_FILE} -p cafe_bc_file ${FCST_BIAS_FILE} -p fidelity_file ${SIMILARITY_FILE} -p independence_plot ${INDEPENDENCE_PLOT} -p region ${SUB_REGION} $< $@

## help : show this message
help :
	@echo 'make [target] [-Bnf] CONFIG=config_file.mk'
	@echo ''
	@echo 'valid targets:'
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'