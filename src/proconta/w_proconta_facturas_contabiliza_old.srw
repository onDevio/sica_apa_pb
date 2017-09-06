HA$PBExportHeader$w_proconta_facturas_contabiliza_old.srw
forward
global type w_proconta_facturas_contabiliza_old from w_sheet
end type
type cb_apuntes from commandbutton within w_proconta_facturas_contabiliza_old
end type
type dw_modo_cont from u_dw within w_proconta_facturas_contabiliza_old
end type
type st_progreso from statictext within w_proconta_facturas_contabiliza_old
end type
type st_cuantas_facturas from statictext within w_proconta_facturas_contabiliza_old
end type
type tab_1 from tab within w_proconta_facturas_contabiliza_old
end type
type tabpage_4 from userobject within tab_1
end type
type dw_facturas from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_facturas dw_facturas
end type
type tabpage_5 from userobject within tab_1
end type
type dw_cobros from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_cobros dw_cobros
end type
type tabpage_3 from userobject within tab_1
end type
type dw_cobros_multiple from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_cobros_multiple dw_cobros_multiple
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cobros_facturas_contabilizadas from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cobros_facturas_contabilizadas dw_cobros_facturas_contabilizadas
end type
type tabpage_apuntes from userobject within tab_1
end type
type dw_apuntes1 from u_dw within tabpage_apuntes
end type
type tabpage_apuntes from userobject within tab_1
dw_apuntes1 dw_apuntes1
end type
type tab_1 from tab within w_proconta_facturas_contabiliza_old
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_apuntes tabpage_apuntes
end type
type dw_fechas from u_dw within w_proconta_facturas_contabiliza_old
end type
type cb_salir from commandbutton within w_proconta_facturas_contabiliza_old
end type
type cb_imprimir_ap from commandbutton within w_proconta_facturas_contabiliza_old
end type
type cb_actualizar from commandbutton within w_proconta_facturas_contabiliza_old
end type
type cb_buscar from commandbutton within w_proconta_facturas_contabiliza_old
end type
end forward

global type w_proconta_facturas_contabiliza_old from w_sheet
integer x = 0
integer y = 0
integer width = 4293
integer height = 1804
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n Facturas Pendientes"
string menuname = "m_proconta_facturas_contabiliza"
windowstate windowstate = maximized!
cb_apuntes cb_apuntes
dw_modo_cont dw_modo_cont
st_progreso st_progreso
st_cuantas_facturas st_cuantas_facturas
tab_1 tab_1
dw_fechas dw_fechas
cb_salir cb_salir
cb_imprimir_ap cb_imprimir_ap
cb_actualizar cb_actualizar
cb_buscar cb_buscar
end type
global w_proconta_facturas_contabiliza_old w_proconta_facturas_contabiliza_old

type variables
u_dw idw_facturas, idw_cobros, idw_cobros_multiples, idw_cobros_facturas_contabilizadas, idw_apuntes

long i_asiento_exp, i_asiento_ot, i_asiento_cobros_mult, i_asiento_rem

long il_coord_x =0 , il_coord_y =0 ,il_tamanyo_x =0 , il_tamanyo_y =0 

boolean ib_comprobadas_variables = false
end variables

forward prototypes
public subroutine wf_preproceso ()
public function long wf_verificar_facturas ()
public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida)
public function boolean wf_comprobar_si_cambiar_asiento (string modo_contabilizacion, string n_remesa, string n_remesa_old, string id_fase, string id_minuta, string id_fase_old, string id_minuta_old)
end prototypes

public subroutine wf_preproceso ();//Revisi$$HEX1$$f300$$ENDHEX$$n datos generales contabilidad
if f_es_vacio(g_conta.concepto_exp) then g_conta.concepto_exp = 'Exp'
if f_es_vacio(g_conta.concepto_rv) then g_conta.concepto_rv = 'RV'
if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_conta.ret_vol) then g_conta.ret_vol = 'C'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'
if f_es_vacio(g_prefijo_arqui_iva) then g_prefijo_arqui_iva = g_prefijo_arqui
if f_es_vacio(g_prefijo_arqui_rf) then g_prefijo_arqui_rf = g_prefijo_arqui

end subroutine

public function long wf_verificar_facturas ();long i, fila_cobro, fila_cobro_multiple
boolean b_error = false
long retorno = 1

// Modificado Ricardo 2005-04-28
// Miramos si todas las facturas y dem$$HEX1$$e100$$ENDHEX$$s est$$HEX1$$e100$$ENDHEX$$n dentro del ejercicio actual
st_progreso.text = 'Buscando si hay facturas de otros ejercicios'
st_progreso.visible = true

// Miramos las facturas
for i = 1 to idw_facturas.RowCount()
	// Le decimos por donde vamos
	yield()
	if string(year(date(idw_facturas.GetItemDatetime(i, 'fecha'))))<>g_ejercicio then
		Messagebox(g_titulo, "Alguna de las facturas a contabilizar no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		b_error = true
		retorno = -1
		st_progreso.text = ''
		exit
	end if
next
return retorno

// Miramos los cobros de las facturas
FOR fila_cobro = 1 TO idw_cobros.RowCount()
	if string(year(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago'))))<>g_ejercicio then
		Messagebox(g_titulo, "Alguno de los cobros de las facturas a contabilizar no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		b_error = true
		retorno = -1
		st_progreso.text = ''
		exit
	end if		
NEXT
return retorno

// Miramos los cobros multiples
FOR fila_cobro_multiple = 1 TO idw_cobros_multiples.RowCount()
	if string(year(date(idw_cobros_multiples.GetitemDatetime(fila_cobro_multiple, 'csi_cobros_multiples_fecha'))))<>g_ejercicio then
		Messagebox(g_titulo, "Alguno de los cobros m$$HEX1$$fa00$$ENDHEX$$ltiples a contabilizar no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		b_error = true
		retorno = -1
		st_progreso.text = ''
		exit
	end if		
NEXT
st_progreso.text = ''
return retorno

// Miramos los cobros de facturas contabilizadas
FOR fila_cobro = 1 TO idw_cobros_facturas_contabilizadas.RowCount()
	if string(year(date(idw_cobros_facturas_contabilizadas.GetItemDateTime(fila_cobro,'csi_cobros_f_pago'))))<>g_ejercicio then
		Messagebox(g_titulo, "Alguno de los cobros de facturas contabilizadas no pertenece al ejercicio actual. El proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n ha sido cancelado.", stopsign!)
		b_error = true
		retorno = -1
		st_progreso.text = ''
		exit
	end if		
NEXT
return retorno


if b_error then retorno = -1 else retorno = 1
return retorno


end function

public subroutine wf_crear_apunte (datetime fecha, string cuenta, string concepto, double debe, double haber, string orden_apunte, string contrapartida);// Generacion del apunte
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
g_apunte.cuenta = cuenta
g_apunte.concepto = trim(concepto)
g_apunte.debe = debe
g_apunte.haber = haber
g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
g_apunte.orden_apunte = orden_apunte
g_apunte.contrapartida = contrapartida
f_apunte_dw(g_apunte,idw_apuntes,'E')


end subroutine

public function boolean wf_comprobar_si_cambiar_asiento (string modo_contabilizacion, string n_remesa, string n_remesa_old, string id_fase, string id_minuta, string id_fase_old, string id_minuta_old);// CReada por ricardo 2005-03-07
// funcion encargada de averiguar cuando toca cambiar de asiento contable!
// FALLA EN EL SIGUIENTE CASO:> cuando se pasa de no remesa a remesa, con el modo 'R' y con asientos en diferentes diarios



boolean anterior_ot, actual_ot

// En el modo de 2 apuntes por cobro, no influyen las remesas!
if modo_contabilizacion = 'N' then 
	n_remesa = ''
	n_remesa_old = ''
end if


// Si lleva numero de remesa y estamos en el modo que cada vez que cambie de remesa se cambia de numero, decimos que hay que cambiar
if not f_es_vacio(n_remesa) then 
	if n_remesa_old = n_remesa then return false
	if (modo_contabilizacion = 'A')  and n_remesa_old <> n_remesa then
		return true
	end if
	// Falta por definir este caso... Cuando se pase de una sin remesa a una con remesa!
	anterior_ot = (f_es_vacio(id_fase_old) and f_es_vacio(id_minuta_old))
	if anterior_ot then
		if g_sica_diario.facts_emitidas_ot <> g_sica_diario.remesas then
			return true
		else
			return false
		end if
	else
		if g_sica_diario.facts_emitidas_exp <> g_sica_diario.remesas then
			return true
		else
			return false
		end if
	end if
else
	// No hay numero de remesa, luego, solo si hay asientos diferentes toca cambiar de asiento
	if g_sica_diario.facts_emitidas_ot <> g_sica_diario.facts_emitidas_exp then
		anterior_ot = (f_es_vacio(id_fase_old) and f_es_vacio(id_minuta_old))
		actual_ot = (f_es_vacio(id_fase) and f_es_vacio(id_minuta))
		
		if anterior_ot<>actual_ot then 
			// PAsamos de una de expediente a una que no o viceversa
			return true 
		else 
			// SE mantiene donde estaba por lo que no se cambia
			return false
		end if
	else
		// Si es el mismo diario, no hace falta cambiar de asiento
		return false
	end if
end if


		
return true
end function

on w_proconta_facturas_contabiliza_old.create
int iCurrent
call super::create
if this.MenuName = "m_proconta_facturas_contabiliza" then this.MenuID = create m_proconta_facturas_contabiliza
this.cb_apuntes=create cb_apuntes
this.dw_modo_cont=create dw_modo_cont
this.st_progreso=create st_progreso
this.st_cuantas_facturas=create st_cuantas_facturas
this.tab_1=create tab_1
this.dw_fechas=create dw_fechas
this.cb_salir=create cb_salir
this.cb_imprimir_ap=create cb_imprimir_ap
this.cb_actualizar=create cb_actualizar
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apuntes
this.Control[iCurrent+2]=this.dw_modo_cont
this.Control[iCurrent+3]=this.st_progreso
this.Control[iCurrent+4]=this.st_cuantas_facturas
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.dw_fechas
this.Control[iCurrent+7]=this.cb_salir
this.Control[iCurrent+8]=this.cb_imprimir_ap
this.Control[iCurrent+9]=this.cb_actualizar
this.Control[iCurrent+10]=this.cb_buscar
end on

on w_proconta_facturas_contabiliza_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_apuntes)
destroy(this.dw_modo_cont)
destroy(this.st_progreso)
destroy(this.st_cuantas_facturas)
destroy(this.tab_1)
destroy(this.dw_fechas)
destroy(this.cb_salir)
destroy(this.cb_imprimir_ap)
destroy(this.cb_actualizar)
destroy(this.cb_buscar)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

// Colocamos los valores de las variables de instancia
idw_facturas				= tab_1.tabpage_4.dw_facturas
idw_cobros					= tab_1.tabpage_5.dw_cobros
idw_cobros_multiples		= tab_1.tabpage_3.dw_cobros_multiple
idw_cobros_facturas_contabilizadas = tab_1.tabpage_1.dw_cobros_facturas_contabilizadas
idw_apuntes				= tab_1.tabpage_apuntes.dw_apuntes1

// Regristramos los reescalados que deben haber en la ventana
inv_resize.of_register (st_cuantas_facturas, "fixedtoright&bottom")
inv_resize.of_register (st_progreso, "fixedtoright&bottom")
inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (idw_facturas, "scaletoright&bottom")
inv_resize.of_register (idw_cobros, "scaletoright&bottom")
inv_resize.of_register (idw_cobros_multiples, "scaletoright&bottom")
inv_resize.of_register (idw_cobros_facturas_contabilizadas, "scaletoright&bottom")
inv_resize.of_register (idw_apuntes, "scaletoright&bottom")

//Botonera
inv_resize.of_register (cb_buscar, "fixedtobottom")
inv_resize.of_register (cb_apuntes, "fixedtobottom")
inv_resize.of_register (cb_actualizar, "fixedtobottom")
inv_resize.of_register (cb_imprimir_ap, "fixedtobottom")
inv_resize.of_register (cb_salir, "fixedtobottom")

// Colocamos una linea en el dw que consulta
dw_fechas.Event pfc_addrow( )
dw_fechas.SetItem(1,'f_inicio',date(string(Today())))
dw_fechas.SetItem(1,'f_fin',date(string(Today())))
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		dw_fechas.setitem(1, 'resumida', 'S')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'N')
	CASE 'COAATZ'
		dw_fechas.setitem(1, 'resumida', 'N')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'S')
	CASE ELSE
		dw_fechas.setitem(1, 'resumida', 'N')
		dw_fechas.setitem(1, 'aglutinar_iva_conceptos', 'N')
END CHOOSE



end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')

end event

event closequery;//SOBREESCRITO...

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("", &
					gnv_app.iapp_object.DisplayName, &
					"La informaci$$HEX1$$f300$$ENDHEX$$n introducida no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n "  + &
					"y debe ser corregida antes de que se salven los cambios.~r~n~r~n" + &
					"$$HEX1$$bf00$$ENDHEX$$Desea salir sin grabar?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"$$HEX1$$bf00$$ENDHEX$$Desea grabar los cambios?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
//			If This.Event pfc_save() >= 1 Then
				// Se debe grabar pinchando en el bot$$HEX1$$f300$$ENDHEX$$n sino no se actuliza el n$$HEX2$$ba002000$$ENDHEX$$de asiento por ejemplo
				cb_actualizar.TriggerEvent(Clicked!)
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
//			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_proconta_facturas_contabiliza_old
integer y = 2048
integer taborder = 0
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_proconta_facturas_contabiliza_old
integer y = 1928
integer taborder = 0
end type

type cb_apuntes from commandbutton within w_proconta_facturas_contabiliza_old
string tag = "&Apuntes"
integer x = 407
integer y = 1428
integer width = 366
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Generar Ap."
end type

event clicked;if f_puedo_escribir(g_usuario,'0000000008')=-1 then return -1
// No permitimos que nos vuelvan a pinchar hasta que acabemos
//this.enabled = false
if idw_facturas.RowCount()>500 then
	if messageBox(g_titulo, "Dada la gran cantidad de facturas, para agilizar el proceso, $$HEX1$$bf00$$ENDHEX$$desea NO MOSTRAR los apuntes hasta finalizado el proceso?", question!,yesno!,1)=1 then idw_apuntes.setredraw(false)
end if

////////////////////////////////////////////////////////////////////////////////
// 								VARIABLES
////////////////////////////////////////////////////////////////////////////////

// Variables para llevar a cabo la opcion resumida
boolean b_resumida, b_aglutinar_iva_conceptos = false, b_aglutinar_irpf = false
double importe_apunte_resumido

long i, j, k, fila_cobro, fila_cobro_multiple
datetime fecha, fecha_pago_cobro
string tipo_factura, n_expedi, id_fase, id_minuta, id_factura, pagado, formadepago,banco,id_col, n_factura, cliente, ctabanco, n_visado, id_fase_old, id_minuta_old
string nif, nombre, concepto, concepto_base, concepto_numeracion, cuenta_col, cuenta_ret,cuenta_irpf, cuenta_cp
string tipo_pago, t_iva, concepto_garantia, orden_apunte, concepto_cobro_a_cuenta
double total, subtotal, importe_reten, subtotal_iva, importe_garantia, t_ret_vol, importe_ret_vol, base_imp, importe_cobro_a_cuenta, descuento
boolean b_continuar, b_dv_pdtes_abono
// Variables para las lineas de las facturas
double linea_subtotal, linea_iva, linea_dto
String linea_t_iva, linea_cuenta, linea_cuenta_presupuestaria, linea_proyecto, linea_concepto_conta,linea_familia
Boolean b_HayIngreso
// VAriables para el iva
double imp_iva
string concepto_iva, cuenta_iva
// VAriables para los cobros
string forma_pago_cobro, pagado_cobro, ctabanco_cobro, tipo_pago_cobro, banco_cobro, concepto_cobro
double total_cobro 
boolean b_HayIngresoCobro
// Variables para los cobros multiples
string forma_pago_cobro_multiple, banco_cobro_multiple, tipo_pago_cobro_multiple, ctabanco_cobro_multiple, concepto_cobro_multiple
string id_cobro_multipl_ant, id_cobro_multiple
double total_cobro_multiple
boolean b_HayIngresoCobroMultiple
datetime fecha_pago_cobro_multiple
// Variables para los cobros de facturas contabilizadas
string tipo_documento_remesa, modo_contabilizacion, n_remesa, n_remesa_old = '-1', id_persona, contabilizado_fact
double total_remesa, total_asiento, saltados
boolean b_cambiar_asiento

SetPointer(Hourglass!)
// Nos aseguramos de haber elegido la forma de contabilizacion ultima
dw_modo_cont.accepttext()
// Cogemos el modo de contabilizacion
b_resumida = (dw_fechas.getitemString(1, 'resumida') ='S')
b_aglutinar_iva_conceptos = (dw_fechas.getitemString(1, 'aglutinar_iva_conceptos') ='S')
b_aglutinar_irpf = (dw_fechas.getitemString(1, 'aglutinar_irpf') ='S')


// DATASTORE PARA PROCESAR LAS LINEAS DE FACTURA (SOLO EN GASTOS)
Datastore ds_lineas
ds_lineas = create datastore
ds_lineas.DataObject = 'd_conta_lineas_fact_emitidas'
ds_lineas.SetTransObject(SQLCA)
// DAtastore para almacenar los tipos de iva y el importe asociado a cada uno de ellos por factura
Datastore ds_iva
ds_iva = create datastore
ds_iva.DataObject = 'd_conta_d_contab_iva'
ds_iva.SetTransObject(SQLCA)
ds_iva.Retrieve()

// Funcion que pone algunos valores por defecto a variables globales que no tienen
wf_preproceso()

// Cogemos los numeros de asientos correspondientes
i_asiento_exp = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp,7))
i_asiento_ot = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot,7))
i_asiento_rem = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.remesas,7))
i_asiento_cobros_mult = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.cobros_multiples,7))
i_asiento_exp = i_asiento_exp - 1
i_asiento_ot = i_asiento_ot - 1
i_asiento_rem = i_asiento_rem - 1
i_asiento_cobros_mult = i_asiento_cobros_mult - 1
// Evitamos los nulos
if isnull(i_asiento_exp) then i_asiento_exp = 0
if isnull(i_asiento_ot) then i_asiento_ot = 0
if isnull(i_asiento_rem) then i_asiento_rem = 0
if isnull(i_asiento_cobros_mult) then i_asiento_cobros_mult = 0

