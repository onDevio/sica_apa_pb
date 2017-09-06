-- ONDEVIO-40
--
IF EXISTS (SELECT * FROM musaat_cias_aseguradoras WHERE cod_s ='CC')
	BEGIN
		update musaat_cias_aseguradoras set nom_s = 'CATALANA OCCIDENTE SRC' where cod_s ='CC'
	END
ELSE
	BEGIN
		insert into musaat_cias_aseguradoras (cod_s, nom_s) values ('CC', 'CATALANA OCCIDENTE SRC')
	END
--
;

update var_globales set texto = 'CC' where nombre = 'g_companyia_src.zurich'
;
--
CREATE VIEW src_contratos_data_asociados (id_fase,id_tramite,coleg_vr,coleg_cz,vor_t,vor,vor_exp,n_registro,n_visado,vor_num,f_entrada,f_visado,vor_data,cole_num,cole_nom,cole_par,cole_nif,obr_tipo_via,obr_adr,obr_num,obr_cp,obr_pob,obr_cat,obr_pem,obr_ti,obr_to,obr_td,obr_ofi,obr_vol,obr_col,obr_ne,obr_nh,obr_st,obr_sh,obr_sg,obr_sa,obr_psr,obr_ssr,obr_pbr,obr_sbr,obr_alt,obr_mtg,obr_llg,obr_vda,obr_au,obr_uso,obr_eg,obr_cq,obr_ncq,cfo_tp,cfo_data,cfo_per,ren_data,ren_per,sin_data,prom_tip,prom_nif,prom_nom,prom_tipo_via,prom_adr,prom_num,prom_cp,prom_pob,observacions,zur_cer,zur_pol,zur_cob,zur_tram,src_cia,src_alta,tipo_persona,id_colegiado, f_abono) AS select F.id_fase, F.id_tramite, (SELECT cod_zurich FROM colegios WHERE cod_colegio = (SELECT texto FROM var_globales WHERE nombre = 'g_cod_colegio')),
	(SELECT cod_zurich FROM colegios WHERE cod_colegio = F.cod_colegio_dest), 'A', 	'',	E.n_expedi,	F.n_registro, F.archivo,'', F.f_entrada, F.f_visado,	F.f_entrada, COL.n_colegiado,
	LTRIM(COL.apellidos) + ' ' + COL.nombre, (FCOL.porcen_a * FCA.porcent)/100 ,	COL.nif, F.tipo_via_emplazamiento, F.emplazamiento, F.n_calle, PF.cod_pos, PF.descripcion, E.r_catastral, FU.pem,	F.fase, F.tipo_trabajo, F.trabajo, E.administracion, FU.volumen, FU.colindantes2m, FU.num_edif, FU.num_viv, '', FU.sup_viv, FU.sup_garage, FU.sup_otros, FU.plantas_sob, FU.sup_sob, FU.plantas_baj, FU.sup_baj, FU.altura, FU.colindantes,	'N', 'N', 'N', FU.uso, FU.estudio_geo,	FU.cc_externo as obr_cq,	FU.niv_cont as obr_ncq,	'' as cfo_tp, '' as cfo_data, '', '', 0,	'', FU.t_promotor, CLI.nif, LTRIM(CLI.apellidos) + ' ' + CLI.nombre, CLI.tipo_via, CLI.nombre_via, '', P.cod_pos, P.descripcion, '', SRC.numero_certificado, SRC.numero_poliza, SRC.src_cober, SRC.tramo, SRC.src_cia, SRC.alta, COL.tipo_persona, COL.id_colegiado, F.f_abono 

FROM fases F, fases_colegiados FCOL, fases_clientes FCLI, clientes CLI, colegiados COL, expedientes E, fases_usos FU, src_colegiado SRC, poblaciones PF, fases_colegiados_asociados FCA, poblaciones P
where F.id_fase = FCOL.id_fase AND 	E.id_expedi = F.id_expedi AND	FU.id_fase = F.id_fase AND	PF.cod_pob = F.poblacion AND 	FCLI.id_fase = F.id_fase AND
	CLI.id_cliente = FCLI.id_cliente AND COL.id_colegiado = FCA.id_col_per AND FCA.id_col_per = SRC.id_colegiado and F.id_fase = FCA.id_fase and FCOL.id_col = FCA.id_col_aso and P.cod_pob = CLI.cod_pob 
