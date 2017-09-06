HA$PBExportHeader$w_contratos_regularizacion.srw
forward
global type w_contratos_regularizacion from w_response
end type
type dw_pem_superficie from u_dw within w_contratos_regularizacion
end type
type cb_1 from commandbutton within w_contratos_regularizacion
end type
type cb_2 from commandbutton within w_contratos_regularizacion
end type
type dw_colegiados from u_dw within w_contratos_regularizacion
end type
type cb_aumentar from commandbutton within w_contratos_regularizacion
end type
type cb_disminuir from commandbutton within w_contratos_regularizacion
end type
type sle_imprimir_copias from singlelineedit within w_contratos_regularizacion
end type
type st_3 from statictext within w_contratos_regularizacion
end type
type st_2 from statictext within w_contratos_regularizacion
end type
type sle_imprimir_originales from singlelineedit within w_contratos_regularizacion
end type
type cb_disminuir_copias from commandbutton within w_contratos_regularizacion
end type
type cb_aumentar_copias from commandbutton within w_contratos_regularizacion
end type
type dw_pago from u_dw within w_contratos_regularizacion
end type
type st_1 from statictext within w_contratos_regularizacion
end type
type dw_3 from u_dw within w_contratos_regularizacion
end type
type st_proceso from statictext within w_contratos_regularizacion
end type
type dw_cip_musaat from u_dw within w_contratos_regularizacion
end type
type cbx_1 from checkbox within w_contratos_regularizacion
end type
type cb_3 from commandbutton within w_contratos_regularizacion
end type
type dw_originales_copias from u_dw within w_contratos_regularizacion
end type
type dw_1 from u_dw within w_contratos_regularizacion
end type
type dw_contrato_seleccionar from u_dw within w_contratos_regularizacion
end type
type dw_fases_informes from u_dw within w_contratos_regularizacion
end type
type cb_4 from commandbutton within w_contratos_regularizacion
end type
type dw_agrupar_act from u_dw within w_contratos_regularizacion
end type
type cbx_avisos_pendientes from checkbox within w_contratos_regularizacion
end type
end forward

global type w_contratos_regularizacion from w_response
integer width = 2560
integer height = 2072
string title = "Regularizaci$$HEX1$$f300$$ENDHEX$$n"
boolean controlmenu = false
event csd_regularizar ( )
event csd_actualizar_pem_sup ( )
event csd_calcular_descuentos ( )
dw_pem_superficie dw_pem_superficie
cb_1 cb_1
cb_2 cb_2
dw_colegiados dw_colegiados
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
sle_imprimir_copias sle_imprimir_copias
st_3 st_3
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_disminuir_copias cb_disminuir_copias
cb_aumentar_copias cb_aumentar_copias
dw_pago dw_pago
st_1 st_1
dw_3 dw_3
st_proceso st_proceso
dw_cip_musaat dw_cip_musaat
cbx_1 cbx_1
cb_3 cb_3
dw_originales_copias dw_originales_copias
dw_1 dw_1
dw_contrato_seleccionar dw_contrato_seleccionar
dw_fases_informes dw_fases_informes
cb_4 cb_4
dw_agrupar_act dw_agrupar_act
cbx_avisos_pendientes cbx_avisos_pendientes
end type
global w_contratos_regularizacion w_contratos_regularizacion

type variables
datawindowchild i_dwc_colegiados
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_descuentos, idw_fases_cip_tfe
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica, idw_historico
string i_id_col, reg
string is_tipo_gestion
datastore ids_honos
long i_notas, i_pem_sup, i_proceso
end variables

event csd_regularizar();string mensaje, id_cliente_mayor_porc, sn_cip, sn_musaat, sn_dv, id_minuta, forma_pago_liq,tipo_minuta
double musaat = 0, cip = 0, i, porc_cli_mayor = 0, dv = 0, honorarios = 0, desplaza = 0, importe_liquidacion
double pem_certif, pem_vieja, pem_nueva, fila, porc_cip=0, pem_nueva_seg, pem_vieja_seg
boolean factura = false
// Variables para el numero de copias
string origin, copias

setpointer(hourglass!)

// Comprobar si est$$HEX2$$e1002000$$ENDHEX$$marcado el check de cobrar
if cbx_1.checked then factura = true 

dw_cip_musaat.accepttext()

// Si los valores son 0 o no hay ning$$HEX1$$fa00$$ENDHEX$$n check marcado no se hace nada
sn_cip = dw_cip_musaat.getitemstring(1, 'restar_cip')
sn_musaat = dw_cip_musaat.getitemstring(1, 'restar_musaat')
sn_dv = dw_cip_musaat.getitemstring(1, 'restar_dv')
musaat = dw_cip_musaat.getitemnumber(1, 'musaat')
cip = dw_cip_musaat.getitemnumber(1, 'cip')
dv = dw_cip_musaat.getitemnumber(1, 'dv')
honorarios = dw_cip_musaat.getitemnumber(1, 'honorarios') // Modificado Ricardo 03/10/01
desplaza = dw_cip_musaat.getitemnumber(1, 'desplaza') // Modificado Ricardo 03/12/02
porc_cip =dw_cip_musaat.getitemnumber(1, 'cip_porc_d')
// Modificado Ricardo 2005-06-15
// incic. 0000002726
tipo_minuta = dw_pem_superficie.getitemString(1, 'tipo_minuta') 
if g_colegio = 'COAATZ' then
	pem_certif = dw_pem_superficie.getitemNumber(1, 'pem_certificacion') 
	if tipo_minuta = 'F' then
		// Ponemos el pem final
		pem_certif = dw_pem_superficie.getitemNumber(1, 'pem2')
		if isnull(pem_certif) then pem_certif = dw_pem_superficie.getitemNumber(1, 'pem1')
	end if
end if
// FIN Modificado Ricardo 2005-06-15

// Si no est$$HEX1$$e100$$ENDHEX$$n los checks marcados pasamos del valor que tengan
if sn_cip= 'N' then cip =0
if sn_musaat= 'N' then musaat =0
if sn_dv= 'N' then dv =0

musaat = f_redondea(musaat)
cip = f_redondea(cip)
dv = f_redondea(dv)
honorarios = f_redondea(honorarios) // Modificado Ricardo 03/10/01
desplaza = f_redondea(desplaza) // Modificado Ricardo 03/12/02
if isnull(musaat) then musaat = 0
if isnull(cip) then cip = 0
if isnull(dv) then dv = 0
if isnull(honorarios) then honorarios = 0 // Modificado Ricardo 03/10/01
if isnull(desplaza) then desplaza = 0 // Modificado Ricardo 03/12/02
if (cip = 0 and musaat = 0 and dv = 0 and honorarios = 0) or (sn_cip = 'N' and sn_musaat = 'N' and sn_dv = 'N') then 
	event csd_actualizar_pem_sup ()
	return 
end if

st_proceso.text = 'Validando entrada ...'
mensaje = mensaje + f_valida(dw_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_pago,'banco','NONULO','Debe especificar el banco.')
mensaje = mensaje + f_valida(dw_pago,'asunto','NONULO','Debe especificar el concepto.')
// MODIFICADO RICARDO 04-06-17
if factura then
	// MODIFICADO RICARDO 03-12-02
	if honorarios <> 0 or desplaza<>0 then
		mensaje = mensaje + f_valida(dw_pago,'forma_pago_liq','NONULO','Debe especificar el concepto.')
		
		// IMPORTE LIQUIDACION = HONORARIOS - GASTOS
		importe_liquidacion = f_calcula_valor_liquidacion(cip, musaat,dv,honorarios,desplaza, is_tipo_gestion)
		
		forma_pago_liq = dw_pago.getitemstring(dw_pago.getrow(), 'forma_pago_liq')
		if f_Es_vacio(forma_pago_liq) then
			mensaje += "Debe especificar la forma de pago de la liquidaci$$HEX1$$f300$$ENDHEX$$n."
		else
			CHOOSE CASE importe_liquidacion
				CASE is >0
					// Liquidacion positiva
					// La forma de pago solo puede ser trasferencia o talon
					if g_formas_pago.transferencia <> forma_pago_liq and g_formas_pago.talon <> forma_pago_liq then
						mensaje += "Una liquidaci$$HEX1$$f300$$ENDHEX$$n positiva s$$HEX1$$f300$$ENDHEX$$lo puede ser con trasferencia o tal$$HEX1$$f300$$ENDHEX$$n." 
					end if
				CASE is <0
					// Liquidacion negativa
					// La forma de pago no puede ser trasferencia o talon
					if g_formas_pago.transferencia = forma_pago_liq or g_formas_pago.talon = forma_pago_liq then
						mensaje += "Una liquidaci$$HEX1$$f300$$ENDHEX$$n negativa s$$HEX1$$f300$$ENDHEX$$lo puede ser ni por trasferencia ni por tal$$HEX1$$f300$$ENDHEX$$n." 
					end if
			END CHOOSE
		end if
	end if	
end if
if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	return
end if

// Coger el promotor de mayor %
for i = 1 to idw_clientes.rowcount()
	if idw_clientes.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cliente_mayor_porc = idw_clientes.getitemstring(i, 'id_cliente')
	end if
next

// Modificado Ricardo 03/10/02
// Cogemos el numero de copias a imprimir
if cbx_1.checked  then 
	if honorarios = 0 and desplaza = 0 then
		copias =  dw_originales_copias.getitemstring(1, 'n_cop_gas')
		origin =  dw_originales_copias.getitemstring(1, 'n_orig_gas')
	else
		copias = dw_originales_copias.getitemstring(1, 'n_cop_hon') + dw_originales_copias.getitemstring(1, 'n_cop_gas')
		origin = dw_originales_copias.getitemstring(1, 'n_orig_hon') + dw_originales_copias.getitemstring(1, 'n_orig_gas')
	end if
else
	// Si no se va a generar facturas ponemos que es un 0 para que no pete
	copias = '00'
	origin = '00'
end if

//Cambio Luis
if(i_pem_sup = 0)then
	event csd_actualizar_pem_sup ()
	i_pem_sup = 1
end if

