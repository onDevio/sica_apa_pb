HA$PBExportHeader$w_usuarios_lista.srw
forward
global type w_usuarios_lista from w_lista
end type
end forward

global type w_usuarios_lista from w_lista
integer height = 1308
boolean controlmenu = false
end type
global w_usuarios_lista w_usuarios_lista

on w_usuarios_lista.create
call super::create
end on

on w_usuarios_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//g_dw_lista = g_dw_lista_usuarios
g_dw_lista= dw_lista
g_w_lista = g_lista_usuarios
g_w_detalle = g_detalle_usuarios
g_lista = 'w_usuarios_lista'
g_detalle = 'w_usuarios_detalle'
end event

event csd_detalle();call super::csd_detalle;if dw_lista.getrow() < 1 then return
g_usuarios_consulta.cod_usuario = dw_lista.GetItemString(dw_lista.GetRow(),'cod_usuario')
Message.StringParm = 'w_usuarios_detalle'
w_aplic_frame.PostEvent('csd_usuariosdetalle')
end event

event pfc_postopen;call super::pfc_postopen;g_dw_lista_usuarios = dw_lista

end event

event csd_nuevo;call super::csd_nuevo;Opensheet(g_detalle_usuarios,g_detalle,w_aplic_frame,0,original!)
end event

event csd_listados();call super::csd_listados;open(w_usuarios_listados)
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_usuarios_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()


end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_usuarios_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_usuarios_lista
end type

type st_1 from w_lista`st_1 within w_usuarios_lista
integer x = 37
end type

type dw_lista from w_lista`dw_lista within w_usuarios_lista
integer x = 37
integer y = 32
string dataobject = "d_usuario"
end type

type cb_consulta from w_lista`cb_consulta within w_usuarios_lista
end type

type cb_detalle from w_lista`cb_detalle within w_usuarios_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_usuarios_lista
end type

