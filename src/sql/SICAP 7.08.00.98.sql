-- versión
update var_globales set texto='20140911', descripcion = 'versión v7.08.00' where nombre='g_version_minima';
update var_globales set sn='S' where nombre='g_carga_a_pruebas'; -- para el paso a PRO