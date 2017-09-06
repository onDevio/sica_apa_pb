HA$PBExportHeader$w_cursos_form_lista_copia_encuesta.srw
forward
global type w_cursos_form_lista_copia_encuesta from w_lista
end type
type cb_1 from commandbutton within w_cursos_form_lista_copia_encuesta
end type
type cb_2 from commandbutton within w_cursos_form_lista_copia_encuesta
end type
end forward

global type w_cursos_form_lista_copia_encuesta from w_lista
integer width = 3515
string title = "Lista de Convocatorias"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
cb_1 cb_1
cb_2 cb_2
end type
global w_cursos_form_lista_copia_encuesta w_cursos_form_lista_copia_encuesta

on w_cursos_form_lista_copia_encuesta.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_cursos_form_lista_copia_encuesta.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta

open(w_cursos_form_consulta)
if message.doubleparm=-1 then return
dw_lista.event csd_retrieve()
end event

type st_1 from w_lista`st_1 within w_cursos_form_lista_copia_encuesta
end type

type dw_lista from w_lista`dw_lista within w_cursos_form_lista_copia_encuesta
string dataobject = "d_cursos_form_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_cursos_form_lista_copia_encuesta
end type

type cb_detalle from w_lista`cb_detalle within w_cursos_form_lista_copia_encuesta
end type

type cb_ayuda from w_lista`cb_ayuda within w_cursos_form_lista_copia_encuesta
end type

type cb_1 from commandbutton within w_cursos_form_lista_copia_encuesta
integer x = 1088
integer y = 1036
integer width = 617
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar: Devolver Valor"
end type

event clicked;closewithreturn(parent,dw_lista.getitemstring(dw_lista.getselectedrow(0),'id_curso'))
end event

type cb_2 from commandbutton within w_cursos_form_lista_copia_encuesta
integer x = 1723
integer y = 1036
integer width = 617
integer height = 88
integer taborder = 40
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

