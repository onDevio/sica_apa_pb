HA$PBExportHeader$w_cobros_cobrar_cobros.srw
forward
global type w_cobros_cobrar_cobros from w_response
end type
type dw_cobros_pagar_cobros from u_dw within w_cobros_cobrar_cobros
end type
type cb_aceptar from commandbutton within w_cobros_cobrar_cobros
end type
type cb_cancelar from commandbutton within w_cobros_cobrar_cobros
end type
end forward

global type w_cobros_cobrar_cobros from w_response
string tag = "texto=general.aceptar"
integer width = 3246
integer height = 1320
string title = "Cobrar cobros seleccionados"
boolean controlmenu = false
event csd_valida_saldo ( )
event csd_informe ( )
dw_cobros_pagar_cobros dw_cobros_pagar_cobros
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_cobros_cobrar_cobros w_cobros_cobrar_cobros

type variables
st_cobros_pagar_cobros ist_cobros
datastore	ids_historico_fact
end variables

forward prototypes
public subroutine wf_guarda_historico_facturas (string id_factura, datetime f_pago, string forma_pago)
end prototypes

event csd_valida_saldo();datetime f_desde, f_hasta
string   colegiado,cuenta
double   saldo=0, pagado=0, total_pagado=0
integer  i
u_dw  ldw_cobros
ldw_cobros = ist_cobros.dw_lista
f_desde   = datetime(date('01/01/'+g_ejercicio),time('00:00'))
f_hasta   = datetime(today(),time('23:59:59'))
					
colegiado = ldw_cobros.getitemstring(1, 'id_persona')
cuenta    = f_dame_cuenta_col(colegiado, g_formas_pago.cuenta_personal)
saldo     = f_saldo_cuenta_bancaria_col(colegiado,f_desde, f_hasta)
ldw_cobros.setsort('n_col')
ldw_cobros.sort()

for i = 1 to ldw_cobros.rowcount()
	if ldw_cobros.getItemstring(i, 'pagado') = 'N' then
		if colegiado <> ldw_cobros.getitemstring(i, 'id_persona') then
			colegiado = ldw_cobros.getitemstring(i, 'id_persona')
			cuenta    = f_dame_cuenta_col(colegiado, g_formas_pago.cuenta_personal)
			saldo     = f_saldo_cuenta_bancaria_col(colegiado,f_desde, f_hasta)
		end if	
		if ldw_cobros.getitemdecimal(i,'importe')> 0 then
			if ldw_cobros.getitemdecimal(i,'importe') <= saldo  and saldo > 0 then
				ldw_cobros.SetItem(i, 'pagado', 'S')
				ldw_cobros.SetItem(i, 'f_pago', today())
				pagado = saldo - ldw_cobros.getitemdecimal(i,'importe') 
				saldo  = pagado
				total_pagado += ldw_cobros.getitemdecimal(i,'importe') 
			end if
		end if
	end if	
next
dw_cobros_pagar_cobros.setitem(1, 'total_pagar', total_pagado)
dw_cobros_pagar_cobros.setitem(1, 'entregado', total_pagado)
end event

event csd_informe;//Construye el inform de cobro segun lo seleccionado
s_printdlgattrib opciones
u_dw				  ldw_cobros
datastore        ds_informe
long 				  ll_new,i


ldw_cobros = ist_cobros.dw_lista
// Creamos el informe de lo que se ha cobrado
ds_informe           =  create datastore
ds_informe.dataobject = 'd_cobros_informe_cobros'
ds_informe.settransobject(sqlca)

