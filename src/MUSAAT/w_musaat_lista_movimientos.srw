HA$PBExportHeader$w_musaat_lista_movimientos.srw
forward
global type w_musaat_lista_movimientos from w_lista
end type
type cb_ec from commandbutton within w_musaat_lista_movimientos
end type
type cb_est from commandbutton within w_musaat_lista_movimientos
end type
type cb_salir from commandbutton within w_musaat_lista_movimientos
end type
end forward

global type w_musaat_lista_movimientos from w_lista
integer height = 1372
string title = "Lista Previa de Movimientos de MUSAAT"
cb_ec cb_ec
cb_est cb_est
cb_salir cb_salir
end type
global w_musaat_lista_movimientos w_musaat_lista_movimientos

on w_musaat_lista_movimientos.create
int iCurrent
call super::create
this.cb_ec=create cb_ec
this.cb_est=create cb_est
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ec
this.Control[iCurrent+2]=this.cb_est
this.Control[iCurrent+3]=this.cb_salir
end on

on w_musaat_lista_movimientos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_ec)
destroy(this.cb_est)
destroy(this.cb_salir)
end on

event activate;call super::activate;g_dw_lista = dw_lista
g_w_lista = g_lista_movimientos_musaat
g_w_detalle = g_detalle_movimientos_musaat
g_lista = 'w_ musaat_lista_movimientos'
g_detalle = 'w_musaat_detalle_movimientos'

end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta:
open(w_musaat_consulta_movimientos)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_detalle;//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada:
g_musaat_movimientos_consulta.id_movimiento = dw_lista.GetItemString(dw_lista.GetRow(), 'id_movimiento')
Message.StringParm = "w_musaat_detalle_movimientos"
w_aplic_frame.Post Event csd_movimientos_musaat_detalle()
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_musaat_movimientos_listados)
end event

event csd_nuevo;call super::csd_nuevo;OpenSheet(g_detalle_movimientos_musaat, g_detalle,  w_aplic_frame, 0, original!)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global:
g_dw_lista_movimientos_musaat = dw_lista
end event

event open;call super::open;inv_resize.of_Register (cb_ec, "FixedtoBottom")
inv_resize.of_Register (cb_est, "FixedtoBottom")
inv_resize.of_Register (cb_salir, "FixedtoBottom")
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_musaat_lista_movimientos
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_musaat_lista_movimientos
string tag = "texto=general.guardar_pantalla"
end type

type st_1 from w_lista`st_1 within w_musaat_lista_movimientos
integer y = 1056
end type

event st_1::doubleclicked;call super::doubleclicked;long fila,fila_aviso
string id_fase
datetime f_visado
datastore ds_fases_minutas

// Creamos un datastore
ds_fases_minutas =create datastore
ds_fases_minutas.dataobject = 'd_fases_minutas'
ds_fases_minutas.settransobject(SQLCA)
ds_fases_minutas.setfilter("pendiente =N")
ds_fases_minutas.setsort("fecha_pago A")

for fila =1 to dw_lista.RowCount()
	yield()
	this.text = 'fila :'+string(fila)+'/'+string(dw_lista.RowCount())
	id_fase = dw_lista.getitemString(fila, 'id_fase')
	if ds_fases_minutas.retrieve(id_fase)>0 then
		f_visado = ds_fases_minutas.getitemDatetime(1,'fecha_pago')
		update fases set f_visado = :f_visado where id_fase = :id_fase and f_visado is null;
	end if 
next
commit;
destroy ds_fases_minutas
end event

type dw_lista from w_lista`dw_lista within w_musaat_lista_movimientos
integer x = 37
integer y = 32
integer width = 3442
string dataobject = "d_musaat_movimientos_lista"
boolean hscrollbar = true
end type

event dw_lista::doubleclicked;// Sobreescrito
CHOOSE CASE dwo.name
	CASE 'n_contrato'
		//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
		g_fases_consulta.id_fase = dw_lista.getitemstring(dw_lista.getrow(),'id_fase')
		g_fase_visared.opcion_importacion = 'N'
		message.stringparm = "w_fases_detalle"
		SetPointer(Hourglass!)
		w_aplic_frame.postevent("csd_fasesdetalle")
	CASE ELsE
		if rowcount() >0 then  Parent.TriggerEvent('csd_detalle')
END CHOOSE
end event

type cb_consulta from w_lista`cb_consulta within w_musaat_lista_movimientos
string tag = "texto=general.consultar"
end type

type cb_detalle from w_lista`cb_detalle within w_musaat_lista_movimientos
string tag = "texto=general.detalle"
end type

type cb_ayuda from w_lista`cb_ayuda within w_musaat_lista_movimientos
string tag = "texto=general.ayuda"
end type

type cb_ec from commandbutton within w_musaat_lista_movimientos
string tag = "texto=musaat.fichero_economico"
integer x = 1938
integer y = 1040
integer width = 462
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Fichero Econ$$HEX1$$f300$$ENDHEX$$mico"
end type

event clicked;open(w_musaat_fichero_eco)
end event

type cb_est from commandbutton within w_musaat_lista_movimientos
string tag = "texto=musaat.fichero_estadistico"
integer x = 2478
integer y = 1040
integer width = 462
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Fichero Estad$$HEX1$$ed00$$ENDHEX$$stico"
end type

event clicked;open(w_musaat_fichero_est)
end event

type cb_salir from commandbutton within w_musaat_lista_movimientos
string tag = "texto=general.salir"
integer x = 3017
integer y = 1040
integer width = 462
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;close(parent)
end event

