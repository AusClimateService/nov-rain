"""Create EC-Earth3 DCPP file list."""

import glob
import numpy as np

# 2018 is left out because it does not have i2 files
# 1976 is left out because the time variable of the following file has a time calendar that
# is "proleptic_gregorian" instead of "gregorian" so open_mfdataset can't merge them
#/g/data/oi10/replicas/CMIP6/DCPP/EC-Earth-Consortium/EC-Earth3/dcppA-hindcast/s1976-r3i1p1f1/Amon/pr/gr/v20201215/pr_Amon_EC-Earth3_dcppA-hindcast_s1976-r3i1p1f1_gr_198611-198710.nc

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/EC-Earth-Consortium/EC-Earth3/dcppA-hindcast/'
for year in np.arange(1960, 2017 + 1):
    if year != 1976:
        infiles1 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20201216/*.nc')
        infiles2 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20201215/*.nc')
        infiles3 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20200508/*.nc')
        infiles = infiles1 + infiles2 + infiles3
        assert len(infiles) == 15 * 11, f'Wrong number of files for year {year}'
        infiles.sort()
        with open('EC-Earth3_dcppA-hindcast_files.txt', 'a') as outfile:
            for item in infiles:
                outfile.write(f"{item}\n")
