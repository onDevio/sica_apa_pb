HA$PBExportHeader$w_fases_pagos_tpv.srw
forward
global type w_fases_pagos_tpv from w_response
end type
type dw_1 from u_dw within w_fases_pagos_tpv
end type
end forward

global type w_fases_pagos_tpv from w_response
integer width = 3104
integer height = 1200
dw_1 dw_1
end type
global w_fases_pagos_tpv w_fases_pagos_tpv

on w_fases_pagos_tpv.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_fases_pagos_tpv.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;f_centrar_ventana(this)

decimal ldc_id_fases_pagos_plataforma
// Recogemos el parametro de entrada
ldc_id_fases_pagos_plataforma = message.doubleparm

// Colocamos el calendario en el dw
dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

// REcuperamos la linea para este final de obra
dw_1.retrieve(ldc_id_fases_pagos_plataforma)
if dw_1.rowCount() = 0 then
	close(this)
	return
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_pagos_tpv
integer x = 1280
integer y = 936
string text = "Volver"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_pagos_tpv
integer x = 2277
integer y = 936
boolean enabled = false
end type

type dw_1 from u_dw within w_fases_pagos_tpv
integer x = 55
integer y = 44
integer width = 2999
integer height = 868
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_pagos_tpv"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

