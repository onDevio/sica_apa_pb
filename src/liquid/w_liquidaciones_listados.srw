HA$PBExportHeader$w_liquidaciones_listados.srw
forward
global type w_liquidaciones_listados from w_listados
end type
type rb_numero from radiobutton within w_liquidaciones_listados
end type
type rb_nombre from radiobutton within w_liquidaciones_listados
end type
type gb_1 from groupbox within w_liquidaciones_listados
end type
end forward

global type w_liquidaciones_listados from w_listados
integer height = 1784
string title = "Listados de Liquidaciones"
rb_numero rb_numero
rb_nombre rb_nombre
gb_1 gb_1
end type
global w_liquidaciones_listados w_liquidaciones_listados

on w_liquidaciones_listados.create
int iCurrent
call super::create
this.rb_numero=create rb_numero
this.rb_nombre=create rb_nombre
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_numero
this.Control[iCurrent+2]=this.rb_nombre
this.Control[iCurrent+3]=this.gb_1
end on

on w_liquidaciones_listados.destroy
call super::destroy
destroy(this.rb_numero)
destroy(this.rb_nombre)
destroy(this.gb_1)
end on

event open;call super::open;inv_resize.of_Register (dw_1,"FixedtoRight&Bottom")
inv_resize.of_Register (gb_1,"FixedtoBottom")
inv_resize.of_Register (rb_numero,"FixedtoBottom")
inv_resize.of_Register (rb_nombre,"FixedtoBottom")
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()



end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_liquidaciones_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_liquidaciones_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_liquidaciones_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_liquidaciones_listados
integer y = 176
end type

event dw_listados_varios::rowfocuschanged;call super::rowfocuschanged;string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')

choose case listado
	case 'd_liquidacion_listado'
		parent.gb_1.visible = true
		parent.rb_nombre.visible = true
		parent.rb_numero.visible = true
		rb_nombre.checked = true
	case 'd_liquidacion_listado_por_colegiado'		
		parent.gb_1.visible = false
		parent.rb_nombre.visible = false
		parent.rb_numero.visible = false
		rb_numero.checked = true
	case 'd_liquidacion_listado_por_colegiado_ext'
		parent.gb_1.visible = true
		parent.rb_nombre.visible = true
		parent.rb_numero.visible = true
		rb_numero.checked = true		
	case 'd_liquidacion_listado_banco'
		parent.gb_1.visible = true
		parent.rb_nombre.visible = true
		parent.rb_numero.visible = true
		rb_nombre.checked = true		
	case 'd_liquidacion_listado_colegiado', 'd_liquidacion_listado_colegiado_gc'
		parent.gb_1.visible = false
		parent.rb_nombre.visible = false
		parent.rb_numero.visible = false
		rb_nombre.checked = true		
	case 'd_liquidacion_listado_minutas'
		parent.gb_1.visible = false
		parent.rb_nombre.visible = false
		parent.rb_numero.visible = false
		rb_nombre.checked = true		
	case 'd_liquidacion_listado_minutas_colegiado'
		parent.gb_1.visible = false
		parent.rb_nombre.visible = false
		parent.rb_numero.visible = false	
		rb_nombre.checked = true
	case 'd_informe_diario_caja_cgc_gu', 'd_informe_diario_caja_sgc_gu', &
		  'd_informe_diario_caja_cgc_le', 'd_informe_diario_caja_sgc_le'
		rb_nombre.checked = true
		rb_numero.checked = false
end choose

end event

