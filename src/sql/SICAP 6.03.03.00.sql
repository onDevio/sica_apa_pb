declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

if @colegio = 'COAATCC'
begin
--SCP-2123 Confirmar con el colegio si quieren mantener esta funcionalidad
insert csi_param_sigescon(nombre, valor_texto, descripcion)
values('g_conta_cobro_ejercicio_noactual','S', 
'Permite contabilizar cobros que no pertenecen al ejercicio actual')
end 
else
begin
insert csi_param_sigescon(nombre, valor_texto, descripcion)
values('g_conta_cobro_ejercicio_noactual','N', 
'Permite contabilizar cobros que no pertenecen al ejercicio actual')
end
;