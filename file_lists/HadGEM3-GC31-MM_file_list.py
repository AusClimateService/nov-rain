"""Create HadGEM3-GC31-MM DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/MOHC/HadGEM3-GC31-MM/dcppA-hindcast'
for year in np.arange(1960, 2018 + 1):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f2/Amon/pr/gn/v20200417/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f2/Amon/pr/gn/v20200417/*.nc')
    infiles2.sort()
    with open('HadGEM3-GC31-MM_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles1 + infiles2:
            outfile.write(f"{item}\n")