type cb_ver from w_listados`cb_ver within w_liquidaciones_listados
end type

event cb_ver::clicked;call super::clicked;string sql,sql_aux, listado,exp,c1,c2,n
datetime f_liq_desde, f_liq_hasta
int i
datastore d_detalle_liquidaciones

g_ultima_consulta = ''

dw_listados.accepttext()
dw_1.of_SetPrintPreview(TRUE)
// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
sql=''
dw_1.of_SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

//Listado de liquidaciones externa
if listado = 'd_liquidacion_listado_por_colegiado_ext' then
	dw_1.dataobject = 'd_liquidacion_listado_por_colegiado'
	sql=''
	dw_1.of_SetTransObject(SQLCA)
	sql = dw_1.describe("datawindow.table.select")
	
	d_detalle_liquidaciones = create datastore
	d_detalle_liquidaciones.dataobject = listado
end if
// ----
choose case listado
	case 'd_liquidacion_listado_colegiado', 'd_liquidacion_listado_colegiado_gc'
		// Solo colegiados, fecha y delegacion
		f_sql('fases_minutas.id_colegiado','=','id_col',dw_listados,sql,g_tipo_base_datos,'Colegiado')		
		f_sql('fases.modalidad','=','cod_delegacion',dw_listados,sql,g_tipo_base_datos,'Delegaci$$HEX1$$f300$$ENDHEX$$n')
	case 'd_liquidacion_listado_minutas', 'd_liquidacion_listado_minutas_colegiado'
		// Solo colegiados, fecha y delegacion
		f_sql('fases_minutas.id_colegiado','=','id_col',dw_listados,sql,g_tipo_base_datos,'Colegiado')	
		f_sql('fases_minutas.fecha_pago','>=','df_liq',dw_listados,sql,g_tipo_base_datos,'Fecha Pago')
		f_sql('fases_minutas.fecha_pago','<','hf_liq',dw_listados,sql,g_tipo_base_datos,'Fecha Pago')		
		f_sql('fases.modalidad','=','cod_delegacion',dw_listados,sql,g_tipo_base_datos,'Delegaci$$HEX1$$f300$$ENDHEX$$n')
	case 'd_informe_diario_caja_sgc_za', 'd_informe_diario_caja_sgc_gu', 'd_informe_diario_caja_sgc_le', 'd_informe_diario_caja_sgc_avi','d_informe_diario_caja_sgc_ter2'
		f_sql('fases_minutas.fecha_pago','>=','df_liq',dw_listados,sql,g_tipo_base_datos,'Fecha Pago')
		f_sql('fases_minutas.fecha_pago','<','hf_liq',dw_listados,sql,g_tipo_base_datos,'Fecha Pago')		
	case 'd_informe_diario_caja_cgc_za', 'd_informe_diario_caja_cgc_gu', 'd_informe_diario_caja_cgc_le', 'd_informe_diario_caja_cgc_avi'
		// no hacemos f_sqls
		/*
	case 'd_liquidacion_listado_banco_za'
//		f_sql('csi_bancos.empresa','=',g_empresa,dw_listados,sql,g_tipo_base_datos,'empresa')
		sql = sql + " AND csi_bancos.empresa = '" + string(g_empresa) + "'"
		*/
	case else
		f_sql('fases_liquidaciones.id_liquidacion','LIKE','id_liquidacion',dw_listados,sql,'1','N$$HEX2$$ba002000$$ENDHEX$$Liquidaci$$HEX1$$f300$$ENDHEX$$n')
		f_sql('fases_liquidaciones.id_colegiado','LIKE','id_col',dw_listados,sql,'1','Colegiado')
		f_sql('fases_liquidaciones.estado','LIKE','estado',dw_listados,sql,'1','Estado')
		f_sql('fases_liquidaciones.contabilizada','LIKE','contabilizada',dw_listados,sql,'1','Contabilizada')
		f_sql('fases_liquidaciones.forma_pago','LIKE','forma_pago',dw_listados,sql,'1','Forma Pago')
		f_sql('fases_liquidaciones.f_liquidacion','>=','df_liq',Parent.dw_listados,sql,'1','Fecha Liquid.')
		f_sql('fases_liquidaciones.f_liquidacion','<','hf_liq',Parent.dw_listados,sql,'1','Fecha Liquid.')
		f_sql('fases_liquidaciones.id_fase','=','id_minuta',Parent.dw_listados,sql,'1','Aviso Factura')
		f_sql('fases_liquidaciones.n_documento','LIKE','n_documento',Parent.dw_listados,sql,'1','N$$HEX2$$ba002000$$ENDHEX$$Documento')
		f_sql('fases_liquidaciones.concepto','LIKE','concepto',Parent.dw_listados,sql,'1','Concepto')
		f_sql('fases_liquidaciones.tipo','=','tipo',Parent.dw_listados,sql,'1','Tipo')
		f_sql('fases_liquidaciones.f_entrada','>=','f_entrada_desde',Parent.dw_listados,sql,'1','Fecha Entrada')
		f_sql('fases_liquidaciones.f_entrada','<','f_entrada_hasta',Parent.dw_listados,sql,'1','Fecha Entrada')
		f_sql('fases_liquidaciones.cod_delegacion','=','cod_delegacion',dw_listados,sql,'1','Delegaci$$HEX1$$f300$$ENDHEX$$n')
		f_sql('fases_liquidaciones.importe','>=','importe_neto_desde',Parent.dw_listados,sql,'1','Importe')
		f_sql('fases_liquidaciones.importe','<','importe_neto_hasta',Parent.dw_listados,sql,'1','Importe')
		f_sql('fases_liquidaciones.saldo_deudor','>=','deudas_desde',Parent.dw_listados,sql,'1','Saldo Deudor')
		f_sql('fases_liquidaciones.saldo_deudor','<','deudas_hasta',Parent.dw_listados,sql,'1','Saldo Deudor')

end choose

//messagebox('',sql)

dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
if listado <> 'd_liquidacion_listado_colegiado' and listado <> 'd_liquidacion_listado_colegiado_gc' and &
	listado <> 'd_informe_diario_caja_cgc_za' and listado <> 'd_informe_diario_caja_cgc_gu' and &
	listado <> 'd_informe_diario_caja_cgc_le' and listado <> 'd_informe_diario_caja_cgc_avi' then
	dw_1.retrieve()
else
	f_liq_desde = datetime(date(dw_listados.getitemdatetime(1,'df_liq')), time('00:00:00'))
	f_liq_hasta = datetime(date(dw_listados.getitemdatetime(1,'hf_liq')), time('23:59:59'))
	dw_1.retrieve(f_liq_desde, f_liq_hasta)
end if

//Listado de liquidaciones externa
if listado = 'd_liquidacion_listado_por_colegiado_ext' then
	// Recorremos las lineas para ir acumulando los importe por colegiado 
	// y rellenando la datawindow externa
	string n_col = '', n_col_ant = '', cuenta, nom_col, cuenta_ant, nom_col_ant
	double importe_col, fila_nueva
	for i = 1 to dw_1.rowcount()
		n_col = dw_1.getitemstring(i, 'colegiados_n_colegiado')
		cuenta = dw_1.getitemstring(i, 'datos_bancarios')
		nom_col = dw_1.getitemstring(i, 'compute_1')
		if n_col <> n_col_ant then
			if n_col_ant <> '' then
				fila_nueva = d_detalle_liquidaciones.insertrow(0)
				d_detalle_liquidaciones.setitem(fila_nueva, 'n_col', n_col_ant)
				d_detalle_liquidaciones.setitem(fila_nueva, 'nom_col', nom_col_ant)
				d_detalle_liquidaciones.setitem(fila_nueva, 'cuenta', cuenta_ant)
				d_detalle_liquidaciones.setitem(fila_nueva, 'importe_total', importe_col)				
			end if
			importe_col = dw_1.getitemnumber(i, 'fases_liquidaciones_importe')
		else
			importe_col += dw_1.getitemnumber(i, 'fases_liquidaciones_importe')
		end if
		n_col_ant = n_col
		cuenta_ant = cuenta
		nom_col_ant = nom_col
		if i = dw_1.rowcount() then
			fila_nueva = d_detalle_liquidaciones.insertrow(0)
			d_detalle_liquidaciones.setitem(fila_nueva, 'n_col', n_col_ant)
			d_detalle_liquidaciones.setitem(fila_nueva, 'nom_col', nom_col_ant)
			d_detalle_liquidaciones.setitem(fila_nueva, 'cuenta', cuenta_ant)
			d_detalle_liquidaciones.setitem(fila_nueva, 'importe_total', importe_col)					
		end if
	next
	// Visualizaremos la datawindow externa
	dw_1.dataobject = 'd_liquidacion_listado_por_colegiado_ext'
	// Rellenamos la dw externa desde la datastore
	for i = 1 to d_detalle_liquidaciones.rowcount()
		fila_nueva = dw_1.insertrow(0)
		dw_1.setitem(fila_nueva, 'n_col', d_detalle_liquidaciones.getitemstring(i,'n_col'))
		dw_1.setitem(fila_nueva, 'nom_col', d_detalle_liquidaciones.getitemstring(i,'nom_col'))
		dw_1.setitem(fila_nueva, 'cuenta', d_detalle_liquidaciones.getitemstring(i,'cuenta'))
		dw_1.setitem(fila_nueva, 'importe_total', d_detalle_liquidaciones.getitemnumber(i,'importe_total'))				
	next
end if

// Al final:
if dw_1.rowcount() > 0 then
	if listado <> 'd_liquidacion_listado_colegiado' then 	dw_1.sort()
	dw_1.visible 		  = true
	dw_1.event pfc_printpreview()
	if dw_1.describe("t_parametros.name") = "t_parametros" then dw_1.object.t_parametros.text = g_ultima_consulta
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
	if rb_nombre.checked = true and rb_nombre.visible = true then rb_nombre.triggerevent(clicked!)
	if rb_numero.checked = true and rb_numero.visible = true then rb_numero.triggerevent(clicked!)	
else
	messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
end if

end event

type cb_salir from w_listados`cb_salir within w_liquidaciones_listados
end type

