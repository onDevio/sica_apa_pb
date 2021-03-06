declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- SCP-1910 León Alta Conceptos "cuotas de PREMAAT" Empresa Aseguradora, Desactivación Conceptos "cuotas de PREMAAT" Empresa Colegio
if @colegio = 'COAATLE'
	begin
		UPDATE csi_articulos_servicios SET activo = 'S' WHERE empresa = '02' AND familia = '02'
		UPDATE csi_articulos_servicios SET activo = 'N' WHERE empresa = '01' AND familia = '02'
	end
-- Como resultado de los test, se confirma que no existe el campo en la rioja	
if @colegio = 'COAATLR'
	begin 
	alter table fases_colegiados add proy char(1) default 'N' null
	end
;