@echo off

SET LOGFILE=%~d0%~p0log.txt

echo. >> %LOGFILE%
echo _____________________________________ >> %LOGFILE%
echo. >> %LOGFILE%


cls
Title Actualizacion version 8.00.00
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

Echo Ejecuantando SICAP_8.00.00.00.sql
SET ruta=%~d0%~p0SICAP_8.00.00.00.sql
SET ruta_log=%~d0%~p0SICAP_8.00.00.00.txt

echo isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.00.00.01.sql
SET ruta=%~d0%~p0SICAP_8.00.00.01.sql
SET ruta_log=%~d0%~p0SICAP_8.00.00.01.txt

echo isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.00.00.98.sql
SET ruta=%~d0%~p0SICAP_8.00.00.98.sql
SET ruta_log=%~d0%~p0SICAP_8.00.00.98.txt

echo isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log%

Echo Ejecuantando SICAP_8.00.00.99.sql
SET ruta=%~d0%~p0SICAP_8.00.00.99.sql
SET ruta_log=%~d0%~p0SICAP_8.00.00.99.txt

echo isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log% >> %LOGFILE%
isql -U%user% -P%password% -S%server% -D%database% -i%ruta% -o%ruta_log%

echo _____________________________________ >> %LOGFILE%