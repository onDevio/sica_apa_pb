-- versión
update var_globales set texto='20141107', descripcion = 'versión v7.09.00' where nombre='g_version_minima';
update var_globales set sn='S' where nombre='g_carga_a_pruebas'; -- para el paso a PRO