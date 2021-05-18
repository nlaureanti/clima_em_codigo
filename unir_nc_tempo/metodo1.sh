#!/usr/bin/python
#Criado por Nicole Laureanti - Clima em Código

"""import warnings
warnings.filterwarnings("ignore")"""
import numpy as np
from netCDF4 import Dataset


file1 = "hgt.1990.nc"
file2 = "hgt.1991.nc"

arq = Dataset(file1, "r")
#lendo arquivos de entrada

x = arq['lon'][:] 
y = arq['lat'][:] 
time = arq['time'][:]
levels = arq['level'][:]
nx = len(x) ;  ny = len(y); nt = len(time)  ;nn=len(levels)
print('nx',nx,'ny',ny,'nt',nt)

ncfile = Dataset(file1, 'r')
hgt1 = ncfile.variables['hgt'][:,:,:]
ncfile.close()

ncfile = Dataset(file2, 'r')
hgt2 = ncfile.variables['hgt'][:,:,:]
ncfile.close()

#iniciando o arquivo de saída
ncfile_out = Dataset('metodo1.nc', 'w')

#criando dimensões
lat_dim = ncfile_out.createDimension('lat', ny)     # latitude 
lon_dim = ncfile_out.createDimension('lon', nx)    # longitude 
time_dim = ncfile_out.createDimension('time', nt*2)
nivel_dim = ncfile_out.createDimension('level', nn)
for dim in ncfile_out.dimensions.items():
    print(dim)

#criando os parâmetros do arquivo
ncfile_out.title='Joined File'
lat = ncfile_out.createVariable('lat', np.float32, ('lat',))
lat.units = 'degrees'
lat.long_name = 'latitude'
lon = ncfile_out.createVariable('lon', np.float32, ('lon',))
lon.units = 'degrees'
lon.long_name = 'longitude'
time = ncfile_out.createVariable('time', np.float64, ('time',))
time.units = 'hours since 1991-01-01'
time.long_name = 'time'
level = ncfile_out.createVariable('level', np.float64, ('level',))
level.units = 'level'
level.long_name = 'level'
hgt = ncfile_out.createVariable('hgt',np.float64,('time','level','lat','lon'))
hgt.units = 'm' 
hgt.standard_name = 'hgt'

#teste
print(hgt.shape)
print(hgt1.shape)

#preenchendo os parâmetros do arquivo
hgt=hgt1+hgt2

ncfile_out.close()

