HA$PBExportHeader$w_facturas_contabiliza.srw
forward
global type w_facturas_contabiliza from w_sheet
end type
type cb_actualizar from commandbutton within w_facturas_contabiliza
end type
type dw_fechas from u_dw within w_facturas_contabiliza
end type
type cb_buscar from commandbutton within w_facturas_contabiliza
end type
type dw_1 from u_dw within w_facturas_contabiliza
end type
type dw_2 from u_dw within w_facturas_contabiliza
end type
type cb_apuntes from commandbutton within w_facturas_contabiliza
end type
type cb_salir from commandbutton within w_facturas_contabiliza
end type
type st_1 from statictext within w_facturas_contabiliza
end type
type st_2 from statictext within w_facturas_contabiliza
end type
type cb_grabar_facturas from commandbutton within w_facturas_contabiliza
end type
type cb_2 from commandbutton within w_facturas_contabiliza
end type
type cb_imprimir_ap from commandbutton within w_facturas_contabiliza
end type
type dw_3 from u_dw within w_facturas_contabiliza
end type
type st_3 from statictext within w_facturas_contabiliza
end type
type st_4 from statictext within w_facturas_contabiliza
end type
end forward

global type w_facturas_contabiliza from w_sheet
integer x = 14
integer y = 336
integer width = 3502
integer height = 2376
string title = "Contabilizaci$$HEX1$$f300$$ENDHEX$$n Facturas Pendientes"
windowstate windowstate = maximized!
event csd_pre_conta ( )
event type long csd_preconta_ejercicio ( ref string mensaje )
cb_actualizar cb_actualizar
dw_fechas dw_fechas
cb_buscar cb_buscar
dw_1 dw_1
dw_2 dw_2
cb_apuntes cb_apuntes
cb_salir cb_salir
st_1 st_1
st_2 st_2
cb_grabar_facturas cb_grabar_facturas
cb_2 cb_2
cb_imprimir_ap cb_imprimir_ap
dw_3 dw_3
st_3 st_3
st_4 st_4
end type
global w_facturas_contabiliza w_facturas_contabiliza

type variables
double i_asiento
long i_asiento_exp, i_asiento_ot
end variables

forward prototypes
public subroutine wf_salir ()
end prototypes

event csd_pre_conta();long cuantos
string mensaje = ''
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
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_exp"
if f_es_vacio(g_sica_t_doc.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_t_doc.facts_emitidas_ot"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico"
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
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

cb_buscar.enabled = true
end event

event type long csd_preconta_ejercicio(ref string mensaje);double i
long returno = 1

mensaje = ''
for i = 1 to dw_1.rowcount()
	if string(year(date(dw_1.getitemdatetime(i, 'fecha')))) <> g_ejercicio then
		mensaje += 'Facturas de Expedientes. El a$$HEX1$$f100$$ENDHEX$$o de la l$$HEX1$$ed00$$ENDHEX$$nea ' + string(i)+ ' es diferente del ejercicio con el que entr$$HEX1$$f300$$ENDHEX$$.' +cr
		returno = -1
	end if
next

for i = 1 to dw_3.rowcount()
	if string(year(date(dw_3.getitemdatetime(i, 'fecha')))) <> g_ejercicio then
		mensaje += 'Facturas NO de Expedientes. El a$$HEX1$$f100$$ENDHEX$$o de la l$$HEX1$$ed00$$ENDHEX$$nea ' + string(i)+ ' es diferente del ejercicio con el que entr$$HEX1$$f300$$ENDHEX$$.'+cr		
		returno = -1
	end if	
next
if mensaje <> '' then
	messagebox(g_titulo, mensaje)
end if

return returno

end event

public subroutine wf_salir ();dynamic event closequery()
Close(this)

end subroutine

on w_facturas_contabiliza.create
int iCurrent
call super::create
this.cb_actualizar=create cb_actualizar
this.dw_fechas=create dw_fechas
this.cb_buscar=create cb_buscar
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_apuntes=create cb_apuntes
this.cb_salir=create cb_salir
this.st_1=create st_1
this.st_2=create st_2
this.cb_grabar_facturas=create cb_grabar_facturas
this.cb_2=create cb_2
this.cb_imprimir_ap=create cb_imprimir_ap
this.dw_3=create dw_3
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_actualizar
this.Control[iCurrent+2]=this.dw_fechas
this.Control[iCurrent+3]=this.cb_buscar
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_apuntes
this.Control[iCurrent+7]=this.cb_salir
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_grabar_facturas
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cb_imprimir_ap
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_4
end on

on w_facturas_contabiliza.destroy
call super::destroy
destroy(this.cb_actualizar)
destroy(this.dw_fechas)
destroy(this.cb_buscar)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_apuntes)
destroy(this.cb_salir)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_grabar_facturas)
destroy(this.cb_2)
destroy(this.cb_imprimir_ap)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

inv_resize.of_register (dw_1, "scaletoright")
inv_resize.of_register (dw_2, "scaletoright&bottom")
inv_resize.of_register (dw_3, "scaletoright")

dw_fechas.Event pfc_addrow( )

