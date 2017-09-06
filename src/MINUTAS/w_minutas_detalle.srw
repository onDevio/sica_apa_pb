HA$PBExportHeader$w_minutas_detalle.srw
forward
global type w_minutas_detalle from w_response
end type
type cbx_f_gastos from checkbox within w_minutas_detalle
end type
type cbx_f_honos from checkbox within w_minutas_detalle
end type
type cbx_aviso from checkbox within w_minutas_detalle
end type
type cb_ver_f_gastos from commandbutton within w_minutas_detalle
end type
type cb_ver_f_honos from commandbutton within w_minutas_detalle
end type
type pb_cobrar from picturebutton within w_minutas_detalle
end type
type pb_salir from picturebutton within w_minutas_detalle
end type
type pb_ver_aviso from picturebutton within w_minutas_detalle
end type
type pb_grabar from picturebutton within w_minutas_detalle
end type
type cb_ver_recibo_musaat from commandbutton within w_minutas_detalle
end type
type cbx_f_musaat from checkbox within w_minutas_detalle
end type
type dw_historico from u_dw within w_minutas_detalle
end type
type dw_fases_datos_exp from u_dw within w_minutas_detalle
end type
type dw_clientes from u_dw within w_minutas_detalle
end type
type dw_colegiados from u_dw within w_minutas_detalle
end type
type dw_descuentos from u_dw within w_minutas_detalle
end type
type dw_estadistica from u_dw within w_minutas_detalle
end type
type dw_fases_src from u_dw within w_minutas_detalle
end type
type dw_fases_minutas from u_dw within w_minutas_detalle
end type
type dw_fases_detalle from u_dw within w_minutas_detalle
end type
type dw_composite from u_dw within w_minutas_detalle
end type
type dw_minuta from u_dw within w_minutas_detalle
end type
type dw_musaat from u_dw within w_minutas_detalle
end type
type dw_impresion from u_dw within w_minutas_detalle
end type
type gb_1 from groupbox within w_minutas_detalle
end type
type dw_factura_gastos from u_dw within w_minutas_detalle
end type
type dw_factura_honos from u_dw within w_minutas_detalle
end type
end forward

global type w_minutas_detalle from w_response
integer width = 2917
integer height = 1972
string title = "Avisos de Factura"
event csd_recalcular_todo ( string campo,  string dato )
event csd_nuevo ( )
event csd_cargar_datos_conceptos ( )
event type double csd_calcula_honos_col_cli ( )
event type double csd_calcula_dv ( )
event type double csd_calcula_musaat ( boolean movimiento )
event type double csd_calcula_cip ( )
event type double csd_dame_porc_col ( )
event type double csd_dame_porc_cli ( )
event type double csd_maximo_honos ( )
event csd_inhabilita ( )
event csd_cobrar ( )
event csd_ver_cunyo ( )
event csd_calcular_descuentos_auto ( )
event csd_poner_totales ( double porc_honos,  double base_honos )
event csd_cuadrar_aviso ( )
event csd_carta_autoliquidacion ( )
event type double csd_calcular_garantia ( )
event key_pressed pbm_keydown
event csd_irpf_colegiado ( )
event type double csd_dame_porc_col_cgc ( )
event csd_calcular_desplazamientos ( )
event csd_aviso_regularizacion ( )
event csd_modificacion_datos ( string idfase,  u_dw dw,  string nombre_dw,  string campo,  long row )
event type integer csd_control_estados ( )
event type double csd_calcula_musaat_fase ( )
event csd_colocar_observaciones ( )
event csd_calcular_libros ( )
event csd_calcular_tipo_minuta ( string id_colegiado,  string id_cliente )
event csd_calcular_gastos_cobro_min ( )
event type double csd_recalcular_cip ( )
event csd_verifica_musaat ( )
cbx_f_gastos cbx_f_gastos
cbx_f_honos cbx_f_honos
cbx_aviso cbx_aviso
cb_ver_f_gastos cb_ver_f_gastos
cb_ver_f_honos cb_ver_f_honos
pb_cobrar pb_cobrar
pb_salir pb_salir
pb_ver_aviso pb_ver_aviso
pb_grabar pb_grabar
cb_ver_recibo_musaat cb_ver_recibo_musaat
cbx_f_musaat cbx_f_musaat
dw_historico dw_historico
dw_fases_datos_exp dw_fases_datos_exp
dw_clientes dw_clientes
dw_colegiados dw_colegiados
dw_descuentos dw_descuentos
dw_estadistica dw_estadistica
dw_fases_src dw_fases_src
dw_fases_minutas dw_fases_minutas
dw_fases_detalle dw_fases_detalle
dw_composite dw_composite
dw_minuta dw_minuta
dw_musaat dw_musaat
dw_impresion dw_impresion
gb_1 gb_1
dw_factura_gastos dw_factura_gastos
dw_factura_honos dw_factura_honos
end type
global w_minutas_detalle w_minutas_detalle

type variables
datawindowchild i_dwc_colegiados, i_dwc_clientes
st_minutas_consulta i_st_minutas_consulta
u_dw idw_clientes, idw_colegiados, idw_descuentos, idw_fases_estadistica, idw_fases_datos_exp, idw_1, idw_fases_src
u_dw idw_fases_minutas
st_csi_articulos_servicios ist_datos_honorarios,  ist_datos_desplazamientos, ist_datos_dv
st_csi_articulos_servicios ist_datos_cip, ist_datos_musaat, ist_datos_retvol, ist_datos_impresos
string i_obra_admin, i_modulo, i_id_fase
boolean i_ya_recalculado = false, ib_cobro_aviso = false
n_csd_impresion_formato i_impresion_formato
double total_dv=0, id_base_cip
int i_aviso=0
end variables

forward prototypes
public function double f_total_movimientos_colegiado (string id_col)
public function double f_total_avisos_colegiado (string id_col)
public function integer f_guarda_dw (datawindow dw_actual, string id_consulta)
end prototypes

event csd_recalcular_todo(string campo, string dato);string tipo_gestion, id_col, id_cli, pagador, irpf_cliente = 'N'
double iva_honorarios=0, porcent_iva=0, porc_retvol=0, iva_desplaza=0, honos_base=0, desplaza_base=0, cip_base=0
double dv_base=0, musaat_base=0, retvol_base=0, honos_totales=0, desplaza_totales=0, dv_totales=0, cip_totales=0
double musaat_totales=0, retvol_totales=0, iva_cip=0, iva_dv=0, porcent_iva_honos=0, porcent_iva_desplaza=0
double porcent_iva_dv=0, porcent_iva_cip=0, total_colegiado=0, total_cliente=0, importe_irpf, porc_irpf, base_garantia
double porcent_iva_impresos=0, impresos_base=0, impresos_totales=0, iva_impresos=0, base_cip_suplida, iva_cip_suplida
double cip_suplida_totales, porcent_iva_cip_suplida, base_musaat_suplida, base_otros=0
boolean aplica_honos=false, aplica_desplaza=false, aplica_dv=false, aplica_cip=false, aplica_musaat=false
boolean aplica_retvol=false, aplica_impresos=false


tipo_gestion	= dw_minuta.getitemstring(1, 'tipo_gestion')
id_col 			= dw_minuta.getitemstring(1, 'id_colegiado')
id_cli 			= dw_minuta.getitemstring(1, 'id_cliente')
pagador 			= dw_minuta.getitemstring(1, 'pagador')
irpf_cliente	= dw_minuta.getitemstring(1, 'irpf_cliente')
porc_irpf 		= dw_minuta.getitemnumber(1, 'irpf')

// IVAS
porcent_iva 			= dw_minuta.getitemnumber(1, 'porc_iva')
porcent_iva_honos 	= dw_minuta.getitemnumber(1, 'porc_iva_honos')
porcent_iva_desplaza = dw_minuta.getitemnumber(1, 'porc_iva_desplaza')
porcent_iva_dv 		= dw_minuta.getitemnumber(1, 'porc_iva_dv')
porcent_iva_cip 		= dw_minuta.getitemnumber(1, 'porc_iva_cip')
porcent_iva_impresos = dw_minuta.getitemnumber(1, 'porc_iva_impresos')

// Aplicar
aplica_honos 		= (dw_minuta.getitemstring(1, 'aplica_honos') = 'S')
aplica_desplaza 	= (dw_minuta.getitemstring(1, 'aplica_desplaza') = 'S')
aplica_dv 			= (dw_minuta.getitemstring(1, 'aplica_dv') = 'S')
aplica_cip 			= (dw_minuta.getitemstring(1, 'aplica_cip') = 'S')
aplica_musaat 		= (dw_minuta.getitemstring(1, 'aplica_musaat') = 'S')
aplica_retvol 		= (dw_minuta.getitemstring(1, 'aplica_retvol') = 'S')
aplica_impresos 	= (dw_minuta.getitemstring(1, 'aplica_impresos') = 'S')

if f_es_vacio(id_cli) or f_es_vacio(id_col) then return

// Honorarios
honos_base = dw_minuta.getitemnumber(1,'base_honos')
iva_honorarios = f_redondea(honos_base * porcent_iva_honos / 100)
dw_minuta.setitem(1, 'iva_honos', iva_honorarios)
honos_totales = f_redondea(honos_base + iva_honorarios)
if irpf_cliente = 'S' then importe_irpf +=(honos_base * porc_irpf /100)
// Modificado Paco 20/4/2005. El f_redondea fallaba para un importe de honos de 306,9 y de IRPF de 15%. Incidencia 2405
importe_irpf=importe_irpf*100
importe_irpf =  round(importe_irpf,0)
importe_irpf= importe_irpf/100

// Desplazamientos
desplaza_base = dw_minuta.getitemnumber(1, 'base_desplaza')
iva_desplaza = f_redondea(desplaza_base * porcent_iva_desplaza / 100)
dw_minuta.setitem(1, 'iva_desplaza', iva_desplaza)
desplaza_totales = f_redondea(desplaza_base + iva_desplaza)
if g_aplica_irpf_en_desplaza = 'S' and irpf_cliente = 'S' then importe_irpf += f_redondea(desplaza_base * porc_irpf /100)

// Derechos de Visado
dv_base = dw_minuta.getitemnumber(1, 'base_dv')
iva_dv = f_redondea(dv_base * porcent_iva_dv / 100)
dw_minuta.setitem(1, 'iva_dv', iva_dv)
dv_totales = f_redondea(dv_base + iva_dv)

// CIP
cip_base = dw_minuta.getitemnumber(1, 'base_cip')
iva_cip = f_redondea(cip_base * porcent_iva_cip / 100)
dw_minuta.setitem(1, 'iva_cip', iva_cip)
cip_totales = f_redondea(cip_base + iva_cip)

// MUSAAT
musaat_base = dw_minuta.getitemnumber(1, 'base_musaat')
musaat_totales = musaat_base

// RET.VOL
porc_retvol = dw_minuta.getitemnumber(1, 'porc_retvol')
retvol_base  = f_redondea(honos_base * porc_retvol / 100)
dw_minuta.setitem(1, 'base_retvol', retvol_base)
retvol_totales = retvol_base

// GARANTIA
base_garantia = dw_minuta.getitemnumber(1, 'base_garantia')

// IMPRESOS
impresos_base = dw_minuta.getitemnumber(1, 'base_impresos')
iva_impresos = f_redondea(impresos_base * porcent_iva_impresos / 100)
dw_minuta.setitem(1, 'iva_impresos', iva_impresos)
impresos_totales = f_redondea(impresos_base + iva_impresos)

// OTROS (BONIF. MUSAAT EN LEON)
base_otros = dw_minuta.getitemnumber(1, 'base_otros')
if isnull(base_otros) then base_otros = 0

total_dv = 0

// TOTALES
choose case tipo_gestion
	case 'C'
		if aplica_honos then total_cliente += honos_totales
		if aplica_desplaza then total_cliente += desplaza_totales
		if aplica_retvol then total_cliente += retvol_totales else total_colegiado += retvol_totales
		// Cuando los derechos de visado no son gastos del colegiado
		if g_colegio <> 'COAATZ' and g_colegio <> 'COAATGU' and g_colegio <> 'COAATNA'  AND g_colegio <> 'COAATTER' then
			if aplica_dv then total_cliente += dv_totales else total_colegiado += dv_totales
		end if
		// Si los DV van en otra factura no se tienen en cuenta en el c$$HEX1$$e100$$ENDHEX$$lculo de Fact. Honos - Fact. Gastos
		if g_colegio = 'COAATAVI' then
			if aplica_dv then total_dv += dv_totales
		end if
		if aplica_cip then total_cliente += cip_totales else total_colegiado += cip_totales
		if aplica_musaat then total_cliente += musaat_totales else total_colegiado += musaat_totales
		if importe_irpf > 0 then 
			total_cliente -= importe_irpf
		else
			total_cliente += importe_irpf
		end if
		if base_garantia > 0 then 
			total_cliente -= base_garantia
		else
			total_cliente += base_garantia
		end if
		// Cuando los libros no son gastos del colegiado
		if g_colegio <> 'COAATZ' and g_colegio <> 'COAATGU' and g_colegio <> 'COAATLE' AND g_colegio <> 'COAATTER' then
			if aplica_impresos then total_cliente += impresos_totales else total_colegiado += impresos_totales
		end if
		if g_colegio = 'COAATGC' then
			// Tiene 2 campos nuevos para los suplidos
			// Suplido CIP (SOLO COAATGC)
			if dw_minuta.getitemnumber(1, 'base_cip_suplida')<>0 then
				base_cip_suplida = dw_minuta.getitemnumber(1, 'base_cip_suplida')
				porcent_iva_cip_suplida = dw_minuta.getitemnumber(1, 'porc_iva_cip_suplida')
				iva_cip_suplida = f_redondea(base_cip_suplida * porcent_iva_cip_suplida / 100)
				dw_minuta.setitem(1, 'iva_cip_suplida', iva_cip_suplida)
				cip_suplida_totales = f_redondea(base_cip_suplida + iva_cip_suplida)
				total_cliente += cip_suplida_totales
			end if
			// Suplido MUSAAT (SOLO COAATGC)
			if dw_minuta.getitemnumber(1, 'musaat_suplida')<>0 then
				base_musaat_suplida = dw_minuta.getitemnumber(1, 'musaat_suplida')
				total_cliente += base_musaat_suplida
			end if
		end if
		if g_colegio = 'COAATLE' then total_colegiado += base_otros // Bonif. Musaat
		
	case 'A'
		total_cliente = 0
		// En GC los campos dv y RETVOL no se usan como tales!
		/*if not aplica_dv then*/ total_colegiado += dv_totales
		/*if not aplica_cip then*/ total_colegiado += cip_totales
		/*if not aplica_musaat then*/ total_colegiado += musaat_totales		
		/*if not aplica_retvol then*/ total_colegiado += retvol_totales
		if base_garantia > 0 then
			messagebox(g_titulo, 'Avise en contabilidad , este contrato tiene garant$$HEX1$$ed00$$ENDHEX$$a y hay que devolverla al colegiado')
			// Generar liquidacion por la prenda
		end if
		total_colegiado += impresos_totales
		if g_colegio = 'COAATLE' then total_colegiado += base_otros // Bonif. Musaat

	case 'S'
		choose case pagador
			case '1','2' //colegiado o empresa
				total_cliente = 0
				if aplica_dv then total_colegiado += dv_totales
				if aplica_cip then total_colegiado += cip_totales
				if aplica_musaat then total_colegiado += musaat_totales
				if aplica_impresos then total_colegiado += impresos_totales
				if g_colegio = 'COAATLE' then total_colegiado += base_otros // Bonif. Musaat
				
			case '3' //cliente
				total_colegiado = 0
				if aplica_dv then total_cliente += dv_totales
				if aplica_cip then total_cliente += cip_totales
				if aplica_musaat then total_cliente += musaat_totales	
				if aplica_impresos then total_cliente += impresos_totales
		end choose
end choose

if tipo_gestion = 'C' or tipo_gestion = 'A' then
	importe_irpf = f_redondea(importe_irpf)
else
	importe_irpf = 0
end if

// Avisamos si le est$$HEX1$$e100$$ENDHEX$$n poniendo IRPF a una sociedad
if importe_irpf > 0 and f_colegiado_tipopersona(id_col)='S' then
	messagebox(g_titulo, "ATENCION: El colegiado es una sociedad y el importe IRPF es mayor que cero")
end if

dw_minuta.setitem(1, 'importe_irpf', importe_irpf)
dw_minuta.setitem(1, 'total_colegiado', total_colegiado)
dw_minuta.setitem(1, 'total_cliente', total_cliente)
if tipo_gestion = 'C' or tipo_gestion = 'A' then
	if total_colegiado > total_cliente then
		THIS.post EVENT csd_cuadrar_aviso()
	end if
end if

end event

event csd_nuevo();string id_col_inicial, id_cli_inicial, tipo_registro
double porc_retvol = 0

dw_minuta.EVENT pfc_addrow()	
dw_minuta.setitem(1, 'id_fase', i_st_minutas_consulta.id_fase)
dw_minuta.setitem(1, 'fecha', datetime(today(),now()))
//Paga el cliente
dw_minuta.setitem(1, 'pagador', '3')
dw_minuta.setitem(1, 'irpf', g_irpf_por_defecto)
dw_minuta.setitem(1, 't_iva', g_t_iva_defecto)
dw_minuta.setitem(1, 'porc_iva', f_dame_porcent_iva(g_t_iva_defecto))
dw_minuta.setitem(1, 'irpf', g_irpf_por_defecto)

dw_minuta. event csd_cargar_dddw()

// Si s$$HEX1$$f300$$ENDHEX$$lo hay un colegiado lo ponemos por defecto
if i_dwc_colegiados.rowcount() = 1 then
	id_col_inicial = i_dwc_colegiados.getitemstring(1, 'id_col')
	dw_minuta.setitem(1, 'id_colegiado', id_col_inicial)	
	this.post event csd_irpf_colegiado()
	
	//Modificado Ricardo 2005-02-22
	// Creado por Ricardo para ver si no tengo que hacer mas!!
	st_control_eventos c_evento
	c_evento.id_colegiado = id_col_inicial
	c_evento.evento = 'MINUTA_COLEGIADOS'
	c_evento.dw = dw_minuta 
	f_control_eventos(c_evento)
	//fin Modificado Ricardo 2005-02-22
end if

// Si s$$HEX1$$f300$$ENDHEX$$lo hay un cliente lo ponemos por defecto
if i_dwc_clientes.rowcount() = 1 then
	id_cli_inicial = i_dwc_clientes.getitemstring(1, 'id_cliente')
	dw_minuta.setitem(1, 'id_cliente', id_cli_inicial)
	// Modificado Ricardo 04/02/16
	dw_minuta.setitem(1, 'irpf_cliente', f_clientes_irpf_cliente(id_cli_inicial))
	// FIN Modificado Ricardo 04/02/16
end if

//Paco 25/8/2005. Una vez tenemos el colegiado y el cliente ponemos el tipo de minuta m$$HEX1$$e100$$ENDHEX$$s adecuado.
if not f_es_vacio(id_col_inicial) and not f_es_vacio(id_cli_inicial) then this.post event csd_calcular_tipo_minuta(id_col_inicial, id_cli_inicial)

// Ponemos los tipos de IVA y porcentajes por defecto
dw_minuta.setitem(1, 't_iva_honos', ist_datos_honorarios.t_iva)
dw_minuta.setitem(1, 'porc_iva_honos', f_dame_porcent_iva(ist_datos_honorarios.t_iva))
dw_minuta.setitem(1, 't_iva_desplaza', ist_datos_desplazamientos.t_iva)
dw_minuta.setitem(1, 'porc_iva_desplaza', f_dame_porcent_iva(ist_datos_desplazamientos.t_iva))
dw_minuta.setitem(1, 't_iva_dv', ist_datos_dv.t_iva)
dw_minuta.setitem(1, 'porc_iva_dv', f_dame_porcent_iva(ist_datos_dv.t_iva))
dw_minuta.setitem(1, 't_iva_cip', ist_datos_cip.t_iva)
dw_minuta.setitem(1, 'porc_iva_cip', f_dame_porcent_iva(ist_datos_cip.t_iva))
dw_minuta.setitem(1, 't_iva_impresos', ist_datos_impresos.t_iva)
dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(ist_datos_impresos.t_iva))

// Configuraci$$HEX1$$f300$$ENDHEX$$n por defecto
dw_minuta.setitem(1, 'aplica_honos', 'S')
dw_minuta.setitem(1, 'aplica_desplaza', 'N')		
dw_minuta.setitem(1, 'aplica_dv', 'N')
dw_minuta.setitem(1, 'aplica_cip', 'N')
dw_minuta.setitem(1, 'aplica_musaat', 'N')
dw_minuta.setitem(1, 'aplica_retvol', 'N')

// Poner por defecto la descripcion del codigo de  honorarios gen$$HEX1$$e900$$ENDHEX$$rico
dw_minuta.setitem(1, 'concepto_honos', ist_datos_honorarios.descripcion)

// Porc. Retvol. por defecto para el colegiado
if g_colegio <> 'COAATGC' then
	porc_retvol = f_colegiados_ret_voluntaria(dw_minuta.getitemstring(1, 'id_colegiado'))
	dw_minuta.setitem(1, 'porc_retvol', porc_retvol)
end if

// Se coge el tipo de gesti$$HEX1$$f300$$ENDHEX$$n del colegiado
if f_tipo_gestion_colegiado(i_st_minutas_consulta.id_fase, id_col_inicial) = 'P' then
	dw_minuta.setitem(1, 'tipo_gestion', 'S')
	dw_minuta.event itemchanged(1, dw_minuta.object.tipo_gestion, 'S')
end if

// Cogemos el numero de contrato anterior si ya lo han introducido previamente
dw_minuta.setitem(1, 'n_contrato_ant', idw_1.getitemstring(1, 'n_contrato_ant'))


