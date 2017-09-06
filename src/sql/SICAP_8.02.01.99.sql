--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = '8.02.01'
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
--SCP-2573
IF EXISTS (SELECT * FROM var_globales WHERE texto='20150605' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2573. Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2573. NO se ha actualizado correctamente a la versión','N',@version)
	END
--
go