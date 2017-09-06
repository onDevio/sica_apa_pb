HA$PBExportHeader$w_siniestros_lista.srw
forward
global type w_siniestros_lista from w_lista
end type
type dw_siniestros_lista_clientes from u_dw within w_siniestros_lista
end type
type dw_siniestros_lista_colegiados from u_dw within w_siniestros_lista
end type
end forward

global type w_siniestros_lista from w_lista
integer width = 3721
integer height = 1264
string title = "Lista de Siniestros"
dw_siniestros_lista_clientes dw_siniestros_lista_clientes
dw_siniestros_lista_colegiados dw_siniestros_lista_colegiados
end type
global w_siniestros_lista w_siniestros_lista

on w_siniestros_lista.create
int iCurrent
call super::create
this.dw_siniestros_lista_clientes=create dw_siniestros_lista_clientes
this.dw_siniestros_lista_colegiados=create dw_siniestros_lista_colegiados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_siniestros_lista_clientes
this.Control[iCurrent+2]=this.dw_siniestros_lista_colegiados
end on

on w_siniestros_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_siniestros_lista_clientes)
destroy(this.dw_siniestros_lista_colegiados)
end on

event activate;call super::activate;//Asignamos las variables globales del modulo creado 
g_dw_lista  = dw_lista 
g_w_lista   = g_lista_siniestros
g_w_detalle = g_detalle_siniestros

g_lista     = 'w_siniestros_lista'
g_detalle   = 'w_siniestros_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_siniestros_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()

end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
//Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
//En este caso le pasamos el id_siniestro ( para la tabla fases_siniestro) a la variable global
g_siniestros_consulta.id_siniestro = dw_lista.getitemstring(dw_lista.getrow(),'fases_siniestros_id_siniestro')
//En este caso le pasamos el id_fase( para las tablas:fases,fases_colegiados y fases_clientes) a la variable global
//g_siniestros_consulta.id_fase=dw_lista.getitemstring(dw_lista.getrow(),'fases_id_fase')	
message.stringparm = "w_siniestros_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_siniestrosdetalle")

end event

event open;call super::open;//Permite redimensionar los datawindows
inv_resize.of_register (dw_siniestros_lista_clientes,"FixedtoBottom")
inv_resize.of_register (dw_siniestros_lista_colegiados,"FixedtoBottom")

end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear un nuevo siniestro
opensheet(g_detalle_siniestros, g_detalle, w_aplic_frame, 0, original!)
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados de los siniestros
open(w_siniestros_listados)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_siniestros = dw_lista
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_siniestros_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_siniestros_lista
end type

type st_1 from w_lista`st_1 within w_siniestros_lista
integer x = 41
integer y = 996
integer height = 64
end type

type dw_lista from w_lista`dw_lista within w_siniestros_lista
integer x = 37
integer y = 28
integer width = 3625
integer height = 584
integer taborder = 10
string dataobject = "d_siniestros_lista"
end type

event dw_lista::retrieveend;call super::retrieveend;// Forzamos a que se dispare el evento RowfocusChanged para que salgan las filas de 
// los datawindows asociados abajo.
this.PostEvent(Rowfocuschanged!)
end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;//Contamos el numero de columnas, si no hay no hace falta que retriveamos 
if this.rowcount() = 0 then return
//Hacemos el retriveo para sacar los colegiados y los clientes, pasandole el campo fases_id_fase
dw_siniestros_lista_clientes.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'fases_id_fase'))
dw_siniestros_lista_colegiados.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'fases_siniestros_id_siniestro'))

end event

type cb_consulta from w_lista`cb_consulta within w_siniestros_lista
integer taborder = 40
end type

type cb_detalle from w_lista`cb_detalle within w_siniestros_lista
integer taborder = 50
end type

type cb_ayuda from w_lista`cb_ayuda within w_siniestros_lista
integer taborder = 60
end type

type dw_siniestros_lista_clientes from u_dw within w_siniestros_lista
integer x = 37
integer y = 624
integer width = 1787
integer height = 348
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_siniestros_lista_clientes"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_siniestros_lista_colegiados from u_dw within w_siniestros_lista
integer x = 1829
integer y = 624
integer width = 1833
integer height = 348
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_siniestros_lista_visible_colegiados"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

