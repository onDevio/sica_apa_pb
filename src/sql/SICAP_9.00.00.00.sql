Update colegiados set ultima_factura_rectif = 0, ultima_factura=0
go
--
Insert into csi_series (serie, empresa, contador, descripcion, recib, anyo, dataobject, tipo, serie_abono, proforma, serie_por_defecto) select serie,   empresa,   0,   descripcion,   recib,   '2016', dataobject, tipo, serie_abono, proforma, serie_por_defecto from csi_series  where anyo = '2015'
go
--
insert into csi_param_facturas (serie, empresa, anyo, idioma, campo, texto) select serie, empresa, '2016', idioma, campo, texto from csi_param_facturas where anyo = '2015'
go
--
update contadores set valor = 0 where contador like 'NUM_EXP%'
go
update contadores set valor = 0 where contador like 'NUM_REG%'
go
update contadores set valor = 0 where contador like 'NUM_SAL%'
go
--
update contadores set valor = 0 where contador like 'NUM_RENUNCIA%'
go
--
update var_globales set texto = '2016' where nombre = 'g_anyo_numeracion'
go
--
update musaat_cober_src set prima = 187500 where prima = 150000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 150000 where prima = 120000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 312500 where prima = 250000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 250000 where prima = 200000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 375000 where prima = 300000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 562500 where prima = 450000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 750000 where prima = 600000 and activo = 'S' and t_poliza = '01'
go
--
update musaat_cober_src set prima = 1125000 where prima = 900000 and activo = 'S' and t_poliza = '01'
go
--
