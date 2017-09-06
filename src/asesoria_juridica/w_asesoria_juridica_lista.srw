HA$PBExportHeader$w_asesoria_juridica_lista.srw
forward
global type w_asesoria_juridica_lista from w_lista
end type
end forward

global type w_asesoria_juridica_lista from w_lista
string tag = "Lista de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
integer width = 3543
integer height = 1332
string title = "Lista de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
end type
global w_asesoria_juridica_lista w_asesoria_juridica_lista

on w_asesoria_juridica_lista.create
call super::create
end on

on w_asesoria_juridica_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_as_juridica
g_w_detalle = g_detalle_as_juridica

g_lista     = 'w_asesoria_juridica_lista'
g_detalle   = 'w_asesoria_juridica_detalle'
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_as_juridica= dw_lista
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_asesoria_juridica_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_as_juridica, g_detalle, w_aplic_frame, 0, original!)

end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
///Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
g_as_juridica_consulta.id_asesoria = dw_lista.getitemstring(dw_lista.getrow(),'id_asesoria')

//Abrimos la ventana de detalle 
message.stringparm = "w_asesoria_juridica_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_as_juridica_detalle")

end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados 
open(w_asesoria_juridica_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_asesoria_juridica_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_asesoria_juridica_lista
end type

type st_1 from w_lista`st_1 within w_asesoria_juridica_lista
integer x = 37
integer y = 1024
end type

type dw_lista from w_lista`dw_lista within w_asesoria_juridica_lista
integer x = 37
integer y = 32
integer width = 3429
integer height = 972
string title = "Lista de Asesor$$HEX1$$ed00$$ENDHEX$$a Jur$$HEX1$$ed00$$ENDHEX$$dica"
string dataobject = "d_asesoria_juridica_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_asesoria_juridica_lista
end type

type cb_detalle from w_lista`cb_detalle within w_asesoria_juridica_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_asesoria_juridica_lista
end type