// Configuraciones por colegio
CHOOSE CASE g_colegio
	CASE 'COAATGC'
		dw_minuta.setitem(1, 't_iva_cip_suplida', ist_datos_cip.t_iva)
		dw_minuta.setitem(1, 'porc_iva_cip_suplida', f_dame_porcent_iva(ist_datos_cip.t_iva))
		
	CASE 'COAATGUI'
		if dw_minuta.getitemstring(1,'tipo_gestion')='C' then dw_minuta.setitem(1, 'aplica_dv', 'S')
		
	CASE 'COAATTFE'
		string id_fase, tipo_gestion
		id_fase = dw_minuta.getitemstring(dw_minuta.getrow(),'id_fase')
		dw_minuta.setitem(dw_minuta.getrow(), 'reclamar', 'N') // Modificado Ricardo 04-07-06	
		tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion' )
		dw_minuta.event csd_configura_aplicas_tfe(tipo_gestion,id_fase)
	
	CASE 'COAATZ', 'COAATAVI'
		if dw_minuta.getitemstring(1,'tipo_gestion')='S' then dw_minuta.setitem(1, 'aplica_impresos', 'S')
		if dw_minuta.getitemstring(1,'tipo_gestion')='C' then 
			dw_minuta.setitem(1, 'aplica_impresos', 'S')
			dw_minuta.setitem(1, 'aplica_dv', 'S')
			dw_minuta.setitem(1, 'aplica_desplaza', 'S')
		end if
		
		// INC. 6037 Poner el importe de los libros y la descripci$$HEX1$$f300$$ENDHEX$$n en funci$$HEX1$$f300$$ENDHEX$$n del tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y obra
		// INC. 6569 Modificaci$$HEX1$$f300$$ENDHEX$$n de anterior incidencia
		string tipo_act, tipo_obra, t_iva, tipo_minuta
		double importe, impuesto
	
		// Necesito saber el tipo de minuta ahora
		if not f_es_vacio(id_col_inicial) and not f_es_vacio(id_cli_inicial) then event csd_calcular_tipo_minuta(id_col_inicial, id_cli_inicial)
		
		tipo_act = idw_1.getitemstring(1, 'fase')
		tipo_minuta = dw_minuta.getitemstring(1, 't_minuta')

		if tipo_minuta = 'I' then
			CHOOSE CASE tipo_act
				CASE '03', '04', '05', '11', '13'
					
					SELECT importe, t_iva, impuesto INTO :importe, :t_iva, :impuesto 
					FROM csi_articulos_servicios WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.impresos;
			
					dw_minuta.setitem(1, 'base_impresos', importe )
					dw_minuta.setitem(1, 'iva_impresos', impuesto )
					dw_minuta.setitem(1, 't_iva_impresos', t_iva )
					dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(t_iva))	
					
					if tipo_act = '11' or tipo_act = '13' then
						dw_minuta.setitem(1, 'concepto_otros','LIBRO DE ORDENES')
					else
						dw_minuta.setitem(1, 'concepto_otros','LIBRO DE INCIDENCIAS')
					end if
			END CHOOSE
		end if
		
	CASE 'COAATGU', 'COAATLE'
		if dw_minuta.getitemstring(1,'tipo_gestion')='S' then dw_minuta.setitem(1, 'aplica_impresos', 'S')
		if dw_minuta.getitemstring(1,'tipo_gestion')='C' then 
			if g_colegio = 'COAATGU' then dw_minuta.setitem(1, 'aplica_impresos', 'S')
			dw_minuta.setitem(1, 'aplica_dv', 'S')
			dw_minuta.setitem(1, 'aplica_desplaza', 'S')
		end if		
		// Ponemos la descripci$$HEX1$$f300$$ENDHEX$$n de los libros si no pone nada
		if g_colegio = 'COAATGU' and f_es_vacio(dw_minuta.getitemstring(1, 'concepto_otros')) then 
			dw_minuta.setitem(1, 'concepto_otros','LIBROS')
		end if
		if g_colegio = 'COAATLE' and f_es_vacio(dw_minuta.getitemstring(1, 'concepto_otros')) then 
			dw_minuta.setitem(1, 'concepto_otros','LIBROS INCIDENCIAS')
		end if
		// Por defecto en las SGC los dv los paga el colegiado
		if dw_minuta.getitemstring(1,'tipo_gestion')='S' then dw_minuta.setitem(1, 'paga_dv','C')

	CASE 'COAATNA'
		// Por defecto en las SGC los dv los paga el colegiado
		if dw_minuta.getitemstring(1,'tipo_gestion')='S' then dw_minuta.setitem(1, 'paga_dv','C')
		// Por defecto en las CGC los dv los paga el cliente
		if dw_minuta.getitemstring(1,'tipo_gestion')='C' then dw_minuta.setitem(1, 'aplica_dv', 'S')	
		
	case 'COAATTGN', 'COAATTEB', 'COAATMCA','COAATLL'
		int i
		// se agregan los campos de formulas para dic y musaat
		for i= 1 to idw_descuentos.rowcount()
			if idw_descuentos.getitemstring(i, 'tipo_informe') = g_codigos_conceptos.cip then dw_minuta.setitem(1, 'formula_cip', idw_descuentos.getitemstring(i, 'formula_sustituida'))	
			if idw_descuentos.getitemstring(i, 'tipo_informe') = g_codigos_conceptos.musaat_variable then dw_minuta.setitem(1, 'formula_musaat', idw_descuentos.getitemstring(i, 'formula_sustituida'))	
		next
		dw_minuta.setitem(1, 'aplica_dv', 'N')
		
			
		
	CASE 'COAATCC'
		dw_minuta.setitem(1, 'aplica_dv', 'N')
		
	CASE 'COAATTER'
		if not f_es_vacio(id_col_inicial) and not f_es_vacio(id_cli_inicial) then event csd_calcular_tipo_minuta(id_col_inicial, id_cli_inicial)
		tipo_act = idw_1.getitemstring(1, 'fase')
		tipo_minuta = dw_minuta.getitemstring(1, 't_minuta')
		if tipo_minuta = 'I' then
			CHOOSE CASE tipo_act
				CASE '03', '04', '05'
					
					SELECT importe, t_iva, impuesto INTO :importe, :t_iva, :impuesto 
					FROM csi_articulos_servicios WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.libro_incidencias;
			
					dw_minuta.setitem(1, 'base_impresos', importe )
					dw_minuta.setitem(1, 'iva_impresos', impuesto )
					dw_minuta.setitem(1, 't_iva_impresos', t_iva )
					dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(t_iva))
					dw_minuta.setitem(1, 'concepto_otros','LIBRO DE INCIDENCIAS')
			END CHOOSE
			if dw_minuta.getitemstring(1,'tipo_gestion')='S' then dw_minuta.setitem(1, 'aplica_impresos', 'S')
			if dw_minuta.getitemstring(1,'tipo_gestion')='C' then 
				dw_minuta.setitem(1, 'aplica_impresos', 'S')
				dw_minuta.setitem(1, 'aplica_dv', 'S')
				dw_minuta.setitem(1, 'aplica_desplaza', 'S')
			end if
		end if
		
END CHOOSE

end event

event csd_cargar_datos_conceptos();ist_datos_honorarios.codigo = g_codigos_conceptos.honorarios
f_csi_articulos_servicios(ist_datos_honorarios)

ist_datos_desplazamientos.codigo = g_codigos_conceptos.desplazamientos
f_csi_articulos_servicios(ist_datos_desplazamientos)

ist_datos_dv.codigo = g_codigos_conceptos.dv
f_csi_articulos_servicios(ist_datos_dv)

ist_datos_cip.codigo = g_codigos_conceptos.cip
f_csi_articulos_servicios(ist_datos_cip)

ist_datos_musaat.codigo = g_codigos_conceptos.musaat_variable
f_csi_articulos_servicios(ist_datos_musaat)

ist_datos_retvol.codigo = g_codigos_conceptos.retvol
f_csi_articulos_servicios(ist_datos_retvol)

ist_datos_impresos.codigo = g_codigos_conceptos.impresos
f_csi_articulos_servicios(ist_datos_impresos)

if g_colegio = 'COAATGU' then
	if idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.libro_ordenes + "'",1,idw_descuentos.RowCount()) > 0 then
		ist_datos_impresos.codigo = g_codigos_conceptos.libro_ordenes
	end if
	if idw_descuentos.Find("tipo_informe = '" + g_codigos_conceptos.libro_incidencias + "'",1,idw_descuentos.RowCount()) > 0 then
		ist_datos_impresos.codigo = g_codigos_conceptos.libro_incidencias
	end if
	f_csi_articulos_servicios(ist_datos_impresos)
	// Vamos a proteger los campos de tipo de iva por si acaso
//	dw_minuta.settaborder('t_iva_honos', 0)
//	dw_minuta.settaborder('t_iva_impresos', 0)
end if

if g_colegio = 'COAATLE' or g_colegio = 'COAATTER' then
	ist_datos_impresos.codigo = g_codigos_conceptos.libro_incidencias
	f_csi_articulos_servicios(ist_datos_impresos)
end if

end event

event type double csd_calcula_honos_col_cli();double porc_col_real = 0, porc_cli_real = 0, honos_totales = 0 , honos_col_cli = 0

// % colegiado
if dw_minuta.getitemstring(1, 'tipo_gestion') = 'C' then
	porc_col_real = this.event csd_dame_porc_col_cgc()
else
	porc_col_real = this.event csd_dame_porc_col()
end if

// % cliente
porc_cli_real = this.event csd_dame_porc_cli()//porc_cli / suma_porc_cli
// Honos Totales
honos_totales = idw_1.getitemnumber(1, 'honorarios')
// Honos Totales de este col. a este cli.
honos_col_cli = f_redondea(honos_totales * porc_col_real * porc_cli_real)

// INC. 6996 - Avisamos si existe alguna minuta pendiente
string id_col, id_cli, id_fase, id_minuta, n_aviso
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')
id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_minuta = dw_minuta.getitemstring(1, 'id_minuta')

select n_aviso
into :n_aviso
from fases_minutas 
where id_colegiado = :id_col and id_cliente = :id_cli and 
		id_fase = :id_fase and id_minuta <> :id_minuta and pendiente = 'S' ;

if not f_es_vacio(n_aviso) and i_aviso = 0 then 
	messagebox(g_titulo, "Existe una minuta pendiente anterior de este colegiado", information!)
	i_aviso++
end if

return honos_col_cli

end event

event type double csd_calcula_dv();double dv_totales = 0, dv = 0, porc_col_real = 0, porc_cli_real = 0
string id_fase , id_col, id_cli
//DV
id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')
choose case dw_minuta.getitemstring(1, 'tipo_gestion')
	case 'C', 'A' // CIP relativa a honorarios
		dv_totales = f_dv_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		porc_cli_real = this.event csd_dame_porc_cli()
		// Miro en la BD
		IF f_total_avisado_dv_col_cli(id_fase, id_col, id_cli) > 0 then 
			// si tenia algo pasado entonces 0
			dv = 0
		else
			dv = max(( dv_totales * porc_col_real * porc_cli_real ) /*- f_total_avisado_dv_col_cli(id_fase, id_col, id_cli)*/, 0)
		end if
		//dw_descuentos.setitem(1, 'dv', dv_col)
		// Cuando hay varios colegiados y paga el cliente se mete el importe total en una sola factura
		if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATAVI' or g_colegio = 'COAATTER' then
			if f_total_avisado_dv_cliente(id_fase, id_cli) > 0 then
				dv = 0
			else
				dv = dv_totales * porc_cli_real
			end if
		end if
	case 'S'
		// Cogemos la cip del contrato, NO recalculamos otra vez
		dv_totales = f_dv_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		// Miro en la BD	
		if f_total_avisado_dv_colegiado(id_fase, id_col) > 0 then
			dv = 0
		else
			dv = max((dv_totales * porc_col_real) /*- f_total_avisado_dv_colegiado(id_fase, id_col)*/, 0)
		end if
		// Cuando hay varios colegiados y paga el cliente se mete el importe total en una sola factura
		if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATAVI'  or g_colegio = 'COAATTER' then
			dw_minuta.accepttext()
			if dw_minuta.getitemstring(1, 'paga_dv')='P' then
				if f_total_avisado_dv_contrato(id_fase) > 0 then 
					dv = 0
				else
					dv = dv_totales
				end if
			end if
		end if
		
end choose

dw_minuta.setitem(1, 'urgente', 'N')

dv = f_redondea(dv)
return dv

end event

event type double csd_calcula_musaat(boolean movimiento);string id_col, id_fase
int retorno
double musaat_col
string mensaje_funcionario = ''
st_musaat_datos st_musaat_datos
id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1,'id_colegiado')
int i, fila_colegiado = 0
string tipo_gestion
tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')

// Modifciado Ricardo 2005-06-14
// incic. 0000002726
if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' then
	st_musaat_datos.pem_certificacion = dw_minuta.GetItemNumber(1,'pem_certificacion') // Modificado Ricardo 2005-06-14
end if
//fin  Modificado Ricardo 2005-06-14
//MUSAAT, calculamos la base total
if g_colegio = 'COAATCC' and idw_colegiados.rowcount() = 1 then
	  SELECT fases_informes.cuantia_colegiado  
    INTO :musaat_col  
    FROM fases_informes  
  where ( fases_informes.id_fase = :id_fase ) And  
         ( fases_informes.tipo_informe = :g_codigos_conceptos.musaat_variable )   ;

else
if idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
	st_musaat_datos.porcentaje = this.event csd_dame_porc_col() * 100
	st_musaat_datos.genera_movi = FALSE
	st_musaat_datos.id_minuta = dw_minuta.getitemstring(1, 'id_minuta')

	st_musaat_datos.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
	st_musaat_datos.int_forzosa = f_musaat_dame_col_int_forzosa(id_col)
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if		
	musaat_col = st_musaat_datos.prima_comp		
end if
end if
//messagebox('kk1', string(musaat_col))
// Si Administraci$$HEX1$$f300$$ENDHEX$$n y es funcionario donde se realiza la obra entonces MUSAAT 0 y tipo 14
if st_musaat_datos.administracion = 'S' then
//	mensaje_funcionario = f_colegiado_funcionario_0(id_fase, id_col)
	for i = 1 to idw_colegiados.rowcount()
		if idw_colegiados.getitemstring(i, 'id_col' ) = id_col and idw_colegiados.getitemstring(i, 'facturado' ) = 'S' then
			fila_colegiado = i
			exit
		end if
	next
//	if idw_fases_colegiados 
	if fila_colegiado > 0 then
		musaat_col = 0
		st_musaat_datos.tipo_csd = '14'
		dw_minuta.setitem(1, 'tipo_minuta', st_musaat_datos.tipo_csd )
//		messagebox('kk11', string(musaat_col))
		return musaat_col
	end if
//	messagebox('kk2', string(musaat_col))
else
// Si no es de administracion, si hay una minuta ya pasada entonces MUSAAT es cero 
	if f_total_avisos_colegiado(id_col) > 0 then
//	messagebox('kk12', string(musaat_col))
		musaat_col = 0
		st_musaat_datos.tipo_csd = '00'
		dw_minuta.setitem(1, 'tipo_minuta', st_musaat_datos.tipo_csd )		
		return 0
	end if
//	messagebox('kk3', string(musaat_col))
end if
// Tipo movimiento csd : Solo primeros visados y certificaciones , las regularizaciones de pem y sup y las anulaciones y renuncias se haran por otro lado
// Quizas falta codificar la ultima certificacion
if musaat_col = 0 then  // Si no hay MUSAAT --> 00
	st_musaat_datos.tipo_csd = '00'
else
	if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' then
		if idw_1.getitemstring(1,'aplicado_10') = 'S' then
			// Modificado Ricardo 2005-06-13
			CHOOSE CASE dw_minuta.getitemString(1, 't_minuta')
				CASE 'I'
					st_musaat_datos.tipo_csd = '11'
				CASE 'P'
					st_musaat_datos.tipo_csd = '23' //Siguientes certificaci$$HEX1$$f300$$ENDHEX$$n
				CASE 'F'
					st_musaat_datos.tipo_csd = '25'
				CASE ELSE
					// ES lo que habia
					st_musaat_datos.tipo_csd = '23' //Siguientes certificaci$$HEX1$$f300$$ENDHEX$$n
			END CHOOSE
			// FIN Modificado Ricardo 2005-06-13
		else
			st_musaat_datos.tipo_csd = '12' // 100% seguridad 
		end if
	else
			st_musaat_datos.tipo_csd = '10' // 100% NO SEGURIDAD
	end if
end if
// Grabar el tipo de minuta en la minuta
dw_minuta.setitem(1, 'tipo_minuta', st_musaat_datos.tipo_csd )

// Si cobro por certificaciones...
if idw_1.getitemstring(1,'aplicado_10') = 'S' then
	if tipo_gestion <> 'S' then
		double honos_contrato, honos_pasados, porc_honos, porc_col
		// calculamos el porcentaje relativo
		porc_col = this.event csd_dame_porc_col()
		honos_contrato = idw_1.getitemnumber(1, 'honorarios') * porc_col
		honos_pasados = dw_minuta.getitemnumber(1, 'base_honos')
		if honos_contrato = 0 or isnull(honos_contrato) then honos_contrato = 1
		porc_honos = honos_pasados / honos_contrato
		// Calculamos la MUSAAT relativa a los honorarios quitando el 10% que ya se le cobro al ser obra oficial
		if g_obra_admin_cgc_aplica_10 = 'N' then
			musaat_col = (musaat_col * 1) * porc_honos
		else
			// Si no cobraron el 10% deberiamos cobrar sobre la base del 100%
			musaat_col = (musaat_col * 0.9) * porc_honos
		end if
	else
		// Si es sin gestion de cobro se cobra el resto
		if g_obra_admin_cgc_aplica_10 = 'N' then
			musaat_col = (musaat_col * 1) * porc_honos
		else
			// Si no cobraron el 10% deberiamos cobrar sobre la base del 100%			
			musaat_col = (musaat_col * 0.9)
		end if
	end if
// Si cobro total ...
//messagebox('kk4', string(musaat_col))
else
	// Miro en la BD
	// Si hay mas de un movimiento y suman mas de 1 unidad (euros)
	if f_tiene_movi_musaat(id_fase, id_col, false) and (f_total_movimientos_colegiado(id_col) > 1) then 
		musaat_col = 0
//		messagebox('kk5', string(musaat_col))
	else
		musaat_col = max(musaat_col - f_total_avisado_musaat_colegiado(id_fase, id_col),0)
//		messagebox('kk6', string(musaat_col))
	end if
end if

musaat_col = f_redondea(musaat_col)
//messagebox('kk7', string(musaat_col))
if musaat_col = 0 then  
	st_musaat_datos.tipo_csd = '00'
	dw_minuta.setitem(1, 'tipo_minuta', st_musaat_datos.tipo_csd )
end if
//messagebox('kk8', string(musaat_col))

// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(id_col),1) = 'R' then
	dw_minuta.setitem(1, 'base_otros', f_redondea(musaat_col*g_porc_bonif_musaat*(-1)))
end if

return musaat_col
end event

event type double csd_calcula_cip();double cip_totales=0,  porc_col_real=0, cip=0, honos_contrato=0, honos_pasados=0, porc_honos=0, honos_contrato_col_cli=0
double honos_pasados_contrato=0, porc_cli_real=0, cip_col_cli=0
string id_fase, id_col, id_cli

id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')

if g_colegio='COAATTEB' or g_colegio='COAATTGN'  OR g_colegio='COAATLL'  then
	return this.event csd_recalcular_cip()
end if
CHOOSE CASE dw_minuta.getitemstring(1, 'tipo_gestion')
	CASE 'C', 'A' // CIP relativa a honorarios
		// Excepci$$HEX1$$f300$$ENDHEX$$n
		if g_colegio = 'COAATLE' and dw_minuta.getitemdatetime(1, 'fecha') < datetime(date("01/01/1997")) then 
			cip = f_redondea(dw_minuta.getitemnumber(1, 'base_honos') * 0.05)
			return cip
		end if
		// Excepci$$HEX1$$f300$$ENDHEX$$n
		if g_colegio = 'COAATAVI' and year(date(idw_1.getitemdatetime(1, 'f_entrada'))) = 1995 then 
			cip = f_redondea(dw_minuta.getitemnumber(1, 'base_honos') * 0.07)
			return cip
		end if		
		// Cogemos la cip del contrato, NO recalculamos otra vez
		cip_totales = f_cip_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		// Divimos importe entre los clientes
		if g_colegio = 'COAATAVI' then
			porc_cli_real = this.event csd_dame_porc_cli()
			cip =  f_redondea(max((cip_totales * porc_col_real * porc_cli_real) -  f_total_avisado_cip_col_cli(id_fase, id_col, id_cli), 0)) 
			return cip
		end if		
		// No calculamos la cip relativa a los honorarios, si est$$HEX2$$e1002000$$ENDHEX$$as$$HEX2$$ed002000$$ENDHEX$$configurado
		if g_cip_cgc_toda = 'S' then
			cip = f_redondea(max((cip_totales * porc_col_real) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0))
			// en minutas CGC en teruel se a$$HEX1$$f100$$ENDHEX$$ade 6
			if g_colegio = 'COAATTER' then
				 cip += 6
			end if	
			
			return cip
		end if
		// Si ya se ha cobrado la cip anteriormente, no se vuelve a cobrar
		if max((f_redondea(cip_totales * porc_col_real)) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0) = 0 then 
			cip = 0
			return cip
		end if
		// calculamos el porcentaje relativo
		honos_contrato = idw_1.getitemnumber(1, 'honorarios')
		honos_pasados = dw_minuta.getitemnumber(1, 'base_honos')
		// Si no han metido los honorarios en el contrato no podemos calcular el porcentaje y tampoco la cip
		if honos_contrato = 0 or isnull(honos_contrato) then 
			honos_contrato = 1
		else
			porc_honos = honos_pasados / honos_contrato
		end if
		// Calculamos la CIP relativa a los honorarios
		cip = cip_totales * porc_honos //- f_total_avisado_cip_col_cli(id_fase, id_col, id_cli) )
		double porc_col_cgc
		porc_col_cgc = this.event csd_dame_porc_col_cgc()
		if porc_col_cgc <> 0 then cip = cip * (1 / porc_col_cgc) * porc_col_real
		// Si hemos pasado el 100% de los honorarios que regularize la CIP
		porc_cli_real = this.event csd_dame_porc_cli()
		honos_pasados_contrato = f_total_avisado_honos_col_cli(id_fase, id_col, id_cli)
		// Le sumo los honorarios actuales
		honos_pasados_contrato += honos_pasados 
		honos_contrato_col_cli = f_redondea(honos_contrato * ( porc_col_real  ) * ( porc_cli_real  ) )
		if honos_contrato_col_cli = honos_pasados_contrato then
			cip = f_cip_contrato_dw(idw_descuentos)
			cip_col_cli = f_redondea(cip * ( porc_col_real  ) * ( porc_cli_real  ))
//			messagebox(g_titulo, 'Se va a regularizar la Cip debido a un cambio de la misma desde su valor inicial')
			cip = cip_col_cli - f_total_avisado_cip_col_cli(id_fase, id_col, id_cli)
		end if
	
	CASE 'S' // Resto CIP colegiado. Restar lo q ya tenga pasado
		// Cogemos la cip del contrato, NO recalculamos otra vez
		cip_totales = f_cip_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		// miro en la BD
		cip = max((cip_totales * porc_col_real) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)
END CHOOSE

if isnull(cip) then cip = 0
cip = f_redondea(cip)

return cip

end event

event type double csd_dame_porc_col();int fila_colegiado = 0, i = 0
string id_col
double porc_col = 0, suma_porc_col = 0, porc_col_real = 0
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
// % colegiado
fila_colegiado = idw_colegiados.find("id_col = '" + id_col+"'", 1, idw_colegiados.rowcount())
if fila_colegiado <= 0 then 
	messagebox(g_titulo, 'No se encuentra el % del colegiado')
	return -1
end if
porc_col = idw_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
// MODIFICADO PACO 05/05/2004
for i = 1 to idw_colegiados.rowcount()
	/*if idw_colegiados.getitemstring(i, 'renunciado') <>  'S' then*/ 
	suma_porc_col += idw_colegiados.getitemnumber(i, 'porcen_a')
next
if suma_porc_col = 0 or isnull(suma_porc_col) then suma_porc_col = 1

