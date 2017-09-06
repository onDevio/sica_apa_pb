HA$PBExportHeader$w_busqueda_tarifas_coeficientes.srw
forward
global type w_busqueda_tarifas_coeficientes from w_mant_simple
end type
type dw_2 from u_dw within w_busqueda_tarifas_coeficientes
end type
type cb_aceptar from commandbutton within w_busqueda_tarifas_coeficientes
end type
type cb_cancelar from commandbutton within w_busqueda_tarifas_coeficientes
end type
end forward

global type w_busqueda_tarifas_coeficientes from w_mant_simple
integer x = 214
integer y = 221
integer width = 4311
integer height = 1776
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
boolean clientedge = true
boolean ib_isupdateable = false
boolean ib_closestatus = true
event pfc_actualizar ( )
event pfc_nuevo ( )
event pfc_detalle ( )
dw_2 dw_2
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_busqueda_tarifas_coeficientes w_busqueda_tarifas_coeficientes

type variables
integer i_fila
end variables

on w_busqueda_tarifas_coeficientes.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_busqueda_tarifas_coeficientes.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event pfc_postopen;//integer child
//datawindowchild dwc

dw_1.retrieve(g_colegio)
dw_2.insertrow(0)
//dw_2.setitem(1,"activo",'A')
//child = dw_2.getchild( "familia",dwc)
//dwc.settransobject(SQLCA)
//dwc.retrieve()

dw_1.of_SetRowSelect(TRUE)
dw_1.of_SetRowManager(TRUE)
dw_1.of_SetSort(TRUE)
dw_1.of_SetProperty(TRUE)


end event

event activate;call super::activate;int i
i=1
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_busqueda_tarifas_coeficientes
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_busqueda_tarifas_coeficientes
integer x = 622
integer y = 1088
integer taborder = 20
end type

type dw_1 from w_mant_simple`dw_1 within w_busqueda_tarifas_coeficientes
integer x = 5
integer y = 316
integer width = 4238
integer height = 1192
integer taborder = 70
string dataobject = "d_busqueda_tarifas_coef_lista"
boolean hscrollbar = false
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
string is_updatesallowed = ""
end type

event dw_1::doubleclicked;call super::doubleclicked;string ls_id_variable


if dw_1.rowcount()>0  then 

    ls_id_variable = dw_1.getitemstring(dw_1.getrow(),"id")
	CloseWithReturn(parent,ls_id_variable)
	
end if

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_busqueda_tarifas_coeficientes
boolean visible = false
integer taborder = 50
boolean enabled = false
end type

event cb_anyadir::clicked;call super::clicked;dw_1.setitem(dw_1.getrow(),'colegio',g_colegio)
dw_1.setitem(dw_1.getrow(),'empresa',g_empresa)
end event

type cb_borrar from w_mant_simple`cb_borrar within w_busqueda_tarifas_coeficientes
boolean visible = false
integer taborder = 60
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_busqueda_tarifas_coeficientes
boolean visible = false
integer taborder = 30
end type

type dw_2 from u_dw within w_busqueda_tarifas_coeficientes
integer x = 37
integer y = 32
integer width = 3461
integer height = 236
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_busqueda_tarifas_coef_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;string ls_sql_old='',ls_sql_nuevo=''

choose case dwo.name
	case 	"b_1" //Buscar

		this.accepttext()
	
		ls_sql_old = dw_1.describe("datawindow.table.select")
		ls_sql_nuevo=ls_sql_old
		
		
		f_sql('tarifas_coeficientes.tipo_coef','=','tipo_coef',dw_2,ls_sql_nuevo,g_tipo_base_datos,'')
		f_sql('tarifas_coeficientes.variable','LIKE','variable',dw_2,ls_sql_nuevo,g_tipo_base_datos,'')
		
		dw_1.modify("datawindow.table.select= ~"" + ls_sql_nuevo + "~"")
		
		dw_1.Retrieve(g_colegio)
			
		dw_1.modify("datawindow.table.select= ~"" + ls_sql_old + "~"")
end choose
end event

type cb_aceptar from commandbutton within w_busqueda_tarifas_coeficientes
integer x = 1701
integer y = 1532
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;string ls_id_variable


if dw_1.rowcount()>0  then 

    ls_id_variable = dw_1.getitemstring(dw_1.getrow(),"id")
	CloseWithReturn(parent,ls_id_variable)
	
else
	
	
	ls_id_variable=""
	CloseWithReturn(parent,ls_id_variable)
end if

end event

type cb_cancelar from commandbutton within w_busqueda_tarifas_coeficientes
integer x = 2066
integer y = 1532
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;	
string ls_id_variable

ls_id_variable=""
CloseWithReturn(parent,ls_id_variable)

end event