dw_fechas.SetItem(1,'f_inicio',Today())
dw_fechas.SetItem(1,'f_fin',Today())
if g_conta.enlace_facturas = 'MINUTAS' then
	dw_1.DataObject = 'd_facturas_contabiliza_minutas'
	dw_1.SetTransObject(SQLCA)
end if

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

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_facturas_contabiliza
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_facturas_contabiliza
end type

type cb_actualizar from commandbutton within w_facturas_contabiliza
string tag = "&Apuntes"
integer x = 2181
integer y = 32
integer width = 370
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar Ap."
end type

event clicked;//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

// Simplemente grabamos los distintos datawindows, haciendolos atomicos el grabado

boolean b_error = false, b_autocomit_SQLCA, b_autocomit_bd_ejercicio

// Quitamos los autocomit
b_autocomit_SQLCA = SQLCA.autocommit
b_autocomit_bd_ejercicio = bd_ejercicio.autocommit
SQLCA.autocommit = false
bd_ejercicio.autocommit = false
// Iniciamos una transaccion, para hacer el proceso atomico
Execute Immediate "BEGIN tran" using SQLCA;
EXECUTE IMMEDIATE "BEGIN tran" USING bd_ejercicio;

if dw_1.Update()<>1 then b_error = true
if dw_2.Update()<>1 then b_error = true
if dw_3.Update()<>1 then b_error = true


if not b_error then
	// Dejamos los cobros como contabilizados.
	double i
	string id_factura
	datetime fecha
	
	//Contabilizamos los cobros que se deban contabilizar
	for i=1 to dw_1.RowCount()
		id_factura=''
		if dw_1.GetItemString(i,'contabilizar_cobro')='S' then
			id_factura = dw_1.GetItemString(i,'id_factura')
			if f_es_vacio(id_factura) then continue
			select f_pago into :fecha from csi_facturas_emitidas where id_factura = :id_factura;
			update csi_cobros set contabilizado='S',f_contabilizado=:fecha where id_factura=:id_factura;
		end if 
	next
	
	for i=1 to dw_3.RowCount()
		id_factura=''
		if dw_3.GetItemString(i,'contabilizar_cobro')='S' then
			id_factura = dw_3.GetItemString(i,'id_factura')
			if f_es_vacio(id_factura) then continue		
			select f_pago into :fecha from csi_facturas_emitidas where id_factura = :id_factura;
			update csi_cobros set contabilizado='S',f_contabilizado=:fecha where id_factura=:id_factura;
		end if
	next
	
	// Confirmamos los cambios
	Execute Immediate "COMMIT Transaction" using SQLCA;
	Execute Immediate "COMMIT Transaction" using bd_ejercicio;
	commit USING SQLCA; 
	commit USING bd_ejercicio;
	// Ahora actualizamos las bbdd de contadores
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento_exp)
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento_ot)
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

type dw_fechas from u_dw within w_facturas_contabiliza
integer y = 4
integer width = 1198
integer height = 220
integer taborder = 10
string dataobject = "d_facturas_desdehasta"
boolean vscrollbar = false
boolean border = false
end type

event pfc_updatespending;return 0
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_buscar from commandbutton within w_facturas_contabiliza
integer x = 1509
integer y = 32
integer width = 334
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Buscar Fact"
end type

event clicked;dw_2.Reset()
datetime f_inicio,f_fin
string centro
string mensaje=''
long num_filas

dw_fechas.AcceptText()

SetPointer(HourGlass!)

f_inicio = dw_fechas.GetItemDateTime(1,'f_inicio')
f_inicio = datetime(date(f_inicio), time('00:00:00'))
f_fin		= DateTime(RelativeDate(Date(dw_fechas.GetItemDateTime(1,'f_fin')),1))
//f_fin = datetime(date(f_fin), time('23:59:59'))
centro = dw_fechas.GetItemString(1,'centro')
if f_es_vacio(centro) then centro = '%'

if isnull(f_inicio) then
	mensaje += 'La fecha de inicio no puede ser nula.'+cr
end if

if isnull(f_fin) then
	mensaje += 'La fecha final no puede ser nula.'+cr
end if

if f_fin<f_inicio then
	mensaje += 'La fecha final no puede ser anterior a la fecha inicio.'
end if

if mensaje<>'' then
	messagebox(g_titulo,mensaje)
	return
else
	num_filas = dw_1.Retrieve(f_inicio,f_fin, centro)	
	st_1.text= string(num_filas)+ ' Facturas.'
	num_filas = dw_3.Retrieve(f_inicio,f_fin, centro)	
	st_3.text= string(num_filas)+ ' Facturas.'
end if

mensaje = ''
// Si hay alguna factura que no es de este ejercicio no permitimos generar los apuntes!!
if parent.trigger event csd_preconta_ejercicio(mensaje)<0 then cb_apuntes.enabled = false

SetPointer(Arrow!)

end event

type dw_1 from u_dw within w_facturas_contabiliza
integer x = 32
integer y = 228
integer width = 3415
integer height = 548
integer taborder = 10
string dataobject = "d_facturas_contabiliza"
boolean hscrollbar = true
end type

event itemchanged;cb_grabar_facturas.enabled = true
end event

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (dw_3.RowCount() > 0)
end event

type dw_2 from u_dw within w_facturas_contabiliza
integer x = 32
integer y = 1440
integer width = 3415
integer height = 784
integer taborder = 10
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

type cb_apuntes from commandbutton within w_facturas_contabiliza
string tag = "&Apuntes"
integer x = 1842
integer y = 32
integer width = 338
integer height = 68
integer taborder = 10
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

this.enabled = false
long i, j, k,lineas
double subtotal, subtotal_iva, total, importe_reten, t_ret_vol, importe_ret_vol, linea_subtotal, linea_iva, imp_iva, base_imp
double descuento, linea_dto
String formadepago, cuenta, cuenta_iva, cuenta_col , t_iva, ctabanco, banco, id_fase
string n_expedi, cliente, cuenta_ret, id_col, n_factura, pagado, tipo_pago, id_minuta
string tipo_factura, id_factura, cuenta_presupuestaria, centro, proyecto, concepto_conta, concepto_base, concepto, concepto_iva
Boolean HayIngreso
Datetime fecha
// Las siguientes variables son s$$HEX1$$f300$$ENDHEX$$lo para la gesti$$HEX1$$f300$$ENDHEX$$n de garant. en Apas.
double importe_garantia
string concepto_garantia
// Las siguientes variables son s$$HEX1$$f300$$ENDHEX$$lo para contabilizar los 2 dws
long zzz
datawindow dw_auxiliar

//DATASTORE PARA PROCESAR LAS LINEAS DE FACTURA (SOLO EN GASTOS)
Datastore ds_lineas
ds_lineas = create datastore
ds_lineas.DataObject = 'd_conta_lineas_fact_emitidas'
ds_lineas.SetTransObject(SQLCA)

Datastore ds_iva
ds_iva = create datastore
ds_iva.DataObject = 'd_conta_d_contab_iva'
ds_iva.SetTransObject(SQLCA)
ds_iva.Retrieve()

SetPointer(Hourglass!)
dw_2.setredraw(false)

//Revisi$$HEX1$$f300$$ENDHEX$$n datos generales contabilidad
if f_es_vacio(g_conta.concepto_exp) then g_conta.concepto_exp = 'Exp'
if f_es_vacio(g_conta.concepto_rv) then g_conta.concepto_rv = 'RV'
if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_conta.ret_vol) then g_conta.ret_vol = 'C'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'
if f_es_vacio(g_prefijo_arqui_iva) then g_prefijo_arqui_iva = g_prefijo_arqui
if f_es_vacio(g_prefijo_arqui_rf) then g_prefijo_arqui_rf = g_prefijo_arqui

i_asiento_exp = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp,7))
i_asiento_ot  = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot,7))
i_asiento_exp = i_asiento_exp - 1
i_asiento_ot = i_asiento_ot - 1
if i_asiento_exp = 0 or isnull(i_asiento_exp) then i_asiento_exp = 0
if i_asiento_ot = 0 or isnull(i_asiento_ot) then i_asiento_ot = 0

dw_1.AcceptText()

