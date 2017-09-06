HA$PBExportHeader$w_factufa_proforma_a_factura.srw
forward
global type w_factufa_proforma_a_factura from w_response
end type
type cb_aceptar from commandbutton within w_factufa_proforma_a_factura
end type
type cb_cancelar from commandbutton within w_factufa_proforma_a_factura
end type
type dw_lista from u_dw within w_factufa_proforma_a_factura
end type
type dw_param from u_dw within w_factufa_proforma_a_factura
end type
type dw_proforma from u_dw within w_factufa_proforma_a_factura
end type
type dw_premaat_datos from u_dw within w_factufa_proforma_a_factura
end type
end forward

global type w_factufa_proforma_a_factura from w_response
integer width = 1883
integer height = 1448
string title = "Convertir Proforma en Factura Activa a efectos de Impuestos"
event csd_datos_defecto ( )
event csd_retrieve_facturas ( )
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
dw_lista dw_lista
dw_param dw_param
dw_proforma dw_proforma
dw_premaat_datos dw_premaat_datos
end type
global w_factufa_proforma_a_factura w_factufa_proforma_a_factura

type variables
String i_lista_id_factura
datawindowchild dwc_bancos
end variables

forward prototypes
public function integer wf_valida ()
public function integer wf_estado_cuenta_colegiado (string id)
end prototypes

event csd_datos_defecto();// Datos mostrados por pantalla, con los que se generar$$HEX2$$e1002000$$ENDHEX$$la factura
dw_param.SetItem(1,'fecha',DateTime(Today()))
dw_param.SetItem(1,'serie',g_serie_fases)
// pagado: Valor por defecto
//dw_param.SetItem(1,'pagado','S') 
dw_param.SetItem(1,'f_pago',DateTime(Today()))
dw_param.SetItem(1,'forma_pago','')
dw_param.SetItem(1,'banco','')


end event

event csd_retrieve_facturas();String sql_nuevo
SetPointer(Hourglass!)

// Concatenamos a la SQL el filtrado por los id_factura seleccionados en la ventana previa
sql_nuevo = dw_lista.describe("datawindow.table.select")
if NOT f_es_vacio(i_lista_id_factura) then  sql_nuevo += " AND id_factura IN ("+f_coloca_comillas(i_lista_id_factura) +")"
dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_lista.Retrieve ()

IF dw_lista.RowCount() = 0 THEN 
	MessageBox(g_titulo,'No hay documentos v$$HEX1$$e100$$ENDHEX$$lidos para continuar.'+cr+'Se aborta este proceso.', StopSign!)
	CloseWithReturn (This,-1)
else
	
dwc_bancos.retrieve(dw_lista.getitemstring(1,'empresa'))

END IF 

SetPointer(Arrow!)


end event

public function integer wf_valida ();string mensaje = ''
long num_facturas_anteriores , resp_temp
string serie_aux,id_colegiado,n_col
datetime fecha
string ls_null 
boolean i_no_saldo
setnull(ls_null)
i_no_saldo=false

dw_param.AcceptText()
fecha = dw_param.GetItemDateTime(1,'fecha')
serie_aux = dw_param.GetItemString(1,'serie') + '-'  + Right(String(Year(Date(fecha))),2) + '%'

// VALIDACIONES OBLIGATORIAS
// La fecha de factura no puede ser vac$$HEX1$$ed00$$ENDHEX$$a 
mensaje += f_valida(dw_param,'fecha','NONULO','Debe especificar un valor en el campo Fecha.')
mensaje += f_valida(dw_param,'serie','NOVACIO','Debe especificar un valor en el campo Serie.')
IF dw_param.GetItemString(1,'pagado') = 'S' THEN
	mensaje += f_valida(dw_param,'f_pago','NONULO','Debe especificar un valor en el campo Fecha de Pago si est$$HEX2$$e1002000$$ENDHEX$$pagada.')
	mensaje += f_valida(dw_param,'forma_pago','NOVACIO','Debe especificar un valor en el campo Forma de Pago si est$$HEX2$$e1002000$$ENDHEX$$pagada.')
	// Banco: lo dejamos opcional
END IF

if dw_param.GetItemString(1,'pagado') = 'N' THEN
	dw_param.SetItem(1,'f_pago', ls_null)
