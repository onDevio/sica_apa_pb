declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// Sólo colegio Navarra

if @colegio = 'COAATNA' 

begin
	insert into tarifas_coeficientes (id, variable, igual_a, porcentaje, colegio) values ('0000000011', 'visared', 'V', -25, 'COAATNA')

	update csi_articulos_servicios set exp = 'S', es_informe = 'S' where codigo = '100107'

end;