// Modificado Ricardo 03/10/02
if honorarios = 0 and desplaza = 0 then
	//Cambio Luis
	if((cip<>0 or musaat<>0 or dv<>0) and (g_colegio = 'COAATMCA'))then
			// Pasamos los datos a la estructura
			st_cobrar_gastos_contrato st_datos
			st_datos.st_proceso = st_proceso
			st_datos.dw_pago = dw_pago
			st_datos.i_id_col = i_id_col
			st_datos.cip = cip
			st_datos.musaat = musaat
			st_datos.dv = dv
			//st_datos.libros = libro
			st_datos.dw_3 = dw_3
			st_datos.impr_copias = Integer(origin)
			st_datos.impr_orig =  Integer(copias)
			st_datos.facturar = factura
			st_datos.honorarios = i_w.dw_1.getitemnumber(1, 'honorarios')
			st_datos.clientes = i_w.idw_fases_promotores
			//st_datos.porc_col = porc_col_real
			st_datos.paga_gastos =  i_w.dw_1.getitemstring(1, 'paga_gastos_cliente')
			st_datos.n_contrato_ant =  i_w.dw_1.getitemstring(1, 'n_contrato_ant')
			st_datos.id_cliente = id_cliente_mayor_porc
			st_datos.tipo_minuta = '20'
			st_datos.porc_cip =  porc_cip
			
			f_cobrar_gastos_contrato_mca(st_datos)
	else
		tipo_minuta = '20'
		// Si los conceptos no son todos positivos o negativos se generan minutas por separado
		if (cip>=0 and musaat>=0 and dv>=0) or (cip<=0 and musaat<=0 and dv<=0) then
			id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, cip, musaat, dv, &
				dw_3, factura, integer(origin), integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif, porc_cip)
		else // 3 casos
			if (cip>=0 and musaat>=0 and dv<0) or (cip<0 and musaat<0 and dv>=0) then
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, cip, musaat, 0, &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, 0, 0, dv,  &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
			end if
			if (cip>=0 and musaat<0 and dv<0) or (cip<0 and musaat>=0 and dv>=0) then
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, cip, 0, 0, &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, 0, musaat, dv, &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
			end if
			if (cip>=0 and musaat<0 and dv>=0) or (cip<0 and musaat>=0 and dv<0) then
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, 0, musaat, 0,  &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
				id_minuta = f_regularizacion_genera_minuta (st_proceso, dw_pago, i_id_col, cip, 0, dv,  &
					dw_3, factura, Integer(origin), Integer(copias),id_cliente_mayor_porc, tipo_minuta, pem_certif,  porc_cip)
			end if
		end if		
	end if
else
	// POR ORDEN DE PACO. 
	// EN ESTE TIPO DE GESTION NO SE SEPARAN ENTRE CONCEPTOS NEGATIVOS NI POSITIVOS
	// El caso normal es que todos sean positivos o todos negativos
	id_minuta = f_regul_genera_minuta_honorario (st_proceso, dw_pago, i_id_col, cip, musaat, dv, honorarios, desplaza, &
		dw_3, factura, integer(origin), integer(copias),id_cliente_mayor_porc, is_tipo_gestion, tipo_minuta, pem_certif)
end if

// Modificado Ricardo 04-06-17
if factura then
	// DAVID - 04/01/2005
	// Ahora vamos a generar liquidaciones cuando salga a devolver la regularizaci$$HEX1$$f300$$ENDHEX$$n
	if importe_liquidacion <> 0 or (cip + dv + musaat < 0) then
		//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
		st_liquidacion st_liquidacion
		st_liquidacion.id_fase		= id_minuta
		st_liquidacion.id_col		= i_id_col
		st_liquidacion.concepto 	= 'Regularizaci$$HEX1$$f300$$ENDHEX$$n '
		if importe_liquidacion <> 0 then
			st_liquidacion.importe	= abs(importe_liquidacion)
		else
			st_liquidacion.importe	= f_minutas_total_aviso(id_minuta) * (-1)
		end if
		st_liquidacion.forma_pago	= dw_pago.getitemstring(1,'forma_pago_liq')
		st_liquidacion.banco			= dw_pago.getitemstring(1,'banco')
		st_liquidacion.f_entrada 	= dw_pago.getitemDatetime(1,'fecha_pago')
		st_liquidacion.tipo			= '2' // Nuevo tipo			
		
		// Modificado Ricardo 2005-03-21
		// Miramos si es positiva o negativa para saber el tipo de liquidacion
		if importe_liquidacion > 0 or (cip + dv + musaat < 0) then
			// Si es positiva hacemos cosas
			st_liquidacion.contabilizada = 'N'
		else 
			// Si es negativo es una devolucion
			st_liquidacion.contabilizada = 'S'
		end if
		f_liquidacion(st_liquidacion)
	end if
end if

//Cambio Luis COAM-124
if(g_colegio = 'COAATMCA')then
	pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
	pem_vieja = dw_pem_superficie.getitemnumber(1, 'pem1')
	pem_nueva_seg = dw_pem_superficie.getitemnumber(1, 'pem_seg2')
	pem_vieja_seg = dw_pem_superficie.getitemnumber(1, 'pem_seg1')

	if( i_notas = 0 )then
		if(pem_nueva <> pem_vieja) or (pem_nueva_seg <> pem_vieja_seg) then
			fila = i_w.idw_fases_incidencias.insertrow(0)
			i_w.idw_fases_incidencias.setitem(fila,'id_incidencias',f_siguiente_numero('INCIDENCIAS-EXP', 10))
			i_w.idw_fases_incidencias.setitem(fila,'id_fase',i_w.dw_1.getitemstring(1,"id_fase"))
			i_w.idw_fases_incidencias.setitem(fila,'fecha',today())
			i_w.idw_fases_incidencias.setitem(fila,'observaciones','El presupuesto anterior era de: '+string(pem_vieja))
			i_w.idw_fases_incidencias.setitem(fila,'codigo','2')
			i_w.idw_fases_incidencias.setitem(fila,'usuario',g_usuario)
			i_notas = 1 
		end if
	end if
end if
//fin cambio

//Cambio Luis
//i_proceso ++
//if(i_proceso = 2)then
	st_proceso.text = 'Proceso Finalizado ...'
	messagebox(g_titulo, 'Proceso Finalizado')
//end if
//event csd_actualizar_pem_sup ()

// Actualizamos los tabs de la ventana de fases
if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if

//close(this)

end event

event csd_actualizar_pem_sup();// Si no hay valores no se hace nada
double pem, sup, sup_ant, pem_ant, pem_seg, pem_seg_ant
pem = dw_pem_superficie.getitemnumber(1, 'pem2')
pem_seg = dw_pem_superficie.getitemnumber(1, 'pem_seg2')
sup = dw_pem_superficie.getitemnumber(1, 'sup2')
if isnull(pem) then pem = 0
if isnull(sup) then sup = 0
if pem = 0 and sup = 0 then 
	return 
end if

sup_ant = dw_pem_superficie.getitemnumber(1, 'sup1')
if sup <> sup_ant then 
	openwithparm(w_superficie, dw_pem_superficie.getitemnumber(1, 'sup2'))
	// Anotamos los cambios en el historico de contratos	
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_viv, string(idw_estadistica.getitemnumber(1,'sup_viv')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_garage, string(idw_estadistica.getitemnumber(1,'sup_garage')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_otros, string(idw_estadistica.getitemnumber(1,'sup_otros')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_sob, string(idw_estadistica.getitemnumber(1,'sup_sob')))
	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_baj, string(idw_estadistica.getitemnumber(1,'sup_baj')))	
	// Se actualizan los datos en el tab de estadisticas
	idw_estadistica.setitem(1, 'sup_viv', g_st_datos_superficie.sup_viv)
	idw_estadistica.setitem(1, 'sup_garage', g_st_datos_superficie.sup_gar)
	idw_estadistica.setitem(1, 'sup_otros', g_st_datos_superficie.sup_otros)
	idw_estadistica.setitem(1, 'sup_sob', g_st_datos_superficie.sup_sob)
	idw_estadistica.setitem(1, 'sup_baj', g_st_datos_superficie.sup_baj)	
	// Anotamos los cambios en el historico de contratos
//	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_viv, string(g_st_datos_superficie.sup_viv))
//	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_garage, string(g_st_datos_superficie.sup_gar))
//	idw_estadistica.event itemchanged(1, idw_estadistica.object.sup_otros, string(g_st_datos_superficie.sup_otros))
end if

// Anotamos los cambios en el historico de contratos
//idw_estadistica.event itemchanged(1, idw_estadistica.object.pem, string(pem))
pem_ant = dw_pem_superficie.getitemnumber(1, 'pem1')
if g_aplica_pem_seg = 'S' then
	pem_seg_ant = dw_pem_superficie.getitemnumber(1, 'pem_seg1')
	if pem_seg <> pem_seg_ant then idw_estadistica.event itemchanged(1, idw_estadistica.object.pres_seguridad, string(idw_estadistica.getitemnumber(1,'pres_seguridad')))
end if
if pem <> pem_ant then idw_estadistica.event itemchanged(1, idw_estadistica.object.pem, string(idw_estadistica.getitemnumber(1,'pem')))

// Se actualizan los datos en el tab de estadisticas
idw_estadistica.setitem(1, 'pem', pem)
if g_aplica_pem_seg = 'S' then idw_estadistica.setitem(1, 'pres_seguridad', pem_seg)
idw_estadistica.setitem(1, 'superficie', sup)
idw_estadistica.update()
idw_estadistica.retrieve(g_id_fase)

// Se actualizan los datos en el tab de descuentos
event csd_calcular_descuentos()
idw_descuentos.update()
idw_descuentos.retrieve(g_id_fase)

// Se actualizan los datos en el historico
idw_historico.update()

// Se actualizan los datos del tab de honos teoricos
if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio =  'COAATTER'  then idw_fases_cip_tfe.update()

//close(this)

end event

event csd_calcular_descuentos();string ctrl_calidad_interno, fase, id_col
long fila_insertada, fila_dv, fila_musaat, fila_cip
double cip_incrementar, dv_incrementar, porc_col=0, porc_col_real=0, suma_porc=0, cip=0, dv=0, musaat=0, i, j
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
st_musaat_datos st_musaat_datos
st_dv_datos st_dv_datos


// CIP
//st_cip_datos.id_fase = dw_1.getitemstring(1, 'id_fase')
st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
st_cip_datos.pem = dw_pem_superficie.getitemnumber(1, 'pem2')
st_cip_datos.t_terreno = idw_estadistica.GetItemString(1,'t_terreno')
st_cip_datos.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.volumen = idw_estadistica.GetItemNumber(1,'volumen')
st_cip_datos.altura = idw_estadistica.GetItemNumber(1,'altura')
st_cip_datos.colindantes = idw_estadistica.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = idw_1.GetItemString(1,'tipo_gestion')
st_cip_datos.pem_seg = dw_pem_superficie.getitemnumber(1, 'pem_seg2')
if g_colegio = 'COAATLR' then 
	st_cip_datos.fecha = DateTime(Today(),Now())
else
	st_cip_datos.fecha = idw_1.GetItemdatetime(1,'f_entrada')
end if
st_cip_datos.long_per = idw_estadistica.getitemnumber(1, 'longitud_per')	
st_cip_datos.vol_tierras = idw_estadistica.getitemnumber(1, 'volumen_tierras')	
st_cip_datos.valor_terreno = idw_estadistica.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion = idw_estadistica.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = idw_estadistica.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura = idw_estadistica.GetItemString(1,'estructura')
st_cip_datos.t_medicion = idw_estadistica.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin = idw_estadistica.GetItemString(1,'replan_deslin')
st_cip_datos.visared = idw_1.GetItemString(1,'e_mail') // modificado Ricardo 2004-12-30
st_cip_datos.vol_edif = idw_estadistica.GetItemnumber(1,'volumen')
st_cip_datos.tipo_registro = idw_1.GetItemString(1,'tipo_registro')
st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
st_cip_datos.id_expedi = idw_fases_datos_exp.getitemstring(1, 'id_expedi')

// Para Cuenca y Zaragoza pasamos los datos de los honos minimos a la funci$$HEX1$$f300$$ENDHEX$$n de cip
if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio =  'COAATTER'  then
	st_cip_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')	
	st_cip_datos.hon_teor =  idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')	
end if

// el 100%
st_cip_datos.porcentaje = 100 

// En algunos colegios se calcula en la ventana de honorarios
if g_colegio = 'COAATGU' then
	st_cip_datos.cip = idw_fases_cip_tfe.getitemnumber(1, 'importe_cip')
else
	f_calcular_cip(st_cip_datos)
end if
cip = st_cip_datos.cip
if isnull(cip) then cip = 0

// MODIFICADO RICARDO 04-10-27
// Solo para el colegio de la rioja
fase = i_w.dw_1.getitemString(1, 'fase')
ctrl_calidad_interno = i_w.idw_fases_estadistica.GetItemString(1,'ctrl_calidad_interno')
if f_es_vacio(ctrl_calidad_interno) then ctrl_calidad_interno = 'N'
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if not f_puede_llevar_control_calidad(fase) = 'S' then
			ctrl_calidad_interno = 'N'
		end if
	CASE ELSE
		// Para todos los dem$$HEX1$$e100$$ENDHEX$$s lo ocultamos siempre
		ctrl_calidad_interno = 'N'
END CHOOSE
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
			st_cip_datos.tipo_act = g_codigo_tipo_actuacion_control_calidad
			f_calcular_cip(st_cip_datos)
			cip_incrementar = st_cip_datos.cip
			if isnull(cip_incrementar) then cip_incrementar = 0
			cip += cip_incrementar
		end if
END CHOOSE
// FIN MODIFICADO RICARDO 04-10-27

// Actualizamos descuento en contratos si corresponde
if cip > 0 /*and dw_cip_musaat.getitemstring(1, 'restar_cip') = 'S'*/ then //CRI-82
	fila_cip = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,idw_descuentos.RowCount())
	if fila_cip > 0 Then
		fila_insertada = fila_cip
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if
	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', cip )
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva ))
	end if
