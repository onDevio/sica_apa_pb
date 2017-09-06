HA$PBExportHeader$w_coaatg_honos_datos_adicionales.srw
forward
global type w_coaatg_honos_datos_adicionales from w_observaciones
end type
type cb_3 from cb_2 within w_coaatg_honos_datos_adicionales
end type
end forward

global type w_coaatg_honos_datos_adicionales from w_observaciones
integer height = 1172
cb_3 cb_3
end type
global w_coaatg_honos_datos_adicionales w_coaatg_honos_datos_adicionales

on w_coaatg_honos_datos_adicionales.create
int iCurrent
call super::create
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
end on

on w_coaatg_honos_datos_adicionales.destroy
call super::destroy
destroy(this.cb_3)
end on

event open;call super::open;f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_observaciones`cb_recuperar_pantalla within w_coaatg_honos_datos_adicionales
integer taborder = 0
end type

type cb_guardar_pantalla from w_observaciones`cb_guardar_pantalla within w_coaatg_honos_datos_adicionales
integer taborder = 0
end type

type sle_1 from w_observaciones`sle_1 within w_coaatg_honos_datos_adicionales
integer taborder = 0
end type

type dw_2 from w_observaciones`dw_2 within w_coaatg_honos_datos_adicionales
integer taborder = 0
end type

type st_1 from w_observaciones`st_1 within w_coaatg_honos_datos_adicionales
end type

type st_2 from w_observaciones`st_2 within w_coaatg_honos_datos_adicionales
end type

type cb_1 from w_observaciones`cb_1 within w_coaatg_honos_datos_adicionales
boolean visible = false
integer taborder = 0
end type

type cb_2 from w_observaciones`cb_2 within w_coaatg_honos_datos_adicionales
boolean visible = false
integer taborder = 0
end type

type dw_1 from w_observaciones`dw_1 within w_coaatg_honos_datos_adicionales
integer taborder = 0
end type

type mle_observaciones from w_observaciones`mle_observaciones within w_coaatg_honos_datos_adicionales
integer x = 32
integer y = 8
integer width = 2642
integer height = 892
integer taborder = 0
integer weight = 700
long textcolor = 8388736
long backcolor = 15793151
boolean vscrollbar = true
end type

type cb_3 from cb_2 within w_coaatg_honos_datos_adicionales
boolean visible = true
integer x = 1029
integer y = 940
integer taborder = 1
string text = "&Cerrar"
end type