end if

//Validamos que el colegiado tiene suficiente saldo en la cuenta personal
if dw_param.getItemString(1,'forma_pago')=g_formas_pago.cuenta_personal and dw_param.GetItemString(1,'pagado') = 'S' then
	if dw_lista.getItemString(1,'tipo_persona')='C' and not f_es_vacio(g_prefijo_cuenta_bancaria_col) then
		n_col=dw_lista.getItemString(1,'n_col')
		id_colegiado=f_colegiado_id_col(n_col)
	
		if wf_estado_cuenta_colegiado(id_colegiado)= 0 then
			mensaje +='El colegiado no tiene cr$$HEX1$$e900$$ENDHEX$$dito suficiente en su cuenta personal'
			i_no_saldo=true
		end if
	elseif dw_lista.getItemString(1,'tipo_persona')='P' then
		mensaje += 'No es posible el pago en cuenta personal para clientes externos'
	end if
end if

//Fin validaci$$HEX1$$f300$$ENDHEX$$n saldo

IF NOT f_es_vacio(mensaje) THEN
	MessageBox(g_titulo,mensaje)
	if i_no_saldo=true then
		st_saldo_cuenta_bancaria_colegiado lst_entrada
		lst_entrada.id_colegiado = id_colegiado
		lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
		lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
		openwithparm(w_saldo_cuenta_bancaria_colegiado,lst_entrada)
	end if
	RETURN -1
END IF

///** Se comenta a petici$$HEX1$$f300$$ENDHEX$$n de Paco, tras realizar pruebas el 30/11 **///	
// VALIDACIONES Opcionales
// NO deben haber facturas con fecha posterior en la misma serie (tendr$$HEX1$$e100$$ENDHEX$$n un n$$HEX1$$fa00$$ENDHEX$$mero anterior)
//SELECT COUNT(*) INTO :num_facturas_anteriores FROM csi_facturas_emitidas 	WHERE fecha > :fecha AND n_fact like :serie_aux ;
//IF num_facturas_anteriores > 0 THEN 
//	resp_temp = MessageBox(g_titulo,'Hay facturas con fecha posterior en la misma serie.'+cr+'$$HEX1$$bf00$$ENDHEX$$Desea continuar de todas formas? (se generar$$HEX1$$e100$$ENDHEX$$n facturas con n$$HEX1$$fa00$$ENDHEX$$mero posterior en fecha anterior a las existentes)',Exclamation!,YesNo!) 
//	IF resp_temp  = 2 THEN 	RETURN -1
//END IF

// Otro Caso, OK
RETURN 1

end function

public function integer wf_estado_cuenta_colegiado (string id);string filtro
double saldo,saldo_facturar
st_saldo_cuenta_bancaria_colegiado lst_entrada
//Obtenemos el saldo de la cuenta personal del colegiado
lst_entrada.id_colegiado = id
lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))

saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
		
saldo_facturar=dw_lista.getItemNumber(1,'total')


if saldo < saldo_facturar then
	return 0
else
	return 1
end if
end function

on w_factufa_proforma_a_factura.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.dw_lista=create dw_lista
this.dw_param=create dw_param
this.dw_proforma=create dw_proforma
this.dw_premaat_datos=create dw_premaat_datos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_lista
this.Control[iCurrent+4]=this.dw_param
this.Control[iCurrent+5]=this.dw_proforma
this.Control[iCurrent+6]=this.dw_premaat_datos
end on

on w_factufa_proforma_a_factura.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.dw_lista)
destroy(this.dw_param)
destroy(this.dw_proforma)
destroy(this.dw_premaat_datos)
end on

event open;call super::open;// Recuperamos el valor pasado a la ventana en una estructura
i_lista_id_factura = Message.StringParm

f_centrar_ventana(this) 

dw_param.event pfc_addrow()

// Asignar valores a los par$$HEX1$$e100$$ENDHEX$$metros de consulta desde la estructura pasada como argumento
This.TriggerEvent("csd_datos_defecto")

dw_param.SetFocus()
dw_param.SetColumn('fecha')


// Recuperamos la lista de facturas a procesar en dw_lista
This.PostEvent("csd_retrieve_facturas")

end event

event pfc_postopen;call super::pfc_postopen;dw_param.of_SetDropDownCalendar(True)
dw_param.iuo_calendar.of_register(dw_param.iuo_calendar.DDLB)
dw_param.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_param.iuo_calendar.of_SetInitialValue(True)







end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_factufa_proforma_a_factura
integer y = 1032
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_factufa_proforma_a_factura
end type

type cb_aceptar from commandbutton within w_factufa_proforma_a_factura
integer x = 453
integer y = 1240
integer width = 402
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;// Aceptar devolver$$HEX1$$e100$$ENDHEX$$:
//			1 => Si se han actualizado correctamente los datos de todas las facturas
//			0 => Si no se han actualizado correctamente todos los datos
// Cancelar devolver$$HEX1$$e100$$ENDHEX$$:
//			-1 => No se debe realizar ninguna acci$$HEX1$$f300$$ENDHEX$$n desde la ventana que invoc$$HEX2$$f3002000$$ENDHEX$$esta ventana

SetPointer(HourGlass!)
long resp, resp_dw_lista, resp_dw_proforma, i
double ldb_iva_fact, ldb_total_fact
resp = 0
datetime fecha, f_pago
string n_fact, pagado, forma_pago, banco, ls_null, ls_serie_abono, ls_id_factura, ls_gen_mov_musaat, ls_serie_defecto
int li_j
datastore ds_lineas_factura
st_facturas lst_facturas

setnull(ls_null)
// Bloque de Validaciones
if wf_valida() < 0 THEN RETURN

// Vac$$HEX1$$ed00$$ENDHEX$$amos el dw auxiliar
dw_proforma.Reset () 

// CONVERSI$$HEX1$$d300$$ENDHEX$$N DE DATOS
	// Realizamos backup de los datos de la proforma. 
	// Por cada campo, vamos asignando los valores actualizados.
	// Por $$HEX1$$fa00$$ENDHEX$$ltimo, actualizamos los datos de los cobros con los datos asignados a la factura
	
// Datos fijos para todas las iteraciones
fecha = dw_param.GetItemDateTime(1,'fecha')
pagado = dw_param.GetItemString(1,'pagado')
if pagado = 'S' then
	f_pago = dw_param.GetItemDateTime(1,'f_pago')
else 
	setnull(f_pago)
end if	
forma_pago = dw_param.GetItemString(1,'forma_pago')
banco = dw_param.GetItemString(1,'banco')
// 

ds_lineas_factura = create datastore
ds_lineas_factura.dataobject = "d_lineas_fact_emitidas"
ds_lineas_factura.setTransObject(SQLCA)

FOR i = 1 TO dw_lista.RowCount()
	// Dato Variable
	ls_gen_mov_musaat = 'N'
	//Se obtiene la serie de la factura dependiendo del tipo de IVA aplicado y el total de la factura.
	ldb_iva_fact = dw_lista.GetItemnumber(i,'iva')
	ldb_total_fact = dw_lista.GetItemnumber(i,'total')
	ls_id_factura = dw_lista.GetItemString(i,'id_factura')
	
	ds_lineas_factura.retrieve(ls_id_factura)
	
	for li_j = 1 to ds_lineas_factura.rowcount()
		if ds_lineas_factura.getitemstring(li_j, 'articulo') = g_codigos_conceptos.musaat_variable then
			ls_gen_mov_musaat = 'S'
		end if	
	next	
	ls_serie_defecto = f_obtener_serie_defecto (f_obtener_empresa_factura(ls_id_factura), g_ejercicio)
	
	if ls_serie_defecto = '-1' then
		ls_serie_defecto = g_serie_fases
	end if	
	
	lst_facturas.cod_empresa = f_obtener_empresa_factura(ls_id_factura)
	lst_facturas.tipo_factura = dw_lista.GetItemString(i,'tipo_factura')
	
	If ldb_iva_fact > 0 then 
		// Serie de expediente
		if ldb_total_fact > 0 then 
			//n_fact = f_siguiente_n_fact_emitida(dw_lista.GetItemString(i,'tipo_factura'),g_serie_fases,'',dw_param.GetItemDateTime(1,'fecha'))
			n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas, ls_serie_defecto,'', dw_param.GetItemDateTime(1,'fecha'))
		else 
			// Serie rectificativa de expedientes
		       n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_facturas_negativas_serie,'',dw_param.GetItemDateTime(1,'fecha'))
		end if
	else 
		
		//Trabaja con la serie de musaat. 
		if g_facturar_musaat_pc_serie_aparte = 'S' and ls_gen_mov_musaat = 'S' then 
			// Serie de MUSAAT
			if ldb_total_fact > 0 then 
				n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_fases_serie_musaat,'',dw_param.GetItemDateTime(1,'fecha'))
			// Serie rectificativa de MUSAAT
			else 
				select serie_abono into :ls_serie_abono from csi_series where serie = :g_fases_serie_musaat;
				if not f_es_vacio(ls_serie_abono) then
					//n_fact = f_siguiente_n_fact_emitida(dw_lista.GetItemString(i,'tipo_factura'),ls_serie_abono,'',dw_param.GetItemDateTime(1,'fecha'))
					n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,ls_serie_abono,'',dw_param.GetItemDateTime(1,'fecha'))
				else
					// Si no tiene serie de abono pasa a la misma serie de musaat.
					//n_fact = f_siguiente_n_fact_emitida(dw_lista.GetItemString(i,'tipo_factura'),g_fases_serie_musaat,'',dw_param.GetItemDateTime(1,'fecha'))
					n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_fases_serie_musaat,'',dw_param.GetItemDateTime(1,'fecha'))
				end if	
			end if
		else
			// No trabaja con serie de Musaat. Serie de expediente
			if ldb_total_fact > 0 then 
				//n_fact = f_siguiente_n_fact_emitida(dw_lista.GetItemString(i,'tipo_factura'),g_serie_fases,'',dw_param.GetItemDateTime(1,'fecha'))
					n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,ls_serie_defecto,'',dw_param.GetItemDateTime(1,'fecha'))
			// Serie rectificativa de expedientes
			else 
				// n_fact = f_siguiente_n_fact_emitida(dw_lista.GetItemString(i,'tipo_factura'),g_facturas_negativas_serie,'',dw_param.GetItemDateTime(1,'fecha'))
				n_fact = f_siguiente_n_fact_emitida_empresa(lst_facturas,g_facturas_negativas_serie,'',dw_param.GetItemDateTime(1,'fecha'))
			end if
		end if	
	end if	
	
	// Proforma - Datos
	dw_proforma.InsertRow(0)
	dw_proforma.SetItem(i,'id_factura',ls_id_factura)
	dw_proforma.SetItem(i,'fecha_proforma',dw_lista.GetItemDateTime(i,'fecha'))
	dw_proforma.SetItem(i,'n_fact_proforma',dw_lista.GetItemString(i,'n_fact'))
	dw_proforma.SetItem(i,'pagado_proforma',dw_lista.GetItemString(i,'pagado'))
	dw_proforma.SetItem(i,'f_pago_proforma',dw_lista.GetItemDateTime(i,'f_pago'))
	dw_proforma.SetItem(i,'forma_pago_proforma',dw_lista.GetItemString(i,'formadepago'))
	dw_proforma.SetItem(i,'banco_proforma',dw_lista.GetItemString(i,'banco'))
	dw_proforma.SetItem(i,'contabilizada_proforma',dw_lista.GetItemString(i,'contabilizada'))
	dw_proforma.SetItem(i,'f_conta_proforma',dw_lista.GetItemdatetime(i,'f_conta'))
	dw_proforma.SetItem(i,'anulada_proforma',dw_lista.GetItemString(i,'anulada'))
	dw_proforma.SetItem(i,'fecha',fecha)
	dw_proforma.SetItem(i,'n_fact',n_fact)
	dw_proforma.SetItem(i,'pagado',pagado)
	dw_proforma.SetItem(i,'f_pago',f_pago)
	dw_proforma.SetItem(i,'forma_pago',forma_pago)
	dw_proforma.SetItem(i,'banco',banco)

	// Factura - Datos que cambian 
	dw_lista.SetItem(i,'proforma','N')
	
	dw_lista.SetItem(i,'fecha',fecha)
	dw_lista.SetItem(i,'n_fact',n_fact)
	dw_lista.SetItem(i,'pagado',pagado)
	dw_lista.SetItem(i,'f_pago',f_pago)
	dw_lista.SetItem(i,'formadepago',forma_pago)
	dw_lista.SetItem(i,'banco',banco)
	dw_lista.SetItem(i,'contabilizada','N')
	dw_lista.SetItem(i,'f_conta',ls_null)
	dw_lista.SetItem(i,'anulada','N')
	dw_lista.SetItem(i,'visared','N')
	dw_lista.SetItem(i,'reclamar','S')
	dw_lista.SetItem(i,'emitida','N')	
	dw_lista.SetItem(i,'reimpresa','N')	
	
//	f_genera_factura_cobro(id_informe,formapago,datos_factura.fecha,datos_factura.banco,n_talon,0, pagada)
	f_genera_factura_cobro(ls_id_factura,forma_pago,fecha,banco,ls_null,ldb_total_fact, pagado,f_obtener_empresa_factura(ls_id_factura))
	
		
NEXT


string ls_id_persona, ls_id_linea, ls_empresa, ls_tipo_factura
int li_d
double ldb_ips, ldb_ccs
boolean lb_insertar, lb_eliminar

// CONTROL DEL VALOR DEVUELTO
resp_dw_lista = dw_lista.Update()
resp_dw_proforma = dw_proforma.Update()
IF (resp_dw_lista =1 AND resp_dw_proforma = 1) THEN resp = 1

if resp = 1 then
	ds_lineas_factura.reset()

	FOR i = 1 TO dw_lista.RowCount()
		
		// Dato Variable
		ls_gen_mov_musaat = 'N'
		ls_id_factura = dw_lista.GetItemString(i,'id_factura')
		ls_empresa = dw_lista.GetItemString(i,'empresa')
		ls_id_persona = f_colegiado_id_col(dw_lista.GetItemString(i,'n_col'))
		ls_tipo_factura =dw_lista.GetItemString(i,'tipo_factura')
				
		ds_lineas_factura.retrieve(ls_id_factura)
		
		for li_j = 1 to ds_lineas_factura.rowcount()
			if ds_lineas_factura.getitemstring(li_j, 'articulo') = g_codigos_conceptos.musaat_variable then
				ls_gen_mov_musaat = 'S'
			end if	
			
			if ls_tipo_factura = g_colegio_colegiado then
			
				lb_insertar = true
				
				ls_id_linea = ds_lineas_factura.getitemstring(li_j, 'id_linea')
			
				f_obtener_datos_premaat_fact_emi(ldb_ips, ldb_ccs, ds_lineas_factura.GetItemString(li_j,'articulo'), ls_empresa, ls_id_persona)

				dw_premaat_datos.retrieve(ls_id_factura)
		
				if (ldb_ips > 0 or ldb_ccs > 0) then
					
					for li_d=1 to dw_premaat_datos.rowcount()
		
						if ls_id_linea = dw_premaat_datos.getitemstring(li_d, 'id_linea') then
							lb_insertar = false
							dw_premaat_datos.setitem(li_d, 'ips', ldb_ips)
							dw_premaat_datos.setitem(li_d, 'ccs', ldb_ccs)
							exit
						end if		 
	
					next 

					if lb_insertar then
						i= dw_premaat_datos.insertrow(0)
						dw_premaat_datos.setitem( li_d, 'id_linea', ls_id_linea)
						dw_premaat_datos.setitem( li_d, 'ips', ldb_ips)
						dw_premaat_datos.setitem( li_d, 'ccs', ldb_ccs)
					end if
								
				else 	
					
					for li_d=1 to dw_premaat_datos.rowcount()
						if ls_id_linea = dw_premaat_datos.getitemstring(li_d, 'id_linea') then
							lb_eliminar = true
							exit
						end if	
					next
					
					if lb_eliminar then dw_premaat_datos.deleterow(li_d)
					
				end if	
			end if		 
		next 
		
		dw_premaat_datos.update()
		dw_premaat_datos.reset()
				
		if ls_gen_mov_musaat = 'S' then
			f_musaat_alta_movimiento_facturar(ls_id_factura)  
		end if	
	next	
end if


CloseWithReturn(Parent,resp)


/*create table csi_proforma_a_factura (id_factura char(10) not null, n_fact_proforma char(15) null, n_fact char(15) null, fecha_proforma datetime null, fecha datetime null, pagado_proforma char(1) null, pagado char(1) null, f_pago_proforma datetime null, f_pago datetime null, forma_pago_proforma char(2) null, forma_pago char(2) null, banco_proforma char(10) null, banco char(10) null) ;
alter table csi_proforma_a_factura add constraint csi_proforma_a_factura primary key nonclustered (id_factura) ;*/

end event

type cb_cancelar from commandbutton within w_factufa_proforma_a_factura
integer x = 969
integer y = 1240
integer width = 402
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;// Aceptar devolver$$HEX1$$e100$$ENDHEX$$:
//			1 => Si se han actualizado correctamente los datos de todas las facturas
//			0 => Si no se han actualizado correctamente los datos de todas las facturas
// Cancelar devolver$$HEX1$$e100$$ENDHEX$$:
//			-1 => No se debe realizar ninguna acci$$HEX1$$f300$$ENDHEX$$n desde la ventana que invoc$$HEX2$$f3002000$$ENDHEX$$esta ventana

// Forzamos que cierre sin preguntar confirmaci$$HEX1$$f300$$ENDHEX$$n de cambios
dw_lista.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_proforma.SetItemStatus( 1, 0 , Primary!, NotModified!)

CloseWithReturn(Parent,-1)

end event

type dw_lista from u_dw within w_factufa_proforma_a_factura
integer x = 37
integer y = 608
integer width = 1792
integer height = 576
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_factufa_proforma_procesadas"
end type

event constructor;call super::constructor;of_SetTransObject(SQLCA)
end event

type dw_param from u_dw within w_factufa_proforma_a_factura
integer x = 110
integer y = 32
integer width = 1682
integer height = 576
integer taborder = 10
string dataobject = "d_factufa_proforma_conversion_a_factura"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;/*this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)*/
dw_param.getchild('banco',dwc_bancos)
dwc_bancos.settransobject(SQLCA)
dwc_bancos.retrieve(g_empresa)
end event

event pfc_updatespending;// SOBREESCRITO
return 0
end event

event itemchanged;call super::itemchanged;string ls_null, ls_banco
Datetime f_nula

SetNull(f_nula)
setnull(ls_null)

if dwo.name = 'pagado' then
	if data = 'N' then
		this.setitem(row,'f_pago', f_nula)
	else
		this.SetItem(row,'f_pago',DateTime(Today()))
	end if	
end if	

If dwo.name = 'f_pago' then
	if isnull(data) then
		this.setitem(row, 'pagado', 'N')
	else
		this.setitem(row, 'pagado', 'S')
	end if	
end if	

if dwo.name = 'forma_pago' then
	if dw_lista.getitemstring(1,'empresa') = g_empresa then
			SELECT csi_formas_de_pago.banco_asociado  
			INTO :ls_banco  
			FROM csi_formas_de_pago  
			WHERE csi_formas_de_pago.tipo_pago = :data ;
					
			this.setitem(row, 'banco', ls_banco)
		
		if data='DB' or data='PE' or data='PP' then
			this.setItem(row,'pagado','N')
			this.setItem(row,'f_pago',f_nula)			
		else				
			this.setItem(row,'pagado','S')
			this.setItem(row,'f_pago',datetime(today()))
		end if
	else
				if data='DB' or data='PE' or data='PP' then
			this.setItem(row,'pagado','N')
			this.setItem(row,'f_pago',f_nula)			
		else				
			this.setItem(row,'pagado','S')
			this.setItem(row,'f_pago',datetime(today()))
		end if
	end if
end if
end event

type dw_proforma from u_dw within w_factufa_proforma_a_factura
boolean visible = false
integer x = 1650
integer y = 52
integer width = 1083
integer height = 468
integer taborder = 11
string dataobject = "d_proforma_a_factura"
end type

type dw_premaat_datos from u_dw within w_factufa_proforma_a_factura
boolean visible = false
integer x = 1650
integer y = 52
integer width = 1083
integer height = 468
integer taborder = 21
boolean bringtotop = true
string dataobject = "ds_premaat_datos_fact_emi"
end type

