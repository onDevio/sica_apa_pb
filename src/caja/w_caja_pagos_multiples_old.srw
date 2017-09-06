HA$PBExportHeader$w_caja_pagos_multiples_old.srw
forward
global type w_caja_pagos_multiples_old from w_response
end type
type gb_pagador from groupbox within w_caja_pagos_multiples_old
end type
type dw_caja_pago from u_dw within w_caja_pagos_multiples_old
end type
type dw_minutas_detalle from u_dw within w_caja_pagos_multiples_old
end type
type cb_aceptar from commandbutton within w_caja_pagos_multiples_old
end type
type cb_cancelar from commandbutton within w_caja_pagos_multiples_old
end type
type dw_cobros_multiples from u_dw within w_caja_pagos_multiples_old
end type
type cb_preparar from commandbutton within w_caja_pagos_multiples_old
end type
type dw_valores_genericos from u_dw within w_caja_pagos_multiples_old
end type
type gb_cabecera from groupbox within w_caja_pagos_multiples_old
end type
type dw_relaciones_generadas from u_dw within w_caja_pagos_multiples_old
end type
type gb_relacion from groupbox within w_caja_pagos_multiples_old
end type
type dw_cobros from u_dw within w_caja_pagos_multiples_old
end type
type gb_cobros_multiples from groupbox within w_caja_pagos_multiples_old
end type
type gb_pago_unico from groupbox within w_caja_pagos_multiples_old
end type
type dw_visualizar_avisos from u_dw within w_caja_pagos_multiples_old
end type
type dw_nombre_pagador from u_dw within w_caja_pagos_multiples_old
end type
type dw_1 from u_dw within w_caja_pagos_multiples_old
end type
type dw_originales_copias_obj_impr from u_dw within w_caja_pagos_multiples_old
end type
end forward

global type w_caja_pagos_multiples_old from w_response
integer width = 3397
integer height = 2008
event csd_comprobar_todo_cobrado ( )
event csd_configurar_ventana ( )
gb_pagador gb_pagador
dw_caja_pago dw_caja_pago
dw_minutas_detalle dw_minutas_detalle
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
dw_cobros_multiples dw_cobros_multiples
cb_preparar cb_preparar
dw_valores_genericos dw_valores_genericos
gb_cabecera gb_cabecera
dw_relaciones_generadas dw_relaciones_generadas
gb_relacion gb_relacion
dw_cobros dw_cobros
gb_cobros_multiples gb_cobros_multiples
gb_pago_unico gb_pago_unico
dw_visualizar_avisos dw_visualizar_avisos
dw_nombre_pagador dw_nombre_pagador
dw_1 dw_1
dw_originales_copias_obj_impr dw_originales_copias_obj_impr
end type
global w_caja_pagos_multiples_old w_caja_pagos_multiples_old

type variables
st_caja_cobros i_parametros
long il_max_cobros = 10
n_csd_impresion_formato i_impresion_formato

end variables

forward prototypes
public subroutine wf_cerrar_ventana_detalle_fases ()
public function long wf_consultar_cobros_avisos ()
public subroutine wf_abrir_ventana_detalle_fases (string id_fase)
public subroutine wf_generar_facturas_y_liquidaciones (string tipo_gestion, u_dw dw)
end prototypes

event csd_comprobar_todo_cobrado();// El contrato pasa a abonado y retirado cuando est$$HEX2$$e1002000$$ENDHEX$$toda la CIP pagada
string id_fase = ''

// Ponemos el puntero a reloj
setpointer(hourglass!)
// Cogemos el idenfitificador de la fase
id_fase = dw_minutas_detalle.getitemstring(dw_minutas_detalle.RowCount(), 'id_fase')

// LLamamos a la funcion que realiza el cambio de estado y dem$$HEX1$$e100$$ENDHEX$$s
if f_fases_cambia_estado_fase_segun_pagado(id_fase, 'CAJA')='-1' then
	Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
	return
end if
end event

event csd_configurar_ventana();// Hacemos la configuraci$$HEX1$$f300$$ENDHEX$$n de la ventana seg$$HEX1$$fa00$$ENDHEX$$n el tipo de cobro elegido

dw_1.trigger event pfc_accepttext(true)

// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		dw_1.visible = true
	CASE 'FACTURA_NUEVA'
		// No hay pagos multiples
		dw_1.setitem(1, 'tipo_cobros', 'U')
		dw_1.visible = false
	CASE 'COBROS_FACTURAS'
		// No hay pagos multiples
		dw_1.setitem(1, 'tipo_cobros', 'U')
		dw_1.visible = false
END CHOOSE


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
		dw_originales_copias_obj_impr.X  = 942
		dw_originales_copias_obj_impr.Y  = 1304		
		
	CASE 'M' // multiple
		gb_cabecera.visible = true
		gb_cobros_multiples.visible = true
		gb_relacion.visible = true
		dw_valores_genericos.visible = true
		dw_cobros_multiples.visible = true
		cb_preparar.enabled = true
		cb_preparar.visible = true
		dw_relaciones_generadas.visible = true
		gb_pagador.visible = true
		dw_nombre_pagador.visible = true
		
		// Ocultamos el otro modo
		gb_pago_unico.visible = false
		dw_caja_pago.visible = false
		dw_originales_copias_obj_impr.visible  = true
		dw_originales_copias_obj_impr.X  = 1765
		dw_originales_copias_obj_impr.Y  = 1316
END CHOOSE 

end event

public subroutine wf_cerrar_ventana_detalle_fases ();// Cerramos la ventana de fases
if isvalid(g_detalle_fases) then close(g_detalle_fases)

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

parametros_factura_minuta.dw_minuta 			= dw_minutas_detalle
parametros_factura_minuta.num_orig 				= Integer(origin)
parametros_factura_minuta.num_copias 			= Integer(copias)
parametros_factura_minuta.regulariza_musaat	= false
parametros_factura_minuta.movimiento_musaat	= true
parametros_factura_minuta.tipo_movimiento_csd= dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
parametros_factura_minuta.tipo_prev				= ''
parametros_factura_minuta.dw_factura			= dw
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

f_generar_facturas_minuta(parametros_factura_minuta)
//f_generar_facturas_minuta(dw_minutas_detalle,Integer(origin),Integer(copias), false, true, dw_minutas_detalle.getitemstring(1, 'tipo_minuta'), '', dw)
// FIN Modificado Ricardo 2005-05-10

				
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
	datos_liquidacion.f_entrada	= dw.GetItemDateTime(1,'fecha_pago')
	datos_liquidacion.tipo			= '0'	
	f_liquidacion(datos_liquidacion)
end if


end subroutine

on w_caja_pagos_multiples_old.create
int iCurrent
call super::create
this.gb_pagador=create gb_pagador
this.dw_caja_pago=create dw_caja_pago
this.dw_minutas_detalle=create dw_minutas_detalle
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.dw_cobros_multiples=create dw_cobros_multiples
this.cb_preparar=create cb_preparar
this.dw_valores_genericos=create dw_valores_genericos
this.gb_cabecera=create gb_cabecera
this.dw_relaciones_generadas=create dw_relaciones_generadas
this.gb_relacion=create gb_relacion
this.dw_cobros=create dw_cobros
this.gb_cobros_multiples=create gb_cobros_multiples
this.gb_pago_unico=create gb_pago_unico
this.dw_visualizar_avisos=create dw_visualizar_avisos
this.dw_nombre_pagador=create dw_nombre_pagador
this.dw_1=create dw_1
this.dw_originales_copias_obj_impr=create dw_originales_copias_obj_impr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_pagador
this.Control[iCurrent+2]=this.dw_caja_pago
this.Control[iCurrent+3]=this.dw_minutas_detalle
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_cobros_multiples
this.Control[iCurrent+7]=this.cb_preparar
this.Control[iCurrent+8]=this.dw_valores_genericos
this.Control[iCurrent+9]=this.gb_cabecera
this.Control[iCurrent+10]=this.dw_relaciones_generadas
this.Control[iCurrent+11]=this.gb_relacion
this.Control[iCurrent+12]=this.dw_cobros
this.Control[iCurrent+13]=this.gb_cobros_multiples
this.Control[iCurrent+14]=this.gb_pago_unico
this.Control[iCurrent+15]=this.dw_visualizar_avisos
this.Control[iCurrent+16]=this.dw_nombre_pagador
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.dw_originales_copias_obj_impr
end on

