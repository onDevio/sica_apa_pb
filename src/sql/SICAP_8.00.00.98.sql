
-- versi�n. SCP-2557
update var_globales set texto='20141227', descripcion = 'versi�n v8.00.00' where nombre='g_version_minima'
GO	
update var_globales set sn='S' where nombre='g_carga_a_pruebas'
GO
 -- para el paso a PRO