// se valida cuando se tenga un colegiado con porc < 100 para que calcule correctamente el musaat
if idw_colegiados.rowcount() = 1 and porc_col<100 then suma_porc_col=100

porc_col_real = porc_col / suma_porc_col

return porc_col_real
end event

event type double csd_dame_porc_cli();string id_cli
int fila_cliente = 0, i = 0
double porc_cli = 0, suma_porc_cli  =  0, porc_cli_real = 0
id_cli = dw_minuta.getitemstring(1, 'id_cliente')

// % cliente
fila_cliente = idw_clientes.find("id_cliente = '" + id_cli + "'", 1, idw_clientes.rowcount())
if fila_cliente <= 0 then 
	messagebox(g_titulo, 'No se encuentra el % del cliente')
	return -1
end if
porc_cli = idw_clientes.getitemnumber(fila_cliente, 'porcen')
for i = 1 to idw_clientes.rowcount()
	suma_porc_cli += idw_clientes.getitemnumber(i, 'porcen')
next
if suma_porc_cli = 0 or isnull(suma_porc_cli) then suma_porc_cli = 1
porc_cli_real = porc_cli / suma_porc_cli

return porc_cli_real
end event

event csd_maximo_honos;string id_col, id_cli, id_fase
double total_col_cli = 0, total_avisado_col_cli = 0, maximo = 0

id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')
id_fase =  dw_minuta.getitemstring(1, 'id_fase')
total_col_cli = this.event csd_calcula_honos_col_cli()
total_avisado_col_cli = f_total_avisado_honos_col_cli(id_fase,id_col,id_cli)
maximo = max( total_col_cli - total_avisado_col_cli, 0)
return maximo
end event

event csd_inhabilita();if dw_minuta.getitemstring(1, 'anulada') = 'S' or dw_minuta.getitemstring(1, 'pendiente') = 'N' or i_modulo = 'AVISOS' then
	dw_minuta.enabled = false
	pb_cobrar.enabled = false
else
	dw_minuta.enabled = true
	pb_cobrar.enabled = true

end if

// MODIFICADO RICARDO 2005-02-03
// Caso especial son los pendientes con forma de pago 'PA'. 
// No dejamos tocar ya que la factura de honorarios ya est$$HEX2$$e1002000$$ENDHEX$$generada
if dw_minuta.getitemstring(1, 'pendiente') = 'S' and dw_minuta.getitemstring(1, 'forma_pago') = g_formas_pago.pendientes_abono then
	dw_minuta.enabled = false
end if

end event

event csd_cobrar();string id_fase, id_col, id_cli, nif_cli, modificacion, idfase, fase
st_musaat_datos datos_musaat
long   fila
int i
boolean pasar_funcionario = true

// MODIFICADO RICARDO 2004-08-12
//openwithparm(w_pago_facturas, dw_minuta.getitemstring(1, 'id_minuta'))
//IF upper(MESSAGE.stringparm) = 'CANCELAR' then return
st_caja_cobros parametros

parametros.tipo = 'MINUTAS'
//parametros.tipo = 'AVISOS'
parametros.dw = dw_minuta
	
openwithparm(w_caja_pagos, parametros)
//openwithparm(w_caja_pagos_multiples, parametros)

// Obtenemos los datos de vuelta
if isvalid(message.powerobjectparm) then
	parametros = message.powerobjectparm
else
	parametros.realizado = false
end if
if not parametros.realizado then return

// FIN MODIFICADO RICARDO 2004-08-12

// Recuperar datos
id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')
// Marcar la prenda como pagada
if dw_minuta.getitemnumber(1, 'base_garantia') <> 0 then
	f_marcar_garantia_pagada(id_fase, id_col, id_cli)
end if
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
		
		datos_musaat.doble_condicion = f_musaat_dame_col_doble_cond(dw_minuta.getitemstring(1, 'id_colegiado'))
		datos_musaat.int_forzosa = f_musaat_dame_col_int_forzosa(dw_minuta.getitemstring(1, 'id_colegiado'))	
		
		f_musaat_calcula_prima(datos_musaat)
	end if
end if

if leftA(dw_minuta.getitemstring(1, 'tipo_minuta'),1) = '6' and dw_minuta.getitemnumber(1, 'base_musaat') = 0 then
	// Modificaciones normas MUSAAT 2009. Se genera movimiento con importe 0
	datetime f_mov_tipo6, f_mov_tipo1
	date f_aux
	f_aux = date(f_musaat_fecha_visado_movimiento(id_fase))
	f_mov_tipo6 = f_ultimo_dia_mes(datetime(today()))
	f_mov_tipo1 = f_ultimo_dia_mes(datetime(date(string(day(f_aux))+"/"+string(month(f_aux)+1)+"/"+string(year(f_aux)+4)), time('00:00:00')))
	if f_mov_tipo6 > f_mov_tipo1 and f_aux <> date('1/1/1900') then
		st_musaat_datos st_musaat_datos
		st_musaat_datos.n_visado = id_fase
		st_musaat_datos.recuperar = true
		st_musaat_datos.genera_movi = true
		st_musaat_datos.id_col = id_col
		st_musaat_datos.cobertura = 0 // ICT-65
		st_musaat_datos.porcentaje_devolucion = dw_minuta.getitemnumber(1, 'cantidad')
		st_musaat_datos.importe_sobre_honos = 0
		st_musaat_datos.tipo_csd = dw_minuta.getitemstring(1, 'tipo_minuta')
		datos_musaat.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
		datos_musaat.int_forzosa = f_musaat_dame_col_int_forzosa(id_col)			

		if f_colegiado_tipopersona(id_col) = 'S' then	
			f_musaat_calcula_prima_sociedad(st_musaat_datos)
		else
			f_musaat_calcula_prima(st_musaat_datos)	
		end if
		messagebox(g_titulo, "Se ha generado el movimiento de renuncia con prima 0.")
	end if	
end if

//Se guarda la modificaci$$HEX1$$f300$$ENDHEX$$n de cobro en el hist$$HEX1$$f300$$ENDHEX$$rico
ib_cobro_aviso = true

fila = dw_historico.triggerevent("pfc_addrow")

modificacion = "COBRO" + ' ' +"aviso= " + dw_minuta.getitemstring(dw_minuta.getrow(), "n_aviso") + '; ' + "total= " + string(dw_minuta.getitemnumber(dw_minuta.getrow(),"total"))	

// Se actualiza la dw de modificaciones oculta
dw_historico.setitem(fila,'id_colegiado',id_fase)
dw_historico.setitem(fila,'modificacion',modificacion)
dw_historico.setitem(fila,'fecha',datetime(today(),now()))
dw_historico.setitem(fila,'usuario',g_usuario)

if dw_historico.update() = 1 then
	commit;
end if


close(this)

end event

event csd_ver_cunyo();//if dw_minuta.getitemstring(1, 'pendiente')  = 'N' then
//	dw_minuta.object.t_anulada.text = 'PAGADA'
//	dw_minuta.object.t_anulada.Color = f_color_azul()	
//end if
//
//if dw_minuta.getitemstring(1, 'anulada')  = 'S' then
//	dw_minuta.object.t_anulada.text = 'ANULADA'
//	dw_minuta.object.t_anulada.Color = f_color_rojo()
//end if
end event

event csd_calcular_descuentos_auto();string tipo_gestion, id_col, nif_cli, id_cli, id_fase
double base_garantia = 0

tipo_gestion =  dw_minuta.getitemstring(1, 'tipo_gestion')

// Estamos regularizando no se deben recalcular los importes
if dw_minuta.getitemstring(1, 'tipo_minuta') = '20' then return

choose case tipo_gestion
	case 'A', 'C'
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_dv)
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_cip)
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_retvol)
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_dev_garan)		
		
		// En el colegio de la rioja no hay que aplicar la musaat. Solo a su peticiones
		if g_colegio <> 'COAATLR' then
			dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_musaat)
		else
			// Ahora si que se aplica musaat - DAVID 22-04-2004
			dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_musaat)
			// dw_minuta.setitem(1, 'base_musaat', 0)
			// Solo en este caso colocamos los desplazamientos
			this.trigger event csd_calcular_desplazamientos()
		end if

		// Ponemos los desplazamientos
		if g_colegio = 'COAATTFE' or g_colegio = 'COAATB' /*or g_colegio = 'COAATZ'*/ then 
			this.trigger event csd_calcular_desplazamientos()
		end if

		if g_colegio = 'COAATGU' then this.trigger event csd_calcular_libros()

		// En Le$$HEX1$$f300$$ENDHEX$$n no se calculan los libros, se coge el importe predeterminado
		// if g_colegio = 'COAATLE' then dw_minuta.setitem(1, 'base_impresos', ist_datos_impresos.importe)
		
		if g_colegio = 'COAATNA' then this.trigger event csd_calcular_gastos_cobro_min()
		
	case 'S'
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_dv)
		dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_cip)
		
		// En el colegio de la rioja no hay que aplicar la musaat. Solo a su peticiones
		if g_colegio <> 'COAATLR' then
			dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_musaat)
		else
			// Ahora si que se aplica musaat - DAVID 22-04-2004
			dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_musaat)
			// dw_minuta.setitem(1, 'base_musaat', 0)
		end if

		dw_minuta.setitem(1, 'porc_honos', 0)
		dw_minuta.setitem(1, 'base_honos', 0)
		dw_minuta.setitem(1, 'iva_honos', 0)
		dw_minuta.setitem(1, 'base_desplaza', 0)
		dw_minuta.setitem(1, 'iva_desplaza', 0)
		dw_minuta.setitem(1, 'porc_retvol', 0)
		dw_minuta.setitem(1, 'base_retvol', 0)

		if g_colegio = 'COAATGU' then this.trigger event csd_calcular_libros()

		// En Le$$HEX1$$f300$$ENDHEX$$n no se calculan los libros, se coge el importe predeterminado
		// if g_colegio = 'COAATLE' then dw_minuta.setitem(1, 'base_impresos', ist_datos_impresos.importe)
end choose

CHOOSE CASE g_colegio
	CASE 'COAATLR'
		this.trigger event csd_colocar_observaciones()
END CHOOSE   

end event

event csd_poner_totales;dw_minuta.setitem(1, 'porc_honos', porc_honos)
dw_minuta.setitem(1, 'base_honos', base_honos)

end event

event csd_cuadrar_aviso;//double total_colegiado, total_cliente, base_cip, base_musaat, base_dv, base_retvol
//string aplica_cip
//total_colegiado = dw_minuta.getitemnumber(1, 'total_colegiado')
//total_cliente = dw_minuta.getitemnumber(1, 'total_cliente')
//aplica_cip = dw_minuta.getitemstring(1, 'aplica_cip')
//base_cip = dw_minuta.getitemnumber(1, 'base_cip')
//if aplica_cip = 'N' then
//	total_colegiado = total_colegiado - base_cip
//	
//	
//end if
end event

event csd_carta_autoliquidacion();double honos,iva_minuta
datastore ds_recibi_sin_gestion
ds_recibi_sin_gestion = CREATE DATASTORE
ds_recibi_sin_gestion.DATAOBJECT = g_informe_autoliquidacion

ds_recibi_sin_gestion.insertrow(0)
ds_recibi_sin_gestion.setitem(1, 'descripcion', f_dame_desc_tipo_actuacion(idw_1.getitemstring(1, 'fase')))
ds_recibi_sin_gestion.setitem(1, 'cliente', f_fases_promotores_fase(idw_1.getitemstring(1, 'id_fase')))
ds_recibi_sin_gestion.setitem(1, 'emplazamiento', idw_1.getitemstring(1, 'emplazamiento'))
ds_recibi_sin_gestion.setitem(1, 'n_contrato', idw_1.getitemstring(1, 'n_registro'))
ds_recibi_sin_gestion.setitem(1, 'n_aviso', dw_minuta.getitemstring(1, 'n_aviso'))
ds_recibi_sin_gestion.setitem(1, 'importe_aviso', dw_minuta.getitemnumber(1, 'base_honos'))
ds_recibi_sin_gestion.setitem(1, 'gastos', dw_minuta.getitemnumber(1, 'total_aviso'))
ds_recibi_sin_gestion.setitem(1, 'n_col', f_colegiado_n_col(dw_minuta.getitemstring(1, 'id_colegiado')))
ds_recibi_sin_gestion.setitem(1, 'colegiado', f_colegiado_apellido(dw_minuta.getitemstring(1, 'id_colegiado')))
CHOOSE CASE g_colegio
	CASE 'COAATTFE'
		// Para el colegio de tenerife lo que se pone en el importe_aviso es lo que se le deberia de haber cobrado al cliente
		ds_recibi_sin_gestion.setitem(1, 'honorarios', dw_minuta.getitemnumber(1, 'base_honos')+dw_minuta.getitemnumber(1, 'iva_honos'))
		ds_recibi_sin_gestion.setitem(1, 'desplazamientos', dw_minuta.getitemnumber(1, 'base_desplaza')+dw_minuta.getitemnumber(1, 'iva_desplaza'))
	CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATTER','COAATMCA','COAATLL'
		double dip, iva, src
		string gastos, n_salida
		// modificado ricardo 2005-03-11
		// Habria que generar el numero de salida primero
		n_salida = f_fases_cambia_estado_fase_segun_pagado(dw_minuta.getitemstring(1, 'id_fase'), 'SOLO_N_SALIDA')
		// fin modificado ricardo 2005-03-11
		dip = dw_minuta.getitemnumber(1, 'base_cip')
		iva = dw_minuta.getitemnumber(1, 'iva_cip')
		src = dw_minuta.getitemnumber(1, 'base_musaat')
		gastos = string(dip, '#,##0.00') + ' (DIP)    ' + string(iva, '#,##0.00') + ' (IVA)    ' + string(src, '#,##0.00') + ' (SRC)'
		ds_recibi_sin_gestion.setitem(1, 'gastos', gastos)
		ds_recibi_sin_gestion.setitem(1, 'iva_minuta', dw_minuta.getitemnumber(1, 'iva_honos'))
		ds_recibi_sin_gestion.setitem(1, 'irpf_minuta', dw_minuta.getitemnumber(1, 'importe_irpf'))
		ds_recibi_sin_gestion.setitem(1, 'n_contrato', n_salida)// modificado ricardo 2005-03-11
END CHOOSE



//CZA-95
if g_colegio='COAATZ' then
	honos=dw_minuta.getitemnumber(1, 'base_honos')
	iva_minuta=dw_minuta.getitemnumber(1, 'iva_honos')
	if dw_minuta.GetItemString(1,'aplica_desplaza')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_desplaza')		
		iva_minuta+=dw_minuta.getitemnumber(1, 'iva_desplaza')				
	end if
	if dw_minuta.GetItemString(1,'aplica_dv')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_dv')		
		iva_minuta+=dw_minuta.getitemnumber(1, 'iva_dv')				
	end if
	if dw_minuta.GetItemString(1,'aplica_cip')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_cip')		
		iva_minuta+=dw_minuta.getitemnumber(1, 'iva_cip')						
	end if
	if dw_minuta.GetItemString(1,'aplica_musaat')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_musaat')
	end if
	if dw_minuta.GetItemString(1,'aplica_impresos')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_impresos')		
		iva_minuta+=dw_minuta.getitemnumber(1, 'iva_impresos')						
	end if
	if dw_minuta.GetItemString(1,'aplica_retvol')='S' then
		honos+=dw_minuta.getitemnumber(1, 'base_retvol')		
		iva_minuta+=dw_minuta.getitemnumber(1, 'iva_retvol')						
	end if	
	
	ds_recibi_sin_gestion.setitem(1, 'importe_aviso', honos)
	ds_recibi_sin_gestion.setitem(1, 'iva_minuta',iva_minuta)	
	
end if




ds_recibi_sin_gestion.print()
if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' then ds_recibi_sin_gestion.print()

end event

event type double csd_calcular_garantia();string id_fase, id_col, id_cli, nif_cli
double base_garantia = 0
string tipo_gestion
double honos_contrato = 0, honos_pasados = 0, honos_pasados_contrato = 0, honos_contrato_col_cli = 0
double porc_col_real =  0 , porc_cli_real = 0

id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')
tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')
if tipo_gestion = 'C' or tipo_gestion = 'A' then
	porc_col_real = this.event csd_dame_porc_col()
	porc_cli_real = this.event csd_dame_porc_cli()	
	honos_contrato = idw_1.getitemnumber(1, 'honorarios')
	honos_contrato_col_cli = f_redondea(honos_contrato * ( porc_col_real  ) * ( porc_cli_real  ) )	
	
	honos_pasados = dw_minuta.getitemnumber(1, 'base_honos')
	honos_pasados_contrato = f_total_avisado_honos_col_cli(id_fase, id_col, id_cli)
	honos_pasados_contrato += honos_pasados 
	if honos_contrato_col_cli = honos_pasados_contrato then	
//		nif_cli = f_dame_nif(id_cli)
		base_garantia = f_dame_garantia_col_cli(id_fase, id_col, id_cli)	
	else
		base_garantia = 0
	end if
end if

return base_garantia
end event

event key_pressed;if keydown(keycontrol!) and keydown(keyX!) then
	CHOOSE CASE g_colegio
		CASE 'COAATTFE'
			long n_reg
			// Se necesita tener un permiso especial para poder tocar este campo
			select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and ((cod_aplicacion = 'TFE0000038' and permiso = 'E') or cod_aplicacion = 'E');
			// Solo se permite a los que tengan el permiso especial
			if n_reg<1 then return
	END CHOOSE	
	if dw_minuta.enabled = false then
		dw_minuta.enabled = true
		dw_minuta.object.pendiente.visible = true
		dw_minuta.object.fecha_pago.tabsequence = 800
		dw_minuta.object.forma_pago.tabsequence = 810
		dw_minuta.object.banco.tabsequence = 820
	else
		dw_minuta.enabled = false 
		dw_minuta.object.pendiente.visible = false	
		dw_minuta.object.fecha_pago.tabsequence = 0
		dw_minuta.object.forma_pago.tabsequence = 0
		dw_minuta.object.banco.tabsequence = 0		
	end if
end if

end event

event csd_irpf_colegiado;string id_col
double porc_irpf = 0

id_col = dw_minuta.getitemstring(1, 'id_colegiado')

porc_irpf = f_dame_irpf_colegiado(id_col)

dw_minuta.setitem(1, 'irpf', porc_irpf)

end event

event type double csd_dame_porc_col_cgc();int fila_colegiado = 0, i = 0
string id_col
double porc_col = 0, suma_porc_col = 0, porc_col_real = 0
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
// % colegiado
fila_colegiado = idw_colegiados.find("id_col = '" + id_col+"'", 1, idw_colegiados.rowcount())
if fila_colegiado <= 0 then 
	messagebox(g_titulo, 'No se encuentra el % del colegiado')
	return -1
end if
porc_col = idw_colegiados.getitemnumber(fila_colegiado, 'porcen_a')
// MODIFICADO PACO 05/05/2004
for i = 1 to idw_colegiados.rowcount()
	/*if idw_colegiados.getitemstring(i, 'renunciado') <>  'S' and */
	IF idw_colegiados.getitemstring(i, 'tipo_gestion') = 'C' then suma_porc_col += idw_colegiados.getitemnumber(i, 'porcen_a')
next
if idw_colegiados.getitemstring(fila_colegiado, 'tipo_gestion') = 'P' then return 0

if suma_porc_col = 0 or isnull(suma_porc_col) then suma_porc_col = 1
porc_col_real = porc_col / suma_porc_col

return porc_col_real

end event

event csd_calcular_desplazamientos();// CREADO RICARDO 04-02-12
// Evento creado para poder calcular los descuentos para la rioja ya que utilizan los descuentos en el contrato

double desplaza_totales, porc_col_real, desplaza
double porc_honos, honos_contrato, honos_pasados, maximo_honos
string id_fase, id_col, id_cli

id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')		

// Solo en el caso de ser con gestion se mira esto
choose case dw_minuta.getitemstring(1, 'tipo_gestion')
	case 'C', 'A' // Desplazamientos relativa a honorarios
		desplaza_totales = f_desplazamientos_contrato_dw(idw_descuentos) - f_total_avisado_desplaza_col_cli(id_fase, id_col, id_cli)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		// calculamos el porcentaje relativo
		honos_contrato = idw_1.getitemnumber(1, 'honorarios')
		honos_pasados = dw_minuta.getitemnumber(1, 'base_honos')
		if honos_contrato = 0 or isnull(honos_contrato) then honos_contrato = 1
		porc_honos = honos_pasados / honos_contrato
		// Calculamos el desplazamiento relativo
		desplaza = desplaza_totales * porc_honos
		// si ya se han pagado todos los honorarios con esta minuta, colocamos todos los desplazamientos
		maximo_honos = this.trigger event csd_maximo_honos()		
		if honos_pasados = maximo_honos and desplaza <> desplaza_totales then
//			if messageBox(g_titulo, "Quedar$$HEX1$$e100$$ENDHEX$$n desplazamientos por colocar en una minuta, $$HEX1$$bf00$$ENDHEX$$desea colocar en este aviso el total de los desplazamientos?", question!, yesno!, 1)=1 then
				desplaza = desplaza_totales
//			end if
		end if
		if this.event csd_dame_porc_col_cgc() > 0 then desplaza = desplaza * (1 / this.event csd_dame_porc_col_cgc()) * porc_col_real
		
		// Aplicamos 
		if isnull(desplaza) then desplaza = 0
		desplaza = f_redondea(desplaza)
		if desplaza >0 then
			// Capturamos el campo, colosamos el valor del mismo y lanzamos el itemchanged
			dw_minuta.setitem(1, 'base_desplaza', desplaza)
			dw_minuta.setitem(1, 'aplica_desplaza', 'S')
			dwobject dwo_campo
			dwo_campo = dw_minuta.object.base_desplaza
			dw_minuta.trigger event itemchanged(1, dwo_campo, string(desplaza))
		end if
end choose
end event

event csd_aviso_regularizacion();// Evento que muestra un aviso cuando la musaat calculada es diferente de la que
// aparece en el aviso
st_musaat_datos datos_musaat
boolean regulariza_musaat=FALSE
string id_col, id_minuta, id_fase
double retorno, musaat, musaat_cobrado, base

musaat_cobrado = f_redondea(dw_minuta.getitemnumber(1, 'base_musaat'))
if not musaat_cobrado > 0 then return // Si el aviso no tiene musaat no hacemos nada
if dw_minuta.getitemstring(1, 'pendiente') <> 'S' then return // Si el aviso no est$$HEX2$$e1002000$$ENDHEX$$pendiente no hacemos nada
if LeftA( dw_minuta.getitemstring(1, 'tipo_minuta'),1) <> '1' then return // Si no es un alta no hacemos nada

id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_minuta = dw_minuta.getitemstring(1, 'id_minuta')
id_fase = dw_minuta.getitemstring(1, 'id_fase')

