HA$PBExportHeader$w_eimporta_detalle_base.srw
forward
global type w_eimporta_detalle_base from w_csd_sheet
end type
type dw_paquetes from u_csd_dw within w_eimporta_detalle_base
end type
type rb_ver_elem_procesados from u_rb within w_eimporta_detalle_base
end type
type rb_ver_bandeja_entrada from u_rb within w_eimporta_detalle_base
end type
type pb_5 from u_pb within w_eimporta_detalle_base
end type
type st_4 from statictext within w_eimporta_detalle_base
end type
type pb_4 from u_pb within w_eimporta_detalle_base
end type
type pb_3 from u_pb within w_eimporta_detalle_base
end type
type pb_2 from u_pb within w_eimporta_detalle_base
end type
type pb_1 from u_pb within w_eimporta_detalle_base
end type
type st_2 from statictext within w_eimporta_detalle_base
end type
type st_1 from statictext within w_eimporta_detalle_base
end type
type p_logo from u_p within w_eimporta_detalle_base
end type
type gb_2 from groupbox within w_eimporta_detalle_base
end type
type dw_documentos from u_csd_dw within w_eimporta_detalle_base
end type
type gb_1 from groupbox within w_eimporta_detalle_base
end type
type tab_1 from tab within w_eimporta_detalle_base
end type
type tabpage_3 from userobject within tab_1
end type
type cb_sel_fase from u_cb within tabpage_3
end type
type cb_importar_fase from u_cb within tabpage_3
end type
type cb_abrir from u_cb within tabpage_3
end type
type cb_buscar_coinc from u_cb within tabpage_3
end type
type dw_coincidencias_lista from u_csd_dw within tabpage_3
end type
type dw_coincidencias_consulta from u_csd_dw within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_sel_fase cb_sel_fase
cb_importar_fase cb_importar_fase
cb_abrir cb_abrir
cb_buscar_coinc cb_buscar_coinc
dw_coincidencias_lista dw_coincidencias_lista
dw_coincidencias_consulta dw_coincidencias_consulta
gb_4 gb_4
end type
type tabpage_2 from userobject within tab_1
end type
type cb_sel_fase2 from u_cb within tabpage_2
end type
type cb_abrir2 from u_cb within tabpage_2
end type
type cb_importar_fase2 from u_cb within tabpage_2
end type
type cb_buscar from u_cb within tabpage_2
end type
type dw_busqueda_consulta from u_csd_dw within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_busqueda_lista from u_csd_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_sel_fase2 cb_sel_fase2
cb_abrir2 cb_abrir2
cb_importar_fase2 cb_importar_fase2
cb_buscar cb_buscar
dw_busqueda_consulta dw_busqueda_consulta
gb_3 gb_3
dw_busqueda_lista dw_busqueda_lista
end type
type tabpage_1 from userobject within tab_1
end type
type dw_subsanacion_incidencias from u_csd_dw within tabpage_1
end type
type dw_incidencias from u_csd_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_subsanacion_incidencias dw_subsanacion_incidencias
dw_incidencias dw_incidencias
end type
type tab_1 from tab within w_eimporta_detalle_base
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
end type
type lb_1 from listbox within w_eimporta_detalle_base
end type
type st_3 from statictext within w_eimporta_detalle_base
end type
type st_div from statictext within w_eimporta_detalle_base
end type
type st_div2 from statictext within w_eimporta_detalle_base
end type
type rb_otra_carpeta from u_rb within w_eimporta_detalle_base
end type
type st_5 from multilineedit within w_eimporta_detalle_base
end type
type cb_obs from commandbutton within w_eimporta_detalle_base
end type
type cb_select_folder from commandbutton within w_eimporta_detalle_base
end type
end forward

global type w_eimporta_detalle_base from w_csd_sheet
integer x = 214
integer y = 221
integer width = 4366
integer height = 2504
string title = "Importaci$$HEX1$$f300$$ENDHEX$$n de Expedientes"
string menuname = "m_eimporta"
windowstate windowstate = maximized!
event csd_redimensionar ( )
event csd_cargar_coincidencias ( string fichero )
event csd_boton_importar ( )
event csd_boton_previsualizar ( )
event csd_boton_validar ( )
event csd_boton_descargar ( )
event csd_boton_salir ( )
event csd_inicializar_var_subsanacion ( )
event csd_boton_lector ( )
dw_paquetes dw_paquetes
rb_ver_elem_procesados rb_ver_elem_procesados
rb_ver_bandeja_entrada rb_ver_bandeja_entrada
pb_5 pb_5
st_4 st_4
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_2 st_2
st_1 st_1
p_logo p_logo
gb_2 gb_2
dw_documentos dw_documentos
gb_1 gb_1
tab_1 tab_1
lb_1 lb_1
st_3 st_3
st_div st_div
st_div2 st_div2
rb_otra_carpeta rb_otra_carpeta
st_5 st_5
cb_obs cb_obs
cb_select_folder cb_select_folder
end type
global w_eimporta_detalle_base w_eimporta_detalle_base

type prototypes

end prototypes

type variables
string i_paquete,i_archivo_ini,i_opcion_importacion
string i_id_paquete

u_csd_dw idw_incidencias, idw_subsanacion_incidencias
u_csd_dw idw_busqueda_consulta, idw_busqueda_lista
u_csd_dw idw_coincidencias_consulta, idw_coincidencias_lista
string i_directorio
string i_id_col[]
string i_id_cli[],i_nif_cli[]
int i_n_colegiados
int i_n_clientes

w_eimporta_procesando iw_extraer

//Para revisar las firmas de los pdf
string i_documentos_mal
datastore ids_incidencias
//Mensaje que aparecer$$HEX2$$e1002000$$ENDHEX$$en el messagebox, cuando no encuentre la referencia del expediente. Y por tanto su opci$$HEX1$$f300$$ENDHEX$$n por
//defecto sea crear un expediente Nuevo
string i_mensaje_exp_nuevo = 'El sistema no ha localizado ning$$HEX1$$fa00$$ENDHEX$$n expediente anterior asociado con el paquete enviado.'+cr &
									+ 'Por defecto se crear$$HEX2$$e1002000$$ENDHEX$$un nuevo expediente con su fase asociada. '+cr &
									+ 'Si NO desea esta opci$$HEX1$$f300$$ENDHEX$$n, y desea incorporar esta fase en alg$$HEX1$$fa00$$ENDHEX$$n expediente existente,'+cr &
									+ 'ind$$HEX1$$ed00$$ENDHEX$$quelo en la ventana que aparecer$$HEX2$$e1002000$$ENDHEX$$a continuaci$$HEX1$$f300$$ENDHEX$$n'
string i_mensaje_fase_nueva = 'El sistema ha localizado un expediente anterior asociado con el paquete enviado.'+cr &
									+ 'Por defecto se incorporar$$HEX2$$e1002000$$ENDHEX$$la fase al expediente que se indica a continuaci$$HEX1$$f300$$ENDHEX$$n. '+cr &
									+ 'Si NO desea esta opci$$HEX1$$f300$$ENDHEX$$n, y desea crear un nuevo expediente, ind$$HEX1$$ed00$$ENDHEX$$quelo en la ventana que aparecer$$HEX2$$e1002000$$ENDHEX$$a continuaci$$HEX1$$f300$$ENDHEX$$n'
string i_mensaje
string i_coincidencia,i_coincidencia_fase

// En la tabla de fases el campo de tipo de actuacion (fase) tiene diferente nombre seg$$HEX1$$fa00$$ENDHEX$$n la aplicaci$$HEX1$$f300$$ENDHEX$$n. Las ventanas hijas deben indicar cual es el correcto.
protected string campo_tipo_actuacion = 'tipo_actuacion'

n_oo_captura_errores zip
string is_fichero_abierto
boolean ib_importado=false


end variables

forward prototypes
public subroutine wf_revisar_firmas (string fichero_pdf)
public function string wf_busqueda_clientes ()
public function string wf_busqueda_colegiados ()
public function string wf_busqueda_poblaciones ()
public function boolean wf_comprobar_incidencias_graves ()
public function string wf_busqueda_coinc_colegiados (string sql_nuevo)
public function st_visared_importacion wf_importacion ()
public subroutine wf_borrar_paquete_bd (string as_paquete)
public subroutine wf_bloqueo_fichero (string fichero, boolean protegido)
public subroutine wf_inicializa ()
public function string wf_busqueda_coinc_clientes (string sql_nuevo)
end prototypes

event csd_redimensionar();if st_div.x < 1870 then st_div.x = 1870

gb_1.height = pb_1.y - gb_1.y - 15
gb_1.width = st_div.x - gb_1.x

if st_div2.y < 520 then st_div2.y = 520
if st_div2.y > gb_1.height - 360 then st_div2.y = gb_1.height - 360 

dw_paquetes.width = st_div.x - dw_paquetes.x - 42
dw_paquetes.height = st_div2.y - dw_paquetes.y
st_3.y = st_div2.y + 20
dw_documentos.width = dw_paquetes.width
dw_documentos.y = st_div2.y + 88
dw_documentos.height = gb_1.height - st_div2.y - 100

gb_2.width = gb_1.width
st_5.width = gb_2.width - 28
p_logo.width = gb_1.width
tab_1.x = st_div.x + 18
tab_1.width = this.width - st_div.x - 77
tab_1.tabpage_3.gb_4.width = tab_1.width - 51 //60
idw_coincidencias_consulta.width = tab_1.width - 69 //78
tab_1.tabpage_3.cb_buscar_coinc.x = tab_1.width - 435
idw_coincidencias_lista.width = tab_1.width - 51 //60
tab_1.tabpage_2.gb_3.width = tab_1.width - 51 //60
idw_busqueda_consulta.width = tab_1.width - 69 //78
tab_1.tabpage_2.cb_buscar.x = tab_1.width - 435
idw_busqueda_lista.width = tab_1.width - 51 //60
idw_incidencias.width = tab_1.width - 51 //60
idw_subsanacion_incidencias.width = tab_1.width - 51 //60

st_4.x = st_div.x + 55

st_div.y = gb_1.y
st_div.height = gb_1.height
st_div2.x = dw_paquetes.x
st_div2.width = dw_paquetes.width

end event

event csd_cargar_coincidencias(string fichero);//Limpiamos el dw
idw_coincidencias_consulta.event pfc_deleterow()
idw_coincidencias_consulta.event pfc_addrow()
idw_coincidencias_lista.reset()
st_4.visible = false

// A extender en los hijos

end event

event csd_boton_importar();pb_1.event clicked()
end event

event csd_boton_previsualizar();pb_2.event clicked()
end event

event csd_boton_validar();pb_3.event clicked()
end event

event csd_boton_descargar();pb_5.event clicked()
end event

event csd_boton_salir();pb_4.event clicked()
end event

event csd_inicializar_var_subsanacion();long i

g_campos_subsanados.cod_pob_emplaz = ""
g_campos_subsanados.cod_pos_emplaz = ""
g_campos_subsanados.desc_poblacion_emplaz = ""
g_campos_subsanados.colegiado=""

for i=1 to 10
	g_campos_subsanados.cli_nif[i]=""
	g_campos_subsanados.rep_nif[i]=""	
	g_campos_subsanados.cod_pob_clientes[i]=""
	g_campos_subsanados.cod_pos_clientes[i]=""
	g_campos_subsanados.desc_poblacion_clientes[i]=""
	
	g_campos_subsanados.col_numero[i]=""
	
	g_campos_subsanados.cod_pob_rep[i]=""
	g_campos_subsanados.cod_pos_rep[i]=""
	g_campos_subsanados.desc_poblacion_rep[i]=""	
next

end event

event csd_boton_lector();string res
long fila

open(w_eimporta_barcode)

res=Message.StringParm

if res='1' then 
	i_archivo_ini="barcode.ini"
	pb_1.enabled=true
	pb_2.enabled=true
	pb_3.enabled=true	
	dw_paquetes.reset()
	dw_documentos.reset()
	fila=dw_paquetes.insertrow(0)
	dw_paquetes.SetItem(fila,'archivo','IMPORTACION CODIGO DE BARRAS')
end if

end event

public subroutine wf_revisar_firmas (string fichero_pdf);// FUNCION DE REVISION DE FIRMAS REESCRITA. ELOY 06/10/2008

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
u_revision_firmas revisor
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
	fila_inc = ids_incidencias.insertrow(0)
	incidencia = 'El fichero: ' + fichero_pdf + ' est$$HEX2$$e1002000$$ENDHEX$$corrupto'
	ids_incidencias.SetItem(fila_inc,'incidencia',incidencia)
	ids_incidencias.SetItem(fila_inc,'solucion','No se importar$$HEX2$$e1002000$$ENDHEX$$el fichero')
	ids_incidencias.SetItem(fila_inc,'nivel_incidencia','M')
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











