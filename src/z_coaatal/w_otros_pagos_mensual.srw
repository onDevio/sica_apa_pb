HA$PBExportHeader$w_otros_pagos_mensual.srw
forward
global type w_otros_pagos_mensual from w_response
end type
type cb_2 from commandbutton within w_otros_pagos_mensual
end type
type dw_lista from u_dw within w_otros_pagos_mensual
end type
type dw_consulta from u_dw within w_otros_pagos_mensual
end type
type cb_generar from commandbutton within w_otros_pagos_mensual
end type
type dw_liquid from u_dw within w_otros_pagos_mensual
end type
type cb_buscar from commandbutton within w_otros_pagos_mensual
end type
end forward

global type w_otros_pagos_mensual from w_response
integer width = 3383
integer height = 1644
string title = "Otros Pagos Mensuales"
boolean ib_isupdateable = false
cb_2 cb_2
dw_lista dw_lista
dw_consulta dw_consulta
cb_generar cb_generar
dw_liquid dw_liquid
cb_buscar cb_buscar
end type
global w_otros_pagos_mensual w_otros_pagos_mensual

type variables

end variables

on w_otros_pagos_mensual.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_lista=create dw_lista
this.dw_consulta=create dw_consulta
this.cb_generar=create cb_generar
this.dw_liquid=create dw_liquid
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.dw_consulta
this.Control[iCurrent+4]=this.cb_generar
this.Control[iCurrent+5]=this.dw_liquid
this.Control[iCurrent+6]=this.cb_buscar
end on

on w_otros_pagos_mensual.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_lista)
destroy(this.dw_consulta)
destroy(this.cb_generar)
destroy(this.dw_liquid)
destroy(this.cb_buscar)
end on

event open;call super::open;f_centrar_ventana(this)

datetime f_ini, f_fin
double mes

mes = month(today())
//mes = mes - 1
//if mes <= 0 then mes = mes + 12
f_ini = datetime(date('01/' + string(mes) + '/' + string(year(today()))), time('00:00:00'))
f_fin = datetime(date(f_ultimo_dia_mes (f_ini)), time('23:59:59'))

dw_consulta.insertrow(0)
dw_consulta.setitem(1, 'f_desde', f_ini)
dw_consulta.setitem(1, 'f_hasta', f_fin)
dw_consulta.setitem(1, 'f_liquid', datetime(today()))


//datetime(date(dw_listados.GetItemDateTime(1,'f_desde')), time('00:00:00'))
//datetime(date(dw_listados.GetItemDateTime(1,'f_hasta')), time('23:59:59'))
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_otros_pagos_mensual
integer x = 3488
integer y = 1420
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_otros_pagos_mensual
integer x = 3479
integer y = 1292
integer taborder = 0
end type

type cb_2 from commandbutton within w_otros_pagos_mensual
integer x = 2912
integer y = 1344
integer width = 416
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type dw_lista from u_dw within w_otros_pagos_mensual
integer x = 37
integer y = 512
integer width = 3291
integer height = 788
integer taborder = 20
string dataobject = "d_otros_pagos_mensual_lista"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type dw_consulta from u_dw within w_otros_pagos_mensual
integer x = 37
integer y = 32
integer width = 1787
integer height = 420
integer taborder = 10
string dataobject = "d_otros_pagos_mensual_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_generar from commandbutton within w_otros_pagos_mensual
integer x = 37
integer y = 1344
integer width = 416
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Pagos"
end type

event clicked;int i
datetime f_liquid

dw_consulta.accepttext()

f_liquid = dw_consulta.getitemdatetime(1, 'f_liquid')

// Validamos que han introducido la fecha
if isnull(f_liquid) then
	messagebox(g_titulo, "Debe introducir las fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n", exclamation!)
	return
end if

// Copiamos las seleccionadas
for i=1 to dw_lista.rowcount()
	if dw_lista.getitemstring(i, 'procesar_registro') = 'N' then continue
	dw_lista.rowscopy(i, i, Primary!, dw_liquid, dw_lista.rowcount(), Primary!)
next
	
// Tenemos que cambiar algunos valores
for i=1 to dw_liquid.rowcount()
	dw_liquid.setitem(i, 'id_liquidacion', f_siguiente_numero('LIQUIDACIONES',10))
	dw_liquid.setitem(i, 'estado', 'P')
	dw_liquid.setitem(i, 'contabilizada', 'N')
	dw_liquid.setitem(i, 'f_liquidacion', f_liquid)
	dw_liquid.SetItem(i, 'n_documento','')	
	dw_liquid.SetItem(i, 'empresa',g_empresa)
	dw_liquid.SetItem(i, 'cod_usuario',g_usuario)
	dw_liquid.SetItem(i, 'f_entrada',datetime(today()))
next

// Grabamos
//dw_liquid.update()
this.enabled = false

// Las liquidaciones que acabamos de generar las mostramos en la lista
u_dw idw_liquid
idw_liquid = g_dw_lista
idw_liquid.reset()
dw_liquid.rowscopy(1, dw_liquid.rowcount(), Primary!, idw_liquid, 1, Primary!)
idw_liquid.update()
end event

type dw_liquid from u_dw within w_otros_pagos_mensual
boolean visible = false
integer x = 1463
integer y = 256
integer width = 1646
integer height = 224
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_premaat_liquid_lista"
end type

type cb_buscar from commandbutton within w_otros_pagos_mensual
integer x = 1902
integer y = 108
integer width = 416
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;datetime f_desde, f_hasta

dw_consulta.AcceptText()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = dw_consulta.getitemdatetime(1, 'f_hasta')

if isnull(f_desde) or isnull(f_hasta) then 
	messagebox(g_titulo, "Debe introducir las fechas de consulta", exclamation!)
	return
else
	dw_lista.retrieve(f_desde, f_hasta, g_empresa)	
end if

end event

