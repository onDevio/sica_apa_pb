HA$PBExportHeader$w_busqueda_remesas.srw
forward
global type w_busqueda_remesas from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_remesas
end type
end forward

global type w_busqueda_remesas from w_busqueda
integer width = 2985
integer height = 1784
dw_3 dw_3
end type
global w_busqueda_remesas w_busqueda_remesas

type variables
string sql
end variables

on w_busqueda_remesas.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_busqueda_remesas.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;sql = dw_1.describe("datawindow.table.select")

dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_remesas
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_remesas
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_remesas
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_remesas
boolean visible = false
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_remesas
end type

type st_2 from w_busqueda`st_2 within w_busqueda_remesas
boolean visible = false
integer y = 552
integer width = 777
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_remesas
integer y = 1556
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF NOT f_es_vacio(dw_3.GetItemString(1,'n_remesa')) THEN
				dw_3.TriggerEvent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
			parent.event pfc_close()
			return
	end if
	
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_remesas
integer y = 1556
integer taborder = 80
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_remesas
event csd_grabar ( )
integer x = 37
integer y = 456
integer width = 2894
integer height = 1040
integer taborder = 60
end type

event csd_grabar;this.update()

end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = True
am_dw.m_table.m_debug.enabled = False
end event

event dw_1::pfc_deleterow;call super::pfc_deleterow;postevent("csd_grabar")
return 1

end event

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

type dw_3 from u_dw within w_busqueda_remesas
integer x = 14
integer width = 2853
integer height = 448
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_remesas_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;string sql_nuevo = '', sql_origen = ''
string n_remesa

this.accepttext()
sql_nuevo = dw_1.describe("datawindow.table.select")
sql_origen= sql_nuevo


f_sql('remesas_reclamaciones.n_remesa','LIKE','n_remesa',dw_3,sql_nuevo,g_tipo_base_datos,'')

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_1.Retrieve('%')

// Se restablece la propiedad select para una nueva consulta
dw_1.modify("datawindow.table.select= ~"" + sql_origen + "~"")

// Para restablecer el valor inicial en DW
dw_3.setitem(1,'n_remesa','')	

end event

event constructor;call super::constructor;this.insertrow(0)

//Se activa el Drop Down para el Calendar
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event itemerror;call super::itemerror;return 1
end event

