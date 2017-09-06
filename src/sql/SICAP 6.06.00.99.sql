--Verificación UPDATER
declare @version varchar(10) 
declare @colegio varchar(10) 
declare @descripcion varchar(100)

select @version = "6.06.00" 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- Se verifica si existe la tabla csi_lineas_fact_emi_premaat (aplica a todos los colegios)
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'csi_lineas_fact_emi_premaat')
	BEGIN
		insert testupdater (descripcion,ok,version) values('Se ha creado correctamente la tabla csi_lineas_fact_emi_premaat','S',@version)
	END
ELSE
	BEGIN
		insert testupdater (descripcion,ok,version) values('No se ha creado la tabla csi_lineas_fact_emi_premaat','N',@version)
	END

if (@colegio = 'COAATGU') 
	begin
//		select @descripcion = dataobject from csi_series WHERE serie = 'MT' and empresa = '04' and anyo = 'XX'
	
		if @descripcion = 'd_premaat_factura_cuotas_generico'
			begin 
				insert testupdater (descripcion,ok,version) values('Se actualizó correctamente el datawindow de la serie MT y año XX','S',@version)
			end 
		else 
			begin
				insert testupdater (descripcion,ok,version) values('No se actualizó correctamente el datawindow de la serie MT y año XX','N',@version)
			end 

		select @descripcion = dataobject from csi_series WHERE serie = 'MT' and empresa = '04' and anyo = '2013'
	
		if @descripcion = 'd_premaat_factura_cuotas_generico'
			begin 
				insert testupdater (descripcion,ok,version) values('Se actualizó correctamente el datawindow de la serie MT y año 2013','S',@version)
			end 
		else 
			begin
				insert testupdater (descripcion,ok,version) values('No se actualizó correctamente el datawindow de la serie MT y año 2013','N',@version)
			end 


		select @descripcion = dataobject from csi_series WHERE serie = 'MT' and empresa = '04' and anyo = '2012'
	
		if @descripcion = 'd_premaat_factura_cuotas_generico'
			begin 
				insert testupdater (descripcion,ok,version) values('Se actualizó correctamente el datawindow de la serie MT y año 2012','S',@version)
			end 
		else 
			begin
				insert testupdater (descripcion,ok,version) values('No se actualizó correctamente el datawindow de la serie MT y año 2012','N',@version)
			end 

	end 
;
