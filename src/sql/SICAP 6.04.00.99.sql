--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
declare @descripcion varchar(100)
declare @aux int
select @version = "6.04.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'


IF EXISTS (SELECT * FROM var_globales WHERE texto='20121122' AND nombre='g_version_minima')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha actualizado la fecha de la versión','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha actualizado la fecha de la versión','N',@version)
	END

select @descripcion = "tipos_modulos_logos num_reg > 8" 
select @aux = count(*) from tipos_modulos_logos 
if @aux > 8
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "csi_empresas_logos Insert > 0" 
select @aux = count(*) from csi_empresas_logos 
if @aux > 0
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "Visible Logo Res.Eco. Genérico Bizkaia, Cáceres, Murcia, Tarragona ó Teruel. Resto colegios, No Visible" 
select @aux = count(*) from csi_empresas_logos WHERE modulo = '001' AND visible = 'S'
if (@aux > 0 AND (@colegio = 'COAATB' OR @colegio = 'COAATCC' OR @colegio = 'COAATMU' OR @colegio = 'COAATTGN' OR @colegio = 'COAATTGN')) OR NOT(@aux > 0 AND (@colegio = 'COAATB' OR @colegio = 'COAATCC' OR @colegio = 'COAATMU' OR @colegio = 'COAATTGN' OR @colegio = 'COAATTER'))
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "Ávila. Logos Formato Facturación, Domic. y General, >4"
select @aux = count(*) from csi_empresas_logos WHERE modulo IN ('000','002','003') AND visible = 'S'
if (@aux > 4 AND @colegio = 'COAATAVI') OR @colegio <> 'COAATAVI'
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "Murcia. Logos Formato Domic. y General, >2"
select @aux = count(*) from csi_empresas_logos WHERE modulo IN ('000','003') AND visible = 'S'
if (@aux > 2 AND @colegio = 'COAATMU') OR @colegio <> 'COAATMU'
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "Navarra. Logos Otros Pagos - Informe Liq. Visible, >0"
select @aux = count(*) from csi_empresas_logos WHERE modulo IN ('008') AND visible = 'S'
if (@aux > 0 AND @colegio = 'COAATNA') OR NOT(@aux > 0 AND @colegio = 'COAATNA')
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

select @descripcion = "Rioja. Cambio del nombre del logo"
select @aux = count(*) from csi_empresas WHERE codigo = '02' AND logo = 'narial.jpg'
if (@aux > 0 AND @colegio = 'COAATLR') OR @colegio <> 'COAATLR'
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

;

