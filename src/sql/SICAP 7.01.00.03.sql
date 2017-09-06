//SCP-2396
declare @colegio varchar (10)
declare @id_tarifa_nueva varchar (10)
declare @id_tarifa int
declare @id_tarifa_tipo_act int
declare @contador int
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATGUI'
begin
INSERT INTO t_fases (c_t_fase , d_t_descripcion, grupo) VALUES ('79','INFORME FINAL GESTION DE RESIDUOS','4')
INSERT INTO musaat_coef_c VALUES (	'79',	'*',	0,	'D',	-1,	9999999,	'19000101', '20500101')
select @id_tarifa_tipo_act = max(convert(int, id_tarifa)) from tarifas_tipo_act
INSERT into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, pem_desde, otro_desde, colegio) values (replicate ('0',10 - char_length(convert(varchar, @id_tarifa_tipo_act +1))) + convert(varchar, @id_tarifa_tipo_act +1),'79', '%',-1,-1,-1,'COAATGUI')
select @id_tarifa_nueva = id_tarifa from tarifas_tipo_act where tipo_act = '79' and colegio = 'COAATGUI'
select @id_tarifa = max(convert(int, id)) from tarifas_importes
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar, @id_tarifa +1))) + convert(varchar, @id_tarifa +1), @id_tarifa_nueva, '06', 20, 1, 'N' ) //REGISTRO
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar, @id_tarifa +2))) + convert(varchar, @id_tarifa +2), @id_tarifa_nueva, '09', 20, 1, 'N' ) //visado
update tarifas_importes set precio_base = 75 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '77') and id_informe ='06'
update tarifas_importes set precio_base = 85 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '77') and id_informe ='09'
end
--
if @colegio = 'COAATAVI' 
begin
    delete tarifas_importes  WHERE id_informe = 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act = '03' and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000068' where tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('44', '45', '46') and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '65' where  id_informe = 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('14', '17', '11') and tipo_obra not in ('5%', '7%', '9%') and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000017' where  id_informe = 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('14', '17', '11') and tipo_obra = '5%' and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000016' where  id_informe = 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('14', '17', '11') and tipo_obra in('7%', '9%') and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000017' where  id_informe <> 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act = '14' and tipo_obra = '9%' and colegio = 'COAATAVI' and otro_hasta = 750)
    update tarifas_importes set id_coeficiente = '0000000020' where  id_informe <> 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act = '14' and tipo_obra = '9%' and colegio = 'COAATAVI' and otro_hasta = 3000)
    update tarifas_importes set id_coeficiente = '0000000068' where tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act = '%' and tipo_obra = '82' and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000069' where tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('78', '77') and tipo_obra = '%' and colegio = 'COAATAVI')
    update tarifas_importes set id_coeficiente = '0000000068' where tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('71', '72', '73', '74', '75', '76', '41', '42', '43', '6%', '8%', '9%' ) and tipo_obra = '%' and colegio = 'COAATAVI')
--
 select @contador = valor from contadores where contador = 'ID_TARIFA'
    insert into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, pem_desde, otro_desde, colegio) values(replicate ('0',10 - char_length(convert(varchar, @contador +1))) + convert(varchar, @contador +1), '14', '6%', -1,-1,-1, 'COAATAVI')
    insert into tarifas_tipo_act (id_tarifa, tipo_act, tipo_obra, sup_desde, pem_desde, otro_desde, colegio) values(replicate ('0',10 - char_length(convert(varchar, @contador +2))) + convert(varchar, @contador +2), '17', '6%', -1,-1,-1, 'COAATAVI')
    update contadores set valor = @contador + 2 where contador = 'ID_TARIFA'
--
    select @contador = valor from contadores where contador = 'ID_TARIFA_IMPORTE'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 1))) + convert(varchar, @contador + 1), id_tarifa, '02', 0, 1, 'S', '0000000022' from tarifas_tipo_act where tipo_act = '14' and tipo_obra = '6%' and colegio = 'COAATAVI'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 2))) + convert(varchar, @contador + 2), id_tarifa, '03', 0, 1, 'S', '0000000022' from tarifas_tipo_act where tipo_act = '14' and tipo_obra = '6%' and colegio = 'COAATAVI'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 3))) + convert(varchar, @contador + 3), id_tarifa, 'cfo', 0, 1, 'S', '0000000017' from tarifas_tipo_act where tipo_act = '14' and tipo_obra = '6%' and colegio = 'COAATAVI'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 4))) + convert(varchar, @contador + 4), id_tarifa, '02', 0, 1, 'S', '0000000022' from tarifas_tipo_act where tipo_act = '17' and tipo_obra = '6%' and colegio = 'COAATAVI'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 5))) + convert(varchar, @contador + 5), id_tarifa, '03', 0, 1, 'S', '0000000022' from tarifas_tipo_act where tipo_act = '17' and tipo_obra = '6%' and colegio = 'COAATAVI'
    insert into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes, id_coeficiente) select replicate ('0',10 - char_length(convert(varchar, @contador + 6))) + convert(varchar, @contador + 6), id_tarifa, 'cfo', 0, 1, 'S', '0000000017' from tarifas_tipo_act where tipo_act = '17' and tipo_obra = '6%' and colegio = 'COAATAVI'
    update contadores set valor = @contador + 6 where contador = 'ID_TARIFA_IMPORTE'
--
    delete from tarifas_tipo_act where colegio = 'COAATAVI' and tipo_act = '17' and tipo_obra = '5%' and sup_desde > 0
    update tarifas_tipo_act set sup_desde = -1, sup_hasta = null, pem_desde = -1, pem_hasta = null, otro_desde = -1, otro_hasta = null where colegio = 'COAATAVI' and tipo_act = '17' and tipo_obra = '5%' and sup_desde = 0
    update tarifas_importes set id_coeficiente = '0000000020' where  id_informe <> 'cfo' and tarifas_importes.id_tarifa in (SELECT tarifas_tipo_act.id_tarifa from tarifas_tipo_act where tipo_act in ('14', '17') and tipo_obra in ('5%', '6%') and colegio = 'COAATAVI')
end 
;