// Algunos datos genericos
select concepto_conta into :concepto_garantia from csi_articulos_servicios where codigo = :g_conta.garantia_codigo_articulo;
select concepto_conta into :concepto_cobro_a_cuenta from csi_articulos_servicios where codigo = :g_codigos_conceptos.cobro_a_cuenta;
 

idw_apuntes.reset()// Vaciamos los apuntes!
this.enabled = false
idw_facturas.AcceptText()
for i = 1 to idw_facturas.RowCount()
	// Le decimos por donde vamos
	st_progreso.text = 'Procesando ' + string(i) + ' de ' + string(idw_facturas.RowCount())+' facturas. '+string(idw_apuntes.RowCount())+' apuntes generados.'
	yield()
	
	//Preproceso necesario para el c$$HEX1$$e100$$ENDHEX$$lculo de IVA totalizado por tipo
	FOR k=1 TO ds_iva.RowCount()
		ds_iva.SetItem(k,'importe',0)
		ds_iva.SetItem(k,'base_imp',0)
	NEXT
	//Fin preproceso IVA/IGIC
	importe_apunte_resumido = 0
	b_dv_pdtes_abono = false
	
	//Marcamos la factura como contabilizada
	idw_facturas.SetItem(i,'contabilizada','S')
	idw_facturas.SetItem(i,'f_conta',idw_facturas.GetItemDatetime(i, 'fecha'))

	//Obtenci$$HEX1$$f300$$ENDHEX$$n de DATOS COMUNES A FACTURAS DE HONORARIOS Y DE GASTOS:
	fecha = idw_facturas.GetItemDatetime(i, 'fecha')
	tipo_factura = idw_facturas.GetItemString(i,'tipo_factura')
	formadepago = upper(idw_facturas.GetItemString(i,'formadepago'))
	banco = idw_facturas.GetItemString(i,'banco')
	id_factura = idw_facturas.GetItemString(i,'id_factura')
	n_factura = idw_facturas.GetItemString(i,'n_fact')
	n_expedi = idw_facturas.GetItemString(i,'expedientes_n_expedi')+'-'+idw_facturas.GetItemString(i,'fases_fase')
	id_fase = idw_facturas.GetItemString(i,'id_fase')
	id_minuta = idw_facturas.GetItemString(i,'id_minuta')
	nif = idw_facturas.GetItemString(i,'nif')
	nombre = idw_facturas.GetItemString(i,'nombre')
	orden_apunte = idw_facturas.GetItemString(i,'orden_apunte')
	id_col  = idw_facturas.GetItemString(i,'emisor')
	cliente = idw_facturas.GetItemString(i,'nombre')
	//Importes:
	total = idw_facturas.GetItemNumber(i,'total')
	subtotal = idw_facturas.GetItemNumber(i,'subtotal')
	descuento = idw_facturas.GetItemNumber(i,'descuento')
	if isnull(descuento) then descuento = 0
	if descuento <> 0 then subtotal = subtotal - descuento	
	base_imp = idw_facturas.GetItemNumber(i,'base_imp')
	importe_reten = idw_facturas.GetItemNumber(i,'importe_reten')
	subtotal_iva = idw_facturas.GetItemNumber(i,'iva')

	// Obtenemos algunos datos adicionales
	select hay_ingreso into :tipo_pago from csi_formas_de_pago where tipo_pago = :formadepago;
	b_HayIngreso = (upper(tipo_pago) = 'S')
	//Banco y su cuenta contable:
	select cuenta_contable into :ctabanco from csi_bancos where codigo = :banco;

	//Rellenamos DATOS GENERALES DE G_APUNTE
	// Hay datos que son condicionales a que sea o no una factura relacionada con un contrato
	concepto = ''
	concepto_base = ''
	if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
		i_asiento_ot++
		g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_ot)),7)
		g_apunte.diario = g_sica_diario.facts_emitidas_ot
		g_apunte.t_doc = g_sica_t_doc.facts_emitidas_ot
		// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
		// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_ot = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
		// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem++
		concepto_numeracion = ''
	else
		CHOOSE CASE g_colegio
			CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA'
				// Quieren el numero de visado
				n_visado = idw_facturas.GetItemString(i,'fases_archivo_real')
				concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' + n_visado
				concepto_numeracion = concepto_base
			CASE ELSE
				concepto_base = g_conta.concepto_exp +' ' + n_expedi
				concepto_numeracion = concepto_base				
		END CHOOSE
		i_asiento_exp++
		g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_exp)),7)
		g_apunte.diario = g_sica_diario.facts_emitidas_exp
		g_apunte.t_doc = g_sica_t_doc.facts_emitidas_exp
		// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
		// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_exp = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
		// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
		if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem++
	end if
	g_apunte.n_apunte = '00000'
	g_apunte.n_doc = n_factura
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	g_apunte.id_interno = id_factura
	// El tipo de documento deber$$HEX1$$ed00$$ENDHEX$$a ir vinculado a la serie y al concepto, tomando preferentemente este $$HEX1$$fa00$$ENDHEX$$ltimo.
	g_apunte.centro = idw_facturas.GetItemString(i,'centro')
	if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto
	g_apunte.proyecto = g_explotacion_por_defecto
	g_apunte.nif = nif
	g_apunte.nombre = nombre
	g_apunte.orden_apunte = orden_apunte

	// Le incrementamos al concepto base con el cliente
	concepto_base = concepto_base + ' ' + cliente
	
	/////////////////////////////////////////
	// PROCESAMOS LAS LINEAS DE LAS FACTURAS
	/////////////////////////////////////////
	CHOOSE CASE tipo_factura
		CASE '04' //FACTURA DE HONORARIOS : COLEGIADO A CLIENTE 
			// NO se procesan las lineas de este tipo de facturas
		CASE ELSE
			// Averiguamos la cuenta sobre la que tenemos que procesar....Depende del tipo de factura
			CHOOSE CASE tipo_factura
				CASE '03' //FACTURA DE GASTOS A COLEGIADO:
					id_col = idw_facturas.GetItemString(i,'id_persona')
					cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
					cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
					cuenta_cp = f_dame_cuenta_col(id_col,'CP')	// cp
				CASE '02' //FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE
					id_col = idw_facturas.GetItemString(i,'id_persona')
					cuenta_col = ''
					cuenta_cp = ''
					//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
					// Modificado Ricardo 2005-11-10
					cuenta_col = f_clientes_cuenta_contable(id_col)