type dw_listados from w_listados`dw_listados within w_liquidaciones_listados
integer y = 176
integer height = 1300
string dataobject = "d_liquidacion_consulta"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_listados::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_listados::csd_oculta();call super::csd_oculta;string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')

//if listado = 'd_liquidacion_listado_colegiado' then
//	dw_listados.object.n_colegiado_t.visible = true
//	dw_listados.object.n_colegiado.visible = true	
//else
//	dw_listados.object.n_colegiado_t.visible = false
//	dw_listados.object.n_colegiado.visible = false
//end if

// Primero todo a false
dw_listados.object.n_colegiado.visible = false
dw_listados.object.n_colegiado_t.visible = false
dw_listados.object.b_busqueda_colegiados.visible = false
dw_listados.object.colegiado.visible = false
dw_listados.object.n_documento.visible = false
dw_listados.object.documento_t.visible = false
dw_listados.object.n_aviso.visible = false
dw_listados.object.n_aviso_t.visible = false
dw_listados.object.estado.visible = false
dw_listados.object.estado_t.visible = false
dw_listados.object.contabilizada.visible = false
dw_listados.object.contabilizada_t.visible = false
dw_listados.object.f_entrada_desde.visible = false
dw_listados.object.f_entrada_desde_t.visible = false
dw_listados.object.f_entrada_hasta.visible = false
dw_listados.object.df_liq.visible = false
dw_listados.object.df_liq_t.visible = false
dw_listados.object.hf_liq.visible = false
dw_listados.object.importe_neto_desde.visible = false
dw_listados.object.importe_neto_desde_t.visible = false
dw_listados.object.importe_neto_hasta.visible = false
dw_listados.object.deudas_desde.visible = false
dw_listados.object.deudas_desde_t.visible = false
dw_listados.object.deudas_hasta.visible = false
dw_listados.object.cod_delegacion.visible = false
dw_listados.object.delegacion_t.visible = false
dw_listados.object.concepto.visible = false
dw_listados.object.concepto_t.visible = false
dw_listados.object.tipo.visible = false
dw_listados.object.tipo_t.visible = false
dw_listados.object.forma_pago.visible = false
dw_listados.object.forma_pago_t.visible = false

choose case listado
	case 'd_informe_diario_caja_cgc_za', 'd_informe_diario_caja_sgc_za', &
		  'd_informe_diario_caja_cgc_gu', 'd_informe_diario_caja_sgc_gu', &
		  'd_informe_diario_caja_cgc_le', 'd_informe_diario_caja_sgc_le', &
		  'd_informe_diario_caja_cgc_avi', 'd_informe_diario_caja_sgc_avi'
		dw_listados.object.df_liq.visible = true
		dw_listados.object.df_liq_t.visible = true
		dw_listados.object.hf_liq.visible = true
		
	case 'd_liquidacion_listado_colegiado', 'd_liquidacion_listado_colegiado_gc'
		// Solo colegiados, fecha y delegacion
		dw_listados.object.n_colegiado_t.visible = true
		dw_listados.object.n_colegiado.visible = true
		dw_listados.object.b_busqueda_colegiados.visible = true
		dw_listados.object.colegiado.visible = true
		dw_listados.object.df_liq.visible = true
		dw_listados.object.df_liq_t.visible = true
		dw_listados.object.hf_liq.visible = true
		dw_listados.object.cod_delegacion.visible = true
		dw_listados.object.delegacion_t.visible = true
		
	case 'd_liquidacion_listado_minutas', 'd_liquidacion_listado_minutas_colegiado'
		// Solo colegiados, fecha y delegacion
		dw_listados.object.n_colegiado_t.visible = true
		dw_listados.object.n_colegiado.visible = true
		dw_listados.object.b_busqueda_colegiados.visible = true
		dw_listados.object.colegiado.visible = true		
		dw_listados.object.df_liq.visible = true
		dw_listados.object.df_liq_t.visible = true
		dw_listados.object.hf_liq.visible = true
		dw_listados.object.cod_delegacion.visible = true		
		dw_listados.object.delegacion_t.visible = true			
	case else
		dw_listados.object.n_colegiado.visible = true
		dw_listados.object.n_colegiado_t.visible = true
		dw_listados.object.b_busqueda_colegiados.visible = true
		dw_listados.object.colegiado.visible = true		
		dw_listados.object.n_documento.visible = true
		dw_listados.object.documento_t.visible = true
		dw_listados.object.n_aviso.visible = true
		dw_listados.object.n_aviso_t.visible = true
		dw_listados.object.estado.visible = true
		dw_listados.object.estado_t.visible = true
		dw_listados.object.contabilizada.visible = true
		dw_listados.object.contabilizada_t.visible = true
		dw_listados.object.f_entrada_desde.visible = true
		dw_listados.object.f_entrada_desde_t.visible = true
		dw_listados.object.f_entrada_hasta.visible = true
		dw_listados.object.df_liq.visible = true
		dw_listados.object.df_liq_t.visible = true
		dw_listados.object.hf_liq.visible = true
		dw_listados.object.importe_neto_desde.visible = true
		dw_listados.object.importe_neto_desde_t.visible = true
		dw_listados.object.importe_neto_hasta.visible = true
		dw_listados.object.deudas_desde.visible = true
		dw_listados.object.deudas_desde_t.visible = true
		dw_listados.object.deudas_hasta.visible = true
		dw_listados.object.cod_delegacion.visible = true
		dw_listados.object.delegacion_t.visible = true
		dw_listados.object.concepto.visible = true
		dw_listados.object.concepto_t.visible = true	
		dw_listados.object.tipo.visible = true
		dw_listados.object.tipo_t.visible = true
		dw_listados.object.forma_pago.visible = true
		dw_listados.object.forma_pago_t.visible = true
end choose

//string listado
//listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
//
//this.setredraw(false)
//this.reset()
//this.insertrow(0)
//
//this.setredraw(true)

end event

event dw_listados::buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_col)
			this.SetItem(1,'n_colegiado',f_colegiado_n_col(id_col))				
		end if
END CHOOSE

end event

event dw_listados::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_liquidaciones_listados
end type

type cb_zoom from w_listados`cb_zoom within w_liquidaciones_listados
end type

