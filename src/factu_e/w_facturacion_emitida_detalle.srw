HA$PBExportHeader$w_facturacion_emitida_detalle.srw
forward
global type w_facturacion_emitida_detalle from w_detalle
end type
type tab_1 from tab within w_facturacion_emitida_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_femitidas_conceptos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_femitidas_conceptos dw_femitidas_conceptos
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_femitidas_cobros from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_femitidas_cobros dw_femitidas_cobros
end type
type tabpage_6 from userobject within tab_1
end type
type dw_cobros_multiples from u_csd_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_cobros_multiples dw_cobros_multiples
end type
type tabpage_4 from userobject within tab_1
end type
type dw_femitidas_apuntes from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_femitidas_apuntes dw_femitidas_apuntes
end type
type tabpage_5 from userobject within tab_1
end type
type dw_datos_contrato from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_datos_contrato dw_datos_contrato
end type
type tabpage_9 from userobject within tab_1
end type
type dw_modificacion_datos from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_modificacion_datos dw_modificacion_datos
end type
type tabpage_7 from userobject within tab_1
end type
type dw_historico_proformas from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_historico_proformas dw_historico_proformas
end type
type tab_1 from tab within w_facturacion_emitida_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_6 tabpage_6
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_9 tabpage_9
tabpage_7 tabpage_7
end type
type cb_imprimir from commandbutton within w_facturacion_emitida_detalle
end type
type dw_2 from u_dw within w_facturacion_emitida_detalle
end type
type cb_exped from commandbutton within w_facturacion_emitida_detalle
end type
type cb_imprimir_recibo from commandbutton within w_facturacion_emitida_detalle
end type
type pb_1 from picturebutton within w_facturacion_emitida_detalle
end type
type cb_recibos_musaat from commandbutton within w_facturacion_emitida_detalle
end type
type cb_borrar_vinculacion from commandbutton within w_facturacion_emitida_detalle
end type
type cb_generar_numero_recibo_musaat from commandbutton within w_facturacion_emitida_detalle
end type
type cb_recibo_irpf from commandbutton within w_facturacion_emitida_detalle
end type
type dw_3 from u_dw within w_facturacion_emitida_detalle
end type
end forward

global type w_facturacion_emitida_detalle from w_detalle
integer width = 3689
integer height = 2312
string title = "Detalle de Facturaci$$HEX1$$f300$$ENDHEX$$n Emitida"
string menuname = "m_factu_e_detalle"
event rellena_struct_f ( integer fila_factura,  integer fila_clasifica )
event rellena_struct_pago ( integer fila_factura,  integer fila_clasifica )
event csd_imprimir ( )
event csd_reclamacion ( )
event csd_factura_negativa ( )
event csd_habilitar_edicion ( )
tab_1 tab_1
cb_imprimir cb_imprimir
dw_2 dw_2
cb_exped cb_exped
cb_imprimir_recibo cb_imprimir_recibo
pb_1 pb_1
cb_recibos_musaat cb_recibos_musaat
cb_borrar_vinculacion cb_borrar_vinculacion
cb_generar_numero_recibo_musaat cb_generar_numero_recibo_musaat
cb_recibo_irpf cb_recibo_irpf
dw_3 dw_3
end type
global w_facturacion_emitida_detalle w_facturacion_emitida_detalle

type variables
string i_centro,i_proyecto, i_forma_pago, i_banco
long   i_asiento
int    i_num_venc
boolean ib_cambio= false
u_dw idw_femitidas_conceptos
//u_dw idw_femitidas_clasificacion
u_dw idw_femitidas_cobros, idw_femitidas_cobros_mult
u_dw idw_femitidas_apuntes
u_dw idw_datos_contrato
u_dw idw_historico_proformas
u_dw idw_modificacion_datos

n_csd_impresion_formato i_impresion_formato

// Se crea una vble. para controlar que no se pierda el n$$HEX2$$ba002000$$ENDHEX$$con que estaba grabada una Fact. si la
// seleccionamos dsd la Lista:
// Si hay una fact. sin grabar en el detalle, pedir$$HEX2$$e1002000$$ENDHEX$$el n$$HEX2$$ba002000$$ENDHEX$$mediante una ventana volviendo a lanzar
// el Activate y cambiando el n$$HEX2$$ba002000$$ENDHEX$$a la factura que abrimos dsd la Lista
boolean i_ejecutar_activate = TRUE
// Var para guardar la serie pasada en el objeto message
string i_serie
st_facturacion_emitida_nueva	i_st_datos_factura_nueva

// En esta variable guardaremos el total de la factura al entrar
double i_total

// Variable para controlar que han pulsado la combinaci$$HEX1$$f300$$ENDHEX$$n de teclas que permite modificar el importe de IVA
boolean i_modificar_iva = FALSE

st_facturacion_emitida_vencimiento ist_vencimiento

datawindowchild idwc_forma_pago, idwc_forma_pago_cobros, idwc_empresa_pagador
end variables

forward prototypes
public subroutine wf_key_pressed (keycode key, unsignedlong keyflags)
public subroutine wf_calcula_montos_vencimiento (ref double total, double n_vencimiento, ref decimal ultimo_valor)
public subroutine wf_actualiza_cobros (string id_pago, string as_id_factura, string nva_formapago, double total_factura, string as_id_cobro_multiple, double total_actual_cobro_multiple)
end prototypes

event rellena_struct_f;//double subtotal, subtotal_iva 
//String concepto, cuenta, cuenta_iva 
//
//		concepto = 'S/Factura n$$HEX2$$ba002000$$ENDHEX$$'+ dw_1.getitemstring(fila_factura,'n_fact_prov') +' '+ dw_1.getitemstring(fila_factura,'nombre')
//		// INTRODUCIMOS LAS L$$HEX1$$cd00$$ENDHEX$$NEAS DE APUNTES EN SU DW
//		// campos comunes a los apuntes
//// El campo n_apunte lo inicializaremos para cada asiento => lo haremos desde el bot$$HEX1$$f300$$ENDHEX$$n 
////		que genere el asiento ... ... ...		g_apunte.n_apunte='00000'
//		g_apunte.concepto = concepto
//		g_apunte.n_doc = dw_1.getitemstring(fila_factura,'n_fact')
//		g_apunte.fecha = g_fecha_ult_conta
//		g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
//		g_apunte.id_interno = dw_1.getitemstring(fila_factura,'id_factura')
//		g_apunte.diario = g_diario_f_recibidas
//	
//		// Datos de Clasificaci$$HEX1$$f300$$ENDHEX$$n
//		g_apunte.centro = idw_femitidas_clasificacion.getitemstring(fila_clasifica,'centro')
//		g_apunte.proyecto = idw_femitidas_clasificacion.getitemstring(fila_clasifica,'proyecto')
//		g_apunte.cta_presupuestaria = idw_femitidas_clasificacion.getitemstring(fila_clasifica,'cta_presupuestaria')		
//
//		g_apunte.t_doc = idw_femitidas_clasificacion.GetItemString(fila_clasifica, 'tipo_clasifica')
//		// Obtenemos la cta. del IVA de g_st_apunte_r.Recibidas -> Soportado, a partir del tipo de IVA
//		cuenta = idw_femitidas_clasificacion.getitemstring(fila_clasifica,'cuenta')
//		subtotal = idw_femitidas_clasificacion.GetItemNumber(fila_clasifica,'subtotal')
//		cuenta_iva = f_dame_cta_iva ('R', idw_femitidas_clasificacion.getitemstring(fila_clasifica,'t_iva'))
//		subtotal_iva = idw_femitidas_clasificacion.GetItemNumber(fila_clasifica,'subtotal_iva')
//			
//		CHOOSE CASE g_apunte.t_doc 
//		// IVA, y Debe
//			CASE g_t_doc_prov_iva 
//				g_apunte.cuenta = cuenta_iva
//				g_apunte.debe = subtotal_iva
//				g_apunte.haber = 0
//		// Debe		
//			CASE g_t_doc_prov_gastos 
//				g_apunte.cuenta = cuenta
//				g_apunte.debe = subtotal
//				g_apunte.haber = 0
//		// Haber
//			CASE ELSE 
//				g_apunte.cuenta = cuenta
//				g_apunte.debe = 0
//				g_apunte.haber = subtotal
//				
//		END CHOOSE 
end event

event rellena_struct_pago;//double importe 
//String concepto, n_emision, cuenta, cuenta_prov
//
//	n_emision = idw_pagos.GetITemString(fila_pago,'n_talon')
//	If IsNull(n_emision) then n_emision = ''
//
//	concepto = 'Pago Fact n$$HEX2$$ba002000$$ENDHEX$$'+ dw_1.getitemstring(fila_factura,'n_fact_prov') +' '+ n_emision +' '+ dw_1.getitemstring(fila_factura,'nombre')
//		// INTRODUCIMOS LAS L$$HEX1$$cd00$$ENDHEX$$NEAS DE APUNTES EN SU DW
//		// campos comunes a los apuntes
//// El campo n_apunte lo inicializaremos para cada asiento => lo haremos desde el bot$$HEX1$$f300$$ENDHEX$$n 
////		que genere el asiento ... ... ...		g_apunte.n_apunte='00000'
//		g_apunte.concepto = concepto
//		g_apunte.n_doc = dw_1.getitemstring(fila_factura,'n_fact')
//		g_apunte.fecha = g_fecha_ult_conta
//		g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
//		g_apunte.id_interno = dw_1.getitemstring(fila_factura,'id_factura')
//		g_apunte.diario = g_diario_f_recibidas
//		
//		g_apunte.t_doc = g_t_doc_prov_pago
//		
//		// Datos de Pagos
//		g_apunte.centro = idw_pagos.getitemstring(fila_pago,'centro')
//		g_apunte.proyecto = idw_pagos.getitemstring(fila_pago,'proyecto')
//		g_apunte.cta_presupuestaria = idw_pagos.getitemstring(fila_pago,'cta_presupuestaria')		
//
//		// Obtenemos la cta. del IVA de g_st_apunte_r.Recibidas -> Soportado, a partir del tipo de IVA
//		cuenta = idw_pagos.getitemstring(fila_pago,'cuenta')
//		importe = idw_pagos.GetItemNumber(fila_pago,'importe')
//
////		cuenta_prov = f_dame_cta_iva ('R', idw_pagos.getitemstring(fila_pago,'t_iva'))
//			
//		CHOOSE CASE t_doc 
//		// 
//			CASE 'PROV' 
//				g_apunte.cuenta = f_dame_cta_proveedor (dw_1.getitemstring(fila_factura,'id_prov'))
//				g_apunte.debe = importe
//				g_apunte.haber = 0
//		// 
//			CASE 'PAGO'
//				g_apunte.cuenta = cuenta
//				g_apunte.debe = 0
//				g_apunte.haber = importe
//		END CHOOSE
//
end event

event csd_imprimir;cb_imprimir.triggerevent(clicked!)
end event

event csd_reclamacion();// Almacenamos la consulta que se debe de aplicar
g_reclamaciones_facturas.consulta = "		Select id_factura 		"+&
												"		  FROM csi_facturas_emitidas, tipos_facturas, csi_formas_de_pago  "+&
												"   WHERE ( csi_facturas_emitidas.tipo_factura *= tipos_facturas.codigo) and "+&
												"			 ( csi_facturas_emitidas.formadepago *= csi_formas_de_pago.tipo_pago) "+&   
												"			 and id_factura = '"+dw_1.getitemstring(1, "id_factura")+"'"
//OpenSheet(g_detalle_reclamaciones,'w_reclamaciones_facturas_generacion',w_aplic_frame,0,original!)

//OpenSheet(g_detalle_reclamaciones,'w_reclamaciones_facturas_proformas',w_aplic_frame,0,original!)
end event

event csd_factura_negativa();string ls_id_nueva_factura,ls_n_nueva_factura, ls_id_factura_original
st_imprimir_factura st_imp_fact
st_generar_facturas_minutas parametros_factura_minuta

ls_id_factura_original = dw_1.GetItemString(dw_1.getrow(),'id_factura')

///*** SCP-662. Alexis. Se evita que se generen facturas negativas de una proforma. 04/11/2010 ***///
if f_es_factura_proforma(ls_id_factura_original) = 'S' then
	messagebox(g_titulo, 'No se pueden generar facturas negativas a partir de una factura proforma')
	return
end if	
 
// Rellenamos la estructura que pasamos a la funci$$HEX1$$f300$$ENDHEX$$n que genera la factura negativa
parametros_factura_minuta.id_factura 	= ls_id_factura_original
parametros_factura_minuta.serie	 		= g_facturas_negativas_serie

openwithparm(w_factu_e_negativa, parametros_factura_minuta)

parametros_factura_minuta = message. powerobjectparm

//ls_id_nueva_factura=f_genera_factura_negativa(parametros_factura_minuta)
ls_id_nueva_factura = parametros_factura_minuta.id_factura

if ls_id_nueva_factura <> ls_id_factura_original then
	select n_fact into :ls_n_nueva_factura from csi_facturas_emitidas where id_factura=:ls_id_nueva_factura;
	

	////Mostrar nuevo n$$HEX1$$fa00$$ENDHEX$$mero de factura
	Messagebox(g_titulo,'N$$HEX2$$ba002000$$ENDHEX$$de la factura generada: '+ls_n_nueva_factura)
	//
	//Imprimir la factura
	//recuperamos los datos de la factura que queremos imprimir
	dw_1.retrieve(ls_id_nueva_factura)
	

	cb_imprimir.triggerevent(clicked!)

	//recolocamos el n$$HEX1$$fa00$$ENDHEX$$mero de factura original
	dw_1.retrieve(ls_id_factura_original)
end if
end event

event csd_habilitar_edicion();if f_puedo_editar_n_factura(g_usuario,'FACT_E_MOD')  = 1 then
dw_1.Object.n_fact.Edit.DisplayOnly = 'No'
dw_1.Object.n_fact.Background.Color = RGB(255,255,255)

end if

if dw_1.getrow() > 0 then
	if f_es_factura_proforma( dw_1.GetItemString(dw_1.getrow(),'id_factura'))='N' then
		    dw_1.Object.anulada.tabsequence = 0
	else
		dw_1.Object.anulada.tabsequence = 270
	end if
end if
end event

public subroutine wf_key_pressed (keycode key, unsignedlong keyflags);if keydown(keycontrol!) and keydown(keyL!) then
	CHOOSE CASE g_colegio
		CASE 'COAATTFE'
			long n_reg
			// Solo se permite a los que tengan el permiso especial
			SELECT count(*) into :n_reg from t_permisos where cod_aplicacion = 'E' and cod_usuario = :g_usuario;
			if n_reg<1 then return
	END CHOOSE	


	if dw_1.object.contabilizada.tabsequence = '0' then
		// Permitir que puedan modificar el check de contabilizada y la fecha de contabilizacion
		dw_1.object.contabilizada.tabsequence = '500'
		dw_1.object.f_conta.tabsequence = '501'
		idw_femitidas_cobros.object.contabilizado.tabsequence = '500'
		idw_femitidas_cobros.object.f_contabilizado.tabsequence ='501'
	else
		// Permitir que puedan modificar el check de contabilizada y la fecha de contabilizacion
		dw_1.object.contabilizada.tabsequence = '0'
		dw_1.object.f_conta.tabsequence = '0'
		idw_femitidas_cobros.object.contabilizado.tabsequence = '0'
		idw_femitidas_cobros.object.f_contabilizado.tabsequence = '0'
	end if
end if

end subroutine

public subroutine wf_calcula_montos_vencimiento (ref double total, double n_vencimiento, ref decimal ultimo_valor);integer i
decimal {2}  total_venc, subtotal


if n_vencimiento > 1 then
   for i =1 to n_vencimiento
		 total_venc += (total /n_vencimiento)
	next
	subtotal = round(total, 2)
	total    = round((total /n_vencimiento),2)
	if  total_venc <> subtotal then
		 total_venc   = subtotal - total_venc  
		 ultimo_valor = total + total_venc
	end if
end if


end subroutine

public subroutine wf_actualiza_cobros (string id_pago, string as_id_factura, string nva_formapago, double total_factura, string as_id_cobro_multiple, double total_actual_cobro_multiple);datetime   ldt_fecha
string       ls_id_cobro_multiple
double      ldb_total
  
setnull(ldt_fecha)

if isnull(total_factura) then total_factura = 0
if isnull(total_actual_cobro_multiple) then total_actual_cobro_multiple = 0


  UPDATE csi_cobros  
     SET forma_pago = :nva_formapago,   
         importe = :total_factura,   
		f_pago = :ldt_fecha,
         id_cobro_multiple = '0'  
   WHERE ( csi_cobros.id_pago = :id_pago ) AND  
         ( csi_cobros.id_factura = :as_id_factura ) ;


ldb_total = total_actual_cobro_multiple - total_factura
if isnull(ldb_total) then ldb_total = 0

  UPDATE csi_cobros_multiples  
     SET importe = :ldb_total  
   WHERE csi_cobros_multiples.id_cobro_multiple = :as_id_cobro_multiple     ;
	
commit;	

if nva_formapago ='DB' or nva_formapago ='PE' then
	  UPDATE csi_cobros  
		  SET pagado ='N'  
		WHERE ( csi_cobros.id_pago = :id_pago ) AND  
				( csi_cobros.id_factura = :as_id_factura ) ;	
				
	  UPDATE csi_facturas_emitidas  
		  SET 	pagado = 'N'   
		WHERE ( csi_facturas_emitidas.id_factura = :as_id_factura ) ;				
		
end if
			  
			  
commit;		
end subroutine

on w_facturacion_emitida_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_factu_e_detalle" then this.MenuID = create m_factu_e_detalle
this.tab_1=create tab_1
this.cb_imprimir=create cb_imprimir
this.dw_2=create dw_2
this.cb_exped=create cb_exped
this.cb_imprimir_recibo=create cb_imprimir_recibo
this.pb_1=create pb_1
this.cb_recibos_musaat=create cb_recibos_musaat
this.cb_borrar_vinculacion=create cb_borrar_vinculacion
this.cb_generar_numero_recibo_musaat=create cb_generar_numero_recibo_musaat
this.cb_recibo_irpf=create cb_recibo_irpf
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_exped
this.Control[iCurrent+5]=this.cb_imprimir_recibo
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.cb_recibos_musaat
this.Control[iCurrent+8]=this.cb_borrar_vinculacion
this.Control[iCurrent+9]=this.cb_generar_numero_recibo_musaat
this.Control[iCurrent+10]=this.cb_recibo_irpf
this.Control[iCurrent+11]=this.dw_3
end on

on w_facturacion_emitida_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cb_imprimir)
destroy(this.dw_2)
destroy(this.cb_exped)
destroy(this.cb_imprimir_recibo)
destroy(this.pb_1)
destroy(this.cb_recibos_musaat)
destroy(this.cb_borrar_vinculacion)
destroy(this.cb_generar_numero_recibo_musaat)
destroy(this.cb_recibo_irpf)
destroy(this.dw_3)
end on

event activate;////g_dw_lista  = g_dw_lista_facturacion_emitida
//g_w_lista   = g_lista_facturacion_emitida
//g_w_detalle = g_detalle_facturacion_emitida 
//g_lista     = 'w_facturacion_emitida_lista'
//g_detalle   = 'w_facturacion_emitida_detalle'

