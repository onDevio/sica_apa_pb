create table dbo.tarifas_importes_aux (id numeric(10,0) identity, id_tarifa varchar(10) null, id_informe varchar(10) null, precio_base double precision null, coef_modificador double precision null, aplica_coeficientes char(1) null, id_coeficiente varchar(10) null);
alter table dbo.tarifas_importes_aux add constraint pk_id_tarifa_informe_aux primary key nonclustered (id);
create table dbo.tarifas_tipo_act_aux (id_tarifa numeric(10,0) identity, tipo_act varchar(3) null, tipo_obra varchar(3) null, sup_desde double precision null, sup_hasta double precision null, pem_desde double precision null, pem_hasta double precision null, otro_desde double precision null, otro_hasta double precision null, colegio varchar(10) null) ;
alter table dbo.tarifas_tipo_act_aux add constraint pk_tarifas_tipo_act_aux primary key clustered (id_tarifa);
create table dbo.tarifas_coeficientes_aux (id  numeric(10,0) identity, variable varchar(100) null, igual_a varchar(50) null, porcentaje double precision null, valor_fijo double precision null, colegio varchar(10) null, tipo_coef char(1) not null, formula varchar(180) null, tipo_autocalculado char(1) null, minimo double precision null, maximo double precision null);
alter table dbo.tarifas_coeficientes_aux add constraint pk_t_coef_aux primary key nonclustered (id);
create table dbo.tarifas_informes_x_tramite_aux (id numeric(10,0) identity, tipo_tramite varchar(10) null, visared varchar(1) null, id_informe varchar(10) null, colegio varchar(10) null, aplica_parti char(1) null);
alter table dbo.tarifas_informes_x_tramite_aux add constraint pk_tarifas_inf_x_tramite_aux primary key nonclustered (id) ;


declare @colegio varchar(10)
declare @var int
declare @contador int
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// Sólo colegio Guadalajara
if @colegio = 'COAATGU'
begin

