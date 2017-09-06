HA$PBExportHeader$w_ofertas_lista.srw
forward
global type w_ofertas_lista from w_lista
end type
end forward

global type w_ofertas_lista from w_lista
string title = "Lista de Ofertas"
end type
global w_ofertas_lista w_ofertas_lista

on w_ofertas_lista.create
call super::create
end on

on w_ofertas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_ofertas
g_w_detalle = g_detalle_ofertas

g_lista     = 'w_ofertas_lista'
g_detalle   = 'w_ofertas_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_ofertas_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
//Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
//En este caso le pasamos el id_oferta ( para la tabla bt_ofertas) a la variable global
g_ofertas_consulta.id_oferta = dw_lista.getitemstring(dw_lista.getrow(),'id_oferta')

//Abrimos la ventana de detalle pra 
message.stringparm = "w_ofertas_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_ofertasdetalle")
end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_ofertas, g_detalle, w_aplic_frame, 0, original!)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_ofertas = dw_lista
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados de las ofertas
open(w_ofertas_listados)
end event

type st_1 from w_lista`st_1 within w_ofertas_lista
end type

type dw_lista from w_lista`dw_lista within w_ofertas_lista
integer y = 0
string title = "Lista de Ofertas de Empleo"
string dataobject = "d_ofertas_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_ofertas_lista
end type

type cb_detalle from w_lista`cb_detalle within w_ofertas_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_ofertas_lista
end type

