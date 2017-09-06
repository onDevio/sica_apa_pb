HA$PBExportHeader$w_sellador_importar_documentos.srw
forward
global type w_sellador_importar_documentos from w_response
end type
type tv_lista_carpetas from u_tvs within w_sellador_importar_documentos
end type
type lv_1 from u_lv within w_sellador_importar_documentos
end type
type dw_documentos from u_dw within w_sellador_importar_documentos
end type
type lb_1 from listbox within w_sellador_importar_documentos
end type
type cb_2 from commandbutton within w_sellador_importar_documentos
end type
type cb_1 from commandbutton within w_sellador_importar_documentos
end type
type st_3 from statictext within w_sellador_importar_documentos
end type
type st_1 from statictext within w_sellador_importar_documentos
end type
type st_2 from statictext within w_sellador_importar_documentos
end type
type gb_1 from groupbox within w_sellador_importar_documentos
end type
type st_5 from multilineedit within w_sellador_importar_documentos
end type
type dw_paquetes from u_dw within w_sellador_importar_documentos
end type
type gb_2 from groupbox within w_sellador_importar_documentos
end type
end forward

global type w_sellador_importar_documentos from w_response
integer width = 2889
integer height = 1872
string title = "Importaci$$HEX1$$f300$$ENDHEX$$n de documentos"
event csd_visualizar_carpetas ( )
event csd_controla_marcados ( )
event csd_refrescar_lv ( )
event type string csd_comprobar_fichero_existe ( string id_fase,  string nombre_fichero )
tv_lista_carpetas tv_lista_carpetas
lv_1 lv_1
dw_documentos dw_documentos
lb_1 lb_1
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_1 st_1
st_2 st_2
gb_1 gb_1
st_5 st_5
dw_paquetes dw_paquetes
gb_2 gb_2
end type
global w_sellador_importar_documentos w_sellador_importar_documentos

type variables
oleobject i_zip
n_cst_filesrvwin32 dire

string i_fichero,i_archivo,i_opcion_importacion, i_paquete
string i_directorio

boolean i_importacion=false
string directorio

//Para revisar las firmas de los pdf
u_revision_firmas revisor
string i_documentos_mal

string i_id_fase

st_visared_importacion ist_documentos_importados
end variables

forward prototypes
public subroutine f_visared_revisar_firmas (string fichero_pdf)
end prototypes

event csd_visualizar_carpetas();long raiz

tv_lista_carpetas.SetRedraw(false)
tv_lista_carpetas.CheckBoxes = false

tv_lista_carpetas.InsertItemLast(0,'Carpetas',1)
tv_lista_carpetas.InsertItemLast(1,'Bandeja de Entrada',2)
tv_lista_carpetas.InsertItemLast(1,'Elementos Procesados',2)

tv_lista_carpetas.ExpandItem(1)
tv_lista_carpetas.selectitem(2)

tv_lista_carpetas.SetRedraw(true)
end event

event csd_controla_marcados();int fila,i

fila = int(Message.LongParm)

listviewitem lvi
for i=1 to lv_1.TotalItems ( )
	if i = fila then 
		lv_1.GetItem(i, lvi)
		lvi.StatePictureIndex = 2
		lvi.selected = true
		lv_1.SetItem(i , lvi)
		continue
	end if
	lv_1.GetItem(i, lvi)
	if lvi.StatePictureIndex = 2 then lvi.StatePictureIndex = 1
	lvi.selected = false
	lv_1.SetItem(i , lvi)
next
end event

event csd_refrescar_lv();int i
string etiqueta

lv_1.deletesmallpictures()
lv_1.addsmallpicture(g_directorio_imagenes+"zip.ico")

for i=1 to lb_1.TotalItems ()
	lb_1.selectitem(i)
	lv_1.additem(lb_1.selecteditem(),1)
next
end event

event type string csd_comprobar_fichero_existe(string id_fase, string nombre_fichero);//Comprueba si un fichero existe y lo renombra para que no se sobreescriba.
//Modifica en la ventana de detalle de fase los documentos para que aparezca el nuevo nombre

string fichero
string nombre_fichero_corto, nombre_fichero_nuevo
int i, j

nombre_fichero_nuevo = nombre_fichero

nombre_fichero_corto = MidA(nombre_fichero, 1 , LenA(nombre_fichero) - 4)

fichero =  f_visared_ruta_documentos(id_fase,nombre_fichero_corto,0)

i = 1
if fileexists(f_visared_ruta_documentos(id_fase,nombre_fichero,0)) then
	do while fileexists(fichero + "_copia" + string(i) + ".pdf")
		i++
	loop
	nombre_fichero_nuevo = nombre_fichero_corto + "_copia" + string(i) + ".pdf"
end if

//Ya tenemos el nuevo nombre, hay que cambiarlo en el datawindow de documentos
datastore ds_documentos_visared
ds_documentos_visared = create datastore
ds_documentos_visared.dataobject = 'd_fases_documentos_visared'
ds_documentos_visared.SetTransObject(SQLCA)
ds_documentos_visared.retrieve(id_fase)

