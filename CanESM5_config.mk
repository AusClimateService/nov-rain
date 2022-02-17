include general_config.mk

MODEL=CanESM5

IO_OPTIONS=${GENERAL_IO_OPTIONS}
MIN_LEAD=3
BASE_PERIOD=2004-01-01 2020-12-31

FCST_DATA=CanESM5_DCPP_files.txt
FCST_ENSEMBLE_FILE=${PROJECT_DIR}/data/${VAR}_CanESM5-dcppA-hindcast_196101-201701_nov_aus-${SPATIAL_AGG}.zarr.zip

INDEPENDENCE_PLOT=${PROJECT_DIR}/figures/independence-test_${VAR}_CanESM5-dcppA-hindcast_196101-201701_nov_aus-${SPATIAL_AGG}.png

FCST_BIAS_FILE=${PROJECT_DIR}/data/${VAR}_CanESM5-dcppA-hindcast_196101-201701_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip
SIMILARITY_FILE=${PROJECT_DIR}/data/ks-test_${VAR}_CanESM5-dcppA-hindcast_196101-201701_nov_aus-${SPATIAL_AGG}_bias-corrected-BoM-${BIAS_METHOD}.zarr.zip