on w_caja_pagos_multiples_old.destroy
call super::destroy
destroy(this.gb_pagador)
destroy(this.dw_caja_pago)
destroy(this.dw_minutas_detalle)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.dw_cobros_multiples)
destroy(this.cb_preparar)
destroy(this.dw_valores_genericos)
destroy(this.gb_cabecera)
destroy(this.dw_relaciones_generadas)
destroy(this.gb_relacion)
destroy(this.dw_cobros)
destroy(this.gb_cobros_multiples)
destroy(this.gb_pago_unico)
destroy(this.dw_visualizar_avisos)
destroy(this.dw_nombre_pagador)
destroy(this.dw_1)
destroy(this.dw_originales_copias_obj_impr)
end on

event open;call super::open;// Recogemos los valores pasados
long fila
double cantidad_pagar
string tipo_gestion

// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
if isvalid(message.PowerObjectParm) Then
	i_parametros = message.PowerObjectParm	
end if

f_centrar_ventana(this)

// Colocamos la fecha y los datos por defecto
dw_caja_pago.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_valores_genericos.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
if f_es_vacio(dw_caja_pago.getitemstring(1, 'forma_pago')) then dw_caja_pago.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
if f_es_vacio(dw_caja_pago.getitemstring(1, 'banco')) then dw_caja_pago.SetItem(1,'banco',g_banco_por_defecto)

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
		dw_valores_genericos.SetItem(1,'total_pagar',cantidad_pagar)
		
/*
		DE MOMENTO EN ESTOS CASOS SIGUE USANDOSE LA VENTANA ANTIGUA
	CASE 'FACTURA_NUEVA'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_caja_pago.SetItem(1,'fecha_pago',i_parametros.fecha_pago)
		// Quitamos la posibilidad de colocar la fecha en el pago
		dw_caja_pago.object.fecha_pago.TabSequence = 0
		dw_caja_pago.object.fecha_pago.Background.Color = f_color_gris_claro()
	CASE 'COBROS_FACTURAS'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_originales_copias.visible = false
*/		
END CHOOSE

dw_originales_copias_obj_impr.insertrow(0)
i_impresion_formato = create n_csd_impresion_formato

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


/*
// ESTO ES COPIADO DE LA OTRA VENTANA
// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro mostramos el n$$HEX2$$ba002000$$ENDHEX$$de orig y copias de honos y gastos
string tipo_gestion
dw_2.Retrieve(i_id_minuta)
tipo_gestion = dw_2.getitemstring(1, 'tipo_gestion')
if tipo_gestion = 'C' then
	dw_3.insertrow(0)
	dw_3.visible = true
end if
*/

this.trigger event csd_configurar_ventana()

end event

event pfc_postopen();call super::pfc_postopen;// Colocamos los calendarios
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
FOR fila =1 to i_parametros.dw.RowCount()
	if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
		// Si hay alguno que es de tipo 'V' lo ponemos
		id_fase = i_parametros.dw.getitemstring(1, 'id_fase')
		SELECT fases.e_mail INTO :fase_visared FROM fases WHERE fases.id_fase = :id_fase   ;
		if fase_visared = 'V' then visared = 'V'
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

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja_pagos_multiples_old
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja_pagos_multiples_old
end type

type gb_pagador from groupbox within w_caja_pagos_multiples_old
boolean visible = false
integer x = 32
integer y = 224
integer width = 3333
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

type dw_caja_pago from u_dw within w_caja_pagos_multiples_old
integer x = 1047
integer y = 412
integer width = 1435
integer height = 868
integer taborder = 10
boolean bringtotop = true
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

type dw_minutas_detalle from u_dw within w_caja_pagos_multiples_old
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

type cb_aceptar from commandbutton within w_caja_pagos_multiples_old
event csd_avisos_multiple ( )
event csd_avisos_unico ( )
integer x = 1399
integer y = 1788
integer width = 343
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
double total_pagado, total_a_pagar, diferencia
long fila, indice_aviso, fila_cobros_factura 
string mensaje_avisos= '', mensaje_cobros ='', mensaje = ''
string id_cobro_multiple, id_minuta, forma_pago, banco, tipo_gestion, pagador, nombre_pagador, lista_n_expedi, n_expedi
string tipo_pago, forma_pago_cobro 
boolean b_error = false, b_HayIngreso
datetime fecha_pago

