HA$PBExportHeader$w_premaat_listados.srw
forward
global type w_premaat_listados from w_listados
end type
end forward

global type w_premaat_listados from w_listados
integer height = 2876
string title = "Listados de Mutua"
end type
global w_premaat_listados w_premaat_listados

forward prototypes
public subroutine wf_rellenar_cuenta ()
end prototypes

public subroutine wf_rellenar_cuenta ();// RICARDO 05-11-03
// Para todo el dw rellenamos la cuenta que a la que se le har$$HEX2$$e1002000$$ENDHEX$$el ingreso. SEr$$HEX2$$e1002000$$ENDHEX$$tomada de colegiados excepto cuando el 
// beneficiario sea un cliente, que se tomar$$HEX2$$e1002000$$ENDHEX$$de clientes

string cuenta, tipo_persona, id_persona
long fila

// Bucle para recorrer el dw
FOR fila=1 TO dw_1.RowCount()
	cuenta = ''
	tipo_persona = dw_1.GetItemString(fila, 'tipo_persona')
	id_persona = dw_1.GetItemString(fila, 'id_persona')

	CHOOSE CASE upper(tipo_persona)
		CASE 'C'
			// Cogemos la cuenta de los conceptos remesables
			SELECT datos_bancarios INTO :cuenta FROM conceptos_remesables WHERE id_colegiado = :id_persona   ;			
		CASE 'B'
			// Cogemos la cuenta del cliente
			cuenta = f_clientes_cuenta_bancaria(id_persona)
	END CHOOSE
	// Colocamos la cuenta en el dw
	dw_1.SetItem(fila, 'cuenta', cuenta)
NEXT




end subroutine

on w_premaat_listados.create
call super::create
end on

on w_premaat_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)


end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_premaat_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_premaat_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_premaat_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_premaat_listados
integer x = 2359
integer y = 192
integer width = 1207
end type

type cb_ver from w_listados`cb_ver within w_premaat_listados
end type

event cb_ver::clicked;call super::clicked;string sql,listado, sql_aux

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

f_sql('premaat.alta', 'LIKE', 'alta_total', Parent.dw_listados,sql, '1', '')
f_sql('premaat.n_col', 'LIKE', 'n_col', Parent.dw_listados,sql, '1', '')
f_sql('premaat.n_mutualista', 'LIKE', 'n_mutualista', Parent.dw_listados,sql, '1', '')
f_sql('premaat.grupo', '=', 'grupo', Parent.dw_listados,sql, '1', '')
f_sql('premaat.grupo_comple1', 'LIKE', 'comple1', Parent.dw_listados,sql, '1', '')
f_sql('premaat.grupo_comple2', 'LIKE', 'comple2', Parent.dw_listados,sql, '1', '')
f_sql('premaat.tipo_mutualista', '=', 'tipo_mutualista', Parent.dw_listados,sql, '1', '')
f_sql('premaat.situacion', '=', 'situacion', Parent.dw_listados,sql, '1', '')
f_sql('colegiados.delegacion','=','delegacion',Parent.dw_listados,sql, '1', '')

// Domiciliaciones
string sl_concepto_domic, sl_forma_pago_domic
double dl_importe_desde, dl_importe_hasta
sl_concepto_domic = dw_listados.getitemstring(1, 'concep_domic')
sl_forma_pago_domic = dw_listados.getitemstring(1, 'forma_pago_domic')
dl_importe_desde = dw_listados.getitemnumber(1, 'importe_domic_desde')
dl_importe_hasta = dw_listados.getitemnumber(1, 'importe_domic_hasta')

if not f_es_vacio(sl_concepto_domic) or not f_es_vacio(sl_forma_pago_domic) or not isnull(dl_importe_desde) or not isnull(dl_importe_hasta) then
	sql = f_sql_join(sql, {'( premaat.id_col = conceptos_domiciliables.id_colegiado )'})
end if

f_sql('conceptos_domiciliables.concepto', '=', 'concep_domic', Parent.dw_listados,sql, '1', '')
f_sql('conceptos_domiciliables.importe', '>=', 'importe_domic_desde', Parent.dw_listados,sql, '1', '')
f_sql('conceptos_domiciliables.importe', '<=', 'importe_domic_hasta', Parent.dw_listados,sql, '1', '')
f_sql('conceptos_domiciliables.forma_de_pago', '=', 'forma_pago_domic', Parent.dw_listados,sql, '1', '')


// Prestaciones 
string sl_tipo_persona, sl_id_persona, sl_tipo_prestacion, sl_forma_cobro

sl_tipo_persona = dw_listados.getitemstring(1, 'pres_tipo_persona')
sl_id_persona = dw_listados.getitemstring(1, 'pres_id_persona')
sl_tipo_prestacion = dw_listados.getitemstring(1, 'pres_tipo_prestacion')
dl_importe_desde = dw_listados.getitemnumber(1, 'pres_importe_desde')
dl_importe_hasta = dw_listados.getitemnumber(1, 'pres_importe_hasta')
sl_forma_cobro = dw_listados.getitemstring(1, 'pres_forma_cobro')

if (sl_tipo_persona<>'%') or not f_es_vacio(sl_id_persona) or not isnull(dl_importe_desde) or not isnull(dl_importe_hasta) &
or not f_es_vacio(sl_tipo_prestacion) or not f_es_vacio(sl_forma_cobro) then
	sql = f_sql_join(sql, {'( premaat.id_premaat = premaat_prestaciones.id_premaat )'})
end if
	
f_sql('premaat_prestaciones.tipo_persona', 'LIKE', 'pres_tipo_persona', Parent.dw_listados,sql, '1', '')
f_sql('premaat_prestaciones.id_persona', '=', 'pres_id_persona', Parent.dw_listados,sql, '1', '')
f_sql('premaat_prestaciones.tipo_prestacion', '=', 'pres_tipo_prestacion', Parent.dw_listados,sql, '1', '')
f_sql('premaat_prestaciones.importe', '>=', 'pres_importe_desde', Parent.dw_listados,sql, '1', '')
f_sql('premaat_prestaciones.importe', '<=', 'pres_importe_hasta', Parent.dw_listados,sql, '1', '')
f_sql('premaat_prestaciones.forma_pago', '=', 'pres_forma_cobro', Parent.dw_listados,sql, '1', '')

//messagebox('kk', sql)
////-----

//Recogemos los par$$HEX1$$e100$$ENDHEX$$metros relativos al reta
f_sql('premaat.alta_reta', 'LIKE', 'alta_reta', Parent.dw_listados,sql, '1', '')
f_sql('premaat.fecha_alta_reta', '>=', 'fecha_alta_reta', Parent.dw_listados,sql, '1', '')
f_sql('premaat.fecha_baja_reta', '<=', 'fecha_baja_reta', Parent.dw_listados,sql, '1', '')

dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")

choose case lower(dw_listados_varios.getitemstring(dw_listados_varios.getrow(), 'descripcion'))
	case 'listado de prestaciones', 'listado de prestaciones resumido'
		dw_1.retrieve('N')
		wf_rellenar_cuenta() // Modifiado RICARDO 05-11-03
	case 'listado de prestaciones con paga extra', 'listado de prestaciones con paga extra resumido'
		dw_1.retrieve('S')
		wf_rellenar_cuenta() // Modifiado RICARDO 05-11-03
	case else
		dw_1.retrieve()
end choose

//Al final:
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
	messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.no_encontrado_registros','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if



end event

type cb_salir from w_listados`cb_salir within w_premaat_listados
end type

