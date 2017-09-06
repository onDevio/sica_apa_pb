Create table fases_pagos_plataforma (id_fases_pagos_plataforma numeric identity not null, id_fase char(10) not null, forma_pago_plataforma char(2) null, importe_pago double precision null,  fecha_orden datetime null, fecha_importacion datetime null, conciliado char(1) null, pasarela varchar (30) null, banco varchar(10) null, terminal char(3) null, codigo_comercio varchar(9) null, nombre_comercio varchar(50) null, numero_pedido varchar(12) null, divisa_nombre varchar(4) null, divisa_iso char(3) null, divisa_codigo char(3) null, importe_tpv double precision null, tipo_transaccion varchar(45) null, n_colegiado char(15) null, codigo_autorizacion char(6) null, pago_seguro char(1) null, estado varchar(15) null, fecha datetime null, detalles_codigo varchar(4) null, detalles_titulo varchar(100) null, detalles_descripcion text null);
--
ALTER TABLE fases_pagos_plataforma add constraint id_fase_pagos_plataforma_pk primary key nonclustered (id_fases_pagos_plataforma);
--
create table fases_pagos_facturas (id_fases_pagos_plataforma double precision not null, id_factura char(15) not null) ;
--
alter table fases_pagos_facturas add constraint id_fases_pagos_facturas primary key nonclustered (id_fases_pagos_plataforma, id_factura) ;
--
insert into csi_formas_de_pago (tipo_pago, descripcion, tipo, cuenta, contado, n_vencimientos, dias_primer_vencimiento, dias_entre_vencimiento, hay_ingreso, efecto, porcent_primero, porcent_resto, descripcion_breve, banco_asociado, fp_extra, declara_metalico_347, t_medio_cobro_pago ) (select 'TP', 'ABONADO POR TPV' , tipo, cuenta, contado, n_vencimientos, dias_primer_vencimiento, dias_entre_vencimiento, hay_ingreso, efecto, porcent_primero, porcent_resto, 'ABONADO TPV', banco_asociado, fp_extra, declara_metalico_347, t_medio_cobro_pago from csi_formas_de_pago where tipo_pago = 'TR');
--
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATMU'
	begin
		insert into t_control_eventos (control, evento, activo, param1, id_control, orden ) values('VISIBLE_TAB', 'FASES_PAGO_PLATAFORM', 'S', '1', 'PLATFORM01', '1' )
		insert into listados (descripcion, dw, ventana, orden, activo) values('Listado de Pagos en Plataforma', 'd_fases_listado_pagos_plataforma', 'w_fases_listados', '25', 'S' )
	end
else
	begin
		insert into t_control_eventos (control, evento, activo, param1, id_control, orden ) values('VISIBLE_TAB', 'FASES_PAGO_PLATAFORM', 'S', '0', 'PLATFORM01', '1' )
		insert into listados (descripcion, dw, ventana, orden, activo) values('Listado de Pagos en Plataforma', 'd_fases_listado_pagos_plataforma', 'w_fases_listados', '25', 'N' )
	end
;	
