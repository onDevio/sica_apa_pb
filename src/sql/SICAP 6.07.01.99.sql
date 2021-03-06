--Verificación UPDATER
declare @version varchar(10) 
select @version = "6.07.01" 


-- SCP-2243
-- Se añden campos a la tabla premaat
if (SELECT  count(*) FROM sysobjects, syscolumns where sysobjects.id = syscolumns.id and sysobjects.type = 'U' AND sysobjects.name = 'premaat' AND syscolumns.name in ('alta_reta', 'fecha_alta_reta', 'fecha_baja_reta') ) = 3

	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2243. Se creó nuevos campos en la tabla premaat de la BBDD','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('SCP-2243. No se crearon los nuevos campos en la tabla premaat de la BBDD. REVISAR','N',@version)
	END



IF EXISTS (SELECT * FROM var_globales WHERE texto='20130627' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END
;