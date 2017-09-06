HA$PBExportHeader$w_ctrlasistencia_anyadir_asistente.srw
forward
global type w_ctrlasistencia_anyadir_asistente from w_response
end type
type dw_1 from u_dw within w_ctrlasistencia_anyadir_asistente
end type
type cb_aceptar from commandbutton within w_ctrlasistencia_anyadir_asistente
end type
end forward

global type w_ctrlasistencia_anyadir_asistente from w_response
integer width = 2135
integer height = 720
string title = "Seleccione los asistentes a a$$HEX1$$f100$$ENDHEX$$adir"
dw_1 dw_1
cb_aceptar cb_aceptar
end type
global w_ctrlasistencia_anyadir_asistente w_ctrlasistencia_anyadir_asistente

type variables
string is_id_asistencia_fecha
end variables

on w_ctrlasistencia_anyadir_asistente.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_aceptar=create cb_aceptar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_aceptar
end on

on w_ctrlasistencia_anyadir_asistente.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_aceptar)
end on

event open;call super::open;
is_id_asistencia_fecha=Message.stringparm

dw_1.settransobject(sqlca)
dw_1.retrieve(is_id_asistencia_fecha)
end event

event close;call super::close;
cb_aceptar.event clicked()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_ctrlasistencia_anyadir_asistente
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_ctrlasistencia_anyadir_asistente
end type

type dw_1 from u_dw within w_ctrlasistencia_anyadir_asistente
integer x = 41
integer y = 32
integer width = 2043
integer height = 448
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ctrlasistencia_anyadir_asistente"
end type

event clicked;call super::clicked;//this.selectRow(0,false)
//this.selectRow(row,true)
end event

event retrieveend;call super::retrieveend;if rowcount=0 then 
	Messagebox(g_titulo,'Todos los asistentes al curso ya est$$HEX1$$e100$$ENDHEX$$n en esta lista de asistencia')
	close(parent)
end if 
end event

event doubleclicked;call super::doubleclicked;setrow(row)
cb_aceptar.event clicked()
end event

event constructor;call super::constructor;of_setrowselect(true)
inv_rowselect.of_setstyle(inv_rowselect.multiple)
end event

type cb_aceptar from commandbutton within w_ctrlasistencia_anyadir_asistente
integer x = 1710
integer y = 504
integer width = 375
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;string ls_id_asistente[]
long i=1,siguiente
st_anyadir_asistente lst_resultado

//Buscamos a partir de la primera fila del dw
siguiente=0

if dw_1.rowcount()>0 then

	do 
		siguiente=dw_1.getselectedrow(siguiente)
		if siguiente=0 then exit
		ls_id_asistente[i]=dw_1.getitemstring(siguiente,'id_asistente')
		i++
	loop while siguiente<>0
  
end if

lst_resultado.asistentes=ls_id_asistente

closewithreturn(parent,lst_resultado)
end event

