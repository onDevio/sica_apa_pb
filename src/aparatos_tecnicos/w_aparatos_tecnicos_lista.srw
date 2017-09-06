HA$PBExportHeader$w_aparatos_tecnicos_lista.srw
forward
global type w_aparatos_tecnicos_lista from w_lista
end type
end forward

global type w_aparatos_tecnicos_lista from w_lista
integer width = 3634
integer height = 1308
string title = "Lista Previa de Aparatos T$$HEX1$$e900$$ENDHEX$$cnicos"
end type
global w_aparatos_tecnicos_lista w_aparatos_tecnicos_lista

type variables

end variables

on w_aparatos_tecnicos_lista.create
call super::create
end on

on w_aparatos_tecnicos_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_aparatos_tecnicos
g_w_detalle = g_detalle_aparatos_tecnicos
g_lista     = 'w_aparatos_tecnicos_lista'
g_detalle   = 'w_aparatos_tecnicos_detalle'
end event

event csd_consulta();call super::csd_consulta;open(w_aparatos_tecnicos_consulta)
if message.doubleparm=-1 then return
dw_lista.event csd_retrieve()



end event

event csd_detalle();call super::csd_detalle;if dw_lista.getrow() < 1 then return
g_aparatos_tecnicos_consulta.id_aparato=dw_lista.GetItemString(dw_lista.GetRow(),'id_aparato')
Message.StringParm="w_aparatos_tecnicos_detalle"
w_aplic_frame.PostEvent("csd_aparatos_tecnicosdetalle")
end event

event pfc_postopen();call super::pfc_postopen;g_dw_lista_aparatos_tecnicos=dw_lista
end event

event csd_nuevo();call super::csd_nuevo;OpenSheet(g_detalle_aparatos_tecnicos,g_detalle,w_aplic_frame,0,original!)
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana listados
open(w_aparatos_tecnicos_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_aparatos_tecnicos_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_aparatos_tecnicos_lista
end type

type st_1 from w_lista`st_1 within w_aparatos_tecnicos_lista
integer x = 37
end type

type dw_lista from w_lista`dw_lista within w_aparatos_tecnicos_lista
integer x = 37
integer y = 32
integer width = 3515
string dataobject = "d_aparatos_tecnicos_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_aparatos_tecnicos_lista
end type

type cb_detalle from w_lista`cb_detalle within w_aparatos_tecnicos_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_aparatos_tecnicos_lista
end type

