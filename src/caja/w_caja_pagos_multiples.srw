HA$PBExportHeader$w_caja_pagos_multiples.srw
forward
global type w_caja_pagos_multiples from w_response
end type
type dw_minutas_detalle from u_dw within w_caja_pagos_multiples
end type
type cb_aceptar from commandbutton within w_caja_pagos_multiples
end type
type cb_cancelar from commandbutton within w_caja_pagos_multiples
end type
type gb_relacion from groupbox within w_caja_pagos_multiples
end type
type dw_originales_copias_obj_impr from u_dw within w_caja_pagos_multiples
end type
type dw_nombre_pagador from u_dw within w_caja_pagos_multiples
end type
type gb_cobros_multiples from groupbox within w_caja_pagos_multiples
end type
type gb_pagador from groupbox within w_caja_pagos_multiples
end type
type dw_relaciones_generadas from u_dw within w_caja_pagos_multiples
end type
type cb_preparar from commandbutton within w_caja_pagos_multiples
end type
type dw_1 from u_dw within w_caja_pagos_multiples
end type
type gb_cabecera from groupbox within w_caja_pagos_multiples
end type
type dw_cobros from u_dw within w_caja_pagos_multiples
end type
type dw_cobros_facturas from u_dw within w_caja_pagos_multiples
end type
type dw_valores_genericos from u_dw within w_caja_pagos_multiples
end type
type dw_visualizar_avisos from u_dw within w_caja_pagos_multiples
end type
type dw_cobros_multiples from u_dw within w_caja_pagos_multiples
end type
type dw_caja_pago from u_dw within w_caja_pagos_multiples
end type
type gb_pago_unico from groupbox within w_caja_pagos_multiples
end type
end forward

global type w_caja_pagos_multiples from w_response
integer x = 214
integer y = 221
integer width = 3429
integer height = 1680
event csd_comprobar_todo_cobrado ( string modulo )
event csd_configurar_ventana ( )
event type integer csd_cambio_iva ( datetime fecha )
dw_minutas_detalle dw_minutas_detalle
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
gb_relacion gb_relacion
dw_originales_copias_obj_impr dw_originales_copias_obj_impr
dw_nombre_pagador dw_nombre_pagador
gb_cobros_multiples gb_cobros_multiples
gb_pagador gb_pagador
dw_relaciones_generadas dw_relaciones_generadas
cb_preparar cb_preparar
dw_1 dw_1
gb_cabecera gb_cabecera
dw_cobros dw_cobros
dw_cobros_facturas dw_cobros_facturas
dw_valores_genericos dw_valores_genericos
dw_visualizar_avisos dw_visualizar_avisos
dw_cobros_multiples dw_cobros_multiples
dw_caja_pago dw_caja_pago
gb_pago_unico gb_pago_unico
end type
global w_caja_pagos_multiples w_caja_pagos_multiples

type variables
st_caja_cobros i_parametros
long il_max_cobros = 10
n_csd_impresion_formato i_impresion_formato

end variables

forward prototypes
public subroutine wf_cerrar_ventana_detalle_fases ()
public subroutine wf_abrir_ventana_detalle_fases (string id_fase)
public subroutine wf_generar_facturas_y_liquidaciones (string tipo_gestion, u_dw dw)
public function long wf_consultar_cobros_avisos ()
public function integer wf_generar_proformas (datetime fecha_pago, string forma_pago, string banco, string lista, string cobros_a_cero, string pagado)
end prototypes

event csd_comprobar_todo_cobrado(string modulo);
// El contrato pasa a abonado y retirado cuando est$$HEX2$$e1002000$$ENDHEX$$toda la CIP pagada
string id_fase = ''

// Ponemos el puntero a reloj
setpointer(hourglass!)
// Cogemos el idenfitificador de la fase
id_fase = dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'id_fase')

// LLamamos a la funcion que realiza el cambio de estado y dem$$HEX1$$e100$$ENDHEX$$s
if f_fases_cambia_estado_fase_segun_pagado(id_fase, modulo)='-1' then
	Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
	return
end if
end event

event csd_configurar_ventana();// Hacemos la configuraci$$HEX1$$f300$$ENDHEX$$n de la ventana seg$$HEX1$$fa00$$ENDHEX$$n el tipo de cobro elegido

dw_1.trigger event pfc_accepttext(true)

// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS', 'COBROS_FACTURAS'
		dw_1.visible = false
	CASE 'FACTURA_NUEVA'
		// No hay pagos multiples
		dw_1.setitem(1, 'tipo_cobros', 'U')
		dw_1.visible = false
END CHOOSE

if g_usa_cobros_multiples = 'S' then
	// SCP-651
	// No hago nada
	// Lo hago as$$HEX2$$ed002000$$ENDHEX$$para que en el caso de que sea otra cosa distinta de M (cobro multiple), bien sea U (cobro $$HEX1$$fa00$$ENDHEX$$nico) o est$$HEX2$$e9002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o,
	// fuerze por defecto la U (cobro $$HEX1$$fa00$$ENDHEX$$nico)
else
	dw_1.setitem(1, 'tipo_cobros', 'U')
end if
// Miramos en que caso estamos
CHOOSE CASE dw_1.getitemString(1, 'tipo_cobros')
	CASE 'U' // unico
		gb_pago_unico.visible = true
		dw_caja_pago.visible = true
		
		// Ocultamos el otro modo
		gb_cobros_multiples.visible = false
		gb_relacion.visible = false
		dw_valores_genericos.visible = false
		dw_cobros_multiples.visible = false
		cb_preparar.enabled = false
		cb_preparar.visible = false
		dw_relaciones_generadas.visible = false
		gb_cabecera.visible = false
		gb_pagador.visible = false
		dw_nombre_pagador.visible = false
		dw_originales_copias_obj_impr.visible  = true
		dw_originales_copias_obj_impr.X  = 46//942
		dw_originales_copias_obj_impr.Y  = 940//1304	
		cb_aceptar.X  = 300
		cb_aceptar.Y  = 1400
		cb_cancelar.Y = 1400
		cb_cancelar.X = 1000
		w_caja_pagos_multiples.width =1800
		dw_cobros_multiples.reset()
		f_centrar_ventana(this)
	CASE 'M' // multiple
		gb_cabecera.visible = true
		gb_cobros_multiples.visible = true
		gb_relacion.visible = false
		dw_valores_genericos.visible = true
		dw_cobros_multiples.visible = true
		cb_preparar.enabled = false
		cb_preparar.visible = false
		dw_relaciones_generadas.visible = false
		gb_pagador.visible = true
		dw_nombre_pagador.visible = true
		
		// Ocultamos el otro modo
		gb_pago_unico.visible = false
		dw_caja_pago.visible = false
		dw_originales_copias_obj_impr.visible  = true
		//dw_originales_copias_obj_impr.X  = 1765
		//dw_originales_copias_obj_impr.Y  = 1316
		
		dw_cobros_multiples.trigger event pfc_addrow()
END CHOOSE 

end event

event type integer csd_cambio_iva(datetime fecha);long i, tipos_iva =1, msg = 0, retorno, msg_acum
string id_minuta, t_iva, aplica, nums_aviso = ' ', n_aviso

FOR i = 1 TO dw_relaciones_generadas.RowCount()
	id_minuta = dw_relaciones_generadas.GetItemString(i, 'id_minuta')
	dw_minutas_detalle.retrieve(id_minuta)
	n_aviso = dw_minutas_detalle.GetItemString(1, 'n_aviso')
	tipos_iva = 1
	msg = 0
	
	DO
	CHOOSE CASE tipos_iva
		CASE 1
			t_iva	= dw_minutas_detalle.GetItemString(1, 't_iva_honos')
			aplica	= dw_minutas_detalle.GetItemString(1, 'aplica_honos')
			if(not(f_es_vacio(t_iva)) and aplica = 'S') then
				if gnv_ivajulio2010.of_valida_iva_fecha( fecha, t_iva) < 0 then
					msg =  msg +1
				end if
			end if
		CASE 2
			t_iva	= dw_minutas_detalle.GetItemString(1, 't_iva_desplaza')
			aplica	= dw_minutas_detalle.GetItemString(1, 'aplica_desplaza')
			if(not(f_es_vacio(t_iva)) and aplica = 'S') then
				if gnv_ivajulio2010.of_valida_iva_fecha( fecha, t_iva) < 0 then
					msg =  msg +1
				end if
			end if
		CASE 3
			t_iva	= dw_minutas_detalle.GetItemString(1, 't_iva_dv')
			aplica	= dw_minutas_detalle.GetItemString(1, 'aplica_dv')
			if(not(f_es_vacio(t_iva)) and aplica = 'S') then
				if gnv_ivajulio2010.of_valida_iva_fecha( fecha, t_iva) < 0 then
					msg =  msg +1
				end if
			end if
		CASE 4
			t_iva	= dw_minutas_detalle.GetItemString(1, 't_iva_cip')
			aplica	= dw_minutas_detalle.GetItemString(1, 'aplica_cip')
			if(not(f_es_vacio(t_iva)) and aplica = 'S') then
				if gnv_ivajulio2010.of_valida_iva_fecha( fecha, t_iva) < 0 then
					msg =  msg +1
				end if
			end if
		CASE 5
			t_iva	= dw_minutas_detalle.GetItemString(1, 't_iva_impresos')
			aplica	= dw_minutas_detalle.GetItemString(1, 'aplica_impresos')
			if(not(f_es_vacio(t_iva)) and aplica = 'S') then
				if gnv_ivajulio2010.of_valida_iva_fecha( fecha, t_iva) < 0 then
					msg =  msg +1
				end if
			end if
	END CHOOSE
	tipos_iva++
	if(msg > 0 and tipos_iva = 6)then
			nums_aviso = nums_aviso + n_aviso + ', '
			msg_acum = msg_acum + msg
	end if
	LOOP UNTIL tipos_iva > 5
	
next
	
	if(msg_acum > 0)then
		retorno=messagebox(g_titulo,'El tipo de IVA de algunos conceptos de los avisos ' +nums_aviso+ 'no es v$$HEX1$$e100$$ENDHEX$$lido para esta fecha de pago. Desea continuar?',Exclamation!, YesNo!,1)
		if(retorno=2) then 
			return -1
		end if
	end if


	
return 1
end event

public subroutine wf_cerrar_ventana_detalle_fases ();// Cerramos la ventana de fases
if isvalid(g_detalle_fases) then close(g_detalle_fases)

end subroutine

public subroutine wf_abrir_ventana_detalle_fases (string id_fase);//Abrimos la ventana de fases con la fase concreta solicitada, porque vamos a llamar a eventos de la fase
g_fases_consulta.id_fase = id_fase
message.stringparm = "w_fases_detalle"
w_aplic_frame.postevent("csd_fasesdetalle")
//string ls_sheetname = "w_fases_detalle"
//opensheet(g_detalle_fases, ls_sheetname, this, 0, original!)
// Hasta que no se abra esperamos
DO WHILE not isvalid(g_detalle_fases)
	yield()
LOOP
end subroutine

public subroutine wf_generar_facturas_y_liquidaciones (string tipo_gestion, u_dw dw);// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro separamos los originales y copias en las facturas de honos y gastos, porque se deben imprimir varias paginas
string copias, origin
st_liquidacion datos_liquidacion


if tipo_gestion = 'C' then
	copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
	origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
else
	copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
	origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
end if
			
// Modificado Ricardo 2005-05-10
st_generar_facturas_minutas parametros_factura_minuta

// Modificado David 27/02/2006 - Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n a la funci$$HEX1$$f300$$ENDHEX$$n
parametros_factura_minuta.impresion_formato 	= i_impresion_formato
if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then
	parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
end if

parametros_factura_minuta.dw_minuta 				= dw_minutas_detalle
parametros_factura_minuta.num_orig 				= Integer(origin)
parametros_factura_minuta.num_copias 			= Integer(copias)
parametros_factura_minuta.regulariza_musaat		= false
parametros_factura_minuta.movimiento_musaat	= true
parametros_factura_minuta.tipo_movimiento_csd	= dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
parametros_factura_minuta.tipo_prev				= ''
parametros_factura_minuta.dw_factura				= dw

// Se agreg$$HEX2$$f3002000$$ENDHEX$$campo a la estructura para poder pasar el dw de cobros multiples
// Yexaira 06/05/08
parametros_factura_minuta.dw_cobros_multiples	= dw_cobros_multiples