/*	Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 20/12/05
	Lo sacamos fuera ya que aki puede darse el caso que no siempre encuentre el 
	fichero correcto y donde se llama ya lo tenemos todo
*/
	
////Empezamos desde el final hacia el principio
//for j = ds_documentos_visared.rowcount() to 1 step -1
//	if ds_documentos_visared.getitemstring(j,'nombre_fichero') = nombre_fichero then
//		ds_documentos_visared.setitem(j,'nombre_fichero',nombre_fichero_nuevo)
//		exit
//	end if 
//next
//
//ds_documentos_visared.update() 
//

/*	Fin comentado Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 20/12/05	*/

//Devolvemos la ruta nueva
return nombre_fichero_nuevo
end event

public subroutine f_visared_revisar_firmas (string fichero_pdf);// FUNCION DE REVISION DE FIRMAS REESCRITA. ELOY 06/10/2008

int i
int fila, fila_inc, num_firmas, num_revisiones
string firmantes
double tamano
date fecha
time hora
string incidencia
boolean firma_valida
boolean certificados_validos = true
boolean revisar_firma,revisar_cert
st_eimporta_validacion_certificado lst_validacion

revisor=create u_revision_firmas

firma_valida = true

fila = dw_documentos.event pfc_addrow()

//Ponemos el id, el nombre del fichero
dw_documentos.setitem(fila,'id_fichero',string(fila))
dw_documentos.setitem(fila,'documento',fichero_pdf)


//Leemos el tama$$HEX1$$f100$$ENDHEX$$o y lo pasamos a Kb
tamano = Ceiling(gnv_fichero.of_GetFileSize(g_directorio_temporal + fichero_pdf) / 1024)

// Obtenemos la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
gnv_fichero.of_GetLastWriteDateTime(g_directorio_temporal + fichero_pdf, fecha, hora)
		
//Comprobamos el tama$$HEX1$$f100$$ENDHEX$$o del documento para invalidarlo en caso de que sea 0
if tamano > 0 then
	dw_documentos.setitem(fila,'descargar','S')
	dw_documentos.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
	dw_documentos.setitem(fila,'fecha',datetime(fecha, hora))
else
	dw_documentos.setitem(fila,'descargar','N')
	dw_documentos.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
	dw_documentos.setitem(fila,'fecha',datetime(fecha, hora))
	dw_documentos.setitem(fila,'firmado','R')
	dw_documentos.setitem(fila,'certificado_valido','NR')
		
	if i_documentos_mal = '' then
		i_documentos_mal = "'" + string(fila) + "'"
	else
		i_documentos_mal += ", '" + string(fila) + "'"
	end if
	n_cst_color colores
	f_dw_resaltar_fila(dw_documentos, 'id_fichero',i_documentos_mal,colores.red)

	//Ni revisamos las firmas
	return
end if

revisar_firma=(g_revisar_firmas='S')
revisar_cert= (g_revisar_certificados='S')

lst_validacion=revisor.of_revisar_fichero(g_directorio_temporal + fichero_pdf,revisar_firma,revisar_cert)

dw_documentos.setitem(fila,'firmado',lst_validacion.firma_valida)
dw_documentos.setitem(fila,'certificado_valido',lst_validacion.certificado_valido)
dw_documentos.setitem(fila,'numero_firmas',lst_validacion.num_firmas)
dw_documentos.setitem(fila,'firmantes',lst_validacion.firmantes)
st_5.text=revisor.of_devolver_error(lst_validacion)





