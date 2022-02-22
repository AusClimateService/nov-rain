"""Create IPSL-CM6A-LR DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/IPSL/IPSL-CM6A-LR/dcppA-hindcast'
for year in np.arange(1960, 2016 + 1):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gr/v20200108/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/Amon/pr/gr/v20200108/*.nc')
    infiles2.sort()
    with open('IPSL-CM6A-LR_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2:
            outfile.write(f"{item}\n")
