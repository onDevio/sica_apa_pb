HA$PBExportHeader$w_visanet_lectura.srw
forward
global type w_visanet_lectura from window
end type
type lb_1 from listbox within w_visanet_lectura
end type
type cb_2 from commandbutton within w_visanet_lectura
end type
type cb_1 from commandbutton within w_visanet_lectura
end type
type st_1 from statictext within w_visanet_lectura
end type
type sle_1 from singlelineedit within w_visanet_lectura
end type
end forward

global type w_visanet_lectura from window
integer width = 2295
integer height = 888
boolean titlebar = true
string title = "Lectura de Formulario Electr$$HEX1$$f300$$ENDHEX$$nico"
windowtype windowtype = response!
long backcolor = 67108864
lb_1 lb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_1 sle_1
end type
global w_visanet_lectura w_visanet_lectura

type variables
string i_pathvisanet,inombre_fichero
end variables

event open;string ls_inifile

f_centrar_ventana(this)

ls_inifile = gnv_app.of_GetAppInifile()

i_pathvisanet = ProfileString(ls_inifile, "visanet","path","Q:\RESENA")
//Llenamos la lista con los ficheros.
lb_1.DirList(i_pathvisanet + "\*.HR",0,st_1)

sle_1.setfocus()
end event

on w_visanet_lectura.create
this.lb_1=create lb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.lb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_1}
end on

on w_visanet_lectura.destroy
destroy(this.lb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

type lb_1 from listbox within w_visanet_lectura
integer x = 942
integer y = 240
integer width = 1143
integer height = 368
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;lb_1.Dirselect(inombre_fichero)
closewithreturn(parent,inombre_fichero)



end event

type cb_2 from commandbutton within w_visanet_lectura
integer x = 1742
integer y = 680
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;closewithreturn(parent,"")

end event

type cb_1 from commandbutton within w_visanet_lectura
integer x = 942
integer y = 680
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;string cadena,codigo_barras,ruta, inombre_ficherores
long i,id_inombre_fichero
boolean recuperar

recuperar=false

codigo_barras=string(sle_1.text)
For i= 1 to lb_1.TotalItems ( )
	inombre_fichero=string(lb_1.Text ( i ))
	ruta=i_pathvisanet + "\"+inombre_fichero
	if i>1 then fileclose(id_inombre_fichero)
	id_inombre_fichero = FileOpen(ruta,LineMode!,Read!)
	FileRead(id_inombre_fichero, cadena)
	
	//MESSAGEBOX('cadena',cadena)
	
	cadena = RightA(cadena,14)
	cadena = MidA(cadena,1,12)
	
	//MESSAGEBOX('CADENA,CODIGO BARRAS',CADENA+' '+CODIGO_BARRAS)
	
		if TRIM(cadena) = TRIM(codigo_barras) then 
			recuperar=true
			exit
		end if

next
fileclose(id_inombre_fichero)
if not recuperar then
	messagebox(g_titulo,'No se ha encontrado ning$$HEX1$$fa00$$ENDHEX$$n fichero con ese c$$HEX1$$f300$$ENDHEX$$digo de barras',Stopsign!)
	return
end if

closewithreturn(parent,inombre_fichero)
end event

type st_1 from statictext within w_visanet_lectura
integer x = 123
integer y = 140
integer width = 777
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Introduzca el c$$HEX1$$f300$$ENDHEX$$digo de barras:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_visanet_lectura
integer x = 942
integer y = 96
integer width = 1143
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

