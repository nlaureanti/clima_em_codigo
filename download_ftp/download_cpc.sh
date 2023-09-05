#!/bin/sh
source /home/nlaureanti/programas/lib.sh

yr_ini=2016
yr_fn=2019

mkdir -p down1

for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Download $yr iniciado${fim}\n"
    a="ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.${yr}.nc"
    wget $a

done