//					select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_col;
//					if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
//						cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_col)
//					elseif f_es_vacio(cuenta_col) then
//						cuenta_col = g_conta.cuenta_clientes_general
//					end if
					// fin Modificado Ricardo 2005-11-10
					b_dv_pdtes_abono = (formadepago =g_formas_pago.pendientes_abono)
			END CHOOSE

			//Procesamos las l$$HEX1$$ed00$$ENDHEX$$neas de facturas (S$$HEX1$$f300$$ENDHEX$$lo en facturas de gastos):
			ds_lineas.Retrieve(id_factura) // -> ESto es mejorable retriveando todas al principio y con filtros
			FOR j=1 TO ds_lineas.RowCount()
				//Lo primero, leemos los datos de las l$$HEX1$$ed00$$ENDHEX$$neas
				linea_subtotal = ds_lineas.GetItemNumber(j,'subtotal')
				linea_dto = ds_lineas.GetItemNumber(j,'importe_dto')
				if isnull(linea_dto) then linea_dto = 0
				if linea_dto <> 0 then linea_subtotal = linea_subtotal - linea_dto				
				linea_iva = f_redondea(ds_lineas.GetItemNumber(j,'subtotal_iva'));if isnull(linea_iva) then linea_iva = 0
				linea_t_iva = ds_lineas.GetItemString(j,'t_iva')
				linea_cuenta = ds_lineas.GetItemString(j,'cuenta')
				linea_cuenta_presupuestaria = ds_lineas.GetItemString(j,'cuenta_presupuestaria')
				linea_proyecto = ds_lineas.GetItemString(j,'proyecto'); if f_es_vacio(linea_proyecto) then linea_proyecto = g_explotacion_por_defecto
				linea_familia = ds_lineas.GetItemString(j,'familia')
				//Las siguiente 3 lineas para prefijar los conceptos en funci$$HEX1$$f300$$ENDHEX$$n del articulo/servicio
				linea_concepto_conta = ds_lineas.GetItemString(j,'concepto_conta')
				if isnull(linea_concepto_conta) then linea_concepto_conta = ''
				linea_concepto_conta = trim(linea_concepto_conta) + ' '
				// Fijamos el concepto		
				if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
					concepto = LeftA(linea_concepto_conta + ds_lineas.GetItemString(j,'descripcion_larga'),57)
					// INC. 6555 - Que aparezca el nombre del colegiado en el asiento del extorno
					if PosA(upper(ds_lineas.GetItemString(j,'descripcion_larga')), "EXTORNO")>0 then
						concepto = LeftA(ds_lineas.GetItemString(j,'descripcion_larga') + ' ' + nombre  ,57)
					end if
				else
					concepto = LeftA(linea_concepto_conta + concepto_base,57)
				end if
				
				//Datos anal$$HEX1$$ed00$$ENDHEX$$ticos:
				g_apunte.proyecto = linea_proyecto
				
				//Si la cuenta es 'RV' quiere decir que la retenci$$HEX1$$f300$$ENDHEX$$n voluntaria
				//aparece en l$$HEX1$$ed00$$ENDHEX$$neas de factura (COAPAs y alg$$HEX1$$fa00$$ENDHEX$$n COARQ)
				if linea_cuenta = 'RV' then
					if cuenta_cp <> cuenta_col then
						wf_crear_apunte(fecha, cuenta_cp, concepto, 0, linea_subtotal, orden_apunte, '')
						importe_apunte_resumido+=linea_subtotal
					else
						//Ret Vol: al debe de la cuenta de honorarios
						wf_crear_apunte(fecha, cuenta_col, concepto, linea_subtotal, 0, orden_apunte, Cuenta_ret)
						//Ret Vol: al haber de las retenciones
	//					if cuenta_cp <> cuenta_col then
	//						wf_crear_apunte(fecha, cuenta_cp,concepto, 0, linea_subtotal, orden_apunte, cuenta_col)
	//					else
						wf_crear_apunte(fecha, Cuenta_ret, 'Ret. Vol Ingreso Cuenta', 0, linea_subtotal, orden_apunte, cuenta_col)
	//					end if
					end if
				else
					//APUNTE DEL INGRESO Y LA CONTRAP. A CUENTA COLEGIADO.
					if tipo_factura = '03' and (linea_familia ='01' or linea_familia = '02' or linea_familia = 'GA') then
						// En este caso quieren que aparezca el nombre del colegiado
						//MODIF PACO 5/4/2005: Para que salga el n$$HEX1$$fa00$$ENDHEX$$mero de visado tambi$$HEX1$$e900$$ENDHEX$$n. 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado
						wf_crear_apunte(fecha, linea_cuenta, linea_concepto_conta+' ' +concepto_numeracion+' '+nombre+' ['+idw_facturas.GetItemString(i,'n_col')+']', 0, linea_subtotal, orden_apunte, cuenta_col)
					else
						wf_crear_apunte(fecha, linea_cuenta, concepto, 0, linea_subtotal, orden_apunte, cuenta_col)
					end if
					// En el caso de facturas pendientes de abono, cambiamos el concepto
					if b_dv_pdtes_abono then concepto = 'Dchos. V$$HEX2$$ba002000$$ENDHEX$$pdtes. '+concepto

					if not b_resumida then
						//CONTRAPARTIDA AL COLEGIADO: (Si se aglutina el iva, incrementamos la cantidad con el iva)
						if b_aglutinar_iva_conceptos then 
							wf_crear_apunte(fecha, cuenta_col, concepto, linea_subtotal+linea_iva, 0, orden_apunte, linea_cuenta)
						else
							wf_crear_apunte(fecha, cuenta_col, concepto, linea_subtotal, 0, orden_apunte, linea_cuenta)
						end if
					else
						// Vamos incrementando el total para la resumida
						importe_apunte_resumido+=linea_subtotal
					end if
				end if
				
				//Proceso para acumular el importe para cada tipo de IVA/IGIC
				if linea_iva = 0 or isnull(linea_iva) then continue //Si no hay IVA nos vamos a la siguiente linea
				FOR k=1 TO ds_iva.RowCount()
					if linea_t_iva <> ds_iva.GetItemString(k,'t_iva') then continue
					ds_iva.SetItem(k,'importe',ds_iva.GetItemNumber(k,'importe') + linea_iva)
					// Almacenamos tambien la base imponible
					ds_iva.SetItem(k,'base_imp',ds_iva.GetItemNumber(k,'base_imp') + linea_subtotal)
				NEXT
				//Fin proceso acumulaci$$HEX1$$f300$$ENDHEX$$n IVA/IGIC
			Next //Lineas de factura (j)
	END CHOOSE

	
	///////////////////////////////////////////
	///////////////////////////////////////////
	//     CONTABILIZACION DE LA FACTURA
	///////////////////////////////////////////
	///////////////////////////////////////////
	CHOOSE CASE tipo_factura
		CASE '04' //FACTURA DE HONORARIOS : COLEGIADO A CLIENTE
			b_continuar = true
			
			cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
			cuenta_cp = f_dame_cuenta_col(id_col,'CP')
			
			CHOOSE CASE formadepago 
				CASE g_formas_pago.otras_entidades
					// Este es especial para zaragoza... VA apunte y contraapunte por el total a la cuenta del colegiado :O
					wf_crear_apunte(fecha, cuenta_col, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
					wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva, 0, orden_apunte, '')
					
					b_continuar = false				
				CASE g_formas_pago.autoliquidacion
					// En las autoliquidaciones.... Para zaragoza... Apunte y contraapunte a la cuenta del colegiado
					CHOOSE CASE g_colegio
						CASE 'COAATZ', 'COAATLE', 'COAATAVI'
							// Este es especial para zaragoza... VA apunte y contraapunte por el total a la cuenta del colegiado :O
							wf_crear_apunte(fecha, cuenta_col, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
							wf_crear_apunte(fecha, cuenta_col, 'IRPF ' +concepto_base, importe_reten, 0, orden_apunte, '')
							wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva - importe_reten, 0, orden_apunte, '')
						CASE ELSE
							// Deshacemos el que corra un numero de asiento para nada
							if f_es_vacio(idw_facturas.GetItemString(i, 'id_fase')) and f_es_vacio(idw_facturas.GetItemString(i, 'id_minuta')) then
								i_asiento_ot --
								// Si el diario de exp es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp --
								// Si el diario de cobros multiples es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.cobros_multiples then i_asiento_cobros_mult --
								// Si el diario de remesas es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem --
							else
								i_asiento_exp --
								// Si el diario de exp es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot --
								// Si el diario de cobros multiples es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.cobros_multiples then i_asiento_cobros_mult --
								// Si el diario de remesas es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.remesas then i_asiento_rem --
							end if
					END CHOOSE
					b_continuar = false
				CASE g_formas_pago.pendientes_abono
					// Este es especial para zaragoza... 
					// Tenemos que montarnos un proceso especial para estas facturas. 
					// -> VA apunte y contraapunte por el total a la cuenta del colegiado :O
					// -> apunte contra la 44100001 y contraapunte por el total a la cuenta especial del colegiado :O (con prefijo 4130)
					concepto = 'Hon.pdtes.'+concepto_base
					wf_crear_apunte(fecha, cuenta_col, concepto, subtotal+subtotal_iva, 0, orden_apunte, '')
					wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal+subtotal_iva, orden_apunte, '')
					cuenta_col = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
					wf_crear_apunte(fecha, g_cuenta_puente_pendiente_abono_hon, concepto, subtotal+subtotal_iva, 0, orden_apunte, cuenta_col)
					wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal+subtotal_iva, orden_apunte, g_cuenta_puente_pendiente_abono_hon)
	
					b_continuar = false
				CASE ELSE
					if isnull(formadepago) then
						// En las nulas
						CHOOSE CASE g_colegio
							CASE 'COAATZ', 'COAATLE', 'COAATAVI'
								// Este es especial para zaragoza... VA apunte y contraapunte por el total a la cuenta del colegiado :O
								wf_crear_apunte(fecha, cuenta_col, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
								wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva, 0, orden_apunte, '')
								b_continuar = false
							CASE ELSE
								// DE momento hago lo mismo
								// Este es especial para zaragoza... VA apunte y contraapunte por el total a la cuenta del colegiado :O
								wf_crear_apunte(fecha, cuenta_col, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
								wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva, 0, orden_apunte, '')
								b_continuar = false
						END CHOOSE
					else
						// SEgun si hay increso o no
						b_continuar = b_HayIngreso
						if not b_HayIngreso then
							if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
								i_asiento_ot --
								// Si el diario de exp es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp --
								// Si el diario de cobros multiples es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.cobros_multiples then i_asiento_cobros_mult --
								// Si el diario de remesas es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem --
							else
								i_asiento_exp --
								// Si el diario de exp es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot --
								// Si el diario de cobros multiples es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.cobros_multiples then i_asiento_cobros_mult --
								// Si el diario de remesas es el mismo, hay que decrementar la otra variable tambien
								if g_sica_diario.facts_emitidas_exp = g_sica_diario.remesas then i_asiento_rem --
							end if
						end if
					end if
			END CHOOSE
			
			if b_continuar then
				//Obtenemos las cuentas del colegiado. En las funciones debe estar el c$$HEX1$$f300$$ENDHEX$$digo de creaci$$HEX1$$f300$$ENDHEX$$n de cuentas y ver si procede su utilizaci$$HEX1$$f300$$ENDHEX$$n.
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_cp = f_dame_cuenta_col(id_col,'CP')
				cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
				cuenta_iva = f_dame_cuenta_col(id_col,'I') 	//IVA
				
				
				// Averiguamos la suma total de garantias
				importe_garantia = 0
				select sum(total) into :importe_garantia from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_conta.garantia_codigo_articulo;
				// Miramos los cobros a cuenta de la factura

				importe_cobro_a_cuenta = 0
				select sum(total) into :importe_cobro_a_cuenta from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_codigos_conceptos.cobro_a_cuenta;
				CHOOSE CASE g_colegio
					CASE 'COAATGUI'
						// Si el Colegio es Gipuzkoa se resta ( o mejor suma ) la provisi$$HEX1$$f300$$ENDHEX$$n de fondos al subtotal
						if importe_garantia <> 0 then
							subtotal = f_redondea(subtotal - importe_garantia) 
						end if
					CASE 'COAATZ', 'COAATLE'
						// Si el Colegio es zaragoza que la garantia vaya aglutinada tambien
						if importe_garantia <> 0 then
							subtotal = f_redondea(subtotal - importe_garantia) 
						end if
						// Quieren que vaya aglutinado, as$$HEX2$$ed002000$$ENDHEX$$que se lo 'restamos' al total
						if importe_cobro_a_cuenta <> 0 then
							subtotal = f_redondea(subtotal - importe_cobro_a_cuenta) 
						end if
				END CHOOSE
						
				// En el caso que el colegiado tuviese retencion voluntaria calculamos la parte que le corresponde
				t_ret_vol = 0
				importe_ret_vol = 0
				if g_conta.ret_vol = 'C' then
					//Ver si tiene retenci$$HEX1$$f300$$ENDHEX$$n voluntaria:
					select ret_voluntaria into :t_ret_vol from colegiados where id_colegiado = :id_col;
					if isnull(t_ret_vol) then t_ret_vol = 0
					importe_ret_vol = round(subtotal * t_ret_vol / 100 , 2)
				end if
				
				//Para ver la descripcion del tipo de IVA en las facturas de honorarios,
				//miramos la l$$HEX1$$ed00$$ENDHEX$$nea de la factura cuyo art$$HEX1$$ed00$$ENDHEX$$culo es 'HO' (espero que valga para aparejadores)
				select t_iva into :t_iva from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_codigos_conceptos.honorarios;
				select descripcion into :concepto_iva from csi_t_iva where t_iva = :t_iva;
	
				//Ahora hacemos los 7 posibles apuntes de una factura de honorarios:
				// Honorarios (base) (en zaragoza siempre la resumida para honorarios)
				if not b_aglutinar_iva_conceptos and (not b_resumida or (b_resumida and cuenta_col<>cuenta_iva)) then
					concepto = LeftA('Hon ' + concepto_base,57)
					// POr el total de los honorarios
					wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal, orden_apunte, '')
					// IVA: al haber de la cuenta de iva
					concepto = LeftA(concepto_iva + ' Hon ' + concepto_base,57)
					g_apunte.base_imp = base_imp
					g_apunte.nombre = cliente
					g_apunte.nif = idw_facturas.GetItemString(i, 'nif')
					g_apunte.t_iva = t_iva
					wf_crear_apunte(fecha, cuenta_iva, concepto, 0, subtotal_iva, orden_apunte, '')
					g_apunte.base_imp = 0
				else
					// Ponemos la cuenta de irpf en esta variable					
					CHOOSE CASE g_colegio
						CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI'
							concepto = concepto_base
						CASE ELSE
							concepto = 'Fact '+n_factura
					END CHOOSE
					cuenta_irpf = cuenta_col
					if importe_ret_vol <> 0 then cuenta_irpf = cuenta_ret
					if (not (b_resumida and b_aglutinar_irpf)) or ((b_resumida and b_aglutinar_irpf) and cuenta_irpf <> cuenta_col ) then
						wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal + subtotal_iva, orden_apunte, '')
					else
						wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal + subtotal_iva - importe_reten, orden_apunte, '')
					end if
				end if
				// IRPF: al debe de los honorarios
				if (not (b_resumida and b_aglutinar_irpf)) or ((b_resumida and b_aglutinar_irpf) and cuenta_irpf <> cuenta_col ) then
					if importe_ret_vol <> 0 then
						//Si hay ret vol, cargamos el IRPF en cta retenc.
						wf_crear_apunte(fecha, cuenta_ret, LeftA('IRPF ' + concepto_base,57), importe_reten, 0, orden_apunte, '')
					else
						wf_crear_apunte(fecha, cuenta_col, LeftA('IRPF ' + concepto_base,57), importe_reten, 0, orden_apunte, '')
					end if
				end if
				// Ret Vol: al debe de la cuenta de honorarios
				concepto = LeftA(g_conta.concepto_rv + ' ' + concepto_base,57)
				wf_crear_apunte(fecha, cuenta_col, concepto, importe_ret_vol, 0, orden_apunte, '')
				// Ret Vol: al haber de las retenciones
				wf_crear_apunte(fecha, cuenta_ret, concepto, 0, importe_ret_vol, orden_apunte, '')
				//Gesti$$HEX1$$f300$$ENDHEX$$n de garant$$HEX1$$ed00$$ENDHEX$$as (S$$HEX1$$f300$$ENDHEX$$lo aparejadores)
				if not f_es_vacio(g_conta.garantia_codigo_articulo) then
					CHOOSE CASE g_colegio
						CASE 'COAATGUI'
							// Solo para GIPUZKOA
							//Descuento de la cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
							concepto = LeftA(trim(concepto_garantia) + ' ' + concepto_base,57)
							wf_crear_apunte(fecha, cuenta_col, concepto, 0, importe_garantia, orden_apunte, '')
						CASE 'COAATZ', 'COAATLE'
							//Descuento de la cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
							concepto = LeftA(trim(concepto_garantia) + ' ' + concepto_base,57)
							wf_crear_apunte(fecha, g_conta.garantia_cuenta, concepto, - importe_garantia, 0, orden_apunte, '')
						CASE ELSE
							//Abono de la garant$$HEX1$$ed00$$ENDHEX$$a en cuenta del colegiado
							concepto = LeftA(trim(concepto_garantia) + ' ' + concepto_base,57)
							wf_crear_apunte(fecha, cuenta_col, concepto, importe_garantia, 0, orden_apunte, '')
							//Descuento de la cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
							wf_crear_apunte(fecha, g_conta.garantia_cuenta, concepto, 0, importe_garantia, orden_apunte, '')
					END CHOOSE
					
					if importe_cobro_a_cuenta<> 0 then
						// PARA ZARAGOZA -> Para el cobro a cuenta hacemos contraapunte a la cuenta del colegiado solo para que quede constancia. El Apunte est$$HEX2$$e1002000$$ENDHEX$$aglutinado
						concepto = LeftA(trim(concepto_cobro_a_cuenta) + ' ' + concepto_base,57)
						wf_crear_apunte(fecha, cuenta_col, concepto, (- importe_cobro_a_cuenta), 0, orden_apunte, '')
					end if
				end if
			end if
		CASE '03'
			id_col = idw_facturas.GetItemString(i,'id_persona')
			cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
			cuenta_cp = f_dame_cuenta_col(id_col,'CP')