end if

// MUSAAT
// Suma de la Musaat de todos los colegiado
// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
st_musaat_datos.pem = dw_pem_superficie.getitemnumber(1, 'pem2')
st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
st_musaat_datos.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')
st_musaat_datos.volumen = idw_estadistica.getitemnumber(1, 'volumen')
// Suma de los % de los colegiados
for j = 1 to idw_colegiados.rowcount()
	suma_porc +=  idw_colegiados.getitemnumber(j, 'porcen_a')	
next
for i = 1 to idw_colegiados.rowcount()
	porc_col =  idw_colegiados.getitemnumber(i, 'porcen_a')	
	if isnull(suma_porc) or suma_porc = 0 then exit
	porc_col_real = porc_col / suma_porc * 100	
	st_musaat_datos.porcentaje = porc_col_real
	id_col = idw_colegiados.getitemstring(i, 'id_col')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.cobertura = 0

	if f_colegiado_tipopersona(id_col) = 'S' then	
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		musaat += st_musaat_datos.prima_comp	
	else
		f_musaat_calcula_prima(st_musaat_datos)	
		musaat += st_musaat_datos.prima_comp
	end if
next
if isnull(musaat) then musaat = 0

// Actualizamos descuento en contratos si corresponde
if musaat > 0 /*and dw_cip_musaat.getitemstring(1, 'restar_musaat') = 'S'*/ then //CRI-82
	fila_musaat = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,idw_descuentos.RowCount())
	if fila_musaat > 0 Then
		fila_insertada = fila_musaat
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if
	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', musaat )
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
	end if
end if

//DV
st_dv_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
st_dv_datos.tipoact = idw_1.getitemstring(1, 'fase')
st_dv_datos.tipoobra = idw_1.getitemstring(1, 'tipo_trabajo')
st_dv_datos.pem = dw_pem_superficie.getitemnumber(1, 'pem2')
st_dv_datos.administracion = ( idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S')
st_dv_datos.porcentaje = 100 // Todos los DV
st_dv_datos.id_expediente = idw_1.getitemstring(1, 'id_expedi')

if g_colegio = 'COAATLR' then 
	st_dv_datos.fecha = DateTime(Today(),Now())
else
	st_dv_datos.fecha = idw_1.GetItemdatetime(1,'f_entrada')
end if

st_dv_datos.superficie = dw_pem_superficie.getitemnumber(1, 'sup2')

if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio =  'COAATTER'  then 
	st_dv_datos.hon_teor = idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')
end if

if g_colegio = 'COAATGU' then
	st_dv_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
	st_dv_datos.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
end if

f_calcular_dv(st_dv_datos)
dv = st_dv_datos.dv
if isnull(dv) then dv = 0

// MODIFICADO RICARDO 04-10-27
// Solo para el colegio de la rioja
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
		st_dv_datos.tipoact = g_codigo_tipo_actuacion_control_calidad
		f_calcular_dv(st_dv_datos)
		dv_incrementar = st_dv_datos.dv
		if isnull(dv_incrementar) then dv_incrementar = 0
			dv += dv_incrementar
		end if
END CHOOSE
// FIN MODIFICADO RICARDO 04-10-27

// Actualizamos descuento en contratos si corresponde
if dv > 0 /*and dw_cip_musaat.getitemstring(1, 'restar_dv') = 'S'*/ then //CRI-82
	fila_dv = idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.dv + "'",0,idw_descuentos.RowCount())
	if fila_dv > 0 Then
		fila_insertada = fila_dv
	Else
		fila_insertada = idw_descuentos.dynamic event pfc_addrow()
	End if
	if fila_insertada > 0 then
		idw_descuentos.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.dv)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.dv
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		idw_descuentos.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
		idw_descuentos.setitem(fila_insertada, 'cuantia_colegiado', dv )
		idw_descuentos.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(dv, st_csi_articulos_servicios.t_iva ))
	end if
end if

end event

on w_contratos_regularizacion.create
int iCurrent
call super::create
this.dw_pem_superficie=create dw_pem_superficie
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_colegiados=create dw_colegiados
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.sle_imprimir_copias=create sle_imprimir_copias
this.st_3=create st_3
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_disminuir_copias=create cb_disminuir_copias
this.cb_aumentar_copias=create cb_aumentar_copias
this.dw_pago=create dw_pago
this.st_1=create st_1
this.dw_3=create dw_3
this.st_proceso=create st_proceso
this.dw_cip_musaat=create dw_cip_musaat
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.dw_originales_copias=create dw_originales_copias
this.dw_1=create dw_1
this.dw_contrato_seleccionar=create dw_contrato_seleccionar
this.dw_fases_informes=create dw_fases_informes
this.cb_4=create cb_4
this.dw_agrupar_act=create dw_agrupar_act
this.cbx_avisos_pendientes=create cbx_avisos_pendientes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pem_superficie
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_colegiados
this.Control[iCurrent+5]=this.cb_aumentar
this.Control[iCurrent+6]=this.cb_disminuir
this.Control[iCurrent+7]=this.sle_imprimir_copias
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.sle_imprimir_originales
this.Control[iCurrent+11]=this.cb_disminuir_copias
this.Control[iCurrent+12]=this.cb_aumentar_copias
this.Control[iCurrent+13]=this.dw_pago
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.st_proceso
this.Control[iCurrent+17]=this.dw_cip_musaat
this.Control[iCurrent+18]=this.cbx_1
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.dw_originales_copias
this.Control[iCurrent+21]=this.dw_1
this.Control[iCurrent+22]=this.dw_contrato_seleccionar
this.Control[iCurrent+23]=this.dw_fases_informes
this.Control[iCurrent+24]=this.cb_4
this.Control[iCurrent+25]=this.dw_agrupar_act
this.Control[iCurrent+26]=this.cbx_avisos_pendientes
end on

on w_contratos_regularizacion.destroy
call super::destroy
destroy(this.dw_pem_superficie)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_colegiados)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.sle_imprimir_copias)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_disminuir_copias)
destroy(this.cb_aumentar_copias)
destroy(this.dw_pago)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.st_proceso)
destroy(this.dw_cip_musaat)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.dw_originales_copias)
destroy(this.dw_1)
destroy(this.dw_contrato_seleccionar)
destroy(this.dw_fases_informes)
destroy(this.cb_4)
destroy(this.dw_agrupar_act)
destroy(this.cbx_avisos_pendientes)
end on

event open;call super::open;f_centrar_ventana(this)

dw_colegiados.retrieve(g_id_fase)
dw_colegiados.selectrow(1, true)
dw_pem_superficie.insertrow(0)
dw_cip_musaat.insertrow(0)
dw_pago.insertrow(0)
dw_1.insertrow(0)
dw_agrupar_act.insertrow(0)

i_w = g_detalle_fases
idw_clientes = i_w.idw_fases_promotores
idw_colegiados = i_w.idw_fases_colegiados
idw_descuentos = i_w.idw_fases_informes
idw_fases_datos_exp = i_w.dw_fases_datos_exp
idw_fases_src = i_w.idw_fases_src
idw_estadistica = i_w.idw_fases_estadistica
idw_historico = i_w.idw_fases_modificacion_datos
idw_1 = i_w.dw_1
idw_fases_cip_tfe = i_w.idw_fases_cip_tfe

if g_aplica_pem_seg = 'S' then
	dw_pem_superficie.dataobject = 'd_datos_pem_superficie_seg'
	dw_pem_superficie.settransobject(sqlca)
	dw_pem_superficie.insertrow(0)
end if

int i
//for i=1 to dw_colegiados.rowcount()
//	if dw_colegiados.getitemstring(i,'id_col') = g_colegiado_comodin then dw_colegiados.setitem(i, 'proc', 'N')
//next

