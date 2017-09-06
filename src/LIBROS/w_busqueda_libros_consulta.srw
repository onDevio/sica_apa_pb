HA$PBExportHeader$w_busqueda_libros_consulta.srw
forward
global type w_busqueda_libros_consulta from window
end type
type dw_colegiado from datawindow within w_busqueda_libros_consulta
end type
end forward

global type w_busqueda_libros_consulta from window
integer width = 3159
integer height = 976
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
dw_colegiado dw_colegiado
end type
global w_busqueda_libros_consulta w_busqueda_libros_consulta

event open;string ls_libro
st_libro_busqueda lst_parametros
dw_colegiado.SetTransObject(SQLCA)

f_centrar_ventana(this)
lst_parametros = message.PowerObjectParm
ls_libro   = lst_parametros.id_libro

this.title = "LIBRO   " + lst_parametros.titulo

if	dw_colegiado.retrieve(ls_libro)<= 0 then

	Messagebox(G_TITULO, "No existen registros")

	close(this)
end if
end event

on w_busqueda_libros_consulta.create
this.dw_colegiado=create dw_colegiado
this.Control[]={this.dw_colegiado}
end on

on w_busqueda_libros_consulta.destroy
destroy(this.dw_colegiado)
end on

type dw_colegiado from datawindow within w_busqueda_libros_consulta
integer x = 18
integer y = 20
integer width = 3072
integer height = 772
integer taborder = 10
string title = "none"
string dataobject = "d_libros_colegiados"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