datos_musaat.recuperar = TRUE
datos_musaat.id_minuta = id_minuta 
datos_musaat.importe_sobre_honos = dw_minuta.getitemnumber(1, 'base_musaat')
datos_musaat.porc_sobre_honos = dw_minuta.getitemnumber(1, 'porc_honos')
datos_musaat.regulariza = TRUE
datos_musaat.f_pago = datetime(today())
datos_musaat.n_visado = id_fase
datos_musaat.id_col = id_col
datos_musaat.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
datos_musaat.int_forzosa = f_musaat_dame_col_int_forzosa(id_col)	

if f_colegiado_tipopersona(id_col) = 'S' then
	retorno = f_musaat_calcula_prima_sociedad(datos_musaat)			
else
	retorno = f_musaat_calcula_prima(datos_musaat)
end if		
musaat = datos_musaat.prima_comp		
musaat = f_redondea(musaat)

base = f_redondea(musaat - musaat_cobrado)

if base <> 0 then
	messagebox(g_titulo, 'El importe de Musaat puede haber variado.')
end if

end event

event csd_modificacion_datos(string idfase, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  fase, modificacion, data, tipo, aviso
integer fila

// Para identificar sobre que aviso se realizan los cambios
aviso = dw_minuta.getitemstring(1, 'n_aviso')

// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

data=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		data=dw.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		data=string(dw.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
		data=string(dw.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(data) then data=''   // return

fila        =dw_historico.rowcount()
fase        =idfase
if fila > 0 then
	modificacion=dw_historico.getitemstring(fila,'modificacion')
else
	fila = dw_historico.triggerevent("pfc_addrow")
end if

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
modificacion = modificacion + nombre_dw + ' (' + aviso + ') ' + campo + '=' + data + '; '

// Se actualiza la dw de modificaciones oculta
dw_historico.setitem(fila,'id_colegiado',fase)
dw_historico.setitem(fila,'modificacion',modificacion)
dw_historico.setitem(fila,'fecha',datetime(today(),now()))
dw_historico.setitem(fila,'usuario',g_usuario)

end event

event type integer csd_control_estados();return f_fase_puede_cobrarse_aviso_estado(idw_1.GetItemString(idw_1.GetRow(),'estado'), true)

end event

event type double csd_calcula_musaat_fase();string id_col, id_fase, tipo_gestion
int retorno, i, fila_colegiado = 0
double musaat_col
st_musaat_datos st_musaat_datos

id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1,'id_colegiado')
tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')

//MUSAAT, calculamos la base total
if idw_fases_estadistica.rowcount() > 0 then
	st_musaat_datos.n_visado = idw_1.getitemstring(1, 'id_fase')
	st_musaat_datos.id_col = id_col
	st_musaat_datos.tipo_act = idw_1.getitemstring(1, 'fase')
	st_musaat_datos.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	st_musaat_datos.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	st_musaat_datos.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	st_musaat_datos.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	st_musaat_datos.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
	st_musaat_datos.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
	st_musaat_datos.porcentaje = this.event csd_dame_porc_col() * 100
	st_musaat_datos.genera_movi = FALSE
	st_musaat_datos.id_minuta = dw_minuta.getitemstring(1, 'id_minuta')
	st_musaat_datos.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
	st_musaat_datos.int_forzosa = f_musaat_dame_col_int_forzosa(id_col)	
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(st_musaat_datos)			
	else
		retorno = f_musaat_calcula_prima(st_musaat_datos)
	end if		
	musaat_col = st_musaat_datos.prima_comp		
end if

return musaat_col
end event

event csd_colocar_observaciones();long fila
string observaciones = ''

fila = idw_descuentos.find("tipo_informe = '"+g_codigos_conceptos.cip+"'",1 , idw_descuentos.RowCount())
if fila>0 then
	if LenA(observaciones)>0 then observaciones += ', ' 
	observaciones += idw_descuentos.getitemstring(fila, 'descripcion')
end if

fila = idw_descuentos.find("tipo_informe = '"+g_codigos_conceptos.dv+"'",1 , idw_descuentos.RowCount())
if fila>0 then
	if LenA(observaciones)>0 then observaciones += ', ' 
	observaciones +=  idw_descuentos.getitemstring(fila, 'descripcion')
end if


if LenA(observaciones)>0 then
	dw_minuta.setitem(1, 'observaciones', observaciones)
end if

end event

event csd_calcular_libros();double lib_totales = 0, lib = 0, porc_col_real = 0, porc_cli_real = 0
string id_fase , id_col, id_cli

// Libros
id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')

choose case dw_minuta.getitemstring(1, 'tipo_gestion')
	case 'C', 'A' // Libros relativos a honorarios
		lib_totales = f_libros_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		porc_cli_real = this.event csd_dame_porc_cli()
		// Miro en la BD
		IF f_total_avisado_libros_col_cli(id_fase, id_col, id_cli) > 0 then 
			// si tenia algo pasado entonces 0
			lib = 0
		else
			lib = max(( lib_totales * porc_col_real * porc_cli_real ),0)
		end if

	case 'S'
		// Cogemos los libros del contrato, NO recalculamos otra vez
		lib_totales = f_libros_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		//CGU-399
		if idw_colegiados.rowcount() = 1 then porc_col_real = 1
		// Miro en la BD
		if f_total_avisado_libros_colegiado(id_fase, id_col) > 0 then
			lib = 0
		else
			lib = max((lib_totales * porc_col_real),0)
		end if
end choose

lib = f_redondea(lib)

dw_minuta.setitem(1, 'base_impresos', lib)

end event

event csd_calcular_tipo_minuta(string id_colegiado, string id_cliente);// Si hay alguna minuta inicial de este colegiado a este cliente la siguiente debe ser parcial.Paco 25/8/2005
if dw_minuta.getitemstring(1,'tipo_gestion') <> 'C' then return
string id_minuta, id_fase
double dl_cuantos
id_cliente = dw_minuta.getitemstring(1, 'id_cliente')
id_minuta =  dw_minuta.getitemstring(1, 'id_minuta')
id_fase = dw_minuta.getitemstring(1,'id_fase')
select count(*)
into :dl_cuantos
from fases_minutas
where id_cliente = :id_cliente and id_colegiado = :id_colegiado and id_fase = :id_fase and id_minuta <> :id_minuta and anulada <> 'S';
if dl_cuantos >= 1 then 
	dw_minuta.setitem(1,'t_minuta', 'P') 
	dw_minuta.event itemchanged(1, dw_minuta.object.t_minuta, 'P')
else 
	dw_minuta.setitem(1,'t_minuta', 'I')
	dw_minuta.event itemchanged(1, dw_minuta.object.t_minuta, 'I')
end if

end event

event csd_calcular_gastos_cobro_min();// C$$HEX1$$e100$$ENDHEX$$lculo de gastos por gesti$$HEX1$$f300$$ENDHEX$$n de cobro de minutas (COAAT Navarra)
// Es un 0.5% sobre los honorarios (parametrizado por variable global)

double honos, importe

honos = dw_minuta.getitemnumber(1, 'base_honos')

importe = f_redondea(honos * g_porc_gastos_minutas)

dw_minuta.setitem(1, 'base_impresos', importe)



end event

event type double csd_recalcular_cip();double cip_totales=0,  porc_col_real=0, cip=0, honos_contrato=0, honos_pasados=0, porc_honos=0, honos_contrato_col_cli=0
double honos_pasados_contrato=0, porc_cli_real=0, cip_col_cli=0,cip_parcial=0
string id_fase, id_col, id_cli

id_fase = dw_minuta.getitemstring(1, 'id_fase')
id_col = dw_minuta.getitemstring(1, 'id_colegiado')
id_cli = dw_minuta.getitemstring(1, 'id_cliente')

CHOOSE CASE dw_minuta.getitemstring(1, 'tipo_gestion')
	CASE 'C', 'A' // CIP relativa a honorarios

		// Cogemos la cip del contrato, NO recalculamos otra vez
		porc_col_real = this.event csd_dame_porc_col()
		
		cip_parcial=f_calcular_cip_contrato_dw(idw_fases_estadistica,idw_1,porc_col_real*100, id_col)
		//cip_totales = f_cip_contrato_dw(idw_descuentos)


		// No calculamos la cip relativa a los honorarios, si est$$HEX2$$e1002000$$ENDHEX$$as$$HEX2$$ed002000$$ENDHEX$$configurado
		if g_cip_cgc_toda = 'S' then
			cip = f_redondea(max((cip_parcial) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0))
			return cip
		end if
		// Si ya se ha cobrado la cip anteriormente, no se vuelve a cobrar
		if max((f_redondea(cip_parcial)) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0) = 0 then 
			cip = 0
			return cip
		end if
		// calculamos el porcentaje relativo
		honos_contrato = idw_1.getitemnumber(1, 'honorarios')
		honos_pasados = dw_minuta.getitemnumber(1, 'base_honos')
		// Si no han metido los honorarios en el contrato no podemos calcular el porcentaje y tampoco la cip
		if honos_contrato = 0 or isnull(honos_contrato) then 
			honos_contrato = 1
		else
			porc_honos = honos_pasados / honos_contrato
		end if
		// Calculamos la CIP relativa a los honorarios
		cip = cip_totales * porc_honos //- f_total_avisado_cip_col_cli(id_fase, id_col, id_cli) )
		double porc_col_cgc
		porc_col_cgc = this.event csd_dame_porc_col_cgc()
		if porc_col_cgc <> 0 then cip = cip * (1 / porc_col_cgc) * porc_col_real
		// Si hemos pasado el 100% de los honorarios que regularize la CIP
		porc_cli_real = this.event csd_dame_porc_cli()
		honos_pasados_contrato = f_total_avisado_honos_col_cli(id_fase, id_col, id_cli)
		// Le sumo los honorarios actuales
		honos_pasados_contrato += honos_pasados 
		honos_contrato_col_cli = f_redondea(honos_contrato * ( porc_col_real  ) * ( porc_cli_real  ) )
		if honos_contrato_col_cli = honos_pasados_contrato then
			cip = f_calcular_cip_contrato_dw(idw_fases_estadistica,idw_1,porc_col_real*100, id_col)		
			cip_col_cli = f_redondea(cip * ( porc_col_real  ) * ( porc_cli_real  ))
//			messagebox(g_titulo, 'Se va a regularizar la Cip debido a un cambio de la misma desde su valor inicial')
			cip = cip_col_cli - f_total_avisado_cip_col_cli(id_fase, id_col, id_cli)
		end if
	
	CASE 'S' // Resto CIP colegiado. Restar lo q ya tenga pasado
		// Cogemos la cip del contrato, NO recalculamos otra vez
		//cip_totales = f_cip_contrato_dw(idw_descuentos)
		porc_col_real = this.event csd_dame_porc_col()
		cip_parcial= f_calcular_cip_contrato_dw(idw_fases_estadistica,idw_1,porc_col_real*100, id_col)		
		// miro en la BD
		cip = max((cip_parcial) - f_total_avisado_cip_colegiado(id_fase, id_col) , 0)
END CHOOSE

if isnull(cip) then cip = 0
cip = f_redondea(cip)

return cip

end event

event csd_verifica_musaat();// Este evento solo verifica los tipos de alta 1.x
st_musaat_datos datos_musaat
string id_col, id_minuta, id_fase
double musaat_cobrado, retorno, base, musaat
	musaat_cobrado = f_redondea(dw_minuta.getitemnumber(1, 'base_musaat'))
	
	if not musaat_cobrado > 0 then return

	// No consideramos las modificaciones o anulaciones
	if LeftA(dw_minuta.getitemstring(1, 'tipo_minuta'),1) <> '1' then return
	// Solo se revisan las minutas pendientes
	if LeftA(dw_minuta.getitemstring(1, 'pendiente'),1) = 'N' then return

	id_col = dw_minuta.getitemstring(1, 'id_colegiado')
	id_minuta = dw_minuta.getitemstring(1, 'id_minuta')
	id_fase = idw_1.getitemstring(1, 'id_fase')
	
	datos_musaat.n_visado = idw_1.getitemstring(1, 'id_fase')
	datos_musaat.id_col = id_col
	datos_musaat.tipo_act = idw_1.getitemstring(1, 'fase')
	datos_musaat.tipo_obra = idw_1.getitemstring(1, 'tipo_trabajo')
	datos_musaat.pem = idw_fases_estadistica.getitemnumber(1, 'pem')
	datos_musaat.administracion = idw_fases_datos_exp.getitemstring(1, 'administracion')
	datos_musaat.superficie = idw_fases_estadistica.getitemnumber(1, 'superficie')
	datos_musaat.volumen = idw_fases_estadistica.getitemnumber(1, 'volumen')
	datos_musaat.colindantes2m = idw_fases_estadistica.getitemstring(1, 'colindantes2m')
	datos_musaat.porcentaje = this.event csd_dame_porc_col() * 100
	datos_musaat.genera_movi = FALSE
	datos_musaat.id_minuta =id_minuta
	datos_musaat.doble_condicion = f_musaat_dame_col_doble_cond(id_col)
	datos_musaat.int_forzosa = f_musaat_dame_col_int_forzosa(id_col)

	
	if f_colegiado_tipopersona(id_col) = 'S' then
		retorno = f_musaat_calcula_prima_sociedad(datos_musaat)			
	else
		retorno = f_musaat_calcula_prima(datos_musaat)
	end if		
	musaat = datos_musaat.prima_comp		
	musaat = f_redondea(musaat)
	
	base = f_redondea(musaat - musaat_cobrado)
	
	
	//if base <> 0 then
	//Cambio Luis CGC-117
	if base > 0.01 or base < -0.01 then
		Messagebox(g_titulo, 'El importe de Musaat puede haber variado en el aviso.')
	end if
	
	return 
end event

public function double f_total_movimientos_colegiado (string id_col);int i
double total_src = 0
for i = 1 to idw_fases_src.rowcount()
	if id_col = idw_fases_src.getitemstring(i, 'id_col') then
		total_src += idw_fases_src.getitemnumber(i, 'importe_vble')
	end if
next

return total_src
	
end function

public function double f_total_avisos_colegiado (string id_col);// N$$HEX1$$fa00$$ENDHEX$$mero de avisos a un colegiado no anulados
int i
double total_avisos = 0
for i = 1 to idw_fases_minutas.rowcount()
	if id_col = idw_fases_minutas.getitemstring(i, 'id_colegiado') then
		if idw_fases_minutas.getitemstring(i, 'anulada') = 'N' then
			if idw_fases_minutas.getitemstring(i, 'id_minuta') <> dw_minuta.getitemstring(1, 'id_minuta') then
				total_avisos ++
			end if
		end if
	end if
next

return total_avisos
end function

public function integer f_guarda_dw (datawindow dw_actual, string id_consulta);// Sobreescrita, no guarda todos los campos

int t,j,num_columnas,fila
string dw,valor_columna_string,desc_columna,tipo_columna
datetime valor_columna_datetime
double  valor_columna_double

dw_actual.AcceptText()
dw = dw_actual.dataobject
//Recorremos todas las columnas del dw
num_columnas = double(dw_actual.Object.Datawindow.Column.Count)
//Recorremos todas las l$$HEX1$$ed00$$ENDHEX$$neas del dw
for t=1 to dw_actual.Rowcount()
	// No Recorremos todos los valores (s$$HEX1$$f300$$ENDHEX$$lo los campos que nos interesan)
	for j=1 to 21 //13 //num_columnas
		desc_columna = dw_actual.Describe('#'+string(j)+'.Name ')
		tipo_columna = dw_actual.Describe('#'+string(j)+'.ColType')
		if (LeftA(tipo_columna,7)='decimal') or tipo_columna ='double' or tipo_columna ='int'  then tipo_columna = 'number'
		choose case tipo_columna
			case 'datetime'
				valor_columna_datetime = dw_actual.GetItemDatetime(t,j)
				setnull(valor_columna_double)
				setnull(valor_columna_string)
				if isnull(valor_columna_datetime) then continue
			case 'number'
				valor_columna_double = dw_actual.GetItemNumber(t,j)
				setnull(valor_columna_datetime)
				setnull(valor_columna_string)
				if isnull(valor_columna_double) then continue
			case else
				valor_columna_string =dw_actual.GetItemString(t,j)
				setnull(valor_columna_double)
				setnull(valor_columna_datetime)
				if f_es_vacio(valor_columna_string) then continue
		end choose
		//Insertamos los valores en la tabla consulta
		fila = i_ds_datos_consulta.InsertRow(0)
		i_ds_datos_consulta.SetItem(fila,'id_consulta_datos',f_siguiente_numero('CONSULTAS_DATOS',10))
		i_ds_datos_consulta.SetItem(fila,'id_consulta',id_consulta)
		i_ds_datos_consulta.SetItem(fila,'datawindow',dw)
		i_ds_datos_consulta.SetItem(fila,'columna',j)
		i_ds_datos_consulta.SetItem(fila,'fila',t)
		i_ds_datos_consulta.SetItem(fila,'valor_datetime',valor_columna_datetime)
		i_ds_datos_consulta.SetItem(fila,'valor_double',valor_columna_double)
		i_ds_datos_consulta.SetItem(fila,'valor_string',valor_columna_string)
	next				
next

return 1
end function

on w_minutas_detalle.create
int iCurrent
call super::create
this.cbx_f_gastos=create cbx_f_gastos
this.cbx_f_honos=create cbx_f_honos
this.cbx_aviso=create cbx_aviso
this.cb_ver_f_gastos=create cb_ver_f_gastos
this.cb_ver_f_honos=create cb_ver_f_honos
this.pb_cobrar=create pb_cobrar
this.pb_salir=create pb_salir
this.pb_ver_aviso=create pb_ver_aviso
this.pb_grabar=create pb_grabar
this.cb_ver_recibo_musaat=create cb_ver_recibo_musaat
this.cbx_f_musaat=create cbx_f_musaat
this.dw_historico=create dw_historico
this.dw_fases_datos_exp=create dw_fases_datos_exp
this.dw_clientes=create dw_clientes
this.dw_colegiados=create dw_colegiados
this.dw_descuentos=create dw_descuentos
this.dw_estadistica=create dw_estadistica
this.dw_fases_src=create dw_fases_src
this.dw_fases_minutas=create dw_fases_minutas
this.dw_fases_detalle=create dw_fases_detalle
this.dw_composite=create dw_composite
this.dw_minuta=create dw_minuta
this.dw_musaat=create dw_musaat
this.dw_impresion=create dw_impresion
this.gb_1=create gb_1
this.dw_factura_gastos=create dw_factura_gastos
this.dw_factura_honos=create dw_factura_honos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_f_gastos
this.Control[iCurrent+2]=this.cbx_f_honos
this.Control[iCurrent+3]=this.cbx_aviso
this.Control[iCurrent+4]=this.cb_ver_f_gastos
this.Control[iCurrent+5]=this.cb_ver_f_honos
this.Control[iCurrent+6]=this.pb_cobrar
this.Control[iCurrent+7]=this.pb_salir
this.Control[iCurrent+8]=this.pb_ver_aviso
this.Control[iCurrent+9]=this.pb_grabar
this.Control[iCurrent+10]=this.cb_ver_recibo_musaat
this.Control[iCurrent+11]=this.cbx_f_musaat
this.Control[iCurrent+12]=this.dw_historico
this.Control[iCurrent+13]=this.dw_fases_datos_exp
this.Control[iCurrent+14]=this.dw_clientes
this.Control[iCurrent+15]=this.dw_colegiados
this.Control[iCurrent+16]=this.dw_descuentos
this.Control[iCurrent+17]=this.dw_estadistica
this.Control[iCurrent+18]=this.dw_fases_src
this.Control[iCurrent+19]=this.dw_fases_minutas
this.Control[iCurrent+20]=this.dw_fases_detalle
this.Control[iCurrent+21]=this.dw_composite
this.Control[iCurrent+22]=this.dw_minuta
this.Control[iCurrent+23]=this.dw_musaat
this.Control[iCurrent+24]=this.dw_impresion
this.Control[iCurrent+25]=this.gb_1
this.Control[iCurrent+26]=this.dw_factura_gastos
this.Control[iCurrent+27]=this.dw_factura_honos
end on

on w_minutas_detalle.destroy
call super::destroy
destroy(this.cbx_f_gastos)
destroy(this.cbx_f_honos)
destroy(this.cbx_aviso)
destroy(this.cb_ver_f_gastos)
destroy(this.cb_ver_f_honos)
destroy(this.pb_cobrar)
destroy(this.pb_salir)
destroy(this.pb_ver_aviso)
destroy(this.pb_grabar)
destroy(this.cb_ver_recibo_musaat)
destroy(this.cbx_f_musaat)
destroy(this.dw_historico)
destroy(this.dw_fases_datos_exp)
destroy(this.dw_clientes)
destroy(this.dw_colegiados)
destroy(this.dw_descuentos)
destroy(this.dw_estadistica)
destroy(this.dw_fases_src)
destroy(this.dw_fases_minutas)
destroy(this.dw_fases_detalle)
destroy(this.dw_composite)
destroy(this.dw_minuta)
destroy(this.dw_musaat)
destroy(this.dw_impresion)
destroy(this.gb_1)
destroy(this.dw_factura_gastos)
destroy(this.dw_factura_honos)
end on

event open;call super::open;i_st_minutas_consulta = message.powerobjectparm
string id_fase, id_expedi

i_modulo = i_st_minutas_consulta.modulo

if i_modulo = 'CAJA' then
	id_fase = i_st_minutas_consulta.id_fase
	
	idw_1 = dw_fases_detalle; idw_1.retrieve(id_fase)
	id_expedi = idw_1.getitemstring(1, 'id_expedi')

	idw_fases_datos_exp = dw_fases_datos_exp; idw_fases_datos_exp.retrieve(id_expedi)	
	idw_clientes = dw_clientes;	idw_clientes .retrieve(id_fase)
	idw_colegiados = dw_colegiados;	idw_colegiados.retrieve(id_fase)	
	idw_descuentos = dw_descuentos; idw_descuentos.retrieve(id_fase)
	idw_fases_estadistica = dw_estadistica; idw_fases_estadistica.retrieve(id_fase)
	idw_fases_src = dw_fases_src; idw_fases_src.retrieve(id_fase)
	idw_fases_minutas = dw_fases_minutas; idw_fases_minutas.retrieve(id_fase)
elseif i_modulo = 'AVISOS' then
	// impedimos que se puedan tocar los botones
	pb_grabar.enabled = false
	pb_grabar.visible = false
	pb_cobrar.enabled = false
	pb_cobrar.visible = false
	
	id_fase = i_st_minutas_consulta.id_fase
	
	idw_1 = dw_fases_detalle; idw_1.retrieve(id_fase)
	id_expedi = idw_1.getitemstring(1, 'id_expedi')

	idw_fases_datos_exp = dw_fases_datos_exp; idw_fases_datos_exp.retrieve(id_expedi)	
	idw_clientes = dw_clientes;	idw_clientes .retrieve(id_fase)
	idw_colegiados = dw_colegiados;	idw_colegiados.retrieve(id_fase)	
	idw_descuentos = dw_descuentos; idw_descuentos.retrieve(id_fase)
	idw_fases_estadistica = dw_estadistica; idw_fases_estadistica.retrieve(id_fase)
	idw_fases_src = dw_fases_src; idw_fases_src.retrieve(id_fase)
	idw_fases_minutas = dw_fases_minutas; idw_fases_minutas.retrieve(id_fase)
	
else
	w_fases_detalle w
	w = g_detalle_fases
	
	idw_clientes = w.idw_fases_promotores
	idw_colegiados = w.idw_fases_colegiados
	idw_descuentos = w.idw_fases_informes
	idw_fases_datos_exp = w.dw_fases_datos_exp
	idw_1 = w.dw_1
	idw_fases_src = w.idw_fases_src
	idw_fases_minutas = w.idw_fases_minutas
	idw_fases_estadistica = w.idw_fases_estadistica
end if

i_obra_admin = idw_fases_datos_exp.getitemstring(1, 'administracion')
// Ponemos los calendarios
dw_minuta.post event csd_calendario()
// cargamos datos de cada concepto como iva, cuenta ...
this.event csd_cargar_datos_conceptos()

choose case i_st_minutas_consulta.accion
	case 'NUEVA'
		this.event csd_nuevo()
	case 'CONSULTA'
		st_control_eventos c_evento
		//Llamamos al control de eventos
		c_evento.evento = 'ABRIR_MINUTA'
		c_evento.dw = dw_minuta
		if f_control_eventos(c_evento)=-1 then return
	
		dw_minuta.retrieve(i_st_minutas_consulta.id_minuta)
		// Julian
string id_col

id_col =idw_fases_minutas.getitemstring(idw_fases_minutas.getrow(),'id_colegiado')

		
		c_evento.id_colegiado = id_col
		c_evento.dw = dw_minuta 
		c_evento.evento = 'MINUTA_COLEGIADOS'
		c_evento.control = "BAJA"
		c_evento.dw = dw_minuta 
		f_control_eventos(c_evento)

// Fin Julian

		if g_musaat_verifica_prima_aviso = 'S' then this.event csd_verifica_musaat()
			
end choose
//g_minutas_consulta.accion = ''
//g_minutas_consulta.modulo = ''

dw_minuta.event csd_configura_tipo_gestion()

f_parametriza_ventana_minuta(this)


string gastos, honos, musaat

SELECT tipos_facturas.plantilla  
INTO :gastos  
FROM tipos_facturas  
WHERE tipos_facturas.codigo = '03'   ;

SELECT tipos_facturas.plantilla  
INTO :honos
FROM tipos_facturas  
WHERE tipos_facturas.codigo = '04'   ;

SELECT tipos_facturas.plantilla  
INTO :musaat
FROM tipos_facturas  
WHERE tipos_facturas.codigo = '05'   ;

dw_factura_honos.dataobject = honos
dw_factura_honos.settransobject(sqlca)
dw_factura_gastos.dataobject = gastos
dw_factura_gastos.settransobject(sqlca)

dw_impresion.of_setprintpreview(true)	
dw_factura_honos.of_setprintpreview(true)	
dw_factura_gastos.of_setprintpreview(true)	
dw_impresion.event pfc_printpreview()
dw_factura_honos.event pfc_printpreview()	
dw_factura_gastos.event pfc_printpreview()

if not f_es_vacio(musaat) then dw_musaat.dataobject = musaat

	if g_colegio = 'COAATMCA'  then
		dw_musaat.dataobject = 'd_recibos_musaat_cma'
		dw_musaat.settransobject(SQLCA)
		if idw_1.getitemString(1, 'mantenimiento')='S' then
			dw_minuta.object.aplica_impresos.checkbox.text = 'Cuota de Mantenimiento.................................................................................'		
			dw_minuta.object.aplica_impresos.visible = true
			dw_minuta.object.base_impresos.visible = true
			dw_minuta.object.iva_impresos.visible = true
			dw_minuta.object.porc_iva_impresos.visible = true
			//dw_minuta.setitem(1, 'aplica_impresos', 'S')
			
		end if
	end if

dw_musaat.settransobject(sqlca)
dw_musaat.of_setprintpreview(true)	
dw_musaat.event pfc_printpreview()


if i_obra_admin = 'N' then
	dw_minuta.object.porc_musaat.visible = false
	dw_minuta.object.t_porc_musaat.visible = false
end if

if g_colegio = 'COAATAVI' and i_st_minutas_consulta.accion = 'CONSULTA' then post event csd_aviso_regularizacion()

if g_colegio='COAATCC' then
	if f_tengo_permiso(g_usuario,'NAVISO_MOD' ,'%') = 1 then
		dw_minuta.Object.n_aviso.Edit.DisplayOnly = 'No'
		dw_minuta.Object.n_aviso.Background.Color = RGB(255,255,255)	
	end if
end if
end event

event pfc_preopen;call super::pfc_preopen;f_centrar_ventana(this)
end event

event pfc_preupdate;call super::pfc_preupdate;//Control de permisos
if f_puedo_escribir(g_usuario,'0000000028')=-1 then return -1

dw_minuta.AcceptText()


// VALIDACIONES
string mensaje='', id_col, id_musaat, tipo_gestion, pagador, t_minuta, mensaje_ant=''
int cuantos
double total_cliente = 0, total_colegiado = 0

mensaje=mensaje + f_valida(dw_minuta,'id_colegiado','NOVACIO','Debe tener un colegiado')
mensaje=mensaje + f_valida(dw_minuta,'id_cliente','NOVACIO','Debe tener un cliente')

tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')
pagador = dw_minuta.getitemstring(1, 'pagador')
total_cliente = dw_minuta.getitemnumber(1, 'total_cliente')
total_colegiado = dw_minuta.getitemnumber(1, 'total_colegiado')
t_minuta = dw_minuta.getitemstring(1, 't_minuta')

mensaje_ant = mensaje

choose case tipo_gestion
	case 'C', 'A'
		if dw_minuta.getitemstring(1, 'aplica_honos') = 'S' then
			mensaje=mensaje + f_valida(dw_minuta,'concepto_honos','NOVACIO','Debe tener un concepto de honorarios')			
		end if
end choose

// Comprobar Total <> 0
choose case tipo_gestion
	case 'C'
		if total_cliente = 0 then
			if g_colegio <> 'COAATZ' and g_colegio <> 'COAATGU' and g_colegio <> 'COAATLE' and g_colegio <> 'COAATAVI' and g_colegio <> 'COAATNA'  and g_colegio <> 'COAATTER' then 
				mensaje += cr + 'El total tiene que ser <> 0'
			end if
		end if
		if (g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' OR g_colegio <> 'COAATTER') and &
		dw_minuta.getitemnumber(1, 'suma_bases') = 0 then mensaje += cr + 'El total tiene que ser <> 0'
		
	case 'A'
		if total_colegiado = 0 and dw_minuta.getitemnumber(1, 'base_honos') = 0 then 
			mensaje += cr + 'El total tiene que ser <> 0'
		end if
		
	case 'S'
		choose case pagador
			case '1','2' //colegiado o empresa
				if total_colegiado = 0 then mensaje += cr + 'El total tiene que ser <> 0'

			case '3' //cliente
				if total_cliente = 0 then mensaje += cr + 'El total tiene que ser <> 0'
		end choose
		// Excepci$$HEX1$$f300$$ENDHEX$$n
		if (g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' ) and t_minuta <> 'I' then
			mensaje = mensaje_ant // Restablecemos los que hubiera
		end if
end choose

// Comprobar que no se generan movimientos de musaat de tipo visado=0 (para COAATGC)
if g_colegio = 'COAATGC' then
	string tipo_minuta
	double musaat
	tipo_minuta = dw_minuta.getitemstring(1, 'tipo_minuta')
	musaat = dw_minuta.getitemnumber(1, 'base_musaat')
	if musaat > 0 and tipo_minuta = '00' then mensaje += cr + 'El tipo de minuta debe ser distinto de "00"'
end if

// Comprobar que no se cobran libros en minutas no iniciales
if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' OR g_colegio = 'COAATTER' then
	double libros
	libros = dw_minuta.getitemnumber(1, 'base_impresos')
	if libros > 0 and t_minuta <> 'I' then 
		// Vamos s$$HEX1$$f300$$ENDHEX$$lo a avisar por ahora
		messagebox(g_titulo, "La minuta no es inicial y existe importe en libros") 
	end if
end if		

// Modificado Ricardo 2005-03-18
// Validar honos > gastos en en los avisos con gesti$$HEX1$$f300$$ENDHEX$$n de cobro
string mensajes_aviso
CHOOSE CASE g_colegio
	CASE 'COAATLR', 'COAATGU', 'COAATLE', 'COAATTER'
		if tipo_gestion = 'C' then
			if total_cliente < total_colegiado then
				mensajes_aviso += cr + 'El total de la Factura de Gastos (' + string(total_colegiado, "#,##0.00")+&
				') supera al total de la Factura de Honorarios (' + string(total_cliente, "#,##0.00") +')' +cr + &
				'Si sigue con el proceso de cobro la diferencia se cargar$$HEX2$$e1002000$$ENDHEX$$contablemente en la cuenta del colegiado que podr$$HEX2$$e1002000$$ENDHEX$$quedar deudora'
			end if
		end if
		
	CASE 'COAATAVI'
		if tipo_gestion = 'C' then
			if (total_cliente - total_dv) < total_colegiado then
				mensajes_aviso += cr + 'El total de la Factura de Gastos (' + string(total_colegiado, "#,##0.00")+&
				') supera al total de la Factura de Honorarios (' + string(total_cliente - total_dv, "#,##0.00") +')'+&
				cr+'Si sigue con el proceso de cobro la diferencia se cargar$$HEX2$$e1002000$$ENDHEX$$contablemente en la cuenta del colegiado que podr$$HEX2$$e1002000$$ENDHEX$$quedar deudora'
			end if
		end if		
END CHOOSE
// fin Modificado Ricardo 2005-03-18


int retorno=1
if mensaje<>'' then
	messagebox(G_TITULO, mensaje,StopSign!)
	retorno=-1
else
	if /*g_colegio = 'COAATLR' and*/ not f_es_vacio(mensajes_aviso) then
		if messagebox(g_titulo, mensajes_aviso, question!, yesno!, 2)=2 then
			return -1
		end if
	end if
	// Ponemos el total
	dw_minuta.setitem(1, 'total_aviso', f_redondea(dw_minuta.getitemnumber(dw_minuta.rowcount(), 'total')))
	
	// SCP-78
	if dw_minuta.getitemstring(1, 'pendiente') = 'S' and  dw_minuta.getitemstring(1, 'anulada') = 'N' then
		event csd_recalcular_todo('','')
	END IF

	// Metemos el n_aviso
	if dw_minuta.getitemstatus(1, 0, Primary!) = New! or dw_minuta.getitemstatus(1, 0, Primary!) = NewModified! then
			if g_colegio='COAATCC' and f_tengo_permiso(g_usuario,'NAVISO_MOD' ,'%') = 1 then
				if f_es_vacio(dw_minuta.GetItemString(1,'n_aviso')) then
					if MessageBox(g_titulo,'Se va a generar el n$$HEX2$$ba002000$$ENDHEX$$de aviso de forma autom$$HEX1$$e100$$ENDHEX$$tica, $$HEX1$$bf00$$ENDHEX$$Desea Continuar?',Question!,YesNo!) = 2 then return -1
					dw_minuta.SetItem(1,'n_aviso',f_numera_aviso(true)) 
				end if
			else
				dw_minuta.SetItem(1,'n_aviso',f_numera_aviso(true)) // Modificado Ricardo 2005-05-12
			end if
	end if
end if

return retorno

end event

event type integer pfc_postupdate(powerobject apo_control[]);call super::pfc_postupdate;if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if
// Nos aprovechamos que es una variable global para actualizar el valor que tiene
if isvalid(w_caja) then
	i_st_minutas_consulta.actualizado = 'S'
end if
return ancestorreturnvalue
end event

event pfc_postopen;call super::pfc_postopen;g_id_minuta_actual = dw_minuta.getitemstring(1, 'id_minuta')
id_base_cip = dw_minuta.getitemnumber(1,'base_cip')

end event

event close;setnull(g_id_minuta_actual)


// MODIFICADO RICARDO 2004-08-13
closewithreturn(this, i_st_minutas_consulta)
// fin MODIFICADO RICARDO 2004-08-13

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_detalle
integer x = 1609
integer y = 1864
integer width = 471
integer height = 88
integer taborder = 240
string text = "Recuperar consulta"
end type

event cb_recuperar_pantalla::clicked;call super::clicked;parent.event csd_recalcular_todo('','')
dw_minuta.event csd_configura_tipo_gestion()

dw_minuta.setitemstatus(1, 0, Primary!, NewModified!)

end event

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_detalle
integer x = 1138
integer y = 1864
integer width = 471
integer height = 88
integer taborder = 230
string text = "Guardar consulta"
end type

type cbx_f_gastos from checkbox within w_minutas_detalle
integer x = 1883
integer y = 1744
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fact. de Gastos"
end type

event clicked;cb_ver_f_gastos.triggerevent(clicked!)
end event

type cbx_f_honos from checkbox within w_minutas_detalle
integer x = 1344
integer y = 1744
integer width = 521
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fact. de Honorarios"
end type

event clicked;cb_ver_f_honos.triggerevent(clicked!)
end event

type cbx_aviso from checkbox within w_minutas_detalle
integer x = 928
integer y = 1744
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carta de Aviso"
end type

event clicked;pb_ver_aviso.triggerevent(clicked!)

end event

type cb_ver_f_gastos from commandbutton within w_minutas_detalle
boolean visible = false
integer x = 1705
integer y = 1532
integer width = 448
integer height = 88
integer taborder = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Prev. Fact. Gastos"
end type

event clicked;if dw_factura_gastos.visible then
	dw_factura_gastos.visible = false
	this.text = 'Prev. Fact. Gastos'
	pb_grabar.enabled = true
	pb_cobrar.enabled = true
	cb_guardar_pantalla.enabled = true
	cb_recuperar_pantalla.enabled = true	
else
	this.text = 'Ocultar'
	pb_grabar.enabled = false
	pb_cobrar.enabled = false
	cb_guardar_pantalla.enabled = false
	cb_recuperar_pantalla.enabled = false
		//Yexaira 09/09/08 Se setean los campos de formula solo para COAATTGN
		choose case g_colegio
			case  'COAATMCA', 'COAATTGN', 'COAATTEB', 'COAATLL'
			int i
			for i= 1 to idw_descuentos.rowcount()
			 	 if idw_descuentos.getitemstring(i, 'tipo_informe') =  g_codigos_conceptos.cip then  dw_minuta.setitem(1, 'formula_cip', idw_descuentos.getitemstring(i, 'formula_sustituida'))
  			 	 if idw_descuentos.getitemstring(i, 'tipo_informe') =  g_codigos_conceptos.musaat_variable then  dw_minuta.setitem(1, 'formula_musaat', idw_descuentos.getitemstring(i, 'formula_sustituida'))
			next
	end choose
	dw_minuta.accepttext()
	if dw_factura_gastos.RowCount() = 0 Then
//		f_rellena_factura_gastos(dw_minuta,dw_factura_gastos,'COPIA PARA EL COLEGIADO')
		// Modificado Ricardo 2005-05-10
		st_generar_facturas_minutas parametros_factura_minuta
		
		parametros_factura_minuta.dw_minuta 			= dw_minuta
		parametros_factura_minuta.num_orig 				= 0
		parametros_factura_minuta.num_copias 			= 0
		parametros_factura_minuta.regulariza_musaat	= false
		parametros_factura_minuta.movimiento_musaat	= true
		parametros_factura_minuta.tipo_movimiento_csd= dw_minuta.getitemstring(1, 'tipo_minuta')
		parametros_factura_minuta.tipo_prev				= 'G'
		parametros_factura_minuta.dw_factura			= dw_factura_gastos
		
		f_generar_facturas_minuta(parametros_factura_minuta)
		// f_generar_facturas_minuta(dw_minuta,0,0, false, true, dw_minuta.getitemstring(1, 'tipo_minuta'), 'G', dw_factura_gastos)
		// FIN Modificado Ricardo 2005-05-10
	Else
		dw_factura_gastos.Reset()
//		f_rellena_factura_gastos(dw_minuta,dw_factura_gastos,'COPIA PARA EL COLEGIADO')
		// Modificado Ricardo 2005-05-10
		parametros_factura_minuta.dw_minuta 			= dw_minuta
		parametros_factura_minuta.num_orig 				= 0
		parametros_factura_minuta.num_copias 			= 0
		parametros_factura_minuta.regulariza_musaat	= false
		parametros_factura_minuta.movimiento_musaat	= true
		parametros_factura_minuta.tipo_movimiento_csd= dw_minuta.getitemstring(1, 'tipo_minuta')
		parametros_factura_minuta.tipo_prev				= 'G'
		parametros_factura_minuta.dw_factura			= dw_factura_gastos
		
		f_generar_facturas_minuta(parametros_factura_minuta)
		// f_generar_facturas_minuta(dw_minuta,0,0, false, true, dw_minuta.getitemstring(1, 'tipo_minuta'), 'G', dw_factura_gastos)
		// FIN Modificado Ricardo 2005-05-10
	End If
	

	
	if dw_factura_gastos.rowcount() > 0 then
		dw_factura_gastos.visible = true	
		if IsValid (dw_factura_gastos.inv_printpreview) then
			if dw_factura_gastos.inv_printpreview.of_GetEnabled() then
				return dw_factura_gastos.inv_printpreview.of_SetZoom(75)
			end if
		end if
	else
		messagebox(g_titulo, 'No existen conceptos')
		this.text = 'Prev. Fact. Gastos'
		pb_grabar.enabled = true
		pb_cobrar.enabled = true
		cb_guardar_pantalla.enabled = true
		cb_recuperar_pantalla.enabled = true
		cbx_f_gastos.checked = false
	end if
end if

end event

type cb_ver_f_honos from commandbutton within w_minutas_detalle
boolean visible = false
integer x = 1691
integer y = 1440
integer width = 530
integer height = 88
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Prev. Fact. Honorarios"
end type

event clicked;if dw_factura_honos.visible then
	dw_factura_honos.visible = false
	this.text = 'Prev. Fact. Honorarios'
	pb_grabar.enabled = true
	pb_cobrar.enabled = true
	cb_guardar_pantalla.enabled = true
	cb_recuperar_pantalla.enabled = true
else
	this.text = 'Ocultar'
	pb_grabar.enabled = false
	pb_cobrar.enabled = false
	cb_guardar_pantalla.enabled = false
	cb_recuperar_pantalla.enabled = false
	dw_minuta.accepttext()
	if dw_factura_honos.RowCount() > 0 Then dw_factura_honos.Reset()
//	f_rellena_factura_honos(dw_minuta,dw_factura_honos,'COPIA PARA EL COLEGIADO')
	// Modificado Ricardo 2005-05-10
	st_generar_facturas_minutas parametros_factura_minuta
	
	parametros_factura_minuta.dw_minuta 			= dw_minuta
	parametros_factura_minuta.num_orig 				= 0
	parametros_factura_minuta.num_copias 			= 0
	parametros_factura_minuta.regulariza_musaat	= false
	parametros_factura_minuta.movimiento_musaat	= true
	parametros_factura_minuta.tipo_movimiento_csd= dw_minuta.getitemstring(1, 'tipo_minuta')
	parametros_factura_minuta.tipo_prev				= 'H'
	parametros_factura_minuta.dw_factura			= dw_factura_honos
	
	f_generar_facturas_minuta(parametros_factura_minuta)
	// f_generar_facturas_minuta(dw_minuta,0,0, false, true, dw_minuta.getitemstring(1, 'tipo_minuta'), 'H', dw_factura_honos)
	// FIN Modificado Ricardo 2005-05-10
	if dw_factura_honos.rowcount() > 0 then
		dw_factura_honos.visible = true	
		if IsValid (dw_factura_honos.inv_printpreview) then
			if dw_factura_honos.inv_printpreview.of_GetEnabled() then
				return dw_factura_honos.inv_printpreview.of_SetZoom(75)
			end if
		end if
	else
		messagebox(g_titulo, 'No existen conceptos')
		this.text = 'Prev. Fact. Honorarios'
		pb_grabar.enabled = true
		pb_cobrar.enabled = true
		cb_guardar_pantalla.enabled = true
		cb_recuperar_pantalla.enabled = true
		cbx_f_honos.checked = false
	end if
end if

end event

type pb_cobrar from picturebutton within w_minutas_detalle
integer x = 466
integer y = 1724
integer width = 389
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cobrar"
boolean originalsize = true
end type

event clicked;string tipo_gestion, mensajes_aviso, ls_modificacion
double total_cliente, total_colegiado, res

dw_minuta.accepttext()

if dw_minuta.event pfc_updatespending() = 1 then
	// Modificado Ricardo 30-10-03
	res = parent.event pfc_save()
	// Hay que tener en cuenta que si no se ha podido grabar, no dejamos continuar con el script de esta ventana
	if res<1 then return
end if
if dw_minuta.getitemstring(1, 'pendiente') = 'N' then
	messagebox(g_titulo, 'Este Aviso ya est$$HEX2$$e1002000$$ENDHEX$$cobrado')
	return 
end if
if dw_minuta.getitemstring(1, 'anulada') = 'S' then
	messagebox(g_titulo, 'Este Aviso est$$HEX2$$e1002000$$ENDHEX$$anulado')
	return 
end if

if parent.event csd_control_estados() = 0 then return

// Recalculamos porque al generar avisos con honorarios no rellena los
// campos total_colegiado y total_cliente y al cobrar aparece el aviso
// que hay a continuaci$$HEX1$$f300$$ENDHEX$$n ---- DAVID 13/10/2004
parent.event csd_recalcular_todo('','')
dw_minuta.update()

// Validar honos > gastos en en los avisos con gesti$$HEX1$$f300$$ENDHEX$$n de cobro
tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')
total_colegiado = dw_minuta.getitemNumber(1, 'total_colegiado')
total_cliente = dw_minuta.getitemNumber(1, 'total_cliente')
if tipo_gestion = 'C' then
	if total_cliente < total_colegiado then
		// Cuando no hay honorarios y si hay gastos no debe aparecer el mensaje
		if (g_colegio='COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI') and dw_minuta.getitemnumber(1, 'base_honos')=0 and total_colegiado>0 then
			mensajes_aviso = ''
		else
			mensajes_aviso += cr + 'El total de la Factura de Gastos (' + string(total_colegiado, "#,##0.00")+') supera al total de la Factura de Honorarios (' + string(total_cliente, "#,##0.00") +')' +cr + &
			'Si sigue con el proceso de cobro la diferencia se cargar$$HEX2$$e1002000$$ENDHEX$$contablemente en la cuenta del colegiado que podr$$HEX2$$e1002000$$ENDHEX$$quedar deudora'
		end if
	end if
end if

// Miramos el saldo deudor del colegiado
if g_comprobar_saldo_deudor_col = 'S' then
	openwithparm(w_conta_saldo_resumen, dw_minuta.getitemstring(1, 'id_colegiado'))
end if

// Sacamos mensajes de s$$HEX1$$f300$$ENDHEX$$lo aviso
if mensajes_aviso<>'' then
	if messagebox(g_titulo, mensajes_aviso + cr + '$$HEX1$$bf00$$ENDHEX$$Desea Continuar?', Question!, YesNo!) = 2 then 
		return
	end if
end if

//SCP-1057
if messagebox(g_titulo, 'Las facturas y cobros se procesar$$HEX2$$e1002000$$ENDHEX$$a la empresa activa ('+ g_nombre_empresa+'). $$HEX1$$bf00$$ENDHEX$$Desea Continuar?', Exclamation!, YesNo!) = 2 then 
	return
end if	
		
parent.event csd_cobrar()

if isvalid(g_detalle_fases) then
	g_detalle_fases.postevent('csd_refrescar_avisos')
	g_detalle_fases.postevent('csd_refrescar_src')	
end if
if isvalid(w_caja) then
	i_st_minutas_consulta.actualizado = 'S'
end if

end event

type pb_salir from picturebutton within w_minutas_detalle
integer x = 2437
integer y = 1724
integer width = 389
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
boolean originalsize = true
end type

event clicked;// 	 SCP-455 est$$HEX2$$e1002000$$ENDHEX$$dando problemas la instrucci$$HEX1$$f300$$ENDHEX$$n .resetupdate() as$$HEX2$$ed002000$$ENDHEX$$que la eliminamos del c$$HEX1$$f300$$ENDHEX$$digo
//if(g_colegio <> 'COAATCC')then
	//dw_minuta.resetupdate()
//end if
close(parent)
end event

type pb_ver_aviso from picturebutton within w_minutas_detalle
boolean visible = false
integer x = 1696
integer y = 1352
integer width = 489
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar Aviso"
boolean originalsize = true
end type

event clicked;
if dw_impresion.visible then
	dw_impresion.visible = false
	this.text = 'Previsualizar Aviso'
	if dw_minuta.getitemstring(1, 'anulada') = 'N' and dw_minuta.getitemstring(1, 'pendiente') = 'S' then
		pb_cobrar.enabled = true
	end if
	pb_grabar.enabled = true
	cb_guardar_pantalla.enabled = true
	cb_recuperar_pantalla.enabled = true
else
	this.text = 'Ocultar Aviso'
	pb_grabar.enabled = false
	pb_cobrar.enabled = false
	cb_guardar_pantalla.enabled = false
	cb_recuperar_pantalla.enabled = false
	dw_minuta.accepttext()
	
	f_rellenar_ficha_aviso(dw_minuta, dw_impresion)			
	
	if dw_impresion.rowcount() > 0 then
		dw_impresion.visible = true	
		if IsValid (dw_impresion.inv_printpreview) then
			if dw_impresion.inv_printpreview.of_GetEnabled() then
				return dw_impresion.inv_printpreview.of_SetZoom(75)
			end if
		end if
	else
		messagebox(g_titulo, 'No existen conceptos')
	end if
end if
end event

type pb_grabar from picturebutton within w_minutas_detalle
integer x = 78
integer y = 1724
integer width = 389
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
boolean originalsize = true
end type

event clicked;parent.event pfc_save()

if ib_cobro_aviso= true then
	ib_cobro_aviso = false
end if
end event

type cb_ver_recibo_musaat from commandbutton within w_minutas_detalle
boolean visible = false
integer x = 1696
integer y = 1624
integer width = 530
integer height = 88
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Prev. Fact. Musaat"
end type

event clicked;if dw_musaat.visible then
	dw_musaat.visible = false
	pb_grabar.enabled = true
	pb_cobrar.enabled = true
	cb_guardar_pantalla.enabled = true
	cb_recuperar_pantalla.enabled = true
else
	pb_grabar.enabled = false
	pb_cobrar.enabled = false
	cb_guardar_pantalla.enabled = false
	cb_recuperar_pantalla.enabled = false
	dw_minuta.accepttext()
	

	
	if dw_musaat.RowCount() > 0 Then 	dw_musaat.Reset()
	
	// Modificado Ricardo 2005-05-10
	st_generar_facturas_minutas parametros_factura_minuta
	
	parametros_factura_minuta.dw_minuta 			= dw_minuta
	parametros_factura_minuta.num_orig 				= 0
	parametros_factura_minuta.num_copias 			= 0
	parametros_factura_minuta.regulariza_musaat	= false
	parametros_factura_minuta.movimiento_musaat	= true
	parametros_factura_minuta.tipo_movimiento_csd= dw_minuta.getitemstring(1, 'tipo_minuta')
	parametros_factura_minuta.tipo_prev				= 'M'
	parametros_factura_minuta.dw_factura			= dw_musaat
	
		choose case g_colegio
			case  'COAATMCA'
			int i
			for i= 1 to idw_descuentos.rowcount()
			 	
  			 	 if idw_descuentos.getitemstring(i, 'tipo_informe') =  g_codigos_conceptos.musaat_variable then  dw_minuta.setitem(1, 'formula_musaat', idw_descuentos.getitemstring(i, 'formula_sustituida'))
			next
	end choose
	f_generar_facturas_minuta(parametros_factura_minuta)

	//	f_generar_facturas_minuta(dw_minuta,0,0, false, true, dw_minuta.getitemstring(1, 'tipo_minuta'), 'M', dw_musaat)
	// FIN Modificado Ricardo 2005-05-10
	// COMENTADO por la SCP-488
	//if dw_musaat.rowcount() > 0  and dw_minuta.getitemdecimal(1, 'base_musaat') <> 0 then
	if dw_musaat.rowcount() > 0  then
		dw_musaat.visible = true	
		if IsValid (dw_musaat.inv_printpreview) then
			if dw_musaat.inv_printpreview.of_GetEnabled() then
				return dw_musaat.inv_printpreview.of_SetZoom(75)
			end if
		end if
	else
		messagebox(g_titulo, 'No existen conceptos')
		pb_grabar.enabled = true
		pb_cobrar.enabled = true
		cb_guardar_pantalla.enabled = true
		cb_recuperar_pantalla.enabled = true
		cbx_f_musaat.checked = false
	end if
end if

end event

type cbx_f_musaat from checkbox within w_minutas_detalle
boolean visible = false
integer x = 891
integer y = 1744
integer width = 457
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
string text = "Fact. de Musaat"
end type

event clicked;cb_ver_recibo_musaat.triggerevent(clicked!)
end event

type dw_historico from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2272
integer y = 392
integer width = 443
integer height = 292
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_historico"
boolean hscrollbar = true
end type

event type long pfc_addrow();call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_minuta.GetItemString(1,'id_fase') )
this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue

end event

type dw_fases_datos_exp from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_datos_exp"
boolean border = false
end type

type dw_clientes from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_promotores"
boolean border = false
end type

type dw_colegiados from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "ds_fases_colegiados"
boolean border = false
end type

type dw_descuentos from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_informes"
boolean border = false
end type

type dw_estadistica from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_expedientes_estadistica"
boolean border = false
end type

type dw_fases_src from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 160
boolean bringtotop = true
string title = "none"
string dataobject = "d_musaat_movimientos_contrato"
boolean border = false
end type

type dw_fases_minutas from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 170
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_minutas"
boolean border = false
end type

type dw_fases_detalle from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 320
integer height = 220
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_detalle"
boolean border = false
end type

type dw_composite from u_dw within w_minutas_detalle
boolean visible = false
integer x = 2277
integer y = 1756
integer width = 133
integer height = 100
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string dataobject = "ds_composite"
end type

type dw_minuta from u_dw within w_minutas_detalle
event csd_calendario ( )
event csd_cargar_dddw ( )
event csd_configura_tipo_gestion ( )
event csd_ultimo_num_minuta ( )
event csd_configura_aplicas_tfe ( string gestion,  string id_fase )
event csd_minuta_urgente ( string urgente )
integer x = 18
integer y = 32
integer width = 2843
integer height = 1664
integer taborder = 10
string dataobject = "d_minutas_detalle"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event csd_calendario;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event csd_cargar_dddw;
IF i_dwc_colegiados.Retrieve(dw_minuta.GetItemString(1,'id_fase'))<1 THEN
	i_dwc_colegiados.InsertRow(0)
END IF
IF i_dwc_clientes.Retrieve(dw_minuta.GetItemString(1,'id_fase'))<1 THEN
	i_dwc_clientes.InsertRow(0)
END IF

i_dwc_colegiados.ResetUpdate()
i_dwc_clientes.ResetUpdate()
end event

event csd_configura_tipo_gestion();this.setredraw(false)

CHOOSE CASE dw_minuta.getitemstring(1, 'tipo_gestion')
	CASE 'S'
		this.object.b_calc_dv.y = this.object.aplica_honos.y
		this.object.aplica_dv.y = this.object.b_calc_dv.y		
		this.object.base_dv.y = this.object.b_calc_dv.y
		this.object.porc_iva_dv.y = this.object.b_calc_dv.y
		this.object.t_iva_dv.y = this.object.b_calc_dv.y
		this.object.iva_dv.y = this.object.b_calc_dv.y
		this.object.paga_dv.y = this.object.b_calc_dv.y

		this.object.b_calc_cip.y = string(long(this.object.b_calc_dv.y ) + 60)
		this.object.aplica_cip.y = this.object.b_calc_cip.y		
		this.object.base_cip.y = this.object.b_calc_cip.y
		this.object.porc_iva_cip.y = this.object.b_calc_cip.y
		this.object.t_iva_cip.y = this.object.b_calc_cip.y
		this.object.iva_cip.y = this.object.b_calc_cip.y
		this.object.porc_cip.y = this.object.b_calc_cip.y
		this.object.t_18.y = this.object.b_calc_cip.y
		
		this.object.b_calc_musaat.y = string(long(this.object.b_calc_cip.y) + 60)
		this.object.aplica_musaat.y = this.object.b_calc_musaat.y		
		this.object.base_musaat.y = this.object.b_calc_musaat.y
		this.object.tipo_minuta.y = this.object.b_calc_musaat.y
		this.object.porc_musaat.y = this.object.b_calc_musaat.y
		this.object.t_porc_musaat.y = this.object.b_calc_musaat.y
		this.object.n_contrato_ant.y = this.object.b_calc_musaat.y
		this.object.n_contrato_ant_t.y = this.object.b_calc_musaat.y
		this.object.pem_certificacion.y = this.object.b_calc_musaat.y // Modificado Ricardo 2005-06-13
		this.object.pem_certificacion_t.y = this.object.b_calc_musaat.y // Modificado Ricardo 2005-06-13
		
		this.object.aplica_impresos.y = string(long(this.object.b_calc_musaat.y ) + 60)
		this.object.base_impresos.y = this.object.aplica_impresos.y
		this.object.iva_impresos.y = this.object.aplica_impresos.y
		this.object.porc_iva_impresos.y = this.object.aplica_impresos.y
		this.object.t_iva_impresos.y = this.object.aplica_impresos.y
		//this.object.concepto_otros.y = string(long(this.object.aplica_impresos.y ) + 60)	
		this.object.concepto_otros.y = this.object.aplica_impresos.y
		this.object.concepto_otros.x = 700
		this.object.concepto_otros.width = 1010	
		
		choose case g_colegio
			case 'COAATGC' 				
				// Desplazamiento y la descripcion
				this.object.aplica_desplaza.width = 500
				this.object.aplica_desplaza.y = string(long(this.object.aplica_impresos.y) + 60)
				this.object.base_desplaza.y = this.object.aplica_desplaza.y
				this.object.iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.porc_iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.t_iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.concepto_desplaza.y = this.object.aplica_desplaza.y
				this.object.concepto_desplaza.x = 700
				this.object.concepto_desplaza.width = 1010	
			case 'COAATZ'	
				// Modificacion Ricardo 2005-06-15
				// Presupuesto nuevo solo para zaragoza
				// incic. 0000002726
				if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S'  then
					this.object.pem_certificacion.visible = true
					this.object.pem_certificacion_t.visible = true
				end if	
				// FIN Modificacion Ricardo 2005-06-15
			case 'COAATLE' 
				this.object.paga_dv.y = this.object.aplica_impresos.y
				this.object.base_otros.y = this.object.aplica_musaat.y
				this.object.bonif_musaat_t.y = this.object.aplica_musaat.y
				this.object.n_contrato_ant.y = string(long(this.object.concepto_otros.y) + 60)
				this.object.n_contrato_ant_t.y =  string(long(this.object.concepto_otros.y) + 60)
			end choose
		

		
	CASE 'A', 'C'
		this.object.b_calc_dv.y = string(long(this.object.concepto_desplaza.y) + 60)
		this.object.aplica_dv.y = this.object.b_calc_dv.y		
		this.object.base_dv.y = this.object.b_calc_dv.y
		this.object.porc_iva_dv.y = this.object.b_calc_dv.y
		this.object.t_iva_dv.y = this.object.b_calc_dv.y
		this.object.iva_dv.y = this.object.b_calc_dv.y
		this.object.paga_dv.y = this.object.b_calc_dv.y		

		this.object.b_calc_cip.y = string(long(this.object.b_calc_dv.y ) + 60)
		this.object.aplica_cip.y = this.object.b_calc_cip.y		
		this.object.base_cip.y = this.object.b_calc_cip.y
		this.object.porc_iva_cip.y = this.object.b_calc_cip.y
		this.object.t_iva_cip.y = this.object.b_calc_cip.y
		this.object.iva_cip.y = this.object.b_calc_cip.y
		this.object.porc_cip.y = this.object.b_calc_cip.y
		this.object.t_18.y = this.object.b_calc_cip.y
		
		this.object.b_calc_musaat.y = string(long(this.object.b_calc_cip.y) + 60)
		this.object.aplica_musaat.y = this.object.b_calc_musaat.y		
		this.object.base_musaat.y = this.object.b_calc_musaat.y
		this.object.tipo_minuta.y = this.object.b_calc_musaat.y
		this.object.porc_musaat.y = this.object.b_calc_musaat.y
		this.object.t_porc_musaat.y = this.object.b_calc_musaat.y
		this.object.n_contrato_ant.y = this.object.b_calc_musaat.y
		this.object.n_contrato_ant_t.y = this.object.b_calc_musaat.y		
		this.object.pem_certificacion.y = this.object.b_calc_musaat.y // Modificado Ricardo 2005-06-13
		this.object.pem_certificacion_t.y = this.object.b_calc_musaat.y // Modificado Ricardo 2005-06-13

		this.object.aplica_impresos.y = string(long(this.object.b_calc_musaat.y ) + 60)
		this.object.base_impresos.y = this.object.aplica_impresos.y
		this.object.iva_impresos.y = this.object.aplica_impresos.y
		this.object.porc_iva_impresos.y = this.object.aplica_impresos.y
		this.object.t_iva_impresos.y = this.object.aplica_impresos.y
		
		this.object.concepto_otros.y = string(long(this.object.aplica_impresos.y ) + 60)
		CHOOSE CASE g_colegio 
			CASE 'COAATTFE'
				this.object.cobro_a_cuenta_t.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.cobro_a_cuenta.y = string(long(this.object.concepto_otros.y ) + 60)
			CASE 'COAATZ', 'COAATGU', 'COAATB'
				this.object.base_garantia.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.t_12.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.cobro_a_cuenta_t.y = string(long(this.object.t_12.y ) + 60)
				this.object.cobro_a_cuenta.y = string(long(this.object.base_garantia.y ) + 60)
				// Modificacion Ricardo 2005-06-15
				// Presupuesto nuevo solo para zaragoza
				if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' and g_colegio = 'COAATZ' then
					this.object.pem_certificacion.visible = true
					this.object.pem_certificacion_t.visible = true
				end if
				// FIN Modificacion Ricardo 2005-06-15
			CASE 'COAATGC'
				// Modificado Ricardo 2005-06-15
				// Solo las posiciones es lo que depende del tipo de gestion!
				// Hay que recolocar todos los controles centrales!!!!
				// Descripcion de honorarios
				this.object.aplica_honos.width = 379
				this.object.concepto_honos.y = this.object.aplica_honos.y
				this.object.concepto_honos.x = 600
				this.object.concepto_honos.width = 800
				// Desplazamiento y la descripcion
				this.object.aplica_desplaza.width = 500
				this.object.aplica_desplaza.y = string(long(this.object.aplica_honos.y) + 64)
				this.object.base_desplaza.y = this.object.aplica_desplaza.y
				this.object.iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.porc_iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.t_iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.iva_desplaza.y = this.object.aplica_desplaza.y
				this.object.concepto_desplaza.y = this.object.aplica_desplaza.y
				this.object.concepto_desplaza.x = 700
				this.object.concepto_desplaza.width = 1010
				// Derechos de visado
				this.object.aplica_dv.y = string(long(this.object.aplica_honos.y) + 128)
				this.object.base_dv.y = this.object.aplica_dv.y
				this.object.porc_iva_dv.y = this.object.aplica_dv.y
				this.object.t_iva_dv.y = this.object.aplica_dv.y
				this.object.iva_dv.y = this.object.aplica_dv.y
				// CIP
				this.object.aplica_cip.y = string(long(this.object.aplica_honos.y) + 192)
				this.object.base_cip.y = this.object.aplica_cip.y
				this.object.porc_iva_cip.y = this.object.aplica_cip.y
				this.object.t_iva_cip.y = this.object.aplica_cip.y
				this.object.iva_cip.y = this.object.aplica_cip.y
				// MUSAAT
				this.object.aplica_musaat.y = string(long(this.object.aplica_honos.y) + 256)
				this.object.base_musaat.y = this.object.aplica_musaat.y
				this.object.t_porc_musaat.y = this.object.aplica_musaat.y
				this.object.porc_musaat.y = this.object.aplica_musaat.y
				this.object.tipo_minuta.y = this.object.aplica_musaat.y
				this.object.n_contrato_ant_t.y = this.object.aplica_musaat.y
				this.object.n_contrato_ant.y = this.object.aplica_musaat.y
				this.object.b_calc_musaat.y = this.object.aplica_musaat.y
				// RETVOL
				this.object.aplica_retvol.y = string(long(this.object.aplica_honos.y) + 320)
				this.object.t_2.y = this.object.aplica_retvol.y
				this.object.porc_retvol.y = this.object.aplica_retvol.y
				this.object.base_retvol.y = this.object.aplica_retvol.y
				// GARANTIA
				this.object.base_garantia.y = string(long(this.object.aplica_honos.y) + 384)
				this.object.t_12.y = this.object.base_garantia.y 
				// COBRO A CUENTA
				//this.object.cobro_a_cuenta.y = string(long(this.object.aplica_honos.y) + 360)
				//this.object.cobro_a_cuenta_t.y = this.object.cobro_a_cuenta.y 
				// SUPLIDO CIP
				this.object.base_cip_suplida.y = string(long(this.object.aplica_honos.y) + 448)
				this.object.cip_suplida_t.y = this.object.base_cip_suplida.y
				this.object.porc_iva_cip_suplida.y = this.object.base_cip_suplida.y
				this.object.t_iva_cip_suplida.y = this.object.base_cip_suplida.y
				this.object.iva_cip_suplida.y = this.object.base_cip_suplida.y
				// SUPLIDO MUSAAT
				this.object.musaat_suplida.y = string(long(this.object.aplica_honos.y) + 512)
				this.object.musaat_suplida_t.y = this.object.musaat_suplida.y
			CASE 'COAATLE'
				this.object.aplica_retvol.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.t_2.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.porc_retvol.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.base_retvol.y = string(long(this.object.concepto_otros.y ) + 60)
				this.object.t_12.y = string(long(this.object.base_retvol.y ) + 60)
				this.object.base_garantia.y = string(long(this.object.base_retvol.y ) + 60)
				this.object.base_otros.y = this.object.aplica_musaat.y
				this.object.bonif_musaat_t.y = this.object.aplica_musaat.y
				this.object.n_contrato_ant.y = this.object.concepto_otros.y
				this.object.n_contrato_ant_t.y = this.object.concepto_otros.y
			CASE 'COAATA'
				this.object.aplica_retvol.y = string(long(this.object.aplica_impresos.y ) + 60)
				this.object.t_2.y = string(long(this.object.aplica_impresos.y ) + 60)
				this.object.porc_retvol.y = string(long(this.object.aplica_impresos.y ) + 60)
				this.object.base_retvol.y = string(long(this.object.aplica_impresos.y ) + 60)
		END CHOOSE
END CHOOSE

this.setredraw(true)

end event

event csd_ultimo_num_minuta;// Avisamos si el n$$HEX2$$ba002000$$ENDHEX$$de aviso es superior al contador de n$$HEX2$$ba002000$$ENDHEX$$de documentaci$$HEX1$$f300$$ENDHEX$$n
string n_aviso
double valor

n_aviso = dw_minuta.getitemstring(1, 'n_aviso')

SELECT contadores.valor  
INTO :valor  
FROM contadores  
WHERE contadores.contador = 'ULT_MIN_DOC'  ;

if double(n_aviso) > valor then messagebox(g_titulo, 'El N$$HEX2$$ba002000$$ENDHEX$$Aviso es superior al $$HEX1$$fa00$$ENDHEX$$ltimo N$$HEX2$$ba002000$$ENDHEX$$Documentaci$$HEX1$$f300$$ENDHEX$$n')

end event

event csd_configura_aplicas_tfe(string gestion, string id_fase);string paga_gastos_cliente

select paga_gastos_cliente into :paga_gastos_cliente from fases where id_fase = :id_fase;

if gestion <> 'C' then
	if paga_gastos_cliente = 'S' then 
		dw_minuta.setitem(1,'pagador','3')
	else 
		dw_minuta.setitem(1,'pagador','1')
	end if
end if

if gestion <> 'S' then
	if paga_gastos_cliente = 'S' then
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_honos','S')
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_desplaza','S')
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_cip','S')
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_musaat','S')
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_dv','S')
	else
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_honos','S')
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_desplaza','S')			
		dw_minuta.setitem(dw_minuta.getrow(),'aplica_dv','S')					
	end if
else
	dw_minuta.setitem(dw_minuta.getrow(),'aplica_dv','S')		
end if

end event

event csd_minuta_urgente(string urgente);string id_fase, tarifa, contenido

id_fase = this.getitemstring(1, 'id_fase')
	
SELECT tarifa, epigrafe INTO :tarifa, :contenido FROM fases_honos_cip WHERE id_fase = :id_fase   ;
	
CHOOSE CASE Tarifa
	CASE '3.1', '3.2', '3.3', '3.4', '4.1.1', '4.1.2', '4.1.4', 'A.2.5.1', 'OT'
		if urgente = 'S' then
			this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') + 15)
		else
			this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') - 15)
		end if
	CASE 'A.1.1', 'A.1.2', 'A.1.3', 'A.1.4', 'A.1.6.3', 'A.1.6.4'
		if urgente = 'S' then
			this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') + 30)
		else
			this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') - 30)
		end if
	CASE '5.15'
		CHOOSE CASE Contenido
			CASE '444', '445', '446', '447', '441', '449', '443'
				if urgente = 'S' then
					this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') + 30)
				else
					this.setitem(1, 'base_dv', this.getitemnumber(1, 'base_dv') - 30)
				end if
		END CHOOSE
END CHOOSE

end event

event itemchanged;double porc_honos=0, total_honos_col_cli=0, base_honos=0, porc_iva_honos=0, porc_iva_desplaza=0, porc_iva_dv=0
double porc_iva_cip=0, iva_honos=0, iva_desplaza=0, iva_dv=0, iva_cip=0, base_desplaza=0, base_dv=0, base_cip=0
double porc_retvol=0, base_retvol=0, maximo=0, maximo_porc=0, base_musaat=0, porc_musaat=0, porc_iva_impr=0
double base_impr=0, iva_impr=0, cip=0, por_cip=0
string tipo_gestion, id_fase, tipo_minuta
boolean bl_regularizacion

// HISTORICO
parent.event csd_modificacion_datos(this.getitemstring(1,'id_fase'), this, 'MINUTAS', dwo.name, row)

choose case dwo.name
	case 'tipo_minuta'
		tipo_minuta = data
	case else
		tipo_minuta = this.getitemstring(1,'tipo_minuta')
end choose
if f_es_vacio(tipo_minuta) then tipo_minuta = '00'
bl_regularizacion = false
if MidA(tipo_minuta,1,1) = '2' or MidA(tipo_minuta,1,1) = '6' then
	bl_regularizacion = TRUE
end if

choose case dwo.name 
	case 'id_cliente'
		parent.post event csd_calcular_descuentos_auto()
		// Modificado Ricardo 04/02/16
		if not f_es_vacio(data) then
			this.setitem(row, 'irpf_cliente', f_clientes_irpf_cliente(data))
		else
			// No tocamos nada, aunque igual deberiamos desmarcar el check del irpf. Me parece que no se puede producir el caso
			// Al menos de momento (dddw no editable)
		end if
		//Paco 25/8/2005. Una vez tenemos el colegiado y el cliente ponemos el tipo de minuta m$$HEX1$$e100$$ENDHEX$$s adecuado.
		string id_colegiado
		id_colegiado = this.getitemstring(1, 'id_colegiado')
		if not f_es_vacio(data) and not f_es_vacio(id_colegiado) then parent.post event csd_calcular_tipo_minuta(id_colegiado, data)
		
		// FIN Modificado Ricardo 04/02/16
	case 'tipo_gestion'
		this.post event csd_configura_tipo_gestion()
		choose case data
			case 'C'
				dw_minuta.setitem(1, 'pagador', '3')						
			case 'A','S'
				dw_minuta.setitem(1, 'pagador', '1')						
		end choose
		// No hay Fact de Honos
		if data = 'S' then
			parent.cbx_f_honos.enabled = false
			dw_minuta.setitem(1, 'aplica_honos', 'N')				
			dw_minuta.setitem(1, 'aplica_desplaza', 'N')						
			dw_minuta.setitem(1, 'aplica_retvol', 'N')								
			
			dw_minuta.setitem(1, 'aplica_dv', 'S')						
			dw_minuta.setitem(1, 'aplica_cip', 'S')						
			dw_minuta.setitem(1, 'aplica_musaat', 'S')
			
			dw_minuta.setitem(1, 'aplica_impresos', 'N')
			if g_colegio = 'COAATTFE' then
				id_fase = dw_minuta.getitemstring(dw_minuta.getrow(),'id_fase')
				this.event csd_configura_aplicas_tfe('S',id_fase)
			end if
			if g_colegio='COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATTER' /*or g_colegio = 'COAATLE'*/ then dw_minuta.setitem(1, 'aplica_impresos', 'S')
			// Para que lo cambie cuando hay m$$HEX1$$e100$$ENDHEX$$s de un colegiado o cliente
			if g_colegio='COAATAVI' or g_colegio = 'COAATNA' then dw_minuta.setitem(1, 'paga_dv', 'C')
			
		elseif data = 'A' then
		 	CHOOSE CASE g_colegio
				CASE 'COAATTFE'
					// QUE NO SE TOQUEN LOS CHECKS
				CASE ELSE
					parent.cbx_f_honos.enabled = true	
					dw_minuta.setitem(1, 'aplica_honos', 'S')				
		//			dw_minuta.setitem(1, 'aplica_desplaza', 'N')						
					
					dw_minuta.setitem(1, 'aplica_retvol', 'N')								
		//			dw_minuta.setitem(1, 'aplica_dv', 'N')						
					dw_minuta.setitem(1, 'aplica_cip', 'N')						
					dw_minuta.setitem(1, 'aplica_musaat', 'N')	
					
					dw_minuta.setitem(1, 'aplica_impresos', 'N')
			END CHOOSE			
		else
			parent.cbx_f_honos.enabled = true	
			dw_minuta.setitem(1, 'aplica_honos', 'S')				
			dw_minuta.setitem(1, 'aplica_desplaza', 'N')						
			
			dw_minuta.setitem(1, 'aplica_retvol', 'N')								
			dw_minuta.setitem(1, 'aplica_dv', 'N')						
			dw_minuta.setitem(1, 'aplica_cip', 'N')						
			dw_minuta.setitem(1, 'aplica_musaat', 'N')
			
			dw_minuta.setitem(1, 'aplica_impresos', 'N')

         // S$$HEX1$$f300$$ENDHEX$$lo Guipuzkoa
         if g_colegio='COAATGUI' then dw_minuta.setitem(1, 'aplica_dv', 'S')
         // S$$HEX1$$f300$$ENDHEX$$lo RIOJA
//         if g_colegio='COAATLR' then dw_minuta.setitem(1, 'aplica_dv', 'S')
			if g_colegio = 'COAATTFE' then
				id_fase = dw_minuta.getitemstring(dw_minuta.getrow(),'id_fase')
				this.event csd_configura_aplicas_tfe('C',id_fase)
			end if
			if g_colegio='COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATNA' or g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio = 'COAATTER' OR g_colegio='COAATLL' then
				dw_minuta.setitem(1, 'aplica_impresos', 'S')
				dw_minuta.setitem(1, 'aplica_dv', 'S')
				dw_minuta.setitem(1, 'aplica_desplaza', 'S')
			end if
			// CGN-214
			if(g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' OR g_colegio='COAATLL')then
				dw_minuta.setitem(1, 'aplica_impresos', 'N')
				dw_minuta.setitem(1, 'aplica_dv', 'S')
				dw_minuta.setitem(1, 'aplica_desplaza', 'S')
			end if
			if g_colegio = 'COAATLE' then dw_minuta.setitem(1, 'aplica_impresos', 'N')
		end if
		if data = 'S' then parent.post event csd_calcular_descuentos_auto()		
		if data = 'A' or data = 'C' then dw_minuta.post event buttonclicked(1,1, dw_minuta.object.b_calc_retvol)
		
	case 't_iva'
		this.setitem(1, 'porc_iva', f_dame_porcent_iva (  data )) 	
		
	case 'porc_honos'
		// C$$HEX1$$e100$$ENDHEX$$lculo de los honorarios en funci$$HEX1$$f300$$ENDHEX$$n del porcentaje
		porc_honos = double(data)
		total_honos_col_cli = parent.event csd_calcula_honos_col_cli()
		base_honos = f_redondea(total_honos_col_cli * porc_honos/100)
		maximo = parent.event csd_maximo_honos()		
		if total_honos_col_cli = 0 then maximo_porc = 0 else maximo_porc = (maximo / total_honos_col_cli) * 100
		if base_honos > maximo and not MidA(tipo_minuta,1,1) = '6' then //(not bl_regularizacion) then /*Modif. David INC.5125*/
			messagebox(g_titulo, 'El m$$HEX1$$e100$$ENDHEX$$ximo de Honorarios de este colegiado a este cliente es : ' + string(maximo, "###,###,##0.00") + cr +&
			'Esto es un % de : ' + string(maximo_porc, "###,###,##0.00"))
			parent.post event csd_poner_totales(maximo_porc,maximo)
		end if		
		this.setitem(1, 'base_honos', base_honos)
		if base_honos > 0 then 
			parent.post event csd_calcular_descuentos_auto()
		else
			if double(data) > 0 then return 2
		end if
		
	case 'base_honos'
		base_honos = double(data)
		total_honos_col_cli = parent.event csd_calcula_honos_col_cli()
		if total_honos_col_cli = 0 then porc_honos = 0 else porc_honos = f_redondea( base_honos / total_honos_col_cli * 100)	
		maximo = parent.event csd_maximo_honos()
		if total_honos_col_cli = 0 then maximo_porc = 0 else maximo_porc = (maximo / total_honos_col_cli) * 100
		if base_honos > maximo and not MidA(tipo_minuta,1,1) = '6' then //(not bl_regularizacion) then /*Modif. David INC.5125*/
			messagebox(g_titulo, 'El m$$HEX1$$e100$$ENDHEX$$ximo de Honorarios de este colegiado a este cliente es : ' + string(maximo, "###,###,##0.00"))
			if messagebox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Desea sobrepasar los honorarios?', Question!, YesNo!) <> 1 then
				parent.post event csd_poner_totales(maximo_porc,maximo)//(100,maximo)
			end if
		end if
		this.setitem(1, 'porc_honos', porc_honos)						
		parent.post event csd_calcular_descuentos_auto()
		
	case 'porc_retvol'
		// C$$HEX1$$e100$$ENDHEX$$lculo de los honorarios en funci$$HEX1$$f300$$ENDHEX$$n del porcentaje
		porc_retvol = double(data)
		base_honos = this.getitemnumber(1, 'base_honos')
		base_retvol = f_redondea(base_honos * porc_retvol/100)
		this.setitem(1, 'base_retvol', base_retvol)
		
	case 'base_retvol'
		base_retvol = double(data)
		base_honos = this.getitemnumber(1, 'base_honos')
		porc_retvol = f_redondea( base_retvol / base_honos * 100)
		this.setitem(1, 'porc_retvol', porc_retvol)
		
	case 't_iva_honos'
		porc_iva_honos = f_dame_porcent_iva (  data )
		this.setitem(1,'porc_iva_honos', porc_iva_honos)
		base_honos = this.getitemnumber(1, 'base_honos')
		iva_honos = f_redondea(base_honos * porc_iva_honos /100)
		this.setitem(1,'iva_honos', iva_honos)
		
	case 't_iva_desplaza'		
		porc_iva_desplaza = f_dame_porcent_iva (  data )		
		this.setitem(1,'porc_iva_desplaza', porc_iva_desplaza)	
		base_desplaza = this.getitemnumber(1, 'base_desplaza')
		iva_desplaza = f_redondea(base_desplaza * porc_iva_desplaza /100)		
		this.setitem(1,'iva_desplaza', iva_desplaza)
		
	case 't_iva_dv'		
		porc_iva_dv = f_dame_porcent_iva (  data )		
		this.setitem(1,'porc_iva_dv', porc_iva_dv)		
		base_dv = this.getitemnumber(1, 'base_dv')
		iva_dv = f_redondea(base_dv * porc_iva_dv /100)				
		this.setitem(1,'iva_dv', iva_dv)
		
	case 't_iva_cip'
		porc_iva_cip = f_dame_porcent_iva (  data )		
		this.setitem(1,'porc_iva_cip', porc_iva_cip)		
		base_cip = this.getitemnumber(1, 'base_cip')
		iva_cip = f_redondea(base_cip * porc_iva_cip /100)				
		this.setitem(1,'iva_cip', iva_cip)
		
	case 't_iva_impresos'		
		porc_iva_impr = f_dame_porcent_iva (  data )
		this.setitem(1,'porc_iva_impresos', porc_iva_impr)		
		base_impr = this.getitemnumber(1, 'base_impresos')
		iva_impr = f_redondea(base_impr * porc_iva_impr /100)				
		this.setitem(1,'iva_impresos', iva_impr)
		
	case 'id_colegiado'
		//Modificado Ricardo 2005-02-22
		// Creado por Ricardo para ver si no tengo que hacer mas!!
		st_control_eventos c_evento
		c_evento.id_colegiado = data
		c_evento.evento = 'MINUTA_COLEGIADOS'
		c_evento.dw = dw_minuta 
		f_control_eventos(c_evento)
		//fin Modificado Ricardo 2005-02-22		

		// Cambiar el porc. de retvol.
		// Porc. Retvol. por defecto para el colegiado
		porc_retvol = f_colegiados_ret_voluntaria(data)
		dw_minuta.setitem(1, 'porc_retvol', porc_retvol)		
		parent.post event csd_irpf_colegiado()
		parent.post event csd_calcular_descuentos_auto()
		// Se cambia el tipo de gesti$$HEX1$$f300$$ENDHEX$$n por la del colegiado
		if f_tipo_gestion_colegiado(g_id_fase, data) = 'P' then
			this.setitem(1, 'tipo_gestion', 'S')
			this.event itemchanged(1, dw_minuta.object.tipo_gestion, 'S')
		else
			this.setitem(1, 'tipo_gestion', 'C')
			this.event itemchanged(1, dw_minuta.object.tipo_gestion, 'C')
		end if
		string id_cliente
		id_cliente = this.getitemstring(1,'id_cliente')
		//Paco 25/8/2005. Una vez tenemos el colegiado y el cliente ponemos el tipo de minuta m$$HEX1$$e100$$ENDHEX$$s adecuado.
		if not f_es_vacio(data) and not f_es_vacio(id_cliente) then parent.post event csd_calcular_tipo_minuta(data, id_cliente)
		
	case 'pagador'
		choose case data
			case '2' //empresa
//				string  empresa, nom_e, nif_e, dom_e, pob_e, prov_e, 
				string id_empresa

////				select trabaja_para_empresa, nombre_empresa, nif_empresa, domicilio_empresa, poblacion_empresa
////				into :empresa, :nom_e, :nif_e, :dom_e, :pob_e 
////				from colegiados where id_colegiado = :id_colegiado;		
////				if isnull(empresa) or empresa<>'S' then 
////					MessageBox(g_titulo,'Este colegiado no trabaja para ninguna empresa')
////					return 2
////				elseif f_es_vacio(nom_e) or f_es_vacio(nif_e) or f_es_vacio(dom_e) or f_es_vacio(pob_e) then
////					MessageBox(g_titulo,'Faltan datos esenciales para facturar a la empresa de este colegiado ( nif ... )'+ cr + 'Debe rellenar estos datos antes en la ficha del colegiado')
////					return 2					
////				end if				
//				select id_empresa into :id_empresa from colegiados where id_colegiado = :id_colegiado;
//				SELECT clientes.apellidos, clientes.nif, clientes.cod_pob, clientes.nombre_via, clientes.cod_prov  
//			   INTO :nom_e, :nif_e, :pob_e, :dom_e, :prov_e  
//    			FROM clientes  
//   			WHERE clientes.id_cliente = :id_empresa   ;

				// La empresa del colegiado est$$HEX2$$e1002000$$ENDHEX$$en la pesta$$HEX1$$f100$$ENDHEX$$a de Colegiados en el contrato
				id_colegiado=dw_minuta.getitemstring(1,'id_colegiado')
				int fila_colegiado
				fila_colegiado = idw_colegiados.find("id_col = '" + id_colegiado +"'", 1, idw_colegiados.rowcount())
				if fila_colegiado <= 0 then 
					messagebox(g_titulo, 'No se encuentra el colegiado')
					return -1
				end if
				id_empresa = idw_colegiados.getitemstring(fila_colegiado, 'id_empresa')

				if f_es_vacio(id_empresa) then
					MessageBox(g_titulo,'Este colegiado no tiene definida ninguna empresa en la pesta$$HEX1$$f100$$ENDHEX$$a de Colegiados.')
					return 2					
//				elseif f_es_vacio(nom_e) or f_es_vacio(nif_e) or f_es_vacio(dom_e) or f_es_vacio(pob_e) or f_es_vacio(prov_e) then
//					MessageBox(g_titulo,'Faltan datos esenciales para facturar a la empresa de este colegiado ( nif ... )'+ cr + 'Debe rellenar estos datos antes en la ficha de la empresa')
//					return 2					
				end if
				this.setitem(1, 'paga_asalariado', 'N')
			case '3'
				this.setitem(1, 'paga_asalariado', 'N')
		end choose
		
	case 'aplica_dv'
		tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')
		if tipo_gestion = 'S' then
			if data = 'S' then
				dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_dv)
			else
				dw_minuta.setitem(1, 'base_dv', 0)
			end if
		end if
		
	case 'aplica_cip'
		tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')		
		if tipo_gestion = 'S' then
			if data = 'S' then
				dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_cip)				
			else
				dw_minuta.setitem(1, 'base_cip', 0)				
			end if
		end if		
		
	case 'aplica_musaat'
		tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')		
		if tipo_gestion = 'S' then
			if data = 'S' then
				dw_minuta.event buttonclicked(1,1, dw_minuta.object.b_calc_musaat)						
			else
				dw_minuta.setitem(1, 'base_musaat', 0)				
			end if
		end if
		
	case 'anulada'
		if data = 'S' then 
			this.setitem(1, 'pendiente', 'N')
		else
			this.setitem(1, 'pendiente', 'S')
		end if
	
	case 'porc_musaat'
		double musaat, pem, porc_col_real
		musaat = parent.event csd_calcula_musaat_fase()
		pem = idw_fases_estadistica.getitemnumber(1, 'pem')
		dw_minuta.setitem(1, 'base_musaat', f_redondea(musaat * double(data) / 100))
		dw_minuta.setitem(1, 'pem_certificacion', f_redondea(pem * double(data) / 100))
		
		if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' then
			if g_obra_admin_cip_sobre_src = 'S' then
				cip = f_cip_contrato_dw(idw_descuentos)
				porc_col_real = parent.event csd_dame_porc_col()
				//CGU-399
				if idw_colegiados.rowcount() = 1 then porc_col_real = 1
				dw_minuta.setitem(1, 'base_cip', f_redondea(cip * double(data) * porc_col_real / 100))				
			end if
		end if
		
		
	CASE 'base_desplaza'
		// Ricardo 04-02-13
		string  id_col, id_cli, mensaje
		double desplaza_totales
		// Si se pasan del m$$HEX1$$e100$$ENDHEX$$ximo de desplazamientos, avisamos
		CHOOSE CASE g_colegio
			CASE 'COAATLR', 'COAATTFE', 'COAATB'
				id_fase = dw_minuta.getitemstring(row, 'id_fase')
				id_col = dw_minuta.getitemstring(row, 'id_colegiado')
				id_cli = dw_minuta.getitemstring(row, 'id_cliente')             

				// Solo en el caso de ser con gestion se mira esto
				choose case dw_minuta.getitemstring(1, 'tipo_gestion')
					case 'C', 'A' // Desplazamientos relativa a honorarios
						desplaza_totales = f_desplazamientos_contrato_dw(idw_descuentos) - f_total_avisado_desplaza_col_cli(id_fase, id_col, id_cli)
						if double(data) > desplaza_totales then
							mensaje  = "Est$$HEX2$$e1002000$$ENDHEX$$indicando mayor cantidad de desplazamientos de la indicada en el contrato"+cr
							mensaje += "Importe indicado = "+string(double(data), "###,###,##0.00")+cr
							mensaje += "Importe no minutado = "+string(desplaza_totales, "###,###,##0.00")+cr
							mensaje += "$$HEX1$$bf00$$ENDHEX$$Desea sobrepasar los desplazamientos?"
							IF messageBox(g_titulo, mensaje, question!, yesno!, 1)=2 THEN
								post setitem(row, 'base_desplaza', f_redondea(desplaza_totales))
						 		this.trigger event itemchanged(row, dwo, string(desplaza_totales))
							END IF
						end if
				END CHOOSE
		END CHOOSE
		
	CASE 'n_contrato_ant'
		// MODIFICADO RICARDO 04-07-06
		// No se puede poner con el tipo de musaat 10
		if LeftA(this.getitemstring(row, 'tipo_minuta'),1) = '1' then
			post messagebox(g_titulo, 'No es posible indicar el contrato anterior en un alta de musaat', stopsign!)
			return 2
		end if
		// FIN MODIFICADO RICARDO 04-07-06

	case 'base_musaat'
		base_musaat = double(data)
		musaat = parent.event csd_calcula_musaat_fase()
		if musaat = 0 then porc_musaat = 0 else porc_musaat = f_redondea( base_musaat / musaat * 100)
		this.setitem(1, 'porc_musaat', porc_musaat)
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(this.getitemstring(1, 'id_colegiado')),1) = 'R' then
			dw_minuta.setitem(1, 'base_otros', f_redondea(base_musaat*g_porc_bonif_musaat*(-1)))
		end if
		
	case 'paga_dv'
		base_dv = parent.event csd_calcula_dv()
		this.setitem(1, 'base_dv', base_dv)

	case 'aplica_impresos'
		if g_colegio = 'COAATGU' then
			// Ponemos la descripci$$HEX1$$f300$$ENDHEX$$n de los libros si no pone nada
			if f_es_vacio(this.getitemstring(1, 'concepto_otros')) then this.setitem(1, 'concepto_otros','LIBROS')
			// Ponemos el importe de los libros
			tipo_gestion = dw_minuta.getitemstring(1, 'tipo_gestion')
			if tipo_gestion = 'S' then
				if data = 'S' then
					dw_minuta.setitem(1, 'base_impresos', f_libros_contrato_dw(idw_descuentos))
				else
					dw_minuta.setitem(1, 'base_impresos', 0)
				end if
			end if
		end if
		// En Le$$HEX1$$f300$$ENDHEX$$n no se calculan los libros, se coge el importe predeterminado		
		if g_colegio = 'COAATLE' then 
			if data = 'S' then
				dw_minuta.setitem(1, 'base_impresos', ist_datos_impresos.importe)
			else
				dw_minuta.setitem(1, 'base_impresos', 0)
			end if
		end if
		
	case 'concepto_honos'
		// Excepci$$HEX1$$f300$$ENDHEX$$n para Guadalajara
		if g_colegio = 'COAATGU' then
			if data = 'APROBACI$$HEX1$$d300$$ENDHEX$$N DE PLAN' or data = 'APROBACION DE PLAN' or data = 'APROBACION DEL PLAN'  or data = 'APROBACION DEL PLAN' then this.setitem(1, 'base_dv', 20)
		end if

	case 'pem_certificacion'
		// Modificado Ricardo 2005-06-14
		//volvemos a hacer que se recalcule la musaat
		double porc, pem_certificacion
		musaat = parent.event csd_calcula_musaat_fase()
		pem = idw_fases_estadistica.getitemnumber(1, 'pem')
		pem_certificacion = double(data)
		porc = pem_certificacion / pem
		dw_minuta.setitem(1, 'base_musaat', musaat * porc )
		dw_minuta.setitem(1, 'porc_musaat', f_redondea(porc * 100))
		// fin Modificado Ricardo 2005-06-14
		
	CASE 't_minuta'
		// Modificado Ricardo 2005-06-13
		string tipo_csd
		if idw_fases_datos_exp.getitemstring(1, 'administracion') = 'S' then
			if idw_1.getitemstring(1,'aplicado_10') = 'S' then
				// Modificado Ricardo 2005-06-13
				CHOOSE CASE data
					CASE 'I'
						tipo_csd = '11'
					CASE 'P'
						tipo_csd = '23' //Siguientes certificaci$$HEX1$$f300$$ENDHEX$$n
					CASE 'F'
						tipo_csd = '25'
					CASE ELSE
						// ES lo que habia
						tipo_csd = '23' //Siguientes certificaci$$HEX1$$f300$$ENDHEX$$n
				END CHOOSE
				this.setitem(row, 'tipo_minuta', tipo_csd)
			end if
		end if

		// En algunos colegios no se cobran libros en las minutas no iniciales
		CHOOSE CASE g_colegio
			CASE 'COAATGU'
				if data <> 'I' then 
					this.setitem(1, 'base_impresos', 0)
				else
					parent.event csd_calcular_libros()
				end if
				
			CASE 'COAATZ', 'COAATAVI'
				if data <> 'I' then 
					this.setitem(1, 'base_impresos', 0)
					this.setitem(1, 'concepto_otros','')
				else
					string tipo_act, t_iva
					double importe, impuesto
					SELECT importe, t_iva, impuesto INTO :importe, :t_iva, :impuesto 
					FROM csi_articulos_servicios WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.impresos;
					tipo_act = idw_1.getitemstring(1, 'fase')
			
					CHOOSE CASE tipo_act
						CASE '03', '04', '05'
							dw_minuta.setitem(1, 'concepto_otros','LIBRO DE INCIDENCIAS')
							dw_minuta.setitem(1, 'base_impresos', importe )
							dw_minuta.setitem(1, 'iva_impresos', impuesto )
							dw_minuta.setitem(1, 't_iva_impresos', t_iva )
							dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(t_iva))
					
						CASE '11', '13'
							dw_minuta.setitem(1, 'concepto_otros','LIBRO DE ORDENES')
							dw_minuta.setitem(1, 'base_impresos', importe )
							dw_minuta.setitem(1, 'iva_impresos', impuesto )
							dw_minuta.setitem(1, 't_iva_impresos', t_iva )
							dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(t_iva))
					END CHOOSE
				end if

			CASE 'COAATTER'
				if data <> 'I' then 
					this.setitem(1, 'base_impresos', 0)
					this.setitem(1, 'concepto_otros','')
				else
					SELECT importe, t_iva, impuesto INTO :importe, :t_iva, :impuesto 
					FROM csi_articulos_servicios WHERE csi_articulos_servicios.codigo = :g_codigos_conceptos.libro_incidencias;
					tipo_act = idw_1.getitemstring(1, 'fase')
			
					CHOOSE CASE tipo_act
						CASE '03', '04', '05'
							dw_minuta.setitem(1, 'concepto_otros','LIBRO DE INCIDENCIAS')
							dw_minuta.setitem(1, 'base_impresos', importe )
							dw_minuta.setitem(1, 'iva_impresos', impuesto )
							dw_minuta.setitem(1, 't_iva_impresos', t_iva )
							dw_minuta.setitem(1, 'porc_iva_impresos', f_dame_porcent_iva(t_iva))
						END CHOOSE
				end if				
		END CHOOSE
	
	CASE 'urgente'
		event csd_minuta_urgente(data)
		
	case 't_iva_cip_suplida'
		porc_iva_cip = f_dame_porcent_iva (  data )		
		this.setitem(1,'porc_iva_cip_suplida', porc_iva_cip)		
		base_cip = this.getitemnumber(1, 'base_cip_suplida')
		iva_cip = f_redondea(base_cip * porc_iva_cip /100)				
		this.setitem(1,'iva_cip_suplida', iva_cip)
		
	case 'irpf_cliente'
		// Preguntamos si est$$HEX1$$e100$$ENDHEX$$n seguros de lo que van a hacer
		if data = 'S' then
			if messagebox(g_titulo, 'Va a aplicar IRPF al cliente. $$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro?', Question!,YesNo!) <> 1 then return 2
		end if
		
	case 'tipo_minuta'
		// Calculamos el 10% de Musaat al coger el tipo de minuta 11
		// Esto lo hacemos gen$$HEX1$$e900$$ENDHEX$$rico, $$HEX1$$fa00$$ENDHEX$$til cuando no sale la ventanita del 10% en O.O.
		if data = '11' or data = '12' then
			musaat = parent.event csd_calcula_musaat_fase()
			if data = '11' then musaat = f_redondea(musaat * 0.1)
			this.setitem(1, 'base_musaat', musaat)
			if data = '11' then
				this.setitem(1, 'porc_musaat', 10)
				this.event itemchanged(1, dw_minuta.object.porc_musaat, string(10))
			else
				this.setitem(1, 'porc_musaat', 100)
				this.event itemchanged(1, dw_minuta.object.porc_musaat, string(100))
			end if
			// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
			if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(this.getitemstring(1, 'id_colegiado')),1) = 'R' then
				dw_minuta.setitem(1, 'base_otros', f_redondea(musaat*g_porc_bonif_musaat*(-1)))
			end iF
		else
			musaat = parent.event csd_calcula_musaat_fase()
			if data = '14' then musaat = 0
			if data = '25' then
				id_fase = dw_minuta.getitemstring(row, 'id_fase')
				id_col = dw_minuta.getitemstring(row, 'id_colegiado')
				porc_musaat = f_minutas_porc_musaat_ultima_certif(id_fase, id_col)
				this.setitem(1, 'base_musaat', f_redondea(musaat*porc_musaat/100))
				this.setitem(1, 'porc_musaat', porc_musaat)
				this.event itemchanged(1, dw_minuta.object.porc_musaat, string(porc_musaat))
			else
				this.setitem(1, 'base_musaat', musaat)
				this.setitem(1, 'porc_musaat', 100)
				this.event itemchanged(1, dw_minuta.object.porc_musaat, string(100))
			end if
		end if
	case 'porc_cip'
