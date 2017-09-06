HA$PBExportHeader$w_jg_reuniones_lista.srw
forward
global type w_jg_reuniones_lista from w_lista
end type
end forward

global type w_jg_reuniones_lista from w_lista
string title = "Lista de Juntas de Gobierno"
end type
global w_jg_reuniones_lista w_jg_reuniones_lista

on w_jg_reuniones_lista.create
call super::create
end on

on w_jg_reuniones_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_jgreuniones
g_w_detalle = g_detalle_jgreuniones

g_lista     = 'w_jg_reuniones_lista'
g_detalle   = 'w_jg_reuniones_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_jg_reuniones_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
///Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
g_jgreuniones_consulta.id_reunion = dw_lista.getitemstring(dw_lista.getrow(),'id_reunion')

//Abrimos la ventana de detalle 
message.stringparm = "w_jg_reuniones_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_jg_reunionesdetalle")

end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_jgreuniones, g_detalle, w_aplic_frame, 0, original!)

end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_jgreuniones = dw_lista
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados 
open(w_jg_reuniones_listados)
end event

type st_1 from w_lista`st_1 within w_jg_reuniones_lista
end type

type dw_lista from w_lista`dw_lista within w_jg_reuniones_lista
string dataobject = "d_jg_reuniones_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_jg_reuniones_lista
end type

type cb_detalle from w_lista`cb_detalle within w_jg_reuniones_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_jg_reuniones_lista
end type

