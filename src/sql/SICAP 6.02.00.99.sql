declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
declare @aux int

declare @version varchar(10) 
select @version = "6.02.00" 
-- Comprobaci�n en testupdater

-- Actualizaci�n var_globales
IF EXISTS (SELECT * FROM var_globales WHERE texto='N' AND nombre='g_imprimir_talon_multiples')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Si colegio <> COAATLL then g_imprimir_talon_multiples = N','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado la variable g_imprimir_talon_multiples','N',@version)
	END

-- Verificamos se aplica el nuevo formato s�lo si Colegio es Guadalajara
select @aux = count(*) from csi_series where dataobject = 'd_premaat_factura_cuotas_gu' AND serie = 'MT' AND empresa = '04' AND anyo = '2012' 
IF (@colegio = 'COAATGU' AND @aux > 0) OR (@colegio <> 'COAATGU' AND @aux = 0)  
	BEGIN
		insert testupdater (descripcion,ok,version) values('El nuevo dataobject se aplica s�lo cuando Colegio es Guadalajara','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No debe aplicarse nuevo dataobject cuando Colegio No es Guadalajara','N',@version)
END

-- Versi�n
IF EXISTS (SELECT * FROM var_globales WHERE texto='20120214' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versi�n','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versi�n','N',@version)
	END
;
