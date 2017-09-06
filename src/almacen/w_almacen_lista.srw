HA$PBExportHeader$w_almacen_lista.srw
forward
global type w_almacen_lista from w_lista
end type
end forward

global type w_almacen_lista from w_lista
integer width = 3497
integer height = 1352
string title = "Lista de Almac$$HEX1$$e900$$ENDHEX$$n"
end type
global w_almacen_lista w_almacen_lista

on w_almacen_lista.create
call super::create
end on

on w_almacen_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_almacen
g_w_detalle = g_detalle_almacen

g_lista     = 'w_almacen_lista'
g_detalle   = 'w_almacen_detalle'
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_almacen= dw_lista
end event

event csd_nuevo;call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_almacen, g_detalle, w_aplic_frame, 0, original!)
end event

event csd_detalle;call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
///Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
g_almacen_consulta = dw_lista.getitemstring(dw_lista.getrow(),'id_almacen')
//
//Abrimos la ventana de detalle 
message.stringparm = "w_almacen_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_almacendetalle")
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_almacen_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados 
open(w_almacen_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_almacen_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_almacen_lista
end type

type st_1 from w_lista`st_1 within w_almacen_lista
integer x = 37
integer y = 1032
end type

type dw_lista from w_lista`dw_lista within w_almacen_lista
integer x = 37
integer y = 32
integer width = 3360
string dataobject = "d_almacen_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_almacen_lista
end type

type cb_detalle from w_lista`cb_detalle within w_almacen_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_almacen_lista
end type

