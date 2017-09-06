--Script de Cambio de año
-- Script genericos

-- SCP-2560
-- Se entrada para csi_empresas_logos
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATZ'
   Begin
        INSERT INTO csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura,modulo, visible) VALUES ( '01',0,0,504,3236,'000','S')
        INSERT INTO csi_empresas_logos (codigo_empresa, pos_x, pos_y, altura, anchura,modulo, visible) VALUES ( '03',900,0,576,3104,'000','S')
   end
go