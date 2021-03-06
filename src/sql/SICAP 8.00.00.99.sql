--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = '8.00.00'
select @colegio = texto from var_globales where nombre = 'COLEGIO'



-- otras variables

declare @count_2014 integer
declare @count_2015 integer
declare @num_errores integer
declare @resultado varchar(20)
select @num_errores = 0 

--

--SCP-2555-01
SELECT @count_2014 = count(*) FROM csi_param_facturas where anyo = '2014' 
SELECT @count_2015 = count(*) FROM csi_param_facturas where anyo = '2015' 

if @count_2014 <> @count_2015 
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2555-01. Actualizados correctamente las configuraciones de las facturas para el 2015','S',@version)
	END
else 
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2555-01. NO Actualizados correctamente las configuraciones de las facturas para el 2015','N',@version)
		select @num_errores = (@num_errores + 1)
	END


--

--SCP-2555-02
SELECT @count_2014 = 0
SELECT @count_2015 = 0
SELECT @count_2014 = count(*) FROM csi_series where anyo = '2014' 
SELECT @count_2015 = count(*) FROM csi_series where anyo = '2015' 

if @count_2014 <> @count_2015 
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2555-02. Actualizados correctamente las configuraciones de las facturas para el 2015','S',@version)
	END
else 
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2555-02. NO Actualizados correctamente las configuraciones de las facturas para el 2015','N',@version)
		select @num_errores = (@num_errores + 1)
	END
--

--SCP-2555-03
if (SELECT count(*) FROM colegiados where ultima_factura <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-03. Actualizado correctamente valor ultima_factura en colegiados','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-03. NO actualizado correctamente valor ultima_factura en colegiados','N',@version)
			select @num_errores = (@num_errores + 1)
		END

if (SELECT count(*) FROM colegiados where ultima_factura_rectif <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-03. Actualizado correctamente valor ultima_factura_rectif en colegiados','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-03. NO actualizado correctamente valor ultima_factura_rectif en colegiados','N',@version)
			select @num_errores = (@num_errores + 1)
		END
--

--SCP-2555-04
if (SELECT count(*) FROM var_globales where nombre = 'g_anyo_numeracion' and texto = '2015') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-04. Actualizado correctamente el valor de g_anyo_numeracion en var_globales.','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-04. NO actualizado correctamente el valor de g_anyo_numeracion en var_globales.','N',@version)
			select @num_errores = (@num_errores + 1)
		END
--

--SCP-2555-05
if @colegio <> 'COAATB' 
BEGIN
	if (SELECT count(*) FROM contadores where contador like 'NUM_EXP%' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. Actualizados corretamente contadores NUM_EXP%','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. NO actualizados corretamente contadores NUM_EXP%','N',@version)
			select @num_errores = (@num_errores + 1)
		END

	if (SELECT count(*) FROM contadores where contador like 'NUM_REG%' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. Actualizados corretamente contadores NUM_REG%','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. NO actualizados corretamente contadores NUM_REG%','N',@version)
			select @num_errores = (@num_errores + 1)
		END

	if (SELECT count(*) FROM contadores where contador like 'NUM_SAL%' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. Actualizados corretamente contadores NUM_SAL%','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. NO actualizados corretamente contadores NUM_SAL%','N',@version)
			select @num_errores = (@num_errores + 1)
		END

	if (SELECT count(*) FROM contadores where contador like 'NUM_RENUNCIA%' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. Actualizados corretamente contadores NUM_RENUNCIA%','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-05. NO actualizados corretamente contadores NUM_RENUNCIA%','N',@version)
			select @num_errores = (@num_errores + 1)
		END
END
--

-- SCP-2555-06
if @colegio = 'COAATAVI' or  @colegio = 'COAATLE' or @colegio = 'COAATLR' or @colegio = 'COAATNA' or  @colegio = 'COAATBU'
BEGIN
	if (SELECT count(*) FROM contadores where contador = 'N_AVISO' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-06. Actualizados corretamente contadores N_AVISO','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-06. NO actualizados corretamente contadores N_AVISO','N',@version)
			select @num_errores = (@num_errores + 1)
		END
END
--
-- SCP-2555-07
if @colegio = 'COAATNA'
BEGIN
	if (SELECT count(*) FROM contadores where contador = 'LIBROS_ORDENES' and valor <> 2015000001) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-07. Actualizados corretamente contadores LIBROS_ORDENES','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-07. NO actualizados corretamente contadores LIBROS_ORDENES','N',@version)
			select @num_errores = (@num_errores + 1)
		END
	if (SELECT count(*) FROM contadores where contador = 'LIBROS_INCIDENCIAS' and valor <> 2015000001) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-07. Actualizados corretamente contadores LIBROS_INCIDENCIAS','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-07. NO actualizados corretamente contadores LIBROS_INCIDENCIAS','N',@version)
			select @num_errores = (@num_errores + 1)
		END
END
--
-- SCP-2555-08
if @colegio = 'COAATTE' 
BEGIN
	if (SELECT count(*) FROM contadores where contador like 'N_REMESA%' and valor <> 0) = 0
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-08. Actualizados corretamente contadores N_REMESA%','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2555-08. NO actualizados corretamente contadores N_REMESA%','N',@version)
			select @num_errores = (@num_errores + 1)
		END
END
--

-- RESULTADO ACTUALIZACION
if @num_errores < 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('CORRECTA actualizacion','S',@version)
			select @resultado = 'CORRECTO ' + CONVERT (varchar(10), @num_errores)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('ERRORES en la actualizacion','N',@version)
			select @resultado = 'INCORRECTO ' + CONVERT (varchar(10), @num_errores)
		END
--


print @resultado

GO