--Script de Cambio de año
-- Script genericos

-- Se inserta las configuraciones de facturas para el 2014
insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) select serie, empresa, '2014', idioma, campo, texto from csi_param_facturas where anyo = '2013';

-- Se insertan las series de facturas para el 2014, de todas las empresas
Insert into csi_series (serie, empresa, contador, descripcion, recib, anyo, dataobject, tipo, serie_abono, proforma, serie_por_defecto)
select serie,   empresa,   0,   descripcion,   recib,   '2014', dataobject, tipo, serie_abono, proforma, serie_por_defecto from csi_series  where anyo = '2013';

-- Se actualiza los contadores de facturas de colegiados
update colegiados set ultima_factura = 0 
update colegiados set ultima_factura_rectif = 0 

--Se actualiza el año en variables globales
update var_globales set texto = '2014' where nombre = 'g_anyo_numeracion';
-- Versión Inicio de año 2014


-- Cambios en MUSAAT 2014

update musaat_coef_c set coef = 2 where tipoact in ('11', '15') and tipoobra in ('41', '42') and tabla = 'A';

update musaat_coef_c set coef = 1.4 where tipoact = '12' and tipoobra in ('41', '42') and tabla = 'A';

update musaat_coef_c set coef = 0.6 where tipoact in ('13', '14', '16', '17') and tipoobra in ('41', '42') and tabla = 'A';

Update musaat_coef_c set coef = 0 where tabla = 'D' and tipoobra = '83';


Update musaat_tarifas set minimo = 0 where tarifa in ('D', 'F');


Update var_globales set numero = 1 where nombre = 'g_musaat_recargo_prima';

//SCP-2390
Update musaat set src_coef_cm = 1.5 where src_coef_cm > 1.5;

Update musaat set src_poliza_plus = 'N';



--Scripts especificos

declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'

-- A bizkaia no se actualiza los contadores de exp, reg, visado y registros entrada salida
if @colegio <> 'COAATB'
begin
update contadores set valor = 0 where contador like 'NUM_EXP%'
update contadores set valor = 0 where contador like 'NUM_REG%'
update contadores set valor = 0 where contador like 'NUM_SAL%'

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
update contadores set valor = 2013000001 where contador like 'LIBROS_ORDENES'
update contadores set valor = 2013000001 where contador like 'LIBROS_INCIDENCIAS'
end

--Se actualiza los contadores de libro de ordenes y de incidencias para Navarra
if @colegio = 'COAATTE' 
begin
update contadores set valor = 0 where contador like 'N_REMESA%'
end
 
;
