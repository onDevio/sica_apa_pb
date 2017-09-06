HA$PBExportHeader$w_garantias_lista.srw
forward
global type w_garantias_lista from w_lista
end type
type dw_1 from u_dw within w_garantias_lista
end type
end forward

global type w_garantias_lista from w_lista
integer width = 3794
integer height = 1280
string title = "Lista de Garant$$HEX1$$ed00$$ENDHEX$$as/Fondos"
string menuname = "m_garantias_lista"
event csd_devolucion ( )
dw_1 dw_1
end type
global w_garantias_lista w_garantias_lista

type variables

end variables

event csd_devolucion();// Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return

// Si hay fecha salida o destinatario, ya se ha generado la liquidaci$$HEX1$$f300$$ENDHEX$$n
datetime fecha_salida
string desti
fecha_salida = dw_lista.GetItemDateTime(dw_lista.GetRow(),'f_out')
//desti = dw_lista.GetItemstring(dw_lista.GetRow(),'destinatario')
If not f_es_vacio(string(fecha_salida)) then // or not f_es_vacio(desti) then
	Messagebox(g_titulo,'Ya ha sido generada la liquidaci$$HEX1$$f300$$ENDHEX$$n correspondiente',Exclamation!)
	return
end if

// Rellenamos la estructura con los id's que necesitamos para extraer los datos necesarios para la ventana de devolucion
g_garantias_consulta.id_fase			= dw_lista.getitemstring(dw_lista.getrow(),'id_fase')
g_garantias_consulta.id_colegiado	= dw_lista.getitemstring(dw_lista.getrow(),'id_colegiado')
g_garantias_consulta.id_cliente		= dw_lista.getitemstring(dw_lista.getrow(),'id_cliente')	
g_garantias_consulta.importe			= dw_lista.getitemnumber(dw_lista.getrow(),'fases_garantias_importe')

open(w_garantias_devolucion)

string dest
dest = message.stringparm
if dest <> '-1' then
	dw_lista.setitem(dw_lista.getrow(),'f_out',datetime(today()))
	dw_lista.setitem(dw_lista.getrow(),'destinatario',dest)
	dw_lista.update()
end if

end event

on w_garantias_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_garantias_lista" then this.MenuID = create m_garantias_lista
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_garantias_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event activate;call super::activate;//Asignamos las variables globales del modulo creado 
g_dw_lista  = dw_lista 
g_w_lista   = g_lista_garantias
g_w_detalle = g_detalle_garantias
g_lista     = 'w_garantias_lista'
g_detalle   = 'w_garantias_detalle'

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_garantias_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados 
open(w_garantias_listados)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_garantias= dw_lista
end event

event type integer pfc_preupdate();call super::pfc_preupdate;if f_puedo_escribir(g_usuario,'0000000007')=-1 then return -1
return 1

end event

event csd_nuevo();// MODIFICADO RICARDO 04-06-10
// EVENTO SOBREESCRITO PARA QUE NO MODIFIQUE LA VAR GLOBAL GB_NUEVO Y PRODUZCA EFECTOS RAROS
// FIN MODIFICADO RICARDO 04-06-10

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_garantias_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_garantias_lista
end type

type st_1 from w_lista`st_1 within w_garantias_lista
integer y = 1024
end type

type dw_lista from w_lista`dw_lista within w_garantias_lista
integer x = 27
integer y = 32
integer width = 3675
integer height = 964
string dataobject = "d_garantias_lista"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cb_consulta from w_lista`cb_consulta within w_garantias_lista
end type

type cb_detalle from w_lista`cb_detalle within w_garantias_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_garantias_lista
end type

type dw_1 from u_dw within w_garantias_lista
boolean visible = false
integer x = 23
integer y = 1108
integer width = 3104
integer height = 324
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

