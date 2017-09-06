declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// SCP-1647
if @colegio = 'COAATAVI'
begin
	INSERT INTO csi_empresas_logos VALUES ('02',0,0,2960,7800,'sociedad.jpg','006','S')
	INSERT INTO csi_empresas_logos VALUES ('01',0,0,3451,2900,'coaatavi_logo.jpg','006','S')
end 

// SCP-2276
if @colegio = 'COAATBU'
begin
	INSERT INTO csi_param_facturas VALUES ( '%', '%', '%', '%', 'aviso_cuenta_1', 'CAJA 3....................................................................................................... 2086 7001 14 0700117175')
	INSERT INTO csi_param_facturas VALUES ( '%', '%', '%', '%', 'aviso_cuenta_2', 'BANCO SABADELL ATLÁNTICO ............................................................. 0081 5075 80 0001345344')
end

// SCP-1647
if @colegio = 'COAATCC'
begin
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('03', 125, 0, 1750, 7125, 'logo 03.jpg', '006', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 125, 0, 2304, 1700, '', '006', 'S')
end

if @colegio = 'COAATGU'
begin
	// SCP-2202
	INSERT INTO csi_param_facturas VALUES ( '%','%','%','%','texto_lopd',
	'Según la LOPD, los datos recogidos por COLEGIO OFICIAL DE APAREJADORES, ARQUITECTOS TÉCNICOS E INGENIEROS DE GUADALAJARA, para cumplir la relación negocial con los clientes, serán incluidos en el fichero CLIENTES inscrito en la AEPD, pudiendo ser cedidos a Bancos y Administración Tributaria, si es necesario para cumplir con esta finalidad. Puede ejercitar sus derechos de acceso, rectificación, cancelación, oposición o su revocación, identificándose fehacientemente y por escrito a nuestra dirección.')
	// SCP-2242
	update csi_fact_reclamaciones_tipos set dw = 'd_reclamaciones_facturas_1a_recla' where descripcion in ('COLEGIADOS: 1a Reclamación','CLIENTES: 1a Reclamación')
	update csi_fact_reclamaciones_tipos set dw = 'd_reclamaciones_facturas_2a_recla' where descripcion in ('COLEGIADOS: 2a Reclamación','CLIENTES: 2a Reclamación')
	update csi_fact_reclamaciones_tipos set dw = 'd_reclamaciones_facturas_3a_recla' where descripcion in ('COLEGIADOS: 3a Reclamación','CLIENTES: 3a Reclamación')
	update csi_fact_reclamaciones_tipos set dw = 'd_reclamaciones_facturas_4a_recla' where descripcion in ('COLEGIADOS: 4a Reclamación','CLIENTES: 4a Reclamación')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ( '01', 0, 0, 0, 0, '', '006', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('04', 0, 0, 2324, 8400, '', '006', 'S')
end 

if @colegio = 'COAATGUI'
begin
	// SCP-2241
	Update csi_param_facturas set texto ='Para su comodidad le rogamos efectúe el pago de la presente Proforma en cualquiera de las cuentas bancarias del BANCO SANTANDER Nº 0049 6668 31 2916225968.' where campo='cuenta_pago' and empresa = '02' and idioma = 'ES'
	Update csi_param_facturas set texto ='Erosoagoa izan dakizun, arren eskatzen dizugu Proforma honen ordainketa egitea, BANCO SANTANDER Nº 0049 6668 31 2916225968.' where campo='cuenta_pago' and empresa = '02' and idioma = 'VA'
	// SCP-2283
	INSERT INTO csi_param_facturas VALUES (	'%',	'%',	'%',	'%',	'aviso_cuenta_1',	'Para su comodidad le rogamos efectúe el pago del presente Aviso de Factura en cualquiera de las cuentas bancarias de KUTXA N° 2095 5007 81 1060002507 o CAJA LABORAL N° 3035 0128 52 12800 00126.')
	INSERT INTO csi_param_facturas VALUES (	'%',	'%',	'%',	'%',	'aviso_cuenta_2',	'Erosoagoa izan dakizun, arren eskatzen dizugu Faktura Abisu honen ordainketa egitea, KUTXA N° 2095 5007 81 1060002507 edo EUSKADIKO KUTXAKO N° 3035 0128 52 12800 00126 edozein sukurtsaletan.')
end

// SCP-2017
if @colegio = 'COAATLE'
begin
	update csi_empresas_logos set visible='S' where modulo= '008'
	update csi_empresas_logos set pos_x=300 where modulo= '008'
end

// SCP-2153, SCP-1887
if @colegio = 'COAATLR'
begin
	update csi_empresas set logo = 'narial.jpg' where codigo = '02'
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 0, 0, 4345, 4345, '', '006', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('02', 0, 0, 4345, 4445, '', '006', 'S')
end

; 