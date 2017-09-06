create table dbo.tarifas_informes_x_tramite_aux (id numeric(10,0) identity, tipo_tramite varchar(10) null, visared varchar(1) null, id_informe varchar(10) null, colegio varchar(10) null, aplica_parti char(1) null);
alter table dbo.tarifas_informes_x_tramite_aux add constraint pk_tarifas_inf_x_tramite_aux primary key nonclustered (id) ;
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

// Sólo colegio Murcia
if @colegio = 'COAATMU'
begin

	// Inserción de entradas para que asocie los artículos a los tipos de trámite.
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'REDAP', '%', '05', 'COAATMU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'REDOC', '%', '05', 'COAATMU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'VV', '%', '02', 'COAATMU', 'S')
	insert into tarifas_informes_x_tramite_aux (tipo_tramite, visared, id_informe, colegio, aplica_parti) values ( 'IP', '%', '02', 'COAATMU', 'S')

	select @var = max(convert(int, id)) from tarifas_informes_x_tramite 

	insert into tarifas_informes_x_tramite (id, tipo_tramite, visared, id_informe, colegio, aplica_parti) select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id))) ) + convert(varchar, @var + convert(int,id)) as id , tipo_tramite, visared, id_informe, colegio, aplica_parti  from tarifas_informes_x_tramite_aux 
	
	update contadores set valor = (select max(convert(int, id)) from tarifas_informes_x_tramite ) where contador = 'id_tarifas_informes'

	
	//Introducción de entradas en la tabla tarifas_tipo_act. Datos de tipos de actuación, tipos de obra y rangos aplicados. 

	// T.A = '01' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 0, 100000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 100001, 200000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 200001, 400000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 400001, 600000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 600001, 1000000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '01', '%', -1, null, 1000001, null, -1, null, 'COAATMU')

	// T.A = '02' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '02', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '01' and tipo_obra = '%'

	// T.A = '04' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '04', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '01' and tipo_obra = '%'

	// T.A = '05' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '05', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '01' and tipo_obra = '%'


	// T.A = '03' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 0, 20000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 20001, 50000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 50001, 75000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 75001, 100000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 100001, 200000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 200001, 400000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 400001, 600000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 600001, 1000000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '03', '%', -1, null, 1000001, null, -1, null, 'COAATMU')



	// T.A = '12' y T.O = '1%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 0, 20000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 20001, 50000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 50001, 75000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 75001, 100000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 100001, 200000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '12', '1%', -1, null, 200001, null, -1, null, 'COAATMU')

	// T.A = '12' y T.O = '2%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '2%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'

	// T.A = '12' y T.O = '3%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '3%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'

	// T.A = '12' y T.O = '4%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '4%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'

	// T.A = '12' y T.O = '7%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '7%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'

	// T.A = '12' y T.O = '84'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '84', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'

	// T.A = '12' y T.O = '9%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '12', '9%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12' and tipo_obra = '1%'



	// T.A = '15' = T.A = '12'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '15', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'

	// T.A = '11' = T.A = '12'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '11', tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '12'



	// T.A = '41'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '41', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '52'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '52', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '54'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '54', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.O = '83'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '%', '83', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '42'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '42', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '32'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '32', '%', -1, null, -1, null, -1, null, 'COAATMU')

		

	// T.A = '13' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 0, 20000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 20001, 50000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 50001, 75000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 75001, 100000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 100001, 200000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 200001, 400000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 400001, 600000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 600001, 1000000, -1, null, 'COAATMU')

	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '13', '%', -1, null, 1000001, null, -1, null, 'COAATMU')

	// T.A = '14' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '14', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '%'

	// T.A = '16' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '16', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '%'

	// T.A = '17' y T.O = '%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) select '17', '%', sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux where tipo_act = '13' and tipo_obra = '%'


	// T.A = '7%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '7%', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '62'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '62', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '63'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '63', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '64'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '64', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '65'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '65', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '66'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '66', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '91'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '91', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '92'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '92', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '8%'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '8%', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '93'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '94', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '95'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '95', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '61'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '61', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '43'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '43', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '44'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '44', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '45'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '45', '%', -1, null, -1, null, -1, null, 'COAATMU')

	// T.A = '46'
	insert into tarifas_tipo_act_aux (tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) values( '46', '%', -1, null, -1, null, -1, null, 'COAATMU')

	select @var = max(convert(int, id_tarifa)) from tarifas_tipo_act 

	--// Inserción de datos sobre la tabla tarifas_tipo_act
	insert into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio) (select replicate ('0', 10 - char_length(convert(varchar, @var + convert(int,id_tarifa))) ) + convert(varchar, @var + convert(int,id_tarifa)) as id_tarifa , tipo_act, tipo_obra, sup_desde, sup_hasta, pem_desde, pem_hasta, otro_desde, otro_hasta, colegio from tarifas_tipo_act_aux )

	update contadores set valor = (select max(convert(int, id_tarifa)) from tarifas_tipo_act) where contador = 'ID_TARIFA'



	-- Inserción de coeficiente de incremento para T.A 11 (PROYECTO Y DIRECCION) 
	insert into tarifas_coeficientes_aux (variable, valor_fijo, colegio, tipo_coef) values('incremento_TA_11', 1.25, 'COAATMU', 'C')

	-- Inserción de coeficiente de incremento para T.A 04 o 05  (Estudio básico y coordinación) 
	insert into tarifas_coeficientes_aux (variable, valor_fijo, colegio, tipo_coef) values('incremento_EBSC', 1.25, 'COAATMU', 'C')

	-- Se añade coeficiente para el descuento de Obra oficial:
	insert into tarifas_coeficientes_aux (variable, igual_a, porcentaje, colegio, tipo_coef) values('obra_oficial', 'S', -50, 'COAATMU', 'D')

	-- Inserción de fórmulas para aplicar el incremento para las tarifas del tipo de actuación 11 que sea necesario
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV1', 'COAATMU', 'F', ' 70 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV2', 'COAATMU', 'F', ' 100 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV3', 'COAATMU', 'F', ' 145 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV4', 'COAATMU', 'F', ' 160 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV5', 'COAATMU', 'F', ' 200 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV6', 'COAATMU', 'F', ' 250 * [incremento_TA_11]')

	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR1', 'COAATMU', 'F', ' 40 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR2', 'COAATMU', 'F', ' 60 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR3', 'COAATMU', 'F', ' 90 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR4', 'COAATMU', 'F', ' 100 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR5', 'COAATMU', 'F', ' 120 * [incremento_TA_11]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR6', 'COAATMU', 'F', ' 150 * [incremento_TA_11]')

	-- Inserción de fórmulas para aplicar el incremento para las tarifas del tipo de actuación 04 o 05 que sea necesario
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV7', 'COAATMU', 'F', ' 70 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV8', 'COAATMU', 'F', ' 100 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV9', 'COAATMU', 'F', ' 120 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV10', 'COAATMU', 'F', ' 150 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV11', 'COAATMU', 'F', ' 200 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DV12', 'COAATMU', 'F', ' 300 * [incremento_EBSC]')

	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR7', 'COAATMU', 'F', ' 40 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR8', 'COAATMU', 'F', ' 60 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR9', 'COAATMU', 'F', ' 72 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR10', 'COAATMU', 'F', ' 90 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR11', 'COAATMU', 'F', ' 120 * [incremento_EBSC]')
	insert into tarifas_coeficientes_aux (variable, colegio, tipo_coef, formula) values('DR12', 'COAATMU', 'F', ' 180 * [incremento_EBSC]')


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

	--// T.A = 01 o 02
	--// Tipo de trámite = registro --> Artículo = 05 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 72, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 600000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 120, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 1000000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 180, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_desde = 1000001)

	--// T.A = 01 o 02
	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 70, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 100, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 120, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 150, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 600000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 200, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_hasta = 1000000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 300, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('01','02') and pem_desde = 1000001)



	--// T.A = 03
	--// Tipo de trámite = registro --> Artículo = 05 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 18, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 24, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 33, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 45, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 55, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 75, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 600000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 110, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 1000000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 125, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_desde = 1000001)

	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 30, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 55, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 66, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 75, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 120, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 600000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 180, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_hasta = 1000000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 210, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '03' and pem_desde = 1000001)


	--// T.A = 04 o 05
	--// Tipo de trámite = registro --> Artículo = 05 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR7' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR8' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR9' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR10' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 600000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR11' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 1000000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR12' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_desde = 1000001)

	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV7' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV8' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV9' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV10' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 600000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV11' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_hasta = 1000000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV12' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('04','05') and pem_desde = 1000001)


	--// T.A = 12 o 15
	--// Tipo de trámite = registro --> Artículo = 05 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 100, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 120, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 200000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 150, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_desde = 200001)

	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 70, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 100, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 145, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 160, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 200, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_hasta = 200000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 250, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in ('12','15') and pem_desde = 200001)



	--// T.A = 11
	--// Tipo de trámite = registro --> Artículo = 05 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR1' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR2' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR3' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR4' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR5' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 200000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '05', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DR6' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_desde = 200001)

	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV1' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV2' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV3' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV4' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV5' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_hasta = 200000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) (select tarifas_tipo_act.id_tarifa, '02', 0, 1, 'S', tarifas_coeficientes.id from tarifas_tipo_act, tarifas_coeficientes where tarifas_coeficientes.variable = 'DV6' and tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act = '11' and pem_desde = 200001)


	--// T.A = 13, 14, 16 o 17
	--// Tipo de trámite = registro --> Artículo = 05 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 24, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 36, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 54, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 72, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 105, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 150, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 210, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 600000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 300, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 1000000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 480, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_desde = 1000001)

	--// Tipo de trámite = visado --> Artículo = 02 

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 20000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 60, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 50000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 75000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 120, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 100000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 175, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 200000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 250, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 400000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 350, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 600000)
		
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 500, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_hasta = 1000000)

	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 800, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('13', '14', '16', '17') and pem_desde = 1000001)



	--// T.A = 32, 41, 42, 52, 54
	--// Tipo de trámite = registro --> Artículo = 05 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 40, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('32', '41', '42',  '52', '54') )
	--// Tipo de trámite = visado --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 70, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('32', '41', '42', '52', '54') )

	--// T.A = 83
	--// Tipo de trámite = registro --> Artículo = 05 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 50, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_obra = '83')
	--// Tipo de trámite = visado --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 90, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_obra = '83')

	--// T.A = 43-46, 7%, 61-66, 8%, 91-94
	--// Tipo de trámite = registro --> Artículo = 05 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '05', 15, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('43', '44', '45', '46', '7%', '61', '62', '63', '64', '65', '66', '8%', '91', '92', '93', '94') )
	--// Tipo de trámite = visado --> Artículo = 02 
	insert into tarifas_importes_aux (id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) (select tarifas_tipo_act.id_tarifa, '02', 25, 1, 'N' from tarifas_tipo_act where tarifas_tipo_act.colegio = 'COAATMU' and tarifas_tipo_act.tipo_act in('43', '44', '45', '46', '7%', '61', '62', '63', '64', '65', '66', '8%', '91', '92', '93', '94') )


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
	drop table tarifas_informes_x_tramite_aux;
	drop table tarifas_tipo_act_aux;
	drop table tarifas_coeficientes_aux;
	drop table tarifas_importes_aux;
