HA$PBExportHeader$w_zoom.srw
$PBExportComments$TRADUCIDO.
forward
global type w_zoom from pfc_w_zoom
end type
end forward

global type w_zoom from pfc_w_zoom
long BackColor=79741120
end type
global w_zoom w_zoom

on w_zoom.create
call super::create
end on

on w_zoom.destroy
call super::destroy
end on

type st_1 from pfc_w_zoom`st_1 within w_zoom
string Text="Porcentaje:"
end type

type cb_cancel from pfc_w_zoom`cb_cancel within w_zoom
string Text="Cancelar"
end type

type cb_apply from pfc_w_zoom`cb_apply within w_zoom
string Text="&Aplicar"
end type

type gb_1 from pfc_w_zoom`gb_1 within w_zoom
string Text="Vista preliminar"
end type

type gb_3 from pfc_w_zoom`gb_3 within w_zoom
string Text="Zoom"
end type

type cb_dlghelp from pfc_w_zoom`cb_dlghelp within w_zoom
int Y=788
boolean Visible=false
end type

