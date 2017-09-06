HA$PBExportHeader$w_demandas_lista.srw
forward
global type w_demandas_lista from w_lista
end type
end forward

global type w_demandas_lista from w_lista
string tag = "Lista de Demandas"
string title = "Lista de Demandas"
end type
global w_demandas_lista w_demandas_lista

on w_demandas_lista.create
call super::create
end on

on w_demandas_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_demandas
g_w_detalle = g_detalle_demandas

g_lista     = 'w_demandas_lista'
g_detalle   = 'w_demandas_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_demandas_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
//Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
//En este caso le pasamos el id_col ( para la tabla bt_demandas) a la variable instancia
g_demandas_consulta.id_col = dw_lista.getitemstring(dw_lista.getrow(),'id_col')

message.stringparm = "w_demandas_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_demandasdetalle")

end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_demandas, g_detalle, w_aplic_frame, 0, original!)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_demandas= dw_lista
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados de los siniestros
open(w_demandas_listados)
end event

type st_1 from w_lista`st_1 within w_demandas_lista
end type

type dw_lista from w_lista`dw_lista within w_demandas_lista
string title = "Lista de Demandas"
string dataobject = "d_demandas_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_demandas_lista
end type

type cb_detalle from w_lista`cb_detalle within w_demandas_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_demandas_lista
end type

