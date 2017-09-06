HA$PBExportHeader$w_caja_salidas_lista.srw
forward
global type w_caja_salidas_lista from w_lista
end type
type dw_consulta from u_dw within w_caja_salidas_lista
end type
type cb_1 from commandbutton within w_caja_salidas_lista
end type
type cb_movimientos from commandbutton within w_caja_salidas_lista
end type
type cb_2 from commandbutton within w_caja_salidas_lista
end type
type cb_3 from commandbutton within w_caja_salidas_lista
end type
end forward

global type w_caja_salidas_lista from w_lista
integer height = 1304
string title = "Cuadre de Caja"
dw_consulta dw_consulta
cb_1 cb_1
cb_movimientos cb_movimientos
cb_2 cb_2
cb_3 cb_3
end type
global w_caja_salidas_lista w_caja_salidas_lista

type variables
DateTime i_fecha
String i_centro

end variables

on w_caja_salidas_lista.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_1=create cb_1
this.cb_movimientos=create cb_movimientos
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_movimientos
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
end on

on w_caja_salidas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_consulta)
destroy(this.cb_1)
destroy(this.cb_movimientos)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_caja_salidas
g_lista     = 'w_caja_salidas_lista'

end event

event pfc_postopen();call super::pfc_postopen;g_dw_lista_caja_salidas = dw_lista

dw_consulta.InsertRow(0)

i_fecha = DateTime(today())
i_centro = f_devuelve_centro(g_cod_delegacion)

dw_consulta.SetItem(1,'fecha',i_fecha)
dw_consulta.SetItem(1,'centro',i_centro)


dw_lista.event csd_retrieve()

end event

event csd_detalle;call super::csd_detalle;// Si el dw_lista no tiene ninguna tupla no entramos en el detalle
if dw_lista.RowCount() < 1 then return 

long fila 
string id 
st_caja_salidas datos

fila = dw_lista.GetRow()
datos.id = dw_lista.GetItemString(fila,'id_caja_salida')

openwithparm(w_caja_salidas_detalle,datos)

this.post event csd_actualiza_listas()


end event

event csd_actualiza_listas;// Actualizamos los dddw de la ventana

if g_dw_lista.rowcount() <= 0 then return 
g_dw_lista.modify("datawindow.table.select= ~"" + i_sentencia_sql_lista + "~"")
dw_lista.event csd_retrieve()

g_dw_lista.modify("datawindow.table.select= ~"" + i_sql_original + "~"")


if dw_lista.rowcount() > 0 then dw_lista.selectrow(1,true)

end event

event csd_listados;call super::csd_listados;open(w_caja_salidas_listados)
end event

event csd_nuevo;call super::csd_nuevo;dw_lista.event pfc_addrow()
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_caja_salidas_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_caja_salidas_lista
integer taborder = 20
end type

type st_1 from w_lista`st_1 within w_caja_salidas_lista
integer x = 37
end type

type dw_lista from w_lista`dw_lista within w_caja_salidas_lista
integer x = 37
integer y = 308
integer width = 3419
integer height = 684
integer taborder = 110
string dataobject = "d_caja_salidas_lista"
end type

event dw_lista::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_debug.enabled = False
end event

event dw_lista::csd_retrieve;// Se asigna a variable que se utilizara para actualizar la lista (desde menu)
i_sentencia_sql_lista = dw_lista.describe("datawindow.table.select")

// Codigo original de w_lista
This.Retrieve(i_fecha,i_centro, g_empresa)
This.modify("DataWindow.Table.Select= ~"" + i_sql_original + "~"")

end event

event dw_lista::pfc_addrow;call super::pfc_addrow;st_caja_salidas st_salida

st_salida.fecha = i_fecha
st_salida.centro = i_centro
st_salida.id = 'NUEVO'

openwithparm(w_caja_salidas_detalle,st_salida)

this.post event csd_retrieve()

return AncestorReturnValue
end event

type cb_consulta from w_lista`cb_consulta within w_caja_salidas_lista
integer taborder = 30
end type

type cb_detalle from w_lista`cb_detalle within w_caja_salidas_lista
integer taborder = 60
end type

type cb_ayuda from w_lista`cb_ayuda within w_caja_salidas_lista
integer taborder = 80
end type

type dw_consulta from u_dw within w_caja_salidas_lista
integer x = 23
integer y = 72
integer width = 2034
integer height = 208
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_caja_salidas_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'fecha'
		i_fecha = DateTime(Date(data),Time("00:00"))
		i_centro = this.GetItemString(1,'centro')
	case 'centro'
		i_centro = data
		i_fecha = this.GetItemDateTime(1,'fecha')
end choose

end event

type cb_1 from commandbutton within w_caja_salidas_lista
boolean visible = false
integer x = 2267
integer y = 112
integer width = 407
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cuadre de Caja"
end type

event clicked;dw_consulta.AcceptText()

if isnull(i_fecha) or f_es_vacio(i_centro) then
	MessageBox(g_titulo,'Debe especificar la Fecha y el Centro')
	return
end if

st_caja_salidas datos

datos.fecha = i_fecha
datos.centro = i_centro
datos.listado = 'C' // Listado de Cuadre de Caja

openwithparm(w_caja_salidas_listado,datos)

end event

type cb_movimientos from commandbutton within w_caja_salidas_lista
boolean visible = false
integer x = 2688
integer y = 112
integer width = 407
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mov. Caja"
end type

event clicked;dw_consulta.AcceptText()

if isnull(i_fecha) or f_es_vacio(i_centro) then
	MessageBox(g_titulo,'Debe especificar la Fecha y el Centro')
	return
end if

st_caja_salidas datos

datos.fecha = i_fecha
datos.centro = i_centro
datos.listado = 'M'

openwithparm(w_caja_salidas_listado,datos)

end event

type cb_2 from commandbutton within w_caja_salidas_lista
integer x = 2144
integer y = 120
integer width = 343
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Recuperar"
end type

event clicked;dw_consulta.accepttext()

dw_lista.event csd_retrieve()

end event

type cb_3 from commandbutton within w_caja_salidas_lista
integer x = 2560
integer y = 120
integer width = 343
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;event pfc_save()

end event