dw_pago.SetItem(1,'fecha_pago',DateTime(Today(),Now()))
dw_pago.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
dw_pago.SetItem(1,'banco',g_banco_por_defecto)

dw_pago.SetItem(1,'asunto','DEVOLUCION Reg. ' + idw_1.getitemstring(1, 'n_registro') + ' EXP. ' + idw_1.getitemstring(1, 'n_EXPEDI'))

if i_w.idw_fases_estadistica.rowcount() > 0 then
	dw_pem_superficie.setitem(1, 'pem1', i_w.idw_fases_estadistica.getitemnumber(1, 'pem'))
	dw_pem_superficie.setitem(1, 'sup1', i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total'))
	dw_pem_superficie.setitem(1, 'pem2', i_w.idw_fases_estadistica.getitemnumber(1, 'pem'))
	dw_pem_superficie.setitem(1, 'sup2', i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total'))	
	if g_aplica_pem_seg = 'S' then
		dw_pem_superficie.setitem(1, 'pem_seg1', i_w.idw_fases_estadistica.getitemnumber(1, 'pres_seguridad'))
		dw_pem_superficie.setitem(1, 'pem_seg2', i_w.idw_fases_estadistica.getitemnumber(1, 'pres_seguridad'))
	end if
		
else
	dw_pem_superficie.setitem(1, 'pem1', 0)
	dw_pem_superficie.setitem(1, 'sup1', 0)
	if g_aplica_pem_seg = 'S' then dw_pem_superficie.setitem(1, 'pem1_seg', 0)
end if

// Modificado Ricardo 03-10-03
string id_col_inicial
// Si solo hay un colegiado
id_col_inicial = idw_colegiados.getitemstring(1, 'id_col')
// Miramos el tipo de gestion para saber como debemos comportarnos
if f_tipo_gestion_colegiado(i_w.dw_1.GetitemString(1, 'id_fase'), id_col_inicial) = 'P' then
	is_tipo_gestion = 'S'
else
	is_tipo_gestion = 'C'
end if
// Lanzamos el evento que colocar$$HEX2$$e1002000$$ENDHEX$$el tipo de gestion
dw_cip_musaat.trigger event csd_configura_tipo_gestion()
// FIN Modificado Ricardo 03-10-03


// MODIFICADO RICARDO 04-10-18
// Colocamos el numero de registro en el dw para seleccionar
dw_contrato_seleccionar.insertrow(0)
dw_contrato_seleccionar.setitem(1, 'n_registro', i_w.dw_1.GetitemString(1, 'n_registro'))
dw_contrato_seleccionar.setitem(1, 'id_fase', g_id_fase)
dw_contrato_seleccionar.setitem(1, 'entrada', 'S')

// Para los colegios con c$$HEX1$$e100$$ENDHEX$$lculo de honorarios te$$HEX1$$f300$$ENDHEX$$ricos
// Mostramos el bot$$HEX1$$f300$$ENDHEX$$n y bloqueamos los campos de pem y superficie nueva
// para que se modifiquen solo desde la ventana del c$$HEX1$$e100$$ENDHEX$$lculo de honorarios
if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio =  'COAATTER'  then
	cb_4.visible = true
	dw_pem_superficie.object.pem2.protect = 1
	dw_pem_superficie.object.sup2.protect = 1
end if

if g_colegio = 'COAATMCA' then
	cbx_avisos_pendientes.visible=true
	cbx_avisos_pendientes.checked=true
end if

// modificado Ricardo 2005-06-14
// inc. 0000002726
// hacemos visible el campo del presupuesto de certificacion si es obra oficial
if i_w.idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' then
	dw_pem_superficie.modify("pem_certificacion.visible = '0~tif (f_colegio() = 'COAATZ',   if (tipo_minuta ='F',0,1),0)'")
	dw_pem_superficie.modify("pem_certificacion_t.visible = '0~tif (f_colegio() = 'COAATZ',   if (tipo_minuta ='F',0,1),0)'")
else
	dw_pem_superficie.modify("pem_certificacion.visible = '0'")
	dw_pem_superficie.modify("pem_certificacion_t.visible = '0'")
end if

// Ponemos por defecto el valor que tenga la variable
dw_agrupar_act.setitem(1, 'agrupar', g_regularizacion_agrupar_act)

end event

event pfc_postopen();call super::pfc_postopen;dw_pago.of_SetDropDownCalendar(True)
dw_pago.iuo_calendar.of_register(dw_pago.iuo_calendar.DDLB)
dw_pago.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_pago.iuo_calendar.of_SetInitialValue(True)


// David 30/08/2006 - INC. 5749
if g_colegio <> 'COAATGC' then // En este colegio siempre agrupan
	string tipo_act, id_fase, id_exp
	double cuantos
	tipo_act = idw_1.getitemstring(1, 'fase')
	id_fase = idw_1.GetitemString(1, 'id_fase')
	id_exp = idw_fases_datos_exp.GetitemString(1, 'id_expedi')
	
	
	SELECT count(*)  INTO :cuantos FROM fases  
	WHERE fases.id_expedi = :id_exp and fases.fase= :tipo_act  and id_fase <> :id_fase ;
	if cuantos>0 then
		MessageBox(g_titulo,'Existe(n) otro(s) contrato(s) en este expediente con el mismo tipo de actuaci$$HEX1$$f300$$ENDHEX$$n.'+cr+&
		+'Puede agrupar los importes estos contratos con la opci$$HEX1$$f300$$ENDHEX$$n superior derecha')
		return
	end if
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_contratos_regularizacion
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_contratos_regularizacion
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type dw_pem_superficie from u_dw within w_contratos_regularizacion
integer x = 37
integer y = 352
integer width = 2048
integer height = 308
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_datos_pem_superficie_seg"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'pem1', 'pem2'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,###.00")))
	case 'sup1', 'sup2'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'pem1', 'sup1'
		// LANZAMOS EL EVENTO QUE HACE EL RECALCULO DE TODO
		dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(g_id_fase)
		cb_2.post event clicked()
		dw_1.setitem(1, 'avi_fact', 'A')
END CHOOSE
end event

type cb_1 from commandbutton within w_contratos_regularizacion
integer x = 704
integer y = 1828
integer width = 402
integer height = 112
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Regularizar"
end type

event clicked;double pem_nueva, sup_nueva

dw_pem_superficie.accepttext()
dw_cip_musaat.accepttext()
dw_originales_copias.accepttext()
dw_pago.accepttext()
dw_contrato_seleccionar.accepttext()

//cb_2.triggerevent(clicked!)

pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
sup_nueva = dw_pem_superficie.getitemnumber(1, 'sup2')
if f_es_vacio(string(pem_nueva)) or f_es_vacio(string(sup_nueva)) then 
	messagebox(g_titulo, 'Debe introducir los nuevos valores para el PEM y la Superficie')
	return
end if

parent.event csd_regularizar()


//if dw_colegiados.rowcount( )	<> 0 then
//	if messagebox("Aviso", 'Existe otro/s colegiados quiere cerrar la ventana S/N?', question!, yesno!) = 1 then
//		close(parent)
//	end if
//end if
//double pem_nueva, sup_nueva
//long i
//
//i_notas = 0
//i_pem_sup = 0
//i_proceso = 0
//for i=1 to dw_colegiados.rowcount( )	
//
//	if(dw_colegiados.getitemstring(i,'selec')='S')then
//		
//		dw_colegiados.event rowfocuschanged(i)
//		cb_2.event clicked()
//		dw_colegiados.accepttext( )
//		dw_pem_superficie.accepttext()
//		dw_cip_musaat.accepttext()
//		dw_originales_copias.accepttext()
//		dw_pago.accepttext()
//		dw_contrato_seleccionar.accepttext()
//		
//		pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
//		sup_nueva = dw_pem_superficie.getitemnumber(1, 'sup2')
//		if f_es_vacio(string(pem_nueva)) or f_es_vacio(string(sup_nueva)) then 
//			messagebox(g_titulo, 'Debe introducir los nuevos valores para el PEM y la Superficie')
//			return
//		end if
//		parent.event csd_regularizar()
//	end if 
//next
//i_notas = 0
//i_pem_sup = 0
//i_proceso = 0


end event

type cb_2 from commandbutton within w_contratos_regularizacion
integer x = 2103
integer y = 548
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Calcular"
end type

event clicked;string id_col, id_fase, paga_dv, tarifa
double cip, total_musaat = 0, porc_col = 0, suma_porc = 0, porc_col_real = 0, pem_nueva, sup_nueva, dv,dv_totales=0, pem_seg_nueva
int i, retorno, fila_colegiado
st_musaat_datos st_musaat_datos
st_cip_datos st_cip_datos
st_dv_datos st_dv_datos

id_col = i_id_col
id_fase = g_id_fase

dw_cip_musaat.event csd_rellenar_cip_musaat_contrato(id_fase)

// Validaciones
if f_es_vacio(id_col) then return
dw_pem_superficie.accepttext()
pem_nueva = dw_pem_superficie.getitemnumber(1, 'pem2')
pem_seg_nueva = dw_pem_superficie.getitemnumber(1, 'pem_seg2')
sup_nueva = dw_pem_superficie.getitemnumber(1, 'sup2')
if f_es_vacio(string(pem_nueva)) or f_es_vacio(string(sup_nueva)) then 
	messagebox(g_titulo, 'Debe introducir los nuevos valores para el PEM y la Superficie')
	return
end if

// Buscamos al colegiado en la lista
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
		fila_colegiado = i
		exit
	end if
next

// Obtenemos el % del porcentaje
porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
next

//Cambio Luis CGU-308
if(i_w.idw_fases_colegiados.rowcount() = 1)then
	suma_porc = 100
end if

porc_col_real = porc_col / suma_porc 

