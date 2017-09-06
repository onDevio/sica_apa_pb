HA$PBExportHeader$w_cobros_domicilia_consulta.srw
forward
global type w_cobros_domicilia_consulta from w_consulta
end type
type tab_1 from tab within w_cobros_domicilia_consulta
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cobros from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_cobros dw_cobros
end type
type tabpage_1 from userobject within tab_1
end type
type dw_factu from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_factu dw_factu
end type
type tab_1 from tab within w_cobros_domicilia_consulta
tabpage_2 tabpage_2
tabpage_1 tabpage_1
end type
type cbx_acumular from checkbox within w_cobros_domicilia_consulta
end type
end forward

global type w_cobros_domicilia_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2944
integer height = 2344
string title = "Consulta de Cobros"
event csd_consulta_cobros ( )
event csd_consulta_facturas ( )
tab_1 tab_1
cbx_acumular cbx_acumular
end type
global w_cobros_domicilia_consulta w_cobros_domicilia_consulta

type variables
u_dw idw_facturas, idw_cobros
string i_sql_nuevo
end variables

event csd_consulta_cobros();string forma_pago, pagado, banco, n_remesa, contabilizado
datetime df_pago, hf_pago

f_sql('csi_cobros.n_remesa','LIKE','n_remesa',idw_cobros,i_sql_nuevo,'1','')	
f_sql('csi_cobros.forma_pago','LIKE','forma_pago',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.pagado','LIKE','pagado',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.banco','LIKE','banco',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.f_pago','>=','df_pago',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.f_pago','<','hf_pago',idw_cobros,i_sql_nuevo,'1','')

//Cambio hecho por Luis 07012009 para incidencia cgn-249, se trata de un error para todos los colegios
f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',idw_cobros,i_sql_nuevo,'1','')
f_sql('csi_cobros.f_vencimiento','<','f_vcto_hasta',idw_cobros,i_sql_nuevo,'1','')


if idw_cobros.getitemString(idw_cobros.getrow(), 'cobros_sin_remesa') = 'S' then
	if (PosA(upper(i_sql_nuevo), "WHERE") > 0) then
		i_sql_nuevo += "AND "
	else
		i_sql_nuevo += " WHERE "
	end if
	i_sql_nuevo += "( csi_cobros.n_remesa is null or csi_cobros.n_remesa = '')"
end if

f_sql('csi_cobros.devuelto','LIKE','devuelto',idw_cobros,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros.id_pago','=','referencia',idw_cobros,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros.devolucion_motivo','LIKE','devolucion_motivo',idw_cobros,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',idw_cobros,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',idw_cobros,i_sql_nuevo,g_tipo_base_datos,'')

if (PosA(upper(i_sql_nuevo), "WHERE") > 0) then
	i_sql_nuevo += "AND csi_cobros.empresa='"+g_empresa+"'"
else
	i_sql_nuevo += " WHERE csi_cobros.empresa='"+g_empresa+"'"
end if

end event

event csd_consulta_facturas();string concepto, hasta_where, despues_where, sql_aux
double conceptod, conceptoh
int pos_where

//Se inicializa el id de cliente
idw_facturas.setitem(1,'id_persona','')

f_sql('csi_facturas_emitidas.n_fact','LIKE','n_fact',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.tipo_persona','LIKE','tipo_persona',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.id_persona','LIKE','id_persona',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.nombre','LIKE','nombre',idw_facturas,i_sql_nuevo,'1','')
//f_sql('csi_facturas_emitidas.domicilio','LIKE','domicilio',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.domicilio_largo','LIKE','domicilio',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.nif','LIKE','nif',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.poblacion','LIKE','poblacion',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.formadepago','LIKE','formadepago',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.centro','LIKE','centro',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.banco','LIKE','banco',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','pagado',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.emitida','LIKE','emitida',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.reimpresa','LIKE','reimpresa',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.contabilizada','LIKE','contabilizada',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','>=','fecha_desde',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','fecha_hasta',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.f_pago','>=','f_pago_desde',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.f_pago','<','f_pago_hasta',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.f_conta','>=','f_conta_desde',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.f_conta','<','f_conta_hasta',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.total','>=','total_desde',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.total','<=','total_hasta',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',idw_facturas,i_sql_nuevo,'1','')// Modificado Ricardo 2005-03-09
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',idw_facturas,i_sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.n_fact','LIKE','n_col_honorario',idw_facturas,i_sql_nuevo,'1','')
//f_sql('csi_lineas_fact_emitidas.articulo','LIKE','concepto',idw_facturas,i_sql_nuevo,'1','')
//f_sql('csi_lineas_fact_emitidas.total','>=','importe_concepto_desde',idw_facturas,i_sql_nuevo,'1','')
//f_sql('csi_lineas_fact_emitidas.total','<=','importe_concepto_hasta',idw_facturas,i_sql_nuevo,'1','')

//A$$HEX1$$f100$$ENDHEX$$adido por Luis para incidencia cgn-256 13/01/2009
f_sql('csi_facturas_emitidas.proyecto','LIKE','proyecto',idw_facturas,i_sql_nuevo,'1','')

//A$$HEX1$$f100$$ENDHEX$$adimos filtrado de facturas proforma SCP-665
f_sql('csi_facturas_emitidas.proforma','=','proforma',idw_facturas,i_sql_nuevo,'1','')

concepto = idw_facturas.getitemstring(1, 'concepto')
conceptod = idw_facturas.getitemnumber(1, 'importe_concepto_desde')
conceptoh = idw_facturas.getitemnumber(1, 'importe_concepto_hasta')

// Alteramos los joins de la lista si se consulta por aviso
if not (f_es_vacio(concepto)) then
	pos_where = PosA(lower(i_sql_nuevo), 'where',1)
	pos_where --
	hasta_where = MidA(i_sql_nuevo, 1, pos_where)
	despues_where = MidA(i_sql_nuevo, pos_where , LenA(i_sql_nuevo))
	hasta_where += ', csi_lineas_fact_emitidas '
	i_sql_nuevo = hasta_where + despues_where
	i_sql_nuevo += ( ' and ( csi_facturas_emitidas.id_factura = csi_lineas_fact_emitidas.id_factura )'  )
	i_sql_nuevo += " and ( articulo = '"+concepto+"' ) " 
	if not (f_es_vacio(string(conceptod))) then i_sql_nuevo= i_sql_nuevo + " and (csi_lineas_fact_emitidas.total >="+f_cambia_comas_decimales(conceptod)+") "
	if not (f_es_vacio(string(conceptoh))) then i_sql_nuevo= i_sql_nuevo + " and (csi_lineas_fact_emitidas.total <="+f_cambia_comas_decimales(conceptoh)+") " 
end if

// Por familia de conceptos
if not f_es_vacio(idw_facturas.getitemstring(1, 'familia')) then
	sql_aux = " and csi_facturas_emitidas.id_factura IN (SELECT id_factura FROM csi_lineas_fact_emitidas, csi_articulos_servicios WHERE csi_lineas_fact_emitidas.articulo = csi_articulos_servicios.codigo and familia = '"+idw_facturas.getitemstring(1,'familia')+"')"
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux
end if

// Todos los colegiados que pertenezcan a la lista de colegiados elegida..
// Pero comprobando si hay que incluirlos o incluirlos
if not ( f_es_vacio(idw_facturas.getitemstring(1, 'lista_colegiados'))) then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux = "and csi_facturas_emitidas.tipo_factura = '03' and csi_facturas_emitidas.id_persona IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_facturas.getitemstring(1,'lista_colegiados')+"')"
	else
		sql_aux = "WHERE csi_facturas_emitidas.tipo_factura = '03' and csi_facturas_emitidas.id_persona IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_facturas.getitemstring(1,'lista_colegiados')+"')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux
END IF

// Minuta
if not ( f_es_vacio(idw_facturas.getitemstring(1, 'fase'))) then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_minuta='"+idw_facturas.getitemstring(1,'id_minuta')+"')"
	else
		sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases_minutas WHERE id_minuta='"+idw_facturas.getitemstring(1,'id_minuta')+"')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux
end if

// Registro
if not ( f_es_vacio(idw_facturas.getitemstring(1, 'n_registro'))) then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase='"+idw_facturas.getitemstring(1,'id_fase')+"')"
	else
		sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM fases, fases_minutas WHERE fases_minutas.id_fase = fases.id_fase and fases.id_fase='"+idw_facturas.getitemstring(1,'id_fase')+"')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux	
end if

// Expediente
if not ( f_es_vacio(idw_facturas.getitemstring(1, 'n_expedi'))) then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux = "and csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+idw_facturas.getitemstring(1,'id_expedi')+"')"
	else
		sql_aux = "WHERE csi_facturas_emitidas.id_fase IN (SELECT id_minuta FROM expedientes, fases, fases_minutas WHERE expedientes.id_expedi = fases.id_expedi and fases_minutas.id_fase = fases.id_fase and expedientes.id_expedi='"+idw_facturas.getitemstring(1,'id_expedi')+"')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux		
end if

end event

on w_cobros_domicilia_consulta.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cbx_acumular=create cbx_acumular
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cbx_acumular
end on

on w_cobros_domicilia_consulta.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cbx_acumular)
end on

event open;call super::open;f_centrar_ventana(this) 
  
idw_facturas 	= tab_1.tabpage_1.dw_factu
idw_cobros 		= tab_1.tabpage_2.dw_cobros