// Para determinar la serie usamos el siguiente criterio:
// -> Minutas SGC : Mirar el total colegiado. ES valido el 100% de las veces
// -> Minutas CGC : Mirar el total colegiado. No es valido siempre, pero elegiremos este criterio por ser el mejor para el colegio (pueden salir mal las de colegiado)
// Modificado Paco 03/11/2005: Se amplia el criterio mirando tambi$$HEX1$$e900$$ENDHEX$$n el total_cliente cuando el total_colegiado = 0
if (dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0) or &
(dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')=0 and dw_minutas_detalle.GetItemNumber(1, 'total_cliente')<0) then
	parametros_factura_minuta.serie				= g_facturas_negativas_serie
else
	parametros_factura_minuta.serie				= g_serie_fases
end if

// Modificado David 21/12/2005: Caso concreto de aviso CGC en que los honorarios son positivos y los gastos negativos
if dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0 and &
	dw_minutas_detalle.GetItemNumber(1, 'total_cliente')>0 then
	parametros_factura_minuta.serie				= g_serie_fases
end if				

// Modificado David 09/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
if g_colegio = 'COAATTFE' then parametros_factura_minuta.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')

f_generar_facturas_minuta(parametros_factura_minuta)
				
dw_minutas_detalle.SetItem(1,'pendiente','N')
dw_minutas_detalle.update()

//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
if tipo_gestion = 'C' then
	// VAciamos la estructura primero ya que sino no funciona correctamente :(
	setnull(datos_liquidacion.importe)
	// VAciamos el asunto
	setnull(datos_liquidacion.concepto)
	
	// Ahora ponemos lo que nos interesa
	datos_liquidacion.id_fase		= dw_minutas_detalle.getitemstring(1, 'id_minuta')
	datos_liquidacion.id_col		= dw_minutas_detalle.getitemstring(1, 'id_colegiado')
	//datos_liquidacion.f_entrada	= dw.GetItemDateTime(1,'fecha_pago')
	
	if g_colegio='COAATCC' or g_colegio='COAATMCA' then
   	   	datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
   	elseif g_usa_cobros_multiples = 'S' then // SCP-2273
		datos_liquidacion.f_entrada = dw_valores_genericos.GetItemDateTime(1,'fecha_pago')
	else
	    	datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_pago')                  
	end if       
   //datos_liquidacion.f_entrada   = dw.GetItemDateTime(1,'fecha_pago')

	datos_liquidacion.tipo			= '0'	

	
	f_liquidacion(datos_liquidacion)


end if
end subroutine

public function long wf_consultar_cobros_avisos ();// Funci$$HEX1$$f300$$ENDHEX$$n que encarga de obtener los id_minuta, concatenarlos en forma de tabla para obtener los cobros y poder generar
// los identificadores. Sabemos seguro que habr$$HEX1$$e100$$ENDHEX$$n relaciones
string sequencia_ids = '', sql, sql_orig
long fila, retorno


FOR fila = 1 TO dw_relaciones_generadas.RowCount()
	sequencia_ids += "'"+dw_relaciones_generadas.GetItemString(fila, 'id_minuta')+"',"
NEXT

// Quitamos la ultima coma
sequencia_ids = LeftA(sequencia_ids, LenA(sequencia_ids)-1)
// Componemos la nueva sql del dw
sql_orig = dw_cobros.describe("datawindow.table.select") // SAbemos que lleva un where seguro
sql = sql_orig
sql += " AND csi_facturas_emitidas.id_fase in ("+ sequencia_ids+")"
// sql += " AND csi_facturas_emitidas.tipo_factura = '"+ g_colegiado_cliente +"'" // Solucion valida para CGC pero no para SGC

// Modificamos la SQL
dw_cobros.modify("datawindow.table.select= ~"" + sql + "~"")
retorno = dw_cobros.retrieve()
// Restauramos la sql
dw_cobros.modify("datawindow.table.select= ~"" + sql_orig + "~"")

return retorno
end function

public function integer wf_generar_proformas (datetime fecha_pago, string forma_pago, string banco, string lista, string cobros_a_cero, string pagado);//Funcion que, dada una lista de id's de facturas, convierte las proformas a facturas
st_datos_facturas_proforma st_datos_proforma
n_csd_facturacion_proformas uo_proformas
int retorno
retorno = 1

uo_proformas = create n_csd_facturacion_proformas

st_datos_proforma.lista_id_factura = lista
st_datos_proforma.forma_pago = forma_pago
st_datos_proforma.banco = banco
st_datos_proforma.pagado = pagado
st_datos_proforma.cobros_a_cero = cobros_a_cero
st_datos_proforma.fecha_pago = fecha_pago
if g_colegio='COAATCC' or g_colegio='COAATMCA' then
	st_datos_proforma.fecha_facturacion = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
elseif g_usa_cobros_multiples = 'S' then // SCP-2273
	st_datos_proforma.fecha_facturacion = dw_valores_genericos.GetItemDateTime(1,'fecha_pago')
else
	st_datos_proforma.fecha_facturacion = dw_caja_pago.GetItemDateTime(1,'fecha_pago')
end if

uo_proformas.of_init(st_datos_proforma)
retorno = uo_proformas.wf_factura()

return retorno
end function

on w_caja_pagos_multiples.create
int iCurrent
call super::create
this.dw_minutas_detalle=create dw_minutas_detalle
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.gb_relacion=create gb_relacion
this.dw_originales_copias_obj_impr=create dw_originales_copias_obj_impr
this.dw_nombre_pagador=create dw_nombre_pagador
this.gb_cobros_multiples=create gb_cobros_multiples
this.gb_pagador=create gb_pagador
this.dw_relaciones_generadas=create dw_relaciones_generadas
this.cb_preparar=create cb_preparar
this.dw_1=create dw_1
this.gb_cabecera=create gb_cabecera
this.dw_cobros=create dw_cobros
this.dw_cobros_facturas=create dw_cobros_facturas
this.dw_valores_genericos=create dw_valores_genericos
this.dw_visualizar_avisos=create dw_visualizar_avisos
this.dw_cobros_multiples=create dw_cobros_multiples
this.dw_caja_pago=create dw_caja_pago
this.gb_pago_unico=create gb_pago_unico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_minutas_detalle
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.gb_relacion
this.Control[iCurrent+5]=this.dw_originales_copias_obj_impr
this.Control[iCurrent+6]=this.dw_nombre_pagador
this.Control[iCurrent+7]=this.gb_cobros_multiples
this.Control[iCurrent+8]=this.gb_pagador
this.Control[iCurrent+9]=this.dw_relaciones_generadas
this.Control[iCurrent+10]=this.cb_preparar
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.gb_cabecera
this.Control[iCurrent+13]=this.dw_cobros
this.Control[iCurrent+14]=this.dw_cobros_facturas
this.Control[iCurrent+15]=this.dw_valores_genericos
this.Control[iCurrent+16]=this.dw_visualizar_avisos
this.Control[iCurrent+17]=this.dw_cobros_multiples
this.Control[iCurrent+18]=this.dw_caja_pago
this.Control[iCurrent+19]=this.gb_pago_unico
end on

on w_caja_pagos_multiples.destroy
call super::destroy
destroy(this.dw_minutas_detalle)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.gb_relacion)
destroy(this.dw_originales_copias_obj_impr)
destroy(this.dw_nombre_pagador)
destroy(this.gb_cobros_multiples)
destroy(this.gb_pagador)
destroy(this.dw_relaciones_generadas)
destroy(this.cb_preparar)
destroy(this.dw_1)
destroy(this.gb_cabecera)
destroy(this.dw_cobros)
destroy(this.dw_cobros_facturas)
destroy(this.dw_valores_genericos)
destroy(this.dw_visualizar_avisos)
destroy(this.dw_cobros_multiples)
destroy(this.dw_caja_pago)
destroy(this.gb_pago_unico)
end on

event open;call super::open;long fila
double cantidad_pagar
string tipo_gestion, tipo_carta_imprimir, id_col



// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
if isvalid(message.PowerObjectParm) Then
	i_parametros = message.PowerObjectParm	
	dw_caja_pago.SetItem(1, 'forma_pago',i_parametros.formapago_cobro)
	dw_caja_pago.event itemchanged(1, dw_caja_pago.object.forma_pago,i_parametros.formapago_cobro)
	//dw_caja_pago.SetItem(1, 'banco',i_parametros.banco)
end if

f_centrar_ventana(this)

//
datawindowchild   dwc_banco
string empresa
empresa=i_parametros.empresa
dw_cobros_multiples.getchild ('banco', dwc_banco)
dwc_banco.settransobject (SQLCA)
dwc_banco.setfilter(" csi_bancos.empresa like '"+empresa+"'")
dwc_banco.filter()

datawindowchild   dwc_banco2


dw_caja_pago.getchild ('banco', dwc_banco2)
dwc_banco2.settransobject (SQLCA)
dwc_banco2.setfilter(" csi_bancos.empresa like '"+empresa+"'")
dwc_banco2.filter()


// Colocamos la fecha y los datos por defecto
dw_caja_pago.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_caja_pago.SetItem(1,'fecha_factura',DateTime(Today(),Now()))
dw_valores_genericos.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
if not f_es_vacio(i_parametros.pagador)  then  dw_nombre_pagador.setitem(1,'nombre_pagador', i_parametros.pagador)
if f_es_vacio(dw_caja_pago.getitemstring(1, 'forma_pago')) then dw_caja_pago.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
if f_es_vacio(dw_caja_pago.getitemstring(1, 'banco')) then dw_caja_pago.SetItem(1,'banco',g_banco_por_defecto)

dw_originales_copias_obj_impr.insertrow(0)
i_impresion_formato = create n_csd_impresion_formato

tipo_gestion = '-1' // pongo un valor aleatorio

// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		// Recorremos el datawindow para ver al cantidad a pagar
		cantidad_pagar = 0
		FOR fila =1 to i_parametros.dw.RowCount()
			if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then

				cantidad_pagar += i_parametros.dw.getitemnumber(fila, 'total')
				// Si hay alguno que es de tipo 'C' lo ponemos
				if i_parametros.dw.GetItemString(fila, 'tipo_gestion') = 'C' then tipo_gestion = 'C'
			end if
		NEXT
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',cantidad_pagar)
		dw_valores_genericos.SetItem(1,'total_pagar',cantidad_pagar)
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				dw_caja_pago.modify("tipo_carta_imprimir.visible = '1'")
				dw_caja_pago.modify("tipo_carta_imprimir_t.visible = '1'")
				dw_caja_pago.modify("copias.visible = '1'")
				dw_caja_pago.modify("copias_t.visible = '1'")
				tipo_carta_imprimir = "0#NINGUNA"
				FOR fila = 1 TO i_parametros.dw.rowcount()
					if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
						tipo_carta_imprimir = f_caja_tipo_carta_imprimir(i_parametros.dw.getitemstring(fila, 'tipo_registro'), i_parametros.dw.getitemstring(fila, 'fase'), tipo_carta_imprimir, true)
					end if
				NEXT
				dw_caja_pago.setitem(1, "tipo_carta_imprimir", MidA(tipo_carta_imprimir, PosA(tipo_carta_imprimir,"#")+1, LenA(tipo_carta_imprimir) - PosA(tipo_carta_imprimir,"#")))
		END CHOOSE
		
	CASE 'MINUTAS'
		// Cambiamos la referencia al dw apuntado
		dw_minutas_detalle = i_parametros.dw
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.dw.GetItemNumber(1, 'total'))
		dw_caja_pago.SetItem(1,'entregado',i_parametros.dw.GetItemNumber(1, 'total'))	
		dw_valores_genericos.SetItem(1,'total_pagar',i_parametros.dw.GetItemNumber(1, 'total'))
		id_col = f_minutas_id_col(i_parametros.dw.GetItemString(1,'id_minuta'))
		this.title = 'Datos del Pago  ' +f_colegiado_apellido(id_col)
		tipo_gestion = i_parametros.dw.getitemstring(1, 'tipo_gestion')
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				dw_caja_pago.modify("tipo_carta_imprimir.visible = '1'")
				dw_caja_pago.modify("tipo_carta_imprimir_t.visible = '1'")
				dw_caja_pago.modify("copias.visible = '1'")
				dw_caja_pago.modify("copias_t.visible = '1'")
				tipo_carta_imprimir = "0#NINGUNA"
				// FALTA AVERIGUAR EL TIPO DE CARTA PARA TENERIFE
//				tipo_carta_imprimir = f_caja_tipo_carta_imprimir(i_parametros.dw.getitemstring(1, 'tipo_registro'), i_parametros.dw.getitemstring(fila, 'fase'), tipo_carta_imprimir, true)
				dw_caja_pago.setitem(1, "tipo_carta_imprimir", MidA(tipo_carta_imprimir, PosA(tipo_carta_imprimir,"#")+1, LenA(tipo_carta_imprimir) - PosA(tipo_carta_imprimir,"#")))
			CASE 'COAATA'
				if tipo_gestion = 'A' then
					dw_caja_pago.modify("forma_pago.tabsequence = '0'")
					dw_caja_pago.modify("banco.tabsequence = '0'")
				end if
		END CHOOSE		

	CASE 'FASES'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',dw_minutas_detalle.GetItemNumber(1, 'total'))
		dw_caja_pago.SetItem(1,'entregado',dw_minutas_detalle.GetItemNumber(1, 'total'))
		dw_valores_genericos.SetItem(1,'total_pagar',dw_minutas_detalle.GetItemNumber(1, 'total'))
		id_col = f_minutas_id_col(dw_minutas_detalle.GetItemString(1,'id_minuta'))
		this.title = 'Datos del Pago  ' +f_colegiado_apellido(id_col)
		tipo_gestion = dw_minutas_detalle.getitemstring(1, 'tipo_gestion')	
		
	CASE 'FACTURA_NUEVA'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',i_parametros.cantidad_pagar)		
		dw_caja_pago.SetItem(1,'fecha_pago',i_parametros.fecha_pago)
		// Quitamos la posibilidad de colocar la fecha en el pago
		dw_caja_pago.object.fecha_pago.TabSequence = 0
		dw_caja_pago.object.fecha_pago.Background.Color = f_color_gris_claro()
		
	CASE 'COBROS_FACTURAS'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',i_parametros.cantidad_pagar)
		dw_valores_genericos.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
	
END CHOOSE


// Obtenemos el correo del colegiado
string ls_postal, ls_email, ls_n_col
dw_originales_copias_obj_impr.setitem(1, 'direccion_email', f_devuelve_mail(id_col))
// Obtenemos si el colegiado quiere recibir los documentos impresos y por email
select recibir_c_postales,recibir_c_email into :ls_postal,:ls_email from colegiados where id_colegiado=:id_col;
if f_es_vacio(ls_postal) then ls_postal = 'N'
if f_es_vacio(ls_email) then ls_email = 'N'
dw_originales_copias_obj_impr.setitem(1, 'papel', ls_postal)
dw_originales_copias_obj_impr.setitem(1, 'email', ls_email)
// Si un colegiado no tiene marcado ning$$HEX1$$fa00$$ENDHEX$$n tipo de informe, marcar papel
if ls_postal='N' and ls_email='N' then dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')
// En Bizkaia piden que nunca est$$HEX2$$e9002000$$ENDHEX$$marcado email que lo tengan que marcar manualmente
if g_colegio = 'COAATB' then dw_originales_copias_obj_impr.setitem(1, 'email', 'N')


if tipo_gestion <> 'C' then
	// Solo dejamos la segunda
	dw_originales_copias_obj_impr.object.n_orig_hon_t.visible = false
	dw_originales_copias_obj_impr.object.n_orig_hon.visible = false
	dw_originales_copias_obj_impr.object.b_mas_oh.visible = false
	dw_originales_copias_obj_impr.object.b_men_oh.visible = false
	dw_originales_copias_obj_impr.object.n_cop_hon_t.visible = false
	dw_originales_copias_obj_impr.object.n_cop_hon.visible = false
	dw_originales_copias_obj_impr.object.b_mas_ch.visible = false
	dw_originales_copias_obj_impr.object.b_men_ch.visible = false
//	dw_originales_copias_obj_impr.visible = true
end if

if (g_colegio = 'COAATA' or g_colegio = 'COAATTFE') and tipo_gestion = 'A' then
	dw_originales_copias_obj_impr.object.n_orig_hon_t.visible = true
	dw_originales_copias_obj_impr.object.n_orig_hon.visible = true
	dw_originales_copias_obj_impr.object.b_mas_oh.visible = true
	dw_originales_copias_obj_impr.object.b_men_oh.visible = true
	dw_originales_copias_obj_impr.object.n_cop_hon_t.visible = true
	dw_originales_copias_obj_impr.object.n_cop_hon.visible = true
	dw_originales_copias_obj_impr.object.b_mas_ch.visible = true
	dw_originales_copias_obj_impr.object.b_men_ch.visible = true
