HA$PBExportHeader$w_garantias_devolucion.srw
forward
global type w_garantias_devolucion from w_response
end type
type dw_1 from u_dw within w_garantias_devolucion
end type
type cb_cancelar from commandbutton within w_garantias_devolucion
end type
type cb_aceptar from commandbutton within w_garantias_devolucion
end type
type dw_liquid from u_dw within w_garantias_devolucion
end type
type dw_2 from u_dw within w_garantias_devolucion
end type
end forward

global type w_garantias_devolucion from w_response
integer width = 2368
integer height = 1140
string title = "Devoluci$$HEX1$$f300$$ENDHEX$$n Garant$$HEX1$$ed00$$ENDHEX$$a"
event csd_emitir_talon ( )
event type long csd_emitir_transferencia ( )
dw_1 dw_1
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_liquid dw_liquid
dw_2 dw_2
end type
global w_garantias_devolucion w_garantias_devolucion

type variables
string i_id_liq
st_cobros_datos_remesa i_datos_remesa
end variables

forward prototypes
public subroutine f_generar_liquidacion ()
public function integer f_genera_talon (string n_talon_inicial, datetime fecha, string banco)
public subroutine f_contabiliza ()
end prototypes

event csd_emitir_talon();string n_talon_inicial, banco
datetime fecha_talon

st_liquidacion_datos_talon ds_talon
//i_modo_liq = dw_modo_liq.GetItemString(1,'modo_liquidacion')

//if i_reproceso then
//	Messagebox(g_titulo,"Recuerde que no todas las liquidaciones est$$HEX1$$e100$$ENDHEX$$n pendientes, por lo que este proceso SOLO imprime talones. NO SE ACTUALIZARAN DATOS!!",Exclamation!)
//else
	Open(w_premaat_liquid_n_talon_inicial)
	ds_talon = Message.PowerObjectParm
	if ds_talon.n_talon_inicial='-1' then return   //Opci$$HEX1$$f300$$ENDHEX$$n Cancelar de la ventana de tal$$HEX1$$f300$$ENDHEX$$n inicial
	n_talon_inicial = ds_talon.n_talon_inicial
	fecha_talon	= ds_talon.fecha_talon
	banco = ds_talon.banco
//end if

f_genera_talon(n_talon_inicial,fecha_talon, banco)
//Messagebox(g_titulo,'Proceso Finalizado.')

//i_reproceso = true
//this.enabled = FALSE

end event

event type long csd_emitir_transferencia();string lista_liquidaciones,nombre_ventana

nombre_ventana = classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)
IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_liquid) THEN RETURN -1
Openwithparm(w_premaat_datos_remesa, 'GARANTIAS')
i_datos_remesa = Message.PowerObjectParm	
IF f_genera_csb34(dw_liquid, i_datos_remesa,nombre_ventana,lista_liquidaciones) = -1 THEN RETURN -1
//f_imprimir_listado_transferencias (nombre_ventana, lista_liquidaciones) 
SetPointer(Arrow!)
RETURN 1
end event

public subroutine f_generar_liquidacion ();datetime f_nula
string dest, id_col, id_cli
setnull(f_nula)

dest = dw_1.getitemstring(1,'destinatario')
id_col = dw_1.getitemstring(1,'id_colegiado')
id_cli = dw_1.getitemstring(1,'id_cliente')

dw_liquid.InsertRow(0)

i_id_liq = f_siguiente_numero('LIQUIDACIONES',10)
dw_liquid.SetItem(1,'id_liquidacion',i_id_liq)
dw_liquid.SetItem(1,'f_liquidacion',dw_1.getitemdatetime(1,'f_liquidacion'))
dw_liquid.SetItem(1,'estado','P')
dw_liquid.SetItem(1,'contabilizada','N')
dw_liquid.SetItem(1,'forma_pago',dw_1.getitemstring(1,'forma_pago'))
dw_liquid.SetItem(1,'importe',dw_1.getitemnumber(1,'importe'))
dw_liquid.SetItem(1,'n_documento','')
choose case dest
	case 'CO'
		dw_liquid.SetItem(1,'id_colegiado',id_col)
		dw_liquid.SetItem(1,'nombre',f_colegiado_apellido(id_col))
		dw_liquid.SetItem(1,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('COL_REMESABLE',id_col) )
	case 'CL'
		dw_liquid.SetItem(1,'id_beneficiario',id_cli)
		dw_liquid.SetItem(1,'nombre',f_dame_cliente(id_cli))
		dw_liquid.SetItem(1,'banco',gnv_control_cuentas_bancarias.of_obtener_iban_nombre_modulo ('CLIENTES',id_cli) )