/*			
			MIENTRAS LAS CUENTAS DEL COLEGIADO Y LA DE RETENCION SEAN LA MISMA CUENTA ES UNA ESTUPIDEZ GENERAR LOS 
			DOS ASIENTOS CORRESPONDIENTES AL IRPF

			//FACTURA DE GASTOS A COLEGIADO:
			// Generamos el apunte del IRPF si tiene la factura
			IF importe_reten <> 0 THEN
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
				// Generamos el apunte del debe y el del haber
				wf_crear_apunte(fecha, cuenta_ret, left('IRPF ' + concepto_base,57), importe_reten, 0, orden_apunte)
				// Lo sacamos de la cuenta del colegiado que es donde estar$$HEX2$$e1002000$$ENDHEX$$por culpa del cobro
				wf_crear_apunte(fecha, cuenta_col, left('IRPF ' + concepto_base,57), 0, importe_reten, orden_apunte)
			END IF 
*/			
		CASE '02'
			//FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE
			// generamos el apunte del IRPF si tiene la factura
			IF importe_reten <> 0 THEN
				cuenta_ret = g_cuenta_irpf_cliente_generica
				cuenta_col = ''
				cuenta_cp = ''
				id_col = idw_facturas.GetItemString(i,'id_persona')
				//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
				select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_col;
				if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_col)
				elseif f_es_vacio(cuenta_col) then
					cuenta_col = g_conta.cuenta_clientes_general
				end if
				// Generamos el apunte del debe y el del haber
				wf_crear_apunte(fecha, cuenta_ret, LeftA('IRPF ' + concepto_base,57), importe_reten, 0, orden_apunte, cuenta_col)
				// Lo sacamos de la cuenta del cliente
				wf_crear_apunte(fecha, cuenta_col, LeftA('IRPF ' + concepto_base,57), 0, importe_reten, orden_apunte, cuenta_ret)
			END IF
	END CHOOSE	

	//S$$HEX1$$f300$$ENDHEX$$lo queda descontar el IVA de la cuenta del colegiado y abonarlo en
	//la cuenta de IVA. Lo hacemos para cada tipo de IVA detectado de la factura:
	CHOOSE CASE tipo_factura
		CASE '04' //FACTURA DE HONORARIOS : COLEGIADO A CLIENTE
			// EN este caso no se mira nada de nada
		CASE ELSE
			FOR k=1 TO ds_iva.RowCount()
				imp_iva = ds_iva.GetItemNumber(k,'importe')
				if imp_iva = 0 then continue
				concepto_iva = LeftA(trim(ds_iva.GetItemString(k,'descripcion')) + ' ' + concepto_base, 57)
				cuenta_iva = ds_iva.GetItemString(k,'id_cuenta_repercutido')
				//Apunte a la cuenta de iva
				g_apunte.base_imp = ds_iva.GetItemNumber(k,'base_imp')
				g_apunte.nombre = nombre
				g_apunte.nif = idw_facturas.GetItemString(i, 'nif')
				g_apunte.t_iva = ds_iva.GetItemString(k, 't_iva')
				wf_crear_apunte(fecha, cuenta_iva, concepto_iva, 0, imp_iva, orden_apunte, cuenta_col)
				g_apunte.base_imp = 0
				if not b_resumida and not b_aglutinar_iva_conceptos then
					//Apunte a la cuenta del colegiado
					wf_crear_apunte(fecha, cuenta_col, concepto_iva, imp_iva, 0, orden_apunte, cuenta_iva)
				else
					// Vamos incrementando el total
					importe_apunte_resumido+=imp_iva
				end if
			NEXT
	END CHOOSE
	if b_resumida then
		// Si la opcion es resumida aqu$$HEX2$$ed002000$$ENDHEX$$es cuando hacemos el totalizado, contra la cuenta del colegiado
		wf_crear_apunte(fecha, cuenta_col, 'Fact '+n_factura, importe_apunte_resumido, 0, orden_apunte, '')
	end if

	if b_dv_pdtes_abono then
		concepto = 'Dchos. V$$HEX2$$ba002000$$ENDHEX$$pdtes. '+concepto_base
		// Para las facturas pendientes de abono de DV, hay que hacer 2 apuntes extras
		wf_crear_apunte(fecha, g_cuenta_puente_pendiente_abono_dv, concepto, subtotal + subtotal_iva, 0, orden_apunte, '')
		wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal + subtotal_iva, orden_apunte, '')
	end if
	
	//////////////////////////////////////////////////////////////////////////////////
	// procesamos los cobros para generar el segundo apunte	en el caso de que las facturas hayan sido pagadas
	//////////////////////////////////////////////////////////////////////////////////
	// Filtramos el dw de cobros para la factura concreta
	idw_cobros.setfilter("id_factura='"+id_factura+"'")
	idw_cobros.filter()
	
	// Recorremos los cobros
	FOR fila_cobro = 1 TO idw_cobros.RowCount()
		//Para cada uno de ellos miramos la forma de pago y el id_cobro_multiple
		forma_pago_cobro = upper(idw_cobros.getitemstring(fila_cobro, 'csi_cobros_forma_pago'))
		id_cobro_multiple = idw_cobros.getitemstring(fila_cobro, 'csi_cobros_id_cobro_multiple')
		pagado_cobro = idw_cobros.getitemstring(fila_cobro, 'csi_cobros_pagado')
		total_cobro  = idw_cobros.getitemNumber(fila_cobro, 'csi_cobros_importe')
		banco_cobro  = idw_cobros.getitemstring(fila_cobro, 'csi_cobros_banco')
		fecha_pago_cobro  = datetime(date(idw_cobros.GetItemDateTime(fila_cobro, 'csi_cobros_f_pago')), time("00:00:00"))
		// Obtenemos algunos datos adicionales
		select hay_ingreso into :tipo_pago_cobro from csi_formas_de_pago where tipo_pago = :forma_pago_cobro;
		b_HayIngresocobro = (upper(tipo_pago_cobro) = 'S')
		//Banco y su cuenta contable:
		select cuenta_contable into :ctabanco_cobro from csi_bancos where codigo = :banco_cobro;
		// Paco: modificado 22/05/2007
		if forma_pago_cobro = 'CP' then ctabanco_cobro = cuenta_cp

		// Pillamos la cuenta 
		CHOOSE CASE tipo_factura
			CASE '03' //FACTURA DE GASTOS A COLEGIADO:
				id_col = idw_facturas.GetItemString(i,'id_persona')
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_cp = f_dame_cuenta_col(id_col,'CP')
				if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
					// Si no son facturas de expedientes, cogemos el asunto de la factura
					concepto = idw_facturas.GetItemString(i,'asunto')
					// Si es vacio cogemos las observaciones
					if f_es_vacio(concepto) then concepto = f_factura_observaciones_text(idw_facturas.GetItemString(i,'id_factura'))
					if f_es_vacio(concepto) then concepto = idw_facturas.GetItemString(i,'n_fact')
				else
					concepto = concepto_base
				end if
			CASE '02' //FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE
				if not b_dv_pdtes_abono then concepto = concepto_base
				cuenta_col = ''
				cuenta_cp = ''
				id_col = idw_facturas.GetItemString(i,'id_persona')
				//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
				select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_col;
				if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_col)
				elseif f_es_vacio(cuenta_col) then
					cuenta_col = g_conta.cuenta_clientes_general
				end if
		END CHOOSE
		
		// Si no es un cobro asociado a un cobro multiple lo procesamos
		if not(forma_pago_cobro = 'CM' and not f_es_vacio(id_cobro_multiple)) then
			// Si la forma de pago implica ingreso, generamos el apunte
			if b_HayIngresocobro then
				
				concepto_cobro = LeftA('Ing ' + concepto,57)
				if forma_pago_cobro = g_formas_pago.domiciliacion then concepto_cobro = LeftA('Dom ' + concepto,57)
				// Si tiene una remesa, evitamos procesar el cobro aqu$$HEX1$$ed00$$ENDHEX$$, sino en remesas
				if not f_es_vacio(idw_cobros.GetItemString(fila_cobro, "n_remesa_real")) then continue 

				// Si es un pago fraccionado indicamos el plazo correspondiente
				string n_plazo
				if lower(idw_cobros.describe("n_plazo.name")) = 'n_plazo' then n_plazo = idw_cobros.GetItemString(fila_cobro,'n_plazo')
				if not f_es_vacio(n_plazo) then concepto_cobro += ' (Plazo ' + n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'	
				
				// Si el cobro est$$HEX2$$e1002000$$ENDHEX$$pagado, lo dejamos contabilizado
				if pagado_cobro = 'S' then
					idw_cobros.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',fecha_pago_cobro)
					idw_cobros.SetItem(fila_cobro, 'csi_cobros_contabilizado','S')
					
					// Generamos el apunte correspondiente
					CHOOSE CASE tipo_factura
						CASE '04'
							CHOOSE CASE formadepago
								CASE g_formas_pago.pendientes_abono
									// Este es especial para zaragoza... Se usa el concepto base directamente
									// Tenemos que deshacer lo que hizo el apunte en su dia
									// -> VA apunte y contraapunte por el total a la cuenta del colegiado :O
									// -> apunte contra la 44100001 y contraapunte por el total a la cuenta especial del colegiado :O (con prefijo 4130)
									cuenta_col = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
									wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva, 0, orden_apunte, '')
									wf_crear_apunte(fecha, g_cuenta_puente_pendiente_abono_hon, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
									cuenta_col = f_dame_cuenta_col(id_col,'P')	// Personal//Honorarios
									wf_crear_apunte(fecha, cuenta_col, LeftA('IRPF ' + concepto_base,57), importe_reten, 0, orden_apunte, '')
									wf_crear_apunte(fecha, cuenta_col, concepto, 0, subtotal+subtotal_iva, orden_apunte, '')
									// Total: al debe del banco
									wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_base, total_cobro, 0, orden_apunte, '')
								CASE ELSE
									// Total: al debe del banco
									wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_base, total_cobro, 0, orden_apunte, '')
							END CHOOSE
						CASE '03'
							//Abono en cuenta del colegiado:
							// SEg$$HEX1$$fa00$$ENDHEX$$n la forma de pago tenemos que poner un tipo de documento u otro
							choose case forma_pago_cobro
								case g_formas_pago.transferencia
									g_apunte.t_doc = g_sica_t_doc.transferencia
								case g_formas_pago.talon
									g_apunte.t_doc = g_sica_t_doc.talon
								case else
									g_apunte.t_doc = g_sica_t_doc.generico
							end choose
							wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto_cobro, 0, total_cobro, orden_apunte, ctabanco_cobro)
							// Total: al debe del banco
							wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto, total_cobro, 0, orden_apunte, cuenta_col)
						CASE '02'
							CHOOSE CASE formadepago
								CASE g_formas_pago.pendientes_abono
									// Este es especial para zaragoza... 
									// Tenemos que deshacer lo que hizo el apunte en su dia
									wf_crear_apunte(fecha, g_cuenta_puente_pendiente_abono_dv, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
									wf_crear_apunte(fecha, cuenta_col, concepto_base, subtotal+subtotal_iva, 0, orden_apunte, '')
									wf_crear_apunte(fecha, cuenta_col, concepto_base, 0, subtotal+subtotal_iva, orden_apunte, '')
									// Total: al debe del banco
									wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_base, total_cobro, 0, orden_apunte, '')
								CASE ELSE
									//Abono en cuenta del colegiado:
									// SEg$$HEX1$$fa00$$ENDHEX$$n la forma de pago tenemos que poner un tipo de documento u otro
									choose case forma_pago_cobro
										case g_formas_pago.transferencia
											g_apunte.t_doc = g_sica_t_doc.transferencia
										case g_formas_pago.talon
											g_apunte.t_doc = g_sica_t_doc.talon
										case else
											g_apunte.t_doc = g_sica_t_doc.generico
									end choose
									wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto_cobro, 0, total_cobro, orden_apunte, ctabanco_cobro)
									// Total: al debe del banco
									wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_base, total_cobro, 0, orden_apunte, cuenta_col)
							END CHOOSE
					END CHOOSE
				end if
			else
				CHOOSE CASE forma_pago_cobro
					CASE g_formas_pago.pendientes_abono
						// Con estas no hacemos nada, de momento
					CASE ELSE
						// Si no implica ingreso, tambien las marcamos como contabilizadas para que no nos sigan saliendo
						idw_cobros.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',fecha_pago_cobro)
						idw_cobros.SetItem(fila_cobro, 'csi_cobros_contabilizado','S')
				END CHOOSE
			end if
		else
			CHOOSE CASE tipo_factura
				CASE '04'
					// Es una de cobro multiple por lo que hay que generar para las de honorarios un apunte a la linea personal
					// Total: al debe del bancoficticio que hemos inventado
					wf_crear_apunte(fecha_pago_cobro, g_cobros_multiples_cuenta_puente, concepto_base, total_cobro, 0, orden_apunte, '')
			END CHOOSE
		end if
	NEXT // Cobros de factura (fila_cobro)
	// Quitamos el filtrado
	idw_cobros.setfilter("")
	idw_cobros.filter()
Next //facturas (i)

/////////////////////////////////////////
// Ahora procesamos los cobros multiples!
/////////////////////////////////////////
id_cobro_multipl_ant = 'zz'
if idw_cobros_multiples.RowCount()>0 then
	// Cogemos el tipo de documento de los cobros multiples
	string tipo_documento_cm
	tipo_documento_cm = g_sica_t_doc.cobros_multiples
	if f_es_vacio(tipo_documento_cm) then tipo_documento_cm = 'CM'
	i_asiento_cobros_mult++
	// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
	if g_sica_diario.cobros_multiples = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
	// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
	if g_sica_diario.cobros_multiples = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
	// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
	if g_sica_diario.cobros_multiples = g_sica_diario.remesas then i_asiento_rem++
	g_apunte.diario = g_sica_diario.cobros_multiples
	g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_cobros_mult)),7)
	g_apunte.n_apunte = '00000'
	g_apunte.t_doc = tipo_documento_cm
	g_apunte.n_doc = ''
	// POnemos el centro por defecto
	g_apunte.centro = g_centro_por_defecto
	g_apunte.base_imp = 0
	g_apunte.nif = ''
	g_apunte.nombre = ''
end if
FOR fila_cobro_multiple = 1 TO idw_cobros_multiples.RowCount()
	id_cobro_multiple  = idw_cobros_multiples.getitemstring(fila_cobro_multiple, 'csi_cobros_multiples_id_cobro_multiple')
	// CAda cobro multiple solo hay que procesarlo una vez, pero como hemos hecho joins con cobros un mismo cobro multiple puede
	// aparecer n veces
	if id_cobro_multipl_ant = id_cobro_multiple then continue
	// Actualizamos la variable pa que vaya bien
	id_cobro_multipl_ant = id_cobro_multiple
	
	st_progreso.text = 'Procesando ' + string(fila_cobro_multiple) + ' de ' + string(idw_cobros_multiples.RowCount())+' cobros m$$HEX1$$fa00$$ENDHEX$$ltiples. '+string(idw_apuntes.RowCount())+' apuntes generados.'
	yield()
	//Para cada uno de ellos miramos la forma de pago y el id_cobro_multiple
	forma_pago_cobro_multiple = upper(idw_cobros_multiples.getitemstring(fila_cobro_multiple, 'csi_cobros_multiples_forma_pago'))
	total_cobro_multiple = idw_cobros_multiples.getitemNumber(fila_cobro_multiple, 'csi_cobros_multiples_importe')
	banco_cobro_multiple  = idw_cobros_multiples.getitemstring(fila_cobro_multiple, 'csi_cobros_multiples_banco')
	concepto_cobro_multiple = idw_cobros_multiples.getitemstring(fila_cobro_multiple, 'csi_cobros_multiples_expediente')+' - '+idw_cobros_multiples.getitemstring(fila_cobro_multiple, 'csi_cobros_multiples_pagador')
	fecha_pago_cobro_multiple = idw_cobros_multiples.GetitemDatetime(fila_cobro_multiple, 'csi_cobros_multiples_fecha')
	
	// Obtenemos algunos datos adicionales
	select hay_ingreso into :tipo_pago_cobro_multiple from csi_formas_de_pago where tipo_pago = :forma_pago_cobro_multiple;
	b_HayIngresoCobroMultiple = (upper(tipo_pago_cobro_multiple) = 'S')
	//Banco y su cuenta contable:
	select cuenta_contable into :ctabanco_cobro_multiple from csi_bancos where codigo = :banco_cobro_multiple;
	if b_HayIngresoCobroMultiple then
		// Contabilizamos el cobro multiple
		idw_cobros_multiples.SetItem(fila_cobro_multiple, 'csi_cobros_multiples_f_contabilizado',fecha_pago_cobro_multiple)
		idw_cobros_multiples.SetItem(fila_cobro_multiple, 'csi_cobros_multiples_contabilizado','S')

	
		/////////////////////////////////////////////////////////////////////////////////////////
		// procesamos los cobros afectados por el cobro multiple correspondiente
		//////////////////////////////////////////////////////////////////////////////////
		// Filtramos el dw de cobros para la factura concreta
		idw_cobros.setfilter("csi_cobros_id_cobro_multiple='"+id_cobro_multiple+"'")
		idw_cobros.filter()
	
		// Recorremos los cobros
		FOR fila_cobro = 1 TO idw_cobros.RowCount()
			//Para cada uno de ellos miramos la forma de pago y el id_cobro_multiple
			forma_pago_cobro = upper(idw_cobros.getitemstring(fila_cobro, 'csi_cobros_forma_pago'))
			pagado_cobro = idw_cobros.getitemstring(fila_cobro, 'csi_cobros_pagado')
			total_cobro = idw_cobros.getitemNumber(fila_cobro, 'csi_cobros_importe')
			banco_cobro = idw_cobros.getitemstring(fila_cobro, 'csi_cobros_banco')
			tipo_factura = idw_cobros.getitemstring(fila_cobro, 'tipo_factura')
			id_fase = idw_cobros.getitemstring(fila_cobro, 'id_fase')
			id_minuta = idw_cobros.getitemstring(fila_cobro, 'id_minuta')
			id_col = idw_cobros.GetItemString(fila_cobro,'id_persona')
			nif = idw_cobros.getitemstring(fila_cobro, 'nif')
			nombre = idw_cobros.getitemstring(fila_cobro, 'nombre')
			
			// Colocamos el concepto base		ESTO PARECE ESTA MAL PUES DEBERIA SER UN OR
			if not f_es_vacio(id_fase) and not f_es_vacio(id_minuta) then 
				CHOOSE CASE g_colegio
					CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI'
						// Enzaragoza quieren el numero de expediente y el numero de visado
						n_visado = idw_facturas.GetItemString(i,'fases_archivo_real')
						concepto_base = 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado+' '+ g_conta.concepto_exp +' ' + n_expedi
					CASE ELSE
						concepto_base = g_conta.concepto_exp +' ' + n_expedi
				END CHOOSE
			end if			

			// Obtenemos algunos datos adicionales
//			select hay_ingreso into :tipo_pago_cobro from csi_formas_de_pago where tipo_pago = :forma_pago_cobro;
//			b_HayIngresocobro = (upper(tipo_pago_cobro) = 'S')
			//Banco y su cuenta contable:
			select cuenta_contable into :ctabanco_cobro from csi_bancos where codigo = :banco_cobro;
			
//			if b_HayIngresoCobro then
				if pagado_cobro = 'S' then
					// Contabilizamos el cobro multiple
					idw_cobros.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',fecha_pago_cobro_multiple)
					idw_cobros.SetItem(fila_cobro, 'csi_cobros_contabilizado','S')
					
					CHOOSE CASE tipo_factura
						CASE '04'
							cuenta_col = g_cobros_multiples_cuenta_puente
							concepto_base = concepto_cobro_multiple 
						CASE '03' //FACTURA DE GASTOS A COLEGIADO:
							cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
							cliente = ''
							if not f_es_vacio(id_fase) then
								if g_conta.enlace_facturas = 'MINUTAS' then
									select clientes.apellidos into :cliente from clientes, fases_minutas
									where fases_minutas.id_minuta = :id_fase and fases_minutas.id_cliente = clientes.id_cliente;
								else
									select clientes.apellidos into :cliente from clientes, fases_clientes
									where fases_clientes.id_fase = :id_fase and fases_clientes.id_cliente = clientes.id_cliente;
								end if
								if f_es_vacio(cliente) then cliente = ''
							else
								// Si es vacio cogemos las observaciones
								if f_es_vacio(concepto_base) then concepto_base = f_factura_observaciones_text(idw_facturas.GetItemString(i,'id_factura'))
								if f_es_vacio(concepto_base) then concepto = idw_facturas.GetItemString(i,'n_fact')
							end if
							
							concepto_base = concepto_cobro_multiple 
							
						CASE '02' //FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE
							cuenta_col = ''
							cuenta_cp = ''
							//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
							select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_col;
							
							if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
								cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_col)
							elseif f_es_vacio(cuenta_col) then
								cuenta_col = g_conta.cuenta_clientes_general
							end if
							
							concepto_base = concepto_cobro_multiple 
				
					END CHOOSE
					
					// Total: al debe del banco
					g_apunte.id_interno = id_cobro_multiple
					g_apunte.nif = nif
					g_apunte.nombre = nombre
					wf_crear_apunte(fecha_pago_cobro_multiple, cuenta_col, "(CM = "+id_cobro_multiple+") "+concepto_cobro_multiple, 0, total_cobro, orden_apunte, '')
				end if
