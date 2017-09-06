HA$PBExportHeader$w_colegiados_facturas_no_pagadas.srw
forward
global type w_colegiados_facturas_no_pagadas from w_response
end type
type st_1 from statictext within w_colegiados_facturas_no_pagadas
end type
type dw_facturas from u_dw within w_colegiados_facturas_no_pagadas
end type
type st_colegiado from statictext within w_colegiados_facturas_no_pagadas
end type
type cb_aceptar from commandbutton within w_colegiados_facturas_no_pagadas
end type
type dw_saldos from u_dw within w_colegiados_facturas_no_pagadas
end type
type dw_lineas_factura from u_dw within w_colegiados_facturas_no_pagadas
end type
type gb_1 from groupbox within w_colegiados_facturas_no_pagadas
end type
end forward

global type w_colegiados_facturas_no_pagadas from w_response
integer width = 3090
integer height = 2188
string title = "Facturas Pendientes"
st_1 st_1
dw_facturas dw_facturas
st_colegiado st_colegiado
cb_aceptar cb_aceptar
dw_saldos dw_saldos
dw_lineas_factura dw_lineas_factura
gb_1 gb_1
end type
global w_colegiados_facturas_no_pagadas w_colegiados_facturas_no_pagadas

type variables
st_factufa_facturas_pendientes i_datos
end variables

on w_colegiados_facturas_no_pagadas.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_facturas=create dw_facturas
this.st_colegiado=create st_colegiado
this.cb_aceptar=create cb_aceptar
this.dw_saldos=create dw_saldos
this.dw_lineas_factura=create dw_lineas_factura
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_facturas
this.Control[iCurrent+3]=this.st_colegiado
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.dw_saldos
this.Control[iCurrent+6]=this.dw_lineas_factura
this.Control[iCurrent+7]=this.gb_1
end on

on w_colegiados_facturas_no_pagadas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_facturas)
destroy(this.st_colegiado)
destroy(this.cb_aceptar)
destroy(this.dw_saldos)
destroy(this.dw_lineas_factura)
destroy(this.gb_1)
end on

event open;call super::open;string filtro

f_centrar_ventana(this)

i_datos = Message.PowerObjectParm

st_colegiado.text = f_colegiado(i_datos.id_col)
dw_facturas.SetTransObject(SQLCA)
dw_facturas.Retrieve( i_datos.id_col)

if i_datos.tipo_gestion = 'C' then
	dw_saldos.InsertRow(0)
	dw_saldos.SetItem(1,'favor',i_datos.total_favor)
	dw_saldos.SetItem(1,'contra',i_datos.total_contra)
end if

if dw_facturas.rowcount()>0 then 
	dw_facturas.SetRow(1)
	dw_lineas_factura.Retrieve(dw_facturas.GetItemString(1,'id_factura'))
end if
dw_facturas.SetRedraw(TRUE)




end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_colegiados_facturas_no_pagadas
integer x = 2130
integer y = 768
integer width = 69
integer height = 60
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_colegiados_facturas_no_pagadas
integer x = 2222
integer y = 768
integer width = 50
integer height = 68
end type

type st_1 from statictext within w_colegiados_facturas_no_pagadas
string tag = "texto=colegiados.colegiado:"
integer x = 110
integer y = 32
integer width = 389
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Colegiado :"
boolean focusrectangle = false
end type

type dw_facturas from u_dw within w_colegiados_facturas_no_pagadas
integer x = 27
integer y = 312
integer width = 2939
integer height = 908
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_facturas_no_pagadas"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;double total,favor,contra
string id_factura,formapago

id_factura = this.GetItemString(row,'id_factura')

this.accepttext()
choose case dwo.name
	case 'incluir'
		if i_datos.tipo_gestion <>'C' then return
		favor = dw_saldos.GetItemNumber(1,'favor')
		contra = dw_saldos.GetItemNumber(1,'contra')
		
		total = this.GetItemNumber(row,'total')
		if data = 'N' then
			select formadepago into :formapago from csi_facturas_emitidas where id_factura = :id_factura;
			total = - total
			this.SetItem(row,'formadepago',formapago)
		else
			this.SetItem(row,'formadepago',g_formas_pago.liquidacion)
		end if
		
		contra = contra + total
		if favor < contra then
			MessageBox(g_titulo,g_idioma.of_getmsg('colegiados.supera_honorarios','La cantidad a pagar por el colegiado supera sus honorarios.'))
			this.SetItem(1,'incluir','N')
			return -1
		end if
		dw_saldos.SetItem(1,'contra',contra)
		
end choose
end event

event rowfocuschanged;if currentrow=0 then
	if this.rowcount()>0 then 
		currentrow=1
	else
		return
	end if
end if
	
dw_lineas_factura.Retrieve(dw_facturas.GetItemString(currentrow,'id_factura'))
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
end event

event retrieveend;call super::retrieveend;if rowcount= 0 then return

dw_lineas_factura.Retrieve(this.GetItemString(1,'id_factura'))
end event

type st_colegiado from statictext within w_colegiados_facturas_no_pagadas
integer x = 585
integer y = 24
integer width = 2021
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_aceptar from commandbutton within w_colegiados_facturas_no_pagadas
string tag = "texto=general.cerrar"
integer x = 1371
integer y = 1956
integer width = 398
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

event clicked;Close(parent)

end event

type dw_saldos from u_dw within w_colegiados_facturas_no_pagadas
integer x = 18
integer y = 156
integer width = 2075
integer height = 156
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_saldos_liquidacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_lineas_factura from u_dw within w_colegiados_facturas_no_pagadas
integer x = 37
integer y = 1348
integer width = 2917
integer height = 520
integer taborder = 11
string dataobject = "d_colegiados_lineas_pendientes"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type gb_1 from groupbox within w_colegiados_facturas_no_pagadas
integer x = 18
integer y = 1284
integer width = 2953
integer height = 624
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Desglose Factura"
end type