end choose
dw_liquid.SetItem(1,'cta_pago','')
dw_liquid.SetItem(1,'descripcion_larga','DEVOLUCION GARANTIA')
dw_liquid.SetItem(1,'tipo','2')
dw_liquid.SetItem(1,'id_fase',dw_1.getitemstring(1,'id_fase'))


end subroutine

public function integer f_genera_talon (string n_talon_inicial, datetime fecha, string banco);datastore ds_talon
long i
string n_talon, ctabanco, sql_nueva, lista_liquidaciones = '( '

ctabanco = f_dame_cuenta_contable_banco(banco)//i_datos_remesa.banco)

ds_talon						= create datastore
ds_talon.dataobject		= g_informe_talon_garantias
ds_talon.SetTransObject(SQLCA)

n_talon = n_talon_inicial

for i= 1 to dw_liquid.RowCount()
	// st_1.Text='Tramitando liquidaci$$HEX1$$f300$$ENDHEX$$n '+string(i)+' de '+string(dw_lista.RowCount())
	if dw_liquid.getitemstring(i,'estado')='P' and dw_liquid.getitemstring(i,'forma_pago')= g_formas_pago.talon then
		// if not i_reproceso then
			ds_talon.InsertRow(0)
			ds_talon.SetItem(ds_talon.RowCount(),'id_colegiado',dw_liquid.GetItemString(i,'id_colegiado'))
			ds_talon.SetItem(ds_talon.RowCount(),'f_liquidacion',fecha)
			ds_talon.SetItem(ds_talon.RowCount(),'importe',dw_liquid.GetItemNumber(i,'importe'))
			ds_talon.SetItem(ds_talon.RowCount(),'n_documento',n_talon)
			dw_liquid.SetItem(i,'n_documento',n_talon)
			dw_liquid.SetItem(i,'estado','L')
			dw_liquid.SetItem(i,'f_liquidacion',fecha)		
			dw_liquid.SetItem(i,'cta_pago',ctabanco)
			dw_liquid.Update()
			ds_talon.Retrieve(dw_liquid.GetItemString(i,'id_liquidacion'))
			n_talon = RightA('0000000000000000000000'+string(long(n_talon) + 1 ),8)
			ds_talon.Print()
			ds_talon.Reset()
		// end if
	end if
next

// Impresi$$HEX1$$f300$$ENDHEX$$n de Talones
//for i= 1 to dw_liquid.RowCount()
	// if dw_liquid.getitemstring(i,'estado')='L' and dw_liquid.getitemstring(i,'forma_pago')= g_formas_pago.talon and i_reproceso then
//		ds_talon.Retrieve(dw_liquid.GetItemString(i,'id_liquidacion'))
//		lista_liquidaciones += '~'' + dw_liquid.getitemstring(i, 'id_liquidacion') + + '~'' + ', ' 
//		ds_talon.Print()
//		ds_talon.Reset()	
	// end if
//next

//lista_liquidaciones = left(lista_liquidaciones, len(lista_liquidaciones)-2) + ' )'

//messagebox('IMPRESION DEL LISTADO DE TALONES GENERADOS', 'Coloque papel blanco en la impresora , va a salir el listado de talones generado')
//datastore ds_liquidacion_listado
//ds_liquidacion_listado = create datastore
//ds_liquidacion_listado.dataobject = 'd_premaat_liquid_listado'
//ds_liquidacion_listado.SetTransObject(SQLCA)
//sql_nueva = ds_liquidacion_listado.describe("datawindow.table.select") + ' and premaat_liquidaciones.id_liquidacion in ' + lista_liquidaciones
//ds_liquidacion_listado.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
//ds_liquidacion_listado.retrieve()
//ds_liquidacion_listado.groupcalc()
//ds_liquidacion_listado.print()
//destroy ds_liquidacion_listado

//i_reproceso = true

destroy ds_talon
return 1
end function

