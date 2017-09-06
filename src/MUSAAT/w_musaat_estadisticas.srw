HA$PBExportHeader$w_musaat_estadisticas.srw
$PBExportComments$Estad$$HEX1$$ed00$$ENDHEX$$sticas de Contratos para Murcia
forward
global type w_musaat_estadisticas from w_listados
end type
end forward

global type w_musaat_estadisticas from w_listados
string title = "Estad$$HEX1$$ed00$$ENDHEX$$sticas"
end type
global w_musaat_estadisticas w_musaat_estadisticas

on w_musaat_estadisticas.create
call super::create
end on

on w_musaat_estadisticas.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_musaat_estadisticas
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_musaat_estadisticas
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_musaat_estadisticas
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_musaat_estadisticas
integer x = 37
integer y = 240
boolean vscrollbar = true
end type

type cb_ver from w_listados`cb_ver within w_musaat_estadisticas
end type

event cb_ver::clicked;call super::clicked;string listado,sql

dw_listados.accepttext()

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

//sql=''
//
dw_1.of_SetTransObject(SQLCA)
//sql = dw_1.describe("datawindow.table.select")
//
////Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
////f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,g_tipo_base_datos,'')
//f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql,g_tipo_base_datos,'Fecha entrada Desde :')
//f_sql('fases.f_entrada','<=','fecha_entrada_h',dw_listados,sql,g_tipo_base_datos,'Fecha entrada Hasta :')
//f_sql('fases.f_visado','>=','fecha_visado_d',dw_listados,sql,g_tipo_base_datos,'Fecha visado Desde :')
//f_sql('fases.f_visado','<=','fecha_visado_h',dw_listados,sql,g_tipo_base_datos,'Fecha visado Hasta :')
//f_sql('fases.poblacion','=','poblacion',dw_listados,sql,g_tipo_base_datos,'Poblaci$$HEX1$$f300$$ENDHEX$$n :')
//f_sql('fases.modalidad','=','centro',dw_listados,sql,g_tipo_base_datos,'Centro :')
//f_sql('fases.fase','like','tipo_act',dw_listados,sql,g_tipo_base_datos,'Tipo Actuaci$$HEX1$$f300$$ENDHEX$$n :')
//f_sql('fases.tipo_trabajo','like','tipo_obra',dw_listados,sql,g_tipo_base_datos,'Tipo Obra :')
//f_sql('fases.f_abono','>=','fecha_abono_d',dw_listados,sql,g_tipo_base_datos,'Fecha abono Desde :')
//f_sql('fases.f_abono','<=','fecha_abono_h',dw_listados,sql,g_tipo_base_datos,'Fecha abono Hasta :')
//
////messagebox('',sql)
//
//dw_1.SetTransobject(sqlca)
//dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")


string tipo_recl, tipo_est_obra, tipo_danyos, cober, grupo
datetime f_ini_0, f_fin_0, f_ini_1, f_fin_1, f_ini_2, f_fin_2, f_ini_3, f_fin_3, f_ini_4, f_fin_4
datetime f_ini_5, f_fin_5
int i

f_ini_0 = datetime(date('01/01/' + string(year(today()))))
f_fin_0 = datetime(date('01/01/' + string(year(today())+1)))
f_ini_1 = datetime(date('01/01/' + string(year(today())-1)))
f_fin_1 = datetime(date('01/01/' + string(year(today()))))
f_ini_2 = datetime(date('01/01/' + string(year(today())-2)))
f_fin_2 = datetime(date('01/01/' + string(year(today())-1)))
f_ini_3 = datetime(date('01/01/' + string(year(today())-3)))
f_fin_3 = datetime(date('01/01/' + string(year(today())-2)))
f_ini_4 = datetime(date('01/01/' + string(year(today())-4)))
f_fin_4 = datetime(date('01/01/' + string(year(today())-3)))
f_ini_5 = datetime(date('01/01/' + string(year(today())-5)))
f_fin_5 = datetime(date('01/01/' + string(year(today())-4)))

CHOOSE CASE listado
	CASE 'd_musaat_estadisticas_sini_tipo_recl'
		dw_1.retrieve()
		for i=1 to dw_1.rowcount()
			tipo_recl = dw_1.getitemstring(i, 'codigo')
			dw_1.setitem(i, 'anyo_0', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_0, f_fin_0))
			dw_1.setitem(i, 'anyo_1', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_1, f_fin_1))
			dw_1.setitem(i, 'anyo_2', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_2, f_fin_2))
			dw_1.setitem(i, 'anyo_3', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_3, f_fin_3))
			dw_1.setitem(i, 'anyo_4', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_4, f_fin_4))
			dw_1.setitem(i, 'anyo_5', f_musaat_siniestros_tipo_reclamacion(tipo_recl, f_ini_5, f_fin_5))
		next

	CASE 'd_musaat_estadisticas_sini_tipo_danyos'
		dw_1.retrieve()
		for i=1 to dw_1.rowcount()
			tipo_danyos = dw_1.getitemstring(i, 'codigo')
			dw_1.setitem(i, 'anyo_0', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_0, f_fin_0))
			dw_1.setitem(i, 'anyo_1', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_1, f_fin_1))
			dw_1.setitem(i, 'anyo_2', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_2, f_fin_2))
			dw_1.setitem(i, 'anyo_3', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_3, f_fin_3))
			dw_1.setitem(i, 'anyo_4', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_4, f_fin_4))
			dw_1.setitem(i, 'anyo_5', f_musaat_siniestros_tipo_danyos(tipo_danyos, f_ini_5, f_fin_5))
		next

	CASE 'd_musaat_estadisticas_sini_tipo_est_obra'
		dw_1.retrieve()
		for i=1 to dw_1.rowcount()
			tipo_est_obra = dw_1.getitemstring(i, 'codigo')
			dw_1.setitem(i, 'anyo_0', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_0, f_fin_0))
			dw_1.setitem(i, 'anyo_1', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_1, f_fin_1))
			dw_1.setitem(i, 'anyo_2', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_2, f_fin_2))
			dw_1.setitem(i, 'anyo_3', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_3, f_fin_3))
			dw_1.setitem(i, 'anyo_4', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_4, f_fin_4))
			dw_1.setitem(i, 'anyo_5', f_musaat_siniestros_tipo_estado_obra(tipo_est_obra, f_ini_5, f_fin_5))
		next

	CASE 'd_musaat_estadisticas_sini_exp_coleg'
		i = dw_1.insertrow(0)
		dw_1.setitem(i, 'concepto', 'N$$HEX2$$ba002000$$ENDHEX$$Expedientes')
		
		dw_1.setitem(i, 'anyo_0', f_musaat_siniestros_num_expedientes(f_ini_0, f_fin_0))
		dw_1.setitem(i, 'anyo_1', f_musaat_siniestros_num_expedientes(f_ini_1, f_fin_1))
		dw_1.setitem(i, 'anyo_2', f_musaat_siniestros_num_expedientes(f_ini_2, f_fin_2))
		dw_1.setitem(i, 'anyo_3', f_musaat_siniestros_num_expedientes(f_ini_3, f_fin_3))
		dw_1.setitem(i, 'anyo_4', f_musaat_siniestros_num_expedientes(f_ini_4, f_fin_4))
		dw_1.setitem(i, 'anyo_5', f_musaat_siniestros_num_expedientes(f_ini_5, f_fin_5))
		
		i = dw_1.insertrow(0)
		dw_1.setitem(i, 'concepto', 'T$$HEX1$$e900$$ENDHEX$$c. Demandados')
		
		dw_1.setitem(i, 'anyo_0', f_musaat_siniestros_num_colegiados(f_ini_0, f_fin_0))
		dw_1.setitem(i, 'anyo_1', f_musaat_siniestros_num_colegiados(f_ini_1, f_fin_1))
		dw_1.setitem(i, 'anyo_2', f_musaat_siniestros_num_colegiados(f_ini_2, f_fin_2))
		dw_1.setitem(i, 'anyo_3', f_musaat_siniestros_num_colegiados(f_ini_3, f_fin_3))
		dw_1.setitem(i, 'anyo_4', f_musaat_siniestros_num_colegiados(f_ini_4, f_fin_4))
		dw_1.setitem(i, 'anyo_5', f_musaat_siniestros_num_colegiados(f_ini_5, f_fin_5))		
		
	CASE 'd_musaat_estadisticas_garantias_src'
		dw_1.retrieve()
		for i=1 to dw_1.rowcount()
			cober = dw_1.getitemstring(i, 'codigo')
			dw_1.setitem(i, 'activos', f_musaat_num_colegiados_cobertura(cober, 'S', 'R%'))
			dw_1.setitem(i, 'act_nores', f_musaat_num_colegiados_cobertura(cober, 'S', 'N%'))
			dw_1.setitem(i, 'pasivos', f_musaat_num_colegiados_cobertura(cober, 'N', 'R%'))
			dw_1.setitem(i, 'pas_nores', f_musaat_num_colegiados_cobertura(cober, 'N', 'N%'))
		next
		
	CASE 'd_premaat_estadisticas_grupos'
		dw_1.retrieve()
		for i=1 to dw_1.rowcount()
			grupo = dw_1.getitemstring(i, 'codigo')
			dw_1.setitem(i, 'activos_alta', f_premaat_num_colegiados_grupo('S', '01', grupo))
			dw_1.setitem(i, 'activos_baja', f_premaat_num_colegiados_grupo('N', '01', grupo))
			dw_1.setitem(i, 'pasivos_alta', f_premaat_num_colegiados_grupo('S', '02', grupo))
			dw_1.setitem(i, 'pasivos_baja', f_premaat_num_colegiados_grupo('N', '02', grupo))
		next
		i = dw_1.insertrow(0)
		dw_1.setitem(i, 'descripcion', 'Complementario 1$$HEX1$$ba00$$ENDHEX$$')
		dw_1.setitem(i, 'activos_alta', f_premaat_num_colegiados_grupo('S', '01', 'C1'))
		dw_1.setitem(i, 'activos_baja', f_premaat_num_colegiados_grupo('N', '01', 'C1'))
		dw_1.setitem(i, 'pasivos_alta', f_premaat_num_colegiados_grupo('S', '02', 'C1'))
		dw_1.setitem(i, 'pasivos_baja', f_premaat_num_colegiados_grupo('N', '02', 'C1'))
		i = dw_1.insertrow(0)		
		dw_1.setitem(i, 'descripcion', 'Complementario 2$$HEX1$$ba00$$ENDHEX$$')
		dw_1.setitem(i, 'activos_alta', f_premaat_num_colegiados_grupo('S', '01', 'C2'))
		dw_1.setitem(i, 'activos_baja', f_premaat_num_colegiados_grupo('N', '01', 'C2'))
		dw_1.setitem(i, 'pasivos_alta', f_premaat_num_colegiados_grupo('S', '02', 'C2'))
		dw_1.setitem(i, 'pasivos_baja', f_premaat_num_colegiados_grupo('N', '02', 'C2'))		
		
END CHOOSE

// Etiquetas A$$HEX1$$f100$$ENDHEX$$os
if lower(dw_1.describe("anyo_0_t.name")) = 'anyo_0_t' then dw_1.object.anyo_0_t.text = string(year(date(f_ini_0)))
if lower(dw_1.describe("anyo_1_t.name")) = 'anyo_1_t' then dw_1.object.anyo_1_t.text = string(year(date(f_ini_1)))
if lower(dw_1.describe("anyo_2_t.name")) = 'anyo_2_t' then dw_1.object.anyo_2_t.text = string(year(date(f_ini_2)))
if lower(dw_1.describe("anyo_3_t.name")) = 'anyo_3_t' then dw_1.object.anyo_3_t.text = string(year(date(f_ini_3)))
if lower(dw_1.describe("anyo_4_t.name")) = 'anyo_4_t' then dw_1.object.anyo_4_t.text = string(year(date(f_ini_4)))
if lower(dw_1.describe("anyo_5_t.name")) = 'anyo_5_t' then dw_1.object.anyo_5_t.text = string(year(date(f_ini_5)))


if dw_1.rowcount() > 0 then
	dw_1.groupcalc()
	dw_1.visible 		  = true
	this.enabled        = false
	dw_1.event pfc_printpreview()
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled   = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_registros_especificaciones','No se han encontrado registros segun las especificaciones.'))
end if

end event

type cb_salir from w_listados`cb_salir within w_musaat_estadisticas
end type

type dw_listados from w_listados`dw_listados within w_musaat_estadisticas
boolean visible = false
string dataobject = ""
end type

event dw_listados::constructor;// Sobreescrito
end event

type cb_imprimir from w_listados`cb_imprimir within w_musaat_estadisticas
end type

type cb_zoom from w_listados`cb_zoom within w_musaat_estadisticas
end type

type cb_esp from w_listados`cb_esp within w_musaat_estadisticas
end type

type cb_guardar from w_listados`cb_guardar within w_musaat_estadisticas
end type

type cb_escala from w_listados`cb_escala within w_musaat_estadisticas
end type

type cb_ordenar from w_listados`cb_ordenar within w_musaat_estadisticas
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_musaat_estadisticas
end type

type dw_1 from w_listados`dw_1 within w_musaat_estadisticas
integer x = 23
integer width = 3621
string dataobject = "d_listado1"
end type

