#!/bin/bash
source /home/nlaureanti/programas/lib.sh

#######################
## 2021
# Fonte: http://ftp.cptec.inpe.br/modelos/tempo/MERGE/GPM/DAILY/

dir_ftp='http://ftp.cptec.inpe.br/modelos/tempo/MERGE/GPM/DAILY/'

yr_ini=2020
yr_fn=2022
DIR_SAIDA="dados-merge"
mkdir -p ${DIR_SAIDA}


for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Download $yr iniciado${fim}\n"
    for mo in 01 02 03 04 05 06 07 08 09 10 11 12 ; do
            mkdir -p ${DIR_SAIDA}/${yr}/${mo}

        for dy in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 ; do

            a="${dir_ftp}${yr}/${mo}/MERGE_CPTEC_${yr}${mo}${dy}.ctl"
            ls ${DIR_SAIDA}/$(basename $a) || wget $a

            a="${dir_ftp}${yr}/${mo}/MERGE_CPTEC_${yr}${mo}${dy}.grib2"
            ls ${DIR_SAIDA}/$(basename $a) || wget $a

            a="${dir_ftp}${yr}/${mo}/MERGE_CPTEC_${yr}${mo}${dy}.idx"
            ls ${DIR_SAIDA}/$(basename $a) || wget $a


        done

            mv "MERGE_CPTEC_${yr}${mo}"* "${DIR_SAIDA}/${yr}/${mo}/"
    done
done

exit

