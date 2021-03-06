--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
declare @descripcion varchar(100)
declare @aux char(1)
select @version = "6.05.02" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'



IF EXISTS (SELECT * FROM var_globales WHERE texto='20130123' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado correctamente a la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado correctamente a la versión','N',@version)
	END


select @descripcion = "Comprobación actualizaciones SCP-2204"
select @aux = sn from var_globales WHERE nombre = 'g_sellador_backup_externo'
if ((@aux = 'S' AND @colegio = 'COAATTGN') OR (@aux = 'N' AND @colegio <> 'COAATTGN'))
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

;