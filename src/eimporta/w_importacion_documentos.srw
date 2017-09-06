HA$PBExportHeader$w_importacion_documentos.srw
forward
global type w_importacion_documentos from w_response
end type
type st_5 from statictext within w_importacion_documentos
end type
type lb_2 from listbox within w_importacion_documentos
end type
type ole_1 from olecontrol within w_importacion_documentos
end type
type st_1 from statictext within w_importacion_documentos
end type
type st_2 from statictext within w_importacion_documentos
end type
type st_3 from statictext within w_importacion_documentos
end type
type st_4 from statictext within w_importacion_documentos
end type
type lb_1 from listbox within w_importacion_documentos
end type
type cb_1 from commandbutton within w_importacion_documentos
end type
type cb_2 from commandbutton within w_importacion_documentos
end type
type rb_1 from radiobutton within w_importacion_documentos
end type
type rb_2 from radiobutton within w_importacion_documentos
end type
type cb_borrar from commandbutton within w_importacion_documentos
end type
type lv_1 from u_lv within w_importacion_documentos
end type
type lv_2 from u_lv within w_importacion_documentos
end type
type cb_sel from commandbutton within w_importacion_documentos
end type
type cb_desel from commandbutton within w_importacion_documentos
end type
type cb_3 from commandbutton within w_importacion_documentos
end type
type gb_2 from groupbox within w_importacion_documentos
end type
type gb_1 from groupbox within w_importacion_documentos
end type
end forward

global type w_importacion_documentos from w_response
integer width = 2917
integer height = 1624
string title = "Importaci$$HEX1$$f300$$ENDHEX$$n de Documentos"
boolean controlmenu = false
event csd_refrescar ( )
event csd_controla_marcados ( )
st_5 st_5
lb_2 lb_2
ole_1 ole_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
lb_1 lb_1
cb_1 cb_1
cb_2 cb_2
rb_1 rb_1
rb_2 rb_2
cb_borrar cb_borrar
lv_1 lv_1
lv_2 lv_2
cb_sel cb_sel
cb_desel cb_desel
cb_3 cb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_importacion_documentos w_importacion_documentos

type variables
oleobject i_zip
n_cst_filesrvwin32 dire
 
st_visared_importacion ist_documentos_importados

string i_fichero,i_archivo,i_opcion_importacion, i_paquete
long i_contador_tiempo
end variables

forward prototypes
public function st_visared_importacion f_visared_importacion ()
public function boolean f_comprobar_en_disco (integer operacion, string ruta1, string ruta2, integer tiempo)
end prototypes

event csd_refrescar;int i
string etiqueta

lv_1.deletesmallpictures()
lv_1.addsmallpicture(g_directorio_imagenes+"zip.ico")

for i=1 to lb_1.TotalItems ()
	lb_1.SetState(i, TRUE)
	lv_1.additem(lb_1.selecteditem(),1)
	lb_1.SetState(i, false)
next
cb_2.enabled=false
st_1.text=string(lb_1.TotalItems ()) + ' fichero/s'
st_4.text='0 fichero/s'
end event

event csd_controla_marcados();int fila,i

fila = int(Message.LongParm)

listviewitem lvi
cb_borrar.enabled=false
for i=1 to lv_1.TotalItems ( )
	if i = fila then continue
	lv_1.GetItem(i, lvi)
	if lvi.StatePictureIndex = 2 then lvi.StatePictureIndex = 1
	lv_1.SetItem(i , lvi)
next


end event

public function st_visared_importacion f_visared_importacion ();st_visared_importacion retorno
string fichero,archivo
int i,fila
listviewitem item

fichero = g_directorio_temporal + i_archivo

//Luego importamos los datos del fichero .ini o .exp
choose case g_colegio
	case 'COAC'
//		retorno = f_visared_importacion_formularios(fichero)
	case ELSE
//		retorno = f_visared_importacion_hr(fichero)
end choose

retorno.ds_documentos_visared = create datastore
retorno.ds_documentos_visared.dataobject = 'd_fases_documentos_visared'
retorno.fichero_importacion=fichero

//Importamos primero los archivos pdf adjuntos....

for i = 1 to lb_2.TotalItems()
	lb_2.SetState(i, TRUE)
	archivo = lb_2.selecteditem()
	if upper(RightA(archivo,3))='INI' or upper(RightA(archivo,3))='EXP' then continue
	fila = retorno.ds_documentos_visared.insertrow(0)
	retorno.ds_documentos_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	retorno.ds_documentos_visared.setitem(fila, 'id_fase', '')
	retorno.ds_documentos_visared.setitem(fila, 'nombre_fichero', archivo)
	// LA ruta no la sabemos hasta que no grabemos y nos de el registro.
	//retorno.ds_documentos_visared.setitem(fila, 'ruta_fichero', g_directorio_importacion)
	retorno.ds_documentos_visared.setitem(fila, 'sellado', 'N')
	retorno.ds_documentos_visared.setitem(fila, 'fecha', today())
	retorno.ds_documentos_visared.setitem(fila,'visualizar_web','S')		
	lb_2.SetState(i, FALSE)
next

return retorno
end function

public function boolean f_comprobar_en_disco (integer operacion, string ruta1, string ruta2, integer tiempo);boolean SI=true, retorno
integer valor

timer(1)
Do While SI
	SetPointer(HourGlass!)
	yield()
	choose case operacion
		case 0 // borrar fichero
			if FileDelete(ruta1) then
				timer(0)
				i_contador_tiempo=0
				SI=false
				retorno=true
			end if
		case 1 // copiar fichero
			if dire.of_filecopy(ruta1, ruta2) = 1 then
				timer(0)
				i_contador_tiempo=0
				SI=false
				retorno=true
			end if
		case 2 // renombrar fichero
			if dire.of_filerename(ruta1, ruta2) = 1 then
				timer(0)
				i_contador_tiempo=0
				SI=false
				retorno=true
			end if			
	end choose
	if i_contador_tiempo >= tiempo then
		i_contador_tiempo=0
		timer(0)
		SI=false
		retorno= false
		choose case operacion
			case 0
				messagebox('Error [0]','No se ha podido borrar el fichero, compruebe su nombre y su ruta.')
			case 1
				messagebox('Error [1]','No se ha podido copiar el fichero, compruebe nombres y rutas.')
			case 2
				messagebox('Error [2]','No se ha podido renombrar el fichero, compruebe nombres y rutas.')				
		end choose		
	end if
loop

return retorno

end function

event open;i_zip = create oleobject 
dire = create n_cst_filesrvwin32


ist_documentos_importados = Message.PowerObjectParm


f_centrar_ventana(this)
lv_1.deleteitems()
lv_2.deleteitems()
lb_1.reset()
lb_1.DirList(g_directorio_importacion + '*.zip', 0)
dire.of_changedirectory(g_dir_aplicacion) // Restauramos el directorio de trabajo, que puede haber cambiado despu$$HEX1$$e900$$ENDHEX$$s de llamar a DirList
this.postevent ('csd_refrescar')

end event

on w_importacion_documentos.create
int iCurrent
call super::create
this.st_5=create st_5
this.lb_2=create lb_2
this.ole_1=create ole_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.lb_1=create lb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_borrar=create cb_borrar
this.lv_1=create lv_1
this.lv_2=create lv_2
this.cb_sel=create cb_sel
this.cb_desel=create cb_desel
this.cb_3=create cb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.lb_2
this.Control[iCurrent+3]=this.ole_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.lb_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.cb_borrar
this.Control[iCurrent+14]=this.lv_1
this.Control[iCurrent+15]=this.lv_2
this.Control[iCurrent+16]=this.cb_sel
this.Control[iCurrent+17]=this.cb_desel
this.Control[iCurrent+18]=this.cb_3
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.gb_1
end on

