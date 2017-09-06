HA$PBExportHeader$w_facturacion_emitida_vencimientos.srw
forward
global type w_facturacion_emitida_vencimientos from w_response
end type
type dw_1 from u_dw within w_facturacion_emitida_vencimientos
end type
type cb_1 from commandbutton within w_facturacion_emitida_vencimientos
end type
type cb_2 from commandbutton within w_facturacion_emitida_vencimientos
end type
end forward

global type w_facturacion_emitida_vencimientos from w_response
integer width = 1591
integer height = 1068
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de Vencimientos"
boolean controlmenu = false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_facturacion_emitida_vencimientos w_facturacion_emitida_vencimientos

type variables
st_facturacion_emitida_vencimiento st_vencimiento
end variables

event open;call super::open;dw_1.InsertRow(0)

f_centrar_ventana(this)

dw_1.setitem(1,'fecha_inicial',today())
end event

on w_facturacion_emitida_vencimientos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_facturacion_emitida_vencimientos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_facturacion_emitida_vencimientos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_facturacion_emitida_vencimientos
end type

type dw_1 from u_dw within w_facturacion_emitida_vencimientos
event csd_calendario ( )
integer x = 32
integer y = 40
integer width = 1454
integer height = 720
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_factu_e_n_vencimientos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_calendario;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;double ll_null

setnull(ll_null)
choose case dwo.name
	case 'tipo_a'
			if data = 'D' then
				this.setitem(1,'dias_primer_vencimiento',ll_null)		
			else
				this.setitem(1,'dias_entre_vencimiento',ll_null)
			end if
	case 'dias_primer_vencimiento'	
			if long(data) > 31 then
				this.setitem(1,'dias_primer_vencimiento',ll_null)
				messagebox(g_titulo,'El d$$HEX1$$ed00$$ENDHEX$$a no puede ser mayor a 31')
				this.setcolumn('dias_primer_vencimiento')
				return 2
			end if
	
end choose
end event

event constructor;call super::constructor;post event csd_calendario()
end event

type cb_1 from commandbutton within w_facturacion_emitida_vencimientos
integer x = 201
integer y = 820
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;string mensaje

dw_1.accepttext()

mensaje=mensaje + f_valida(dw_1,'n_vencimientos','n_vencimientos','Debe especificar la cantidad de vencimientos')
mensaje=mensaje + f_valida(dw_1,'forma_pago','forma_pago','Debe especificar la forma de pago')



if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)
else
	st_vencimiento.fecha_inicial   = dw_1.getitemdatetime(1,'fecha_inicial')
	st_vencimiento.dias_entre      = dw_1.getitemdecimal(1,'dias_entre_vencimiento')
	st_vencimiento.dias_primer     = dw_1.getitemdecimal(1,'dias_primer_vencimiento')
	st_vencimiento.n_vencimiento   = dw_1.getitemdecimal(1,'n_vencimientos')
	st_vencimiento.formapago	    = dw_1.getitemstring(1,'forma_pago')
	
	
	CloseWithReturn(parent,st_vencimiento)

end if
end event

type cb_2 from commandbutton within w_facturacion_emitida_vencimientos
integer x = 942
integer y = 820
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;


CloseWithReturn(parent,st_vencimiento)
end event