//		// C$$HEX1$$e100$$ENDHEX$$lculo del cip en funci$$HEX1$$f300$$ENDHEX$$n del porcentaje
		//cip = this.getitemdecimal(1,'base_cip')//parent.event csd_calcula_cip()
		por_cip =  double(data)
		this.setitem(1, 'base_cip', f_redondea(id_base_cip*por_cip/100))

end choose
this.accepttext( )
if(g_colegio = 'COAATLR' and this.getitemstring(1,'tipo_gestion') = 'C')then
	dw_impresion.object.observaciones.Visible=0
//else 
//	dw_impresion.object.observaciones.Visible=1
end if
parent.post event csd_recalcular_todo(dwo.name, data)

end event

event pfc_addrow;call super::pfc_addrow;this.SetItem(1,'id_minuta',f_siguiente_numero('FASES-MINUTAS',10))

if f_tengo_permiso(g_usuario,'NAVISO_MOD' ,'%') <> 1 or g_colegio<>'COAATCC' then
	this.SetItem(1,'n_aviso',f_numera_aviso(false)) // Modificado Ricardo 2005-05-12
//else
//	dw_minuta.Object.n_aviso.Edit.DisplayOnly = 'No'
//	dw_minuta.Object.n_aviso.Background.Color = RGB(255,255,255)	
end if

