#!/bin/bash
source /scratchin/grupos/apgmet/home/nicole.cristine/programas/lib.sh

raiz_dados='/scratchin/grupos/apgmet/home/nicole.cristine/data/'
undef='-9999.99'
experimentos='cgcm016 agcm016'

for exp in ${experimentos} ; do
    
	case $exp in 
	exp208) v_variaveis=('omeg' 'prec' 'tsfc' 'vvel' 'uvel'); datai='01jan997'; dataf='31dec2016';;
	cgcm059) v_variaveis=('omtm' 'prec' 't2mt' 'vvmt' 'uvmt'); datai='01jan2011'; dataf='31dec2030';;
	cgcm060) v_variaveis=('omtm' 'prec' 't2mt' 'vvmt' 'uvmt'); datai='01jan2007'; dataf='31dec2026';;
	cgcm016) v_variaveis=('uvel' 'vvel' 'tems' 'role' 'swrh' 'zgeo'); datai='2001';dataf='2009';hind=1;;
	agcm016) v_variaveis=('uvel' 'vvel' 'tems' 'role' 'swrh' 'zgeo'); datai='2001';dataf='2009';hind=1;;
	esac
	
    for v in ${v_variaveis[@]} ; do 
        case $v in 
            prec ) nivel=( '1000' ); dx_var=('1.0' );;
            omeg | omtm ) nivel=( '500' );  dx_var=( '1.0' );;
            vvel | uvel | vvmt | uvmt ) nivel=( '850' '200' );  dx_var=( '1.0' );;
	    zgeo  ) nivel=( '950' '200' );  dx_var=( '1.0' );;
            tsfc | t2mt | tems | role |swrh ) nivel=( '1000' );  dx_var=( '1.0' );;
        esac
    
    for niv in ${nivel[@]} ; do

    
        for dx in ${dx_var[@]} ; do
            if [[ $dx  == '1.0' ]]; then
                ext='nc'
                lon_i=0
                lon_f=360
                lat_i=-90
                lat_f=90                
            else
                ext='bin'
                lon_i='0'
                lon_f='360'
                lat_i='-90'
                lat_f='90'                 
            fi
            
            if [[ $v == 'u'* || $v == "v"* ]] ; then
		v_1=$(echo $v | cut -c1-1)
		echo $v_1
		saida_dados="$raiz_dados/$exp/${v_1}/${exp}_${v}${niv}_${dx}.${ext}"
	        mkdir -p $raiz_dados/$exp/${v_1}/
	    else	
                saida_dados="$raiz_dados/$exp/${v}/${v}${niv}_${dx}.${ext}"
                mkdir -p $raiz_dados/$exp/${v}/
	    fi
        if [[ $hind == 1 ]] ; then
		template=template.${exp}.convertgrib.gs
	else
		template=template.convertgrib.gs
	fi
    			sed "
				s#@SAIDA_DADOS@#${saida_dados}#g;
				s#@EXT@#${ext}#g;
				s#@EXP@#${exp}#g;
				s#@VAR@#${v}#g;
				s#@EXP@#${exp}#g;
				s#@NIV@#${niv}#g;				
				s#@UNDEF@#${undef}#g;
				s#@DATAI@#${datai}#g;
				s#@DATAF@#${dataf}#g;
				s#@DX@#${dx}#g;				
				s#@lon_i@#${lon_i}#g;
				s#@lon_f@#${lon_f}#g;
				s#@lat_i@#${lat_i}#g;
				s#@lat_f@#${lat_f}#g;												
			" $template > 740tmp.gs
			
		echo -ne "${bg_vm}\nOPTIONS: ------${fim} \n\tVARIAVEL: ${v} \n\tPERIOD: ${datai}-${dataf}\n\tEXP: ${exp}\n\tSAIDA:${saida_dados}\n"
	chmod 740 ./740tmp.gs
	ls $saida_dados ||  ./740tmp.gs
	done
	done
			
    done
			
done

