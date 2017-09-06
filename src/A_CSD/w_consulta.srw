HA$PBExportHeader$w_consulta.srw
forward
global type w_consulta from w_response
end type
type cb_limpiar from commandbutton within w_consulta
end type
type st_5 from statictext within w_consulta
end type
type cb_1 from commandbutton within w_consulta
end type
type cb_2 from commandbutton within w_consulta
end type
type cb_ayuda from commandbutton within w_consulta
end type
type dw_1 from u_dw within w_consulta
end type
end forward

global type w_consulta from w_response
integer width = 1938
integer height = 1180
string title = "Consulta de Fichas"
boolean controlmenu = false
event csd_actualiza_dddw ( )
cb_limpiar cb_limpiar
st_5 st_5
cb_1 cb_1
cb_2 cb_2
cb_ayuda cb_ayuda
dw_1 dw_1
end type
global w_consulta w_consulta

event csd_actualiza_dddw;// Actualizamos los dddw de la ventana
	f_actualizar_ventana(this)

end event

on w_consulta.create
int iCurrent
call super::create
this.cb_limpiar=create cb_limpiar
this.st_5=create st_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_ayuda=create cb_ayuda
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_limpiar
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_ayuda
this.Control[iCurrent+6]=this.dw_1
end on

on w_consulta.destroy
call super::destroy
destroy(this.cb_limpiar)
destroy(this.st_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_ayuda)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.event pfc_addrow()


//inv_resize.of_register (cb_1, "scaletoRight&Bottom")
//inv_resize.of_register (cb_2, "scaletoRight&Bottom")
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_consulta
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_consulta
end type

type cb_limpiar from commandbutton within w_consulta
boolean visible = false
integer x = 1312
integer y = 928
integer width = 517
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Limpiar Consulta"
end type

event clicked;// borraremos los datos que tenga la consulta
parent.dw_1.deleterow(0)
parent.dw_1.event pfc_addrow()

end event

type st_5 from statictext within w_consulta
string tag = "texto=general.texto_consulta"
integer x = 105
integer y = 32
integer width = 1216
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79416533
boolean enabled = false
string text = "Introduzca los par$$HEX1$$e100$$ENDHEX$$metros de consulta y pulse &Aceptar"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_consulta
event clicked pbm_bnclicked
string tag = "texto=general.aceptar"
integer x = 96
integer y = 928
integer width = 512
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;dw_1.Accepttext()

//string sql_nuevo
//Recuperamos le select del datawindow de lista
//sql_nuevo = g_dw_lista.describe("datawindow.table.select")
//f_sql('cod_acometida', 'LIKE', 'cod_acometida', Parent.dw_1,sql_nuevo)
// ... f_sql$$HEX1$$b400$$ENDHEX$$s
//modificamos el dw con los parametros de la ventana de consulta
//g_dw_lista.modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

//Parent.event pfc_close()



end event

type cb_2 from commandbutton within w_consulta
string tag = "texto=general.cancelar"
integer x = 718
integer y = 928
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Closewithreturn(parent,-1)
end event

type cb_ayuda from commandbutton within w_consulta
boolean visible = false
integer x = 1335
integer y = 928
integer width = 512
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ayuda"
boolean cancel = true
end type

event clicked;f_ayuda(40)

end event

event constructor;this.visible = false
end event

type dw_1 from u_dw within w_consulta
integer x = 110
integer y = 120
integer width = 1614
integer height = 724
integer taborder = 10
string dataobject = "d_actividades"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event itemfocuschanged;call super::itemfocuschanged;//f_asistente(this, dwo.name)
end event

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

