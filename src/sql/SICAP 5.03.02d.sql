update var_globales set  nombre='g_dw_etiquetas_visado_old' where nombre = 'g_dw_etiquetas_visado';
//Se actualiza la fecha de versión
update var_globales set texto='20110525', descripcion = 'versión v5.3.02d' where nombre='g_version_minima';