for zzz = 1 to 2 // Para los dos datawindows
	if zzz = 1 then dw_auxiliar = dw_1 else dw_auxiliar = dw_3

	for i = 1 to dw_auxiliar.RowCount()
		st_2.text = 'Procesando ' + string(i) + ' de ' + string(dw_auxiliar.RowCount())+' facturas. '+string(dw_2.RowCount())+' apuntes generados.'
	
		//Preproceso necesario para el c$$HEX1$$e100$$ENDHEX$$lculo de IVA totalizado por tipo
		FOR k=1 TO ds_iva.RowCount()
			ds_iva.SetItem(k,'importe',0)
			ds_iva.SetItem(k,'base_imp',0)
		NEXT
		//Fin preproceso IVA/IGIC
	
		fecha = dw_auxiliar.GetItemDateTime(i,'fecha')
		//Marcamos la factura como contabilizada:
		dw_auxiliar.SetItem(i,'contabilizada','S')
		// Modificado Paco: 15/11/2005. ponia g_apunte.fecha en lugar de fecha, al no estar inicializada la primera factura quedaba con f_conta=01/01/1900
		dw_auxiliar.SetItem(i,'f_conta',fecha)
		
		//OBTENCION DE DATOS NECESARIOS PARA CONTABILIZACION Y CONSTRUCCION DE LOS CONCEPTOS
		tipo_factura = dw_auxiliar.GetItemString(i,'tipo_factura')
		//Obtenci$$HEX1$$f300$$ENDHEX$$n de DATOS COMUNES A FACTURAS DE HONORARIOS Y DE GASTOS:
		if zzz = 1 then
			n_expedi = dw_auxiliar.GetItemString(i,'expedientes_n_expedi')+'-'+dw_auxiliar.GetItemString(i,'fases_fase')
			id_fase = dw_auxiliar.GetItemString(i,'id_fase')
			id_minuta = dw_auxiliar.GetItemString(i,'id_minuta')
		else
			n_expedi = ''
			id_fase = ''
			id_minuta = ''
		end if
		
		id_factura = dw_auxiliar.GetItemString(i,'id_factura')
		n_factura = dw_auxiliar.GetItemString(i,'n_fact')
		pagado = dw_auxiliar.GetItemString(i,'pagado')
		// Siempre que la factura est$$HEX2$$e9002000$$ENDHEX$$pagada dejaremos el cobro contabilizado
		if pagado = 'S' then dw_auxiliar.setitem(i, 'contabilizar_cobro', 'S') else dw_auxiliar.setitem(i, 'contabilizar_cobro', 'N')
		//Importes:
		total = dw_auxiliar.GetItemNumber(i,'total')
		subtotal = dw_auxiliar.GetItemNumber(i,'subtotal')
		descuento = dw_auxiliar.GetItemNumber(i,'descuento')
		if isnull(descuento) then descuento = 0
		if descuento <> 0 then subtotal = subtotal - descuento
		importe_reten = dw_auxiliar.GetItemNumber(i,'importe_reten')
		subtotal_iva = dw_auxiliar.GetItemNumber(i,'iva')
		concepto_base=''
		if zzz = 1 then concepto_base = g_conta.concepto_exp +' ' + n_expedi else concepto_base = ''
		concepto = ''
		//Veamos la forma de pago y si hay ingreso en banco:
		formadepago = upper(dw_auxiliar.GetItemString(i,'formadepago'))
		select hay_ingreso into :tipo_pago from csi_formas_de_pago where tipo_pago = :formadepago;
		HayIngreso = (upper(tipo_pago) = 'S')
		//Banco y su cuenta contable:
		banco = dw_auxiliar.GetItemString(i,'banco')
		select cuenta_contable into :ctabanco from csi_bancos where codigo = :banco;
		
		//Rellenamos DATOS GENERALES DE G_APUNTE
		if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
			// Es una factura no ligada a contrato
			i_asiento_ot++
			g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_ot)),7)
			g_apunte.t_doc = g_sica_t_doc.facts_emitidas_ot
			g_apunte.diario = g_sica_diario.facts_emitidas_ot
			// Si el diario es el mismo que la factura de expedientes avanzamos tambien con la otra variable
			if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp++
		else
			// Es una factura de contratos
			i_asiento_exp++
			g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento_exp)),7)
			g_apunte.t_doc = g_sica_t_doc.facts_emitidas_exp
			g_apunte.diario = g_sica_diario.facts_emitidas_exp
			// Si el diario es el mismo que la factura de no expedientes avanzamos tambien con la otra variable
			if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot++
		end if
		g_apunte.n_apunte = '00000'
		g_apunte.n_doc = n_factura
		g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
		g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
		g_apunte.id_interno = id_factura
		// Nuevo!!!!
		g_apunte.centro = dw_auxiliar.GetItemString(i,'centro')
		if f_es_vacio(g_apunte.centro) then g_apunte.centro = g_centro_por_defecto
		if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
		g_apunte.proyecto = g_explotacion_por_defecto
		// Nuevo hasta aqu$$HEX1$$ed00$$ENDHEX$$
		// Modificado Ricardo 2004-10-25
		g_apunte.nif = dw_auxiliar.GetItemString(i,'nif')
		g_apunte.nombre = dw_auxiliar.GetItemString(i,'nombre')
		// FIN Modificado Ricardo 2004-10-25
		
		total = dw_auxiliar.GetItemNumber(i,'total')
			
		CHOOSE CASE tipo_factura
			CASE '04' //FACTURA DE HONORARIOS : COLEGIADO A CLIENTE
				//Lo primero: si no hay ingreso, se trata de autoliquidaci$$HEX1$$f300$$ENDHEX$$n por lo que no se contabiliza nada
				if not HayIngreso then
					if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
						i_asiento_ot --
						// Si el diario es el mismo que la factura de expedientes decrementamos tambien con la otra variable
						if g_sica_diario.facts_emitidas_ot = g_sica_diario.facts_emitidas_exp then i_asiento_exp --
					else
						i_asiento_exp --
						// Si el diario es el mismo que la factura de no expedientes decrementamos tambien con la otra variable
						if g_sica_diario.facts_emitidas_exp = g_sica_diario.facts_emitidas_ot then i_asiento_ot --
					end if
					continue
				end if
				
				id_col  = dw_auxiliar.GetItemString(i,'emisor')
				
				//Obtenemos las cuentas del colegiado. En las funciones debe estar el c$$HEX1$$f300$$ENDHEX$$digo de creaci$$HEX1$$f300$$ENDHEX$$n de cuentas y ver si procede su utilizaci$$HEX1$$f300$$ENDHEX$$n.
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol
				cuenta_iva = f_dame_cuenta_col(id_col,'I') 	//IVA
				
				cliente = dw_auxiliar.GetItemString(i,'nombre')
				concepto_base = concepto_base + ' ' + cliente
	
				subtotal = dw_auxiliar.GetItemNumber(i,'subtotal')

				descuento = dw_auxiliar.GetItemNumber(i,'descuento')
				if isnull(descuento) then descuento = 0
				if descuento <> 0 then subtotal = subtotal - descuento				
		
				importe_garantia = 0
				
				select sum(total) into :importe_garantia from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = :g_conta.garantia_codigo_articulo;
				// Si el Colegio es Gipuzkoa se resta ( o mejor suma ) la provisi$$HEX1$$f300$$ENDHEX$$n de fondos al subtotal
				if g_colegio = 'COAATGUI' and importe_garantia <> 0 then
					subtotal = f_redondea(subtotal - importe_garantia) 
				end if			
				
				importe_reten = dw_auxiliar.GetItemNumber(i,'importe_reten')
				t_ret_vol = 0
				importe_ret_vol = 0
				if g_conta.ret_vol = 'C' then
					//Ver si tiene retenci$$HEX1$$f300$$ENDHEX$$n voluntaria:
					select ret_voluntaria into :t_ret_vol from colegiados where id_colegiado = :id_col;
					if isnull(t_ret_vol) then t_ret_vol = 0
					importe_ret_vol = round(subtotal * t_ret_vol / 100 , 2)
				end if
				//Ahora hacemos los 8 posibles apuntes de una factura de honorarios:
				// Honorarios (base)
				concepto = LeftA('Hon ' + concepto_base,57)
				g_apunte.concepto = concepto
				g_apunte.cuenta = cuenta_col
				g_apunte.debe = 0
				g_apunte.haber = subtotal
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)
				f_apunte_dw(g_apunte,dw_2,'E')
				//Para ver la descripcion del tipo de IVA en las facturas de honorarios,
				//miramos la l$$HEX1$$ed00$$ENDHEX$$nea de la factura cuyo art$$HEX1$$ed00$$ENDHEX$$culo es 'HO' (espero que valga para aparejadores)
				select t_iva into :t_iva from csi_lineas_fact_emitidas where id_factura = :id_factura and articulo = '15';
				select descripcion into :concepto_iva from csi_t_iva where t_iva = :t_iva;
				// IVA: al haber de la cuenta de iva
				concepto = LeftA(concepto_iva + ' Hon ' + concepto_base,57)
				g_apunte.cuenta = cuenta_iva
				g_apunte.concepto = concepto	
				g_apunte.debe = 0
				g_apunte.haber = subtotal_iva
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
				g_apunte.base_imp = dw_auxiliar.GetItemNumber(i,'base_imp') // MODIFICADO RICARDO 2004-10-25
				// 05/11/04 MODIFICADO POR GONZALO. A$$HEX1$$f100$$ENDHEX$$adimos el nombre, el nif y el t_iva al apunte
				g_apunte.nombre = cliente
				g_apunte.nif = dw_auxiliar.GetItemString(i, 'nif')
				g_apunte.t_iva = t_iva
				// 05/11/04 FIN MODIFICACION GONZALO
				f_apunte_dw(g_apunte,dw_2,'E')	
				g_apunte.base_imp = 0 // MODIFICADO RICARDO 2004-10-25
				// IRPF: al debe de los honorarios
				g_apunte.concepto = LeftA('IRPF ' + concepto_base,57)
				g_apunte.cuenta = cuenta_col
				if importe_ret_vol <> 0 then g_apunte.cuenta = cuenta_ret //Si hay ret vol, cargamos el IRPF en cta retenc.
				g_apunte.debe = importe_reten
				g_apunte.haber = 0		
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
				f_apunte_dw(g_apunte,dw_2,'E')
				// Ret Vol: al debe de la cuenta de honorarios
				g_apunte.cuenta = cuenta_col
				concepto = LeftA(g_conta.concepto_rv + ' ' + concepto_base,57)
				g_apunte.concepto = concepto
				g_apunte.debe = importe_ret_vol
				g_apunte.haber = 0
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
				f_apunte_dw(g_apunte,dw_2,'E')
				// Ret Vol: al haber de las retenciones
				g_apunte.concepto = concepto
				g_apunte.cuenta = cuenta_ret
				g_apunte.debe = 0
				g_apunte.haber = importe_ret_vol		
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
				f_apunte_dw(g_apunte,dw_2,'E')
				//Gesti$$HEX1$$f300$$ENDHEX$$n de garant$$HEX1$$ed00$$ENDHEX$$as (S$$HEX1$$f300$$ENDHEX$$lo aparejadores)
				if not f_es_vacio(g_conta.garantia_codigo_articulo) then
					select concepto_conta into :concepto_garantia from csi_articulos_servicios where codigo = :g_conta.garantia_codigo_articulo;
					//Abono de la garant$$HEX1$$ed00$$ENDHEX$$a en cuenta del colegiado
					if g_colegio <> 'COAATGUI'  then				
						concepto = LeftA(trim(concepto_garantia) + ' ' + concepto_base,57)
						g_apunte.concepto = concepto
						g_apunte.cuenta = cuenta_col
						g_apunte.debe = importe_garantia
						g_apunte.haber = 0
						g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
						f_apunte_dw(g_apunte,dw_2,'E')
					
						//Descuento de la cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
						g_apunte.concepto = concepto
						g_apunte.cuenta = g_conta.garantia_cuenta
						g_apunte.debe = 0
						g_apunte.haber = importe_garantia
						g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
						f_apunte_dw(g_apunte,dw_2,'E')
					else // Solo para GIPUZKOA
						//Descuento de la cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
						concepto = LeftA(trim(concepto_garantia) + ' ' + concepto_base,57)
						g_apunte.concepto = concepto
						g_apunte.cuenta = cuenta_col
						g_apunte.debe = 0
						g_apunte.haber = importe_garantia
						g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)    
						f_apunte_dw(g_apunte,dw_2,'E')
					end if
				end if
				// Total: al debe del banco
				g_apunte.concepto = concepto_base
				g_apunte.cuenta = ctabanco
				g_apunte.debe = total
				g_apunte.haber = 0		
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
				f_apunte_dw(g_apunte,dw_2,'E')
				continue
				
			CASE '03' //FACTURA DE GASTOS A COLEGIADO:
				id_col = dw_auxiliar.GetItemString(i,'id_persona')
				cuenta_col = f_dame_cuenta_col(id_col,'P')	// personal / honorarios
				cuenta_ret = f_dame_cuenta_col(id_col,'R')	// ret. vol			
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
					concepto_base = concepto_base + ' ' + cliente		
				else
					// Si no son facturas de expedientes, cogemos el asunto de la factura
					concepto_base = dw_auxiliar.GetItemString(i,'asunto')
				end if
				
				if HayIngreso and pagado = 'S' then //Se ha hecho un ingreso: 2 apuntes
					choose case formadepago
						case g_formas_pago.transferencia
							g_apunte.t_doc = g_sica_t_doc.transferencia
						case g_formas_pago.talon
							g_apunte.t_doc = g_sica_t_doc.talon
						case else
							g_apunte.t_doc = g_sica_t_doc.generico
					end choose
					//Debe al banco del ingreso:
					g_apunte.cuenta = ctabanco
					g_apunte.debe = total
					g_apunte.haber = 0
					concepto = LeftA('Ing ' + concepto_base,57)
					if formadepago = 'DB' then concepto = LeftA('Dom ' + concepto_base,57)
					g_apunte.concepto = concepto
					g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
					f_apunte_dw(g_apunte,dw_2,'E')
					//Abono en cuenta del colegiado:
					g_apunte.cuenta = cuenta_col
					g_apunte.haber = total
					g_apunte.debe = 0
					g_apunte.concepto = concepto
					g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
					f_apunte_dw(g_apunte,dw_2,'E')
				end if
				//Si no hay ingreso no hay que hacer nada pues los gastos e iva se cargan
				//en la cuenta del colegiado
			
			CASE '02' //FACTURA DE GASTOS A PROMOTOR: COLEGIO A CLIENTE
				cuenta_col = ''
				id_col = dw_auxiliar.GetItemString(i,'id_persona')
				//Obtenci$$HEX1$$f300$$ENDHEX$$n cuenta contable del cliente. Si es vac$$HEX1$$ed00$$ENDHEX$$a se pone la general
				select cuenta_contable into :cuenta_col from clientes where id_cliente = :id_col;
				
				if f_es_vacio(cuenta_col) and g_conta.crear_cuentas_clientes_terceros = 'S' then
					cuenta_col = f_cuenta_contable_defecto_cli_provs('C', id_col)
				elseif f_es_vacio(cuenta_col) then
					cuenta_col = g_conta.cuenta_clientes_general
				end if
	
				cliente = dw_auxiliar.GetItemString(i,'nombre')
				concepto_base = concepto_base + ' ' + cliente
				
				if HayIngreso and pagado = 'S' then //Se ha hecho un ingreso: 2 apuntes
					choose case formadepago
						case g_formas_pago.transferencia
							g_apunte.t_doc = g_sica_t_doc.transferencia
						case g_formas_pago.talon
							g_apunte.t_doc = g_sica_t_doc.talon
						case else
							g_apunte.t_doc = g_sica_t_doc.generico
					end choose				
					//Debe al banco del ingreso:
					g_apunte.cuenta = ctabanco
					g_apunte.debe = total
					g_apunte.haber = 0
					concepto = LeftA('Ing ' + concepto_base,57)
					g_apunte.concepto = concepto
					g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
					f_apunte_dw(g_apunte,dw_2,'E')
					//Abono en cuenta del colegiado:
					g_apunte.cuenta = cuenta_col
					g_apunte.haber = total
					g_apunte.debe = 0
					g_apunte.concepto = concepto
					g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
					f_apunte_dw(g_apunte,dw_2,'E')
				end if		
			// FALTA EL TIPO 01
		END CHOOSE
		
		// REstauramos el tipo de documento que tuviesemos antes
		if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
			// Es una factura no ligada a contrato
			g_apunte.t_doc = g_sica_t_doc.facts_emitidas_ot
		else
			// Es una factura de contratos
			g_apunte.t_doc = g_sica_t_doc.facts_emitidas_exp
		end if
		
		ds_lineas.Retrieve(id_factura)
		lineas = ds_lineas.RowCount()
		
		//Procesamos las l$$HEX1$$ed00$$ENDHEX$$neas de facturas (S$$HEX1$$f300$$ENDHEX$$lo en facturas de gastos):
		FOR j=1 TO lineas
			//Lo primero, leemos los datos de las l$$HEX1$$ed00$$ENDHEX$$neas
			linea_subtotal = ds_lineas.GetItemNumber(j,'subtotal')
			linea_dto = ds_lineas.GetItemNumber(j,'importe_dto')
			if isnull(linea_dto) then linea_dto = 0
			if linea_dto <> 0 then linea_subtotal = linea_subtotal - linea_dto
			linea_iva = ds_lineas.GetItemNumber(j,'subtotal_iva')
			t_iva = ds_lineas.GetItemString(j,'t_iva')
			cuenta = ds_lineas.GetItemString(j,'cuenta')
			cuenta_presupuestaria = ds_lineas.GetItemString(j,'cuenta_presupuestaria')
			// Cogemos el centro de la linea, si esta vacio de la cabecera y sino el centro por defecto
			centro = ds_lineas.GetItemString(j,'centro')
			if f_es_vacio(centro) then centro = dw_auxiliar.GetItemString(i,'centro')
			if f_es_vacio(centro) then centro = g_centro_por_defecto
			proyecto = ds_lineas.GetItemString(j,'proyecto')
			if f_es_vacio(proyecto) then proyecto = g_explotacion_por_defecto
			//Las siguiente 3 lineas para prefijar los conceptos en funci$$HEX1$$f300$$ENDHEX$$n del articulo/servicio
			concepto_conta = ds_lineas.GetItemString(j,'concepto_conta')
			if isnull(concepto_conta) then concepto_conta = ''
			concepto_conta = trim(concepto_conta) + ' '
			
			if not f_es_vacio(id_fase) then
				concepto = LeftA(concepto_conta + concepto_base,57)
			else
				concepto_base = ds_lineas.GetItemString(j,'descripcion_larga')
				concepto = LeftA(concepto_conta + concepto_base,57)
			end if
			
			//Datos anal$$HEX1$$ed00$$ENDHEX$$ticos:
			g_apunte.centro = centro
			g_apunte.proyecto = proyecto
			g_apunte.cta_presupuestaria = cuenta_presupuestaria
			
			//Si la cuenta es 'RV' quiere decir que la retenci$$HEX1$$f300$$ENDHEX$$n voluntaria
			//aparece en l$$HEX1$$ed00$$ENDHEX$$neas de factura (COAPAs y alg$$HEX1$$fa00$$ENDHEX$$n COARQ)
			if cuenta = 'RV' then
				//Ret Vol: al debe de la cuenta de honorarios
				g_apunte.cuenta = cuenta_col
				g_apunte.concepto = concepto
				g_apunte.debe = linea_subtotal
				g_apunte.haber = 0
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
				f_apunte_dw(g_apunte,dw_2,'E')
				//Ret Vol: al haber de las retenciones
				g_apunte.concepto = 'Ret. Vol Ingreso Cuenta'
				g_apunte.cuenta = cuenta_ret
				g_apunte.debe = 0
				g_apunte.haber = linea_subtotal
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
				f_apunte_dw(g_apunte,dw_2,'E')
			else
				//APUNTE DEL INGRESO Y LA CONTRAP. A CUENTA COLEGIADO.
				g_apunte.cuenta = cuenta
				g_apunte.concepto = concepto
				g_apunte.debe = 0
				g_apunte.haber = linea_subtotal
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
				f_apunte_dw(g_apunte,dw_2,'E')
				//CONTRAPARTIDA AL COLEGIADO:
				g_apunte.cuenta = cuenta_col
				g_apunte.concepto = concepto
				g_apunte.debe = linea_subtotal
				g_apunte.haber = 0
				g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
				f_apunte_dw(g_apunte,dw_2,'E')
			end if
			
			//Proceso para acumular el importe para cada tipo de IVA/IGIC
			if linea_iva = 0 or isnull(linea_iva) then continue //Si no hay IVA nos vamos a la siguiente linea
			FOR k=1 TO ds_iva.RowCount()
				if t_iva <> ds_iva.GetItemString(k,'t_iva') then continue
				imp_iva = ds_iva.GetItemNumber(k,'importe') + linea_iva
				ds_iva.SetItem(k,'importe',imp_iva)
				// MODIFICADO RICARDO 2004-10-25
				base_imp = ds_iva.GetItemNumber(k,'base_imp') + linea_subtotal
				ds_iva.SetItem(k,'base_imp',base_imp)
				// FIN MODIFICADO RICARDO 2004-10-25
			NEXT
			//Fin proceso acumulaci$$HEX1$$f300$$ENDHEX$$n IVA/IGIC
		Next //Lineas de factura (j)
		//S$$HEX1$$f300$$ENDHEX$$lo queda descontar el IVA de la cuenta del colegiado y abonarlo en
		//la cuenta de IVA. Lo hacemos para cada tipo de IVA detectado de la factura:
		FOR k=1 TO ds_iva.RowCount()
			imp_iva = ds_iva.GetItemNumber(k,'importe')
			if imp_iva = 0 then continue
			concepto_iva = trim(ds_iva.GetItemString(k,'descripcion'))
			concepto = LeftA(concepto_iva + ' ' + concepto_base, 57)
			cuenta_iva = ds_iva.GetItemString(k,'id_cuenta_repercutido')
			//Apunte a la cuenta de iva
			g_apunte.cuenta = cuenta_iva
			g_apunte.debe = 0
			g_apunte.haber = imp_iva
			g_apunte.concepto = concepto
			g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)				
			g_apunte.base_imp = ds_iva.GetItemNumber(k,'base_imp')
			// 05/11/04 MODIFIADO POR GONZALO. A$$HEX1$$f100$$ENDHEX$$adimos el nombre, nif y t_iva al apunte
			g_apunte.nombre = dw_auxiliar.GetItemString(i, 'nombre')
			g_apunte.nif = dw_auxiliar.GetItemString(i, 'nif')
			g_apunte.t_iva = ds_iva.GetItemString(k, 't_iva')
			// 05/11/04 FIN MODIFICACION GONZALO.
			f_apunte_dw(g_apunte,dw_2,'E')
			g_apunte.base_imp = 0 // MODIFICADO RICARDO 2004-10-25
			//Apunte a la cuenta del colegiado
			g_apunte.cuenta = cuenta_col
			g_apunte.debe = imp_iva
			g_apunte.haber = 0
			g_apunte.concepto = concepto
			g_apunte.cta_presupuestaria = f_devuelve_cta_presup_enlace(g_apunte.cuenta, g_apunte.centro, g_apunte.proyecto, 100)			
			f_apunte_dw(g_apunte,dw_2,'E')			
		NEXT
	Next //facturas (i)