/*int i
int fila, fila_inc, num_firmas
string firmantes
double tamano
date fecha
time hora
string incidencia
boolean firma_valida
boolean certificados_validos = true

firma_valida = true

fila = dw_documentos.event pfc_addrow()

//Ponemos el id, el nombre del fichero
dw_documentos.setitem(fila,'id_fichero',string(fila))
dw_documentos.setitem(fila,'documento',fichero_pdf)

if upper(RightA(fichero_pdf,3))='PDF' then

	//Leemos el tama$$HEX1$$f100$$ENDHEX$$o y lo pasamos a Kb
	tamano = Ceiling(dire.of_GetFileSize(g_directorio_temporal + fichero_pdf) / 1024)
	
	dire.of_GetLastWriteDateTime(g_directorio_temporal + fichero_pdf, fecha, hora)
			
	//Comprobamos el tama$$HEX1$$f100$$ENDHEX$$o del documento para invalidarlo en caso de que sea 0
	if tamano > 0 then
		dw_documentos.setitem(fila,'descargar','S')
		dw_documentos.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
		dw_documentos.setitem(fila,'fecha',datetime(fecha, hora))
	else
		dw_documentos.setitem(fila,'descargar','N')
		dw_documentos.setitem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')
		dw_documentos.setitem(fila,'fecha',datetime(fecha, hora))
		dw_documentos.setitem(fila,'firmado','R')
		dw_documentos.setitem(fila,'certificado_valido','NR')
		
		if i_documentos_mal = '' then
			i_documentos_mal = "'" + string(fila) + "'"
		else
			i_documentos_mal += ", '" + string(fila) + "'"
		end if
		n_cst_color colores
		f_dw_resaltar_fila(dw_documentos, 'id_fichero',i_documentos_mal,colores.red)
		return
	end if
	
	if g_revisar_firmas = 'S' then
		//Comprobamos las firmas
		revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
		revisor.is_nombre_fichero_ini = g_directorio_temporal + LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
		if g_revisar_certificados = 'S' then
			revisor.of_leer_certificado(true)
		else
			revisor.of_leer_certificado(false)
		end if
		
		firmantes = ''
		num_firmas = revisor.ii_num_firmas
		//A$$HEX1$$f100$$ENDHEX$$adimos los firmantes y comprobamos la validez de todas las firmas
		for i = 1 to num_firmas
			if firmantes = '' then
				firmantes = revisor.is_cn_certificado[i]
			else
				firmantes += cr + revisor.is_cn_certificado[i]
			end if
			if revisor.ib_certificado_valido[i] = false or revisor.is_error_firma[i] = '-2' or revisor.is_error_firma[i] = '-4' then 
				certificados_validos = false
			end if
		next
		
		//Comprobamos la validez de las firmas
		for i = 1 to num_firmas
			if revisor.ib_firma_valida[i] = false or revisor.is_error_firma[i] = '-3' then
				firma_valida = false
			end if
		next
	
		//Segun la combinacion, el estado del documento varia
		// N - No firmado
		if num_firmas = 0 then 
			dw_documentos.setitem(fila,'firmado','N')
		end if
		// V - Firmado la ultima firma Valida (es la que engloba todo el documento)
		if num_firmas > 0 and firma_valida = true then 
			dw_documentos.setitem(fila,'firmado','V')
		end if
		// F - Firmado pero la ultima firma Valida no es valida
		if num_firmas > 0 and firma_valida = false then 
			dw_documentos.setitem(fila,'firmado','F')
		end if
		// E - Error validando la firma
		if num_firmas < 0 then 
			dw_documentos.setitem(fila,'firmado','E')
			num_firmas = 0
		end if	
		
		//Segun el certificado, lo guardamos.
		if g_revisar_certificados = 'S' and certificados_validos = true then
			dw_documentos.setitem(fila,'certificado_valido','CV')
		end if
		
		if g_revisar_certificados = 'S' and (certificados_validos = false or num_firmas = 0) then
			dw_documentos.setitem(fila,'certificado_valido','NV')
		end if
		
		if g_revisar_certificados = 'N' then
			dw_documentos.setitem(fila,'certificado_valido','NR')
		end if
	
		dw_documentos.setitem(fila,'numero_firmas',num_firmas)
		dw_documentos.setitem(fila,'firmantes',firmantes)
	else
		num_firmas = 0
		firmantes = ''
		dw_documentos.setitem(fila,'descargar','S')
		dw_documentos.setitem(fila,'firmado','R')
		dw_documentos.setitem(fila,'certificado_valido','NR')
	end if
else
	num_firmas = 0
	firmantes = ''
	dw_documentos.setitem(fila,'descargar','S')
	dw_documentos.setitem(fila,'firmado','Z')
	dw_documentos.setitem(fila,'certificado_valido','ZZ')
end if

*/
end subroutine

event open;call super::open;i_id_fase = Message.stringParm

f_centrar_ventana(this)

//Si tenemos la revision de firmas activa ponemos un dw, sino ponemos el otro
if g_activar_revision_firmas = 'N' then
	dw_documentos.dataobject = 'd_eimporta_lista_documentos'
	dw_documentos.settrans(sqlca)
end if

i_zip = create oleobject
dire = create n_cst_filesrvwin32

lv_1.deleteitems()
lb_1.reset()
lb_1.DirList(g_directorio_importacion + '*.zip', 0)
f_cambiar_directorio_activo(g_dir_aplicacion) // Restauramos el directorio base de la aplicaci$$HEX1$$f300$$ENDHEX$$n que puede haber cambiado tras la llamada a DirList

this.event csd_visualizar_carpetas()
end event

on w_sellador_importar_documentos.create
int iCurrent
call super::create
this.tv_lista_carpetas=create tv_lista_carpetas
this.lv_1=create lv_1
this.dw_documentos=create dw_documentos
this.lb_1=create lb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.st_5=create st_5
this.dw_paquetes=create dw_paquetes
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_lista_carpetas
this.Control[iCurrent+2]=this.lv_1
this.Control[iCurrent+3]=this.dw_documentos
this.Control[iCurrent+4]=this.lb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.dw_paquetes
this.Control[iCurrent+13]=this.gb_2
end on

on w_sellador_importar_documentos.destroy
call super::destroy
destroy(this.tv_lista_carpetas)
destroy(this.lv_1)
destroy(this.dw_documentos)
destroy(this.lb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.st_5)
destroy(this.dw_paquetes)
destroy(this.gb_2)
end on

