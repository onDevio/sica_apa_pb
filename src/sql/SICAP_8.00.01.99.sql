--Verificaci�n UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = '8.00.01'
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
--SCP-2557
IF EXISTS (SELECT * FROM var_globales WHERE texto='20150113' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2565. Se ha actualizado correctamente a la versi�n','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2565. NO se ha actualizado correctamente a la versi�n','N',@version)
	END
--
go