HA$PBExportHeader$w_mant_busq_form.srw
$PBExportComments$MADRE DE LOS MANTENIMIENTOS TAB/FORM CON BUSQUEDA
forward
global type w_mant_busq_form from w_mant_busq
end type
type cb_detalle from commandbutton within w_mant_busq_form
end type
type dw_2 from u_dw within w_mant_busq_form
end type
end forward

global type w_mant_busq_form from w_mant_busq
int Width=2665
event csd_detalle ( )
event csd_lista ( )
cb_detalle cb_detalle
dw_2 dw_2
end type
global w_mant_busq_form w_mant_busq_form

type variables
string is_columna_ppal, is_columna_detalle
end variables

event csd_detalle;call super::csd_detalle;// Este evento:
// 1.- muestra dw_1 (detalle) y oculta  dw_2
// 2.- cambia el texto del cb_detalle
// 3.- inhabilita cb_buscar

dw_1.visible = true
dw_2.visible = false
cb_detalle.text = "&Lista"
cb_buscar.enabled =false
cb_borrar.enabled=true

end event

event csd_lista;call super::csd_lista;// Este evento:
// 1.- oculta dw_1 (detalle) y muestra  dw_2
// 2.- cambia el texto del cb_detalle
// 3.-habilita cb_buscar

int retorno

//Veamos si se ha modificado el detalle
retorno = this.Event closequery()
if retorno = 1 then return
dw_1.resetupdate()
dw_1.visible = false
dw_2.visible = true
cb_detalle.text = "&Detalle"
cb_buscar.enabled =true
cb_borrar.enabled=false
end event

event open;call super::open;//inv_resize.of_Register (dw_1, "FixedToRight&ScaleToBottom")
dw_retrieve=dw_2
dw_2.of_SetUpdateable(FALSE)
inv_resize.of_Register (cb_detalle, "FixedtoBottom")

ii_ayuda=70

dw_2.of_SetLinkage(TRUE)  //master o Retrieve
dw_1.of_SetLinkage(TRUE)  //detail

dw_2.of_SetTransObject(SQLCA)

dw_1.inv_linkage.of_LinkTo(dw_2)
dw_1.inv_linkage.of_SetArguments (is_columna_ppal,is_columna_detalle) 
//dw_2.inv_linkage.of_SetUpdateBottomUp (TRUE) 
dw_1.inv_linkage.of_SetUseColLinks(2)

This.PostEvent(resize!)
This.PostEvent("csd_lista")

sle_1.setfocus()
end event

on w_mant_busq_form.create
int iCurrent
call super::create
this.cb_detalle=create cb_detalle
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_detalle
this.Control[iCurrent+2]=this.dw_2
end on

on w_mant_busq_form.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_detalle)
destroy(this.dw_2)
end on

event resize;call super::resize;//Posici$$HEX1$$f300$$ENDHEX$$n y tama$$HEX1$$f100$$ENDHEX$$o de dw_2 (detalle)
dw_2.x = dw_1.x
dw_2.y = dw_1.y
dw_2.width  = dw_1.width
dw_2.height = dw_1.height

end event

type dw_1 from w_mant_busq`dw_1 within w_mant_busq_form
int Y=128
int Height=1056
int TabOrder=60
boolean Visible=false
string DataObject="d_clientes"
end type

type cb_anyadir from w_mant_busq`cb_anyadir within w_mant_busq_form
int TabOrder=70
end type

event cb_anyadir::clicked;call super::clicked;parent.PostEvent("csd_detalle")
dw_1.SetItem(dw_1.GetRow(),1,'')
end event

type cb_borrar from w_mant_busq`cb_borrar within w_mant_busq_form
int TabOrder=50
boolean BringToTop=true
end type

type cb_ayuda from w_mant_busq`cb_ayuda within w_mant_busq_form
boolean BringToTop=true
end type

type st_1 from w_mant_busq`st_1 within w_mant_busq_form
boolean BringToTop=true
end type

type st_2 from w_mant_busq`st_2 within w_mant_busq_form
boolean BringToTop=true
end type

type sle_1 from w_mant_busq`sle_1 within w_mant_busq_form
int TabOrder=40
end type

type sle_2 from w_mant_busq`sle_2 within w_mant_busq_form
int TabOrder=30
end type

type cb_buscar from w_mant_busq`cb_buscar within w_mant_busq_form
int TabOrder=20
boolean BringToTop=true
end type

event cb_buscar::clicked;call super::clicked;Parent.PostEvent("csd_lista")
end event

type cb_detalle from commandbutton within w_mant_busq_form
int X=832
int Y=1208
int Width=352
int Height=92
int TabOrder=41
boolean BringToTop=true
string Text="&Detalle"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "&Detalle" then
	parent.PostEvent("csd_detalle")
else
	parent.PostEvent("csd_lista")
end if

end event

type dw_2 from u_dw within w_mant_busq_form
int X=1746
int Y=1120
int Width=763
int Height=204
int TabOrder=10
boolean BringToTop=true
string DataObject="d_clientes_lista"
boolean HScrollBar=true
end type

event doubleclicked;call super::doubleclicked;cb_detalle.TriggerEvent(clicked!)
end event

event constructor;call super::constructor;inv_sort.of_SetColumnHeader (true)
inv_filter.of_SetStyle (1)
inv_sort.of_SetStyle (2)
of_SetPrintPreview (true)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve(sle_1.text+'%',sle_2.text+'%')
end event