/*
int i
int fila, fila_inc, num_firmas, num_revisiones
string firmantes
double tamano
date fecha
time hora
string incidencia
boolean firma_valida
boolean certificados_validos = true
u_revision_firmas revisor

revisor = create u_revision_firmas

firma_valida = true

fila = dw_documentos.event pfc_addrow()

//Ponemos el id, el nombre del fichero
dw_documentos.setitem(fila,'id_fichero',string(fila))
dw_documentos.setitem(fila,'documento',fichero_pdf)

if upper(right(fichero_pdf,3))='PDF' then

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
		fila_inc = ids_incidencias.insertrow(0)
		incidencia = 'El fichero: ' + fichero_pdf + ' est$$HEX2$$e1002000$$ENDHEX$$corrupto'
		ids_incidencias.SetItem(fila_inc,'incidencia',incidencia)
		ids_incidencias.SetItem(fila_inc,'solucion','No se importar$$HEX2$$e1002000$$ENDHEX$$el fichero')
		ids_incidencias.SetItem(fila_inc,'nivel_incidencia','M')
		//Ni revisamos las firmas
		return
	end if
	
	if g_revisar_firmas = 'S' then
		//Comprobamos las firmas
		revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
		revisor.is_nombre_fichero_ini = g_directorio_temporal + left(fichero_pdf,len(fichero_pdf) - 4) + ".ini"
		if g_revisar_certificados = 'S' then
			revisor.of_leer_certificado(true)
		else
			revisor.of_leer_certificado(false)
		end if
		
		firmantes = ''
		num_firmas = revisor.ii_num_firmas
		num_revisiones = revisor.ii_num_revisiones
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
		if num_firmas > 0 and firma_valida = true and num_firmas = num_revisiones then 
			dw_documentos.setitem(fila,'firmado','V')
		end if
		// F - Firmado pero hay firmas no validas
		if num_firmas > 0 and firma_valida = false then 
			dw_documentos.setitem(fila,'firmado','F')
		end if
		//F - Firmado pero hay mas revisiones que firmas
		if num_firmas > 0 and firma_valida = true and num_firmas <> num_revisiones then
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

destroy revisor
*/
end subroutine

public function string wf_busqueda_clientes ();// A implementar en los hijos
return ''
end function

public function string wf_busqueda_colegiados ();// A implementar en los hijos
return ''
end function

public function string wf_busqueda_poblaciones ();// A implementar en los hijos
return ''
end function

public function boolean wf_comprobar_incidencias_graves ();long i
boolean hay_graves

for i = 1 to idw_incidencias.rowcount()
	if idw_incidencias.getitemstring(i, 'nivel_incidencia') = 'G' and idw_incidencias.getitemstring(i, 'subsanado') = 'N' then
		hay_graves = true
		exit
	end if
next

if hay_graves then
	pb_1.enabled = false
	m_eimporta.of_menu_eimporta_importar().enabled = false
	return false
else
	pb_1.enabled = true
	m_eimporta.of_menu_eimporta_importar().enabled = true
	return true
end if

end function

public function string wf_busqueda_coinc_colegiados (string sql_nuevo);//Evento que concatena la busqueda de coincidencias por colegiados
string sql_aux = ""
string lista_in
int i

if i_n_colegiados = 0 then
	messagebox(g_titulo, 'No hay colegiados para buscar.')
	return '-1'
end if

//Preparamos el IN
lista_in="''"
for i = 1 to i_n_colegiados
	if not(f_es_vacio(i_id_col[i])) then
		if lista_in = '' then
			lista_in += "'" + i_id_col[i] + "'"
		else
			lista_in += ", '" + i_id_col[i] + "'"
		end if
	end if
next

//Comprobamos si se quieren consultar por todos o por alguno
if lista_in<>"''" then
	if idw_coincidencias_consulta.getitemstring(1,"rb_colegiados") = "T" then
		sql_nuevo += ' AND ((Select count(*) from fases_colegiados where fases.id_fase = fases_colegiados.id_fase AND fases_colegiados.id_col IN (' + lista_in + ')) = ' + string(i_n_colegiados) + ')'
	else
		sql_nuevo += ' AND (fases_colegiados.id_col IN (' + lista_in + '))'
	end if
end if

return sql_nuevo

end function

public function st_visared_importacion wf_importacion ();st_visared_importacion retorno
string fichero,archivo,archivo_t
int i,fila
listviewitem item
string tamano, firmado, certificado

fichero = g_directorio_temporal + i_archivo_ini

idw_incidencias.reset()

//Luego importamos los datos del fichero .ini o .exp

retorno = f_eimporta_importacion(fichero)

if retorno.id_expedi = '-1' then return retorno


	retorno.ds_documentos_visared = create datastore
	retorno.ds_documentos_visared.dataobject = 'd_fases_documentos_visared'
	retorno.fichero_importacion = fichero
	retorno.paquete_importacion = i_directorio + i_paquete
	
	//Importamos primero los archivos pdf adjuntos....
	
	for i = 1 to dw_documentos.rowcount()
		archivo = dw_documentos.getitemstring(i,'documento')
		tamano = dw_documentos.getitemstring(i,'tamano')
		firmado = dw_documentos.getitemstring(i,'firmado')
		certificado = dw_documentos.getitemstring(i,'certificado_valido')
		if f_eimporta_es_archivo_ini(archivo) then continue
		//Hemos seleccionado no descargar este fichero
		if dw_documentos.getitemstring(i,'descargar') = 'N' then continue

		// Controlamos que el nombre del archivo no exceda del m$$HEX1$$e100$$ENDHEX$$ximo permitido
		archivo_t = f_eimporta_truncar_nombre_archivo(archivo, f_tamanyo_columna(retorno.ds_documentos_visared, 'nombre_fichero'))
		if (archivo_t <> archivo) then
			Messagebox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n: El nombre del documento "' + archivo + '" excede la longitud m$$HEX1$$e100$$ENDHEX$$xima permitida para nombres de archivo, por lo que se truncar$$HEX2$$e1002000$$ENDHEX$$el nombre.', Exclamation!)
			gnv_fichero.of_filerename(g_directorio_temporal + archivo, g_directorio_temporal + archivo_t)
		end if

		fila = retorno.ds_documentos_visared.insertrow(0)
		retorno.ds_documentos_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
		retorno.ds_documentos_visared.setitem(fila, 'id_fase', '')
		retorno.ds_documentos_visared.setitem(fila, 'nombre_fichero', archivo_t)
		// LA ruta no la sabemos hasta que no grabemos y nos de el registro.
		//retorno.ds_documentos_visared.setitem(fila, 'ruta_fichero', g_directorio_importacion)
		retorno.ds_documentos_visared.setitem(fila, 'sellado', 'N')
		retorno.ds_documentos_visared.setitem(fila, 'fecha', datetime(today(),now()))
		retorno.ds_documentos_visared.setitem(fila,'visualizar_web','N')
		retorno.ds_documentos_visared.setitem(fila,'tamano',tamano)
		retorno.ds_documentos_visared.setitem(fila,'firmado',firmado)
		retorno.ds_documentos_visared.setitem(fila,'certificado_confianza',certificado)		
	next
	
	// A$$HEX1$$f100$$ENDHEX$$adimos el propio zip del paquete a la documentaci$$HEX1$$f300$$ENDHEX$$n del expediente
	if g_incorporar_zip_exp = 'S' then
		fila = retorno.ds_documentos_visared.insertrow(0)
		retorno.ds_documentos_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
		retorno.ds_documentos_visared.setitem(fila, 'id_fase', '')
		retorno.ds_documentos_visared.setitem(fila, 'nombre_fichero', i_paquete)
		// LA ruta no la sabemos hasta que no grabemos y nos de el registro.
		//retorno.ds_documentos_visared.setitem(fila, 'ruta_fichero', g_directorio_importacion)
		retorno.ds_documentos_visared.setitem(fila, 'sellado', 'N')
		retorno.ds_documentos_visared.setitem(fila, 'fecha', datetime(today(),now()))
		retorno.ds_documentos_visared.setitem(fila,'visualizar_web','N')
		retorno.ds_documentos_visared.setitem(fila,'tamano', dw_paquetes.GetItemString(dw_paquetes.getrow(), 'tamano'))
		retorno.ds_documentos_visared.setitem(fila,'firmado','Z')
		retorno.ds_documentos_visared.setitem(fila,'certificado_confianza','ZZ')		
		
		// Copiamos el paquete al directorio temporal para que se pueda importar al grabar la fase		
		// Usamos la funcion de la API que es mucho mas rapida		
		//gnv_fichero.of_filecopy(i_directorio + i_paquete, g_directorio_temporal + i_paquete)
		st_5.Text = 'Copiando el paquete a una carpeta temporal'

		If FileExists(g_directorio_temporal + i_paquete) then wf_bloqueo_fichero(g_directorio_temporal + i_paquete,false)
		if CopyFile(i_directorio + i_paquete, g_directorio_temporal + i_paquete,0)<>1 then 
			Messagebox(g_titulo,"Ocurrio un error al mover el paquete a la carpeta temporal",StopSign!)
		end if
	end if
	
	//Rellenamos las incidencias en el dw

	if retorno.ds_incidencias.rowcount()>0 then 
		retorno.ds_incidencias.RowsCopy(1,retorno.ds_incidencias.rowcount(),Primary!,idw_incidencias,1000,Primary!)
		st_5.Text = 'Debe revisar la lista de incidencias antes de continuar con la importaci$$HEX1$$f300$$ENDHEX$$n'
		idw_incidencias.Event rowfocuschanged(1)	
		tab_1.SelectTab(3)
	else	
		st_5.Text = 'El fichero es CORRECTO. Puede continuar con la importaci$$HEX1$$f300$$ENDHEX$$n.'
	end if

if not wf_comprobar_incidencias_graves() then
	retorno.id_expedi = '-1'
end if

return retorno

end function

public subroutine wf_borrar_paquete_bd (string as_paquete);string ls_id

select id into :ls_id from paquetes where fichero=:as_paquete;
delete from paquetes where id=:ls_id;
delete from paquetes_ficheros where id_paquete=:ls_id;
COMMIT;
end subroutine

public subroutine wf_bloqueo_fichero (string fichero, boolean protegido);long res,n_controles,al_valor=0,posicion,fila_fichero
string archivo,ls_estado

