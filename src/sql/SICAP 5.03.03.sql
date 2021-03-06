
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

--Solo Navarra. 
if @colegio = 'COAATNA' 
begin
	//Cambios para NAVARRA
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('COLEGIADOS','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('F','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('MU','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('MUSAAT','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('PF','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('PREMAA','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('PROFOR','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('R','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('RECTIF','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('V','01','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('NAPC','02','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('NAPF','02','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('NAPM','02','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('PROFOR','02','2011','%', 'n_emisor3','')
	insert into csi_param_facturas (serie, empresa, anyo,idioma, campo, texto) values('RECTIF','02','2011','%', 'n_emisor3','')

	update csi_empresas set logo='logo_coaatna.jpg' where codigo='01'
	update csi_empresas set logo='musaat_logo.jpg' where codigo='02'
end 

if @colegio = 'COAATLE' 
begin
	//LEON
	update csi_param_facturas set texto ='Agencia exclusiva de MUSAAT, Mutua de Seguros a Prima Fija,' where serie='PC' and empresa='02' and campo='N_emisor2' and anyo='2011' and idioma='%'
	insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('PC', '02', '2011', '%' ,'n_emisor3', 'con número de registro:M0368B24613945')
end 

if @colegio = 'COAATBU' 
begin
	//Cambios para Burgos//******MAGID******//
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','P_bancos','El pago de la presenta factura/proforma, se podrá efectuar en una de las siguientes cuentas bancarias :')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','banco1','Caja de ahorros del Círculo Católico de Burgos: 2017 0001 18 3000017620.')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','banco2','Banco Sabadell Atlántico :                      0081 5075 80 0001345344.')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','horario_banco','El horario colegial para la retirada de la documentación será de 9 a 14 horas, de lunes a viernes con presentación del correspondiente justificante bancario')
end 

if @colegio = 'COAATAVI' 
	begin
	//CAMBIOS ÁVILA//******MAGID******//
	update csi_empresas set banco_defecto = '04' where codigo='01' 
	update csi_empresas set banco_defecto = '05' where codigo='02' 
	update csi_empresas set cuenta_bancaria = '2094-0001-06-0001037006' where codigo='01' 
	update csi_empresas set cuenta_bancaria = '0030-1065-50-0000572271' where codigo='02'

	//Añadidos cambios para Ávila a raíz de CAV-306 y CAV-305 
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','P_bancos','El pago indicado deberá efectuarlo por cualquiera de los procedimientos siguientes :')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','banco1','A).- En nuestras oficinas, de Lunes a Viernes, de 09:00 a 13:00 horas, mediante la entrega de un cheque debidamente conformado.')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','banco2','B).- Mediante ingreso en la c/c 2038-7725-24-6800034436 de Caja de Ahorros de Ávila, haciendo constar la referencia del Nº de registro')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','01','%','%','horario_banco','Lo que comunicamos a Ud. para su conocimiento y efectos.')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','02','%','%','P_bancos','El pago indicado deberá efectuarlo por cualquiera de los procedimientos siguientes :')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','02','%','%','banco1','A).- En nuestras oficinas, de Lunes a Viernes, de 09:00 a 13:00 horas, mediante la entrega de un cheque debidamente conformado.')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','02','%','%','banco2','B).- Mediante ingreso en la c/c 2038-7725-20-6000094642 de Caja de Ahorros de Ávila, haciendo constar la referencia del Nº de registro')
	insert into csi_param_facturas ( serie , empresa , anyo , idioma, campo ,texto) values ('CARTA','02','%','%','horario_banco','Lo que comunicamos a Ud. para su conocimiento y efectos.')
end

if @colegio = 'COAATZ' 
begin
	//CAMBIOS ZARAGOZA
	UPDATE csi_empresas SET logo = 'coaatz_seguros.jpg' WHERE codigo = '03'
	UPDATE csi_empresas SET logo = 'coaatz.jpg' WHERE codigo = '01'
	INSERT INTO csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) VALUES ('%','03','2011','ES','pie_pagina','Inscrita en el Reg. Merc. de Zaragoza, Tomo 3802, Folio 85, Hoja Z-50698, Inscripción 1ª - C.I.F. B99287260')
end 

if @colegio = 'COAATB' 
begin
	//Cambios bizcaia
	insert into var_globales (nombre, texto) values ('g_tipo_num_doc', 'GENERAL')
end

if @colegio = 'COAATGC' 
begin
	//Cambios gran canaria
	insert into var_globales (nombre, texto) values ('g_tipo_num_doc', 'FASE')
end

if @colegio <> 'COAATNA' AND @colegio <> 'COAATLE' AND @colegio <> 'COAATBU' AND  @colegio <> 'COAATAVI' AND @colegio <> 'COAATZ' AND @colegio <> 'COAATB' AND @colegio <> 'COAATGC' 
begin
	//Resto de colegios
	insert into var_globales (nombre, texto) values ('g_tipo_num_doc', 'TIPO_DOCUMENTO')
end


//Nuevo contador
insert into contadores (contador, valor, descripcion,modificable) values('NUM_DOC_ANEXOS', 0 , 'Contador de documentos anexos', 'N')

//Se actualiza la fecha de versión
update var_globales set texto='20110628', descripcion = 'versión v5.3.03' where nombre='g_version_minima'
;
