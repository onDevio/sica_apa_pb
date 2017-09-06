HA$PBExportHeader$w_eimporta_xml_mca.srw
forward
global type w_eimporta_xml_mca from w_response
end type
type cb_importar from commandbutton within w_eimporta_xml_mca
end type
type dw_archivos from u_dw within w_eimporta_xml_mca
end type
type dw_detalle from u_dw within w_eimporta_xml_mca
end type
type cb_salir from commandbutton within w_eimporta_xml_mca
end type
type cb_previsualizar from commandbutton within w_eimporta_xml_mca
end type
type cb_cerrar_preview from commandbutton within w_eimporta_xml_mca
end type
type cb_selec from commandbutton within w_eimporta_xml_mca
end type
type cb_1 from commandbutton within w_eimporta_xml_mca
end type
end forward

global type w_eimporta_xml_mca from w_response
integer width = 3136
integer height = 2024
event csd_cargar_documentos ( )
cb_importar cb_importar
dw_archivos dw_archivos
dw_detalle dw_detalle
cb_salir cb_salir
cb_previsualizar cb_previsualizar
cb_cerrar_preview cb_cerrar_preview
cb_selec cb_selec
cb_1 cb_1
end type
global w_eimporta_xml_mca w_eimporta_xml_mca

type variables
string is_directorio_xml

end variables

event csd_cargar_documentos();//El sistema busca si han entrado paquetes nuevos en la ruta especificada para visared
datetime f_ultima_revision,f_modificado_fichero,f_modificado
string fs_ultima_revision,hs_ultima_revision
integer num_ficheros,modificados=0
long indice
date dia
time hora
n_cst_filesrvwin32 ficheros
n_cst_dirattrib lista_ficheros[],lista_ficheros2[],lista_ficheros3[]
string subdirec,subdirec2,ruta, carpeta,ruta2
integer num_ficheros2,i,fila,j,num_ficheros3,k
ficheros = create n_cst_filesrvwin32

indice = 1
dw_archivos.reset()

//Recuperamos la lista de ficheros en formato zip
num_ficheros = ficheros.of_dirlist(is_directorio_xml + "*.*",16,lista_ficheros[])

//Ordenamos la lista de ficheros (lista_ficheros) por fecha de escritura (3) en orden descendente(false)
ficheros.of_sortdirlist(lista_ficheros,3,false)

for i=1 to num_ficheros
	if left(lista_ficheros[i].is_FileName,1)='[' then
		subdirec=upper(mid(lista_ficheros[i].is_FileName,2,len(lista_ficheros[i].is_FileName) - 2))
		ruta= is_directorio_xml +subdirec+ '\ENVIOS\PENDIENTES\'
		num_ficheros2 = ficheros.of_dirlist(ruta + "*.*",16,lista_ficheros2[])
		for j=1 to num_ficheros2
			if left(lista_ficheros2[j].is_FileName,1)<>'[' or left(lista_ficheros2[j].is_FileName,2)='[.' then continue
			subdirec2=mid(lista_ficheros2[j].is_FileName,2,len(lista_ficheros2[j].is_FileName) - 2) 
			ruta2= is_directorio_xml +subdirec+ '\ENVIOS\PENDIENTES\'+subdirec2+'\'
			num_ficheros3 = ficheros.of_dirlist(ruta2 + "*.xml",0,lista_ficheros3[])
			Date	id_LastWriteDate
Time	it_LastWriteTime
			for k=1 to num_ficheros3
				fila=dw_archivos.insertrow(0)
				dw_archivos.SetITem(fila,'carpeta',subdirec)
				dw_archivos.SetITem(fila,'directorio',subdirec2)				
				dw_archivos.SetItem(fila,'archivo',lista_ficheros3[k].is_FileName)
				dw_archivos.SetItem(fila,'fecha',datetime(lista_ficheros3[k].id_LastWriteDate,lista_ficheros3[k].it_LastWriteTime))
				choose case upper(subdirec)
					case 'CUOTAS_COLEGIALES','CUOTAS_INTERVENCION','CUOTAS_INTERVENCION_CH','CUOTAS_PRIMA_COMPLEMENTARIA'
						carpeta='Recibos'
					case 'CH'
						carpeta='Certificados Habitabilidad'
					case 'VISADOS'
						carpeta='Visados'
					case else
						carpeta='Otros'
				end choose
				dw_archivos.SetITem(fila,'descripcion',carpeta)
			next
		next
	end if
next
dw_archivos.sort()
dw_archivos.groupcalc()

for i=1 to dw_archivos.rowcount()
	dw_archivos.expand(i,1)
next


end event

on w_eimporta_xml_mca.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
this.dw_archivos=create dw_archivos
this.dw_detalle=create dw_detalle
this.cb_salir=create cb_salir
this.cb_previsualizar=create cb_previsualizar
this.cb_cerrar_preview=create cb_cerrar_preview
this.cb_selec=create cb_selec
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
this.Control[iCurrent+2]=this.dw_archivos
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.cb_previsualizar
this.Control[iCurrent+6]=this.cb_cerrar_preview
this.Control[iCurrent+7]=this.cb_selec
this.Control[iCurrent+8]=this.cb_1
end on

on w_eimporta_xml_mca.destroy
call super::destroy
destroy(this.cb_importar)
destroy(this.dw_archivos)
destroy(this.dw_detalle)
destroy(this.cb_salir)
destroy(this.cb_previsualizar)
destroy(this.cb_cerrar_preview)
destroy(this.cb_selec)
destroy(this.cb_1)
end on

event open;call super::open;is_directorio_xml=ProfileString("sica.ini","COAATMCA","XML",'')

event csd_cargar_documentos()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_eimporta_xml_mca
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_eimporta_xml_mca
end type

type cb_importar from commandbutton within w_eimporta_xml_mca
integer x = 462
integer y = 1808
integer width = 343
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Convertir"
end type

event clicked;integer err,num_ficheros
n_csd_conversion_xml_a_zip uo_xml
string carpeta1,carpeta2,archivo,xml,destino,origen
n_cst_dirattrib lista_ficheros[]
long i,j
string mensaje
int ok,fallo


for j=1 to dw_archivos.rowcount()
	
	if not( dw_archivos.IsSelected(j)) then continue
	
	uo_xml = create n_csd_conversion_xml_a_zip
	
	carpeta1=dw_archivos.GetItemString(j,'carpeta')
	carpeta2=dw_archivos.GetItemString(j,'directorio')
	archivo=dw_archivos.GetItemString(j,'archivo')
	xml=is_directorio_xml+carpeta1+'\ENVIOS\PENDIENTES\'+carpeta2+'\'+archivo
	origen=is_directorio_xml+carpeta1+'\ENVIOS\PENDIENTES\'+carpeta2+'\'
	
	uo_xml.of_inicializar(xml,g_directorio_importacion,left(archivo,len(archivo) -4) +'.zip')
	err=uo_xml.of_convertir()
	
	if err>=0 then
		destino=is_directorio_xml+carpeta1+'\ENVIOS\REALIZADOS\'+carpeta2+'\'
		CreateDirectory(destino)
		
		num_ficheros = gnv_fichero.of_dirlist(origen + "*.*",0,lista_ficheros[])
		for i=1 to num_ficheros
			if left(lista_ficheros[i].is_FileName,1)='[' or left(lista_ficheros[i].is_FileName,2)='[.' then continue
			archivo=lista_ficheros[i].is_FileName
			if FileMove(origen+archivo,destino+archivo)=1 then
				RemoveDirectory(is_directorio_xml+carpeta1+'\ENVIOS\PENDIENTES\'+carpeta2)
			end if			
		next
		ok++
	else
		fallo++
	end if
next
event csd_cargar_documentos()

mensaje=''
if ok>0 then
	mensaje+=string(ok) + " XML convertidos correctamente"+cr
end if
if fallo>0 then
	mensaje+=string(fallo)+" XML fallaron"
end if
if not(f_es_vacio(mensaje)) then MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!",mensaje)
end event

type dw_archivos from u_dw within w_eimporta_xml_mca
integer x = 82
integer y = 44
integer width = 2971
integer height = 1732
integer taborder = 10
string dataobject = "d_eimporta_archivos_mca"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
of_setrowmanager(true)
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)


