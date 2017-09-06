HA$PBExportHeader$w_premaat_lista.srw
forward
global type w_premaat_lista from w_lista
end type
type dw_cuotas from u_dw within w_premaat_lista
end type
type dw_prestaciones from u_dw within w_premaat_lista
end type
end forward

global type w_premaat_lista from w_lista
integer width = 3712
integer height = 1756
string title = "Lista Previa de Mutua"
dw_cuotas dw_cuotas
dw_prestaciones dw_prestaciones
end type
global w_premaat_lista w_premaat_lista

on w_premaat_lista.create
int iCurrent
call super::create
this.dw_cuotas=create dw_cuotas
this.dw_prestaciones=create dw_prestaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cuotas
this.Control[iCurrent+2]=this.dw_prestaciones
end on

on w_premaat_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cuotas)
destroy(this.dw_prestaciones)
end on

event activate;call super::activate;g_dw_lista = dw_lista
g_w_lista = g_lista_premaat
g_w_detalle = g_detalle_premaat
g_lista = 'w_ premaat_lista'
g_detalle = 'w_premaat_detalle'

end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta:
open(w_premaat_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada:
if dw_lista.RowCount()>0 then 
	g_premaat_consulta.id_premaat = dw_lista.GetItemString(dw_lista.GetRow(), 'id_premaat')
	Message.StringParm = "w_premaat_detalle"
	w_aplic_frame.Post Event csd_premaat_detalle()
end if
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_premaat_listados)
end event

event csd_nuevo;call super::csd_nuevo;OpenSheet(g_detalle_premaat, g_detalle,  w_aplic_frame, 0, original!)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global:
g_dw_lista_premaat = dw_lista
end event

event open;call super::open;inv_resize.of_Register (dw_cuotas, "FixedtoBottom&ScaletoRight")
inv_resize.of_Register (dw_prestaciones, "FixedtoRight&Bottom")


end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_premaat_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_premaat_lista
end type

type st_1 from w_lista`st_1 within w_premaat_lista
integer x = 37
integer y = 1504
end type

type dw_lista from w_lista`dw_lista within w_premaat_lista
integer x = 37
integer y = 32
integer width = 3607
integer height = 1080
string dataobject = "d_premaat_lista"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_lista::rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
dw_cuotas.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_col'))
dw_prestaciones.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_premaat'))
end event

event dw_lista::retrievestart;call super::retrievestart;// MODIFICADO RICARDO 03-11-07
dw_cuotas.reset()
dw_prestaciones.reset()
// FIN MODIFICADO RICARDO 03-11-07
end event

type cb_consulta from w_lista`cb_consulta within w_premaat_lista
integer y = 1448
end type

type cb_detalle from w_lista`cb_detalle within w_premaat_lista
integer y = 1448
end type

type cb_ayuda from w_lista`cb_ayuda within w_premaat_lista
integer y = 1448
end type

type dw_cuotas from u_dw within w_premaat_lista
integer x = 37
integer y = 1116
integer width = 951
integer height = 376
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_premaat_lista_conceptos_domiciliables"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_prestaciones from u_dw within w_premaat_lista
integer x = 997
integer y = 1116
integer width = 2647
integer height = 376
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_premaat_lista_prestaciones"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

