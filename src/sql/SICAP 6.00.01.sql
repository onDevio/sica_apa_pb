declare @descripcion varchar(100)
declare @version varchar(10)
declare @aux int
declare @aux2 int
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

--SCP-1922 PROBLEMAS CON EL LOGO DE MALLORCA.
if @colegio = 'COAATMCA'
   begin
       update listados set dw = 'd_garantias_listado_banco_mca' where dw = 'd_garantias_listado_banco_le'
       update var_globales set texto = 'd_garantias_listado_banco_mca' where nombre ='g_listado_liquid_otros_pagos'
   end

-- Verificación
select @descripcion = "MALLORCA LOGO LISTADOS TRANSFERENCIAS" 
select @version = "6.00.01" 
select @aux = count(*) from listados where dw = 'd_garantias_listado_banco_le' AND 
	((select texto FROM var_globales where nombre = 'COLEGIO') IN ('COAATMCA'))
select @aux2 = count(*) from var_globales where texto = 'd_garantias_listado_banco_mca' AND nombre ='g_listado_liquid_otros_pagos' AND
	((select texto FROM var_globales where nombre = 'COLEGIO') IN ('COAATMCA'))

if (@aux = 0 AND @aux2 = 1 AND @colegio = 'COAATMCA') OR @colegio <> 'COAATMCA'
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'S',@version)
	end
else
	begin
		insert testupdater (descripcion,ok,version) values(@descripcion,'N',@version)
	end

-- versión
update var_globales set texto='20111230', descripcion = 'versión v6.00.01' where nombre='g_version_minima'
;