end event

type dw_detalle from u_dw within w_eimporta_xml_mca
boolean visible = false
integer x = 82
integer y = 44
integer width = 2971
integer height = 1732
integer taborder = 10
string dataobject = "d_eimporta_archivos_detalle_mca"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
end event

type cb_salir from commandbutton within w_eimporta_xml_mca
integer x = 2651
integer y = 1808
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;close(parent)
end event

type cb_previsualizar from commandbutton within w_eimporta_xml_mca
integer x = 91
integer y = 1808
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Previsualizar"
end type

event clicked;long fila
string xml,campo,valor
string carpeta1,carpeta2,archivo
string xml_string,linea
long i,j,k,fd

if dw_archivos.GetRow()<=0 then return

dw_detalle.reset()

carpeta1=dw_archivos.GetItemString(dw_archivos.GetRow(),'carpeta')
carpeta2=dw_archivos.GetItemString(dw_archivos.GetRow(),'directorio')
archivo=dw_archivos.GetItemString(dw_archivos.GetRow(),'archivo')
xml=is_directorio_xml+carpeta1+'\ENVIOS\PENDIENTES\'+carpeta2+'\'+archivo


dw_archivos.visible=false
dw_detalle.visible=true

PBDOM_OBJECT cabecera_xml[]
PBDOM_OBJECT contenido[]
PBDOM_OBJECT contrato[]
PBDOM_OBJECT lista_clientes[]
PBDOM_OBJECT lista_docs[]
PBDOM_OBJECT lista_colegiados[]
PBDOM_OBJECT clientes[]
PBDOM_OBJECT cliente_rep[]
PBDOM_OBJECT colegia[]
PBDOM_OBJECT docs[]
PBDOM_Document    pbdom_doc
PBDOM_Builder     pbdom_bldr

blob blb
// CONVERTIMOS EL XML EN STRING YA QUE DIRECTAMENTE NO LEE BIEN LOS RETORNOS DE CARRO
fd = FileOpen(xml,LineMode!,Read!,LockWrite!)
if fd<0 then return -1
pbdom_bldr = Create PBDOM_Builder
xml_string = ''
do while FileRead(fd,linea) > 0
	linea=trim(linea)
	blb=blob(linea,EncodingANSI!)
	linea=string(blb,EncodingUTF8!)
	if xml_string = '' then
		xml_string += linea
	else
		xml_string = xml_string + linea
	end if
loop

Fileclose(fd)

try
	pbdom_doc = pbdom_bldr.buildfromString(xml_string)
catch (throwable e1)
	return 
end try



pbdom_doc.GetContent(cabecera_xml[])
cabecera_xml[2].GetContent(contenido[])
contenido[1].GetContent(contrato[])

// ******************************	
// CARGA DE LOS DATOS DEL CONTRATO	
// ******************************
dw_detalle.SetRedraw(false)
for i=1 to UpperBound(contrato)
	campo = contrato[i].GetName()
	valor = contrato[i].GetText()		
	  choose case campo
	case 'COAT_CLIENTE'
		contrato[i].GetContent(lista_clientes[])
	case 'DOCUMENTACION'
		contrato[i].GetContent(lista_docs[])				
	case 'COAT_COLEGIADOS'
		contrato[i].GetContent(lista_colegiados[])
	case else
		fila=dw_detalle.insertrow(0)
		dw_detalle.SetItem(fila,'archivo',archivo)
		dw_detalle.SetItem(fila,'seccion','CONTRATO')
		dw_detalle.SetItem(fila,'campo',campo)	
		dw_detalle.SetItem(fila,'valor',valor)	
	end choose