// Aceptamos lo ultimo indicado
dw_valores_genericos.trigger event pfc_accepttext(true)
dw_cobros_multiples.trigger event pfc_accepttext(true)
dw_relaciones_generadas.trigger event pfc_accepttext(true)

// Que indiquen al menos un cobro multiple
if dw_cobros_multiples.RowCount() = 0 then
	MessageBox(g_titulo, "Debe indicar al menos una l$$HEX1$$ed00$$ENDHEX$$nea en los cobros realizados", stopsign!)
	return
end if

// --> Que haya m$$HEX1$$e100$$ENDHEX$$s de un cobro multiple sino ni lo hacemos
if i_parametros.dw.RowCount() < 2 then
	MessageBox(g_titulo, "Para generar un cobro m$$HEX1$$fa00$$ENDHEX$$ltiple al menos debe indicar 2 o m$$HEX1$$e100$$ENDHEX$$s cobros o bien cobrar m$$HEX1$$e100$$ENDHEX$$s de un aviso", stopsign!)
	return
end if

// --> verificamos que los importes coincidan
total_pagado = round(dw_cobros_multiples.getitemNumber(1, 'total'),2)
total_a_pagar = round(dw_valores_genericos.getitemNumber(1, 'total_pagar'),2)
diferencia = total_a_pagar - total_pagado
if abs(diferencia)>=0.01 then
	MessageBox(g_titulo, "Los importes pagado y a pagar no coinciden (diferencia "+string(round(diferencia,2), "#,##0.00")+" )", stopsign!)
	return
end if

// --> Comprobamos que ha generado las relaciones
if dw_relaciones_generadas.RowCount()= 0 then
	Messagebox(g_titulo, "Debe pulsar el bot$$HEX1$$f300$$ENDHEX$$n de preparar las relaciones", stopsign!)
	return
end if

// --> Verificamos que todo aviso est$$HEX2$$e1002000$$ENDHEX$$casado con 1 solo cobro
FOR fila = 1 TO dw_relaciones_generadas.Rowcount()
	// simplemente es comprobar el computado si es distinto de 1
	if dw_relaciones_generadas.GetItemNumber(fila, 'marcas_por_aviso') <> 1 then
		mensaje_avisos += dw_relaciones_generadas.GetItemString(fila, 'n_aviso')+", "
	end if
NEXT
if LenA(mensaje_avisos) >0 then mensaje_avisos = LeftA(mensaje_avisos, LenA(mensaje_avisos)-2)
// --> y todo cobro tiene al menos un aviso (solo de los cobros multiples)
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	if dw_relaciones_generadas.GetItemNumber(1, 'marcas_cobro_multiple_'+string(fila)) = 0 then
		mensaje_cobros+= string(fila)+", "
	end if
NEXT
if LenA(mensaje_cobros) >0 then mensaje_cobros = LeftA(mensaje_cobros, LenA(mensaje_cobros)-2)

if not f_es_vacio(mensaje_avisos) or not f_es_vacio(mensaje_cobros) then
	mensaje = "Encontrado el/los siguiente/s problema/s"+cr
	if not f_es_vacio(mensaje_avisos) then mensaje += "Debe indicar un $$HEX1$$da00$$ENDHEX$$NICO cobro con el que casar los avisos "+cr+mensaje_avisos+cr
	if not f_es_vacio(mensaje_cobros) then mensaje += "No tienen avisos los cobros "+cr+mensaje_cobros+cr
	mensaje += "Solucione estos problemas para poder continuar "
	MessageBox(g_titulo, mensaje, stopsign!)
	return
end if

// --> VAlidamos los datos de cobros multiples
mensaje = ''
mensaje +=f_valida(dw_cobros_multiples, 'fecha', "NONULO", "Debe indicar la fecha de pago")
mensaje +=f_valida(dw_cobros_multiples, 'forma_pago', "NONULO", "Debe indicar la forma de pago para cada uno de los cobros m$$HEX1$$fa00$$ENDHEX$$ltiples")
mensaje +=f_valida(dw_cobros_multiples, 'banco', "NONULO", "Debe indicar el banco para cada uno de los cobros m$$HEX1$$fa00$$ENDHEX$$ltiples")
mensaje +=f_valida(dw_cobros_multiples, 'importe', "NOCERO", "Debe indicar un importe v$$HEX1$$e100$$ENDHEX$$lido para cada uno de los cobros m$$HEX1$$fa00$$ENDHEX$$ltiples")
if not f_es_vacio(mensaje) then
	MessageBox(g_titulo, mensaje, stopsign!)
	return
