--Script de Cambio de año
-- Script genericos

-- SCP-2560
-- Se entrada para csi_empresas_logos
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATLL'
   Begin
	Insert into var_globales (nombre, texto, descripcion, modificable) values ('g_sepa_habilitado', 'PLAYD0', 'Clave de acceso a las funcionalidades SEPA. No tocar', 'N')
   end
go