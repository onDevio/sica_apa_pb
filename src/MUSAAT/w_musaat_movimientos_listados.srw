HA$PBExportHeader$w_musaat_movimientos_listados.srw
forward
global type w_musaat_movimientos_listados from w_listados
end type
end forward

global type w_musaat_movimientos_listados from w_listados
integer width = 3694
string title = "Listados de Movimientos de MUSAAT"
end type
global w_musaat_movimientos_listados w_musaat_movimientos_listados

on w_musaat_movimientos_listados.create
call super::create
end on

on w_musaat_movimientos_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

inv_resize.of_Register (dw_listados, "ScaletoRight&Bottom")
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_musaat_movimientos_listados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_musaat_movimientos_listados
string tag = "texto=general.recuperar_pantalla"
end type

type cb_limpiar from w_listados`cb_limpiar within w_musaat_movimientos_listados
string tag = "texto=general.limpiar_consulta"
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_musaat_movimientos_listados
integer x = 2158
integer width = 1157
end type

type cb_ver from w_listados`cb_ver within w_musaat_movimientos_listados
end type

event cb_ver::clicked;call super::clicked;string listado,  sql_nuevo, sql_copia

dw_listados.Accepttext()
//dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql_nuevo = dw_1.describe("Datawindow.Table.Select")
sql_copia = sql_nuevo


