--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "9.07.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
IF EXISTS (SELECT * FROM var_globales WHERE texto='20170223' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values(convert(varchar,getdate(), 101) + '. Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values(convert(varchar,getdate(), 101) + '. No se ha actualizado correctamente a la versión','N',@version)
	END
--
go