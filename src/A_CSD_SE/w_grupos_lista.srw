HA$PBExportHeader$w_grupos_lista.srw
forward
global type w_grupos_lista from w_sheet
end type
type dw_lista from u_dw within w_grupos_lista
end type
type dw_1 from u_dw within w_grupos_lista
end type
type cb_grabar from u_cb within w_grupos_lista
end type
type cb_salir from u_cb within w_grupos_lista
end type
type dw_grupo from u_dw within w_grupos_lista
end type
type cb_cancelar from u_cb within w_grupos_lista
end type
type st_grupo from statictext within w_grupos_lista
end type
type st_permisos from statictext within w_grupos_lista
end type
end forward

global type w_grupos_lista from w_sheet
integer width = 4091
integer height = 2216
windowstate windowstate = maximized!
dw_lista dw_lista
dw_1 dw_1
cb_grabar cb_grabar
cb_salir cb_salir
dw_grupo dw_grupo
cb_cancelar cb_cancelar
st_grupo st_grupo
st_permisos st_permisos
end type
global w_grupos_lista w_grupos_lista

type variables

end variables

on w_grupos_lista.create
int iCurrent
call super::create
this.dw_lista=create dw_lista
this.dw_1=create dw_1
this.cb_grabar=create cb_grabar
this.cb_salir=create cb_salir
this.dw_grupo=create dw_grupo
this.cb_cancelar=create cb_cancelar
this.st_grupo=create st_grupo
this.st_permisos=create st_permisos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_grabar
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.dw_grupo
this.Control[iCurrent+6]=this.cb_cancelar
this.Control[iCurrent+7]=this.st_grupo
this.Control[iCurrent+8]=this.st_permisos
end on

on w_grupos_lista.destroy
call super::destroy
destroy(this.dw_lista)
destroy(this.dw_1)
destroy(this.cb_grabar)
destroy(this.cb_salir)
destroy(this.dw_grupo)
destroy(this.cb_cancelar)
destroy(this.st_grupo)
destroy(this.st_permisos)
end on

event open;call super::open;
dw_1.SetTransObject(SQLCA)
dw_1.retrieve()

dw_lista.SetTransObject(SQLCA)
dw_lista.retrieve()

of_SetResize (true)
inv_resize.of_Register (dw_lista, "ScaletoBottom")
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_grabar, "FixedtoBottom")
inv_resize.of_Register (cb_cancelar, "FixedtoBottom")
inv_resize.of_Register (cb_salir, "FixedtoRight&Bottom")
//inv_resize.of_Register (st_permisos, "FixedtoRight")

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_grupos_lista
integer taborder = 40
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_grupos_lista
end type

type dw_lista from u_dw within w_grupos_lista
integer x = 23
integer y = 144
integer width = 1847
integer height = 1768
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_grupo"
end type

event rowfocuschanged;call super::rowfocuschanged;string cod_grupo,cod_aplic,permiso
long i,indice

if currentrow<1 then return

for i=1 to dw_1.rowcount()
	dw_1.SetItem(i,'seleccionado','N')
next

cod_grupo=dw_lista.GetItemSTring(currentrow,'cod_grupo')

dw_grupo.DataObject='d_grupo_permisos'
dw_grupo.SetTransObject(SQLCA)
dw_grupo.retrieve(cod_grupo)


for i=1 to dw_grupo.rowcount()
	cod_aplic=dw_grupo.GetItemString(i,'cod_aplicacion')
	indice=dw_1.find("cod_aplicacion='" + cod_aplic + "'",1,dw_1.rowcount())
	if indice>0 then 
		permiso=dw_grupo.GetItemString(i,'permiso')
		dw_1.SetItem(indice,'seleccionado',permiso)
	end if
next
end event

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)
// Orden
of_setsort(true)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
end event

event retrieveend;call super::retrieveend;if rowcount>0 then 
	this.SetRow(1)
	this.event rowfocuschanged(1)
end if
end event

event pfc_addrow;call super::pfc_addrow;cb_grabar.enabled=true

return ancestorreturnvalue
end event

event pfc_predeleterow;call super::pfc_predeleterow;string cod_grupo
long i

if MessageBox("$$HEX1$$bf00$$ENDHEX$$Borrar?","Esto borrar$$HEX2$$e1002000$$ENDHEX$$el grupo definitivamente. $$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro?",Question!,YesNo!)<>1 then return 0


cod_grupo=dw_lista.GetItemString(dw_lista.GetRow(),'cod_grupo')

delete from t_grupo_permisos where cod_grupo=:cod_grupo;

return ancestorreturnvalue
end event

type dw_1 from u_dw within w_grupos_lista
integer x = 1925
integer y = 148
integer width = 2066
integer height = 1752
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_grupo_aplicacion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;long indice
string cod_aplic,cod_grupo

if dw_lista.rowcount() = 0 then return

dw_lista.enabled=false
cb_grabar.enabled=true
cb_cancelar.enabled=true

choose case dwo.name
	case 'seleccionado'
		// Buscamos si el permiso marcado existe en la tabla de permisos del grupo
		cod_aplic=dw_1.GetItemString(row,'cod_aplicacion')
		cod_grupo=dw_lista.GetItemString(dw_lista.GetRow(),'cod_grupo')
		indice=dw_grupo.find("cod_aplicacion='" + cod_aplic + "' and cod_grupo='"+cod_grupo+"'",1,dw_grupo.rowcount())
		
		// Si existe y habiamos marcado N, lo borramos
		// Si no existe y habiamos marcado S lo a$$HEX1$$f100$$ENDHEX$$adimos
		if indice>0 then
			if data='N' then
				dw_grupo.deleterow(indice)
			else
				dw_grupo.SetItem(indice,'permiso',data)
			end if
		else
			if data='L' or data='E' then 
				indice=dw_grupo.insertrow(0)
				dw_grupo.SetItem(indice,'cod_grupo',cod_grupo)
				dw_grupo.SetItem(indice,'cod_aplicacion',cod_aplic)
				dw_grupo.SetItem(indice,'permiso',data)				
			end if
		end if
		
		
end choose
end event

type cb_grabar from u_cb within w_grupos_lista
integer x = 87
integer y = 1956
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string text = "&Grabar"
end type

event clicked;call super::clicked;parent.event pfc_save()

dw_lista.enabled=true
cb_grabar.enabled=false
cb_cancelar.enabled=false

end event

type cb_salir from u_cb within w_grupos_lista
integer x = 3607
integer y = 1948
integer taborder = 21
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;close(parent)
end event

type dw_grupo from u_dw within w_grupos_lista
boolean visible = false
integer x = 2030
integer y = 1928
integer width = 946
integer height = 152
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_grupo_permisos"
end type

type cb_cancelar from u_cb within w_grupos_lista
integer x = 471
integer y = 1956
integer taborder = 21
boolean bringtotop = true
boolean enabled = false
string text = "&Cancelar"
end type

event clicked;call super::clicked;dw_lista.enabled=true
dw_lista.event rowfocuschanged(dw_lista.GetRow())
cb_grabar.enabled=false
cb_cancelar.enabled=false

end event

type st_grupo from statictext within w_grupos_lista
integer x = 896
integer y = 32
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Grupos"
boolean focusrectangle = false
end type

type st_permisos from statictext within w_grupos_lista
integer x = 2624
integer y = 40
integer width = 690
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Permisos de Grupo"
boolean focusrectangle = false
end type

