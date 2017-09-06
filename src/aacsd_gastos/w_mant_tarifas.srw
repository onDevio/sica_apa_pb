HA$PBExportHeader$w_mant_tarifas.srw
forward
global type w_mant_tarifas from w_sheet
end type
type dw_tipos_act from u_dw within w_mant_tarifas
end type
type dw_precios from u_dw within w_mant_tarifas
end type
type dw_consulta from u_dw within w_mant_tarifas
end type
type cb_guardar from commandbutton within w_mant_tarifas
end type
type cb_cerrar from commandbutton within w_mant_tarifas
end type
type cb_cancelar from commandbutton within w_mant_tarifas
end type
type dw_tarifas_x_tramite from u_dw within w_mant_tarifas
end type
type st_1 from statictext within w_mant_tarifas
end type
type st_2 from statictext within w_mant_tarifas
end type
type st_3 from statictext within w_mant_tarifas
end type
end forward

global type w_mant_tarifas from w_sheet
integer x = 214
integer y = 221
integer width = 4206
integer height = 1920
string title = "Mantenimiento de Gastos"
windowstate windowstate = maximized!
dw_tipos_act dw_tipos_act
dw_precios dw_precios
dw_consulta dw_consulta
cb_guardar cb_guardar
cb_cerrar cb_cerrar
cb_cancelar cb_cancelar
dw_tarifas_x_tramite dw_tarifas_x_tramite
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_mant_tarifas w_mant_tarifas

event open;call super::open;dw_consulta.insertrow(0)

dw_tipos_act.SetTransObject(SQLCA)
dw_precios.SetTransObject(SQLCA)
dw_tarifas_x_tramite.SetTransObject(SQLCA)

dw_consulta.SetItem(1,'colegio',g_colegio)
dw_consulta.event itemchanged(1,dw_consulta.object.colegio,g_colegio)

// Enable the resize service
of_SetResize (true)

// Specify how the window will be resized
inv_resize.of_Register (dw_tipos_act, "ScaleToBottom")
inv_resize.of_Register (dw_precios, "ScaleToBottom")
inv_resize.of_Register (cb_guardar, "FixedtoRight&Bottom")
inv_resize.of_Register (cb_cancelar, "FixedtoRight&Bottom")
inv_resize.of_Register (cb_cerrar, "FixedtoRight&Bottom")
inv_resize.of_Register (dw_tarifas_x_tramite,"ScaleToRight&Bottom")
//dw_1.SetFocus()


end event

on w_mant_tarifas.create
int iCurrent
call super::create
this.dw_tipos_act=create dw_tipos_act
this.dw_precios=create dw_precios
this.dw_consulta=create dw_consulta
this.cb_guardar=create cb_guardar
this.cb_cerrar=create cb_cerrar
this.cb_cancelar=create cb_cancelar
this.dw_tarifas_x_tramite=create dw_tarifas_x_tramite
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tipos_act
this.Control[iCurrent+2]=this.dw_precios
this.Control[iCurrent+3]=this.dw_consulta
this.Control[iCurrent+4]=this.cb_guardar
this.Control[iCurrent+5]=this.cb_cerrar
this.Control[iCurrent+6]=this.cb_cancelar
this.Control[iCurrent+7]=this.dw_tarifas_x_tramite
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
end on

on w_mant_tarifas.destroy
call super::destroy
destroy(this.dw_tipos_act)
destroy(this.dw_precios)
destroy(this.dw_consulta)
destroy(this.cb_guardar)
destroy(this.cb_cerrar)
destroy(this.cb_cancelar)
destroy(this.dw_tarifas_x_tramite)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_mant_tarifas
integer x = 41
integer y = 1416
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_mant_tarifas
integer x = 41
integer y = 1296
end type

type dw_tipos_act from u_dw within w_mant_tarifas
integer x = 9
integer y = 384
integer width = 2267
integer height = 1248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_tarifas_tipos_act"
boolean ib_isupdateable = false
end type

