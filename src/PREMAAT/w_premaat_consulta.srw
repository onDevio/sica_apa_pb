HA$PBExportHeader$w_premaat_consulta.srw
forward
global type w_premaat_consulta from w_consulta
end type
end forward

global type w_premaat_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 2309
integer height = 2444
string title = "Consulta de Mutua"
end type
global w_premaat_consulta w_premaat_consulta

on w_premaat_consulta.create
call super::create
end on

on w_premaat_consulta.destroy
call super::destroy
end on

event open;call super::open;f_centrar_ventana(this)


// Poder seleccionar todos los conceptos domiciliables de premaat
datawindowchild idwc_conceptos_domiciliables

dw_1.getchild('concep_domic', idwc_conceptos_domiciliables)

idwc_conceptos_domiciliables.insertrow(0)
idwc_conceptos_domiciliables.setitem(idwc_conceptos_domiciliables.rowcount(), 'descripcion', 'TODOS')
idwc_conceptos_domiciliables.setitem(idwc_conceptos_domiciliables.rowcount(), 'codigo', '%')
if g_usar_idioma='S' then g_idioma.of_cambia_textos( this)
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_premaat_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_premaat_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_premaat_consulta
end type

type st_5 from w_consulta`st_5 within w_premaat_consulta
string tag = "texto=cobros.int_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_premaat_consulta
integer x = 443
integer y = 2168
integer height = 96
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_aux

//Recuperamos la select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('premaat.alta', 'LIKE', 'alta_total', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.n_col', 'LIKE', 'n_col', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.n_mutualista', 'LIKE', 'n_mutualista', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.grupo', '=', 'grupo', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.grupo_comple1', 'LIKE', 'comple1', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.grupo_comple2', 'LIKE', 'comple2', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.tipo_mutualista', '=', 'tipo_mutualista', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.situacion', '=', 'situacion', Parent.dw_1,sql_nuevo, '1', '')
f_sql('colegiados.delegacion','=','delegacion',Parent.dw_1,sql_nuevo, '1', '')
f_sql('colegiados.nif','LIKE','nif',Parent.dw_1,sql_nuevo, '1', '')

// Domiciliaciones
string sl_concepto_domic, sl_forma_pago_domic
double dl_importe_desde, dl_importe_hasta
sl_concepto_domic = dw_1.getitemstring(1, 'concep_domic')
sl_forma_pago_domic = dw_1.getitemstring(1, 'forma_pago_domic')
dl_importe_desde = dw_1.getitemnumber(1, 'importe_domic_desde')
dl_importe_hasta = dw_1.getitemnumber(1, 'importe_domic_hasta')

if not f_es_vacio(sl_concepto_domic) or not f_es_vacio(sl_forma_pago_domic) or not isnull(dl_importe_desde) or not isnull(dl_importe_hasta) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( premaat.id_col = conceptos_domiciliables.id_colegiado )'})
end if

if dw_1.getitemstring(1, 'concep_domic') = '%' then
	sql_nuevo = f_sql_join(sql_nuevo, {'(  conceptos_domiciliables.concepto = csi_articulos_servicios.codigo)'})
	f_sql('csi_articulos_servicios.familia', '=', 'familia', Parent.dw_1,sql_nuevo, '1', '')
else
	f_sql('conceptos_domiciliables.concepto', '=', 'concep_domic', Parent.dw_1,sql_nuevo, '1', '')
end if
f_sql('conceptos_domiciliables.importe', '>=', 'importe_domic_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('conceptos_domiciliables.importe', '<=', 'importe_domic_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('conceptos_domiciliables.forma_de_pago', '=', 'forma_pago_domic', Parent.dw_1,sql_nuevo, '1', '')


// Prestaciones 
string sl_tipo_persona, sl_id_persona, sl_tipo_prestacion, sl_forma_cobro

sl_tipo_persona = dw_1.getitemstring(1, 'pres_tipo_persona')
sl_id_persona = dw_1.getitemstring(1, 'pres_id_persona')
sl_tipo_prestacion = dw_1.getitemstring(1, 'pres_tipo_prestacion')
dl_importe_desde = dw_1.getitemnumber(1, 'pres_importe_desde')
dl_importe_hasta = dw_1.getitemnumber(1, 'pres_importe_hasta')
sl_forma_cobro = dw_1.getitemstring(1, 'pres_forma_cobro')

if (sl_tipo_persona<>'%') or not f_es_vacio(sl_id_persona) or not isnull(dl_importe_desde) or not isnull(dl_importe_hasta) &
or not f_es_vacio(sl_tipo_prestacion) or not f_es_vacio(sl_forma_cobro) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( premaat.id_premaat = premaat_prestaciones.id_premaat )'})
end if
	
f_sql('premaat_prestaciones.tipo_persona', 'LIKE', 'pres_tipo_persona', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat_prestaciones.id_persona', '=', 'pres_id_persona', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat_prestaciones.tipo_prestacion', '=', 'pres_tipo_prestacion', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat_prestaciones.importe', '>=', 'pres_importe_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat_prestaciones.importe', '<=', 'pres_importe_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat_prestaciones.forma_pago', '=', 'pres_forma_cobro', Parent.dw_1,sql_nuevo, '1', '')
//messagebox('kk', sql_nuevo)
// Modificamos el dw con los parametros de la ventana de consulta

//Recogemos los par$$HEX1$$e100$$ENDHEX$$metros relativos al reta
f_sql('premaat.alta_reta', 'LIKE', 'alta_reta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.fecha_alta_reta', '>=', 'fecha_alta_reta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('premaat.fecha_baja_reta', '<=', 'fecha_baja_reta', Parent.dw_1,sql_nuevo, '1', '')

g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_premaat_consulta
integer x = 1065
integer y = 2168
integer height = 96
end type

type cb_ayuda from w_consulta`cb_ayuda within w_premaat_consulta
end type