if g_verificador_autonomo='S' then
	posicion=lastpos(fichero,'\')
	archivo=mid(fichero,posicion+1)
	if rb_ver_bandeja_entrada.checked then
		ls_estado = "A"
	elseif rb_ver_elem_procesados.checked then
		ls_estado = "P"
	end if

	if protegido=true then
		update paquetes set bloqueado='S' where estado=:ls_estado and fichero=:archivo;
	else
		update paquetes set bloqueado='N' where estado=:ls_estado and fichero=:archivo;
	end if
	
else
	res=GetFileAttributesA(fichero)
	if res= -1 then 
		//messagebox("Error...","Al leer atributos.")
		return
	end if
	
	Checkbox as_Checkbox
	Checkbox as_Checkboxa[]
	
	
	FOR n_controles = 1 TO 14
		as_Checkboxa[n_controles]=create Checkbox
		as_Checkboxa[n_controles].checked = false
		if Int(Mod(res / (2 ^ (n_controles - 1)), 2)) > 0 then
			as_Checkboxa[n_controles].checked = true
		end if	
	next
	
	as_Checkboxa[1].checked=protegido //Check READONLY
	
	FOR n_controles = 1 TO 14
		if as_Checkboxa[n_controles].checked = true then
			al_valor=al_valor + (2^(n_controles -1 ))
		end if
	next
	
	SetFileAttributesA(fichero, al_valor )
end if
end subroutine

public subroutine wf_inicializa ();//********************************************************************************\\
//***																									 ***\\
//***		Esta funci$$HEX1$$f300$$ENDHEX$$n inicializa la estructura la variable g_fase_visared de   ***\\
//***		tipo st_visared_importacion.														 ***\\										
//***																									 ***\\
//***		Autor: Ismael Arcoba						Fecha: 14/09/2006						 ***\\
//***																									 ***\\
//********************************************************************************\\
 
setnull(g_fase_visared.ds_arquitectos)
setnull(g_fase_visared.ds_asociados)
setnull(g_fase_visared.ds_clientes)
setnull(g_fase_visared.ds_clientes_nuevos)
setnull(g_fase_visared.ds_coactfe_usos)
setnull(g_fase_visared.ds_coeficientes)
setnull(g_fase_visared.ds_coeficientes_cuota)
setnull(g_fase_visared.ds_coeficientes_m2)
setnull(g_fase_visared.ds_colegiados)
setnull(g_fase_visared.ds_constructores)
setnull(g_fase_visared.ds_datos_urbanisticos)
setnull(g_fase_visared.ds_detalle_fase)
setnull(g_fase_visared.ds_documentos_visared)
setnull(g_fase_visared.ds_estadisticas)
setnull(g_fase_visared.ds_honorarios)
setnull(g_fase_visared.ds_incidencias)
setnull(g_fase_visared.ds_informes)
setnull(g_fase_visared.ds_usos)
setnull(g_fase_visared.fichero_importacion)
setnull(g_fase_visared.id_expedi)
setnull(g_fase_visared.opcion_importacion)
setnull(g_fase_visared.paquete_importacion)
setnull(g_fase_visared.poblacion)

return













end subroutine

public function string wf_busqueda_coinc_clientes (string sql_nuevo);//Evento que concatena la busqueda de coincidencias por clientes
string sql_aux = ""
string lista_in
int i

if i_n_clientes = 0 then
	messagebox(g_titulo, 'No hay clientes para buscar.')
	return '-1'
end if

//Preparamos el IN
lista_in=""

//for i = 1 to i_n_clientes
//	if not(f_es_vacio(i_id_cli[i])) then
//		if lista_in = '' then
//			lista_in += "'" + i_id_cli[i] + "'"
//		else
//			lista_in += ", '" + i_id_cli[i] + "'"
//		end if
//	end if
//next
//

for i = 1 to i_n_clientes
	if i=1 then
		lista_in += "'" + i_nif_cli[i] + "'"
	else
		lista_in += ", '" + i_nif_cli[i] + "'"
	end if
next

//Comprobamos si se quieren consultar por todos o por alguno
if lista_in<>"''" then
	if idw_coincidencias_consulta.getitemstring(1,"rb_clientes") = "T" then
		sql_nuevo += ' AND ((Select count(*) from fases_clientes,clientes where fases.id_fase = fases_clientes.id_fase AND fases_clientes.id_cliente=clientes.id_cliente AND clientes.nif IN (' + lista_in + ')) = ' + string(i_n_clientes) + ')'
	else
		sql_nuevo += ' AND (fases_clientes.id_cliente in (select clientes.id_cliente from clientes where clientes.nif IN (' + lista_in + ')))'
	end if
end if
return sql_nuevo

end function

on w_eimporta_detalle_base.create
int iCurrent
call super::create
if this.MenuName = "m_eimporta" then this.MenuID = create m_eimporta
this.dw_paquetes=create dw_paquetes
this.rb_ver_elem_procesados=create rb_ver_elem_procesados
this.rb_ver_bandeja_entrada=create rb_ver_bandeja_entrada
this.pb_5=create pb_5
this.st_4=create st_4
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_2=create st_2
this.st_1=create st_1
this.p_logo=create p_logo
this.gb_2=create gb_2
this.dw_documentos=create dw_documentos
this.gb_1=create gb_1
this.tab_1=create tab_1
this.lb_1=create lb_1
this.st_3=create st_3
this.st_div=create st_div
this.st_div2=create st_div2
this.rb_otra_carpeta=create rb_otra_carpeta
this.st_5=create st_5
this.cb_obs=create cb_obs
this.cb_select_folder=create cb_select_folder
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_paquetes
this.Control[iCurrent+2]=this.rb_ver_elem_procesados
this.Control[iCurrent+3]=this.rb_ver_bandeja_entrada
this.Control[iCurrent+4]=this.pb_5
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.pb_4
this.Control[iCurrent+7]=this.pb_3
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.p_logo
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.dw_documentos
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.tab_1
this.Control[iCurrent+17]=this.lb_1
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.st_div
this.Control[iCurrent+20]=this.st_div2
this.Control[iCurrent+21]=this.rb_otra_carpeta
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.cb_obs
this.Control[iCurrent+24]=this.cb_select_folder
end on

on w_eimporta_detalle_base.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_paquetes)
destroy(this.rb_ver_elem_procesados)
destroy(this.rb_ver_bandeja_entrada)
destroy(this.pb_5)
destroy(this.st_4)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_logo)
destroy(this.gb_2)
destroy(this.dw_documentos)
destroy(this.gb_1)
destroy(this.tab_1)
destroy(this.lb_1)
destroy(this.st_3)
destroy(this.st_div)
destroy(this.st_div2)
destroy(this.rb_otra_carpeta)
destroy(this.st_5)
destroy(this.cb_obs)
destroy(this.cb_select_folder)
end on

event open;call super::open;event csd_inicializar_var_subsanacion()

zip = create n_oo_captura_errores

if g_verificador_autonomo = 'S' then
	rb_otra_carpeta.visible = false
else
	//Si tenemos la revision de firmas activa ponemos un dw, sino ponemos el otro
	rb_otra_carpeta.visible = true
	if g_activar_revision_firmas = 'N' then		
		dw_documentos.dataobject = 'd_eimporta_lista_documentos'
		dw_documentos.settrans(sqlca)
	end if
end if


idw_incidencias = tab_1.tabpage_1.dw_incidencias
idw_subsanacion_incidencias = tab_1.tabpage_1.dw_subsanacion_incidencias
idw_busqueda_consulta = tab_1.tabpage_2.dw_busqueda_consulta
idw_busqueda_lista = tab_1.tabpage_2.dw_busqueda_lista
idw_coincidencias_consulta = tab_1.tabpage_3.dw_coincidencias_consulta
idw_coincidencias_lista = tab_1.tabpage_3.dw_coincidencias_lista

of_setresize(true)

inv_resize.of_register (tab_1, "scaletoright&bottom")

inv_resize.of_register (idw_incidencias, "scaletoright&bottom")
inv_resize.of_register (idw_subsanacion_incidencias, "FixedToBottom&ScaleToRight")

inv_resize.of_register (idw_coincidencias_consulta, "scaletoright")
inv_resize.of_register (idw_coincidencias_lista, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_3.cb_importar_fase, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_3.cb_sel_fase, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_3.cb_abrir, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_3.gb_4, "scaletoright")
inv_resize.of_register (tab_1.tabpage_3.cb_buscar_coinc, "fixedtoright")

inv_resize.of_register (idw_busqueda_consulta, "scaletoright")
inv_resize.of_register (idw_busqueda_lista, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_2.cb_buscar, "fixedtoright")
inv_resize.of_register (tab_1.tabpage_2.cb_sel_fase2, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_2.cb_importar_fase2, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_2.cb_abrir2, "fixedtoright&bottom")
inv_resize.of_register (tab_1.tabpage_2.gb_3, "scaletoright")

inv_resize.of_register (st_5, "fixedtobottom")
inv_resize.of_register (gb_2, "fixedtobottom")
inv_resize.of_register (p_logo, "fixedtobottom")
inv_resize.of_register (st_4, "fixedtobottom")


inv_resize.of_register (pb_1, "fixedtobottom")
inv_resize.of_register (pb_2, "fixedtobottom")
inv_resize.of_register (pb_3, "fixedtobottom")
inv_resize.of_register (pb_4, "fixedtobottom")
inv_resize.of_register (pb_5, "fixedtobottom")

inv_resize.of_register (st_div, "scaletobottom")
inv_resize.of_register (dw_documentos, "scaletobottom")
inv_resize.of_register (gb_1, "scaletobottom")

idw_busqueda_consulta.event pfc_addrow()
idw_coincidencias_consulta.event pfc_addrow()

this.event csd_redimensionar()

if g_verificador_autonomo = 'S' then
	dw_paquetes.post event csd_refrescar_paquetes_verif()
else
	dw_paquetes.post event csd_refrescar_paquetes()
end if
//dw_paquetes.post event csd_refrescar()
 
end event

event pfc_preclose;call super::pfc_preclose;string archivo
//zip.close()
destroy zip


if not(ib_importado) then
	if FileExists(is_fichero_abierto) then f_bloqueo_fichero(is_fichero_abierto,false)
end if
		
		

return ancestorreturnvalue
end event

event close;call super::close;ChangeDirectory(g_dir_aplicacion)
end event

type cb_recuperar_pantalla from w_csd_sheet`cb_recuperar_pantalla within w_eimporta_detalle_base
integer y = 1388
integer taborder = 80
end type

type cb_guardar_pantalla from w_csd_sheet`cb_guardar_pantalla within w_eimporta_detalle_base
integer y = 1268
integer taborder = 50
end type

type dw_paquetes from u_csd_dw within w_eimporta_detalle_base
event csd_refrescar ( )
event csd_abrir ( )
event csd_enviar ( integer destino )
event csd_eliminar ( )
event csd_refrescar_paquetes ( )
event csd_refrescar_paquetes_verif ( )
event csd_desbloquear ( )
event csd_renombrar ( )
event csd_observaciones ( )
integer x = 55
integer y = 288
integer width = 1774
integer height = 564
integer taborder = 60
string dataobject = "d_eimporta_lista_paquetes"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_refrescar();if g_verificador_autonomo = 'S' then
	this.event csd_refrescar_paquetes_verif()
	dw_documentos.event csd_refrescar_verif()
else
	this.event csd_refrescar_paquetes()
	dw_documentos.event csd_refrescar()
end if


end event

event csd_abrir();int fila
string archivo

fila = this.getrow()
archivo = this.getitemstring(fila,'archivo')
f_abrir_fichero(i_directorio, archivo, "")

end event

event csd_enviar(integer destino);/*
string archivo,n_col,email
st_mail parametros

archivo = this.getitemstring(this.getrow(), 'archivo')

choose case destino
	case 1 // Bandeja de entrada
		if rb_ver_bandeja_entrada.checked then return
		gnv_fichero.of_filerename( i_directorio + archivo, g_directorio_importacion + archivo)
		this.event csd_refrescar()
	case 2 // Elmentos procesados
		if rb_ver_elem_procesados.checked then return
		gnv_fichero.of_filerename( i_directorio + archivo, g_directorio_importados + archivo)
		this.event csd_refrescar()
	case 3 // Enviar comunicacion al colegiado
		email=ProfileString(g_directorio_temporal+"\"+i_archivo_ini,"DESCRIPTORES","email","")
		n_col=ProfileString(g_directorio_temporal+"\"+i_archivo_ini,"CONTRATO","colegiado","")
				
		parametros.asunto = "Archivo Recibido "+dw_paquetes.GetItemString(dw_paquetes.GetRow(),'archivo')
		if trim(email)="" then 
			select email into :email from colegiados where n_colegiado=:n_col;			
		end if
		parametros.asunto = parametros.asunto + ". Colegiado n$$HEX1$$ba00$$ENDHEX$$"+n_col
		parametros.direccion = email
		parametros.mensaje = "Su proyecto ha sido recibido correctamente."
		parametros.dw_adjuntos='d_email_adjuntos'
		if g_sistema_mailing='O' then
			OpenWithParm(w_csd_mail_send, parametros)
		else
			OpenWithParm(w_csd_mail_send_sock, parametros)
		end if
end choose
*/
end event

event csd_eliminar();string archivo

archivo = this.getitemstring(this.getrow(), 'archivo')
if messagebox(g_titulo, '$$HEX1$$bf00$$ENDHEX$$Seguro que desea eliminar el archivo "' + archivo + '"?', Question!, YesNo!) = 1 then
	f_bloqueo_fichero(i_directorio + archivo,false)
	FileDelete(i_directorio + archivo)
	//Borro el archivo de la BD (si corresponde)
	if g_verificador_autonomo='S' then wf_borrar_paquete_bd(archivo)
	this.event csd_refrescar()
end if
end event

event csd_refrescar_paquetes();if rb_ver_bandeja_entrada.checked then
	i_directorio = g_directorio_importacion
elseif rb_ver_elem_procesados.checked then
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

event csd_refrescar_paquetes_verif();datastore ds_paquetes
string ls_estado
integer i, li_ret, li_cuantos
string id, fichero, observ, fich_log, tamano
datetime fecha


if rb_ver_bandeja_entrada.checked then
	i_directorio = g_directorio_importacion
	ls_estado = "A"
elseif rb_ver_elem_procesados.checked then
	i_directorio = g_directorio_importados
	ls_estado = "P"
end if

ds_paquetes = create datastore

ds_paquetes.dataobject = 'd_eimporta_lista_paquetes_verificador'
ds_paquetes.SetTransObject(SQLCA)
li_cuantos = ds_paquetes.retrieve(ls_estado)

