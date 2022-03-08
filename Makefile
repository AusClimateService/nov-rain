.PHONY: help format-obs process-forecast independence-test bias-correction similarity-test analysis

include ${MODEL_CONFIG}
#Model config file needs to define MODEL, MODEL_IO_OPTIONS (optional) MIN_LEAD,
#BIAS_METHOD, BASE_PERIOD, BASE_PERIOD_TEXT and TIME_PERIOD_TEXT

PROJECT_DIR=/g/data/xv83/dbi599/nov-rain
VAR=pr
UNITS=${VAR}='mm month-1'
SHAPEFILE=${PROJECT_DIR}/shapefiles/australia.shp
SPATIAL_AGG=mean
TIME_AGG=sum
BIAS_METHOD=multiplicative
DASK_CONFIG=dask_local.yml
IO_OPTIONS=--variables ${VAR} --spatial_coords -44 -11 113 154 --month 11 --shapefile ${SHAPEFILE} --spatial_agg ${SPATIAL_AGG} --units ${UNITS} --units_timing middle ${MODEL_IO_OPTIONS}
OBS_TXT_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.txt
OBS_NC_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.nc
OBS_URL=http://www.bom.gov.au/climate/change/
FCST_DATA=file_lists/${MODEL}_${EXPERIMENT}_files.txt
FCST_ENSEMBLE_FILE=${PROJECT_DIR}/data/${VAR}_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_nov_aus-${SPATIAL_AGG}.zarr.zip
INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_${VAR}_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_nov_aus-${SPATIAL_AGG}.png
FCST_BIAS_FILE=${PROJECT_DIR}/data/${VAR}_${MODEL}-${EXPERIMENT}_${TIME_PERIOD_TEXT}_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip
SIMILARITY_BIAS_FILE=${PROJECT_DIR}/data/ks-test_${VAR}_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip
SIMILARITY_RAW_FILE=${PROJECT_DIR}/data/ks-test_${VAR}_${MODEL}-${EXPERIMENT}_${BASE_PERIOD_TEXT}_nov_aus-${SPATIAL_AGG}_BoM.zarr.zip


## format-obs : txt to nc
format-obs : ${OBS_NC_DATA}
${OBS_NC_DATA} : ${OBS_TXT_DATA}
	python bom_txt_to_nc.py $< ${VAR} ${OBS_URL} $@ 

## model-file-list : create a list of model files for processing
model-file-list : ${FCST_DATA}
${FCST_DATA} :
	python file_lists/${MODEL}_file_list.py

## process-forecast : preprocessing of CAFE forecast ensemble
process-forecast : ${FCST_ENSEMBLE_FILE}
${FCST_ENSEMBLE_FILE} : ${FCST_DATA}
	fileio $< $@ --forecast ${IO_OPTIONS} --reset_times --output_chunks lead_time=50 --dask_config ${DASK_CONFIG} --verbose

## independence-test : independence test for different lead times
independence-test : ${INDEPENDENCE_PLOT}
${INDEPENDENCE_PLOT} : ${FCST_ENSEMBLE_FILE}
	independence $< ${VAR} $@

## bias-correction : bias corrected forecast data using observations
bias-correction : ${FCST_BIAS_FILE}
${FCST_BIAS_FILE} : ${FCST_ENSEMBLE_FILE} ${OBS_NC_DATA}
	bias_correction $< $(word 2,$^) ${VAR} ${BIAS_METHOD} $@ --base_period ${BASE_PERIOD} --rounding_freq A --min_lead ${MIN_LEAD}

## similarity-test-bias : similarity test between observations and bias corrected forecast
similarity-test-bias : ${SIMILARITY_BIAS_FILE}
${SIMILARITY_BIAS_FILE} : ${FCST_BIAS_FILE} ${OBS_NC_DATA}
	similarity $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD}

## similarity-test-raw : similarity test between observations and raw forecast
similarity-test-raw : ${SIMILARITY_RAW_FILE}
${SIMILARITY_RAW_FILE} : ${FCST_ENSEMBLE_FILE} ${OBS_NC_DATA}
	similarity $< $(word 2,$^) ${VAR} $@ --reference_time_period ${BASE_PERIOD}

## analysis : do the final analysis
analysis : analysis/analysis_${MODEL}.ipynb
analysis/analysis_${MODEL}.ipynb : analysis/analysis.ipynb ${OBS_NC_DATA} ${FCST_ENSEMBLE_FILE} ${FCST_BIAS_FILE} ${SIMILARITY_BIAS_FILE} ${SIMILARITY_RAW_FILE} ${INDEPENDENCE_PLOT}
	papermill -p bom_file $(word 2,$^) -p model_file $(word 3,$^) -p model_bc_file $(word 4,$^) -p similarity_bc_file $(word 5,$^) -p similarity_raw_file $(word 6,$^) -p independence_plot $(word 7,$^) -p model_name ${MODEL} -p min_lead ${MIN_LEAD} $< $@

## help : show this message
help :
	@echo 'make [target] [-Bnf] MODEL_CONFIG=config_file.mk'
	@echo ''
	@echo 'valid targets:'
	@grep -h -E '^##' ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ':'
