--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
select @version = "8.02.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
-- otras variables
declare @num_errores integer
select @num_errores = 0 
--
--SCP-2274
if @colegio = 'COAATLR' 
BEGIN
	if (SELECT count(*) FROM csi_param_facturas where serie = 'carta' and empresa = '01') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2274. Actualizados corretamente csi_param_facturas','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2274. NO actualizados corretamente csi_param_facturas','N',@version)
			select @num_errores = (@num_errores + 1)
		END

	if (SELECT count(*) FROM csi_param_facturas where serie = 'carta' and empresa = '02') = 1
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2274. Actualizados corretamente csi_param_facturas','S',@version)
		END
	else 
		BEGIN
			insert testupdater (descripcion,ok,version) values('SCP-2274. NO actualizados corretamente csi_param_facturas','N',@version)
			select @num_errores = (@num_errores + 1)
		END
END
--

GO