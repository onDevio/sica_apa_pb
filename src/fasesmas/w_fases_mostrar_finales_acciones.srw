HA$PBExportHeader$w_fases_mostrar_finales_acciones.srw
forward
global type w_fases_mostrar_finales_acciones from w_popup
end type
type dw_1 from u_dw within w_fases_mostrar_finales_acciones
end type
end forward

global type w_fases_mostrar_finales_acciones from w_popup
integer width = 3017
integer height = 624
string title = "Acciones a Realizar para una Correcta realizaci$$HEX1$$f300$$ENDHEX$$n en los finales de obra"
event csd_cargar_valores ( st_finales_acciones finales_acciones )
dw_1 dw_1
end type
global w_fases_mostrar_finales_acciones w_fases_mostrar_finales_acciones

event csd_cargar_valores(st_finales_acciones finales_acciones);// Volvemos a cargar con los nuevos tipos pasados
dw_1.reset()
dw_1.retrieve(finales_acciones.tipo_trabajo, finales_acciones.trabajo)

if dw_1.rowcount()<1 then
	close(this)
end if

end event

on w_fases_mostrar_finales_acciones.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_fases_mostrar_finales_acciones.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within w_fases_mostrar_finales_acciones
integer x = 14
integer y = 12
integer width = 2958
integer height = 496
integer taborder = 10
string dataobject = "d_fases_mostrar_finales_acciones"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