CHOOSE CASE listado
	CASE 'd_musaat_listado_lineas_sin_movimientos'
		f_sql('fases.n_expedi', 'LIKE', 'n_exp', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_facturas_emitidas.n_col', 'LIKE', 'n_col', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases_minutas.n_aviso', '>=', 'n_aviso', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_facturas_emitidas.fecha', '>=', 'f_factura_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_facturas_emitidas.fecha', '<', 'f_factura_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_lineas_fact_emitidas.total', '>=', 'importe_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_lineas_fact_emitidas.total', '<=', 'importe_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('expedientes.administracion', 'LIKE', 'obra_oficial', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases.modalidad', 'LIKE', 'modalidad', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases.n_registro', 'LIKE', 'n_registro', Parent.dw_listados,sql_nuevo, '1', '')
		
	CASE 'd_musaat_comprueba_fic_cc'

		f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_calculo_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.fecha_calculo', '<', 'f_calculo_hasta', Parent.dw_listados,sql_nuevo, '1', '')

		f_sql('csi_facturas_emitidas.fecha', '>=', 'f_factura_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('csi_facturas_emitidas.fecha', '<', 'f_factura_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		//f_sql('fases.n_registro', 'LIKE', 'n_registro', Parent.dw_listados,sql_nuevo, '1', '')

		
	CASE ELSE
		f_sql('fases.n_expedi', 'LIKE', 'n_exp', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.n_col', 'LIKE', 'n_col', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases_minutas.n_aviso', '>=', 'n_aviso', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.fecha_calculo', '>=', 'f_calculo_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.fecha_calculo', '<', 'f_calculo_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.fecha_notificacion', '>=', 'f_notific_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.fecha_notificacion', '<', 'f_notific_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.importe_vble', '>=', 'importe_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.importe_vble', '<=', 'importe_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.t_visado', '=', 't_visado', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.obra_oficial', 'LIKE', 'obra_oficial', Parent.dw_listados,sql_nuevo, '1', '')
//		f_sql('musaat_movimientos.aplica_10', 'LIKE', 'aplicado_10', Parent.dw_listados,sql_nuevo, '1', '')
//		f_sql('musaat_movimientos.anulado', 'LIKE', 'anulado', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases.modalidad', 'LIKE', 'modalidad', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.decenal', 'LIKE', 'decenal', Parent.dw_listados,sql_nuevo, '1', '')
		
		//SCP-891
		f_sql('musaat_movimientos.obra_iniciada', 'LIKE', 'obra_iniciada', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.f_renuncia', '>=', 'f_renuncia_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.f_renuncia', '<', 'f_renuncia_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.f_extorno', '>=', 'f_extorno_desde', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('musaat_movimientos.f_extorno', '<', 'f_extorno_hasta', Parent.dw_listados,sql_nuevo, '1', '')
		f_sql('fases.n_registro', 'LIKE', 'n_registro', Parent.dw_listados,sql_nuevo, '1', '')
END CHOOSE

if sql_nuevo=sql_copia then 
	MessageBox(g_titulo,g_idioma.of_getmsg('msg_musaat.especificar_param_busqueda','Ha de especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda'))
	return 1
else
	dw_1.SetTransobject(sqlca)
	dw_1.Modify("Datawindow.table.Select= ~"" + sql_nuevo + "~"")
	
	
//	messagebox("sql nuevo", sql_nuevo)
	
//	datetime f_desde, f_hasta
//	f_desde = dw_listados.getitemdatetime(1, 'f_calculo_desde')
//	f_hasta = dw_listados.getitemdatetime(1, 'f_calculo_hasta')
//	dw_1.retrieve(f_desde, f_hasta)
	if listado = 'd_musaat_listado_lineas_sin_movimientos' then
		dw_1.retrieve(g_codigos_conceptos.musaat_variable)
	else
		dw_1.retrieve()		
	end if
end if

if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.no_registros_especificaciones','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if	
	
end event

type cb_salir from w_listados`cb_salir within w_musaat_movimientos_listados
end type

type dw_listados from w_listados`dw_listados within w_musaat_movimientos_listados
integer height = 1596
string dataobject = "d_musaat_movimientos_consulta"
end type

event dw_listados::csd_oculta;call super::csd_oculta;string listado
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')

//dw_listados.reset()
//dw_listados.insertrow(1)
//
CHOOSE CASE listado
	CASE 'd_musaat_listado_lineas_sin_movimientos'
//		this.object.aplicado_10.visible = false
//		this.object.aplicado_10_t.visible = false
//		this.object.anulado.visible = false
//		this.object.anulado_t.visible = false

		this.object.n_exp_t.visible = true
		this.object.n_exp.visible = true
		this.object.t_1.visible = true
		this.object.n_visado.visible = true
		this.object.n_col_t.visible = true
		this.object.n_col.visible = true
		this.object.n_aviso_t.visible = true
		this.object.n_aviso.visible = true
		this.object.t_2.visible = true
		this.object.modalidad.visible = true
		this.object.obra_oficial_t.visible = true
		this.object.obra_oficial.visible = true
		this.object.t_3.visible = true
		this.object.decenal.visible = true
		this.object.importe_desde_t.visible = true
		this.object.importe_desde.visible = true
		this.object.importe_hasta.visible = true




		this.object.f_calculo_desde.visible = false
		this.object.f_calculo_desde_t.visible = false
		this.object.f_calculo_hasta.visible = false
		this.object.t_visado.visible = false
		this.object.t_visado_t.visible = false
		this.object.f_notific_desde_t.visible = false
		this.object.f_notific_desde.visible = false		
		this.object.f_notific_hasta.visible = false
		this.object.f_factura_desde_t.visible = true
		this.object.f_factura_desde.visible = true
		this.object.f_factura_hasta.visible = true
		this.object.f_renuncia_desde.visible = false
		this.object.f_renuncia_hasta.visible = false
		this.object.f_extorno_desde.visible = false
		this.object.f_extorno_hasta.visible = false
		this.object.obra_iniciada.visible = false
		this.object.t_4.visible = false
		this.object.t_5.visible = false
		this.object.t_6.visible = false
		
	CASE 'd_musaat_comprueba_fic_cc'
		this.object.f_calculo_desde.visible = true
		this.object.f_calculo_desde_t.visible = true
		this.object.f_calculo_hasta.visible = true
		this.object.t_visado.visible = false
		this.object.t_visado_t.visible = false
		this.object.f_notific_desde_t.visible = false
		this.object.f_notific_desde.visible = false		
		this.object.f_notific_hasta.visible = false
		this.object.f_factura_desde_t.visible = true
		this.object.f_factura_desde.visible = true
		this.object.f_factura_hasta.visible = true
		
		this.object.n_exp_t.visible = false
		this.object.n_exp.visible = false
		this.object.t_1.visible = false
		this.object.n_visado.visible = false
		this.object.n_col_t.visible = false
		this.object.n_col.visible = false
		this.object.n_aviso_t.visible = false
		this.object.n_aviso.visible = false
		this.object.t_2.visible = false
		this.object.modalidad.visible = false
		this.object.obra_oficial_t.visible = false
		this.object.obra_oficial.visible = false
		this.object.t_3.visible = false
		this.object.decenal.visible = false
		this.object.importe_desde_t.visible = false
		this.object.importe_desde.visible = false
		this.object.importe_hasta.visible = false
		this.object.f_renuncia_desde.visible = false
		this.object.f_renuncia_hasta.visible = false
		this.object.f_extorno_desde.visible = false
		this.object.f_extorno_hasta.visible = false
		this.object.obra_iniciada.visible = false
		this.object.t_4.visible = false
		this.object.t_5.visible = false
		this.object.t_6.visible = false
		
		
	CASE ELSE
//		this.object.aplicado_10.visible = true
//		this.object.aplicado_10_t.visible = true
//		this.object.anulado.visible = true
//		this.object.anulado_t.visible = true
		this.object.f_calculo_desde.visible = true
		this.object.f_calculo_desde_t.visible = true
		this.object.f_calculo_hasta.visible = true
		this.object.t_visado.visible = true
		this.object.t_visado_t.visible = true
		this.object.f_notific_desde_t.visible = true
		this.object.f_notific_desde.visible = true		
		this.object.f_notific_hasta.visible = true
		this.object.f_factura_desde_t.visible = false
		this.object.f_factura_desde.visible = false
		this.object.f_factura_hasta.visible = false
		
		this.object.n_exp_t.visible = true
		this.object.n_exp.visible = true
		this.object.t_1.visible = true
		this.object.n_visado.visible = true
		this.object.n_col_t.visible = true
		this.object.n_col.visible = true
		this.object.n_aviso_t.visible = true
		this.object.n_aviso.visible = true
		this.object.t_2.visible = true
		this.object.modalidad.visible = true
		this.object.obra_oficial_t.visible = true
		this.object.obra_oficial.visible = true
		this.object.t_3.visible = true
		this.object.decenal.visible = true
		this.object.importe_desde_t.visible = true
		this.object.importe_desde.visible = true
		this.object.importe_hasta.visible = true

		
		this.object.f_renuncia_desde.visible = true
		this.object.f_renuncia_hasta.visible = true
		this.object.f_extorno_desde.visible = true
		this.object.f_extorno_hasta.visible = true
		this.object.obra_iniciada.visible = true
		this.object.t_4.visible = true
		this.object.t_5.visible = true
		this.object.t_6.visible = true
		
		
		
		
		
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_musaat_movimientos_listados
end type

type cb_zoom from w_listados`cb_zoom within w_musaat_movimientos_listados
end type

type cb_esp from w_listados`cb_esp within w_musaat_movimientos_listados
end type

type cb_guardar from w_listados`cb_guardar within w_musaat_movimientos_listados
end type

type cb_escala from w_listados`cb_escala within w_musaat_movimientos_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_musaat_movimientos_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_musaat_movimientos_listados
end type

type dw_1 from w_listados`dw_1 within w_musaat_movimientos_listados
end type

event dw_1::retrievestart;call super::retrievestart;// Indicamos que queremos cambiar el idioma
if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