// Eliminamos tarifas anteriores.
	delete tarifas_importes where id_tarifa in (select id_tarifa from tarifas_tipo_act where colegio = 'COAATGU')
	delete tarifas_tipo_act where colegio = 'COAATGU'

	// Para tipos de trámite REDAP T.A = '%' y T.O = '%'
	//insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '%', '%', -1, null, -1, null, -1, null, 'COAATGU')
	
	// T.A = '01'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '02'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '02', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '03'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '04'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '04', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '05'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '05', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '91' sup <= 50 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '91', 0, 50, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '91', sup >= 50 m2. y sup <= 100 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '91', 50.001, 100, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '91', sup >= 100 m2. y sup <= 300 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '91', 100.001, 300, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '91', sup >= 30 m2. y sup <= 500 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '91', 300.001, 500, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '91', sup >= 500.001 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '91', 500.001, null, -1, null, -1, null, 'COAATGU')
	
	// T.A = '11',  T.O = '92' sup <= 50 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '92', 0, 50, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '92', sup >= 50 m2. y sup <= 100 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '92', 50.001, 100, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '92', sup >= 100 m2. y sup <= 300 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '92', 100.001, 300, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '92', sup >= 30 m2. y sup <= 500 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '92', 300.001, 500, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '92', sup >= 500.001 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '92', 500.001, null, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '93' sup <= 50 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '93', 0, 50, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '93', sup >= 50 m2. y sup <= 100 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '93', 50.001, 100, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '93', sup >= 100 m2. y sup <= 300 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '93', 100.001, 300, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '93', sup >= 30 m2. y sup <= 500 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '93', 300.001, 500, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '93', sup >= 500.001 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '93', 500.001, null, -1, null, -1, null, 'COAATGU')


	// T.A = '11',  T.O = '%' sup <= 50 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '%', 0, 50, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '%', sup >= 50 m2. y sup <= 100 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '%', 50.001, 100, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '%', sup >= 100 m2. y sup <= 300 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '%', 100.001, 300, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '%', sup >= 30 m2. y sup <= 500 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '%', 300.001, 500, -1, null, -1, null, 'COAATGU')

	// T.A = '11',  T.O = '%', sup >= 500.001 m2.
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '11', '%', 500.001, null, -1, null, -1, null, 'COAATGU')

	// T.A = '12' = T.A. = 11 sin la excepción de los tipos de obra '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11' and tipo_obra not in ( '91', '92', '93')  

	// T.A = '13' = T.A. = 12
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '13', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'

	// T.A = '14' = T.A. = 12
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '14', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'

	// T.A = '15' =  T.O = '11'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '11'

	// T.A = '16' = T.A. = 12
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '16', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'

	// T.A = '17' = T.A. = 12
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '17', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'

	
	// T.A = '31'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '31', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '32'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '32', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '33'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '33', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '41'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '41', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '42'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '42', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '43'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '43', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '44'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '44', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '45'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '45', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '46'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '46', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '5%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '5%', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '6%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '6%', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '71'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '71', '%', -1, null, -1, null, -1, null, 'COAATGU')
	
	// T.A = '72'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '72', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '73'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '73', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '74'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '74', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '75'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '75', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '76'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '76', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '8%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '8%', '%', -1, null, -1, null, -1, null, 'COAATGU')

	// T.A = '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '9%', '%', -1, null, -1, null, -1, null, 'COAATGU')

	select @var = max(convert(int, id_tarifa)) from tarifas_tipo_act 

	--// Inserción de datos sobre la tabla tarifas_tipo_act
	insert into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) (select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id_tarifa))) ) + convert(varchar, @var + convert(int,id_tarifa)) as id_tarifa , tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux )

	update contadores set valor = (select max(convert(int, id_tarifa)) from tarifas_tipo_act) where contador = 'ID_TARIFA'


	// Inserción de entradas para que asocie los artículos a los tipos de trámite.
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'IP', 'S', '017', 'COAATGU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'REDOC', 'S', '017', 'COAATGU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'VV', 'S', '017', 'COAATGU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'IP', 'N', '018', 'COAATGU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'REDOC', 'N', '018', 'COAATGU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'VV', 'N', '018', 'COAATGU', 'S')


	select @var = max(convert(int, id)) from tarifas_informes_x_tramite 

	insert into tarifas_informes_x_tramite (id, tipo_tramite, visared, id_informe, colegio, aplica_parti) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id , tipo_tramite, visared, id_informe, colegio, aplica_parti  from tarifas_informes_x_tramite_aux 
	
	Select @var = max(convert(int, id)) from tarifas_coeficientes

	select @contador = valor from contadores where contador = 'id_tarifas_informes'

	if @var > @contador
		Begin
			update contadores set valor = @var where contador = 'id_tarifas_informes'
		end




	
	-- Actualizado de descuento de visared
	update tarifas_coeficientes set porcentaje = 10 where variable = 'visared' and colegio = 'COAATGU'
	
	-- Inserción de coeficiente de descuento para T.A 71, 72, 73, 74, y 75 
	insert into tarifas_coeficientes_aux (variable, valor_fijo, colegio, tipo_coef) values('descuento_TA_71-75', 0.35185, 'COAATGU', 'C')

	-- Inserción de fórmula para aplicar el descuento para las tarifas del tipo de actuación 71, 72, 73, 74 y 75 que sea necesario
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('formula_TA_71-75', 'COAATGU', 'F', '60 - (60 * [descuento_TA_71-75])')

	
	
	select @var = max(convert(int, id)) from tarifas_coeficientes 

	insert into tarifas_coeficientes (id, variable, igual_a, porcentaje, valor_fijo, colegio, tipo_coef, formula, tipo_autocalculado, minimo, maximo) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id , variable, igual_a, porcentaje, valor_fijo, colegio, tipo_coef, formula, tipo_autocalculado, minimo, maximo from tarifas_coeficientes_aux

	Select @var = max(convert(int, id)) from tarifas_coeficientes

	select @contador = valor from contadores where contador = 'id_tarifas_coef'

	if @var > @contador
		Begin
			update contadores set valor = @var where contador = 'id_tarifas_coef'
		end

	
	--// T.A = 01 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '01')

	--// T.A = 02 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 45, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '02')

	--// T.A = 03
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '03')

	--// T.A = 04
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 124, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '04')

	--// T.A = 05
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 102, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '05')

	--// T.A = 11 y T.O = '91', '92' ó '93'
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 155, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra in ( '91', '92', '93') )

	--// T.A = 11 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 80, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 11 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 130, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 11 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 210, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 11 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 310, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 11 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 480, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '11' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)

	--// T.A = 12 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 65, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 12 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 110, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 12 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 180, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 12 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 280, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 12 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 450, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '12' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)

	--// T.A = 13 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '13' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 13 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 100, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '13' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 13 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 160, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '13' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 13 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 250, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '13' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 13 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 410, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '13' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)

	--// T.A = 14 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 14 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 100, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 14 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 160, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 14 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 250, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 14 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 410, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '14' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)


	--// T.A = 15 y T.O = '91', '92' ó '93'
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 155, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra in ( '91', '92', '93') )

	--// T.A = 15 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 80, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 15 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 130, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 15 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 210, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 15 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 310, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 15 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 480, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '15' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)


	--// T.A = 16 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 135, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '16' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 16 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 175, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '16' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 16 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 235, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '16' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 16 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 325, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '16' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 16 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 485, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '16' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)


	--// T.A = 17 y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 135, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 0)

	--// T.A = 17 y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 175, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 50.001)

	--// T.A = 17 y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 235, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 100.001)

	--// T.A = 17 y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 325, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 300.001)

	--// T.A = 17 y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 485, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '17' and tarifas_tipo_act.tipo_obra = '%' and sup_desde = 500.001)


	--// T.A = '31' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 35, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '31' )

	--// T.A = '32' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 45, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '32' )

	--// T.A = '33' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 70, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '33' )

	--// T.A = '41' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 70, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '41' )
	
	--// T.A = '42' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '42' )

	--// T.A = '43' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 35, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '43' )

	--// T.A = '44' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '44' )

	--// T.A = '45' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '45' )

	--// T.A = '46' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '46' )

	--// T.A = '5%' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '5%' )

	--// T.A = '6%' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 35, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '6%' )

	--// T.A = '8%' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 35, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '8%' )

	--// T.A = '9%' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 35, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '9%' )

	--// T.A = '76' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '003', 15, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '76' )

	--// T.A = '71' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 018 - Visados en Papel
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '018', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '71' )

	--// T.A = '72' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 018 - Visados en Papel
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '018', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '72' )

	--// T.A = '73' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 018 - Visados en Papel
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '018', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '73' )

	--// T.A = '74' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 018 - Visados en Papel
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '018', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '74' )

	--// T.A = '75' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 018 - Visados en Papel
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '018', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '75' )

	--// T.A = '71' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 - Visado digital
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '017', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'formula_TA_71-75' and tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '71' )

	--// T.A = '72' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 - Visado digital
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '017', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'formula_TA_71-75' and tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '72' )

	--// T.A = '73' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 - Visado digital
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '017', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'formula_TA_71-75' and tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '73' )

	--// T.A = '74' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 - Visado digital
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '017', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'formula_TA_71-75' and tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '74' )

	--// T.A = '75' y T.O = '%' 
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 003 - Visado digital
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '017', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'formula_TA_71-75' and tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act = '75' )


	
	--// T.A = '1%' y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 004 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '004', 75, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') )


	--// T.A = '1%' y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 016 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '016', 135, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') and sup_desde = 0)

	--// T.A = '1%' y T.O = '%' y sup_desde = 50.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 016 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '016', 175, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') and sup_desde = 50.001)

	--// T.A = '1%' y T.O = '%' y sup_desde = 100.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 016 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '016', 235, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') and sup_desde = 100.001)

	--// T.A = '1%' y T.O = '%' y sup_desde = 300.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 016 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '016', 325, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') and sup_desde = 300.001)

	--// T.A = '1%' y T.O = '%' y sup_desde = 500.001
	--// Tipo de trámite = VV o REDOC o IP --> Artículo = 016 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '016', 485, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' and tarifas_tipo_act.tipo_act in ('11', '12', '13', '14', '15', '16', '17') and sup_desde = 500.001)

	--// T.A = '%' y T.O = '%' y sup_desde = 0
	--// Tipo de trámite = REDAP --> Artículo = 001 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '001', 30, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATGU' )


	select @var = max(convert(int, id)) from tarifas_importes

	insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente from tarifas_importes_aux 

	select @var = max(convert(int, id)) from tarifas_importes

	select @contador = valor from contadores where contador = 'ID_TARIFA_IMPORTE'

	if @var > @contador
		Begin
			update contadores set valor = (select max(convert(int, id)) from tarifas_importes ) where contador = 'ID_TARIFA_IMPORTE'
		end


	// Actualización de importes de los artículos indicados. 
	update csi_articulos_servicios set importe = 20, impuesto = 4.2 where codigo = '005'

	update csi_articulos_servicios set importe = 35, impuesto = 7.35 where codigo = '006'

	update csi_articulos_servicios set importe = 25, impuesto = 5.25 where codigo = '007'

	update csi_articulos_servicios set importe = 40, impuesto = 8.4 where codigo = '008'

	update csi_articulos_servicios set importe = 22, impuesto = 4.62 where codigo = '012'

	update csi_articulos_servicios set importe = 22, impuesto = 4.62 where codigo = '013'

	update csi_articulos_servicios set importe = 15, impuesto = 3.15 where codigo = 'LO'

	update csi_articulos_servicios set importe = 15, impuesto = 3.15 where codigo = 'LI'
	
	 
end 
;

--// Se eliminan tablas auxiliares
drop table tarifas_tipo_act_aux;
drop table tarifas_coeficientes_aux;
drop table tarifas_importes_aux;
drop table tarifas_informes_x_tramite_aux;