end if

// Verificamos la forma de pago
mensaje = ''
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	// Cogemos la forma de pago
	forma_pago = dw_cobros_multiples.GetitemString(fila, 'forma_pago')
	FOR indice_aviso =1 to dw_relaciones_generadas.RowCount()
		//Cogemos los par$$HEX1$$e100$$ENDHEX$$metros necesarios para realizar las validaciones
		if dw_relaciones_generadas.GetItemString(indice_aviso, 'relacionado_cobro_multiple'+string(fila)) = '1' then
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
		end if
	NEXT
NEXT
if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
End if				

// En el proceso se rellenar$$HEX2$$e1002000$$ENDHEX$$el nombre dle pagador
nombre_pagador = ''

// Cogemos el nombre de quien paga
nombre_pagador = dw_nombre_pagador.getItemString(1, 'nombre_pagador')
if f_es_vacio(nombre_pagador) then
	// Cogemos el nombre de quien paga
	nombre_pagador = dw_relaciones_generadas.getItemString(1, 'nombre_pagador')
end if

///////////////////////////////////////////////////////
// Generacion de todo lo necesario para los avisos
///////////////////////////////////////////////////////
// Colocamos el identificador del cobro multiple en cada uno de los cobros de las facturas
fecha_pago = dw_cobros_multiples.GetitemDateTime(1, 'fecha')
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	// Cogemos los datos que necesitamos del cobro multiple
	forma_pago = dw_cobros_multiples.GetitemString(fila, 'forma_pago')
	banco = dw_cobros_multiples.GetitemString(fila, 'banco')

	FOR indice_aviso = 1 TO dw_relaciones_generadas.RowCount()
		if dw_relaciones_generadas.GetItemString(indice_aviso, 'relacionado_cobro_multiple'+string(fila)) = '1' then
			id_minuta = dw_relaciones_generadas.GetItemString(indice_aviso, 'id_minuta')
			tipo_gestion = dw_relaciones_generadas.GetItemString(indice_aviso, 'tipo_gestion')
			// Retriveamos la minuta
			dw_minutas_detalle.retrieve(id_minuta)
			// Actualizamos los valores
			dw_minutas_detalle.SetItem(1,'fecha_pago',fecha_pago)
			dw_minutas_detalle.SetItem(1,'forma_pago','CM') // POR ORDEN DE PACO LA FORMA DE PAGO SER$$HEX2$$c1002000$$ENDHEX$$CM
			dw_minutas_detalle.SetItem(1,'banco',banco) // No se puede pasar blanco
			///////////////////////////////////////////////////////
			// Debemos generar la facturas asociadas a este aviso!
			///////////////////////////////////////////////////////
			wf_generar_facturas_y_liquidaciones(tipo_gestion, dw_valores_genericos)
			
			// Marcar la prenda como pagada
			if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
				f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
			end if
		end if
	NEXT
NEXT

// Ahora ponemos el id correspondiente en la tabla de cobros
if wf_consultar_cobros_avisos()<1 then
	// Error al recuperar los cobros
	Messagebox(g_titulo, "Ha ocurrido un error al procesar los cobros de las facturas. Consulte el estado de las mismas", stopsign!)
	b_error = true
	return
end if


// Colocamos el identificador del cobro multiple en cada uno de los cobros de las facturas
fecha_pago = dw_cobros_multiples.GetitemDateTime(1, 'fecha')
FOR fila = 1 TO dw_cobros_multiples.RowCount()
	// Colocamos el idfntificador
	lista_n_expedi= ''
	n_expedi = ''
	id_cobro_multiple = f_siguiente_numero('ID_COBRO_MULTIPLE',10)
	dw_cobros_multiples.setitem(fila, 'id_cobro_multiple', id_cobro_multiple)
	dw_cobros_multiples.setitem(fila, 'pagador', nombre_pagador)
	// Cogemos los datos que necesitamos del cobro multiple
	forma_pago = dw_cobros_multiples.GetitemString(fila, 'forma_pago')
	banco = dw_cobros_multiples.GetitemString(fila, 'banco')

	
	FOR indice_aviso = 1 TO dw_relaciones_generadas.RowCount()
		if dw_relaciones_generadas.GetItemString(indice_aviso, 'relacionado_cobro_multiple'+string(fila)) = '1' then
			id_minuta = dw_relaciones_generadas.GetItemString(indice_aviso, 'id_minuta')
			if n_expedi <> dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi') then
				if LenA(lista_n_expedi)>0 then lista_n_expedi += ', '
				lista_n_expedi += dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi')
				n_expedi = dw_relaciones_generadas.GetItemString(indice_aviso, 'n_expedi')
			end if
			// Retriveamos la minuta
			dw_minutas_detalle.retrieve(id_minuta)
			// Actualizamos los valores
			dw_minutas_detalle.SetItem(1,'fecha_pago',fecha_pago)
			
			dw_minutas_detalle.SetItem(1,'forma_pago','CM') // POR ORDEN DE PACO LA FORMA DE PAGO SER$$HEX2$$c1002000$$ENDHEX$$CM, simpre que no sea autoliquidacion
