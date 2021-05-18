#!/bin/bash

#Criado por Nicole Laureanti - Clima em Código

file1="hgt.1990.nc"
file2="hgt.1991.nc"

ncrcat $file1 $file2 -O metodo4.nc
