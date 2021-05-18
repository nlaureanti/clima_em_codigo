#!/bin/bash

#Criado por Nicole Laureanti - Clima em Código

file1="hgt.1990.nc"
file2="hgt.1991.nc"

cdo mergetime $file1 $file2 metodo3.nc
#or with wildcards
#cdo mergetime precip?.nc merged_file.nc 

#You can add another step from the command line to extract the location of choice by using
#
#cdo remapnn,lon=X/lat=Y merged_file.nc my_location.nc
#this picks out the gridcell nearest to your specified lon/lat (X,Y) coordinate, or you can use bilinear interpolation if you prefer:
#
#cdo remapbil,lon=X/lat=Y merged_file.nc my_location.nc 