on w_importacion_documentos.destroy
call super::destroy
destroy(this.st_5)
destroy(this.lb_2)
destroy(this.ole_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.lb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_borrar)
destroy(this.lv_1)
destroy(this.lv_2)
destroy(this.cb_sel)
destroy(this.cb_desel)
destroy(this.cb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event close;call super::close;dire.of_deltree(g_directorio_temporal)
destroy dire	
destroy i_zip
end event

event timer;call super::timer;i_contador_tiempo=i_contador_tiempo+1
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_importacion_documentos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_importacion_documentos
end type

type st_5 from statictext within w_importacion_documentos
integer x = 78
integer y = 1364
integer width = 2784
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Seleccione el paquete comprimido que desee importar."
boolean focusrectangle = false
end type

type lb_2 from listbox within w_importacion_documentos
boolean visible = false
integer x = 2409
integer y = 620
integer width = 78
integer height = 124
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//string etiqueta
//etiqueta=lb_1.selecteditem()
//lv_1.additem(etiqueta,1)
//
end event

type ole_1 from olecontrol within w_importacion_documentos
boolean visible = false
integer x = 2405
integer y = 788
integer width = 329
integer height = 200
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_importacion_documentos.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type st_1 from statictext within w_importacion_documentos
integer x = 142
integer y = 1240
integer width = 974
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type st_2 from statictext within w_importacion_documentos
integer x = 123
integer y = 236
integer width = 453
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Lista de paquetes"
boolean focusrectangle = false
end type

type st_3 from statictext within w_importacion_documentos
integer x = 1138
integer y = 240
integer width = 1170
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Contenido del paquete"
boolean focusrectangle = false
end type

type st_4 from statictext within w_importacion_documentos
integer x = 1138
integer y = 1240
integer width = 1170
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false

end type

type lb_1 from listbox within w_importacion_documentos
boolean visible = false
integer x = 2624
integer y = 624
integer width = 78
integer height = 124
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//string etiqueta
//etiqueta=lb_1.selecteditem()
//lv_1.additem(etiqueta,1)
//
end event

type cb_1 from commandbutton within w_importacion_documentos
integer x = 2377
integer y = 544
integer width = 430
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir/Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_importacion_documentos
integer x = 2377
integer y = 336
integer width = 430
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Importar"
end type

event clicked;string ruta_doc, nom_doc, ruta_dest, n_reg
int valor, fila, i
boolean errores=false
datastore ds_documentos_visared

ds_documentos_visared = create datastore

ds_documentos_visared.dataobject='d_fases_documentos_visared'
ds_documentos_visared.settransobject(SQLCA)

//Creamos el directorio, si ya existe no pasa nada
dire.of_createdirectory(g_directorio_documentos_visared + string(year(today()))+ '\' + ist_documentos_importados.paquete_importacion + '\')
ruta_doc=g_directorio_temporal
ruta_dest=g_directorio_documentos_visared + string(year(today()))+ '\' + ist_documentos_importados.paquete_importacion + '\'

for i = 1 to lb_2.TotalItems()
	lb_2.SetState(i, TRUE)
	nom_doc = lb_2.selecteditem()
	lb_2.SetState(i, false)
	if upper(RightA(nom_doc,3))='INI' or upper(RightA(nom_doc,3))='EXP' then continue
	
	//Movemos primero el fichero f$$HEX1$$ed00$$ENDHEX$$sico, para que no haya problemas despues de crear la lineas en la bd.
	if fileexists(ruta_dest + nom_doc) then
		messagebox('DUPLICADO', 'Esta fase ya tiene el fichero '+ nom_doc + ' importado.' )
		errores=true
		continue
	end if
	if not f_comprobar_en_disco(1,ruta_doc + nom_doc, ruta_dest + nom_doc,5) then
		errores=true
		continue
	end if
	
	//Insertamos en tabla
	fila = ds_documentos_visared.insertrow(0)
	ds_documentos_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	ds_documentos_visared.setitem(fila, 'id_fase', ist_documentos_importados.id_expedi)
	ds_documentos_visared.setitem(fila, 'nombre_fichero', nom_doc)
	ds_documentos_visared.setitem(fila, 'ruta_fichero', string(year(today()))+ '\' + ist_documentos_importados.paquete_importacion + '\')
	ds_documentos_visared.setitem(fila, 'sellado', 'N')
	ds_documentos_visared.setitem(fila, 'fecha', today())
	ds_documentos_visared.setitem(fila,'visualizar_web','N')		
	lb_2.SetState(i, FALSE)
next

if ds_documentos_visared.update()=1 and errores=false then
	messagebox('','Fichero/s importado/s correctamente.')
	//Movemos el paquete importado a la carpeta de importados:
	f_comprobar_en_disco(2,g_directorio_importacion + i_fichero, g_directorio_importados+ i_fichero, 5)
	close(parent)
else
	messagebox('','Se han producido errores, no se grabar$$HEX2$$e1002000$$ENDHEX$$ning$$HEX1$$fa00$$ENDHEX$$n dato en la base de datos.')
end if

destroy ds_documentos_visared
end event

type rb_1 from radiobutton within w_importacion_documentos
integer x = 64
integer y = 16
integer width = 654
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Paquetes NO importados"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;lv_1.deleteitems()
lv_2.deleteitems()
lb_1.reset()
lb_1.DirList(g_directorio_importacion + '*.zip', 0)
dire.of_changedirectory(g_dir_aplicacion) // Restauramos el directorio de trabajo, que puede haber cambiado despu$$HEX1$$e900$$ENDHEX$$s de llamar a DirList
parent.postevent ('csd_refrescar')
end event

type rb_2 from radiobutton within w_importacion_documentos
integer x = 64
integer y = 88
integer width = 626
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "Paquetes YA importados"
borderstyle borderstyle = stylelowered!
end type

event clicked;lv_1.deleteitems()
lv_2.deleteitems()
lb_1.reset()
lb_1.DirList(g_directorio_importados + '*.zip', 0)
dire.of_changedirectory(g_dir_aplicacion) // Restauramos el directorio de trabajo, que puede haber cambiado despu$$HEX1$$e900$$ENDHEX$$s de llamar a DirList
parent.postevent ('csd_refrescar')
end event

type cb_borrar from commandbutton within w_importacion_documentos
boolean visible = false
integer x = 773
integer y = 1196
integer width = 297
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Borrar Sel."
end type

event clicked;string fichero
int i,a
listviewitem lvi
if messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Confirma la eliminaci$$HEX1$$f300$$ENDHEX$$n de los paquetes marcados?',Question!, YesNo!,2)=1 then

	for i=1 to lv_1.TotalItems ( )
		lv_1.GetItem(i, lvi)
		if lvi.StatePictureIndex = 2 then
			lv_1.GetItem ( i, 1, i_fichero )
			if rb_1.checked=true then
				fichero=i_fichero
				fichero=LeftA(i_fichero, LenA(i_fichero)-4)
				dire.of_filerename(g_directorio_importacion + i_fichero, g_directorio_importacion + fichero + '.zup')
				FileDelete(g_directorio_importacion + i_fichero)
			else
				FileDelete(g_directorio_importacion + i_fichero)
			end if
		end if
	next
end if
lv_1.deleteitems()
lv_2.deleteitems()
lb_1.reset()
if rb_1.checked=true then lb_1.DirList(g_directorio_importacion + '*.zip', 0)
if rb_1.checked=false then lb_1.DirList(g_directorio_importacion + '*.zup', 0)
dire.of_changedirectory(g_dir_aplicacion) // Restauramos el directorio de trabajo, que puede haber cambiado despu$$HEX1$$e900$$ENDHEX$$s de llamar a DirList
parent.postevent ('csd_refrescar')


end event

type lv_1 from u_lv within w_importacion_documentos
integer x = 119
integer y = 320
integer width = 974
integer height = 912
integer taborder = 11
boolean showheader = false
boolean checkboxes = true
boolean oneclickactivate = true
listviewview view = listviewsmallicon!
end type

event clicked;boolean hay_ini,hay_exp,hay_fase
long i,valor
int retorno1,cuantos
string fichero,n_registro_importado,n_expedi_importado,n_reg,n_exp,id_fase
string directorio

setpointer(Hourglass!)

if rb_1.checked = true then
	directorio = g_directorio_importacion
else 
	directorio = g_directorio_importados
end if

st_5.text='Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'
lb_2.reset()
// Creamos directorio temporal para extraer los ficheros
valor=dire.of_deltree(g_directorio_temporal)
valor=dire.of_CreateDirectory(g_directorio_temporal)

// Extraemos los ficheros
lv_2.deleteitems()
lv_1.GetItem ( index, 1, i_fichero )

if index=-1 then
	cb_2.enabled=false
	//parent.Postevent('csd_controla_marcados',index,index)
	return
end if

cb_2.enabled=true 
fichero = directorio+ i_fichero
if not FileExists(fichero) then 
	parent.Postevent('csd_controla_marcados',index,index)
	return 1
end if
i_paquete = i_fichero
retorno1 = i_zip.ConnectToNewObject("SAWZip.Archive")

i_zip.Open(fichero) 
hay_ini=false
i_archivo=''

lv_2.deletesmallpictures()
lv_2.addsmallpicture(g_directorio_imagenes+"ini.ico")
lv_2.addsmallpicture(g_directorio_imagenes+"pdf.ico")

for i = 1 to i_zip.files.count
	if upper(RightA(i_zip.Files.Item(i -1).name,3))='INI' or upper(RightA(i_zip.Files.Item(i -1).name,3))='EXP' or upper(RightA(i_zip.Files.Item(i -1).name,2))='HR'then
			lv_2.additem(i_zip.Files.Item(i -1).name,1)
			i_archivo=i_zip.Files.Item(i -1).name
			hay_ini=true
	else
			lv_2.additem(i_zip.Files.Item(i -1).name,2)
			lb_2.additem(i_zip.Files.Item(i -1).name)
	end if
	i_zip.Files.Item(i -1).extract(g_directorio_temporal)
next
st_4.text=string(i_zip.files.count) + ' fichero/s'
i_zip.close()

parent.Postevent('csd_controla_marcados',index,index)

//hay_exp=false
//hay_fase=false
//n_exp=''
//n_reg=''
////Comprobamos si el expediente existe
//n_expedi_importado= ProfileString(g_directorio_temporal+i_archivo,"CONTRATO","n_expedi","")
//select n_expedi into :n_exp from fases where n_expedi_visared=:n_expedi_importado;
//if not isnull(n_exp) and n_exp <> '' then hay_exp=true
////Comprobamos si la fase existe
//n_registro_importado= ProfileString(g_directorio_temporal+i_archivo,"CONTRATO","n_registro","")
//select n_registro,id_fase into :n_reg,:id_fase from fases where n_expedi_visared= :n_expedi_importado and  n_registro_visared=:n_registro_importado;
//if not isnull(n_reg) and n_reg <> ''then hay_fase=true
//
//if hay_exp then
//	if hay_fase then
//		// Existe la fase y expediente
//		messagebox('Importaci$$HEX1$$f300$$ENDHEX$$n Visared','El paquete que desea importar Ya pertenece a un contrato importado anteriormente:' + CR + &
//					  'Expediente : ' + n_exp + ' Registro : ' + n_reg + CR + &
//					  'Se procedr$$HEX2$$e1002000$$ENDHEX$$a recuperar los datos de dicho contrato para importar los documentos.' )
//
//		i_opcion_importacion='I'
//		g_fases_consulta.id_fase = id_fase
//		message.stringparm = "w_fases_detalle"
//		w_aplic_frame.postevent("csd_fasesdetalle")	
//	else
//		//Existe el expediente pero no la fase
//		messagebox('Importaci$$HEX1$$f300$$ENDHEX$$n Visared','El paquete que desea importar Ya pertenece a un expediente importado anteriormente:' + CR + &
//					  'Expediente : ' + n_exp + CR + &
//					  'Deber$$HEX2$$e1002000$$ENDHEX$$crear un contrato nuevo asignado a este expediente e importar los datos del contrato.' )
//		i_opcion_importacion='F'
//		iwl.triggerevent ("csd_nuevo")
//	end if
//else
//	// Expediente nuevo
//	messagebox('Importaci$$HEX1$$f300$$ENDHEX$$n Visared','Se va crear un contrato nuevo, debe seleccionar si desea la asignaci$$HEX1$$f300$$ENDHEX$$n del contrato manual o autom$$HEX1$$e100$$ENDHEX$$tica' )
//	i_opcion_importacion='E'
//	iwl.triggerevent ("csd_nuevo")
//end if
//setpointer(Arrow!)



end event

type lv_2 from u_lv within w_importacion_documentos
integer x = 1143
integer y = 320
integer width = 974
integer height = 912
integer taborder = 10
boolean twoclickactivate = true
listviewview view = listviewsmallicon!
end type

event doubleclicked;call super::doubleclicked;long i
int retorno1
string archivo, ext, a

lv_2.GetItem ( index, 1, archivo )
a=g_directorio_temporal
//ext=right(archivo,4)
i_archivo=g_directorio_temporal + archivo
if ext = ".pdf" OR ext = ".PDF" then
	f_abrir_pdf(i_archivo )
end if

ole_1.InsertFile(i_archivo)
ole_1.Activate(OffSite!)

end event

type cb_sel from commandbutton within w_importacion_documentos
boolean visible = false
integer x = 142
integer y = 1196
integer width = 297
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Selec. &Todos"
end type

event clicked;int i,a
listviewitem lvi
lv_1.setredraw(false)
for i=1 to lv_1.TotalItems ( )
	lv_1.GetItem(i, lvi)
	lvi.StatePictureIndex = 2
	lv_1.SetItem(i , lvi)
next
lv_1.setredraw(true)
parent.postevent ('csd_controla_marcados')
end event

type cb_desel from commandbutton within w_importacion_documentos
boolean visible = false
integer x = 457
integer y = 1196
integer width = 297
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Deselecionar"
end type

event clicked;int i,a
listviewitem lvi
lv_1.setredraw(false)
for i=1 to lv_1.TotalItems ( )
	lv_1.GetItem(i, lvi)
	lvi.StatePictureIndex = 1
	lv_1.SetItem(i , lvi)
next
lv_1.setredraw(true)
parent.postevent ('csd_controla_marcados')
end event

type cb_3 from commandbutton within w_importacion_documentos
integer x = 2377
integer y = 440
integer width = 430
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Previsualizar"
end type

event clicked;string archivo,ext
int indice

indice = lv_2.SelectedIndex()
lv_2.GetItem ( indice, 1, archivo )

ext=RightA(archivo,4)
if upper(ext) <> ".PDF" then return

if run(g_directorio_acrobat + ' ' +  g_directorio_temporal + archivo) <> 1 then
	messagebox(g_titulo, 'No se encuentra el visualizador de PDF$$HEX1$$b400$$ENDHEX$$s: ' + g_directorio_acrobat)
end if


end event

type gb_2 from groupbox within w_importacion_documentos
boolean visible = false
integer x = 119
integer y = 1144
integer width = 974
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_importacion_documentos
integer x = 46
integer y = 184
integer width = 2816
integer height = 1148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
02w_importacion_documentos.bin 
2C00006c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd0000002dfffffffe0000002600000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f000000100000001100000012000000130000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f000000200000002100000022000000230000002400000025fffffffe0000002700000028000000290000002a0000002b0000002c0000002efffffffe0000002f0000003000000031000000320000003300000034fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000002b801ca6511d0a1fc4544ad85000054530000000000000000000000001955e2d001c557010000000300001d8000000000004f00010065006c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000102000affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000001400000000006f00430074006e006e006500730074000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010200120000000100000003ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000040000435500000000004f00020065006c007200500073006500300030000000300000000000000000000000000000000000000000000000000000000000000000000000000000000001020018ffffffff00000004ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000100000e2200000000fffffffe00000002000000030000000400000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f000000100000001100000012000000130000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f000000200000002100000022000000230000002400000025000000260000002700000028000000290000002a0000002b0000002c0000002d0000002e0000002f00000030000000310000003200000033000000340000003500000036000000370000003800000039fffffffe0000003b0000003c0000003d0000003e0000003f000000400000004100000042000000430000004400000045000000460000004700000048000000490000004a0000004b0000004c0000004d0000004e0000004f000000500000005100000052000000530000005400000055000000560000005700000058000000590000005a0000005b0000005c0000005d0000005e0000005f000000600000006100000062000000630000006400000065000000660000006700000068000000690000006a0000006b0000006c0000006d0000006e0000006f000000700000007100000072
2C000000730000007400000075fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0200000100000000000000000000000000000000001db360002000650070006c007200630061006500690074006e006f006900740065006d0020002c00650072ffffffff000000030000000400000001ffffffff000000020000000000001020000009ec00000de80009000106f403000000000000000621000400000103000000050008020c0000009c0060000000050000020b000500000201000000ffffff00000005000002090004000001070000006500010b410000008800c6002000200000000000200020003e0010000000280000002000000020000100010000000000000000000000000000000000000000000000000000000000ffffffffffffff010000e00100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800300008003000080ffffffff0000000400010107000000050001020900050000020100000000000100000005ffff0201000500ff020900000000000000000004000301070000062100460b41002000660000002000200000001000200028003e00200000002000000001000000000018000000000000000000000000000000000000000000000000000000000000000046445025322e312de3e2250d0a0dd3cf203020310d6a626f0d203c3c6572432f6f6974617461446e442820653030323a30393032303231322933323872502f0d6375646f282072654d2f0d296144646f2820657430323a443930323032313131343538302732302b29273030203e3e0d646e650d0d6a626f203020320d6a626f2f0d205b204644507865542f5d0d2074646e650d0d6a626f203020330d6a626f0d203c3c6761502f33207365203020332f0d20526570795461432f206f6c61742f0d20676166654447746c7520796172302034330d2052206665442f746c756120424752302035330d2052200d203e3e6f646e65340d6a626f2030203c0d6a622f0d203c6570795461502f200d2065677261502f20746e65203020352f0d20526f736552656372753c3c20736f462f203c20746e462f203c20362030205220302031462f20302038462f20523231203252203020203e3e206f72502f74655363302032203e2052202f0d203e746e6f4373746e652030312020522030203e3e0d646e650d0d6a626f203020350d6a626f0d203c3c64694b2f205b2073203020343431205252203020203731202052203030203032322052202030203336322052522030200d205d20756f432f3620746e542f0d20206570796761502f0d2073657261502f20746e65302033330d2052200d203e3e6f646e65360d6a626f2030203c0d6a622f0d203c657079546f462f200d20746e6275532f6570797472542f20795465750d2065706d614e2f462f20652f0d203065736142746e6f4672412f20206c616969462f0d43747372207261680d20313373614c2f61684374353220722f0d2035746469575b207368303537203837322038373220353533203635352036353520393838203736362031393120333333203333332039383320343835203837322033333320383732203837322035350d20353520363535203635352036353520363535203635352036353520363535203635352036373220363732203838352038383520343835203435352034310d2036203531302037363620373636203232372032323720373636203131362038373720323237203837322030303520373636203635352033333820323237203837373736360d38373720323237203736362031313620323237203736362034343920373636203736362031313620383732203837322038373220393634203635352033330d20353520333535203630352036353520303535203637322036353520383535203632322036323220323035203232322030333820323535203335352036350d20363520363533203635352033333220303035203837352036353720303035203232352030303520303033203030322034333320303635203433372034380d20303520363535203035372032323220363535203333333030303136353520363535203333332030303120363620303333203736362033313620373136203131362031370d20313220303532203232332032323320333333203333352030353120363520303030203333333030303130303520333333203030352035373320303035203030352037320d20333320383333203335352033353520363636203636322037353520303333203633372033363620373535203738352036333320343337203331362037340d20313520303033203934322033333320323235203333352036373220373333203837352033333520363535203030352036353320363532203333352032390d203030203232372037363620373636203736362037363620363535203232372032323720323237203736362037363620373636203736362038373220383732203232373232370d32323720323237203837372038373720383737203837372034383520323237203232372032323720323237203232372037363620313136203131362033330d2035352033353520363535203635352036
2B3232203630352032303520303035203035352030353520363535203635352036373220363732203831362038350d20353520363535203635352036353520363535203635352036353520363533203934352033333520363535203635352036353520363532203030332038370d2033332f0d205d6f636e45676e696469572f20736e416e636e45696e69646f2f0d2067746e6f4663736544747069723720726f522030203e3e0d206e650d206a626f643020370d6a626f20203c3c0d79542f0d2f206570746e6f4663736544747069720d20726f6e6f462f6d614e74412f20656c616972462f0d207367616c203233206f462f0d4242746e5b20786f35322d20322d20303120313320323932303030310d205d2073694d2f676e697374646957363720682f0d20396d65745334382056532f0d20486d65742034382074492f0d63696c616c676e412030206561432f0d696548702074686730303031582f0d2067696548372074680d2030306373412f20746e6530303031442f0d20656373652d20746e20313332654c2f0d6e696461333220672f0d20315778614d68746469373031202f0d20375767764168746469323634203e3e0d206e650d206a626f643020380d6a626f20203c3c0d79542f0d2f206570746e6f46532f0d20797462752f20657065757254657079544e2f0d2020656d612031462f61422f0d6f4665732f20746e616972416f422c6c0d20646c7269462f68437473332072612f0d20317473614c7261684335353220572f0d2068746469205b207320303537203837322033333320343734203635352036353520393838203232372038333220333333203333332039383320343835203837322033333320383732203837323635350d36353520363535203635352036353520363535203635352036353520363535203635352033333320333333203438352034383520343835203131362037390d20323720353237203232372032323720323636203231362037373720313237203837322032353520383237203631362032333820313237203337372032360d20383720373637203837362032323620373637203131362032323920373636203434362037363620373633203131322033333320383735203333352034380d203635203333332036353520313136203635352031313620363535203333332031313620313136203837322038373220363535203837322039383820313136203131363131360d31313620393833203635352033333320313136203635352038373720363535203635352030303520393833203038322039383320343835203035372035350d203537203637322030353520383035203630312030352030303520363533203635312033332030303020373636203333333030303130353720303537203035372035370d20373220303732203830352038303520303533203035352030303120363320303031203333203030302036353520333333203434392030353720303537203736363837320d33333320363535203635352036353520363535203038322036353520333333203733372030373320363535203438352033333320373337203235352030340d20343520303333203933332033333320333735203335352036373220363333203833332033363320333535203533382036333820343338203431362034370d2031372032323720323237203232372032323720323231203232203030302032323720373636203736362037363620373636203837322038373220383732203837323232370d32323720383737203837372038373720383737203837372034383520383737203232372032323720323237203232372037363620373636203131362035350d20353520363535203635352036353520363535203638382036353520393535203635352036353520363535203637322036373220383732203837322038360d20383620313136203131362031313620313136203131362031313520313136203934362031313620313136203131362031313520313136203635352031310d2036352f0d205d6f636e45676e696469572f20736e416e636e45696e69646f2f0d2067746e6f4663736544747069723920726f522030203e3e0d206e650d206a626f643020390d6a626f20203c3c0d79542f0d2f206570746e6f4663736544747069720d20726f6e6f462f6d614e74412f20656c6169726c6f422c2f0d206467616c4636312073203631346f462f0d4242746e5b20786f35322d20322d20303120313420333832203133392f0d205d7373694d57676e696874646939353720532f0d20566d657434353120532f0d20486d657434353120492f0d20696c6174676e41633020656c432f0d20654870617468676931333920582f0d2067696548362074680d2031356373412f20746e652031333965442f0d6e656373322d20740d20313461654c2f676e6964363032204d2f0d20695778612068746439363031412f0d20695767762068746420333834203e3e0d646e650d0d6a626f302030316a626f20203c3c0d6e654c2f20687467302031312f205220746c69462f20726574616c46636544652065646f0d203e3e657274730a0d6d615785894848e34edbfc82fd102b323d435f6edc625612191fe104dc4856ac35611b64dd8ddb4cee39f5f3159e9db37d5b44846660555dc71c8ba9d4e724166ebf59024122012c834e2116acd885b53fe80865d9c5bafdbd854b308308212cbc630942220c2707fe5e
24b5e2b23725438a849bc77ecbbfd9424e594d1033a678adf7e5a06d29772978a003153782cd817cdea20922dbe8849604668c740fbc2f24c3d6a61a07ce01af031f698ecb0be4af6cf4559d2bd335f70cb7c8f017ab1512bd591e1de0c5c657dd996028b29c1a0e45b840125d4c28a203c4b7f188873884ebf73777171dd5d5ebf970d6ac75717b74847ebb779cdc2df5570fd66f1472c6e7fb4b336b7127a361a46b7b1e0d6b0b88ffae3c8d5ab87a7c2fe0af9d7ebf3c78f9f5c15af387bbd78d231b6b54cb01313906c1a7854d1d614938ee717368510cf286f62300c517bbe4d4958c4e601c2f2ec516f3b7f4f66f9fe6d5cd73adbf8b51196e7ba4a3859fc3d85a13beddeb27ce993f66e1cd276148779a2c3e436a627abab6f99848aef0ea1f8f0f9dbc742a288df4dcf3585ec51887924bf28c1459723a832092bdc547e549d93be0d3886841481613170b01e80b0357d7482fd8e646c8e3c879deee8863b689d93d3864e6ac644ba5b845c4902f7d2812f6564bd9f13ac775013f3c63ff5ec798855c88b42aa9485d410ab0d141dbce626f65f8e8b1b391c3870bc4241bf659e6978dfc63205858fdeac65a512b630fe669ea07496d356de16472faa7b9e6c93f1c9a428ffb777f72a78f9038b58e1246779186911ed4151cc57be07f6b21945bad83ae3a629d0b65034dec2fc3a7ade322ae75a48d8d01f2e0928d0c214a6fb20b62de1bace298e95179a605699a5725f699f5e00cf0e134eea3e9f027dd0ed3a4ae05fc90d170188d2c10fa267a25b69c1ec3a3e22b0a0f1fa93664bd54215a88d55432522f66a78450b41d051169d6bd7de34b0e85445983f62680023a2c60f175e1c50e462715d71666948491198784123e36be3646945f69b6353e9affa66c56f15e6fa0a61bf3d1b7e0cb595e0611c77aa7ea4a9ac390a1ea9f4649260ef234bf3c7d833895c49dda27f571d559065b3783131a67bb6d0c5393e07b563f3d6e98bd223e313803145ac48d00cfd66f0c10884cb6a64a19167769e9d5c1ff41ad55246529426d8bbdf2531bc074fb8bc36d8dd743c922f5db783673e89095c796e53e174288cab971a9fbda8615e3f35ef7c27c4dc2fdc772740d50814e94601e6b62bf8edcfaff09f54989b8e149eb6f2762152e3dab41ab431b2015c256ecf5b2de347fac520073c6bd98a67dacfc29dc572f698823a48b3da6459132c39df7b66e03cfc5a8abf1102ee19b3bf68c1c48bc743df4248e5680dd458ecbb44fdec98553c6a7ba16b452f17bdf530e3ccc6ba19ed64a20a4275e02fde05f346a8907ac3d3430681fff0c1a9c0e9cd3807519c6459a2bd8703e4c020c1a37401d82869b8572110b26df72d1e51c9ef1cde1ee658f962d539bf366e092c5cc92636e5127ed161ad1d592da844253e17ad85369be1fc90f520d6837b56205ab13c5a8e6d56d70c4c9bbf422d44e70cda3d49d90e914ad1b358ec57151a74ac1d2cd69532d8efe33407ac3bfc5ea99c0d56786c00277f35f5d4e6f757d663ef68c017c2a26dd7522d276f041e69b5f448b58cdabea5e30f931d5ef0a198d61a0947fbb5c373ee8560822b3b28d5a63d59b92bdae14e72d732cf9a40f91983da26ea862bb9d7a695d0ebe85ae77aed66e8fdbb6cc377d3913e74434c5e62fe7ca51d7a0851fb37630d31753483d35498b51099f7c8e78282e3e3e4b2714fb220b5d1c3b4a181dc6085f61df9c268eee3d7e38271ad6e896ea378405e8ea18453078bcff7afb14674fa5ea63f69a9513af133452b8b7713787722ad1ed8a2ccb67afa188fd49def857991bae52cf63128573175ad798fc13363a569183af09b276dc8c90cd3db09bde9df45f26da39b333ae862ed28df8523e97dbd63e976071864e091d4327d1ed5d9ca7d306123226f982e645cbac3d6bddd74c4d86f8f929917710c76d08eb8760927e4b30eba5687a9be8b8a11b040d0ffc650dbf3c7473646e6d616572646e650d0d6a626f302031316a626f203135310d650d2030626f646e32310d6a6f2030203c0d6a622f0d203c657079546f462f200d20746e6275532f6570797472542f20795465750d2065706d614e2f462f20652f0d203265736142746e6f4672412f202c6c61696c6174490d2063697269462f68437473332072612f0d20317473614c7261684335353220572f0d2068746469205b207320303537203837322038373220353533203635352036353520393838203736362031393120333333203333332039383320343835203837322033333320383732203837323635350d36353520363535203635352036353520363535203635352036353520363535203635352038373220383732203438352034383520343835203635352030310d203620353136203736372037363720323236203232362037363720313137203837322032323520383736203030352037363820363537203333372032320d203837203736362038373720323237203736362031313620323237203736362034343920373636203736362031313620383732203837322038373220393634203635353333330d36353520363535203030352036353520363535203837322036353520363535203232322032323220303035203232322033333820363535203635352035350d20353520363333203630352033373220303535203830352036323720303035203230352030303520303333203036322034333320303835203435372034350d20303720363532203035352032323320363531203333203030302036353520363535
2C203333333030303137363620333333203736362031313620313136203131362035370d20323220303232203233332032333320333533203335352030303120363320303031203333203030302030303520333333203030352034353320303035203030353837320d33333320333333203635352036353520373636203036322036353520333333203733372037363620363535203438352033333320373337203131362030340d20343520303333203932322033333320323735203333352036373220373333203835352033303520363535203035352036333320363832203330352031370d20303620323236203736362037363620373635203736372036353720323237203232362032323620373636203736362037363220373632203837372038370d203232203232372032323720323237203837372038373720383737203837372034383520323237203232372032323720323237203232372037363620313136203131363333330d36353520363535203635352036353520323232203030352030303520303035203635352036353520363535203635352038373220383732203532362035350d203535203635352036353520363535203635352036353520363435203633332039353520333535203635352036353520363035203637322030333320385d0d2033452f0d20646f636e20676e696e69572f69736e416f636e45676e6964462f0d2044746e6f726373656f74706933312072522030203e3e0d206e650d206a626f642033310d626f20303c3c0d6a542f0d20206570796e6f462f736544747069726320726f746f462f0d614e746e2f20656d6169724174492c6c63696c61462f0d207367616c203639206f462f0d4242746e5b20786f35322d20322d20303120313320323932303030310d205d2073694d2f676e697374646957363720682f0d20396d65745334382056532f0d20486d65742034382074492f0d63696c616c676e41312d20652f0d20314870614368676965303120740d2030306548582f7468676930303720412f0d206e656373303120740d2030307365442f746e656333322d202f0d20316461654c20676e6920313332614d2f0d64695778312068742037373076412f0d64695767342068740d2032360d203e3e6f646e65310d6a62203020340d6a626f0d203c3c7079542f502f20652065676161502f0d746e6572302035200d2052207365522f6372756f3c207365462f203c20746e6f2f203c3c3620304652203020203e3e206f72502f74655363302032203e2052202f0d203e746e6f4373746e652035312020522030203e3e0d646e650d0d6a626f302035316a626f20203c3c0d6e654c2f20687467302036312f205220746c69462f20726574616c46636544652065646f0d203e3e657274730a0d6d6157bd894836e36f4df905fd10d94f440fd44ad6c29bb2def7168169eda1731c8b2065da25b9292a91677d7e7089c921f8287b76dc44b20462de6f3391fcfe337ba4549774cca8d2acbc7a7909e9fe098bf8fbb913776a4c4b471778fbb8515a71651c486ce5c29271f0dee49f525a73d3be47784949118f47dc7e5a0a62198e915c1269c4fa7cdc8e605e9e40234d3de74d818f6a7e24966832ab38bf0f4fdfb73d488c7a5b91a7af71f587be6ef5bb5560fe7b29bd85a597a1f768f36692dfa57dd6e54542b74a5111410d3261a274368b4e788d939692546832194e08311b214986ec65f3a9c399d219559e69f531a65c971393dc1b8eb3ccfcd06382f4d865499700b776b5968b124d3dc7fe9572d866dc893e33c93a7384bbe92d87f0acf2bb5655a7191d0f95c1f36f5584611be3f8c910922349e69c82e33f21a4c4fa506dd39d7851d3ad940e87ccd8b5611e1ec2b420b6708e428c60766a353d8c1e2fe887b34459c5b2e7eb4e3019c8ac63c48607199131fc9b7f17667271db830926baad6986d803698e20ea7e889c912cd8a21048f56e1a99888f7dd9c47a13fd428dba2d03480c8b96563316936872f21c33d2769184439a18303222587f29f0cda2b4cde189b8bc06ddb2590b528f6882f5a2af4965ef466ffdf5e6b045d183614497d8eaf7d22d253584368cd52338a38890fe1cd59f683a11c9fe093d6da0280240ceb0ac846708c23b2690804f6025cf876233cabd146f4d2d00ab74cd0f3ceeccdeb85931df0f010d2ad678b469b1a11e1eaa0b0c20f84050cf6e5cefcd10a05c0a5bd2506622f1d743b04df894397b5679207d4a2a3c3d7e8b206509ac00811cd274600016e5028de69fe010a2f5a6037683df8be3956fcd55b81b866a57a73705dfc43438559c41a652dafb5d65e507637c2138e18c598b7cf67e0e46a1380414a857ec388134c8e9ac75b448671a0a5d71a801473fa907c7bd90699497702c1c67c4f63449b7add6e65503396c6cdbb9af6527acd92075551ad5a0c3e567067801995cb3a1b0d71420a1e16a6e6455a7858ae97650e668b040e41db2a27ccb1706a8c8b0cead57bd3b59c6b2f5ab560821016f20165eec5745e4455e98a547928b7a680e7b14261bd7cd855fba80bf03acb4a0d100a9054766a85dc074374e06128dcd59696f519ea79dcbd867dc011f7532382c0b9908f8a866ae819ff3c685ea980c34b099afd333254384987a84ce582f41bc9180b0d6155724e2146dadecddabf21d22eb78d9a6d5ce7500268db34fd46edf7b2f72ccbd4b8e3cbebeafe3b70d8358c9beb8afdb41ef3066147c368f16d36a08500f41de668476ed8d4e205e859028b7722b21d1
2Cd2dc3a3ff925992d21ebfe0f57891be2385c1165d6f7f60e2ef53d851af67cae5704b082aba6305d5a51a3f10ae2a3bbabe95a03aed5c7f4cd586093d2c0c2c8551fa763283d56ab1f8b70cbcaeb43ebb377b9a70016e3fb0922ee1e6ab43cf13df27d1866d2ad6f7ed71a76ae62e5ac06ebb29dcc928dae81a505b6e812f834a129c5af35cb7869aadd92ea137d4d7a157d6c82282347d0aea0fff10bc9bfee6968dce61968555f65eb8d34e68285e68702b210767b6edea0737640bde19b1d742ecb4738b1eb33b9bacddd3516c5d9beccdeecd9e77b3767e9e3d59411481b8bb91557b5636de339d6ce2671dcf8e5f0dedb5f76e35a2f84df7c675251fe3de59e3ed71f66c77783f30a5db4f22e3f7b976b9ae1dafbf729723324ad523c7a0f888053eb20ed38f206e55a840fe396e083f44e885a2cafb496b7fe34e618355159860c00f8616780545d23b72c080d156caf637356529d10bdb8765b38e5db823bee8f065470f99bc08d47f37a4a0c009040f7055c48582c56c81dc6da8826ba717e9ed796b91ae1cd024dc5b17c8c011eb57aeb5aa1b7846915e837f83a469f5f7c1df202feee0d1d434473646e65616572746e650d6d6a626f642036310d626f203033310d6a0d2039396f646e65310d6a62203020370d6a626f0d203c3c7079542f502f20652065676161502f0d746e6572302035200d2052207365522f6372756f3c207365462f203c20746e6f2f203c3c3620304652203020203e3e206f72502f74655363302032203e2052202f0d203e746e6f4373746e652038312020522030203e3e0d646e650d0d6a626f302038316a626f20203c3c0d6e654c2f20687467302039312f205220746c69462f20726574616c46636544652065646f0d203e3e657274730a0d6d61578d894836db734dfe05fc149a9e980f53f0cd8e9c6d8f244cd33c9e102fa3e250f029096a9003047ddf5f9c32520020b07c64dd62c0d14c87beeedf926f1ebf1655958a8f630595a33137f737647d1f598effefdc3e3f3dd59e51c4f8363e09cbfe3d96de9e6f7ecf8f63bd3eced937147167b9becb58975949a512703defce1cbde276f2378ea63d65db2994eb056ba334ad613a7c47ecc96851f10bd8613b469b38ebd71fc9d92b449fefdf4f8bf1c2d72df11dc0164459a5dc10b003da94571e6c3bbb6a1af5e6a8b5015951a4d3defcf9258ea08ec7292797a28996ec001faa358ea0d8eab5c62a59c50930df097a267233cb3e84662e5fcf060869c5de651b2b7a40b373d1150f124d6e7576300c516461d90c33484b627163f01096f5472328347be9c67935c308d16d703111d16788d138ae6b4c6fcd7b533d3e0e096882d18b28e2d694d1697135505857c4bcbd57619d4713884a86883874126df4cd0a56ec29e9c67b461b33d75b2d271ce1ab02de82fad4ddf9ef9a8da8556f33f2ccb6158942cde885c54d2dd952542b5aa6b38f634aa1d1bfe788d07cf46aa59ee3a02e4313c0fdc4eef07f06be111bffa062b7a1cabb070d2a155e275916187896c20ea811496fa81b28cac123335d1230b10d15cab5dedc8a133306b8123795a8e51c69490be1159490bae922b300915245b01279840751a2d2483826544737e04168b6e753c5f50dad566e3a657faa00f0227a7608ba95c937c5c287d70abcce26298766d699293b645c8d30bed2fab5ed3add7faf653b597af2b259a50996f0ec0bb640410fbfa98776ab3891f4905ad36e6ab9759f29466ead424e034ec94d80b6be186f2da89e7728661da92c194fd7be5a9586ea1ae1ac582157e1ba9149bb3908dc0e786cf767ab15715cd36e46e85fbcef53305d3a93e5c2946998504942e170e62d3b70f023e3fb4cdd286a9403f5f48476ed9d57ff6835dd2ede800de7c01257473b841275e52128186d05232e80064e86fecb43d980a43c2288baae83f48b32136fca3304296d15a834bd539260c051766c56ab37990cf9a287b27782d2a71b241108d72c0a1d6dc0dd911d3294a2648b0016e642dfc46ce9cb9d55bad0a035c1d708b0b75fbe15a4a88bf5f2ac29ec57cd80c92eb05bcf105e43d94ff9127568a499a9c923fc87434efc66d337e3e95597b729f73f69ed04322be683a07be3a3e9a88408b5107ac59e01216a1a44dfe71c19d62dab65e6201117aa99a8fb112bea31642be07b31fe3da7740d24b3dbcf99891358d03a28f4e9d80d12dad9ed075acd3c39e04dbb85a87a546a4ea2ecd549b12126f334fd272a2f62f762d92e6cf4ad3e941ff259698295ea27d690654807d8d089e38ead1d26d3a526555bbf0a32b6496cb4e6c4a63a0d9ac594fc363da8582933f08c2f60054439681d941286053f60cadfdcb3640bb53438bb9ab372b44e82a1ad769c4d842bdb2955eb5e7f3b4deb2b2231699d6e1579e55b23c9ed64d72428cc8f621e47c72bf26485e6dd9d1e6dc1efd243a8b047ed75a6ef22522b1b78768f69fa0b552a8108408afd852ecd19d201f6edaf5d31be1316592cbbd75a32f0a8510925284e4c068aa7dbc645eca3b397493f72fb833b6d577590f12168a5ff1092a98937e38a63cc7ef39f9d4dadfe4ef2650d59308f6d1ec9d4d1ba245f911765fe8f4d4fe97eac2f3cdfcbcafd48e3789e550e8399a43bc1aa6b41182341bb8f6f50465edeab427ef2f16cea220a6238a418615ed8ad7d2d860cd29805f1154a206b74fb16077927b5c5f92d9790c2ce914c233a1ea6709b336039c673403a6c2284ec292cdbf6cb3b75aaccdd57a296c6991ffe3a5dc2f31063d9cab93ec3cf8f8846
22ce3ed276a4fdcd82e882261ad361d56efe36e7b7b126c1baed5242d71b446d8a598487395000b93f0b058b442ccbbddfd87c1673966aed587138b12025a58b2bf74718463c586a42e516868316719520b66059a440d45d247db56a1e997dc9cb94caae77313bb63dae5addf1fd4daee5a188c7a93c5bce179f009b0800abfaec39852cf88d83c802780f7b0edc0abab985e02b86d04976e43d395a435c82e8e082268cb00db640226c85ad6f03e6e06662f8cf6dc7ba39f67ca81c6fb6d1975fc99f73e983bb9975e58e117f92f69f91ecd3d59cbe18eb0dd6a784ef719b1c5e8269a2eb91d616bd63d9f2a6ecc6b3750d9b3af82cbb47926518fd4b7f343706f65db8ea06d27dd558bd374f5757f33fd3618bcbfcaf92767457f785a719c0d34e0fdae5e6655874cde3e3ec221e327f6e650d31727473640d6d61656f646e65310d6a62203020390d6a626f393436316e650d206a626f642030320d626f20303c3c0d6a542f0d20206570796761502f2f0d2065657261503520746e52203020522f0d20756f736573656372203c3c206e6f462f3c3c207430462f20302036203e205220502f203e53636f723220746552203020203e3e206f432f0d6e65746e32207374203020313e0d2052650d203e626f646e31320d6a6f2030203c0d6a624c2f203c74676e65323220685220302069462f207265746c6c462f2044657461646f63653e3e206574730d206d61657289480a0d6edb5795fd1036dc1f03ff0288ad629b7d4a24a46814934be041a2e15c2fc9f66865b6894ab50dc9677d7ee357769378e0083b1b3932b5ac339ce6735edebf339a889ad1e424a2674e55c3f6207d9ff0cb7f6f57df1fe349de59e55f6c7c0554c978cd0997fc7c18466374fcb07d1ad2078fd0f23267923927a3db4ea37b8d5678ef653bcd193541f6d277d041f4a77241914e91d54633ba3db74a4e5265f6fc6cefc46437e955ffc209f6e46334a6bac102462ec1770d54f22159e406a74c10da76ebd2d77e87ed1e26f1c35c1d53bf55bd923a4a547d5fd3fb7813ae06f52082e3b87a6af813c12ad2283ba5ee52fc10cec83d77e4f046a46590f644525fc0e4d3862c368708450ce1f50d67a8dc925c13e10cf1dda98bf07c6b8a03e357b9b72377408d41cac6b1923c595828e52c5c6cb338027788e21edb9474353aec91b8e134baaed8c6f7bc3310d793c9f1b38daab7ae76cbdf779a500e1abb3c92afecd6f6b4a258c1cc00df510dd5a75737031945243ee0b4620b3a71a0c391e20810c41592a63be2e9d7ce79c6375e7270fe7f12fe7b8deef689ee578d2110bb07a869ce0ea1db5ffd6f6d907f5c070cf41e4f95b483a7220d1db2008315eeea5d8c4a03b559e34740fd949ea757b26a4f0e5a3476802ea48e8160886b11d75d453e173c8b224b49865116c05bd5ef6040c829e3d8d984a836af5d995a9a2eb9d2cd515c74014a3ada14e1a9e92f83b4cc4125f9252b61e3c80c15ca1820252fb9adc08b9f569b2077decb875a3dfa90822459e2c28ef6851341418ecce6b6caa734e50501b4213a8515e77f0c48f040b02d6622c4f508114a503656b2d50ab83ea59b03d90d43a6450c0619ad9072241f667fc156d7c0072eebf20eebeb57f8a2eb1979407c194220cb13b93e7c03ece7db7898aed855ec88de17f19f8c1359c9c2eaaf34b9def7bfbdde8b966878e65fd160972a859af37b8365013f903ec6eecbc7777ee93bf752369e064a7043c7591d4c3964d12b26e9c028a171405a76f2f589b81c2baa95f41a18fdbc93cfc5160cbf051b37d5a97667ff7e4382765401b9922f1464d9dc15e15da9c257fa5968553537a0505386736a1f4842e80793bada33121806c8b29fa7913916ce4381b05e14d699815134d5e58fc806d50eb8182462ad8c9b66f01488fff22312e297fd8035ba91ae2a08a8fae91a1b167a41343fc916bc6ced78c9f7cd68417054eec6956d4ee586d9aef57588b2069435a0a11251161a1681c660b53154d1949f7684d62b601725cc1a5143c57bd93bae45680b9f59b35988d8ca9ca582c3dafc059832f8724ec986caf5a33a242092e8811567ca3dc9bcc5c8b9cd6afe4eff24eb7a7bfda8a277a01f7f57cc17feef7b6841c6709ebcdb2937c782ea56f94ed7f2728c6e417bc7372096e0ea183ed0d31fe7ddcea007c42264b708110b51004187be9c7c43cea0a527b36fcc7ede9924b6bcbb4b6a7cad3b8209e293c89d5a021368c46302c13eb5aa7a5035ee7f6af25e1535fb955965c2c52d9683cf0dd8d88e3e5d34a42cf9340fa8615d3cc300ad018712a18b78a2a008adf0424ea91f9e2558d479c7376ca0ca6a4703b59806cf94feab0905ce55852c1f70f91b83c8ad5864617ad19ca9854f382975c0c2e79657f35879aabb2478fa1b6879af070a0eef064e470b172003dddff45da4cf078f5e893869b53baca0fc1cd27ca0dc1778123838d05344f71a71f75587458ee7d8b52f55f2a617f3e29efed32cdab87579c904d2cd2cd2bb0982b98f2b2813a1228ce6482a8acc55a49710af58f95e5a00e569987d14949a2e1f46091be04834d30348e38d86b69f38dcc6951ea95d6eedd2b5e8e81af30b65aada6f1d80dbcd8942c38e98ae3de2e6ebdfaa2a01bbb0e27962efdb5b1ac561b5e7f7d9acc64e14ed3263c23e29c58372575c2858b0fb3fb714686923bbb4e8895396abf3bae89cd59c0bd56b82675b71baaeacffece1ad85e9db59f16459f1e67ae625e393d17d72180db4aa20bae8555520cf32c9711d68bba538c13039edde07
28e6df184378cf3c5e545f3dbd00869d69a9146941d360c3dbb75166d575f425f3d2a8a9b33dce3415470d1d9f01c485b9ab444dbc51dfd3c9a52b44da9c10d222a52c31e0333b12693620ebce4d2a9d568c6673244c9da545b87678c7e53536066bb5aa06f5e8bda0238a92a52158ee4c39a1414e8b1f026df8340ca6f0b4f8381d55b3365c97130ce3a5a679c03e419d83991adb9c42eac39b8cee6bcb965d5595361728f31abc9fca04cd59ce3c773b75e933ce1c61b5dfda002bd835a007e240f3b00cafea6cbf3ead10815679650ce0c068d2df4c369b768cedf023ad20a28bfc9705bb3505f576d42d28b8641b112a77c88eec4d979c9bad35325c8e2e05a02d41de4606328391f703e14300fec0b00d87653d675835368fd0f6bea274a8b33bc2f9e155b09d03a970a6cf0218b3690d0567ce23719c03fdc7d2fd9b82648b0aa441e0292614cb8359dd95e52c4ef3f2f7f4676d182e038b8e01af623d28eb16b887137d884cea5f7ce6cf7198bc69d59c45dda4875561e70036128fb10a16e494e6a402bf2cc9c3cb052eef338afc2fcb62ff2d84f2c7eb1b9501ffabdbc47264bd646e650d65727473650d6d61626f646e32320d6a6f203020310d6a6220363838646e650d0d6a626f302033326a626f20203c3c0d79542f0d2f20657065676150502f0d206e657261203520742052203065522f0d72756f73207365632f203c3c746e6f46203c3c202030462f203020363e3e205272502f206553636f20322074205220300d203e3e6e6f432f746e657434322073522030203e3e0d206e650d206a626f642034320d626f20303c3c0d6a654c2f206874676e20353220205220306c69462f20726574616c462f6544657465646f63203e3e207274730d0d6d61658d89480ae372cb5702fc1036498e03fd4df2e64a7789b8ea5654c72b12405f471145c2d2d674405ae0f4fafe2ba2ca258a65cbb19e9e8104efd19e9eb2d64dfba6922da6b8ff6c62eafd1949fa7cdb23bb9db29aa43cd87db864d649ed94f1ec3cbf61ff2bf365e58a6f3fdb647adeda4d9692697924d6edc2dced99841b232fc577fd1696a41b38c08da9479f19c8f581cb4a2fa757ac0fe988b8b3ebbb1222c87db603b0b724b2bf3dffd845f9e26ac4be72b3a7cf5a018c4cd4b3c779a2ec1313159f5851b9eb9462cec81198ad479625aa5a111cf6bcdaab2298b9329a2559d552c3a51452c0faa8f65b152084f917e462d3238ca2f9bd4f30e262ea2a7c6e230c2241e94af75a507c4ec04a35982386da4847f336b208917e7c0bc5ace417d83fe01790f653a6d2d7d749152c7467ad97515cc26269c2021b04e331fb2d3d04e8a3e7eba0e02595c679a755880b3c3896f94852756b3bcefb23199454fdce7480451af1ec932586031f7629b4f44bb57a1e388ecf6b8ee17d73f7b26c200695e9d90d356707d38204925079120da97bc4fa18b061265b113d69807c047898f277f5f3a92cb0c1aed3e6223a0416368c03c980cc69778c1ccf28ad19f603a02207281c46b91f1e419394404024a03fee8ed6510dc491c3461cc606df193bc8f910019479e9c05b23e927e5df24655a752f416914283838c7714fd5936483d591b6cc99f3fa1c907997358e23509657b72bb3338f91fb1d15865dfec8cf65b85dad6ec49e5310aa2ccb1304bd6cbcaec1fd99f3fd994495d8329a789f14098f8413e39114e81a1e6519cb413839350a1e8abd53574fbcc2b2f8c57dd2e7c7103651520d8fe42716a4b5f93fead2bb6f45c5aebac6bb7cd23a9a9aad03cbbac3792cdf6493b9ace67966088a939a4950dada5145771328ec3a21ca5665b1532f7e66ea416bc223aeb37fed4a1e56d25dcde4d3309117865fce90875afdf0cfdd0acce29004cc8b4fba7c2fc909680641dc8b68c30bc38148e356b5229d1196554ed3598b2eb7066b707c50408d1e08f0a4160ec8285a2a9ca887d1bfcaf9416e9c79afeb3ec366c558498bdeac2d288a9fb092af029f26659531372ea0fde175131f2b257d84864f47b1bb46e2ac56b3ea16558ba5e7e8aec1d0bbc070688b624fa6a9d455649022d4e06ffabaff98f2d4d8b28735dbc6edd6cd2f14b4c25c45f3e8e647c154adb01680098f7e37b2aa3fdd6a8232195d7b51ddf87af0ea7e41afb885919cc3507c7f8e10814b31fcd0d1ee226abc9eacb8bde1ecc0721869d680f25bc4c121309c9a9bc56ac3e36906dd65fc6e60de5072ae9ff7ce3f539577073c92fd4149e7dc7d1c2f6dcaae84533c1987faa479074f831df5b962a7e271897d75cd1d54212d536d1e6d093ddbf4bac095caf2c9f24de7f7f38021245bf6dc0a2bfd8ce36891a9a575c4722f4a9f4bad95cd74ed4aa2a4a4063b2d3c0e6d812ac466940513f35a0277e0e32dfa82b1bc67007cc2b3d088b52ee75b803b4993f1a1da79149ed8fed2c63903bd7711b81ca9756236ae07ecbe753428ee49f22afa101c8b5b6a61ee5203cb7069a4058250685adade8b4b6968a654bbcf52b7a7a24cc8f391e82e0fbb55a57deeab2ae363aaf98d77f29aeeda3f1d55d673bb22b826d1d8673ae90d99b81419f541cefb2d9e34af7ab3c35c10626706e835d893635794eabb665746db7571b53d4a22f57c140db4eb25b9af84971d6bcedd44940063ea346850d4318a49da86bca25a7e5b5e6bfa92f8ba1a7ee494fad053d7c15752f1317c2adf9db283a2726f28111609ea2db4bf0518c791371755b50cbb628900ec0dd1780ac6cdf495988403b2f1b3b177d4b2ac05d92319115921f3b87c11083eb89041
296ac6091ea77ec70fd8eca642b1063e2cd3c31f5dfac27430e619d0fd27b7c9f8834f3e437eb8fb3ced1434815d6e0db21c0940b96f1e3bd024a313cf6c9b062eef54f5178f5ea962ecbf4bb0ae02ff370df1660173646e65616572746e650d6d6a626f642035320d626f203034310d6a0d2034336f646e65320d6a62203020360d6a626f0d203c3c7079542f502f20652065676161502f0d746e6572302035200d2052207365522f6372756f3c207365462f203c20746e6f2f203c3c3620304652203020203e3e206f72502f74655363302032203e2052202f0d203e746e6f4373746e652037322020522030203e3e0d646e650d0d6a626f302037326a626f20203c3c0d6e654c2f20687467302038322f205220746c69462f20726574616c46636544652065646f0d203e3e657274730a0d6d6157ad894836db8edbfd82fd1085263e077ba91157e6ec9adf648b40a90bec0a5f0306d12d694474493bebe71b4b699bc3fc2d14b938a68b609ccce667ba7dbe19f2a935a32105612629770f4f2474cfc1a7de6f775c2a49a449a5dc3e3f0a539a5926925bf3f0d5992feaf26f4bf791f249a723b73bc4f89cf648c4457bc20b5ca5e7a8f2f0a88a939673edeb455b2d538a3e413a8ec932e38f6ce477a7935e493ee0804f068313cb16d6a56caad2ad9a7b1f66b19e71aad2ccf52cf8dd8d49c94e1327840a4fa93a4067c82c5e99a23926e80269f338c5a1afda1671fe7b01c27fc340090793a166e5b30931668f9ecfa944c7a7aa82110b4d058d980b328ab268ee474ad3f08774bc70f6a47040f8869045e7c87aa0ace745a75b061e247c74050644d75bcb65e6918746a9069a8393d05e9b8e798580d3b953692071aab0e8a20300a487921f27ac95f0042154d37a225d8cb2b21f595b1175a724a94efb02462393a9d22493651146132da24f89d17350e25d68e0f6a2046586ab00292c57c719a306f2cfe032d3cfe1cc6d7205c2f81207d2720f1305fab7ad123f4bb79ef0bc2243dfdac1085a5b487b76b254b82b2bbb0ab64d82cd2c61c3c298fe70775f947c8e989f95f93222e05287b90e65f159ee536d74636d674b4eac6a0a28aca7f07db751d699a2706b2de19e75904d7cf48cc56b08a6afcea3c90f05959da2271b417e22d2cd3478626b46a68ba2bf1afb4bb5032973fc0345197952bad8ad54cb14803364e3f389fcb4616fcd40177d0a542b118c12c4120abf3f95865db299207ecd31e03ad22bbfec6f77afcf356dc250a841de6f86767a16690098c46f706841cfe0e0f78ff06178d97862fd3cd542822c89d105954de51c8385a28cc68d8400533e23cc52ed6d2a1a4d006a0e546d8c700e4936995505d65096132278a44c1e3564c42676e5197cc063198d206b46127fc9a29536ace717328f8b9cce35da89a30fc07bf594410752972c45f0b4d59a83d52218334744510610d2624e386bfc582f88d9898c91a350516577b5eef4fa8667ea8bc1b786de4507c9c3e51f016637f7d0faaf0bad83d4c9fd30bacb46422433e8289f189759018e53f844b5d174fa37d0ab6ee7aa23b21079a5502ed79a16ea90df4a7cc7914b2baf99979dbfff96b531394137c8019d15e83a5b6dd893e89ccd7424334d4d338508f94fa75ac0247c552aae0db2d4818ce5621c7af5aeeee2dc089b36abe0c9653aa5722ebdebe582a2f2f3dc0a1efb61f3363a1bd5b12f5299bd10f2863e5c79099440f3fef0b70164c5226d8580864331fc410e85c56010b90042261950a973f722812f711f1256fa9798817eced33675ca431dab506446a1d69082b12a38bd852481d7e19e17e32eaf04ccd7c55a138fb5d51aa7534b32c384319bd2932f5e37538acd9b32c61a6feef0b1434b04bd51151b438f448bd7d161df288e44fd8a8e7e6725fb3fe9293e705f48db7aa2aa03ccc3b082c61b0f20bd5a8bb6ef3088e53a98a987ba0923be12b53286e8c7cc5d805804f4985b115f804edb4fb5cd4c7b98896a6573156e4a32fdde45db1ddde2d3ceaa77f40dd89c8c5d9c2f818a83f635525be11cde13019e370521189dcafddc75cca681304e5b60f59f8b4c5097a24f66479b204795de6774372d750db30eb5d4ee67e6595c12690750d8611db64fac00b9949be7b930627c45ba2cd445ed245cc30a8cf80856a43aaf8265a6cde80a7b239796113dc33c36cea720f45585a37a3cfb41a12e360312aaf0e7ecf63b0a1180844b63b2ca096b9379452d94f2c3fb6019f1fa3f475300bc96fb7e38787f8005ebf67878af6957aeea058667848e041a2b5796637740b2388b5b8c3392b918c0eaa01364a7ec1d87c49d10bf1c0d5912f5704db9a5db550deec95daf093f89da5497f1efcd4bf8518135b7c669611e3ae0c4a4f96a2b54bc50c6014407fdc02cd7f534b744075ad46fce86c302f8ed06206d95ee1539ba72fb6824b837095b8b8e62ac2242e1018bc48b617bd93e1123a49603cac37ac3728b8f14df4269b3b5eb982fe6653781010e1fb93b567fa8db84c55c2ef37adfad38da523d4be61b4387734b854358a0ed61399b9d0f9c1290a47a4ba0aaae602f765965f73b7ba288945bb941a72d5417af726c934f597afd8141ab98ad649b2d19181fc5f124fd62d80b4cb814a76f900bb43949e78601b68338fcb26a2a0afde6f539300d7f440b95e2724a7815ce0f3af803a925911d74f8fad937260ff7650df06f7473646e6d616572646e650d0d6a626f302038326a626f203236310d650d2036626f646e39320d6a6f2030203c0d6a622f0d203c6570795461502f20
210d2065677261502f20746e65302030330d2052207365522f6372756f3c207365462f203c20746e6f2f203c3c3620304652203020203e3e206f72502f74655363302032203e2052202f0d203e746e6f4373746e652031332020522030203e3e0d646e650d0d6a626f302030336a626f20203c3c0d694b2f0d5b20736420393220205220302f0d205d6e756f432031207479542f0d2f206570656761502f0d2073657261503320746e203020333e0d2052650d203e626f646e31330d6a6f2030203c0d6a624c2f203c74676e65323320685220302069462f207265746c6c462f2044657461646f63653e3e206574730d206d61657289480a0d4ecd9185841030c3b0ef209fc1352a47f71d8a3f8ae5b40631731cd4154ab6f64075cae27e763dbc5ca04e5a9be4f5ac9d73f19d29640ad1466dea0004fe7d20809ee3d9c719642a44148cc74030a4d015584a0ab0f05f8f39c5e0eb5b5edb6f1c22c1e7d6f834f070df0b6a6160ddd03a39f50588346c2466a913bf8e7757102bc78bc701f741f6ee93c3a1fbf12f22af6875e03ca48f410b4a72a18278de56394640cdc1db889f780d204fb698334669f782e1ef7238c500f3435eeb87b00e3447a7106daba5c1ea2cd1eb174336bd6ea7fba2f47da356ce346a169a9511637ba64ca38aa336eb2e5a7b8b4958de97986c22d55e06c564b8c8c7d1b38ba7866b8b63e8298a60c08ae4c46ac62a4afd4aa4a6c2d80b4cde9be0d1fc382e1f77ca5fecbf91094719555693cbb3fdc7757eceaed799ee35006e650d02727473640d6d61656f646e65330d6a62203020320d6a626f20353133646e650d0d6a626f302033336a626f20203c3c0d694b2f0d5b207364302035203320522020302030205d20526f432f0d20746e752f0d20376570795461502f2020736567654d2f0d426169645b20786f3020302036393520323438200d205d200d203e3e6f646e65330d6a62203020340d6a626f2f0d205b476c6143207961722f203c3c74696857696f50655b20746e392e3020203530352e312031313938302f205d206d6d61472e30206138363432203e3e20650d5d0d626f646e35330d6a6f2030205b0d6a62432f0d2047526c613c3c204268572f2050657469746e696f30205b203035392e2031203538302e315d20313961472f2020616d6d2e30205b38363432322e30202038363434322e305d203836614d2f207869727430205b203633342e2e30203135323232302e30202039333138332e30302031353631372e2e302039313739302e30203131333431302e302039353036372e3020203134313e205d0d0d0d203e6e650d5d6a626f646572780d20300d660d203633303030303030303036203030353335350a0d6620303030303030303030203631303030300a0d6e20303030303130303030203032303030300a0d6e20303030303130303030203235303030300a0d6e20303030303230303030203734303030300a0d6e20303030303330303030203239303030300a0d6e20303030303530303030203730303030300a0d6e20303030303631303030203530303030300a0d6e20303030303831303030203737303030300a0d6e20303030303932303030203138303030300a0d6e20303030303233303030203036303030300a0d6e20303030303834303030203834303030300a0d6e20303030303834303030203037303030300a0d6e20303030303935303030203737303030300a0d6e20303030303236303030203935303030300a0d6e20303030303336303030203438303030300a0d6e20303030303837303030203136303030300a0d6e20303030303837303030203338303030300a0d6e20303030303038303030203830303030300a0d6e20303030303739303030203533303030300a0d6e20303030303739303030203735303030300a0d6e20303030303839303030203238303030300a0d6e20303030303831313030203634303030300a0d6e20303030303831313030203836303030300a0d6e20303030303931313030203339303030300a0d6e20303030303533313030203530303030300a0d6e20303030303533313030203732303030300a0d6e20303030303633313030203235303030300a0d6e20303030303335313030203635303030300a0d6e20303030303335313030203837303030300a0d6e20303030303535313030203430303030300a0d6e20303030303535313030203638303030300a0d6e20303030303935313030203937303030300a0d6e20303030303036313030203030303030300a0d6e20303030303036313030203939303030300a0d6e20303030303136313030203238303030300a0d6e20696172740d72656c2f0d3c3c657a69530d363320666e492f2031206f205220306f522f0d3320746f52203020492f0d20373c5b44363831323434613264643434623232373537613063303766353630333e3938373132373c613236383434343432376464613062323766353730336330383735360d5d3e39730d3e3e74726174666572783336310d250d3136464f45250000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077000000777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777700777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777000000000000000000ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33000000ff007777770000000000000000f1ff33007777f1f1777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777733007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300ddddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300dd00ff3300ddddff33dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300ddddff33003300ddddddddddffdddddddd6633ddddffffff9933ffffffffff9966ddddddffdddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd00ff3300ddddff33ff3300ddff996633ffffffffffffffffffffffffffffffffffffffffdd996633dddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd00dddddd3300ff33ff3300ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddddffffdddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddff3300ffffff3300ffffffffffffffffffffffffffffffffffffffffffffffff6633ffffdddddd99dddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddff3300ff00ff33003300ff33ffffffffffffffffffffffffffffffffffffffffffffffffddddddffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd33ddddddffff9966ffffffff00ff33003300ff33ff3300ff00ff3300ffffff33ffffffffffffffffffffffffff3300ff00ff33003300ff33ddddddff77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ff3300ffffff33ffffffff00ff33003300ff33ff3300ff00ff33003300ff33ffffffffddddddddddddddddff3300dd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ffffffffffff33ffffffffffffffffffffffffff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ddddddff77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd33ddddddffff9966ffffffff00ffffff3300ff33ffffffffffffffff3300ffffff3300ffffff3300ffffffff996633ffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ffffff3300ff33ffffffff00ffffff3300ff33ffffffffffffffffffffffffffffffffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddffffffffffffffff3300ffffff3300ff00ffffffffffff33ffffffffffffffffffffffffddddddffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddd6633ddddffffff99ffffffff3300ffffff3300ff00ff3300ffffff33ffffffffffffffff6633ffffdddddd99dddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddffffffddffffffffffffffffff3300ffffff3300ffffffffffffffffffffffffddddffffdddddddddddddddddddddddd
2Bdddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddddddddddff9966333300ffffff3300ffffff3300ffffffffffffffffdd996633dddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddffffffff33ff3300ffff9966ddddddffdddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddddddddddddddddddddddddddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f13300f1f1000000ff00777777000000000000000000ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33000000ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000001070000000500010209000000000001000000050001020100040000012e000000050006020900000000000000000004000101020000000f0011052175636f44746e656d6341206f61626f72004000740003004e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff000000030000000400000004ffffffff000000070000000000000b5e0000066800000e9000090001074803000001000000000621000400000103000000050008020b00000000000000000005003e020c0005006e0201000000ffffff00000005000002090004000001070000006500010b410000008800c600200020000000000020002000270000000000280000002000000020000100010000000000000000000000000000000000000000000000000000000000ffffffffffffff010000e00100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800100008001000080010000800300008003000080ffffffff0000000400010107000000050001020900050000020100000000000100000005ffff0201000500ff020900000000000000000004000301070000062100460b4100200066004f00020065006c007200500073006500300030000000310000000000000000000000000000000000000000000000000000000000000000000000000000000000020018ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000003a00000eca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020002000000000002000280027002000000020000000010000000000180000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077000000777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777700777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777000000000000000000ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33000000ff007777770000000000000000f1ff33007777f1f1777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777733007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300ddddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300dd00ff3300ddddff33dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ff3300ddddff33003300ddddddddddffdddddddd6633ddddffffff9933ffffffffff9966ddddddffdddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd00ff3300ddddff33ff3300ddff996633ffffffffffffffffffffffffffffffffffffffffdd996633dddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd00dddddd3300ff33ff3300ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffddddffffdddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddff3300ffffff3300ffffffffffffffffffffffffffffffffffffffffffffffff6633ffffdddddd99dddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddff3300ff00ff33003300ff33ffffffffffffffffffffffffffffffffffffffffffffffffddddddffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd33ddddddffff9966ffffffff00ff33003300ff33ff3300ff00ff3300ffffff33ffffffffffffffffffffffffff3300ff00ff33003300ff33ddddddff77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ff3300ffffff33ffffffff00ff33003300ff33ff3300ff00ff33003300ff33ffffffffddddddddddddddddff3300dd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ffffffffffff33ffffffffffffffffffffffffff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ddddddff77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddd33ddddddffff9966ffffffff00ffffff3300ff33ffffffffffffffff3300ffffff3300ffffff3300ffffffff996633ffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddffddddddffffffffffffffff00ffffff3300ff33ffffffff00ffffff3300ff33ffffffffffffffffffffffffffffffffdddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddffffddddffffffffffffffff3300ffffff3300ff00ffffffffffff33ffffffffffffffffffffffffddddddffdddddddddddddddddddddddd77dddddd33007777000000ff0077777700000000
2200000000f1ff3300ddddf1f1dddddddddddddddd6633ddddffffff99ffffffff3300ffffff3300ff00ff3300ffffff33ffffffffffffffff6633ffffdddddd99dddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddffffffddffffffffffffffffff3300ffffff3300ffffffffffffffffffffffffddddffffdddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddddddddddff9966333300ffffff3300ffffff3300ffffffffffffffffdd996633dddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddffffffff33ff3300ffff9966ddddddffdddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddd3300ddddddddddffddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1ddddddddddddddddddddddddddddddddddddddddddddddddff3300dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300ddddf1f1dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd77dddddd33007777000000ff007777770000000000000000f1ff3300f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f13300f1f1000000ff00777777000000000000000000ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33ff3300ff00ff33003300ff33000000ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000010700000005000102090000000000010000000500010201000a0000062600000009000f6e6f6349796c6e4f000500000209000000000000000000040001010200000014fff802fb000000000190000000000000000000005320534d20736e616972655300000066000000040000012d000000040006012e0000001300240a320010003700000004006e00006341003e61626f726f442074656d75630004746e012e00000024000106260000003e000f415c3a436968637220736f767020656472676f725c616d61626f644163415c6561626f722e34207463415c3061626f7263415c7461626f7278652e7400060065062600000002000f0003003000000000000000000000000000000000000000000800000000000000000000000d0cff0b000000360000002100000015000000160000000500000013000000460000019000000000000000600000006025cc000d000d000c0700000000000001002400400000080000000d73000004c600040000000000000000000000000000000000000000000008006c6100000000000001e4000001700000000400000035000000110000000000000000000001900100000002010203007500540067006e00000061000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12w_importacion_documentos.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
