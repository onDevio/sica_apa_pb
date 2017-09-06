declare @version varchar(10) 
select @version = "6.01.00" 

-- Comprobaci�n en testupdater
-- Versi�n
IF EXISTS (SELECT * FROM var_globales WHERE texto='20120119' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versi�n','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versi�n','N',@version)
	END
;