idw_facturas.insertrow(1)
idw_cobros.insertrow(1)

idw_cobros.SetFocus()
idw_cobros.SetColumn('n_remesa')

// Por defecto que no aparezcan los cobros de facturas anuladas
// Podemos cambiar el criterio con una consulta de inicio
idw_facturas.setitem(1, 'anulada', 'N')

end event

event pfc_postopen;call super::pfc_postopen;// 	 CGN-450
idw_facturas.SetItem(1,'anulada','N')
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_cobros_domicilia_consulta
string tag = "texto=general.recuperar"
boolean visible = true
integer x = 2455
integer y = 616
integer width = 402
integer height = 80
integer taborder = 50
string text = "Recuperar"
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_cobros_domicilia_consulta
string tag = "texto=general.guardar"
boolean visible = true
integer x = 2455
integer y = 516
integer width = 402
integer height = 80
integer taborder = 40
string text = "Guardar"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_cobros_domicilia_consulta
integer x = 2363
integer y = 1280
integer taborder = 60
end type

type st_5 from w_consulta`st_5 within w_cobros_domicilia_consulta
string tag = "texto=cobros.int_param_consulta_aceptar"
integer x = 96
integer y = 16
end type

type cb_1 from w_consulta`cb_1 within w_cobros_domicilia_consulta
integer x = 2455
integer y = 416
integer width = 402
end type

event cb_1::clicked;call super::clicked;SetPointer(HourGlass!)
dw_1.AcceptText()
i_sql_nuevo = g_dw_lista.describe("datawindow.table.select")
idw_facturas.AcceptText()
idw_cobros.AcceptText()

parent.TriggerEvent('csd_consulta_facturas')
parent.TriggerEvent('csd_consulta_cobros')

// Si se quiere acumular la consulta hacemos una union
if cbx_acumular.checked then
	if not f_es_vacio(g_consulta_actual) then
		i_sql_nuevo = g_consulta_actual + " UNION "+i_sql_nuevo
	end if
end if

//MESSAGEBOX('', i_sql_nuevo)
g_dw_lista.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_cobros_domicilia_consulta
integer x = 2455
integer y = 716
integer width = 402
end type

type cb_ayuda from w_consulta`cb_ayuda within w_cobros_domicilia_consulta
string tag = "texto=general.ayuda"
integer x = 2386
integer y = 1280
integer taborder = 70
end type

type dw_1 from w_consulta`dw_1 within w_cobros_domicilia_consulta
boolean visible = false
integer x = 2386
integer y = 28
integer width = 507
integer height = 336
string dataobject = "d_cobros_domicilia_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// MODIFICADO RICARDO 04-02-26
// ponemos el check de sin remesas visible
this.object.cobros_sin_remesa.visible = true
// FIN MODIFICADO RICARDO 04-02-26

end event

event dw_1::buttonclicked;call super::buttonclicked;string remesa
choose case dwo.name
	case 'b_busqueda_remesa'
		g_busqueda.titulo = 'B$$HEX1$$fa00$$ENDHEX$$squeda de remesas de cobros'
		g_busqueda.dw = 'd_lista_busqueda_remesas_cobros'		
		open(w_busqueda_remesas_cobros)
		remesa = message.stringparm
		this.setitem(1, 'n_remesa', remesa)
end choose
end event

type tab_1 from tab within w_cobros_domicilia_consulta
integer x = 50
integer y = 120
integer width = 2331
integer height = 2060
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_2 tabpage_2
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_2,&
this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_2)
destroy(this.tabpage_1)
end on

type tabpage_2 from userobject within tab_1
string tag = "texto=cobros.cobros"
integer x = 18
integer y = 100
integer width = 2295
integer height = 1944
long backcolor = 79741120
string text = "Cobros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cobros dw_cobros
end type

on tabpage_2.create
this.dw_cobros=create dw_cobros
this.Control[]={this.dw_cobros}
end on

on tabpage_2.destroy
destroy(this.dw_cobros)
end on

type dw_cobros from u_dw within tabpage_2
event csd_formatea_n_remesa ( string dato )
integer x = 59
integer y = 48
integer width = 1883
integer height = 1400
integer taborder = 10
string dataobject = "d_cobros_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_formatea_n_remesa(string dato);string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	this.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event buttonclicked;call super::buttonclicked;string remesa
choose case dwo.name
	case 'b_busqueda_remesa'
		g_busqueda.titulo = 'B$$HEX1$$fa00$$ENDHEX$$squeda de remesas de cobros'
		g_busqueda.dw = 'd_lista_busqueda_remesas_cobros'		
		open(w_busqueda_remesas_cobros)
		remesa = message.stringparm
		this.setitem(1, 'n_remesa', remesa)
