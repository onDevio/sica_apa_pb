HA$PBExportHeader$w_musaat_fichero_eco_consulta.srw
$PBExportComments$A fecha de 2004-06-16 vuelve a utilizarse para hacer la consulta de los movimientos de musaat
forward
global type w_musaat_fichero_eco_consulta from w_consulta
end type
end forward

global type w_musaat_fichero_eco_consulta from w_consulta
integer x = 214
integer y = 221
string title = "Consulta de Fichero Econ$$HEX1$$f300$$ENDHEX$$mico"
end type
global w_musaat_fichero_eco_consulta w_musaat_fichero_eco_consulta

on w_musaat_fichero_eco_consulta.create
call super::create
end on

on w_musaat_fichero_eco_consulta.destroy
call super::destroy
end on

event open;call super::open;// Modificado Ricardo 04-06-14
CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		dw_1.setitem(dw_1.getrow(), 'centro', f_devuelve_centro(g_cod_delegacion))
END CHOOSE
// FIN Modificado Ricardo 04-06-14
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_musaat_fichero_eco_consulta
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_musaat_fichero_eco_consulta
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_musaat_fichero_eco_consulta
string tag = "texto=general.limpiar_consulta"
end type

type st_5 from w_consulta`st_5 within w_musaat_fichero_eco_consulta
string tag = "texto=musaat.introducir_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_musaat_fichero_eco_consulta
integer x = 402
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_copia, sql_origin
string n_expedi_basura

//Recuperamos le select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
sql_copia = sql_nuevo
sql_origin = sql_nuevo
//Nuevas normativas de musaat se debe poder elejir fichero solo renuncias o resto
CHOOSE CASE dw_1.getitemstring(dw_1.getrow(),'t_visado')
	case '2' 
 	f_sql_valores('musaat_movimientos.t_visado','<>','6','CH',sql_nuevo,g_tipo_base_datos,'')
	case '3'
 	f_sql_valores('musaat_movimientos.t_visado','=','3','CH',sql_nuevo,g_tipo_base_datos,'')		
	case '6'
	f_sql_valores('musaat_movimientos.t_visado','=','6','CH',sql_nuevo,g_tipo_base_datos,'')
end choose
	
f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_desde', dw_1,sql_nuevo, g_tipo_base_datos, '')
f_sql('musaat_movimientos.fecha_calculo', '<', 'f_hasta', dw_1,sql_nuevo, g_tipo_base_datos, '')

select param1
into :n_expedi_basura
from t_control_eventos
where control = 'BORRAR_FASE' and evento = 'BORRAR_FASE';
//f_sql('fases_n_expedi', '<>', n_expedi_basura, dw_1,sql_nuevo, g_tipo_base_datos, '')
sql_nuevo = sql_nuevo + " and fases.n_expedi <> '"+n_expedi_basura+"' "


if sql_nuevo=sql_copia then 
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.fechas_generacion_fichero','Ha de especificar las fechas para la generaci$$HEX1$$f300$$ENDHEX$$n del fichero'), stopsign!)
	return
end if
// Si quieren excluir, separamos 
if dw_1.getitemstring(dw_1.getrow(), 'excluir')='S' then f_sql_valores ('musaat_movimientos.fecha_notificacion','=','null','CH',sql_nuevo,g_tipo_base_datos,'')

// Volvemos a igualar porque querran en tenerife que se obligue a poner el centro
sql_copia = sql_nuevo
f_sql('fases.modalidad', '=', 'centro', dw_1,sql_nuevo, g_tipo_base_datos, '')
CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		if sql_nuevo=sql_copia then 
			MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.centro_generacion_fichero','Ha de especificar el centro para la generaci$$HEX1$$f300$$ENDHEX$$n del fichero'), stopsign!)
			return
		end if
END CHOOSE
g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")
g_dw_lista.retrieve()
g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_origin + "~"")
Parent.event pfc_close()








/*
string sql_nuevo, sql_copia
//Recuperamos le select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")
sql_copia = sql_nuevo

f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat_movimientos.fecha_calculo', '<=', 'f_hasta', Parent.dw_1,sql_nuevo, '1', '')


if sql_nuevo=sql_copia then 
	MessageBox(g_titulo,'Ha de especificar las fechas para la generacion del fichero')
else
	g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

	Parent.event pfc_close()
end if
*/
end event

type cb_2 from w_consulta`cb_2 within w_musaat_fichero_eco_consulta
integer x = 1029
integer y = 936
end type

event cb_2::clicked;// Sobreescrito
Closewithreturn(parent,'-1')
end event

type cb_ayuda from w_consulta`cb_ayuda within w_musaat_fichero_eco_consulta
string tag = "texto=general.ayuda"
end type

type dw_1 from w_consulta`dw_1 within w_musaat_fichero_eco_consulta
integer y = 160
integer width = 1719
integer height = 576
string dataobject = "d_musaat_fichero_eco_consulta"
end type

event dw_1::itemchanged;call super::itemchanged;choose case dwo.name
	case 'mes'
		datetime f_desde
		string mes
		mes = data
		
		f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
end choose
end event

