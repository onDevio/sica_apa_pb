HA$PBExportHeader$w_escaner_principal.srw
forward
global type w_escaner_principal from w_response
end type
type otwain from olecustomcontrol within w_escaner_principal
end type
type cb_scan from picturebutton within w_escaner_principal
end type
type cb_select from picturebutton within w_escaner_principal
end type
type pb_save from picturebutton within w_escaner_principal
end type
type pb_zoom_menos from picturebutton within w_escaner_principal
end type
type pb_zoom_mas from picturebutton within w_escaner_principal
end type
type pb_zoom_ajustar from picturebutton within w_escaner_principal
end type
type pb_rotar_izq from picturebutton within w_escaner_principal
end type
type pb_rotar_der from picturebutton within w_escaner_principal
end type
type ddlb_zoom from u_ddlb within w_escaner_principal
end type
type cbx_setup from u_cbx within w_escaner_principal
end type
type st_pag from statictext within w_escaner_principal
end type
type st_2 from statictext within w_escaner_principal
end type
type em_1 from u_em within w_escaner_principal
end type
type cb_ir from u_cb within w_escaner_principal
end type
type cb_ant from u_cb within w_escaner_principal
end type
type cb_sig from u_cb within w_escaner_principal
end type
type cb_borrar from u_cb within w_escaner_principal
end type
type cb_act_pagina from u_cb within w_escaner_principal
end type
type cb_cerrar from u_cb within w_escaner_principal
end type
type cb_brillo_contraste from u_cb within w_escaner_principal
end type
end forward

global type w_escaner_principal from w_response
integer width = 2555
integer height = 1644
windowstate windowstate = maximized!
event csd_crear_ruta ( string ruta )
otwain otwain
cb_scan cb_scan
cb_select cb_select
pb_save pb_save
pb_zoom_menos pb_zoom_menos
pb_zoom_mas pb_zoom_mas
pb_zoom_ajustar pb_zoom_ajustar
pb_rotar_izq pb_rotar_izq
pb_rotar_der pb_rotar_der
ddlb_zoom ddlb_zoom
cbx_setup cbx_setup
st_pag st_pag
st_2 st_2
em_1 em_1
cb_ir cb_ir
cb_ant cb_ant
cb_sig cb_sig
cb_borrar cb_borrar
cb_act_pagina cb_act_pagina
cb_cerrar cb_cerrar
cb_brillo_contraste cb_brillo_contraste
end type
global w_escaner_principal w_escaner_principal

type variables
st_w_escanear  ist_datos_fichero
long i_scan_ui=0
string is_dir_destino,is_nombre_fichero,is_nombre

boolean ib_ajustar=false
long il_zoom=5
long il_pag_actual,il_total_pag



end variables

event csd_crear_ruta(string ruta);//FUNCION QUE CREA LA RUTA DESTINO DE MANERA RECURSIVA

string cadena,directorio
long i,j

cadena=ruta

i=1
do 
	j=pos(cadena,"\",i)
	directorio=mid(cadena,1,j)
	i=j+1
	
	if Not(FileExists(directorio)) then 	CreateDirectory(directorio)
	
loop while j<>0


end event

on w_escaner_principal.create
int iCurrent
call super::create
this.otwain=create otwain
this.cb_scan=create cb_scan
this.cb_select=create cb_select
this.pb_save=create pb_save
this.pb_zoom_menos=create pb_zoom_menos
this.pb_zoom_mas=create pb_zoom_mas
this.pb_zoom_ajustar=create pb_zoom_ajustar
this.pb_rotar_izq=create pb_rotar_izq
this.pb_rotar_der=create pb_rotar_der
this.ddlb_zoom=create ddlb_zoom
this.cbx_setup=create cbx_setup
this.st_pag=create st_pag
this.st_2=create st_2
this.em_1=create em_1
this.cb_ir=create cb_ir
this.cb_ant=create cb_ant
this.cb_sig=create cb_sig
this.cb_borrar=create cb_borrar
this.cb_act_pagina=create cb_act_pagina
this.cb_cerrar=create cb_cerrar
this.cb_brillo_contraste=create cb_brillo_contraste
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.otwain
this.Control[iCurrent+2]=this.cb_scan
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.pb_save
this.Control[iCurrent+5]=this.pb_zoom_menos
this.Control[iCurrent+6]=this.pb_zoom_mas
this.Control[iCurrent+7]=this.pb_zoom_ajustar
this.Control[iCurrent+8]=this.pb_rotar_izq
this.Control[iCurrent+9]=this.pb_rotar_der
this.Control[iCurrent+10]=this.ddlb_zoom
this.Control[iCurrent+11]=this.cbx_setup
this.Control[iCurrent+12]=this.st_pag
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.em_1
this.Control[iCurrent+15]=this.cb_ir
this.Control[iCurrent+16]=this.cb_ant
this.Control[iCurrent+17]=this.cb_sig
this.Control[iCurrent+18]=this.cb_borrar
this.Control[iCurrent+19]=this.cb_act_pagina
this.Control[iCurrent+20]=this.cb_cerrar
this.Control[iCurrent+21]=this.cb_brillo_contraste
end on

on w_escaner_principal.destroy
call super::destroy
destroy(this.otwain)
destroy(this.cb_scan)
destroy(this.cb_select)
destroy(this.pb_save)
destroy(this.pb_zoom_menos)
destroy(this.pb_zoom_mas)
destroy(this.pb_zoom_ajustar)
destroy(this.pb_rotar_izq)
destroy(this.pb_rotar_der)
destroy(this.ddlb_zoom)
destroy(this.cbx_setup)
destroy(this.st_pag)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.cb_ir)
destroy(this.cb_ant)
destroy(this.cb_sig)
destroy(this.cb_borrar)
destroy(this.cb_act_pagina)
destroy(this.cb_cerrar)
destroy(this.cb_brillo_contraste)
end on

