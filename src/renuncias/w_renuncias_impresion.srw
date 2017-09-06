HA$PBExportHeader$w_renuncias_impresion.srw
forward
global type w_renuncias_impresion from w_response
end type
type cb_imprimir from u_cb within w_renuncias_impresion
end type
type dw_1 from u_dw within w_renuncias_impresion
end type
type cb_cancelar from commandbutton within w_renuncias_impresion
end type
end forward

global type w_renuncias_impresion from w_response
integer x = 214
integer y = 221
integer width = 1463
integer height = 688
event csd_rellenar_destinatarios ( string tipo )
cb_imprimir cb_imprimir
dw_1 dw_1
cb_cancelar cb_cancelar
end type
global w_renuncias_impresion w_renuncias_impresion

event csd_rellenar_destinatarios(string tipo);int fila
datawindowchild destinatarios

dw_1.getchild('destinatario',destinatarios)
destinatarios.SetTransObject(SQLCA)

destinatarios.reset()

if(tipo = 'C') then
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','TODAS')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','ARQUITECTOS')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','AYUNTAMIENTO')	
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','COAC')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','CONSEJERIA')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','GABINETE SSL')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','MINISTERIO')
end if

if(tipo = 'D') then
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','TODAS')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','ARQUITECTOS')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','AYUNTAMIENTO')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','COAC')
	fila = destinatarios.insertrow(0)
	destinatarios.setitem(fila,'destinatario','CONSEJERIA')
end if
end event

on w_renuncias_impresion.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_renuncias_impresion.destroy
call super::destroy
destroy(this.cb_imprimir)
destroy(this.dw_1)
destroy(this.cb_cancelar)
end on

event open;call super::open;string id_fase
string tipo_carta

id_fase = message.stringparm

dw_1.insertrow(0)

select fase into :tipo_carta from fases where id_fase = :id_fase;

if(LeftA(tipo_carta,1) = '0') then 
	dw_1.setitem(1,'tipo_carta','C')
	this.event csd_rellenar_destinatarios('C')
else
	dw_1.setitem(1,'tipo_carta','D')
	this.event csd_rellenar_destinatarios('D')
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_renuncias_impresion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_renuncias_impresion
end type

type cb_imprimir from u_cb within w_renuncias_impresion
integer x = 311
integer y = 468
integer taborder = 10
boolean bringtotop = true
string text = "Imprimir"
end type

event clicked;call super::clicked;st_renuncias_impresion imprimir

dw_1.accepttext()

imprimir.copias = dw_1.getitemstring(1,'copias')
imprimir.tipo_carta =  dw_1.getitemstring(1,'tipo_carta')
imprimir.destinatario =  dw_1.getitemstring(1,'destinatario')

closewithreturn(parent,imprimir)
end event

type dw_1 from u_dw within w_renuncias_impresion
integer x = 32
integer y = 28
integer width = 1385
integer height = 404
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_parametros_impresion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string num

CHOOSE CASE dwo.name
	CASE 'b_mas'
		num = this.getitemstring(1, 'copias')
		if num < '98' then this.setitem(1, 'copias', string(integer(num) + 1, '00'))
	CASE 'b_menos'
		num = this.getitemstring(1, 'copias')
		if num  > '00' then this.setitem(1, 'copias', string(integer(num) - 1, '00'))
end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'tipo_carta'
		if(data = 'D') then
			parent.event csd_rellenar_destinatarios('D')
		else
			parent.event csd_rellenar_destinatarios('C')
		end if
end choose
end event

type cb_cancelar from commandbutton within w_renuncias_impresion
integer x = 768
integer y = 468
integer width = 352
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