//			end if
		NEXT
		if idw_cobros.RowCount()>0 then
			// Generamos el apunte correspondiente
			// Total: al debe del banco
			g_apunte.id_interno = id_cobro_multiple
			g_apunte.nif = ''
			g_apunte.nombre = ''
			wf_crear_apunte(fecha_pago_cobro_multiple, ctabanco_cobro_multiple, "(CM = "+id_cobro_multiple+") "+concepto_cobro_multiple, total_cobro_multiple, 0, orden_apunte, '')
		end if
		

		// Quitamos el filtrado
		idw_cobros.setfilter("")
		idw_cobros.filter()
	end if
NEXT


//////////////////////////////////////////////////////////////////////////////////
// Ahora procesamos los cobros de facturas ya contabilizadas
//////////////////////////////////////////////////////////////////////////////////
if idw_cobros_facturas_contabilizadas.RowCount()>0 then
	tipo_documento_remesa = g_sica_t_doc.remesas
	if f_es_vacio(tipo_documento_remesa) then tipo_documento_remesa = 'RE'
	modo_contabilizacion = dw_modo_cont.getitemstring(1, 'modo_contabilizacion')
	
	
	b_cambiar_asiento = true
//	i_asiento_rem++
//	// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
//	if g_sica_diario.remesas = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
//	// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
//	if g_sica_diario.remesas = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
//	// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
//	if g_sica_diario.remesas = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
//	g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_rem)),7)
//	g_apunte.n_apunte = '00000'
//	// POnemos el centro por defecto
//	g_apunte.centro = g_centro_por_defecto
//	g_apunte.base_imp = 0
//	g_apunte.nif = ''
//	g_apunte.nombre = ''

	// Colocamos la inicializacion de las variables
	total_remesa = 0
	total_asiento = 0
	
	// Si la contabilizacion es por remesas debemos ordenar pos este valor
	if modo_contabilizacion = 'R' or modo_contabilizacion = 'A' then 
		idw_cobros_facturas_contabilizadas.setsort("n_remesa_real A, de_expediente A, id_fase D, id_remesa D")
		idw_cobros_facturas_contabilizadas.sort()
	else
		idw_cobros_facturas_contabilizadas.setsort("de_expediente A, id_fase D, id_minuta D")
		idw_cobros_facturas_contabilizadas.sort()
	end if
	
	saltados = 0
	FOR fila_cobro = 1 TO idw_cobros_facturas_contabilizadas.RowCount()
		st_progreso.text = 'Procesando ' + string(fila_cobro) + ' de ' + string(idw_cobros_facturas_contabilizadas.RowCount())+' cobro de Fact. Cont. '+string(idw_apuntes.RowCount())+' apuntes generados.'
		yield()
		n_remesa = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'n_remesa_real')
		id_factura = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_factura')
		id_fase = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_fase')
		id_minuta = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_minuta')

		
		// 	Modificado Ricardo 2005-05-11
		// Encontrado en la rioja... Cuando una remesa las cabeceras de las facturas no est$$HEX1$$e100$$ENDHEX$$n contabilizadas cuando se llegue a este punto... 
		// los apuntes de los cobros se generarar$$HEX1$$e100$$ENDHEX$$n hasta la saciedad!
		// Tenemos que comprobar que el id_factura devuelva que est$$HEX2$$e1002000$$ENDHEX$$contabilizada o bien est$$HEX2$$e1002000$$ENDHEX$$en la parte a contabilizar de esta vez!
		select contabilizada into :contabilizado_fact from csi_facturas_emitidas where id_factura = :id_factura;
		if contabilizado_fact = 'N' then
			// Tenemos que mirar si est$$HEX2$$e1002000$$ENDHEX$$esta vez seleccionado, o saltarselo este cobro!
			if idw_facturas.find("id_factura = '"+id_factura+"'", 1, idw_facturas.RowCount()) = 0 then
				saltados++
				continue
			end if
		end if

		if n_remesa_old = '-1' or (f_es_vacio(n_remesa_old) and not f_es_vacio(n_remesa) and modo_contabilizacion<>'A')  then n_remesa_old = n_remesa // Inicializamos el valor de la remesa al de la primera remesa

		if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A')  and n_remesa_old <> n_remesa then
			// Hay que hacer la contabilizacion de la remesa anterior y preparar la siguiente
			// Total: al debe del banco
//			g_apunte.diario = g_sica_diario.remesas
			g_apunte.id_interno = n_remesa_old
			g_apunte.n_doc = n_remesa_old
			g_apunte.t_doc = tipo_documento_remesa
			g_apunte.nif = ''
			g_apunte.nombre = ''
			wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, 'Rem. '+ n_remesa_old, total_remesa, 0, '', '')


			// Cuando hay varios diarios, al hay que ver si cambia de uno a otro para saber si hay que cambiar de asiento o no
			if not b_cambiar_asiento then b_cambiar_asiento = wf_comprobar_si_cambiar_asiento(modo_contabilizacion, n_remesa, n_remesa_old, id_fase,id_minuta,id_fase_old,id_minuta_old)

			// VAciamos la remesa
			total_remesa = 0
			n_remesa_old = n_remesa
			
//			if modo_contabilizacion = 'A' then
//				b_cambiar_asiento = true
//				i_asiento_rem++
//				// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
//				if g_sica_diario.remesas = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
//				// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
//				if g_sica_diario.remesas = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
//				// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
//				if g_sica_diario.remesas = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
//				g_apunte.n_asiento = right('0000000' + trim(string(i_asiento_rem)),7)
//				g_apunte.n_apunte = '00000'
//			end if
		else
			// Cuando hay varios diarios, al hay que ver si cambia de uno a otro para saber si hay que cambiar de asiento o no
			if not b_cambiar_asiento then b_cambiar_asiento = wf_comprobar_si_cambiar_asiento(modo_contabilizacion, n_remesa, n_remesa_old, id_fase,id_minuta,id_fase_old,id_minuta_old)
		end if

		
		
		// Cogemos variables temporales que nos ser$$HEX1$$e100$$ENDHEX$$n necesarias
		id_persona = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_persona')
		tipo_factura = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'tipo_factura')
		cliente = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'nombre')
		id_minuta = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'id_minuta')
		n_expedi = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'expedientes_n_expedi')
		forma_pago_cobro = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'csi_cobros_forma_pago')
		fecha_pago_cobro = idw_cobros_facturas_contabilizadas.GetItemDateTime(fila_cobro,'csi_cobros_f_pago')
		total_cobro	= idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'csi_cobros_importe')
		banco_cobro = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'csi_cobros_banco')
		nif = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'nif')
		nombre = idw_cobros_facturas_contabilizadas.getitemstring(fila_cobro, 'nombre')
		formadepago = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'formadepago')
		subtotal = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'subtotal')
		importe_reten = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'importe_reten')
		subtotal_iva = idw_cobros_facturas_contabilizadas.GetItemNumber(fila_cobro,'iva')
		id_col  = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'emisor')
		
		// Obtenemos algunos datos adicionales
		select hay_ingreso into :tipo_pago_cobro from csi_formas_de_pago where tipo_pago = :forma_pago_cobro;
		b_HayIngresocobro = (upper(tipo_pago_cobro) = 'S')
		//Banco y su cuenta contable:
		select cuenta_contable into :ctabanco_cobro from csi_bancos where codigo = :banco_cobro;

		CHOOSE CASE tipo_factura
			CASE '04'
				// Factura de honorarios
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_cp = f_dame_cuenta_col(id_col,'CP')
			CASE '03'
				// Factura de gastos, o de colegiado
				cuenta_col = f_dame_cuenta_col(id_persona,'P')	// personal / honorarios
				cuenta_cp = f_dame_cuenta_col(id_persona,'CP')
			CASE '02'
				// Factura a cliente
				cuenta_ret = g_cuenta_irpf_cliente_generica
				cuenta_col = ''
				cuenta_cp = ''
				//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
				select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_persona;
				if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_persona)
				elseif f_es_vacio(cuenta_col) then
					cuenta_col = g_conta.cuenta_clientes_general
				end if
		END CHOOSE
		
		// Paco: 22/05/2007
		if forma_pago_cobro = 'CP' then ctabanco_cobro = cuenta_cp
		
		concepto_base = 'Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_fact')
		concepto_cobro = LeftA('Ing ' + concepto_base,57)
		if forma_pago_cobro = g_formas_pago.domiciliacion then concepto_cobro = LeftA('Dom ' + concepto_base,57)

		// Si es un pago fraccionado indicamos el plazo correspondiente
		if lower(idw_cobros_facturas_contabilizadas.describe("n_plazo.name")) = 'n_plazo' then n_plazo = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_plazo')
		if not f_es_vacio(n_plazo) then concepto_cobro += ' (Plazo ' + n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'				

		idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',fecha_pago_cobro)
		idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_contabilizado','S')
	
		CHOOSE CASE forma_pago_cobro
			CASE g_formas_pago.liquidacion
				// Si la forma de pago del cobro es 'LI' o de la factura es 'LI' saltamos la generacion del apunte
				continue
			CASE g_formas_pago.cargo
				// Si la forma de pago del cobro es 'CA' o de la factura es 'CA' saltamos la generacion del apunte
				continue
			CASE g_formas_pago.pendientes_abono
				// Si la forma de pago del cobro es 'PA' o de la factura es 'PA' saltamos la generacion del apunte
				setnull(fecha_pago_cobro)
				idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_f_contabilizado',fecha_pago_cobro)
				idw_cobros_facturas_contabilizadas.SetItem(fila_cobro, 'csi_cobros_contabilizado','N')
				continue
		END CHOOSE
		
		// No procesamos las 'LI' ni las 'CA'
		if formadepago = g_formas_pago.liquidacion then continue
		if formadepago = g_formas_pago.cargo then continue
		
		IF not b_HayIngresocobro then continue
		// Modificamos el concepto apra decir que es parte de una remesa
		if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then concepto_cobro = 'Rem. '+n_remesa+' ('+concepto_cobro+')'
	
		////////////////////////////////////////////////////////
		//Rellenamos DATOS GENERALES DE G_APUNTE
		////////////////////////////////////////////////////////
		if b_cambiar_asiento then
			if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then
				// VAn contra el diario de la remesa
				i_asiento_rem++
				g_apunte.diario = g_sica_diario.remesas
				g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_rem)),7)
				g_apunte.n_apunte = '00000'
	
				// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.remesas = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
				// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.remesas = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
				// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
				if g_sica_diario.remesas = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
				// POnemos el centro por defecto
				g_apunte.centro = g_centro_por_defecto
				g_apunte.base_imp = 0
				g_apunte.nif = ''
				g_apunte.nombre = ''
				
				b_cambiar_asiento = false
	
			else
				// SEg$$HEX1$$fa00$$ENDHEX$$n si la factura va relacionada con un contrato o no va contra uno u otro diario
				if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
					i_asiento_ot++
					g_apunte.diario = g_sica_diario.facts_emitidas_ot
					g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_ot)),7)
					g_apunte.n_apunte = '00000'
					
	
					// Si el diario de exp es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
					// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_ot = g_sica_diario.remesas then i_asiento_rem++
					// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_ot = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
					// POnemos el centro por defecto
					g_apunte.centro = g_centro_por_defecto
					g_apunte.base_imp = 0
					g_apunte.nif = ''
					g_apunte.nombre = ''
				else
					i_asiento_exp++
					g_apunte.diario = g_sica_diario.facts_emitidas_exp
					g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_exp)),7)
					g_apunte.n_apunte = '00000'

					// Si el diario de ot es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
					// Si el diario de remesas es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_exp = g_sica_diario.remesas then i_asiento_rem++
					// Si el diario de cobros multiples es el mismo, hay que incrementar la otra variable tambien
					if g_sica_diario.facts_emitidas_exp = g_sica_diario.cobros_multiples then i_asiento_cobros_mult++
					// POnemos el centro por defecto
					g_apunte.centro = g_centro_por_defecto
					g_apunte.base_imp = 0
					g_apunte.nif = ''
					g_apunte.nombre = ''
				end if
				b_cambiar_asiento = false
			end if
		end if
	
		g_apunte.centro = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'centro')	
		choose case forma_pago_cobro
			case g_formas_pago.transferencia
				g_apunte.t_doc = g_sica_t_doc.transferencia
			case g_formas_pago.talon
				g_apunte.t_doc = g_sica_t_doc.talon
			case else
				g_apunte.t_doc = g_sica_t_doc.generico
		end choose

		// Si pertenece a una remesa, el tipo de documento ser$$HEX2$$e1002000$$ENDHEX$$remesa
		if modo_contabilizacion = 'N' or (f_es_vacio(n_remesa) and (modo_contabilizacion = 'R' or modo_contabilizacion = 'A'))  then 
			g_apunte.id_interno = id_factura
			g_apunte.n_doc = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'n_fact')
		end if 
		if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not f_es_vacio(n_remesa) then 
			g_apunte.n_doc = n_remesa
			g_apunte.t_doc = tipo_documento_remesa
			g_apunte.id_interno = n_remesa
		end if


		// Generamos el apunte correspondiente...
		CHOOSE CASE formadepago
			CASE g_formas_pago.pendientes_abono
				// Tratamiento especial para zaragoza
				CHOOSE CASE tipo_factura
					CASE '04'
						n_visado = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'fases_archivo_real')
						concepto = 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado+' '+cliente
						// Este es especial para zaragoza... 
						// Tenemos que deshacer lo que hizo el apunte en su dia
						// -> VA apunte y contraapunte por el total a la cuenta del colegiado :O
						// -> apunte contra la 44100001 y contraapunte por el total a la cuenta especial del colegiado :O (con prefijo 4130)
						cuenta_col = f_dame_cuenta_col(id_col,'A')	// Cuenta pendite abono
						wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
						wf_crear_apunte(fecha_pago_cobro, g_cuenta_puente_pendiente_abono_hon, concepto, 0, subtotal+subtotal_iva, '', '')
						cuenta_col = f_dame_cuenta_col(id_col,'P')	// Personal//Honorarios
						wf_crear_apunte(fecha_pago_cobro, cuenta_col, LeftA('IRPF ' + concepto,57), importe_reten, 0, orden_apunte, '')
						wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, 0, subtotal+subtotal_iva, '', '')
						b_cambiar_asiento = true // Forzamos el cambio de asiento
					CASE '02'
						n_visado = idw_cobros_facturas_contabilizadas.GetItemString(fila_cobro,'fases_archivo_real')
						concepto = 'V$$HEX2$$ba002000$$ENDHEX$$' +n_visado+' '+cliente
						// Este es especial para zaragoza... 
						// modificado ricardo 2005-11-14
						//cuenta_col = f_dame_cuenta_col(id_persona,'P')	// Personal//Honorarios
						cuenta_col = ''
						cuenta_cp = ''
						//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
						select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_persona;
						if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
							cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_persona)
						elseif f_es_vacio(cuenta_col) then
							cuenta_col = g_conta.cuenta_clientes_general
						end if
						// modificado ricardo 2005-11-14
						
						// Tenemos que deshacer lo que hizo el apunte en su dia
						wf_crear_apunte(fecha_pago_cobro, g_cuenta_puente_pendiente_abono_dv, concepto, 0, subtotal+subtotal_iva, '', '')
						wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, subtotal+subtotal_iva, 0, '', '')
						wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto, 0, subtotal+subtotal_iva, '', '')
						b_cambiar_asiento = true // Forzamos el cambio de asiento
				END CHOOSE
			CASE ELSE
				if tipo_factura <> '04' then
					//Abono en cuenta del colegiado:
					g_apunte.nif = nif
					g_apunte.nombre = nombre
					wf_crear_apunte(fecha_pago_cobro, cuenta_col, concepto_cobro, 0, total_cobro, '', ctabanco_cobro)
				end if
		END CHOOSE
				
		if modo_contabilizacion = 'N' or f_es_vacio(n_remesa) then
			// Total: al debe del banco
			wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, concepto_cobro, total_cobro, 0, '', cuenta_col)
			// Forzamos a un cambio de asiento cuando n_remesa es vacio
			if f_es_vacio(n_remesa) then b_cambiar_asiento = true // Modificado Ricardo 2005-05-20
		end if
		// Solo si estamos con una remesa valida vamos 
		if not(modo_contabilizacion = 'N' or f_es_vacio(n_remesa)) then total_remesa += total_cobro
		total_asiento += total_cobro
		n_remesa_old = n_remesa
		id_fase_old = id_fase
		id_minuta_old = id_minuta
	NEXT
	if (modo_contabilizacion = 'R' or modo_contabilizacion = 'A') and not (f_es_vacio(n_remesa_old) or n_remesa_old = '-1') then
		// Hay que hacer la contabilizacion de la remesa anterior puesto que era la ultima antes de salir del bucle y faltar$$HEX2$$e1002000$$ENDHEX$$el contraasiento
		// Total: al debe del banco
