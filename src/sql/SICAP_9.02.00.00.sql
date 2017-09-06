insert into var_globales (nombre, texto, modificable, descripcion) values('ruta_WS_platforma','https://visados.ondevio.com/sica/ws', 'N', 'Ruta del webservice para la actualización de datos de la plataforma')
--
update expedientes set cerrado = 'N' where (cerrado is null or cerrado = '') and (f_cierre is null or f_cierre = '')
--
update expedientes set cerrado = 'S' where f_cierre is not null and (cerrado is null or cerrado = '') and (select count(*) from fases where fases.id_expedi = expedientes.id_expedi and estado in ('05', '06', 'VI', 'FN', 'FP', 'FR')) = 0
--
-- Resto de casos
update expedientes set cerrado = 'N' where (cerrado is null or cerrado = '')
go