// 05/12/05 SOBREESCRITO
if i_ejecutar_activate THEN
	// C$$HEX1$$d300$$ENDHEX$$DIGO HEREDADO
	if gb_nuevo = true then
		This.PostEvent('csd_nuevo')
		gb_nuevo=false
	else
		dw_1.event csd_retrieve()
	end if
	// Fin c$$HEX1$$f300$$ENDHEX$$digo heredado

//	g_dw_lista  = g_dw_lista_facturacion_emitida
	g_w_lista   = g_lista_facturacion_emitida
	g_w_detalle = g_detalle_facturacion_emitida 
	g_lista     = 'w_facturacion_emitida_lista'
	g_detalle   = 'w_facturacion_emitida_detalle'
Else
	i_st_datos_factura_nueva = message.PowerObjectParm
	i_ejecutar_activate = TRUE
end if

end event

event csd_nuevo;//SOBREESCRITO!!!!
string id,nombre,n_factura
long i,n_fact

//VEAMOS SI SE HAN PRODUCIDO CAMBIOS EN las dws actuales
// Si cancela o no quiere guardar evitamos que inserte la nueva apertura
int retorno

if f_es_vacio(i_centro) then i_centro = f_devuelve_centro(g_cod_delegacion)
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
i_proyecto = g_explotacion_por_defecto

retorno = this.Event closequery()

if retorno = 1 then return -1
dw_1.reset()
idw_femitidas_conceptos.Reset()
idw_femitidas_apuntes.Reset()
//idw_femitidas_clasificacion.Reset()
idw_femitidas_cobros.Reset()

i=dw_1.event pfc_addrow()

//Introducimos en el campo clave el valor obtenido desde el contador.
dw_1.SetItem(dw_1.GetRow(),'id_factura',f_siguiente_numero('FACTUEMI',10))
dw_1.SetItem(dw_1.GetRow(),'centro',i_centro)
dw_1.SetItem(dw_1.GetRow(),'proyecto',i_proyecto)
dw_1.SetItem(dw_1.GetRow(),'usuario',g_usuario)
dw_1.SetItem(dw_1.GetRow(),'empresa',g_empresa)
// ANTES del pfc_addrow hemos de haberle puesto valor en la cabecera a id_factura para que enlace ok
idw_femitidas_conceptos.event pfc_addrow()

//Inicializacion de campos: f_alta, f_colegiacion a la fecha actual
Dw_1.setitem(1, 'fecha', datetime(Today()) )

// Ponemos la moneda por defecto 
dw_1.Setitem(1,"moneda",moneda_ejercicio)

// Ponemos la empresa por defecto 
//dw_1.Setitem(1,"empresa",f_devolver_empresa())

//donde "n" es un entero que indica la longitud en caracteres del contador
dw_1.setfocus()

//tab_1.tabpage_1.enabled=false

// Ocultar w_b$$HEX1$$fa00$$ENDHEX$$squeda
dw_1.Object.b_busqueda_colegiados.Visible = False
dw_1.Object.b_busqueda_clientes_exp.Visible = False
dw_1.Object.b_busqueda_clientes_csi.Visible = False

return 1
end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	// Nos aseguramos que no da error como en datos facturaci$$HEX1$$f300$$ENDHEX$$n en contratos por ejemplo
	if lower(g_dw_lista.describe("id_factura.name")) = 'id_factura' then 	
		g_facturacion_emitida_consulta.id_factura = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_factura')
		dw_1.event csd_retrieve()
		//Se visualiza Cobros Multiples si la factura tiene forma de pago = 'CM'
		if dw_1.getitemstring( 1, 'formadepago') = 'CM' then 
			tab_1.tabpage_6.visible= true
			tab_1.tabpage_3.visible= false
		else
			tab_1.tabpage_3.visible= true
			tab_1.tabpage_6.visible= false
		end if

	end if
end if


end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then
	// Nos aseguramos que no da error como en datos facturaci$$HEX1$$f300$$ENDHEX$$n en contratos por ejemplo
	if lower(g_dw_lista.describe("id_factura.name")) = 'id_factura' then 	
		g_dw_lista.setrow(1)
		g_dw_lista.scrolltorow(1)
		g_facturacion_emitida_consulta.id_factura= g_dw_lista.getitemstring(1,"id_factura")
		
		dw_1.event csd_retrieve()
		//Se visualiza Cobros Multiples si la factura tiene forma de pago = 'CM'
		if dw_1.getitemstring( 1, 'formadepago') = 'CM' then 
			tab_1.tabpage_6.visible= true
			tab_1.tabpage_3.visible= false
		else
			tab_1.tabpage_3.visible= true
			tab_1.tabpage_6.visible= false
		end if

	end if
end if

end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then
	// Nos aseguramos que no da error como en datos facturaci$$HEX1$$f300$$ENDHEX$$n en contratos por ejemplo
	if lower(g_dw_lista.describe("id_factura.name")) = 'id_factura' then 
		g_dw_lista.setrow(g_dw_lista.rowcount())
		g_dw_lista.scrolltorow(g_dw_lista.rowcount())
		g_facturacion_emitida_consulta.id_factura= g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_factura")
	
		dw_1.event csd_retrieve()
		//Se visualiza Cobros Multiples si la factura tiene forma de pago = 'CM'
		if dw_1.getitemstring( 1, 'formadepago') = 'CM' then 
			tab_1.tabpage_6.visible= true
			tab_1.tabpage_3.visible= false
		else
			tab_1.tabpage_3.visible= true
			tab_1.tabpage_6.visible= false
		end if

	end if
end if
end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	// Nos aseguramos que no da error como en datos facturaci$$HEX1$$f300$$ENDHEX$$n en contratos por ejemplo
	if lower(g_dw_lista.describe("id_factura.name")) = 'id_factura' then 
		g_facturacion_emitida_consulta.id_factura= g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_factura')

		dw_1.event csd_retrieve()
		
		//Se visualiza Cobros Multiples si la factura tiene forma de pago = 'CM'
		if dw_1.getitemstring( 1, 'formadepago') = 'CM' then 
			tab_1.tabpage_6.visible= true
			tab_1.tabpage_3.visible= false
		else
			tab_1.tabpage_3.visible= true
			tab_1.tabpage_6.visible= false
		end if

	end if
end if

end event

event open;call super::open;idw_femitidas_conceptos = tab_1.tabpage_1.dw_femitidas_conceptos
idw_femitidas_cobros = tab_1.tabpage_3.dw_femitidas_cobros
idw_femitidas_apuntes = tab_1.tabpage_4.dw_femitidas_apuntes
idw_datos_contrato = tab_1.tabpage_5.dw_datos_contrato
idw_modificacion_datos = tab_1.tabpage_9.dw_modificacion_datos
idw_femitidas_cobros_mult	=tab_1.tabpage_6.dw_cobros_multiples
idw_historico_proformas = tab_1.tabpage_7.dw_historico_proformas

f_enlaza_dw(dw_1, idw_femitidas_conceptos, 'id_factura', 'id_factura')
f_enlaza_dw(dw_1, idw_femitidas_cobros, 'id_factura', 'id_factura')
//Se agrega dw de cobros multiples yexaira 01/05/08
f_enlaza_dw(dw_1, idw_femitidas_cobros_mult, 'id_factura', 'id_factura')
// Para la v3 mirar pq no enlaza bien por id_interno
// Modificado Ricardo 03-11-05
//f_enlaza_dw(dw_1, idw_femitidas_apuntes, 'n_fact', 'n_doc')
// Creo que no enlazaba porque no estaba bien puesto el enlazamiento
f_enlaza_dw(dw_1, idw_femitidas_apuntes, 'id_factura', 'id_interno')
f_enlaza_dw(dw_1, dw_3, 'id_factura', 'id_factura')
//f_enlaza_dw(dw_1, idw_historico_proformas, 'id_factura', 'id_factura')

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright&bottom")
//inv_resize.of_register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_3, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_4, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_6, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_7, "scaletoright&bottom")
//Luego de los DW
inv_resize.of_register (idw_femitidas_conceptos, "scaletoright&bottom")
//inv_resize.of_register (idw_femitidas_clasificacion, "scaletoright&bottom")
inv_resize.of_register (idw_femitidas_cobros, "scaletoright&bottom")
inv_resize.of_register (idw_femitidas_cobros_mult, "scaletoright&bottom")
inv_resize.of_register (idw_femitidas_apuntes, "scaletoright&bottom")
inv_resize.of_register (idw_datos_contrato, "scaletoright&bottom")
inv_resize.of_Register (idw_modificacion_datos, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_historico_proformas, "ScaletoRight&Bottom")

// Para el usuario csd mostramos el bot$$HEX1$$f300$$ENDHEX$$n para ver el hist$$HEX1$$f300$$ENDHEX$$rico
// DAVID - 14/10/2004
if (g_usuario = '0000000001') or (f_es_superusuario() <> '-1') then pb_1.visible = true 

// Mostramos el bot$$HEX1$$f300$$ENDHEX$$n de imprimir recibos de musaat
if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLR' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' then 
	cb_recibos_musaat.visible = true
end if

i_impresion_formato = create n_csd_impresion_formato


//idwc_forma_pago.setfilter("tipo_pago<> 'CM'")
//idwc_forma_pago.filter()



this.post event csd_habilitar_edicion()
end event

event pfc_preupdate;string mensaje='',tipo_factura,n_inf,id_persona,n_inf_unico,serie_facturas, emisor, msg
int retorno=1, num, continua
datetime hoy, fecha_inicio_validez, fecha_fin_validez
st_facturas lst_facturas

//control de permisos
dw_2.SetTransObject(bd_ejercicio)
if f_puedo_escribir(g_usuario, '0000000019')= -1 then return -1 

///***SCP-756. Alexis. 03012011. Para proformas, no se pueden guardar cobros. ***///
if idw_femitidas_cobros.rowcount() > 0 or idw_femitidas_cobros_mult.rowcount()>0 then
	if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
		messagebox(g_titulo, "No se pueden guardar facturas proforma con cobros asociados. Elim$$HEX1$$ed00$$ENDHEX$$nelos antes de continuar." )
		return -1 
	end if	
end if

tipo_factura = dw_1.GetItemString(dw_1.GetRow(),'tipo_factura')
emisor = dw_1.GetItemString(dw_1.GetRow(),'emisor')
hoy = datetime(Today())
if f_es_vacio(dw_1.getitemstring(1,'asunto')) then
   messagebox(g_titulo,"La factura se guardar$$HEX2$$e1002000$$ENDHEX$$con asunto contable vacio...")
end if
	
//mensaje=mensaje + f_valida(dw_1,'n_fact','NOVACIO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de factura.')
mensaje=mensaje + f_valida(dw_1,'fecha','NONULO','Debe especificar un valor en el campo Fecha.')

mensaje=mensaje + f_valida(dw_1,'nif','NOVACIO','Debe especificar un valor en el campo NIF.')
mensaje=mensaje + f_valida(dw_1,'tipo_factura','NOVACIO','Debe especificar un valor en el campo Tipo de factura.')
mensaje=mensaje + f_valida(dw_1,'nombre','NOVACIO','Debe especificar un valor en el campo Nombre.')
//mensaje=mensaje + f_valida(dw_1,'domicilio','NOVACIO','Debe especificar un valor en el campo Domicilio.')
mensaje=mensaje + f_valida(dw_1,'domicilio_largo','NOVACIO','Debe especificar un valor en el campo Domicilio.')
mensaje=mensaje + f_valida(dw_1,'poblacion','NOVACIO','Debe especificar un valor en el campo Poblaci$$HEX1$$f300$$ENDHEX$$n.')

mensaje=mensaje + f_valida(idw_femitidas_conceptos,'t_iva','NOVACIO','Debe especificar un valor en el campo Tipo de IVA.')
mensaje=mensaje + f_valida(idw_femitidas_conceptos,'articulo','NOVACIO','Debe especificar un valor en el campo Art$$HEX1$$ed00$$ENDHEX$$culo.')
//mensaje=mensaje + f_valida(dw_1,'cuenta','NOVACIO','Debe especificar un valor en el campo Cuenta.')

//fin 

// INC. 8583
string banco, forma_pago
forma_pago = dw_1.GetItemString(1, 'formadepago')
banco = dw_1.GetItemString(1,'banco')
if g_colegio = "COAATA" and forma_pago = g_formas_pago.domiciliacion and banco = "09" then
	messagebox(g_titulo, "No se permite esta combinaci$$HEX1$$f300$$ENDHEX$$n de forma de pago y banco", stopsign!)
	retorno=-1
end if


// Ricardo 04-01-21
// Para los conceptos, copiamos el centro de la cabecera, as$$HEX2$$ed002000$$ENDHEX$$evitamos problemas, se haya puesto lo que se haya puesto
// No es la mejor solucion, pero si la m$$HEX1$$e100$$ENDHEX$$s rapida
long fila
string centro_cabecera= '', mensaje_centro_cobros = ''
centro_cabecera = dw_1.getitemstring(dw_1.getrow(), 'centro')
FOR fila = 1 TO idw_femitidas_conceptos.RowCount()
	if f_es_vacio(idw_femitidas_conceptos.GetitemString(fila, 'centro')) then
		idw_femitidas_conceptos.SetItem(fila, 'centro', centro_cabecera)
	else
		if idw_femitidas_conceptos.GetitemString(fila, 'centro')<>centro_cabecera then
			idw_femitidas_conceptos.SetItem(fila, 'centro', centro_cabecera)
		end if
	end if
NEXT

// MODIFICADO RICARDO 04-05-06
datetime f_pago
double importe_pagos = 0
boolean b_computar_cobros 
f_pago = datetime(date("1/1/1900"), time("00:00"))
b_computar_cobros = true//(dw_1.GetitemString(1, 'pagado') = 'N')
// FIN MODIFICADO RICARDO 04-05-06

// Para las filas de los cobros protestaremos antes de actualizar
FOR fila = 1 TO idw_femitidas_cobros.RowCount()
	if not f_es_vacio(idw_femitidas_cobros.GetitemString(fila, 'centro')) then
		if idw_femitidas_cobros.GetitemString(fila, 'centro')<>centro_cabecera then
			mensaje_centro_cobros = 'Existen cobros con un centro diferente de '+centro_cabecera+''
		end if
	end if

	// MODIFICADO RICARDO 04-05-24
	CHOOSE CASE g_colegio
		CASE 'COAATLR'
			string mensaje_importe_cero_cobros
			// Miramos si hay alguno con el importe a 0
			if idw_femitidas_cobros.GetitemNumber(fila, 'importe') = 0 or isnull(idw_femitidas_cobros.GetitemNumber(fila, 'importe')) then
				mensaje_importe_cero_cobros = 'Existen cobros con el importe a 0 o nulo'
			end if
	END CHOOSE
	// FIN MODIFICADO RICARDO 04-05-24

	// MODIFICADO RICARDO 04-05-06
	if b_computar_cobros then
		// Si la suma de cobros supera el total de la factura, marcamos el pagado y ponemos la fecha de pago a la mayor 
		// de las fechas de los cobros
		if idw_femitidas_cobros.GetitemString(fila, 'pagado') = 'S' then
			if not isnull(idw_femitidas_cobros.GetitemNumber(fila, 'importe')) then importe_pagos += idw_femitidas_cobros.GetitemNumber(fila, 'importe')
			if not isnull(idw_femitidas_cobros.GetitemDatetime(fila, 'f_pago')) then 
				// VAmos acumulando para tener la ultima fecha de pago
				if f_pago < idw_femitidas_cobros.GetitemDatetime(fila, 'f_pago') then 
					f_pago = idw_femitidas_cobros.GetitemDatetime(fila, 'f_pago')
					forma_pago = idw_femitidas_cobros.GetitemString(fila, 'forma_pago')
					banco = idw_femitidas_cobros.GetitemString(fila, 'banco')
				end if
			end if
		end if
	end if
	// FIN MODIFICADO RICARDO 04-05-06

	string mensaje_cobros_no_pagados
	// MODIFICADO RICARDO 04-05-20
	// Si es una factura de honorarios de colegiados no es posible dejar los cobros como no pagados
	if dw_1.getitemstring(1, 'tipo_factura') = g_colegiado_cliente and f_es_vacio(mensaje_cobros_no_pagados) then
		if ib_cambio = false then
			if idw_femitidas_cobros.GetitemString(fila, 'pagado') = 'N' and idw_femitidas_cobros.GetitemString(fila, 'forma_pago')<>g_formas_pago.pendientes_abono then mensaje_cobros_no_pagados += "Los cobros de una factura Colegiado-Cliente no pueden quedar como no pagados" 
		end if
	end if
	// FIN MODIFICADO RICARDO 04-05-20
NEXT

// MODIFICADO RICARDO 04-05-20
if not f_es_vacio(mensaje_cobros_no_pagados) then
	mensaje += cr+mensaje_cobros_no_pagados
end if

if not f_es_vacio(mensaje_importe_cero_cobros) then
	mensaje += cr+mensaje_importe_cero_cobros
end if

// MODIFICADO RICARDO 04-05-06
if b_computar_cobros then
	if dw_1.GetItemNumber(1, 'total')>0 and importe_pagos>(dw_1.GetItemNumber(1, 'total') - 0.01) or &
		dw_1.GetItemNumber(1, 'total')<0 and importe_pagos<(dw_1.GetItemNumber(1, 'total') + 0.01) then
		//Andr$$HEX1$$e900$$ENDHEX$$s 20/06/05
		//Avisamos al usuario de que se va a marcar como pagada la factura
		//05/08/05 ..s$$HEX1$$f300$$ENDHEX$$lo si la factura no estaba pagada
		if dw_1.getitemstring(1,'pagado')<>'S' then
			Messagebox(g_titulo,'Dado que los cobros superan el importe de la factura $$HEX1$$e900$$ENDHEX$$sta se marcar$$HEX2$$e1002000$$ENDHEX$$como pagada',Information!)
		end if
		dw_1.setitem(1, 'pagado', 'S')  
		if isnull(dw_1.GetItemDatetime(1, 'f_pago')) then dw_1.setitem(1, 'f_pago', f_pago)
		if isnull(dw_1.GetItemString(1, 'formadepago')) then dw_1.setitem(1, 'formadepago', forma_pago)
		if isnull(dw_1.GetItemString(1, 'banco')) then dw_1.setitem(1, 'banco', banco)
	end if
end if
// FIN MODIFICADO RICARDO 04-05-06

