HA$PBExportHeader$w_fases_renuncias_detalle.srw
forward
global type w_fases_renuncias_detalle from w_response
end type
type dw_1 from u_dw within w_fases_renuncias_detalle
end type
type cb_1 from commandbutton within w_fases_renuncias_detalle
end type
type cb_2 from commandbutton within w_fases_renuncias_detalle
end type
end forward

global type w_fases_renuncias_detalle from w_response
integer x = 214
integer y = 221
integer width = 2491
integer height = 1448
string title = "Detalle de Renuncias"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_fases_renuncias_detalle w_fases_renuncias_detalle

type variables
datawindowchild i_dwc_colegiados,i_dwc_clientes
w_fases_detalle i_w
datawindow  idw_clientes, idw_colegiados, idw_descuentos 
datawindow  idw_estadistica, idw_fases_datos_exp, idw_1, idw_fases_src
string grabar_renuncia = 'N'
end variables

on w_fases_renuncias_detalle.create
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

on w_fases_renuncias_detalle.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;f_centrar_ventana(this)

string id_renuncia

id_renuncia = message.stringparm

dw_1.retrieve(id_renuncia)

end event

event pfc_preupdate;call super::pfc_preupdate;// COMPROBACIONES


// LOS DATOS SE GUARDAN SOLO EN DW_1, hay que pasarlos a ese datawindow
dw_1.accepttext()


return 1

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_renuncias_detalle
integer x = 2533
integer y = 1376
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_renuncias_detalle
integer x = 2533
integer y = 1236
integer taborder = 0
end type

type dw_1 from u_dw within w_fases_renuncias_detalle
integer x = 37
integer y = 32
integer width = 2418
integer height = 1176
integer taborder = 10
string dataobject = "d_fases_renuncias_detalle"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_fases_renuncias_detalle
integer x = 667
integer y = 1244
integer width = 402
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Guardar"
end type

event clicked;integer Net
dw_1.accepttext()
IF dw_1.ModifiedCount() + dw_1.DeletedCount() > 0 THEN
	Net = MessageBox(g_titulo, "Se van a guardar los cambios realizados $$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro?  ", Exclamation!, OKCancel!, 2)
	
	IF Net = 1 THEN
	 /*o	Si el usuario selecciona Aceptar en el mensaje de confirmaci$$HEX1$$f300$$ENDHEX$$n del bot$$HEX1$$f300$$ENDHEX$$n Guardar 
			se almacenan los cambios realizados por el usuario en base de datos.
		o	Cuando se realiza una modificaci$$HEX1$$f300$$ENDHEX$$n en el detalle de renuncias se deben almacenar los datos de usuario y fecha de modificaci$$HEX1$$f300$$ENDHEX$$n.
		o	En el campo usuario se guarda el login del usuario.
		o	En el campo f_modificacion se guarda la fecha actual en la que se realiza el cambio.
	*/
		dw_1.setitem(1, 'usuario', g_usuario)
		dw_1.setitem(1, 'f_modificacion', today())
		dw_1.accepttext()
	//	parent.event pfc_save()
		dw_1.update()
	ELSE
		return
	/*o	Si el usuario selecciona Cancelar en el mensaje de confirmaci$$HEX1$$f300$$ENDHEX$$n del bot$$HEX1$$f300$$ENDHEX$$n Guardar 
			entonces se cierra el mensaje de confirmaci$$HEX1$$f300$$ENDHEX$$n y se queda en la pantalla de detalle 
			de renuncias sin realizar ning$$HEX1$$fa00$$ENDHEX$$n cambio.*/
	
	END IF
END IF	
end event

type cb_2 from commandbutton within w_fases_renuncias_detalle
integer x = 1294
integer y = 1244
integer width = 402
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;// Descartamos los cambios
dw_1.SetItemStatus(1, 0, Primary!, NotModified!)

closewithreturn(parent, 'CANCELAR')

end event

