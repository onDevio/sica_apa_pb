--SCP-2308
declare @colegio varchar(10)
select @colegio = texto from var_globales where nombre = 'COLEGIO'
begin
if @colegio = 'COAATAVI'
begin
update csi_series set recib = 'S', serie_por_defecto = 'N' where serie = 'PC' AND anyo = '2013' AND empresa = '02'
update csi_series set recib = 'N', serie_por_defecto = 'S', serie_abono = 'ABONO' where serie = 'F' AND anyo = '2013' AND empresa = '02'
update csi_series set  serie_abono = 'RECTIF' where recib = 'S' AND anyo = '2013' AND empresa = '02' AND serie <> 'RECTIF'
INSERT INTO csi_series (serie,empresa,contador, descripcion,recib,anyo,serie_abono,proforma, serie_por_defecto) VALUES ('ABONO','02',0,'ABONO PARA FACTURAS','N','2013','','N','N')
end
if @colegio = 'COAATMU'
begin
update var_globales set sn = 'N' where nombre = 'g_facturar_musaat_pc_serie_aparte'
end
end ;