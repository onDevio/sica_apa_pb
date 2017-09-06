HA$PBExportHeader$w_final_obra_lista.srw
forward
global type w_final_obra_lista from w_lista
end type
end forward

global type w_final_obra_lista from w_lista
string title = "Lista de Finales de Obra"
end type
global w_final_obra_lista w_final_obra_lista

on w_final_obra_lista.create
call super::create
end on

on w_final_obra_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//Asignamos cada variable global
g_dw_lista  = dw_lista
g_w_lista   = g_lista_final_obra
g_w_detalle = g_detalle_final_obra

g_lista     = 'w_final_obra_lista'
g_detalle   = 'w_final_obra_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_final_obra_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return

//Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
g_final_obra_consulta.id_fase = dw_lista.getitemstring(dw_lista.getrow(),'id_fase')
g_final_obra_consulta.id_fases_final = dw_lista.getitemstring(dw_lista.getrow(),'id_fases_final')

//Abrimos la ventana de detalle 
message.stringparm = "w_final_obra_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_final_obra_detalle")

end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados 
open(w_final_obra_listados)
end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear una nueva demanda
opensheet(g_detalle_final_obra, g_detalle, w_aplic_frame, 0, original!)

end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_final_obra= dw_lista

// Llamamos al control de eventos con el idw_lista
st_control_eventos c_evento
c_evento.evento = 'ABRIR_FINAL_OBRA'
c_evento.dw = dw_lista
if f_control_eventos(c_evento)=-1 then return
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_final_obra_lista
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_final_obra_lista
string tag = "texto=general.duardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_final_obra_lista
integer x = 37
end type

type dw_lista from w_lista`dw_lista within w_final_obra_lista
integer x = 37
integer y = 32
integer width = 3438
string title = "Lista de Finales de Obra"
string dataobject = "d_final_obra_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_final_obra_lista
string tag = "texto=general.consultar"
end type

type cb_detalle from w_lista`cb_detalle within w_final_obra_lista
string tag = "texto=general.detalle"
end type

type cb_ayuda from w_lista`cb_ayuda within w_final_obra_lista
string tag = "texto=general.ayuda"
end type

