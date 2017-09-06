--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = '9.00.00'
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
IF EXISTS (SELECT * FROM var_globales WHERE texto='20151230' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión 9.00.00','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('NO se ha actualizado correctamente a la versión 9.00.00','N',@version)
	END
--
go