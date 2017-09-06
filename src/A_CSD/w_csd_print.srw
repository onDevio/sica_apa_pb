HA$PBExportHeader$w_csd_print.srw
forward
global type w_csd_print from w_print
end type
end forward

global type w_csd_print from w_print
integer width = 2021
string title = "Imprimir"
end type
global w_csd_print w_csd_print

on w_csd_print.create
call super::create
end on

on w_csd_print.destroy
call super::destroy
end on

type cb_recuperar_pantalla from w_print`cb_recuperar_pantalla within w_csd_print
end type

type cb_guardar_pantalla from w_print`cb_guardar_pantalla within w_csd_print
end type

type cbx_printtofile from w_print`cbx_printtofile within w_csd_print
boolean visible = false
integer width = 517
string text = "Imprimir a archivo"
end type

type rb_all from w_print`rb_all within w_csd_print
string tag = "texto=Todo"
string text = "&Todo"
end type

type rb_pages from w_print`rb_pages within w_csd_print
string tag = "texto=P$$HEX1$$e100$$ENDHEX$$ginas"
integer width = 270
string text = "P$$HEX1$$e100$$ENDHEX$$&ginas"
end type

type st_1 from w_print`st_1 within w_csd_print
string tag = "texto=de:"
integer width = 128
string text = "de:"
alignment alignment = right!
end type

type em_frompage from w_print`em_frompage within w_csd_print
integer height = 72
end type

type st_2 from w_print`st_2 within w_csd_print
string tag = "texto=a:"
string text = "a:"
alignment alignment = right!
end type

type em_topage from w_print`em_topage within w_csd_print
integer height = 72
end type

type rb_selection from w_print`rb_selection within w_csd_print
end type

type p_collate from w_print`p_collate within w_csd_print
end type

type gb_1 from w_print`gb_1 within w_csd_print
string tag = "texto=Intervalo de p$$HEX1$$e100$$ENDHEX$$ginas"
string text = "Intervalo de p$$HEX1$$e100$$ENDHEX$$ginas "
end type

type st_3 from w_print`st_3 within w_csd_print
string tag = "texto=N$$HEX1$$fa00$$ENDHEX$$mero de copias:"
string text = "N$$HEX1$$fa00$$ENDHEX$$mero de copias:"
end type

type em_copies from w_print`em_copies within w_csd_print
end type

type cbx_collate from w_print`cbx_collate within w_csd_print
string tag = "texto=Intercalar"
integer width = 306
string text = "Intercalar"
end type

type cb_ok from w_print`cb_ok within w_csd_print
string tag = "texto=OK"
end type

type cb_cancel from w_print`cb_cancel within w_csd_print
string tag = "texto=Cancelar"
string text = "Cancelar"
end type

type cb_printer from w_print`cb_printer within w_csd_print
string tag = "texto=Impresora..."
string text = "Impresora..."
end type

type gb_2 from w_print`gb_2 within w_csd_print
string tag = "texto=Copias"
integer width = 869
string text = "Copias"
end type