Next // 2 Datawindows
st_2.text = 'Presentando apuntes, espere por favor...'
dw_2.Sort()
dw_2.GroupCalc()
st_2.text = 'Generaci$$HEX1$$f300$$ENDHEX$$n de apuntes finalizada: '+string(dw_2.RowCount())+' apuntes generados.'
cb_actualizar.enabled = (dw_2.RowCount() > 0)
cb_imprimir_ap.enabled = (dw_2.RowCount() > 0)
destroy ds_lineas
destroy ds_iva
dw_2.setredraw(true)
end event

type cb_salir from commandbutton within w_facturas_contabiliza
integer x = 3241
integer y = 36
integer width = 201
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;
Close(Parent)

end event

type st_1 from statictext within w_facturas_contabiliza
integer x = 1225
integer y = 116
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean focusrectangle = false
end type

type st_2 from statictext within w_facturas_contabiliza
integer x = 1765
integer y = 116
integer width = 1522
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean focusrectangle = false
end type

type cb_grabar_facturas from commandbutton within w_facturas_contabiliza
integer x = 2843
integer y = 32
integer width = 398
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Grabar facturas"
end type

event clicked;dw_1.Update()
dw_3.update()
end event

type cb_2 from commandbutton within w_facturas_contabiliza
integer x = 1202
integer y = 32
integer width = 306
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pre-conta"
end type