event close;call super::close;// Borramos el contenido del directorio temporal por los ficheros que se hayan extraido en el
dire.of_deltree(g_directorio_temporal)
dire.of_CreateDirectory(g_directorio_temporal)

destroy dire
destroy i_zip 

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_sellador_importar_documentos
integer x = 1152
integer y = 944
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_sellador_importar_documentos
end type

type tv_lista_carpetas from u_tvs within w_sellador_importar_documentos
integer x = 82
integer y = 108
integer width = 832
integer height = 656
integer taborder = 10
boolean bringtotop = true
string picturename[] = {"Custom039!","VCRNext!"}
end type

event selectionchanged;call super::selectionchanged;if newhandle = 2 then
	lv_1.deleteitems()
	lb_1.reset()
	dw_documentos.reset()
	dw_documentos.object.documento_t.text = 'Documentos'
	lb_1.DirList(g_directorio_importacion + '*.zip', 0)
	directorio = g_directorio_importacion
	parent.postevent ('csd_refrescar_lv')
	dw_paquetes.event csd_refrescar_paquetes(1)
end if

if newhandle = 3 then
	lv_1.deleteitems()
	lb_1.reset()
	dw_documentos.reset()
	dw_documentos.object.documento_t.text = 'Documentos'
	lb_1.DirList(g_directorio_importados + '*.zip', 0)
	directorio = g_directorio_importados
	parent.postevent ('csd_refrescar_lv')
	dw_paquetes.event csd_refrescar_paquetes(2)	
end if
end event

type lv_1 from u_lv within w_sellador_importar_documentos
boolean visible = false
integer x = 937
integer y = 108
integer width = 1682
integer height = 656
integer taborder = 20
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
boolean showheader = false
boolean checkboxes = true
boolean oneclickactivate = true
listviewview view = listviewlist!
string smallpicturename[] = {""}
string statepicturename[] = {"",""}
boolean ib_rmbmenu = false
end type

event clicked;call super::clicked;boolean hay_ini,hay_exp,hay_fase,caracteres_no_validos
long i,valor
int retorno1,cuantos
string fichero,n_registro_importado,n_expedi_importado,n_reg,n_exp,id_fase
string opcion_visared, comentario_visared
int cuantos_ficheros

cb_1.enabled=false
revisor = create u_revision_firmas

// Borramos el contenido del directorio temporal para extraer los ficheros
valor=dire.of_deltree(g_directorio_temporal)
valor=dire.of_CreateDirectory(g_directorio_temporal)

// Extraemos los ficheros
lv_1.GetItem ( index, 1, i_fichero )
dw_documentos.reset()
dw_documentos.object.documento_t.text = 'Documentos'
i_documentos_mal = ''
f_dw_resaltar_fila(dw_documentos, '','0',0)
dw_documentos.setredraw(false)

if index=-1 then
	//Desactivar botones
	parent.Postevent('csd_controla_marcados',index,index)
	return
end if

//Activar botones

fichero = directorio + i_fichero
if not FileExists(fichero) then 
	parent.Postevent('csd_controla_marcados',index,index)
	return 1
end if
i_paquete = i_fichero
retorno1 = i_zip.ConnectToNewObject("SAWZip.Archive")

//i_zip.of_capturar_errores(true) // Evita que la aplicaci$$HEX1$$f300$$ENDHEX$$n pete si el zip est$$HEX2$$e1002000$$ENDHEX$$corrupto
i_zip.Open(fichero) 
//if i_zip.i_resultcode <> 0 then
//	st_5.text = "Error al abrir el zip. Es posible que el archivo est$$HEX2$$e9002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado."
//	return
//end if
//i_zip.of_capturar_errores(false)



hay_ini=false
i_archivo=''

cuantos_ficheros = i_zip.files.count
st_5.Alignment = Center!
SetPointer(HourGlass!)

for i = 1 to i_zip.files.count
	st_5.text = 'Extrayendo fichero ' + string(i) + ' de ' + string(cuantos_ficheros)
	i_zip.Files.Item(i -1).extract(g_directorio_temporal)
	//Le quitamos los atributos al fichero por si acaso tenia alguno
	valor = dire.of_setfileattributes(i_zip.Files.Item(i -1).name, false,false,false,false)	
	if Not(f_parsea_fichero(i_zip.Files.Item(i -1).name)) then
		caracteres_no_validos=true
	end if
	f_visared_revisar_firmas(i_zip.Files.Item(i -1).name)		
next
i_zip.close()
destroy revisor
SetPointer(Arrow!)
st_5.Alignment = Left!
dw_documentos.object.documento_t.text = 'Documentos ('+ string(dw_documentos.rowcount()) + ')'

dw_documentos.setredraw(true)

if caracteres_no_validos then 
	st_5.text='El zip contiene ficheros con caracteres no validos'
	MessageBox("Caracteres NO validos","El zip contiene ficheros con caracteres no validos",StopSign!)
else
	st_5.text='Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'
	cb_1.enabled=true
