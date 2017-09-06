HA$PBExportHeader$w_busqueda_old.srw
forward
global type w_busqueda_old from w_response
end type
type sle_1 from singlelineedit within w_busqueda_old
end type
type dw_1 from datawindow within w_busqueda_old
end type
type dw_2 from datawindow within w_busqueda_old
end type
type st_1 from statictext within w_busqueda_old
end type
type st_2 from statictext within w_busqueda_old
end type
type cb_1 from commandbutton within w_busqueda_old
end type
type cb_2 from commandbutton within w_busqueda_old
end type
end forward

global type w_busqueda_old from w_response
int X=46
int Y=124
int Width=2738
int Height=1452
sle_1 sle_1
dw_1 dw_1
dw_2 dw_2
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
end type
global w_busqueda_old w_busqueda_old

on w_busqueda_old.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
end on

on w_busqueda_old.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;this.title=g_busqueda.titulo
dw_1.DataObject=g_busqueda.dw
dw_1.SetTransObject(SQLCA)
end event

type sle_1 from singlelineedit within w_busqueda_old
int X=805
int Y=68
int Width=1870
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;dw_1.Retrieve(this.text+'%')
end event

type dw_1 from datawindow within w_busqueda_old
int X=41
int Y=320
int Width=2647
int Height=908
int TabOrder=20
boolean BringToTop=true
string DataObject="d_dddw_jur_term_prueba"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;cb_1.TriggerEvent(clicked!)
end event

type dw_2 from datawindow within w_busqueda_old
int X=795
int Y=176
int Width=1897
int Height=116
int TabOrder=30
boolean BringToTop=true
string DataObject="d_busqueda_activa"
boolean Border=false
boolean LiveScroll=true
end type

event editchanged;dw_1.Retrieve(data+'%')
end event

event constructor;this.insertrow(0)
end event

type st_1 from statictext within w_busqueda_old
int X=37
int Y=72
int Width=745
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Introduzca el par$$HEX1$$e100$$ENDHEX$$metro completo:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_busqueda_old
int X=37
int Y=192
int Width=617
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Par$$HEX1$$e100$$ENDHEX$$metro activo al teclear:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_busqueda_old
int X=430
int Y=1244
int Width=590
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="&Aceptar: Devolver Valor"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_1.Rowcount() < 1 then
	parent.event pfc_close()
	return
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))
end event

type cb_2 from commandbutton within w_busqueda_old
int X=1472
int Y=1244
int Width=590
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="&Cancelar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.event pfc_close()
end event

