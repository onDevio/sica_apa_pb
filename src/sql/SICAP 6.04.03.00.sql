--Script de Cambio de año
-- Script genericos

-- Se inserta las configuraciones de facturas para el 2013
insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) select serie, empresa, '2013', idioma, campo, texto from csi_param_facturas where anyo = '2012'

-- Se insertan las series de facturas para el 2013, de todas las empresas
insert into csi_series (serie, empresa, contador, descripcion, recib, anyo, dataobject, tipo, serie_abono, proforma, serie_por_defecto)
select serie,   empresa,   0,   descripcion,   recib,   '2013', dataobject, tipo, serie_abono, proforma, serie_por_defecto
from csi_series  where anyo = '2012'   

-- Se actualiza los contadores de facturas de colegiados
update colegiados set ultima_factura = 0 
update colegiados set ultima_factura_rectif = 0 

--Se actualiza el año en variables globales
update var_globales set texto = '2013' where nombre = 'g_anyo_numeracion';
-- Versión Inicio de año 2013


-- Cambios en MUSAAT 2013 FALTA MODIFICAR EL COEF PLUS QUE NO LO HAN NOTIFICADO(27/11)
update musaat_coef_g set coef = 1.804 , coef_plus = 2.255 where musaat_coef_g.cobertura = 120000 
update musaat_coef_g set coef = 1.990, coef_plus = 2.488  where musaat_coef_g.cobertura = 150000 
update musaat_coef_g set coef = 2.152 , coef_plus = 2.690 where musaat_coef_g.cobertura = 200000 
update musaat_coef_g set coef = 2.214, coef_plus = 2.768  where musaat_coef_g.cobertura = 250000 
update musaat_coef_g set coef = 2.288, coef_plus = 2.860  where musaat_coef_g.cobertura = 300000 
update musaat_coef_g set coef = 2.473, coef_plus = 3.091  where musaat_coef_g.cobertura = 450000 
update musaat_coef_g set coef = 2.661, coef_plus = 3.326  where musaat_coef_g.cobertura = 600000 
update musaat_coef_g set coef = 3.034, coef_plus = 3.793  where musaat_coef_g.cobertura = 900000 

-- Se actualiza el minimo para la tarifa F que corresponde a los tipos de actuación 76,79 y 77
update  musaat_tarifas  set minimo = 3 where tarifa = 'F'

-- Se actualiza el coeficiente de zona a 1, por que se elimina
update colegios set musaat_coef_malus = 1

-- Antigua variable utilizada para el coeficiente de zona se actualiza
update var_globales set numero = 1 where nombre = 'g_col_coef_musaat'

-- SCP-2223 Cambios PREMAAT 2013
insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150Pr', 'PREMAAT- CUOTA Premaat Profesional', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'Pr', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')

insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150B+', 'PREMAAT- CUOTA Básico ampliado', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'B+', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')

insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150Aj', 'PREMAAT- CUOTA Premaat Plus (Ah.Jub.)', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'Aj', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')

insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150Jc', 'PREMAAT- CUOTA JUBILACIÓN C1', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'Jc', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')

insert into csi_articulos_servicios (codigo, descripcion, familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, concepto_conta, suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar) (select '150Jb', 'PREMAAT- CUOTA JUBILACIÓN Básico', familia, cuenta, cta_presupuestaria, exp, general, importe, activo, es_informe, impuesto, orden, colegio, t_iva, honorario, impreso, en_ficha_colegiado, 'Jb', suplido, grupo_gastos, ing_gas, incluir_347, tiene_irpf, empresa, cta_gasto, regularizar from csi_articulos_servicios where codigo = '150Ba' and activo = 'S')

insert into premaat_grupo (codigo, descripcion) values ('Pr','PREMAAT PROFESIONAL')
insert into premaat_grupo (codigo, descripcion) values ('Pl','PREMAAT PLUS')
insert into premaat_grupo (codigo, descripcion) values ('B+','GRUPO BÁSICO AMPLIADO/ALTERNATIVIDAD')

insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('13', 'INCAPACIDAD PERMANENTE', 'S')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('14', 'ACCIDENTE(MATERNIDAD)', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('15', 'MATERNIDAD O PATERNIDAD', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('16', 'RIESGO DURANTE EL EMBARAZO', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('17', 'INCAPACIDAD TRANSITORIA(ACCIDENTE)', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('18', 'INCAPACIDAD TRANSITORIA(INFARTO)', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('19', 'INCAPACIDAD TRANSITORIA(MATERNIDAD)', 'N')
insert into premaat_tipo_pres (codigo, descripcion, es_extra) values('20', 'ORFANDAD CON DISCAPACIDAD', 'N') 



declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- A bizkaia no se actualiza los contadores de exp, reg, visado y registros entrada salida
if @colegio <> 'COAATB'
begin
update contadores set valor = 0 where contador like 'NUM_EXP%'
update contadores set valor = 0 where contador like 'NUM_REG%'
update contadores set valor = 0 where contador like 'NUM_SAL%'

-- Se actualiza Número de renuncias
update contadores set valor = 0 where contador like 'NUM_RENUNCIA%'
end
-- Se actualiza el contador de número de avisos de facturas
-- Ávila, León, Burgos, Navarra, La Rioja
if @colegio = 'COAATAVI' or  @colegio = 'COAATLE' or @colegio = 'COAATLR' or @colegio = 'COAATNA' or  @colegio = 'COAATBU'
begin
Update contadores set valor = 0 where contador = 'N_AVISO'   
end 


--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATNA' 
begin
update contadores set valor = 2013000001 where contador like 'LIBROS_ORDENES'
update contadores set valor = 2013000001 where contador like 'LIBROS_INCIDENCIAS'
end

--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATTE' 
begin
update contadores set valor = 0 where contador like 'N_REMESA%'
end
 
;
