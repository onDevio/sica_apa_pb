--Versión SICAP 6.00.00
--Modificación en le menú
update menu set descripcion = 'Recálculo Avisos/Proformas' where objeto= 'm_aplic_frame.m_file.m_new.m_src.m_recalculoavisos'

-- tabla temporal utilizada para los test de cambio de año
create table dbo.testupdater (id_testupdater numeric identity not null, descripcion varchar(100) null, ok varchar(1) null, version varchar (20) null)
alter table dbo.testupdater add constraint testupdater_x primary key nonclustered(id_testupdater) 

-- versión
update var_globales set texto='20111212', descripcion = 'versión v6.00.00' where nombre='g_version_minima';


