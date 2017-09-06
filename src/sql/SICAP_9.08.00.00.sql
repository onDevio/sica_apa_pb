insert into var_globales (nombre, texto, descripcion, modificable) values ('ruta_WS_calculo_gastos','https://excel-calc.ondevio.com/ws','Ruta del servicio de Cálculo de Gastos','N');
--
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATZ'
	BEGIN
		insert into var_globales (nombre, texto, descripcion, modificable) values ('g_utilizar_ws_calc_gastos','S','Variable para indicar el uso del servicio de Cálculo de Gastos','N')
	END
else
	BEGIN
		insert into var_globales (nombre, texto, descripcion, modificable) values ('g_utilizar_ws_calc_gastos','N','Variable para indicar el uso del servicio de Cálculo de Gastos','N')
	END
--
go