return ancestorreturnvalue
end event

event constructor;call super::constructor;this.GetChild('id_colegiado',i_dwc_colegiados)
i_dwc_colegiados.settransobject(sqlca)
i_dwc_colegiados.InsertRow (0)
	
this.GetChild('id_cliente',i_dwc_clientes)
i_dwc_clientes.settransobject(sqlca)
i_dwc_clientes.InsertRow (0)
end event

event retrieveend;call super::retrieveend;parent.trigger event csd_ver_cunyo()
this.post event csd_cargar_dddw()
parent.post event csd_inhabilita()

if this.getitemstring(1, 'tipo_gestion') = 'S' then
	parent.cbx_f_honos.enabled = false
else
	parent.cbx_f_honos.enabled = true
end if

//Si es La Rioja y gesti$$HEX1$$f300$$ENDHEX$$n de cobro
this.accepttext( )
if(g_colegio = 'COAATLR' and this.getitemstring(1,'tipo_gestion') = 'C')then
	dw_impresion.object.observaciones.Visible=0
//else 
//	dw_impresion.object.observaciones.Visible=1
end if

// Miramos si el check de urgente tiene valor inicial
if f_es_vacio(this.GetItemString(1, 'urgente')) then
	this.SetItem(1, 'urgente', 'N')
	this.update()
