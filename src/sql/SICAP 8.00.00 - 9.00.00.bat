@echo off

SET LOGFILE=%~dp0%log.txt

echo. >> %LOGFILE%
echo _____________________________________ >> %LOGFILE%
echo. >> %LOGFILE%


cls
Title Actualizacion version 9.00.00
:server
::cls
Echo Nombre del servidor=
set /p server=
if "%server%"=="" set server=MV_sybase_11

:usuario
::cls
Echo Nombre de usuario=
set /p user=sa
if "%user%"=="" set user=sa

:Password
::cls
Echo password=
set /p password=
echo %password%

:Base datos
::cls
Echo Base de datos =
set /p database=
if "%database%"=="" set database=sicap

SET ruta=%~dp0%colegiados.txt
bcp %database%..colegiados out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%var_globales.txt
bcp %database%..var_globales out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%contadores.txt
bcp %database%..contadores out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%csi_param_facturas.txt
bcp %database%..csi_param_facturas out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%csi_series.txt
bcp %database%..csi_series out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%musaat_cober_src.txt
bcp %database%..musaat_cober_src out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

SET ruta=%~dp0%registro_series.txt
bcp %database%..registro_series out %ruta% -c -U %user% -P %password% -S %server% >> log.txt

echo BCP realizados 
echo ¿Desea continuar? (y/n) :
set /p valor=
if "%valor%"=="" set valor= y
if %valor%== n goto fin


::  **** 8.00.01 *****
Echo Ejecuantando SICAP_8.00.01.00.sql
SET ruta=%~dp0%SICAP_8.00.01.00.sql
SET ruta_log=%~dp0%SICAP_8.00.01.00.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.00.01.98.sql
SET ruta=%~dp0%SICAP_8.00.01.98.sql
SET ruta_log=%~dp0%SICAP_8.00.01.98.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.00.01.99.sql
SET ruta=%~dp0%SICAP_8.00.01.99.sql
SET ruta_log=%~dp0%SICAP_8.00.01.99.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%


::  **** 8.02.00 *****
Echo Ejecuantando SICAP_8.02.00.00.sql
SET ruta=%~dp0%SICAP_8.02.00.00.sql
SET ruta_log=%~dp0%SICAP_8.02.00.00.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.02.00.98.sql
SET ruta=%~dp0%SICAP_8.02.00.98.sql
SET ruta_log=%~dp0%SICAP_8.02.00.98.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.02.00.99.sql
SET ruta=%~dp0%SICAP_8.02.00.99.sql
SET ruta_log=%~dp0%SICAP_8.02.00.99.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

::  **** 9.00.00 *****
Echo Ejecuantando SICAP_9.00.00.00.sql
SET ruta=%~dp0%SICAP_9.00.00.00.sql
SET ruta_log=%~dp0%SICAP_9.00.00.00.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_9.00.00.01.sql
SET ruta=%~dp0%SICAP_9.00.00.01.sql
SET ruta_log=%~dp0%SICAP_9.00.00.01.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_9.00.00.98.sql
SET ruta=%~dp0%SICAP_9.00.00.98.sql
SET ruta_log=%~dp0%SICAP_9.00.00.98.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_9.00.00.99.sql
SET ruta=%~dp0%SICAP_9.00.00.99.sql
SET ruta_log=%~dp0%SICAP_9.00.00.99.txt

echo isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U %user% -P %password% -S%server% -D%database% -i%ruta% -o%ruta_log%

echo _____________________________________ >> %LOGFILE%