if mensaje_centro_cobros<>'' then
	if messagebox(g_titulo, mensaje_centro_cobros+cr+ "Mientras no sean iguales no se podr$$HEX2$$e1002000$$ENDHEX$$actualizar"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea que sea colocado el valor de la cabecera de la factura automaticamente?", question!, yesno!, 2)=2 then
		mensaje = "El centro de la cabecera y de los cobros no es el mismo"
	else
		FOR fila = 1 TO idw_femitidas_cobros.RowCount()
			if f_es_vacio(idw_femitidas_cobros.GetitemString(fila, 'centro')) then
				idw_femitidas_cobros.SetItem(fila, 'centro', centro_cabecera)
			else
				if idw_femitidas_cobros.GetitemString(fila, 'centro')<>centro_cabecera then
					idw_femitidas_cobros.SetItem(fila, 'centro', centro_cabecera)
				end if
			end if
		NEXT
	end if
end if
// Fin Ricardo 04-01-21

dw_1.SetItem(1,'obs',LeftA(dw_1.getitemString(1, 'observaciones_text'),200))

// Modificado David - 23/02/2005
// Han pedido que les avise cuando no rellenan estos dos campos
if g_colegio = 'COAATGC' then
	string fpago, bpago
	fpago = dw_1.getitemstring(1, 'formadepago')
	bpago = dw_1.getitemstring(1, 'banco')
	if f_es_vacio(fpago) or f_es_vacio(bpago) then 
		messagebox(g_titulo, "No ha introducido la forma de pago y/o el banco", information!)
	end if
end if

//Salva Ren$$HEX2$$fa002000$$ENDHEX$$30/06/09
string n_fact 
string id_factura 
int cuantos
n_fact = dw_1.GetItemString(1,'n_fact')
if not(f_es_vacio(n_fact)) then
	//Comprobamos si la factura est$$HEX2$$e1002000$$ENDHEX$$duplicada

	id_factura = dw_1.GetItemString(1,'id_factura')
	select count(*) into :cuantos from csi_facturas_emitidas where n_fact = :n_fact and id_factura <> :id_factura AND empresa=:g_empresa;
	
	if cuantos > 0 then mensaje = mensaje + cr + "Ya existe una factura con ese n$$HEX1$$fa00$$ENDHEX$$mero."
	
end if

//Luis - Validaci$$HEX1$$f300$$ENDHEX$$n para el nuevo tipo de IVA
num = gnv_ivajulio2010.of_validez_iva_documento( 'E', dw_1, idw_femitidas_conceptos,'N')

// 16%, 7%
//IF num = -2 THEN 
//	select f_fin_validez into :fecha_fin_validez from csi_t_iva where t_iva = '16';
//	msg = g_idioma.of_getmsg('factura_e.iva16','Los tipos de IVA al 16% y 7% s$$HEX1$$f300$$ENDHEX$$lo son v$$HEX1$$e100$$ENDHEX$$lidos para fechas anteriores al') +' '+ string(date(fecha_fin_validez)) +'. '+ g_idioma.of_getmsg('factura_e.continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?')
//	continua = messagebox(g_titulo,msg,Exclamation!, YesNo!,1)
//// 18%, 8%
//ELSEIF num = -1 THEN 
//	select f_inicio_validez into :fecha_inicio_validez from csi_t_iva where t_iva = 'Z8';
//	msg = g_idioma.of_getmsg('factura_e.iva18','Los tipos de IVA al 18% y 8% s$$HEX1$$f300$$ENDHEX$$lo son v$$HEX1$$e100$$ENDHEX$$lidos para fechas posteriores al ')+' '+string(date(fecha_inicio_validez))+'. '+ g_idioma.of_getmsg('factura_e.continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?')
//	continua = messagebox(g_titulo,msg,Exclamation!, YesNo!,1)
//END IF

IF num < 0  THEN 
	msg =  'El tipo de IVA de alguno de los articulos es obsoleto.$$HEX1$$bf00$$ENDHEX$$Desea continuar?'
	continua = messagebox(g_titulo,msg,Exclamation!, YesNo!,1)
END IF

if(continua=2) then 
		retorno=-1
end if
//fin cambio

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
else
	i_centro = dw_1.GetItemString(dw_1.GetRow(),'centro')
	//Llamamos al Control de Eventos...
	st_control_eventos c_evento
	c_evento.evento = 'GRABAR_FACTURA'
	c_evento.dw = dw_1
	if f_control_eventos(c_evento) = -1 then return -1

	if f_es_vacio(dw_1.GetItemString(dw_1.GetRow(),'n_fact')) then
		// 05/12/05 Para evitar problemas con el evento activate si abrimos una factura y a$$HEX1$$fa00$$ENDHEX$$n no 
		// hab$$HEX1$$ed00$$ENDHEX$$amos asignado n$$HEX1$$fa00$$ENDHEX$$mero a$$HEX1$$f100$$ENDHEX$$adimos la siguiente l$$HEX1$$ed00$$ENDHEX$$nea
		i_ejecutar_activate = FALSE
		Open(w_facturacion_emitida_serie)
		// 05/12/05 Para evitar problemas con el evento activate si abrimos una factura y a$$HEX1$$fa00$$ENDHEX$$n no 
		// hab$$HEX1$$ed00$$ENDHEX$$amos asignado n$$HEX1$$fa00$$ENDHEX$$mero utilizamos una vble.instancia serie_facturas= Message.StringParm
		i_serie = i_st_datos_factura_nueva.serie 

		serie_facturas= i_st_datos_factura_nueva.serie 
		
//		Open(w_facturacion_emitida_serie)
//		serie_facturas= Message.StringParm
		if not(f_es_vacio(serie_facturas)) and i_st_datos_factura_nueva.automatico then
			if serie_facturas = 'COLEGIADOS' then serie_facturas = dw_1.getitemstring(1, 'n_col')
			///*** SCP-1190. Cambios con motivos de la aplicaci$$HEX1$$f300$$ENDHEX$$n multiempresa.  Alexis. 16/03/2011 ***///
			lst_facturas.cod_empresa = g_empresa
			lst_facturas.tipo_factura = tipo_factura
			n_inf=f_siguiente_n_fact_emitida_empresa(lst_facturas,serie_facturas,emisor,hoy)
			dw_1.SetItem(dw_1.GetRow(),'n_fact',n_inf)
		else
			dw_1.SetItem(1,'n_fact',i_st_datos_factura_nueva.n_fact)
				id_factura = dw_1.GetItemString(1,'id_factura')
				n_fact = i_st_datos_factura_nueva.n_fact
			select count(*) into :cuantos from csi_facturas_emitidas where n_fact = :n_fact and id_factura <> :id_factura and empresa=:g_empresa;
	
			if cuantos > 0 then 
				MessageBox(g_titulo,"Ya existe una factura con ese n$$HEX1$$fa00$$ENDHEX$$mero.",StopSign!)
				return -1
			end if

		end if
	end if
	if f_es_vacio(dw_1.GetItemString(dw_1.GetRow(),'n_fact_unico')) then
		n_inf_unico=f_siguiente_numero('SERIE_UNICA',10)
		dw_1.SetItem(dw_1.GetRow(),'n_fact_unico',n_inf_unico)
	end if
	// INC. 4110
	// Avisamos si se ha modificado el total de una factura que tiene liquidaci$$HEX1$$f300$$ENDHEX$$n
	string id_liq
	id_liq = dw_1.getitemstring(1, 'id_liquidacion')
	if f_es_vacio(id_liq) then id_liq = f_factura_num_liquidacion_incluida(dw_1.getitemstring(1, 'id_fase'))
	if not f_es_vacio(id_liq) then
		if i_total <> dw_1.getitemnumber(1, 'total') then
			messagebox(g_titulo, "Revise la liquidaci$$HEX1$$f300$$ENDHEX$$n n$$HEX2$$ba002000$$ENDHEX$$" + id_liq + ", puede haber variado su importe")
		end if
	end if
	i_total = dw_1.getitemnumber(1, 'total')
end if
return retorno

end event

event pfc_postupdate;call super::pfc_postupdate;// Modificado Ricardo 03-11-05
long fila, fila_musaat = -1
long  ll_fila
string modificacion

if AncestorReturnValue>0 then
	// Hay que volver a retrivear porque no se trabaja sobre el idw_femitidas_apuntes, sino sobre el dw_2
	idw_femitidas_apuntes.retrieve(dw_1.GetItemString(dw_1.getrow(), 'id_factura'))

	CHOOSE CASE g_colegio
		CASE 'COAATZ', 'COAATGU', 'COAATLR', 'COAATLE', 'COAATAVI'
			// Inicializamos el check a N por una parte y por otra buscamos si hay concepto de musaat variable sin n_recibo
			for fila = 1 to idw_femitidas_conceptos.rowcount()
				if idw_femitidas_conceptos.getitemString(fila, 'articulo') = g_codigos_conceptos.musaat_variable and f_es_vacio(idw_femitidas_conceptos.getitemString(fila, 'id_recibo')) then
					fila_musaat = fila
					exit
				end if
			next
			// MODIFICADO RICARDO 2005-03-01
			// Cuando recuperan no dejamos ver el bot$$HEX1$$f300$$ENDHEX$$n
			if fila_musaat>0 then
				cb_generar_numero_recibo_musaat.enabled = true
				cb_generar_numero_recibo_musaat.visible = true
			else
				cb_generar_numero_recibo_musaat.visible = false
			end if
			// MODIFICADO RICARDO 2005-03-01
	END CHOOSE
	
	///INCLUYE INFORMACI$$HEX1$$d300$$ENDHEX$$N EN EL HISTORICO PARA LA CREACION DE LA FACTURA
	Datastore ds_historico
	ds_historico = create datastore
	ds_historico.dataobject = 'd_historico'
	ds_historico.SetTransObject(SQLCA)
	
	ll_fila = ds_historico.InsertRow(0)
	
	modificacion = "CREA FACTURA " 
	
	ds_historico.setitem(ll_fila, 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
	ds_historico.setitem(ll_fila, 'id_colegiado',dw_1.getitemstring(1,'id_factura') )
	ds_historico.setitem(ll_fila, 'tipo_modulo', '05')
	ds_historico.setitem(ll_fila, 'modificacion', modificacion)
	ds_historico.setitem(ll_fila,'fecha',datetime(today(),now()))
	ds_historico.setitem(ll_fila,'usuario',g_usuario)
	
	ds_historico.update() 

	COMMIT;
	
	
end if

return AncestorReturnValue
// FIN Modificado Ricardo 03-11-05

end event

event pfc_postopen;call super::pfc_postopen;if dw_1.rowcount()>0 then
	//Se visualiza Cobros Multiples si la factura tiene forma de pago = 'CM'
	if dw_1.getitemstring( 1, 'formadepago') = 'CM' then 
		tab_1.tabpage_6.visible= true
		tab_1.tabpage_3.visible= false
	else
		tab_1.tabpage_3.visible= true
		tab_1.tabpage_6.visible= false
	end if
end if



end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_facturacion_emitida_detalle
integer y = 1416
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_facturacion_emitida_detalle
integer y = 1264
end type

type cb_nuevo from w_detalle`cb_nuevo within w_facturacion_emitida_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_facturacion_emitida_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_facturacion_emitida_detalle
integer y = 104
end type

type cb_ant from w_detalle`cb_ant within w_facturacion_emitida_detalle
end type

type cb_sig from w_detalle`cb_sig within w_facturacion_emitida_detalle
end type

type dw_1 from w_detalle`dw_1 within w_facturacion_emitida_detalle
event csd_btn_busqueda_persona ( )
event calcula_total ( )
event generar_cobros ( )
event ctav_generar_pagos ( )
event type double csd_calcula_irpf ( )
event csd_modificacion_datos ( string id_colegiado,  u_dw dw,  string nombre_dw,  string campo,  long row )
event csd_comprueba_cuenta_bancaria ( )
event csd_banco ( )
event csd_formapago_fraccionada ( )
integer x = 0
integer y = 0
integer width = 3218
integer height = 1376
string dataobject = "d_facturacion_emitida_detalle"
boolean border = false
end type

event dw_1::csd_btn_busqueda_persona;// Este evento se ejecuta despu$$HEX1$$e900$$ENDHEX$$s de cambiar el tipo persona

	// Borramos los datos de la persona al cambiar el tipo de factura
		f_limpiar_datos_persona( this, 1)
		
	// Nos sirve para mostrar los campos referentes al tipo de persona, ocultando los dem$$HEX1$$e100$$ENDHEX$$s
		f_habilita_btn_busqueda_tipo_factura (this)
		
end event

event dw_1::calcula_total();double bi,iva,irpf,total,bi_irpf, t_irpf

bi = this.GetItemNumber(this.getRow(),'base_imp')
bi_irpf = event csd_calcula_irpf()
iva = this.GetItemNumber(this.getRow(),'iva')
t_irpf = this.GetItemNumber(this.getRow(),'tipo_reten')

irpf = f_redondea(bi_irpf*t_irpf/100)
this.SetItem(this.GetRow(),'importe_reten',irpf)
//irpf = this.GetItemNumber(this.getRow(),'importe_reten')

if isnull(bi) then bi=0
if isnull(iva) then iva=0
if isnull(t_irpf) then irpf=0

total = bi + iva - irpf


this.SetItem(this.GetRow(),'total',f_redondea(total))

///* SCP-756. SCP-833. Si es proforma no se actualizan los cobros. Alexis. 04-01-2011***///
if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'N' then
	idw_femitidas_cobros.TriggerEvent('csd_actualizar_cobros')
end if	
end event

event dw_1::generar_cobros;int i, num_venc

// Si no hay pagos ya creados,
// 	generamos tantas l$$HEX1$$ed00$$ENDHEX$$neas de pago como num. venc. tenga la forma de pago

	tab_1.selecttab('tabpage_3')

	num_venc = f_dame_campos_integer_formadepago ( 'num_venc', this.GetItemString(1, 'formadepago') )
	if idw_femitidas_cobros.RowCount() = 0 then
		for i = 1 to num_venc 
				idw_femitidas_cobros.Event pfc_addrow()
		next
	end if// Ya hay pagos definidos
end event

event dw_1::ctav_generar_pagos();/// EVENTO ctav_generar_pagos
int i,  ll_new, mes, a$$HEX1$$f100$$ENDHEX$$o, dia
double  total, dias_entre_venc, dia_primer_venc
decimal {2} subtotal, total_venc ,ultimo_valor
string  contado, ls_fecha, ls_forma_pago
datetime fecha, fecha_inicial, f_vencimiento
 
// Si no hay pagos ya creados,
// generamos tantas l$$HEX1$$ed00$$ENDHEX$$neas de pago como num. venc. tenga la forma de pago

fecha = dw_1.GetItemDateTime(1,'fecha')
if IsNull(fecha) then fecha = DateTime(Today())

total = dw_1.GetItemNumber (1,'total')
if IsNull(total) then total = 0
 
i_forma_pago = dw_1.GetItemString(1,'formadepago')
 
if i_forma_pago ='FR' then
	
	this.triggerEvent('csd_formapago_fraccionada')
	
	
else
	i_num_venc = f_dame_campos_integer_formadepago ( 'num_venc', i_forma_pago )
			

 
	tab_1.selecttab('tabpage_3')
	
	if idw_femitidas_cobros.RowCount() = 0 then
		for i = 1 to i_num_venc 
			ll_new = idw_femitidas_cobros.Event pfc_addrow()
			idw_femitidas_cobros.SetItem(ll_new,'importe',total)
			idw_femitidas_cobros.SetItem(ll_new,'forma_pago',i_forma_pago)
			idw_femitidas_cobros.SetItem(ll_new,'cod_usuario', g_usuario)
			contado = f_dame_campos_string_formadepago ( 'contado', i_forma_pago )
	
			if contado = 'S' then
				// Si es contado marcamos la factura como cobrada con la fecha de la factura o del sistema si esta es vac$$HEX1$$ed00$$ENDHEX$$a
				dw_1.SetItem(ll_new,'pagado','S')
				dw_1.SetItem(ll_new,'f_pago',fecha)
				
				// Si es contado marcamos el cobro como cobrado con la fecha de la factura o del sistema si esta es vac$$HEX1$$ed00$$ENDHEX$$a
				idw_femitidas_cobros.SetItem(ll_new,'pagado','S')
				idw_femitidas_cobros.SetItem(ll_new,'f_pago',fecha)
			end if	
		
		next
	
	end if
end if// Ya hay pagos definidos

end event

event type double dw_1::csd_calcula_irpf();int i
double irpf_total, subtotal

idw_femitidas_conceptos.accepttext()

for i=1 to idw_femitidas_conceptos.rowcount()
	if f_concepto_tiene_irpf(idw_femitidas_conceptos.getitemstring(i, 'articulo')) = 'S' then
		subtotal= idw_femitidas_conceptos.getitemnumber(i, 'subtotal')
		if isnull(subtotal) then subtotal = 0
		irpf_total += subtotal
	end if
next

return irpf_total

end event

event dw_1::csd_modificacion_datos(string id_colegiado, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  colegiado, modificacion, data, tipo
integer fila

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

//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion=TRUE then
	idw_modificacion_datos.triggerevent("pfc_addrow")
end if

fila        =idw_modificacion_datos.rowcount()
colegiado   =id_colegiado
modificacion=idw_modificacion_datos.getitemstring(fila,'modificacion')

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
if LeftA(nombre_dw,9) = 'CONCEPTOS' or LeftA(nombre_dw,6) = 'COBROS' then 
	modificacion = modificacion + nombre_dw + ' (' + string(row) + ') ' + campo + '=' + data + '; '
else
	modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '
end if

// Se actualiza la dw de modificaciones oculta
idw_modificacion_datos.setitem(fila,'id_colegiado',colegiado)
idw_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion=FALSE

end event

event dw_1::csd_comprueba_cuenta_bancaria();// Comprobamos que en las facturas que se van a domiciliar la cuenta bancaria es correcta
string fp
fp = this.getitemstring(1, 'formadepago')
if f_es_vacio(fp) or fp <> g_formas_pago.domiciliacion then return

string tipo_fact, id_persona, bdom

tipo_fact = this.getitemstring(1, 'tipo_factura')
id_persona = this.getitemstring(1, 'id_persona')

CHOOSE CASE tipo_fact
	CASE '02' // Cliente
		select datos_bancarios_iban into :bdom from clientes where id_cliente = :id_persona;
		bdom = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(bdom)
	CASE '03' // Colegiado
		select datos_bancarios_iban into :bdom from colegiados where id_colegiado = :id_persona;
		// Si no tiene la general probamos con la de expedientes
		bdom = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(bdom)
		if f_es_vacio(bdom) or LenA(trim(bdom))<>20 then
			select datos_bancarios_iban into :bdom from conceptos_domiciliables 
			where id_colegiado = :id_persona and 
					forma_de_pago = :g_formas_pago.domiciliacion and 
					concepto = :g_conta.concepto_exp ;
			bdom = gnv_control_cuentas_bancarias.of_obtener_cuenta_sin_iban(bdom)		
		end if
END CHOOSE


if f_es_vacio(bdom) or LenA(trim(bdom))<>20 then
	messagebox(g_titulo, 'La cuenta bancaria del colegiado/cliente no existe o no es v$$HEX1$$e100$$ENDHEX$$lida', exclamation!)
end if

end event

event dw_1::csd_banco;// Se busca el banco asociado a la forma de pago

SELECT csi_formas_de_pago.banco_asociado  
INTO :i_banco  
FROM csi_formas_de_pago  
WHERE csi_formas_de_pago.tipo_pago = :i_forma_pago ;
		


end event

event dw_1::csd_formapago_fraccionada();/// EVENTO csd_formapago_fraccionada
int i, j, num_venc, ll_new, mes, a$$HEX1$$f100$$ENDHEX$$o, dia
double  total, dias_entre_venc, dia_primer_venc
decimal {2} subtotal, total_venc ,ultimo_valor
string  contado, ls_fecha, ls_forma_pago
datetime fecha, fecha_inicial, f_vencimiento

//Abrimos la ventana de n vencimientos
open(w_facturacion_emitida_vencimientos)
	
ist_vencimiento =  message.PowerObjectParm	
num_venc 		 = ist_vencimiento.n_vencimiento	  // cantidad de vencimientos
dia_primer_venc = ist_vencimiento.dias_primer     // vence cada dia_primer_venc
dias_entre_venc = ist_vencimiento.dias_entre      // tiene un lapso de duraci$$HEX1$$f300$$ENDHEX$$n entre dias de dias_entre_venc
fecha_inicial   = ist_vencimiento.fecha_inicial   // fecha del primer vencimiento
ls_forma_pago   = ist_vencimiento.formapago 

i_forma_pago = ls_forma_pago

this.triggerEvent('csd_banco') 


total = dw_1.GetItemNumber (1,'total')
if IsNull(total) then total = 0

	 
//se hace el c$$HEX1$$e100$$ENDHEX$$lculo distribuido del importe
wf_calcula_montos_vencimiento(total, num_venc, ultimo_valor)
 
tab_1.selecttab('tabpage_3')


if idw_femitidas_cobros.RowCount() > 0 then
	int k
	k = idw_femitidas_cobros.RowCount()
	for j = 1  to k
			idw_femitidas_cobros.Event pfc_deleterow()
	next
	
end if
 
//idw_femitidas_cobros.update()
//messagebox("row", string(idw_femitidas_cobros.RowCount()))
	for i = 1 to num_venc 
		ll_new = idw_femitidas_cobros.Event pfc_addrow()

		idw_femitidas_cobros.SetItem(ll_new,'importe', round(total, 2))
		idw_femitidas_cobros.SetItem(ll_new,'forma_pago',ls_forma_pago)
		idw_femitidas_cobros.SetItem(ll_new,'banco', i_banco)
		idw_femitidas_cobros.SetItem(ll_new,'n_plazo', string(i))
		contado = f_dame_campos_string_formadepago ( 'contado', ls_forma_pago )
		if ultimo_valor > 0 and i = num_venc then
			idw_femitidas_cobros.SetItem(ll_new,'importe',round(ultimo_valor, 2))
		end if
			
	
	next


a$$HEX1$$f100$$ENDHEX$$o  = year(today())
mes  = month(today())

// calculo de las fechas
for i = 1 to num_venc
	
	
	//C$$HEX1$$e100$$ENDHEX$$lculo cuando vence un dia determinado
	if dia_primer_venc > 0 then
		dia = dia_primer_venc
		mes = mes+1
		if mes > 12 then
			mes = 1
			a$$HEX1$$f100$$ENDHEX$$o = a$$HEX1$$f100$$ENDHEX$$o+1
		end if
		if dia >=29  then
			dia = f_fecha_ultimo_dia( dia,mes)
		end if
	//	messagebox("dia",dia)
		
		ls_fecha = string (string(dia) +'/'+string(mes)+'/' +string(a$$HEX1$$f100$$ENDHEX$$o))
		//messagebox("ls_fecha",ls_fecha)
		f_vencimiento = datetime(date(ls_fecha))
		
	end if
	
	//C$$HEX1$$e100$$ENDHEX$$culo del d$$HEX1$$ed00$$ENDHEX$$a cuando tiene duraci$$HEX1$$f300$$ENDHEX$$n
	if dias_entre_venc > 0 and not isnull(fecha_inicial)then
		mes  = month(date(fecha_inicial))
		dia  = day(date(fecha_inicial))
		
		if i = 1 then
			f_vencimiento = fecha_inicial
		else
			f_vencimiento = datetime(RelativeDate(date(fecha_inicial), dias_entre_venc))
			fecha_inicial = f_vencimiento
		end if
		
	end if
	
		idw_femitidas_cobros.SetItem(i,'f_vencimiento',f_vencimiento)

next
//
//end if
//
end event

event dw_1::csd_retrieve();call super::csd_retrieve;//Variables de control de grabacion de modificacion
g_recien_grabado_modificacion=TRUE

if g_facturacion_emitida_consulta.id_factura = '' or isnull(g_facturacion_emitida_consulta.id_factura) then return
int retorno
double i

retorno = parent.event closequery()
if retorno = 1 then return

idw_femitidas_apuntes.settransobject(bd_ejercicio)
this.retrieve(g_facturacion_emitida_consulta.id_factura )
//Se enlaza el Tab dependiendo del valor de tipo_persona

g_facturacion_emitida_consulta.id_factura = ''

i_total = this.getitemnumber(1, 'total')

end event

event dw_1::itemchanged;string id_persona, ls_formapago, ls_nva_formapago,ls_id_cobro_multiple, ls_id_pago, ls_id_factura
int respuesta, num
double     ldb_total_factura, ldb_total_actual_cobro
boolean   lb_cambio
datetime fecha_ant

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_factura'), this, 'DETALLE', dwo.name, row)

fecha_ant = dw_1.getitemdatetime(1,'fecha')

choose case dwo.name
//	case 'tipo_persona'
//		this.PostEvent('actualiza_campos')

	case 'fecha'
		//Luis - Validaci$$HEX1$$f300$$ENDHEX$$n para el nuevo tipo de IVA
		dw_1.accepttext( )
		//gnv_ivajulio2010.of_fecha_validez_iva( 'E', dw_1, idw_femitidas_conceptos)
		num = gnv_ivajulio2010. of_cambio_periodo_iva_fecha_factura( date(data), fecha_ant, 'N')
		if(num = -1)then
			MessageBox(g_titulo,g_idioma.of_getmsg('factura_e.fecha_iva','El cambio de fecha implica cambios en los tipos de IVA, revise las lineas de conceptos'),Exclamation!, OK!,1)
		end if
		
	case 'tipo_factura'
		// Borramos los datos de la persona al cambiar el tipo de factura
		// 	y habilitamos el btn de busqueda correspondiente
		this.PostEvent('csd_btn_busqueda_persona')
		choose case data
			case '01'
				this.SetItem(1,'tipo_persona','G')
			case '03'
				this.SetItem(1,'tipo_persona','C')
				///***SCP-1051. Alexis. 03/03/2011. Se setean campos de los datos del pagador para que se queden a NO ***///
				this.SetItem(1,'paga_empresa','N')
				this.SetItem(1,'paga_externo','N')
				this.SetItem(1,'imprime_cta_banco_col','N')
			case else
				this.SetItem(1,'tipo_persona','P')
		end choose
		
	case 'base_imp'
		this.PostEvent('calcula_total')
	case 'iva'
		this.PostEvent('calcula_total')
	case 'tipo_reten'
		this.PostEvent('calcula_total')
	case 'importe_reten'
		respuesta = messagebox(g_titulo, 'Queda bajo su responsabilidad que el importe de IRPF que est$$HEX2$$e1002000$$ENDHEX$$cambiando se corresponda con el % IRPF vigente.$$HEX1$$bf00$$ENDHEX$$Desea Continuar con el cambio?', Question!,YesNo!)
		if respuesta = 1 then
			real bi,iva,irpf,total,t_irpf
			
			bi = this.GetItemNumber(this.getRow(),'base_imp')
			iva = this.GetItemNumber(this.getRow(),'iva')
			irpf = f_redondea(double(data))
			
			if isnull(bi) then bi=0
			if isnull(iva) then iva=0
			if isnull(t_irpf) then irpf=0
			
			total = bi + iva - irpf
			
			this.SetItem(this.GetRow(),'total',f_redondea(total))	
			///*** CBI-177. Se comprueba que hayan lineas en los cobros si no salta un error. Alexis. 22/06/2010 ***///
			if idw_femitidas_cobros.RowCount() > 0 then
				//A$$HEX1$$f100$$ENDHEX$$adido Jesus 08/03/2010 ICTL-291
				if (f_redondea(idw_femitidas_cobros.GetItemnumber(idw_femitidas_cobros.RowCount(), 'importe')) <> f_redondea(total)) then
					messagebox(g_titulo,'Ha cambiado el total de la factura y no coincide con el importe del cobro. Deber$$HEX1$$ed00$$ENDHEX$$a cambiar el importe del cobro si lo cree conveniente.')
				end if
			else 
				messagebox(g_titulo,'No existen datos relativos al cobro. Deber$$HEX1$$ed00$$ENDHEX$$a seleccionar una forma de pago.')
			end if	
		end if
		
		
	case 'formadepago'
		tab_1.tabpage_1.dw_femitidas_conceptos.AcceptText()
		// Modificado Ricardo 04-07-19
		string tipo_pago, banco
		tipo_pago = string(data)
		
		/// SCP-1861. Se comenta para sacar el c$$HEX1$$f300$$ENDHEX$$digo de la versi$$HEX1$$f300$$ENDHEX$$n del trunck 5.03.05
//		if this.getitemstring(row,'formadepago')='CM' then 
//			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "La factura pertenece a un cobro compuesto, Para modificar la forma de pago hazlo desde el modulo del cobro compuesto. ")
//			 this.setitem(row,"formadepago", 'CM')
//			return 2
//		end if
//		
//		if tipo_pago='CM' then 			
//			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "Para a$$HEX1$$f100$$ENDHEX$$adir la factura a un cobro compuesto, hazlo desde el m$$HEX1$$f300$$ENDHEX$$dulo de cobros compuestos.. ")
//			 this.setitem(row,"formadepago",this.getitemstring(row,'formadepago'))
//			return 2
//		end if
		
		if tipo_pago='CA' and this.GetItemString(this.getrow(),'tipo_factura')='04' then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "Una minuta no puede cobrarse por cuenta personal")
			return 2
		end if
		
		// Se valida que si es tarragona se verifique que el colegiado tenga activo el campo de rebut bancario
		if g_colegio = 'COAATTGN' then
			if g_forma_pago_por_defecto ='DB'  and not isnull(this.getitemstring(row, 'colegiado')) then
				if f_dame_otros_conceptos_colegiado(this.getitemstring(row, 'colegiado'), '04') = 'N' then
					tipo_pago ='TR'
				end if
			end if
			
		end if
	
		ls_formapago = this.getitemstring(row,"formadepago")
		
	
		if ls_formapago ='CM' then
			if   Messagebox(g_titulo,'Se cambiar$$HEX2$$e1002000$$ENDHEX$$la Forma de Pago. Est$$HEX2$$e1002000$$ENDHEX$$Seguro....?',Question!, YesNo!)= 1 then
				ib_cambio = true
				ls_nva_formapago = data
				ldb_total_factura = this.getitemnumber(row,"total")
				if idw_femitidas_cobros_mult.rowcount() > 0 then
					ls_id_cobro_multiple = idw_femitidas_cobros_mult.getitemstring(idw_femitidas_cobros_mult.getrow(),"id_cobro_multiple")
					ls_id_pago = idw_femitidas_cobros_mult.getitemstring(idw_femitidas_cobros_mult.getrow(),"id_pago")
					ls_id_factura = idw_femitidas_cobros_mult.getitemstring(idw_femitidas_cobros_mult.getrow(),"id_factura")
					ldb_total_actual_cobro = idw_femitidas_cobros_mult.getitemnumber(idw_femitidas_cobros_mult.getrow(),"csi_cobros_multiples_importe")
					wf_actualiza_cobros(ls_id_pago, ls_id_factura, ls_nva_formapago,ldb_total_factura, ls_id_cobro_multiple, ldb_total_actual_cobro)
				else
					ib_cambio = false
					 Messagebox(g_titulo,'No existen datos del Cobro Compuesto',Information!)
					 this.setitem(row,"formadepago", 'CM')
					 return 2
				end if
			else
				ib_cambio = false			
			end if
		end if
			

		SELECT csi_formas_de_pago.banco_asociado  
		INTO :banco  
		FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		
		// Si la forma de pago es TR o DB y el banco es vac$$HEX1$$ed00$$ENDHEX$$o que lo ponga sino no
		string banco_pago
		banco_pago = this.GetItemString(row,'banco')
		
//		if tipo_pago = g_formas_pago.domiciliacion or tipo_pago = g_formas_pago.transferencia then
//			if f_es_vacio(banco_pago) then	
//				IF NOT f_es_vacio(banco) then this.setitem(row, 'banco', banco)
//			end if
//		else
		// Si no es TR o DB que ponga el banco pero que avise
			if not f_es_vacio(banco_pago) and banco <> banco_pago then messagebox(g_titulo, "Se va a cambiar el banco")
			IF NOT f_es_vacio(banco) then this.setitem(row, 'banco', banco)
		//end if
		
		if dw_1.getitemstring(1, 'proforma') <> 'S' then
			this.PostEvent('ctav_generar_pagos')
			idw_femitidas_cobros.PostEvent('csd_actualizar_cobros')
		end if	
			
		if  ib_cambio then //se cambi$$HEX2$$f3002000$$ENDHEX$$la forma de pago de la factura
			if   data = 'CM' then 
				tab_1.tabpage_6.visible= true
				tab_1.tabpage_3.visible= false
			else
				tab_1.tabpage_3.visible= true
				tab_1.tabpage_6.visible= false
			end if
			dw_1.event csd_retrieve()
		end if

		
	case 'contabilizada'
		//Cambio Luis CGN-460
		if(data = 'N')then
			MessageBox(g_titulo,'Recuerde que cambiar la factura a no contabilizada, puede afectar a la correcta contabilizaci$$HEX1$$f300$$ENDHEX$$n de este documento') 
		end if
		//fin cambio
		if this.GetItemString(row,'contabilizada')<>'S' then
			this.SetItem(row,'f_conta',datetime(Today()))
		end if
	case 'pagado'
		if this.GetItemString(row,'pagado')<>'S' then
			this.SetItem(row,'f_pago',datetime(Today()))
		end if	
	case 'n_col'
		if this.GetItemString(row,'tipo_factura')= g_colegio_colegiado then
			select id_colegiado into :id_persona from colegiados where n_colegiado = :data;
			this.SetItem(row,'id_persona',id_persona)
			this.SetItem(row,'nif',f_devuelve_nif(id_persona))
			this.SetItem(row,'nombre',f_colegiado_apellido(id_persona))
			this.SetItem(row,'domicilio',f_domicilio_fiscal(id_persona))
			this.SetItem(row,'domicilio_largo',f_domicilio_fiscal(id_persona))
			this.SetItem(row,'poblacion',f_poblacion_fiscal(id_persona))
			this.SetItem(row,'cuenta',f_devuelve_cuenta(id_persona))
			if f_colegiado_es_moroso(id_persona) then MessageBox(g_titulo,g_idioma.of_getmsg('factura_e.colegiado_moroso','El colegiado seleccionado es moroso'),Exclamation!, OK!,1)	
		end if
		if this.GetItemString(row,'tipo_factura')= g_colegio_cliente then	
			select id_cliente into :id_persona from clientes where n_cliente = :data;
			this.SetItem(row,'id_persona',id_persona)
			//this.SetItem(row,'n_col',f_clientes_n_cliente(id_persona))
			this.SetItem(row,'nif',f_dame_nif(id_persona))
			this.SetItem(row,'nombre',f_dame_cliente(id_persona))
			this.SetItem(row,'domicilio',f_dame_domicilio(id_persona))
			this.SetItem(row,'domicilio_largo',f_dame_domicilio(id_persona))
			this.SetItem(row,'poblacion',f_retorna_poblacion(id_persona))
		end if
		
	case 'banco'
		idw_femitidas_cobros.PostEvent('csd_actualizar_cobros')
		
   // Modificado Ricardo 03-12-12
   case 'nif'
		string nif, tipo_factura
     	long num_clientes, num_colegiados
      st_ficha_cliente datos_cliente
      // Miramos si est$$HEX2$$e1002000$$ENDHEX$$puesto el tipo de factura, sino es tonteria que tecleen el nif
      tipo_factura = this.getitemString(row, 'tipo_factura')
      if f_es_vacio(tipo_Factura) then
         MessageBox(g_titulo, "Debe indicar primero el tipo factura")
         return 2
      end if
      CHOOSE CASE LenA(data)
      	CASE 0
         	// Est$$HEX2$$e1002000$$ENDHEX$$vaciando
            this.SetItem(row,'id_persona','')
            this.SetItem(row,'n_col','')
            this.SetItem(row,'nif','')
            this.SetItem(row,'nombre','')
            this.SetItem(row,'domicilio','')
            this.SetItem(row,'domicilio_largo','')				
            this.SetItem(row,'poblacion','')
            this.SetItem(row,'cuenta','')
         CASE 9
         	// El nif est$$HEX2$$e1002000$$ENDHEX$$completo
            if RightA(data, 1) = '*' then
               nif = f_calculo_nif(data)
            	// Si ha fallado el calculo del nif salimos
               if nif = '-1' then return -1
            else
               nif = data
            end if
                             
				// En cualquier otro caso lanzamos la ventana de busqueda
				choose case tipo_factura
					case '03' // Colegiado
						select count(*) into :num_colegiados from colegiados where nif=:nif;
						if num_colegiados > 0 then  
							if num_colegiados = 1 then
								// Obtenemos el di_colegiado
								id_persona = f_devuelve_id_col_de_nif(nif)
							else
								// Existe m$$HEX1$$e100$$ENDHEX$$s de un colegiado, no se que hacer
								// g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
								// g_busqueda.dw="d_lista_busqueda_colegiados"
								// id_persona=f_busqueda_colegiados()
							end if
						else
							// No existe el coegiado, no hacemos nada
							MessageBox(g_titulo, "Nif de colegiado no valido")
						end if
					case else // cliente
						select count(*) into :num_clientes from clientes where nif=:nif;
						if num_clientes > 0 then  
							if num_clientes = 1 then
								// obtenemos el id_cliente y calculamos todos los datos
								id_persona = f_cliente_id_cliente(nif)
							else
								g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
								g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
								id_persona=f_busqueda_clientes(nif)
							end if
						else
							// No existe el cliente
							if MessageBox(g_titulo,'Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?',Question!,YesNo!,1)=1 then
								//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
								datos_cliente.nif=nif
								datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
								OpenWithParm(w_fases_ficha_cliente,datos_cliente)
								id_persona = Message.StringParm
							end if
						end if
				end choose
		CASE ELSE
        	nif = data
         // En cualquier otro caso lanzamos la ventana de busqueda
         choose case tipo_factura
          	case '03' // Colegiado
					// g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
					// g_busqueda.dw="d_lista_busqueda_colegiados"
					// id_persona=f_busqueda_colegiados()
					MessageBox(g_titulo, "Nif de colegiado no valido")
            case else // cliente
				g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
             		g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
				id_persona=f_busqueda_clientes(nif)
            end choose
		END CHOOSE
                
      // llegados a este punto debemos tener un id_persona
      if not f_es_vacio(id_persona) then
       	// Colcoamos 
         this.SetItem(row,'id_persona',id_persona)
			choose case tipo_factura
				case '03' // Colegiado
		    			this.SetItem(row,'n_col',f_colegiado_n_col(id_persona))
				   	this.post SetItem(row,'nif',f_devuelve_nif(id_persona))
					this.SetItem(row,'nombre',f_colegiado_apellido(id_persona))
					this.SetItem(row,'domicilio',f_domicilio_fiscal(id_persona))
					this.SetItem(row,'domicilio_largo',f_domicilio_fiscal(id_persona))					
					this.SetItem(row,'poblacion',f_poblacion_fiscal(id_persona))
					this.SetItem(row,'cuenta',f_devuelve_cuenta(id_persona))
					if f_colegiado_es_moroso(id_persona) then MessageBox(g_titulo,g_idioma.of_getmsg('factura_e.colegiado_moroso','El colegiado seleccionado es moroso'),Exclamation!, OK!,1)	
				case else // cliente
					this.SetItem(row,'n_col',f_clientes_n_cliente(id_persona))
					this.post SetItem(row,'nif',f_dame_nif(id_persona))
					this.SetItem(row,'nombre',f_dame_cliente(id_persona))
					this.SetItem(row,'domicilio',f_dame_domicilio(id_persona))
					this.SetItem(row,'domicilio_largo',f_dame_domicilio(id_persona))					
					this.SetItem(row,'poblacion',f_retorna_poblacion(id_persona))
			end choose
		end if       
		// FIN Modificado Ricardo 03-12-12
	case 'nif_pagador'
		string nif_pagador, id_cliente_pagador
		nif_pagador = data
		if f_es_vacio(nif_pagador) then 
			this.SetItem(1,'id_cliente_pagador','')
	  		this.SetItem(1,'nif_pagador','')
			this.SetItem(1,'nombre_pagador','')
			this.SetItem(1,'domicilio_pagador','')
			this.SetItem(1,'domicilio_pagador_largo','')			
			this.SetItem(1,'poblacion_pagador','')	
		elseif LenA(nif_pagador) < 9 then
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
			g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
			id_cliente_pagador=f_busqueda_clientes(nif_pagador)
		else
				select count(*) into :num_clientes from clientes where nif=:nif_pagador;
				if num_clientes > 0 then  
					if num_clientes = 1 then
						// obtenemos el id_cliente y calculamos todos los datos
						id_cliente_pagador = f_cliente_id_cliente(nif_pagador)
					else
						g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
						g_busqueda.dw="d_lista_busqueda_clientes_cta_contable"               
						id_cliente_pagador=f_busqueda_clientes(nif_pagador)
					end if
				else
					// No existe el cliente
					if MessageBox(g_titulo,'Este cliente NO existe, $$HEX1$$bf00$$ENDHEX$$Desea darlo de alta?',Question!,YesNo!,1)=1 then
						//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana 
						datos_cliente.nif=nif_pagador
						datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
						OpenWithParm(w_fases_ficha_cliente,datos_cliente)
						id_cliente_pagador = Message.StringParm						
					end if
				end if
		end if
		if not f_es_vacio(id_cliente_pagador) then
			this.SetItem(1,'id_cliente_pagador',id_cliente_pagador)
	      	this.post SetItem(1,'nif_pagador',f_dame_nif(id_cliente_pagador))
			this.SetItem(1,'nombre_pagador',f_dame_cliente(id_cliente_pagador))
			this.SetItem(1,'domicilio_pagador',f_dame_domicilio(id_cliente_pagador))
			this.SetItem(1,'domicilio_pagador_largo',f_dame_domicilio(id_cliente_pagador))			
			this.SetItem(1,'poblacion_pagador',f_retorna_poblacion(id_cliente_pagador))			
		end if
		
	case 'solo_pagos'
		// MODIFICADO RICARDO 2005-03-02
		IF data = 'S' then
			if messagebox(g_titulo, 'Est$$HEX2$$e1002000$$ENDHEX$$marcando esta factura como "S$$HEX1$$f300$$ENDHEX$$lo Pago", $$HEX1$$bf00$$ENDHEX$$Desea continuar?', Question!,YesNo!) <> 1 then return 2
			this.SetItem(1,'contabilizada','S')
		ELSE
			// Si pasa a No, preguntamos si quiere actualizar el valor del campo contabilizado a 'N'
			if MessageBox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea tambi$$HEX1$$e900$$ENDHEX$$n dejar la factura no contabilizada? (Recuerde que cambiar el valor puede afectar a la correcta contabilizaci$$HEX1$$f300$$ENDHEX$$n de este documento)',Exclamation!,YesNo!) = 1 then 
				this.SetItem(1,'contabilizada','N')
			end if
		END IF
		// FIN MODIFICADO RICARDO 2005-03-02
		
	case 'proyecto'
		int i
		if idw_femitidas_conceptos.rowcount() > 0 then
			for i = 1 to idw_femitidas_conceptos.rowcount()
				idw_femitidas_conceptos.setitem(i,'proyecto', data)
			next
		end if
		
	case 'paga_empresa' // SCP-1160 Asignamos el mismo valor al campo paga_externo
		this.SetItem(row,'paga_externo',data)
	
end choose

end event

event dw_1::buttonclicked;call super::buttonclicked;// Lanzamos la func. que sirve para las ventanas de detalle, consulta, listado
this.accepttext()
f_btn_busqueda_facturas(this, dwo.name, row) 
end event

event dw_1::retrieveend;call super::retrieveend;// Habilitamos el btn de busqueda correspondiente
f_habilita_btn_busqueda_tipo_factura (this)

i_centro = this.getitemstring(1, 'centro')
i_proyecto = this.getitemstring(1, 'proyecto')
if isnull(i_centro) then i_centro = ''
if isnull(i_proyecto) then i_proyecto = ''

// Situamos el NIF del pagador externo
string id_cliente_pagador, nif_pagador
id_cliente_pagador = this.getitemstring(1, 'id_cliente_pagador')
if not f_es_vacio(id_cliente_pagador) then
	nif_pagador = f_dame_nif(id_cliente_pagador)
	if not f_es_vacio(nif_pagador) then
		this.setitem(1, 'nif_pagador', nif_pagador)
		this.setitemstatus(1, 'nif_pagador', Primary!, Notmodified!)
	end if
end if

// Recuperamos los datos de la fase
string id_fase, id_minuta, id_fase_real
// En el id_fase se guarda el id_minuta y viceversa
id_fase = dw_1.getitemstring(1, 'id_fase')
id_minuta = dw_1.getitemstring(1, 'id_minuta')

tab_1.tabpage_5.visible = true

if not f_es_vacio(id_fase) then
	select id_fase into :id_fase_real from fases_minutas where id_minuta = :id_fase;
	idw_datos_contrato.retrieve(id_fase_real)
elseif not f_es_vacio(id_minuta) then
	idw_datos_contrato.retrieve(id_minuta)
else
	tab_1.tabpage_5.visible = false
end if

// MODIFICADO RICARDO 2005-03-02
// Miramos si el check de solo a efectos de pago tiene valor inicial, para que no proteste
if f_es_vacio(this.GetItemString(rowcount, 'solo_pagos')) then
	this.SetItem(rowcount, 'solo_pagos', 'N')
	this.update()
end if
// FIN MODIFICADO RICARDO 2005-03-02

// Miramos si el check de otro pagador tiene valor inicial
if f_es_vacio(this.GetItemString(rowcount, 'otro_pagador')) then
	this.SetItem(rowcount, 'otro_pagador', 'N')
	this.update()
end if

// Miramos si el check de reclamar tiene valor inicial
if f_es_vacio(this.GetItemString(rowcount, 'reclamar')) then
	this.SetItem(rowcount, 'reclamar', 'S')
	this.update()
end if

// Mostramos el bot$$HEX1$$f300$$ENDHEX$$n de imprimir recibos de irpf
if (g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio = 'COAATNA' or g_colegio = 'COAATTER') and dw_1.getitemstring(1, 'tipo_factura') = '04' then cb_recibo_irpf.visible = true

//Modificado Luis CGN-460
if dw_1.object.contabilizada.tabsequence = '0' then
	// Permitir que puedan modificar el check de contabilizada y la fecha de contabilizacion
	dw_1.object.contabilizada.tabsequence = '500'
	dw_1.object.f_conta.tabsequence = '501'
	idw_femitidas_cobros.object.contabilizado.tabsequence = '500'
	idw_femitidas_cobros.object.f_contabilizado.tabsequence ='501'
end if
//fin modificado

///*** SCP-662. ALEXIS. Se protege los campos de pagado para que no se modifiquen manualmente. 
if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
	tab_1.tabpage_7.visible= false
//int li_i
//	dw_1.object.pagado.protect = 1
//	dw_1.object.f_pago.protect = 1
//	dw_1.object.contabilizada.protect = 1
//	dw_1.object.f_conta.protect = 1
else 
	idw_historico_proformas.retrieve(dw_1.getitemstring(1,'id_factura'))
	
	if idw_historico_proformas.rowcount() < 1 then
		tab_1.tabpage_7.visible= false
	else
		tab_1.tabpage_7.visible= true
	end if	
	
end if	
//idw_femitidas_cobros.postevent ('csd_configura')
//idw_femitidas_cobros_mult.postevent ('csd_configura')

///*** SCP-2431 ***\\\
string ls_firmada
ls_firmada = this.getitemstring(this.getrow(), 'firmado') 
if f_es_vacio(ls_firmada) then this.setitem(this.getrow(), 'firmado', 'N') 

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'importe_reten'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose
end event

event dw_1::doubleclicked;call super::doubleclicked;string obser, coleg
CHOOSE CASE dwo.name
	CASE 'observaciones_text'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones_text')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then 
				dw_1.SetItem(row,'observaciones_text',obser)
			end if 	
		end if
	CASE 'colegiado'
		// MODIFICADO RICARDO 2005-03-17
		coleg = dw_1.getitemstring(row,'emisor')
		if f_es_vacio(coleg) then return
		g_colegiados_consulta.id_colegiado = coleg
		message.stringparm = "w_colegiados_detalle"
		w_aplic_frame.postevent("csd_colegiadosdetalle")
	CASE 'n_col'
		// MODIFICADO RICARDO 2005-03-17
		coleg = dw_1.getitemstring(row,'id_persona')
		if f_es_vacio(coleg) then return
		g_colegiados_consulta.id_colegiado = coleg
		message.stringparm = "w_colegiados_detalle"
		w_aplic_frame.postevent("csd_colegiadosdetalle")
		//N_registro
	CASE 'compute_1'
		string ls_n_registro,ls_id_fase
		ls_n_registro=getitemstring(1,'compute_1')
		select id_fase into :ls_id_fase from fases where n_registro=:ls_n_registro;
		if f_es_vacio(ls_id_fase) then return
		g_fases_consulta.id_fase = ls_id_fase
		g_fase_visared.opcion_importacion = 'N'
		message.stringparm = "w_fases_detalle"
		w_aplic_frame.postevent("csd_fasesdetalle")
END CHOOSE

end event

event dw_1::csd_tecla;call super::csd_tecla;wf_key_pressed(key, keyflags)
end event

event dw_1::constructor;call super::constructor;this.getchild('formadepago', idwc_forma_pago)
idwc_forma_pago.settransobject(SQLCA)


end event

type tab_1 from tab within w_facturacion_emitida_detalle
integer x = 9
integer y = 1416
integer width = 3360
integer height = 688
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_6 tabpage_6
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_9 tabpage_9
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_6=create tabpage_6
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_9=create tabpage_9
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_6,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_9,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_6)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_9)
destroy(this.tabpage_7)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Conceptos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom082!"
long picturemaskcolor = 12632256
dw_femitidas_conceptos dw_femitidas_conceptos
end type

