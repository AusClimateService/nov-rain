"""Create MIROC6 DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/MIROC/MIROC6/dcppA-hindcast'
for year in np.arange(1960, 2022):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v*/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/Amon/pr/gn/v*/*.nc')
    infiles2.sort()
    with open('MIROC6_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2:
            outfile.write(f"{item}\n")