//		g_apunte.diario = g_sica_diario.remesas
		g_apunte.id_interno = n_remesa_old
		g_apunte.n_doc = n_remesa_old
		g_apunte.t_doc = tipo_documento_remesa
		g_apunte.nif = ''
		g_apunte.nombre = ''
		wf_crear_apunte(fecha_pago_cobro, ctabanco_cobro, 'Rem. '+ n_remesa_old, total_remesa, 0, '', '')
	end if
end if

if saltados>0 then Messagebox(g_titulo,"De los cobros sueltos, "+string(saltados)+" han sido obviados por no estar la cabecera de la factura contabilizada, ni contabilizarse en este mismo proceso")
st_progreso.text = 'Presentando apuntes, espere por favor...'
yield()
idw_apuntes.Sort()
idw_apuntes.GroupCalc()
st_progreso.text = 'Generaci$$HEX1$$f300$$ENDHEX$$n de apuntes finalizada: '+string(idw_apuntes.RowCount())+' apuntes generados.'
yield()
cb_actualizar.enabled = (idw_apuntes.RowCount() > 0)
cb_imprimir_ap.enabled = (idw_apuntes.RowCount() > 0)
destroy ds_lineas
destroy ds_iva

//this.enabled = true // David - 13/12/2005 Para evitar que dupliquen (I4014, I4029)
idw_apuntes.setredraw(true)

end event

type dw_modo_cont from u_dw within w_proconta_facturas_contabiliza_old
integer x = 2213
integer y = 68
integer width = 1531
integer height = 88
integer taborder = 20
string dataobject = "d_cobros_modo_contabilizacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;// Metemos una linea para que se pueda elegir como se quiere trabajar
this.insertrow(0)

end event

type st_progreso from statictext within w_proconta_facturas_contabiliza_old
integer x = 1998
integer y = 1500
integer width = 2222
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = true
boolean focusrectangle = false
end type

type st_cuantas_facturas from statictext within w_proconta_facturas_contabiliza_old
integer x = 1998
integer y = 1408
integer width = 2222
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean border = true
boolean focusrectangle = false
end type

type tab_1 from tab within w_proconta_facturas_contabiliza_old
integer x = 23
integer y = 444
integer width = 4206
integer height = 928
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_3 tabpage_3
tabpage_1 tabpage_1
tabpage_apuntes tabpage_apuntes
end type

on tab_1.create
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_3=create tabpage_3
this.tabpage_1=create tabpage_1
this.tabpage_apuntes=create tabpage_apuntes
this.Control[]={this.tabpage_4,&
this.tabpage_5,&
this.tabpage_3,&
this.tabpage_1,&
this.tabpage_apuntes}
end on

on tab_1.destroy
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_3)
destroy(this.tabpage_1)
destroy(this.tabpage_apuntes)
end on

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 812
long backcolor = 79741120
string text = "Facturas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_facturas dw_facturas
end type

on tabpage_4.create
this.dw_facturas=create dw_facturas
this.Control[]={this.dw_facturas}
end on

on tabpage_4.destroy
destroy(this.dw_facturas)
end on

type dw_facturas from u_dw within tabpage_4
integer width = 4160
integer height = 808
integer taborder = 80
string dataobject = "d_proconta_facturas_contabiliza"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_FTURAS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

// Evitamos que aparezcan las 'PA' de momento
//this.setfilter("formadepago <> 'PA'")  

end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 812
long backcolor = 79741120
string text = "Cobros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros dw_cobros
end type

event constructor;//this.visible = false
end event

on tabpage_5.create
this.dw_cobros=create dw_cobros
this.Control[]={this.dw_cobros}
end on

on tabpage_5.destroy
destroy(this.dw_cobros)
end on

type dw_cobros from u_dw within tabpage_5
integer y = 4
integer width = 4160
integer height = 808
integer taborder = 11
string dataobject = "d_proconta_cobros_contabiliza"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_COBROS'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 812
long backcolor = 79741120
string text = "Cobros Multiples"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros_multiple dw_cobros_multiple
end type

on tabpage_3.create
this.dw_cobros_multiple=create dw_cobros_multiple
this.Control[]={this.dw_cobros_multiple}
end on

on tabpage_3.destroy
destroy(this.dw_cobros_multiple)
end on

event constructor;// RICARDO 04-07
// Solo hacemos visible el tab de cobros multiples si tambien lo est$$HEX2$$e1002000$$ENDHEX$$la entrada de menu
//tab_1.tabpage_3.visible = m_aplic_frame.m_file.m_new.m_contabilidad0.m_cobrosmultiples.visible

// Vamos a mirar en la bd porque pierde la referencia del men$$HEX1$$fa00$$ENDHEX$$
string vis

SELECT visible INTO :vis FROM menu WHERE activo = 'S' AND codigo = '0000000154'  ;

if vis = '0' then tab_1.tabpage_3.visible = false

end event

type dw_cobros_multiple from u_dw within tabpage_3
integer y = 4
integer width = 4165
integer height = 808
integer taborder = 11
string dataobject = "d_proconta_cobros_multipl_contabiliza"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_CM'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4169
integer height = 812
long backcolor = 79741120
string text = "Cobros Fact. Contabilizadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros_facturas_contabilizadas dw_cobros_facturas_contabilizadas
end type

on tabpage_1.create
this.dw_cobros_facturas_contabilizadas=create dw_cobros_facturas_contabilizadas
this.Control[]={this.dw_cobros_facturas_contabilizadas}
end on

on tabpage_1.destroy
destroy(this.dw_cobros_facturas_contabilizadas)
end on

type dw_cobros_facturas_contabilizadas from u_dw within tabpage_1
integer y = 4
integer width = 4165
integer height = 808
integer taborder = 11
string dataobject = "d_proconta_cobros_facts_contabilizada"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (idw_cobros_multiples.RowCount() > 0) or (idw_cobros.RowCount() > 0) or (idw_cobros_facturas_contabilizadas.RowCount()>0)
end event

event constructor;call super::constructor;st_control_eventos c_evento

c_evento.evento = 'CONTA_CFACTC'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return
end event

type tabpage_apuntes from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4169
integer height = 812
long backcolor = 79741120
string text = "Apuntes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_apuntes1 dw_apuntes1
end type

on tabpage_apuntes.create
this.dw_apuntes1=create dw_apuntes1
this.Control[]={this.dw_apuntes1}
end on

on tabpage_apuntes.destroy
destroy(this.dw_apuntes1)
end on

type dw_apuntes1 from u_dw within tabpage_apuntes
integer y = 4
integer width = 4155
integer height = 808
integer taborder = 11
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
of_SetPrintPreview(TRUE)
this.trigger event pfc_printpreview()
end event

event doubleclicked;call super::doubleclicked;//parent.setredraw(false)
//if il_coord_x >0 then
//	// Restauramos el tama$$HEX1$$f100$$ENDHEX$$o original
//	this.x = il_coord_x
//	this.y = il_coord_y
//	this.width = il_tamanyo_x
//	this.height = il_tamanyo_y
//	
//	il_coord_x = 0
//	il_coord_y = 0
//	il_tamanyo_x = 0
//	il_tamanyo_y = 0
//else
//	// Maximizamos
//	il_coord_x = this.x
//	il_coord_y = this.y 
//	il_tamanyo_x = this.width
//	il_tamanyo_y = this.height
//
//	this.x = 32
//	this.y = 336
//	this.width =  il_tamanyo_x
//	this.height = il_coord_y+il_tamanyo_y - 336
//end if
//this.visible = true
//parent.setredraw(true)
end event

type dw_fechas from u_dw within w_proconta_facturas_contabiliza_old
integer x = 27
integer y = 4
integer width = 2199
integer height = 408
integer taborder = 10
string dataobject = "d_facturas_desdehasta"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// Paco 22/05/2007
//CHOOSE CASE g_colegio
//	CASE 'COAATLR'
//		this.modify("resumida.visible = '1'")
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '0'")
//	CASE 'COAATZ'
//		this.modify("resumida.visible = '0'")
//		this.modify("aglutinar_iva_conceptos.visible = '1'")
//		this.modify("aglutinar_irpf.visible = '0'")
//	CASE 'COAATGU', 'COAATLE', 'COAATAVI'
//		this.modify("resumida.visible = '1'")
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '1'")
//	CASE ELSE
//		this.modify("resumida.visible = '1'") // Solo temporal
//		this.modify("aglutinar_iva_conceptos.visible = '0'")
//		this.modify("aglutinar_irpf.visible = '0'")
//END CHOOSE

