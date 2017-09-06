HA$PBExportHeader$w_asistente.srw
forward
global type w_asistente from w_popup
end type
type dw_1 from u_dw within w_asistente
end type
type cbx_1 from checkbox within w_asistente
end type
type cb_salir from commandbutton within w_asistente
end type
end forward

global type w_asistente from w_popup
integer x = 1504
integer y = 24
integer width = 1422
integer height = 640
string title = "Asistente"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
dw_1 dw_1
cbx_1 cbx_1
cb_salir cb_salir
end type
global w_asistente w_asistente

type variables
boolean ib_edicion
end variables

on w_asistente.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cbx_1=create cbx_1
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.cb_salir
end on

on w_asistente.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cbx_1)
destroy(this.cb_salir)
end on

event activate;call super::activate;//Lo primero, si no hay datos en g_asistente, nos largamos:

if isnull(g_asistente.dw) or isnull(g_asistente.campo) or g_asistente.dw='' or g_asistente.campo='' then return

if dw_1.Rowcount() >= 1 then
	string dw, campo
	//Si ya hay datos verificamos que no nos referimos al mismo dw/campo
	//antes de hacer un retrieve
	dw = dw_1.GetItemString(1,'dw')
	campo = dw_1.GetItemString(1,'campo')
	if dw = g_asistente.dw and campo = g_asistente.campo then return
end if

IF ib_edicion THEN
	// Llamamos al closequery  para ver si quiere grabar lo que hay
	this.trigger event closequery()
END IF
//Si no hay filas o si hay una fila referente a una dw/campo distintas:
//Hacemos un retrieve asociado al nuevo dw/campo
dw_1.Retrieve(g_asistente.dw, g_asistente.campo)

if dw_1.RowCount() = 0 and ib_edicion then
	//Si no se recupera ninguno y estamos permitiendo edici$$HEX1$$f300$$ENDHEX$$n, a$$HEX1$$f100$$ENDHEX$$adimos
	//una fila para permitir que se introduzca el t$$HEX1$$ed00$$ENDHEX$$tulo y ayuda
	//evitando que pida grabar si el usuario no teclea nada
	dw_1.InsertRow(0)
	dw_1.SetItem(1,'dw',g_asistente.dw)
	dw_1.SetItemStatus(1, 'dw', primary!, notmodified!)
	dw_1.SetItem(1,'campo',g_asistente.campo)
	dw_1.SetItemStatus(1, 'campo', primary!, notmodified!)
	dw_1.SetItemStatus(1, 0, primary!, notmodified!)
end if
end event

event open;call super::open;String modoedicion='N', ls_inifile

ls_inifile = gnv_app.of_GetAppInifile()

modoedicion = ProfileString ( ls_inifile, "Configuracion", "AsistenteModoedicion", "N")

ib_edicion = false

if modoedicion <> "S" then return


//Estamos en modo edici$$HEX1$$f300$$ENDHEX$$n, por lo que vamos a
//habilitar las funciones de edici$$HEX1$$f300$$ENDHEX$$n/grabaci$$HEX1$$f300$$ENDHEX$$n:
ib_edicion = true
//cb_grabar.visible = true
dw_1.Object.ayuda.Edit.DisplayOnly = 'no'
dw_1.Object.titulo.Edit.DisplayOnly = 'no'



end event

event pfc_close();call super::pfc_close;// VAciamos los campos para que no haya problemas
setnull(g_asistente.dw)
setnull(g_asistente.campo)

end event

type dw_1 from u_dw within w_asistente
event csd_retrieve ( )
integer x = 5
integer y = 4
integer width = 1390
integer height = 380
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_asistente"
boolean vscrollbar = false
end type

event csd_retrieve;//This.Retrieve(g_asistente.dw, g_asistente.campo)
//if this.RowCount()>0 then return
//if this.RowCount() = 0 and i_edicion then
//	This.InsertRow(0)
//	This.SetItem(1,'dw',g_asistente.dw)
//	This.SetItem(1,'campo',g_asistente.campo)	
//end if
//
end event

event itemfocuschanged;// SOBREESCRITO: El cambio de foco en este datawindow no deber$$HEX1$$ed00$$ENDHEX$$a modificar
// nada de la ventana

end event

event doubleclicked;// SOBREESCRITO: No queremos la ayuda en el asistente
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
am_dw.m_table.m_delete.enabled = false

end event

type cbx_1 from checkbox within w_asistente
boolean visible = false
integer x = 5
integer y = 408
integer width = 782
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 79741120
string text = "No volver a mostrar el asistente"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

type cb_salir from commandbutton within w_asistente
integer x = 910
integer y = 400
integer width = 485
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar Asistente"
end type

event clicked;string ls_inifile

if cbx_1.checked then
	ls_inifile = gnv_app.of_GetAppInifile()
	SetProfileString ( ls_inifile, "Configuracion", "AsistenteMostrar", "N" )
	Messagebox(g_titulo,"Ha decidido no volver a mostrar el asistente. Si desea volver a activarlo, pulse la opci$$HEX1$$f300$$ENDHEX$$n de men$$HEX2$$fa002000$$ENDHEX$$Asistente.",Information!)
end if

// VAciamos los campos para que no haya problemas
setnull(g_asistente.dw)
setnull(g_asistente.campo)


close(parent)
end event