// Musaat (Nueva)
if i_w.idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = pem_nueva
	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = sup_nueva
	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.porcentaje = porc_col_real *100 
	st_musaat_datos.colindantes2m = i_w.idw_fases_estadistica.getitemstring(1, 'colindantes2m')
	st_musaat_datos.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
	
	datetime fecha
	double variac_pem, variac_sup
	fecha = f_musaat_fecha_visado_movimiento (id_fase)
	variac_pem = abs(dw_pem_superficie.getitemnumber(1, 'porc_pem'))
	variac_sup = abs(dw_pem_superficie.getitemnumber(1, 'porc_sup'))	
	
	if g_musaat_tabla_desc_activa = 'S' then 
		// Nuevas normas MUSAAT 2009. En regularizaciones superiores a 20% de visados anteriores a 2009 no se aplica tabla de descuentos
		if fecha<datetime(date('01/01/2009'), time('00:00:00')) and fecha<>datetime(date('01/01/1900'), time('00:00:00')) and (variac_pem > 20 or variac_sup > 20) and porc_col_real <> 1 then
			st_musaat_datos.no_aplicar_tabla_desc = true
			messagebox(g_titulo, "No se va a aplicar la tabla de descuentos de Musaat.", information!)
		end if
		
		//	//SCP-193 Para devoluciones anteriores al 4/08/09 con prima negativa debe realizarse con recargo inicial 0.3%
		date f_aux1
		f_aux1 = date(f_musaat_fecha_visado_movimiento( idw_1.getitemstring(1, 'id_fase')))
		if f_aux1< date('4/8/2009')   and (dw_pem_superficie.getitemdecimal(1, 'porc_pem')<0 or dw_pem_superficie.getitemdecimal(1, 'porc_sup')<0) then
			st_musaat_datos.no_aplicar_tarifa_coef_g =true
		else
			st_musaat_datos.no_aplicar_tarifa_coef_g =false
		end if
		// fin scp-193
	else
		
		// Se hacen las validaciones para variaciones de visados con fecha>= '01-01-09' al '12-21-09'
		if fecha>= datetime(date('01/01/2009'), time('00:00:00')) and fecha <datetime(date('01/01/2010'), time('00:00:00')) and (variac_pem >= 20 or variac_sup >= 20) and porc_col_real <> 1 then
		
			tarifa = f_musaat_tipo_tarifa(idw_1.getitemstring(1, 'fase'), sup_nueva, idw_1.getitemstring(1, 'tipo_trabajo') ) 
			choose case tarifa 
				case 'A', 'B', 'C'
					if (variac_pem>= 20) or (variac_pem>= 20 and  variac_sup >= 20) then st_musaat_datos.pem = pem_nueva - dw_pem_superficie.getitemnumber(1, 'pem1')
					if variac_sup >= 20 and tarifa = 'A' then st_musaat_datos.coef_k = f_musaat_dame_coef_k_mov(id_fase, id_col)
						
			end choose
					
		end if
		
	end if
	
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if
dw_cip_musaat.setitem(1, 'musaat_nueva', total_musaat)

// CIP Nueva
st_cip_datos.tipo_act = idw_1.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie = sup_nueva
st_cip_datos.pem = pem_nueva
st_cip_datos.pem_seg = pem_seg_nueva
if i_w.idw_fases_estadistica.rowcount() > 0 then
	st_cip_datos.volumen = i_w.idw_fases_estadistica.GetItemNumber(1,'volumen')
	st_cip_datos.altura = i_w.idw_fases_estadistica.GetItemNumber(1,'altura')
	st_cip_datos.colindantes = i_w.idw_fases_estadistica.GetItemString(1,'colindantes')
	st_cip_datos.t_terreno = i_w.idw_fases_estadistica.GetItemString(1,'t_terreno')
	st_cip_datos.long_per = i_w.idw_fases_estadistica.getitemnumber(1, 'longitud_per')	
	st_cip_datos.vol_tierras = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen_tierras')	
	st_cip_datos.valor_terreno = i_w.idw_fases_estadistica.getitemnumber(1, 'valor_terreno')	
	st_cip_datos.valor_tasacion = i_w.idw_fases_estadistica.getitemnumber(1, 'valor_tasacion')
	st_cip_datos.valoracion_estim = i_w.idw_fases_estadistica.getitemnumber(1, 'valoracion_estim')
	st_cip_datos.estructura = i_w.idw_fases_estadistica.GetItemString(1,'estructura')
	st_cip_datos.t_medicion = i_w.idw_fases_estadistica.GetItemString(1,'t_medicion')
	st_cip_datos.replan_deslin = i_w.idw_fases_estadistica.GetItemString(1,'replan_deslin')
	st_cip_datos.vol_edif = i_w.idw_fases_estadistica.GetItemnumber(1,'volumen')	
end if
st_cip_datos.admon = i_w.dw_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.tipo_gestion = idw_1.GetItemString(1,'tipo_gestion')
st_cip_datos.porcentaje = porc_col_real * 100
if g_colegio = 'COAATLR' then 
	st_cip_datos.fecha = DateTime(Today(),Now())
else
	st_cip_datos.fecha = idw_1.GetItemdatetime(1,'f_entrada')
end if
st_cip_datos.visared = idw_1.GetItemString(1,'e_mail')// Modificado Ricardo 2004-12-30
st_cip_datos.tipo_registro = idw_1.GetItemString(1,'tipo_registro')
st_cip_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
st_cip_datos.id_expedi = idw_fases_datos_exp.getitemstring(1, 'id_expedi')

// Para Cuenca y Zaragoza pasamos los datos de los honos minimos a la funci$$HEX1$$f300$$ENDHEX$$n de cip
if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio =  'COAATTER'  then
	st_cip_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')	
	st_cip_datos.hon_teor =  idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')
end if

// En algunos colegios se calcula en la ventana de honorarios
if g_colegio = 'COAATGU' then
	st_cip_datos.cip = idw_fases_cip_tfe.getitemnumber(1, 'importe_cip')
else
	f_calcular_cip(st_cip_datos)
end if
if g_colegio = 'COAATMCA' then
	cip = st_cip_datos.cip
else
	cip = st_cip_datos.cip * porc_col/100
end if

// MODIFICADO RICARDO 04-08-04
// Solo para el colegio de la rioja
string ctrl_calidad_interno, fase
double cip_incrementar, dv_incrementar
fase = i_w.dw_1.getitemString(1, 'fase')
ctrl_calidad_interno = i_w.idw_fases_estadistica.GetItemString(1,'ctrl_calidad_interno')
if f_es_vacio(ctrl_calidad_interno) then ctrl_calidad_interno = 'N'
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if not f_puede_llevar_control_calidad(fase) = 'S' then
			ctrl_calidad_interno = 'N'
		end if
	CASE ELSE
		// Para todos los dem$$HEX1$$e100$$ENDHEX$$s lo ocultamos siempre
		ctrl_calidad_interno = 'N'
END CHOOSE
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
			st_cip_datos.tipo_act = g_codigo_tipo_actuacion_control_calidad
			f_calcular_cip(st_cip_datos)
			cip_incrementar = st_cip_datos.cip
			if isnull(cip_incrementar) then cip_incrementar = 0
			cip += (cip_incrementar * porc_col/100)
		end if
END CHOOSE
// FIN MODIFICADO RICARDO 04-08-04

dw_cip_musaat.setitem(1, 'cip_nueva', f_redondea(cip))


