include general_config.mk

MODEL=CAFE

IO_OPTIONS=${GENERAL_IO_OPTIONS} --scale_factors pr=days_in_month
MIN_LEAD=3
BASE_PERIOD=2004-01-01 2020-12-31

FCST_DATA_1990S := $(sort $(wildcard /g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-199[5,6,7,8,9]*/atmos_isobaric_month.zarr.zip))
FCST_DATA_2000S := $(sort $(wildcard /g/data/xv83/dcfp/CAFE-f6/c5-d60-pX-f6-2*/atmos_isobaric_month.zarr.zip))
FCST_DATA := ${FCST_DATA_1990S} ${FCST_DATA_2000S}
FCST_METADATA=--metadata_file /home/599/dbi599/forks/unseen/config/dataset_cafe_monthly.yml
FCST_ENSEMBLE_FILE=${PROJECT_DIR}/data/${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}.zarr.zip

INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}.png

FCST_BIAS_FILE=${PROJECT_DIR}/data/${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip
SIMILARITY_FILE=${PROJECT_DIR}/data/ks-test_${VAR}_cafe-c5-d60-pX-f6_19950501-20201101_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip

