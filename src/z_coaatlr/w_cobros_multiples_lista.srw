HA$PBExportHeader$w_cobros_multiples_lista.srw
forward
global type w_cobros_multiples_lista from w_lista
end type
type dw_cobros from u_dw within w_cobros_multiples_lista
end type
type cb_anyadir_cobro from commandbutton within w_cobros_multiples_lista
end type
type dw_apuntes from u_dw within w_cobros_multiples_lista
end type
end forward

global type w_cobros_multiples_lista from w_lista
integer width = 3849
integer height = 1956
string title = "Lista Cobros M$$HEX1$$fa00$$ENDHEX$$ltiples"
string menuname = "m_cobros_multiples_lista"
dw_cobros dw_cobros
cb_anyadir_cobro cb_anyadir_cobro
dw_apuntes dw_apuntes
end type
global w_cobros_multiples_lista w_cobros_multiples_lista

on w_cobros_multiples_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cobros_multiples_lista" then this.MenuID = create m_cobros_multiples_lista
this.dw_cobros=create dw_cobros
this.cb_anyadir_cobro=create cb_anyadir_cobro
this.dw_apuntes=create dw_apuntes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cobros
this.Control[iCurrent+2]=this.cb_anyadir_cobro
this.Control[iCurrent+3]=this.dw_apuntes
end on

on w_cobros_multiples_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_cobros)
destroy(this.cb_anyadir_cobro)
destroy(this.dw_apuntes)
end on

event activate;call super::activate;g_dw_lista  = dw_lista 
g_w_lista   = g_lista_cobros_multiples
//g_w_detalle = g_detalle_fases
g_lista     = 'w_cobros_multiples_lista'
//g_detalle   = 'w_fases_detalle'
end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_cobros_multiples_consulta)
if Message.DoubleParm = -1 then return
//messagebox(g_titulo,string(Message.DoubleParm))
dw_lista.Event csd_retrieve()

end event

event open;call super::open;// hacemos que el de cobros est$$HEX2$$e9002000$$ENDHEX$$fijo abajo
inv_resize.of_register (dw_cobros,"FixedtoBottom&ScaleToRight")
inv_resize.of_register (cb_anyadir_cobro,"FixedtoRight&Bottom")
inv_resize.of_register (dw_apuntes,"FixedtoBottom&ScaleToRight")
end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_cobros_multiples = dw_lista
end event

event type integer pfc_preupdate();call super::pfc_preupdate;long fila
string forma_pago, banco, id_cobro_multiple, id_pago
string mensaje = ''

// Si no hay permiso salimos
if f_puedo_escribir(g_usuario,'0000000036')<>1 then return -1

// VAlidamos las cosas de la parte superior
FOR fila = 1 TO dw_cobros.RowCount()
	// Comrpobamos que todo est$$HEX2$$e9002000$$ENDHEX$$correcto
	id_cobro_multiple = dw_cobros.getitemstring(fila, 'id_cobro_multiple')
	forma_pago = dw_cobros.getitemstring(fila, 'csi_cobros_forma_pago')
	banco = dw_cobros.getitemstring(fila, 'csi_cobros_banco')
	if not f_es_vacio(id_cobro_multiple) then
		// Obligamos a que la forma de pago sea 'CM'
		if f_es_vacio(forma_pago) then 
			mensaje += "La forma de pago de un cobro asociado a un cobro multiple debe ser Cobro Multiple (CM) ( fila "+string(fila)+")"+cr
		elseif forma_pago <> 'CM' then
			mensaje += "La forma de pago de un cobro asociado a un cobro multiple debe ser Cobro Multiple (CM) ( fila "+string(fila)+")"+cr
		end if
		// VAildamos el banco
		if f_es_vacio(banco) then
			mensaje += "Debe indicar un banco ( fila "+string(fila)+")"+cr
		end if
	end if
NEXT
if mensaje<>'' then
	MessageBox(g_titulo, mensaje, stopsign!)
	return -1
end if

return AncestorReturnValue

end event

event type integer pfc_postupdate(powerobject apo_control[]);call super::pfc_postupdate;//
if ancestorReturnVAlue>0 then
	// Retiveamos nuevamente el dw de cobros
	dw_cobros.retrieve(dw_lista.getitemString(dw_lista.getRow(), 'id_cobro_multiple'))
end if

return AncestorREturnValue
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_cobros_multiples_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_cobros_multiples_lista
end type

type st_1 from w_lista`st_1 within w_cobros_multiples_lista
integer y = 1692
end type

type dw_lista from w_lista`dw_lista within w_cobros_multiples_lista
integer width = 3730
integer height = 540
string dataobject = "d_cobros_multiples_lista"
end type

event dw_lista::retrieveend;call super::retrieveend;this.PostEvent(Rowfocuschanged!) // No se si acaba de ir, pero bueno

end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;string id_cobro_multiple

if dw_lista.rowcount()=0 then return
id_cobro_multiple = dw_lista.getitemstring(dw_lista.getrow(),'id_cobro_multiple')
// VAciamos el de cobros
dw_cobros.reset()
dw_apuntes.reset()

if this.rowcount() = 0 then return
// Retriveamos los cobros de este cobro multiple
dw_cobros.retrieve(id_cobro_multiple)
// Retriveamos los apuntes del cobro multiple indicado
dw_apuntes.retrieve(id_cobro_multiple)