//DV Nueva
st_dv_datos.id_fase = idw_1.getitemstring(1, 'id_fase')
st_dv_datos.tipoact = idw_1.getitemstring(1, 'fase')
st_dv_datos.tipoobra = idw_1.getitemstring(1, 'tipo_trabajo')
st_dv_datos.pem = pem_nueva//i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
st_dv_datos.administracion = ( idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S')
st_dv_datos.porcentaje = 100 // Todos los DV
st_dv_datos.id_expediente = idw_1.getitemstring(1, 'id_expedi')
st_dv_datos.fecha = idw_1.GetItemdatetime(1,'f_entrada')
if g_colegio = 'COAATLR' then 
	st_dv_datos.fecha = DateTime(Today(),Now())
else
	st_dv_datos.fecha = idw_1.GetItemdatetime(1,'f_entrada')
end if

st_dv_datos.superficie = sup_nueva
st_dv_datos.regularizacion = 'S'
st_dv_datos.visared = idw_1.GetItemString(1,'e_mail')// Modificado Ricardo 2004-12-30

if g_colegio = 'COAATCU' or g_colegio = 'COAATZ' or g_colegio =  'COAATTER'  then 
	st_dv_datos.hon_teor = idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')
end if

if g_colegio = 'COAATGU' then
	st_dv_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
	st_dv_datos.contenido = idw_fases_cip_tfe.getitemstring(1, 'epigrafe')
end if
if g_colegio = 'COAATMCA' then 
	if (pem_nueva - dw_pem_superficie.getitemnumber(1, 'pem1')) = 0 then
		st_dv_datos.pem = pem_nueva
	else
		st_dv_datos.pem = (pem_nueva - dw_pem_superficie.getitemnumber(1, 'pem1'))
	end if
	if (pem_seg_nueva - dw_pem_superficie.getitemnumber(1, 'pem_seg1')) = 0 then
		st_dv_datos.pres_seguridad = pem_seg_nueva
	else
		st_dv_datos.pres_seguridad = pem_seg_nueva - dw_pem_superficie.getitemnumber(1, 'pem_seg1')
	end if
end if
	

f_calcular_dv(st_dv_datos)

//if f_total_avisado_dv_colegiado(id_fase, id_col) > 0 then
//	dv = 0

if g_colegio = 'COAATMCA' then
//	// En otros datos se guarda si es el cliente paga el CCV o el colegiado (paga_ccv='N' (DEFECTO) -> Paga el cliente, paga_ccv='S' -> paga el colegiado )
	dv_totales = st_dv_datos.dv
	select s_n into :paga_dv from otros_datos_colegiado where id_colegiado = :id_col and cod_caracteristica = 'PC';
	if f_es_vacio(paga_dv) or paga_dv='N' then 
		paga_dv='P'
	else
		paga_dv='C'
	end if
	//if paga_dv = 'C' then
//		dv = max((dv_totales * porc_col_real) ,0)
//	
//	else
		dv = dv_totales 
//	end if
else	
	dv = st_dv_datos.dv * porc_col/100
end if

// MODIFICADO RICARDO 04-08-04
// Solo para el colegio de la rioja
CHOOSE CASE g_colegio
	CASE 'COAATLR'
		if ctrl_calidad_interno = 'S' then
		st_dv_datos.tipoact = g_codigo_tipo_actuacion_control_calidad
		f_calcular_dv(st_dv_datos)
		dv_incrementar = st_dv_datos.dv
		if isnull(dv_incrementar) then dv_incrementar = 0
			dv += (dv_incrementar * porc_col/100)
		end if
END CHOOSE
// FIN MODIFICADO RICARDO 04-08-04

dw_cip_musaat.setitem(1, 'dv_nueva', f_redondea(dv))


dw_cip_musaat.setitem(1, 'cip', dw_cip_musaat.getitemnumber(1, 'cip_nueva') - dw_cip_musaat.getitemnumber(1, 'cip_pagada'))

if fecha>= datetime(date('01/01/2009'), time('00:00:00')) and fecha <datetime(date('01/01/2010'), time('00:00:00')) and (variac_pem >= 20 or variac_sup >= 20) and porc_col_real <> 1 then
	if tarifa = 'A' or tarifa = 'B' or tarifa = 'C' then
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') )
	else
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada'))
	end if
else
	dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada'))
end if

if g_colegio = 'COAATMCA' then
	dw_cip_musaat.setitem(1, 'dv', dw_cip_musaat.getitemnumber(1, 'dv_nueva') )
else
	dw_cip_musaat.setitem(1, 'dv', dw_cip_musaat.getitemnumber(1, 'dv_nueva') - dw_cip_musaat.getitemnumber(1, 'dv_pagada'))
end if


dw_cip_musaat.setitem(1, 'cip_porc_d', 100)
dw_cip_musaat.setitem(1, 'musaat_porc_d', 100)
dw_cip_musaat.setitem(1, 'dv_porc_d', 100)

// COAM-398
string alta_musaat
select src_alta into :alta_musaat from musaat where id_col=:id_col;
if alta_musaat='N' then
	dw_cip_musaat.setitem(1, 'restar_musaat', 'N')
end if
// FIN COAM-398
reg = '1'

end event

type dw_colegiados from u_dw within w_contratos_regularizacion
integer x = 37
integer y = 112
integer width = 2048
integer height = 228
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_regularizacion"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)

end event

event retrieveend;call super::retrieveend;this.PostEvent(Rowfocuschanged!)
end event

event rowfocuschanged;if this.rowcount() = 0 then return

int i
for i = 1 to this.rowcount()
	this.selectrow(i, false)
next

if (isnull(currentrow) or currentrow = 0)then
	currentrow = 1
end if

if currentrow > 1 then
	this.selectrow(currentrow, true)
else
	this.selectrow(1, true)
end if

//i_id_col=dw_colegiados.getitemstring(dw_colegiados.getrow(),'id_col')
i_id_col=dw_colegiados.getitemstring(currentrow,'id_col')
dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(g_id_fase)

cb_2.post event clicked()

dw_1.setitem(1, 'avi_fact', 'A')

string id_col_inicial
if currentrow > 0 then 
	id_col_inicial = this.getitemstring(currentrow, 'id_col')
	// Miramos el tipo de gestion para saber como debemos comportarnos
	if f_tipo_gestion_colegiado(g_id_fase, id_col_inicial) = 'P' then
		is_tipo_gestion = 'S'
	else
		is_tipo_gestion = 'C'
	end if
	dw_cip_musaat.trigger event csd_configura_tipo_gestion()
end if

end event

type cb_aumentar from commandbutton within w_contratos_regularizacion
boolean visible = false
integer x = 2345
integer y = 1360
integer width = 64
integer height = 44
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type cb_disminuir from commandbutton within w_contratos_regularizacion
boolean visible = false
integer x = 2345
integer y = 1408
integer width = 64
integer height = 44
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type sle_imprimir_copias from singlelineedit within w_contratos_regularizacion
boolean visible = false
integer x = 2231
integer y = 1360
integer width = 105
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type st_3 from statictext within w_contratos_regularizacion
boolean visible = false
integer x = 1957
integer y = 1568
integer width = 270
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_contratos_regularizacion
boolean visible = false
integer x = 1925
integer y = 1416
integer width = 311
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_contratos_regularizacion
boolean visible = false
integer x = 2231
integer y = 1512
integer width = 105
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_disminuir_copias from commandbutton within w_contratos_regularizacion
boolean visible = false
integer x = 2345
integer y = 1560
integer width = 64
integer height = 44
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type cb_aumentar_copias from commandbutton within w_contratos_regularizacion
boolean visible = false
integer x = 2345
integer y = 1512
integer width = 64
integer height = 44
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type dw_pago from u_dw within w_contratos_regularizacion
boolean visible = false
integer x = 14
integer y = 1276
integer width = 1280
integer height = 448
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pago_facturas"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.object.asunto_t.visible = false
this.object.asunto.visible = false
end event

event itemchanged;call super::itemchanged;CHOOSE CASE DWO.NAME 
	case 'forma_pago'
		// Colocamos el banco
		this.setitem(1, 'banco', f_banco_asociado_a_forma_pago(string(data)))		
		
		if data = g_formas_pago.cargo then
			this.object.banco.protect = 1
			this.object.banco.background.color = f_color_gris()
			choose CASE g_colegio
				case 'COAATB'
					THIS.SETITEM(1,'BANCO','09')
			END CHOOSE
		else
			this.object.banco.protect = 0
			this.object.banco.background.color = f_color_blanco()			
		end if
end choose
end event

type st_1 from statictext within w_contratos_regularizacion
integer x = 37
integer y = 32
integer width = 690
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione el colegiado :"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_contratos_regularizacion
boolean visible = false
integer x = 2491
integer y = 732
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

type st_proceso from statictext within w_contratos_regularizacion
integer x = 23
integer y = 1716
integer width = 1701
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_cip_musaat from u_dw within w_contratos_regularizacion
event csd_rellenar_cip_musaat ( )
event csd_configura_tipo_gestion ( )
event csd_rellenar_cip_musaat_contrato ( string id_fase )
event type double csd_calcula_honos ( )
integer x = 37
integer y = 672
integer width = 2450
integer height = 512
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_datos_cip_musaat_nuevo"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_rellenar_cip_musaat();string id_col, id_fase
double cip, musaat, porc_renuncia = 0, porc_realizado = 0
boolean restar_cip = false, restar_musaat = false
double total_cip = 0, total_musaat = 0, total_dv = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0
double realizado_cip = 0, realizado_musaat = 0
double porc_col = 0, suma_porc = 0, porc_col_real = 0
st_musaat_datos st_musaat_datos
int i, retorno, fila_colegiado
double cip_a_retener = 0 , musaat_a_retener = 0


//// Recuperamos los datos de entrada
//restar_cip = ( this.getitemstring(1, 'restar_cip') = 'S')
//restar_musaat = ( this.getitemstring(1, 'restar_musaat') = 'S')
id_col = i_id_col //dw_1.getitemstring(1, 'id_colegiado')
id_fase = g_id_fase //i_w.dw_1.getitemstring(1, 'id_fase')
//porc_renuncia = this.getitemnumber(1, 'porc_renuncia')
//porc_realizado = f_redondea ( 100 - porc_renuncia )
// Validaciones
if f_es_vacio(id_col) then return
// Buscamos al colegiado en la lista
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	if i_w.idw_fases_colegiados.getitemstring(i, 'id_col') = id_col then
		fila_colegiado = i
		exit
	end if
next
// Obtenemos el % del porcentaje
porc_col = i_w.idw_fases_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
for i = 1 to i_w.idw_fases_colegiados.rowcount()
	suma_porc += i_w.idw_fases_colegiados.getitemnumber(i, 'porcen_a')
next
porc_col_real = porc_col / suma_porc

// Prima Total (actual)
if i_w.idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	// MODIFICADO RICARDO 04-10-18
	//st_musaat_datos.pem = i_w.idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.pem = dw_pem_superficie.GetItemNumber(1, 'pem1')
	st_musaat_datos.administracion = i_w.idw_fases_datos_exp.getitemstring(1, 'administracion')
	//st_musaat_datos.superficie = i_w.idw_fases_estadistica.getitemnumber(1, 'sup_total')
	st_musaat_datos.superficie = dw_pem_superficie.GetItemNumber(1, 'sup1')
	// FIN MODIFICADO RICARDO 04-10-18
	st_musaat_datos.volumen = i_w.idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.porcentaje =porc_col_real * 100
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if
this.setitem(1, 'musaat_total', total_musaat)

// CIP Total (actual)
total_cip = f_cip_contrato_dw(i_w.idw_fases_informes)
total_cip = f_redondea(total_cip * porc_col_real )
total_cip = f_redondea(total_cip)
this.setitem(1, 'cip_total', total_cip)

// DV total (actual)
total_dv = f_dv_contrato_dw(i_w.idw_fases_informes)
total_dv = f_redondea(total_dv * porc_col_real )
total_dv = f_redondea(total_dv)
this.setitem(1, 'dv_total', total_dv)

// Pagado
pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col) 
pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col)
this.setitem(1, 'cip_pagada', pagado_cip)
this.setitem(1, 'musaat_pagada', pagado_musaat)
this.setitem(1, 'dv_pagada', pagado_dv)

this.setitem(1, 'cip', this.getitemnumber(1, 'cip_nueva') - this.getitemnumber(1, 'cip_pagada'))
this.setitem(1, 'musaat', this.getitemnumber(1, 'musaat_nueva') - this.getitemnumber(1, 'musaat_pagada'))
this.setitem(1, 'dv', this.getitemnumber(1, 'dv_nueva') - this.getitemnumber(1, 'dv_pagada'))





//// Realizado
//musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado /100))
//cip_a_retener = f_redondea( pagado_cip * (porc_realizado /100))
//dw_1.setitem(1, 'realizado_cip', cip_a_retener)
//dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
//
//// A devolver
//if restar_cip then
//	if pagado_cip >= cip_a_retener then
//		cip = (-1) * f_redondea(( pagado_cip - cip_a_retener ))
//	else
//		cip = (-1) * pagado_cip
//	end if
//else
//	cip = 0
//end if
//if restar_musaat then
//	if pagado_musaat >= musaat_a_retener then
//		musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
//	else
//		musaat = (-1) * pagado_musaat
//	end if
//else
//	musaat = 0
//end if
//cip = f_redondea(cip)
//musaat = f_redondea(musaat)
//
//dw_1.setitem(1, 'cip',cip)
//dw_1.setitem(1, 'musaat', musaat)
end event

event csd_configura_tipo_gestion();this.setredraw(false)
// COAM-409
if g_colegio='COAATMCA' then is_tipo_gestion='S'

choose case is_tipo_gestion
	case 'C'
		// Con gestion de cobros
//		this.object.aplica_honos.visible = true // Lo quito porque solo se va a poner un campo
		this.object.honorarios_t.visible = true
//		this.object.porc_honorarios.visible = true // Lo quito porque solo se va a poner un campo
		this.object.honorarios.visible = true
		this.object.desplaza.visible = true
		this.object.desplaza_t.visible = true
		
		// Modificado David 01/03/2006 - Ponemos los honorarios restantes
		if this.rowcount() > 0 then
			double honos
			honos = event csd_calcula_honos()
			this.setitem(1, 'honorarios', honos)
		end if		
		
	case 'S'
		// Sin gestion de cobros
//		this.object.aplica_honos.visible = false
		this.object.honorarios_t.visible = false
