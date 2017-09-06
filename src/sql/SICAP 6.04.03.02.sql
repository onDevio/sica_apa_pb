create table dbo.tarifas_importes_aux (id numeric(10,0) identity, id_tarifa varchar(10) null, id_informe varchar(10) null, precio_base double precision null, coef_modificador double precision null, aplica_coeficientes char(1) null, id_coeficiente varchar(10) null);
alter table dbo.tarifas_importes_aux add constraint pk_id_tarifa_informe_aux primary key nonclustered (id);
create table dbo.tarifas_tipo_act_aux (id_tarifa numeric(10,0) identity, tipo_act varchar(3) null, tipo_obra varchar(3) null, sup_desde double precision null, sup_hasta double precision null, pem_desde double precision null, pem_hasta double precision null, otro_desde double precision null, otro_hasta double precision null, colegio varchar(10) null) ;
alter table dbo.tarifas_tipo_act_aux add constraint pk_tarifas_tipo_act_aux primary key clustered (id_tarifa);
create table dbo.tarifas_coeficientes_aux (id  numeric(10,0) identity, variable varchar(100) null, igual_a varchar(50) null, porcentaje double precision null, valor_fijo double precision null, colegio varchar(10) null, tipo_coef char(1) not null, formula varchar(180) null, tipo_autocalculado char(1) null, minimo double precision null, maximo double precision null);
alter table dbo.tarifas_coeficientes_aux add constraint pk_t_coef_aux primary key nonclustered (id);



