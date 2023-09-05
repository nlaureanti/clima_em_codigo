#!/bin/bash
source /home/nlaureanti/programas/lib.sh

#######################
## 2021
# Fonte: https://psl.noaa.gov/data/gridded/data.ncep.reanalysis2.pressure.html
# OLR: https://psl.noaa.gov/data/gridded/data.olrcdr.interp.html

yr_ini=2020
yr_fn=2020
DIR_SAIDA="dados-ncep"
mkdir -p ${DIR_SAIDA}

#falta 2017

for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Download $yr iniciado${fim}\n"
#
#    a="ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_precip/precip.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a

#    a="ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis2.dailyavgs/pressure/vwnd.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a

#
#    a="ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis2.dailyavgs/pressure/vwnd.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a
#

#    a="ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis2/surface/mslp${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a


#    a="ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis2.dailyavgs/pressure/hgt.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a
#
#    a="ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis2.dailyavgs/pressure/omega.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a

#    a="ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis2/pressure/rhum.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a


#    a="ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis2/pressure/air.${yr}.nc"
#    ls ${DIR_SAIDA}/$(basename $a) || wget $a

    a="ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis2.dailyavgs/pressure/uwnd.${yr}.nc"
    ls ${DIR_SAIDA}/$(basename $a) || wget $a

	mv *${yr}.nc ${DIR_SAIDA}

done

    a="ftp://ftp.cdc.noaa.gov/Datasets/olrcdr/olr.day.mean.nc" #atualizado 2021
    ls ${DIR_SAIDA}/$(basename $a) || wget $a


exit



    a="ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis2/surface/mslp${yr}.nc"
    ls $(basename $a) || wget $a
