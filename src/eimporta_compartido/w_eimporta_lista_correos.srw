HA$PBExportHeader$w_eimporta_lista_correos.srw
forward
global type w_eimporta_lista_correos from w_response
end type
type dw_lista from u_dw within w_eimporta_lista_correos
end type
type st_1 from u_st within w_eimporta_lista_correos
end type
type cb_1 from u_cb within w_eimporta_lista_correos
end type
type cb_2 from u_cb within w_eimporta_lista_correos
end type
end forward

global type w_eimporta_lista_correos from w_response
integer width = 3575
integer height = 1436
string title = "Seleccione los correos a descargar"
dw_lista dw_lista
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_eimporta_lista_correos w_eimporta_lista_correos

type variables
st_correos_recibidos recibidos
end variables

event open;call super::open;int i, fila
int codigo
string nombre, correo, asunto

f_centrar_ventana(this)

recibidos = message.powerobjectparm

FOR i = 1 to UpperBound(recibidos.codigo[])
	codigo = recibidos.codigo[i]
	nombre = recibidos.nombre[i]
	correo = recibidos.correo[i]
	asunto = recibidos.asunto[i]
	fila = dw_lista.event pfc_addrow()
	dw_lista.setitem(fila,'codigo',codigo)
	dw_lista.setitem(fila,'nombre',nombre)
	dw_lista.setitem(fila,'correo',correo)
	dw_lista.setitem(fila,'asunto',asunto)
	dw_lista.setitem(fila,'descargar','S')
next

st_1.text = string(fila) + " correos nuevos"
end event

on w_eimporta_lista_correos.create
int iCurrent
call super::create
this.dw_lista=create dw_lista
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_eimporta_lista_correos.destroy
call super::destroy
destroy(this.dw_lista)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event close;closewithreturn(this,recibidos)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_eimporta_lista_correos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_eimporta_lista_correos
end type

type dw_lista from u_dw within w_eimporta_lista_correos
integer x = 37
integer y = 32
integer width = 3493
integer height = 1184
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_eimporta_lista_correos"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type st_1 from u_st within w_eimporta_lista_correos
integer x = 41
integer y = 1248
integer width = 480
boolean bringtotop = true
long textcolor = 16777215
long backcolor = 255
string text = ""
end type

type cb_1 from u_cb within w_eimporta_lista_correos
integer x = 2811
integer y = 1232
integer taborder = 11
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;int i
string descargar

FOR i = 1 to dw_lista.rowcount()
	descargar = dw_lista.getitemstring(i,'descargar')
	recibidos.descargar[i] = descargar
next

close(parent)
end event

type cb_2 from u_cb within w_eimporta_lista_correos
integer x = 3177
integer y = 1232
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;recibidos.codigo[1] = -1
close(parent)
end event

