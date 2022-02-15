"""Convert BoM txt files to netCDF"""

import argparse
import pdb

import cftime
import xarray as xr
import numpy as np

from unseen import fileio


def main(args):
    """Run the program."""

    with open(args.infile) as f:
        lines = f.readlines()

    times = []
    values = []
    for line in lines:
        date, value = line.split()
        year = int(date[0:4])
        month = int(date[4:])
        times.append(cftime.DatetimeJulian(year, month, 15))
        values.append(float(value))

    if args.var == 'pr':
        var_attrs = {'long_name': 'precipitation', 'units' : 'mm month-1'}
    else:
        raise ValueError("Invalid variable")

    ds = xr.Dataset(
        {
            'pr': xr.DataArray(
                data = np.array(values),
                dims = ['time'],
                coords = {'time': np.array(times)},
                attrs = var_attrs
            )
        },
            attrs = {
                'history': fileio.get_new_log(),
                'source': args.source
            }
        )
    ds['time'].attrs['long_name'] = 'time'
    
    ds.to_netcdf(args.outfile)
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__,
                                     argument_default=argparse.SUPPRESS,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
                                     
    parser.add_argument("infile", type=str, help="Input txt file")
    parser.add_argument("var", type=str, choices=('pr',), help="Data variable")
    parser.add_argument("source", type=str, help="URL for data download source")
    parser.add_argument("outfile", type=str, help="Output netCDF file")

    args = parser.parse_args()
    main(args)
