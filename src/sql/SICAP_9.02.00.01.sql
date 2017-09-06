declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
IF @colegio = 'COAATTER'
	BEGIN
		Insert into var_globales (nombre, sn, descripcion, modificable) values('g_fact_set_original_envio_correo', 'S', 'permite ocultar los campos indicativos de si es una copia para el envío por correo', 'S')
	END
ELSE
	BEGIN
		Insert into var_globales (nombre, sn, descripcion, modificable) values('g_fact_set_original_envio_correo', 'N', 'permite ocultar los campos indicativos de si es una copia para el envío por correo', 'S')
	END
--
go