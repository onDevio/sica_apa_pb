HA$PBExportHeader$w_preferencias.srw
forward
global type w_preferencias from w_consulta
end type
type tab_1 from tab within w_preferencias
end type
type tabpage_1 from userobject within tab_1
end type
type dw_pref_sica from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_pref_sica dw_pref_sica
end type
type tabpage_2 from userobject within tab_1
end type
type dw_pref_visared from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_pref_visared dw_pref_visared
end type
type tabpage_3 from userobject within tab_1
end type
type dw_pref_correo from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_pref_correo dw_pref_correo
end type
type tab_1 from tab within w_preferencias
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_preferencias from w_consulta
integer x = 214
integer y = 221
integer width = 3145
integer height = 1908
string title = "Preferencias del sistema"
tab_1 tab_1
end type
global w_preferencias w_preferencias

type variables
n_cst_filesrvwin32 inv_filesrvwin32

u_dw idw_pref_SICA,idw_pref_Visared,idw_pref_correo

n_cst_encrypt encriptacion




end variables

forward prototypes
public subroutine wf_cargar_conf_correo ()
public subroutine wf_guardar_conf_correo ()
end prototypes

public subroutine wf_cargar_conf_correo ();// Obtencion de los datos del .ini

idw_pref_correo.SetItem(1,'tipo_envio',g_sistema_mailing)
idw_pref_correo.SetItem(1,'partir_envio_masivo',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","partir_envio_masivo", "N"))
idw_pref_correo.SetItem(1,'smtp',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", ""))
idw_pref_correo.SetItem(1,'pop',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop", ""))
idw_pref_correo.SetItem(1,'direccion',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion", ""))
idw_pref_correo.SetItem(1,'direccion_copia',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia", ""))
idw_pref_correo.SetItem(1,'nombre',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","nombre", ""))
idw_pref_correo.SetItem(1,'login',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","login", ""))
idw_pref_correo.SetItem(1,'recordar',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","recordar", ""))
idw_pref_correo.SetItem(1,'maximo_envio',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","maximo_envios", ""))
idw_pref_correo.SetItem(1,'puerto_smtp',ProfileString(g_dir_aplicacion+"sica.ini","CORREO","puerto_servidor_smtp", "25")) 
if idw_pref_correo.GetItemString(1,'recordar')='S' then
	habilita(idw_pref_correo,'password',70)
	idw_pref_correo.SetItem(1,'password',encriptacion.of_decrypt(ProfileString(g_dir_aplicacion+"sica.ini","CORREO","password", "")))
	idw_pref_correo.Object.password.color=rgb(0,0,255)
else
	inhabilita(idw_pref_correo,'password')
end if
	

end subroutine

public subroutine wf_guardar_conf_correo ();string password

idw_pref_correo.accepttext()

// Parametros de Configuracion del Correo
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","tipo_envio", idw_pref_correo.GetItemString(1,'tipo_envio'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","servidor_smtp", idw_pref_correo.GetItemString(1,'smtp'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","servidor_pop",  idw_pref_correo.GetItemString(1,'pop'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","direccion",  idw_pref_correo.GetItemString(1,'direccion'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","direccion_copia",  idw_pref_correo.GetItemString(1,'direccion_copia'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","nombre",  idw_pref_correo.GetItemString(1,'nombre'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","login",  idw_pref_correo.GetItemString(1,'login'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","recordar",  idw_pref_correo.GetItemString(1,'recordar'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","partir_envio_masivo",  idw_pref_correo.GetItemString(1,'partir_envio_masivo'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","maximo_envios",  idw_pref_correo.GetItemString(1,'maximo_envio'))
Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","puerto_servidor_smtp",  idw_pref_correo.GetItemString(1,'puerto_smtp'))
password=encriptacion.of_encrypt(idw_pref_correo.GetItemString(1,'password'))
if idw_pref_correo.GetItemString(1,'recordar')='S' then
	Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","password", password )
else
	Setprofilestring(g_dir_aplicacion+"sica.ini","CORREO","password", "" )
end if

end subroutine

on w_preferencias.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_preferencias.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;DataWindowChild dw_ejerc
string nom_empresa

f_centrar_ventana(this)
encriptacion=create n_cst_encrypt
/*
//Se formatean los valores por defecto
if f_es_vacio(g_aviso_paquetes_nuevos) then g_aviso_paquetes_nuevos ='N'
if isnull(g_tiempo_revision) then g_tiempo_revision = 300  //5 segundos
*/
idw_pref_SICA.SetItem(1,'dir_aplicacion', g_dir_aplicacion)

idw_pref_SICA.SetItem(1,'plantillas',g_directorio_rtf)
idw_pref_SICA.SetItem(1,'generados', g_directorio_generados)
idw_pref_SICA.SetItem(1,'es', g_directorio_e_s)
idw_pref_SICA.SetItem(1,'fotos', g_directorio_fotos)
idw_pref_SICA.SetItem(1,'docuprinter', g_impresion_docuprinter)
//idw_pref_SICA.SetItem(1,'actas', g_directorio_actas)

idw_pref_SICA.SetItem(1,'pdf', g_formato_impresion.pdf)
idw_pref_SICA.SetItem(1,'email', g_formato_impresion.email)
idw_pref_SICA.SetItem(1,'papel', g_formato_impresion.papel)
idw_pref_SICA.SetItem(1,'pdf_visared', g_formato_impresion_visared.pdf)
idw_pref_SICA.SetItem(1,'email_visared', g_formato_impresion_visared.email)
idw_pref_SICA.SetItem(1,'papel_visared', g_formato_impresion_visared.papel)
idw_pref_SICA.SetItem(1,'generar_registro', g_formato_impresion.generar_registro)
if g_textos_en_botones=true then
	idw_pref_SICA.SetItem(1,'textos_en_menu','S')
else
	idw_pref_SICA.SetItem(1,'textos_en_menu','N')
end if

if g_piedepagina=true then
	idw_pref_SICA.SetItem(1,'pie_pagina','S')
else
	idw_pref_SICA.SetItem(1,'pie_pagina','N')
end if
/*
if g_cargar_ultima_consulta=true then
	idw_pref_SICA.SetItem(1,'cargar_ultima_consulta','S')
else
	idw_pref_SICA.SetItem(1,'cargar_ultima_consulta','N')
end if

if g_ignorar_mayusc_consulta=true then
	idw_pref_SICA.SetItem(1,'ignorar_mayusc_consulta','S')
else
	idw_pref_SICA.SetItem(1,'ignorar_mayusc_consulta','N')
end if
*/

//idw_pref_SICA.SetItem(1,'delegacion',g_cod_delegacion)

idw_pref_SICA.SetItem(1,'emp_activa',g_empresa)
idw_pref_SICA.SetItem(1,'ejercicios',g_ejercicio)



idw_pref_Visared.SetItem(1,'mostrar_aviso',ProfileString(g_dir_aplicacion+"sica.ini","VISARED","aviso_llegada","N"))
idw_pref_Visared.SetItem(1,'imagenes',g_directorio_imagenes)
idw_pref_Visared.SetItem(1,'certificados', g_directorio_certificados)
idw_pref_Visared.SetItem(1,'fuentes', g_directorio_fuentes)
idw_pref_Visared.SetItem(1,'importacion', g_directorio_importacion)
idw_pref_Visared.SetItem(1,'importados', g_directorio_importados)
idw_pref_Visared.SetItem(1,'docs_visared', g_directorio_documentos_visared)
//idw_pref_Visared.SetItem(1,'temporales', g_directorio_temporal)
idw_pref_Visared.SetItem(1,'aviso_nuevos', g_aviso_paquetes_nuevos)
//idw_pref_Visared.SetItem(1,'tiempo_revision', g_tiempo_revision)
//idw_pref_Visared.SetItem(1,'descargar_correos', g_descarga_correo)
idw_pref_Visared.SetItem(1,'revisar_firmas', g_revisar_firmas)
idw_pref_Visared.SetItem(1,'directorio_firmas', g_directorio_firmas)
idw_pref_Visared.SetItem(1,'revisar_certificados', g_revisar_certificados)
idw_pref_Visared.SetItem(1,'directorio_sellos', g_directorio_sellos)
idw_pref_Visared.SetItem(1,'incorporar_zip_exp', g_incorporar_zip_exp)


if g_activar_revision_firmas = 'S' then
	idw_pref_Visared.object.revisar_firmas.visible = true
	idw_pref_Visared.object.directorio_firmas.visible = true
	idw_pref_Visared.object.t_2.visible = true
	idw_pref_Visared.object.b_8.visible = true	
	g_revisar_firmas = 'S'
	g_revisar_certificados = 'S'
else
	idw_pref_Visared.object.revisar_firmas.visible = false
	idw_pref_Visared.object.directorio_firmas.visible = false
	idw_pref_Visared.object.t_2.visible = false
	idw_pref_Visared.object.b_8.visible = false	
	g_revisar_firmas = 'N'
	g_revisar_certificados = 'N'
end if
wf_cargar_conf_correo()
end event

event pfc_preopen;call super::pfc_preopen;DatawindowChild dw_ejerc

idw_pref_SICA=tab_1.tabpage_1.dw_pref_sica
idw_pref_Visared=tab_1.tabpage_2.dw_pref_visared
idw_pref_correo=tab_1.tabpage_3.dw_pref_correo

idw_pref_SICA.GetChild("ejercicios",dw_ejerc)

dw_ejerc.InsertRow(0)
dw_ejerc.SetTransObject(SQLCA)
dw_ejerc.retrieve(g_empresa)

idw_pref_SICA.event pfc_addrow()
idw_pref_visared.event pfc_addrow()
idw_pref_correo.event pfc_addrow()




end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_preferencias
end type

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_preferencias
end type

type cb_limpiar from w_consulta`cb_limpiar within w_preferencias
end type

type st_5 from w_consulta`st_5 within w_preferencias
boolean visible = false
end type

type cb_1 from w_consulta`cb_1 within w_preferencias
integer x = 2011
integer y = 1684
end type

event cb_1::clicked;call super::clicked;idw_pref_sica.accepttext()
idw_pref_visared.accepttext()

Setprofilestring(g_dir_aplicacion+"sica.ini","Rtf","path_rtf", idw_pref_Sica.GetItemString(1,'plantillas'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Generados","path_generados", idw_pref_Sica.GetItemString(1,'generados'))
Setprofilestring(g_dir_aplicacion+"sica.ini","E_s","path_e_s", idw_pref_Sica.GetItemString(1,'es'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Actas","path_actas", idw_pref_Sica.GetItemString(1,'actas'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Fotos","path_fotos", idw_pref_Sica.GetItemString(1,'fotos'))

Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","textos", idw_pref_Sica.GetItemString(1,'textos_en_menu'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","piedepagina", idw_pref_Sica.GetItemString(1,'pie_pagina'))

Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","pdf", idw_pref_Sica.GetItemString(1,'pdf'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","email", idw_pref_Sica.GetItemString(1,'email'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","papel", idw_pref_Sica.GetItemString(1,'papel'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","pdf_visared", idw_pref_Sica.GetItemString(1,'pdf_visared'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","email_visared", idw_pref_Sica.GetItemString(1,'email_visared'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","papel_visared", idw_pref_Sica.GetItemString(1,'papel_visared'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","registro_salida", idw_pref_Sica.GetItemString(1,'generar_registro'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Parametros","docuprinter", idw_pref_Sica.GetItemString(1,'docuprinter'))


//if idw_pref_Sica.GetItemString(1,'ejercicios')<>"" then
//   Setprofilestring(g_dir_aplicacion+"sica.ini","Empresa_Activa","Ejercicio", idw_pref_Sica.GetItemString(1,'ejercicios'))
//end if
//
if idw_pref_Sica.GetItemString(1,'emp_activa')<>"" then
   Setprofilestring(g_dir_aplicacion+"sica.ini","Empresa_Activa","Empresa", idw_pref_Sica.GetItemString(1,'emp_activa'))
end if
//
//Setprofilestring(g_dir_aplicacion+"sica.ini","Delegacion","delegacion", idw_pref_Sica.GetItemString(1,'delegacion'))
//
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","aviso_llegada", idw_pref_Visared.GetItemString(1,'mostrar_aviso'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_certificados", idw_pref_Visared.GetItemString(1,'certificados'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_imagenes", idw_pref_Visared.GetItemString(1,'imagenes'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_importacion", idw_pref_Visared.GetItemString(1,'importacion'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_importados", idw_pref_Visared.GetItemString(1,'importados'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_fuentes", idw_pref_Visared.GetItemString(1,'fuentes'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_documentos_visared", idw_pref_Visared.GetItemString(1,'docs_visared'))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_temporal", idw_pref_Visared.GetItemString(1,'temporales'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_firmas", idw_pref_Visared.GetItemString(1,'directorio_firmas'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_aviso_nuevos", idw_pref_Visared.GetItemString(1,'aviso_nuevos'))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_tiempo_revision", string(idw_pref_Visared.GetItemNumber(1,'tiempo_revision')))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_descarga_correo", idw_pref_Visared.GetItemString(1,'descargar_correos'))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_revisar_firmas", idw_pref_Visared.GetItemString(1,'revisar_firmas'))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_revisar_certificados", idw_pref_Visared.GetItemString(1,'revisar_certificados'))
Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_directorio_sellos", idw_pref_Visared.GetItemString(1,'directorio_sellos'))
//Setprofilestring(g_dir_aplicacion+"sica.ini","Visared","g_incorporar_zip_exp", idw_pref_Visared.GetItemString(1,'incorporar_zip_exp'))

wf_guardar_conf_correo()

f_inicializar_var_globales()
//w_aplic_frame.event csd_activar_temporizador()


close(parent)
end event

type cb_2 from w_consulta`cb_2 within w_preferencias
integer x = 2555
integer y = 1684
end type

type cb_ayuda from w_consulta`cb_ayuda within w_preferencias
end type

type dw_1 from w_consulta`dw_1 within w_preferencias
boolean visible = false
end type

type tab_1 from tab within w_preferencias
integer x = 32
integer y = 100
integer width = 3054
integer height = 1544
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3017
integer height = 1416
long backcolor = 79741120
string text = "SICA"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Application!"
long picturemaskcolor = 536870912
dw_pref_sica dw_pref_sica
end type

on tabpage_1.create
this.dw_pref_sica=create dw_pref_sica
this.Control[]={this.dw_pref_sica}
end on

on tabpage_1.destroy
destroy(this.dw_pref_sica)
end on

type dw_pref_sica from u_dw within tabpage_1
integer x = 23
integer y = 40
integer width = 2990
integer height = 1348
integer taborder = 11
string dataobject = "d_preferencias"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string fichero
nca_folderbrowse lnca_bff
String ls_A

choose case dwo.name
	case 'b_3'	
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de las plantillas' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'plantillas', ls_A + '\')			
	case 'b_4'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los documentos generados' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'generados', ls_A + '\')					
	case 'b_5'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los ficheros de Entrada/Salida' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'es', ls_A + '\')							
	case 'b_6'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los contratos' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'contratos', ls_A + '\')							
	case 'b_7'		
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de las fotos' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'fotos', ls_A + '\')							
	case 'b_8'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de las actas' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'actas', ls_A + '\')									

		
end choose

end event

event itemchanged;call super::itemchanged;DataWindowChild dddw_ejercicio


choose case dwo.name
	case 'emp_activa'		
		idw_pref_sica.GetChild('ejercicios',dddw_ejercicio)
		dddw_ejercicio.SetTransObject(SQLCA)
		dddw_ejercicio.retrieve(data)				
end choose
end event

type tabpage_2 from userobject within tab_1
string tag = "texto=general.visado_electronico"
integer x = 18
integer y = 112
integer width = 3017
integer height = 1416
long backcolor = 79741120
string text = "Visado Electr$$HEX1$$f300$$ENDHEX$$nico"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom084!"
long picturemaskcolor = 536870912
dw_pref_visared dw_pref_visared
end type

on tabpage_2.create
this.dw_pref_visared=create dw_pref_visared
this.Control[]={this.dw_pref_visared}
end on

on tabpage_2.destroy
destroy(this.dw_pref_visared)
end on

type dw_pref_visared from u_dw within tabpage_2
integer x = 14
integer y = 140
integer width = 2898
integer height = 1260
integer taborder = 11
string dataobject = "d_preferencias_visared"
boolean vscrollbar = false
boolean border = false
end type

event buttonclicked;call super::buttonclicked;string fichero
nca_folderbrowse lnca_bff
String ls_A

choose case dwo.name
	case 'b_1'	
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de las imagenes' )		
		if not f_es_vacio(ls_A) then this.setitem(1, 'imagenes', ls_A + '\')			
	case 'b_2'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los certificados' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'certificados', ls_A + '\')					
	case 'b_3'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de las fuentes' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'fuentes', ls_A + '\')							
	case 'b_4'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de importaci$$HEX1$$f300$$ENDHEX$$n' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'importacion', ls_A + '\')							
	case 'b_5'		
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los archivos importados' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'importados', ls_A + '\')							
	case 'b_6'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los Documentos Visared' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'docs_visared', ls_A + '\')									
	case 'b_7'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los Ficheros Temporales' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'temporales', ls_A + '\')									
	case 'b_8'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los Ficheros de firmas' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'directorio_firmas', ls_A + '\')	
	case 'b_9'
		ls_A = lnca_BFF.BrowseForFolder( w_preferencias, 'Seleccione el directorio de los Ficheros de Sellos' )
		if not f_es_vacio(ls_A) then this.setitem(1, 'directorio_sellos', ls_A + '\')	
end choose

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'revisar_firmas'
		if data = 'N' then
			this.setitem(1,'revisar_certificados','N')
		end if
end choose
end event

type tabpage_3 from userobject within tab_1
string tag = "texto=general.correo"
integer x = 18
integer y = 112
integer width = 3017
integer height = 1416
long backcolor = 79741120
string text = "Correo"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom025!"
long picturemaskcolor = 536870912
dw_pref_correo dw_pref_correo
end type

on tabpage_3.create
this.dw_pref_correo=create dw_pref_correo
this.Control[]={this.dw_pref_correo}
end on

on tabpage_3.destroy
destroy(this.dw_pref_correo)
end on

type dw_pref_correo from u_dw within tabpage_3
integer x = 14
integer y = 144
integer width = 2985
integer height = 976
integer taborder = 11
string dataobject = "d_preferencias_correo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'recordar'
		if data='S' then
			habilita(idw_pref_correo,'password',85)
			idw_pref_correo.Object.password.color=rgb(0,0,255)
		else
			inhabilita(idw_pref_correo,'password')
			
		end if
end choose
		
end event

