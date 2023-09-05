#!/opt/grads/2.0.a9/bin/grads -lbc 

#*=============================================================================================
#*This code reads outputs from the model available in specific dirs to one other unic file
undef=@UNDEF@
lev=@NIV@
datai='@DATAI@'
dataf='@DATAF@'
var='@VAR@'
saida='@SAIDA_DADOS@'
extensao='@EXT@'
exp='@EXP@'

lon_var=@DX@
lon_i=@lon_i@
lon_f=@lon_f@

lat_var=@DX@
lat_i=@lat_i@
lat_f=@lat_f@

#*=============================================================================================
'!mkdir -p /scratchin/grupos/apgmet/home/nicole.cristine/data/'exp'/'var
say 'period ' datai '-'dataf
yr=datai
while (yr<=dataf)
saida='/scratchin/grupos/apgmet/home/nicole.cristine/data//'exp'/'var'/'exp'_'var''lev'_'yr'.nc'
'openexp cgcm016 atmos AGCM daily 'yr' 10 01'


'q ctlinfo'
ctl=result
aux=sublin(ctl,3)
und=subwrd(aux,2)

'q file'
aux=sublin(result,7)
#var=subwrd(aux,1)

say 'var ' var

'q file'
aux=sublin(result,5)
nx=subwrd(aux,3)
ny=subwrd(aux,6)

say 'nx,ny 'nx' , 'ny
*### ARGUMENTO LAT/LON ###

* Vari�veis auxiliares para corre��o de coordenadas (meio ao inv�s de bordas)
passou_lon_i=1
passou_lon_f=1
passou_lat_i=1
passou_lat_f=1
* Fim vari�veis auxiliares
'set x 1 'nx
if (lon_i = "-");
     lon_i=subwrd(result,4);
     passou_lon_i=0
endif

if (lon_f = "-");
     lon_f=subwrd(result,5);
     passou_lon_f=0
endif

'set y 1 'ny
if (lat_i = "-");
     lat_i=subwrd(result,4);
     passou_lat_i=0
endif

if (lat_f = "-");
     lat_f=subwrd(result,5);
     passou_lat_f=0
endif
*#########################

*############### CALCULAR NLAT, NLON 
if ( lon_var <= 0 )
     say 'ERRO! regrid: invalid dlon=' lon_var
     return
else
     nlon = 1 + math_nint((lon_f-lon_i) / lon_var)
     say 'LON_REGRID_INFO#' nlon '#' lon_f '#'  lon_i '#' lon_var
endif
if ( lat_var <= 0 )
     say 'ERRO! regrid: invalid dlat=' lat_var
     return
else
     nlat = 1 + math_nint((lat_f-lat_i)/lat_var)
     say 'LAT_REGRID_INFO#' nlat '#' lat_f '#'  lat_i '#' lat_var
endif
*###################################################################


*############### ESCREVER O ARQUIVO 

'set undef file 'entrada
'set x 1 'nx
'set y 1 'ny
'set lev ' lev
say result


say 'inicio do display'
*'set fwrite 'saida
'set sdfwrite 'saida
*'set gxout fwrite'
say 'saida: 'saida
'set t 1 last'
*'set time 'datai' 'dataf
say result

if (undef!=0)
 'set undef 'undef
else
 
 'set undef 'undef
endif

say 'UNDEF 'undef

say 're('var','nlon',LINEAR,'lon_i','lon_var','nlat',LINEAR,'lat_i','lat_var',bs)'
'define v1  = re('var','nlon',LINEAR,'lon_i','lon_var','nlat',LINEAR,'lat_i','lat_var',bs)'
'sdfwrite v1'

*'disable fwrite'

'q dims'
say result

aux=sublin(result,5)
say 'Time ' aux
ti=subwrd(aux,11)
say 'ti 'ti 
tf=subwrd(aux,13)
say 'tf ' tf 

if (ti != '' | ti != 1)
nt_total=tf-ti+1
else
nt_total=1
endif


'close 1'
yr=yr+1
endwhile

say ''
say ''
say '-----------------------------------'
say 'NT_TOTAL:'nt_total
say ''
say 'COMECO CTL'
*say ctl
say 'FIM CTL'
say ''

'quit'

