HA$PBExportHeader$w_expedientes_lista.srw
forward
global type w_expedientes_lista from w_lista
end type
end forward

global type w_expedientes_lista from w_lista
string title = "Lista Previa de Expedientes"
end type
global w_expedientes_lista w_expedientes_lista

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_expedientes
g_w_detalle = g_detalle_expedientes
g_lista     = 'w_expedientes_lista'
g_detalle   = 'w_expedientes_detalle'
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_expedientes_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()

end event

on w_expedientes_lista.create
call super::create
end on

on w_expedientes_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
SetPointer(HourGlass!)
g_expedientes_consulta.id_expediente = dw_lista.getitemstring(dw_lista.getrow(),'id_expedi')
message.stringparm = "w_expedientes_detalle"
w_aplic_frame.postevent("csd_expedientesdetalle")

end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_expedientes_listados)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_expedientes = dw_lista
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_expedientes, g_detalle, w_aplic_frame, 0, original!)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_expedientes_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_expedientes_lista
end type

type st_1 from w_lista`st_1 within w_expedientes_lista
end type

type dw_lista from w_lista`dw_lista within w_expedientes_lista
string dataobject = "d_expedientes_lista"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;SetPointer(Arrow!)
end event

type cb_consulta from w_lista`cb_consulta within w_expedientes_lista
end type

type cb_detalle from w_lista`cb_detalle within w_expedientes_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_expedientes_lista
end type