for i= 1 to ldw_cobros.rowcount()
	if ldw_cobros.getitemstring(i,'pagado') = 'S'  and  ldw_cobros.getitemstring(i,'activo') = 'S'then
		if ldw_cobros.getitemstring(i,'forma_pago') = dw_cobros_pagar_cobros.getitemstring(1,'forma_pago') then
			ll_new = ds_informe.insertrow(0)
			ds_informe.setitem(ll_new, 'fecha_pago',dw_cobros_pagar_cobros.getitemdatetime(1,'fecha_pago'))
			ds_informe.setitem(ll_new, 'formapago',dw_cobros_pagar_cobros.getitemstring(1,'forma_pago'))
			ds_informe.setitem(ll_new, 'banco',dw_cobros_pagar_cobros.getitemstring(1,'banco'))
			ds_informe.setitem(ll_new, 'total',dw_cobros_pagar_cobros.getitemdecimal(1,'total_pagar'))
			ds_informe.setitem(ll_new, 'n_colegiado',ldw_cobros.getitemstring(i,'n_col'))
			ds_informe.setitem(ll_new, 'nombre',ldw_cobros.getitemstring(i,'nombre'))
			ds_informe.setitem(ll_new, 'id_factura',ldw_cobros.getitemstring(i,'n_fact'))
			ds_informe.setitem(ll_new, 'asunto',ldw_cobros.getitemstring(i,'asunto'))
			ds_informe.setitem(ll_new, 'importe',ldw_cobros.getitemdecimal(i,'importe'))
		end if
	end if
next


opciones.b_allpages = true
opciones.b_pagenums = false
opciones.b_selection = false
opciones.b_disableselection = true
opciones.b_collate = false
opciones.l_copies = 1
opciones.l_frompage = 1
opciones.l_topage = long(ds_informe.Describe ("evaluate ('PageCount()', 1)"))
opciones.l_minpage = 1
opciones.l_maxpage = long(ds_informe.Describe ("evaluate ('PageCount()', 1)"))
opciones.b_hideprinttofile = true

openwithparm(w_csd_print,opciones)

opciones = message.powerobjectParm

if not(opciones.b_disablepagenums) then return

ds_informe.object.datawindow.print.collate = opciones.b_collate
ds_informe.object.datawindow.print.copies = opciones.l_copies
if opciones.b_pagenums then
	ds_informe.object.datawindow.print.page.range = string(opciones.l_frompage) + "-" + string(opciones.l_topage)
end if

ds_informe.Print(TRUE)
// Destruimos el datastore
	destroy ds_informe
end event

public subroutine wf_guarda_historico_facturas (string id_factura, datetime f_pago, string forma_pago);
int ll_new

