HA$PBExportHeader$w_email_agenda.srw
forward
global type w_email_agenda from w_response
end type
type dw_lista_contactos from u_dw within w_email_agenda
end type
type dw_detalle_contacto from u_dw within w_email_agenda
end type
type cb_guardar from u_cb within w_email_agenda
end type
type cb_cancelar from u_cb within w_email_agenda
end type
type cb_nuevo from u_cb within w_email_agenda
end type
type cb_salir from u_cb within w_email_agenda
end type
type cb_borrar from u_cb within w_email_agenda
end type
type st_1 from statictext within w_email_agenda
end type
end forward

global type w_email_agenda from w_response
integer width = 3237
integer height = 1344
string title = "Agenda de Contactos"
dw_lista_contactos dw_lista_contactos
dw_detalle_contacto dw_detalle_contacto
cb_guardar cb_guardar
cb_cancelar cb_cancelar
cb_nuevo cb_nuevo
cb_salir cb_salir
cb_borrar cb_borrar
st_1 st_1
end type
global w_email_agenda w_email_agenda

forward prototypes
public function string wf_rellenar_linea ()
end prototypes

public function string wf_rellenar_linea ();string nueva_linea

nueva_linea=dw_detalle_contacto.GetItemString(1,'nombre')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'email')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'direccion')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'ciudad')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'cp')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'provincia')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'pais')+';'		
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'telefono')+';'	
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'direccion_trabajo')+';'	
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'ciudad_trabajo')+';'	
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'cp_trabajo')+';'	
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'provincia_trabajo')+';'			
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'pais_trabajo')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'telefono_trabajo')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'organizacion')+';'
nueva_linea=nueva_linea+dw_detalle_contacto.GetItemString(1,'puesto')	

return nueva_linea
end function

on w_email_agenda.create
int iCurrent
call super::create
this.dw_lista_contactos=create dw_lista_contactos
this.dw_detalle_contacto=create dw_detalle_contacto
this.cb_guardar=create cb_guardar
this.cb_cancelar=create cb_cancelar
this.cb_nuevo=create cb_nuevo
this.cb_salir=create cb_salir
this.cb_borrar=create cb_borrar
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lista_contactos
this.Control[iCurrent+2]=this.dw_detalle_contacto
this.Control[iCurrent+3]=this.cb_guardar
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.cb_nuevo
this.Control[iCurrent+6]=this.cb_salir
this.Control[iCurrent+7]=this.cb_borrar
this.Control[iCurrent+8]=this.st_1
end on

on w_email_agenda.destroy
call super::destroy
destroy(this.dw_lista_contactos)
destroy(this.dw_detalle_contacto)
destroy(this.cb_guardar)
destroy(this.cb_cancelar)
destroy(this.cb_nuevo)
destroy(this.cb_salir)
destroy(this.cb_borrar)
destroy(this.st_1)
end on

event open;call super::open;f_centrar_ventana(this)
dw_lista_contactos.SetTransObject(SQLCA)
dw_detalle_contacto.SetTransObject(SQLCA)
dw_detalle_contacto.insertrow(0)
f_email_importar_direcciones(dw_lista_contactos)
dw_lista_contactos.sort()


if dw_lista_contactos.rowcount()>0 then
	dw_detalle_contacto.enabled=true
else
	dw_detalle_contacto.enabled=false
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_email_agenda
integer x = 59
integer y = 820
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_email_agenda
integer x = 69
integer y = 912
end type

type dw_lista_contactos from u_dw within w_email_agenda
integer x = 32
integer y = 36
integer width = 1065
integer height = 976
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_email_direcciones"
boolean ib_isupdateable = false
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow>0 then 
	cb_borrar.enabled=true
	dw_detalle_contacto.enabled=true	
	dw_detalle_contacto.event csd_cargar_contacto(dw_lista_contactos.GetItemString(currentrow,'nombre'))
else
	cb_borrar.enabled=false
	dw_detalle_contacto.enabled=false
end if

cb_cancelar.enabled=false
cb_guardar.enabled=false

end event

event constructor;call super::constructor;//of_setrowselect(false)
//of_setrowmanager(true)

// Multiseleccion
//this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

type dw_detalle_contacto from u_dw within w_email_agenda
event csd_cargar_contacto ( string nombre )
event csd_guardar_contacto ( string nombre,  boolean borrar )
integer x = 1138
integer y = 32
integer width = 2080
integer height = 1008
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_email_detalle_contacto"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_cargar_contacto(string nombre);string linea,linea_anterior,resta_linea,direccion,nombre_contacto
long fichero,posic_pyc,fila

// Abrimos el fichero
fichero=FileOpen(g_dir_aplicacion+'\libreta_direcciones.txt',linemode!,Read!)

// Ignoramos la linea de cabecera
FileRead(fichero,linea)
linea_anterior=linea

