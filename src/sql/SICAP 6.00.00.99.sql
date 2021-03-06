-- Tabla testupdater: id_testupdater, descripcion, ok, version

-- Vacíamos la tabla
DELETE FROM testupdater

declare @descripcion varchar(100)
declare @version varchar(10) 

declare @colegio varchar(10) 
declare @aux int
declare @g_reg_es_series char(1)

select @colegio = texto from var_globales where nombre = 'COLEGIO'
select @g_reg_es_series = texto from var_globales where nombre = 'g_reg_es_series'

select @descripcion = "MUSAAT_TARIFAS insert tarifa F" 
select @version = "5.03.07" 
select @aux = count(*) from musaat_tarifas where tarifa= 'F'
if @aux = 1
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "g_musaat_coef_poliza_plus update" 
select @aux = count(*) from var_globales where nombre = 'g_musaat_coef_poliza_plus' AND numero = 1
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "musaat_coef_c update coef 1.08" 
select @aux = count(*) from musaat_coef_c where tabla = 'A' and tipoact in ('14', '17') and tipoobra = '11' AND coef =1.08
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

--Alta al menos 2 registros
select @descripcion = "t_fases insert c_t_fase 76,77,79" 
select @aux = count(*) from t_fases where c_t_fase in ('76','77','79')
if @aux > 1
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

-- Alta 3 registros
select @descripcion = "musaat_coef_c insert tipoact 76,77,79" 
select @aux = count(*) from musaat_coef_c where tipoact in ('76','77','79')
if @aux = 3
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "musaat_coef_g update coef, coef_plus cobertura" 
select @aux = count(*) from musaat_coef_g where 
    (cobertura = 120000 AND coef = 1.757 AND coef_plus = 2.197)
 OR (cobertura = 150000 AND coef = 1.938 AND coef_plus = 2.423) 
 OR (cobertura = 200000 AND coef = 2.095 AND coef_plus = 2.619) 
 OR (cobertura = 250000 AND coef = 2.156 AND coef_plus = 2.695)
 OR (cobertura = 300000 AND coef = 2.228 AND coef_plus = 2.785)
 OR (cobertura = 450000 AND coef = 2.408 AND coef_plus = 3.010)
 OR (cobertura = 600000 AND coef = 2.591 AND coef_plus = 3.239)
 OR (cobertura = 900000 AND coef = 2.954 AND coef_plus = 3.693) 
if @aux = 8
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "colegios update musaat_coef_malus cod_colegio"
select @aux = count(*) from colegios where
	(musaat_coef_malus = 0.85 AND cod_colegio in('01','43'))
	OR (musaat_coef_malus = 0.88 AND cod_colegio = '16')
	OR (musaat_coef_malus = 0.90 AND cod_colegio = '19')
	OR (musaat_coef_malus = 0.91 AND cod_colegio = '20')
	OR (musaat_coef_malus = 0.92 AND cod_colegio in('36','41'))
	OR (musaat_coef_malus = 0.93 AND cod_colegio in('21','22','40', '55', '47'))
	OR (musaat_coef_malus = 0.95 AND cod_colegio ='02')
	OR (musaat_coef_malus = 0.97 AND cod_colegio in('96','56'))
	OR (musaat_coef_malus = 0.98 AND cod_colegio ='46')
	OR (musaat_coef_malus = 1.02 AND cod_colegio in('07', '25', '10', '15', '30', '34', '13','42','44','49','45'))
	OR (musaat_coef_malus = 1.03 AND cod_colegio in('04','06','14','23','26','32', '35', '52'))
	OR (musaat_coef_malus = 1.04 AND cod_colegio ='17')
	OR (musaat_coef_malus = 1.06 AND cod_colegio in ('08','31','37', '38'))
	OR (musaat_coef_malus = 1.07 AND cod_colegio ='50')
	OR (musaat_coef_malus = 1.08 AND cod_colegio in ('48','05'))
	OR (musaat_coef_malus = 1.10 AND cod_colegio  in('03','12', '18','33','39'))
	OR (musaat_coef_malus = 1 AND cod_colegio in('09','11','24','27','28','29','51'))
if @aux = 55
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "var_globales update g_col_coef_musaat" 
select @aux = count(*) from colegios, var_globales where 
	var_globales.nombre = 'g_col_coef_musaat' 
	AND colegios.musaat_coef_malus = var_globales.numero 
	AND colegios.cod_colegio IN 
	(select texto FROM var_globales where nombre = 'g_cod_colegio')
if @aux = 1
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