on tabpage_1.create
this.dw_femitidas_conceptos=create dw_femitidas_conceptos
this.Control[]={this.dw_femitidas_conceptos}
end on

on tabpage_1.destroy
destroy(this.dw_femitidas_conceptos)
end on

type dw_femitidas_conceptos from u_dw within tabpage_1
event recalcular_importe ( )
event rellenar_linea_concepto ( )
event actualizar_datos_premaat ( )
integer x = 9
integer y = 8
integer width = 3305
integer height = 552
integer taborder = 11
string dataobject = "d_lineas_fact_emitidas"
end type

event recalcular_importe();double precio, importe,uds, subtotal, subtotal_dto, subtotal_iva, total, total_importe, total_dto, total_iva
double base_imp, porcen_dto, dto_unit
string t_iva
long i

total_importe=0
total_dto=0 
total_iva=0

if this.RowCount() =  0 then return
	

//if message.stringparm <> 'subtotal' then this.setitem(this.getrow(),'subtotal', precio * unidades)
	
For i= 1 to this.rowcount()
	uds			= this.getitemnumber(i,'unidades')
	precio		= this.getitemnumber(i,'precio')
	this.SetItem(i,'subtotal',uds*precio)
	
	t_iva			= this.getitemstring(i,'t_iva')
	porcen_dto    = this.getitemnumber(i,'porcent_dto')
	if isnull(porcen_dto) then porcen_dto=0
	
	subtotal 		= this.getitemnumber(i,'subtotal')
	// Aplicamos el descuento al precio unitario y multiplicamos por las unidades
