HA$PBExportHeader$w_eimporta_barcode.srw
forward
global type w_eimporta_barcode from w_response
end type
type mle_texto from multilineedit within w_eimporta_barcode
end type
type cb_1 from u_cb within w_eimporta_barcode
end type
type cb_cancelar from u_cb within w_eimporta_barcode
end type
end forward

global type w_eimporta_barcode from w_response
integer width = 3424
integer height = 1932
string title = "Lector de c$$HEX1$$f300$$ENDHEX$$digo de barras / Importaci$$HEX1$$f300$$ENDHEX$$n"
mle_texto mle_texto
cb_1 cb_1
cb_cancelar cb_cancelar
end type
global w_eimporta_barcode w_eimporta_barcode

on w_eimporta_barcode.create
int iCurrent
call super::create
this.mle_texto=create mle_texto
this.cb_1=create cb_1
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_texto
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_eimporta_barcode.destroy
call super::destroy
destroy(this.mle_texto)
destroy(this.cb_1)
destroy(this.cb_cancelar)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_eimporta_barcode
integer x = 1774
integer y = 872
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_eimporta_barcode
integer x = 1774
integer y = 744
end type

type mle_texto from multilineedit within w_eimporta_barcode
integer x = 41
integer y = 16
integer width = 3333
integer height = 1564
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type cb_1 from u_cb within w_eimporta_barcode
integer x = 1262
integer y = 1660
integer width = 393
integer height = 104
integer taborder = 11
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;long li_filenum

//g_directorio_temporal + i_archivo_ini
li_FileNum = FileOpen(g_directorio_temporal + "barcode.ini", LineMode!, Write!, LockWrite!, Replace!)

FileWrite(li_FileNum, mle_texto.text)

FileClose(li_fileNum)

CloseWithreturn(parent,"1")
end event

type cb_cancelar from u_cb within w_eimporta_barcode
integer x = 1678
integer y = 1660
integer width = 393
integer height = 104
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;Close(parent)
end event

