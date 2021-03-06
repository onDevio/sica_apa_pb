declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio <> 'COAATB' 
begin
	--Todos a excepción de Bizcaia. SCP-1644
	update var_globales set sn = '', texto = 'R', descripcion = 'Indica si en el proceso de contabilización, el concepto incluira sólo el num. de Registro o si tiene num. Visado, introduzca el num. visado' where nombre = 'g_conta_concepto_solo_n_registros' and sn = 'S'
	update var_globales set sn = '', texto = 'V', descripcion = 'Indica si en el proceso de contabilización, el concepto incluira sólo el num. de Registro o si tiene num. Visado, introduzca el num. visado' where nombre = 'g_conta_concepto_solo_n_registros' and sn = 'N'
end

if @colegio = 'COAATB' 
begin
	--PARA BIZCAIA. SCP-1644
	update var_globales set sn = '', texto = 'E', descripcion = 'Indica si en el proceso de contabilización, el concepto incluira sólo el num. de Registro o si tiene num. Visado, introduzca el num. visado' where nombre = 'g_conta_concepto_solo_n_registros'  
end

--Todos scp-1627
alter table musaat_params_linea_fe add id_col char(10) null

//Se actualiza la fecha de versión
update var_globales set texto='20110804', descripcion = 'versión v5.3.04' where nombre='g_version_minima'
;