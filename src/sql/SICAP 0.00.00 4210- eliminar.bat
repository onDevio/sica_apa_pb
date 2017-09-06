@echo off
set password=
set basedatos=sicap

set /p servidor=Nombre del servidor:
set /p password=Password de SA[%password%]:
set /p basedatos=Nombre de la base de datos[%basedatos%]:

isql -Usa -P%password% -S%servidor% -D%basedatos% -iv4210.txt -ooutput_v4210.txt
