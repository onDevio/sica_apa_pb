//SCP-2403
//Script 3


drop table csi_bancos_maestro;
create table csi_bancos_maestro (id char(10) not null, cod varchar(10) null, descripcion varchar(60) null, pais char(2) null) ;
alter table csi_bancos_maestro add constraint csi_bancos_maestro_x primary key nonclustered (id) ;