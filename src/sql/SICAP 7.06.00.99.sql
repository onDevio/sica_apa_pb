--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "7.06.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- SCP-2513
IF EXISTS (SELECT * FROM var_globales WHERE texto='20140603' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
--
-- SCP-2495 
-- Se comprueba la creación de los campos Iban y BIC en la tabla de domiciliaciones. 
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'domiciliaciones' AND syscolumns.name in ('iban', 'bic') ) = 2

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2495. Se creó los campos bic e iban en la tabla domiciliaciones de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2495. No se pudo crear los campos bic e iban en la tabla domiciliaciones de la BBDD','N',@version)
	END
--
-- SCP-2497 
-- Se crea variable para controlar el uso de las fechas de abono o visado en la generación de los movimientos de Musaat. 
if @colegio = 'COAATAVI' OR @colegio ='COAATGU' OR @colegio = 'COAATLE' OR @colegio = 'COAATA' OR @colegio = 'COAATNA' OR @colegio ='COAATTGN' OR @colegio = 'COAATTEB' OR @colegio = 'COAATMCA' OR @colegio = 'COAATCC' OR @colegio = 'COAATLL'
	begin 
		if (Select count(*) from var_globales where nombre = 'g_utiliza_f_abono_fichero_eco' and sn = 'S') = 1
			begin 
				insert testupdater (descripcion,ok,version) values('SCP-2497. Se insertó correctmente la variable global g_utiliza_f_abono_fichero_eco','S',@version)
			end 
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2497. No se insertó correctmente la variable global g_utiliza_f_abono_fichero_eco','S',@version)
			end 
	
	end 
else 
	begin 
		if (Select count(*) from var_globales where nombre = 'g_utiliza_f_abono_fichero_eco' and sn = 'N') = 1
			begin 
				insert testupdater (descripcion,ok,version) values('SCP-2497. Se insertó correctmente la variable global g_utiliza_f_abono_fichero_eco','S',@version)
			end 
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2497. No se insertó correctmente la variable global g_utiliza_f_abono_fichero_eco','S',@version)
			end 
	end 
--
-- SCP-2351
-- Se crea variable para controlar el criterio de generación de las fechas de los movimientos de Musaat, Fecha de Factura ó Fecha de Sistema. 
if @colegio = 'COAATLR'
	begin 
		if (Select count(*) from var_globales where nombre = 'g_musaat_movi_fecha_sistema_o_factura' and texto = 'F') = 1
			begin 
				insert testupdater (descripcion,ok,version) values('SCP-2351. Se insertó correctmente la variable global g_musaat_movi_fecha_sistema_o_factura','S',@version)
			end 
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2351 No se insertó correctmente la variable global g_musaat_movi_fecha_sistema_o_factura','S',@version)
			end 
	
	end 
else 
	begin 
		if (Select count(*) from var_globales where nombre = 'g_musaat_movi_fecha_sistema_o_factura' and texto = 'S') = 1
			begin 
				insert testupdater (descripcion,ok,version) values('SCP-2351. Se insertó correctmente la variable global g_musaat_movi_fecha_sistema_o_factura','S',@version)
			end 
		else
			begin
				insert testupdater (descripcion,ok,version) values('SCP-2351. No se insertó correctmente la variable global g_musaat_movi_fecha_sistema_o_factura','S',@version)
			end 
	end 
;
;
