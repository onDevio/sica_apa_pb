HA$PBExportHeader$w_musaat_lista.srw
forward
global type w_musaat_lista from w_lista
end type
end forward

global type w_musaat_lista from w_lista
integer width = 4201
integer height = 1396
string title = "Lista Previa de Seguros"
end type
global w_musaat_lista w_musaat_lista

type variables

end variables

on w_musaat_lista.create
call super::create
end on

on w_musaat_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista = dw_lista
g_w_lista = g_lista_musaat
g_w_detalle = g_detalle_musaat
g_lista = 'w_ musaat_lista'
g_detalle = 'w_musaat_detalle'

end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta:
open(w_musaat_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada:
g_musaat_consulta.id_musaat = dw_lista.GetItemString(dw_lista.GetRow(), 'id_musaat')
Message.StringParm = "w_musaat_detalle"
w_aplic_frame.Post Event csd_musaat_detalle()
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_musaat_listados)
end event

event csd_nuevo;call super::csd_nuevo;OpenSheet(g_detalle_musaat, g_detalle,  w_aplic_frame, 0, original!)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global:
g_dw_lista_musaat = dw_lista
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_musaat_lista
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_musaat_lista
string tag = "texto=general.guardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_musaat_lista
integer x = 37
integer y = 1140
end type

type dw_lista from w_lista`dw_lista within w_musaat_lista
integer x = 37
integer y = 32
integer width = 4101
integer height = 1096
integer taborder = 50
string dataobject = "d_musaat_lista"
boolean hscrollbar = true
end type

type cb_consulta from w_lista`cb_consulta within w_musaat_lista
string tag = "texto=general.consultar"
end type

type cb_detalle from w_lista`cb_detalle within w_musaat_lista
string tag = "texto=general.detalle"
integer taborder = 30
end type

type cb_ayuda from w_lista`cb_ayuda within w_musaat_lista
string tag = "texto=general.ayuda"
integer taborder = 40
end type

