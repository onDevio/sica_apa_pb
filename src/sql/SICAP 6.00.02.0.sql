-- Creamos la nueva tabla csi_empresas_logos 
create table csi_empresas_logos (id_empresa_logo numeric identity not null, codigo_empresa varchar(5) null, pos_x int null, pos_y int null, altura int null, anchura int null);
alter table csi_empresas_logos add constraint pk_csi_empresas_logos primary key nonclustered(id_empresa_logo);