public subroutine f_contabiliza ();long i_asiento
long cuantos
string mensaje = ''
int continuar
int i
datetime fecha
double importe, saldo = 0, saldo_deudor = 0
string estado, concepto_base, concepto, formadepago, id_colegiado, cuenta_col, cliente, n_expedi
string ctabanco, contabilizada, n_documento,  cuenta_presupuestaria
string id_beneficiario
string nombre = ''

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

// Modificado Ricardo 2005-04-28
//if not g_contabilidad_automatica then return

// ------ Pre-contabilizaci$$HEX1$$f300$$ENDHEX$$n
if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.liq_otros_pagos) then mensaje = mensaje + cr + "g_sica_diario.liq_otros_pagos"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_sica_t_doc.talon) then mensaje = mensaje + cr + "g_sica_t_doc.talon"
if f_es_vacio(g_sica_t_doc.transferencia) then mensaje = mensaje + cr + "g_sica_t_doc.transferencia" 
if f_es_vacio(g_sica_t_doc.generico) then mensaje = mensaje + cr + "g_sica_t_doc.generico" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

//select count(*) into :cuantos from csi_formas_de_pago where cuenta = null or cuenta = '';
//if cuantos > 0 then Messagebox(g_titulo,"Hay Formas de Pago sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then return	
end if

// Modificado Ricardo 2005-04-28
// Si la fecha de liquidacion no est$$HEX2$$e1002000$$ENDHEX$$dentro del ejercicio actual no generamos apuntes
if string(year(date(dw_liquid.GetItemDateTime(1,'f_liquidacion'))))<>g_ejercicio then
	messageBox(g_titulo, "No es posible generar los apuntes correspondientes por que la fecha de liquidaci$$HEX1$$f300$$ENDHEX$$n indicada no pertenece al ejercicio abierto.")
	return
end if
// FIN Modificado Ricardo 2005-04-28

if f_es_vacio(g_conta.cuenta_clientes_general) then g_conta.cuenta_clientes_general = '4400000'
if f_es_vacio(g_prefijo_arqui) then g_prefijo_arqui = '430'

i_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.liq_otros_pagos,7))
i_asiento = i_asiento - 1
if isnull(i_asiento) then i_asiento = 0

//dw_lista.AcceptText()
for i = 1 to dw_liquid.RowCount()
	fecha = dw_liquid.GetItemDateTime(i,'f_liquidacion')
	importe = dw_liquid.GetItemNumber(i,'importe')
	//	estado = dw_lista.GetItemString(i,'estado')
	//	if estado <> 'L' then continue
	//	contabilizada = dw_lista.GetItemString(i,'contabilizada')
	//	if contabilizada = 'S' then continue	
	id_colegiado = dw_liquid.GetItemString(i,'id_colegiado')
	id_beneficiario = dw_liquid.GetItemString(i,'id_beneficiario')	
	n_documento = dw_liquid.GetItemString(i,'n_documento')
		
	concepto_base = ''
	concepto_base = 'DEVOLUCION GARANTIA: '
	formadepago = dw_liquid.GetItemString(i,'forma_pago')
	ctabanco = dw_liquid.GetItemString(i,'cta_pago')
	
	//  SELECT csi_formas_de_pago.cuenta  
	//    INTO :ctabanco  
	//    FROM csi_formas_de_pago  
	//   WHERE csi_formas_de_pago.tipo_pago = :formadepago   ;
	
	//Rellenamos DATOS GENERALES DE G_APUNTE
	i_asiento++
	g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento)),7)
	g_apunte.n_apunte = '00000'
	g_apunte.n_doc = n_documento
	g_apunte.id_interno = ''
	g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
	g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
	g_apunte.diario = g_sica_diario.liq_otros_pagos
	g_apunte.proyecto = g_explotacion_por_defecto
	g_apunte.centro = g_centro_por_defecto
	g_apunte.cta_presupuestaria = cuenta_presupuestaria	

	choose case formadepago
		case g_formas_pago.transferencia
			g_apunte.t_doc = g_sica_t_doc.transferencia
		case g_formas_pago.talon
			g_apunte.t_doc = g_sica_t_doc.talon
		case else
			g_apunte.t_doc = g_sica_t_doc.generico
	end choose
	
	if not f_es_vacio(id_beneficiario) then
		nombre = f_dame_cliente(id_beneficiario)
	else
		nombre =	 f_colegiado_apellido(id_colegiado)
	end if
	if f_es_vacio(nombre) then nombre = ''
	concepto_base = concepto_base + nombre
	// Abono a la Cuenta de garant$$HEX1$$ed00$$ENDHEX$$as
	concepto = LeftA(concepto_base,57)
	g_apunte.concepto = concepto
	g_apunte.cuenta = g_conta.garantia_cuenta
	g_apunte.debe = importe
	g_apunte.haber = 0
	g_apunte.contrapartida = ctabanco
	f_apunte_dw(g_apunte,dw_2,'E')	
	
	// Cargo a Banco
	g_apunte.concepto = concepto
	g_apunte.cuenta = ctabanco
	g_apunte.debe = 0
	g_apunte.contrapartida = g_conta.garantia_cuenta
	g_apunte.haber = importe
	f_apunte_dw(g_apunte,dw_2,'E')	
		
	//Marcamos la liquidacion como contabilizada:
	dw_liquid.SetItem(i,'contabilizada','S')
		
	dw_liquid.Update()
	dw_2.Update()
	f_actualiza_numero_bd_ejercicio(g_sica_diario.liq_otros_pagos, i_asiento)
	dw_2.reset()
