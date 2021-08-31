from datetime import datetime
from dateutil import tz

# Definindo as zonas de inicio e final
zona_inicial = tz.gettz('UTC')
zona_final = tz.gettz('America/Sao_Paulo') #verificar a tz em: https://en.wikipedia.org/wiki/Tz_database

# Definindo as horas
utc = datetime.strptime('2011-01-21 02:37:21', '%Y-%m-%d %H:%M:%S')   #formato para qualquer hora
#alternativamente:
#utc = datetime.strptime(str(datetime(2011, 1, 21, 2, 37,21)),'%Y-%m-%d %H:%M:%S')   #formato para qualquer hora

#usando a zona_inicial definida
utc = utc.replace(tzinfo=zona_inicial)  
print("Horário em UTC:                         ",utc)
#UTC_timestamp = float(utc.strftime("%s"))
#print("Horário em UTC (formato mili-seg):           ", UTC_timestamp)


#Conversão

#Convertendo para hora local
hora_local = utc.astimezone(zona_final)
print("Horário convertido para hora-local:      ",hora_local)
