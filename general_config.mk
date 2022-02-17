# General configuration for November rain analysis

PROJECT_DIR=/g/data/xv83/dbi599/nov-rain

VAR=pr
UNITS=${VAR}='mm month-1'
SHAPEFILE=${PROJECT_DIR}/AUS_2021_AUST_SHP_GDA2020.zip
SPATIAL_AGG=mean
TIME_AGG=sum
BIAS_METHOD=additive

GENERAL_IO_OPTIONS=--variables ${VAR} --spatial_coords -44 -11 113 154 --month 11 --shapefile ${SHAPEFILE} --spatial_agg ${SPATIAL_AGG} --units ${UNITS} --units_timing middle

OBS_TXT_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.txt
OBS_NC_DATA=${PROJECT_DIR}/data/pr_BoM_1900-2021_nov_aus-mean.nc
OBS_URL=http://www.bom.gov.au/climate/change/

DASK_CONFIG=dask_local.yml







