HA$PBExportHeader$w_listas_seleccion.srw
forward
global type w_listas_seleccion from w_response
end type
type cb_borrar from commandbutton within w_listas_seleccion
end type
type cb_2 from commandbutton within w_listas_seleccion
end type
type cb_1 from commandbutton within w_listas_seleccion
end type
type st_1 from statictext within w_listas_seleccion
end type
type dw_1 from u_dw within w_listas_seleccion
end type
type dw_opcion from u_dw within w_listas_seleccion
end type
end forward

global type w_listas_seleccion from w_response
integer width = 2885
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n de Listas"
cb_borrar cb_borrar
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_1 dw_1
dw_opcion dw_opcion
end type
global w_listas_seleccion w_listas_seleccion

on w_listas_seleccion.create
int iCurrent
call super::create
this.cb_borrar=create cb_borrar
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_opcion=create dw_opcion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_borrar
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_opcion
end on

on w_listas_seleccion.destroy
call super::destroy
destroy(this.cb_borrar)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_opcion)
end on

event open;f_centrar_ventana(this)
dw_opcion.InsertRow(0)

dw_1.SetRedraw(FALSE)
dw_1.Retrieve()
dw_1.SetFilter("propietario = '" + g_usuario+"'")
dw_1.Filter()
dw_1.SetRedraw(TRUE)



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_listas_seleccion
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_listas_seleccion
string tag = "texto=general.guardar_pantalla"
end type

type cb_borrar from commandbutton within w_listas_seleccion
string tag = "texto=general.borrar"
integer x = 1129
integer y = 1228
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Borrar"
end type

event clicked;int fila
string id_consulta

fila = dw_1.GetRow()
if fila=0 then return

id_consulta = dw_1.GetItemString(fila,'id_consulta')

//Verificamos el borrado
if Messagebox(g_titulo,g_idioma.of_getmsg('msg_listas.borrar_consulta','ATENCION!!  Esta operaci$$HEX1$$f300$$ENDHEX$$n borrar$$HEX2$$e1002000$$ENDHEX$$la consulta seleccionada.')+cr+g_idioma.of_getmsg('msg_listas.desea_continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?'),Question!,YesNo!)=2 then return
//Borramos la entrada de la tabla 'consultas'
dw_1.DeleteRow(fila)
//Borramos entradas de la tabla 'consultas_datos'
delete from consultas_datos where id_consulta = :id_consulta;

dw_1.Update()




	
end event

type cb_2 from commandbutton within w_listas_seleccion
string tag = "texto=general.cancelar"
integer x = 1623
integer y = 1228
integer width = 402
integer height = 92
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

event clicked;CloseWithReturn(parent,'')
end event

type cb_1 from commandbutton within w_listas_seleccion
string tag = "texto=general.aceptar"
integer x = 640
integer y = 1228
integer width = 402
integer height = 92
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

event clicked;string id_lista

id_lista = dw_1.GetItemString(dw_1.GetRow(),'id_lista')

CloseWithReturn(parent,id_lista)
end event

type st_1 from statictext within w_listas_seleccion
string tag = "texto=listas.seleccione_lista"
integer x = 105
integer y = 68
integer width = 1458
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione una lista :"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_listas_seleccion
integer x = 37
integer y = 216
integer width = 2789
integer height = 968
integer taborder = 10
string dataobject = "d_listas_seleccion"
boolean livescroll = false
end type

event doubleclicked;call super::doubleclicked;cb_1.Event Clicked()
end event

event retrieveend;call super::retrieveend;this.SetFocus()
this.PostEvent(Rowfocuschanged!)
end event

event rowfocuschanged;call super::rowfocuschanged;if this.RowCount() < 1 then return

this.selectrow(0,false)
this.selectrow(Getrow(), true)
end event

type dw_opcion from u_dw within w_listas_seleccion
integer x = 1733
integer y = 48
integer width = 1010
integer height = 136
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_consulta_seleccion_tipo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;string opcion,filtro

dw_1.SetRedraw(FALSE)

if data ='%' then 
	filtro = ""
else
	filtro = "propietario = '"+ g_usuario +"'"
end if


dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.SetRedraw(TRUE)


end event

