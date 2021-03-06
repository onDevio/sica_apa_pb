--Verificación UPDATER
declare @version varchar(10) 
select @version = "6.03.03" 

--SCP-2123 Se comprueba que exista la variable
IF EXISTS (SELECT * FROM csi_param_sigescon WHERE nombre = 'g_conta_cobro_ejercicio_noactual')
BEGIN
	insert testupdater (descripcion,ok,version) values('Se insertó correctamente la variable g_conta_cobro_ejercicio_noactual','S',@version)
END
ELSE
BEGIN
	insert testupdater (descripcion,ok,version) values('No se inserto correctamente la g_conta_cobro_ejercicio_noactual','N',@version)
END 

IF EXISTS (SELECT * FROM var_globales WHERE texto='20120611' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;