// Por cada linea leemos los dos primeros campos Nombre y Direccion
FileRead(fichero,linea)
do while linea_anterior<>linea and nombre<>nombre_contacto
	resta_linea=linea	
	posic_pyc=PosA(resta_linea,';')
	nombre_contacto=MidA(linea,1,posic_pyc - 1)
	if nombre_contacto<>nombre then
		linea_anterior=linea
		FileRead(fichero,linea)
		continue
	else // Hemos encontrado el contacto. Cargamos sus datos.
		dw_detalle_contacto.SetItem(1,'nombre',nombre_contacto)
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'email',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'direccion',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'ciudad',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'cp',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'provincia',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'pais',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'telefono',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'direccion_trabajo',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'ciudad_trabajo',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'cp_trabajo',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'provincia_trabajo',MidA(resta_linea,1,posic_pyc - 1))
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'pais_trabajo',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'telefono_trabajo',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		posic_pyc=PosA(resta_linea,';')
		dw_detalle_contacto.SetItem(1,'organizacion',MidA(resta_linea,1,posic_pyc - 1))		
		resta_linea=MidA(resta_linea,posic_pyc + 1)
		dw_detalle_contacto.SetItem(1,'puesto',MidA(resta_linea,1))		

		linea_anterior=linea
		
		
	end if
loop


FileClose(fichero)
end event

event csd_guardar_contacto(string nombre, boolean borrar);string linea,linea_anterior,resta_linea,direccion,nombre_contacto,nueva_linea
long fichero_origen,fichero_destino,posic_pyc,fila
boolean encontrado
string nombre_fichero_destino,nombre_fichero_origen

nombre_fichero_origen=g_dir_aplicacion+'\libreta_direcciones.txt'
nombre_fichero_destino=g_dir_aplicacion+'\libreta_direcciones.tmp'

// Si no existe creamos la libreta de direcciones
if Not(FileExists(nombre_fichero_origen)) then
	fichero_origen=FileOpen(nombre_fichero_origen,linemode!,Write!)
	FileWrite(fichero_origen,"Nombre;Direcci$$HEX1$$f300$$ENDHEX$$n de correo electr$$HEX1$$f300$$ENDHEX$$nico;Calle;Ciudad;C$$HEX1$$f300$$ENDHEX$$digo postal del domicilio;Estado o provincia del domicilio;Pa$$HEX1$$ed00$$ENDHEX$$s o regi$$HEX1$$f300$$ENDHEX$$n del domicilio;Tel$$HEX1$$e900$$ENDHEX$$fono particular;Direcci$$HEX1$$f300$$ENDHEX$$n del trabajo;Ciudad de trabajo;C$$HEX1$$f300$$ENDHEX$$digo postal del trabajo;Estado o provincia del trabajo;Pa$$HEX1$$ed00$$ENDHEX$$s o regi$$HEX1$$f300$$ENDHEX$$n de trabajo;Tel$$HEX1$$e900$$ENDHEX$$fono del trabajo;Organizaci$$HEX1$$f300$$ENDHEX$$n;Puesto")
	FileClose(fichero_origen)
end if

// Si existe el fichero temporal lo borramos
if FileExists(nombre_fichero_destino) then
	FileDelete(nombre_fichero_destino)
end if

// Abrimos el fichero
fichero_destino=FileOpen(nombre_fichero_destino,linemode!,Write!)
fichero_origen=FileOpen(nombre_fichero_origen,linemode!,Read!)

// Escribimos la cabecera tal cual
FileRead(fichero_origen,linea)
FileWrite(fichero_destino,linea)
linea_anterior=linea
encontrado=false

// Por cada linea leemos el primer campo para ver si existe.
FileRead(fichero_origen,linea)
do while linea_anterior<>linea
	resta_linea=linea	
	posic_pyc=PosA(resta_linea,';')
	nombre_contacto=MidA(linea,1,posic_pyc - 1) // El nombre del contacto llega hasta el primer separador
	if nombre_contacto<>nombre then // Si no se encuentra escribimos la linea tal cual
		linea_anterior=linea
		FileWrite(fichero_destino,linea)
	else // Hemos encontrado el contacto. Escribimos la linea con los datos nuevos.
		encontrado=true
		// Si se ha indicado borrar=true esta parte se saltar$$HEX1$$e100$$ENDHEX$$, con lo que no se insertara la linea
		if borrar=false then
			nueva_linea=wf_rellenar_linea()			
			FileWrite(fichero_destino,nueva_linea)		
		end if
		linea_anterior=linea
	end if
	FileRead(fichero_origen,linea)
loop

// Si no se ha encontrado la linea la a$$HEX1$$f100$$ENDHEX$$adimos al final
if encontrado=false then 
	nueva_linea=wf_rellenar_linea()
	FileWrite(fichero_destino,nueva_linea)		
end if

FileClose(fichero_origen)
FileClose(fichero_destino)

// Guardamos una copia de seguridad
gnv_fichero.of_FileCopy(nombre_fichero_origen,g_dir_aplicacion+'\libreta_direcciones.bak')
gnv_fichero.of_FileCopy(nombre_fichero_destino,nombre_fichero_origen)
FileDelete(nombre_fichero_destino)

