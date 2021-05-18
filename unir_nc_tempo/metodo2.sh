#!/usr/bin/python

#Criado por Nicole Laureanti - Clima em Código

import netCDF4
import numpy
import xarray

file1 = "hgt.1990.nc"
file2 = "hgt.1991.nc"
files = [file1,file2]
#ou files="hgt.199*.nc"
ds = xarray.open_mfdataset(files, concat_dim="time")


ds.to_netcdf('metodo2.nc')






