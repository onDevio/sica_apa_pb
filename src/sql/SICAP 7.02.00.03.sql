//SCP-2403
//Script 2

insert into contadores (contador, valor, descripcion, modificable) values ('id_bancos_maestro',0, 'contador para la tabla csi_bancos_maestro', 'N'); 
insert into csi_bancos_maestro_aux (cod, descripcion) select csi_bancos_maestro.cod, csi_bancos_maestro.descripcion from csi_bancos_maestro;