end choose
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// MODIFICADO RICARDO 04-02-26
// ponemos el check de sin remesas visible
this.object.cobros_sin_remesa.visible = true
// FIN MODIFICADO RICARDO 04-02-26

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'n_remesa'
			this.post event csd_formatea_n_remesa(data)
end choose
end event

type tabpage_1 from userobject within tab_1
string tag = "texto=cobros.facturas"
integer x = 18
integer y = 100
integer width = 2295
integer height = 1944
long backcolor = 79741120
string text = "Facturas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_factu dw_factu
end type

on tabpage_1.create
this.dw_factu=create dw_factu
this.Control[]={this.dw_factu}
end on

on tabpage_1.destroy
destroy(this.dw_factu)
end on

type dw_factu from u_dw within tabpage_1
integer x = 37
integer y = 16
integer width = 2185
integer height = 1908
integer taborder = 10
string dataobject = "d_facturacion_emitida_cobros_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;this.accepttext()
string id_persona,cuenta
// C$$HEX1$$f300$$ENDHEX$$digo a ejecutar cuando se pincha sobre el btn de B$$HEX1$$fa00$$ENDHEX$$squeda asociado a la persona a la que
//  se le ha emitido la factura

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.n_colegiado_vapido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_persona',id_persona)
				if this.getitemstring(1,'tipo_factura') ='04' then
					this.SetItem(1,'n_col_honorario',f_colegiado_n_col(id_persona))				
				else
					this.SetItem(1,'n_col',f_colegiado_n_col(id_persona))				
				end if
			end if

		CASE 'b_busqueda_clientes_exp'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
			g_busqueda.dw="d_lista_busqueda_clientes"
			id_persona=f_busqueda_clientes_exp()
		
			if id_persona="-1" then
				messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.n_cliente_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.'))
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_persona',id_persona)
				this.SetItem(1,'nif',f_dame_nif(id_persona))				
			end if
			
		CASE 'b_busqueda_clientes_csi'
//			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes Generales"
//			g_busqueda.dw="d_lista_busqueda_clientes_csi"
//			id_persona=f_busqueda_clientes_csi()
//
//			if id_persona="-1" then
//				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
//				this.setfocus()
//				return -1
//			else
//				this.SetItem(1,'id_persona',id_persona)
//				this.SetItem(1,'n_col',f_csi_dame_codigo(id_persona))				
//			end if
end choose

RETURN 1

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)



//if g_conta.enlace_facturas = 'MINUTAS' then
//	dw_1.object.documento_t.text = 'Aviso:'
//end if
end event

event doubleclicked;call super::doubleclicked;// Lanzamos la func. que sirve para las ventanas de detalle, consulta, listado
f_btn_busqueda_facturas(this, dwo.name, row)
end event

event itemchanged;call super::itemchanged;string ls_null
setnull(ls_null)
CHOOSE CASE dwo.name
	CASE 'tipo_factura'
		// Habilitamos el btn de busqueda correspondiente
//		post f_habilita_btn_busqueda_tipo_factura (this)
		CHOOSE CASE data
			CASE '03'
				this.object.b_busqueda_clientes_exp.visible = false
				this.object.b_busqueda_clientes_csi.visible = false
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col.visible = true
				this.object.n_col_honorario.visible = false
				this.setitem(1,'n_col_honorario', ls_null)
			CASE '02'
				this.object.b_busqueda_clientes_exp.visible = true
				this.object.b_busqueda_clientes_csi.visible = false
				this.object.b_busqueda_colegiados.visible = false
				this.object.n_col.visible = true
				this.object.n_col_honorario.visible = false
				this.setitem(1,'n_col_honorario', ls_null)
			CASE '04'
				this.object.b_busqueda_clientes_exp.visible = false
				this.object.b_busqueda_clientes_csi.visible = false
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col.visible = false
				this.object.n_col_honorario.visible = true
				this.setitem(1,'n_col', ls_null)
			CASE ELSE
				this.object.b_busqueda_clientes_exp.visible = true
				this.object.b_busqueda_clientes_csi.visible = false
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col_honorario.visible = false
				this.object.n_col.visible = true
		END CHOOSE
	CASE 'serie'
		this.SetItem(1,'n_fact','')
		this.SetItem(1,'n_fact_desde','')
		this.SetItem(1,'n_fact_hasta','')		
		//En este caso ponemos en el n_factura el nombre de la serie
		if LeftA(data,6) <> 'COLEGI' then
			this.SetItem(1,'n_fact',data)
		else
			this.SetItem(1,'n_fact_desde',FillA('0',15))
			this.SetItem(1,'n_fact_hasta',FillA('9',15))
		end if

END CHOOSE

end event

type cbx_acumular from checkbox within w_cobros_domicilia_consulta
string tag = "texto=cobros.acumular_consulta"
integer x = 2418
integer y = 1036
integer width = 512
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
string text = "Acumular Consulta"
end type

