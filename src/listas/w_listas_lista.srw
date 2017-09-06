HA$PBExportHeader$w_listas_lista.srw
forward
global type w_listas_lista from w_lista
end type
end forward

global type w_listas_lista from w_lista
integer width = 2341
string title = "Lista Previa de Listas"
end type
global w_listas_lista w_listas_lista

on w_listas_lista.create
call super::create
end on

on w_listas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_listas
g_w_detalle = g_detalle_listas
g_lista     = 'w_listas_lista'
g_detalle   = 'w_listas_detalle'
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_listas_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_listas = dw_lista
end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_listas_consulta.id_lista = dw_lista.getitemstring(dw_lista.getrow(),'id_lista')
message.stringparm = "w_listas_detalle"
w_aplic_frame.postevent("csd_listas_detalle")

end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_listas, g_detalle, w_aplic_frame, 0, original!)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_listas_lista
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_listas_lista
string tag = "texto=general.guardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_listas_lista
end type

type dw_lista from w_lista`dw_lista within w_listas_lista
integer width = 2226
string dataobject = "d_listas_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_listas_lista
string tag = "texto=general.consultar"
end type

type cb_detalle from w_lista`cb_detalle within w_listas_lista
string tag = "texto=general.detalle"
end type

type cb_ayuda from w_lista`cb_ayuda within w_listas_lista
string tag = "texto=general.ayuda"
end type