// Se inserta las modificaciones en el historico de las facturas
	ll_new = ids_historico_fact.insertrow(0)
	ids_historico_fact.setitem(ll_new, 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
	ids_historico_fact.setitem(ll_new, 'id_colegiado', id_factura )
	ids_historico_fact.setitem(ll_new, 'tipo_modulo', '05')
	ids_historico_fact.setitem(ll_new, 'usuario', g_usuario)
	ids_historico_fact.setitem(ll_new, 'fecha',f_pago)
	ids_historico_fact.setitem(ll_new, 'modificacion', 'DETALLE formadepago= '+ forma_pago)
end subroutine

on w_cobros_cobrar_cobros.create
int iCurrent
call super::create
this.dw_cobros_pagar_cobros=create dw_cobros_pagar_cobros
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cobros_pagar_cobros
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_cobros_cobrar_cobros.destroy
call super::destroy
destroy(this.dw_cobros_pagar_cobros)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
f_centrar_ventana(this)
if isvalid(message.PowerObjectParm) Then
	ist_cobros = message.PowerObjectParm	
end if

DataWindowChild dwc_banco
dw_cobros_pagar_cobros.GetChild("banco", dwc_banco)
dwc_banco.SetTransObject(SQLCA)
dwc_banco.Retrieve(g_empresa)



end event

event pfc_postopen;call super::pfc_postopen;// Aqu$$HEX2$$ed002000$$ENDHEX$$es donde realizamos las acciones

// Colcocamos el calendario
dw_cobros_pagar_cobros.of_SetDropDownCalendar(True)
dw_cobros_pagar_cobros.iuo_calendar.of_register(dw_cobros_pagar_cobros.iuo_calendar.DDLB)
dw_cobros_pagar_cobros.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_cobros_pagar_cobros.iuo_calendar.of_SetInitialValue(True)

// Colocamos la fecha y los datos por defecto
dw_cobros_pagar_cobros.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
if f_es_vacio(dw_cobros_pagar_cobros.getitemstring(1, 'forma_pago')) then dw_cobros_pagar_cobros.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
if f_es_vacio(dw_cobros_pagar_cobros.getitemstring(1, 'banco')) then dw_cobros_pagar_cobros.SetItem(1,'banco',g_banco_por_defecto)


CHOOSE CASE ist_cobros.ventana
	CASE 'w_cobros_domicilia_lista'
		// SAbemos que venimos de la ventana de lista de cobros por lo que actuamos como tal
		dw_cobros_pagar_cobros.setitem(1, 'total_pagar', round(ist_cobros.importe_total,2))
		dw_cobros_pagar_cobros.setitem(1, 'entregado', dw_cobros_pagar_cobros.getitemdecimal(1, 'total_pagar'))
END CHOOSE
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cobros_cobrar_cobros
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cobros_cobrar_cobros
string tag = "texto=general.guardar_pantalla"
end type

type dw_cobros_pagar_cobros from u_dw within w_cobros_cobrar_cobros
integer x = 50
integer y = 28
integer width = 3136
integer height = 996
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cobros_pagar_cobros"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;dw_cobros_pagar_cobros.insertrow(0)

datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

event itemchanged;u_dw ldw_cobros
ldw_cobros = ist_cobros.dw_lista

CHOOSE CASE dwo.name
	CASE 'forma_pago'
		string tipo_pago, banco
		tipo_pago = string(data)
	   SELECT csi_formas_de_pago.banco_asociado  
		 INTO :banco  
		 FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		
		// Colocamos el banco
		this.setitem(row, 'banco', banco)
		
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				CHOOSE CASE tipo_pago
					CASE 'TA', 'TJ'
						// Si es talon o tarjeta le ponemos el total en importe a entregar
						this.setitem(row, 'entregado', this.GetItemNumber(row, 'total_pagar'))
				END CHOOSE
			CASE 'COAATLR'
				CHOOSE CASE tipo_pago
					CASE 'DB'
						// Si es Domiciliacion bancaria
						this.setitem(row, 'entregado', this.GetItemNumber(row, 'total_pagar'))
				END CHOOSE
		END CHOOSE

END CHOOSE
end event

type cb_aceptar from commandbutton within w_cobros_cobrar_cobros
string tag = "texto=general.aceptar"
integer x = 809
integer y = 1076
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;call super::clicked;call super::clicked;call super::clicked;call super::clicked;long fila
double entregado, importe_cobros
string forma_pago, banco, mensaje = '', id_factura, colegiado
datetime f_pago
boolean b_sobreescribir, b_sobreescribir_cabecera
datastore ds_facturacion_emitida_detalle,ds_informe
datawindow  p
int i
u_dw  ldw_cobros 

dw_cobros_pagar_cobros.trigger event pfc_accepttext(true)

ldw_cobros = ist_cobros.dw_lista

// Valiamos que todo est$$HEX2$$e9002000$$ENDHEX$$correcto
mensaje += f_valida(dw_cobros_pagar_cobros,'fecha_pago', 'NONULO', g_idioma.of_getmsg('msg_cobros.indicar_fecha',"Debe indicar una fecha en la que se ha/n realizado el/los cobro/s"))
mensaje += f_valida(dw_cobros_pagar_cobros,'forma_pago', 'NOVACIO',g_idioma.of_getmsg('msg_cobros.indicar_forma_pago', "Debe indicar la forma de pago en la que se ha/n realizado el/los cobro/s"))
mensaje += f_valida(dw_cobros_pagar_cobros,'banco', 'NOVACIO',g_idioma.of_getmsg('msg_cobros.indicar_banco', "Debe indicar el banco para el/los cobro/s"))
entregado = dw_cobros_pagar_cobros.GetItemNumber(1, 'entregado')
if not isnull(entregado) then
	if ist_cobros.importe_total >0 then
		// Tienen que indicar una cantidad igual o superior
		if not((entregado - ist_cobros.importe_total)> - 0.01) then
			mensaje += g_idioma.of_getmsg('msg_cobros.importe_grande',"Debe indicar un importe suficientemente grande")
		end if
	else
		// Es porque las cantaidades son negativas... No se que es lo que debe cumplirse en este caso
	end if
else
	// ES nulo
	mensaje += g_idioma.of_getmsg('msg_cobros.importe_grande',"Debe indicar un importe suficientemente grande")
end if

if not f_es_vacio(mensaje) then
	MessageBox(g_titulo, mensaje, stopsign!)
	return
end if



// Recogemos los datos indicados para poder tratar con ellos
f_pago = datetime(date(dw_cobros_pagar_cobros.GetItemDatetime(1, 'fecha_pago')), time("00:00:00"))
forma_pago = dw_cobros_pagar_cobros.getItemString(1, 'forma_pago')
banco = dw_cobros_pagar_cobros.getItemString(1, 'banco')
b_sobreescribir = (dw_cobros_pagar_cobros.getItemString(1, 'modificar_datos')='S')
b_sobreescribir_cabecera = (dw_cobros_pagar_cobros.getItemString(1, 'modificar_cabecera_facturas')='S')

// Avisamos de la opcion elegida lo que va a realizar
if b_sobreescribir and b_sobreescribir_cabecera then 
	if Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.ha_elegido_banco',"Ha elegido actualizar todos cobros no pagados y facturas (excepto las contabilizadas ya) con la forma de pago y el banco indicado.")+cr+g_idioma.of_getmsg('msg_cobros.desea_continuar',"$$HEX1$$bf00$$ENDHEX$$Desea continuar?"), question!, yesno!, 2)=2 then return
end if
if b_sobreescribir and not b_sobreescribir_cabecera then 
	if Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.ha_elegido_factura',"Ha elegido actualizar todos cobros no pagados con la forma de pago y el banco indicado pero no las facturas, con el consiguiente descuadre entre factura y cobro ")+cr+g_idioma.of_getmsg('msg_cobros.desea_continuar',"$$HEX1$$bf00$$ENDHEX$$Desea continuar?"), question!, yesno!, 2)=2 then return
end if
if not b_sobreescribir and b_sobreescribir_cabecera then 
	Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.no_permitida',"Opci$$HEX1$$f300$$ENDHEX$$n no permitida"),stopsign! )
	return
end if
if not b_sobreescribir and not b_sobreescribir_cabecera then 
	if Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.marcara_cobro',"S$$HEX1$$f300$$ENDHEX$$lo se marcar$$HEX2$$e1002000$$ENDHEX$$el pagado y la fecha de pago de los cobros y las facturas, dejando los valores indicados en el banco y la forma de pago")+cr+g_idioma.of_getmsg('msg_cobros.desea_continuar',"$$HEX1$$bf00$$ENDHEX$$Desea continuar?"), question!, yesno!, 2)=2 then return
end if
	
CHOOSE CASE ist_cobros.ventana
	CASE 'w_cobros_domicilia_lista'
		
		ds_facturacion_emitida_detalle = create datastore
		ds_facturacion_emitida_detalle.dataobject = 'd_facturacion_emitida_detalle'
		ds_facturacion_emitida_detalle.settransobject(SQLCA)

		
		// SAbemos que venimos de la ventana de lista de cobros por lo que actuamos como tal
		FOR fila = 1 TO ist_cobros.dw_lista.RowCount()
			if ist_cobros.dw_lista.GetItemString(fila, 'pagado') = 'N' then
				if f_es_vacio(ist_cobros.dw_lista.GetItemString(fila, 'forma_pago')) or b_sobreescribir then ist_cobros.dw_lista.SetItem(fila, 'forma_pago', forma_pago)
				if f_es_vacio(ist_cobros.dw_lista.GetItemString(fila, 'banco')) or b_sobreescribir then ist_cobros.dw_lista.SetItem(fila, 'banco', banco)
			
			
				if g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio='COAATLL' then
					colegiado = ist_cobros.dw_lista.getitemstring(i, 'id_persona')
						if forma_pago ='DB'  and not isnull(colegiado) then
							if f_dame_otros_conceptos_colegiado(colegiado, '04') = 'N' then
									ist_cobros.dw_lista.Setitem(fila,'forma_pago','TR')
									forma_pago = 'TR'
							end if
						end if
					end if
				
				// Marcamos el pagado y la fecha de pago
				// Si la forma de pago es domiciliacion bancaria, no marcamos los cobros como pagados porque hay que generar las trasferencias al banco
				if forma_pago <> 'DB'  and forma_pago<>'CP'then
					ist_cobros.dw_lista.SetItem(fila, 'pagado', 'S')
					ist_cobros.dw_lista.SetItem(fila, 'f_pago', f_pago)
				end if
				ist_cobros.dw_lista.SetItem(fila, 'modificado', 'S')
			end if
		NEXT
		
		// Si la forma de pago es domiciliacion bancaria le pasamos a la ventana las cosas que sabemos
		if forma_pago = 'DB' then
			st_cobros_datos_pre_remesa datos
			datos.dw_lista = ist_cobros.dw_lista
			datos.modulo='COBROS'
			datos.forma_pago = forma_pago
			datos.banco = banco
			datos.fecha = f_pago
			OpenWithParm(w_cobros_pre_remesa,datos)		
			if message.stringparm = '-1' then
				Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.cancelar_generacion',"Ha cancelado la generaci$$HEX1$$f300$$ENDHEX$$n de la remesa. Los cobros ser$$HEX1$$e100$$ENDHEX$$n restablecidos tal como est$$HEX1$$e100$$ENDHEX$$n almacenados deshaciendo cualquier cambio realizado"))
				ist_cobros.retorno = 'csd_actualiza_listas'
				closewithreturn(parent, ist_cobros)
				return
			end if
		END IF
		// Si la forma de pago es Cuenta Personal se verifica si tiene saldo para pagar
		if forma_pago = 'CP' then
//			//Modificacion Yexaira 14/10/08
//			//Se verifica que el colegiado tenga activo el servicio BBVA para verificar el saldo
//			if  f_devuelve_servicio_bbva (ldw_cobros.getitemstring(1, 'id_persona')) = 'S' then
	    			 parent.triggerevent('csd_valida_saldo')
//			else
//				ist_cobros.dw_lista.SetItem(fila, 'forma_pago', g_formas_pago.domiciliacion)
//			end if
		end if
		
		
		
		if ist_cobros.dw_lista.update()<>1 then 
			Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_actualizar',"Se ha producido un error cuando se intentaba actualizar los cobros... Revise cada uno de ellos"), exclamation!)
			ist_cobros.retorno = '-2'
			closewithreturn(parent, ist_cobros)
			return
		end if
		
		// Agregado por yexaira 22-05-08
		ids_historico_fact = create datastore
		ids_historico_fact.dataobject = 'd_historico'
		ids_historico_fact.settransobject(SQLCA)		
		
		// Ahora es cuando deberiamos mirar las cabeceras de las facturas correspondientes
		FOR fila = 1 TO ist_cobros.dw_lista.RowCount()
			if ist_cobros.dw_lista.GetItemString(fila, 'modificado') =  'S' then
				id_factura = ist_cobros.dw_lista.GetItemString(fila, 'id_factura')
				if ds_facturacion_emitida_detalle.retrieve(id_factura) = 1 then
					if ds_facturacion_emitida_detalle.GetItemString(1, 'pagado') = 'N' then
						// Cogemos la suma de los importes de los cobros de esa factura
						select sum(importe) into :importe_cobros from csi_cobros where id_factura = :id_factura and pagado = 'S';
						if isnull(importe_cobros) then importe_cobros = 0
						// Miramos si se parece al total de la factura
						if abs(ds_facturacion_emitida_detalle.GetItemNumber(1, 'total') - importe_cobros)<0.5 then
							// Marcaremos la factura como pagada y grabaremos
							ds_facturacion_emitida_detalle.SetItem(1, 'pagado', 'S')
							ds_facturacion_emitida_detalle.SetItem(1, 'f_pago', ist_cobros.dw_lista.GetItemDateTime(fila, 'f_pago'))
							// MODIFICADO YEXAIRA 22-05-08
							// Se modifica la forma de pago  a la factura si es diferente a la del cobro
							if ds_facturacion_emitida_detalle.getitemstring(1, 'formadepago') <> forma_pago then
								ds_facturacion_emitida_detalle.SetItem(1, 'formadepago', forma_pago )
								// Se inserta las modificaciones en el historico de las facturas
								wf_guarda_historico_facturas(id_factura, ist_cobros.dw_lista.GetItemDateTime(fila, 'f_pago'), forma_pago)
							end if
							//FIN MODIFICACION							
						end if
					end if
					// En el caso que hayan pedido actualizar los datos de la cabecera cambiaremos la forma de pago y el banco si no est$$HEX2$$e1002000$$ENDHEX$$contabilizada
					if ds_facturacion_emitida_detalle.GetItemString(1, 'contabilizada') = 'N' then
						if f_es_vacio(ds_facturacion_emitida_detalle.GetItemString(1, 'formadepago')) or b_sobreescribir_cabecera then ds_facturacion_emitida_detalle.SetItem(1, 'formadepago', ist_cobros.dw_lista.GetItemString(fila, 'forma_pago'))
						if f_es_vacio(ds_facturacion_emitida_detalle.GetItemString(1, 'banco')) or b_sobreescribir_cabecera then ds_facturacion_emitida_detalle.SetItem(1, 'banco', ist_cobros.dw_lista.GetItemString(fila, 'banco'))
					end if			
					if ds_facturacion_emitida_detalle.update()<>1 then
						Messagebox(g_titulo, g_idioma.of_getmsg('msg_cobros.error_actualizar_fact',"Se ha producido un error cuando se intentaba actualizar las facturas de los cobros indicados"), exclamation!)
						ist_cobros.retorno = '-3'
						closewithreturn(parent, ist_cobros)
						return
					else
						// MODIFICADO YEXAIRA 22-05-08
						// Se inserta las modificaciones en el historico de las facturas
							ids_historico_fact.update()
						//FIN MODIFICACION						
					end if
				end if
			end if
		NEXT
		
		// Destruimos el datastore
		destroy ds_facturacion_emitida_detalle
		destroy ids_historico_fact		
END CHOOSE

// Evento para imprimir el listado de lo cobrado
	 parent.triggerevent('csd_informe')
	 
// Cerramos la ventana con lo que nos digan en la opcion de contabilizar
ist_cobros.forma_pago = forma_pago
ist_cobros.contabilizar = dw_cobros_pagar_cobros.getitemString(1, 'contabilizar')
ist_cobros.retorno = '1'
closewithreturn(parent, ist_cobros)
end event

type cb_cancelar from commandbutton within w_cobros_cobrar_cobros
string tag = "texto=general.cancelar"
integer x = 1842
integer y = 1076
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;ist_cobros.retorno = '-1'
closewithreturn(parent, ist_cobros)
end event