declare @colegio varchar(10)
declare @var int
declare @contador int
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// Sólo colegio Ávila
if @colegio = 'COAATAVI'
begin

	// insertamos artículos que se corresponden con los certificados para poder agregarlos a las tarifas
	insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, en_ficha_colegiado, concepto_conta, suplido, ing_gas, incluir_347, tiene_irpf, empresa, regularizar) values ('cfo', ' Certificado de final de obra','D', 'EXP', 'EXP', 'S', 'S', 0, 'S', 'S', 0, 0, 'COAATAVI', '00', 'N', 'N', 'CFO', 'N', 'S', 'S', 'N', '01', 'N'  )
	insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, en_ficha_colegiado, concepto_conta, suplido, ing_gas, incluir_347, tiene_irpf, empresa, regularizar) values ('cfco', ' Certificado de final de Coordinación','D', 'EXP', 'EXP', 'S', 'S', 0, 'S', 'S', 0, 0, 'COAATAVI', '00', 'N', 'N', 'CFCO', 'N', 'S', 'S', 'N', '01', 'N'  )


	// Eliminamos tarifas anteriores.
	delete tarifas_importes where id_tarifa in (select id_tarifa from tarifas_tipo_act where colegio = 'COAATAVI')
	delete tarifas_tipo_act where colegio = 'COAATAVI'

	//Introducción de entradas en la tabla tarifas_tipo_act. Datos de tipos de actuación, tipos de obra y rangos aplicados. 

	// T.A  '01' y T.O  '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', 0, 1000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', 1001, 3000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', 3001, 5000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', 5001, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '02' y T.O  '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '02', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '03' y T.O  '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', 0, 250, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', 251, 1000, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', 1001, 5000, 30000, null, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', 5001, null, 30000, null, -1, null, 'COAATAVI')


	// T.A  '04' y T.O '%' = T.A. '03' + T.A.'01'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 0, 1000, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 1001, 3000, 0, 29999, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 3001, 5000, 0, 29999, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 5001, null, 0, 29999, -1, null, 'COAATAVI')


	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 0, 250, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 251, 1000, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 1001, 3000, 30000, null, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 3001, 5000, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', 5001, null, 30000, null, -1, null, 'COAATAVI')

	// T.A '05' =  T.A. '03' = T.A. '03' + T.A.'02'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '05', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '03' and tipo_obra = '%'


	// T.A  '15' y T.O '1%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '15', '1%', 0, 50, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '15', '1%', 51, 100, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '15', '1%', 101, 500, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '15', '1%', 501, 1000, -1, null, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '15', '1%', 1001, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '15' y T.O '2%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '2%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'


	// T.A  '15' y T.O '3%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '3%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'

	// T.A  '15' y T.O '4%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '4%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'

	// T.A  '15' y T.O '81'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '81', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'

	// T.A  '15' y T.O '82'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '82', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'

	// T.A  '15' y T.O '83'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', '83', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15' and tipo_obra = '1%'


	// T.A '12' = TA '15' +
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '15'

	// T.A  '12' y T.O '5%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '5%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '12' y T.O '6%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '6%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '12' y T.O '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '9%', -1, null, -1, null, 0, 750, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '9%', -1, null, -1, null, 751, 3000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '9%', -1, null, -1, null, 3001, 5000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '9%', -1, null, -1, null, 5001, null, 'COAATAVI')
	

	// T.A  '12' y T.O '7%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '7%', -1, null, 0, 30000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '7%', -1, null, 30001, 100000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '7%', -1, null, 100001, 500000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '7%', -1, null, 500001, null, -1, null, 'COAATAVI')
	

	// T.A  '13' y T.O '1%' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', 0, 50, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', 51, 100, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', 101, 500, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', 501, 1000, 30000, null, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', 1001, null, 30000, null, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '2%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '2%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '3%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '3%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '4%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '4%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '5%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '5%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '81'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '81', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '82'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '82', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'

	// T.A  '13' y T.O '83'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', '83', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '1%'


	// T.A  '13' y T.O '1%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '1%', -1, null, 0, 29999, -1, null, 'COAATAVI')
	
	// T.A  '13' y T.O '2%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '2%', -1, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '3%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '3%', -1, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '4%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '4%', -1, null, 0, 29999, -1, null, 'COAATAVI')
	
	// T.A  '13' y T.O '5%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '5%', -1, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '81' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '81', -1, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '82' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '82', -1, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '13' y T.O '83' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '83', -1, null, 0, 29999, -1, null, 'COAATAVI')


	// T.A '16' = TA '13' 
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '16', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13'


	// T.A  '17' = T.A. '13' Obra mayor (PEM >= 30000) +
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '17', tipo_obra, sup_desde, sup_hasta, -1, null, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and pem_desde = 30000 

	// T.A  '14' = T.A. '17' - (T.O ='5%') +
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '14', tipo_obra, sup_desde, sup_hasta, -1, null, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '17' and tipo_obra <> '5%'

	// T.A  '14' y T.O '5%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '5%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '14' y T.O '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '9%', -1, null, -1, null, 0, 750, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '9%', -1, null, -1, null, 751, 3000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '9%', -1, null, -1, null, 3001, 5000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '9%', -1, null, -1, null, 5001, null, 'COAATAVI')

	// T.A  '14' y T.O '7%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '7%', -1, null, 0, 30000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '7%', -1, null, 30001, 100000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '7%', -1, null, 100001, 500000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '14', '7%', -1, null, 500001, null, -1, null, 'COAATAVI')

	
	
	// T.A '11' y T.O '1%' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 0, 50, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 51, 100, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 101, 500, 30000, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 501, 1000, 30000, null, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 1001, null, 30000, null, -1, null, 'COAATAVI')

	// T.A  '11' y T.O '2%' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '2%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'

	// T.A  '11' y T.O '3%' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '3%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'

	// T.A  '11' y T.O '4%' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '4%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'

	// T.A  '11' y T.O '81' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '81', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'

	// T.A  '11' y T.O '82' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '82', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'

	// T.A  '11' y T.O '83' Obra mayor (PEM >= 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '83', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%'


	// T.A '11' y T.O '1%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 0, 50, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 51, 100, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 101, 500, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 501, 750, 0, 29999, -1, null, 'COAATAVI')
	
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 751, 1000, 0, 29999, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '1%', 1001, null, 0, 29999, -1, null, 'COAATAVI')

	// T.A  '11' y T.O '2%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '2%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0

	// T.A  '11' y T.O '3%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '3%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0

	// T.A  '11' y T.O '4%' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '4%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0

	// T.A  '11' y T.O '81' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '81', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0

	// T.A  '11' y T.O '82' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '82', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0

	// T.A  '11' y T.O '83' Obra menor (PEM < 30000)
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', '83', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra = '1%' and pem_desde = 0


	// T.A  '11' y T.O '5%' ó '6%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '5%', -1, null, -1, null, -1, null, 'COAATAVI')
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '6%', -1, null, -1, null, -1, null, 'COAATAVI')


	// T.A '11' y T.O '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '9%', -1, null, -1, null, 0, 750, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '9%', -1, null, -1, null, 751, 3000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '9%', -1, null, -1, null, 3001, 5000, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '9%', -1, null, -1, null, 5001, null, 'COAATAVI')


	// T.A '11' y T.O '7%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '7%', -1, null, 0, 30000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '7%', -1, null, 30001, 100000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '7%', -1, null, 100001, 500000, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '7%', -1, null, 500001, null, -1, null, 'COAATAVI')



	// T.A  '31' y T.O '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '31', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A  '32' y T.O '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '32', '%', -1, null, -1, null, -1, null, 'COAATAVI')


	// T.A  '33' y T.O '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '33', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	
	// T.A  '52' y T.O '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '52', '%', 0, 10000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '52', '%', 10001, 20000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '52', '%', 20001, 30000, -1, null, -1, null, 'COAATAVI')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '52', '%', 30001, null, -1, null, -1, null, 'COAATAVI')


	// T.A = '44'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '44', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '46'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '46', '%', -1, null, -1, null, -1, null, 'COAATAVI')


	// T.A = '41'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '41', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '42'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '42', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '43'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '43', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '45'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '45', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '6%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '6%', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '71'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '71', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '72'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '72', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '73'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '73', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '74'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '74', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '75'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '75', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '77'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '77', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '8%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '8%', '%', -1, null, -1, null, -1, null, 'COAATAVI')

	// T.A = '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '9%', '%', -1, null, -1, null, -1, null, 'COAATAVI')


	// T.O = '82'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '%', '82', -1, null, -1, null, -1, null, 'COAATAVI')

	select @var = max(convert(int, id_tarifa)) from tarifas_tipo_act 

	--// Inserción de datos sobre la tabla tarifas_tipo_act
	insert into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) (select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id_tarifa))) ) + convert(varchar, @var + convert(int,id_tarifa)) as id_tarifa , tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux )

	update contadores set valor = (select max(convert(int, id_tarifa)) from tarifas_tipo_act) where contador = 'ID_TARIFA'




	-- Inserción de coeficiente de descuento para T.A 11 (PROYECTO Y DIRECCION) 
	insert into tarifas_coeficientes_aux (variable, valor_fijo, colegio, tipo_coef) values('descuento_TA_compuesto', 0.80, 'COAATAVI', 'C')

	-- Inserción de coeficiente K. Por el momento el valor será 1 para que no intervenga en los resultados. 
	insert into tarifas_coeficientes_aux (variable, valor_fijo, colegio, tipo_coef) values('k', 1, 'COAATAVI', 'C')


	--// Inserción de coeficientes de tipo A
	insert into tarifas_coeficientes_aux ( variable, colegio, tipo_coef, tipo_autocalculado) values( 'superficie', 'COAATAVI', 'A', 'S')
	insert into tarifas_coeficientes_aux ( variable, colegio, tipo_coef, tipo_autocalculado) values( 'PEM', 'COAATAVI', 'A', 'P')
	insert into tarifas_coeficientes_aux ( variable, colegio, tipo_coef, tipo_autocalculado) values( 'volumen', 'COAATAVI', 'A', 'O')
	
	
	-- Inserción de fórmulas para aplicar el incremento para las tarifas del tipo de actuación 11 que sea necesario
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('30k', 'COAATAVI', 'F', '30 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('50k', 'COAATAVI', 'F', '50 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('75k', 'COAATAVI', 'F', '75 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('80k', 'COAATAVI', 'F', '80 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('100k', 'COAATAVI', 'F', '100 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('120k', 'COAATAVI', 'F', '120 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('125k', 'COAATAVI', 'F', '125 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('130k', 'COAATAVI', 'F', '130 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('150k', 'COAATAVI', 'F', '150 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('175k', 'COAATAVI', 'F', '175 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('180k', 'COAATAVI', 'F', '180 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('200k', 'COAATAVI', 'F', '200 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('230k', 'COAATAVI', 'F', '230 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('250k', 'COAATAVI', 'F', '250 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('300k', 'COAATAVI', 'F', '300 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('400k', 'COAATAVI', 'F', '400 * [k]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('450k', 'COAATAVI', 'F', '450 * [k]')


	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('100k_desc', 'COAATAVI', 'F', '100 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('125k_desc', 'COAATAVI', 'F', '125 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('150k_desc', 'COAATAVI', 'F', '150 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('195k_desc', 'COAATAVI', 'F', '195 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('220k_desc', 'COAATAVI', 'F', '220 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('225k_desc', 'COAATAVI', 'F', '225 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('250k_desc', 'COAATAVI', 'F', '250 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('275k_desc', 'COAATAVI', 'F', '275 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('300k_desc', 'COAATAVI', 'F', '300 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('325k_desc', 'COAATAVI', 'F', '325 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('350k_desc', 'COAATAVI', 'F', '350 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('380k_desc', 'COAATAVI', 'F', '380 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('400k_desc', 'COAATAVI', 'F', '400 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('450k_desc', 'COAATAVI', 'F', '450 * [k] * [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('550k_desc', 'COAATAVI', 'F', '550 * [k] * [descuento_TA_compuesto]')


	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_2.5', 'COAATAVI', 'F', '150 * [k] + ( 50 * [k] * (truncate((([volumen] -1)- 5000) / 1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_1.5', 'COAATAVI', 'F', '180 * [k] + ( 75 * [k] * (truncate((([superficie] -1)- 30000) / 10000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_1.4', 'COAATAVI', 'F', '180 * [k] + ( 100 * [k] * (truncate((([PEM] -1)- 500000) / 500000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_1.3', 'COAATAVI', 'F', '200 * [k] + ( 50 * [k] * (truncate((([volumen] -1)- 5000) / 1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_1.6', 'COAATAVI', 'F', '200 * [k] + ( 30 * [k] * (truncate((([superficie] -1)- 5000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_2.6', 'COAATAVI', 'F', '200 * [k] + ( 75 * [k] * (truncate((([PEM] -1)- 500000)/500000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_1.1', 'COAATAVI', 'F', '250 * [k] + ( 100 * [k] * (truncate((([superficie] -1)- 1000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_2.7', 'COAATAVI', 'F', '250 * [k] + ( 50 * [k] * (truncate((([superficie] -1)- 5000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_2.1', 'COAATAVI', 'F', '300 * [k] + ( 75 * [k] * (truncate((([superficie] -1)- 1000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_2.3', 'COAATAVI', 'F', '300 * [k] + ( 75 * [k] * (truncate((([superficie] -1)- 1000)/1000; 0) + 1 ))')

	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta04-', 'COAATAVI', 'F', '230 * [k] + ( 30 * [k] * (truncate((([superficie] -1)- 5000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta04+', 'COAATAVI', 'F', '450 * [k] + ( 80 * [k] * (truncate((([superficie] -1)- 5000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta05', 'COAATAVI', 'F', '300 * [k] + ( 50 * [k] * (truncate((([superficie] -1)- 5000)/1000; 0) + 1 ))')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta11.1', 'COAATAVI', 'F', '(325 * [k] + ( 100 * [k] * (truncate((([superficie] -1)- 1000)/1000; 0) + 1 )))* [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta11.2', 'COAATAVI', 'F', '(550 * [k] + ( 175 * [k] * (truncate((([superficie] -1) - 1000)/1000; 0) + 1 )))* [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta11.3', 'COAATAVI', 'F', '(350 * [k] + ( 100 * [k] * (truncate((([volumen] -1) - 5000)/1000; 0) + 1 )))* [descuento_TA_compuesto]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('tarifa_ta11.4', 'COAATAVI', 'F', '(380 * [k] + ( 175 * [k] * (truncate((([PEM] -1) - 500000)/500000; 0) + 1 )))* [descuento_TA_compuesto]')


	select @var = max(convert(int, id)) from tarifas_coeficientes 

	insert into tarifas_coeficientes (id, variable, igual_a, porcentaje, valor_fijo, colegio, tipo_coef, formula, tipo_autocalculado, minimo, maximo) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id , variable, igual_a, porcentaje, valor_fijo, colegio, tipo_coef, formula, tipo_autocalculado, minimo, maximo from tarifas_coeficientes_aux

	Select @var = max(convert(int, id)) from tarifas_coeficientes

	select @contador = valor from contadores where contador = 'id_tarifas_coef'

	if @var > @contador
		Begin
			update contadores set valor = @var where contador = 'id_tarifas_coef'
		end





	--  Carga de la tabla tarifas_importes

	--//******* Se cargan tarifas fijas en la tabla tarifas_importe *******//

	--// T.A = 01 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '01' and tarifas_tipo_act.sup_desde = 0)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '01' and tarifas_tipo_act.sup_desde= 1001)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '01' and tarifas_tipo_act.sup_desde = 3001)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.6' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '01' and tarifas_tipo_act.sup_desde = 5001)

	
	--// T.A = 02 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '02' )


	--// T.A = 03 y PEM < 30000
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '30k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '03' and tarifas_tipo_act.pem_hasta = 29999 )


	--// T.A = 03 y PREM >= 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '03' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '03' and tarifas_tipo_act.sup_desde= 251 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '250k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '03' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.7' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '03' and tarifas_tipo_act.sup_desde = 5001 and tarifas_tipo_act.pem_desde = 30000)	


	--// T.A = 04 y PEM < 30000
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '130k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.pem_hasta = 29999 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '180k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.pem_hasta = 29999 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '230k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 3001 and tarifas_tipo_act.pem_hasta = 29999 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta04-' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 5001 and tarifas_tipo_act.pem_hasta = 29999 )


	--// T.A = 04 y PREM >= 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '175k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '250k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde= 251 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '400k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '450k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 3001 and tarifas_tipo_act.pem_desde = 30000)	

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta04+' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '04' and tarifas_tipo_act.sup_desde = 5001 and tarifas_tipo_act.pem_desde = 30000)	


	--// T.A = 05 y PEM < 30000
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '80k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '05' and tarifas_tipo_act.pem_hasta = 29999 )

	
	--// T.A = 05 y PREM >= 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '125k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '05' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '05' and tarifas_tipo_act.sup_desde= 251 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '300k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '05' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.pem_desde = 30000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta05' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '05' and tarifas_tipo_act.sup_desde = 5001 and tarifas_tipo_act.pem_desde = 30000)	
	

	--// T.A = 15 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.sup_desde = 0 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '120k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.sup_desde = 51 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.sup_desde = 101 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '250k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.sup_desde = 501 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.1' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.sup_desde = 1001 )	
	

	--// T.A 12 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83') 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '120k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '250k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.1' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))


	--// T.A 12 y T.O. '5%' o '6%'
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '125k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra in ('5%', '6%'))


	--// T.A 12 y T.O. = '9%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.otro_desde = 0 and tarifas_tipo_act.tipo_obra = '9%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.otro_desde = 751 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.otro_desde = 3001 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.3' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.otro_desde = 5001 and tarifas_tipo_act.tipo_obra = '9%')


	--// T.A 12 y T.O. = '7%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '120k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.pem_desde = 0 and tarifas_tipo_act.tipo_obra = '7%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.pem_desde = 30001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '180k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.pem_desde = 100001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.4' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.pem_desde = 500001 and tarifas_tipo_act.tipo_obra = '7%')
	
	
	--// T.A 13 ó 16 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83') PEM < 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.pem_desde = 0 )

	
	--// T.A 13 ó 16 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83') PEM >= 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.pem_desde = 30000 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '300k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.1' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.pem_desde = 30000)

	
	--// T.A 17 y T.O. in ('1%', '2%', '3%', '4%', '51', '52', '81', '82', '83') 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83'))

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '300k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.3' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83'))
	

	--// T.A 14 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83')
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '300k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.3' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83'))

	
	--// T.A 14 y T.O. = '5%') 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '5%')
	

	--// T.A 14 y T.O. = '9%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.otro_desde = 0 and tarifas_tipo_act.tipo_obra = '9%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.otro_desde = 751 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.otro_desde = 3001 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.5' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.otro_desde = 5001 and tarifas_tipo_act.tipo_obra = '9%')


	--// T.A 14 y T.O. = '7%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.pem_desde = 0 and tarifas_tipo_act.tipo_obra = '7%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.pem_desde = 30001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '200k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.pem_desde = 100001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_2.6' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.pem_desde = 500001 and tarifas_tipo_act.tipo_obra = '7%')


	--// T.A 11 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83') PEM < 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '125k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') 	and tarifas_tipo_act.pem_desde = 0 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '195k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 0 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '275k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 0 ) 
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '325k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 0 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta11.1' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 0 )

	
	--// T.A 11 y T.O. in ('1%', '2%', '3%', '4%', '81', '82', '83') PEM >= 30000 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '100k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 0 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83')	and tarifas_tipo_act.pem_desde = 30000 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '220k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 51 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '400k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 101 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '450k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 501 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 30000 )

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '550k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 751 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 30000 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta11.2' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.sup_desde = 1001 and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') and tarifas_tipo_act.pem_desde = 30000)

	
	--// T.A 11 y T.O. = '5%' ó '6%') 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '225k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra in ('5%', '6%'))
	

	--// T.A 11 y T.O. = '9%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.otro_desde = 0 and tarifas_tipo_act.tipo_obra = '9%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '250k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.otro_desde = 751 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '350k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.otro_desde = 3001 and tarifas_tipo_act.tipo_obra = '9%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta11.3' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.otro_desde = 5001 and tarifas_tipo_act.tipo_obra = '9%')


	--// T.A 11 y T.O. = '7%' 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '195k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.pem_desde = 0 and tarifas_tipo_act.tipo_obra = '7%')

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '300k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.pem_desde = 30001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '380k_desc' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.pem_desde = 100001 and tarifas_tipo_act.tipo_obra = '7%')
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_ta11.4' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.pem_desde = 500001 and tarifas_tipo_act.tipo_obra = '7%')



	--// T.A = 52 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '120k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '52' and tarifas_tipo_act.sup_desde = 0 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '150k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '52' and tarifas_tipo_act.sup_desde = 10001 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '180k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '52' and tarifas_tipo_act.sup_desde = 20001 )
	
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'tarifa_1.5' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '52' and tarifas_tipo_act.sup_desde = 30001 )
	

	--// T.A = 31, 32, 44, ó 46 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('31', '32', '44', '46') )
	
	 
	--// T.A = 33 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '33' )


	--// T.A in ('41', '42', '43', '45, '61, '62', '63', '64, '65', '66', '71', '72', '73', '74', '75', '77', '81', '82', '83', '91, '92', '93', '94', '95') 
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '30k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('41', '42', '43', '45', '6%', '71', '72', '73', '74', '75', '77', '8%', '9%') )

	--// T.O = '82'  
	--// Tipo de trámite = VV o REDAP --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '30k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_obra = '82' and tarifas_tipo_act.tipo_act ='%' )



	--// Tipo de trámite IP --> Artículo = 03  =  tarifas articulo '02'
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_importes_aux.id_tarifa, '03', tarifas_importes_aux.precio_base, tarifas_importes_aux.coef_modificador, tarifas_importes_aux.aplica_coeficientes, tarifas_importes_aux.id_coeficiente from tarifas_tipo_act, tarifas_importes_aux where tarifas_importes_aux.id_tarifa = tarifas_tipo_act.id_tarifa and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_importes_aux.id_informe = '02')

	

	--//  Artículo = cfo  -- TA 13 o 16  -- TO in ('1%', '2%', '3%', '4%', '81', '82', '83') PEM >= 30000 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('13', '16') and tarifas_tipo_act.pem_desde = 30000 )

	--//  Artículo = cfo  -- TA  17  -- TO in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83') 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '17'  and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '5%', '81', '82', '83') )

	--//  Artículo = cfo  -- TA  14  -- TO in ('1%', '2%', '3%', '4%', '81', '82', '83') 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '75k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14'  and tarifas_tipo_act.tipo_obra in ('1%', '2%', '3%', '4%', '81', '82', '83') )

	--//  Artículo = cfo  -- TA  14  -- TO in '5%' 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14'  and tarifas_tipo_act.tipo_obra = '5%' )

	--//  Artículo = cfo  -- TA  14  -- TO in ('9%', '7%')
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '30k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '14'  and tarifas_tipo_act.tipo_obra in ('7%', '9%' ))

	--//  Artículo = cfo  -- TA  11  
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfo', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '50k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act = '11' )



	--//  Artículo = cfco  -- TA  03, 04 ó 05-- PEM >=30000
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, 'cfco', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = '30k' and tarifas_tipo_act.colegio = 'COAATAVI' and tarifas_tipo_act.tipo_act in ('03', '04', '05') and tarifas_tipo_act.pem_desde = 30000 )





	select @var = max(convert(int, id)) from tarifas_importes

	insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente from tarifas_importes_aux 

	select @var = max(convert(int, id)) from tarifas_importes

	select @contador = valor from contadores where contador = 'ID_TARIFA_IMPORTE'

	if @var > @contador
		Begin
			update contadores set valor = (select max(convert(int, id)) from tarifas_importes ) where contador = 'ID_TARIFA_IMPORTE'
		end


end 
;

--// Se eliminan tablas auxiliares
drop table tarifas_tipo_act_aux;
drop table tarifas_coeficientes_aux;
drop table tarifas_importes_aux;
