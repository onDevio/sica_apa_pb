--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "7.00.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
-- SCP-2310
-- Se crean variables globales. 
if (Select count(*) from var_globales where nombre = "g_valor_extension_docs_sellados" and texto = "_signed") = 1
	begin 
		insert testupdater (descripcion,ok,version) values('SCP-2310. Se creó var global - g_valor_extension_docs_sellados -','S',@version)
	end 
else
	begin 
		insert testupdater (descripcion,ok,version) values('SCP-2310. No se creó var global - g_valor_extension_docs_sellados -','N',@version)	
	end
--
--
if (Select count(*) from var_globales where nombre = "g_nombre_consulta_datos_sello_imp" and texto = "INICIO") = 1
	begin 
		insert testupdater (descripcion,ok,version) values('SCP-2310. Se creó var global - g_nombre_consulta_datos_sello_imp -','S',@version)
	end 
else
	begin 
		insert testupdater (descripcion,ok,version) values('SCP-2310. No se creó var global - g_nombre_consulta_datos_sello_imp -','N',@version)	
	end
--
--
-- SCP-2312
-- Se añaden campos id_factura a la tabla fases_documentos_visared
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'fases_documentos_visared' AND syscolumns.name = 'id_factura' ) = 1

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2312. Se creó campo - id_factura - en la tabla fases_documentos_visared de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2243. No se creó campo - id_factura - en la tabla fases_documentos_visared de la BBDD. REVISAR','N',@version)
	END
--
--
--SCP-2210
if (@colegio = 'COAATZ') 
	begin
		if(Select count(*) from var_globales where nombre = "g_visualizar_facturas_sin_firma_en_web" and sn = "N") = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2310. Se creó var global - g_visualizar_facturas_sin_firma_en_web -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2310. No se creó var global - g_visualizar_facturas_sin_firma_en_web -','N',@version)
			end		
	end
else
	begin
		if(Select count(*) from var_globales where nombre = "g_visualizar_facturas_sin_firma_en_web" and sn = "S") = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2310. Se creó var global - g_visualizar_facturas_sin_firma_en_web -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2310. No se creó var global - g_visualizar_facturas_sin_firma_en_web -','N',@version)
			end		
	end	
--
--
--SCP-2321
if (@colegio = 'COAATZ') or (@colegio = 'COAATCC') or (@colegio = 'COAATAVI') or (@colegio = 'COAATNA')
	begin
		if(Select count(*) from var_globales where nombre = "g_enviar_email_facturacion_clientes" and sn = "S") = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2321. Se creó var global - g_visualizar_facturas_sin_firma_en_web -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2321. No se creó var global - g_visualizar_facturas_sin_firma_en_web -','N',@version)
			end		
	end
else
	begin
		if(Select count(*) from var_globales where nombre = "g_enviar_email_facturacion_clientes" and sn = "N") = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2321. Se creó var global - g_visualizar_facturas_sin_firma_en_web -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2321. No se creó var global - g_visualizar_facturas_sin_firma_en_web -','N',@version)
			end		
	end
--
--
-- SCP-2327
-- Borrado de la tabla consultas_datos_aux
if (SELECT  count(*) FROM sysobjects where sysobjects.type = 'U' AND sysobjects.name = 'consultas_datos_aux' ) = 0

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2327. Se eliminó la tabla - consultas_datos_aux - de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2327. No se eliminó la tabla - consultas_datos_aux - de la BBDD','S',@version)
	END
--
--
-- SCP-2378
IF EXISTS (SELECT * FROM var_globales WHERE texto='20131104' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
--
--SCP-2359
if ((@colegio = 'COAATZ') or (@colegio = 'COAATCC')) 
	begin
		if(Select count(*) from var_globales where nombre = "numero_impresos_listados_domiciliaciones" and numero = 1) = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2359. Se creó var global - numero_impresos_listados_domiciliaciones -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2359. No se creó var global - numero_impresos_listados_domiciliaciones -','N',@version)
			end		
	end
else
	begin
		if(Select count(*) from var_globales where nombre = "numero_impresos_listados_domiciliaciones" and numero = 2) = 1
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2359. Se creó var global - numero_impresos_listados_domiciliaciones -','S',@version)
			end
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2359. No se creó var global - numero_impresos_listados_domiciliaciones -','N',@version)
			end		
	end
;