type dw_listados from w_listados`dw_listados within w_premaat_listados
integer y = 224
integer width = 2286
integer height = 2048
string dataobject = "d_premaat_consulta"
end type

event dw_listados::csd_oculta();call super::csd_oculta;string listado

listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')

//choose case listado
//	CASE 'd_premaat_listado_beneficiarios'
//		this.object.n_col.visible = FALSE
//		this.object.n_col_t.visible = FALSE
//		this.object.grupo.visible = FALSE
//		this.object.t_5.visible = FALSE
//		this.object.comple1.visible = FALSE
//		this.object.t_6.visible = FALSE
//		this.object.comple2.visible = FALSE
//		this.object.t_7.visible = FALSE
////		this.object.gb_2.visible = FALSE
////		this.object.importe_pagar_desde.visible = FALSE
////		this.object.importe_pagar_hasta.visible = FALSE
////		this.object.t_3.visible = FALSE
////		this.object.t_4.visible = FALSE
//		this.object.alta.visible = TRUE
//		this.object.alta_t.visible = TRUE
//		this.object.alta_total.visible = false
//		this.object.alta_total_t.visible = false		
//	CASE ELSE
//		this.object.n_col.visible = TRUE
//		this.object.n_col_t.visible = TRUE
//		this.object.grupo.visible = TRUE
//		this.object.t_5.visible = TRUE
//		this.object.comple1.visible = TRUE
//		this.object.t_6.visible = TRUE
//		this.object.comple2.visible = TRUE
//		this.object.t_7.visible = TRUE
////		this.object.gb_2.visible = TRUE
////		this.object.importe_pagar_desde.visible = TRUE
////		this.object.importe_pagar_hasta.visible = TRUE
////		this.object.t_3.visible = TRUE
////		this.object.t_4.visible = TRUE
//		this.object.alta.visible = FALSE
//		this.object.alta_t.visible = FALSE
//		this.object.alta_total.visible = TRUE
//		this.object.alta_total_t.visible = TRUE		
//End Choose
//
end event

event dw_listados::buttonclicked;call super::buttonclicked;string tipo_persona, id_beneficiario, id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_colegiado="-1" then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_cobros.n_colegiado_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
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

event dw_listados::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
		
	CASE 'pres_tipo_persona'
		this.setitem(1, 'pres_id_persona', '')
END CHOOSE

end event

type cb_imprimir from w_listados`cb_imprimir within w_premaat_listados
end type

type cb_zoom from w_listados`cb_zoom within w_premaat_listados
end type

type cb_esp from w_listados`cb_esp within w_premaat_listados
end type

type cb_guardar from w_listados`cb_guardar within w_premaat_listados
end type

type cb_escala from w_listados`cb_escala within w_premaat_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_premaat_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_premaat_listados
integer y = 1916
end type

type dw_1 from w_listados`dw_1 within w_premaat_listados
integer x = 23
integer width = 3602
integer height = 1872
boolean ib_rmbmenu = false
end type

event dw_1::retrievestart;call super::retrievestart;if g_usar_idioma = 'S' then g_idioma.of_cambia_textos(this)
end event

