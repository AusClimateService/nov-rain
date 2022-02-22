"""Create CanESM5 DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/CCCma/CanESM5/dcppA-hindcast'
for year in np.arange(1960, 2017):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p2f1/Amon/pr/gn/v20190429/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p2f1/Amon/pr/gn/v20190429/*.nc')
    infiles2.sort()
    with open('CanESM5_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2:
            outfile.write(f"{item}\n")