next

end subroutine

on w_garantias_devolucion.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_liquid=create dw_liquid
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.dw_liquid
this.Control[iCurrent+5]=this.dw_2
end on

on w_garantias_devolucion.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_liquid)
destroy(this.dw_2)
end on

event open;double talon

f_centrar_ventana(this)

dw_1.InsertRow(0)

dw_1.setitem(1,'importe',g_garantias_consulta.importe)
dw_1.setitem(1,'id_colegiado',g_garantias_consulta.id_colegiado)
dw_1.setitem(1,'id_cliente',g_garantias_consulta.id_cliente)
dw_1.setitem(1,'id_fase',g_garantias_consulta.id_fase)
dw_1.setitem(1,'f_liquidacion',datetime(today()))
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_garantias_devolucion
integer x = 622
integer y = 1180
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_garantias_devolucion
integer x = 1106
integer y = 1180
end type

type dw_1 from u_dw within w_garantias_devolucion
integer x = 37
integer y = 32
integer width = 2167
integer height = 796
integer taborder = 20
string dataobject = "d_garantias_devolucion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

type cb_cancelar from commandbutton within w_garantias_devolucion
integer x = 1307
integer y = 896
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(parent,'-1')


end event

type cb_aceptar from commandbutton within w_garantias_devolucion
integer x = 475
integer y = 896
integer width = 507
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Liquidaci$$HEX1$$f300$$ENDHEX$$n"
boolean default = true
end type

event clicked;long resp= 1
dw_1.accepttext()

if f_es_vacio(dw_1.getitemstring(1,'forma_pago')) then
	messagebox(g_titulo, 'Debe seleccionar una forma de pago')
	return
end if

f_generar_liquidacion()

if dw_1.getitemstring(1, 'liquidar') = 'S' then 
	CHOOSE CASE  dw_1.getitemstring(1, 'forma_pago') 
		CASE g_formas_pago.talon 
			parent.event csd_emitir_talon()
		CASE g_formas_pago.transferencia 
			resp = parent.event csd_emitir_transferencia()
	END CHOOSE
	
	if resp = -1 THEN 
		dw_liquid.ResetUpdate()
		CloseWithReturn(parent,'-1')
	else
		if dw_1.getitemstring(1, 'contabilizar') = 'S' then f_contabiliza()
	end if

end if

IF resp<> -1 THEN 
	dw_liquid.Update()
	messagebox(g_titulo, 'Proceso finalizado.')
	CloseWithReturn(parent,dw_1.getitemstring(1,'destinatario'))
END IF



end event

type dw_liquid from u_dw within w_garantias_devolucion
boolean visible = false
integer x = 2190
integer y = 60
integer width = 635
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_premaat_liquid_lista"
end type

type dw_2 from u_dw within w_garantias_devolucion
boolean visible = false
integer x = 2002
integer y = 332
integer width = 357
integer height = 240
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;SetTransObject(bd_ejercicio)
end event

