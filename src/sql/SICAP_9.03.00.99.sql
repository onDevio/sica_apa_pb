--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "9.03.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- 
IF EXISTS (SELECT * FROM var_globales WHERE texto='20160513' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
-- ONEVIO-28 
-- Se comprueba la creación del campo escalera en la tabla de fases. 
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'fases' AND syscolumns.name = 'escalera') = 1

	BEGIN
		insert testupdater (descripcion,ok,version) values('Ondevio-28. Se creó el campo escalera en la tabla fases','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('Ondevio-28. No se pudo crear el campo escalera en la tabla fases de la BBDD','N',@version)
	END

--
go