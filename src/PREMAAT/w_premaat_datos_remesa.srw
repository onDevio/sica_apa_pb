HA$PBExportHeader$w_premaat_datos_remesa.srw
forward
global type w_premaat_datos_remesa from w_response
end type
type cb_cancelar from commandbutton within w_premaat_datos_remesa
end type
type cb_aceptar from commandbutton within w_premaat_datos_remesa
end type
type dw_1 from u_dw within w_premaat_datos_remesa
end type
end forward

global type w_premaat_datos_remesa from w_response
integer width = 2405
integer height = 980
string title = "Datos Remesa"
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_1 dw_1
end type
global w_premaat_datos_remesa w_premaat_datos_remesa

on w_premaat_datos_remesa.create
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

on w_premaat_datos_remesa.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_1)
end on

event open;call super::open;string tipo

tipo = message.stringparm

f_centrar_ventana(this)
dw_1.InsertRow(1)

// Ponemos ese concepto por defecto s$$HEX1$$f300$$ENDHEX$$lo para las liquidaciones de premaat
if tipo = 'PREMAAT' then 
	dw_1.setitem(1, 'concepto', 'Prest. PREMAAT ' +  f_obtener_mes(datetime(today())) + ' ' +string(year(today())))
end if

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

banco = dw_1.getitemstring(1, 'banco')
dw_1.SetItem(1,'codigo',f_cobros_devuelve_ncontrol(banco))
end event

event csd_recuperar_consulta;call super::csd_recuperar_consulta;gnv_control_cuentas_bancarias.of_sepa_habilitado (dw_1)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_premaat_datos_remesa
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_premaat_datos_remesa
end type

type cb_cancelar from commandbutton within w_premaat_datos_remesa
string tag = "texto=general.cancelar"
integer x = 1280
integer y = 732
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

type cb_aceptar from commandbutton within w_premaat_datos_remesa
string tag = "texto=general.aceptar"
integer x = 759
integer y = 732
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

dw_1.accepttext()
datos_remesa.banco 			= dw_1.GetItemString(1,'banco')
datos_remesa.codigo			= dw_1.GetItemString(1,'codigo')
datos_remesa.fecha			= dw_1.GetItemDateTime(1,'fecha')
datos_remesa.concepto	= dw_1.GetItemString(1,'concepto')
datos_remesa.formato	= dw_1.GetItemString(1,'formato_norma')

CloseWithReturn(parent,datos_remesa)

end event

type dw_1 from u_dw within w_premaat_datos_remesa
integer x = 64
integer y = 96
integer width = 2286
integer height = 444
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

