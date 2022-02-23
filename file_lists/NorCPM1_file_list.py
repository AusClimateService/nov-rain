"""Create NorCPM1 DCPP file list."""

import glob
import os

import numpy as np

#outfile_i1 = 'NorCPM1-i1_dcppA-hindcast_files.txt'
#outfile_i2 = 'NorCPM1-i2_dcppA-hindcast_files.txt'
#os.system(f'rm {outfile_i1}')
#os.system(f'rm {outfile_i2}')

file_dir = '/g/data/oi10/replicas/CMIP6/DCPP/NCC/NorCPM1/dcppA-hindcast'

# 1987 only has 9 ensemble members (not 10) for i1

for year in np.arange(1960, 2018 + 1):
    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v20190914/*.nc')
    infiles1.sort()
    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/Amon/pr/gn/v20190914/*.nc')
    infiles2.sort()
    infiles3 = glob.glob(f'{file_dir}/s{year}-r?i2p1f1/Amon/pr/gn/v20190914/*.nc')
    infiles3.sort()
    infiles4 = glob.glob(f'{file_dir}/s{year}-r??i2p1f1/Amon/pr/gn/v20190914/*.nc')
    infiles4.sort()
    if year != 1987:
        with open('NorCPM1_dcppA-hindcast_files.txt', 'a') as outfile:
            for item in infiles1 + infiles2 + infiles3 + infiles4:
                outfile.write(f"{item}\n")

#for year in np.arange(1960, 2018 + 1):
#    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i1p1f1/Amon/pr/gn/v20190914/*.nc')
#    infiles1.sort()
#    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i1p1f1/Amon/pr/gn/v20190914/*.nc')
#    infiles2.sort()
#    if year != 1987:
#        with open(outfile_i1, 'a') as outfile:
#            for item in infiles1 + infiles2:
#                outfile.write(f"{item}\n")

#for year in np.arange(1960, 2018 + 1):
#    infiles1 = glob.glob(f'{file_dir}/s{year}-r?i2p1f1/Amon/pr/gn/v20190914/*.nc')
#    infiles1.sort()
#    infiles2 = glob.glob(f'{file_dir}/s{year}-r??i2p1f1/Amon/pr/gn/v20190914/*.nc')
#    infiles2.sort()
#    if year != 1987:
#        with open(outfile_i2, 'a') as outfile:
#            for item in infiles1 + infiles2:
#                outfile.write(f"{item}\n")
