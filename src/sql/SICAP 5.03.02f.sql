declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

--Solo CACERES. 
if @colegio = 'COAATCC' 
begin
-- Solo empresa Aseguradora (03)
	update csi_param_facturas set texto ='Agencia de Seguros Exclusiva de MUSAAT, ~nMutua de Seguros a Prima Fija.~nCon nº de Registro: M0368B10407377' where serie='PC' and empresa='03' and campo ='N_emisor2'
end

//Se actualiza la fecha de versión
update var_globales set texto='20110608', descripcion = 'versión v5.3.02f' where nombre='g_version_minima'
;