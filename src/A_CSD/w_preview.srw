HA$PBExportHeader$w_preview.srw
forward
global type w_preview from w_response
end type
type dw_1 from u_dw within w_preview
end type
type cb_1 from commandbutton within w_preview
end type
type cb_2 from commandbutton within w_preview
end type
end forward

global type w_preview from w_response
integer width = 3515
integer height = 2432
string title = "Previsualizaci$$HEX1$$f300$$ENDHEX$$n"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_preview w_preview

type variables
st_preview ist_preview
end variables

on w_preview.create
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

on w_preview.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;ist_preview = message.powerobjectparm

dw_1.dataobject = ist_preview.dataobject
//dw_1.insertrow(0)
dw_1.importstring(ist_preview.data)

if g_usar_idioma = "S" then
	g_idioma.of_cambia_textos_dw( dw_1 )
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_preview
integer x = 3154
integer y = 1024
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_preview
integer x = 3154
integer y = 896
end type

type dw_1 from u_dw within w_preview
integer x = 37
integer y = 32
integer width = 3429
integer height = 2156
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;//of_setprintpreview(true)
end event

type cb_1 from commandbutton within w_preview
string tag = "texto=general.imprimir"
integer x = 1335
integer y = 2232
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
string text = "&Imprimir"
end type

event clicked;dw_1.accepttext()
//dw_1.print()

if g_colegio = 'COAATGU' then
	// Eligen n$$HEX2$$ba002000$$ENDHEX$$de copias
	int i
	string  sl_copias
	openwithparm(w_n_copias, ist_preview.modulo)
	sl_copias  = Message.StringParm
	for i=1 to long(sl_copias)
		dw_1.print()
	next
else
	dw_1.print()
end if

end event

type cb_2 from commandbutton within w_preview
string tag = "texto=general.cerrar"
integer x = 3122
integer y = 2232
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

