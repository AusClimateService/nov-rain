"""Create EC-Earth3 DCPP file list."""

import glob
import numpy as np

# 2018 is left out because it does not have i2 files

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/EC-Earth-Consortium/EC-Earth3/dcppA-hindcast/'
for year in np.arange(1960, 2017 + 1):
    infiles1 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20201216/*.nc')
    infiles2 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20201215/*.nc')
    infiles3 = glob.glob(f'{file_dir}/s{year}-*/Amon/pr/gr/v20200508/*.nc')
    infiles = infiles1 + infiles2 + infiles3
    assert len(infiles) == 15 * 11, f'Wrong number of files for year {year}'
    infiles.sort()
    with open('EC-Earth3_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles:
            outfile.write(f"{item}\n")