end if
// Configuramos n$$HEX1$$fa00$$ENDHEX$$mero de originales y copias seg$$HEX1$$fa00$$ENDHEX$$n el tipo
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// Colocamos 2 copias de cada uno de los tipos de facturas
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				// Colocamos el foco en el campo de entregado
				dw_caja_pago.setcolumn("entregado")
			CASE 'COAATZ'
				tipo_gestion = i_parametros.dw.getitemstring(1, 'tipo_gestion')
				if tipo_gestion = 'C' then	dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				if tipo_gestion = 'S' then dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				if tipo_gestion = 'A' then dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATGU'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATLE'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','01')
			CASE 'COAATA'
				if tipo_gestion = 'C' or tipo_gestion = 'A' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				else
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','01')
				END IF
			CASE 'COAATGC'
				dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.metalico)
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
			CASE 'COAATNA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
			CASE 'COAATTGN', 'COAATTER', 'COAATLL'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','01')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')	
			CASE 'COAATTEB', 'COAATMCA', 'COAATCC'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')		
		END CHOOSE
	CASE 'FACTURA_NUEVA'
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
		dw_originales_copias_obj_impr.modify("n_orig_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Originales'")
		dw_originales_copias_obj_impr.modify("n_cop_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Copias'")
		dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')
		
		dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		CHOOSE CASE g_colegio
			CASE 'COAATMCA'
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
			case else
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','01')
		end choose
		
	CASE 'COBROS_FACTURAS'
		//MODIFICADO RICARDO 04-06-14
		// Incidencia 3272 : Pongo el n$$HEX2$$ba002000$$ENDHEX$$de orig. a 1 y cop. a 2, de gastos.
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
		
		
		dw_originales_copias_obj_impr.modify("n_orig_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Originales'")
		dw_originales_copias_obj_impr.modify("n_cop_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Copias'")
		//FIN MODIFICADO RICARDO 04-06-14
		dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')
		dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		CHOOSE CASE g_colegio
			CASE 'COAATMCA'
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				case else
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
		end choose
	CASE 'MINUTAS'
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// Colocamos 2 copias de cada uno de los tipos de facturas
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				// Colocamos el foco en el campo de entregado
				dw_caja_pago.setcolumn("entregado")
			CASE 'COAATZ'
				if tipo_gestion = 'C' then	dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				if tipo_gestion = 'S' then dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				if tipo_gestion = 'A' then dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATGU', 'COAATTER'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATLE'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','01')
			CASE 'COAATGUI'
				if tipo_gestion = 'S' then
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.domiciliacion)
				else
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.transferencia)
				end if
				dw_caja_pago.setitem(1, 'banco', '03')
			CASE 'COAATA'
				if tipo_gestion <> 'S' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				END IF
			CASE 'COAATGC'
				dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.metalico)				
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
			CASE 'COAATNA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				if tipo_gestion = 'S' then
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.domiciliacion)
					dw_caja_pago.setitem(1, 'banco', '3008')
				else
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.transferencia)
					dw_caja_pago.setitem(1, 'banco', '3008')
				end if
			CASE 'COAATTGN', 'COAATLL', 'COAATTEB', 'COAATCC', 'COAATMCA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')					
		END CHOOSE
end choose

if i_parametros.formapago_cobro = 'PP' or i_parametros.formapago_cobro = 'DB' or i_parametros.formapago_cobro = 'PE' then dw_1.setitem(1, 'tipo_cobros', 'U')


this.trigger event csd_configurar_ventana()

//majid
//string empresa
//empresa=i_parametros.empresa
//messagebox('',empresa)
end event

event pfc_postopen;call super::pfc_postopen;// Colocamos los calendarios
//->Dw_generico
dw_valores_genericos.of_SetDropDownCalendar(True)
dw_valores_genericos.iuo_calendar.of_register(dw_valores_genericos.iuo_calendar.DDLB)
dw_valores_genericos.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_valores_genericos.iuo_calendar.of_SetInitialValue(True)
//->Dw_cobros_multiples
dw_cobros_multiples.of_SetDropDownCalendar(True)
dw_cobros_multiples.iuo_calendar.of_register(dw_cobros_multiples.iuo_calendar.DDLB)
dw_cobros_multiples.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_cobros_multiples.iuo_calendar.of_SetInitialValue(True)
//->Dw_cobro_unico
dw_caja_pago.of_SetDropDownCalendar(True)
dw_caja_pago.iuo_calendar.of_register(dw_caja_pago.iuo_calendar.DDLB)
dw_caja_pago.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_caja_pago.iuo_calendar.of_SetInitialValue(True)

// Modificado David 11/02/2005
// Si el expediente es de visared, ponemos las copias a 0
string fase_visared, id_fase, visared
long fila
//if isvalid( i_parametros.dw.GetItemString(fila, 'procesar')) then
	FOR fila =1 to i_parametros.dw.RowCount()
		if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
			// Si hay alguno que es de tipo 'V' lo ponemos
			//Comprobamos primero si existe dicho campo (puesto que con el cambio de SCP-651 y el RD 1000/2010, por aqui pasaran dw que pueden no contener ese campo)
			if lower(i_parametros.dw.describe("id_fase.name")) = 'id_fase' then
				id_fase = i_parametros.dw.getitemstring(fila, 'id_fase')
				SELECT fases.e_mail INTO :fase_visared FROM fases WHERE fases.id_fase = :id_fase   ;
				if fase_visared = 'V' then visared = 'V'
			end if
		end if
	NEXT
	
	if visared = 'V' then
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
		dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
		// Ahora marcamos pdf y desmarcamos papel
		dw_originales_copias_obj_impr.setitem(1,'pdf','S')
		dw_originales_copias_obj_impr.setitem(1,'papel','N')
	else
		// El else vac$$HEX1$$ed00$$ENDHEX$$o lo pongo porque sino entra en el if cuando no toca
	end if
//end if
string id_col
// Se valida que si es tarragona se verifique que el colegiado tenga activo el campo de rebut bancario
if g_colegio = 'COAATTGN' or g_colegio='COAATLL' then
	if lower(i_parametros.dw.describe("id_minuta.name")) = 'id_minuta' then
		id_col = f_minutas_id_col(i_parametros.dw.GetItemString(1,'id_minuta'))
		if g_forma_pago_por_defecto ='DB'  and not isnull(id_col) then
			
			if f_dame_otros_conceptos_colegiado(id_col, '04') = 'N' then
				Messagebox(g_titulo, 'No puede realizarse cobros por rebut bancari.')
				//dw_caja_pago.Setitem(1,'forma_pago','TR')
			end if
		end if
	end if
end if




end event

event close;call super::close;// Cambiamos DW a no modificados para que no pida grabar cambios
int fila
for fila=1 to dw_cobros_multiples.RowCount()
	dw_cobros_multiples.SetItemStatus( fila, 0 , Primary!, NotModified!)
next
for fila=1 to dw_cobros_multiples.RowCount()
	dw_cobros_facturas.SetItemStatus( fila, 0 , Primary!, NotModified!)
next
for fila=1 to dw_cobros_multiples.RowCount()
	dw_cobros.SetItemStatus( fila, 0 , Primary!, NotModified!)
next
dw_caja_pago.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_1.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_relaciones_generadas.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_valores_genericos.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_nombre_pagador.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_originales_copias_obj_impr.SetItemStatus( 1, 0 , Primary!, NotModified!)
dw_minutas_detalle.SetItemStatus( 1, 0 , Primary!, NotModified!)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja_pagos_multiples
integer y = 1224
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja_pagos_multiples
integer y = 1096
end type

type dw_minutas_detalle from u_dw within w_caja_pagos_multiples
integer x = 3205
integer y = 1588
integer width = 114
integer height = 164
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.visible = false
end event

type cb_aceptar from commandbutton within w_caja_pagos_multiples
event csd_avisos_multiple ( )
event csd_avisos_unico ( )
event csd_generar_liquidacion ( datawindow dw_avisos )
event csd_facturas_unico ( string lista_facturas,  string lista_proformas )
event csd_facturas_multiple ( string lista_facturas,  string lista_proformas )
integer x = 635
integer y = 1396
integer width = 466
integer height = 92
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event csd_avisos_multiple();// Evento para el cobro multiple
double total_pagado, total_a_pagar, diferencia, saldo
long fila, indice_aviso, fila_cobros_factura , j, retorno
string mensaje_avisos= '', mensaje_cobros ='', mensaje = ''
string id_cobro_multiple, id_minuta, forma_pago, banco, tipo_gestion, pagador, nombre_pagador, lista_n_expedi, n_expedi
string tipo_pago, forma_pago_cobro , lista_n_fact
boolean b_error = false, b_HayIngreso
datetime fecha_pago
st_liquidacion datos_liquidacion

// Se  preparan los avisos antes de generar las facturas y cobros
cb_preparar.trigger event clicked()

// Aceptamos lo ultimo indicado
dw_valores_genericos.trigger event pfc_accepttext(true)
dw_cobros_multiples.trigger event pfc_accepttext(true)
dw_relaciones_generadas.trigger event pfc_accepttext(true)
dw_nombre_pagador.trigger event pfc_accepttext(true)

// Que indiquen al menos un cobro multiple
if dw_cobros_multiples.RowCount() = 0 then
	MessageBox(g_titulo, "Debe indicar al menos una l$$HEX1$$ed00$$ENDHEX$$nea en los cobros realizados", stopsign!)
	return
	
end if


