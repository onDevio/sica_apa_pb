--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "9.03.02" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
-- 
IF EXISTS (SELECT * FROM trabajos WHERE c_trabajo='91')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se comprueba que el tipo de destino 91 existe','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No existe el tipo de destino 91. Revisar','N',@version)
	END
-- 
IF EXISTS (SELECT * FROM tipos_trabajos WHERE c_t_trabajo='99')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se comprueba que el tipo de obra 99 existe','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No existe el tipo de obra 99. Revisar','N',@version)
	END
--
--
IF EXISTS (SELECT * FROM var_globales WHERE texto='20160526' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
go