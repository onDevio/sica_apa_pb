// SCP-2026
create table csi_lineas_fact_emi_premaat (id_linea char(10) not null, ips double precision null, ccs double precision null) ;
alter table csi_lineas_fact_emi_premaat add constraint csi_lineas_fact_emi_premaat_x primary key nonclustered (id_linea) ;
//
//SCP-2267
CREATE TABLE src_colegiado (id_src_colegiado char(10) not null, id_colegiado char(10) null, src_cia char(2) null, tramo char(2) default 'A' null, alta char(1) default 'S' null, f_alta datetime null, f_baja datetime null, motivo_baja varchar(255) null, moroso char(1) default 'N' null, numero_siniestros double precision null, numero_certificado varchar(15) null, numero_poliza varchar(15) null, src_cober varchar(9) null)  ;
alter table src_colegiado add constraint src_colegiado_x primary key nonclustered (id_src_colegiado) ;
//
CREATE TABLE src_colegiado_aux (id_src_colegiado numeric(10,0) identity, id_colegiado char(10) null, src_cia char(2) null, f_alta datetime null, f_baja datetime null, numero_poliza varchar(15) null, src_alta char(1) null)  ;
alter table src_colegiado_aux add constraint src_colegiado_aux_x primary key nonclustered (id_src_colegiado) ;
//
insert into src_colegiado_aux (id_colegiado, src_cia, f_alta, f_baja, numero_poliza, src_alta) select id_col, src_cia, src_f_alta, src_f_baja, src_n_poliza, src_alta from musaat;
//
insert into src_colegiado (id_src_colegiado,id_colegiado, src_cia, f_alta, f_baja, numero_siniestros, numero_poliza) select replicate ('0', 10 - char_length(convert(varchar(10), id_src_colegiado))) + convert(varchar(10), id_src_colegiado) as id, id_colegiado, src_cia, f_alta, f_baja, 0, numero_poliza from src_colegiado_aux where src_alta = 'O';
//
insert into src_colegiado (id_src_colegiado,id_colegiado, alta,  numero_siniestros) select replicate ('0', 10 - char_length(convert(varchar(10), id_src_colegiado))) + convert(varchar(10), id_src_colegiado) as id, id_colegiado, 'N', 0 from src_colegiado_aux where src_alta <> 'O';
//
insert into contadores (contador, valor, descripcion, modificable) select 'ID_SRC_COLEGIADOS', max(id_src_colegiado), "Contador para la tabla src_colegiado", "N" from src_colegiado_aux;
//
drop table src_colegiado_aux; 
//
update musaat set src_alta = 'N' where src_alta = 'O';
//
update listados set descripcion = 'Listado del SRC MUSAAT' where dw = 'd_musaat_listado_src';
