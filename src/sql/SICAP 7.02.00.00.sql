//SCP-2400
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATA'
begin
update csi_articulos_servicios set descripcion = 'RECARGO VISADO PRESENCIAL' where codigo = '14'
end
;