this.setredraw(false)
this.reset()

//Traslado la informacion del datastore al dw.
for i=1 to li_cuantos
	this.insertrow(0)
	li_ret = this.SetItem(i, 'id', ds_paquetes.GetItemString(i, 'id'))
	li_ret = this.SetItem(i, 'archivo', ds_paquetes.GetItemString(i, 'fichero'))
	li_ret = this.SetItem(i, 'fecha', ds_paquetes.GetItemDateTime(i, 'f_entrada'))
	li_ret = this.SetItem(i, 'estado', ls_estado)
	li_ret = this.SetItem(i, 'observaciones', ds_paquetes.GetItemString(i, 'observaciones'))
	li_ret = this.SetItem(i, 'fichero_log', ds_paquetes.GetItemString(i, 'fichero_log'))
	li_ret = this.SetItem(i, 'tamano', ds_paquetes.GetItemString(i, 'tamanyo'))
next

this.object.fecha_t.text = 'Fecha Entrada'

this.sort()
this.selectrow(0, false)
this.selectrow(this.getrow(), true)
this.setredraw(true)


destroy ds_paquetes
end event

event csd_desbloquear();string fichero

fichero  = i_directorio + dw_paquetes.GetItemString(dw_paquetes.GetRow(),'archivo')

if is_fichero_abierto<>fichero then wf_bloqueo_fichero(fichero,false)
end event

event csd_renombrar();integer res,li_rc

string nombre,nombre_nuevo,ruta,ruta_dest

nombre=this.GetItemString(this.GetRow(),'archivo')
OpenWithParm(w_sellador_cambio_nombre,nombre)
nombre_nuevo=Message.StringParm

if nombre_nuevo<>'-1' then 
	
	if rb_ver_bandeja_entrada.checked then
		ruta=g_directorio_importacion+nombre
		ruta_dest=g_directorio_importacion+nombre_nuevo
	else
		ruta=g_directorio_importados+nombre	
		ruta_dest=g_directorio_importados+nombre_nuevo
	end if

	res=FileOpen(ruta,LineMode!,Write!,LockReadWrite!,Append!)
	
	if res<1 then
		wf_bloqueo_fichero(ruta,false)
		//MessageBox("FICHERO EN USO","El fichero est$$HEX2$$e1002000$$ENDHEX$$en uso. Es posible que otra persona est$$HEX2$$e9002000$$ENDHEX$$importandolo en este momento o que el fichero se est$$HEX2$$e9002000$$ENDHEX$$recibiendo por FTP."+cr+"Si est$$HEX2$$e1002000$$ENDHEX$$seguro que no se encuentra en uso, puede desbloquearlo con el boton derecho->desbloquear",StopSign!)
		//return
	else
		FileClose(res)
	end if
		
	
	li_rc=gnv_fichero.of_filerename(ruta,ruta_dest) 
	
	if li_rc=-1 then
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$algun error al renombrar el fichero. $$HEX1$$bf00$$ENDHEX$$Fichero bloqueado?",StopSign!)
		return
	else
		this.SetItem(this.GetRow(),'archivo',nombre_nuevo)
	end if
	
	
	// Si estaba bloqueado volvemos a poner el bloqueo.
	if res<1 then
		wf_bloqueo_fichero(ruta_dest,true)
	end if

	// Si el fichero que hemos cambiado el nombre era el que estaba abierto, actualizamos el nuevo nombre en la variable
	if is_fichero_abierto=ruta then
		is_fichero_abierto=ruta_dest
	end if

end if

end event

event csd_observaciones();// A implementar en el hijo
end event

event constructor;call super::constructor;this.of_SetRowSelect(true)
this.of_SetSort(true)