//	subtotal_dto 	= subtotal*porcen_dto/100
	dto_unit 		= f_redondea(precio * porcen_dto/100)
	subtotal_dto 	= dto_unit * uds
	// El IVA se calcula despues de descuento
//	subtotal_iva 	= f_redondea(f_aplica_t_iva(subtotal - subtotal_dto,t_iva))
	// INC. 7346 El IVa se calcula aplicando sobre la b.i. unitaria y multiplicando por las unidades
	if g_calculo_iva_fact = 'S' then
		subtotal_iva 	= f_redondea(f_aplica_t_iva(precio - dto_unit,t_iva)*uds)
	else	
		subtotal_iva 	= f_redondea(f_aplica_t_iva(subtotal - subtotal_dto,t_iva))
	end if
	
	if IsNull(subtotal) then subtotal = 0
	if isnull(uds) then uds=1
	if IsNull(subtotal_dto) then subtotal_dto = 0
	if IsNull(subtotal_iva) then subtotal_iva = 0
	
	// Si tiene permiso para modificar el campo importe Iva entonces 
	if not i_modificar_iva then 
		this.SetItem(i,'subtotal_iva',subtotal_iva)
	else
		subtotal_iva = this.getitemnumber(i, 'subtotal_iva')
	end if
	this.SetItem(i,'importe_dto',subtotal_dto)
	total = subtotal - subtotal_dto + subtotal_iva
	this.SetItem(i, 'total', f_redondea(total))
		
	total_importe += subtotal
	total_dto += subtotal_dto		
	total_iva += subtotal_iva
	idw_femitidas_cobros.TriggerEvent('csd_actualizar_cobros')	
Next
	
base_imp = total_importe - total_dto
dw_1.setitem(dw_1.getrow(),'subtotal', f_redondea(total_importe))
dw_1.setitem(dw_1.getrow(),'descuento', f_redondea(total_dto))	
dw_1.setitem(dw_1.getrow(),'base_imp', f_redondea(base_imp))
dw_1.setitem(dw_1.getrow(),'iva', f_redondea(total_iva) )

//	dw_1.Postevent("recalcular_importe")
	

dw_1.Postevent('calcula_total')
	

end event

event rellenar_linea_concepto();string t_iva,codigo,descripcion
double subtotal,importe_iva

codigo = this.GetitemString(this.GetRow(),'articulo')

	SELECT t_iva,importe,descripcion  
    INTO :t_iva,:subtotal,:descripcion
    FROM csi_articulos_servicios  
   WHERE csi_articulos_servicios.codigo = :codigo and csi_articulos_servicios.colegio = :g_colegio and empresa=:g_empresa ;
	
this.SetItem(this.GetRow(),'descripcion',descripcion)
this.SetItem(this.GetRow(),'descripcion_larga',descripcion)
//if this.getitemnumber(this.getrow(), 'precio') = 0 then 
this.SetItem(this.GetRow(),'precio',subtotal)
if this.getitemnumber(this.getrow(), 'subtotal') = 0 then this.SetItem(this.GetRow(),'subtotal',subtotal)
if this.getitemnumber(this.getrow(), 'unidades') = 0 then this.SetItem(this.GetRow(),'unidades',1)
if this.getitemnumber(this.getrow(), 'porcent_dto') = 0 then this.SetItem(this.GetRow(),'porcent_dto',0)
if this.getitemnumber(this.getrow(), 'importe_dto') = 0 then this.SetItem(this.GetRow(),'importe_dto',0)
this.SetItem(this.GetRow(),'t_iva',t_iva)


this.SetItem(this.GetRow(),'subtotal_iva',f_redondea(f_aplica_t_iva(subtotal,t_iva)))

// MODIFICADO RICARDO 2005-03-01
CHOOSE CASE g_colegio
	CASE 'COAATZ', 'COAATGU', 'COAATLR', 'COAATLE', 'COAATAVI'
		// Si es el codigo de musaat, visualizamos el bot$$HEX1$$f300$$ENDHEX$$n
		if codigo = g_codigos_conceptos.musaat_variable and f_es_vacio(idw_femitidas_conceptos.getitemString(this.GetRow(), 'id_recibo')) then
			cb_generar_numero_recibo_musaat.visible = true
		end if
		// MODIFICADO RICARDO 2005-03-01
END CHOOSE
	
this.PostEvent('recalcular_importe')

end event

event actualizar_datos_premaat();string ls_cod_articulo, ls_id_linea
int i
double ldb_ips, ldb_ccs
boolean	lb_insertar, lb_eliminar

lb_insertar = true
lb_eliminar = false


ls_cod_articulo = this.getitemstring(this.getrow(), 'articulo');
ls_id_linea = this.getitemstring(this.getrow(), 'id_linea');


f_obtener_datos_premaat_fact_emi(ldb_ips, ldb_ccs, ls_cod_articulo, g_empresa, dw_1.getitemstring(dw_1.getrow(), 'id_persona'))
		
if (ldb_ips > 0 or ldb_ccs > 0) then

	for i=1 to dw_3.rowcount()
		
		if ls_id_linea = dw_3.getitemstring(i, 'id_linea') then
		 	lb_insertar = false
			 dw_3.setitem(i, 'ips', ldb_ips)
 			 dw_3.setitem(i, 'ccs', ldb_ccs)
			  exit
		end if		 
	
	next 

	if lb_insertar then
		i= dw_3.insertrow(0)
		dw_3.setitem( i, 'id_linea', ls_id_linea)
		dw_3.setitem( i, 'ips', ldb_ips)
		dw_3.setitem( i, 'ccs', ldb_ccs)
	end if
		

else 

	for i=1 to dw_3.rowcount()
		if ls_id_linea = dw_3.getitemstring(i, 'id_linea') then
			lb_eliminar = true
			exit
		end if		 
	next 
	
	if lb_eliminar then dw_3.deleterow(i)

	
end if


end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_factura'), this, Upper(Parent.text), dwo.name, row)

CHOOSE CASE dwo.name 
	CASE 'precio', 'importe_dto', 'subtotal','subtotal_iva','t_iva','porcent_dto','unidades'
		message.stringparm= string(dwo.name)
		this.postevent("recalcular_importe")
		//Se notifica que se realiza cambios en el total de cobros
		if idw_femitidas_cobros.rowcount() = 1 then
			messagebox(g_titulo,"Se actualizar$$HEX2$$e1002000$$ENDHEX$$el importe total del cobro")
			tab_1.SelectTab(3)
		end if

	CASE 'articulo'
		This.PostEvent("rellenar_linea_concepto")
		This.PostEvent("actualizar_datos_premaat")
		
END CHOOSE

end event

event pfc_addrow;call super::pfc_addrow;string id, id_factura
datetime fecha_factura



fecha_factura = dw_1.GetItemDatetime(1, 'fecha')
if isnull(fecha_factura) then fecha_factura= datetime(Today())
id = f_siguiente_numero('LINEA_FEMI',10)

//this.SetItem(this.RowCount(),'id_factura', id_factura)
this.SetItem(this.RowCount(),'id_linea', id)
this.SetItem(this.GetRow(),'centro',i_centro)
this.SetItem(this.GetRow(),'proyecto',i_proyecto)
this.SetItem(this.GetRow(),'fecha',fecha_factura)
// Incidencia 3301
this.SetItem(this.GetRow(),'id_fase',dw_1.getitemstring(1,'id_fase'))

//this.SetItem(this.RowCount(),'t_iva', f_dame_t_iva_por_defecto( ) )
//this.SetItem(this.RowCount(),'porcent_dto', 0 )

// centro y la explotacion
//this.Setitem(this.RowCount(),"centro",g_centro_por_defecto)
//this.Setitem(this.RowCount(),"proyecto",g_explotacion_por_defecto)

return this.RowCount()
end event

event pfc_deleterow;call super::pfc_deleterow;this.postevent("recalcular_importe")