event rowfocuschanged;call super::rowfocuschanged;string id_Tarifa
if currentrow>0 then
	id_tarifa=this.getitemString(currentrow,'id_tarifa')
	dw_precios.retrieve(id_tarifa)
end if


end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = true

if this.rowcount() > 0 then 
	am_dw.m_table.m_delete.enabled = true
else
	am_dw.m_table.m_delete.enabled = false
end if




end event

event retrieveend;call super::retrieveend;if rowcount>0 then
	this.SelectRow(1,true)
	this.event rowfocuschanged(1)
end if

end event

event pfc_addrow;call super::pfc_addrow;cb_guardar.enabled=true
cb_cancelar.enabled=true


this.SetItem(ancestorreturnvalue,'id_tarifa', f_siguiente_numero('ID_TARIFA', 10))
this.SetItem(ancestorreturnvalue,'sup_desde', -1)
this.SetItem(ancestorreturnvalue,'pem_desde',-1)
this.SetItem(ancestorreturnvalue,'otro_desde',-1)
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)

return ancestorreturnvalue
end event

event itemchanged;call super::itemchanged;cb_guardar.enabled=true
cb_cancelar.enabled=true

return ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;long total_filas,i


if messageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Esta opci$$HEX1$$f300$$ENDHEX$$n no es reversible. El borrado eliminar$$HEX2$$e1002000$$ENDHEX$$todos los importes a$$HEX1$$f100$$ENDHEX$$adidos en la tarifa seleccionada",Question!,YesNo!)=1 then
	total_filas=dw_precios.rowcount()
	for i=total_filas to 1 step -1	
		dw_precios.deleterow(i)
	next
	dw_precios.update()
else
	return 0
end if




return ancestorreturnvalue
end event

event pfc_deleterow;call super::pfc_deleterow;if ancestorreturnvalue=1 then this.update()

return ancestorreturnvalue
end event

type dw_precios from u_dw within w_mant_tarifas
integer x = 2277
integer y = 384
integer width = 1097
integer height = 1248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_tarifas_precios"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
if dw_tipos_act.GetRow()>0 then
	am_dw.m_table.m_addrow.enabled = true
else
	am_dw.m_table.m_addrow.enabled = false
end if

if this.rowcount() > 0 then 
	am_dw.m_table.m_delete.enabled = true
else
	am_dw.m_table.m_delete.enabled = false
end if


end event

event pfc_addrow;call super::pfc_addrow;cb_guardar.enabled=true
cb_cancelar.enabled=true
dw_tipos_act.enabled=false

this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('ID_TARIFA_IMPORTE', 10))
this.SetItem(ancestorreturnvalue,'id_tarifa',dw_tipos_act.GetItemString(dw_tipos_act.GetRow(),'id_tarifa') )
this.SetItem(ancestorreturnvalue,'coef_modificador',1 )

return ancestorreturnvalue
end event

event pfc_deleterow;call super::pfc_deleterow;cb_guardar.enabled=true
cb_cancelar.enabled=true

return ancestorreturnvalue 
end event

event itemchanged;call super::itemchanged;string id_informe
cb_guardar.enabled=true
cb_cancelar.enabled=true
id_informe=this.getitemString(this.getrow(),'id_informe')
dw_tarifas_x_tramite.retrieve(g_colegio,id_informe)
return ancestorreturnvalue

end event

event rowfocuschanged;call super::rowfocuschanged;string id_informe
//id_tarifa=this.getitemString(currentrow,'id_tarifa')
if this.rowcount() >0 then
id_informe=this.getitemString(currentrow,'id_informe')
dw_tarifas_x_tramite.retrieve(g_colegio,id_informe)
else
	dw_tarifas_x_tramite.reset()
end if
end event

event retrieveend;call super::retrieveend;string id_informe
if this.rowcount()>0 then
	id_informe=this.getitemString(1,'id_informe')
	dw_tarifas_x_tramite.retrieve(g_colegio,id_informe)
end if
end event

type dw_consulta from u_dw within w_mant_tarifas
integer x = 37
integer y = 20
integer width = 1952
integer height = 276
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_seleccion_colegio"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;string tipo_act
string sql, sql_orig
long i
		