event clicked;Parent.TriggerEvent("csd_pre_conta")
end event

type cb_imprimir_ap from commandbutton within w_facturas_contabiliza
integer x = 2551
integer y = 32
integer width = 293
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Imprimir Ap."
end type

event clicked;string texto = ''
datetime f_desde, f_hasta

// Para el COAATGUI ponemos las fechas de las facturas
if g_colegio = 'COAATGUI' then
	if dw_1.rowcount() > 0 then
		f_desde = dw_1.getitemdatetime(1, 'fecha')
		f_hasta = dw_1.getitemdatetime(dw_1.rowcount(), 'fecha')
		texto = 'Facts. Exp.: ' + string(f_desde, "dd/mm/yyyy") + ' - ' + string(f_hasta, "dd/mm/yyyy") + '     '
	end if
	if dw_3.rowcount() > 0 then
		f_desde = dw_3.getitemdatetime(1, 'fecha')
		f_hasta = dw_3.getitemdatetime(dw_3.rowcount(), 'fecha')
		texto += 'Facts. NO Exp.: ' + string(f_desde, "dd/mm/yyyy") + ' - ' + string(f_hasta, "dd/mm/yyyy")
	end if
	dw_2.object.fechas_facts.text = texto
end if

dw_2.Print()
end event

type dw_3 from u_dw within w_facturas_contabiliza
integer x = 32
integer y = 840
integer width = 3415
integer height = 592
integer taborder = 10
string dataobject = "d_facturas_contabiliza_sin_expedi"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;cb_grabar_facturas.enabled = true
end event

event retrieveend;call super::retrieveend;cb_apuntes.enabled = (this.RowCount() > 0) or  (dw_1.RowCount() > 0)
end event

type st_3 from statictext within w_facturas_contabiliza
integer x = 1225
integer y = 784
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean focusrectangle = false
end type

type st_4 from statictext within w_facturas_contabiliza
integer x = 1765
integer y = 784
integer width = 1522
integer height = 304
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
boolean focusrectangle = false
end type

