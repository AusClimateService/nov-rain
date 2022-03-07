"""Create BCC-CSM2-MR DCPP file list."""

import glob
import numpy as np

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/BCC/BCC-CSM2-MR/dcppA-hindcast'
for year in np.arange(1961, 2014 + 1):
    infiles = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v*/*.nc')
    infiles.sort()
    with open('BCC-CSM2-MR_dcppA-hindcast_files.txt', 'a') as outfile:
        for item in infiles:
            outfile.write(f"{item}\n")

# Need to manually delete /g/data/oi10/replicas/CMIP6/DCPP/BCC/BCC-CSM2-MR/dcppA-hindcast/s1962-r8i1p1f1/Amon/pr/gn/v20191209/pr_Amon_BCC-CSM2-MR_dcppA-hindcast_s1962-r8i1p1f1_gn_196201-197112.nc
