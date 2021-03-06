--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
--
select @version = "7.03.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
-- SCP-2426
-- Se añaden campo 'codigo_sepa' a la tabla devoluciones_motivos
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'devoluciones_motivos' AND syscolumns.name = 'codigo_sepa' ) = 1

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2426. Se creó el campo -codigo_sepa- en la tabla devoluciones_motivos de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2426. No se pudo crear el  campo -codigo_sepa- en la tabla devoluciones_motivos de la BBDD','N',@version)
	END
--
-- SCP-2429
-- Se añaden los campos 'iban' y 'bic a la tabla csi_empresas
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'csi_empresas' AND syscolumns.name in ('iban', 'bic') ) = 2

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2426. Se creó los campos bic e iban en la tabla csi_empresas de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2426. No se pudo crear los campos bic e iban en la tabla csi_empresas de la BBDD','N',@version)
	END
;