; 
--
CREATE VIEW src_contratos_data (id_fase,id_tramite,coleg_vr,coleg_cz,vor_t,vor,vor_exp,n_registro,n_visado,vor_num,f_entrada,f_visado,vor_data,cole_num,cole_nom,cole_par,cole_nif,obr_tipo_via,obr_adr,obr_num,obr_cp,obr_pob,obr_cat,obr_pem,obr_ti,obr_to,obr_td,obr_ofi,obr_vol,obr_col,obr_ne,obr_nh,obr_st,obr_sh,obr_sg,obr_sa,obr_psr,obr_ssr,obr_pbr,obr_sbr,obr_alt,obr_mtg,obr_llg,obr_vda,obr_au,obr_uso,obr_eg,obr_cq,obr_ncq,cfo_tp,cfo_data,cfo_per,ren_data,ren_per,sin_data,prom_tip,prom_nif,prom_nom,prom_tipo_via,prom_adr,prom_num,prom_cp,prom_pob,observacions,zur_cer,zur_pol,zur_cob,zur_tram,src_cia,src_alta,tipo_persona,id_colegiado, f_abono) 
AS select F.id_fase, F.id_tramite, (SELECT cod_zurich FROM colegios WHERE cod_colegio = (SELECT texto FROM var_globales WHERE nombre = 'g_cod_colegio')),
	(SELECT cod_zurich FROM colegios WHERE cod_colegio = F.cod_colegio_dest), 'A', 	'',	E.n_expedi,	F.n_registro, F.archivo,'', F.f_entrada, F.f_visado,	F.f_entrada, COL.n_colegiado,
	LTRIM(COL.apellidos) + ' ' + COL.nombre, FCOL.porcen_a,	COL.nif, F.tipo_via_emplazamiento, F.emplazamiento, F.n_calle, PF.cod_pos, PF.descripcion, E.r_catastral, FU.pem,	F.fase, F.tipo_trabajo, F.trabajo, E.administracion, FU.volumen, FU.colindantes2m, FU.num_edif, FU.num_viv, '', FU.sup_viv, FU.sup_garage, FU.sup_otros, FU.plantas_sob, FU.sup_sob, FU.plantas_baj, FU.sup_baj, FU.altura, FU.colindantes,	'N', 'N', 'N', FU.uso, FU.estudio_geo,	FU.cc_externo as obr_cq,	FU.niv_cont as obr_ncq,	'' as cfo_tp, '' as cfo_data, '', '', 0,	'', FU.t_promotor, CLI.nif, LTRIM(CLI.apellidos) + ' ' + CLI.nombre, CLI.tipo_via, CLI.nombre_via, '', (SELECT P.cod_pos FROM poblaciones P WHERE P.cod_pob = CLI.cod_pob), (SELECT P.descripcion FROM poblaciones P WHERE P.cod_pob = CLI.cod_pob), '', SRC.numero_certificado, SRC.numero_poliza, SRC.src_cober, SRC.tramo, SRC.src_cia, SRC.alta, COL.tipo_persona, COL.id_colegiado, F.f_abono 
FROM fases F, fases_colegiados FCOL, fases_clientes FCLI, clientes CLI, colegiados COL, expedientes E, fases_usos FU, src_colegiado SRC, poblaciones PF 
where F.id_fase = FCOL.id_fase AND 	E.id_expedi = F.id_expedi AND	FU.id_fase = F.id_fase AND	PF.cod_pob = F.poblacion AND 	FCLI.id_fase = F.id_fase AND
	CLI.id_cliente = FCLI.id_cliente AND COL.id_colegiado = FCOL.id_col AND FCOL.id_col = SRC.id_colegiado ;	

