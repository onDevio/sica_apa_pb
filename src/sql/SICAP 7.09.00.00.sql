//SCP-2545

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
-- Actualización de las cartas de reclamación de avisos
if @colegio= 'COAATTER' 
	begin 
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) 
		values('carta', '01', '%', '%', 'info_bancaria', "B).- Mediante ingreso en la c/c IBAN ES90 2038 7725 2468 0003 4436 de Bankia o la c/c IBAN ES06 0030 1065 5000 0057 2271 del Banco Santander, haciendo constar la referencia")
	end 
;

//SCP-2333
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATZ'
   Begin
        INSERT INTO csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura,modulo, visible) VALUES ( '01',0,0,576,3698,'005','S')
        INSERT INTO csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura,modulo, visible) VALUES ( '03',900,0,576,3104,'005','S')
   end
;

//SCP-2384
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATZ'
   Begin
    declare @existe integer
    select @existe = count(*) from var_globales where nombre = 'numero_impresos_listados_domiciliaciones'
    if @existe > 0  
    Begin
      update var_globales set numero =1 where nombre = 'numero_impresos_listados_domiciliaciones'
    end 
    if @existe < 1
    Begin
      INSERT INTO var_globales VALUES ( 'numero_impresos_listados_domiciliaciones', 1,  NULL, NULL, NULL, 'Número impresiones listados de domiciliaciones', NULL, 'S')
    end 
   end 
;

//SCP-2342
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATLR'
   Begin
    INSERT INTO csi_empresas_logos (codigo_empresa,pos_x,pos_y,altura,anchura,logo,modulo,visible) VALUES ('01',0,0,6270,5937,'logocol.bmp','009','S')
    INSERT INTO csi_empresas_logos (codigo_empresa,pos_x,pos_y,altura,anchura,logo,modulo,visible) VALUES ('02',0,0,4092,5485,'narial.jpg','009','S')
   end
;

//SCP-2551
update csi_empresas set nombre = 'COLEGIO OFICIAL DE APAREJADORES Y ARQUITECTOS TÉCNICOS DE CÁCERES' where codigo = '01'  AND 1 = (select count(*) from var_globales where nombre = 'COLEGIO' and texto = 'COAATCC');

// SCP-2552
DELETE FROM var_globales WHERE nombre = 'g_nombre_colegio_carta';