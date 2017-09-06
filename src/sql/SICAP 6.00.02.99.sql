declare @colegio varchar(10)
declare @aux int
declare @version varchar(10) 

select @colegio = texto from var_globales where nombre = 'COLEGIO'
select @version = "6.00.02" 

-- Comprobación en testupdater
-- Se verifica si existe la tabla csi_empresas_logos (aplica a todos los colegios)
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'csi_empresas_logos')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha creado correctamente la tabla csi_empresas_logos','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha creado la tabla csi_empresas_logos','N',@version)
	END

-- Verificamos existen registros en la tabla csi_empresas_logos con altura>0 sólo si Colegio es Murcia
select @aux = count(*) from csi_empresas_logos where altura > 0
IF (@colegio = 'COAATMU' AND @aux > 0) OR (@colegio <> 'COAATMU' AND @aux = 0)  
	BEGIN
		insert testupdater (descripcion,ok,version) values('Existen registros en la tabla csi_empresas_logos con altura > 0 sólo cuando Colegio es Murcia','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No deben haber registros en la tabla csi_empresas_logos con altura > 0 cuando Colegio No es Murcia','N',@version)
END
;