end if

parent.Postevent('csd_controla_marcados',index,index)
end event

type dw_documentos from u_dw within w_sellador_importar_documentos
event csd_revisar_todos ( )
event csd_revisar_fichero ( )
event csd_abrir_pdf ( )
integer x = 82
integer y = 844
integer width = 2720
integer height = 684
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_eimporta_lista_documentos_firmas"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_revisar_todos();string fichero_pdf,mensaje,texto_error
st_eimporta_validacion_certificado lst_validacion
long i

revisor=create u_revision_firmas

texto_error=''

for i = 1 to dw_documentos.rowcount()
	st_5.text = 'Revisando documento ' + string(i) + ' de ' + string(dw_documentos.rowcount())
	fichero_pdf = dw_documentos.getitemstring(i,'documento')
	
	lst_validacion=revisor.of_revisar_fichero(g_directorio_temporal + fichero_pdf,true,true)
	
	dw_documentos.setitem(i,'firmado',lst_validacion.firma_valida)
	dw_documentos.setitem(i,'certificado_valido',lst_validacion.certificado_valido)
	texto_error+='('+string(i)+') '+revisor.of_devolver_error(lst_validacion)
next

st_5.text=texto_error





/*int i,j,k
int num_firmas
string firmantes
boolean firma_valida
boolean certificados_validos = true
string fichero_pdf
string texto_ant

revisor = create u_revision_firmas

texto_ant = st_5.text
st_5.Alignment = Center!

for i = 1 to dw_documentos.rowcount()

	firma_valida = true
	fichero_pdf = dw_documentos.getitemstring(i,'documento')
	st_5.text = 'Revisando documento ' + string(i) + ' de ' + string(dw_documentos.rowcount())

	firmantes = ''
	num_firmas = 0
	
	if upper(RightA(fichero_pdf,3))='PDF' then
			//Comprobamos las firmas
			revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
			revisor.is_nombre_fichero_ini = g_directorio_temporal + LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
			revisor.of_leer_certificado(true)
	
			num_firmas = revisor.ii_num_firmas
			//A$$HEX1$$f100$$ENDHEX$$adimos los firmantes y comprobamos la validez de todas las firmas
			for j = 1 to num_firmas
				if firmantes = '' then
					firmantes = revisor.is_cn_certificado[j]
				else
					firmantes += cr + revisor.is_cn_certificado[j]
				end if
				if revisor.ib_certificado_valido[j] = false or revisor.is_error_firma[j] = '-2' or revisor.is_error_firma[j] = '-4' then 
					certificados_validos = false
				end if
			next
			
			//Comprobamos la validez de las firmas
			for k = 1 to num_firmas
				if revisor.ib_firma_valida[k] = false or revisor.is_error_firma[k] = '-3' then
					firma_valida = false
				end if
			next
		
			//Segun la combinacion, el estado del documento varia
			// N - No firmado
			if num_firmas = 0 then 
				dw_documentos.setitem(i,'firmado','N')
			end if
			// V - Firmado la ultima firma Valida (es la que engloba todo el documento)
			if num_firmas > 0 and firma_valida = true then 
				dw_documentos.setitem(i,'firmado','V')
			end if
			// F - Firmado pero la ultima firma Valida no es valida
			if num_firmas > 0 and firma_valida = false then 
				dw_documentos.setitem(i,'firmado','F')
			end if
			// E - Error validando la firma
			if num_firmas < 0 then 
				dw_documentos.setitem(i,'firmado','E')
				num_firmas = 0
			end if	
			
			//Segun el certificado, lo guardamos.
			if certificados_validos = true then
				dw_documentos.setitem(i,'certificado_valido','CV')
			end if
			
			if certificados_validos = false or num_firmas = 0 then
				dw_documentos.setitem(i,'certificado_valido','NV')
			end if
			
			dw_documentos.setitem(i,'numero_firmas',num_firmas)
			dw_documentos.setitem(i,'firmantes',firmantes)
	else
		num_firmas = 0
		firmantes = ''
		dw_documentos.setitem(i,'descargar','S')
		dw_documentos.setitem(i,'firmado','Z')
		dw_documentos.setitem(i,'certificado_valido','ZZ')
	end if
next

st_5.Alignment = Left!
st_5.text = texto_ant

destroy revisor*/
end event

event csd_revisar_fichero();string fichero_pdf
st_eimporta_validacion_certificado lst_validacion
integer i

revisor=create u_revision_firmas

fichero_pdf = dw_documentos.getitemstring(dw_documentos.getrow(),'documento')

lst_validacion=revisor.of_revisar_fichero(g_directorio_temporal + fichero_pdf,true,true)

i = dw_documentos.getselectedrow(0)

dw_documentos.setitem(i,'firmado',lst_validacion.firma_valida)
dw_documentos.setitem(i,'certificado_valido',lst_validacion.certificado_valido)

st_5.text=revisor.of_devolver_error(lst_validacion)