-- CAMBIAMOS DE VERSIÓN
select @version = "6.00.00" 

select @descripcion = "csi_param_facturas insert 2012" 
select @aux = count(*) from csi_param_facturas where anyo = '2012'
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "csi_series insert 2012" 
select @aux = count(*) from csi_series where anyo = '2012'
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "colegiados update facturas a Clientes" 
select @aux = count(*) from colegiados where NOT(ultima_factura = 0 AND ultima_factura_rectif = 0)
if @aux = 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "var_globales update g_anyo_numeracion 2012" 
select @aux = count(*) from var_globales where texto = '2012' AND nombre = 'g_anyo_numeracion'
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

-- Se deberá verificar mediante checklist. Reflejamos en la tabla los valores actuales del contador
--select @descripcion = "contadores update" 
--INSERT testupdater (descripcion, ok, version) select '(CHECKLIST) ' +LTRIM(RTRIM(contador)) + ',valor= ' + convert(varchar(10),valor),'S',@version from contadores WHERE contador like 'NUM_EXP%' OR contador like 'NUM_REG%' OR contador like 'NUM_SAL%' OR contador like 'REGISTRO_ENTRADA%' OR contador like 'REGISTRO_SALIDA%' OR contador like 'NUM_RENUNCIA%' OR contador like 'N_REMESA%' OR contador IN ('N_AVISO', 'LIBROS_ORDENES', 'LIBROS_INCIDENCIAS') ORDER BY contador

-- No hay ninguno de los contadores (para los colegios afectados)  que no se hayan reseteado a 0
select @descripcion = "contadores update valor=0 Colegio<>COAATB" 
select @aux = count(*) from contadores where valor <> 0
	AND (contador like 'NUM_EXP%' OR contador like 'NUM_REG%' OR contador like 'NUM_SAL%' OR contador like 'REGISTRO_ENTRADA%' OR contador like 'REGISTRO_SALIDA%' OR contador like 'NUM_RENUNCIA%') AND 
	((select texto FROM var_globales where nombre = 'g_cod_colegio') NOT IN ('COAATB'))
if @aux = 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end	

-- No hay ninguno de los contadores (para los colegios afectados)  que no se hayan reseteado a 0
select @descripcion = "contadores update valor=0 N_AVISO Colegio IN Ávila, León, Burgos, Navarra, La Rioja" 
select @aux = count(*) from contadores where valor <> 0
	AND contador = 'N_AVISO' AND 
	((select texto FROM var_globales where nombre = 'g_cod_colegio') IN ('COAATAVI','COAATLE','COAATLR','COAATNA','COAATBU'))
if @aux = 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end	

-- No hay ninguno de los contadores (para los colegios afectados)  que no se hayan reseteado a 0
select @descripcion = "contadores update valor=2012000001 LIBROS_... Colegio=COAATNA" 
select @aux = count(*) from contadores where valor <> 2012000001
	AND contador IN ('LIBROS_ORDENES','LIBROS_INCIDENCIAS') AND 
	((select texto FROM var_globales where nombre = 'g_cod_colegio') IN ('COAATNA'))
if @aux = 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end		
	
-- No hay ninguno de los contadores (para los colegios afectados)  que no se hayan reseteado a 0
select @descripcion = "contadores update valor=0 N_REMESA Colegio=COAATTER" 
select @aux = count(*) from contadores where valor <> 0
	AND contador like ('N_REMESA%') AND 
	((select texto FROM var_globales where nombre = 'g_cod_colegio') IN ('COAATTER'))
if @aux = 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end		

-- Para los colegios a los que se ha activado Reg.E/S hay algún contador llamado RE en la tabla registro_series 
select @descripcion = "registro_series insert g_reg_es_series update Colegio=Varios" 
select @aux = count(*) from registro_series where codigo = 'RE'
if ((@colegio = 'COAATA' OR @colegio = 'COAATB' OR @colegio = 'COAATGU' OR @colegio = 'COAATGUI' OR @colegio = 'COAATMU' OR @colegio = 'COAATLR' OR @colegio = 'COAATFE' OR @colegio = 'COAATTER') AND @g_reg_es_series = 'S' AND @aux >0) 
	OR
NOT(@colegio = 'COAATA' OR @colegio = 'COAATB' OR @colegio = 'COAATGU' OR @colegio = 'COAATGUI' OR @colegio = 'COAATMU' OR @colegio = 'COAATLR' OR @colegio = 'COAATFE' OR @colegio = 'COAATTER')	
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end		
;