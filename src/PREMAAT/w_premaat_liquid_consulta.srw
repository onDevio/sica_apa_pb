HA$PBExportHeader$w_premaat_liquid_consulta.srw
forward
global type w_premaat_liquid_consulta from w_consulta
end type
end forward

global type w_premaat_liquid_consulta from w_consulta
integer x = 214
integer y = 221
integer width = 1710
integer height = 1332
string title = "Consulta"
end type
global w_premaat_liquid_consulta w_premaat_liquid_consulta

on w_premaat_liquid_consulta.create
call super::create
end on

on w_premaat_liquid_consulta.destroy
call super::destroy
end on

event open;call super::open;string tipo
tipo = message.stringparm
dw_1.setitem(1,'tipo',tipo)

//messagebox('', tipo)
if f_es_vacio(tipo) then 
	dw_1.dataobject = 'd_garantia_liquid_consulta'
	dw_1.settransobject(SQLCA)
	dw_1.event pfc_addrow()
	dw_1.setitem(1,'tipo','3')
end if

f_centrar_ventana(this)
end event

event pfc_postopen();call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)
end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_premaat_liquid_consulta
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_premaat_liquid_consulta
end type

type cb_limpiar from w_consulta`cb_limpiar within w_premaat_liquid_consulta
integer y = 776
end type

type st_5 from w_consulta`st_5 within w_premaat_liquid_consulta
string tag = "texto=cobros.int_param_consulta_aceptar"
end type

type cb_1 from w_consulta`cb_1 within w_premaat_liquid_consulta
integer x = 229
integer y = 1124
end type

event cb_1::clicked;call super::clicked;string sql_nuevo

dw_1.AcceptText()
SetPointer(HourGlass!)
sql_nuevo = g_dw_lista.describe("datawindow.table.select")

f_sql('premaat_liquidaciones.id_colegiado','LIKE','id_colegiado',dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.estado','LIKE','estado',dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.contabilizada','LIKE','contabilizada',dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.forma_pago','LIKE','forma_pago',dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.f_liquidacion','>=','df_liq',Parent.dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.f_liquidacion','<','hf_liq',Parent.dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.nombre','LIKE','nombre',Parent.dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.tipo','LIKE','tipo',Parent.dw_1,sql_nuevo,'1','')
f_sql('premaat_liquidaciones.descripcion_larga','LIKE','descripcion',Parent.dw_1,sql_nuevo,'1','')
//f_sql('fases.modalidad','LIKE','modalidad',dw_1,sql_nuevo,'1','')

if dw_1.dataobject = 'd_garantia_liquid_consulta' then
	f_sql('premaat_liquidaciones.f_entrada','>=','df_ent',Parent.dw_1,sql_nuevo,'1','')
	f_sql('premaat_liquidaciones.f_entrada','<','hf_ent',Parent.dw_1,sql_nuevo,'1','')
end if
g_dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
//messagebox('kk', sql_nuevo)
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_premaat_liquid_consulta
integer x = 905
integer y = 1124
end type

type cb_ayuda from w_consulta`cb_ayuda within w_premaat_liquid_consulta
integer x = 1865
integer y = 768
end type

type dw_1 from w_consulta`dw_1 within w_premaat_liquid_consulta
integer x = 14
integer y = 144
integer width = 1600
integer height = 936
string dataobject = "d_premaat_liquid_consulta"
end type

event dw_1::constructor;// Sobreescrito
of_SetTransObject(SQLCA)
datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()
end event

event dw_1::itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', id_col)
END CHOOSE

end event

event dw_1::buttonclicked;call super::buttonclicked;string id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_colegiado="-1" then
			messagebox(g_titulo,g_idioma.of_getmsg('colegiados.num_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_colegiado)
			this.SetItem(1,'n_colegiado',f_colegiado_n_col(id_colegiado))				
	end if
END CHOOSE

end event

