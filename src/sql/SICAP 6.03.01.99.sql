--Verificación UPDATER
declare @version varchar(10) 
declare @aux int
select @version = "6.03.01" 
select @aux = count(*) from csi_empresas_logos where anchura = 0
IF (@aux = 0)  
	BEGIN
		insert testupdater (descripcion,ok,version) values('No hay registros en la tabla csi_empresas_logos cuando anchura es 0','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No hay registros en la tabla csi_empresas_logos cuando anchura es 0','N',@version)
END
IF EXISTS (SELECT * FROM var_globales WHERE texto='20120410' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;