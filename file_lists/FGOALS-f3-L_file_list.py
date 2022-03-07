"""Create FGOALS-f3-L DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/CAS/FGOALS-f3-L/dcppA-hindcast'
for year in np.arange(1960, 2017):
    infiles = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gr/v*/*.nc')
    infiles.sort()
    with open('FGOALS-f3-L_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles:
            outfile.write(f"{item}\n")
