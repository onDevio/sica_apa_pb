HA$PBExportHeader$w_visared_alta_poblacion.srw
forward
global type w_visared_alta_poblacion from w_response
end type
type dw_1 from u_dw within w_visared_alta_poblacion
end type
type cb_1 from commandbutton within w_visared_alta_poblacion
end type
type cb_aceptar from commandbutton within w_visared_alta_poblacion
end type
end forward

global type w_visared_alta_poblacion from w_response
integer width = 2491
integer height = 804
dw_1 dw_1
cb_1 cb_1
cb_aceptar cb_aceptar
end type
global w_visared_alta_poblacion w_visared_alta_poblacion

type variables
st_visared_poblacion poblacion


end variables

on w_visared_alta_poblacion.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_aceptar
end on

on w_visared_alta_poblacion.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_aceptar)
end on

event open;call super::open;f_centrar_ventana(this)
int fila
string nom, cod_prov

poblacion=message.PowerObjectParm
fila=dw_1.InsertRow(0)
dw_1.setItem(fila,"descripcion",poblacion.descripcion)
dw_1.setItem(fila,"cod_pos",poblacion.cod_pos)
dw_1.setItem(fila,"cod_pob",poblacion.cod_pos)
dw_1.setItem(fila, "provincia",poblacion.provincia)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_alta_poblacion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_alta_poblacion
end type

type dw_1 from u_dw within w_visared_alta_poblacion
integer x = 73
integer y = 48
integer width = 2359
integer height = 452
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_visared_alta_poblacion"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;string cod_prov, nom_prov

if dwo.name='cod_pos' then

cod_prov=f_dame_provincia(data)
dw_1.setItem(dw_1.getRow(), "provincia",cod_prov)

select nombre into :nom_prov from provincias where cod_provincia=:cod_prov;
dw_1.object.t_provincia.text=nom_prov

end if
end event

type cb_1 from commandbutton within w_visared_alta_poblacion
integer x = 1202
integer y = 548
integer width = 462
integer height = 112
integer taborder = 40
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

event clicked;dw_1.ResetUpdate()
CloseWithReturn(parent,-1)
end event

type cb_aceptar from commandbutton within w_visared_alta_poblacion
integer x = 672
integer y = 548
integer width = 462
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;parent.TriggerEvent('pfc_save')

CloseWithReturn(parent,1)
end event

