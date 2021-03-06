declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio = 'COAATGU' 
begin
	//Colegio de Guadalajara
	insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values( 'MT', '04', '2011', '%', 'dir_premaat','c\Juan Ramon Jiménez 15')
	insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values( 'MT', '04', '2011', '%', 'pob_premaat','28036 Madrid')
	insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values( 'MT', '04', '2011', '%', 'nif_premaat','G28618536')
	insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) values( 'MT', '04', '2011', '%', 'emisor_premaat','PREMAAT, Previsión Mutua de Aparejadores y Arquitectos Técnicos, M.P.S')
end

//Se actualiza la fecha de versión
update var_globales set texto='20110707', descripcion = 'versión v5.3.03a3' where nombre='g_version_minima'
;