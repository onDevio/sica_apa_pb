HA$PBExportHeader$w_mant_busq.srw
$PBExportComments$MADRE DE LOS MANTENIMIENTOS TABULARES CON BUSQUEDA
forward
global type w_mant_busq from w_mant
end type
type st_1 from statictext within w_mant_busq
end type
type st_2 from statictext within w_mant_busq
end type
type sle_1 from u_sle within w_mant_busq
end type
type sle_2 from u_sle within w_mant_busq
end type
type cb_buscar from commandbutton within w_mant_busq
end type
end forward

global type w_mant_busq from w_mant
integer width = 2679
string menuname = "m_manteni"
st_1 st_1
st_2 st_2
sle_1 sle_1
sle_2 sle_2
cb_buscar cb_buscar
end type
global w_mant_busq w_mant_busq

type variables
u_dw dw_retrieve
end variables

on w_mant_busq.create
int iCurrent
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
this.st_1=create st_1
this.st_2=create st_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.cb_buscar
end on

on w_mant_busq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.cb_buscar)
end on

event open;call super::open;//Por defecto, recuperaremos los datos desde dw_1.
dw_retrieve=dw_1
ii_ayuda=60
end event

event pfc_print;call super::pfc_print;return dw_1.Print()
end event

type cb_recuperar_pantalla from w_mant`cb_recuperar_pantalla within w_mant_busq
end type

type cb_guardar_pantalla from w_mant`cb_guardar_pantalla within w_mant_busq
end type

type dw_1 from w_mant`dw_1 within w_mant_busq
event csd_retrieve ( )
integer y = 168
integer height = 1024
integer taborder = 40
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;return this.retrieve(sle_1.text+'%',sle_2.text+'%')
end event

type cb_anyadir from w_mant`cb_anyadir within w_mant_busq
integer taborder = 50
end type

type cb_borrar from w_mant`cb_borrar within w_mant_busq
integer taborder = 30
end type

type cb_ayuda from w_mant`cb_ayuda within w_mant_busq
end type

type st_1 from statictext within w_mant_busq
string tag = "texto=mant_busq.codigo"
integer x = 27
integer y = 24
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79416533
boolean enabled = false
string text = "Etiqueta del C$$HEX1$$f300$$ENDHEX$$digo:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_busq
string tag = "texto=mant_busq.descripcion"
integer x = 1024
integer y = 24
integer width = 590
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79416533
boolean enabled = false
string text = "Etiqueta de la descripci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type sle_1 from u_sle within w_mant_busq
string tag = "microhelp=Introduzca el par$$HEX1$$e100$$ENDHEX$$metro o principio del par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda"
integer x = 549
integer y = 24
integer taborder = 20
textcase textcase = upper!
end type

type sle_2 from u_sle within w_mant_busq
string tag = "microhelp=Introduzca el par$$HEX1$$e100$$ENDHEX$$metro o principio del par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda"
integer x = 1614
integer y = 24
integer width = 626
integer taborder = 10
end type

type cb_buscar from commandbutton within w_mant_busq
event clicked pbm_bnclicked
string tag = "texto=general.buscar"
integer x = 2272
integer y = 12
integer width = 334
integer height = 96
integer taborder = 1
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;if (sle_1.text + sle_2.text = '') then
	messagebox("B$$HEX1$$fa00$$ENDHEX$$squeda de datos","Debe especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda",StopSign!)
	sle_1.SetFocus()
	return
end if
dw_retrieve.event pfc_retrieve()
end event

