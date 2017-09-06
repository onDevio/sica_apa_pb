HA$PBExportHeader$w_cobros_listados.srw
forward
global type w_cobros_listados from w_listados
end type
end forward

global type w_cobros_listados from w_listados
integer height = 2276
string title = "Listados de Cobros"
end type
global w_cobros_listados w_cobros_listados

on w_cobros_listados.create
call super::create
end on

on w_cobros_listados.destroy
call super::destroy
end on

event open;call super::open;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)

dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

// Se desplaza el apuntador al primer registro
dw_listados_varios.scrolltorow(1)
dw_listados_varios.setfocus()

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_cobros_listados
string tag = "texto=general.recuperar_consulta"
boolean visible = true
integer x = 626
integer y = 2052
integer width = 503
integer height = 96
string text = "Recuperar consulta"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_cobros_listados
string tag = "texto=general.guardar_consulta"
boolean visible = true
integer x = 73
integer y = 2052
integer width = 503
integer height = 96
string text = "Guardar consulta"
end type

type cb_limpiar from w_listados`cb_limpiar within w_cobros_listados
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_cobros_listados
end type

event dw_listados_varios::clicked;call super::clicked;string listado

listado = this.getitemstring(row,'dw')
choose case listado
		case 'd_caja_salidas_listado_cm', 'd_caja_listado_diario_caja_tg', 'd_caja_listado_talones_tg', 'd_caja_salidas_listado_cm_mca'
			
			if g_colegio<>'COAATMCA' then
				dw_listados.setitem(1,'cod_usuario', g_usuario)
			end if
			dw_listados.setitem(1,'centro', g_centro_por_defecto)
			if f_puedo_escribir(g_usuario,'INFORME CAJA') = 1 then
				dw_listados.object.cod_usuario.protect=false
			end if
			dw_listados.setitem(1,'cf_desde', today())
			dw_listados.setitem(1,'cf_hasta', today())
	end choose
end event

type cb_ver from w_listados`cb_ver within w_cobros_listados
end type

event cb_ver::clicked;call super::clicked;string sql,listado,sql_exp, sql_no_exp, sql_resumen, sql_multiples, sql_liq, sql_resumen_liq, sql_cmult
boolean b_visualizar
int i
st_datos_empresa_emisora lst_datos_empresa_emisora
datetime desde, hasta

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

dw_listados.setitem(1,'id_persona','')

// Como los listados con composite tardan m$$HEX1$$e100$$ENDHEX$$s fijo el cursor a arena pa que no me haga nada el usuario mientras
setpointer(hourglass!)
choose case listado
	case 'd_cobros_listado_remesa','d_cobros_listado_remesa_mca'
		if g_colegio = 'COAATCC' then
			dw_1.dataobject = 'd_cobros_listado_remesa_cc'
			dw_1.of_settransobject(sqlca)
		end if
		f_sql('domiciliaciones.ref_interna','=','n_remesa',dw_listados,sql,g_tipo_base_datos,'')	
		
	case  'd_caja_salidas_listado_cm', 'd_caja_listado_diario_caja_tg', 'd_caja_listado_talones_tg', 'd_caja_salidas_listado_cm_mca'
		// Informe de Caja nuevo y Resumen de Caja
		desde = dw_listados.getitemdatetime( 1,'cf_desde')
		hasta = dw_listados.getitemdatetime( 1,'cf_hasta')
		
		if  isnull(desde) and  isnull(hasta) then
			Messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.ingresar_fecha_datos_caja', 'Debe ingresar la fecha en los datos de caja'))		
		end if
	
		datawindowchild dwc_cobros
		dw_1.GetChild('csi_cobros_multiples_banco', dwc_cobros)
		dwc_cobros.settransobject(SQLCA)
		dwc_cobros.retrieve(g_empresa)