return 1 //pfc_deleterow devuelve 1 si ha podido borrar la l$$HEX1$$ed00$$ENDHEX$$nea
end event

event pfc_insertrow;call super::pfc_insertrow;string id, id_factura
integer fila
datetime fecha_factura


fecha_factura = dw_1.GetItemDatetime(1, 'fecha')
if isnull(fecha_factura) then fecha_factura= datetime(Today())

// En este dw no est$$HEX2$$e1002000$$ENDHEX$$funcionando bien el GetRow(), cambia el foco a la siguiente l$$HEX1$$ed00$$ENDHEX$$nea y 
// no hace bien los setitem con GetRow
fila = ancestorreturnvalue

//id_factura = dw_1.GetItemString(1, 'id_factura')
id = f_siguiente_numero('LINEA_FEMI',10)

//this.SetItem(fila,'id_factura', id_factura)
this.SetItem(fila,'id_linea', id)
this.SetItem(this.GetRow(),'centro',i_centro)
this.SetItem(this.GetRow(),'proyecto',i_proyecto)
this.SetItem(this.GetRow(),'fecha',fecha_factura)
// Incidencia 3301
this.SetItem(this.GetRow(),'id_fase',dw_1.getitemstring(1,'id_fase'))

//this.SetItem(fila,'t_iva', f_dame_t_iva_por_defecto( ) )
//this.SetItem(fila,'porcent_dto', 0 )

// centro y la explotacion
//this.Setitem(fila,"centro",g_centro_por_defecto)
//this.Setitem(fila,"proyecto",g_explotacion_por_defecto)
//
return fila

end event

event itemfocuschanged;call super::itemfocuschanged;choose case dwo.name
	case 'unidades'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
	case 'porcent_dto', 'porcent_irpf'
		this.SelectText(1, LenA(string(double(this.GetText()),"##0.00")))
	case 'precio', 'subtotal', 'importe_dto', 'subtotal_iva', 'importe_irpf'
		this.SelectText(1, LenA(string(double(this.GetText()),"###,###,##0.00")))		
end choose
end event

event constructor;call super::constructor;// MODIFICADO RICARDO 2004-11-16
// Para el usuario csd mostramos el check del irpf
CHOOSE CASE g_colegio
	CASE 'COAATB'
		if g_usuario = '0000000001' then 
			this.modify("aplica_irpf_colegio.visible = '1'")
			this.modify("aplica_irpf_colegio_t.visible = '1'")
		end if
END CHOOSE
// fin MODIFICADO RICARDO 2004-11-16
end event

event retrieveend;call super::retrieveend;// MODIFICADO RICARDO 2004-11-16
// actualizamos para el colegio de bizkaia el check de irpf 
long fila,fila_musaat = -1

CHOOSE CASE g_colegio
	CASE 'COAATB'
		IF lower(this.describe("aplica_irpf_colegio.name")) = 'aplica_irpf_colegio' THEN
			for fila = 1 to rowcount
				if f_es_vacio(this.getitemstring(fila, "aplica_irpf_colegio")) then this.setitem(fila, "aplica_irpf_colegio", 'N')
			next
			// Grabamos directamente pq no se ha podido modificar todavia
			this.update()
		END IF
	CASE 'COAATZ', 'COAATGU', 'COAATLR', 'COAATLE', 'COAATAVI'
		// Inicializamos el check a N por una parte y por otra buscamos si hay concepto de musaat variable sin n_recibo
		for fila = 1 to rowcount
			if f_es_vacio(this.getitemstring(fila, "aplica_irpf_colegio")) then this.setitem(fila, "aplica_irpf_colegio", 'N')
			if idw_femitidas_conceptos.getitemString(fila, 'articulo') = g_codigos_conceptos.musaat_variable and f_es_vacio(idw_femitidas_conceptos.getitemString(fila, 'id_recibo')) then
				fila_musaat = fila
			end if
		next
		// Grabamos directamente pq no se ha podido modificar todavia
		this.update()
		// MODIFICADO RICARDO 2005-03-01
		// Cuando recuperan no dejamos ver el bot$$HEX1$$f300$$ENDHEX$$n
		if fila_musaat>0 then
			cb_generar_numero_recibo_musaat.enabled = true
			cb_generar_numero_recibo_musaat.visible = true
		else
			cb_generar_numero_recibo_musaat.visible = false
		end if
		// MODIFICADO RICARDO 2005-03-01
	CASE ELSE
		// PAra el resto de colegios lo inicializamos si no tiene valor a 'N'
		for fila = 1 to rowcount
			if f_es_vacio(this.getitemstring(fila, "aplica_irpf_colegio")) then this.setitem(fila, "aplica_irpf_colegio", 'N')
		next
		// Grabamos directamente pq no se ha podido modificar todavia
		this.update()
END CHOOSE
// fin MODIFICADO RICARDO 2004-11-16

end event

event csd_tecla;call super::csd_tecla;wf_key_pressed(key, keyflags)
if keydown(keycontrol!) and keydown(keyI!) and this.getcolumnname() = 'subtotal_iva' then i_modificar_iva = true
end event

event pfc_predeleterow;call super::pfc_predeleterow;	int i
	string ls_id_linea
	boolean lb_delete
	lb_delete = false
	
	ls_id_linea = this.getitemstring(this.getrow(), 'id_linea');
	
	for i=1 to dw_3.rowcount()
		if ls_id_linea = dw_3.getitemstring(i, 'id_linea') then
			lb_delete = true
			exit
		end if		 
	next 
	
	if lb_delete then dw_3.deleterow(i)
	
	return ancestorReturnValue

end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Clasificaci$$HEX1$$f300$$ENDHEX$$n Contable"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "EditDataFreeform!"
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Cobros"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom048!"
long picturemaskcolor = 12632256
dw_femitidas_cobros dw_femitidas_cobros
end type

on tabpage_3.create
this.dw_femitidas_cobros=create dw_femitidas_cobros
this.Control[]={this.dw_femitidas_cobros}
end on

on tabpage_3.destroy
destroy(this.dw_femitidas_cobros)
end on

type dw_femitidas_cobros from u_dw within tabpage_3
event cuenta_contable ( )
event f_pago ( )
event f_vencimiento ( )
event csd_actualizar_cobros ( )
event csd_contabilizar_cobros ( integer fila )
event csd_configura ( )
integer x = 9
integer y = 8
integer width = 3287
integer height = 540
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cobros_frecibidas"
boolean hscrollbar = true
end type

event cuenta_contable;string tipo_pago, banco, cuenta, cuenta_banco, mensaje
int fila

fila = Message.WordParm

tipo_pago = this.GetItemString(fila,'forma_pago')
banco = this.GetItemString(fila,'banco')
cuenta = this.GetItemString(fila,'cuenta')

// Si ha introducido una forma de pago, no ha puesto una cuenta =>
//			calculamos la cuenta para la l$$HEX1$$ed00$$ENDHEX$$nea de pago en func. de la forma de pago o del banco
if NOT f_es_vacio(tipo_pago) AND f_es_vacio(cuenta) then 
	cuenta = f_dame_campos_string_formadepago ( 'cuenta', tipo_pago )
	mensaje = f_validar_cuenta_mensaje (cuenta, fila, ' de la forma de pago ')

	// si la cta. contable para la forma de pago es v$$HEX1$$e100$$ENDHEX$$lida, la ponemos
	if f_es_vacio(mensaje) then 
		this.SetItem(fila, 'cuenta', cuenta)	
	else		
	// si la cta. contable para el banco es v$$HEX1$$e100$$ENDHEX$$lida, la ponemos
		cuenta_banco = f_dame_cuenta_contable_banco ( This.GetItemString(fila,'banco') )
		mensaje = f_validar_cuenta_mensaje (cuenta_banco, fila, ' del banco ')
		if f_es_vacio(mensaje) then this.SetItem(fila, 'cuenta', cuenta_banco)

	end if
	
end if
end event

event f_pago;int fila
fila = Message.WordParm
if this.GetItemString(fila,'pagado') = 'S' AND IsNull(this.GetItemDateTime(fila,'f_pago'))  then this.SetItem(fila,'f_pago',DateTime (Date(String(Today(),"dd/mm/yyyy"))))

end event

event f_vencimiento;string tipo_pago
int fila, num_dias
datetime fecha, f_vencimiento

fila = Message.WordParm

fecha = dw_1.GetItemDateTime(1,'fecha')

tipo_pago = this.GetItemString(fila,'forma_pago')
f_vencimiento = this.GetItemDateTime(fila,'f_vencimiento')

// Si ha introducido una forma de pago, no ha puesto fecha de venc. y hay una fecha para la cabecera de la fact. =>
//			calculamos la f_vencimiento para la l$$HEX1$$ed00$$ENDHEX$$nea de pago
If NOT (f_es_vacio(tipo_pago)) AND IsNull(f_vencimiento) AND NOT ISNull(fecha) then

	num_dias = f_dame_campos_integer_formadepago ( 'num_dias', tipo_pago )
	f_vencimiento = DateTime ( relativeDate(Date(fecha), num_dias)) 

	this.SetItem(fila, 'f_vencimiento', f_vencimiento)
	
end if
end event

event csd_actualizar_cobros;if this.getrow() <1  then return
if this.rowcount() >1  then return

//Cada vez que se modifiquen de la factura 1 de estos tres campos
//   ser$$HEX2$$e1002000$$ENDHEX$$llamado este evento...
this.SetItem(this.GetRow(),'f_vencimiento',dw_1.GetItemdatetime(1,'fecha'))
this.SetItem(this.GetRow(),'forma_pago',dw_1.GetItemString(1,'formadepago'))
this.SetItem(this.GetRow(),'banco',dw_1.GetItemString(1,'banco'))
this.SetItem(this.GetRow(),'importe',dw_1.GetItemNumber(1,'total'))


// Colocamos la fecha de vencimiento a ultimo de mes (del mes actual)
choose case g_colegio
	case 'COAATLR'
		if dw_1.GetItemString(dw_femitidas_cobros.getrow(),'formadepago') = 'DB' then
			this.SetItem(dw_femitidas_cobros.getrow(), 'f_vencimiento', f_ultimo_dia_mes(datetime(today())))
		end if
end choose

end event

event csd_contabilizar_cobros(integer fila);string mensaje='', estado, concepto_base, concepto, formadepago, id_colegiado, cuenta, ctabanco, contabilizada
string n_documento, id_cli, cuenta_presupuestaria, id_liquidacion, id_factura, pagado, centro, proyecto, banco
string pagado_factura, contabilizada_factura, forma_pago, forma_pago_factura, n_factura, tipo_factura, id_persona
string cuenta_cp, n_plazo
long cuantos
int continuar
datetime fecha
double importe, saldo = 0, saldo_deudor = 0


// Modificado Ricardo 04-03-15
//if not g_contabilidad_automatica then return

dw_2.SetTransObject(bd_ejercicio)
fila = this.GetRow()

if this.RowCount() =0 then 
	Messagebox(g_titulo, 'No hay Cobros que contabilizar')
	return
end if

//SCP-166 Verificamos que el ejercicio contable esta abierto
if NOT f_ejercicio_abierto(g_ejercicio) then
	Messagebox(g_titulo,'El ejercicio contable '+ g_ejercicio + ' no est$$HEX2$$e1002000$$ENDHEX$$abierto. No es posible continuar con el proceso de contabilizaci$$HEX1$$f300$$ENDHEX$$n.',stopsign!)
	return
end if

if isnull(g_num_digitos) or g_num_digitos > 10 or g_num_digitos < 6 then mensaje = mensaje + cr + "g_num_digitos"
if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"
if f_es_vacio(g_sica_diario.facts_emitidas_exp) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_exp"
if f_es_vacio(g_sica_diario.facts_emitidas_ot) then mensaje = mensaje + cr + "g_sica_diario.facts_emitidas_ot"
if f_es_vacio(g_t_asiento_apuntes_automaticos) then mensaje = mensaje + cr + "g_t_asiento_apuntes_automaticos"
if f_es_vacio(g_t_doc_recibos_sica) then mensaje = mensaje + cr + "g_t_doc_talon" 
if f_es_vacio(g_centro_por_defecto) then mensaje = mensaje + cr + "g_centro_por_defecto"

if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
if f_es_vacio(g_explotacion_por_defecto) then mensaje = mensaje + cr + "g_explotacion_por_defecto"

if f_es_vacio(g_conta.cuenta_clientes_general) then mensaje = mensaje + cr + "g_conta.cuenta_clientes_general"
if f_es_vacio(g_prefijo_arqui) then mensaje = mensaje + cr + "g_prefijo_arqui"

select count(*) into :cuantos from csi_bancos where cuenta_contable = null or cuenta_contable = '';
if cuantos > 0 then Messagebox(g_titulo,"Hay bancos sin la cuenta contable definida. Se producir$$HEX1$$e100$$ENDHEX$$n errores en el proceso.",Stopsign!)

if mensaje <> '' then
	mensaje = 'Hay que definir las siguientes variables para poder contabilizar:' + cr + mensaje
	messagebox(g_titulo,mensaje,Stopsign!)
	Messagebox(g_titulo,'De momento les pondremos valores por defecto, pero no se debe poner en marcha si se lee este mensaje!!!',Stopsign!)
	continuar = Messagebox(g_titulo,'$$HEX2$$bf002000$$ENDHEX$$Desea Continuar ? ',Question!, YesNo!)
	if continuar = 2 then return	
	
end if

// Modificado Ricardo 2005-04-27
// Si la fecha del cobro no es del ejercicio actual, salimos
if string(year(date(this.GetItemDateTime(fila,'f_pago'))))<>g_ejercicio then
	messagebox(g_titulo, "La fecha del cobro no pertenece al ejercicio actual abierto, por lo que no es posible contabilizar",stopsign!)
	return
end if
// Modificado Ricardo 2005-04-27

// Seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura lo tenemos que pasar hacia uno u otro diario
if f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_fase')) and f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_minuta')) then
	// ES una factura no relacionada con contratos
	i_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot,7))
else
	i_asiento = long(f_ver_siguiente_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp,7))
end if
i_asiento = i_asiento - 1
if isnull(i_asiento) then i_asiento = 0


fecha = this.GetItemDateTime(fila,'f_pago')
importe = this.GetItemNumber(fila,'importe')
id_factura = dw_1.GetItemString(1,'id_factura')
pagado = this.GetItemString(fila,'pagado')
contabilizada = this.GetItemString(fila,'contabilizado')
n_factura= dw_1.GetItemString(1,'n_fact')
formadepago = this.GetItemString(fila,'forma_pago')
banco = this.GetItemString(fila,'banco')
centro = this.GetItemString(fila,'centro')
proyecto = this.GetItemString(fila,'proyecto')
cuenta_presupuestaria	= this.GetItemString(fila,'cta_presupuestaria')
tipo_factura = dw_1.GetItemString(1,'tipo_factura')
id_persona = dw_1.GetItemString(1,'id_persona')
pagado_factura = dw_1.GetItemString(1,'pagado')
contabilizada_factura = dw_1.GetItemString(1,'contabilizada')
forma_pago = this.GetItemString(fila,'forma_pago')
forma_pago_factura = dw_1.GetItemString(1,'formadepago')

if pagado <> 'S' then 
	messagebox(g_titulo, 'Este cobro no se puede contabilizar pues no est$$HEX2$$e1002000$$ENDHEX$$pagado')
	return
end if
if contabilizada = 'S' then 
	messagebox(g_titulo, 'Este cobro est$$HEX2$$e1002000$$ENDHEX$$ya contabilizado')	
	return	
end if

// Modificado Ricardo 04-05-11
if contabilizada_factura <> 'S' then 
	messagebox(g_titulo, 'La factura no est$$HEX2$$e1002000$$ENDHEX$$contabilizada por lo que el cobro no puede contabilizarse individualmente')    
	return  
end if

// Si la forma de pago de pago es 'LI' marcamos el cobro como contabilizado pero no generamos apuntes
if forma_pago_factura = 'LI' or forma_pago = 'LI' THEN
	//Marcamos la liquidacion como contabilizada:
	this.SetItem(fila,'contabilizado','S')
	this.SetItem(fila,'f_contabilizado',fecha)
	return
END IF
// FIN Modificado Ricardo 04-05-11

// MODIFICADO RICARDO 2005-01-21
// Si la forma de pago de pago es 'OE' marcamos el cobro como contabilizado pero no generamos apuntes
if forma_pago_factura = g_formas_pago.otras_entidades or forma_pago = g_formas_pago.otras_entidades THEN
	//Marcamos la liquidacion como contabilizada:
	this.SetItem(fila,'contabilizado','S')
	this.SetItem(fila,'f_contabilizado',fecha)
	return
END IF
// FIN MODIFICADO RICARDO 2005-01-21

// Modificado Ricardo 04-09-13
// Si la forma de pago de pago es 'CA' marcamos el cobro como contabilizado pero no generamos apuntes
if forma_pago_factura = 'CA' or forma_pago = 'CA' THEN
	  //Marcamos la liquidacion como contabilizada:
	  this.SetItem(fila,'contabilizado','S')
	  this.SetItem(fila,'f_contabilizado',fecha)
	  return
END IF
// FIN Modificado Ricardo 04-09-13

// MODIFICADO RICARDO 2005-01-28
// Si la forma de pago de pago es 'AL' marcamos el cobro como contabilizado pero no generamos apuntes
if forma_pago_factura = 'AL' or forma_pago = 'AL' THEN
 //Marcamos la liquidacion como contabilizada:
 this.SetItem(fila,'contabilizado','S')
 this.SetItem(fila,'f_contabilizado',fecha)
 return
END IF
// FIN MODIFICADO RICARDO 2005-01-28

if f_es_vacio(n_factura) then n_factura = ''
if f_es_vacio(banco) then banco = g_banco_por_defecto
if f_es_vacio(proyecto) then n_factura = g_explotacion_por_defecto

concepto_base = 'Pago Fact N$$HEX2$$ba002000$$ENDHEX$$'+n_factura

// Si es un pago fraccionado indicamos el plazo correspondiente
n_plazo = this.GetItemString(fila,'n_plazo')
if not f_es_vacio(n_plazo) then concepto_base += ' (Plazo ' + n_plazo + '$$HEX1$$ba00$$ENDHEX$$)'

//Cogemos la Cta. del Banco de la Cuenta Contable del Banco que seleccionamos para la remesa
SELECT cuenta_contable INTO :ctabanco FROM csi_bancos WHERE codigo = :banco  and empresa=:g_empresa ;

//Rellenamos DATOS GENERALES DE G_APUNTE
i_asiento++
g_apunte.n_asiento = RightA('0000000' + trim(string(i_asiento)),7)
g_apunte.n_apunte = '00000'
g_apunte.n_doc = n_factura
g_apunte.fecha = datetime(date(fecha), time("00:00:00"))
g_apunte.t_asiento = g_t_asiento_apuntes_automaticos
g_apunte.id_interno = id_factura
// Seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura lo tenemos que pasar hacia uno u otro diario
if f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_fase')) and f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_minuta')) then
	// ES una factura no relacionada con contratos
	g_apunte.diario = g_sica_diario.facts_emitidas_ot
else
	g_apunte.diario = g_sica_diario.facts_emitidas_exp
end if
g_apunte.proyecto = proyecto
g_apunte.centro = centro
g_apunte.cta_presupuestaria = cuenta_presupuestaria	

choose case formadepago
	case g_formas_pago.transferencia
		g_apunte.t_doc = g_sica_t_doc.transferencia
	case g_formas_pago.talon
		g_apunte.t_doc = g_sica_t_doc.talon
	case else
		g_apunte.t_doc = g_sica_t_doc.generico
