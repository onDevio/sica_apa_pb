HA$PBExportHeader$w_seleccion_certificado.srw
forward
global type w_seleccion_certificado from w_response
end type
type cb_seleccionar from commandbutton within w_seleccion_certificado
end type
type cb_cancelar from commandbutton within w_seleccion_certificado
end type
type st_1 from statictext within w_seleccion_certificado
end type
type st_2 from statictext within w_seleccion_certificado
end type
type cb_actualizar from commandbutton within w_seleccion_certificado
end type
type dw_lista from u_dw within w_seleccion_certificado
end type
end forward

global type w_seleccion_certificado from w_response
integer width = 2446
integer height = 840
cb_seleccionar cb_seleccionar
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
cb_actualizar cb_actualizar
dw_lista dw_lista
end type
global w_seleccion_certificado w_seleccion_certificado

on w_seleccion_certificado.create
int iCurrent
call super::create
this.cb_seleccionar=create cb_seleccionar
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
this.cb_actualizar=create cb_actualizar
this.dw_lista=create dw_lista
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_seleccionar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_actualizar
this.Control[iCurrent+6]=this.dw_lista
end on

on w_seleccion_certificado.destroy
call super::destroy
destroy(this.cb_seleccionar)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_actualizar)
destroy(this.dw_lista)
end on

event pfc_postopen;call super::pfc_postopen;long li_FileNum,i,posi_barra,posi_coma,fila
long posi_llave,posi_llave_final
string certs,cadena,nombre,descripcion
n_runandwait runandwait
runandwait = create n_runandwait
blob blb

if not(FileExists(g_dir_aplicacion+"BrowserCertificates.txt")) then
	//runandwait.of_SetPriority(runandwait.HIGH_PRIORITY_CLASS)
	runandwait.iul_timeout = 90000
	runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
	runandwait.of_SetWindow("normal")
	runandwait.of_runandwait(g_dir_aplicacion+"browserCerts.exe")
end if


if FileExists(g_dir_aplicacion+"BrowserCertificates.txt") then	
	li_FileNum = FileOpen(g_dir_aplicacion+"BrowserCertificates.txt" )
	
	FileRead(li_FileNum,certs)
	// CONVERSION DE CARACTERES PARA LOS ACENTOS
	blb=blob(certs,EncodingAnsi!)
	certs=string(blb,EncodingUTF8!)
	FileClose(li_FileNum)
	
	cadena=certs
	
	
	do while not(f_es_vacio(cadena))
		posi_llave=pos(cadena,'{')
		
		if posi_llave>0 then
			posi_llave_final=pos(cadena,'}')
			if posi_llave_final<=0 then posi_llave_final=len(cadena)
			descripcion = mid(cadena,posi_llave + 1, posi_llave_final - 2)
			posi_barra=pos(descripcion,'|')
			nombre= mid(descripcion,posi_barra + 1)
			descripcion=mid(descripcion,1,posi_barra - 1)
	
			fila=dw_lista.insertrow(0)
			dw_lista.SetItem(fila,'descripcion',descripcion)
			dw_lista.SetItem(fila,'nombre',nombre)
				
			cadena=mid(cadena,posi_llave_final + 1)	
		else 
			exit
		end if
		
	loop
	
	
	
	if dw_lista.rowcount()>0 then 
		dw_lista.visible=true
		dw_lista.object.datawindow.color=31315402
		cb_seleccionar.enabled=true
	else
		st_1.text='No se encontraron certificados'
	end if
else
	st_1.text='No se han podido obtener los certificados'	
	
end if
destroy runandwait
end event

event open;call super::open;st_1.backcolor=31315402
st_2.backcolor=31315402

f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_seleccion_certificado
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_seleccion_certificado
end type

type cb_seleccionar from commandbutton within w_seleccion_certificado
integer x = 741
integer y = 624
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Seleccionar"
end type

event clicked;if dw_lista.GetRow()>0 then
	CloseWithReturn(parent,dw_lista.GetItemString(dw_lista.GetRow(),'nombre'))
else
	CloseWithReturn(parent,'')
end if
end event

type cb_cancelar from commandbutton within w_seleccion_certificado
integer x = 1166
integer y = 624
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;CloseWithReturn(parent,'')
end event

type st_1 from statictext within w_seleccion_certificado
integer x = 160
integer y = 244
integer width = 2039
integer height = 112
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cargando Certificados..."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_seleccion_certificado
integer x = 160
integer y = 56
integer width = 2039
integer height = 508
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_actualizar from commandbutton within w_seleccion_certificado
integer x = 1929
integer y = 620
integer width = 466
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualizar Lista"
end type

event clicked;long li_FileNum,i,posi_barra,posi_coma,fila
long posi_llave,posi_llave_final
string certs,cadena,nombre,descripcion
n_runandwait runandwait
runandwait = create n_runandwait


dw_lista.visible=false
dw_lista.reset()
st_1.visible=true
st_1.text='Cargando Certificados...'
st_2.visible=false
dw_lista.object.datawindow.color=31315402
cb_seleccionar.enabled=false

runandwait.of_SetCurrentDirectory(g_dir_aplicacion)
runandwait.of_SetWindow("normal")
runandwait.iul_timeout = 90000
runandwait.of_runandwait(g_dir_aplicacion+"browserCerts.exe")


if FileExists(g_dir_aplicacion+"BrowserCertificates.txt") then
	li_FileNum = FileOpen(g_dir_aplicacion+"BrowserCertificates.txt")
	
	FileRead(li_FileNum,certs)
	
	FileClose(li_FileNum)
	
	cadena=certs
	
	
	do while not(f_es_vacio(cadena))
		posi_llave=pos(cadena,'{')
		
		if posi_llave>0 then
			posi_llave_final=pos(cadena,'}')
			if posi_llave_final<=0 then posi_llave_final=len(cadena)
			descripcion = mid(cadena,posi_llave + 1, posi_llave_final - 2)
			posi_barra=pos(descripcion,'|')
			nombre= mid(descripcion,posi_barra + 1)
			descripcion=mid(descripcion,1,posi_barra - 1)
	
			fila=dw_lista.insertrow(0)
			dw_lista.SetItem(fila,'descripcion',descripcion)
			dw_lista.SetItem(fila,'nombre',nombre)
				
			cadena=mid(cadena,posi_llave_final + 1)	
		else 
			exit
		end if
		
	loop

	
	if dw_lista.rowcount()>0 then 
		dw_lista.visible=true
		dw_lista.object.datawindow.color=31315402
		cb_seleccionar.enabled=true
	else
		st_1.text='No se encontraron certificados'
	end if
else
	st_1.text='No se han podido obtener los certificados'	
end if
destroy runandwait
end event

type dw_lista from u_dw within w_seleccion_certificado
boolean visible = false
integer x = 37
integer y = 36
integer width = 2331
integer height = 560
integer taborder = 10
string dataobject = "d_certificados_navegador"
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