// Column header sort
inv_sort.of_SetColumnHeader(true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event rbuttonup;call super::rbuttonup;m_eimporta_explora_paquetes menu

if this.getrow() <= 0 then return

menu = create m_eimporta_explora_paquetes
menu.idw_padre = this
	
menu.PopMenu(w_aplic_frame.PointerX() + 5, w_aplic_frame.PointerY() + 10)

destroy menu

end event

event clicked;call super::clicked;string archivo,ls_estado,bloqueado
int res

choose case dwo.name
	case 'archivo','tamano','fecha'
		if leftA(this.GetItemString(row,'archivo'),11)='IMPORTACION' then return
		
		i_coincidencia=""
		if rb_ver_bandeja_entrada.checked then
			ls_estado = "A"
		elseif rb_ver_elem_procesados.checked then
			ls_estado = "P"
		end if		
		// COMPROBAMOS SI EL FICHERO YA ESTA ABIERTO
		archivo=dw_paquetes.GetItemString(dw_paquetes.GetRow(),'archivo')
		select bloqueado into :bloqueado from paquetes where estado=:ls_estado and fichero=:archivo;		
		archivo=i_directorio+archivo
		
		if  g_verificador_autonomo = 'S' then
			wf_bloqueo_fichero(is_fichero_abierto,false)
			if is_fichero_abierto<>archivo and bloqueado='S' then
				MessageBox("FICHERO EN USO","El fichero est$$HEX2$$e1002000$$ENDHEX$$en uso. Es posible que otra persona est$$HEX2$$e9002000$$ENDHEX$$importandolo en este momento o que el fichero se est$$HEX2$$e9002000$$ENDHEX$$recibiendo por FTP."+cr+"Si est$$HEX2$$e1002000$$ENDHEX$$seguro que no se encuentra en uso, puede desbloquearlo con el boton derecho->desbloquear",StopSign!)
				return					
			end if
			dw_documentos.PostEvent('csd_refrescar_verif')
			open(w_eimporta_extrayendo)
		else

			if is_fichero_abierto<>archivo then //Saltamos la comprobacion si es el fichero que tenemos abierto nosotros
				wf_bloqueo_fichero(is_fichero_abierto,false)
				res=FileOpen(archivo,LineMode!,Write!,LockReadWrite!,Append!)
				
				if res<1 then
					MessageBox("FICHERO EN USO","El fichero est$$HEX2$$e1002000$$ENDHEX$$en uso. Es posible que otra persona est$$HEX2$$e9002000$$ENDHEX$$importandolo en este momento o que el fichero se est$$HEX2$$e9002000$$ENDHEX$$recibiendo por FTP."+cr+"Si est$$HEX2$$e1002000$$ENDHEX$$seguro que no se encuentra en uso, puede desbloquearlo con el boton derecho->desbloquear",StopSign!)
					return
				end if
				FileClose(res)
			end if			
						
			// Si no est$$HEX2$$e1002000$$ENDHEX$$abierto, mostramos el contenido
			dw_documentos.PostEvent('csd_refrescar')
			open(w_eimporta_procesando)
		end if
		//dw_documentos.Event csd_refrescar()
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;//dw_documentos.event csd_refrescar()
end event

type rb_ver_elem_procesados from u_rb within w_eimporta_detalle_base
integer x = 855
integer y = 56
integer width = 603
integer taborder = 40
string text = "Elementos procesados"
end type

event clicked;call super::clicked;rb_ver_bandeja_entrada.checked = false
rb_ver_elem_procesados.checked = true
rb_otra_carpeta.checked=false

cb_select_folder.visible = false

if g_verificador_autonomo = 'S' then
	dw_paquetes.event csd_refrescar_paquetes_verif()
else
	dw_paquetes.event csd_refrescar_paquetes()
end if

dw_documentos.reset()

pb_1.enabled=false
pb_2.enabled=false
pb_3.enabled=false
//dw_paquetes.event csd_refrescar()

end event

type rb_ver_bandeja_entrada from u_rb within w_eimporta_detalle_base
integer x = 320
integer y = 56
integer width = 571
integer taborder = 30
string text = "Bandeja de entrada"
boolean checked = true
end type

event clicked;call super::clicked;rb_ver_bandeja_entrada.checked = true
rb_ver_elem_procesados.checked = false
rb_otra_carpeta.checked=false

cb_select_folder.visible = false

if g_verificador_autonomo = 'S' then
	dw_paquetes.event csd_refrescar_paquetes_verif()
else
	dw_paquetes.event csd_refrescar_paquetes()
end if

dw_documentos.reset()

pb_1.enabled=false
pb_2.enabled=false
pb_3.enabled=false
//dw_paquetes.event csd_refrescar()
end event

type pb_5 from u_pb within w_eimporta_detalle_base
integer x = 1147
integer y = 1684
integer width = 343
integer height = 112
integer taborder = 130
string text = "Descargar"
end type

event clicked;call super::clicked;st_correos_recibidos recibidos
int descargados

recibidos = f_eimporta_comprobar_correo()

if recibidos.codigo[1] <> -1 then
	openwithparm(w_eimporta_lista_correos,recibidos)
	recibidos = message.powerobjectparm
end if

if recibidos.codigo[1] <> -1 then
	descargados = f_eimporta_descargar_correo(recibidos)
end if

if descargados > 0 then
	messagebox(g_titulo,'Se han descargado correctamente ' + string(descargados) + " paquetes a la bandeja de entrada")
end if

rb_ver_bandeja_entrada.event clicked()

end event

type st_4 from statictext within w_eimporta_detalle_base
boolean visible = false
integer x = 1925
integer y = 2160
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 1090519039
long backcolor = 255
boolean focusrectangle = false
end type

type pb_4 from u_pb within w_eimporta_detalle_base
integer x = 1513
integer y = 1684
integer width = 343
integer height = 112
integer taborder = 140
string text = "Salir"
end type

event clicked;call super::clicked;// Borramos el contenido del directorio temporal por los ficheros que se hayan extraido en el
gnv_fichero.of_deltree(g_directorio_temporal)
gnv_fichero.of_CreateDirectory(g_directorio_temporal)

// Nota: no se debe borrar el directorio temporal en el evento close pq al continuar la importaci$$HEX1$$f300$$ENDHEX$$n la ventana de fases espera encontrar en $$HEX1$$e900$$ENDHEX$$l los documentos despu$$HEX1$$e900$$ENDHEX$$s de que se haya cerrado esta ventana
//f_bloqueo_fichero(i_directorio+dw_paquetes.GetItemString(dw_paquetes.GetRow(),'archivo'),false)
Close(parent)

end event

type pb_3 from u_pb within w_eimporta_detalle_base
integer x = 782
integer y = 1684
integer width = 343
integer height = 112
integer taborder = 120
boolean enabled = false
string text = "Validar"
end type

event clicked;call super::clicked;setpointer(HourGlass!)

g_fase_visared = wf_importacion()

setpointer(Arrow!)

end event

type pb_2 from u_pb within w_eimporta_detalle_base
integer x = 416
integer y = 1684
integer width = 343
integer height = 112
integer taborder = 110
boolean enabled = false
string text = "Previsualizar"
end type

event clicked;call super::clicked;string fichero


fichero = g_directorio_temporal + i_archivo_ini

if f_eimporta_es_archivo_ini(i_archivo_ini) then
	OpenWithParm(w_visared_previsualizacion,fichero)
else
	Messagebox(g_titulo,'El fichero no tiene una extensi$$HEX1$$f300$$ENDHEX$$n v$$HEX1$$e100$$ENDHEX$$lida.')
end if

end event

type pb_1 from u_pb within w_eimporta_detalle_base
integer x = 50
integer y = 1684
integer width = 343
integer height = 112
integer taborder = 100
boolean enabled = false
string text = "Importar"
end type

event clicked;call super::clicked;setpointer(HourGlass!)

wf_inicializa()

g_fase_visared = wf_importacion()

setpointer(Arrow!)

// A extender en los hijos
end event

type st_2 from statictext within w_eimporta_detalle_base
integer x = 101
integer y = 212
integer width = 407
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

type st_1 from statictext within w_eimporta_detalle_base
integer x = 101
integer y = 56
integer width = 247
integer height = 52
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Carpetas :"
boolean focusrectangle = false
end type

type p_logo from u_p within w_eimporta_detalle_base
integer x = 37
integer y = 2032
integer width = 1829
integer height = 220
boolean bringtotop = true
string picturename = "Imagenes\logo_hor.gif"
end type

event constructor;call super::constructor;this.picturename= g_directorio_imagenes + 'logo_hor.gif'

if not fileexists(g_directorio_imagenes + 'logo_hor.gif') then this.visible = false
end event

type gb_2 from groupbox within w_eimporta_detalle_base
integer x = 41
integer y = 1792
integer width = 1829
integer height = 224
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
end type

type dw_documentos from u_csd_dw within w_eimporta_detalle_base
event csd_revisar_todos ( )
event csd_revisar_fichero ( )
event csd_abrir ( )
event csd_refrescar ( )
event csd_refrescar_verif ( )
integer x = 55
integer y = 944
integer width = 1774
integer height = 680
integer taborder = 70
string dataobject = "d_eimporta_lista_documentos_firmas"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_revisar_todos();string fichero_pdf,mensaje,texto_error
u_revision_firmas revisor
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
	dw_documentos.setitem(i,'numero_firmas',lst_validacion.num_firmas)	
	
	texto_error+='('+string(i)+') '+revisor.of_devolver_error(lst_validacion)
next

st_5.text=texto_error

/*
int i,j,k
int num_firmas,num_revisiones 
string firmantes
boolean firma_valida,todos_validos=true,todos_firmados=true
boolean certificados_validos
string fichero_pdf
string texto_ant,texto=""
u_revision_firmas revisor

revisor = create u_revision_firmas

st_5.Alignment = Center!

for i = 1 to dw_documentos.rowcount()

	firma_valida = true
	certificados_validos = true
	fichero_pdf = dw_documentos.getitemstring(i,'documento')
	st_5.text = 'Revisando documento ' + string(i) + ' de ' + string(dw_documentos.rowcount())

	firmantes = ''
	num_firmas = 0
	
	if upper(right(fichero_pdf,3))='PDF' then
			//Comprobamos las firmas
			revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
			revisor.is_nombre_fichero_ini = g_directorio_temporal + left(fichero_pdf,len(fichero_pdf) - 4) + ".ini"
			revisor.of_leer_certificado(true)
	
			num_firmas = revisor.ii_num_firmas
			num_revisiones = revisor.ii_num_revisiones
			//A$$HEX1$$f100$$ENDHEX$$adimos los firmantes y comprobamos la validez de todas las firmas
			for j = 1 to num_firmas
				if firmantes = '' then
					firmantes = revisor.is_cn_certificado[j]
				else
					firmantes += cr + revisor.is_cn_certificado[j]
				end if
				if revisor.ib_firma_caducada[j] = true or revisor.ib_certificado_valido[j] = false or revisor.is_error_firma[j] = '-2' or revisor.is_error_firma[j] = '-4' then 
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
				todos_firmados=false
			end if
			// V - Firmado la ultima firma Valida (es la que engloba todo el documento)
			if num_firmas > 0 and firma_valida = true and num_firmas = num_revisiones then 
				dw_documentos.setitem(i,'firmado','V')
			end if
			// F - Firmado pero la ultima firma Valida no es valida
			if num_firmas > 0 and (firma_valida = false or num_firmas <> num_revisiones) then 
				dw_documentos.setitem(i,'firmado','F')
				todos_firmados=false
			end if
			// E - Error validando la firma
			if num_firmas < 0 then 
				dw_documentos.setitem(i,'firmado','E')
				num_firmas = 0
				todos_firmados=false
			end if	
			
			//Segun el certificado, lo guardamos.
			if certificados_validos = true then
				dw_documentos.setitem(i,'certificado_valido','CV')
			end if
			
			if certificados_validos = false or num_firmas = 0 then
				todos_validos=false
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
texto=""
if not(todos_firmados) then texto="Alguno de los documentos no est$$HEX1$$e100$$ENDHEX$$n firmados."	
if not(todos_validos) then texto+="No se encuentra la clave publica de alguno de los certificados"	
if todos_validos then texto="La revisi$$HEX1$$f300$$ENDHEX$$n de firmas fue correcta"

st_5.text=texto
	


destroy revisor*/
end event

event csd_revisar_fichero();string fichero_pdf
u_revision_firmas revisor
st_eimporta_validacion_certificado lst_validacion

revisor=create u_revision_firmas

fichero_pdf = dw_documentos.getitemstring(dw_documentos.getrow(),'documento')

lst_validacion=revisor.of_revisar_fichero(g_directorio_temporal + fichero_pdf,true,true)

dw_documentos.setitem(dw_documentos.getrow(),'firmado',lst_validacion.firma_valida)
dw_documentos.setitem(dw_documentos.getrow(),'certificado_valido',lst_validacion.certificado_valido)
dw_documentos.setitem(dw_documentos.getrow(),'numero_firmas',lst_validacion.num_firmas)	

st_5.text=revisor.of_devolver_error(lst_validacion)
/*
int i,j,k
int num_firmas, num_revisiones
string firmantes
boolean firma_valida
boolean certificados_validos = true,certificado_caducado=false
string fichero_pdf
u_revision_firmas revisor

revisor = create u_revision_firmas
firma_valida = true
i = dw_documentos.getrow()

fichero_pdf = dw_documentos.getitemstring(i,'documento')

if upper(right(fichero_pdf,3))='PDF' then
	//Comprobamos las firmas
	revisor.is_nombre_fichero_pdf = g_directorio_temporal + fichero_pdf
	revisor.is_nombre_fichero_ini = g_directorio_temporal + left(fichero_pdf,len(fichero_pdf) - 4) + ".ini"
	revisor.of_leer_certificado(true)

	firmantes = ''
	num_firmas = revisor.ii_num_firmas
	num_revisiones = revisor.ii_num_revisiones
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
		
		if revisor.ib_firma_caducada[j] = true then
			certificado_caducado = true
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
	if num_firmas > 0 and firma_valida = true and num_firmas = num_revisiones then 
		dw_documentos.setitem(i,'firmado','V')
	end if
	// F - Firmado pero la ultima firma Valida no es valida
	if num_firmas > 0 and (firma_valida = false or num_firmas <> num_revisiones) then 
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
	
	if certificado_caducado=true or certificados_validos = false or num_firmas = 0 then
		dw_documentos.setitem(i,'certificado_valido','NV')
	end if
		
	dw_documentos.setitem(i,'numero_firmas',num_firmas)
	dw_documentos.setitem(i,'firmantes',firmantes)
end if

if certificado_caducado=true then
	st_5.text="Alguno de los certificados est$$HEX2$$e1002000$$ENDHEX$$caducado"
elseif certificados_validos=false then
	st_5.text="No se encuentra la clave publica de alguno de los certificados"
else
	st_5.text="La revisi$$HEX1$$f300$$ENDHEX$$n de firmas fue correcta"
end if
	
destroy revisor
*/

end event

event csd_abrir;int fila
string archivo

fila = this.getrow()
archivo = this.getitemstring(fila,'documento')
f_abrir_fichero(g_directorio_temporal, archivo, "")

end event

event csd_refrescar();boolean hay_ini,hay_exp,hay_fase,caracteres_no_validos
long i,valor
int retorno1,cuantos
string fichero,n_registro_importado,n_expedi_importado,n_reg,n_exp,id_fase
string opcion_visared, comentario_visared
int cuantos_ficheros


caracteres_no_validos=false
pb_1.enabled=false
pb_2.enabled=false
pb_3.enabled=false
cb_obs.visible=false	
if dw_paquetes.rowcount()=0 then 
	this.reset()
	return
end if

/*
// Si el paquete que seleccionamos anteriormente es el mismo, evitamos que recargue el zip
if i_paquete=dw_paquetes.GetItemString(dw_paquetes.getrow(), 'archivo') then 
	close(w_eimporta_procesando)
	return
end if
*/
idw_incidencias.reset()
idw_subsanacion_incidencias.reset()

// Borramos el contenido del directorio temporal para extraer los ficheros
valor=gnv_fichero.of_deltree(g_directorio_temporal)
valor=gnv_fichero.of_CreateDirectory(g_directorio_temporal)

this.reset()
this.object.documento_t.text = 'Documentos'

if dw_paquetes.getrow() <= 0 then
	pb_1.enabled = false
	pb_2.enabled = false
	pb_3.enabled = false
		
	m_eimporta.of_menu_eimporta_previsualizar().enabled = false
	m_eimporta.of_menu_eimporta_validar().enabled = false
	m_eimporta.of_menu_eimporta_importar().enabled = false
	close(w_eimporta_procesando)
	return
end if

i_paquete = dw_paquetes.GetItemString(dw_paquetes.getrow(), 'archivo')
if f_es_vacio(i_paquete) then
	close(w_eimporta_procesando)
	return // Esto ocurre cuando se est$$HEX2$$e1002000$$ENDHEX$$rellenando la lista de paquetes
end if


i_documentos_mal = ''
f_dw_resaltar_fila(this, '','0',0)
this.setredraw(false)

ids_incidencias = create datastore
ids_incidencias.dataobject = 'd_visared_incidencias'



fichero = i_directorio + i_paquete
if not FileExists(fichero) then 
	close(w_eimporta_procesando)
	return
end if

if f_comprobar_sawzip(zip)=-1 then
	close(w_eimporta_procesando)
	return
end if
	
/*
retorno1 = zip.ConnectToNewObject("SAWZip.Archive")
if retorno1 < 0 then
	close(w_eimporta_procesando)
	Messagebox(g_titulo, "No se puede acceder a la librer$$HEX1$$ed00$$ENDHEX$$a de manipulaci$$HEX1$$f300$$ENDHEX$$n de zips (SAWZip). Deber$$HEX2$$e1002000$$ENDHEX$$reinstalar la aplicaci$$HEX1$$f300$$ENDHEX$$n.")
	return
end if	*/


zip.of_capturar_errores(true) // Evita que la aplicaci$$HEX1$$f300$$ENDHEX$$n pete si el zip est$$HEX2$$e1002000$$ENDHEX$$corrupto
zip.Open(fichero) 
if zip.i_resultcode <> 0 then
	st_5.text = "Error al abrir el zip. Es posible que el archivo est$$HEX2$$e9002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado."
	zip.Close()
	close(w_eimporta_procesando)
	this.setredraw(true)
	return
end if


is_fichero_abierto=fichero
wf_bloqueo_fichero(fichero,true)

	

zip.of_capturar_errores(false)

// Por alguna extra$$HEX1$$f100$$ENDHEX$$a raz$$HEX1$$f300$$ENDHEX$$n el m$$HEX1$$e900$$ENDHEX$$todo zip.extract permite que mientras se ejecuta se procesen eventos en espera.
// Por ello deshabilitamos los controles que pueden provocar otro refresco mientras este no haya acabado.
rb_ver_bandeja_entrada.enabled = false
rb_ver_elem_procesados.enabled = false
dw_paquetes.enabled = false
dw_documentos.enabled = false

hay_ini=false
i_archivo_ini=''

cuantos_ficheros = zip.files.count
st_5.Alignment = Center!
SetPointer(HourGlass!)

for i = 1 to cuantos_ficheros
	yield()
	if g_interrupt then
		g_interrupt=false
		if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea interrumpir el proceso?",Question!,YesNo!)=1 then			
			close(w_eimporta_procesando)
			st_5.text="Proceso cancelado por el usuario"
			dw_paquetes.enabled = true
			rb_ver_bandeja_entrada.enabled = true
			rb_ver_elem_procesados.enabled = true
			dw_documentos.enabled = true			
			this.reset()
			this.setredraw(true)
			return
		end if
	end if
	st_5.text = 'Extrayendo fichero ' + string(i) + ' de ' + string(cuantos_ficheros)
	if f_eimporta_es_archivo_ini(zip.Files.Item(i -1).name) then
			i_archivo_ini=zip.Files.Item(i -1).name
			hay_ini=true
	elseif lower(zip.Files.Item(i -1).name)='observaciones.txt' then
		cb_obs.visible=true		
	end if
	zip.Files.Item(i -1).extract(g_directorio_temporal)
	//Le quitamos los atributos al fichero por si acaso tenia alguno
	valor = gnv_fichero.of_setfileattributes(zip.Files.Item(i -1).name, false,false,false,false)	
	if Not(f_parsea_fichero(zip.Files.Item(i -1).name)) then
		caracteres_no_validos=true
	end if
	wf_revisar_firmas(zip.Files.Item(i -1).name)	
next

if caracteres_no_validos then
	close(w_eimporta_procesando)
	MessageBox("Caracteres NO validos","El zip contiene ficheros con caracteres no validos",StopSign!)
	dw_paquetes.enabled = true
	this.setredraw(true)
	return
end if

zip.close()
//destroy zip
//
close(w_eimporta_procesando)
rb_ver_bandeja_entrada.enabled = true
rb_ver_elem_procesados.enabled = true
dw_paquetes.enabled = true
dw_documentos.enabled = true

st_5.Alignment = Left!
SetPointer(Arrow!)

if not hay_ini then
	st_5.text = "El zip no contiene un archivo INI."
	return
end if

pb_1.enabled = true 
pb_2.enabled = true 
pb_3.enabled = true
m_eimporta.of_menu_eimporta_previsualizar().enabled = true
m_eimporta.of_menu_eimporta_validar().enabled = true
m_eimporta.of_menu_eimporta_importar().enabled = true

this.object.documento_t.text = 'Documentos ('+ string(this.rowcount()) + ')'

if ids_incidencias.rowcount() > 0 then
	ids_incidencias.RowsCopy(1,ids_incidencias.rowcount(),Primary!,idw_incidencias,1000,Primary!)
	st_5.Text = 'Existen ficheros en mal estado, debe revisar la lista de incidencias'
	idw_incidencias.Event rowfocuschanged(1)	
	tab_1.SelectTab(3)
else
	st_5.text='Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'
end if

this.sort()

this.setredraw(true)

parent.event csd_cargar_coincidencias(g_directorio_temporal + i_archivo_ini)

//Leemos la opcion de importacion que nos ha enviado el colegiado y el comentario
opcion_visared = ProfileString(g_directorio_temporal + i_archivo_ini,"DESCRIPTORES","TIPO","")
comentario_visared = ProfileString(g_directorio_temporal + i_archivo_ini,"DESCRIPTORES","COMENTARIO","")

choose case opcion_visared
	case 'NUEVO'
		st_5.text = 'Nuevo env$$HEX1$$ed00$$ENDHEX$$o - ' + comentario_visared
	case 'SUBSA'
		st_5.text = 'Subsanaci$$HEX1$$f300$$ENDHEX$$n reparo - ' + comentario_visared
	case 'ANEXO'
		st_5.text = 'Anexo de documentos - ' + comentario_visared
end choose

g_interrupt=false

//st_5.text += cr + 'Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'

end event

event csd_refrescar_verif();string fichero, opcion_visared, comentario_visared
long valor
int retorno, cuantos_ficheros, i, li_cuantos
boolean hay_ini
datastore ds_documentos

pb_1.enabled = false
pb_2.enabled = false
pb_3.enabled = false

if dw_paquetes.rowcount()=0 then 
	this.reset()
	return
end if
// Si el paquete que seleccionamos anteriormente es el mismo, evitamos que recargue el zip
if i_paquete=dw_paquetes.GetItemString(dw_paquetes.getrow(), 'archivo') then 
	close(w_eimporta_extrayendo)
	return
end if

idw_incidencias.reset()
idw_subsanacion_incidencias.reset()

// Borramos el contenido del directorio temporal para extraer los ficheros
valor=gnv_fichero.of_deltree(g_directorio_temporal)
valor=gnv_fichero.of_CreateDirectory(g_directorio_temporal)

this.reset()
this.object.documento_t.text = 'Documentos'

if dw_paquetes.getrow() <= 0 then
	pb_1.enabled = false
	pb_2.enabled = false
	pb_3.enabled = false
		
	m_eimporta.of_menu_eimporta_previsualizar().enabled = false
	m_eimporta.of_menu_eimporta_validar().enabled = false
	m_eimporta.of_menu_eimporta_importar().enabled = false
	close(w_eimporta_extrayendo)
	return
end if

i_paquete=dw_paquetes.GetItemString(dw_paquetes.getrow(), 'archivo')
i_id_paquete=dw_paquetes.GetItemString(dw_paquetes.getrow(), 'id')

if f_es_vacio(i_paquete) then
	close(w_eimporta_extrayendo)
	return // Esto ocurre cuando se est$$HEX2$$e1002000$$ENDHEX$$rellenando la lista de paquetes
end if


zip = create n_oo_captura_errores

f_dw_resaltar_fila(this, '','0',0)
this.setredraw(false)

fichero = i_directorio + i_paquete
if not FileExists(fichero) then 
	st_5.text="El fichero no existe.Compruebe las rutas"
	close(w_eimporta_extrayendo)
	this.setredraw(true)
	return
end if

retorno = zip.ConnectToNewObject("SAWZip.Archive")
if retorno < 0 then
	close(w_eimporta_extrayendo)
	Messagebox(g_titulo, "No se puede acceder a la librer$$HEX1$$ed00$$ENDHEX$$a de manipulaci$$HEX1$$f300$$ENDHEX$$n de zips (SAWZip). Deber$$HEX2$$e1002000$$ENDHEX$$reinstalar la aplicaci$$HEX1$$f300$$ENDHEX$$n.")
	this.setredraw(true)
	return
end if	

zip.of_capturar_errores(true) // Evita que la aplicaci$$HEX1$$f300$$ENDHEX$$n pete si el zip est$$HEX2$$e1002000$$ENDHEX$$corrupto
zip.Open(fichero) 
if zip.i_resultcode <> 0 then
	st_5.text = "Error al abrir el zip. Es posible que el archivo est$$HEX2$$e9002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado."
	close(w_eimporta_extrayendo)
	this.setredraw(true)
	return
end if

is_fichero_abierto=fichero
wf_bloqueo_fichero(fichero,true)

zip.of_capturar_errores(false)

// Por alguna extra$$HEX1$$f100$$ENDHEX$$a raz$$HEX1$$f300$$ENDHEX$$n el m$$HEX1$$e900$$ENDHEX$$todo zip.extract permite que mientras se ejecuta se procesen eventos en espera.
// Por ello deshabilitamos los controles que pueden provocar otro refresco mientras este no haya acabado.
rb_ver_bandeja_entrada.enabled = false
rb_ver_elem_procesados.enabled = false
dw_paquetes.enabled = false
dw_documentos.enabled = false

hay_ini=false
i_archivo_ini=''

cuantos_ficheros = zip.files.count
st_5.Alignment = Center!
SetPointer(HourGlass!)
//Cargamos el ds.
ds_documentos = create datastore
ds_documentos.dataobject = 'd_eimporta_lista_documentos_verificador'
ds_documentos.SetTransObject(SQLCA)
li_cuantos = ds_documentos.retrieve(i_id_paquete)

//Extraemos los ficheros al directorio temporal para poder trabajar con ellos.
for i = 1 to li_cuantos
	yield()
	if g_interrupt then
		g_interrupt=false
		if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro que desea interrumpir el proceso?",Question!,YesNo!)=1 then			
			close(w_eimporta_extrayendo)
			st_5.text="Proceso cancelado por el usuario"
			rb_ver_bandeja_entrada.enabled = true
			rb_ver_elem_procesados.enabled = true
			dw_documentos.enabled = true
			dw_paquetes.enabled = true
			this.reset()
			this.setredraw(true)
			return
		end if
	end if
	st_5.text = 'Extrayendo fichero ' + string(i) + ' de ' + string(li_cuantos)
	if f_eimporta_es_archivo_ini(zip.Files.Item(i -1).name) then
			i_archivo_ini=zip.Files.Item(i -1).name
			hay_ini=true
	end if
	zip.Files.Item(i -1).extract(g_directorio_temporal)
	//Le quitamos los atributos al fichero por si acaso tenia alguno
	valor = gnv_fichero.of_setfileattributes(zip.Files.Item(i -1).name, false,false,false,false)	
	//A$$HEX1$$f100$$ENDHEX$$ado la fila con el documento
	this.insertRow(0)
	retorno = this.SetItem(i, 'id_fichero', ds_documentos.GetItemString(i, 'id'))
	retorno = this.SetItem(i, 'id_paquete', ds_documentos.GetItemString(i, 'id_paquete'))
	retorno = this.SetItem(i, 'documento', ds_documentos.GetItemString(i, 'nombre_fichero'))
	retorno = this.SetItem(i, 'es_pdf', ds_documentos.GetItemString(i, 'es_pdf'))
	retorno = this.SetItem(i, 'firmado', ds_documentos.GetItemString(i, 'firma'))
	retorno = this.SetItem(i, 'certificado_valido', ds_documentos.GetItemString(i, 'certificado'))
	retorno = this.SetItem(i, 'fecha', ds_documentos.GetItemDateTime(i, 'f_modificacion'))
	retorno = this.SetItem(i, 'tamano', ds_documentos.GetItemString(i, 'tamanyo'))
	retorno = this.SetItem(i, 'firmantes', ds_documentos.GetItemString(i, 'firmantes'))
next

zip.close()

close(w_eimporta_extrayendo)
rb_ver_bandeja_entrada.enabled = true
rb_ver_elem_procesados.enabled = true
dw_paquetes.enabled = true
dw_documentos.enabled = true

st_5.Alignment = Left!
SetPointer(Arrow!)

if not hay_ini then 
	st_5.text = "El zip no contiene un archivo INI."
else
	st_5.text='Pulse el bot$$HEX1$$f300$$ENDHEX$$n "Importar" para comenzar el proceso de importaci$$HEX1$$f300$$ENDHEX$$n o el de "Cancelar" para cerrar la ventana sin importar.'
	pb_1.enabled = true 
	pb_2.enabled = true 
	pb_3.enabled = true
	m_eimporta.of_menu_eimporta_previsualizar().enabled = true
	m_eimporta.of_menu_eimporta_validar().enabled = true
	m_eimporta.of_menu_eimporta_importar().enabled = true
end if

this.object.documento_t.text = 'Documentos ('+ string(this.rowcount()) + ')'

this.sort()
this.setredraw(true)

if hay_ini then 
	parent.event csd_cargar_coincidencias(g_directorio_temporal + i_archivo_ini)

	//Leemos la opcion de importacion que nos ha enviado el colegiado y el comentario
	opcion_visared = ProfileString(g_directorio_temporal + i_archivo_ini,"DESCRIPTORES","TIPO","")
	comentario_visared = ProfileString(g_directorio_temporal + i_archivo_ini,"DESCRIPTORES","COMENTARIO","")

	choose case opcion_visared
		case 'NUEVO'
			st_5.text = 'Nuevo env$$HEX1$$ed00$$ENDHEX$$o - ' + comentario_visared
		case 'SUBSA'
			st_5.text = 'Subsanaci$$HEX1$$f300$$ENDHEX$$n reparo - ' + comentario_visared
		case 'ANEXO'
			st_5.text = 'Anexo de documentos - ' + comentario_visared
	end choose
	
end if

g_interrupt=false
destroy ds_documentos
end event

event constructor;call super::constructor;this.of_SetRowSelect(true)
this.of_SetSort(true)


// Column header sort
inv_sort.of_SetColumnHeader(true)

// Set to simple sort style
inv_sort.of_SetStyle (2)



//Ponemos las imagenes del datawindows
dw_documentos.object.p_1.Filename = g_directorio_imagenes + "v.gif"
dw_documentos.object.p_2.Filename = g_directorio_imagenes + "x.gif"
dw_documentos.object.p_3.Filename = g_directorio_imagenes + "i.gif"
dw_documentos.object.p_4.Filename = g_directorio_imagenes + "v.gif"
dw_documentos.object.p_5.Filename = g_directorio_imagenes + "x.gif"
dw_documentos.object.p_6.Filename = g_directorio_imagenes + "i.gif"
end event

event rbuttonup;call super::rbuttonup;m_eimporta_dw_firmas menu

if this.getrow() <= 0 or g_activar_revision_firmas = 'N' then return

this.selectrow(0, false)
this.selectrow(row,true)

menu = create m_eimporta_dw_firmas
menu.idw_padre = this

if g_verificador_autonomo = 'S' then
	menu.m_revisardocumento.visible = False
	menu.m_revisartodos.visible = False
	menu.m_-.visible = False
end if

menu.PopMenu(w_aplic_frame.PointerX() + 5, w_aplic_frame.PointerY() + 10)


end event

event doubleclicked;call super::doubleclicked;event csd_abrir()
end event

type gb_1 from groupbox within w_eimporta_detalle_base
integer x = 23
integer y = 16
integer width = 1847
integer height = 1648
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type tab_1 from tab within w_eimporta_detalle_base
integer x = 1911
integer y = 36
integer width = 2405
integer height = 2220
integer taborder = 150
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
tabpage_3 tabpage_3
tabpage_2 tabpage_2
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_2=create tabpage_2
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_3,&
this.tabpage_2,&
this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_3)
destroy(this.tabpage_2)
destroy(this.tabpage_1)
end on