end event

event dw_lista::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event dw_lista::rowfocuschanging;call super::rowfocuschanging;long retorno

if dw_lista.trigger event pfc_updatespending()<>0 or dw_cobros.trigger event pfc_updatespending()<>0 then
	if Messagebox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios actuales?", question!, yesno!, 1) = 1 then
		// lanzamos el evento de grabar
		retorno = parent.trigger event pfc_preupdate()
		if retorno<>0 or retorno<>1 then
			return 0
		else
			return AncestorReturnValue
		end if
	else
		// Pierde los cambios, dejamos que continue
		Return AncestorREturnValue
	end if
end if
end event

type cb_consulta from w_lista`cb_consulta within w_cobros_multiples_lista
integer y = 1296
end type

type cb_detalle from w_lista`cb_detalle within w_cobros_multiples_lista
integer y = 1296
end type

type cb_ayuda from w_lista`cb_ayuda within w_cobros_multiples_lista
integer y = 1296
end type

type dw_cobros from u_dw within w_cobros_multiples_lista
integer x = 23
integer y = 580
integer width = 3735
integer height = 544
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_multiples_cobros_relacion_lista"
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event buttonclicked;call super::buttonclicked;// SEg$$HEX1$$fa00$$ENDHEX$$n el bot$$HEX1$$f300$$ENDHEX$$n que pulse borramos o ponemos el id_cobros
string id_cobro, banco, pagado
double importe
datetime f_pago

CHOOSE CASE dwo.name
	CASE 'b_borrar_cobro'
		// Simplemente quitamos el identificador del cobro multiple
		this.setitem(row, 'id_cobro_multiple', '')
		dw_lista.setfocus()
	CASE 'b_reenlazar'
		// Volvemos a colocar el id_cobro
		this.setitem(row, 'id_cobro_multiple', dw_lista.GetItemString(dw_lista.getRow(), 'id_cobro_multiple'))
		this.setitem(row, 'csi_cobros_forma_pago', 'CM') // TAl como se ha dicho por el momento
	CASE 'b_buscar_cobro'
		// Abrimos la busqueda de cobros multiples y permitimos seleccionar un nuevo cobro
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Cobros"
		g_busqueda.dw="d_cobros_no_relacionados_busqueda"
		id_cobro = f_busqueda_cobros_no_relacionados()  
		if not f_es_vacio(id_cobro) then
			// Colocamos el numero de aviso
			this.setitem(row, 'id_pago', id_cobro)
			this.setitemstatus(row, 0, primary!, datamodified!)
			this.setitem(row, 'csi_facturas_emitidas_n_fact', f_dame_n_factura_id_cobro(id_cobro))
			this.setitem(row, 'fases_minutas_n_aviso', f_dame_n_aviso_id_cobro(id_cobro))
			SELECT banco, importe, f_pago, pagado into :banco, :importe, :f_pago, :pagado from csi_cobros where id_pago = :id_cobro;
			// hay que obtener el banco que hab$$HEX1$$ed00$$ENDHEX$$a
			this.setitem(row, 'csi_cobros_banco', banco)
			this.setitem(row, 'csi_cobros_importe', importe)
			this.setitem(row, 'csi_cobros_f_pago', f_pago)
			this.setitem(row, 'csi_cobros_pagado', pagado)
			this.setitem(row, 'id_cobro_multiple', dw_lista.GetItemString(dw_lista.getRow(), 'id_cobro_multiple'))
		end if
END CHOOSE
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'csi_cobros_forma_pago'
		// Miramos si est$$HEX2$$e1002000$$ENDHEX$$enganchado a un cobro
		if not f_es_vacio(this.GetitemString(row, 'id_cobro_multiple')) then
			MessageBox(g_titulo, "No se puede modificar la forma de pago pues entonces no se contabilizar$$HEX1$$ed00$$ENDHEX$$a como cobro m$$HEX1$$fa00$$ENDHEX$$ltiple", stopsign!)
			return 2
		end if
END CHOOSE
end event

event doubleclicked;call super::doubleclicked;if row < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_facturacion_emitida_consulta.id_factura = this.getitemstring(row,'csi_cobros_id_factura')
message.stringparm = "w_facturacion_emitida_detalle"
w_aplic_frame.postevent("csd_facturacion_emitida_detalle")

end event

type cb_anyadir_cobro from commandbutton within w_cobros_multiples_lista
boolean visible = false
integer x = 3136
integer y = 1128
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Cobro"
end type

event clicked;// A$$HEX1$$f100$$ENDHEX$$adiremos un nueva linea en el de cobros para el cobro multiple indicado
dw_cobros.insertRow(0)
// Colocamos el identificador
dw_cobros.setitem(dw_cobros.rowcount(), 'id_cobro_multiple', dw_lista.GetItemString(dw_lista.getRow(), 'id_cobro_multiple'))
// La forma de pago es obligatoriamente CM
dw_cobros.setitem(dw_cobros.rowcount(), 'csi_cobros_forma_pago', 'CM') // TAl como se ha dicho por el momento

end event

type dw_apuntes from u_dw within w_cobros_multiples_lista
integer x = 23
integer y = 1136
integer width = 3749
integer height = 544
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos_fe"
boolean ib_rmbmenu = false
end type

event constructor;this.SetTransObject(bd_ejercicio)
end event

