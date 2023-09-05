#!/bin/bash
source /home/nicole/programas/lib.sh

#######################
## 2021
# Fonte: http://ftp.cptec.inpe.br/modelos/tempo/MERGE/GPM/DAILY/


yr_ini=2020
yr_fn=2022
DIR_OUTPUT="nc"
mkdir -p ${DIR_OUTPUT}


for yr in $(seq $yr_ini $yr_fn); do
#for yr in $(seq 2011 $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Converte $yr iniciado${fim}\n"
    for mo in 01 02 03 04 05 06 07 08 09 10 11 12 ; do
            mkdir -p ./${yr}/${mo}
            DIR_INPUT="./${yr}/${mo}"
        for dy in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 ; do

        wgrib2 $DIR_INPUT/MERGE_CPTEC_${yr}${mo}${dy}.grib2 -netcdf $DIR_OUTPUT/tmp01.MERGE_CPTEC_${yr}${mo}${dy}.nc
        cdo -s -chname,PREC_surface,prec -selname,PREC_surface $DIR_OUTPUT/tmp01.MERGE_CPTEC_${yr}${mo}${dy}.nc $DIR_OUTPUT/tmp02.MERGE_CPTEC_${yr}${mo}${dy}.nc
        
        done
    done
done

rm ./$DIR_OUTPUT/tmp01.MERGE_CPTEC_*
cd $DIR_OUTPUT

for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Mergetime $yr iniciado${fim}\n"

    echo -ne "${sb} cdo -s -O mergetime ./tmp02.MERGE_CPTEC_${yr}* ./tmp03.MERGE_CPTEC_${yr}.nc ${fim}\n"
    cdo -s -O mergetime ./tmp02.MERGE_CPTEC_${yr}* ./tmp03.MERGE_CPTEC_${yr}.nc
done

rm ./$DIR_OUTPUT/tmp02.MERGE_CPTEC_*
limpar_memoria

echo -ne "\n${sb}${ng}${ps}${br}${bg_ci}Mergetime ${yr_ini}-${yr_fn} iniciado${fim}\n"
cdo -s -O mergetime tmp03.MERGE_CPTEC_* MERGE_CPTEC_${yr_ini}-${yr_fn}.nc
    rm tmp03.MERGE_CPTEC_*
cd -

