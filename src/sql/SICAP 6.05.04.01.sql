// SCP-2253 COAAT Ávila: Añadimos parametrización que desactive el texto ORIGINAL/COPIA en facturas
insert into var_globales (nombre, sn, descripcion, modificable) values('g_fact_ocultar_original_copia', 'N', 'Variable para controlar que se pueda ocultar ORIGINAL/COPIA al imprimir facturas.', 'N')
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
if @colegio = 'COAATAVI'
begin
UPDATE var_globales SET sn = 'S' WHERE nombre = 'g_fact_ocultar_original_copia'
end
;