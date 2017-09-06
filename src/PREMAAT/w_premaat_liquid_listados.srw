HA$PBExportHeader$w_premaat_liquid_listados.srw
forward
global type w_premaat_liquid_listados from w_listados
end type
end forward

global type w_premaat_liquid_listados from w_listados
string title = "Listados"
end type
global w_premaat_liquid_listados w_premaat_liquid_listados

on w_premaat_liquid_listados.create
call super::create
end on

on w_premaat_liquid_listados.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)


end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_premaat_liquid_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_premaat_liquid_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_premaat_liquid_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_premaat_liquid_listados
end type

type cb_ver from w_listados`cb_ver within w_premaat_liquid_listados
end type

event cb_ver::clicked;call super::clicked;string sql, listado

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
if dw_listados_varios.GetRow()>0 then
	listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
end if
dw_1.dataobject = listado


dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

//Hacer f_sql de todos los campos de la dw_listados
f_sql('premaat_liquidaciones.id_colegiado','LIKE','id_colegiado',dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.estado','LIKE','estado',dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.contabilizada','LIKE','contabilizada',dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.forma_pago','LIKE','forma_pago',dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.f_liquidacion','>=','df_liq',Parent.dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.f_liquidacion','<','hf_liq',Parent.dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.nombre','LIKE','nombre',Parent.dw_listados,sql,'1','')
f_sql('premaat_liquidaciones.descripcion_larga','LIKE','descripcion',Parent.dw_listados,sql,'1','')

dw_1.SetTransobject(sqlca)
dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
dw_1.retrieve()

//Al final:
if dw_1.RowCount() > 0 then
	dw_1.visible = true
	dw_1.event pfc_printpreview()
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,g_idioma.of_getmsg('msg_cliente.registros_especif','No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.'))
end if	

end event

type cb_salir from w_listados`cb_salir within w_premaat_liquid_listados
end type

type dw_listados from w_listados`dw_listados within w_premaat_liquid_listados
integer height = 872
string dataobject = "d_premaat_liquid_consulta"
end type

event dw_listados::buttonclicked;call super::buttonclicked;string id_colegiado

CHOOSE CASE dwo.name
	CASE 'b_busqueda_colegiados'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_colegiado=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_colegiado="-1" then
			messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.n_coleg_valido','Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.'))
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_colegiado',id_colegiado)
			this.SetItem(1,'n_colegiado',f_colegiado_n_col(id_colegiado))				
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

type cb_imprimir from w_listados`cb_imprimir within w_premaat_liquid_listados
end type

type cb_zoom from w_listados`cb_zoom within w_premaat_liquid_listados
end type

type cb_esp from w_listados`cb_esp within w_premaat_liquid_listados
end type

type cb_guardar from w_listados`cb_guardar within w_premaat_liquid_listados
end type

type cb_escala from w_listados`cb_escala within w_premaat_liquid_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_premaat_liquid_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_premaat_liquid_listados
end type

type dw_1 from w_listados`dw_1 within w_premaat_liquid_listados
integer height = 1308
end type