//		this.object.porc_honorarios.visible = false
		this.object.honorarios.visible = false
		this.object.desplaza.visible = false
		this.object.desplaza_t.visible = false
		if this.rowcount() > 0 then
			this.setitem(1, 'honorarios', 0)
			this.setitem(1, 'desplaza', 0)
		end if
	case 'A'
		// Autoliquidacion. Creo que no se usar$$HEX1$$e100$$ENDHEX$$
end choose
this.setredraw(true)

// En Zaragoza nunca se regularizan los dv
if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio =  'COAATTER'  then this.setitem(1, 'restar_dv', 'N')

end event

event csd_rellenar_cip_musaat_contrato(string id_fase);// Evento que permitir$$HEX2$$e1002000$$ENDHEX$$colocar los valores de un contrato dado, no del que se tiene abierto

//if dw_contrato_seleccionar.getitemstring(1, 'id_fase') = g_id_fase then 
//	this.event csd_rellenar_cip_musaat()
//	return
//end if

string id_col
long retorno
double porc_col = 0, porc_col_real = 0, suma_porc = 0
st_musaat_datos st_musaat_datos
double total_cip = 0, total_musaat = 0, total_dv = 0
double pagado_cip = 0, pagado_musaat = 0, pagado_dv = 0

// Recuperamos los datos de entrada
id_col = i_id_col 
// Validaciones
if f_es_vacio(id_col) then return


//porc_renuncia = this.getitemnumber(1, 'porc_renuncia')
//porc_realizado = f_redondea ( 100 - porc_renuncia )

// Obtenemos el % del porcentaje
select porcen_a into :porc_col from fases_colegiados where id_fase = :id_fase and id_col = :id_col;
select sum(porcen_a) into :suma_porc from fases_colegiados where id_fase = :id_fase;

porc_col_real = porc_col / suma_porc

// Prima Total (actual)
if i_w.idw_fases_estadistica.rowcount() > 0 then
	string tipo_act, tipo_trabajo, administracion
	double volumen
	
	select fase, fases.tipo_trabajo, administracion, volumen 
	into :tipo_act, :tipo_trabajo, :administracion, :volumen
	from expedientes, fases 
	where expedientes.id_expedi = fases.id_expedi and fases.id_fase = :id_fase;
	st_musaat_datos.n_visado = id_fase
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = tipo_act
	st_musaat_datos.tipo_obra = tipo_trabajo
	st_musaat_datos.pem = dw_pem_superficie.GetItemNumber(1, 'pem1')
	st_musaat_datos.administracion = administracion
	st_musaat_datos.superficie = dw_pem_superficie.GetItemNumber(1, 'sup1')
	st_musaat_datos.volumen = volumen
	st_musaat_datos.porcentaje =porc_col_real * 100
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if			
	total_musaat = st_musaat_datos.prima_comp
	total_musaat = f_redondea(total_musaat)
end if
this.setitem(1, 'musaat_total', total_musaat)

dw_fases_informes.retrieve(id_fase)

// CIP Total (actual)
total_cip = f_cip_contrato_dw(dw_fases_informes)
total_cip = f_redondea(total_cip * porc_col_real )
total_cip = f_redondea(total_cip)
this.setitem(1, 'cip_total', total_cip)

// DV total (actual)
total_dv = f_dv_contrato_dw(dw_fases_informes)
total_dv = f_redondea(total_dv * porc_col_real )
total_dv = f_redondea(total_dv)
this.setitem(1, 'dv_total', total_dv)



// Pagado
string id_expedi
id_expedi = idw_1.getitemstring(1, 'id_expedi')
// David 30/08/2006 - INC. 5749
// Vemos si est$$HEX2$$e1002000$$ENDHEX$$marcada o no la opci$$HEX1$$f300$$ENDHEX$$n de agrupar los importes para
// los contratos con el mismo tipo de actuaci$$HEX1$$f300$$ENDHEX$$n
double pendiente_cip=0,pendiente_musaat=0,pendiente_dv=0
if dw_agrupar_act.getitemstring(1, 'agrupar') = 'S' then
	pagado_cip = f_total_cobrado_cip_colegiado_expediente(id_expedi, id_col, tipo_act)
	pagado_musaat = f_total_cobrado_musaat_colegiado_expedi(id_expedi, id_col, tipo_act)
	pagado_dv = f_total_cobrado_dv_colegiado_expediente(id_expedi, id_col, tipo_act)
	if cbx_avisos_pendientes.checked and cbx_avisos_pendientes.visible then
		pendiente_cip=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, tipo_act, 'CIP')
		pendiente_dv=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, tipo_act, 'DV')
		pendiente_musaat=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, tipo_act, 'MUSAAT')				
	end if	
else
	pagado_cip = f_total_cobrado_cip_colegiado(id_fase, id_col) 
	pagado_musaat = f_total_cobrado_musaat_colegiado(id_fase, id_col)
	pagado_dv = f_total_cobrado_dv_colegiado(id_fase, id_col)
	
	if cbx_avisos_pendientes.checked and cbx_avisos_pendientes.visible then
		pendiente_cip=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, '', 'CIP')
		pendiente_dv=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, '', 'DV')
		pendiente_musaat=f_total_avisos_emitidos_colegiado_exp(id_expedi, id_fase, id_col, '', 'MUSAAT')				
	end if
end if

pagado_cip+= pendiente_cip
pagado_dv+=pendiente_dv
pagado_musaat+=pendiente_musaat

this.setitem(1, 'cip_pagada', pagado_cip)
this.setitem(1, 'musaat_pagada', pagado_musaat)
this.setitem(1, 'dv_pagada', pagado_dv)
this.setitem(1, 'cip', this.getitemnumber(1, 'cip_nueva') - this.getitemnumber(1, 'cip_pagada'))
this.setitem(1, 'musaat', this.getitemnumber(1, 'musaat_nueva') - this.getitemnumber(1, 'musaat_pagada'))
this.setitem(1, 'dv', this.getitemnumber(1, 'dv_nueva') - this.getitemnumber(1, 'dv_pagada'))

// Actualizamos porcentajes de diferencia
this.setitem(1, 'cip_porc_d',100 )
this.setitem(1, 'musaat_porc_d', 100)
this.setitem(1, 'dv_porc_d', 100)

//// Realizado
//musaat_a_retener = f_redondea( pagado_musaat * (porc_realizado /100))
//cip_a_retener = f_redondea( pagado_cip * (porc_realizado /100))
//dw_1.setitem(1, 'realizado_cip', cip_a_retener)
//dw_1.setitem(1, 'realizado_musaat', musaat_a_retener)
//
//// A devolver
//if restar_cip then
//	if pagado_cip >= cip_a_retener then
//		cip = (-1) * f_redondea(( pagado_cip - cip_a_retener ))
//	else
//		cip = (-1) * pagado_cip
//	end if
//else
//	cip = 0
//end if
//if restar_musaat then
//	if pagado_musaat >= musaat_a_retener then
//		musaat = (-1) * f_redondea(( pagado_musaat - musaat_a_retener ))
//	else
//		musaat = (-1) * pagado_musaat
//	end if
//else
//	musaat = 0
//end if
//cip = f_redondea(cip)
//musaat = f_redondea(musaat)
//
//dw_1.setitem(1, 'cip',cip)
//dw_1.setitem(1, 'musaat', musaat)
end event

event type double csd_calcula_honos();// C$$HEX1$$f300$$ENDHEX$$digo copiado de w_fases_minutas para calcular los honorarios que restan del colegiado al cliente
string id_col, id_cli, id_fase
double total_col_cli=0, total_avisado_col_cli=0, maximo=0, porc_cli_mayor, porc_col=0, porc_cli=0
double suma_porc_col=0, suma_porc_cli=0, porc_col_real=0, porc_cli_real=0, honos_totales=0, honos_col_cli=0
int fila_colegiado=0, fila_cliente=0, i=0

// Coger el promotor de mayor %
for i = 1 to idw_clientes.rowcount()
	if idw_clientes.getitemnumber(i, 'porcen') > porc_cli_mayor then
		id_cli = idw_clientes.getitemstring(i, 'id_cliente')
	end if
next

id_fase =  idw_1.getitemstring(1, 'id_fase')


// % colegiado
fila_colegiado = idw_colegiados.find("id_col = '" + i_id_col+"'", 1, idw_colegiados.rowcount())
if fila_colegiado <= 0 then
	messagebox(g_titulo, 'No se encuentra el % del colegiado')
	return 0
end if
porc_col = idw_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
for i = 1 to idw_colegiados.rowcount()
	IF idw_colegiados.getitemstring(i, 'tipo_gestion') = 'C' then suma_porc_col += idw_colegiados.getitemnumber(i, 'porcen_a')
next
if idw_colegiados.getitemstring(fila_colegiado, 'tipo_gestion') = 'P' then return 0

if suma_porc_col = 0 or isnull(suma_porc_col) then suma_porc_col = 1
porc_col_real = porc_col / suma_porc_col

// % cliente
fila_cliente = idw_clientes.find("id_cliente = '" + id_cli + "'", 1, idw_clientes.rowcount())
if fila_cliente <= 0 then 
	messagebox(g_titulo, 'No se encuentra el % del cliente')
	return 0
end if
porc_cli = idw_clientes.getitemnumber(fila_cliente, 'porcen')
for i = 1 to idw_clientes.rowcount()
	suma_porc_cli += idw_clientes.getitemnumber(i, 'porcen')
next
if suma_porc_cli = 0 or isnull(suma_porc_cli) then suma_porc_cli = 1
porc_cli_real = porc_cli / suma_porc_cli

// Honos Totales
honos_totales = idw_1.getitemnumber(1, 'honorarios')

// Honos Totales de este col. a este cli.
honos_col_cli = f_redondea(honos_totales * porc_col_real * porc_cli_real)

total_col_cli = honos_col_cli

total_avisado_col_cli = f_total_avisado_honos_col_cli(id_fase,i_id_col,id_cli)
maximo = max( total_col_cli - total_avisado_col_cli, 0)

return maximo

end event

event doubleclicked;// Sobreescrito
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	case 'restar_cip'
		if data = 'N' then this.setitem(1,'cip',0)
	case 'restar_musaat'
		if data = 'N' then this.setitem(1,'musaat',0)			
	case 'restar_dv'
		if data = 'N' then this.setitem(1,'dv',0)			
		
	CASE 'honorarios'
		if double(data) <> 0 then 
			// Modificado por Ricardo 03-11-02
			dw_pago.object.forma_pago_liq_t.visible = true
			dw_pago.object.forma_pago_liq.visible = true
		else
			// Si el otro valor es 0 lo ocultamos
			if this.GetItemNumber(row, 'desplaza') = 0 then
