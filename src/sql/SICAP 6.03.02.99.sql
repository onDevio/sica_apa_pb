--Verificación UPDATER
declare @version varchar(10) 
select @version = "6.03.02" 

IF EXISTS (SELECT * FROM var_globales WHERE texto='20120502' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;