end choose

//Seg$$HEX1$$fa00$$ENDHEX$$n el tipo de persona seleccionamos la cuenta de Cliente o Colegiado
choose case tipo_factura
	CASE g_colegio_colegiado
		cuenta = f_dame_cuenta_col(id_persona,'P')	// personal / honorarios
	CASE else
		cuenta = f_clientes_cuenta_contable(id_persona)
end choose

if forma_pago = 'CP' and tipo_factura = g_colegio_colegiado then
	cuenta_cp = f_dame_cuenta_col(id_persona,'CP')
	ctabanco = cuenta_cp
end if

//id_cli = f_minutas_id_cli(id_minuta)
// Abono a Banco
g_apunte.concepto = LeftA(concepto_base,57)
g_apunte.cuenta = ctabanco
g_apunte.debe = importe
g_apunte.haber = 0
g_apunte.contrapartida = cuenta
f_apunte_dw(g_apunte,dw_2,'E')	

// Cargo a la Cuenta del colegiado
concepto = LeftA(concepto_base,57)
g_apunte.concepto = concepto
g_apunte.cuenta = cuenta
g_apunte.debe = 0
g_apunte.haber = importe
g_apunte.contrapartida = ctabanco
f_apunte_dw(g_apunte,dw_2,'E')	

//Marcamos la liquidacion como contabilizada:
this.SetItem(fila,'contabilizado','S')
this.SetItem(fila,'f_contabilizado',fecha)

// Seg$$HEX1$$fa00$$ENDHEX$$n el tipo de factura lo tenemos que pasar hacia uno u otro diario
if f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_fase')) and f_es_vacio(dw_1.GetItemString(dw_1.getrow(), 'id_minuta')) then
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_ot, i_asiento)     
else
	f_actualiza_numero_bd_ejercicio(g_sica_diario.facts_emitidas_exp, i_asiento)    
end if

// Actualizamos 
int retorno_update
retorno_update = this.update()
retorno_update += dw_2.update()
if retorno_update <> 2 then
	messagebox(g_titulo, 'Se produjo un error al contabilizar el cobro, vuelva a intentarlo o consulte con su proveedor')   
end if
dw_2.reset()


end event

event csd_configura();//if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
//	this.object.pagado.protect  = 1
//	this.object.f_pago.protect = 1
//	this.object.contabilizado.protect = 1 
//	this.object.f_contabilizado.protect = 1
//	this.object.b_contabilizar.visible = 0
//end if
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateformat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

this.getchild('forma_pago', idwc_forma_pago_cobros)
idwc_forma_pago_cobros.settransobject(SQLCA)

// MODIFICADO YEXAIRA 29/05/08
//SE AGREGO PARA FILTRAR EL TIPO DE PAGO COBRO MULTIPLE
idwc_forma_pago_cobros.setfilter("tipo_pago <> 'CM'")
idwc_forma_pago_cobros.filter()
end event

event pfc_addrow;call super::pfc_addrow;string id, id_factura,centro

//centro = f_devuelve_centro(g_cod_delegacion)
id = f_siguiente_numero('COBRO_FEMI',10)

//this.SetItem(this.RowCount(),'id_factura', id_factura)
this.SetItem(this.RowCount(),'id_pago', id)

// centro y la explotacion
this.Setitem(this.RowCount(),"centro",i_centro)
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
this.Setitem(this.RowCount(),"proyecto",g_explotacion_por_defecto)

//usuario
this.Setitem(this.RowCount(),"cod_usuario",g_usuario)
this.Setitem(this.RowCount(),"empresa",g_empresa)
return this.RowCount()

end event

event pfc_insertrow;call super::pfc_insertrow;string id, id_factura,centro
int fila

// En este dw no est$$HEX2$$e1002000$$ENDHEX$$funcionando bien el GetRow(), cambia el foco a la siguiente l$$HEX1$$ed00$$ENDHEX$$nea y 
// no hace bien los setitem con GetRow
fila = ancestorreturnvalue
//centro = f_devuelve_centro(g_cod_delegacion)
//id_factura = dw_1.GetItemString(1, 'id_factura')
id = f_siguiente_numero('COBRO_FEMI',10)

//this.SetItem(fila,'id_factura', id_factura)
this.SetItem(fila,'id_pago', id)

// centro y la explotacion
this.Setitem(fila,"centro",i_centro)
if f_es_vacio(g_explotacion_por_defecto) then g_explotacion_por_defecto = f_dame_dpto_usuario(g_usuario)
this.Setitem(fila,"proyecto",g_explotacion_por_defecto)
// Se a$$HEX1$$f100$$ENDHEX$$ade el usuario y la empresa
this.Setitem(fila,"cod_usuario",g_usuario)
this.Setitem(fila,"empresa",g_empresa)

return fila


end event

event pfc_predeleterow;call super::pfc_predeleterow;if this.GetItemString (this.GetRow(), 'contabilizado') = 'S' then
	MessageBox(g_titulo, 'No puede borrar un pago ya contabilizado')
	return 0
end if

return 1

end event

event itemchanged;string id_cobro_multiple

// Modificacion de Datos
dw_1.event csd_modificacion_datos(dw_1.getitemstring(dw_1.getrow(),'id_factura'), this, Upper(Parent.text), dwo.name, row)

CHOOSE CASE dwo.name
	CASE 'forma_pago'
		
	// VERIFICAMOS QUE NO SEA MINUTA Y EL COBRO SEA POR CUENTA PERSONAL CAL-144
		if data='CA' and dw_1.GetItemString(dw_1.getrow(),'tipo_factura')='04' then
			MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!", "Una minuta no puede cobrarse por cuenta personal")
			return 2
		end if	
   	// Verificamos que no pertenezca a un cobro multiple
      id_cobro_multiple = f_dame_id_cobro_multiple_de_cobro(this.getitemString(row, 'id_pago'))
      if not f_es_vacio(id_cobro_multiple) then
      	Messagebox(g_titulo, "La forma de pago debe ser Cobro Multiple para que se contabilice correctamente", stopsign!)
         return 2
	end if
                
      this.PostEvent ("cuenta_contable",row,0)
      this.PostEvent ("f_vencimiento",row,0)          
	CASE 'banco'
			this.PostEvent ("cuenta_contable",row,0)
			//Actualizamos banco de la factura
			dw_1.SetItem(1,'banco',data)
	CASE 'pagado'
			this.PostEvent ("f_pago",row,0)
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;//string cuenta
//
//g_busqueda.dw = 'd_dddw_cuentas_anali_busqueda'
//g_busqueda.titulo = 'Consulta de cuenta'
//
//cuenta = f_busqueda_bd_ejercicio()
//
//if isnull(cuenta) or cuenta='' then return
//
//CHOOSE CASE dwo.name 
//	CASE 'cb_cuenta'
//		this.SetItem(1,'cuenta',cuenta)
////	CASE 'cb_hasta'
////		this.SetItem(1,'cuenta_hasta',cuenta)
//END CHOOSE

CHOOSE CASE dwo.name
	CASE 'b_contabilizar'
		this.trigger event pfc_accepttext(true)
		this.Trigger Event csd_contabilizar_cobros(row)
END CHOOSE

end event

event retrieveend;call super::retrieveend;// Es necesario que se tenga el check inicializado para que no pete y deje grabar siempre
long fila
// Recorremos todos los cobros
FOR fila = 1 to this.RowCount()
	if f_es_vacio(this.getitemstring(fila, 'devuelto')) then
		this.setitem(fila, 'devuelto', 'N')
	end if
NEXT
// Grabamos directamente ya que todavia no ha tocado el usuario
this.update()

end event

event csd_tecla;call super::csd_tecla;wf_key_pressed(key, keyflags)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;
if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
	am_dw.m_table.m_insert.enabled = False
	am_dw.m_table.m_addrow.enabled = False
	am_dw.m_table.m_delete.enabled = False
end if	
end event

type tabpage_6 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Cobros Compuestos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom048!"
long picturemaskcolor = 536870912
dw_cobros_multiples dw_cobros_multiples
end type

on tabpage_6.create
this.dw_cobros_multiples=create dw_cobros_multiples
this.Control[]={this.dw_cobros_multiples}
end on

on tabpage_6.destroy
destroy(this.dw_cobros_multiples)
end on

type dw_cobros_multiples from u_csd_dw within tabpage_6
event csd_configura ( )
integer x = 9
integer y = 8
integer width = 3287
integer height = 540
integer taborder = 11
string dataobject = "d_cobros_fmultiples"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event csd_configura();//if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
//	this.object.pagado.protect  = 1
//	this.object.f_pago.protect = 1
//	this.object.contabilizado.protect = 1 
//	this.object.f_contabilizado.protect = 1
//end if
end event

event buttonclicked;call super::buttonclicked;string id_cobro_multiple, ls_cierre
st_busqueda_facturas  lst_datos

choose case dwo.name
	case 'b_cobros_mult'
		lst_datos.id_cobro_multiple = idw_femitidas_cobros_mult.getitemstring(row, 'id_cobro_multiple')
		lst_datos.cobro_contabilizado =  idw_femitidas_cobros_mult.getitemstring(row, 'contabilizado')
		lst_datos.fact_contabilizada = dw_1.getitemstring(1, 'contabilizada')

		OpenWithParm(w_cobros_multiiples_response,  lst_datos)
		
		ls_cierre = message.stringparm
		if ls_cierre = 'Cerr$$HEX1$$f300$$ENDHEX$$' then
			idw_femitidas_cobros_mult.retrieve(dw_1.getitemstring(1,"id_factura"))
		end if
		/// SCP-1831. Se comenta para sacar el c$$HEX1$$f300$$ENDHEX$$digo de la versi$$HEX1$$f300$$ENDHEX$$n trunck 5.03.05. 
//	case 'b_borrar_cobro'
//		
//		string is_contabilizada, is_id_factura, is_nulo,is_id_cobro_multi,is_n_facturas
//          double id_total_cobro,id_total_cobro_multiple,id_diferencia 
//          datastore  ds_cobros_multiples
//
//          SetNull(is_nulo)
//
//         is_id_cobro_multi=this.GetItemString(this.getrow(),'id_cobro_multiple')
//	    is_contabilizada=this.GetItemString(this.getrow(),'cc_contabilizado')
//	  
//	    if NOT f_es_vacio(is_contabilizada) then
//			if is_contabilizada='S' then	
//				messagebox(g_titulo,'No se puede borrar el cobro, el cobro ya esta contabilizado.')
//			else		
//				ds_cobros_multiples = create datastore
//				ds_cobros_multiples.dataobject = 'd_cobros_multiples_lista'
//				ds_cobros_multiples.SetTransObject( SQLCA )	
//				ds_cobros_multiples.Retrieve(is_id_cobro_multi)
//				is_id_factura = dw_1.getitemstring (dw_1.GetRow(), 'id_factura') 
//      			this.setitem(this.getrow( ),'csi_cobros_forma_pago',is_nulo) 
//		   		this.setitem(this.getrow( ), 'csi_cobros_banco', is_nulo)	
//				this.setitem(this.getrow( ), 'pagado', 'N')		
//				this.setitem(this.getrow( ), 'id_cobro_multiple', is_nulo)			
//				dw_1.setitem(dw_1.GetRow(), 'banco', is_nulo)
//			   	dw_1.setitem(dw_1.GetRow(), 'formadepago',is_nulo)
//	  			dw_1.setitem(dw_1.GetRow(), 'pagado','N')				  
//				id_total_cobro = this.GetItemNumber (this.getrow(), 'csi_cobros_importe')
//				id_total_cobro_multiple = ds_cobros_multiples.GetItemNumber (ds_cobros_multiples.GetRow(), 'importe')
//				id_diferencia = ds_cobros_multiples.GetItemNumber (ds_cobros_multiples.GetRow(), 'diferencia')
//	        		 if MessageBox("Atencion","$$HEX1$$bf00$$ENDHEX$$Desea actualizar el total del cobro? Si no se actualiza el total del cobro, se producir$$HEX2$$e1002000$$ENDHEX$$un descuadre en contabilidad  ",Question!,YesNo!)=2 then 
//					id_diferencia=id_total_cobro_multiple - id_total_cobro
//				else 
//					id_total_cobro_multiple=id_total_cobro_multiple - id_total_cobro
//		          end if
//				ds_cobros_multiples.setitem( ds_cobros_multiples.getrow(),'diferencia',id_diferencia)
//				ds_cobros_multiples.setitem( ds_cobros_multiples.getrow(),'importe',id_total_cobro_multiple)
//				is_n_facturas = f_cobro_multiple_dame_facturas(is_id_cobro_multi)
//				ds_cobros_multiples.setitem( ds_cobros_multiples.getrow(),'lista_fact',is_n_facturas)
//				ds_cobros_multiples.Update( )      			
// 				is_n_facturas = f_cobro_multiple_dame_facturas(is_id_cobro_multi)
//				ds_cobros_multiples.setitem( ds_cobros_multiples.getrow(),'lista_fact',is_n_facturas)
//				dw_1.Update( )
//				this.Update( ) 
//     			this.retrieve(is_id_cobro_multi )	
//			end if      
//				  		 
//		end if
end choose
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//if f_es_factura_proforma(dw_1.getitemstring(dw_1.getrow(), 'id_factura')) = 'S' then
	am_dw.m_table.m_insert.enabled = False
	am_dw.m_table.m_addrow.enabled = False
	am_dw.m_table.m_delete.enabled = true
//end if	
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Apuntes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Report5!"
long picturemaskcolor = 536870912
dw_femitidas_apuntes dw_femitidas_apuntes
end type

on tabpage_4.create
this.dw_femitidas_apuntes=create dw_femitidas_apuntes
this.Control[]={this.dw_femitidas_apuntes}
end on

on tabpage_4.destroy
destroy(this.dw_femitidas_apuntes)
end on

type dw_femitidas_apuntes from u_dw within tabpage_4
integer x = 9
integer y = 8
integer width = 3296
integer height = 544
integer taborder = 11
string dataobject = "d_apuntes_automaticos_fe"
end type

event constructor;call super::constructor;this.SetTransObject(bd_ejercicio)

string valor, filtro

filtro = "(diario = '"+g_sica_diario.facts_emitidas_exp+"' or diario = '"+g_sica_diario.facts_emitidas_ot+"' or diario = '"+g_sica_diario.devoluciones+"')"
filtro += " and (t_doc = '"+g_sica_t_doc.facts_emitidas_exp+"' or t_doc = '"+g_sica_t_doc.facts_emitidas_ot+"' or "
filtro += " t_doc = '"+g_sica_t_doc.talon+"' or t_doc = '"+g_sica_t_doc.transferencia+"' or t_doc = '"+g_sica_t_doc.generico+"')"
// Modificacion Ricardo 2005-04-26
// Parte pedida por Javi
filtro += " and ( isnull (t_asiento) OR t_asiento <> '"+f_t_asiento_liquidacion()+"' )"


// filtramos los apuntes
this.setfilter(filtro)

end event

event csd_tecla;call super::csd_tecla;wf_key_pressed(key, keyflags)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Datos contrato"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Continue!"
long picturemaskcolor = 12632256
dw_datos_contrato dw_datos_contrato
end type

on tabpage_5.create
this.dw_datos_contrato=create dw_datos_contrato
this.Control[]={this.dw_datos_contrato}
end on

on tabpage_5.destroy
destroy(this.dw_datos_contrato)
end on

type dw_datos_contrato from u_dw within tabpage_5
integer x = 9
integer y = 8
integer width = 3296
integer height = 544
integer taborder = 11
string dataobject = "d_facturacion_emitida_datos_contrato"
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event retrieveend;call super::retrieveend;if this.rowcount()>0 then
	this.setitem(1,'n_expediente', this.getitemstring(1,'n_expediente_computado'))
end if
end event

event doubleclicked;call super::doubleclicked;//Si el usuario pulsa sobre el n$$HEX1$$ba00$$ENDHEX$$expediente o el n$$HEX1$$ba00$$ENDHEX$$registro le llevamos al detalle del 
//elemento correspondiente
string ls_id_expedi,ls_n_expedi,ls_id_fase,ls_n_registro

choose case dwo.name
//	case 'n_expediente' 
//		ls_n_expedi=getitemstring(1,'n_expediente')
//		select id_expedi into :ls_id_expedi from expedientes where n_expedi=:ls_n_expedi;
//		g_expedientes_consulta.id_expediente =ls_id_expedi
//		message.stringparm = "w_expedientes_detalle"
//		w_aplic_frame.postevent("csd_expedientesdetalle")
	case 'fases_n_registro' 
		ls_n_registro=getitemstring(1,'fases_n_registro')
		select id_fase into :ls_id_fase from fases where n_registro=:ls_n_registro;
		g_fases_consulta.id_fase = ls_id_fase
		g_fase_visared.opcion_importacion = 'N'
		message.stringparm = "w_fases_detalle"
		w_aplic_frame.postevent("csd_fasesdetalle")
end choose

end event

type tabpage_9 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$ricos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_modificacion_datos dw_modificacion_datos
end type

on tabpage_9.create
this.dw_modificacion_datos=create dw_modificacion_datos
this.Control[]={this.dw_modificacion_datos}
end on

on tabpage_9.destroy
destroy(this.dw_modificacion_datos)
end on

type dw_modificacion_datos from u_dw within tabpage_9
boolean visible = false
integer x = 9
integer y = 8
integer width = 3305
integer height = 552
integer taborder = 10
string dataobject = "d_historico"
end type

event type long pfc_addrow();call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_factura') )
this.setitem(this.rowcount(), 'tipo_modulo', '05')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3323
integer height = 560
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico proforma"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Asterisk!"
long picturemaskcolor = 536870912
dw_historico_proformas dw_historico_proformas
end type

on tabpage_7.create
this.dw_historico_proformas=create dw_historico_proformas
this.Control[]={this.dw_historico_proformas}
end on

on tabpage_7.destroy
destroy(this.dw_historico_proformas)
end on

type dw_historico_proformas from u_dw within tabpage_7
integer x = 9
integer y = 8
integer width = 3305
integer height = 552
integer taborder = 10
string dataobject = "d_historico_proformas"
boolean ib_isupdateable = false
end type

event type long pfc_addrow();call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_factura') )
this.setitem(this.rowcount(), 'tipo_modulo', '05')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

type cb_imprimir from commandbutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 464
integer width = 398
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Factura"
end type

event clicked;string id_factura,tipo_factura,mensaje='',emisor, imprimir_a_pdf, visared, nif_cli,paga_empresa,paga_externo,id_pagador
string imprime_cta_banco_col, ls_id_minuta, tipo_gestion, ls_id_fase_aux
integer retorno

retorno = parent.event closequery()
if retorno = 1 then return

id_factura = dw_1.GetItemString(dw_1.GetRow(),'id_factura')
tipo_factura = dw_1.GetItemString(dw_1.GetRow(),'tipo_factura')
emisor = dw_1.GetItemString(dw_1.GetRow(),'emisor')
paga_empresa = dw_1.GetItemString(dw_1.GetRow(),'paga_empresa')
paga_externo = dw_1.GetItemString(dw_1.GetRow(),'paga_externo')
id_pagador = dw_1.GetItemString(dw_1.Getrow(),'id_cliente_pagador')
ls_id_minuta = dw_1.GetItemString(dw_1.Getrow(),'id_minuta')

