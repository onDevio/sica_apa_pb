// SCP-2082 Logos
// Tipos de Módulos que se van a controlar
insert into tipos_modulos_logos values ('000', 'Genérico')
insert into tipos_modulos_logos values ('001', 'Resúmenes Económicos')
insert into tipos_modulos_logos values ('002', 'Facturación')
insert into tipos_modulos_logos values ('003', 'Domiciliaciones')
insert into tipos_modulos_logos values ('004', 'Listados de Contrato')
insert into tipos_modulos_logos values ('005', 'Liquidaciones')
insert into tipos_modulos_logos values ('006', 'Reclamaciones')
insert into tipos_modulos_logos values ('007', 'Vencimiento cobros')
insert into tipos_modulos_logos values ('008', 'Otros Pagos - Informe Liq.')
// Inicialización Logos 
update csi_empresas_logos set visible = 'S', modulo = '000'
update csi_empresas_logos set logo = (select csi_empresas.logo from csi_empresas where csi_empresas.codigo = csi_empresas_logos.codigo_empresa)
// Para todas las instalaciones se insertan entradas con logos no visibles para el módulo de resúmenes económicos.
insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, modulo, visible) select csi_empresas.codigo,0,0,0,0,'001','N' from csi_empresas
// Para todas las instalaciones se insertan entradas con logos no visibles para el módulo Otros Pagos - Informe Liq.
insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, modulo, visible) select csi_empresas.codigo,0,0,0,0,'008','N' from csi_empresas

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// SCP-1965,SCP-1993 Ávila
if @colegio = 'COAATAVI'
begin
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01',0,0,472,400, 'coaatavi_logo.jpg', '003', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 0,0,0,0, 'coaatavi_logo.jpg', '002', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 100,0,0,0, 'coaatavi_logo.jpg', '000', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 0,0,264,600, 'sociedad.jpg', '002', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 100,0,264,600, 'sociedad.jpg', '000', 'S') 
end 

// SCP-2185 Bizkaia
if @colegio = 'COAATB'
begin
	update csi_empresas_logos set pos_x = 100, altura = 322, anchura = 1600, logo = 'logo_colegio.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '01'
	update csi_empresas_logos set pos_x = 100, altura = 407, anchura = 939, logo = 'logo_asebiten.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '03'
end 

// SCP-2093 Cáceres
if @colegio = 'COAATCC'
begin
	update csi_empresas_logos set pos_x= 125, altura = 384, anchura = 300, logo = 'logo_ecoaat.gif', visible = 'S' where modulo ='001' and codigo_empresa = '01'
	update csi_empresas_logos set pos_x= 125, altura = 445, anchura = 311, logo = 'logo fundacion solo logo.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '02'
end 

// SCP-2082 Murcia
if @colegio = 'COAATMU'
begin
	update csi_empresas_logos set logo = 'logo_largo.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '01'
	update csi_empresas_logos set pos_x = 15, altura = 400, anchura = 526, logo = 'logo_datie.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '02'
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01', 160,80, 332,332, 'A.jpg', '003', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('02', 160,80, 400,526, 'logo_datie.jpg', '003', 'S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('02', 0, 0, 400,526, 'logo_datie.jpg', '000', 'S')
end

// SCP-2106 Navarra
if @colegio = 'COAATNA'
begin
	update csi_empresas_logos set visible = 'S' where modulo ='008'
end 

// SCP-2185 Rioja
if @colegio = 'COAATLR'
begin
    update csi_empresas set logo = 'narial.jpg' where codigo = '02'
end 

// SCP-2093 Tarragona
if @colegio = 'COAATTGN'
begin
	update csi_empresas_logos set pos_x = 125, altura = 250, anchura = 608, logo = 'Logo_COAATTGN_factu.gif', visible = 'S' where modulo ='001' and codigo_empresa = '01'
	update csi_empresas_logos set pos_x = 125, altura = 166, anchura = 600, logo = 'LOGOMUSAAT.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '03'
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('01',150,0,500,1216,'Logo_COAATTGN_factu.gif','003','S')
	insert into csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura, logo, modulo, visible) values ('03',150,0,332,1200,'LOGOMUSAAT.jpg','003','S')
end 

// SCP-2211 Teruel
if @colegio = 'COAATTER'
begin
	update csi_empresas_logos set pos_x = 75, altura = 372, anchura = 1030, logo = 'logo_teruel.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '01'
	update csi_empresas_logos set pos_x = 75, altura = 256, anchura = 620, logo = 'logo_SGA.jpg', visible = 'S' where modulo ='001' and codigo_empresa = '02'
end 

;
