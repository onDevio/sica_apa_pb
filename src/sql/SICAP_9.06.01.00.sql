alter table colegios add cod_colegios_cat char(2) null;
--
update colegios set cod_colegios_cat = 'B' where cod_colegio = '08';
update colegios set cod_colegios_cat = 'G' where cod_colegio = '17';
update colegios set cod_colegios_cat = 'L' where cod_colegio = '29';	
update colegios set cod_colegios_cat = 'T' where cod_colegio = '44';
update colegios set cod_colegios_cat = 'TE' where cod_colegio = '55';
--
CREATE VIEW datos_contratos_otros_destinos (COLEG_VR, COLEG_CZ, DATA1, VOR, VOR_NUM, VOR_ANT, VOR_DATA, COLE_NUM, COLE_NOM, COLE_ASS, COLE_GAR, COLE_SIN, COLE_PAR, COLE_NIF, OBR_ADR, OBR_NUM, OBR_CP, OBR_POB, OBR_PEM, OBR_TI, OBR_TO, OBR_TD, OBR_OFI, OBR_VOL, OBR_COL, OBR_NE, OBR_NH, OBR_ST, OBR_SH, OBR_SG, OBR_SA, OBR_PSR, OBR_SSR, OBR_PBR, OBR_SBR, OBR_ALT, OBR_MTG, OBR_USO, OBR_EG, OBR_CQ, OBR_NCQ, CFO_TP, CFO_DATA, CFO_PER, REN_DATA, REN_PER, PROM_TIP, PROM_NIF, PROM_NOM, PROM_ADR, PROM_NUM, PROM_CP, PROM_POB, LLIURE, f_entrada, f_visado, id_colegiado, id_tramite, id_fase, n_registro, n_visado)
AS select '  ', f.cod_colegio_dest, Right( '00' +Convert(varchar(2), datepart(Month, GetDate())), 2) + Right( '0000' +Convert(varchar(4), datepart(Year, GetDate())), 4), 'R', f.n_registro, '', 
Right( '00' +Convert(varchar(2), datepart(Day, f.f_entrada)), 2) + Right( '00' +Convert(varchar(2), datepart(Month, f.f_entrada)), 2) + Right( '0000' + Convert(varchar(4), datepart(Year, f.f_entrada)), 4),
c.n_colegiado, LTRIM(c.apellidos) + ' ' + LTRIM(c.nombre), LTRIM(mca.nom_s), mcs.prima, m.src_coef_cm, fc.porcen_a, c.nif, f.tipo_via_emplazamiento + ' ' + f.emplazamiento, f.n_calle, p.cod_pos, p.descripcion,
fu.pem, f.fase, f.tipo_trabajo, f.trabajo, e.administracion, fu.volumen, fu.colindantes2m, fu.num_edif, fu.num_viv, fu.sup_viv + fu.sup_garage + fu.sup_otros, fu.sup_viv, fu.sup_garage, fu.sup_otros, fu.plantas_sob, fu.sup_sob,
fu.plantas_baj, fu.sup_baj, fu.altura, fu.colindantes, fu.tipo_viv, fu.estudio_geo, fu.cc_externo, fu.niv_cont, 
' ', '        ', 0.00, '        ', 0.00 , fu.t_promotor, cl.nif, LTRIM(cl.apellidos) + ' ' + cl.nombre, cl.tipo_via + ' ' + cl.nombre_via, '', (SELECT P.cod_pos FROM poblaciones P WHERE P.cod_pob = cl.cod_pob), 
(SELECT P.descripcion FROM poblaciones P WHERE P.cod_pob = cl.cod_pob), '', f.f_entrada, f.f_visado, c.id_colegiado, f.id_tramite, f.id_fase, f.n_registro, f.archivo
from fases f,  fases_colegiados fc,  colegiados c, musaat m, musaat_cias_aseguradoras mca,  musaat_cober_src mcs, poblaciones p, fases_usos fu, expedientes e, fases_clientes fcl, clientes cl 
where f.id_fase = fc.id_fase and c.id_colegiado = fc.id_col and m.id_col = c.id_colegiado and mca.cod_s = m.src_cia and mcs.codigo = m.src_cober and p.cod_pob = f.poblacion
and fu.id_fase = f.id_fase and e.id_expedi = f.id_expedi and fcl.id_fase = f.id_fase and cl.id_cliente = fcl.id_cliente 
and f.cod_colegio_dest <> (SELECT texto FROM var_globales WHERE nombre = 'g_cod_colegio')
;
--
declare @colegio varchar(10) 
select @colegio = texto from var_globales where nombre = 'COLEGIO'
--
if @colegio = 'COAATLL' or @colegio = 'COAATTGN' or @colegio = 'COAATTEB' 
BEGIN
		INSERT INTO menu (codigo, descripcion, objeto, visible, enabled, ventana, activo ) VALUES ( '0000000211', 'Fichero Contratos Otras Demarcaciones', 	'm_aplic_frame.m_file.m_new.m_fases.m_f_contratos_otras_demarcaciones',  '1', '1', '', 'S' )
	END
ELSE
	BEGIN
		INSERT INTO menu (codigo, descripcion, objeto, visible, enabled, ventana, activo ) VALUES ( '0000000211', 'Fichero Contratos Otras Demarcaciones', 	'm_aplic_frame.m_file.m_new.m_fases.m_f_contratos_otras_demarcaciones',  '0', '0', '', 'N' )
	END
--
go

  

