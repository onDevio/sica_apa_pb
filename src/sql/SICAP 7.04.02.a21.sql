--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "7.04.02a2" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- SCP-2475
IF EXISTS (SELECT * FROM var_globales WHERE texto='20140402' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;