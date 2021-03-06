//SCP-2530 
if (SELECT  count(*) FROM csi_articulos_servicios where lower(codigo) = '150ac' and activo = 'S' ) = 0
  BEGIN
    insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150Ac', 'PREMAAT - CUOTA SEG. ACCIDENTES', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'AC', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')
  END
--
--
if (SELECT  count(*) FROM csi_articulos_servicios where lower(codigo) = '150oc' and activo = 'S' ) = 0
  BEGIN
    insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150oC', 'PREMAAT - OTRAS COBERTURAS', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'Oc', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')
  END
--
// SCP2532
insert into t_aplicacion (cod_aplicacion, nombre) values ('CUMPLE_COL', 'Permiso para indicar que recibe notificaciones de los cumpleaños');
--
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio= 'COAATAVI' 
	begin
		insert into t_permisos (cod_usuario, cod_aplicacion, permiso) values('0000000003', 'CUMPLE_COL', 'E')
	end
else 
	begin
		insert into t_permisos (cod_usuario, cod_aplicacion, permiso) values('0000000005', 'CUMPLE_COL', 'E')
	end
--
-- SCP-2528. Cambios para las cartas de reclamación de Ávila
If @colegio = 'COAATAVI'
	begin 
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('carta', '01', '%', '%', 'info_bancaria', "B).- Mediante ingreso en la c/c IBAN ES90 2038 7725 2468 0003 4436 de Bankia o la c/c IBAN ES06 0030 1065 5000 0057 2271 del Banco Santander, haciendo constar la referencia")
	end 
--
-- SCP-2374. Cambios para las cartas de reclamación de Gipuzkoa
If @colegio = 'COAATGUI'
	begin 
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('carta', '%', '%', '%', 'codigo_banco1', "03") 
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('carta', '%', '%', '%', 'codigo_banco2', "04")
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('carta', '%', '%', '%', 'nombre_banco1_eus', "KUTXA BANK")
		insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values('carta', '%', '%', '%', 'nombre_banco2_eus', "LABORAL KUTXA")
	end 
--
-- SCP-2414. Se crea listado para Caceres
If @colegio = 'COAATCC'
	begin 
		Insert into listados (descripcion, dw, ventana, orden, activo) values ("Listado Servicios Encargos Profesionales", "d_colegiados_listado_serv_encargos_prof", "w_colegiados_listados", '0', 'S')
	end 
;