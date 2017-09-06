HA$PBExportHeader$w_etiquetas.srw
forward
global type w_etiquetas from w_response
end type
type dw_1 from u_dw within w_etiquetas
end type
end forward

global type w_etiquetas from w_response
integer x = 214
integer y = 221
integer width = 1618
integer height = 892
dw_1 dw_1
end type
global w_etiquetas w_etiquetas

type variables
datastore ids_etiquetas 

end variables

event open;st_certificados_etiquetas etiquetas
etiquetas = message.PowerObjectParm

//ids_etiquetas = etiquetas.ds_etiquetas
//ids_etiquetas = create datastore

dw_1.reset()
etiquetas.ds_etiquetas.rowscopy(1, etiquetas.ds_etiquetas.rowcount(),primary!,dw_1,1,primary!)
//destroy ids_etiquetas

this.x=etiquetas.posx
this.y=etiquetas.posy
this.title='Etiquetas'
g_rtf_paso_param.etiqueta=''

end event

on w_etiquetas.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_etiquetas.destroy
call super::destroy
destroy(this.dw_1)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_etiquetas
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_etiquetas
end type

type dw_1 from u_dw within w_etiquetas
integer width = 1591
integer height = 800
integer taborder = 10
string dataobject = "d_etiquetas"
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
end event

event doubleclicked;g_rtf_paso_param.etiqueta=this.getitemstring(row,'etiqueta')
if LenA(g_rtf_paso_param.etiqueta) < 3 then g_rtf_paso_param.etiqueta=''
close(w_etiquetas)
end event

event losefocus;call super::losefocus;close(parent)
end event