event selectionchanged;st_4.visible = false
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2368
integer height = 2092
long backcolor = 79741120
string text = "Buscar Coincidencias"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Copy!"
long picturemaskcolor = 536870912
cb_sel_fase cb_sel_fase
cb_importar_fase cb_importar_fase
cb_abrir cb_abrir
cb_buscar_coinc cb_buscar_coinc
dw_coincidencias_lista dw_coincidencias_lista
dw_coincidencias_consulta dw_coincidencias_consulta
gb_4 gb_4
end type

on tabpage_3.create
this.cb_sel_fase=create cb_sel_fase
this.cb_importar_fase=create cb_importar_fase
this.cb_abrir=create cb_abrir
this.cb_buscar_coinc=create cb_buscar_coinc
this.dw_coincidencias_lista=create dw_coincidencias_lista
this.dw_coincidencias_consulta=create dw_coincidencias_consulta
this.gb_4=create gb_4
this.Control[]={this.cb_sel_fase,&
this.cb_importar_fase,&
this.cb_abrir,&
this.cb_buscar_coinc,&
this.dw_coincidencias_lista,&
this.dw_coincidencias_consulta,&
this.gb_4}
end on

on tabpage_3.destroy
destroy(this.cb_sel_fase)
destroy(this.cb_importar_fase)
destroy(this.cb_abrir)
destroy(this.cb_buscar_coinc)
destroy(this.dw_coincidencias_lista)
destroy(this.dw_coincidencias_consulta)
destroy(this.gb_4)
end on