type dw_1 from w_consulta`dw_1 within w_premaat_consulta
integer x = 37
integer y = 112
integer width = 2245
integer height = 2036
string dataobject = "d_premaat_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;string tipo_persona, id_beneficiario, id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_col',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados")
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_colegiado="-1" then
			messagebox(g_titulo,g_idioma.of_getmsg('colegiados.introducir_num','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_colegiado)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_colegiado))				
	end if

	CASE 'b_1'
		tipo_persona = this.getitemstring(row, 'pres_tipo_persona')
		choose case tipo_persona
			case 'C'
				g_busqueda.titulo=g_idioma.of_getmsg('colegiados.busqueda_rapido_col',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados")
				g_busqueda.dw="d_lista_busqueda_colegiados"
				
				id_colegiado=f_busqueda_colegiados()
				
				if not f_es_vacio(id_colegiado) then this.setitem(1,'pres_id_persona',id_colegiado)
			case 'B'		
				g_busqueda.titulo=g_idioma.of_getmsg('beneficiarios.busqueda_rapida',"B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Beneficiarios")
				g_busqueda.dw="d_lista_busqueda_terceros"
				
				id_beneficiario=f_busqueda_terceros(g_terceros_codigos.ben_premaat)
				
				if not f_es_vacio(id_beneficiario) then this.setitem(1,'pres_id_persona',id_beneficiario)	
		end choose
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
		
	CASE 'pres_tipo_persona'
		this.setitem(1, 'pres_id_persona', '')
END CHOOSE

end event

event dw_1::constructor;call super::constructor;datawindowchild dwc_forma_pago, dwc_pre_fp
// Capturamos el desplegable
this.getchild ('forma_pago_domic', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

this.getchild ('pre_forma_cobro', dwc_pre_fp)
dwc_pre_fp.settransobject (SQLCA)
dwc_pre_fp.setfilter("tipo_pago <>'CM'")
dwc_pre_fp.filter()


end event

