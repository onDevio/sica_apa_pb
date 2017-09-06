//SCP-2388 Cambios de tarifas 2014 para COAAT-LA RIOJA
declare @colegio varchar (10)
declare @id_tarifa_nueva varchar (10)
declare @id_tarifa_nueva2 varchar (10)
declare @id_tarifa_nueva3 varchar (10)
declare @id_tarifa_nueva4 varchar (10)
declare @id_tarifa int
declare @id_tarifa_tipo_act int
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATLR'
begin
update tarifas_importes set precio_base = 50 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '01' and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 95 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '01' and colegio = 'COAATLR' ) and id_informe = '00-01'
//
update tarifas_importes set precio_base = 40 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '02' and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 65 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '02' and colegio = 'COAATLR' ) and id_informe = '00-01'
//
update tarifas_importes set precio_base = 40 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '03' and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 85 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '03' and colegio = 'COAATLR' ) and id_informe = '00-01'
//
update tarifas_importes set precio_base = 80 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '04' and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 125 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '04' and colegio = 'COAATLR' ) and id_informe = '00-01'
//
update tarifas_importes set precio_base = 80 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '05' and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 115 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '05' and colegio = 'COAATLR' ) and id_informe = '00-01'
//
//actualizacion de rangos de PEM
//tipo_act 11
update tarifas_tipo_act set pem_hasta = 60000 where tipo_act = '11' and pem_desde = 0 and pem_hasta = 30000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 60001, pem_hasta = 150000 where tipo_act = '11' and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 150001, pem_hasta = 300000 where tipo_act = '11' and pem_desde = 60001 and pem_hasta = 100000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 300001  where tipo_act = '11' and pem_desde = 100001 and colegio = 'COAATLR'
//
//actualizacion de importes
update tarifas_importes set precio_base = 145 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 160 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 165 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 185 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 205 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 150001 and pem_hasta = 300000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 230 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 150001 and pem_hasta = 300000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 235 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 300001 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 255 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '11' and pem_desde = 300001 and colegio = 'COAATLR' ) and id_informe = '00-01'
//
//
//tipo_act 12/15
update tarifas_tipo_act set pem_hasta = 60000 where (tipo_act = '15' or tipo_act = '12') and pem_desde = 0 and pem_hasta = 30000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 60001,  pem_hasta = 150000 where (tipo_act = '15' or tipo_act = '12') and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 150001,  pem_hasta = 300000 where (tipo_act = '15' or tipo_act = '12') and pem_desde = 60001 and pem_hasta = 100000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 300001  where (tipo_act = '15' or tipo_act = '12') and pem_desde = 100001 and colegio = 'COAATLR'
//
//actualizacion de importes
update tarifas_importes set precio_base = 145 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 160 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 165 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 185 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 205 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 150001 and pem_hasta = 300000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 230 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 150001 and pem_hasta = 300000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 235 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 300001 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 265 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '12' or tipo_act = '15') and pem_desde = 300001 and colegio = 'COAATLR' ) and id_informe = '00-01'
//
//tipo_act 16
update tarifas_tipo_act set pem_hasta = 60000 where tipo_act = '16' and pem_desde = 0 and pem_hasta = 30000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 60001, pem_hasta = 150000 where tipo_act = '16' and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR'
update tarifas_tipo_act set  pem_desde = 150001, pem_hasta = null where tipo_act = '16' and pem_desde = 60001 and pem_hasta = 100000 and colegio = 'COAATLR'
delete from tarifas_importes where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_desde = 100001 and colegio = 'COAATLR')
delete from tarifas_tipo_act where tipo_act = '16' and pem_desde = 100001 and colegio = 'COAATLR'
//
//actualizacion de importes
update tarifas_importes set precio_base = 145 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 150 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 150 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 155 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 170 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_desde = 150001 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 175 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '16' and pem_desde = 150001 and colegio = 'COAATLR' ) and id_informe = '00-01'
//
//tipo_act 13
update tarifas_tipo_act set pem_hasta = 3000 where tipo_act = '13' and pem_desde = 0 and pem_hasta = 30000 and colegio = 'COAATLR'
update tarifas_tipo_act set pem_desde = 3001 , pem_hasta = 60000 where tipo_act = '13' and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR'
update tarifas_tipo_act set pem_desde = 60001,  pem_hasta = 150000 where tipo_act = '13' and pem_desde = 60001 and pem_hasta = 100000 and colegio = 'COAATLR'
update tarifas_tipo_act set pem_desde = 150001,  pem_hasta = null where tipo_act = '13' and pem_desde = 100001 and colegio = 'COAATLR'
//
//actualizacion de importes
update tarifas_importes set precio_base = 65 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_hasta = 3000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 65 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_hasta = 3000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 145 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 150 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 30001 and pem_hasta = 60000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 150 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 155 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 60001 and pem_hasta = 150000 and colegio = 'COAATLR' ) and id_informe = '00-01'
update tarifas_importes set precio_base = 170 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 150001 and colegio = 'COAATLR' ) and id_informe = '00-00'
update tarifas_importes set precio_base = 175 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act = '13' and pem_desde = 150001 and colegio = 'COAATLR' ) and id_informe = '00-01'
//
select @id_tarifa_tipo_act = max(convert(int, id_tarifa)) from tarifas_tipo_act
INSERT into tarifas_tipo_act (id_tarifa, tipo_act,   tipo_obra,  sup_desde,  pem_desde, pem_hasta , otro_desde,  colegio) values (replicate ('0',10 - char_length(convert(varchar,@id_tarifa_tipo_act +1))) + convert(varchar,@id_tarifa_tipo_act +1),'14', '%',-1,600001,1000000,-1,'COAATLR')
INSERT into tarifas_tipo_act (id_tarifa, tipo_act,   tipo_obra,  sup_desde,  pem_hasta, otro_desde,  colegio) values (replicate ('0',10 - char_length(convert(varchar,@id_tarifa_tipo_act +2))) + convert(varchar,@id_tarifa_tipo_act +2),'14', '%',-1,100000 ,-1,'COAATLR')
INSERT into tarifas_tipo_act (id_tarifa, tipo_act,   tipo_obra,  sup_desde,  pem_desde, pem_hasta , otro_desde,  colegio) values (replicate ('0',10 - char_length(convert(varchar,@id_tarifa_tipo_act +3))) + convert(varchar,@id_tarifa_tipo_act +3),'17', '%',-1,600001,1000000,-1,'COAATLR')
INSERT into tarifas_tipo_act (id_tarifa, tipo_act,   tipo_obra,  sup_desde,  pem_hasta, otro_desde,  colegio) values (replicate ('0',10 - char_length(convert(varchar,@id_tarifa_tipo_act +4))) + convert(varchar,@id_tarifa_tipo_act +4),'17', '%',-1,100000,-1,'COAATLR')
//
//tarifas_importes 14/17
select @id_tarifa_nueva = id_tarifa from tarifas_tipo_act where tipo_act = '14' and pem_desde = 600001 and pem_hasta = 1000000 and colegio = 'COAATLR'
select @id_tarifa = max(convert(int, id)) from tarifas_importes
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +1))) + convert(varchar,@id_tarifa +1), @id_tarifa_nueva, '00-00', 510, 1, 'N' ) 
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +2))) + convert(varchar,@id_tarifa +2), @id_tarifa_nueva, '00-01', 510, 1, 'N' ) 
select @id_tarifa_nueva2 = id_tarifa from tarifas_tipo_act where tipo_act = '14' and pem_hasta = 100000 and colegio = 'COAATLR'
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +3))) + convert(varchar,@id_tarifa +3), @id_tarifa_nueva2, '00-00', 150, 1, 'N' ) 
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +4))) + convert(varchar,@id_tarifa +4), @id_tarifa_nueva2, '00-01', 150, 1, 'N' ) 
//
select @id_tarifa_nueva3 = id_tarifa from tarifas_tipo_act where tipo_act = '17' and pem_desde = 600001 and pem_hasta = 1000000 and colegio = 'COAATLR'
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +5))) + convert(varchar,@id_tarifa +5), @id_tarifa_nueva3, '00-00', 510, 1, 'N' ) 
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +6))) + convert(varchar,@id_tarifa +6), @id_tarifa_nueva3, '00-01', 510, 1, 'N' ) 
select @id_tarifa_nueva4 = id_tarifa from tarifas_tipo_act where tipo_act = '17' and pem_hasta = 100000 and colegio = 'COAATLR'
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +7))) + convert(varchar,@id_tarifa +7), @id_tarifa_nueva4, '00-00', 150, 1, 'N' ) 
INSERT into tarifas_importes (id, id_tarifa, id_informe, precio_base, coef_modificador, aplica_coeficientes) values(replicate ('0',10 - char_length(convert(varchar,@id_tarifa +8))) + convert(varchar,@id_tarifa +8), @id_tarifa_nueva4, '00-01', 150, 1, 'N' ) 
//
//rangos PEM 14/17
update tarifas_tipo_act set pem_desde = 100001,  pem_hasta = 300000 where  (tipo_act = '14' or tipo_act = '17') and pem_desde = 0 and pem_hasta = 300000 and colegio = 'COAATLR'
update tarifas_tipo_act set pem_desde = 300001,  pem_hasta = 600000 where  (tipo_act = '14' or tipo_act = '17') and pem_desde = 300001 and pem_hasta = 1000000 and colegio = 'COAATLR'
//
//actualizacion importes
update tarifas_importes set precio_base = 760 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and pem_desde = 1000001 and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')
update tarifas_importes set precio_base = 230 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and pem_desde = 100001 and pem_hasta = 300000 and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')
update tarifas_importes set precio_base = 310 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '14' or tipo_act = '17') and pem_desde = 300001 and pem_hasta = 600000 and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')
//actualizacion importes 31, 32, 33
update tarifas_importes set precio_base = 145 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '31' or tipo_act = '32' or tipo_act = '33') and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')
//
//actualizacion importes 41, 42
update tarifas_importes set precio_base = 100 where id_tarifa in (select id_tarifa from tarifas_tipo_act where (tipo_act = '41' or tipo_act = '42') and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')
//
//actualizacion importes 62, 63, 65, 66, 61, 64, 71, 72, 73, 74, 75, 91, 92, 93, 94, 95, 81, 82, 83.
update tarifas_importes set precio_base = 25 where id_tarifa in (select id_tarifa from tarifas_tipo_act where tipo_act in ('62','63','65','66','61','64','71','72','73','74','75','91','92','93','94','95','81','82','83')  and colegio = 'COAATLR' ) and (id_informe = '00-00' or id_informe = '00-01')



//SCP-462
//Este campo no estaba en la base de datos

alter table fases_colegiados add proy char(1) default 'N' null
end
;