type cb_sel_fase from u_cb within tabpage_3
integer x = 809
integer y = 1980
integer width = 558
integer taborder = 21
string text = "Seleccionar Fase"
end type

event clicked;call super::clicked;long fila

fila=dw_coincidencias_lista.Getrow()
if fila>0 then 
	if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Importar el paquete en la fase seleccionada?",Question!,YesNo!)=1 then
		i_coincidencia_fase=dw_coincidencias_lista.GetItemString(fila,'id_fase')
		pb_1.event clicked()
	end if
end if
end event

type cb_importar_fase from u_cb within tabpage_3
integer x = 1403
integer y = 1980
integer width = 558
integer taborder = 11
string text = "Seleccionar Exp."
end type

event clicked;call super::clicked;idw_coincidencias_lista.event doubleclicked(0,0,idw_coincidencias_lista.GetRow(),idw_coincidencias_lista.Object.expedientes_n_expedi)
end event

type cb_abrir from u_cb within tabpage_3
integer x = 1984
integer y = 1980
integer taborder = 11
string text = "Abrir Fase"
end type

event clicked;call super::clicked;if idw_coincidencias_lista.getrow() < 1 then return

//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_fases_consulta.id_fase = idw_coincidencias_lista.getitemstring(idw_coincidencias_lista.getrow(),'id_fase')
g_fase_visared.opcion_importacion = 'X'
message.stringparm = "w_fases_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_fasesdetalle")
end event

type cb_buscar_coinc from u_cb within tabpage_3
integer x = 1330
integer y = 52
integer taborder = 11
fontcharset fontcharset = ansi!
string text = "Buscar"
end type

event clicked;call super::clicked;string sql_nuevo, sql_restaurar
int encontrados
boolean seleccionado = false

idw_coincidencias_consulta.accepttext()

i_coincidencia=""
sql_nuevo = idw_coincidencias_lista.describe("datawindow.table.select")
sql_restaurar = sql_nuevo