//				dw_minutas_detalle.SetItem(1,'banco',banco)
			// Filtramos los cobros para que salgan solo los de esa minuta
			dw_cobros.setfilter("id_fase = '"+ id_minuta + "'")
			dw_cobros.filter()
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
						dw_cobros.setitem(fila_cobros_factura , 'id_cobro_multiple', id_cobro_multiple)
						// Colocamos a pelo la forma de pago como CM
						dw_cobros.setitem(fila_cobros_factura , 'forma_pago', 'CM')
					end if
				END IF
			NEXT
			// Lanzamos el ultimo evento
			parent.trigger event csd_comprobar_todo_cobrado()
		end if
	NEXT
	// Colocamos el del ultimo expediente
	dw_cobros_multiples.setitem(fila, 'expediente', lista_n_expedi)
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
// Cerramos la ventana
closewithreturn(parent, i_parametros)
end event

event csd_avisos_unico();// Evento para el cobro unico


this.enabled = false
dw_caja_pago.accepttext()
string mensaje
string tipo_gestion, forma_pago, pagador
long fila
st_liquidacion datos_liquidacion

SetPointer(HourGlass!)
mensaje = mensaje + f_valida(dw_caja_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'banco','NONULO','Debe especificar el banco.')

// Modificado Ricardo 04-03-10
double cambio
cambio = dw_caja_pago.getitemNumber(dw_caja_pago.getrow(), 'cambio') 
if cambio<0 or isnull(cambio) then mensaje += "Debe indicar un importe suficientemente grande como para pagar la factura"
// FIN Modificado Ricardo 04-03-10


if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	this.enabled = true
	return
End if
forma_pago = dw_caja_pago.getitemstring(1, 'forma_pago')

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
					return
				End if				
				// ------------- Fin validaciones Forma de Pago
				dw_minutas_detalle.SetItem(1,'fecha_pago',dw_caja_pago.GetItemDateTime(1,'fecha_pago'))
				dw_minutas_detalle.SetItem(1,'forma_pago',dw_caja_pago.GetItemString(1,'forma_pago'))
				dw_minutas_detalle.SetItem(1,'banco',dw_caja_pago.GetItemString(1,'banco'))
				// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro separamos los originales y copias en las facturas de honos y gastos, porque se deben imprimir varias paginas
				string copias, origin
				if tipo_gestion = 'C' then
					copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				else
					copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				end if
				///////////////////////////////////////////////////////
				// Debemos generar la facturas asociadas a este aviso!
				///////////////////////////////////////////////////////
				wf_generar_facturas_y_liquidaciones(tipo_gestion, dw_valores_genericos)
				// Lanzamos el evento para ver si est$$HEX2$$e1002000$$ENDHEX$$todo cobrado
				parent.trigger event csd_comprobar_todo_cobrado()
				// Marcar la prenda como pagada
				if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
					f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
				end if
			end if
		NEXT
		
		/* ESTA COPIADO DE LA OTRA VENTANA PERO LA VERDAD ES QUE NO SE PARA QUE SE UTILIZABA
		// Movimiento funcionario para administraci$$HEX1$$f300$$ENDHEX$$n y no existen mas movimientos para este colegiado de este tipo
		if dw_minuta.getitemstring(1, 'tipo_minuta') = '14' then
			for i = 1 to idw_fases_src.rowcount()
				// Conque tenga un movimiento basta para no pasar el movimiento
				if idw_fases_src.getitemstring(i, 'id_col') = id_col then
					pasar_funcionario = false
					exit
				end if
			next
			if pasar_funcionario then
				// recuperar par$$HEX1$$e100$$ENDHEX$$metros de la base de datos
				datos_musaat.recuperar = true
				// Generar movimiento para MUSAAT
				datos_musaat.genera_movi = true
				datos_musaat.id_minuta = dw_minuta.getitemstring(1,'id_minuta')
				// NUEVO : tipo_csd
				datos_musaat.tipo_csd = dw_minuta.getitemstring(1,'tipo_minuta')
				datos_musaat.n_visado = dw_minuta.getitemstring(1, 'id_fase')
				datos_musaat.id_col = dw_minuta.getitemstring(1, 'id_colegiado')
				f_musaat_calcula_prima(datos_musaat)
			end if
		end if
		*/		
	CASE 'FACTURA_NUEVA'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')

	CASE 'COBROS_FACTURAS'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
