HA$PBExportHeader$w_registros_lista.srw
forward
global type w_registros_lista from w_lista
end type
type cb_certificados from commandbutton within w_registros_lista
end type
end forward

global type w_registros_lista from w_lista
string title = "Lista Previa de Registros"
cb_certificados cb_certificados
end type
global w_registros_lista w_registros_lista

on w_registros_lista.create
int iCurrent
call super::create
this.cb_certificados=create cb_certificados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_certificados
end on

on w_registros_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_certificados)
end on

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_registros_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()

end event

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_registros
g_w_detalle = g_detalle_registros
g_lista     = 'w_registros_lista'
g_detalle   = 'w_registros_detalle'

dw_lista.SetRedraw(true)
end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_registros_consulta.id_registro = dw_lista.getitemstring(dw_lista.getrow(),'id_registro')

dw_lista.SetRedraw(false)

message.stringparm = "w_registros_detalle"
w_aplic_frame.postevent("csd_registrosdetalle")


end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_registros = dw_lista
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_registros, g_detalle, w_aplic_frame, 0, original!)
end event

event csd_listados;call super::csd_listados;// Se llama a la ventana de listados
open(w_registros_listados)
end event

event open;call super::open;inv_resize.of_Register (cb_certificados, "FixedtoBottom")

if g_colegio='COAATMCA' then 
	cb_certificados.visible=true
else
	cb_certificados.visible=false
end if
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_registros_lista
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_registros_lista
string tag = "texto=general.guardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_registros_lista
end type

type dw_lista from w_lista`dw_lista within w_registros_lista
integer width = 3465
integer height = 936
string dataobject = "d_registros_lista"
boolean hscrollbar = true
end type

type cb_consulta from w_lista`cb_consulta within w_registros_lista
string tag = "texto=general.consultar"
integer x = 530
integer y = 608
end type

type cb_detalle from w_lista`cb_detalle within w_registros_lista
string tag = "texto=general.detalle"
integer x = 1079
integer y = 608
end type

type cb_ayuda from w_lista`cb_ayuda within w_registros_lista
string tag = "texto=general.ayuda"
end type

type cb_certificados from commandbutton within w_registros_lista
integer x = 599
integer y = 996
integer width = 448
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Certificados"
end type

event clicked;string id_reg

open(w_reg_es_emision_certificados)

id_reg=Message.StringParm

if not(f_es_vacio(id_reg)) then
	//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
	g_registros_consulta.id_registro = id_reg

	message.stringparm = "w_registros_detalle"
	w_aplic_frame.postevent("csd_registrosdetalle")
end if
end event

