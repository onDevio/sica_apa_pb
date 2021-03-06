--Verificación UPDATER
declare @colegio varchar(10)
declare @aux int
declare @version varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
select @version = "6.03.00" 
-- Verificamos se aplica el nuevo formato sólo si Colegio es Navarra
select @aux = count(*) from var_globales where nombre = 'g_hoja_reclamo_recibos_impagados' AND texto = 'd_cobros_carta_reclamo_logos_cuenta_bancaria'
IF (@colegio = 'COAATNA' AND @aux > 0) OR (@colegio <> 'COAATNA' AND @aux = 0)  
	BEGIN
		insert testupdater (descripcion,ok,version) values('El nuevo dataobject se aplica sólo cuando Colegio es Navarra','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No debe aplicarse nuevo dataobject cuando Colegio No es Navarra','N',@version)
END
-- Verificamos se quitan las entradas de csi_empresas_logos
select @aux = count(*) from csi_empresas_logos 
IF (@colegio = 'COAATNA' AND @aux = 0) OR (@colegio <> 'COAATNA' )  
	BEGIN
		insert testupdater (descripcion,ok,version) values('No es Navarra, ó es Navarra y no hay entradas en csi_empresas_logos','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No es Navarra, ó es Navarra y no hay entradas en csi_empresas_logos','N',@version)
END
-- Verificamos los logos se han actualizado ok para Navarra
select @aux = count(*) from csi_empresas WHERE (codigo = '01' AND logo = 'colegio_ENCABEZADO.jpg') OR (codigo = '02' AND logo = 'narial_ENCABEZADO.jpg')
IF (@colegio = 'COAATNA' AND @aux = 2) OR (@colegio <> 'COAATNA' AND @aux <2) 
	BEGIN
		insert testupdater (descripcion,ok,version) values('No es Navarra, ó es Navarra y se han actualizado ok los nombres de los logos','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No es Navarra, ó es Navarra y se han actualizado ok los nombres de los logos','N',@version)
END
;