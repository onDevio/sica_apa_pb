HA$PBExportHeader$w_fases_ultimo_numero_minuta.srw
forward
global type w_fases_ultimo_numero_minuta from w_response
end type
type cb_1 from commandbutton within w_fases_ultimo_numero_minuta
end type
type st_1 from statictext within w_fases_ultimo_numero_minuta
end type
type cb_2 from commandbutton within w_fases_ultimo_numero_minuta
end type
type sle_1 from u_sle within w_fases_ultimo_numero_minuta
end type
type dw_1 from u_dw within w_fases_ultimo_numero_minuta
end type
end forward

global type w_fases_ultimo_numero_minuta from w_response
integer width = 1202
integer height = 636
boolean controlmenu = false
cb_1 cb_1
st_1 st_1
cb_2 cb_2
sle_1 sle_1
dw_1 dw_1
end type
global w_fases_ultimo_numero_minuta w_fases_ultimo_numero_minuta

event open;call super::open;string num
f_centrar_ventana(this)

dw_1.retrieve()

//select valor into :num from contadores where contador = 'ULT_MIN_DOC';
//sle_1.text=num
end event

on w_fases_ultimo_numero_minuta.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.sle_1=create sle_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_fases_ultimo_numero_minuta.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.dw_1)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_ultimo_numero_minuta
integer x = 1435
integer y = 1168
integer width = 576
integer taborder = 0
string text = "Recuperar Consulta"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_ultimo_numero_minuta
integer x = 818
integer y = 1148
integer width = 526
string text = "Grabar Consulta"
end type

type cb_1 from commandbutton within w_fases_ultimo_numero_minuta
integer x = 603
integer y = 412
integer width = 347
integer height = 92
integer taborder = 50
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

type st_1 from statictext within w_fases_ultimo_numero_minuta
integer x = 41
integer y = 52
integer width = 896
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Ultimo n$$HEX1$$fa00$$ENDHEX$$mero de minuta :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_fases_ultimo_numero_minuta
integer x = 233
integer y = 412
integer width = 347
integer height = 92
integer taborder = 40
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

event clicked;double valor

dw_1.accepttext()

//valor = double(sle_1.text)
valor = dw_1.getitemnumber(1, 'valor')

UPDATE contadores  SET valor = :valor  WHERE contadores.contador = 'ULT_MIN_DOC' ;
commit;

close(parent)
  

end event

type sle_1 from u_sle within w_fases_ultimo_numero_minuta
boolean visible = false
integer x = 393
integer y = 200
integer height = 80
integer taborder = 20
boolean bringtotop = true
end type

type dw_1 from u_dw within w_fases_ultimo_numero_minuta
integer x = 361
integer y = 188
integer width = 718
integer height = 132
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ultimo_num_minuta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

