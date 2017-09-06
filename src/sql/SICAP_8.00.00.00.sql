--Script de Cambio de año
-- Script genericos

-- SCP-2555-01
-- Se inserta las configuraciones de facturas para el 2015
insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) select serie, empresa, '2015', idioma, campo, texto from csi_param_facturas where anyo = '2014'
GO

-- SCP-2555-02
-- Se insertan las series de facturas para el 2015, de todas las empresas
Insert into csi_series (serie, empresa, contador, descripcion, recib, anyo, dataobject, tipo, serie_abono, proforma, serie_por_defecto)
select serie,   empresa,   0,   descripcion,   recib,   '2015', dataobject, tipo, serie_abono, proforma, serie_por_defecto from csi_series  where anyo = '2014'
GO

-- SCP-2555-03
-- Se actualiza los contadores de facturas de colegiados
update colegiados set ultima_factura = 0 
GO
update colegiados set ultima_factura_rectif = 0 
GO

-- SCP-2555-04
--Se actualiza el año en variables globales
update var_globales set texto = '2015' where nombre = 'g_anyo_numeracion'
GO
-- Versión Inicio de año 2015


--Scripts especificos

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'


-- SCP-2555-05
-- A bizkaia no se actualiza los contadores de exp, reg, visado y registros entrada salida
if @colegio <> 'COAATB'
begin
update contadores set valor = 0 where contador like 'NUM_EXP%'
update contadores set valor = 0 where contador like 'NUM_REG%'
update contadores set valor = 0 where contador like 'NUM_SAL%'


-- Se actualiza Número de renuncias
update contadores set valor = 0 where contador like 'NUM_RENUNCIA%'
end


-- SCP-2555-06
-- Se actualiza el contador de número de avisos de facturas
-- Ávila, León, Burgos, Navarra, La Rioja
if @colegio = 'COAATAVI' or  @colegio = 'COAATLE' or @colegio = 'COAATLR' or @colegio = 'COAATNA' or  @colegio = 'COAATBU'
begin
Update contadores set valor = 0 where contador = 'N_AVISO'   
end 


-- SCP-2555-07
--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATNA' 
begin
update contadores set valor = 2015000001 where contador like 'LIBROS_ORDENES'
update contadores set valor = 2015000001 where contador like 'LIBROS_INCIDENCIAS'
end


-- SCP-2555-08
--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATTE' 
begin
update contadores set valor = 0 where contador like 'N_REMESA%'
end
GO
 