//if not(f_es_vacio(ls_id_minuta)) and (tipo_factura = g_colegiado_cliente) then 
//	tipo_gestion = f_tipo_gestion_colegiado(ls_id_minuta, emisor)
//end if

///*** SCP-1051. Alexis. 03/03/2011. Se va a proceder a averiguar la empresa asociada al contrato ***///
If f_es_vacio(id_pagador) then 
	if not f_es_vacio(ls_id_minuta) then
		id_pagador= f_factura_id_empresa_colegiado(f_colegiado_id_col(dw_1.GetItemString(dw_1.Getrow(),'n_col')), ls_id_minuta )			
	else
		id_pagador=  f_minutas_id_empresa(dw_1.GetItemString(dw_1.Getrow(),'id_fase'), f_colegiado_id_col(dw_1.GetItemString(dw_1.Getrow(),'n_col')) )
	end if
end if 
imprime_cta_banco_col	= dw_1.GetItemString(dw_1.Getrow(),'imprime_cta_banco_col')
//Andr$$HEX1$$e900$$ENDHEX$$s 24/05/2005
if isnull(tipo_factura) then
	mensaje= mensaje + 'Debe especificar un Tipo de Factura'+cr
end if

if tipo_factura = g_colegiado_cliente then
	emisor = dw_1.GetItemString(dw_1.GetRow(),'emisor')
	if isnull(emisor) then
		mensaje = mensaje + 'Debe especificar un Emisor de la Factura'
	end if
end if

if mensaje<>'' then
	Messagebox(g_titulo,mensaje)
	return -1
end if

//imprimir_a_pdf = dw_1.getitemstring(dw_1.GetRow(),'visared')

st_imprimir_factura_obj_impr st_imp_fact
st_imp_fact.id_factura = id_factura
st_imp_fact.id_persona = emisor
st_imp_fact.tipo = tipo_factura
st_imp_fact.dw = dw_1
st_imp_fact.paga_empresa       =paga_empresa
st_imp_fact.paga_externo	=paga_externo
st_imp_fact.id_cliente_pagador	= id_pagador
st_imp_fact.imprime_cta_banco_col	=	imprime_cta_banco_col

//Inicializamos datos del objeto de impresi$$HEX1$$f300$$ENDHEX$$n
string ls_id_col, ls_n_col,ls_postal,ls_email,ls_num_factura
ls_num_factura=dw_1.getitemstring(dw_1.getrow(),'n_fact')
i_impresion_formato.nombre=ls_num_factura
i_impresion_formato.asunto_email='Factura '+ls_num_factura
//obtenemos el correo del colegiado
ls_n_col=dw_1.getitemstring(dw_1.getrow(),'n_col')
ls_id_col=f_colegiado_id_col(ls_n_col)


//obtenemos si el colegiado quiere recibir los documentos impresos y por email
select recibir_c_postales,recibir_c_email into :ls_postal,:ls_email from colegiados where id_colegiado=:ls_id_col;
// if imprimir_a_pdf = 'V' then i_impresion_formato.pdf='S'
i_impresion_formato.papel=ls_postal
i_impresion_formato.email=ls_email

//Si un colegiado no tiene marcado ning$$HEX1$$fa00$$ENDHEX$$n tipo de informe marcar papel 
if ls_postal='N' and ls_email='N' then i_impresion_formato.papel='S'
//Donde se hace la impresi$$HEX1$$f300$$ENDHEX$$n
string valretorno    
st_w_factu_e_imprimir l_st_w_factu
l_st_w_factu.varias_facturas=false

string id_fase,id_colegiado//,id_minuta

id_colegiado=dw_1.GetItemString(dw_1.GetRow(),'id_persona')
id_fase=dw_1.GetItemString(dw_1.GetRow(),'id_fase')
//id_minuta=dw_1.GetItemString(dw_1.GetRow(),'id_minuta')

if (tipo_factura = g_colegiado_cliente) then 
	if not (f_es_vacio(ls_id_minuta)) then 
		tipo_gestion = f_tipo_gestion_colegiado(ls_id_minuta, emisor)
	else 
		ls_id_fase_aux = f_devuelve_id_fase_minuta(id_fase)
		tipo_gestion = f_tipo_gestion_colegiado(ls_id_fase_aux, emisor)
	end if 
end if	

i_impresion_formato.avisos=1

i_impresion_formato.pdf = g_formato_impresion.pdf
i_impresion_formato.papel = g_formato_impresion.papel
i_impresion_formato.email = g_formato_impresion.email	

i_impresion_formato.id_factura = id_factura
	
if f_es_vacio(id_fase) and f_es_vacio(ls_id_minuta) then
	i_impresion_formato.destino='TO'	
	i_impresion_formato.referencia=id_colegiado
	i_impresion_formato.referencia2=id_factura
else
	i_impresion_formato.destino='T'
	i_impresion_formato.referencia=id_fase
	i_impresion_formato.referencia2=ls_id_minuta
	
	if not(f_es_vacio(id_fase))  then  // ID_FASE
		select fases.e_mail into :visared from fases, fases_minutas
		where fases_minutas.id_minuta = :id_fase and	fases_minutas.id_fase = fases.id_fase;
	else // ID_MINUTA
		select fases.e_mail into :visared from fases where id_fase=:ls_id_minuta;
	end if
	
	if visared='V' then
		i_impresion_formato.pdf = g_formato_impresion_visared.pdf
		i_impresion_formato.papel = g_formato_impresion_visared.papel
		i_impresion_formato.email = g_formato_impresion_visared.email				
	end if

	
end if

f_rellenar_destinatarios_email(id_factura,i_impresion_formato) 

if ((f_var_global_sn("g_enviar_email_facturacion_clientes") = 'S') and (i_impresion_formato.email <> 'S') and (tipo_factura = g_colegio_cliente or (tipo_factura = g_colegiado_cliente and tipo_gestion = 'C'))) then 
	i_impresion_formato.email = 'S'		
end if

string impresora, bandeja
f_impresora_fact(dw_1.getitemstring(dw_1.getrow(),'tipo_factura'), impresora, bandeja)
i_impresion_formato.impresora_bandeja = bandeja
i_impresion_formato.impresora = impresora

if i_impresion_formato.f_opciones_impresion()<>1 then return

st_imp_fact.objeto_nuevo='S'
st_imp_fact.impresion_formato=i_impresion_formato
//
////Imprimimos originales
f_imprimir_factura_objeto_impr(st_imp_fact)

st_imp_fact.impresion_formato.texto_email = ''

if dw_1.GetItemString(1,'emitida') = 'S' then
	dw_1.SetItem(1,'reimpresa','S')
else 
	dw_1.SetItem(1,'emitida','S')
end if

//Guardamos si se ha imprimido en pdf
if st_imp_fact.impresion_formato.pdf='S' then
	dw_1.setitem(dw_1.getrow(),'visared','V')
end if

dw_1.update()

end event

type dw_2 from u_dw within w_facturacion_emitida_detalle
boolean visible = false
integer x = 2971
integer y = 884
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_apuntes_automaticos"
end type

event constructor;call super::constructor;this.SetTransObject(bd_ejercicio)
end event

type cb_exped from commandbutton within w_facturacion_emitida_detalle
integer x = 3218
integer y = 28
integer width = 91
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string exp, id_fase, n_registro

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_fases"
id_fase=f_busqueda_fases()  

//Andr$$HEX1$$e900$$ENDHEX$$s: 1/2/2005 Si es vac$$HEX1$$ed00$$ENDHEX$$o no lo copiamos
if NOT f_es_vacio(id_fase) then
	dw_1.setitem(1,'id_minuta',id_fase)
end if

end event

type cb_imprimir_recibo from commandbutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 564
integer width = 398
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Recibo"
end type

event clicked;string id_factura,tipo_factura,mensaje='',emisor, imprimir_a_pdf
integer retorno

retorno = parent.event closequery()
if retorno = 1 then return
 
id_factura = dw_1.GetItemString(dw_1.GetRow(),'id_factura')
tipo_factura = dw_1.GetItemString(dw_1.GetRow(),'tipo_factura')
emisor = dw_1.GetItemString(dw_1.GetRow(),'emisor')
 
//dw_impresion_factura.retrieve(id_factura,'',f_devuelve_moneda_ejercicio())
 
if isnull(tipo_factura) then
	mensaje= mensaje + 'Debe especificar un Tipo de Factura'+cr
end if
 
if tipo_factura = g_colegiado_cliente then
	emisor = dw_1.GetItemString(dw_1.GetRow(),'emisor')
 	if isnull(emisor) then
  		mensaje = mensaje + 'Debe especificar un Emisor de la Factura'
 	end if
end if
 
if mensaje<>'' then
 	Messagebox(g_titulo,mensaje)
 	return -1
end if
 
//imprimir_a_pdf = dw_1.getitemstring(dw_1.GetRow(),'visared')

st_imprimir_factura_obj_impr st_imp_fact
st_imp_fact.id_factura = id_factura
st_imp_fact.id_persona = emisor
st_imp_fact.tipo = tipo_factura
st_imp_fact.dw = dw_1
st_imp_fact.recibo = TRUE

 //Inicializamos datos del objeto de impresi$$HEX1$$f300$$ENDHEX$$n
 string ls_id_col, ls_n_col,ls_num_factura
 ls_num_factura=dw_1.getitemstring(dw_1.getrow(),'n_fact')
 i_impresion_formato.nombre=ls_num_factura
 i_impresion_formato.asunto_email='Factura '+ls_num_factura
 //obtenemos el correo del colegiado
 ls_n_col=dw_1.getitemstring(dw_1.getrow(),'n_col')
 ls_id_col=f_colegiado_id_col(ls_n_col)
 i_impresion_formato.direccion_email=f_devuelve_mail(ls_id_col)

//Marcamos s$$HEX1$$f300$$ENDHEX$$lo papel
i_impresion_formato.papel='S'
i_impresion_formato.pdf='N'
i_impresion_formato.email='N'

 string valretorno   
 st_w_factu_e_imprimir l_st_w_factu
 l_st_w_factu.varias_facturas=false
 l_st_w_factu.impresion_formato=i_impresion_formato
 
 openwithparm(w_factu_e_imprimir,l_st_w_factu)

 valretorno=message.stringparm
 if valretorno = 'CANCELAR' then 
	return
end if
 
 st_imp_fact.impresion_formato=i_impresion_formato
 
 //Imprimimos originales
st_imp_fact.copia = 'N'
 f_imprimir_factura_objeto_impr(st_imp_fact)
 //Imprimimos copias
 st_imp_fact.copia = 'S'
 //Evitamos que envie el email 2 veces
 st_imp_fact.impresion_formato.email='N'
 st_imp_fact.impresion_formato.copias=long(valretorno)
 f_imprimir_factura_objeto_impr(st_imp_fact)
  //Imprimimos en pdf 
   //Esto es necesario porque f_imprimir_factura hace cosas distintas en funci$$HEX1$$f300$$ENDHEX$$n del valor de st_imp_fact.copia
 st_imp_fact.copia = 'V'
 st_imp_fact.impresion_formato.copias=1
 f_imprimir_factura_objeto_impr(st_imp_fact)


if dw_1.GetItemString(1,'emitida') = 'S' then
 	dw_1.SetItem(1,'reimpresa','S')
else 
 	dw_1.SetItem(1,'emitida','S')
end if

//Guardamos si se ha imprimido en pdf
 if st_imp_fact.impresion_formato.pdf='S' then
	dw_1.setitem(dw_1.getrow(),'visared','V')
 end if
 
dw_1.update()

end event

event constructor;if  f_colegio() = 'COAATTFE'THEN cb_imprimir_recibo.VISIBLE = TRUE
end event

type pb_1 from picturebutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 664
integer width = 398
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;openwithparm(w_historico, dw_1.getitemstring(1,'id_factura')+"05")

end event

type cb_recibos_musaat from commandbutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 564
integer width = 398
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Recibos Musaat"
end type

event clicked;string id_factura

//// Preguntamos los originales y las copias
//string sl_imprimir, sl_originales, sl_copias
//long pos_#, ll_originales, ll_copias
//open(w_factu_e_imprimir)
//sl_imprimir = Message.StringParm
//pos_# = pos(sl_imprimir, '#')
//
//sl_originales = mid(sl_imprimir, 1, pos_# - 1)
//sl_copias = mid(sl_imprimir, pos_#  + 1, len(sl_imprimir))
//ll_originales = long(sl_originales)
//ll_copias = long(sl_copias)
//// fin originales y copias
//// Recorremos las facturas

datastore ds_recibo
ds_recibo = create datastore
CHOOSE CASE g_colegio
	CASE 'COAATZ'
		ds_recibo.dataobject = 'd_recibo_musaat_za'
	CASE 'COAATGU'
		ds_recibo.dataobject = 'd_recibo_musaat_gu'
	CASE 'COAATLR'
		ds_recibo.dataobject = 'd_recibo_musaat_lr'
	CASE 'COAATLE'
		ds_recibo.dataobject = 'd_recibo_musaat_le'
	CASE 'COAATAVI'
		ds_recibo.dataobject = 'd_recibo_musaat_avi'
END CHOOSE
ds_recibo.settransobject (sqlca)

// Recorremos las facturas e imprimimos las que tengan una linea de musaat
id_factura 	= dw_1.GetItemString(1,'id_factura')
ds_recibo.retrieve(id_factura, 'N')
if ds_recibo.rowcount() > 0 then ds_recibo.print()

destroy ds_recibo

end event

type cb_borrar_vinculacion from commandbutton within w_facturacion_emitida_detalle
integer x = 3310
integer y = 28
integer width = 91
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "X"
end type

event clicked;dw_1.setitem(1,'id_minuta','')
end event

type cb_generar_numero_recibo_musaat from commandbutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 764
integer width = 398
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "N$$HEX2$$ba002000$$ENDHEX$$Rec. Musaat"
end type

event clicked;// CREADO POR RICARDO 2005-03-01

long fila, fila_musaat = -1, retorno
string n_recibo_mus
st_facturas lst_facturas

lst_facturas.cod_empresa = g_empresa

// La factura tiene que estar grabada primero
retorno = parent.trigger event pfc_save()
if retorno<>0 and retorno<>1 then return

FOR fila = 1 TO idw_femitidas_conceptos.RowCount()
	// Buscamos la fila de musaat
	if idw_femitidas_conceptos.getitemString(fila, 'articulo') = g_codigos_conceptos.musaat_variable and f_es_vacio(idw_femitidas_conceptos.getitemString(fila, 'id_recibo')) then
		fila_musaat = fila
		exit
	end if
NEXT

if fila_musaat>0 then
	// En este caso, generamos la factura de musaat y le permitimos que le de numero de musaat
	//SCP-1190. Alexis. 16/03/2011. Se cambia la funci$$HEX1$$f300$$ENDHEX$$n debido a los cambios multiempresa en la aplicaci$$HEX1$$f300$$ENDHEX$$n ***///
	//n_recibo_mus = f_siguiente_n_fact_emitida_za('','MU','',dw_1.GetitemDatetime(1, 'fecha'))
	n_recibo_mus = f_siguiente_n_fact_emitida_n_recibo(lst_facturas,'MU')
	
	idw_femitidas_conceptos.setitem(fila_musaat, 'id_recibo', n_recibo_mus)
	// Grabamos para que no se salgan sin grabar
	retorno = parent.trigger event pfc_save()
	MessageBox(g_titulo, "El n$$HEX1$$fa00$$ENDHEX$$mero de recibo es : "+n_recibo_mus)
else
	Messagebox(g_titulo, "Esta factura no tiene concepto de musaat variable para generar un n$$HEX1$$fa00$$ENDHEX$$mero de recibo", stopsign!)
end if


end event

type cb_recibo_irpf from commandbutton within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3227
integer y = 464
integer width = 398
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Recibos &IRPF"
end type

event clicked;st_recibo_retencion datos_recibo_retencion
double importe_honorarios, importe_despl, importe_reten
string tratamiento, id_emisor, id_fase, id_factura, id_fase_real

importe_reten = dw_1.getitemnumber(1, 'importe_reten')

if importe_reten > 0 then
	id_factura = dw_1.getitemstring(1, 'id_factura')

	SELECT csi_lineas_fact_emitidas.subtotal  
	INTO :importe_honorarios  
	FROM csi_facturas_emitidas, csi_lineas_fact_emitidas  
	WHERE ( csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura )  and
			( csi_facturas_emitidas.id_factura = :id_factura ) and	
			( csi_lineas_fact_emitidas.articulo = :g_codigos_conceptos.honorarios ) ;

	SELECT csi_lineas_fact_emitidas.subtotal  
	INTO :importe_despl
	FROM csi_facturas_emitidas, csi_lineas_fact_emitidas  
	WHERE ( csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura )  and
			( csi_facturas_emitidas.id_factura = :id_factura ) and	
			( csi_lineas_fact_emitidas.articulo = :g_codigos_conceptos.desplazamientos ) ;

	if g_aplica_irpf_en_desplaza = 'S' then importe_honorarios+=importe_despl
	
	id_emisor=dw_1.getitemstring(1, 'emisor')
	id_fase=dw_1.getitemstring(1, 'id_fase')	
	
	if not f_es_vacio(id_fase) then 
		select id_fase into :id_fase_real from fases_minutas where id_minuta = :id_fase;
	end if

	select tratamiento into :tratamiento from colegiados where id_colegiado=:id_emisor;
	
	datos_recibo_retencion.nombre_entidad=dw_1.getitemstring(1, 'nombre')
//	datos_recibo_retencion.domicilio_entidad=dw_1.getitemstring(1, 'domicilio')
	datos_recibo_retencion.domicilio_entidad=dw_1.getitemstring(1, 'domicilio_largo')	
	datos_recibo_retencion.poblacion_entidad=dw_1.getitemstring(1, 'poblacion')
	datos_recibo_retencion.cif_entidad=dw_1.getitemstring(1, 'nif')
	datos_recibo_retencion.nombre_profesional=f_nombre_colegiado(id_emisor)
	datos_recibo_retencion.domicilio_profesional=f_domicilio_fiscal(id_emisor)
	datos_recibo_retencion.poblacion_profesional=f_poblacion_fiscal(id_emisor)
	datos_recibo_retencion.cif_profesional=f_devuelve_nif(id_emisor)
	datos_recibo_retencion.objeto_trabajo=f_dame_descripcion_contrato(id_fase_real)
	datos_recibo_retencion.emplazamiento_trabajo=f_dame_direccion_contrato(id_fase_real)
	datos_recibo_retencion.importe_honorarios=importe_honorarios
	datos_recibo_retencion.importe_retencion=importe_reten
	datos_recibo_retencion.porcentaje_retencion=dw_1.getitemnumber(1, 'tipo_reten')
	datos_recibo_retencion.actividad_profesional=tratamiento
	
	CHOOSE CASE g_colegio
		CASE 'COAATGU'
			f_generar_recibo_retencion_gu(datos_recibo_retencion) 
		CASE 'COAATLE'
			f_generar_recibo_retencion_le(datos_recibo_retencion) 
		CASE 'COAATAVI'
			f_generar_recibo_retencion_avi(datos_recibo_retencion) 
		CASE 'COAATTER'
			f_generar_recibo_retencion_ter(datos_recibo_retencion)
	END CHOOSE
	
end if

end event

type dw_3 from u_dw within w_facturacion_emitida_detalle
boolean visible = false
integer x = 3314
integer y = 888
integer taborder = 21
boolean bringtotop = true
string dataobject = "ds_premaat_datos_fact_emi"
end type