event open;call super::open;int ret_val,valor

ist_datos_fichero=Message.PowerObjectParm

if oTWAIN.classShortName='Unknown' or f_es_vacio(oTWAIN.classShortName) then
	MessageBox("OCX no registrado","Debe instalar el OCX del scanner para poder usarlo")

	close(this)
else
	oTWAIN.width=2000
	oTWAIN.height=1340	
	of_SetResize (true)
	inv_resize.of_Register (oTWAIN, "ScaletoRight&Bottom")
	
	inv_resize.of_Register (cb_scan, "FixedtoRight")
	inv_resize.of_Register (cb_select, "FixedtoRight")
	inv_resize.of_Register (pb_zoom_mas, "FixedtoRight")
	inv_resize.of_Register (pb_zoom_menos, "FixedtoRight")
	inv_resize.of_Register (pb_zoom_ajustar, "FixedtoRight")
	inv_resize.of_Register (cb_brillo_contraste, "FixedtoRight")
	inv_resize.of_Register (pb_rotar_izq, "FixedtoRight")
	inv_resize.of_Register (pb_rotar_der, "FixedtoRight")
	inv_resize.of_Register (cb_cerrar, "FixedtoRight")
	inv_resize.of_Register (ddlb_zoom, "FixedtoRight")
	inv_resize.of_Register (cbx_setup, "FixedtoRight")
	inv_resize.of_Register (pb_save, "FixedtoRight")
	inv_resize.of_Register (st_pag, "FixedtoRight")	
	inv_resize.of_Register (em_1, "FixedtoRight")	
	inv_resize.of_Register (cb_ir, "FixedtoRight")	
	inv_resize.of_Register (st_2, "FixedtoRight")		
	inv_resize.of_Register (cb_act_pagina, "FixedtoRight")	
	inv_resize.of_Register (cb_borrar, "FixedtoRight")		
	inv_resize.of_Register (cb_ant, "FixedtoRight")		
	inv_resize.of_Register (cb_sig, "FixedtoRight")		
	
	//oTWAIN.object.LicenseKey ="5200 single developer license" 
	oTWAIN.object.LicenseKey ="9810 team developer license"
		
	//ventana_escaneado=this
	
end if





end event

event key;call super::key;
if key=KeyEqual! or key=KeyAdd!  then
	pb_zoom_mas.event clicked()	
elseif key=KeyDash! or key=KeySubtract! then
	pb_zoom_menos.event clicked()
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_escaner_principal
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_escaner_principal
end type

type otwain from olecustomcontrol within w_escaner_principal
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event endscan ( )
integer x = 55
integer y = 32
integer width = 914
integer height = 800
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_escaner_principal.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_scan from picturebutton within w_escaner_principal
integer x = 2071
integer y = 52
integer width = 174
integer height = 152
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = ".\imagenes\scanner.gif"
alignment htextalign = left!
end type

event clicked;oTWAIN.object.FeederEnabled = True

if cbx_setup.checked then
	oTWAIN.object.ShowTwainUI=true
else
	oTWAIN.object.ShowTwainUI=false
end if
oTWAIN.object.Scan()
oTWAIN.object.Brightness=0
oTWAIN.object.Contrast=1

cb_act_pagina.event clicked()



end event

type cb_select from picturebutton within w_escaner_principal
integer x = 2103
integer y = 232
integer width = 174
integer height = 152
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\imagenes\selectscan.gif"
alignment htextalign = left!
end type

event clicked;oTWAIN.object.SelectImageSource()
end event

type pb_save from picturebutton within w_escaner_principal
integer x = 2304
integer y = 232
integer width = 174
integer height = 152
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\imagenes\filesave.gif"
alignment htextalign = left!
end type

event clicked;string nombre_fichero,nombre,nombre_sin_ext
int ret_val=0
int total_pag
boolean lb_multi=false

total_pag=oTWAIN.object.TotalPage()

if total_pag<1 then
	return
elseif total_pag > 1 then
	if MessageBox("Multipagina","Ha escaneado m$$HEX1$$e100$$ENDHEX$$s de una p$$HEX1$$e100$$ENDHEX$$gina. Si quiere guardar un documento multip$$HEX1$$e100$$ENDHEX$$gina en PDF, pulse SI, en caso contrario se guardar$$HEX2$$e1002000$$ENDHEX$$solamente la p$$HEX1$$e100$$ENDHEX$$gina actual",Question!,YesNo!)=1 then
		lb_multi=true
	end if
end if
	

//Le pasamos como paremetro el nombre del fichero que hemos generado con el contador
OpenWithParm(w_escaner_guardar_fichero,ist_datos_fichero.nombre_fichero)
nombre_sin_ext=Message.StringParm


//Construimos la ruta para guardar el fichero
if Not(f_es_vacio(nombre_sin_ext)) then 	
	//nombre=nombre_sin_ext + '.jpg'
	parent.event csd_crear_ruta(ist_datos_fichero.ruta)
	if RightA(ist_datos_fichero.ruta,1)='\' then
		is_nombre_fichero=ist_datos_fichero.ruta+nombre_sin_ext
	else
		is_nombre_fichero=ist_datos_fichero.ruta+'\'+nombre_sin_ext
	end if
	
	// Guardamos la imagen
	oTWAIN.object.JPEGQuality=85
	if lb_multi then
		is_nombre=nombre_sin_ext+'.pdf'
		is_nombre_fichero+='.pdf'
		if oTWAIN.object.SaveAllPage2PDF(is_nombre_fichero,true,1)	then
			ret_val=1
		end if
	else		
		is_nombre=nombre_sin_ext+'.pdf'
		//is_nombre_fichero+='.pdf'
		ret_val =oTWAIN.object.save(is_nombre_fichero, 'PDF')
		is_nombre_fichero+='.pdf'
	
	end if
	
	//29/02/2008 - A$$HEX1$$f100$$ENDHEX$$adida comprobacion de existencia
	if ret_val = 0 or Not(FileExists(is_nombre_fichero)) then 
		MessageBox("ERROR","Hubo un error al guardar el fichero")
	else
		MessageBox(g_titulo,"El fichero ha sido guardado en: "+is_nombre_fichero)
	end if

end if




end event

type pb_zoom_menos from picturebutton within w_escaner_principal
integer x = 2267
integer y = 132
integer width = 101
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = ".\imagenes\viewmag-.gif"
alignment htextalign = left!
end type

event clicked;if il_zoom>1 then	il_zoom -= 1

//oTWAIN.object.View=il_zoom	
ddlb_zoom.selectItem(il_zoom)
ddlb_zoom.event selectionchanged(il_zoom)
end event

type pb_zoom_mas from picturebutton within w_escaner_principal
integer x = 2263
integer y = 36
integer width = 101
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\imagenes\viewmag+.gif"
alignment htextalign = left!
end type

event clicked;if il_zoom<7 then	il_zoom+=1

//oTWAIN.object.View=il_zoom	
ddlb_zoom.selectItem(il_zoom)
ddlb_zoom.event selectionchanged(il_zoom)
end event

type pb_zoom_ajustar from picturebutton within w_escaner_principal
integer x = 2386
integer y = 88
integer width = 101
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\imagenes\viewmagfit.gif"
alignment htextalign = left!
end type

event clicked;//uo_1.fu_zoom_fixed(100)

oTWAIN.object.View=10
end event

type pb_rotar_izq from picturebutton within w_escaner_principal
integer x = 2139
integer y = 404
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = ".\imagenes\rotateleft.gif"
alignment htextalign = left!
end type

event clicked;oTWAIN.object.rotate(0)
end event

type pb_rotar_der from picturebutton within w_escaner_principal
integer x = 2263
integer y = 404
integer width = 101
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = ".\imagenes\rotateright.gif"
alignment htextalign = left!
end type

event clicked;oTWAIN.object.rotate(2)
end event

type ddlb_zoom from u_ddlb within w_escaner_principal
integer x = 2089
integer y = 540
integer width = 398
integer height = 496
integer taborder = 11
boolean bringtotop = true
string item[] = {"25%","33%","50%","75%","100%","150%","200%"}
end type

event selectionchanged;call super::selectionchanged;oTWAIN.object.View=index

il_zoom=index
end event

type cbx_setup from u_cbx within w_escaner_principal
integer x = 2085
integer y = 804
integer width = 389
boolean bringtotop = true
string text = "Mostrar Setup"
boolean checked = true
end type

type st_pag from statictext within w_escaner_principal
integer x = 2089
integer y = 888
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80263581
string text = "0 / 0 p$$HEX1$$e100$$ENDHEX$$ginas"
boolean focusrectangle = false
end type

type st_2 from statictext within w_escaner_principal
integer x = 2085
integer y = 956
integer width = 123
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 80263581
string text = "Ir a"
boolean focusrectangle = false
end type

type em_1 from u_em within w_escaner_principal
integer x = 2194
integer y = 956
integer width = 137
integer taborder = 11
boolean bringtotop = true
string mask = "###"
end type

type cb_ir from u_cb within w_escaner_principal
integer x = 2373
integer y = 952
integer width = 101
integer height = 80
integer taborder = 21
boolean bringtotop = true
string text = "Ir"
end type

event clicked;call super::clicked;oTwain.Object.SetActivePageNo(long(em_1.text))
cb_act_pagina.event clicked()
end event

type cb_ant from u_cb within w_escaner_principal
integer x = 2167
integer y = 1052
integer width = 101
integer height = 76
integer taborder = 31
boolean bringtotop = true
string text = "<<"
end type

event clicked;call super::clicked;cb_act_pagina.event clicked()
if il_pag_actual = 0 then return
il_pag_actual --

oTwain.Object.SetActivePageNo(il_pag_actual)
cb_act_pagina.event clicked()
end event

type cb_sig from u_cb within w_escaner_principal
integer x = 2313
integer y = 1052
integer width = 101
integer height = 76
integer taborder = 41
boolean bringtotop = true
string text = ">>"
end type

event clicked;call super::clicked;cb_act_pagina.event clicked()
if il_pag_actual = il_total_pag then return
il_pag_actual ++
oTwain.Object.SetActivePageNo(il_pag_actual)
cb_act_pagina.event clicked()
end event

type cb_borrar from u_cb within w_escaner_principal
integer x = 2089
integer y = 1168
integer width = 411
integer taborder = 11
boolean bringtotop = true
string text = "Borrar P$$HEX1$$e100$$ENDHEX$$gina"
end type

event clicked;call super::clicked;oTwain.object.DeletePage(oTwain.object.Getactivepageno())
cb_act_pagina.event clicked()
end event

type cb_act_pagina from u_cb within w_escaner_principal
integer x = 2089
integer y = 1276
integer width = 411
integer taborder = 21
boolean bringtotop = true
string text = "Actualiza n$$HEX2$$ba002000$$ENDHEX$$pag."
end type

event clicked;call super::clicked;il_total_pag=oTWAIN.object.TotalPage()
il_pag_actual=oTwain.object.GetActivePageNo()

st_pag.text=string(il_pag_actual) + ' / ' + string(il_total_pag) + ' p$$HEX1$$e100$$ENDHEX$$ginas'

end event

type cb_cerrar from u_cb within w_escaner_principal
integer x = 2089
integer y = 1416
integer width = 411
integer taborder = 21
boolean bringtotop = true
string text = "Cerrar"
end type

event clicked;call super::clicked;closeWithReturn(parent,is_nombre)
end event

type cb_brillo_contraste from u_cb within w_escaner_principal
integer x = 2089
integer y = 668
integer width = 411
integer taborder = 21
boolean bringtotop = true
string text = "Brillo / Contraste"
end type

event clicked;call super::clicked;st_valores st_old_brillo_contraste,st_new_brillo_contraste

st_old_brillo_contraste.brillo=oTWAIN.object.brightness
st_old_brillo_contraste.contraste=oTWAIN.object.contrast
st_old_brillo_contraste.ventana_escaneado=parent

OpenWithParm(w_escaner_brillo_contraste,st_old_brillo_contraste)

st_new_brillo_contraste=Message.PowerObjectParm

if Not(IsNull(st_new_brillo_contraste)) and IsValid(st_new_brillo_contraste) then
	oTWAIN.object.Brightness=st_new_brillo_contraste.brillo
	oTWAIN.object.Contrast=st_new_brillo_contraste.contraste
	oTwain.Object.ApplyChange()
end if
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_escaner_principal.bin 
2200000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000c656432001c89bbf00000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000440000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000002000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004831a607c4f8e77ca05987fb3fa63ac7400000000c656432001c89bbfc656432001c89bbf00000000000000000000000000000001fffffffe000000030000000400000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f004300790070006900720068006700200074006300280020002900300032003500300056002000730069006f00630020006d006f005300740066006100770065007200200072007000790073006f00290020002000200065007200750074006e007200200073006f006c0067006e005b002000620070005f006d0062006c0000fffe00020105831a607c4f8e77ca05987fb3fa63ac7400000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000014ac00000003000014ac00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900680074007200650000005d000000000000000000000000000000000000000000000000000000000000000000010000000014ac000014ac0000000000000064000000000000000064040000006f6d650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000026000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_escaner_principal.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