/*
int i,j,k
int num_firmas
string firmantes
boolean firma_valida
boolean certificados_validos = true
string fichero_pdf

revisor = create u_revision_firmas
firma_valida = true
i = dw_documentos.getselectedrow(0)

fichero_pdf = dw_documentos.getitemstring(i,'documento')

if upper(RightA(fichero_pdf,3))='PDF' then
	//Comprobamos las firmas
	revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
	revisor.is_nombre_fichero_ini = g_directorio_temporal + LeftA(fichero_pdf,LenA(fichero_pdf) - 4) + ".ini"
	revisor.of_leer_certificado(true)

	firmantes = ''
	num_firmas = revisor.ii_num_firmas
	//A$$HEX1$$f100$$ENDHEX$$adimos los firmantes y comprobamos la validez de todas las firmas
	for j = 1 to num_firmas
		if firmantes = '' then
			firmantes = revisor.is_cn_certificado[j]
		else
			firmantes += cr + revisor.is_cn_certificado[j]
		end if
		if revisor.ib_certificado_valido[j] = false or revisor.is_error_firma[j] = '-2' or revisor.is_error_firma[j] = '-4' then 
			certificados_validos = false
		end if
	next
			
	//Comprobamos la validez de las firmas
	for k = 1 to num_firmas
		if revisor.ib_firma_valida[k] = false or revisor.is_error_firma[k] = '-3' then
			firma_valida = false
		end if
	next
		
	//Segun la combinacion, el estado del documento varia
	// N - No firmado
	if num_firmas = 0 then 
		dw_documentos.setitem(i,'firmado','N')
	end if
	// V - Firmado la ultima firma Valida (es la que engloba todo el documento)
	if num_firmas > 0 and firma_valida = true then 
		dw_documentos.setitem(i,'firmado','V')
	end if
	// F - Firmado pero la ultima firma Valida no es valida
	if num_firmas > 0 and firma_valida = false then 
		dw_documentos.setitem(i,'firmado','F')
	end if
	// E - Error validando la firma
	if num_firmas < 0 then 
		dw_documentos.setitem(i,'firmado','E')
		num_firmas = 0
	end if	
	
	//Segun el certificado, lo guardamos.
	if certificados_validos = true then
		dw_documentos.setitem(i,'certificado_valido','CV')
	end if
	
	if certificados_validos = false or num_firmas = 0 then
		dw_documentos.setitem(i,'certificado_valido','NV')
	end if
		
	dw_documentos.setitem(i,'numero_firmas',num_firmas)
	dw_documentos.setitem(i,'firmantes',firmantes)
end if

destroy revisor*/
end event

event csd_abrir_pdf();int fila
int retorno1
string archivo, ext, a

fila = this.getselectedrow(0)

archivo = this.getitemstring(fila,'documento')
ext=RightA(archivo,4)
archivo=g_directorio_temporal + archivo
if ext = ".pdf" OR ext = ".PDF" then
	f_abrir_fichero(g_directorio_temporal, archivo, "")
	//f_abrir_pdf(archivo)
end if
end event

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)

//Ponemos las imagenes del datawindows
dw_documentos.object.p_1.Filename = g_directorio_imagenes + "v.gif"
dw_documentos.object.p_2.Filename = g_directorio_imagenes + "x.gif"
dw_documentos.object.p_3.Filename = g_directorio_imagenes + "i.gif"
dw_documentos.object.p_4.Filename = g_directorio_imagenes + "v.gif"
dw_documentos.object.p_5.Filename = g_directorio_imagenes + "x.gif"
dw_documentos.object.p_6.Filename = g_directorio_imagenes + "i.gif"
end event

event doubleclicked;call super::doubleclicked;event csd_abrir_pdf()
end event

event rbuttonup;call super::rbuttonup;m_eimporta_dw_firmas menu

if this.getrow() <= 0 or g_activar_revision_firmas = 'N' then return

this.selectrow(0, false)
this.selectrow(row,true)

menu = create m_eimporta_dw_firmas
menu.idw_padre = this

menu.PopMenu(w_aplic_frame.PointerX() + 5, w_aplic_frame.PointerY() + 10)

end event

type lb_1 from listbox within w_sellador_importar_documentos
boolean visible = false
integer x = 2281
integer y = 1240
integer width = 178
integer height = 148
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 50331647
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_sellador_importar_documentos
integer x = 2299
integer y = 1668
integer width = 357
integer height = 92
integer taborder = 40
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

type cb_1 from commandbutton within w_sellador_importar_documentos
integer x = 2299
integer y = 1568
integer width = 357
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Importar"
end type

event clicked;string fichero,archivo
int i,fila,cuantos_ficheros
listviewitem item
string tamano, firmado, certificado
datastore ds_documentos_visared
string fichero_orig,fichero_dst, fichero_temp
boolean copia_correcta
string ruta_base

copia_correcta = true

ds_documentos_visared = create datastore
ds_documentos_visared.dataobject = 'd_fases_documentos_visared'
ds_documentos_visared.settransobject(SQLCA)

