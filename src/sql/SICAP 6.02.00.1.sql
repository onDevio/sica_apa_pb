declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--SCP-2004
if @colegio = 'COAATGU'
begin
	UPDATE csi_series SET dataobject = '' WHERE serie = 'MT' AND empresa = '04' AND anyo = 'XX'
	UPDATE csi_series SET dataobject = 'd_premaat_factura_cuotas_gu' WHERE serie = 'MT' AND empresa = '04' AND anyo = '2012'
end
;