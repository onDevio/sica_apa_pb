--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "9.03.01" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- 
IF EXISTS (SELECT * FROM var_globales WHERE texto='20160523' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
go