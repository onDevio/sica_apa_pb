declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

--Solo Murcia. 
if @colegio = 'COAATMU' 
begin
	UPDATE csi_empresas SET logo='logo_datie.jpg' WHERE es_colegio = 'N'
end

//Se actualiza la fecha de versión
update var_globales set texto='20111123', descripcion = 'versión v5.03.07' where nombre='g_version_minima'
;