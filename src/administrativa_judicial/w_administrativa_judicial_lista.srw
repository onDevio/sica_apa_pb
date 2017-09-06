HA$PBExportHeader$w_administrativa_judicial_lista.srw
forward
global type w_administrativa_judicial_lista from w_lista
end type
type dw_administrativa_judicial_lista_cliente from u_dw within w_administrativa_judicial_lista
end type
type dw_administrativa_judicial_lista_cole from u_dw within w_administrativa_judicial_lista
end type
end forward

global type w_administrativa_judicial_lista from w_lista
string tag = "Lista de Adiministrativa y Judicial"
integer width = 3671
integer height = 1780
string title = "Lista de Adiministrativa y Judicial"
dw_administrativa_judicial_lista_cliente dw_administrativa_judicial_lista_cliente
dw_administrativa_judicial_lista_cole dw_administrativa_judicial_lista_cole
end type
global w_administrativa_judicial_lista w_administrativa_judicial_lista

on w_administrativa_judicial_lista.create
int iCurrent
call super::create
this.dw_administrativa_judicial_lista_cliente=create dw_administrativa_judicial_lista_cliente
this.dw_administrativa_judicial_lista_cole=create dw_administrativa_judicial_lista_cole
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_administrativa_judicial_lista_cliente
this.Control[iCurrent+2]=this.dw_administrativa_judicial_lista_cole
end on

on w_administrativa_judicial_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_administrativa_judicial_lista_cliente)
destroy(this.dw_administrativa_judicial_lista_cole)
end on

event activate;call super::activate;//Asignamos las variables globales del modulo creado 
g_dw_lista  = dw_lista 
g_w_lista   = g_lista_ad_judicial
g_w_detalle = g_detalle_ad_judicial

g_lista     = 'w_administrativa_judicial_lista'
g_detalle   = 'w_administrativa_judicial_detalle'
end event

event open;call super::open;//Permite redimensionar los datawindows
inv_resize.of_register (dw_administrativa_judicial_lista_cliente,"FixedtoBottom")
inv_resize.of_register (dw_administrativa_judicial_lista_cole,"FixedtoBottom")

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_administrativa_judicial_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()

end event

event csd_detalle();call super::csd_detalle;//Si no hay lineas en la lista salimos del evento
if dw_lista.getrow() < 1 then return
//Rellenamos la estructura con los id's que necesitamos para extraer los datos en la ventana de detalle
//En este caso le pasamos el id_administracion( para la tabla fases_administrativa_judicial) a la variable global
g_ad_judicial_consulta.id_administracion= dw_lista.getitemstring(dw_lista.getrow(),'id_administracion')
//En este caso le pasamos el id_fase( para las tablas:fases,fases_colegiados y fases_clientes) a la variable global
g_ad_judicial_consulta.id_fase=dw_lista.getitemstring(dw_lista.getrow(),'id_fase')	
message.stringparm = "w_administrativa_judicial_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_ad_judicial_detalle")

end event

event csd_nuevo();call super::csd_nuevo;//Abrimos la ventana de detalle para crear un nuevo siniestro
opensheet(g_detalle_ad_judicial, g_detalle, w_aplic_frame, 0, original!)
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_ad_judicial = dw_lista
end event

event csd_listados();call super::csd_listados;//Llamamos a la ventana de listados de los siniestros
open(w_administrativa_judicial_listados)
end event

type st_1 from w_lista`st_1 within w_administrativa_judicial_lista
integer x = 41
integer y = 1500
end type

type dw_lista from w_lista`dw_lista within w_administrativa_judicial_lista
integer x = 27
integer width = 3584
integer height = 864
integer taborder = 10
string dataobject = "d_administrativa_judicial_lista"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_lista::retrieveend;call super::retrieveend;// Forzamos a que se dispare el evento RowfocusChanged para que salgan las filas de 
// los datawindows asociados abajo.
this.PostEvent(Rowfocuschanged!)
end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;//Contamos el numero de columnas, si no hay no hace falta que retriveamos 
if this.rowcount() = 0 then return
//Hacemos el retriveo para sacar los colegiados y los clientes, pasandole el campo fases_id_fase
dw_administrativa_judicial_lista_cliente.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))
dw_administrativa_judicial_lista_cole.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_administracion'))

end event

type cb_consulta from w_lista`cb_consulta within w_administrativa_judicial_lista
integer taborder = 40
end type

type cb_detalle from w_lista`cb_detalle within w_administrativa_judicial_lista
integer taborder = 50
end type

type cb_ayuda from w_lista`cb_ayuda within w_administrativa_judicial_lista
integer taborder = 60
end type

type dw_administrativa_judicial_lista_cliente from u_dw within w_administrativa_judicial_lista
integer x = 23
integer y = 920
integer width = 1810
integer height = 556
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_administrativa_judicial_lista_clientes"
end type

type dw_administrativa_judicial_lista_cole from u_dw within w_administrativa_judicial_lista
integer x = 1861
integer y = 920
integer width = 1746
integer height = 556
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_administrativa_judicial_lista_cole"
end type