//Poblaciones
if idw_coincidencias_consulta.getitemstring(1,'check_pob') = 'S' then
	gnv_sql.of_sql('poblaciones.cod_pos','LIKE','cod_pos',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if

//Emplazamiento
if idw_coincidencias_consulta.getitemstring(1,'check_emplaz') = 'S' then
	gnv_sql.of_sql('fases.emplazamiento','LIKE','emplazamiento',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if

//Numero de expediente electronico
if idw_coincidencias_consulta.getitemstring(1,'check_exp') = 'S' then
	gnv_sql.of_sql('fases.n_expedi_visared','LIKE','n_expedi_elect',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if
//Numero de registro electronico
if idw_coincidencias_consulta.getitemstring(1,'check_reg') = 'S' then
	gnv_sql.of_sql('fases.n_registro_visared','LIKE','n_registro_elect',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if

//Numero de expediente del colegio
if idw_coincidencias_consulta.getitemstring(1,'check_exp_sica') = 'S' then
	gnv_sql.of_sql('expedientes.n_expedi','LIKE','n_expedi_sica',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if
//Numero de registro del colegio
if idw_coincidencias_consulta.getitemstring(1,'check_reg_sica') = 'S' then
	gnv_sql.of_sql('fases.n_registro','LIKE','n_registro_sica',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if


//Tipo de fase
if idw_coincidencias_consulta.getitemstring(1,'check_fase') = 'S' then
	gnv_sql.of_sql('fases.' + campo_tipo_actuacion,'LIKE','fase',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
	seleccionado = true
end if

//Colegiados
//Comprobamos si esta seleccionada la busqueda por colegiados
if idw_coincidencias_consulta.getitemstring(1,'check_colegiado') = 'S' then
	sql_nuevo = wf_busqueda_coinc_colegiados(sql_nuevo)
	seleccionado = true
end if

//Clientes
//Comprobamos si esta seleccionada la busqueda por clientes
if idw_coincidencias_consulta.getitemstring(1,'check_cliente') = 'S' then
	//si no hemos encontrado ningun colegiado, pasamos la sql correcta 
	if sql_nuevo='-1' then sql_nuevo = sql_restaurar
	sql_nuevo = wf_busqueda_coinc_clientes(sql_nuevo)
	seleccionado = true
end if

idw_coincidencias_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

if seleccionado = false then
	messagebox(g_titulo,'Debe de seleccionar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda.')
else
	//messagebox('',sql_nuevo)
	//no existe ningun cliente o colegiado, salimos
	if sql_nuevo='-1' then
		//Restauramos la consulta original del datawidows
		idw_coincidencias_lista.modify("datawindow.table.select= ~"" + sql_restaurar + "~"")
		return
	else
		//MessageBox("DEBUG",sql_nuevo)
		if sql_nuevo=sql_restaurar then 
			MessageBox(g_titulo,"La busqueda no devolvi$$HEX2$$f3002000$$ENDHEX$$valor. Es posible que el parametro seleccionado no exista en la BD.")
			return
		else
			encontrados = idw_coincidencias_lista.retrieve()
			if encontrados<=0 then
				MessageBox(g_titulo,"La busqueda no devolvi$$HEX2$$f3002000$$ENDHEX$$valor. Es posible que el parametro seleccionado no exista en la BD.")
			end if
			st_4.visible = true
			st_4.text = string(encontrados) + ' registros.'			
		end if
	end if
end if


//Restauramos la consulta original del datawidows
idw_coincidencias_lista.modify("datawindow.table.select= ~"" + sql_restaurar + "~"")
end event

type dw_coincidencias_lista from u_csd_dw within tabpage_3
integer x = 5
integer y = 692
integer width = 2331
integer height = 1260
integer taborder = 11
boolean hscrollbar = true
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
end event

event doubleclicked;call super::doubleclicked;if row>0 then
	if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Importar el paquete en el expediente seleccionado?",Question!,YesNo!)=1 then
		i_coincidencia=idw_coincidencias_lista.GetItemString(row,'fases_id_expedi')
		pb_1.event clicked()
	end if
end if
end event

type dw_coincidencias_consulta from u_csd_dw within tabpage_3
integer x = 14
integer y = 32
integer width = 2286
integer height = 616
integer taborder = 11
string dataobject = "d_visared_coincidencias_consulta"
boolean hscrollbar = true
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type gb_4 from groupbox within tabpage_3
integer x = 5
integer width = 2341
integer height = 668
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2368
integer height = 2092
long backcolor = 79741120
string text = "Busqueda Avanzada"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Find!"
long picturemaskcolor = 536870912
cb_sel_fase2 cb_sel_fase2
cb_abrir2 cb_abrir2
cb_importar_fase2 cb_importar_fase2
cb_buscar cb_buscar
dw_busqueda_consulta dw_busqueda_consulta
gb_3 gb_3
dw_busqueda_lista dw_busqueda_lista
end type

on tabpage_2.create
this.cb_sel_fase2=create cb_sel_fase2
this.cb_abrir2=create cb_abrir2
this.cb_importar_fase2=create cb_importar_fase2
this.cb_buscar=create cb_buscar
this.dw_busqueda_consulta=create dw_busqueda_consulta
this.gb_3=create gb_3
this.dw_busqueda_lista=create dw_busqueda_lista
this.Control[]={this.cb_sel_fase2,&
this.cb_abrir2,&
this.cb_importar_fase2,&
this.cb_buscar,&
this.dw_busqueda_consulta,&
this.gb_3,&
this.dw_busqueda_lista}
end on

on tabpage_2.destroy
destroy(this.cb_sel_fase2)
destroy(this.cb_abrir2)
destroy(this.cb_importar_fase2)
destroy(this.cb_buscar)
destroy(this.dw_busqueda_consulta)
destroy(this.gb_3)
destroy(this.dw_busqueda_lista)
end on

type cb_sel_fase2 from u_cb within tabpage_2
integer x = 809
integer y = 1980
integer width = 558
integer taborder = 11
string text = "Seleccionar Fase"
end type

event clicked;call super::clicked;long fila

fila=dw_busqueda_lista.Getrow()
if fila>0 then
	if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Importar el paquete en la fase seleccionada?",Question!,YesNo!)=1 then
		i_coincidencia_fase=dw_busqueda_lista.GetItemString(fila,'id_fase')
		pb_1.event clicked()
	end if
end if
end event

type cb_abrir2 from u_cb within tabpage_2
integer x = 1984
integer y = 1980
integer taborder = 11
string text = "Abrir Fase"
end type

event clicked;call super::clicked;if idw_busqueda_lista.getrow() < 1 then return

//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_fases_consulta.id_fase = idw_busqueda_lista.getitemstring(idw_busqueda_lista.getrow(),'id_fase')
g_fase_visared.opcion_importacion = 'X'
message.stringparm = "w_fases_detalle"
SetPointer(Hourglass!)
w_aplic_frame.postevent("csd_fasesdetalle")
end event

type cb_importar_fase2 from u_cb within tabpage_2
integer x = 1403
integer y = 1980
integer width = 558
integer taborder = 11
string text = "Seleccionar Exp."
end type

event clicked;call super::clicked;//idw_busqueda_lista
idw_busqueda_lista.event doubleclicked(0,0,idw_busqueda_lista.GetRow(),idw_busqueda_lista.Object.expedientes_n_expedi)
end event

type cb_buscar from u_cb within tabpage_2
integer x = 1330
integer y = 52
integer taborder = 11
string text = "Buscar"
end type

event clicked;call super::clicked;string sql_nuevo, sql_restaurar, sql_cliente
int encontrados

idw_busqueda_consulta.accepttext()

sql_nuevo = idw_busqueda_lista.describe("datawindow.table.select")
sql_restaurar = sql_nuevo

if not(f_intervalo_fechas_correcto(idw_busqueda_consulta.GetItemDateTime(1,'fecha_desde'),idw_busqueda_consulta.GetItemDateTime(1,'fecha_hasta'))) then
	MessageBox(g_titulo,"La fecha de entrada de inicio no puede ser mayor que la de fin")
	return
end if

gnv_sql.of_sql('fases.n_expedi','LIKE','n_expedi',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('fases.n_registro','LIKE','n_registro',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')

gnv_sql.of_sql('fases_colegiados.id_col','=','id_col',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('colegiados.n_colegiado','=','n_col',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('colegiados.apellidos','LIKE','nom_col',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')

sql_cliente = sql_nuevo
gnv_sql.of_sql('fases_clientes.id_cliente','=','id_cli',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'') 
gnv_sql.of_sql('clientes.apellidos','LIKE','nom_cli',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'') 
gnv_sql.of_sql('clientes.nif','LIKE','nif_cli',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'') 
if sql_cliente<>sql_nuevo then	
	sql_nuevo = gnv_sql.of_sql(sql_nuevo, {'fases_clientes.id_cliente = clientes.id_cliente '}) //f_sql_join
end if

gnv_sql.of_sql('fases.emplazamiento','LIKE','direccion',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('poblaciones.descripcion','LIKE','desc_poblacion',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('fases.f_entrada','>=','fecha_desde',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('fases.f_entrada','<','fecha_hasta',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('fases.e_mail','LIKE','visared',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')
gnv_sql.of_sql('fases.archivo','LIKE','n_visado',idw_busqueda_consulta,sql_nuevo,g_tipo_base_datos,'')

idw_busqueda_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//messagebox('DEBUG',sql_nuevo)

encontrados = idw_busqueda_lista.retrieve()
st_4.visible = true
st_4.text = string(encontrados) + ' registros.'

//Restauramos la consulta original del datawidows
idw_busqueda_lista.modify("datawindow.table.select= ~"" + sql_restaurar + "~"")
end event

type dw_busqueda_consulta from u_csd_dw within tabpage_2
integer x = 14
integer y = 36
integer width = 2313
integer height = 744
integer taborder = 11
string dataobject = "d_visared_consulta_importacion"
boolean hscrollbar = true
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string pob
string id_col, id_cliente

choose case dwo.name
	CASE 'b_poblacion'
		pob=wf_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
		this.SetItem(1,'desc_poblacion',f_poblacion_descripcion(pob))

	case "b_colegiados"
		id_col=wf_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			this.setitem(1,'n_col',f_colegiado_n_col(id_col))
			this.setitem(1,'id_col',id_col)
		end if

	case "b_clientes"
		id_cliente=wf_busqueda_clientes()
		if NOT f_es_vacio(id_cliente)  then
			this.setitem(1,'nif_cli',f_dame_nif(id_cliente))
			this.setitem(1,'id_cli',id_cliente)
		end if
end choose
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	case 'n_col'
		this.setitem(this.getrow(),'id_col','')
	case 'nif_cli'
		this.setitem(this.getrow(),'id_cli','')
END CHOOSE
end event

type gb_3 from groupbox within tabpage_2
integer x = 5
integer width = 1714
integer height = 796
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

type dw_busqueda_lista from u_csd_dw within tabpage_2
integer x = 5
integer y = 824
integer width = 2327
integer height = 1136
integer taborder = 11
string dataobject = "d_visared_lista_importacion"
boolean hscrollbar = true
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
end event

event doubleclicked;call super::doubleclicked;if row>0 then
	if MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Importar el paquete en el expediente seleccionado?",Question!,YesNo!)=1 then
		i_coincidencia=this.GetItemString(row,'fases_id_expedi')
		pb_1.event clicked()
	end if
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2368
integer height = 2092
long backcolor = 79741120
string text = "Incidencias"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Watcom!"
long picturemaskcolor = 536870912
dw_subsanacion_incidencias dw_subsanacion_incidencias
dw_incidencias dw_incidencias
end type

on tabpage_1.create
this.dw_subsanacion_incidencias=create dw_subsanacion_incidencias
this.dw_incidencias=create dw_incidencias
this.Control[]={this.dw_subsanacion_incidencias,&
this.dw_incidencias}
end on

on tabpage_1.destroy
destroy(this.dw_subsanacion_incidencias)
destroy(this.dw_incidencias)
end on

type dw_subsanacion_incidencias from u_csd_dw within tabpage_1
event csd_sincronizar_incidencia ( )
event type long csd_poblacion_seleccion ( )
event type long csd_asociar_colegiado ( )
integer x = 5
integer y = 1512
integer width = 2318
integer height = 496
integer taborder = 20
string dataobject = "d_visared_subsanacion_incidencias"
boolean hscrollbar = true
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_sincronizar_incidencia();long fila

fila = idw_incidencias.getrow()
idw_subsanacion_incidencias.SetItem(1,'incidencia',idw_incidencias.GetItemString(fila,'solucion'))
idw_subsanacion_incidencias.SetItem(1,'evento_asociado',idw_incidencias.GetItemString(fila,'evento_asociado'))
idw_subsanacion_incidencias.SetItem(1,'campo_anomalo',idw_incidencias.GetItemString(fila,'campo_anomalo'))
idw_subsanacion_incidencias.SetItem(1,'dato_anomalo',idw_incidencias.GetItemString(fila,'valor_descripcion'))
idw_subsanacion_incidencias.SetItem(1,'codigo_anomalo',idw_incidencias.GetItemString(fila,'valor_codigo'))

end event

event type long csd_poblacion_seleccion();st_visared_poblacion datos_poblacion
//st_eimporta_campos_subsanados subsanaciones
st_visared_Poblacion subsanaciones

string filtro,cod_pos
long modificado
string retorno
long cuantos,i
int fila

cod_pos = idw_subsanacion_incidencias.GetItemString(1,'codigo_anomalo')

//filtro = "cod_pos ='"+ cod_pos +"'"
//g_fase_visared.poblacion.SetFilter(filtro)
//cuantos = g_fase_visared.poblacion.Filter()
//
//if cuantos = 0 then return -2

datos_poblacion.cod_pos = g_fase_visared.poblacion.getItemString(1,'cod_pos')
datos_poblacion.provincia =g_fase_visared.poblacion.getItemString(1,'provincia')
datos_poblacion.descripcion =g_fase_visared.poblacion.getItemString(1,'descripcion')

if right(idw_incidencias.GetItemString(idw_incidencias.GetRow(),"campo_anomalo"),1)='n' then
	datos_poblacion.numero_cliente=0
else
	datos_poblacion.numero_cliente=long(right(idw_incidencias.GetItemString(idw_incidencias.GetRow(),"campo_anomalo"),1))
end if

// Para solucionar problemas con varios cod_pos iguales
datos_poblacion.fichero_zip = i_directorio + i_paquete
datos_poblacion.fichero_ini = g_directorio_temporal + i_archivo_ini


OpenWithParm(w_eimporta_busqueda_poblacion,datos_poblacion)
 subsanaciones = Message.PowerobjectParm


if IsValid(subsanaciones) then
	if subsanaciones.cod_pos<>'-1' then
		i=datos_poblacion.numero_cliente
		if i<1 then
			g_campos_subsanados.cod_pos_emplaz=subsanaciones.cod_pos
			g_campos_subsanados.cod_pob_emplaz=subsanaciones.cod_pob
			g_campos_subsanados.desc_poblacion_emplaz=subsanaciones.descripcion		
			g_campos_subsanados.cod_prov_emplaz=subsanaciones.provincia				
		else
			choose case left(idw_incidencias.GetItemString(idw_incidencias.GetRow(),"campo_anomalo"),3)			
				case 'rep'
					g_campos_subsanados.cod_pob_rep[i]=subsanaciones.cod_pob
					g_campos_subsanados.cod_pos_rep[i]=subsanaciones.cod_pos
					g_campos_subsanados.desc_poblacion_rep[i]=subsanaciones.descripcion
					g_campos_subsanados.cod_prov_rep[i]=subsanaciones.provincia		
				case else
					g_campos_subsanados.cod_pob_clientes[i]=subsanaciones.cod_pob
					g_campos_subsanados.cod_pos_clientes[i]=subsanaciones.cod_pos
					g_campos_subsanados.desc_poblacion_clientes[i]=subsanaciones.descripcion
					g_campos_subsanados.cod_prov_clientes[i]=subsanaciones.provincia					
			end choose
		end if
		modificado=1
	end if
else
	modificado=0
end if	



/*if f_es_vacio(modificado) or modificado='-1' then 
	return 0
else
	return 1
end if
*/

return modificado
	


end event

event type long csd_asociar_colegiado();//g_terceros_codigos.representantes
string id_cliente,nif,id
string n_col,id_colegiado
long modificado=1
string num_col

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_colegiado=f_busqueda_colegiados()

num_col=right(idw_subsanacion_incidencias.GetItemString(idw_subsanacion_incidencias.GetRow(),"campo_anomalo"),1)

select n_colegiado into :n_col from colegiados where id_colegiado=:id_colegiado;
if not(f_es_vacio(n_col)) then
	if num_col="0" then
		g_campos_subsanados.colegiado=n_col
	else
		g_campos_subsanados.col_numero[long(num_col)]=n_col
	end if
	Message.DoubleParm=1
	modificado=1	
else
	g_campos_subsanados.colegiado=""
	Message.DoubleParm=0
	modificado=0
end if


return modificado
end event

event buttonclicked;call super::buttonclicked;string evento,codigo
long modificado= 0 
string filtro
int devolver,otro,rowc
long n_filas
int fila_inc
evento = this.GetItemString(row,'evento_asociado')
codigo = this.GetItemString(row,'codigo_anomalo')
              
if f_es_vacio(evento) then return

this.TriggerEvent(evento)
modificado = Message.DoubleParm

if modificado > 0 or IsValid(Message.PowerObjectParm) then
 idw_incidencias.SetItem(idw_incidencias.GetRow(),'evento_asociado','')
 idw_incidencias.SetItem(idw_incidencias.GetRow(),'subsanado','S')
 fila_inc = g_fase_visared.ds_incidencias.find("incidencia = '" + &
  idw_incidencias.getitemstring(idw_incidencias.GetRow(),'incidencia') + "'",1,idw_incidencias.rowcount())
 
 
 g_fase_visared.ds_incidencias.SetItem(fila_inc,'evento_asociado','')
 g_fase_visared.ds_incidencias.SetItem(fila_inc,'subsanado','S') 
 
 this.event csd_sincronizar_incidencia()
end if

wf_comprobar_incidencias_graves()

end event

type dw_incidencias from u_csd_dw within tabpage_1
integer x = 5
integer y = 20
integer width = 2331
integer height = 1476
integer taborder = 40
string dataobject = "d_visared_incidencias"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount()=0  then return 1
if idw_subsanacion_incidencias.rowcount()=0 then idw_subsanacion_incidencias.InsertRow(0)

dw_subsanacion_incidencias.event csd_sincronizar_incidencia()

end event

type lb_1 from listbox within w_eimporta_detalle_base
boolean visible = false
integer x = 2418
integer y = 32
integer width = 919
integer height = 612
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 50331647
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_eimporta_detalle_base
integer x = 91
integer y = 876
integer width = 681
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
string text = "Contenido del paquete"
boolean focusrectangle = false
end type

type st_div from statictext within w_eimporta_detalle_base
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event mousemove pbm_mousemove
integer x = 1870
integer y = 36
integer width = 18
integer height = 1352
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeWE!"
long textcolor = 33554432
long backcolor = 80269524
boolean focusrectangle = false
end type

event lbuttondown;this.BackColor = 0

end event

event lbuttonup;n_cst_color lnv_color

if This.BackColor = 0 then // Si se est$$HEX2$$e1002000$$ENDHEX$$desplazando el separador
	This.BackColor = lnv_color.BUTTONFACE
	event csd_redimensionar()
end if


end event

event mousemove;if This.BackColor = 0 then // Si se est$$HEX2$$e1002000$$ENDHEX$$desplazando el separador
	this.X = Parent.PointerX()
end if

end event

type st_div2 from statictext within w_eimporta_detalle_base
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event mousemove pbm_mousemove
integer x = 82
integer y = 744
integer width = 1746
integer height = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 80269524
boolean focusrectangle = false
end type

event lbuttondown;this.BackColor = 0

end event

event lbuttonup;n_cst_color lnv_color

if This.BackColor = 0 then // Si se est$$HEX2$$e1002000$$ENDHEX$$desplazando el separador
	This.BackColor = lnv_color.BUTTONFACE
	event csd_redimensionar()
end if


end event

event mousemove;if This.BackColor = 0 then // Si se est$$HEX2$$e1002000$$ENDHEX$$desplazando el separador
	this.Y = Parent.PointerY()
end if

end event

type rb_otra_carpeta from u_rb within w_eimporta_detalle_base
integer x = 1467
integer y = 56
integer width = 379
boolean bringtotop = true
string text = "Otra carpeta"
end type

event clicked;call super::clicked;//nca_folderbrowse seleccion
//string ruta

cb_select_folder.visible = true

rb_ver_bandeja_entrada.checked = false
rb_ver_elem_procesados.checked = true
rb_otra_carpeta.checked=true

if g_verificador_autonomo = 'S' then
	dw_paquetes.event csd_refrescar_paquetes_verif()
else
	
	if not f_es_vacio(g_directorio_defecto_otras_carpetas) and g_directorio_defecto_otras_carpetas <> '\' then 
		i_directorio = g_directorio_defecto_otras_carpetas
		dw_paquetes.event csd_refrescar_paquetes()
	else 
		cb_select_folder.event clicked( )
	end if

end if

dw_documentos.reset()

pb_1.enabled=false
pb_2.enabled=false
pb_3.enabled=false
//dw_paquetes.event csd_refrescar()

end event

type st_5 from multilineedit within w_eimporta_detalle_base
integer x = 59
integer y = 1828
integer width = 1783
integer height = 164
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
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
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_obs from commandbutton within w_eimporta_detalle_base
boolean visible = false
integer x = 992
integer y = 856
integer width = 411
integer height = 76
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Observaciones"
end type

event clicked;dw_paquetes.event csd_observaciones()
end event

type cb_select_folder from commandbutton within w_eimporta_detalle_base
boolean visible = false
integer x = 1166
integer y = 156
integer width = 654
integer height = 76
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Seleccionar directorio"
end type

event clicked;nca_folderbrowse seleccion
string ruta

ruta = seleccion.browseforfolder( parent,'Seleccione el directorio de importacion')

if not(f_es_vacio(ruta)) then 
	i_directorio=ruta+'\'
	dw_paquetes.event csd_refrescar_paquetes()
else
	rb_ver_bandeja_entrada.event clicked()
end if
end event

