-- SCP-2243
declare @colegio varchar(10)
declare @contador int
select @colegio = texto from var_globales where nombre = 'COLEGIO'
// SCP-1647
if @colegio = 'COAATACC'
begin
update premaat set alta_reta = 'S', fecha_alta_reta = f_alta where grupo = 'R'
update t_control_eventos set control = 'AVISO_PREMAAT_RETA', id_control= 'AVISORETA' where control = 'AVISO_NO_PREMAAT'
end 
//
-- SCP-2332 Avila
if @colegio = 'COAATAVI'
begin
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '75k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '15' and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '50k'))
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '150k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '15' and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '120k'))
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '75k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '13' or tipo_act = '16') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '50k')) and id_informe <> 'cfo'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '125k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '13' or tipo_act = '16') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '100k')) and id_informe <> 'cfo'
select @contador = valor from contadores where contador = 'id_tarifas_coef'
insert into tarifas_coeficientes (id, variable, colegio, tipo_coef, formula) values ( convert(varchar,@contador+1) ,'45k', 'COAATAVI', 'F', '45 * [k]')
update contadores set valor = (@contador+1) where contador = 'id_tarifas_coef'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '45k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '13' or tipo_act = '16') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '50k')) and id_informe = 'cfo'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '75k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '50k')) and id_informe <> 'cfo'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '125k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '100k')) and id_informe <> 'cfo'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '45k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and colegio = 'COAATAVI')) and (id_coeficiente in ( select id from tarifas_coeficientes where variable = '50k')) and id_informe = 'cfo'
update tarifas_importes set id_coeficiente = (select id from tarifas_coeficientes where variable = '25k')
where (id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '77' and colegio = 'COAATAVI')) and (id_coeficiente in (select id from tarifas_coeficientes where variable = '30k'))
//
select @contador = valor from contadores where contador = 'id_tarifas_coef'
insert into tarifas_coeficientes (id, variable, igual_a, porcentaje, colegio, tipo_coef) values ( convert(varchar,@contador+1), 'visared', 'V', -10, 'COAATAVI', 'D')
end 
;