end if

end event

event buttonclicked;string tipo_gestion, tipo_minuta
boolean bl_regularizacion

tipo_gestion = this.getitemstring(1, 'tipo_gestion')
tipo_minuta 	= this.getitemstring(1, 'tipo_minuta')
if f_es_vacio(tipo_minuta) then tipo_minuta = '00'
bl_regularizacion = MidA(tipo_minuta,1,1)='2' or MidA(tipo_minuta,1,1)='6'

CHOOSE CASE dwo.name
	CASE 'b_calc_cip'
		double cip
		cip = parent.event csd_calcula_cip()
		if dw_minuta.getitemnumber(1, 'base_cip') <> cip /*and (not bl_regularizacion)*/ then 
			dw_minuta.setitem(1, 'base_cip', cip)
		end if

	CASE 'b_calc_dv'
		double dv
		dv = parent.event csd_calcula_dv()
		if dw_minuta.getitemnumber(1, 'base_dv') <> dv /*and (not bl_regularizacion)*/ then 
			dw_minuta.setitem(1, 'base_dv', dv)
		end if

	CASE 'b_calc_musaat'
		// Calcular solo si el tipo de movimiento es un alta
		string tipo
		tipo = this.getitemstring(1, 'tipo_minuta')
		if isnull(tipo) then tipo = ''
		if LeftA(tipo,1) <> '2' and LeftA(tipo,1) <> '6' then 
			double musaat
			musaat = parent.event csd_calcula_musaat(false)
			if dw_minuta.getitemnumber(1, 'base_musaat') <> musaat then 
				dw_minuta.setitem(1, 'base_musaat', musaat)
			end if
		end if
		// Para que ponga el porcentaje
		double total_musaat, porc_musaat
		total_musaat = parent.event csd_calcula_musaat_fase()
		if musaat = 0 then porc_musaat = 0 else porc_musaat = f_redondea( musaat / total_musaat * 100)
		this.setitem(1, 'porc_musaat', porc_musaat)
		if g_colegio = 'COAATZ' then
			double pem
			pem = idw_fases_estadistica.getitemnumber(1, 'pem')
			this.setitem(1, 'pem_certificacion', f_redondea( porc_musaat * pem / 100))
		end if


	CASE 'b_calc_retvol'	
		if tipo_gestion = 'S' or tipo_gestion = 'A' then
			this.setitem(1, 'base_retvol', 0)
			this.setitem(1, 'porc_retvol', 0)
			this.setitem(1, 'aplica_retvol', 'N')				
		elseif tipo_gestion = 'C' then
			double retvol, porc_retvol, base_honos
			porc_retvol = f_colegiados_ret_voluntaria(this.getitemstring(1, 'id_colegiado'))
			dw_minuta.setitem(1, 'porc_retvol', porc_retvol)			
