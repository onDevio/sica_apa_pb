HA$PBExportHeader$w_liquidaciones_consulta.srw
forward
global type w_liquidaciones_consulta from w_consulta
end type
type cbx_acumular from checkbox within w_liquidaciones_consulta
end type
end forward

global type w_liquidaciones_consulta from w_consulta
integer width = 1966
integer height = 1888
string title = "Consulta de Liquidaciones"
cbx_acumular cbx_acumular
end type
global w_liquidaciones_consulta w_liquidaciones_consulta

on w_liquidaciones_consulta.create
int iCurrent
call super::create
this.cbx_acumular=create cbx_acumular
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_acumular
end on

on w_liquidaciones_consulta.destroy
call super::destroy
destroy(this.cbx_acumular)
end on

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_liquidaciones_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_liquidaciones_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_liquidaciones_consulta
end type

type st_5 from w_consulta`st_5 within w_liquidaciones_consulta
end type

type cb_1 from w_consulta`cb_1 within w_liquidaciones_consulta
integer x = 384
integer y = 1644
end type

event cb_1::clicked;call super::clicked;string sql_nuevo

dw_1.AcceptText()
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('fases_liquidaciones.id_liquidacion','LIKE','id_liquidacion',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.id_liquidacion','>=','id_liq_desde',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.id_liquidacion','<=','id_liq_hasta',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.id_colegiado','=','id_colegiado',dw_1,sql_nuevo,'1','')
f_sql('colegiados.n_colegiado','=','n_colegiado',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.estado','LIKE','estado',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.contabilizada','LIKE','contabilizada',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.forma_pago','LIKE','forma_pago',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.f_liquidacion','>=','df_liq',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.f_liquidacion','<','hf_liq',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.id_fase','=','id_minuta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.n_documento','LIKE','n_documento',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.concepto','LIKE','concepto',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.tipo','=','tipo',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.f_entrada','>=','f_entrada_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.f_entrada','<','f_entrada_hasta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.cod_delegacion','=','cod_delegacion',dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.importe','>=','importe_neto_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.importe','<','importe_neto_hasta',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.saldo_deudor','>=','deudas_desde',Parent.dw_1,sql_nuevo,'1','')
f_sql('fases_liquidaciones.saldo_deudor','<','deudas_hasta',Parent.dw_1,sql_nuevo,'1','')

///*** SCP-1060. 02/03/2011. Alexis. Se filtra por empresa activa para que no muestre liquidaciones de otras empresas. ***///

sql_nuevo = sql_nuevo + " and fases_liquidaciones.empresa  = '" + g_empresa + "' " 

// Si se quiere acumular la consulta hacemos una union
if cbx_acumular.checked then
	if not f_es_vacio(g_consulta_actual_liquidaciones) then
		sql_nuevo = g_consulta_actual_liquidaciones + " UNION "+sql_nuevo
	end if
end if

g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
//messagebox('kk', sql_nuevo)
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_liquidaciones_consulta
integer x = 1006
integer y = 1644
end type

type cb_ayuda from w_consulta`cb_ayuda within w_liquidaciones_consulta
end type

type dw_1 from w_consulta`dw_1 within w_liquidaciones_consulta
integer x = 37
integer y = 128
integer width = 1883
integer height = 1404
string dataobject = "d_liquidacion_consulta"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_col

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

event dw_1::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
END CHOOSE

end event

type cbx_acumular from checkbox within w_liquidaciones_consulta
integer x = 549
integer y = 1548
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

