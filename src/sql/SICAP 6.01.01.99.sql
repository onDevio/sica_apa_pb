declare @version varchar(10) 
select @version = "6.01.01" 

-- Comprobación en testupdater
-- Versión
IF EXISTS (SELECT * FROM var_globales WHERE texto='20120124' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;