END CHOOSE





// Cerramos esta ventana
i_parametros.realizado = true
i_parametros.unico_multiple = 'U' // Unico
closewithreturn(parent, i_parametros)


end event

event clicked;this.enabled = false
// Cosas a tener en cuenta:
double total_pagado,total_a_pagar,diferencia

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
END CHOOSE
end event

type cb_cancelar from commandbutton within w_caja_pagos_multiples_old
integer x = 1792
integer y = 1788
integer width = 343
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
i_parametros.realizado = false
closewithreturn(parent, i_parametros)
end event

type dw_cobros_multiples from u_dw within w_caja_pagos_multiples_old
boolean visible = false
integer x = 50
integer y = 488
integer width = 3291
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

event type long pfc_addrow();call super::pfc_addrow;// Solo puede ocurrir este caso

datetime fecha_pago
if AncestorReturnValue>0 then
	// Solo dejamos seguir si hay fecha de pago
	fecha_pago = dw_valores_genericos.getitemDatetime(1, 'fecha_pago')
	// Colocamos la fecha de pago
	this.setitem(AncestorReturnValue, 'fecha', fecha_pago)
end if
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
			Messagebox(g_titulo, "El importe abonado no puede superar el importa a pagar", stopsign!)
			return 2
		end if
			
		// Si tocan el importe a mano quitamos el check del resto
		if this.getitemString(row, 'resto') = 'S' then
			this.setitem(row, 'resto', 'N')
		end if
		if diferencia>=0.01 then
			// Colocamos una nueva linea
			this.trigger event pfc_addrow()
		end if
		
END CHOOSE
end event

event constructor;call super::constructor;// MODIFICADO POR RICARDO 04-03-01
// Omitimos la forma de pago de domiciliacion bancaria

datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
// Aplicamos el filtrado
dwc_forma_pago.setfilter("tipo_pago<>'DB'")
dwc_forma_pago.filter()
// FIN MODIFICADO POR RICARDO 04-03-01
end event

type cb_preparar from commandbutton within w_caja_pagos_multiples_old
boolean visible = false
integer x = 1531
integer y = 1076
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
double total_pagado, total_a_pagar


if dw_cobros_multiples.Rowcount() = 0 then
	MessageBox(g_titulo, "No existen l$$HEX1$$ed00$$ENDHEX$$neas de cobros m$$HEX1$$fa00$$ENDHEX$$ltiples")
	return
end if

// Hay que ver si el total coincide
total_pagado = dw_cobros_multiples.getitemNumber(1, 'total')
total_a_pagar = dw_valores_genericos.getitemNumber(1, 'total_pagar')

if round(total_pagado,2)<>round(total_a_pagar,2) then
	Messagebox(g_titulo, "El importe a pagar y el importe pagado no coinciden", stopsign!)
	return
end if



// Impedimos el redibujado
dw_relaciones_generadas.setredraw(false)
// Vaciamos todas las relaciones
dw_relaciones_generadas.reset()
// Ocultamos todas 
For fila = 1 TO il_max_cobros
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+"_t.visible = 0")
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+".visible = 0")
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+"_t.text = ''")
NEXT
// Para cada uno de los cobros multiples habilitamos una columna abajo
For fila = 1 to dw_cobros_multiples.RowCount()
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+"_t.visible = 1")
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+".visible = 1")
	dw_relaciones_generadas.modify("relacionado_cobro_multiple"+string(fila)+"_t.text = '"+string(fila)+"'")
	
	// Miramos que el importe no sea 0
	if round(dw_cobros_multiples.getitemNumber(fila,  'importe'),2) = 0 then
		MessageBox(g_titulo, "No pueden haber cobros con el importe a 0")
		// PErmitirmos el redibujado
		dw_relaciones_generadas.setredraw(true)
		return
	end if
