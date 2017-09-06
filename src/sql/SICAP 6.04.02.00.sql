-- 1. Nuevo contador para mantenimiento de de artículos por trámite.
insert into contadores (contador, valor, descripcion, modificable) values('id_tarifas_informes', 100000, "contador para el mantenimiento de informes por trámites del calculo de gastos", "N" );

--// 4. Se crean nuevos campo en la tabla tarifas_coeficientes.
--// Se crea tabla auxiliar para el nuevo campo tipo_coef que será obligatorio. 
create table dbo.tarifas_coeficientes_aux (id varchar(10) not null, variable varchar(100) null, igual_a varchar(50) null, porcentaje double precision null, valor_fijo double precision null, colegio varchar(10) null, tipo_coef char(1) not null) ;
alter table dbo.tarifas_coeficientes_aux add constraint pk_t_coef_aux primary key nonclustered (id) ;

insert into tarifas_coeficientes_aux select id, tarifas_coeficientes.variable, igual_a, porcentaje, valor_fijo, colegio, 'C' from tarifas_coeficientes;

drop table tarifas_coeficientes;

create table dbo.tarifas_coeficientes (id varchar(10) not null, variable varchar(100) null, igual_a varchar(50) null, porcentaje double precision null, valor_fijo double precision null, colegio varchar(10) null, tipo_coef char(1) not null) ;
alter table dbo.tarifas_coeficientes add constraint pk_t_coef primary key nonclustered (id) ;

insert into tarifas_coeficientes select id, tarifas_coeficientes_aux.variable, igual_a, porcentaje, valor_fijo, colegio, 'C' from tarifas_coeficientes_aux;

drop table tarifas_coeficientes_aux;

alter table tarifas_coeficientes add formula varchar(180) null;
alter table tarifas_coeficientes add tipo_autocalculado char(1) null;
alter table tarifas_coeficientes add minimo double precision null;
alter table tarifas_coeficientes add maximo double precision null;


--// 5. Actualización de de coeficientes de tipo D
update tarifas_coeficientes set tipo_coef = 'D' where valor_fijo = null;


--// 8. Creación de nuevo contador para los coeficientes
declare @var int

select @var = max(convert(int, id)) from tarifas_coeficientes 

begin 
insert into contadores (contador, valor, descripcion, modificable) select 'id_tarifas_coef', max(convert(int, id)), "contador para el mantenimiento de coeficientes de tarifas de gastos", "N" from tarifas_coeficientes
end 
;


--// 9. Creación de nuevos campo en la tabla tarifas_importes.
alter table tarifas_importes add aplica_coeficientes char(1) null;
alter table tarifas_importes add id_coeficiente varchar(10) null;

--// 10. Actualiza coeficientes
update tarifas_importes set aplica_coeficientes = 'N';