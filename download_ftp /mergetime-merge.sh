#!/bin/bash
source /home/nlaureanti/programas/lib.sh

#######################
## MAY 2021
yr_ini=2003
yr_fn=2020


cd tmp

for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Mergetime $yr iniciado${fim}\n"

    echo -ne "${sb} cdo -s -O mergetime ./tmp02.MERGE_CPTEC_${yr}* ./MERGE_CPTEC_${yr}.nc ${fim}"
    cdo -s -O mergetime ./tmp02.MERGE_CPTEC_${yr}* ./MERGE_CPTEC_${yr}.nc
done

cd -
exit


cdo -s -O mergetime tmp/MERGE_CPTEC_20* MERGE_CPTEC.nc

rm -f ./tmp/tmp*

