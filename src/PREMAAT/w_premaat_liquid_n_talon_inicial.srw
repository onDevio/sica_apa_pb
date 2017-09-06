HA$PBExportHeader$w_premaat_liquid_n_talon_inicial.srw
forward
global type w_premaat_liquid_n_talon_inicial from w_response
end type
type dw_1 from u_dw within w_premaat_liquid_n_talon_inicial
end type
type cb_cancelar from commandbutton within w_premaat_liquid_n_talon_inicial
end type
type cb_aceptar from commandbutton within w_premaat_liquid_n_talon_inicial
end type
end forward

global type w_premaat_liquid_n_talon_inicial from w_response
integer width = 1920
integer height = 940
string title = "Emisi$$HEX1$$f300$$ENDHEX$$n de Talones"
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
end type
global w_premaat_liquid_n_talon_inicial w_premaat_liquid_n_talon_inicial

on w_premaat_liquid_n_talon_inicial.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_aceptar
end on

on w_premaat_liquid_n_talon_inicial.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
end on

event open;call super::open;string n_talon_por_defecto
long talon

dw_1.InsertRow(0)
select max(n_documento) into :n_talon_por_defecto from premaat_liquidaciones;
talon = long(n_talon_por_defecto)
talon ++

n_talon_por_defecto = string(talon)

if f_es_vacio(n_talon_por_defecto) then n_talon_por_defecto=''
dw_1.SetItem(dw_1.RowCount(),'n_talon_inicial',n_talon_por_defecto)
dw_1.SetItem(dw_1.RowCount(),'fecha_talon',datetime(Today()))
dw_1.SetItem(dw_1.RowCount(),'f_vencimiento',datetime(Today()))

end event

event pfc_postopen();call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_premaat_liquid_n_talon_inicial
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_premaat_liquid_n_talon_inicial
end type

type dw_1 from u_dw within w_premaat_liquid_n_talon_inicial
integer x = 37
integer y = 32
integer width = 1765
integer height = 380
integer taborder = 10
string dataobject = "d_liquidacion_datos_talon"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_cancelar from commandbutton within w_premaat_liquid_n_talon_inicial
integer x = 992
integer y = 576
integer width = 402
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;
st_liquidacion_datos_talon ds_talon

ds_talon.n_talon_inicial = '-1'
CloseWithReturn(parent,ds_talon)


end event

type cb_aceptar from commandbutton within w_premaat_liquid_n_talon_inicial
integer x = 471
integer y = 576
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string retorno
st_liquidacion_datos_talon ds_talon

dw_1.AcceptText()

if f_es_vacio(dw_1.GetItemString(dw_1.RowCount(),'n_talon_inicial')) then 
	MessageBox(g_titulo,g_idioma.of_getmsg('premaat.talon_inicial','Debe especificar un n$$HEX1$$fa00$$ENDHEX$$mero de tal$$HEX1$$f300$$ENDHEX$$n inicial.'))
	return 
end if

if not(IsNumber(dw_1.GetItemString(dw_1.RowCount(),'n_talon_inicial')))  then 
	Messagebox(g_titulo,g_idioma.of_getmsg('premaat.valor_numerico','Debe especificar un valor num$$HEX1$$e900$$ENDHEX$$rico.'))
	return
end if

if f_es_vacio(dw_1.GetItemString(dw_1.RowCount(),'banco')) then 
	MessageBox(g_titulo,g_idioma.of_getmsg('premaat.banco_pago','Debe especificar un Banco de Pago.'))
	return 
end if

retorno = RightA('0000000000000000000000'+string(dw_1.GetItemString(dw_1.RowCount(),'n_talon_inicial')),8)

ds_talon.n_talon_inicial = retorno
ds_talon.fecha_talon = dw_1.GetItemDatetime(dw_1.RowCount(),'fecha_talon')
ds_talon.banco = dw_1.GetItemString(dw_1.RowCount(),'banco')
//messagebox('',string(dw_1.RowCount(),'fecha_talon'))
ds_talon.f_vencimiento = dw_1.GetItemDatetime(dw_1.RowCount(),'f_vencimiento')
ds_talon.texto_manual = dw_1.GetItemString(dw_1.RowCount(),'texto_manual')
CloseWithReturn(parent,ds_talon)





end event

