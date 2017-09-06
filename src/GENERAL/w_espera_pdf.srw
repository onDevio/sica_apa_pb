HA$PBExportHeader$w_espera_pdf.srw
forward
global type w_espera_pdf from w_response
end type
type cb_abortar from u_cb within w_espera_pdf
end type
type st_1 from statictext within w_espera_pdf
end type
type st_2 from statictext within w_espera_pdf
end type
end forward

global type w_espera_pdf from w_response
integer width = 1847
integer height = 528
cb_abortar cb_abortar
st_1 st_1
st_2 st_2
end type
global w_espera_pdf w_espera_pdf

type variables
string i_nombre_fichero
boolean i_salir = false
n_esperar_proceso inv_esperar

end variables

event open;call super::open;i_nombre_fichero=Message.StringParm
f_centrar_ventana(this)
inv_esperar = create n_esperar_proceso

end event

event pfc_postopen;call super::pfc_postopen;int ret = 1
//MessageBox("DEBUG",i_nombre_fichero)
DO UNTIL fileexists(i_nombre_fichero) OR i_salir 
	SetPointer(Hourglass!)
	Yield()
LOOP

if i_salir then ret = -1

closewithreturn(this,ret)

end event

event pfc_close;call super::pfc_close;destroy inv_esperar
end event

on w_espera_pdf.create
int iCurrent
call super::create
this.cb_abortar=create cb_abortar
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_abortar
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
end on

on w_espera_pdf.destroy
call super::destroy
destroy(this.cb_abortar)
destroy(this.st_1)
destroy(this.st_2)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_espera_pdf
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_espera_pdf
end type

type cb_abortar from u_cb within w_espera_pdf
integer x = 1403
integer y = 312
integer taborder = 10
boolean bringtotop = true
string text = "Abortar"
end type

event clicked;call super::clicked;i_salir = true

inv_esperar.f_esperar_proceso('DocuPrinter')
	


end event

type st_1 from statictext within w_espera_pdf
integer x = 165
integer y = 60
integer width = 859
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Generando documento en formato PDF"
boolean focusrectangle = false
end type

type st_2 from statictext within w_espera_pdf
integer x = 165
integer y = 160
integer width = 1367
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Esta operaci$$HEX1$$f300$$ENDHEX$$n puede tardar varios segundos, espere por favor"
boolean focusrectangle = false
end type

