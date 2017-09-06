
-- versión. SCP-2565
update var_globales set texto='20150113', descripcion = 'versión v8.00.01' where nombre='g_version_minima'
GO	
update var_globales set sn='S' where nombre='g_carga_a_pruebas'
GO
 -- para el paso a PRO