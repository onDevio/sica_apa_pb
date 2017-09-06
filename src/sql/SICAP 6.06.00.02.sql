-- SCP-2272
create table fases_siniestros_coles_aux (id_siniestro char(10) not null, id_colegiado char(10) not null, src_n_poliza char(10) null, src_cober char(3) null, reclamacion_colegiado char(1) null) ;
alter table fases_siniestros_coles_aux add constraint pk primary key nonclustered (id_siniestro, id_colegiado) ;
	
insert into fases_siniestros_coles_aux (id_siniestro, id_colegiado, src_n_poliza, src_cober, reclamacion_colegiado) 
	select id_siniestro, id_colegiado, src_n_poliza, src_cober, reclamacion_colegiado  from fases_siniestros_coles;

drop table fases_siniestros_coles;

create table fases_siniestros_coles (id_siniestro char(10) not null, id_colegiado char(10) not null, src_n_poliza varchar(15) null, src_cober char(3) null, reclamacion_colegiado char(1) null, src_cia char(2) default 'MU' null, src_cober_otras varchar(15) null) ;
alter table fases_siniestros_coles add constraint pk primary key nonclustered (id_siniestro, id_colegiado) ;

insert into fases_siniestros_coles (id_siniestro, id_colegiado, src_n_poliza, src_cober, reclamacion_colegiado, src_cia, src_cober_otras) 
	select id_siniestro, id_colegiado, src_n_poliza, src_cober, reclamacion_colegiado, 'MU',''  from fases_siniestros_coles_aux;

drop table fases_siniestros_coles_aux;