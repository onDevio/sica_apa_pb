-- SCP-2082 Logos
alter table csi_empresas_logos add logo varchar(60) null, modulo varchar(3) null, visible char(1) default 'N' null
create table tipos_modulos_logos (codigo varchar(3) not null, descripcion varchar(80) null )
alter table tipos_modulos_logos add constraint pk_tipos_modulos_logos primary key nonclustered(codigo)