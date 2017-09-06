HA$PBExportHeader$w_toolbars.srw
$PBExportComments$TRADUCIDO. LORENZO. SEPTIEMBRE 1998.
forward
global type w_toolbars from pfc_w_toolbars
end type
end forward

global type w_toolbars from pfc_w_toolbars
boolean TitleBar=true
string Title="Organizar Herramientas"
long BackColor=79741120
end type
global w_toolbars w_toolbars

on w_toolbars.create
call super::create
end on

on w_toolbars.destroy
call super::destroy
end on

type st_selecttoolbar from pfc_w_toolbars`st_selecttoolbar within w_toolbars
int Width=553
string Text="&Barras de Herramientas:"
end type

type cb_ok from pfc_w_toolbars`cb_ok within w_toolbars
int X=192
end type

type cb_cancel from pfc_w_toolbars`cb_cancel within w_toolbars
int X=567
string Text="Cancelar"
end type

type cbx_text from pfc_w_toolbars`cbx_text within w_toolbars
string Text="Botones grandes"
end type

type cbx_tips from pfc_w_toolbars`cbx_tips within w_toolbars
string Text="Mostrar ayudas"
end type

type cb_apply from pfc_w_toolbars`cb_apply within w_toolbars
int X=942
string Text="&Aplicar"
end type

type gb_app from pfc_w_toolbars`gb_app within w_toolbars
string Text="Opciones de la aplicaci$$HEX1$$f300$$ENDHEX$$n"
end type

type rb_top from pfc_w_toolbars`rb_top within w_toolbars
string Text="Superior"
end type

type rb_bottom from pfc_w_toolbars`rb_bottom within w_toolbars
string Text="Inferior"
end type

type rb_left from pfc_w_toolbars`rb_left within w_toolbars
string Text="Izquierda"
end type

type rb_right from pfc_w_toolbars`rb_right within w_toolbars
string Text="Derecha"
end type

type rb_floating from pfc_w_toolbars`rb_floating within w_toolbars
string Text="&Flotante"
end type

type gb_position from pfc_w_toolbars`gb_position within w_toolbars
string Text="Posici$$HEX1$$f300$$ENDHEX$$n"
end type

type cb_dlghelp from pfc_w_toolbars`cb_dlghelp within w_toolbars
boolean Visible=false
end type