next

// ******************************	
// CARGA DE LOS DATOS DE LOS COLEGIADOS
// ******************************


for i=1 to UpperBound(lista_colegiados)
	lista_colegiados[i].GetContent(colegia[])
	for j=1 to UpperBound(colegia)
		campo = colegia[j].GetName()
		valor = colegia[j].GetText()		
		fila=dw_detalle.insertrow(0)
		dw_detalle.SetItem(fila,'archivo',archivo)
		dw_detalle.SetItem(fila,'seccion','COLEGIADOS')
		dw_detalle.SetItem(fila,'campo',campo)	
		dw_detalle.SetItem(fila,'valor',valor)		
	next
next


// ******************************	
// CARGA DE LOS DATOS DE LOS CLIENTES
// ******************************
for i=1 to UpperBound(lista_clientes)
	lista_clientes[i].GetContent(cliente_rep[])
	for j=1 to UpperBound(cliente_rep)
		campo = upper(cliente_rep[j].GetName())
		valor = cliente_rep[j].GetText()		
		choose case campo
			case 'CLIENTE'
				cliente_rep[j].GetContent(clientes[])
				for k=1 to UpperBound(clientes)
					campo = upper(clientes[k].GetName())
					valor = clientes[k].GetText()		
					fila=dw_detalle.insertrow(0)
					dw_detalle.SetItem(fila,'archivo',archivo)
					dw_detalle.SetItem(fila,'seccion','CLIENTES')
					dw_detalle.SetItem(fila,'campo',campo)	
					dw_detalle.SetItem(fila,'valor',valor)		
				next
			case else
				fila=dw_detalle.insertrow(0)
				dw_detalle.SetItem(fila,'archivo',archivo)
				dw_detalle.SetItem(fila,'seccion','REPRESENTANTE CLIENTE')
				dw_detalle.SetItem(fila,'campo',campo)	
				dw_detalle.SetItem(fila,'valor',valor)		
		end choose
	next
next


// ******************************	
// CARGA DE LOS DATOS DE DOCUMENTOS
// ******************************
for i=1 to UpperBound(lista_docs)
	lista_docs[i].GetContent(docs[])
	for j=1 to UpperBound(docs)
		campo = docs[j].GetName()
		valor = docs[j].GetText()		
		fila=dw_detalle.insertrow(0)
		dw_detalle.SetItem(fila,'archivo',archivo)
		dw_detalle.SetItem(fila,'seccion','DOCUMENTOS')
		dw_detalle.SetItem(fila,'campo',campo)	
		dw_detalle.SetItem(fila,'valor',valor)		
	next
next


//dw_detalle.sort()
dw_detalle.groupcalc()
dw_detalle.SetRedraw(true)
dw_detalle.expand(1,1)

cb_cerrar_preview.visible=true
cb_previsualizar.visible=false
cb_importar.enabled=false
end event

type cb_cerrar_preview from commandbutton within w_eimporta_xml_mca
boolean visible = false
integer x = 91
integer y = 1808
integer width = 334
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar Preview"
end type

event clicked;dw_detalle.visible=false
dw_archivos.visible=true

this.visible=false
cb_previsualizar.visible=true
cb_importar.enabled=true
end event

type cb_selec from commandbutton within w_eimporta_xml_mca
integer x = 1147
integer y = 1808
integer width = 315
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Selec. Todo"
end type

event clicked;long i
dw_archivos.expandall()

for i=1 to dw_archivos.rowcount()
	dw_archivos.selectrow(i,true)
next
end event

type cb_1 from commandbutton within w_eimporta_xml_mca
integer x = 1472
integer y = 1808
integer width = 315
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deselec"
end type

event clicked;long i

for i=1 to dw_archivos.rowcount()
	dw_archivos.selectrow(i,false)
next
end event

