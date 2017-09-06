HA$PBExportHeader$w_busqueda_remesas_cobros.srw
forward
global type w_busqueda_remesas_cobros from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_remesas_cobros
end type
end forward

global type w_busqueda_remesas_cobros from w_busqueda
integer width = 1911
integer height = 1464
dw_3 dw_3
end type
global w_busqueda_remesas_cobros w_busqueda_remesas_cobros

type variables
string sql
end variables

on w_busqueda_remesas_cobros.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_busqueda_remesas_cobros.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;sql = dw_1.describe("datawindow.table.select")

dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_remesas_cobros
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_remesas_cobros
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_remesas_cobros
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_remesas_cobros
boolean visible = false
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_remesas_cobros
end type

type st_2 from w_busqueda`st_2 within w_busqueda_remesas_cobros
boolean visible = false
integer y = 552
integer width = 777
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_remesas_cobros
integer x = 55
integer y = 1200
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF (NOT f_es_vacio(dw_3.GetItemString(1,'n_remesa')) OR &
		NOT isnull(dw_3.GetItemDateTime(1,'f_desde'))  OR &
		NOT isnull(dw_3.GetItemDateTime(1,'f_hasta')) ) THEN
			dw_3.triggerevent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
		parent.event pfc_close()
		return
	end if
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_remesas_cobros
integer x = 1102
integer y = 1200
integer taborder = 80
boolean cancel = true
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_remesas_cobros
integer x = 14
integer y = 384
integer width = 1819
integer height = 760
integer taborder = 60
string dataobject = "d_lista_busqueda_remesas_cobros"
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
end event

type dw_3 from u_dw within w_busqueda_remesas_cobros
event csd_formatea_n_remesa ( string dato )
integer x = 14
integer width = 1851
integer height = 348
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_busqueda_remesas_cobros"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event csd_formatea_n_remesa(string dato);string n_remesa_formateado
n_remesa_formateado = f_rellenar_ceros_campo(dato, 10)
if n_remesa_formateado <> dato then
	this.setitem(1, 'n_remesa', n_remesa_formateado)
end if
end event

event buttonclicked;call super::buttonclicked;string  sql_nuevo = '', sql_origen = ''

this.accepttext()

sql_nuevo = dw_1.describe("datawindow.table.select")
sql_origen= sql_nuevo
		
f_sql('remesas.n_remesa','LIKE','n_remesa',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('remesas.fecha','>=','f_desde',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('remesas.fecha','<=','f_hasta',dw_3,sql_nuevo,g_tipo_base_datos,'')

if (PosA(upper(sql_nuevo), "WHERE") > 0) then
	sql_nuevo += "AND remesas.empresa='"+g_empresa+"'"
else
	sql_nuevo += " WHERE remesas.empresa='"+g_empresa+"'"
end if

//messagebox(' sql ',sql_nuevo)

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_1.Retrieve('%')

// Se restablece la propiedad select para una nueva consulta
dw_1.modify("datawindow.table.select= ~"" + sql_origen + "~"")

end event

event constructor;call super::constructor;this.insertrow(0)

//Se activa el Drop Down para el Calendar
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

// this.setformat('f_entrada','dd/mm/yyyy')
end event

event itemerror;call super::itemerror;// messagebox(g_titulo,'La informaci$$HEX1$$f300$$ENDHEX$$n introducida en alg$$HEX1$$fa00$$ENDHEX$$n par$$HEX1$$e100$$ENDHEX$$metro es incorrecta')
return 1
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'n_remesa'
			this.post event csd_formatea_n_remesa(data)
end choose
end event

