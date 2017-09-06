HA$PBExportHeader$w_colegiados_alta_baja.srw
forward
global type w_colegiados_alta_baja from w_response
end type
type dw_consulta from u_dw within w_colegiados_alta_baja
end type
type cb_3 from commandbutton within w_colegiados_alta_baja
end type
type cb_impr from commandbutton within w_colegiados_alta_baja
end type
type cb_emitir_cartas from commandbutton within w_colegiados_alta_baja
end type
end forward

global type w_colegiados_alta_baja from w_response
integer width = 1472
integer height = 944
string title = "Alta/Baja"
boolean controlmenu = false
boolean ib_isupdateable = false
dw_consulta dw_consulta
cb_3 cb_3
cb_impr cb_impr
cb_emitir_cartas cb_emitir_cartas
end type
global w_colegiados_alta_baja w_colegiados_alta_baja

type variables
string i_alta_baja


end variables

on w_colegiados_alta_baja.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_3=create cb_3
this.cb_impr=create cb_impr
this.cb_emitir_cartas=create cb_emitir_cartas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_impr
this.Control[iCurrent+4]=this.cb_emitir_cartas
end on

on w_colegiados_alta_baja.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.cb_3)
destroy(this.cb_impr)
destroy(this.cb_emitir_cartas)
end on

event open;call super::open;f_centrar_ventana(this)

dw_consulta.insertrow(0)

i_alta_baja = message.stringparm
//messagebox('', alta_baja)

dw_consulta.setitem(1, 'alta_baja', i_alta_baja)
dw_consulta.setitem(1, 'fecha', datetime(today()))

// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)



end event

event pfc_postopen();call super::pfc_postopen;dw_consulta.of_SetDropDownCalendar(True)
dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_consulta.iuo_calendar.of_SetInitialValue(True)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_colegiados_alta_baja
integer x = 2427
integer y = 1824
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_colegiados_alta_baja
integer x = 2427
integer y = 1696
end type

type dw_consulta from u_dw within w_colegiados_alta_baja
integer x = 37
integer y = 32
integer width = 1422
integer height = 568
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_colegiados_alta_baja"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
				if g_usar_idioma = 'N' then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
		else
			messagebox(g_titulo,g_idioma.of_getmsg("colegiados.colegiado_valido"))
		end if
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_col)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_col))				
		end if
END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
	case 'tipo_baja'
			//COAM-29
			if data='B4' and g_colegio='COAATMCA' then
				cb_emitir_cartas.visible=true
			else
				cb_emitir_cartas.visible=false
			end if
END CHOOSE

end event

type cb_3 from commandbutton within w_colegiados_alta_baja
string tag = "texto=general.aceptar"
integer x = 59
integer y = 672
integer width = 329
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string tipo_alta, tipo_baja, mensaje=''
datetime fecha

dw_consulta.accepttext()

fecha = dw_consulta.getitemdatetime(1, 'fecha')
tipo_alta = dw_consulta.getitemstring(1, 'tipo_alta')
tipo_baja = dw_consulta.getitemstring(1, 'tipo_baja')


string l_mensaje_traducido


if g_usar_idioma = 'S' then
 l_mensaje_traducido = g_idioma.of_getmsg("general.especificar_fecha")
 if isnull(string(fecha)) then mensaje += l_mensaje_traducido
else
	if isnull(string(fecha)) then mensaje += 'Debe especificar una fecha.'
end if

if g_usar_idioma = 'S' then
if f_es_vacio(tipo_alta) and f_es_vacio(tipo_baja) then mensaje += cr + g_idioma.of_getmsg("general.especificar_tipo")

else
if f_es_vacio(tipo_alta) and f_es_vacio(tipo_baja) then mensaje += cr + 'Debe especificar un valor en el campo tipo.'
end if

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
else
	g_colegiados_consulta.fecha = fecha
	if i_alta_baja = 'S' then g_colegiados_consulta.tipo = tipo_alta
	if i_alta_baja = 'N' then g_colegiados_consulta.tipo = tipo_baja
	closewithreturn(parent, "1")
end if

end event

type cb_impr from commandbutton within w_colegiados_alta_baja
string tag = "texto=general.cancelar"
integer x = 1038
integer y = 672
integer width = 329
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent, "-1")

end event

type cb_emitir_cartas from commandbutton within w_colegiados_alta_baja
boolean visible = false
integer x = 480
integer y = 668
integer width = 475
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Carta Defunci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;w_colegiados_detalle w_ventana
st_colegiado_defuncion st_col


w_ventana= g_w_detalle
st_col.f_defuncion= dw_consulta.GetItemDateTime(1,'fecha')
st_col.n_colegiado=w_ventana.dw_1.GetItemString(w_ventana.dw_1.GetRow(),'n_colegiado')
OpenWithParm(w_cartas_defuncion_generacion,st_col)
end event