//		dwc_cobros.SetFilter('empresa = '+g_empresa)
//		dwc_cobros.Filter()
		
		
	case 'd_cobros_listado_caja', 'd_cobros_listado_caja_gc'
		// Sacamos la SQL de cada uno de los dos datawindows existentes en el composite
		datawindowchild dwc_cobros_exp, dwc_cobros_no_exp, dwc_cobros_resumen, dwc_cobros_liq
		datawindowchild dwc_cobros_resumen_liq

		dw_1.GetChild('dw_cobros_caja_exp', dwc_cobros_exp)
		dw_1.GetChild('dw_cobros_caja_no_exp', dwc_cobros_no_exp)
		dw_1.GetChild('dw_cobros_caja_liq', dwc_cobros_liq)				
		dw_1.GetChild('dw_cobros_caja_resumen', dwc_cobros_resumen)
		dw_1.GetChild('dw_cobros_caja_resumen_liq', dwc_cobros_resumen_liq)
		
		dwc_cobros_exp.settransobject(SQLCA)
		dwc_cobros_no_exp.settransobject(SQLCA)
		dwc_cobros_liq.settransobject(SQLCA)				
		dwc_cobros_resumen.settransobject(SQLCA)
		dwc_cobros_resumen_liq.settransobject(SQLCA)
		
		sql_exp = dwc_cobros_exp.describe("Datawindow.Table.Select")
		sql_no_exp = dwc_cobros_no_exp.describe("Datawindow.Table.Select")
		sql_liq = dwc_cobros_liq.describe("Datawindow.Table.Select")		
		sql_resumen = dwc_cobros_resumen.describe("Datawindow.Table.Select")
		sql_resumen_liq = dwc_cobros_resumen_liq.describe("Datawindow.Table.Select")
		
		if g_colegio = 'COAATGC' then
			//Hacemos la consulta para el dataobject de liquidaciones
			f_sql('fases_liquidaciones.forma_pago','LIKE','forma_pago',dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','>=','df_pago',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','<','hf_pago',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.contabilizada','LIKE','c_contabilizado',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','>=','f_fact_desde',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','<','f_fact_hasta',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_liq,g_tipo_base_datos,'')
			
			//Hacemos la consulta para el dataobject de resumen de liquidaciones
			f_sql('fases_liquidaciones.forma_pago','LIKE','forma_pago',dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','>=','df_pago',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','<','hf_pago',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.contabilizada','LIKE','c_contabilizado',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','>=','f_fact_desde',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.f_liquidacion','<','f_fact_hasta',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')
			f_sql('fases_liquidaciones.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_resumen_liq,g_tipo_base_datos,'')						
		end if
		
		//Hacemos la consulta para el primero de los dataobjects
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')			
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')// Modificado Ricardo 2005-03-09. Consultamos unicamente las que no son a efectos de pago
		f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.nif','LIKE','nif',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','LIKE','n_col_honorario',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		
		
		//Hacemos la consulta para el segundo de los dataobjects
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')			

		//Hacemos la consulta para el tercer dataobjet
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')			


	case 'd_cobros_listado_caja_lr'
		// Sacamos la SQL de cada uno de los dos datawindows existentes en el composite
		datawindowchild dwc_cobros_multiples
		dw_1.GetChild('dw_cobros_caja_exp', dwc_cobros_exp)
		dw_1.GetChild('dw_cobros_caja_no_exp', dwc_cobros_no_exp)
		dw_1.GetChild('dw_cobros_multiples', dwc_cobros_multiples)
		dw_1.GetChild('dw_cobros_caja_resumen', dwc_cobros_resumen)
		dwc_cobros_exp.settransobject(SQLCA)
		dwc_cobros_no_exp.settransobject(SQLCA)
		dwc_cobros_multiples.settransobject(SQLCA)
		dwc_cobros_resumen.settransobject(SQLCA)
		sql_exp = dwc_cobros_exp.describe("Datawindow.Table.Select")
		sql_no_exp = dwc_cobros_no_exp.describe("Datawindow.Table.Select")
		sql_multiples = dwc_cobros_multiples.describe("Datawindow.Table.Select")
		sql_resumen = dwc_cobros_resumen.describe("Datawindow.Table.Select")
		
		//Hacemos la consulta para el primero de los dataobjects
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')			
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')// Modificado Ricardo 2005-03-09. Consultamos unicamente las que no son a efectos de pago
		f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.nif','LIKE','nif',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','LIKE','n_col_honorario',Parent.dw_listados,sql_exp,g_tipo_base_datos,'')

		//Hacemos la consulta para el segundo de los dataobjects
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_no_exp,g_tipo_base_datos,'')			

		// Hacemos la consulta para el de cobros multiples
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_multiples,g_tipo_base_datos,'')			

		//Hacemos el ultimo dataobject
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',dw_listados,sql_resumen,g_tipo_base_datos,'')
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql_resumen,g_tipo_base_datos,'')			

	case else
		//Hacer f_sql de todos los campos de la dw_listados
		f_sql('csi_cobros.forma_pago','LIKE','forma_pago',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.pagado','=','pagado',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.banco','LIKE','banco',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','>=','df_pago',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_pago','<','hf_pago',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.centro','LIKE','delegacion',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.n_remesa','=','n_remesa',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.contabilizado','LIKE','c_contabilizado',Parent.dw_listados,sql,g_tipo_base_datos,'')		
		f_sql('csi_cobros.f_vencimiento','>=','f_vcto_desde',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_cobros.f_vencimiento','<=','f_vcto_hasta',dw_listados,sql,g_tipo_base_datos,'')
		
		if (PosA(upper(sql), "WHERE") > 0) then
			sql += "AND csi_cobros.empresa='"+g_empresa+"'"
		else
			sql += " WHERE csi_cobros.empresa='"+g_empresa+"'"
		end if
		
		f_sql('csi_facturas_emitidas.n_fact','LIKE','serie',Parent.dw_listados,sql,g_tipo_base_datos,'')
		//f_sql('colegiados.delegacion','LIKE','delegacion',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','>=','n_fact_desde',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','<=','n_fact_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','>=','f_fact_desde',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.fecha','<','f_fact_hasta',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.contabilizada','LIKE','f_contabilizada',Parent.dw_listados,sql,g_tipo_base_datos,'')			
		f_sql('csi_facturas_emitidas.solo_pagos','LIKE','solo_pagos',Parent.dw_listados,sql,g_tipo_base_datos,'')// Modificado Ricardo 2005-03-09. Consultamos unicamente las que no son a efectos de pago
		f_sql('csi_facturas_emitidas.tipo_factura','LIKE','tipo_factura',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.id_persona','LIKE','id_persona',dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.nif','LIKE','nif',Parent.dw_listados,sql,g_tipo_base_datos,'')
		f_sql('csi_facturas_emitidas.n_fact','LIKE','n_col_honorario',Parent.dw_listados,sql,g_tipo_base_datos,'')
	
end choose

if listado = 'd_cobros_listado' then sql = ReplaceA(sql,PosA(sql,'*'),1,'')
if g_usuario = 'csd' then messagebox("sql", sql)
dw_1.SetTransobject(sqlca)

// En el listado de caja no modificamos la SQL pq es diferente
if listado<>'d_cobros_listado_caja' and listado<>'d_cobros_listado_caja_lr' and listado<>'d_cobros_listado_caja_gc'  and listado<> '' &
and  listado<>'d_caja_listado_talones_tg' and listado<>'d_caja_listado_diario_caja_tg'  then dw_1.modify("datawindow.table.select= ~"" + sql + "~"")
	string parametros_texto = ""
		datetime f_pago_cobro_desde,f_pago_cobro_hasta
choose case listado
	case 'd_cobros_listado_remesa','d_cobros_listado_remesa_mca'
		dw_1.retrieve('S') // Por el tema del retrieval argument de remesado	
		b_visualizar = (dw_1.RowCount() > 0)
		
	case 'd_cobros_listado'
		dw_1.retrieve()
		b_visualizar = (dw_1.RowCount() > 0)
//		int i
		string id_fact
		setpointer(hourglass!)
		for i=1 to dw_1.rowcount()
			id_fact = dw_1.getitemstring(i, 'id_factura')
			dw_1.setitem(i, 'n_reg', f_numero_registro_de_factura_emitida(id_fact))
			dw_1.setitem(i, 'n_exp', f_numero_expedi_de_factura_emitida(id_fact))
		next
		setpointer(arrow!)
		
	case 'd_cobros_listado_za'
		dw_1.retrieve()
		b_visualizar = (dw_1.RowCount() > 0)
		setpointer(hourglass!)
		for i=1 to dw_1.rowcount()
			id_fact = dw_1.getitemstring(i, 'id_factura')
			dw_1.setitem(i, 'n_reg', f_numero_salida_de_factura_emitida(id_fact))
			dw_1.setitem(i, 'n_exp', f_numero_expedi_de_factura_emitida(id_fact))
		next
		setpointer(arrow!)
		
	case 'd_caja_salidas_listado_cm', 'd_caja_listado_talones_tg' , 'd_caja_listado_diario_caja_tg' , 'd_caja_salidas_listado_cm_mca'
		string centro, usuario
		datetime f_desde, f_hasta

		centro= dw_listados.getitemstring(dw_listados.getRow(), 'centro')
		usuario = dw_listados.getitemstring(dw_listados.getRow(), 'cod_usuario')
		f_desde=datetime(date(dw_listados.GetItemDateTime(1,'cf_desde')), time('00:00:00'))
        	f_hasta=datetime(date(dw_listados.GetItemDateTime(1,'cf_hasta')), time('23:59:59'))
		
		if not isnull(f_desde) then parametros_texto = "Fecha  Desde: "+string(f_desde, "DD/MM/YYYY")+"     "
		if not isnull(f_hasta) then parametros_texto += "Fecha  Hasta: "+string(f_hasta, "DD/MM/YYYY")
		
		if isnull(centro) or centro = '' then centro = '%'
		if isnull(usuario) or usuario = '' then usuario = '%'
		
		//if listado = 'd_cobros_listado_informe_caja' then dw_1.object.parametros_t.text = parametros_texto
		
		sql = dw_1.describe("Datawindow.Table.Select")
		//messagebox("sql",sql)
		dw_1.retrieve(f_desde, f_hasta, centro, usuario, g_empresa)
		b_visualizar = (dw_1.RowCount() > 0)
		
	case 'd_cobros_listado_caja', 'd_cobros_listado_caja_gc'
	
		
		f_pago_cobro_desde = dw_listados.getitemDatetime(dw_listados.getRow(), 'df_pago')
		f_pago_cobro_hasta = dw_listados.getitemDatetime(dw_listados.getRow(), 'hf_pago')
		
		if not isnull(f_pago_cobro_desde) then parametros_texto = "Fecha Pago Desde: "+string(f_pago_cobro_desde, "DD/MM/YYYY")+"     "
		if not isnull(f_pago_cobro_hasta) then parametros_texto += "Fecha Pago Hasta: "+string(f_pago_cobro_hasta, "DD/MM/YYYY")
		
		// Metemos las fechas que me ha comentado Paco en el listados
		dw_1.object.parametros_t.text = parametros_texto
		// Colocamos la SQL de cada uno de los dataobjects, y retriveamos
		dwc_cobros_exp.modify("datawindow.table.select= ~"" + sql_exp + "~"")
		dwc_cobros_no_exp.modify("datawindow.table.select= ~"" + sql_no_exp + "~"")
		dwc_cobros_liq.modify("datawindow.table.select= ~"" + sql_liq + "~"")				
		dwc_cobros_resumen.modify("datawindow.table.select= ~"" + sql_resumen + "~"")
		dwc_cobros_resumen_liq.modify("datawindow.table.select= ~"" + sql_resumen_liq + "~"")
		
		// REtriveamos cada uno de los reports
		if dwc_cobros_exp.retrieve()>0 then b_visualizar = true
		if dwc_cobros_no_exp.retrieve()>0 then b_visualizar = true
		if dwc_cobros_liq.retrieve()>0 then b_visualizar = true		
		if dwc_cobros_resumen.retrieve()>0 then b_visualizar = true
		if dwc_cobros_resumen_liq.retrieve()>0 then b_visualizar = true		
		
	case 'd_cobros_listado_caja_lr'
		f_pago_cobro_desde = dw_listados.getitemDatetime(dw_listados.getRow(), 'df_pago')
		f_pago_cobro_hasta = dw_listados.getitemDatetime(dw_listados.getRow(), 'hf_pago')
		
		if not isnull(f_pago_cobro_desde) then parametros_texto = "Fecha Pago Desde: "+string(f_pago_cobro_desde, "DD/MM/YYYY")+"     "
		if not isnull(f_pago_cobro_hasta) then parametros_texto += "Fecha Pago Hasta: "+string(f_pago_cobro_hasta, "DD/MM/YYYY")
		
		// Metemos las fechas que me ha comentado Paco en el listados
		dw_1.object.parametros_t.text = parametros_texto
		// Colocamos la SQL de cada uno de los dataobjects, y retriveamos
		dwc_cobros_exp.modify("datawindow.table.select= ~"" + sql_exp + "~"")
		dwc_cobros_no_exp.modify("datawindow.table.select= ~"" + sql_no_exp + "~"")
		dwc_cobros_multiples.modify("datawindow.table.select= ~"" + sql_multiples + "~"")
		dwc_cobros_resumen.modify("datawindow.table.select= ~"" + sql_resumen + "~"")
		// REtriveamos cada uno de los reports
		if dwc_cobros_exp.retrieve()>0 then b_visualizar = true
		if dwc_cobros_no_exp.retrieve()>0 then b_visualizar = true
		if dwc_cobros_multiples.retrieve()>0 then b_visualizar = true
		if dwc_cobros_resumen.retrieve()>0 then b_visualizar = true
		
	case else
		dw_1.retrieve()
		b_visualizar = (dw_1.RowCount() > 0)
end choose



//SCP-1269  Busca la etiqueta p_logo_empresa y si existe la substituye por la image correspondiente para la empresa.
f_rellena_st_datos_empresa(lst_datos_empresa_emisora , g_empresa)

if g_activa_multiempresa = 'S' then
	//choose case g_colegio
		//case 'COAATGU', 'COAATTFE', 'COAATTGN', 'COAATA', 'COAATAVI', 'COAATZ', 'COAATLE', 'COAATGUI', 'COAATB','COAATNA', 'COAATTER'
			if not f_es_vacio(lst_datos_empresa_emisora.logo_empresa)then
				if lower(dw_1.describe("p_logo_empresa.name")) = 'p_logo_empresa' then 
					dw_1.Object.p_logo_empresa.Filename = "..\imagenes\" + lst_datos_empresa_emisora.logo_empresa 
					//.\imagenes\coaatmca_logo.jpg
				end if	
			end if	
	//end choose
end if	

//END SCP-1269 

//Al final: // ->  Modificado por Ricardo porque cuando un listado es un composite siempre aparecia
if b_visualizar then
	dw_1.visible = true
	// No se puede hacer un printpreview de un composite
	if dw_1.Describe("DataWindow.Nested") = "no" then dw_1.event pfc_printpreview()
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
	// Devuelvo el estado normal
	setpointer(arrow!)
else
	// Devuelvo el estado normal
	setpointer(arrow!)
	messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.no_encontrado_registros','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if	

end event

type cb_salir from w_listados`cb_salir within w_cobros_listados
end type

type dw_listados from w_listados`dw_listados within w_cobros_listados
event csd_formatea_n_remesa ( string dato )
integer y = 184
integer width = 1947
integer height = 1808
string dataobject = "d_cobros_domicilia_consulta"
end type

event dw_listados::csd_formatea_n_remesa(string dato);string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	this.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event dw_listados::csd_oculta;call super::csd_oculta;string sql,listado

listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
choose case listado
	case 'd_cobros_listado_remesa'
		dw_listados.object.gb_1.visible = false
		dw_listados.object.gb_2.visible = false		
		dw_listados.object.n_fact_desde.visible = false				
		dw_listados.object.n_fact_hasta.visible = false		
		dw_listados.object.n_fact_desde_t.visible = false		
		dw_listados.object.n_fact_hasta_t.visible = false				
		dw_listados.object.f_fact_desde.visible = false						
		dw_listados.object.f_fact_hasta.visible = false		
		dw_listados.object.f_fact_desde_t.visible = false		
		dw_listados.object.f_fact_hasta_t.visible = false	
		
		dw_listados.object.f_vcto_desde.visible = false						
		dw_listados.object.f_vcto_hasta.visible = false		
		dw_listados.object.f_vcto_desde_t.visible = false		
		dw_listados.object.f_vcto_hasta_t.visible = false	
		
		dw_listados.object.delegacion.visible = false				
		dw_listados.object.delegacion_t.visible = false						
		dw_listados.object.serie.visible = false						
		dw_listados.object.serie_t.visible = false								
		dw_listados.object.n_remesa.visible = true
		dw_listados.object.n_remesa_t.visible = true
		dw_listados.object.forma_pago.visible = false								
		dw_listados.object.forma_pago_t.visible = false										
		dw_listados.object.pagado.visible = false		
		dw_listados.object.pagado_t.visible = false			
		dw_listados.object.banco.visible = false		
		dw_listados.object.banco_t.visible = false		
		dw_listados.object.df_pago.visible = false		
		dw_listados.object.df_pago_t.visible = false				
		dw_listados.object.hf_pago.visible = false				
		dw_listados.object.hf_pago_t.visible = false	
		this.object.t_1.visible = false
		this.object.f_contabilizada.visible = false
		this.object.t_2.visible = false
		this.object.c_contabilizado.visible = false
		this.object.solo_pagos_t.visible = false
		this.object.solo_pagos.visible = false
		
		this.object.n_col.visible = false
		this.object.tipo_factura.visible = false
		this.object.nif.visible = false
		this.object.n_col_t.visible = false
		this.object.t_4.visible = false
		this.object.t_3.visible = false
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_remesa.visible = false
		//Cambio realizado por Luis para incidencia cgn-256 13/01/2009
		if(g_colegio='COAATTGN' or g_colegio = 'COAATTEB' or g_colegio='COAATLL')then
			this.object.b_busqueda_remesa.visible = true
		end if
		
		this.object.t_5.visible = false
		this.object.t_8.visible = false
		this.object.t_7.visible = false
		this.object.t_6.visible = false
		this.object.gb_3.visible = false
		this.object.cod_usuario.visible = false
		this.object.centro.visible = false
		this.object.cf_desde.visible = false
		this.object.cf_hasta.visible = false
		
	case  'd_caja_salidas_listado_cm', 'd_caja_listado_diario_caja_tg', 'd_caja_listado_talones_tg', 'd_caja_salidas_listado_cm_mca'
		
		dw_listados.object.gb_1.visible = false
		dw_listados.object.gb_2.visible = false		
		dw_listados.object.n_fact_desde.visible = false				
		dw_listados.object.n_fact_hasta.visible = false		
		dw_listados.object.n_fact_desde_t.visible = false		
		dw_listados.object.n_fact_hasta_t.visible = false				
		dw_listados.object.f_fact_desde.visible = false						
		dw_listados.object.f_fact_hasta.visible = false		
		dw_listados.object.f_fact_desde_t.visible = false		
		dw_listados.object.f_fact_hasta_t.visible = false	
		
		dw_listados.object.f_vcto_desde.visible = false						
		dw_listados.object.f_vcto_hasta.visible = false		
		dw_listados.object.f_vcto_desde_t.visible = false		
		dw_listados.object.f_vcto_hasta_t.visible = false	
		
		dw_listados.object.delegacion.visible = false				
		dw_listados.object.delegacion_t.visible = false						
		dw_listados.object.serie.visible = false						
		dw_listados.object.serie_t.visible = false								
		dw_listados.object.n_remesa.visible = false
		dw_listados.object.n_remesa_t.visible = false
		dw_listados.object.forma_pago.visible = false								
		dw_listados.object.forma_pago_t.visible = false										
		dw_listados.object.pagado.visible = false		
		dw_listados.object.pagado_t.visible = false			
		dw_listados.object.banco.visible = false		
		dw_listados.object.banco_t.visible = false		
		dw_listados.object.df_pago.visible = false		
		dw_listados.object.df_pago_t.visible = false				
		dw_listados.object.hf_pago.visible = false				
		dw_listados.object.hf_pago_t.visible = false	
		this.object.t_1.visible = false
		this.object.f_contabilizada.visible = false
		this.object.t_2.visible = false
		this.object.c_contabilizado.visible = false
		this.object.solo_pagos_t.visible = false
		this.object.solo_pagos.visible = false
		
		this.object.n_col.visible = false
		this.object.tipo_factura.visible = false
		this.object.nif.visible = false
		this.object.n_col_t.visible = false
		this.object.t_4.visible = false
		this.object.t_3.visible = false
		this.object.b_busqueda_colegiados.visible = false
		this.object.b_busqueda_clientes_exp.visible = false
		this.object.b_busqueda_remesa.visible = false
		
		this.object.t_5.visible = true
		this.object.t_8.visible = true
		this.object.t_7.visible = true
		this.object.t_6.visible = true
		this.object.gb_3.visible = true
		this.object.cod_usuario.visible = true
		this.object.centro.visible = true
		this.object.cf_desde.visible = true
		this.object.cf_hasta.visible = true
		
	case else
		dw_listados.object.gb_1.visible = true
		dw_listados.object.gb_2.visible = true		
		dw_listados.object.n_fact_desde.visible = true				
		dw_listados.object.n_fact_hasta.visible = true		
		dw_listados.object.n_fact_desde_t.visible = true		
		dw_listados.object.n_fact_hasta_t.visible = true	
		dw_listados.object.f_fact_desde.visible = true						
		dw_listados.object.f_fact_hasta.visible = true		
		dw_listados.object.f_fact_desde_t.visible = true		
		dw_listados.object.f_fact_hasta_t.visible = true
		
		dw_listados.object.f_vcto_desde.visible = true						
		dw_listados.object.f_vcto_hasta.visible = true		
		dw_listados.object.f_vcto_desde_t.visible = true		
		dw_listados.object.f_vcto_hasta_t.visible = true	
		
		dw_listados.object.delegacion.visible = true				
		dw_listados.object.delegacion_t.visible = true						
		dw_listados.object.serie.visible = true						
		dw_listados.object.serie_t.visible = true								
		dw_listados.object.n_remesa.visible = true
		dw_listados.object.n_remesa_t.visible = true
		dw_listados.object.forma_pago.visible = true								
		dw_listados.object.forma_pago_t.visible = true										
		dw_listados.object.pagado.visible = true		
		dw_listados.object.pagado_t.visible = true			
		dw_listados.object.banco.visible = true		
		dw_listados.object.banco_t.visible = true		
		dw_listados.object.df_pago.visible = true		
		dw_listados.object.df_pago_t.visible = true				
		dw_listados.object.hf_pago.visible = true				
		dw_listados.object.hf_pago_t.visible = true		
		dw_listados.object.solo_pagos_t.visible = true
		dw_listados.object.solo_pagos.visible = true
		
		this.object.n_col.visible = true
		this.object.tipo_factura.visible = true
		this.object.nif.visible = true
		this.object.n_col_t.visible = true
		this.object.t_4.visible = true
		this.object.t_3.visible = true
		this.object.b_busqueda_colegiados.visible = true
		this.object.b_busqueda_clientes_exp.visible = true
		this.object.b_busqueda_remesa.visible = true
		
		this.object.t_1.visible = true
		this.object.f_contabilizada.visible = true
		this.object.t_2.visible = true
		this.object.c_contabilizado.visible = true
		this.object.solo_pagos_t.visible = true
		this.object.solo_pagos.visible = true
		
		
		this.object.t_5.visible = false
		this.object.t_8.visible = false
		this.object.t_7.visible = false
		this.object.t_6.visible = false
		this.object.gb_3.visible = false
		this.object.cod_usuario.visible = false
		this.object.centro.visible = false
		this.object.cf_desde.visible = false
		this.object.cf_hasta.visible = false
end choose

end event

event dw_listados::buttonclicked;call super::buttonclicked;string remesa, id_persona

CHOOSE CASE dwo.name
	CASE 'b_busqueda_remesa'
		g_busqueda.titulo = 'B$$HEX1$$fa00$$ENDHEX$$squeda de remesas de cobros'
		g_busqueda.dw = 'd_lista_busqueda_remesas_cobros'		
		open(w_busqueda_remesas_cobros)
		remesa = message.stringparm
		this.setitem(1, 'n_remesa', remesa)
		
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_persona=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_persona="-1" then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.n_colegiado_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
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

END CHOOSE

end event

event dw_listados::itemchanged;call super::itemchanged;string ls_null
setnull(ls_null)

CHOOSE CASE dwo.name
	CASE 'n_remesa'
			this.post event csd_formatea_n_remesa(data)

	CASE 'tipo_factura'
		CHOOSE CASE data
			CASE '03'
				this.object.b_busqueda_clientes_exp.visible = false
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col.visible = true
				this.object.n_col_honorario.visible = false
				this.setitem(1,'n_col_honorario', ls_null)
			CASE '02'
				this.object.b_busqueda_clientes_exp.visible = true
				this.object.b_busqueda_colegiados.visible = false
				this.object.n_col.visible = true
				this.object.n_col_honorario.visible = false
				this.setitem(1,'n_col_honorario', ls_null)
			CASE '04'
				this.object.b_busqueda_clientes_exp.visible = false
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col.visible = false
				this.object.n_col_honorario.visible = true
				this.setitem(1,'n_col', ls_null)
			CASE ELSE
				this.object.b_busqueda_clientes_exp.visible = true
				this.object.b_busqueda_colegiados.visible = true
				this.object.n_col_honorario.visible = false
				this.object.n_col.visible = true
		END CHOOSE
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_cobros_listados
end type

type cb_zoom from w_listados`cb_zoom within w_cobros_listados
end type

type cb_esp from w_listados`cb_esp within w_cobros_listados
end type

type cb_guardar from w_listados`cb_guardar within w_cobros_listados
end type

type cb_escala from w_listados`cb_escala within w_cobros_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_cobros_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_cobros_listados
end type

type dw_1 from w_listados`dw_1 within w_cobros_listados
integer width = 3593
integer height = 1784
end type

event dw_1::retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

