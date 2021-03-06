--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = "7.09.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
--
--SCP-2553
IF EXISTS (SELECT * FROM var_globales WHERE texto='20141107' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2553. Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2553. No se ha actualizado correctamente a la versión','N',@version)
	END
--
--SCP-2545 
if @colegio = 'Coaater' 
BEGIN
	if (SELECT  count(*) FROM csi_param_facturas where empresa = '01' and serie = 'carta' and campo = 'info_bancaria' ) = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2545. Se ha añadido nuevo parámetro en csi_facturas_emitidas para las cartas','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2545. No se ha podido añadir un nuevo parámetro en csi_facturas_emitidas para las cartas','N',@version)
		END
END
--
--
--SCP-2333
if @colegio = 'Coaatz' 
BEGIN
	if (SELECT  count(*) FROM csi_empresas_logos where codigo_empresa = '01' and modulo = '005' and visible = 'S' ) = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2333. Se ha añadido logo en csi_empresas_logos para el módulo 005 y la empresa 01','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2333. No se ha añadido el logo en csi_empresas_logos para el módulo 005 y la empresa 01','N',@version)
		END
--
--
	if (SELECT  count(*) FROM csi_empresas_logos where codigo_empresa = '03' and modulo = '005' and visible = 'S' ) = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2333. Se ha añadido logo en csi_empresas_logos para el módulo 005 y la empresa 03','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2333. No se ha añadido el logo en csi_empresas_logos para el módulo 005 y la empresa 03','N',@version)
		END

END
--
--
-- SCP-2384
if @colegio = 'Coaatz'
   Begin
	if (SELECT count(*) FROM var_globales where nombre = 'numero_impresos_listados_domiciliaciones' and numero = 1 ) = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2384. Se crea o resetea la var_global -numero_impresos_listados_domiciliaciones-','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2384. No se pudo crear o resetear la var_global -numero_impresos_listados_domiciliaciones-','N',@version)
		END
   End
--
--
-- SCP-2342
if @colegio = 'Coaatlr'
   Begin
	if (SELECT count(*) FROM csi_empresas_logos where codigo_empresa = '01' and modulo = '009' and visible = 'S' and logo = 'logocol.bmp') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2342. Se ha añadido el logo -logocol.bmp- en csi_empresas_logos para el módulo 009 y la empresa 01','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2342. No se ha añadido el logo -logocol.bmp- en csi_empresas_logos para el módulo 009 y la empresa 01','N',@version)
		END
   
--
--
	if (SELECT count(*) FROM csi_empresas_logos where codigo_empresa = '02' and modulo = '009' and visible = 'S' and logo = 'narial.jpg') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2342. Se ha añadido el logo -narial.jpg- en csi_empresas_logos para el módulo 009 y la empresa 02','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2342. No se ha añadido el logo -narial.jpg- en csi_empresas_logos para el módulo 009 y la empresa 02','N',@version)
		END
	End 
--
--
-- SCP-2551
if @colegio = 'Coaatcc'
   Begin
	if (SELECT count(*) FROM csi_empresas where codigo = '01' and nombre = 'COLEGIO OFICIAL DE APAREJADORES Y ARQUITECTOS TÉCNICOS DE CÁCERES') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2551. Se ha el nombre de la empresa 01','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2551. Se ha el nombre de la empresa 01','N',@version)
		END
   End
--
--
-- SCP-2552
if (SELECT count(*) FROM var_globales where nombre = 'g_nombre_colegio_carta' ) = 0
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2552. Se elimina la var_global -g_nombre_colegio_carta-','S',@version)
	END
else 
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2552. No se pudo eliminar la var_global -g_nombre_colegio_carta-','N',@version)
	END
;