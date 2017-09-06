INSERT INTO var_globales (nombre,texto,descripcion,modificable) values ('g_hoja_reclamo_recibos_impagados','d_cobros_carta_reclamo','Variable para almacenar el nombre del dw de reclamación de recibos impagados','S')
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--SCP-2058, SCP-2030
if @colegio = 'COAATNA'
begin
	UPDATE var_globales SET texto = 'd_cobros_carta_reclamo_logos_cuenta_bancaria' WHERE nombre = 'g_hoja_reclamo_recibos_impagados'
	DELETE FROM csi_empresas_logos
	UPDATE csi_empresas SET logo = 'colegio_ENCABEZADO.jpg' WHERE codigo = '01'
	UPDATE csi_empresas SET logo = 'narial_ENCABEZADO.jpg' WHERE codigo = '02'
end
;