-- COAATMU-52 - ONDEVIO-35
--
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATMU'
	begin
		insert into var_globales (nombre, texto, descripcion, modificable) values('g_banco_defecto_plataforma', '02', 'Código del banco por defecto empleado en la plataforma', 'S')
	end
else 
	begin
		insert into var_globales (nombre, texto, descripcion, modificable) select 'g_banco_defecto_plataforma', texto, 'Código del banco por defecto empleado en la plataforma', 'S' from var_globales where nombre = 'g_banco_por_defecto'
	end 
go