end event

event editchanged;call super::editchanged;cb_guardar.enabled=true
cb_cancelar.enabled=true
end event

type cb_guardar from u_cb within w_email_agenda
integer x = 795
integer y = 1092
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string text = "Guardar"
end type

event clicked;call super::clicked;dw_detalle_contacto.AcceptText()

// dw_lista_contactos esta desactivado cuando se ha pulsado en el bot$$HEX1$$f300$$ENDHEX$$n NUEVO
if dw_lista_contactos.enabled then
	dw_detalle_contacto.event csd_guardar_contacto(dw_lista_contactos.GetItemString(dw_lista_contactos.GetRow(),'nombre'),false)
else	
	dw_detalle_contacto.event csd_guardar_contacto(dw_detalle_contacto.GetItemString(1,'nombre'),false)
	st_1.visible=false
end if

dw_lista_contactos.reset()
f_email_importar_direcciones(dw_lista_contactos)
dw_lista_contactos.sort()
dw_lista_contactos.enabled=true
cb_guardar.enabled=false
cb_cancelar.enabled=false

end event

type cb_cancelar from u_cb within w_email_agenda
integer x = 1161
integer y = 1092
integer taborder = 21
boolean bringtotop = true
boolean enabled = false
string text = "Cancelar"
end type

event clicked;call super::clicked;if dw_lista_contactos.rowcount()>0 then
	dw_lista_contactos.event rowfocuschanged(dw_lista_contactos.GetRow())
	
	/*
	if dw_lista_contactos.enabled then
		dw_lista_contactos.event rowfocuschanged(dw_lista_contactos.GetRow())
	else	
		dw_lista_contactos.event rowfocuschanged(1)
		
	end if*/
	
	
end if

dw_lista_contactos.enabled=true
cb_guardar.enabled=false
cb_cancelar.enabled=false
st_1.visible=false
end event

type cb_nuevo from u_cb within w_email_agenda
integer x = 50
integer y = 1088
integer taborder = 21
boolean bringtotop = true
string text = "Nuevo"
end type

event clicked;call super::clicked;st_1.visible=true
dw_lista_contactos.enabled=false
dw_detalle_contacto.enabled=true
dw_detalle_contacto.reset()
dw_detalle_contacto.insertrow(0)

// Inicializamos los campos para que al concatenar no lo haga con NULL
dw_detalle_contacto.Setitem(1,'nombre','')
dw_detalle_contacto.Setitem(1,'email','')
dw_detalle_contacto.Setitem(1,'direccion','')
dw_detalle_contacto.Setitem(1,'ciudad','')
dw_detalle_contacto.Setitem(1,'cp','')
dw_detalle_contacto.Setitem(1,'provincia','')
dw_detalle_contacto.Setitem(1,'pais','')
dw_detalle_contacto.Setitem(1,'telefono','')
dw_detalle_contacto.Setitem(1,'direccion_trabajo','')
dw_detalle_contacto.Setitem(1,'ciudad_trabajo','')
dw_detalle_contacto.Setitem(1,'cp_trabajo','')
dw_detalle_contacto.Setitem(1,'provincia_trabajo','')
dw_detalle_contacto.Setitem(1,'pais_trabajo','')
dw_detalle_contacto.Setitem(1,'telefono_trabajo','')
dw_detalle_contacto.Setitem(1,'organizacion','')
dw_detalle_contacto.Setitem(1,'puesto','')

//
cb_borrar.enabled=false
cb_cancelar.enabled=true




end event

type cb_salir from u_cb within w_email_agenda
integer x = 2825
integer y = 1092
integer taborder = 21
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_borrar from u_cb within w_email_agenda
integer x = 416
integer y = 1088
integer taborder = 31
boolean bringtotop = true
boolean enabled = false
string text = "Borrar"
end type

event clicked;call super::clicked;if (MessageBox(g_titulo,"Esto borrar$$HEX2$$e1002000$$ENDHEX$$el contacto definitivamente.$$HEX1$$bf00$$ENDHEX$$Estas seguro?",Question!,YesNo!)=1) then
	dw_detalle_contacto.event csd_guardar_contacto(dw_detalle_contacto.GetItemString(1,'nombre'),true)
	cb_borrar.enabled=false
	cb_guardar.enabled=false
	cb_cancelar.enabled=false		
	dw_lista_contactos.reset()
	f_email_importar_direcciones(dw_lista_contactos)
	dw_lista_contactos.sort()
	if dw_lista_contactos.rowcount()<0 then
		dw_lista_contactos.enabled=false
	else
		dw_lista_contactos.enabled=true
	end if
	if dw_lista_contactos.rowcount()>0 then
		dw_lista_contactos.event rowfocuschanged(dw_lista_contactos.GetRow())
	end if
	
	
end if
end event

type st_1 from statictext within w_email_agenda
boolean visible = false
integer x = 2574
integer y = 96
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "NUEVO"
alignment alignment = right!
boolean focusrectangle = false
end type

