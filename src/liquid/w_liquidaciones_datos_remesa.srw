HA$PBExportHeader$w_liquidaciones_datos_remesa.srw
forward
global type w_liquidaciones_datos_remesa from w_response
end type
type cb_cancelar from commandbutton within w_liquidaciones_datos_remesa
end type
type cb_aceptar from commandbutton within w_liquidaciones_datos_remesa
end type
type dw_1 from u_dw within w_liquidaciones_datos_remesa
end type
end forward

global type w_liquidaciones_datos_remesa from w_response
integer width = 2359
integer height = 884
string title = "Datos Remesa"
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_1 dw_1
end type
global w_liquidaciones_datos_remesa w_liquidaciones_datos_remesa

on w_liquidaciones_datos_remesa.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.dw_1
end on

on w_liquidaciones_datos_remesa.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_1)
end on

event open;call super::open;f_centrar_ventana(this)
dw_1.InsertRow(1)

if f_es_vacio(dw_1.getitemstring(1, 'banco')) then dw_1.SetItem(1,'banco',g_banco_por_defecto)
dw_1.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(g_banco_por_defecto))
dw_1.SetItem(1,'fecha',datetime(Today()))

gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_1)
end event

event pfc_postopen;call super::pfc_postopen;string banco

dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

//Modificado por Luis CZA-92
if(g_colegio = 'COAATZ')then
	dw_1.SetItem(1,'banco',g_banco_por_defecto)
end if
//fin modificado Luis
banco = dw_1.getitemstring(1, 'banco')
dw_1.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(banco))
end event

event csd_recuperar_consulta;call super::csd_recuperar_consulta;gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_1)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_liquidaciones_datos_remesa
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_liquidaciones_datos_remesa
end type

type cb_cancelar from commandbutton within w_liquidaciones_datos_remesa
integer x = 1262
integer y = 636
integer width = 402
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;st_cobros_datos_remesa datos_remesa

datos_remesa.banco 	= '-1'
CloseWithReturn(Parent,datos_remesa)
end event

type cb_aceptar from commandbutton within w_liquidaciones_datos_remesa
integer x = 741
integer y = 636
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;st_cobros_datos_remesa datos_remesa

datos_remesa.banco 			= dw_1.GetItemString(1,'banco')
datos_remesa.codigo			= dw_1.GetItemString(1,'codigo')
datos_remesa.fecha			= dw_1.GetItemDateTime(1,'fecha')
datos_remesa.concepto	= dw_1.GetItemString(1,'concepto')
datos_remesa.formato	= dw_1.GetItemString(1,'formato_norma')

CloseWithReturn(parent,datos_remesa)

end event

type dw_1 from u_dw within w_liquidaciones_datos_remesa
integer x = 37
integer y = 64
integer width = 2254
integer height = 452
integer taborder = 10
string title = "Datos Remesa"
string dataobject = "d_liquidaciones_datos_remesa"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;CHOOSE CASE dwo.name
	CASE 'banco'
		this.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(data))
END CHOOSE
end event

