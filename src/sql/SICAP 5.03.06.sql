declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio = 'COAATMCA' 
begin
	//Sólo COAAT Mallorca
	UPDATE csi_series SET serie_abono = '' WHERE empresa = (SELECT texto FROM var_globales WHERE nombre = 'g_cod_empresa_aseguradora') AND anyo='2011' AND serie = (SELECT texto FROM var_globales WHERE nombre = 'g_fases_serie_musaat')
end 

//Se actualiza la fecha de versión
update var_globales set texto='20111115', descripcion = 'versión v5.3.06' where nombre='g_version_minima';