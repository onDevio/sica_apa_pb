//SCP-2454
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATGUI'
begin
	update csi_param_facturas set texto = 'Régimen Especial del Criterio de Caja Kutxa-Irizpidearen Araubide Berezia' where campo = 't_recc' and idioma = '%'
end
;
