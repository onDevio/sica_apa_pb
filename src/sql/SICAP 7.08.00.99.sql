--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = "7.08.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
--2537
IF EXISTS (SELECT * FROM var_globales WHERE texto='20140911' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
--SCP-2530 
if (SELECT  count(*) FROM csi_articulos_servicios where lower(codigo) = '150ac' and activo = 'S' ) > 0
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2530. Se ha añadido o existía el artículo -150AC-','S',@version)
	END
else 

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2530. No se ha añadido el artículo -150Ac-','N',@version)
	END

if (SELECT  count(*) FROM csi_articulos_servicios where lower(codigo) = '150oc' and activo = 'S' ) > 0
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2530. Se ha añadido o existía el artículo -150Oc-','S',@version)
	END
else 

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2530. No se ha añadido el artículo -150Oc-','N',@version)
	END
--
-- SCP-2528
if @colegio = 'COAATAVI'
	BEGIN
		if (select count(*) from csi_param_facturas where empresa = '01' and serie = 'carta' and campo = 'info_bancaria') = 1 
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2528. Se creo entrada en -csi_param_facturas- para las cartas de reclamación','S',@version)
			END
		else
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2528. No se ha creado entrada en -csi_param_facturas- para las cartas de reclamación','N',@version)
			END
 


	END 
--
--
-- SCP-2374
if @colegio = 'COAATGUI'
	BEGIN
		if (select count(*) from csi_param_facturas where empresa = '01' and serie = 'carta' and campo in ('codigo_banco1', 'codigo_banco2', 'nombre_banco1_eus', 'nombre_banco2_eus' )) = 4 
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2374. Se crearon entradas en -csi_param_facturas- para las cartas de reclamación','S',@version)
			END
		else
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2374. No se han creado entradas en -csi_param_facturas- para las cartas de reclamación','N',@version)
			END
 


	END 
--
--
-- SCP-2414
if @colegio = 'COAATCC'
	BEGIN
		if (select count(*) from listados where descripcion = "Listado Servicios Encargos Profesionales" and dw = "d_colegiados_listado_serv_encargos_prof" and ventana = "w_colegiados_listados" and orden = '0' and activo= 'S') = 1 
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2414. Se crea listado de servicios encargos profesionales','S',@version)
			END
		else
			BEGIN
				insert testupdater (descripcion,ok,version) values('SCP-2414. No se han creado el listado de servicios encargos profesionales','N',@version)
			END
 


	END 
;