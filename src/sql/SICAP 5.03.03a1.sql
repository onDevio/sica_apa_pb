// SOLO SE DEBE REALIZAR ESTE CAMBIO PARA LOS COLEGIOS QUE SOLICITEN
// FORMATO GENERICO DE MUSAAT Y PREMAAT
//Sustituir <EMPRESA ASEGURADORA> por el codigo de la empresa
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio = 'COAATGU' 
begin
	update csi_series set dataobject = 'd_recibo_musaat_generico' where serie in ('PC', 'PF') and anyo='2011' and empresa = '04'
	update csi_series set dataobject = 'd_recibo_premaat_cuota_generico' where serie = 'MU' and anyo='2011' and empresa = '04'
end 

//Se actualiza la fecha de versión
update var_globales set texto='20110630', descripcion = 'versión v5.3.03a1' where nombre='g_version_minima'
;