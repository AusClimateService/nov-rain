## November 2021 rainfall analysis

November 2021 was the wettest November on record for Australia.

### Observations

November rainfall data for Australia was downloaded from:  
http://www.bom.gov.au/climate/change/index.shtml#tabs=Tracker&tracker=timeseries&tQ=graph%3Drain%26area%3Daus%26season%3D11%26ave_yr%3D0

### Shapefile

The Australian Bureau of Statistics provides digital boundary files.
The boundaries for Australia (`AUS_2021_AUST_SHP_GDA2020.zip `)
were dowloaded from:  
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files

### Analysis

Step 1: Prepare the shapefile

```
$ papermill shapefile_preparation.ipynb
```

Step 2: Perform the UNSEEN analysis for any models that have a config file. e.g:

```
$ make analysis MODEL_CONFIG=config_CanESM5.mk
```


