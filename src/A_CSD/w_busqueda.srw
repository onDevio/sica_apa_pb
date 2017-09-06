HA$PBExportHeader$w_busqueda.srw
forward
global type w_busqueda from w_response
end type
type sle_1 from singlelineedit within w_busqueda
end type
type dw_2 from datawindow within w_busqueda
end type
type st_1 from statictext within w_busqueda
end type
type st_2 from statictext within w_busqueda
end type
type cb_1 from commandbutton within w_busqueda
end type
type cb_2 from commandbutton within w_busqueda
end type
type dw_1 from u_dw within w_busqueda
end type
end forward

global type w_busqueda from w_response
integer x = 73
integer y = 148
integer width = 2734
integer height = 1452
sle_1 sle_1
dw_2 dw_2
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_busqueda w_busqueda

on w_busqueda.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_1
end on

on w_busqueda.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;call super::open;this.title  =g_busqueda.titulo
dw_1.DataObject=g_busqueda.dw
dw_1.SetTransObject(SQLCA)
dw_2.SetFocus()

if g_usar_idioma ="S" then
	g_idioma.of_cambia_textos_dw( dw_1 )
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_busqueda
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_busqueda
end type

type sle_1 from singlelineedit within w_busqueda
integer x = 805
integer y = 68
integer width = 1870
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;dw_1.Retrieve(this.text+'%')
end event

type dw_2 from datawindow within w_busqueda
integer x = 795
integer y = 176
integer width = 1897
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_busqueda_activa"
boolean border = false
boolean livescroll = true
end type

event editchanged;dw_1.Retrieve(data+'%')
end event

event constructor;this.insertrow(0)
end event

type st_1 from statictext within w_busqueda
string tag = "texto=busqueda.parametro:"
integer x = 37
integer y = 72
integer width = 745
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Introduzca el par$$HEX1$$e100$$ENDHEX$$metro completo:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_busqueda
string tag = "texto=busqueda.parametro_activo:"
integer x = 37
integer y = 192
integer width = 731
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Par$$HEX1$$e100$$ENDHEX$$metro activo al teclear:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_busqueda
string tag = "texto=general.acep_valor"
integer x = 507
integer y = 1244
integer width = 590
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar: Devolver Valor"
boolean default = true
end type

event clicked;if dw_1.Rowcount() < 1 then
	parent.event pfc_close()
	return
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))
end event

type cb_2 from commandbutton within w_busqueda
string tag = "texto=general.cancelar"
integer x = 1554
integer y = 1244
integer width = 590
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;parent.event pfc_close()
end event

type dw_1 from u_dw within w_busqueda
integer x = 69
integer y = 328
integer width = 2610
integer height = 860
integer taborder = 11
boolean bringtotop = true
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (false)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)
inv_sort.of_SetVisibleOnly(FALSE)

// Enable printpreview service
of_SetPrintPreview (true)



end event

event doubleclicked;if rowcount() >0 then cb_1.TriggerEvent(Clicked!)
end event

event pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

