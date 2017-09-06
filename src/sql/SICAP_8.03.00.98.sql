
-- versión. SCP-2577
update var_globales set texto='20150624', descripcion = 'versión v8.03.00' where nombre='g_version_minima'
	go
update var_globales set sn='S' where nombre='g_carga_a_pruebas'
	go
 -- para el paso a PRO