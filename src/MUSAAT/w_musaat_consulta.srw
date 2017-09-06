HA$PBExportHeader$w_musaat_consulta.srw
forward
global type w_musaat_consulta from w_consulta
end type
end forward

global type w_musaat_consulta from w_consulta
integer width = 2629
integer height = 2676
string title = "Consulta de Seguros"
end type
global w_musaat_consulta w_musaat_consulta

on w_musaat_consulta.create
call super::create
end on

on w_musaat_consulta.destroy
call super::destroy
end on

event open;call super::open;f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_musaat_consulta
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_musaat_consulta
string tag = "texto=general.guardar_pantalla"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_musaat_consulta
string tag = "texto=general.limpiar_consulta"
end type

type st_5 from w_consulta`st_5 within w_musaat_consulta
string tag = "texto=musaat.introducir_param_consulta_aceptar"
integer x = 32
end type

type cb_1 from w_consulta`cb_1 within w_musaat_consulta
integer x = 658
integer y = 2440
integer height = 96
integer weight = 700
fontcharset fontcharset = ansi!
end type

event cb_1::clicked;call super::clicked;string sql_nuevo, sql_aux
//Recuperamos le select del datawindow de lista
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('colegiados.n_colegiado', 'LIKE', 'n_col', Parent.dw_1,sql_nuevo, '1', '')
f_sql('colegiados.delegacion','=','delegacion',Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.n_mutualista', 'LIKE', 'n_mutualista', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_alta', 'LIKE', 'src_de_alta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_prefijo', '=', 'src_prefijo', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_n_poliza', 'LIKE', 'src_n_poliza', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_cober', 'LIKE', 'src_cober', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_estado', 'LIKE', 'src_estado', Parent.dw_1,sql_nuevo, '1', '')
//f_sql('musaat.src_cia', '=', 'cia_src', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.accidentes_alta', 'LIKE', 'acci_de_alta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.accidentes_n_poliza', 'LIKE', 'acci_n_poliza', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.accidentes_cober_muerte', '=', 'acci_cober_muerte', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.accidentes_cober_invalidez2', '=', 'acci_cober_invalidez', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.accidentes_cia', '=', 'cia_accidentes', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.tasadores_alta', 'LIKE', 'tasa_de_alta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.tasadores_n_poliza', '=', 'tasa_n_poliza', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.tasadores_cober', 'LIKE', 'tasa_cober', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.tasadores_cia', '=', 'cia_tasaciones', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.peritos_alta', 'LIKE', 'peri_de_alta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.peritos_n_poliza', '=', 'peri_n_poliza', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.peritos_cober', 'LIKE', 'peri_cober', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.peritos_cia', '=', 'cia_peritos', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.otros', 'LIKE inside', 'otros_datos', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.exceso', 'LIKE', 'exceso_alta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.exceso_n_poliza', 'LIKE', 'exceso_n_poliza', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.exceso_cobertura', 'LIKE', 'exceso_cober', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_coef_cm', '>=', 'src_bonus_malus_desde', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_coef_cm', '<=', 'src_bonus_malus_hasta', Parent.dw_1,sql_nuevo, '1', '')
f_sql('musaat.src_t_poliza', '=', 'src_t_poliza', Parent.dw_1,sql_nuevo, '1', '')

f_sql('src_colegiado.numero_poliza', 'LIKE', 'n_poliza_otros_src', Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.alta', 'LIKE', 'alta_otros_src', Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.src_cia', '=', 'cia_otros_src', Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.f_alta','>=','f_alta_desde_otros_src',Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.f_alta','<','f_alta_hasta_otros_src',Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.f_baja','>=','f_baja_desde_otros_src',Parent.dw_1,sql_nuevo, '1', '')
f_sql('src_colegiado.f_baja','<','f_baja_desde_otros_src',Parent.dw_1,sql_nuevo, '1', '')


string conceptos_domi, forma_pago_domi
double importe_desde_domi, importe_hasta_domi
conceptos_domi = dw_1.getitemstring(1, 'conceptos_domi')
importe_desde_domi = dw_1.getitemnumber(1, 'importe_desde_domi')
importe_hasta_domi = dw_1.getitemnumber(1, 'importe_hasta_domi')
forma_pago_domi = dw_1.getitemstring(1, 'forma_pago_domi')
if (not f_es_vacio(conceptos_domi)) or (not isnull(importe_desde_domi)) or (not isnull(importe_hasta_domi)) or (not f_es_vacio(forma_pago_domi)) then
	sql_nuevo = f_sql_join(sql_nuevo, {'( musaat.id_col = conceptos_domiciliables.id_colegiado )'})
end if

if not f_es_vacio(conceptos_domi) then sql_nuevo += " and ( conceptos_domiciliables.concepto like'"+conceptos_domi+"')"
if not isnull(importe_desde_domi) then sql_nuevo += " and ( conceptos_domiciliables.importe >= "+f_cambia_comas_decimales(importe_desde_domi)+")"
if not isnull(importe_hasta_domi) then sql_nuevo += " and ( conceptos_domiciliables.importe <= "+f_cambia_comas_decimales(importe_hasta_domi)+")"
if not f_es_vacio(forma_pago_domi) then sql_nuevo += " and ( conceptos_domiciliables.forma_de_pago like'"+forma_pago_domi+"')"

if not isnull(sql_aux) then sql_nuevo += sql_aux

g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_musaat_consulta
integer x = 1280
integer y = 2440
integer height = 96
end type

type cb_ayuda from w_consulta`cb_ayuda within w_musaat_consulta
string tag = "texto=general.ayuda"
integer x = 1431
integer y = 1892
end type

type dw_1 from w_consulta`dw_1 within w_musaat_consulta
integer x = 37
integer y = 128
integer width = 2555
integer height = 2280
string dataobject = "d_musaat_consulta"
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_col'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"

		id_colegiado=f_busqueda_colegiados()
		
		setItem(1,'n_col',f_colegiado_n_col(id_colegiado))
END CHOOSE

end event

event dw_1::clicked;call super::clicked;string t_poliza,cia_src,ls_null
setnull(ls_null)
// Filtramos las coberturas seg$$HEX1$$fa00$$ENDHEX$$n el tipo de poliza
CHOOSE CASE dwo.name
	CASE 'src_cober'
		//this.setitem(1,'src_cober',ls_null)
		t_poliza = this.getitemstring(1, 'src_t_poliza')
		if isnull(t_poliza) then t_poliza = ''
		DataWindowChild dwc_cober_src
		this.GetChild('src_cober', dwc_cober_src)
		dwc_cober_src.setfilter("t_poliza = '" + t_poliza + "'")		
		dwc_cober_src.filter()	
		
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;datawindowchild  ldwc_src_cober
Long num_digitos
string ls_null,ls_codigo
setnull(ls_null)
choose case dwo.name
	case 'cia_src'	
			this.getchild("src_cober", ldwc_src_cober)	
			ldwc_src_cober.settransobject(sqlca)
			this.setitem(1,'src_cober',ls_null)
			ldwc_src_cober.retrieve(data)	
	case 'src_t_poliza_1'	
			this.setitem(1,'src_cober',ls_null)
end choose
end event

