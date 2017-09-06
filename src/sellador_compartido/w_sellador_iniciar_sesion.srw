HA$PBExportHeader$w_sellador_iniciar_sesion.srw
forward
global type w_sellador_iniciar_sesion from w_response
end type
type cb_1 from u_cb within w_sellador_iniciar_sesion
end type
type cb_2 from u_cb within w_sellador_iniciar_sesion
end type
type dw_certificado from u_dw within w_sellador_iniciar_sesion
end type
type gb_1 from groupbox within w_sellador_iniciar_sesion
end type
end forward

global type w_sellador_iniciar_sesion from w_response
integer x = 214
integer y = 221
integer width = 1824
integer height = 616
cb_1 cb_1
cb_2 cb_2
dw_certificado dw_certificado
gb_1 gb_1
end type
global w_sellador_iniciar_sesion w_sellador_iniciar_sesion

on w_sellador_iniciar_sesion.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_certificado=create dw_certificado
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_certificado
this.Control[iCurrent+4]=this.gb_1
end on

on w_sellador_iniciar_sesion.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_certificado)
destroy(this.gb_1)
end on

event open;call super::open;dw_certificado.event pfc_insertrow()

if g_sellador_certificado <> '' then
	dw_certificado.setitem(1,'certificado',g_sellador_certificado)
end if

if g_sellador_password <> '' then
	dw_certificado.setitem(1,'password',g_sellador_password)
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_iniciar_sesion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_iniciar_sesion
end type

type cb_1 from u_cb within w_sellador_iniciar_sesion
integer x = 539
integer y = 408
integer taborder = 11
boolean bringtotop = true
string text = "Aceptar"
boolean default = true
end type

event clicked;call super::clicked;dw_certificado.accepttext()

if dw_certificado.getitemstring(1,'certificado') <> '' then
	g_sellador_certificado = dw_certificado.getitemstring(1,'certificado')
end if

if dw_certificado.getitemstring(1,'password') = '' then
	g_sellador_password = 'X'
else
	g_sellador_password = dw_certificado.getitemstring(1,'password')
end if

if dw_certificado.GetItemString(1,'fichero')='S' then
	if (g_sellador_certificado <> '' and g_sellador_password <> '') then
		messagebox(g_titulo_aplicacion,'Sesi$$HEX1$$f300$$ENDHEX$$n iniciada con $$HEX1$$e900$$ENDHEX$$xito')
	else
		messagebox(g_titulo_aplicacion,'La sesi$$HEX1$$f300$$ENDHEX$$n no se ha iniciado correctamente')
	end if
else
	if (g_sellador_certificado <> '') then
		messagebox(g_titulo_aplicacion,'Sesi$$HEX1$$f300$$ENDHEX$$n iniciada con $$HEX1$$e900$$ENDHEX$$xito')
	else
		messagebox(g_titulo_aplicacion,'La sesi$$HEX1$$f300$$ENDHEX$$n no se ha iniciado correctamente')
	end if
end if

close(parent)
end event

type cb_2 from u_cb within w_sellador_iniciar_sesion
integer x = 914
integer y = 408
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

type dw_certificado from u_dw within w_sellador_iniciar_sesion
integer x = 27
integer y = 48
integer width = 1755
integer height = 300
integer taborder = 10
string dataobject = "d_sellador_iniciar_sesion"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string certificado,certificado_id
choose case dwo.name
	case 'b_cert'
		if this.GetItemString(1,'fichero')='S' then
			openwithparm(w_certificados, this.getitemstring(1,'certificado'))
			certificado = message.stringparm
			if certificado = '' then return
			this.setitem(1,'certificado', certificado)
		else
			open(w_seleccion_certificado)
			certificado_id=Message.StringParm
			if f_es_vacio(certificado_id) then return
			this.SetItem(1,'certificado',certificado_id)		
			
		end if
end choose
end event

type gb_1 from groupbox within w_sellador_iniciar_sesion
integer x = 18
integer width = 1778
integer height = 368
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

