#!/bin/bash
source /home/nlaureanti/programas/lib.sh

#######################
## 2021



yr_ini=1995
yr_fn=2010
DIR_SAIDA="dados-era5"
mkdir -p ${DIR_SAIDA}

#falta 2017

for yr in $(seq $yr_ini $yr_fn) ; do
    echo -ne "${sb}${ng}${ps}${br}${bg_ci}Download $yr iniciado${fim}\n"

    a="http://ftp1.cptec.inpe.br/pesquisa/grpeta/sazonal/ERA5/SST/ERA5_SST_${yr}.nc"
    ls ${DIR_SAIDA}/$(basename $a) || wget $a

	mv *${yr}.nc ${DIR_SAIDA}

done

exit