//				dw_pago.object.forma_pago_liq_t.visible = false
//				dw_pago.object.forma_pago_liq.visible = false
			end if
		end if
	CASE 'desplaza'
		if double(data) <> 0 then 
			// Modificado por Ricardo 03-11-02
			dw_pago.object.forma_pago_liq_t.visible = true
			dw_pago.object.forma_pago_liq.visible = true
		else
			// Si el otro valor es 0 lo ocultamos
			if this.GetItemNumber(row, 'honorarios') = 0 then
//				dw_pago.object.forma_pago_liq_t.visible = false
//				dw_pago.object.forma_pago_liq.visible = false
			end if
		end if
	case 'cip'
		// Si se modifica se debe recalcular el porcentaje
		// Actualizamos porcentajes de diferencia
		double cip_dif 
		cip_dif = double(data)
		this.setitem(1, 'cip_porc_d', (cip_dif / this.getitemnumber(1, 'cip')))
		
	case 'cip_porc_d'	
		if g_regulariza_cip_porc_nuevo = 'S' then
			this.setitem(1, 'cip', (this.getitemnumber(1, 'cip_nueva')*double(data)) /100)
		else
			this.setitem(1, 'cip', (this.getitemnumber(1, 'cip')*double(data)) /100)
		end if
		
	case 'musaat'
		///** CRI-233.Alexis. 30/03/2010. Se modifica por si tuviese valor = 0, ya que har$$HEX1$$ed00$$ENDHEX$$a una divisi$$HEX1$$f300$$ENDHEX$$n por cero ***//
		if this.getitemnumber(1, 'musaat') = 0 then
			this.setitem(1, 'musaat_porc_d', 100)
		else
			this.setitem(1, 'musaat_porc_d', (double(data) / this.getitemnumber(1, 'musaat')) *100)
		end if
	case 'dv'	
		
		if this.getitemnumber(1, 'dv') = 0 then
			this.setitem(1, 'dv_porc_d', 100)
		else
			this.setitem(1, 'dv_porc_d', (double(data) / this.getitemnumber(1, 'dv')) *100)
		end if
		///** Fin modificado por Alexis. CRI-233 ***///		

		
end choose

end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'cip', 'musaat', 'dv', 'desplaza', 'honorario'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))
	case 'porc_honorarios'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))		
end choose
end event

type cbx_1 from checkbox within w_contratos_regularizacion
integer x = 64
integer y = 1204
integer width = 709
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facturar y cobrar el aviso"
end type

event clicked;double honorarios, desplaza
boolean b_congc = false

if this.checked = true then
	dw_pago.visible = true
	
	// Modificado Ricardo 03/10/02
	honorarios = dw_cip_musaat.getitemNumber(dw_cip_musaat.getrow(), 'honorarios')
	if isnull(honorarios) then honorarios = 0
	// Modificado Ricardo 03/12/02
	desplaza = dw_cip_musaat.getitemNumber(dw_cip_musaat.getrow(), 'desplaza')
	if isnull(desplaza) then desplaza = 0
	
	
	if honorarios <> 0 or desplaza <> 0 then b_congc = true
	
	// Insertamos una linea para poder colocar la impresion de la factura
	dw_originales_copias.reset()
	dw_originales_copias.insertrow(0)
	if not b_congc then
		// Solo dejamos la segunda
		dw_originales_copias.object.n_orig_hon_t.visible = false
		dw_originales_copias.object.n_orig_hon.visible = false
		dw_originales_copias.object.b_mas_oh.visible = false
		dw_originales_copias.object.b_men_oh.visible = false
		dw_originales_copias.object.n_cop_hon_t.visible = false
		dw_originales_copias.object.n_cop_hon.visible = false
		dw_originales_copias.object.b_mas_ch.visible = false
		dw_originales_copias.object.b_men_ch.visible = false
	else
		// Visualizamos la primera tambien
		dw_originales_copias.object.n_orig_hon_t.visible = true
		dw_originales_copias.object.n_orig_hon.visible = true
		dw_originales_copias.object.b_mas_oh.visible = true
		dw_originales_copias.object.b_men_oh.visible = true
		dw_originales_copias.object.n_cop_hon_t.visible = true
		dw_originales_copias.object.n_cop_hon.visible = true
		dw_originales_copias.object.b_mas_ch.visible = true
		dw_originales_copias.object.b_men_ch.visible = true
		
		// Modificado por Ricardo 03-11-02
		dw_pago.object.forma_pago_liq_t.visible = true
		dw_pago.object.forma_pago_liq.visible = true
	end if
	dw_originales_copias.visible = true
	
	
	/*
	st_2.visible = true
	st_3.visible = true
	sle_imprimir_copias.visible = true
	sle_imprimir_originales.visible = true
	cb_aumentar.visible = true
	cb_disminuir.visible = true
	cb_aumentar_copias.visible = true
	cb_disminuir_copias.visible = true
	*/
	// fin Modificado Ricardo 02/10/03
else
	dw_pago.visible = false
	dw_originales_copias.visible = false
	
	// Modificado Ricardo 02/10/03
	/*
	st_2.visible = false
	st_3.visible = false
	sle_imprimir_copias.visible = false
	sle_imprimir_originales.visible = false
	cb_aumentar.visible = false
	cb_disminuir.visible = false
	cb_aumentar_copias.visible = false
	cb_disminuir_copias.visible = false
	*/
	// FIN Modificado Ricardo 02/10/03
end if

end event

type cb_3 from commandbutton within w_contratos_regularizacion
integer x = 1307
integer y = 1828
integer width = 402
integer height = 112
integer taborder = 180
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

event clicked;closewithreturn(parent, 'CANCELAR')

end event

type dw_originales_copias from u_dw within w_contratos_regularizacion
integer x = 1294
integer y = 1276
integer width = 1207
integer height = 448
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_facturas_num_orig_cop"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

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

event constructor;call super::constructor;this.visible = false
end event

type dw_1 from u_dw within w_contratos_regularizacion
integer x = 2139
integer y = 100
integer width = 379
integer height = 240
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_musaat_pagado_avi_fact"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;double pagado_musaat
string id_col, id_fase

choose case dwo.name
	case 'avi_fact'
		id_col = i_id_col 
		id_fase = g_id_fase 
		if data = 'A' then
			dw_cip_musaat.setitem(1, 'musaat_pagada', f_total_cobrado_musaat_colegiado(id_fase, id_col))
		else
			dw_cip_musaat.setitem(1, 'musaat_pagada', f_total_cobrado_musaat_colegiado_fact(id_fase, id_col))
		end if
		dw_cip_musaat.setitem(1, 'musaat', dw_cip_musaat.getitemnumber(1, 'musaat_nueva') - dw_cip_musaat.getitemnumber(1, 'musaat_pagada'))
end choose
		
end event

type dw_contrato_seleccionar from u_dw within w_contratos_regularizacion
boolean visible = false
integer x = 731
integer y = 12
integer width = 1376
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_regularizacion_contrato"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;// Modificado Ricardo 04-10-18
string id_fase
double sup_total, pem

CHOOSE CASE dwo.name
	CASE 'n_registro'
		id_fase = f_devuelve_id_fase_por_num(data)
		if id_fase = '-1' then
			post messagebox(g_titulo, "Contrato no encontrado", stopsign!)
			return 2
		else
			this.setitem(row, 'id_fase', id_fase)
			// si es el que tenemos el detalle, marcamos que es con el que hemos entrado
			if id_fase = g_id_fase then 
				dw_contrato_seleccionar.setitem(1, 'entrada', 'S')			
			else
				dw_contrato_seleccionar.setitem(1, 'entrada', 'N')			
			end if
			
			// Colocamos la superfie y el presupuesto de esta obra
		   SELECT sup_viv + sup_garage + sup_otros as sub_total,
					pem
			 INTO :sup_total,
					:pem
			 FROM fases_usos
			WHERE fases_usos.id_fase = :id_fase  ;
					
			dw_pem_superficie.setitem(1, 'pem1', pem)
			dw_pem_superficie.setitem(1, 'sup1', sup_total)
			
			// Hacemos los calculos pertinentes
			dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(id_fase)
			
		end if
END CHOOSE
end event

type dw_fases_informes from u_dw within w_contratos_regularizacion
boolean visible = false
integer x = 1513
integer y = 924
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_fases_informes"
end type

type cb_4 from commandbutton within w_contratos_regularizacion
boolean visible = false
integer x = 2103
integer y = 352
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular &Hon."
end type

event clicked;st_calculo_honorarios st_hon

st_hon.id_fase = idw_1.getitemstring(1, 'id_fase')

CHOOSE CASE g_colegio
	CASE 'COAATCU'
		openwithparm(w_calculo_honorarios, st_hon)
	CASE 'COAATZ', 'COAATTER'
		openwithparm(w_calculo_honorarios_za, st_hon)
	CASE 'COAATGU'
		st_hon.admon = idw_fases_datos_exp.getitemstring(1, 'administracion')
		st_hon.fecha = idw_1.GetItemdatetime(1,'f_entrada')
		openwithparm(w_calculo_gastos_honorarios_gu, st_hon)
END CHOOSE

ids_honos = Message.PowerObjectParm

CHOOSE CASE g_colegio
	CASE 'COAATCU', 'COAATZ', 'COAATTER'
		if isvalid(ids_honos) then
			dw_pem_superficie.setitem(1, 'pem2', ids_honos.getitemnumber(1, 'presupuesto'))
			dw_pem_superficie.setitem(1, 'sup2', ids_honos.getitemnumber(1, 'superficie'))
			f_configura_parametros_fases_honos_cu (ids_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ids_honos, 'R')
		end if
	CASE 'COAATGU'
		if isvalid(ids_honos) then
			dw_pem_superficie.setitem(1, 'pem2', ids_honos.getitemnumber(1, 'presupuesto'))
			dw_pem_superficie.setitem(1, 'sup2', ids_honos.getitemnumber(1, 'superficie'))
			f_configura_parametros_fases_honos_gu (ids_honos.getitemstring(1,'tarifa'), idw_fases_cip_tfe, ids_honos, 'R')
		end if
END CHOOSE


end event

type dw_agrupar_act from u_dw within w_contratos_regularizacion
integer x = 1637
integer y = 12
integer width = 882
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_regularizacion_agrupar_act"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;// Recalculamos
dw_cip_musaat.post event csd_rellenar_cip_musaat_contrato(g_id_fase)

end event

type cbx_avisos_pendientes from checkbox within w_contratos_regularizacion
integer x = 1728
integer y = 1196
integer width = 745
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Incluir avisos pendientes:"
boolean lefttext = true
end type

