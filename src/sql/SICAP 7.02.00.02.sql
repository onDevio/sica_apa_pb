//SCP-2403
//Script 1

CREATE TABLE csi_bancos_maestro_bic (id_codigo_bic numeric(10,0) identity NOT NULL, codigo_entidad varchar(10) NULL, codigo_bic varchar(11) NULL, codigo_por_defecto char(1) DEFAULT 'N' NULL);
ALTER TABLE csi_bancos_maestro_bic add constraint csi_bancos_maestro_bic_pk primary key nonclustered (id_codigo_bic);

alter table conceptos_remesables add datos_bancarios_iban varchar(34) null;
alter table conceptos_remesables add bic varchar(11) null;

alter table conceptos_domiciliables add datos_bancarios_iban varchar(34) null;
alter table conceptos_domiciliables add bic varchar(11) null;

alter table colegiados add datos_bancarios_iban varchar(34) null;
alter table colegiados add bic varchar(11) null;

alter table colegiados add cuenta_personal_iban varchar(34) null;
alter table colegiados add cuenta_personal_bic varchar(11) null;

alter table clientes add datos_bancarios_iban varchar(34) null;
alter table clientes add bic varchar(11) null;

create table csi_bancos_maestro_aux (cod char(10) not null, descripcion char(60) null) ;
alter table csi_bancos_maestro_aux add constraint csi_bancos_maestro_aux_x primary key nonclustered (cod);
