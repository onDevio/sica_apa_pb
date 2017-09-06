HA$PBExportHeader$w_liquidaciones_genera_liquidacion.srw
forward
global type w_liquidaciones_genera_liquidacion from w_response
end type
type cb_1 from commandbutton within w_liquidaciones_genera_liquidacion
end type
type cb_cancelar from commandbutton within w_liquidaciones_genera_liquidacion
end type
type dw_liquid from u_dw within w_liquidaciones_genera_liquidacion
end type
end forward

global type w_liquidaciones_genera_liquidacion from w_response
integer width = 1399
integer height = 896
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n Liquidaci$$HEX1$$f300$$ENDHEX$$n"
cb_1 cb_1
cb_cancelar cb_cancelar
dw_liquid dw_liquid
end type
global w_liquidaciones_genera_liquidacion w_liquidaciones_genera_liquidacion

type variables
st_liquidacion i_parametros
 
end variables

on w_liquidaciones_genera_liquidacion.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_cancelar=create cb_cancelar
this.dw_liquid=create dw_liquid
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_liquid
end on

on w_liquidaciones_genera_liquidacion.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_cancelar)
destroy(this.dw_liquid)
end on

event open;call super::open;// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
if isvalid(message.PowerObjectParm) then i_parametros = message.PowerObjectParm	

f_centrar_ventana(this)

// Colocamos los datos por defecto
dw_liquid.SetItem(1,'fecha_pago',DateTime(Today(),time("00:00")))
dw_liquid.Setitem(1,'forma_pago',g_formas_pago.transferencia)
dw_liquid.Setitem(1,'total_pagar',(-1)*i_parametros.importe)
dw_liquid.Setitem(1,'asunto',i_parametros.concepto)

end event

event pfc_postopen();call super::pfc_postopen;dw_liquid.of_SetDropDownCalendar(True)
dw_liquid.iuo_calendar.of_register(dw_liquid.iuo_calendar.DDLB)
dw_liquid.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_liquid.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_liquidaciones_genera_liquidacion
integer x = 1445
integer taborder = 70
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_liquidaciones_genera_liquidacion
integer x = 1445
integer y = 988
end type

type cb_1 from commandbutton within w_liquidaciones_genera_liquidacion
integer x = 224
integer y = 660
integer width = 402
integer height = 92
integer taborder = 80
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

event clicked;string mensaje

// Validaciones
dw_liquid.accepttext()
mensaje = mensaje + f_valida(dw_liquid,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_liquid,'forma_pago','NONULO','Debe especificar la forma de pago.')

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if

// Si no quieren generarla cerramos
if dw_liquid.getitemstring(1,'liquidar') = 'N' then
	close(parent)
else
	// Pasamos los datos introducidos
	i_parametros.forma_pago		= dw_liquid.getitemstring(1,'forma_pago')
	i_parametros.f_entrada 		= dw_liquid.getitemdatetime(1,'fecha_pago')
	i_parametros.concepto		= dw_liquid.getitemstring(1,'asunto')
	i_parametros.importe_suma	= (-1)*i_parametros.importe
	
	f_liquidacion_facturas_general(i_parametros)
	
	close(parent)
end if

end event

type cb_cancelar from commandbutton within w_liquidaciones_genera_liquidacion
integer x = 768
integer y = 660
integer width = 402
integer height = 92
integer taborder = 90
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

event clicked;close(parent)
end event

type dw_liquid from u_dw within w_liquidaciones_genera_liquidacion
integer x = 37
integer y = 32
integer width = 1307
integer height = 508
integer taborder = 20
string dataobject = "d_minutas_genera_liquidacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.insertrow(0)


//Hacemos el filtro para que no muestre la forma de pago CM
datawindowchild dwc_formapago
this.GetChild('forma_pago', dwc_formapago)
dwc_formapago.settransobject(sqlca)
dwc_formapago.setfilter("tipo_pago<>'CM'")
dwc_formapago.filter()


end event