choose case dwo.name
	case 'colegio'
		dw_tipos_act.retrieve(data)
	case 'tipo_act'		
		this.AcceptText()
		SetPointer(HourGlass!)
		
		tipo_act = this.getitemstring(this.getrow(),'tipo_act')
		if f_es_vacio(tipo_act) then tipo_act = '%'
		
		sql_orig = dw_tipos_act.describe("datawindow.table.select")	
		sql = sql_orig
		
		//Tipo de actuacion.
		f_sql('tarifas_tipo_act.tipo_act','LIKE','tipo_act', dw_consulta, sql, g_tipo_base_datos, '')
		
		dw_tipos_act.Modify("datawindow.table.select= ~"" + sql + "~"")
		
		dw_precios.Reset()
		dw_tarifas_x_tramite.Reset()
		
		dw_tipos_act.Retrieve(g_colegio)
			
		dw_tipos_act.Modify("datawindow.table.select= ~"" + sql_orig + "~"")
		
		SetPointer(Arrow!)
end choose
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_borrar'
		this.SetItem(this.GetRow(),'tipo_act','')
		event itemchanged(this.GetRow(), this.Object.tipo_act, '')
end choose
end event

type cb_guardar from commandbutton within w_mant_tarifas
integer x = 2546
integer y = 1668
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Guardar"
end type

event clicked;dw_tipos_act.enabled=true
dw_precios.enabled=true
cb_guardar.enabled=false
cb_cancelar.enabled=false

dw_tipos_act.update()
dw_precios.update()
dw_tarifas_x_tramite.update()
end event

type cb_cerrar from commandbutton within w_mant_tarifas
integer x = 3726
integer y = 1660
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
end type

event clicked;
Close(parent)
end event

type cb_cancelar from commandbutton within w_mant_tarifas
integer x = 2958
integer y = 1668
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Cancelar"
end type

event clicked;string id_Tarifa
id_tarifa=dw_tipos_act.getitemString(dw_tipos_act.getRow(),'id_tarifa')

dw_precios.enabled=true
dw_tipos_act.enabled=true
cb_guardar.enabled=false
cb_cancelar.enabled=false

dw_precios.retrieve(id_tarifa)
end event

type dw_tarifas_x_tramite from u_dw within w_mant_tarifas
integer x = 3374
integer y = 384
integer width = 731
integer height = 1248
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mant_tarifas_x_tramite"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event itemchanged;call super::itemchanged;cb_guardar.enabled=true
cb_cancelar.enabled=true

return ancestorreturnvalue
end event

event pfc_deleterow;call super::pfc_deleterow;cb_guardar.enabled=true
cb_cancelar.enabled=true

return ancestorreturnvalue 
end event

event pfc_addrow;call super::pfc_addrow;cb_guardar.enabled=true
cb_cancelar.enabled=true
dw_tipos_act.enabled=false
dw_precios.enabled=false
cb_guardar.enabled=true
cb_cancelar.enabled=true
this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('ID_TARIFA', 10))
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)
this.SetItem(ancestorreturnvalue,'id_informe',dw_precios.GetItemString(dw_precios.GetRow(),'id_informe') )


return ancestorreturnvalue
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
if dw_tipos_act.GetRow()>0 then
	am_dw.m_table.m_addrow.enabled = true
else
	am_dw.m_table.m_addrow.enabled = false
end if

if this.rowcount() > 0 then 
	am_dw.m_table.m_delete.enabled = true
else
	am_dw.m_table.m_delete.enabled = false
end if


end event

type st_1 from statictext within w_mant_tarifas
integer x = 2277
integer y = 320
integer width = 754
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Descuento:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_tarifas
integer x = 9
integer y = 320
integer width = 1024
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de actuaci$$HEX1$$f300$$ENDHEX$$n y coheficientes:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_mant_tarifas
integer x = 3374
integer y = 320
integer width = 731
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de tramite:"
boolean focusrectangle = false
end type

