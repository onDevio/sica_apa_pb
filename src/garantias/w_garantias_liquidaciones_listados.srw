HA$PBExportHeader$w_garantias_liquidaciones_listados.srw
forward
global type w_garantias_liquidaciones_listados from w_listados
end type
end forward

global type w_garantias_liquidaciones_listados from w_listados
integer width = 4037
string title = "Listados de Otros Pagos"
end type
global w_garantias_liquidaciones_listados w_garantias_liquidaciones_listados

on w_garantias_liquidaciones_listados.create
call super::create
end on

on w_garantias_liquidaciones_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)


string tipo
tipo = message.stringparm
//messagebox('', tipo)
if f_es_vacio(tipo) then 
	dw_listados.dataobject = 'd_garantia_liquid_consulta'
	dw_listados.settransobject(SQLCA)
	dw_listados.event pfc_addrow()
	dw_listados.setitem(1,'tipo','3')

	
end if

f_centrar_ventana(this)

end event

event pfc_postopen;call super::pfc_postopen;if dw_listados.dataobject = 'd_garantia_liquid_consulta' then
dw_listados.of_SetDropDownCalendar(True)
dw_listados.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_listados.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_listados.iuo_calendar.of_SetInitialValue(True)
end if
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_garantias_liquidaciones_listados
integer taborder = 30
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_garantias_liquidaciones_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_garantias_liquidaciones_listados
integer y = 1408
integer taborder = 40
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_garantias_liquidaciones_listados
integer x = 3040
integer y = 192
integer width = 969
integer taborder = 50
end type

type cb_ver from w_listados`cb_ver within w_garantias_liquidaciones_listados
integer taborder = 80
end type

event cb_ver::clicked;call super::clicked;string sql
string listado, descripcion
long Posini, Posfin

g_ultima_consulta = ''
g_parametros_listados=''
g_etiquetas_listados=''

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
descripcion = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'descripcion')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

dw_listados.setitem(1,'tipo','3') 

f_sql('premaat_liquidaciones.id_colegiado','LIKE','id_colegiado',dw_listados,sql,'1','Colegiado')
f_sql('premaat_liquidaciones.estado','LIKE','estado',dw_listados,sql,'1','Estado')
f_sql('premaat_liquidaciones.contabilizada','LIKE','contabilizada',dw_listados,sql,'1','Contabilizada')
f_sql('premaat_liquidaciones.forma_pago','LIKE','forma_pago',dw_listados,sql,'1','Forma Pago')
f_sql('premaat_liquidaciones.f_liquidacion','>=','df_liq',dw_listados,sql,'1','Fecha liq.')
f_sql('premaat_liquidaciones.f_liquidacion','<','hf_liq',dw_listados,sql,'1','Fecha liq.')
f_sql('premaat_liquidaciones.nombre','LIKE','nombre',dw_listados,sql,'1','Nombre')
f_sql('premaat_liquidaciones.tipo','LIKE','tipo',dw_listados,sql,'1','Tipo')
f_sql('premaat_liquidaciones.descripcion_larga','LIKE','descripcion',dw_listados,sql,'1','Descripcion')

Posini = Pos(upper(sql), "FROM")+5
Posfin = Pos(upper(sql), "WHERE")
if pos(upper(sql), "CSI_BANCOS") >0 then
	sql = sql + " and csi_bancos.empresa = '" + g_empresa +"'"
end if
sql=sql+" and premaat_liquidaciones.empresa='"+g_empresa+"'"

if 	dw_listados.dataobject = 'd_garantia_liquid_consulta' then
  f_sql('premaat_liquidaciones.f_entrada','>=','df_ent',dw_listados,sql,'1','')
  f_sql('premaat_liquidaciones.f_entrada','<','hf_ent',dw_listados,sql,'1','')
end if
		
		
		dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
		dw_1.retrieve()




//Al final:
if dw_1.RowCount() > 0 then
	if dw_1.describe("t_parametros.name") = "t_parametros" then dw_1.object.t_parametros.text = g_ultima_consulta		
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	
end event

type cb_salir from w_listados`cb_salir within w_garantias_liquidaciones_listados
integer taborder = 150
end type

type dw_listados from w_listados`dw_listados within w_garantias_liquidaciones_listados
integer y = 192
integer width = 2967
integer height = 968
integer taborder = 20
string dataobject = "d_premaat_liquid_consulta"
end type

event dw_listados::clicked;call super::clicked;string id_colegiado

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

type cb_imprimir from w_listados`cb_imprimir within w_garantias_liquidaciones_listados
integer taborder = 110
end type

type cb_zoom from w_listados`cb_zoom within w_garantias_liquidaciones_listados
integer taborder = 90
end type

type cb_esp from w_listados`cb_esp within w_garantias_liquidaciones_listados
integer taborder = 130
end type

type cb_guardar from w_listados`cb_guardar within w_garantias_liquidaciones_listados
integer taborder = 140
end type

type cb_escala from w_listados`cb_escala within w_garantias_liquidaciones_listados
integer taborder = 100
end type

type cb_ordenar from w_listados`cb_ordenar within w_garantias_liquidaciones_listados
integer taborder = 120
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_garantias_liquidaciones_listados
integer taborder = 60
end type

type dw_1 from w_listados`dw_1 within w_garantias_liquidaciones_listados
integer width = 3968
integer taborder = 70
end type

