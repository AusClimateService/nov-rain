"""Create CMCC-CM2-SR5 DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/CMCC/CMCC-CM2-SR5/dcppA-hindcast'
for year in np.arange(1960, 2020):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v20210312/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v20210719/*.nc')
    infiles2.sort()
    infiles3 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/Amon/pr/gn/v20210719/*.nc')
    infiles3.sort()
    with open('CMCC-CM2-SR5_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2 + infiles3:
            outfile.write(f"{item}\n")