// --> verificamos que los importes coincidan
total_pagado = round(dw_cobros_multiples.getitemNumber(1, 'total'),2)
total_a_pagar = round(dw_valores_genericos.getitemNumber(1, 'total_pagar'),2)
diferencia = total_a_pagar - total_pagado
if abs(diferencia)>=0.01 then
	// Modificado yexaira 05/05/08
	if MessageBox(g_titulo, "Los importes pagado y a pagar no coinciden (diferencia "+string(round(diferencia,2), "#,##0.00")+" ).&
	Est$$HEX2$$e1002000$$ENDHEX$$seguro de continuar? (S/N)", question!, yesno!) = 2 then
		return
	else 
		dw_cobros_multiples.setitem(1, 'diferencia', round(diferencia, 2))
	end if
end if

//// --> Comprobamos que ha generado las relaciones
//if dw_relaciones_generadas.RowCount()= 0 then
//	Messagebox(g_titulo, "Debe pulsar el bot$$HEX1$$f300$$ENDHEX$$n de preparar las relaciones", stopsign!)
//	return
//end if
///**/
dw_originales_copias_obj_impr.accepttext()
dw_originales_copias_obj_impr.Event csd_opciones_impresion()

//Deshabilito el bot$$HEX1$$f300$$ENDHEX$$n para que no cobren m$$HEX1$$e100$$ENDHEX$$s de una vez
this.enabled = false

// Verificamos la forma de pago
mensaje = ''
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	// Cogemos la forma de pago
	forma_pago = dw_cobros_multiples.GetitemString(fila, 'forma_pago')
	FOR indice_aviso =1 to dw_relaciones_generadas.RowCount()
		//Cogemos los par$$HEX1$$e100$$ENDHEX$$metros necesarios para realizar las validaciones
		//yexa
	//	if dw_relaciones_generadas.GetItemString(indice_aviso, 'relacionado_cobro_multiple'+string(fila)) = '1' then
			tipo_gestion = dw_relaciones_generadas.GetItemString(indice_aviso, 'tipo_gestion')
			pagador = dw_relaciones_generadas.GetItemString(indice_aviso, 'pagador')
			// ------------- Validaciones forma de pago
			if forma_pago = g_formas_pago.cargo then
				if tipo_gestion = 'C' then
					mensaje += 'Aviso: '+dw_relaciones_generadas.GetItemString(indice_aviso, 'n_aviso')+'  -   Un Aviso Con Gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se puede cobrar por cuenta personal.'+cr
				elseif tipo_gestion = 'S'  then
					if pagador = '2' then // pagador es empresa
						mensaje += 'Aviso: '+dw_relaciones_generadas.GetItemString(indice_aviso, 'n_aviso')+'  -    El pagador es una empresa. No puede cargarle al colegiado los gastos, paga la empresa.'+cr
					end if
					if pagador = '3' then // pagador es cliente
						mensaje += 'Aviso: '+dw_relaciones_generadas.GetItemString(indice_aviso, 'n_aviso')+'  -   El pagador es un cliente. No puede cargarle al colegiado los gastos, paga el cliente.'+cr		
					end if		
				end if
			end if				
	//	end if
	NEXT
NEXT


/**/
//yexa
if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if				

// En el proceso se rellenar$$HEX2$$e1002000$$ENDHEX$$el nombre dle pagador
nombre_pagador = ''

// Cogemos el nombre de quien paga
//nombre_pagador = dw_nombre_pagador.getItemString(1, 'nombre_pagador')
//if f_es_vacio(nombre_pagador) then
//	// Cogemos el nombre de quien paga
	nombre_pagador = dw_relaciones_generadas.getItemString(1, 'nombre_pagador')
//end if

///////////////////////////////////////////////////////
// Generacion de todo lo necesario para los avisos
///////////////////////////////////////////////////////
// Colocamos el identificador del cobro multiple en cada uno de los cobros de las facturas
fecha_pago = dw_cobros_multiples.GetitemDateTime(1, 'fecha')

retorno = parent.event csd_cambio_iva(fecha_pago)
if(retorno < 0)then
	return
end if

//MODIFICADO YEXAIRA 12/05/08
	// Cogemos los datos que necesitamos del cobro multiple
	forma_pago = dw_cobros_multiples.GetitemString(1, 'forma_pago')
	banco =dw_cobros_multiples.GetitemString(1, 'banco')//dw_cobros_multiples.GetitemString(1, 'banco') 

	FOR indice_aviso = 1 TO dw_relaciones_generadas.RowCount()
		//MODIFICADO YEXAIRA 05/05/08
	     	id_minuta = dw_relaciones_generadas.GetItemString(indice_aviso, 'id_minuta')
			tipo_gestion = dw_relaciones_generadas.GetItemString(indice_aviso, 'tipo_gestion')
			// Retriveamos la minuta
			dw_minutas_detalle.retrieve(id_minuta)
			// Actualizamos los valores
			dw_minutas_detalle.SetItem(1,'fecha_pago',fecha_pago)
			dw_minutas_detalle.SetItem(1,'forma_pago','CM') // POR ORDEN DE PACO LA FORMA DE PAGO SER$$HEX2$$c1002000$$ENDHEX$$CM
			dw_minutas_detalle.SetItem(1,'banco',banco) // No se puede pasar blanco

			string copias, origin
			// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro o autoliquidaci$$HEX1$$f300$$ENDHEX$$n separamos los originales y copias en las facturas de honos y gastos
			if tipo_gestion = 'S' then
				copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
				origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
			else
				copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
				origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
			end if
			// Tenemos que hacer esto antes para que salga el n$$HEX2$$ba002000$$ENDHEX$$de salida en las facturas
			CHOOSE CASE g_colegio
					CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA','COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER', 'COAATMCA', 'COAATLL'
						if f_fases_cambia_estado_fase_segun_pagado(dw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
							Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
							return
						end if
			END CHOOSE
			
			// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
				if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_caja_pago.getitemnumber(1, 'total_pagar')>0 then
					st_saldo_cuenta_bancaria_colegiado lst_entrada
					lst_entrada.id_colegiado = dw_minutas_detalle.getitemstring(1, 'id_colegiado')
					lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
					lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
				
					saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
				//	messagebox('', string(saldo))	
					if saldo < dw_caja_pago.getitemnumber(1, 'total_pagar') then
						openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
						return
					end if
				end if

				
			///////////////////////////////////////////////////////
			// Debemos generar la facturas asociadas a este aviso!
			///////////////////////////////////////////////////////
			wf_generar_facturas_y_liquidaciones(tipo_gestion, dw_valores_genericos)
			
			// Marcar la prenda como pagada
			if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
				f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
			end if
			// Lanzamos el ultimo evento
				parent.trigger event csd_comprobar_todo_cobrado('MINUTAS')
			j++
			if j=dw_cobros_multiples.rowcount() then j= 1
		//end if
	NEXT
//NEXT

// Ahora ponemos el id correspondiente en la tabla de cobros
if wf_consultar_cobros_avisos()<1 then
	// Error al recuperar los cobros
	Messagebox(g_titulo, "Ha ocurrido un error al procesar los cobros de las facturas. Consulte el estado de las mismas", stopsign!)
	b_error = true
	return
end if
lista_n_expedi= ''
n_expedi = ''
lista_n_fact = ''

FOR indice_aviso = 1 TO dw_relaciones_generadas.RowCount()
		//yexaira 
		//if dw_relaciones_generadas.GetItemString(indice_aviso, 'relacionado_cobro_multiple'+string(fila)) = '1' then
			id_minuta = dw_relaciones_generadas.GetItemString(indice_aviso, 'id_minuta')
			if n_expedi <> dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi') then
				if LenA(lista_n_expedi)>0 then lista_n_expedi += ', '
				lista_n_expedi += dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi')
				n_expedi = dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi')
			end if
			// Filtramos los cobros para que salgan solo los de esa minuta
			dw_cobros.setfilter("id_fase = '"+ id_minuta + "'")
			dw_cobros.filter()
			for fila = 1 to dw_cobros.rowcount()
					if dw_cobros.getitemstring(fila, 'forma_pago') <> 'CM' then continue
					if LenA(lista_n_fact)>0 then lista_n_fact += ', '
					lista_n_fact += f_dame_n_fact_de_id(dw_cobros.getitemstring(fila,'id_factura')) 
			next
			// Quitamos los filtros
			dw_cobros.setfilter("")
			dw_cobros.filter()
					
next

// Colocamos el identificador del cobro multiple en cada uno de los cobros de las facturas
fecha_pago = dw_cobros_multiples.GetitemDateTime(1, 'fecha')
//MODIFICADO YEXAIRA 12/05/08
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	// Colocamos el idfntificador
	id_cobro_multiple = f_siguiente_numero('ID_COBRO_MULTIPLE',10)
	dw_cobros_multiples.setitem(fila, 'id_cobro_multiple', id_cobro_multiple)
	
	//Se actuaslizar$$HEX2$$e1002000$$ENDHEX$$la empresa para multiempresa -  betsy
	dw_cobros_multiples.setitem(fila, 'empresa',g_empresa)
	
	//if nombre_pagador <> dw_nombre_pagador.getItemString(1, 'nombre_pagador') then
		dw_cobros_multiples.setitem(fila, 'pagador',dw_nombre_pagador.getItemString(1, 'nombre_pagador'))
	//else
		//dw_cobros_multiples.setitem(fila, 'pagador', nombre_pagador)
	//end if
	
	// Cogemos los datos que necesitamos del cobro multiple
	forma_pago = dw_cobros_multiples.GetitemString(fila, 'forma_pago')
	banco = dw_cobros_multiples.GetitemString(fila, 'banco')
	
	// Colocamos el del ultimo expediente
	if len(lista_n_expedi)>100 then
		dw_cobros_multiples.setitem(fila, 'expediente',mid(lista_n_expedi,0,97)+"..")
	else
		dw_cobros_multiples.setitem(fila, 'expediente',lista_n_expedi)
	end if
	//Colocamos las facturas asociadas al cobro
		if len(lista_n_fact)>150 then
			 dw_cobros_multiples.setitem(fila, 'lista_fact',mid(lista_n_fact,0,147)+"..")
		else
			 dw_cobros_multiples.setitem(fila, 'lista_fact',lista_n_fact)
		end if

	
NEXT	

j=1

FOR indice_aviso = 1 TO dw_relaciones_generadas.RowCount()
	//yexaira 
	id_minuta = dw_relaciones_generadas.GetItemString(indice_aviso, 'id_minuta')
	// Retriveamos la minuta
	dw_minutas_detalle.retrieve(id_minuta)
	

	// Filtramos los cobros para que salgan solo los de esa minuta
	dw_cobros.setfilter("id_fase = '"+ id_minuta + "'")
	dw_cobros.filter()
			
	if g_cerrar_exp_minuta_final='S' then
		string id_fase
		select f.id_fase,f.tipo_gestion into :id_fase,:tipo_gestion from fases_minutas m,fases f where f.id_fase=m.id_fase and m.id_minuta=:id_minuta;

		if tipo_gestion='C' then
			f_fases_cierre_expedientes_congest(id_fase)		
		else
			f_fases_cierre_expedientes_singest(id_fase)						
		end if

	end if			
		
			FOR fila_cobros_factura = 1 TO dw_cobros.RowCount()
				// No actualizamos los datos si es una factura de gastos de un aviso con gestion de cobros
				if not(dw_cobros.GetItemString(fila_cobros_factura, 'tipo_gestion') = 'C' and &
					dw_cobros.GetItemString(fila_cobros_factura, 'tipo_factura') = g_colegio_colegiado) then
					forma_pago_cobro = dw_cobros.GetItemString(fila_cobros_factura, 'forma_pago')
					// Averiguamos si es autoliquidacion, que en este caso no se debe tocar nada
					select hay_ingreso into :tipo_pago from csi_formas_de_pago where tipo_pago = :forma_pago_cobro;
					b_HayIngreso = (upper(tipo_pago) = 'S')
					// No lo ponemos en la autoliquidacion
					if b_HayIngreso then
						// Coloco el identificador
						id_cobro_multiple = dw_cobros_multiples.getitemstring(j,'id_cobro_multiple')
						dw_cobros.setitem(fila_cobros_factura , 'id_cobro_multiple', id_cobro_multiple)
						// Colocamos a pelo la forma de pago como CM
						dw_cobros.setitem(fila_cobros_factura , 'forma_pago', 'CM')
							
						if dw_cobros_multiples.rowcount() =j then 
							j=1
						else
							j++
						end if
					
					end if
				END IF
					
			NEXT
			// Lanzamos el ultimo evento
			//parent.trigger event csd_comprobar_todo_cobrado('CAJA')
				
		//end if
	NEXT


	


// Quitamos los filtros
dw_cobros.setfilter("")
dw_cobros.filter()
// Grabamos el dw de cobros multiples
dw_cobros_multiples.update()
// Grabamos el dw de cobros de facturas
dw_cobros.update()

// Cerramos esta ventana
i_parametros.realizado = true
i_parametros.unico_multiple = 'M' // Multiple
i_parametros.tipo_carta_imprimir = dw_caja_pago.getitemstring(1, 'tipo_carta_imprimir')
i_parametros.copias = dw_caja_pago.getitemnumber(1, 'copias')
// Cerramos la ventana
closewithreturn(parent, i_parametros)
end event

event csd_avisos_unico();//// Evento para el cobro unico

this.enabled = false
dw_caja_pago.accepttext()
string mensaje, tipo_gestion, forma_pago, pagador, id_minuta, id_factura_ultima_generada
string id_factura_ultima_generada_despues, orden_apunte, pagador_aviso, id_cliente, id_minuta_otra, id_fase
long fila
double saldo
w_fases_detalle w_ventana_fases
string id_expedi
st_liquidacion datos_liquidacion

SetPointer(HourGlass!)
mensaje = mensaje + f_valida(dw_caja_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'banco','NOVACIO','Debe especificar el banco.')


// Modificado Ricardo 04-03-10
double cambio
cambio = dw_caja_pago.getitemNumber(dw_caja_pago.getrow(), 'cambio') 
if cambio< -0.01 or isnull(cambio) then mensaje += "Debe indicar un importe suficientemente grande como para pagar la factura"
// FIN Modificado Ricardo 04-03-10

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	this.enabled = true
	return
End if
forma_pago = dw_caja_pago.getitemstring(1, 'forma_pago')

// INC. 8583
string banco
banco = dw_caja_pago.GetItemString(1,'banco')
if g_colegio = "COAATA" and forma_pago = g_formas_pago.domiciliacion and banco = "09" then
	messagebox(g_titulo, "No se permite esta combinaci$$HEX1$$f300$$ENDHEX$$n de forma de pago y banco", stopsign!)
	this.enabled = true
	return
end if

// Modificado David 14/04/2005 - Deshabilitamos el dw para que no puedan modificar el banco, que seg$$HEX1$$fa00$$ENDHEX$$n dicen, genera facturas duplicadas
dw_caja_pago.enabled = false
// Modificado David 20/04/2005 - Deshabilitamos tambi$$HEX1$$e900$$ENDHEX$$n el bot$$HEX1$$f300$$ENDHEX$$n cancelar para que no puedan pinchar y dar error
cb_cancelar.enabled = false


dw_originales_copias_obj_impr.accepttext()
dw_originales_copias_obj_impr.Event csd_opciones_impresion()


// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		//	Caso en que hay que cobrar mas de una minuta (seg$$HEX1$$fa00$$ENDHEX$$n las marcadas por procesar)
		// Recorremos el datawindow para ver al cantidad a pagar
		FOR fila =1 to i_parametros.dw.RowCount()
			if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
				//Cogemos los par$$HEX1$$e100$$ENDHEX$$metros necesarios para realizar las validaciones
				dw_minutas_detalle.retrieve(i_parametros.dw.GetItemString(fila, 'id_minuta'))
				tipo_gestion = i_parametros.dw.GetItemString(fila, 'tipo_gestion')
				pagador = i_parametros.dw.GetItemString(fila, 'pagador')
				// ------------- Validaciones forma de pago
				if forma_pago = g_formas_pago.cargo then
					if tipo_gestion = 'C' then
						mensaje = cr + mensaje + 'Un Aviso Con Gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se puede cobrar por cuenta personal.' + cr + 'Cancele y cambie el tipo de gesti$$HEX1$$f300$$ENDHEX$$n si desea cobrar con cargo en cuenta del colegiado'
					elseif tipo_gestion = 'S'  then
						if pagador = '2' then // pagador es empresa
							mensaje = cr + mensaje + 'El pagador de este aviso es una empresa.' + cr + 'No puede cargarle al colegiado los gastos, paga la empresa.'
						end if
						if pagador = '3' then // pagador es cliente
							mensaje = cr + mensaje + 'El pagador de este aviso es un cliente.' + cr + 'No puede cargarle al colegiado los gastos, paga el cliente.'		
						end if		
					end if
				end if				
				if mensaje<>'' Then
					Messagebox(g_titulo,mensaje,StopSign!)
					this.enabled = true
					dw_caja_pago.enabled = true
					cb_cancelar.enabled = true
					return
				End if				
				// ------------- Fin validaciones Forma de Pago
				dw_minutas_detalle.SetItem(1,'fecha_pago',dw_caja_pago.GetItemDateTime(1,'fecha_pago'))
				dw_minutas_detalle.SetItem(1,'forma_pago',dw_caja_pago.GetItemString(1,'forma_pago'))
				dw_minutas_detalle.SetItem(1,'banco',dw_caja_pago.GetItemString(1,'banco'))
				string copias, origin
				// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro o autoliquidaci$$HEX1$$f300$$ENDHEX$$n separamos los originales y copias en las facturas de honos y gastos
				if tipo_gestion = 'S' then
					copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				else
					copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
//					i_impresion_formato.copias = dw_originales_copias_obj_impr.GetItemstring(1, "n_orig_gas") + dw_originales_copias_obj_impr.GetItemstring(1, "n_orig_gas")
				end if

				// Tenemos que hacer esto antes para que salga el n$$HEX2$$ba002000$$ENDHEX$$de salida en las facturas
				CHOOSE CASE g_colegio
					CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA', 'COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER', 'COAATMCA', 'COAATLL'
						if f_fases_cambia_estado_fase_segun_pagado(dw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
							Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
							return
						end if
				END CHOOSE
				
				// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
				if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_caja_pago.getitemnumber(1, 'total_pagar')>0 then
					st_saldo_cuenta_bancaria_colegiado lst_entrada
					lst_entrada.id_colegiado = dw_minutas_detalle.getitemstring(1, 'id_colegiado')
					lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
					lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
				
					saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
				//	messagebox('', string(saldo))	
					if saldo < dw_caja_pago.getitemnumber(1, 'total_pagar') then
						openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
						return
					end if
				end if

				// Modificado Ricardo 2005-05-10
				st_generar_facturas_minutas parametros_factura_minuta

				// Modificado David 23/02/2006 - Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n a la funci$$HEX1$$f300$$ENDHEX$$n
				parametros_factura_minuta.impresion_formato 	= i_impresion_formato
			     if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then      
               			parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
           		end if

				parametros_factura_minuta.dw_minuta 			= dw_minutas_detalle
				parametros_factura_minuta.num_orig 				= Integer(origin)
				parametros_factura_minuta.num_copias 			= Integer(copias)
				parametros_factura_minuta.regulariza_musaat	= false
				parametros_factura_minuta.movimiento_musaat	= true
				parametros_factura_minuta.tipo_movimiento_csd= dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
				parametros_factura_minuta.tipo_prev				= ''
				parametros_factura_minuta.dw_factura			= dw_caja_pago
				// Para determinar la serie usamos el siguiente criterio:
				// -> Minutas SGC : Mirar el total colegiado. ES valido el 100% de las veces
				// -> Minutas CGC : Mirar el total colegiado. No es valido siempre, pero elegiremos este criterio por ser el mejor para el colegio (pueden salir mal las de colegiado)		
				// Modificado Paco 03/11/2005: Se amplia el criterio mirando tambi$$HEX1$$e900$$ENDHEX$$n el total_cliente cuando el total_colegiado = 0
				if (dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0) or &
				(dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')=0 and dw_minutas_detalle.GetItemNumber(1, 'total_cliente')<0) then
					parametros_factura_minuta.serie				= g_facturas_negativas_serie
				else
					parametros_factura_minuta.serie				= g_serie_fases
				end if
				// Modificado David 21/12/2005: Caso concreto de aviso CGC en que los honorarios son positivos y los gastos negativos
				if dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0 and &
					dw_minutas_detalle.GetItemNumber(1, 'total_cliente')>0 then
					parametros_factura_minuta.serie				= g_serie_fases
				end if
				
				// Modificado David 09/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
				if g_colegio = 'COAATTFE' then parametros_factura_minuta.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
				
				f_generar_facturas_minuta(parametros_factura_minuta)
//				f_generar_facturas_minuta(dw_minutas_detalle,Integer(origin),Integer(copias), false, true, dw_minutas_detalle.getitemstring(1, 'tipo_minuta'), '', dw_caja_pago)
				// FIN Modificado Ricardo 2005-05-10
				CHOOSE CASE dw_caja_pago.GetItemString(1,'forma_pago')
					CASE g_formas_pago.pendientes_abono
						// En este caso no lo colocamos como cobrado!
						dw_minutas_detalle.update()
					CASE ELSE
						dw_minutas_detalle.SetItem(1,'pendiente','N')
						dw_minutas_detalle.update()
				
						//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
						if dw_minutas_detalle.getitemstring(1, 'tipo_gestion') = 'C' then
							// VAciamos la estructura primero ya que sino no funciona correctamente :(
							setnull(datos_liquidacion.importe)
							// VAciamos el asunto
							setnull(datos_liquidacion.concepto)
							
							
							// Ahora ponemos lo que nos interesa
							datos_liquidacion.id_fase		= dw_minutas_detalle.getitemstring(1, 'id_minuta')
							datos_liquidacion.id_col		= dw_minutas_detalle.getitemstring(1, 'id_colegiado')
							//datos_liquidacion.f_entrada	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
							
							if g_colegio='COAATCC' or g_colegio='COAATMCA' then
                       			 	datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
                   				else
                      				  datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_pago')                  
                     			end if                     

							datos_liquidacion.tipo			= '0'
							// Con estas formas de pago no se genera liquidaci$$HEX1$$f300$$ENDHEX$$n
							if forma_pago <> g_formas_pago.pendientes_abono and forma_pago <> g_formas_pago.otras_entidades then f_liquidacion(datos_liquidacion)
						end if
						// Lanzamos el ultimo evento
						parent.trigger event csd_comprobar_todo_cobrado('CAJA')
				END CHOOSE
				
				// Generaci$$HEX1$$f300$$ENDHEX$$n de liquidaciones para avisos con importe negativo
				event csd_generar_liquidacion(dw_minutas_detalle)
				
				// Marcar la prenda como pagada
				if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
					f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
				end if
			end if
		NEXT

		
				
	CASE 'FACTURA_NUEVA'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
		// Modificado David 13/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then i_parametros.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
		i_parametros.impresion_formato = i_impresion_formato
		if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then
         		parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
     		end if      

		
	CASE 'COBROS_FACTURAS'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
		// Modificado David 13/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then i_parametros.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
		i_parametros.impresion_formato = i_impresion_formato
		
	CASE 'MINUTAS', 'FASES'
		// Cobramos un aviso de factura
		// Validaciones forma de pago
		tipo_gestion = dw_minutas_detalle.getitemstring(1, 'tipo_gestion')
		pagador = dw_minutas_detalle.getitemstring(1, 'pagador')
		if forma_pago = g_formas_pago.cargo then
			if tipo_gestion = 'C' then
				mensaje = cr + mensaje + 'Un Aviso Con Gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se puede cobrar por cuenta personal.' + cr + 'Cancele y cambie el tipo de gesti$$HEX1$$f300$$ENDHEX$$n si desea cobrar con cargo en cuenta del colegiado'
			elseif tipo_gestion = 'S'  then
				if pagador = '2' then // pagador es empresa
					mensaje = cr + mensaje + 'El pagador de este aviso es una empresa.' + cr + 'No puede cargarle al colegiado los gastos, paga la empresa.'
				end if
				if pagador = '3' then // pagador es cliente
					mensaje = cr + mensaje + 'El pagador de este aviso es un cliente.' + cr + 'No puede cargarle al colegiado los gastos, paga el cliente.'		
				end if		
			end if
		end if				
		if mensaje<>'' Then
			Messagebox(g_titulo,mensaje,StopSign!)
			this.enabled = true
			dw_caja_pago.enabled = true
			cb_cancelar.enabled = true
			return
		End if				
		// ------------- Fin validaciones Forma de Pago		
		dw_minutas_detalle.SetItem(1,'fecha_pago',dw_caja_pago.GetItemDateTime(1,'fecha_pago'))
		dw_minutas_detalle.SetItem(1,'forma_pago',dw_caja_pago.GetItemString(1,'forma_pago'))
		dw_minutas_detalle.SetItem(1,'banco',dw_caja_pago.GetItemString(1,'banco'))

		
		// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro o autoliquidaci$$HEX1$$f300$$ENDHEX$$n separamos los originales y copias en las facturas de honos y gastos
		if tipo_gestion = 'S' then
			copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
			origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		else
			copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
			origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')			
		end if
		
		// Tenemos que hacer esto antes para que salga el n$$HEX2$$ba002000$$ENDHEX$$de salida en las facturas
		CHOOSE CASE g_colegio
			CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA', 'COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER', 'COAATMCA', 'COAATLL'
				if f_fases_cambia_estado_fase_segun_pagado(dw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
					Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
					return
				end if
		END CHOOSE		
		
		// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
		if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_caja_pago.getitemnumber(1, 'total_pagar')>0 then
			lst_entrada.id_colegiado = dw_minutas_detalle.getitemstring(1, 'id_colegiado')
			lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
			lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
		
			saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
		//	messagebox('', string(saldo))	
			if saldo < dw_caja_pago.getitemnumber(1, 'total_pagar') then
				openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
				return
			end if
		end if

		id_factura_ultima_generada = f_siguiente_numero_informativo("FACTUEMI", 10)

		// Modificado David 23/02/2006 - Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n a la funci$$HEX1$$f300$$ENDHEX$$n
		parametros_factura_minuta.impresion_formato 	= i_impresion_formato
		if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then
        		parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
     		end if      


		// Modificado Ricardo 2005-05-10
		parametros_factura_minuta.dw_minuta 			= dw_minutas_detalle
		parametros_factura_minuta.num_orig 				= Integer(origin)
		parametros_factura_minuta.num_copias 			= Integer(copias)
		parametros_factura_minuta.regulariza_musaat	= false
		parametros_factura_minuta.movimiento_musaat	= true
		parametros_factura_minuta.tipo_movimiento_csd= dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
		parametros_factura_minuta.tipo_prev				= ''
		parametros_factura_minuta.dw_factura			= dw_caja_pago
		// Para determinar la serie usamos el siguiente criterio:
		// -> Minutas SGC : Mirar el total colegiado. ES valido el 100% de las veces
		// -> Minutas CGC : Mirar el total colegiado. No es valido siempre, pero elegiremos este criterio por ser el mejor para el colegio (pueden salir mal las de colegiado)
		// Modificado Paco 03/11/2005: Se amplia el criterio mirando tambi$$HEX1$$e900$$ENDHEX$$n el total_cliente cuando el total_colegiado = 0
		if (dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0) or &
		(dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')=0 and dw_minutas_detalle.GetItemNumber(1, 'total_cliente')<0) then
			parametros_factura_minuta.serie				= g_facturas_negativas_serie
		else
			parametros_factura_minuta.serie				= g_serie_fases
		end if
		// Modificado David 21/12/2005: Caso concreto de aviso CGC en que los honorarios son positivos y los gastos negativos
		if dw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0 and &
			dw_minutas_detalle.GetItemNumber(1, 'total_cliente')>0 then
			parametros_factura_minuta.serie				= g_serie_fases
		end if

		// Modificado David 09/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then parametros_factura_minuta.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')

		f_generar_facturas_minuta(parametros_factura_minuta)
		//f_generar_facturas_minuta(dw_minutas_detalle,Integer(origin),Integer(copias), false, true, dw_minutas_detalle.getitemstring(1, 'tipo_minuta'), '', dw_caja_pago)
		// FIN Modificado Ricardo 2005-05-10
		
		// David 28/04/2006 - C$$HEX1$$f300$$ENDHEX$$digo extra$$HEX1$$ed00$$ENDHEX$$do y adaptado de la caja donde ya se rellena el campo orden_apunte
		id_factura_ultima_generada_despues = f_siguiente_numero_informativo("FACTUEMI", 10)
		if g_colegio = 'COAATGU' then
			// Para cada aviso ponemos el numero en las facturas generadas
			id_minuta = dw_minutas_detalle.GetItemString(1, 'id_minuta')
			pagador_aviso = dw_minutas_detalle.GetItemString(1, 'pagador')
			id_cliente = dw_minutas_detalle.GetItemString(1, 'id_cliente')
			id_fase = dw_minutas_detalle.GetItemString(1, 'id_fase')
			// Buscamos otro aviso de la fase con el mismo pagador para poner el mismo n$$HEX1$$fa00$$ENDHEX$$mero
			select id_minuta into :id_minuta_otra from fases_minutas where id_minuta <> :id_minuta and pagador = :pagador_aviso and id_cliente = :id_cliente and id_fase = :id_fase ;
			if not f_es_vacio (id_minuta_otra) then
				select orden_apunte into :orden_apunte from csi_facturas_emitidas where id_fase = :id_minuta_otra ;
			end if
			// Pillamos el siguiente numerito de cobros juntos
			if f_es_vacio(orden_apunte) then orden_apunte = f_siguiente_numero('ORDEN_APUNTE', 10)
			// Hacemos el update
			update csi_facturas_emitidas set orden_apunte = :orden_apunte where id_fase = :id_minuta and id_factura between :id_factura_ultima_generada and :id_factura_ultima_generada_despues ;
		end if
		// Fin David 28/04/2006		
		
		CHOOSE CASE dw_caja_pago.GetItemString(1,'forma_pago')
			CASE g_formas_pago.pendientes_abono
				// No hacemos nada
				dw_minutas_detalle.update()
			CASE ELSE
				dw_minutas_detalle.SetItem(1,'pendiente','N')
				dw_minutas_detalle.update()
				//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
				if dw_minutas_detalle.getitemstring(1, 'tipo_gestion') = 'C' then
					// VAciamos la estructura primero ya que sino no funciona correctamente :(
					setnull(datos_liquidacion.importe)
					// VAciamos el asunto
					setnull(datos_liquidacion.concepto)
					
					// Ahora ponemos lo que nos interesa
					datos_liquidacion.id_fase		= dw_minutas_detalle.getitemstring(1, 'id_minuta')
					datos_liquidacion.id_col		= dw_minutas_detalle.getitemstring(1, 'id_colegiado')
					//datos_liquidacion.f_entrada	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
					if g_colegio='COAATCC' or g_colegio='COAATMCA' then
							datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
						else
							datos_liquidacion.f_entrada   = dw_caja_pago.GetItemDateTime(1,'fecha_pago')                  
						end if               

					datos_liquidacion.tipo			= '0'
					// Con estas formas de pago no se genera liquidaci$$HEX1$$f300$$ENDHEX$$n
					if forma_pago <> g_formas_pago.pendientes_abono and forma_pago <> g_formas_pago.otras_entidades then f_liquidacion(datos_liquidacion)
				end if
				// Lanzamos el ultimo evento
				parent.trigger event csd_comprobar_todo_cobrado('MINUTAS')
		END CHOOSE
		
		// Generaci$$HEX1$$f300$$ENDHEX$$n de liquidaciones para avisos con importe negativo
		event csd_generar_liquidacion(dw_minutas_detalle)

		// Marcar la prenda como pagada
		if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
			f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
		end if		
		
		// Modificado David - 23/02/2005
		// En las regularizaciones el importe pagado es menor que el que figura en descuentos
		// y hay que pasar el contrato a abonado y retirado
		if g_colegio = 'COAATGC' then
			id_fase = dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'id_fase')
			id_minuta = dw_minutas_detalle.getitemstring(1, 'id_minuta')
			f_fases_cambia_estado_regulariza_gc(id_fase,id_minuta)
		end if
		
		datetime f_cierre,f_abono,f_tmp


///////////////////////////////////////////////////////////////////////////////////////////////////////
// NUEVO CRITERIO: ICN-19  1/10/2008
// Se cierra el expediente si no existe ninguna minuta en todo el expediente pendiente de cobro
///////////////////////////////////////////////////////////////////////////////////////////////////////		

	if g_cerrar_exp_minuta_final='S' then
		id_fase = dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'id_fase')
		tipo_gestion=dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'tipo_gestion')
		if g_cerrar_exp_minuta_final='S' and tipo_gestion='C' then
			f_fases_cierre_expedientes_congest(id_fase)		
		end if
	end if
		
		

	/*
		////////////////////////////////////////////////////////////////////////////////////////
		//  Se cierra el expediente cuando se cobra una minuta final	(Agosto 2008)
		////////////////////////////////////////////////////////////////////////////////////////
		if g_cerrar_exp_minuta_final='S' and dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 't_minuta')='F' then

			id_fase = dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'id_fase')		
			select id_expedi, f_abono into :id_expedi,:f_abono from fases where id_fase=:id_fase;			
			
			if dw_minutas_detalle.getitemstring(1, 'tipo_gestion')='C' then
				f_cierre= dw_minutas_detalle.GetItemDateTime(1,'fecha_pago')
			else
				f_cierre=f_abono
			end if			

			select e.f_cierre into :f_tmp from fases f,expedientes e where f.id_fase=:id_fase and f.id_expedi=e.id_expedi;				
			if IsNull(f_tmp) then 
				update expedientes set cerrado='S',f_cierre=:f_cierre from fases f where f.id_fase=:id_fase and f.id_expedi=expedientes.id_expedi;				
			end if
				
			
			if (IsValid(g_detalle_fases)) then
				w_ventana_fases=g_detalle_fases 
				select id_expedi into :id_expedi from fases where id_fase=:id_fase;
				 w_ventana_fases.dw_fases_datos_exp.retrieve(id_expedi)
			end if
		end if	
	*/	
END CHOOSE

i_parametros.realizado = true
i_parametros.unico_multiple = 'U' // Unico
i_parametros.tipo_carta_imprimir = dw_caja_pago.getitemstring(1, 'tipo_carta_imprimir')
i_parametros.copias = dw_caja_pago.getitemnumber(1, 'copias')
closewithreturn(parent, i_parametros)






end event

event csd_generar_liquidacion;string tipo_min
double importe


//MODIFICACION YEXAIRA 23-05-08
//se valida que no se genere liquidaciones con forma de pago CP con importe negativo
if (dw_caja_pago.getitemstring(1,'forma_pago') = 'CP') and (dw_caja_pago.getitemnumber(1,'total_pagar')<0)then return  
//FIN MODIFICACION

// Primero determinamos si corresponde generar la liquidaci$$HEX1$$f300$$ENDHEX$$n
// En principio s$$HEX1$$f300$$ENDHEX$$lo para minutas de regularizaci$$HEX1$$f300$$ENDHEX$$n o devoluci$$HEX1$$f300$$ENDHEX$$n y negativas
tipo_min = LeftA(dw_avisos.getitemstring(1, 'tipo_minuta'),1)
importe = dw_avisos.getitemnumber(1, 'total_colegiado')

// Cuando no se devuelve musaat, el tipo de minuta es 00
if /*(tipo_min = '2' or tipo_min = '6') and*/ importe < 0 then
	// Pasamos los datos de la minuta a la liquidaci$$HEX1$$f300$$ENDHEX$$n
	st_liquidacion datos_liq
	datos_liq.id_fase 	= dw_avisos.getitemstring(1, 'id_minuta')
	datos_liq.id_col  	= dw_avisos.getitemstring(1, 'id_colegiado')
	datos_liq.importe		= importe * (-1)
	
	if tipo_min = '2' then 
		datos_liq.concepto = 'Regularizaci$$HEX1$$f300$$ENDHEX$$n '
		datos_liq.tipo	= '2'
	end if
	
	if tipo_min = '6' then
		datos_liq.concepto = 'Devoluci$$HEX1$$f300$$ENDHEX$$n '
		datos_liq.tipo	= '1'
	end if
	
	openwithparm(w_minutas_genera_liquidacion, datos_liq)
end if

end event

event csd_facturas_unico(string lista_facturas, string lista_proformas);string id_factura='', n_talon, sql_facturas_ant, sql_facturas, id_facturas[], es_proforma, is_forma_pago, is_banco
int fila_cobros, fila, ii_copias, ii_originales, retorno=1
double importe, total_por_pagar,saldo,total_pagar
datastore ds_cobros_frecibidas, ds_facturas
st_liquidacion st_liq
datetime is_fecha_pago
string nombre_pagador,pagador
boolean b_multiples_pagadores,b_no_saldo

//Recojemos valor de la estrcutura
st_liq = i_parametros.st_liq

// Datastore para las facturas
ds_cobros_frecibidas = create datastore
ds_cobros_frecibidas.dataobject = 'd_cobros_frecibidas'
ds_cobros_frecibidas.settransobject (SQLCA)

ds_facturas = create datastore
ds_facturas.dataobject = 'd_caja_factura_emitida_facturas'
ds_facturas.settransobject (SQLCA)

dw_caja_pago.AcceptText()

is_fecha_pago = dw_caja_pago.GetItemDateTime(1,'fecha_pago')
is_forma_pago = dw_caja_pago.GetItemString(1,'forma_pago')
is_banco = dw_caja_pago.GetItemString(1,'banco')
ii_copias = Integer(dw_originales_copias_obj_impr.Getitemstring (1,'n_cop_gas'))
ii_originales = Integer(dw_originales_copias_obj_impr.Getitemstring (1,'n_orig_gas'))
if isnull(ii_copias) then ii_copias = 0
if isnull(ii_originales) then ii_originales = 1

//***********************GENERO FACTURAS DESDE PROFORMA (en su caso)***********************************
//Convierto a proforma (si es el caso)
boolean lb_cobrar=true
if not f_es_vacio(lista_proformas) then
	retorno = wf_generar_proformas(is_fecha_pago,is_forma_pago,is_banco, lista_proformas, 'N', 'N')
	if retorno < 1 then
		lb_cobrar=false
	end if
end if
//*************************************************************************************************

if lb_cobrar then
	//Juntamos las dos listas
	if f_es_vacio(lista_facturas) then
		lista_facturas=lista_proformas
	elseif f_es_vacio(lista_proformas) then
		lista_facturas = lista_facturas
	else
		lista_facturas = lista_facturas + ', ' + lista_proformas
	end if
	
	
	//Troceo los ids
	f_separa_string(lista_facturas, ',', id_facturas)
	
	//Filtro el datastore y me dejo solo las facturas a recorrer
	sql_facturas_ant = ds_facturas.Describe ("DataWindow.Table.Select")
	sql_facturas = sql_facturas_ant
	sql_facturas += " AND id_factura IN ("+f_coloca_comillas(lista_facturas)+")"
	ds_facturas.Modify("DataWindow.Table.Select=~"" + sql_facturas + "~"")
	ds_facturas.Retrieve()
	
	//Inicializamos variable 
	b_multiples_pagadores=false
	b_no_saldo=false
	
	//Validamos la la cuenta personal en caso de tener facturas de un solo colegiado, en caso de n colegiados no permitimos esta forma de pago
	if is_forma_pago=g_formas_pago.cuenta_personal then
		FOR fila = 1 TO ds_facturas.RowCount()
			if f_es_vacio(nombre_pagador) then
				nombre_pagador = ds_facturas.getitemString(fila, 'n_col')						
			else
				if nombre_pagador <> ds_facturas.getitemString(fila, 'n_col')  then
					b_multiples_pagadores = true
					exit
				end if
			end if
		next
		//Si existen facturas de colegiados diferentes, paramos el proceso
		if b_multiples_pagadores=true then
			MessageBox(g_titulo,'No es posible el pago en cuenta personal para facturas de colegiados distintos',StopSign!)
			cb_cancelar.enabled=true
			return
		else
			//Si las facturas son de un solo colegiado, comprobamos si tiene saldo suficiente en su cuenta personal
			total_pagar=dw_caja_pago.getItemNumber(1,'total_pagar')
			if  not f_es_vacio(g_prefijo_cuenta_bancaria_col) and total_pagar>0 and ds_facturas.GetItemString(1,'tipo_persona')='C' then
				st_saldo_cuenta_bancaria_colegiado lst_entrada
				lst_entrada.id_colegiado = 	f_colegiado_id_col(nombre_pagador)
				lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
				lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
						
				saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
				
				if saldo < total_pagar then
					openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
					cb_cancelar.enabled=true
					return
				end if
			//En caso de que el pagador sea un cliente externo, mostramos mensaje por pantalla y paramos el proceso
			elseif ds_facturas.GetItemString(1,'tipo_persona')='P' then
				MessageBox(g_titulo,'No es posible el pago en cuenta personal para clientes externos',StopSign!)
				cb_cancelar.enabled=true
				return
			end if
		end if
	end if
		
		
	// Ahora es cuando marcamos las facturas y los cobros
	importe=0
	FOR fila = 1 TO ds_facturas.RowCount()
	
		// Marcamos el pagado
		ds_facturas.SetItem(fila, 'pagado', 'S')
		ds_facturas.SetItem(fila, 'f_pago', is_fecha_pago)
		ds_facturas.SetItem(fila, 'formadepago', is_forma_pago)
		ds_facturas.SetItem(fila, 'banco', is_banco)
		
		// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
		
					
		id_factura = ds_facturas.GetItemString(fila, 'id_factura')
		st_liq.concepto+=ds_facturas.GetItemString(fila, 'n_fact')
		// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que a$$HEX1$$f100$$ENDHEX$$adir$$HEX2$$e1002000$$ENDHEX$$una linea a la factura para la comisi$$HEX1$$f300$$ENDHEX$$n de la tarjeta
		if i_parametros.comision_tarjeta > 0 then f_factura_comision_tarjeta(id_factura, i_parametros.comision_tarjeta)
							
		// Recupero los cobros
		ds_cobros_frecibidas.retrieve(id_factura)
		// Aplicamos un filtrado para que quite los que est$$HEX1$$e100$$ENDHEX$$n ya pagados. ESos no los queremos
		// SCP-651 Tampoco se quieren cobros con forma de pago PP, DB, ni PE
		ds_cobros_frecibidas.setfilter("pagado = 'N'")
		ds_cobros_frecibidas.filter()
		if ds_cobros_frecibidas.RowCount()>0 then
			// Y ahora debemos marcarlos
			FOR fila_cobros = 1 TO ds_cobros_frecibidas.RowCount()
				if is_forma_pago <> 'PP' and is_forma_pago <> 'DB' and is_forma_pago <> 'PE' then
					ds_cobros_frecibidas.setitem(fila_cobros, 'pagado', 'S')
					ds_cobros_frecibidas.setitem(fila_cobros, 'f_pago', is_fecha_pago)
					ds_cobros_frecibidas.setitem(fila_cobros, 'f_vencimiento', DateTime(Today()))
				else
					datetime aux
					setnull(aux)
					//Factura y cobro impagado
					ds_cobros_frecibidas.setitem(fila_cobros, 'pagado', 'N')
					ds_cobros_frecibidas.setitem(fila_cobros, 'f_pago', aux)
					ds_facturas.SetItem(fila, 'pagado', 'N')
					ds_facturas.SetItem(fila, 'f_pago', aux)
				end if
				// Actualizamos el banco y la forma de pago
				ds_cobros_frecibidas.setitem(fila_cobros, 'forma_pago', is_forma_pago)
				ds_cobros_frecibidas.setitem(fila_cobros, 'banco', is_banco)
				ds_cobros_frecibidas.setitem(fila_cobros, 'cod_usuario', g_usuario)
				ds_cobros_frecibidas.setitem(fila_cobros, 'centro', f_devuelve_centro(g_cod_delegacion))
				importe+=ds_cobros_frecibidas.GetItemNumber(fila_cobros,'importe')
			NEXT
			// Grabamos el dastastore
			ds_cobros_frecibidas.update()
		else
			// Generar el cobro, para ello primero calculamos lo pendiete a cobrar
			double importe_pagado, importe_pagar, importe_total
			importe_total = ds_facturas.GetItemNumber(fila, 'total')
			// Obtenemos lo que se ha pagado ya
			SELECT sum(csi_cobros.importe)   
			into :importe_pagado
			 FROM csi_cobros  
			WHERE csi_cobros.id_factura = :id_factura and pagado = 'S'   ;
			
			// Y ahora es cuando colocamos los valores
			if isnull(importe_pagado) then importe_pagado = 0
			
			// Hacemos la resta y generamos el cobro
			importe_pagar = importe_total - importe_pagado
			
			f_genera_factura_cobro(id_factura,is_forma_pago,is_fecha_pago,is_banco,n_talon,importe_pagar,'S','')
			
			importe+=importe_pagar
			
		end if
							
		// Miramos si querian imprimir las facturas
		datawindow dw_vacio
				
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.id_factura 			= id_factura
		st_imp_fact.id_persona 			= ds_facturas.GetItemString(fila,'emisor')
		st_imp_fact.tipo 					= ds_facturas.GetItemString(fila,'tipo_factura')
		st_imp_fact.dw	 					= dw_vacio
		st_imp_fact.impresion_formato = i_parametros.impresion_formato
		
		// ORIGINALES
		st_imp_fact.copia = 'N'
		st_imp_fact.impresion_formato.asunto_email = 'Factura '+ ds_facturas.GetItemString(fila, 'n_fact')
		st_imp_fact.impresion_formato.nombre = ds_facturas.GetItemString(fila, 'n_fact')
		st_imp_fact.impresion_formato.copias = long(ii_originales)
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// COPIAS
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.email = 'N' // Evitamos que envie el email 2 veces
		st_imp_fact.impresion_formato.copias = long(ii_copias)
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// PDF
		st_imp_fact.copia = 'V' // Esto es necesario porque f_imprimir_factura hace cosas distintas en funci$$HEX1$$f300$$ENDHEX$$n del valor de st_imp_fact.copia
		st_imp_fact.impresion_formato.copias = 1
		f_imprimir_factura_objeto_impr(st_imp_fact)
	NEXT
	// Una vez pagados los cobros y marcadas las facturas grabamos
	ds_facturas.update()
					
	/*if importe<0 then
		st_liq.importe=importe
		OpenWithParm(w_liquidaciones_genera_liquidacion,st_liq)
	end if*/
					
	// Destruimos el datastore
	destroy ds_cobros_frecibidas
end if
//i_parametros.dw.Retrieve()
close(parent)
end event

event csd_facturas_multiple(string lista_facturas, string lista_proformas);// Evento para el cobro multiple
double total_pagado, total_a_pagar, diferencia, saldo
long fila, indice_aviso, fila_cobros_factura , j, retorno, i, n_cobros_s, n_cobros_m, n_cobros_a_generar
string mensaje_avisos= '', mensaje_cobros ='', mensaje = ''
string id_cobro_multiple, id_minuta, forma_pago, banco, tipo_gestion, pagador, nombre_pagador, lista_n_expedi, n_expedi
string tipo_pago, forma_pago_cobro , lista_n_fact, es_proforma, empresa
boolean b_error = false, b_HayIngreso
datetime fecha_pago
st_liquidacion datos_liquidacion
datastore ds_facturas

// VALIDACIONES
// Aceptamos lo ultimo indicado
dw_valores_genericos.trigger event pfc_accepttext(true)
dw_cobros_multiples.trigger event pfc_accepttext(true)
dw_nombre_pagador.trigger event pfc_accepttext(true)
dw_cobros_facturas.trigger event pfc_accepttext(true)
empresa = i_parametros.empresa
// Que indiquen al menos un cobro multiple
if dw_cobros_multiples.RowCount() = 0 then
	MessageBox(g_titulo, "Debe indicar al menos una l$$HEX1$$ed00$$ENDHEX$$nea en los cobros realizados", stopsign!)
	return
end if

// --> verificamos que los importes coincidan
total_pagado = round(dw_cobros_multiples.getitemNumber(1, 'total'),2)
total_a_pagar = round(dw_valores_genericos.getitemNumber(1, 'total_pagar'),2)
diferencia = total_a_pagar - total_pagado
if abs(diferencia)>=0.01 then
	if MessageBox(g_titulo, "Los importes pagado y a pagar no coinciden (diferencia "+string(round(diferencia,2), "#,##0.00")+" ).&
	Est$$HEX2$$e1002000$$ENDHEX$$seguro de continuar? (S/N)", question!, yesno!) = 2 then
		return
	else 
		dw_cobros_multiples.setitem(1, 'diferencia', round(diferencia, 2))
	end if
end if

dw_originales_copias_obj_impr.accepttext()
dw_originales_copias_obj_impr.Event csd_opciones_impresion()
	

// En el proceso se rellenar$$HEX2$$e1002000$$ENDHEX$$el nombre del pagador
nombre_pagador = ''
// Cogemos el nombre de quien paga
nombre_pagador = dw_nombre_pagador.getItemString(1, 'nombre_pagador')
if f_es_vacio(nombre_pagador) then
	nombre_pagador=''
end if

///////////////////////////////////////////////////////
// Generacion de todo lo necesario 
///////////////////////////////////////////////////////
// Colocamos el identificador del cobro multiple en cada uno de los cobros de las facturas
fecha_pago = dw_valores_genericos.GetitemDateTime(1, 'fecha_pago')

retorno = parent.event csd_cambio_iva(fecha_pago)
if(retorno < 0)then
	return
end if

//****************FIN VALIDACIONES **************************//




//Deshabilitamos el bot$$HEX1$$f300$$ENDHEX$$n para evitar que facturen m$$HEX1$$e100$$ENDHEX$$s de 1 vez
this.enabled = false


//Primero convierto proforma a facturas (si es el caso)
//Para comprobarlo miro la lista de proformas
boolean lb_cobrar=true
if not f_es_vacio(lista_proformas) then
	retorno = wf_generar_proformas(dw_valores_genericos.GetItemDateTime(1,'fecha_pago'), 'CM', f_banco_asociado_a_forma_pago('CM'), lista_proformas, 'S', 'S')
	if retorno < 1 then
		lb_cobrar=false
	end if
end if

if lb_cobrar then
	//Juntamos las dos listas
	if f_es_vacio(lista_facturas) then
		lista_facturas=lista_proformas
	elseif f_es_vacio(lista_proformas) then
		lista_facturas = lista_facturas
	else
		lista_facturas = lista_facturas + ', ' + lista_proformas
	end if
	
	//Troceo los ids
	string id_factura[]
	f_separa_string(lista_facturas, ',', id_factura)
	
	//**********MODIFICAR COBROS MULTIPLES****************
	FOR i=1 to dw_cobros_multiples.RowCount()
		// Cogemos los datos que necesitamos del cobro multiple
		forma_pago = dw_cobros_multiples.GetitemString(i, 'forma_pago')
		banco = dw_cobros_multiples.GetitemString(i, 'banco')
		
		// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
		if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and total_a_pagar>0 and dw_nombre_pagador.GetItemString(1,'tipo_persona')='C' then
			st_saldo_cuenta_bancaria_colegiado lst_entrada
			lst_entrada.id_colegiado = 	dw_nombre_pagador.GetItemString(1,'id_pagador')
			lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
			lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
					
			saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
						if saldo < total_a_pagar then
				openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
				return
			end if
		elseif dw_nombre_pagador.GetItemString(1,'tipo_persona')='P' then
			MessageBox(g_titulo,'No es posible el pago en cuenta personal para clientes externos',StopSign!)
			return
		end if
		
		// Colocamos el identificador
		id_cobro_multiple = f_siguiente_numero('ID_COBRO_MULTIPLE',10)
		dw_cobros_multiples.setitem(i, 'id_cobro_multiple', id_cobro_multiple)
		//Scp-1570  		//Se actualizar$$HEX2$$e1002000$$ENDHEX$$la empresa para multiempresa
		if f_es_vacio(i_parametros.empresa) then empresa = g_empresa
		dw_cobros_multiples.setitem(i, 'empresa', empresa)
		//Nombre_pagador
		dw_cobros_multiples.setitem(i, 'pagador',nombre_pagador)
		// Colocamos el del ultimo expediente
		setnull(lista_n_expedi)
		dw_cobros_multiples.setitem(i, 'expediente',lista_n_expedi)
		//Colocamos las facturas asociadas al cobro
		if len(lista_facturas)>150 then
			 dw_cobros_multiples.setitem(i, 'lista_fact',mid(lista_facturas,0,147)+"..")
		else
			 dw_cobros_multiples.setitem(i, 'lista_fact',lista_facturas)
		end if
		
		 //Pagado = 'S'
		
	NEXT
	
	//Quitamos filtros
	dw_cobros.setfilter("")
	dw_cobros.filter()
	// Grabamos el dw de cobros multiples
	dw_cobros_multiples.update()
	// Grabamos el dw de cobros de facturas
	dw_cobros.update()
	
	// Llamamos a la funci$$HEX1$$f300$$ENDHEX$$n que nos cambia el estado de la fase si est$$HEX2$$e1002000$$ENDHEX$$todo pagado.
	//De momento no ! 
	/*
	CHOOSE CASE g_colegio
		CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA','COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER', 'COAATMCA', 'COAATLL'
			if f_fases_cambia_estado_fase_segun_pagado(dw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
				Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
				return
			end if
	END CHOOSE
	*/
	
	//**********MODIFICAR COBROS SIMPLES****************
	
	//Preparo el datastore
	ds_facturas = create datastore
	ds_facturas.dataobject = 'd_facturacion_emitida_lista'
	ds_facturas.settransobject (SQLCA)
	
	//Recorro las facturas 
	FOR i=1 to UpperBound(id_factura)
		//Primero genero los cobros que falten
			//Cogemos los cobros de esa factura
		dw_cobros_facturas.Retrieve(id_factura[i])
		n_cobros_s = dw_cobros_facturas.RowCount()
		n_cobros_m = dw_cobros_multiples.RowCount()
	
		if (n_cobros_m > n_cobros_s) then
			//Si hay m$$HEX1$$e100$$ENDHEX$$s multiples que simples genero los simples que quedan
			FOR n_cobros_s=n_cobros_s+1 to n_cobros_m
				string n_talon
				setnull(n_talon)
				f_genera_factura_cobro(id_factura[i], 'CM', fecha_pago, f_banco_asociado_a_forma_pago('CM'),n_talon,0,'S','')
			NEXT
		elseif (n_cobros_s > n_cobros_m) then
			//Si hay m$$HEX1$$e100$$ENDHEX$$s simples que multiples, los borro
			FOR n_cobros_s=n_cobros_s to n_cobros_m+1 step -1
				dw_cobros_facturas.DeleteRow(n_cobros_s)
			NEXT
		end if
		
		//Refresco
		dw_cobros_facturas.Retrieve(id_factura[i])
		
		//Despu$$HEX1$$e900$$ENDHEX$$s cambio todos los cobros con las siguientes especificaciones
			// id_cobro_multiple = csi_cobros_multiples.id_cobro_multiple
			// forma_d_pago='CM'
			// importe = 0
		boolean encontrado
		encontrado=false
		FOR j=1 to dw_cobros_multiples.RowCount()
			dw_cobros_facturas.SetItem(j,'id_cobro_multiple',dw_cobros_multiples.GetItemString(j,'id_cobro_multiple'))
			dw_cobros_facturas.SetItem(j,'forma_pago','CM')
			dw_cobros_facturas.SetItem(j,'importe',0)
			forma_pago = dw_cobros_multiples.GetitemString(j, 'forma_pago')
			if forma_pago <> 'PP' and forma_pago <> 'DB' and forma_pago <> 'PE' then
				dw_cobros_facturas.SetItem(j,'pagado','S')
				dw_cobros_facturas.SetItem(j,'f_pago',dw_valores_genericos.GetItemDateTime(1,'fecha_pago'))
				dw_cobros_facturas.SetItem(j,'f_vencimiento',Datetime(Today()))
			else
				encontrado = true
				datetime f_pago
				setnull(f_pago)
				//Factura y cobro impagado
				dw_cobros_facturas.SetItem(j,'pagado','N')
				dw_cobros_facturas.SetItem(j,'f_pago',f_pago)
				UPDATE csi_facturas_emitidas SET pagado = 'N' WHERE id_factura = :id_factura[i];
				UPDATE csi_facturas_emitidas SET f_pago = :f_pago WHERE id_factura = :id_factura[i];
			end if
		NEXT
		
		//Limpiamos filtro
		dw_cobros_facturas.SetFilter("")
		dw_cobros_facturas.Filter()
		
		// Grabamos el dw de cobros de facturas
		dw_cobros_facturas.update()
		
		//Por $$HEX1$$fa00$$ENDHEX$$ltimo, marco facturas como pagadas y les pongo fecha de pago y forma de pago CM ; e imprimo
			// Miramos si querian imprimir las facturas
		datawindow dw_vacio
		string sql_facturas, sql_facturas_ant
				
			//Filtro el datastore y me dejo solo las facturas a recorrer
		sql_facturas_ant = ds_facturas.Describe ("DataWindow.Table.Select")
		sql_facturas = sql_facturas_ant
		sql_facturas += " AND csi_facturas_emitidas.id_factura = '"+id_factura[i]+"'"
		ds_facturas.Modify("DataWindow.Table.Select=~"" + sql_facturas + "~"")
		ds_facturas.Retrieve()
		
		if not encontrado then
			UPDATE csi_facturas_emitidas SET pagado = 'S' WHERE id_factura = :id_factura[i];
			UPDATE csi_facturas_emitidas SET f_pago = :fecha_pago WHERE id_factura = :id_factura[i];
		end if
		UPDATE csi_facturas_emitidas SET formadepago = 'CM' WHERE id_factura = :id_factura[i];
		
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.id_factura 			= id_factura[i]
		st_imp_fact.id_persona 			= ds_facturas.GetItemString(1,'emisor')
		st_imp_fact.tipo 					= ds_facturas.GetItemString(1,'tipo_factura')
		st_imp_fact.dw	 					= dw_vacio
		st_imp_fact.impresion_formato = i_parametros.impresion_formato
			
		// ORIGINALES
		st_imp_fact.copia = 'N'
		st_imp_fact.impresion_formato.asunto_email = 'Factura '+ f_dame_n_fact_de_id(id_factura[i])
		st_imp_fact.impresion_formato.nombre =  f_dame_n_fact_de_id(id_factura[i])
		st_imp_fact.impresion_formato.copias = integer(dw_originales_copias_obj_impr.GetItemString(1,'n_orig_gas'))
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// COPIAS
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.email = 'N' // Evitamos que envie el email 2 veces
		st_imp_fact.impresion_formato.copias = integer(dw_originales_copias_obj_impr.GetItemString(1,'n_cop_gas'))
		f_imprimir_factura_objeto_impr(st_imp_fact)
		// PDF
		st_imp_fact.copia = 'V' // Esto es necesario porque f_imprimir_factura hace cosas distintas en funci$$HEX1$$f300$$ENDHEX$$n del valor de st_imp_fact.copia
		st_imp_fact.impresion_formato.copias = 1
		f_imprimir_factura_objeto_impr(st_imp_fact)
		
		//Quito filtros para siguiente iteracion
		ds_facturas.Modify("DataWindow.Table.Select=~"" + sql_facturas_ant + "~"")
	NEXT
else
	dw_cobros_multiples.SetItemStatus(1,0, Primary!, NotModified!)
end if
//FINAL
// Cerramos esta ventana
i_parametros.realizado = true
//i_parametros.dw.Retrieve()
close(parent)
end event

event clicked;
// Cosas a tener en cuenta:
double total_pagado,total_a_pagar,diferencia
int fila
string lista_facturas= '',lista_proformas='',lista_principal='', id_factura, sql_nuevo

// Aceptamos los valores
dw_1.trigger event pfc_accepttext(true)

dw_originales_copias_obj_impr.accepttext()
dw_originales_copias_obj_impr.Event csd_opciones_impresion()

// Evitamos que puedan pulsar lo que no deben
cb_cancelar.enabled = false 
// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		// Miramos en que caso estamos 
		CHOOSE CASE dw_1.getitemString(1, 'tipo_cobros')
			CASE 'U'
				this.trigger event csd_avisos_unico()
			CASE 'M'
				this.trigger event csd_avisos_multiple()
		END CHOOSE	
		
	CASE 'COBROS_FACTURAS'
		// SCP-651
		// Primero rellenamos dos listas:
		// Por un lado est$$HEX2$$e1002000$$ENDHEX$$'lista_facturas' que contiene una lista de id's de facturas NO proforma seleccionadas
		// Por otro lado est$$HEX2$$e1002000$$ENDHEX$$'lista_proformas' que contiene una lista de id's de facturas SI proforma seleccionadas
		lista_facturas= ''
		lista_proformas=''
		lista_principal=''
		
		FOR fila=1 to i_parametros.dw.RowCount()
			if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
				
				id_factura = i_parametros.dw.GetItemString(fila, 'id_factura')
				// Elijo como lista_principal la que toque en cada caso....
				if i_parametros.dw.GetItemString(fila, 'proforma') = 'S' then
					lista_principal = lista_proformas
				elseif i_parametros.dw.GetItemString(fila, 'proforma') = 'N' then
					lista_principal = lista_facturas
				end if
				//A$$HEX1$$f100$$ENDHEX$$ado el id_factura a la lista principa, antes seleccionada...
				if not f_es_vacio ( id_factura ) then
					if lista_principal = '' then
						lista_principal =  id_factura //f_dame_n_fact_de_id(id_factura)
					else
						lista_principal += ', ' +  id_factura //f_dame_n_fact_de_id(id_factura)
					end if
				end if
				//Machaco la lista que toque con la lista principal que acabo de modificar
				if i_parametros.dw.GetItemString(fila, 'proforma') = 'S' then
					lista_proformas = lista_principal
				elseif i_parametros.dw.GetItemString(fila, 'proforma') = 'N' then
					lista_facturas = lista_principal
				end if
				
			end if
		NEXT
		
		//Proceso proformas
		/*if lista_proformas <>'' then
			//Digo que la lista principal es la de proformas
			lista_principal = lista_proformas
		else
			//Digo que la lista principal es la de facturas
			lista_principal = lista_facturas
		end if*/
		
		//Cobrar facturas
		CHOOSE CASE dw_1.getitemString(1, 'tipo_cobros')
			CASE 'U'
				//Preparamos estructura i_parametros (que antes se preparaba en w_caja_pagos) para cobrar las facturas despu$$HEX1$$e900$$ENDHEX$$s
				i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
				i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
				i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
				i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
				i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
				// Modificado David 13/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
				if g_colegio = 'COAATTFE' then i_parametros.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
				i_parametros.impresion_formato = i_impresion_formato
				
				this.trigger event csd_facturas_unico(lista_facturas,lista_proformas)
			CASE 'M'
				//Preparamos estructura i_parametros (que antes se preparaba en w_caja_pagos para cobrar las facturas despu$$HEX1$$e900$$ENDHEX$$s
				i_parametros.fecha_pago 	= dw_valores_genericos.GetItemDateTime(1,'fecha_pago')
				i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
				i_parametros.impresion_formato = i_impresion_formato
				
				this.trigger event csd_facturas_multiple(lista_facturas,lista_proformas)
		END CHOOSE
		
END CHOOSE
end event

type cb_cancelar from commandbutton within w_caja_pagos_multiples
integer x = 1129
integer y = 1396
integer width = 466
integer height = 92
integer taborder = 31
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

event clicked;// De momento
int fila
i_parametros.realizado = false
closewithreturn(parent, i_parametros)
end event

type gb_relacion from groupbox within w_caja_pagos_multiples
boolean visible = false
integer x = 37
integer y = 1148
integer width = 489
integer height = 608
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 80269524
string text = "Relaci$$HEX1$$f300$$ENDHEX$$n entre cobros y avisos:"
end type

type dw_originales_copias_obj_impr from u_dw within w_caja_pagos_multiples
event csd_opciones_impresion ( )
integer x = 1655
integer y = 1116
integer width = 1701
integer height = 436
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_caja_pagos_formato_impresion"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_opciones_impresion();// Se ocultan los campos del asunto email y del nombre del pdf porque a$$HEX1$$fa00$$ENDHEX$$n no hemos generado la factura
// y no sabemos cu$$HEX1$$e100$$ENDHEX$$l ser$$HEX2$$e1002000$$ENDHEX$$su n$$HEX1$$fa00$$ENDHEX$$mero. Se pasar$$HEX1$$e100$$ENDHEX$$n en la f_factura

//Datos de copias en papel
i_impresion_formato.papel	= GetItemstring(1, "papel")
i_impresion_formato.copias = long(GetItemstring(1, "n_orig_gas"))
//Datos de copias en email
i_impresion_formato.direccion_email=GetItemstring(1, "direccion_email")
i_impresion_formato.email 			= GetItemstring(1, "email")
i_impresion_formato.asunto_email = GetItemstring(1, "asunto_email")

if f_es_vacio(i_impresion_formato.asunto_email) then
	i_impresion_formato.asunto_email = 'Informaci$$HEX1$$f300$$ENDHEX$$n de facturas '
end if

i_impresion_formato.texto_email = ''

//Datos de copias en pdf
i_impresion_formato.visualizar_web 	= 'N'
i_impresion_formato.pdf = GetItemstring(1, "pdf") 
i_impresion_formato.nombre=getitemstring(1,'nombre')

if f_es_vacio(i_impresion_formato.nombre) then i_impresion_formato.nombre = 'Facturas'

i_impresion_formato.ruta_base 			= g_directorio_documentos_visared
i_impresion_formato.ruta_relativa 		= ''
i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
i_impresion_formato.modo_creacion	= 0		//Si el fichero ya existe, se sustituye

end event

event buttonclicked;call super::buttonclicked;string num

CHOOSE CASE dwo.name
	CASE 'b_mas_oh'
		num = this.getitemstring(1, 'n_orig_hon')
		if num < '98' then this.setitem(1, 'n_orig_hon', string(integer(num) + 1, '00'))
	CASE 'b_mas_ch'
		num = this.getitemstring(1, 'n_cop_hon')
		if num < '98' then this.setitem(1, 'n_cop_hon', string(integer(num) + 1, '00'))
	CASE 'b_mas_og'
		num = this.getitemstring(1, 'n_orig_gas')
		if num < '98' then this.setitem(1, 'n_orig_gas', string(integer(num) + 1, '00'))
	CASE 'b_mas_cg'
		num = this.getitemstring(1, 'n_cop_gas')
		if num < '98' then this.setitem(1, 'n_cop_gas', string(integer(num) + 1, '00'))
	CASE 'b_men_oh'
		num = this.getitemstring(1, 'n_orig_hon')
		if num > '00' then this.setitem(1, 'n_orig_hon', string(integer(num) - 1, '00'))
	CASE 'b_men_ch'
		num = this.getitemstring(1, 'n_cop_hon')
		if num > '00' then this.setitem(1, 'n_cop_hon', string(integer(num) - 1, '00'))
	CASE 'b_men_og'
		num = this.getitemstring(1, 'n_orig_gas')
		if num > '00' then this.setitem(1, 'n_orig_gas', string(integer(num) - 1, '00'))
	CASE 'b_men_cg'
		num = this.getitemstring(1, 'n_cop_gas')
		if num > '00' then this.setitem(1, 'n_cop_gas', string(integer(num) - 1, '00'))
END CHOOSE

end event

type dw_nombre_pagador from u_dw within w_caja_pagos_multiples
integer x = 37
integer y = 320
integer width = 3291
integer height = 84
integer taborder = 11
string dataobject = "d_caja_pagador_cobro_multiple"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;// Buscamos la persona que se pretenda colocar como pagador

string id_persona, nulo
CHOOSE CASE dwo.name
	CASE 'b_buscar_colegiado'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_pagador',id_persona)
				this.SetItem(1,'nombre_pagador',f_colegiado_apellido(id_persona))				
				this.SetItem(1,'tipo_persona','C')				
			end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes_exp()

	
		if id_persona="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_pagador',id_persona)
			this.SetItem(1,'nombre_pagador',f_dame_cliente(id_persona))				
			this.SetItem(1,'tipo_persona','P')				
		end if
		
	CASE 'b_borrar'
		setnull(nulo)
		this.SetItem(1,'id_pagador',nulo)
		this.SetItem(1,'nombre_pagador',nulo)
		this.SetItem(1,'tipo_persona',nulo)
END CHOOSE

end event

event constructor;call super::constructor;// Insertamos una linea para poder indicar el pagador
this.insertrow(0)
end event

type gb_cobros_multiples from groupbox within w_caja_pagos_multiples
boolean visible = false
integer x = 32
integer y = 448
integer width = 3328
integer height = 648
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 80269524
string text = "Cobros realizados para pagar los avisos indicados:"
end type

type gb_pagador from groupbox within w_caja_pagos_multiples
boolean visible = false
integer x = 32
integer y = 256
integer width = 3328
integer height = 164
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 80269524
string text = "Pagador de la factura:"
end type

type dw_relaciones_generadas from u_dw within w_caja_pagos_multiples
boolean visible = false
integer y = 1344
integer width = 631
integer height = 432
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_caja_cobro_multiple_relacion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;CHOOSE CASE LeftA(dwo.name, LenA(string(dwo.name))-1)
	CASE 'relacionado_cobro_multiple'
		if dw_relaciones_generadas.GetItemNumber(row, 'marcas_por_aviso') = 1 and data = '1' then
			MessageBox(g_titulo, "No se pueden marcar m$$HEX1$$e100$$ENDHEX$$s de un cobro m$$HEX1$$fa00$$ENDHEX$$ltiple por aviso")
			return 2
		end if
END CHOOSE
end event

type cb_preparar from commandbutton within w_caja_pagos_multiples
boolean visible = false
integer x = 146
integer y = 1784
integer width = 512
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Preparar Relaciones"
end type

event clicked;long fila, fila_insert, n_cobros_multiples
double total_pagado, total_a_pagar, diferencia


if dw_cobros_multiples.Rowcount() = 0 then
	MessageBox(g_titulo, "No existen l$$HEX1$$ed00$$ENDHEX$$neas de cobros m$$HEX1$$fa00$$ENDHEX$$ltiples")
	return
end if

// Hay que ver si el total coincide
total_pagado = dw_cobros_multiples.getitemNumber(1, 'total')
total_a_pagar = dw_valores_genericos.getitemNumber(1, 'total_pagar')

// Se cambia para permitir pagos por mas o menos que el importe a pagar
//scp-1941
//Yexaira 05/05/08
//if round(total_pagado,2)<>round(total_a_pagar,2) then
//	diferencia =  round(total_pagado - total_a_pagar,2)
////	dw_cobros_multiples.setitem(dw_cobros_multiples.rowcount(),'diferencia', diferencia)
//end if
//



// Impedimos el redibujado
dw_relaciones_generadas.setredraw(false)
// Vaciamos todas las relaciones
dw_relaciones_generadas.reset()

// Para cada uno de los cobros multiples habilitamos una columna abajo
For fila = 1 to dw_cobros_multiples.RowCount()

	// Miramos que el importe no sea 0
	if round(dw_cobros_multiples.getitemNumber(fila,  'importe'),2) = 0 then
		MessageBox(g_titulo, "No pueden haber cobros con el importe a 0")
		// PErmitirmos el redibujado
		dw_relaciones_generadas.setredraw(true)
		return
	end if
NEXT

// Miramos cuantos cobros multiples han indicado
n_cobros_multiples = dw_cobros_multiples.RowCount()

// Hacemos un bucle para buscar los valores
FOR fila =1 to i_parametros.dw.RowCount()
	if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
		// Para cada uno de los procesados introducimos una linea en el de relaciones
		fila_insert = dw_relaciones_generadas.insertrow(0)
		CHOOSE CASE i_parametros.tipo 
			CASE 'AVISOS'
				// Colocamos el numero de aviso. Copiamos algunos datos que nos vendr$$HEX1$$e100$$ENDHEX$$n bien en el proceso final
				dw_relaciones_generadas.setitem(fila_insert, 'n_aviso', i_parametros.dw.GetitemString(fila, 'n_aviso'))
				dw_relaciones_generadas.setitem(fila_insert, 'id_minuta', i_parametros.dw.GetitemString(fila, 'id_minuta'))
				dw_relaciones_generadas.setitem(fila_insert, 'tipo_gestion', i_parametros.dw.GetitemString(fila, 'tipo_gestion'))
				dw_relaciones_generadas.setitem(fila_insert, 'pagador', i_parametros.dw.GetitemString(fila, 'pagador'))
				dw_relaciones_generadas.setitem(fila_insert, 'n_expedi', i_parametros.dw.GetitemString(fila, 'n_expedi'))
				dw_relaciones_generadas.setitem(fila_insert, 'nombre_pagador', i_parametros.dw.GetitemString(fila, 'nombre_pagador'))
			CASE 'COBROS_FACTURAS'
		END CHOOSE
		// Si solo hay un cobro multiple, lo marcamos por defecto
		if n_cobros_multiples = 1 then dw_relaciones_generadas.setitem(fila_insert, 'relacionado_cobro_multiple1', '1')
	end if
NEXT

// PErmitirmos el redibujado
dw_relaciones_generadas.setredraw(true)
end event

type dw_1 from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 73
integer y = 32
integer width = 841
integer height = 224
integer taborder = 10
boolean enabled = false
string dataobject = "d_caja_cobro_multiple_seleccion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;// Metemos una linea seg$$HEX1$$fa00$$ENDHEX$$n el tipo de cobro que se quiera
this.insertrow(0)
end event

event itemchanged;call super::itemchanged;// Al cambiar le avisamos de que perder$$HEX2$$e1002000$$ENDHEX$$la informaci$$HEX1$$f300$$ENDHEX$$n actual

if Messagebox(g_titulo, "Est$$HEX2$$e1002000$$ENDHEX$$a punto de cambiar de tipo de cobro, perder$$HEX2$$e1002000$$ENDHEX$$la informacion actual"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea Continuar?", question!, yesno!, 2)=2 then return 2

// Llamamos al evneto que modifica la ventana
parent.post event csd_configurar_ventana()
end event

event doubleclicked;call super::doubleclicked;//dw_cobros.visible = true
end event

type gb_cabecera from groupbox within w_caja_pagos_multiples
boolean visible = false
integer x = 37
integer width = 1463
integer height = 256
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 80269524
end type

type dw_cobros from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 110
integer y = 1404
integer width = 274
integer height = 200
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_caja_cobro_multiple_cobros"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_cobros_facturas from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 407
integer y = 1404
integer width = 274
integer height = 200
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_caja_cobro_multiple_cobros_facturas"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_valores_genericos from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 178
integer y = 36
integer width = 1303
integer height = 184
integer taborder = 11
string dataobject = "d_caja_cobro_multiple_generico"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.insertRow(0)

end event

event itemchanged;call super::itemchanged;long fila
datetime fecha

CHOOSE CASE dwo.name
	CASE 'fecha_pago'
		fecha = datetime(date(data))
		// CAmbiamos la fecha de pago en todos los cobros
		FOR fila =1 TO dw_cobros_multiples.RowCount()
			dw_cobros_multiples.SetItem(fila, 'fecha', fecha)
		NEXT
END CHOOSE

end event

type dw_visualizar_avisos from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 32
integer y = 488
integer width = 3333
integer height = 268
integer taborder = 11
boolean bringtotop = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_cobros_multiples from u_dw within w_caja_pagos_multiples
boolean visible = false
integer x = 59
integer y = 508
integer width = 3278
integer height = 560
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_caja_cobro_multiple_cobros_multiples"
end type

event type integer pfc_preinsertrow();call super::pfc_preinsertrow;// No dejamos poner m$$HEX1$$e100$$ENDHEX$$s de 10
datetime fecha_pago
if this.rowCount() = il_max_cobros then
	Messagebox(g_titulo, "No se pueden indicar m$$HEX1$$e100$$ENDHEX$$s de "+string(il_max_cobros)+" formas de pago distintas", stopsign!)
	return 0
else
	fecha_pago = dw_valores_genericos.getitemDatetime(1, 'fecha_pago')
	if isnull(fecha_pago) then
		MessageBox(g_titulo,"Debe indicar la fecha de pago primero", stopsign!)
		return 0
	end if
	return AncestorReturnValue
end if

end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;// Quitamos el bot$$HEX1$$f300$$ENDHEX$$n de insertar
am_dw.m_table.m_insert.visible = false
am_dw.m_table.m_insert.enabled = false
end event

event pfc_addrow;call super::pfc_addrow;// Solo puede ocurrir este caso
string ls_forma_pago, centro, banco
datetime fecha_pago
if AncestorReturnValue>0 then
	// Solo dejamos seguir si hay fecha de pago
	fecha_pago = dw_valores_genericos.getitemDatetime(1, 'fecha_pago')
	centro = f_devuelve_centro(g_cod_delegacion)
	// Colocamos la fecha de pago
	this.setitem(AncestorReturnValue, 'fecha', fecha_pago)
	this.setitem(AncestorReturnValue, 'cod_usuario', g_usuario)
	this.setitem(AncestorReturnValue, 'centro', centro)//g_centro_por_defecto)
	this.setitem(AncestorReturnValue, 'id_pagador', i_parametros.id_pagador)
	this.setitem(AncestorReturnValue, 'tipo_pagador', i_parametros.tipo_pagador)
	
	// Se coloca por defecto forma de pago Transferencia
	
	if isnull(i_parametros.formapago_cobro) then 
		ls_forma_pago = g_forma_pago_por_defecto
	else
			ls_forma_pago = i_parametros.formapago_cobro
	end if
	if  ls_forma_pago = 'DB' then ls_forma_pago = 'TR'
	if f_es_vacio(this.getitemstring(1, 'forma_pago')) then this.Setitem(1,'forma_pago',ls_forma_pago)
	
	 SELECT csi_formas_de_pago.banco_asociado  
		 INTO :banco  
		 FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :ls_forma_pago ;
		
	if f_es_vacio(this.getitemstring(1, 'banco')) then this.SetItem(1,'banco',banco)
	
	if ls_forma_pago ='ME' then 
		this.object.banco.protect = 1
	else 
		this.object.banco.protect = 0		
	end if


end if

// Se valida que si es colegiado si tiene activo para tarragona el campo de DB



return AncestorReturnValue
end event

event itemchanged;call super::itemchanged;double diferencia, total_pagado, total_a_pagar

CHOOSE CASE dwo.name
	CASE 'forma_pago'
		string tipo_pago, banco
		tipo_pago = string(data)
	   SELECT csi_formas_de_pago.banco_asociado  
		 INTO :banco  
		 FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		if(data ='ME' and (g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio='COAATLL'))then 
			this.object.banco.protect = 1
		else 
			this.object.banco.protect = 0
		end if
	
		// Colocamos el banco
		this.setitem(row, 'banco', banco)
	CASE 'resto'
		if data = 'S' then
			total_pagado = round(dw_cobros_multiples.getitemNumber(1, 'total'),2)
			total_a_pagar = round(dw_valores_genericos.getitemNumber(1, 'total_pagar'),2)
			diferencia = total_a_pagar - total_pagado + this.getitemNumber(row, 'importe')
			if diferencia>=0.01 then
				// Colocamos la diferencia de precio
				this.setitem(row, 'importe', round(diferencia, 2))
			end if
		else
			// quitamos el valor
			this.setitem(row, 'importe', 0)
		end if
	CASE 'importe'
		// Si el total todav$$HEX1$$ed00$$ENDHEX$$a no es el que toca a$$HEX1$$f100$$ENDHEX$$adiremos otra linea
		total_pagado = round(dw_cobros_multiples.getitemNumber(1, 'total'),2)
		total_a_pagar = round(dw_valores_genericos.getitemNumber(1, 'total_pagar'),2)
		diferencia = total_a_pagar - total_pagado + this.getitemNumber(row, 'importe') - double(data)
		if diferencia<0 then
			// Es negativo por lo que impedimos dicho valor
			//Messagebox(g_titulo, "El importe abonado no puede superar el importa a pagar", stopsign!)
			//return 2
			//Se permite hacer pagos por encima y por debajo del importe a pagar
			//Cambio Yexaira 05/05/08
			if Messagebox(g_titulo, "El importe abonado superar el importa a pagar. Est$$HEX2$$e1002000$$ENDHEX$$seguro de continuar?(S/N)", question!, yesno!) = 2 then
				return 2
			end if
			//this.setitem(row,'diferencia', diferencia)
			
		end if
			
		// Si tocan el importe a mano quitamos el check del resto
		if this.getitemString(row, 'resto') = 'S' then
			this.setitem(row, 'resto', 'N')
		end if
		if diferencia>=0.01 then
//			// Colocamos una nueva linea
//			this.trigger event pfc_addrow()

		end if
		
END CHOOSE
end event

event constructor;call super::constructor;// MODIFICADO POR RICARDO 04-03-01
// Omitimos la forma de pago de domiciliacion bancaria

datawindowchild dwc_forma_pago


// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
//// Aplicamos el filtrado
// MODIFICADO POR JESUS 30-11-2010
dwc_forma_pago.setfilter("tipo_pago not in ('DB','CM','PP','PE') ")
// FIN MODIFICADO POR JESUS 30-11-2010
dwc_forma_pago.filter()
// FIN MODIFICADO POR RICARDO 04-03-01


end event

type dw_caja_pago from u_dw within w_caja_pagos_multiples
integer x = 151
integer y = 60
integer width = 1541
integer height = 868
integer taborder = 10
string dataobject = "d_caja_pago"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.insertrow(0)
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'forma_pago'
		string tipo_pago, banco
		tipo_pago = string(data)
	   SELECT csi_formas_de_pago.banco_asociado  
		 INTO :banco  
		 FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		
		// Colocamos el banco
		this.setitem(row, 'banco', banco)
END CHOOSE
end event

type gb_pago_unico from groupbox within w_caja_pagos_multiples
integer x = 46
integer y = 28
integer width = 1701
integer height = 912
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