//Comprobamos si existe la carpeta del a$$HEX1$$f100$$ENDHEX$$o. Si no hay que crearla...
ruta_base=f_obtener_ruta_base(g_anyo_numeracion)
if not dire.of_directoryexists(ruta_base + g_anyo_numeracion ) then
	dire.of_createdirectory(ruta_base + g_anyo_numeracion )
end if

//Cargamos los datos de los ficheros en el datastore	
for i = 1 to dw_documentos.rowcount()
	archivo = dw_documentos.getitemstring(i,'documento')
	tamano = dw_documentos.getitemstring(i,'tamano')
	firmado = dw_documentos.getitemstring(i,'firmado')
	certificado = dw_documentos.getitemstring(i,'certificado_valido')
	if upper(RightA(archivo,3))='INI' or upper(RightA(archivo,3))='EXP' then continue
	//Hemos seleccionado no descargar este fichero
	if dw_documentos.getitemstring(i,'descargar') = 'N' then continue

	fila = ds_documentos_visared.insertrow(0)
	ds_documentos_visared.SetItem(fila,'id_fase',i_id_fase)
	ds_documentos_visared.SetItem(fila,'ruta_fichero',f_visared_ruta_documentos(i_id_fase,'',2))
	ds_documentos_visared.setitem(fila,'visualizar_web','N')	
	ds_documentos_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
	ds_documentos_visared.setitem(fila, 'nombre_fichero', archivo)
	ds_documentos_visared.setitem(fila, 'sellado', 'N')
	ds_documentos_visared.setitem(fila, 'fecha', today())
	ds_documentos_visared.setitem(fila,'visualizar_web','N')
	ds_documentos_visared.setitem(fila,'tamano',tamano)
	ds_documentos_visared.setitem(fila,'firmado',firmado)
	ds_documentos_visared.setitem(fila,'certificado_confianza',certificado)		
next

//Guardamos los datos
ds_documentos_visared.update()

// Crear directorio del registro si no existe	
dire.of_createdirectory(f_visared_ruta_documentos(i_id_fase,'',1))

cuantos_ficheros = ds_documentos_visared.rowcount()
st_5.Alignment = Center!

//Copiamos los ficheros fisicamente
for i= 1 to ds_documentos_visared.rowcount()
	st_5.text = 'Importando fichero ' + string(i) + ' de ' + string(cuantos_ficheros)
	fichero_orig = g_directorio_temporal + ds_documentos_visared.getitemstring(i, 'nombre_fichero')
	fichero_temp = event csd_comprobar_fichero_existe(i_id_fase,ds_documentos_visared.getitemstring(i, 'nombre_fichero'))

	/*	Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 20/12/05
		como he comentado las l$$HEX1$$ed00$$ENDHEX$$neas donde se guardaba en el la funci$$HEX1$$f300$$ENDHEX$$n csd_comprobar_fichero_existe
		tenemos que poner el nombre aki
	*/
	ds_documentos_visared.setitem(i,'nombre_fichero',fichero_temp)
	
	fichero_dst = f_visared_ruta_documentos(i_id_fase,fichero_temp,0)
	dire.of_filecopy(fichero_orig, fichero_dst) // Copiando no tenemos problemas de que el archivo este en uso mientras se previsualiza
next

ds_documentos_visared.update()

/*	Fin Juan Miguel Cebell$$HEX1$$e100$$ENDHEX$$n 20/12/05	*/

//Comprobamos que esta bien copiado
for i = 1 to ds_documentos_visared.rowcount()
	fichero_orig = ds_documentos_visared.getitemstring(i, 'nombre_fichero')
	fichero_orig = f_visared_ruta_documentos(i_id_fase,fichero_orig,0)
	if not fileexists(fichero_orig) then 
		copia_correcta = false
		exit
	end if
next

st_5.Alignment = Left!
st_5.text = 'Importaci$$HEX1$$f300$$ENDHEX$$n finalizada'
		
if copia_correcta = true then
	messagebox('','Fichero/s importado/s correctamente.')
	//Movemos el paquete a la carpeta importados
	f_bloqueo_fichero(fichero_orig,false)
	fichero_orig = g_directorio_importacion + i_paquete
	fichero_dst = g_directorio_importados + i_paquete

	dire.of_filerename(fichero_orig, fichero_dst)	
	close(parent)
else
	messagebox('','Se han producido errores, existen documentos que no se han importado correctamente')
end if

destroy ds_documentos_visared
end event

type st_3 from statictext within w_sellador_importar_documentos
integer x = 96
integer y = 780
integer width = 1170
integer height = 52
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

type st_1 from statictext within w_sellador_importar_documentos
integer x = 96
integer y = 52
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Carpetas"
boolean focusrectangle = false
end type

type st_2 from statictext within w_sellador_importar_documentos
integer x = 946
integer y = 52
integer width = 453
integer height = 56
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

