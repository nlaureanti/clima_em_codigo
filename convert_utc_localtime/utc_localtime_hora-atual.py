from dateutil import tz

# Definindo as zonas de inicio e final
zona_inicial = tz.gettz('UTC')
zona_final = tz.gettz('America/Sao_Paulo') #verificar a tz em: https://en.wikipedia.org/wiki/Tz_database

# Definindo as horas para a hora atual
from datetime import datetime
utc = datetime.utcnow()     #para hora atual

#usando a zona_inicial definida
utc = utc.replace(tzinfo=zona_inicial)  
print("Horário em UTC:                         ",utc)
UTC_timestamp = float(utc.strftime("%s"))
print("Horário em UTC (formato mili-seg):           ", UTC_timestamp)


#Conversão

#Convertendo para hora local
hora_local = utc.astimezone(zona_final)
print("Horário convertido para hora-local:      ",hora_local)


#Para conferir
import time
Local = time.time()
print("Horário local:", datetime.fromtimestamp(Local))
