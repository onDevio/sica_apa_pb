-- Inicializamos la altura y anchura de la nueva tabla sólo si el colegio es Murcia
INSERT INTO csi_empresas_logos (codigo_empresa, pos_x,pos_y, altura, anchura) SELECT codigo,0,0,0,0 FROM csi_empresas
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATMU'
begin
	update csi_empresas_logos SET altura = 400, anchura = 526
end
;