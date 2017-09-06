--Script de Cambio de año
-- Script genericos

-- Se inserta las configuraciones de facturas para el 2012
insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) select serie, empresa, '2012', idioma, campo, texto from csi_param_facturas where anyo = '2011'

-- Se insertan las series de facturas para el 2012, de todas las empresas
insert into csi_series (serie, empresa, contador, descripcion, recib, anyo, dataobject, tipo, serie_abono, proforma, serie_por_defecto)
select serie,   empresa,   0,   descripcion,   recib,   '2012', dataobject, tipo, serie_abono, proforma, serie_por_defecto
from csi_series  where anyo = '2011'   

-- Se actualiza los contadores de facturas de colegiados
update colegiados set ultima_factura = 0 
update colegiados set ultima_factura_rectif = 0 

--Se actualiza el año en variables globales
update var_globales set texto = '2012' where nombre = 'g_anyo_numeracion';
-- Versión Inicio de año 2012

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- A bizkaia no se actualiza los contadores de exp, reg, visado y registros entrada salida
if @colegio <> 'COAATB'
begin
update contadores set valor = 0 where contador like 'NUM_EXP%'
update contadores set valor = 0 where contador like 'NUM_REG%'
update contadores set valor = 0 where contador like 'NUM_SAL%'

--Se actualiza los contadores de registro de entrada y salida
update contadores set valor = 0 where contador like 'REGISTRO_ENTRADA%' 
update contadores set valor = 0 where contador like 'REGISTRO_SALIDA%'

-- Se actualiza Número de renuncias
update contadores set valor = 0 where contador like 'NUM_RENUNCIA%'
end

-- Se actualiza el contador de número de avisos de facturas
-- Ávila, León, Burgos, Navarra, La Rioja
if @colegio = 'COAATAVI' or  @colegio = 'COAATLE' or @colegio = 'COAATLR' or @colegio = 'COAATNA' or  @colegio = 'COAATBU'
begin
Update contadores set valor = 0 where contador = 'N_AVISO'   
end 


--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATNA' 
begin
update contadores set valor = 2012000001 where contador like 'LIBROS_ORDENES'
update contadores set valor = 2012000001 where contador like 'LIBROS_INCIDENCIAS'
end

--Se comenta el contador de n_remesa puesto que no está soportado el reinicio a lo largo de los años
--if @colegio = 'COAATTER' 
--begin
--update contadores set valor = 0 where contador like 'N_REMESA%'
--end 
;