//			porc_retvol = this.getitemnumber(1, 'porc_retvol')
			base_honos = this.getitemnumber(1, 'base_honos')
			retvol = f_redondea(base_honos * porc_retvol/100)			
			if dw_minuta.getitemnumber(1, 'base_retvol') <> retvol then 
				dw_minuta.setitem(1, 'base_retvol', retvol)
			end if		
		end if

	CASE 'b_calc_dev_garan'
		double garantia
		garantia = parent.event csd_calcular_garantia()
		if dw_minuta.getitemnumber(1, 'base_garantia') <> garantia then 
			dw_minuta.setitem(1, 'base_garantia', garantia)
		end if		

	CASE 'b_autoliquidacion'
		parent.event csd_carta_autoliquidacion()
		
	CASE 'b_regulariza'
		openwithparm(w_minutas_final, this.getitemstring(1, 'id_colegiado'))
		
		// Calculamos la bonificaci$$HEX1$$f300$$ENDHEX$$n de musaat (s$$HEX1$$f300$$ENDHEX$$lo colegiados residentes)
		if g_colegio = 'COAATLE' and LeftA(f_colegiado_residente(this.getitemstring(1, 'id_colegiado')),1) = 'R' then
			this.setitem(1, 'base_otros', f_redondea(this.getitemnumber(1, 'base_musaat')*g_porc_bonif_musaat*(-1)))
		end if		
END CHOOSE
//parent.post event csd_recalcular_todo('','')

end event

event type long pfc_insertrow();call super::pfc_insertrow;this.SetItem(1,'id_minuta',f_siguiente_numero('FASES-MINUTAS',10))
this.SetItem(1,'n_aviso',f_numera_aviso(false)) // Modificado Ricardo 2005-05-12

return ancestorreturnvalue
end event

event key;call super::key;if keydown(keycontrol!) and keydown(keyX!) then
	if dw_minuta.enabled = false then
		dw_minuta.enabled = true
		dw_minuta.object.pendiente.visible = true
	else
		dw_minuta.enabled = false 
		dw_minuta.object.pendiente.visible = false		
	end if
end if
end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'porc_honos', 'porc_retvol', 'porc_musaat'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
	case 'base_honos', 'base_desplaza', 'base_dv', 'base_cip', 'base_musaat', 'base_retvol', 'base_garantia', 'pem_certificacion'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

type dw_musaat from u_dw within w_minutas_detalle
boolean visible = false
integer width = 2894
integer height = 1676
integer taborder = 90
string dataobject = "d_factu_gastos_za"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;
string impresora, bandeja, n_reg,id_col,email
n_csd_impresion_formato uo_impresion
string id_fase,id_minuta,id_colegiado,n_fact,visared,tipo_factura,id_factura

uo_impresion = create n_csd_impresion_formato

uo_impresion.dw=this

id_fase=dw_minuta.GetItemString(dw_minuta.GetRow(),'id_fase')
select n_registro into :n_reg from fases where id_fase=:id_fase;
uo_impresion.copias=1
uo_impresion.avisos=1
uo_impresion.generar_registro='N'
//uo_impresion.tipo_receptor='O'
uo_impresion.asunto_email='Aviso'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
uo_impresion.asunto_registro='Aviso'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
//uo_impresion.receptor='AYUNTAMIENTO DE '+pobla
uo_impresion.serie='AVISOS'
uo_impresion.visualizar_web = 'N'
uo_impresion.pdf = g_formato_impresion.pdf
uo_impresion.papel = g_formato_impresion.papel
uo_impresion.email = g_formato_impresion.email	
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(today()))
uo_impresion.ruta_relativa3=n_reg
uo_impresion.nombre='Aviso_3_'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')

id_col=dw_minuta.GetItemString(1,'id_colegiado')
email=f_devuelve_mail(id_col)
uo_impresion.direccion_email=email

	if uo_impresion.f_opciones_impresion()<>1 then return		
	uo_impresion.f_impresion()	

end event

type dw_impresion from u_dw within w_minutas_detalle
boolean visible = false
integer y = 4
integer width = 2894
integer height = 1660
integer taborder = 190
string dataobject = "d_ficha_aviso_factura"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event doubleclicked;call super::doubleclicked;//this.event pfc_print()
//this.print()
//if g_colegio <> 'COAATCU' then this.print()

//int i
//string n_copias
//
//if g_colegio = 'COAATGUI' then // David 03/05/2006 - Utilizamos la ventana de impresi$$HEX1$$f300$$ENDHEX$$n de facturas
//	string valretorno
//	n_csd_impresion_formato impr
//	impr = create n_csd_impresion_formato
//	
//	impr.papel = 'S'
//	impr.dw = this
//	
//	st_w_factu_e_imprimir l_st_w_factu
//	l_st_w_factu.varias_facturas=false
//	l_st_w_factu.impresion_formato=impr
//	l_st_w_factu.impresion_formato.nombre=idw_1.getitemstring(1, 'n_registro')
//	
//	openwithparm(w_factu_e_imprimir,l_st_w_factu)
//	
//	valretorno=message.stringparm
//	if valretorno <> 'CANCELAR' then 
//		//Imprimimos tantas copias como 'originales' y 'copias' nos indiquen
//		impr.copias=impr.copias+long(valretorno)
//		impr.f_impresion()
//	end if
//	destroy impr
//else // Funcionamiento normal
//	openwithparm(w_n_copias, 'AVISO')
//	
//	n_copias = message.stringparm
//	
//	for i=1 to long(n_copias)
//		this.print()	
//	next
//end if

string impresora, bandeja, n_reg, id_col,email
n_csd_impresion_formato uo_impresion
string id_fase,id_minuta,id_colegiado,n_fact,visared,tipo_factura,id_factura

uo_impresion = create n_csd_impresion_formato

uo_impresion.dw=this

id_fase=dw_minuta.GetItemString(dw_minuta.GetRow(),'id_fase')

///* Introducido por Alexis para incluir la impresi$$HEX1$$f300$$ENDHEX$$n de una plantilla concreta para el env$$HEX1$$ed00$$ENDHEX$$o de correos
// para Vizcaya. CBI-130. 18/11/2009 */
//if dw_minuta.getitemstring(dw_minuta.getrow(), 'tipo_gestion') = 'S' and g_colegio = 'COAATB' then
 if 	g_colegio = 'COAATB' then
	uo_impresion.plantilla = 'aviso_visado.txt'
	uo_impresion.referencia = id_fase
	uo_impresion.referencia2 = dw_minuta.GetItemString(dw_minuta.GetRow(),'id_minuta')
end if

select n_registro into :n_reg from fases where id_fase=:id_fase;
uo_impresion.copias=1
uo_impresion.avisos=1
uo_impresion.generar_registro='N'
//uo_impresion.tipo_receptor='O'
uo_impresion.asunto_email='Aviso Factura'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
uo_impresion.asunto_registro='Aviso Factura'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
//uo_impresion.receptor='AYUNTAMIENTO DE '+pobla
uo_impresion.serie='AVISOS'
uo_impresion.visualizar_web = 'N'
uo_impresion.pdf = g_formato_impresion.pdf
uo_impresion.papel = g_formato_impresion.papel
uo_impresion.email = g_formato_impresion.email	
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(today()))
uo_impresion.ruta_relativa3=n_reg
uo_impresion.nombre='Aviso_factura_'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
id_col=dw_minuta.GetItemString(1,'id_colegiado')
email=f_devuelve_mail(id_col)
uo_impresion.direccion_email=email

if uo_impresion.f_opciones_impresion()<>1 then return		
uo_impresion.f_impresion()	

end event

type gb_1 from groupbox within w_minutas_detalle
integer x = 869
integer y = 1692
integer width = 1477
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Previsualizar"
end type

type dw_factura_gastos from u_dw within w_minutas_detalle
boolean visible = false
integer width = 2889
integer height = 1676
integer taborder = 70
string dataobject = "d_factu_gastos_viz_nueva"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;//this.event pfc_print()
string impresora, bandeja, n_reg,id_col,email
n_csd_impresion_formato uo_impresion
string id_fase,id_minuta,id_colegiado,n_fact,visared,tipo_factura,id_factura

uo_impresion = create n_csd_impresion_formato




if this.Describe("DataWindow.Print.Margin.Bottom")='14000' then

	dw_composite.object.dw_1.dataobject = dw_factura_gastos.dataobject
	dw_composite.object.dw_2.dataobject = dw_factura_gastos.dataobject
	
	datawindowchild dwc, dwc2
	
	dw_composite.GetChild("dw_1", dwc)
	dw_composite.GetChild("dw_2", dwc2)
	
	dw_factura_gastos.RowsCopy(1,  dw_factura_gastos.RowCount(), Primary!, dwc, 1, Primary!)
	dw_factura_gastos.RowsCopy(1,  dw_factura_gastos.RowCount(), Primary!, dwc2, 1, Primary!) 
	
	//dw_factura_gastos = dw_composite
	
	// CGN-292
	dw_composite.object.dw_1.object.t_1.text = 'AV$$HEX1$$cd00$$ENDHEX$$S'
	dw_composite.object.dw_2.object.t_1.text = 'AV$$HEX1$$cd00$$ENDHEX$$S'
	dw_composite.object.dw_1.object.t_5.text = 'N$$HEX1$$fa00$$ENDHEX$$m. Av$$HEX1$$ed00$$ENDHEX$$s'
	dw_composite.object.dw_2.object.t_5.text = 'N$$HEX1$$fa00$$ENDHEX$$m. Av$$HEX1$$ed00$$ENDHEX$$s'				
	
	//dw_composite.print()
	uo_impresion.dw=dw_composite
else
	uo_impresion.dw=this
				
end if

id_fase=dw_minuta.GetItemString(dw_minuta.GetRow(),'id_fase')
select n_registro into :n_reg from fases where id_fase=:id_fase;
uo_impresion.copias=1
uo_impresion.avisos=1
uo_impresion.generar_registro='N'
//uo_impresion.tipo_receptor='O'
uo_impresion.asunto_email='Aviso '+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
uo_impresion.asunto_registro='Aviso '+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
//uo_impresion.receptor='AYUNTAMIENTO DE '+pobla
uo_impresion.serie='AVISOS'
uo_impresion.visualizar_web = 'N'
uo_impresion.pdf = g_formato_impresion.pdf
uo_impresion.papel = g_formato_impresion.papel
uo_impresion.email = g_formato_impresion.email	
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(today()))
uo_impresion.ruta_relativa3=n_reg
uo_impresion.nombre='Aviso_'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
id_col=dw_minuta.GetItemString(1,'id_colegiado')
email=f_devuelve_mail(id_col)
uo_impresion.direccion_email=email
	if uo_impresion.f_opciones_impresion()<>1 then return		
	uo_impresion.f_impresion()	

end event

type dw_factura_honos from u_dw within w_minutas_detalle
boolean visible = false
integer width = 2894
integer height = 1672
integer taborder = 80
string dataobject = "d_factu_honos_viz_nueva"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;
string impresora, bandeja, n_reg, id_col,email
n_csd_impresion_formato uo_impresion
string id_fase,id_minuta,id_colegiado,n_fact,visared,tipo_factura,id_factura

uo_impresion = create n_csd_impresion_formato

uo_impresion.dw=this

id_fase=dw_minuta.GetItemString(dw_minuta.GetRow(),'id_fase')
select n_registro into :n_reg from fases where id_fase=:id_fase;
uo_impresion.copias=1
uo_impresion.avisos=1
uo_impresion.generar_registro='N'
//uo_impresion.tipo_receptor='O'
uo_impresion.asunto_email='Aviso Hon.'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
uo_impresion.asunto_registro='Aviso Hon.'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')
//uo_impresion.receptor='AYUNTAMIENTO DE '+pobla
uo_impresion.serie='AVISOS'
uo_impresion.visualizar_web = 'N'
uo_impresion.pdf = g_formato_impresion.pdf
uo_impresion.papel = g_formato_impresion.papel
uo_impresion.email = g_formato_impresion.email	
uo_impresion.ruta_automatica=true
uo_impresion.ruta_relativa1=''
uo_impresion.ruta_relativa2=string(year(today()))
uo_impresion.ruta_relativa3=n_reg
uo_impresion.nombre='Aviso_2_'+dw_minuta.GetItemString(dw_minuta.GetRow(),'n_aviso')

id_col=dw_minuta.GetItemString(1,'id_colegiado')
email=f_devuelve_mail(id_col)
uo_impresion.direccion_email=email

	if uo_impresion.f_opciones_impresion()<>1 then return		
	uo_impresion.f_impresion()	

end event

