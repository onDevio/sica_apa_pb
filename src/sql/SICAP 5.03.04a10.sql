declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

// SCP-1660. Alexis. 19/09/2011
// Para todos los colegios excepto León
insert into var_globales (nombre, sn, descripcion) values ('g_imprimir_registro_docs_fase', 'S', 'Variable para controlar la impresión del documento que se imprime con la asignación de num. de registro en los documentos de una fase') 
if @colegio = 'COAATLE' 
begin
	// Sólo para León
	UPDATE var_globales SET sn = 'N' WHERE nombre = 'g_imprimir_registro_docs_fase'
end

// SCP-728. Alexis. 20-09-2011
// Para todos los colegios excepto Terres
insert into var_globales (nombre, sn, descripcion) values ('permitir_generar_apuntes_garantias', 'S', 'Variable para controlar la generación de los apuntes relacionados con la garantia. En principio unicamente para Terres') 
if @colegio = 'COAATTEB' 
begin
	// SÓLO PARA Terres:
	UPDATE var_globales  SET sn = 'N' WHERE nombre = 'permitir_generar_apuntes_garantias' 
end


//SCP-1832. Sólo Guipuzkoa
if @colegio = 'COAATGUI' 
begin
	update fases_finales_acciones_realiza set descripcion = 'Se deben regularizar los gastos ya que el presupuesto final supera en más de un 20% el inicial.' WHERE id_accion = '0000000002'
end

// SCP-1837. Alexis. 08/11/2011	
update colegios set cod_sica = cod_colegio where cod_sica = '' or cod_sica = null
// SCP-1851 Se actualiza la fecha de versión
update var_globales set texto='20111108', descripcion = 'versión v5.03.04a10' where nombre='g_version_minima'
;