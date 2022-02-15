# Configuration for November rain analysis

PROJECT_DIR=/g/data/xv83/dbi599/nov-rain

VAR=pr
UNITS=${VAR}='mm month-1'

SHAPEFILE=${PROJECT_DIR}/AUS_2021_AUST_SHP_GDA2020.zip
SPATIAL_AGG=mean

TIME_AGG=sum

BIAS_METHOD=additive
BASE_PERIOD=2004-01-01 2020-12-31

GENERAL_IO_OPTIONS=--variables ${VAR} --spatial_coords -44 -11 113 154 
TIME_IO_OPTIONS=--month 11 
SPATIAL_IO_OPTIONS=--shapefile ${SHAPEFILE} --spatial_agg ${SPATIAL_AGG}
IO_OPTIONS=${GENERAL_IO_OPTIONS} ${TIME_IO_OPTIONS} ${SPATIAL_IO_OPTIONS} --units ${UNITS} --units_timing middle

FCST_DATA_1990S := $(sort $(wildcard /g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-199[5,6,7,8,9]*/atmos_isobaric_month.zarr.zip))
FCST_DATA_2000S := $(sort $(wildcard /g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-2*/atmos_isobaric_month.zarr.zip))
FCST_DATA := ${FCST_DATA_1990S} ${FCST_DATA_2000S}
FCST_METADATA=/home/599/dbi599/unseen/config/dataset_cafe_monthly.yml
FCST_CLIMATOLOGY=${PROJECT_DIR}/data/${VAR}_cafe-c5-d60-pX-f6_2004-2019_annual-climatology.zarr.zip
FCST_ENSEMBLE_FILE=${PROJECT_DIR}/data/${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}.zarr.zip

OBS_TXT_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.txt
OBS_NC_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.nc
OBS_URL=http://www.bom.gov.au/climate/change/

INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}_bias-corrected-agcd-${BIAS_METHOD}.png

FCST_BIAS_FILE=${PROJECT_DIR}/data/${VAR}_cafe-c5-d60-pX-f6_20040501-20201101_${TIME_FREQ}_${REGION}-${SPATIAL_AGG}_bias-corrected-agcd-${BIAS_METHOD}.zarr.zip
SIMILARITY_FILE=${PROJECT_DIR}/data/ks-test_${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_${TIME_FREQ}_${REGION}-${SPATIAL_AGG}_bias-corrected-agcd-${BIAS_METHOD}.zarr.zip

DASK_CONFIG=dask_local.yml