type gb_1 from groupbox within w_sellador_importar_documentos
integer x = 41
integer y = 16
integer width = 2811
integer height = 1536
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_5 from multilineedit within w_sellador_importar_documentos
integer x = 55
integer y = 1580
integer width = 2194
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Seleccione el paquete comprimido que desee importar."
boolean border = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_paquetes from u_dw within w_sellador_importar_documentos
event csd_refrescar_paquetes ( integer carpeta_selec )
integer x = 937
integer y = 108
integer width = 1856
integer height = 652
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_eimporta_lista_paquetes"
boolean ib_isupdateable = false
end type

event csd_refrescar_paquetes(integer carpeta_selec);if carpeta_selec=1 then
	i_directorio = g_directorio_importacion
elseif carpeta_selec=2 then
	i_directorio = g_directorio_importados	
end if

lb_1.DirList(i_directorio + '*.zip', 0)
f_cambiar_directorio_activo(g_dir_aplicacion) // Restauramos el directorio base de la aplicaci$$HEX1$$f300$$ENDHEX$$n que puede haber cambiado tras la llamada a DirList


int i
string archivo
double tamano
date fecha
time hora

//this.setredraw(false)

this.reset()

for i=1 to lb_1.TotalItems ()
	lb_1.selectitem(i)
	
	archivo = lb_1.selecteditem()
	
	//Leemos el tama$$HEX1$$f100$$ENDHEX$$o y lo pasamos a Kb
	tamano = Ceiling(gnv_fichero.of_GetFileSize(i_directorio + archivo) / 1024)
	
	gnv_fichero.of_GetLastWriteDateTime(i_directorio + archivo, fecha, hora)
	
	this.insertrow(0)
	this.setitem(i, 'archivo', archivo)
	this.setitem(i, 'tamano', string(tamano,"#,###,##0") + ' Kb')
	this.setitem(i, 'fecha', datetime(fecha, hora))
next

this.object.fecha_t.text = 'Fecha modificaci$$HEX1$$f300$$ENDHEX$$n'

this.sort()
this.selectrow(0, false)
this.selectrow(this.getrow(), true)

this.setredraw(true)
end event

event clicked;call super::clicked;boolean hay_ini,hay_exp,hay_fase,caracteres_no_validos
long i,valor
int retorno1,cuantos
string fichero,n_registro_importado,n_expedi_importado,n_reg,n_exp,id_fase
string opcion_visared, comentario_visared
int cuantos_ficheros

cb_1.enabled=false
revisor = create u_revision_firmas

// Borramos el contenido del directorio temporal para extraer los ficheros
valor=dire.of_deltree(g_directorio_temporal)
valor=dire.of_CreateDirectory(g_directorio_temporal)

// Extraemos los ficheros
if row<=0 then
	//Desactivar botones
	return
end if
i_fichero=dw_paquetes.GetItemString(row,'archivo')
dw_documentos.reset()
dw_documentos.object.documento_t.text = 'Documentos'
i_documentos_mal = ''
f_dw_resaltar_fila(dw_documentos, '','0',0)
dw_documentos.setredraw(false)

//Activar botones

fichero = directorio + i_fichero
if not FileExists(fichero) then 
	return 1
end if
i_paquete = i_fichero
retorno1 = i_zip.ConnectToNewObject("SAWZip.Archive")

try
	i_zip.Open(fichero) 
	
	hay_ini=false
	i_archivo=''
	
	cuantos_ficheros = i_zip.files.count
	st_5.Alignment = Center!
	SetPointer(HourGlass!)
	
	for i = 1 to i_zip.files.count
		st_5.text = 'Extrayendo fichero ' + string(i) + ' de ' + string(cuantos_ficheros)
		i_zip.Files.Item(i -1).extract(g_directorio_temporal)
		//Le quitamos los atributos al fichero por si acaso tenia alguno
		valor = dire.of_setfileattributes(i_zip.Files.Item(i -1).name, false,false,false,false)	
		if Not(f_parsea_fichero(i_zip.Files.Item(i -1).name)) then
			caracteres_no_validos=true
		end if
		f_visared_revisar_firmas(i_zip.Files.Item(i -1).name)		
	next
	i_zip.close()
catch (Throwable ex)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","No se puede procesar el zip.Quiz$$HEX1$$e100$$ENDHEX$$s est$$HEX2$$e9002000$$ENDHEX$$defectuoso")
	return
end try
	
destroy revisor
SetPointer(Arrow!)
st_5.Alignment = Left!
dw_documentos.object.documento_t.text = 'Documentos ('+ string(dw_documentos.rowcount()) + ')'

dw_documentos.setredraw(true)

if caracteres_no_validos then 
	st_5.text='El zip contiene ficheros con caracteres no validos'
	MessageBox("Caracteres NO validos","El zip contiene ficheros con caracteres no validos",StopSign!)
else
	st_5.text='Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'
	cb_1.enabled=true
end if

end event

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)
// Orden
of_setsort(true)
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
// Multiseleccion
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

type gb_2 from groupbox within w_sellador_importar_documentos
integer x = 41
integer y = 1540
integer width = 2222
integer height = 224
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
end type