end event

event pfc_updatespending;return 0
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'aglutinar_irpf'
		// Solo se puede aglutinar irpf con la contabilizaci$$HEX1$$f300$$ENDHEX$$n resumida
		if data ='S' and this.getitemstring(row, 'resumida')='N' then
			post messagebox(g_titulo, "S$$HEX1$$f300$$ENDHEX$$lo se puede aglutinar irpf con la contabilizaci$$HEX1$$f300$$ENDHEX$$n resumida", exclamation!)
			return 2
		end if
END CHOOSE
end event

type cb_salir from commandbutton within w_proconta_facturas_contabiliza_old
boolean visible = false
integer x = 1582
integer y = 1428
integer width = 366
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;Close(Parent)
end event

type cb_imprimir_ap from commandbutton within w_proconta_facturas_contabiliza_old
integer x = 1166
integer y = 1428
integer width = 366
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Imprimir Ap."
end type

event clicked;//dw_apuntes.Print()
f_opciones_impresion(idw_apuntes)
end event

type cb_actualizar from commandbutton within w_proconta_facturas_contabiliza_old
event cliced_old ( )
string tag = "&Apuntes"
integer x = 786
integer y = 1428
integer width = 366
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar Ap."
end type

event cliced_old();/*

boolean b_error = false, b_autocomit_SQLCA, b_autocomit_bd_ejercicio

// Quitamos los autocomit
b_autocomit_SQLCA = SQLCA.autocommit
b_autocomit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
// Iniciamos una transaccion, para hacer el proceso atomico
Execute Immediate "BEGIN tran" using SQLCA;
EXECUTE IMMEDIATE "BEGIN tran" USING bd_ejercicio;

if idw_facturas.Update()<>1 then b_error = true
if idw_cobros.Update()<>1 then b_error = true
if idw_cobros_multiples.Update()<>1 then b_error = true
if dw_apuntes.Update()<>1 then b_error = true
if idw_cobros_facturas_contabilizadas.update()<>1 then b_error = true

if not b_error then
	// Confirmamos los cambios
	Execute Immediate "COMMIT Transaction" using SQLCA;
	Execute Immediate "COMMIT Transaction" using bd_ejercicio;
	commit USING SQLCA; 
	commit USING bd_ejercicio;
	// Ahora actualizamos las bbdd de contadores
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento_exp)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento_ot)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.cobros_multiples, i_asiento_cobros_mult)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.remesas, i_asiento_rem)
else
	// Desacemos los cambios realizados
	Execute Immediate "ROLLBACK Transaction" using SQLCA;
	Execute Immediate "ROLLBACK Transaction" using bd_ejercicio;
	EXECUTE IMMEDIATE "rollback" USING SQLCA;
	EXECUTE IMMEDIATE "rollback" USING bd_ejercicio;
	rollback USING SQLCA; 
	rollback USING bd_ejercicio;
	messagebox(g_titulo, "Se ha producido un error al intentar actualizar facturas y grabar los apuntes generados"+cr+"Avise al departamento de inform$$HEX1$$e100$$ENDHEX$$tica", stopsign!)
end if
// Cerramos la transaccion
EXECUTE IMMEDIATE "END tran" USING SQLCA;
EXECUTE IMMEDIATE "END tran" USING bd_ejercicio;
// restauramos los autocomit
SQLCA.autocommit = b_autocomit_SQLCA
bd_ejercicio.autocommit = b_autocomit_bd_ejercicio

this.enabled = false
*/
end event

event clicked;// Simplemente grabamos los distintos datawindows, haciendolos atomicos el grabado
long asiento_exp, asiento_ot, asiento_rem, asiento_cobros_mult
long fila
string n_asiento, n_asiento_old, n_asiento_renumerado, diario, diario_old

// Cogemos los numeros de asientos correspondientes, pq vamos a renumerar todos los asientos generados
boolean b_error = false, b_autocomit_SQLCA, b_autocomit_bd_ejercicio

// Quitamos los autocomit
b_autocomit_SQLCA = SQLCA.autocommit
b_autocomit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
// Iniciamos una transaccion, para hacer el proceso atomico
Execute Immediate "BEGIN tran" using SQLCA;
EXECUTE IMMEDIATE "BEGIN tran" USING bd_ejercicio;

// MODIFICADO RICARDO 2005-07-27
// PARA LA RENUMERACI$$HEX1$$d300$$ENDHEX$$N DE ASIENTOS CONTABLES
n_asiento = "-1"
diario = "-1"
n_asiento_old = ''
diario_old = ''
FOR fila = 1 to idw_apuntes.RowCount()
	diario = idw_apuntes.getitemstring(fila, 'diario')
	n_asiento = idw_apuntes.getitemstring(fila, 'n_asiento')
	// Si cambia de asiento/diario, renumeramos de nuevo
	if n_asiento <> n_asiento_old or diario<>diario_old then
		n_asiento_renumerado = f_siguiente_numero_bd_ejercicio(diario,7) // ESto asegura que los numeros de asiento se hagan bien
	end if
	// Cambiamos el asiento segun
	idw_apuntes.SetItem(fila, 'n_asiento', n_asiento_renumerado)
	
	// Mantenemos los datos de la iteracion anterior
	n_asiento_old = n_asiento
	diario_old = diario
NEXT
idw_apuntes.groupcalc()
// FIN MODIFICADO RICARDO 2005-07-27

if idw_facturas.Update()<>1 then b_error = true
if idw_cobros.Update()<>1 then b_error = true
if idw_cobros_multiples.Update()<>1 then b_error = true
if idw_apuntes.Update()<>1 then b_error = true
if idw_cobros_facturas_contabilizadas.update()<>1 then b_error = true

if not b_error then
	// Confirmamos los cambios
	Execute Immediate "COMMIT Transaction" using SQLCA;
	Execute Immediate "COMMIT Transaction" using bd_ejercicio;
	commit USING SQLCA; 
	commit USING bd_ejercicio;

	// MODIFICADO RICARDO 2005-07-27
	// AHORA ESTA PARTE YA NO TIENE SENTIDO
	// Ahora actualizamos las bbdd de contadores
	//f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento_exp)
	//f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento_ot)
	//f_actualiza_numero_bd_ejercicio(g_sica_diario.cobros_multiples, i_asiento_cobros_mult)
	//f_actualiza_numero_bd_ejercicio(g_sica_diario.remesas, i_asiento_rem)
	// FIN MODIFICADO RICARDO 2005-07-27
else
	// Desacemos los cambios realizados
	Execute Immediate "ROLLBACK Transaction" using SQLCA;
	Execute Immediate "ROLLBACK Transaction" using bd_ejercicio;
	EXECUTE IMMEDIATE "rollback" USING SQLCA;
	EXECUTE IMMEDIATE "rollback" USING bd_ejercicio;
	rollback USING SQLCA; 
	rollback USING bd_ejercicio;
	messagebox(g_titulo, "Se ha producido un error al intentar actualizar facturas y grabar los apuntes generados"+cr+"Avise al departamento de inform$$HEX1$$e100$$ENDHEX$$tica", stopsign!)
end if
// Cerramos la transaccion
EXECUTE IMMEDIATE "END tran" USING SQLCA;
EXECUTE IMMEDIATE "END tran" USING bd_ejercicio;
// restauramos los autocomit
SQLCA.autocommit = b_autocomit_SQLCA
bd_ejercicio.autocommit = b_autocomit_bd_ejercicio

this.enabled = false

end event

type cb_buscar from commandbutton within w_proconta_facturas_contabiliza_old
integer x = 27
integer y = 1428
integer width = 366
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar Fact"
end type

event clicked;idw_apuntes.Reset()
datetime f_inicio,f_fin
string centro, serie
string mensaje=''
long num_filas


if not ib_comprobadas_variables then
	long cuantos
	if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
	
	if f_es_vacio(g_conta.concepto_exp) then mensaje = mensaje + cr + "g_conta.concepto_exp"
	if f_es_vacio(g_conta.concepto_rv) then mensaje = mensaje + cr + "g_conta.concepto_rv"
	if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
	if f_es_vacio(g_conta.ret_vol) then mensaje = mensaje + cr + "g_conta.ret_vol"
	if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
	//if f_es_vacio(g_prefijo_arqui_iva) then mensaje = mensaje + cr + "g_prefijo_arqui_iva"
	//if f_es_vacio(g_prefijo_arqui_rf) then mensaje = mensaje + cr + "g_prefijo_arqui_rf"
	if f_es_vacio(g_sica_diario.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_exp"

	if f_es_vacio(g_sica_diario.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_ot"
	if f_es_vacio(g_sica_diario.remesas) then mensaje = mensaje + cr + "g_sica_diario.remesas"
	if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
	if f_es_vacio(g_sica_t_doc.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_exp"
	if f_es_vacio(g_sica_t_doc.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_ot"
	if f_es_vacio(g_sica_t_doc.remesas) then mensaje = mensaje + cr + "g_sica_t_doc.remesas"
	if f_es_vacio(g_sica_t_doc.cobros_multiples) then mensaje = mensaje + cr + "g_sica_t_doc.cobros_multiples"
	if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia"
	if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
	if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico"
	if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
	if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"
	
	select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_t_iva where descripcion = null or descripcion = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay Tipos de IVA sin descripci$$HEX1$$f300$$ENDHEX$$n: Se generar$$HEX1$$e100$$ENDHEX$$n mal los conceptos.",Stopsign!)
	
	select count(*) into :cuantos from csi_t_iva where id_cuenta_repercutido = null or id_cuenta_repercutido = '';
	if cuantos > 0 then Messagebox(g_titulo,"Hay Tipos de IVA sin la cuenta contable definida: Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_articulos_servicios where cuenta = null or cuenta = '';
	if cuantos > 0 then Messagebox(g_titulo,"Art$$HEX1$$ed00$$ENDHEX$$culos/Servicios sin la cuenta contable definida: Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)
	
	select count(*) into :cuantos from csi_articulos_servicios where concepto_conta = null or concepto_conta = '';
	if cuantos > 0 then Messagebox(g_titulo,"Art$$HEX1$$ed00$$ENDHEX$$culos/Servicios sin el concepto (resumen). Se generar$$HEX1$$e100$$ENDHEX$$n mal los conceptos.",Stopsign!)
	
	if mensaje <> '' then
		mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
		messagebox(g_titulo,mensaje,Stopsign!)
		Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	end if
	ib_comprobadas_variables = true
end if


mensaje = ''


dw_fechas.AcceptText()

SetPointer(HourGlass!)

// Cogemos los datos de la consulta que tenemos
f_inicio = dw_fechas.GetItemDateTime(1,'f_inicio')
f_inicio = datetime(date(f_inicio), time('00:00:00'))
f_fin		= DateTime(RelativeDate(Date(dw_fechas.GetItemDateTime(1,'f_fin')),1))
centro = dw_fechas.GetItemString(1,'centro')
if f_es_vacio(centro) then centro = '%'
serie= dw_fechas.GetItemString(1,'serie')
if f_es_vacio(serie) then serie= '%' else serie += '%'
// Hacemos las validaciones pertinentes sobre la consulta
if isnull(f_inicio) then mensaje += 'La fecha de inicio no puede ser nula.'+cr
if isnull(f_fin) then mensaje += 'La fecha final no puede ser nula.'+cr
if f_fin<f_inicio then mensaje += 'La fecha final no puede ser anterior a la fecha inicio.'

// Si hay errores los mostramos... sino, recuperamos las filas y lo ponemos en pantalla
if mensaje<>'' then
	messagebox(g_titulo,mensaje)
	return
else
	string texto
	num_filas = idw_facturas.Retrieve(f_inicio,f_fin, centro, serie)	
	texto = string(num_filas)+ ' Facturas.'
	// REcuperamos cobros y cobros multiples
	idw_cobros.Retrieve(f_inicio,f_fin, centro, serie)
	num_filas = idw_cobros_multiples.Retrieve(f_inicio,f_fin, centro, serie)
	if num_filas>0 then texto += '  -  ' + string(num_filas)+ ' Cobros multiples.'

	num_filas = idw_cobros_facturas_contabilizadas.Retrieve(f_inicio,f_fin, centro, serie)
	if num_filas>0 then texto += '  -  ' + string(num_filas)+ ' Cobros de fact. contab. o bien de fact. remesadas no contab.'
	st_cuantas_facturas.text= texto
end if

mensaje = ''

// Modificado Ricardo 2005-04-28
// Miramos si son todas del a$$HEX1$$f100$$ENDHEX$$o actual para contabilizarlas
if wf_verificar_facturas()<1 and not(g_debug = '1') then cb_apuntes.enabled = false


// Vaciamos el otro texto, que suele quedar mal que se quede visible
st_progreso.text = ''

SetPointer(Arrow!)
end event