type cb_esp from w_listados`cb_esp within w_liquidaciones_listados
end type

type cb_guardar from w_listados`cb_guardar within w_liquidaciones_listados
end type

type cb_escala from w_listados`cb_escala within w_liquidaciones_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_liquidaciones_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_liquidaciones_listados
integer y = 1344
integer height = 112
end type

type dw_1 from w_listados`dw_1 within w_liquidaciones_listados
integer x = 18
integer height = 1312
string dataobject = "d_liquidacion_listado"
end type

type rb_numero from radiobutton within w_liquidaciones_listados
integer x = 183
integer y = 1552
integer width = 581
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
string text = "N$$HEX1$$fa00$$ENDHEX$$mero de Colegiado"
end type

event clicked;string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
choose case listado
	case 'd_liquidacion_listado'
		dw_1.setsort('fases_liquidaciones_f_liquidacion A, colegiados_n_colegiado A, fases_liquidaciones_importe A')
	case 'd_liquidacion_listado_por_colegiado'		
		dw_1.setsort('colegiados_n_colegiado A')		
	case 'd_liquidacion_listado_banco'
		dw_1.setsort('fases_liquidaciones_f_liquidacion A, colegiados_n_colegiado A')
	case 'd_liquidacion_listado_colegiado', 'd_liquidacion_listado_colegiado_gc'
