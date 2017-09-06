HA$PBExportHeader$w_calculo_formulas_visared.srw
forward
global type w_calculo_formulas_visared from w_calculo_formulas
end type
type cb_aceptar_vis from u_pb within w_calculo_formulas_visared
end type
type cb_cancelar_vis from u_pb within w_calculo_formulas_visared
end type
end forward

global type w_calculo_formulas_visared from w_calculo_formulas
cb_aceptar_vis cb_aceptar_vis
cb_cancelar_vis cb_cancelar_vis
end type
global w_calculo_formulas_visared w_calculo_formulas_visared

on w_calculo_formulas_visared.create
int iCurrent
call super::create
this.cb_aceptar_vis=create cb_aceptar_vis
this.cb_cancelar_vis=create cb_cancelar_vis
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar_vis
this.Control[iCurrent+2]=this.cb_cancelar_vis
end on

on w_calculo_formulas_visared.destroy
call super::destroy
destroy(this.cb_aceptar_vis)
destroy(this.cb_cancelar_vis)
end on

event open;call super::open;dw_variables.object.datawindow.color = 31315402

if i_calculo_formulas.classname() = 'n_calculo_coste_referencia' then
	this.width = 3000
	dw_variables.width = 2900
else
	this.width = 4500
	dw_variables.width = 4400
end if
f_centrar_ventana(this)

if f_colegio() = '35' then
	this.Title = 'C$$HEX1$$e100$$ENDHEX$$lculo de Honorarios'
end if

cb_recalcular.event clicked()

end event

type cb_recuperar_pantalla from w_calculo_formulas`cb_recuperar_pantalla within w_calculo_formulas_visared
end type

type cb_guardar_pantalla from w_calculo_formulas`cb_guardar_pantalla within w_calculo_formulas_visared
end type

type dw_variables from w_calculo_formulas`dw_variables within w_calculo_formulas_visared
string dataobject = "d_calculo_formulas_variables_visared"
end type

event dw_variables::buttonclicked;call super::buttonclicked;String ls_retorno

choose case dwo.name
	case 'b_porcentaje'
		 open(w_cuotas_porcentajes)
		 ls_retorno=Message.StringParm
		 if not f_es_vacio(ls_retorno) then
			 this.SetItem(row,'paplic',double(ls_retorno))
			 this.event itemchanged(row, this.object.paplic, ls_retorno)
		end if
end choose

end event

type cb_aceptar from w_calculo_formulas`cb_aceptar within w_calculo_formulas_visared
boolean visible = false
boolean default = false
end type

type cb_cancelar from w_calculo_formulas`cb_cancelar within w_calculo_formulas_visared
boolean visible = false
boolean cancel = false
end type

type cb_recalcular from w_calculo_formulas`cb_recalcular within w_calculo_formulas_visared
boolean visible = false
integer y = 1868
integer width = 352
integer height = 124
end type

type cbx_disenyo_avanzado from w_calculo_formulas`cbx_disenyo_avanzado within w_calculo_formulas_visared
boolean visible = false
end type

type cb_aceptar_vis from u_pb within w_calculo_formulas_visared
integer x = 69
integer y = 1868
integer height = 124
integer taborder = 11
boolean bringtotop = true
string text = ""
boolean default = true
string picturename = ".\Imagenes\Boton_aceptar.jpg"
end type

event clicked;call super::clicked;cb_aceptar.TriggerEvent(clicked!)

end event

type cb_cancelar_vis from u_pb within w_calculo_formulas_visared
integer x = 517
integer y = 1868
integer height = 124
integer taborder = 11
boolean bringtotop = true
string text = ""
boolean cancel = true
string picturename = ".\Imagenes\Boton_cancelar.jpg"
end type

event clicked;call super::clicked;cb_cancelar.TriggerEvent(clicked!)

end event