NEXT

// Miramos cuandos cobros multiples han indicado
n_cobros_multiples = dw_cobros_multiples.RowCount()

// Hacemos un bucle para buscar los valores
FOR fila =1 to i_parametros.dw.RowCount()
	if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
		// Para cada uno de los procesados introducimos una linea en el de relaciones
		fila_insert = dw_relaciones_generadas.insertrow(0)
		// Colocamos el numero de aviso. Copiamos algunos datos que nos vendr$$HEX1$$e100$$ENDHEX$$n bien en el proceso final
		dw_relaciones_generadas.setitem(fila_insert, 'n_aviso', i_parametros.dw.GetitemString(fila, 'n_aviso'))
		dw_relaciones_generadas.setitem(fila_insert, 'id_minuta', i_parametros.dw.GetitemString(fila, 'id_minuta'))
		dw_relaciones_generadas.setitem(fila_insert, 'tipo_gestion', i_parametros.dw.GetitemString(fila, 'tipo_gestion'))
		dw_relaciones_generadas.setitem(fila_insert, 'pagador', i_parametros.dw.GetitemString(fila, 'pagador'))
		dw_relaciones_generadas.setitem(fila_insert, 'n_expedi', i_parametros.dw.GetitemString(fila, 'n_expedi'))
		dw_relaciones_generadas.setitem(fila_insert, 'nombre_pagador', i_parametros.dw.GetitemString(fila, 'nombre_pagador'))
		// Si solo hay un cobro multiple, lo marcamos por defecto
		if n_cobros_multiples = 1 then dw_relaciones_generadas.setitem(fila_insert, 'relacionado_cobro_multiple1', '1')
	end if
NEXT

// PErmitirmos el redibujado
dw_relaciones_generadas.setredraw(true)
end event

type dw_valores_genericos from u_dw within w_caja_pagos_multiples_old
boolean visible = false
integer x = 896
integer y = 40
integer width = 1257
integer height = 176
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

type gb_cabecera from groupbox within w_caja_pagos_multiples_old
boolean visible = false
integer x = 882
integer y = 8
integer width = 2478
integer height = 216
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

type dw_relaciones_generadas from u_dw within w_caja_pagos_multiples_old
boolean visible = false
integer x = 50
integer y = 1208
integer width = 3291
integer height = 544
integer taborder = 11
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

type gb_relacion from groupbox within w_caja_pagos_multiples_old
boolean visible = false
integer x = 32
integer y = 1160
integer width = 3333
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

type dw_cobros from u_dw within w_caja_pagos_multiples_old
boolean visible = false
integer x = 50
integer y = 1208
integer width = 3291
integer height = 544
integer taborder = 11
string dataobject = "d_caja_cobro_multiple_cobros"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type gb_cobros_multiples from groupbox within w_caja_pagos_multiples_old
boolean visible = false
integer x = 32
integer y = 436
integer width = 3333
integer height = 628
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

type gb_pago_unico from groupbox within w_caja_pagos_multiples_old
integer x = 942
integer y = 380
integer width = 1577
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

type dw_visualizar_avisos from u_dw within w_caja_pagos_multiples_old
boolean visible = false
integer x = 32
integer y = 488
integer width = 3333
integer height = 268
integer taborder = 11
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_nombre_pagador from u_dw within w_caja_pagos_multiples_old
integer x = 50
integer y = 288
integer width = 3291
integer height = 76
integer taborder = 11
boolean bringtotop = true
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

type dw_1 from u_dw within w_caja_pagos_multiples_old
integer x = 27
integer y = 8
integer width = 855
integer height = 248
integer taborder = 10
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

type dw_originales_copias_obj_impr from u_dw within w_caja_pagos_multiples_old
event csd_opciones_impresion ( )
integer x = 942
integer y = 1304
integer width = 1577
integer height = 436
integer taborder = 60
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

