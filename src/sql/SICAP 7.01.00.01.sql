//SCP-2392
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO' 
if @colegio = 'COAATGUI'
begin
INSERT INTO csi_param_facturas VALUES ( '%', '%', '%', '%', 't_recc', 'Kutxa-Irizpidearen Araubide Berezia') 
end 
if @colegio = 'COAATTEB' or @colegio = 'COAATTGN'
begin
INSERT INTO csi_param_facturas VALUES ( '%', '%', '%', '%', 't_recc', 'Règim Especial del Criteri de Caixa') 
end
else 
begin
INSERT INTO csi_param_facturas VALUES ( '%', '%', '%', '%', 't_recc', 'Régimen Especial del Criterio de Caja')
end 


//SCP-2385
if @colegio = 'COAATNA'
begin
insert into t_control_eventos (evento, control, activo, id_control, mensaje) values('CALCULAR_GASTOS', 'COMPROBAR_PROY_NA', 'S', 'NA-P+D', 'Control para direcciones cuyo colegiado ya haya presentado un proyecto del mismo expediente.')
insert into var_globales (nombre, numero, descripcion, modificable) values ('g_tarifa_Navarra_direccion_despues_de_contrato', 27, 'Cantidad a cobrar en los contratos de tipo dirección (13 o 16) si el mismo colegiado como autor a entregado el proyecto (12 o 15) con anterioridad', 'S')
end 

else
begin
insert into t_control_eventos (evento, control, activo, id_control, mensaje) values('CALCULAR_GASTOS', 'COMPROBAR_PROY_NA', 'N', 'NA-P+D', 'Control para direcciones cuyo colegiado ya haya presentado un proyecto del mismo expediente.')
end
;