//		dw_1.setsort('integer(n_aviso)')			
	case 'd_liquidacion_listado_minutas'
//		dw_1.setsort('colegiados_n_colegiado')		
	case 'd_liquidacion_listado_minutas_colegiado'
//		dw_1.setsort('colegiados_n_colegiado')
	case 'd_liquidacion_listado_por_colegiado_ext'
		dw_1.setsort('n_col')
	case 'd_informe_diario_caja_cgc_za', 'd_informe_diario_caja_sgc_za', &
		  'd_informe_diario_caja_cgc_gu', 'd_informe_diario_caja_sgc_gu', &
		  'd_informe_diario_caja_cgc_le', 'd_informe_diario_caja_sgc_le', &
		  'd_informe_diario_caja_cgc_avi', 'd_informe_diario_caja_sgc_avi'
		dw_1.setsort('fases_minutas_banco A, colegiados_n_colegiado A')
	case 'd_liquidacion_listado_completo'
		dw_1.setsort('num_col A')		
end choose
dw_1.sort()
dw_1.groupcalc()
end event

type rb_nombre from radiobutton within w_liquidaciones_listados
integer x = 814
integer y = 1548
integer width = 809
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
string text = "Nombre de Colegiado"
boolean checked = true
end type

event clicked;string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
choose case listado
	case 'd_liquidacion_listado'
		dw_1.setsort('fases_liquidaciones_f_liquidacion A, colegiados_apellidos A, fases_liquidaciones_importe A')
	case 'd_liquidacion_listado_por_colegiado'		
		dw_1.setsort('compute_1 A')		
	case 'd_liquidacion_listado_banco'
		dw_1.setsort('fases_liquidaciones_f_liquidacion A, colegiados_apellidos A')
	case 'd_liquidacion_listado_colegiado', 'd_liquidacion_listado_colegiado_gc'
//		dw_1.setsort('integer(n_aviso)')		
//	case 'd_liquidacion_listado_minutas'
//		dw_1.setsort('colegiados_n_colegiado')		
//	case 'd_liquidacion_listado_minutas_colegiado'
//		dw_1.setsort('colegiados_n_colegiado')
	case 'd_liquidacion_listado_por_colegiado_ext'
		dw_1.setsort('nom_col')
	case 'd_informe_diario_caja_cgc_za', 'd_informe_diario_caja_sgc_za', &
		  'd_informe_diario_caja_cgc_gu', 'd_informe_diario_caja_sgc_gu', &
		  'd_informe_diario_caja_cgc_le', 'd_informe_diario_caja_sgc_le', &
		  'd_informe_diario_caja_cgc_avi', 'd_informe_diario_caja_sgc_avi'
		dw_1.setsort('fases_minutas_banco A, colegiado A')
	case 'd_liquidacion_listado_completo'
		dw_1.setsort('colegiado A')
end choose
dw_1.sort()
dw_1.groupcalc()
end event

type gb_1 from groupbox within w_liquidaciones_listados
integer x = 78
integer y = 1476
integer width = 1614
integer height = 168
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordenado por"
end type

