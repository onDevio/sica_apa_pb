-- SCP-1912 Se activa numeración Registro E/S con tabla registro_series
declare @g_reg_es_series char(1)
declare @reg_es_series char(1)
declare @colegio varchar(10)
declare @empresa_aseguradora varchar(2)

select @colegio = texto from var_globales where nombre = 'COLEGIO'
select @g_reg_es_series = texto from var_globales where nombre = 'g_reg_es_series'
-- Prevenimos que asignemos un valor nulo a la descripción del contador
update csi_empresas set etiqueta_superior_listados = '' where etiqueta_superior_listados = null 

-- Activar @reg_es_series
if (@g_reg_es_series = 'N' )
	begin
		delete from registro_series where codigo IN ('RE','RS') and contador = 0
		insert registro_series (codigo, descripcion, cod_delegacion, contador, tipo, ruta_base, tiene_anyo, tiene_carpeta_final, impresora, bandeja, cod_aplicacion, empresa) 
			select substring(contador,1,1) + substring(contador,10,1),substring(contador,1,1) + substring(contador,10,1) + ' ' + etiqueta_superior_listados  ,'%',valor,substring(contador,10,1),'','S','N','','','',codigo
			 from contadores, csi_empresas where codigo = '01' AND contador IN ('REGISTRO_ENTRADA', 'REGISTRO_SALIDA')
		insert registro_series (codigo, descripcion, cod_delegacion, contador, tipo, ruta_base, tiene_anyo, tiene_carpeta_final, impresora, bandeja, cod_aplicacion, empresa) 
			select substring(contador,1,1) + substring(contador,10,1),substring(contador,1,1) + substring(contador,10,1) + ' ' + etiqueta_superior_listados  ,'%',0,substring(contador,10,1),'','S','N','','','',codigo
			 from contadores, csi_empresas where codigo <> '01' AND contador IN ('REGISTRO_ENTRADA', 'REGISTRO_SALIDA')
		update var_globales set texto = 'S' where nombre = 'g_reg_es_series' 
	end

-- Activar Murcia CON delegación: Delegaciones M y C
if @colegio = 'COAATMU'
	begin
		update registro_series SET descripcion = LTRIM(RTRIM(descripcion)) +' '+ 'MURCIA', cod_delegacion = 'M' WHERE empresa = '01'
		insert registro_series (codigo, descripcion, cod_delegacion, contador, tipo, ruta_base, tiene_anyo, tiene_carpeta_final, impresora, bandeja, cod_aplicacion, empresa) 
			select substring(contador,1,1) + substring(contador,10,1),substring(contador,1,1) + substring(contador,10,1) + ' ' + etiqueta_superior_listados +' '+ 'CARTAGENA','C',valor,substring(contador,10,1),'','S','N','','','',codigo
			 from contadores, csi_empresas where contador IN ('REGISTRO_ENTRADA_C', 'REGISTRO_SALIDA_C') AND csi_empresas.codigo = '01'
	end
;