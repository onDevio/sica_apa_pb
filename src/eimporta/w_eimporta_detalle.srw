HA$PBExportHeader$w_eimporta_detalle.srw
forward
global type w_eimporta_detalle from w_eimporta_detalle_base
end type
type cb_importar from commandbutton within w_eimporta_detalle
end type
end forward

global type w_eimporta_detalle from w_eimporta_detalle_base
integer x = 214
integer y = 221
cb_importar cb_importar
end type
global w_eimporta_detalle w_eimporta_detalle

type variables
st_fases_consulta st_datos

string i_n_registro_elec,i_n_expedi_elec
string i_n_registro_sica,i_n_expedi_sica,i_id_colprincipal


end variables

forward prototypes
public function string wf_busqueda_clientes ()
public function string wf_busqueda_colegiados ()
public function string wf_busqueda_poblaciones ()
end prototypes

public function string wf_busqueda_clientes ();g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
g_busqueda.dw="d_lista_busqueda_clientes"
return f_busqueda_clientes("")

end function

public function string wf_busqueda_colegiados ();g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
return f_busqueda_colegiados()   

end function

public function string wf_busqueda_poblaciones ();g_busqueda.titulo='Poblaciones'
g_busqueda.dw='d_poblaciones_lista_busqueda'
g_busqueda.param1='S'
return f_busqueda_poblaciones()

end function

on w_eimporta_detalle.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
end on

on w_eimporta_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_importar)
end on

event open;call super::open;// En la tabla de fases el campo de tipo de actuacion (fase) tiene diferente nombre seg$$HEX1$$fa00$$ENDHEX$$n la aplicaci$$HEX1$$f300$$ENDHEX$$n. Las ventanas hijas deben indicar cual es el correcto.
campo_tipo_actuacion = "fase"

idw_coincidencias_consulta.Object.check_pem.visible=true
idw_busqueda_consulta.object.n_visado.visible=true
idw_busqueda_consulta.object.t_visado.visible=true
if g_colegio='COAATNA' then
	cb_importar.visible=true
elseif g_colegio='COAATMCA'  then
	cb_importar.text='Convertir'
	cb_importar.visible=true	
else	
	cb_importar.visible=false
end if



end event

event close;call super::close;g_visared_activo = false
end event

event csd_cargar_coincidencias;call super::csd_cargar_coincidencias;int fila
String dato
string desc_pob
string campo1
string id_col, n_col, nombre_col
int i
string nombre_cliente, id_cliente, nif_cli,n_expedi,n_colprincipal,n_registro
string n_expedi_sica,n_registro_sica,pem
fila = 1

n_expedi=ProfileString(fichero,"CONTRATO","n_expedi","")
n_registro=ProfileString(fichero,"CONTRATO","n_registro","")
n_expedi_sica=ProfileString(fichero,"CONTRATO","n_exp_colegial","")
n_registro_sica=ProfileString(fichero,"CONTRATO","n_reg_colegial","")
pem=ProfileString(fichero,"CONTRATO","pem","")

n_colprincipal=ProfileString(fichero,"CONTRATO","colegiado","")

idw_coincidencias_consulta.SetItem(fila, "n_expedi_elect",n_colprincipal+'-'+n_expedi)
idw_coincidencias_consulta.SetItem(fila, "n_registro_elect",n_colprincipal+n_registro)

//Cargamos los datos nuevos
//Numero de expediente
idw_coincidencias_consulta.SetItem(fila, "n_expedi", n_expedi)
idw_coincidencias_consulta.SetItem(fila, "n_registro", n_registro)
idw_coincidencias_consulta.SetItem(fila, "n_expedi_sica", n_expedi_sica)
idw_coincidencias_consulta.SetItem(fila, "n_registro_sica", n_registro_sica)

// PEM
idw_coincidencias_consulta.SetItem(fila, "pem", double(pem))

//Tipo de actuacion (fase)
idw_coincidencias_consulta.SetItem(fila, "fase", profilestring(fichero, "CONTRATO", "tipo_actuacion" , ""))

//Emplazamiento
dato = ProfileString(fichero,"CONTRATO","emplazamiento","")
idw_coincidencias_consulta.SetItem(fila, "emplazamiento", dato)

//Poblacion
dato = ProfileString(fichero,"CONTRATO","cod_pos","")
desc_pob = ProfileString(fichero,"CONTRATO","desc_poblacion","") + "%"
idw_coincidencias_consulta.SetItem(fila, "cod_pos",dato )

//TEMPORAL HASTA QUE SE ACLARE F_POBLACION_DESCRIPCION CON COD_POB - COD_POS
select descripcion into :dato from poblaciones where cod_pos = :dato and descripcion like :desc_pob;
idw_coincidencias_consulta.SetItem(fila, "desc_poblacion", dato)

//Datos de Colegiados de la Fase
campo1='numero_'

i_n_colegiados = integer(ProfileString(fichero, "COLEGIADOS", "total" ,''))
for i = 1 to i_n_colegiados 
	id_col = ''
	n_col = profilestring(fichero, "COLEGIADOS", campo1+string(i),'')
	
	if g_colegio = 'COAR' then
		select id_colegiado into :id_col from colegiados where n_consejo = :n_col;
	else
		select id_colegiado into :id_col from colegiados where n_colegiado = :n_col;
	end if

	if f_es_vacio(id_col) then
		//Si la longitud del colegiado es <5 completamos con tantos ceros como sea necesario
		//ya que la numeraci$$HEX1$$f300$$ENDHEX$$n de los colegiados en el colegio est$$HEX1$$e100$$ENDHEX$$n precedidos de 0's (Ej. 00015)
		if LenA(n_col)<5 then 
			n_col = f_completar_con_caracteres(n_col,5,'I','0')
			if g_colegio = 'COAR' then
				select id_colegiado into :id_col from colegiados where n_consejo = :n_col;
			else
				select id_colegiado into :id_col from colegiados where n_colegiado = :n_col;
			end if
		end if
	end if		
	i_id_col[i] = id_col
next

//Datos de Clientes de la Fase
campo1='nif_'

i_n_clientes = integer(ProfileString(fichero, "CLIENTES", "total" ,''))
if isnull(i_n_clientes) then i_n_clientes = 0

string sql,sql_original


for i=1 to i_n_clientes

	id_cliente = ''
	nif_cli = profileString(fichero, "CLIENTES", campo1+string(i) ,'')
	select id_cliente into :id_cliente from clientes where nif = :nif_cli;
	i_nif_cli[i]=nif_cli
	i_id_cli[i] = id_cliente

	
next

end event

event csd_redimensionar;call super::csd_redimensionar;p_logo.width = gb_1.width - 10
end event

type cb_recuperar_pantalla from w_eimporta_detalle_base`cb_recuperar_pantalla within w_eimporta_detalle
integer taborder = 10
end type

type cb_guardar_pantalla from w_eimporta_detalle_base`cb_guardar_pantalla within w_eimporta_detalle
end type

type dw_paquetes from w_eimporta_detalle_base`dw_paquetes within w_eimporta_detalle
end type

event dw_paquetes::csd_enviar;call super::csd_enviar;string archivo,n_col,email
st_mail parametros
nca_folderbrowse lnca_bff
String ls_dir
archivo = this.getitemstring(this.getrow(), 'archivo')
f_bloqueo_fichero(i_directorio + archivo,false)

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
		case 4 // Otra carpeta
			ls_dir = lnca_BFF.BrowseForFolder( w_eimporta_detalle, 'Seleccione el directorio destino' )
			if ls_dir<>"" then 
				gnv_fichero.of_filerename( i_directorio + archivo, ls_dir + '\'+ archivo)
				this.event csd_refrescar()				
			end if
end choose
end event

event dw_paquetes::csd_observaciones;call super::csd_observaciones;openWithParm(w_visared_observaciones,i_directorio + i_paquete)

end event

type rb_ver_elem_procesados from w_eimporta_detalle_base`rb_ver_elem_procesados within w_eimporta_detalle
end type

type rb_ver_bandeja_entrada from w_eimporta_detalle_base`rb_ver_bandeja_entrada within w_eimporta_detalle
end type

type pb_5 from w_eimporta_detalle_base`pb_5 within w_eimporta_detalle
end type

event pb_5::clicked;call super::clicked;// LO HACE EL PADRE
end event

type st_4 from w_eimporta_detalle_base`st_4 within w_eimporta_detalle
end type

type pb_4 from w_eimporta_detalle_base`pb_4 within w_eimporta_detalle
end type

event pb_4::clicked;call super::clicked;// LO HACE EL PADRE
end event

type pb_3 from w_eimporta_detalle_base`pb_3 within w_eimporta_detalle
end type

event pb_3::clicked;call super::clicked;// LO HACE EL PADRE
end event

type pb_2 from w_eimporta_detalle_base`pb_2 within w_eimporta_detalle
end type

event pb_2::clicked;// Este evento no extiende el antecesor

string fichero
boolean tramitado = false

fichero = g_directorio_temporal + i_archivo_ini

//Si el archivo es una hoja de VISARED con extensi$$HEX1$$f300$$ENDHEX$$n .INI
if RightA(lower(i_archivo_ini),4) = '.ini' then
	OpenWithParm(w_visared_previsualizacion,fichero)
	tramitado = true
end if


if not tramitado then
	Messagebox(g_titulo,'El fichero no tiene una extensi$$HEX1$$f300$$ENDHEX$$n v$$HEX1$$e100$$ENDHEX$$lida.')
end if


end event

type pb_1 from w_eimporta_detalle_base`pb_1 within w_eimporta_detalle
end type

event pb_1::clicked;call super::clicked;boolean hay_exp,hay_fase
long i,valor
int retorno1,cuantos_expedi,cuantos_fase,cuantos,incidencias_graves
string n_registro_visared_importado,n_expedi_visared_importado,n_registro,n_expedi,id_fase,id_expedi,fichero
string colegiado,version
string id_expedi_real, id_fase_real,refweb
string n_exp_real, n_reg_real
string n_expedi_importado,n_registro_importado
st_visared_busq_fase st_fase
st_visared_detalle_importacion st_importacion

// Extraemos los ficheros
hay_exp=false
hay_fase=false
n_expedi=''
n_registro=''
cuantos_expedi=0
cuantos_fase=0

//g_fase_visared = wf_importacion() // Lo hace el padre
if g_fase_visared.id_expedi='-1' then 
	i_coincidencia=""
	i_coincidencia_fase=""
	return
end if

setpointer(HourGlass!)

fichero = g_directorio_temporal + i_archivo_ini
version = ProfileString(fichero,"VERSION","version","")

if left(version,3)='FEW' then
	n_expedi_visared_importado=g_fase_visared.ds_detalle_fase.getItemstring(1, "n_expedi")
	n_registro_visared_importado=g_fase_visared.ds_detalle_fase.getItemstring(1, "n_registro")
	st_fase.few=true
	// 	 SCP-574 se a$$HEX1$$f100$$ENDHEX$$ade la busqueda por referencia web por si no existiera en el paquete el numero de registro.
	refweb=g_fase_visared.ds_detalle_fase.getItemstring(1, "id_referencia_web")
	if f_es_vacio(n_expedi_visared_importado) and f_es_vacio(n_registro_visared_importado) and not  f_es_vacio(refweb) then
		select id_fase into :id_fase from fases_otros_datos where id_referencia_web=:refweb;
		if not f_es_vacio(id_fase) then 
			Select n_expedi,n_registro into :n_expedi_visared_importado,:n_registro_visared_importado from fases where id_fase=:id_fase;
		end if 
	end if 
	// fin SCP-574
else
	n_expedi_visared_importado=g_fase_visared.ds_detalle_fase.getItemstring(1, "n_expedi_visared")
	n_registro_visared_importado=g_fase_visared.ds_detalle_fase.getItemstring(1, "n_registro_visared")
	
	if mid(trim(n_registro_visared_importado),pos(n_registro_visared_importado,'-'))='-' then
		n_expedi_visared_importado=''
		n_registro_visared_importado=''
	end if	
end if

	
// IMPORTAMOS SEGUN EL N$$HEX2$$ba002000$$ENDHEX$$EXP Y LA FASE DEL COLEGIADO
if f_es_vacio(i_coincidencia) and f_es_vacio(i_coincidencia_fase) then 	
	//rellenamos la estructura q le pasaremos a la ventana de opciones d importacion
	st_fase.n_expedi = n_expedi_visared_importado
	st_fase.n_registro = n_registro_visared_importado

	if (not f_es_vacio(n_expedi_visared_importado)) or (not f_es_vacio(n_registro_visared_importado)) then
		//Comprobamos si el expediente existe
		if left(version,3)='FEW' then
			select id_expedi into :id_expedi_real from fases where n_expedi=:n_expedi_visared_importado;
		else
			select id_expedi into :id_expedi_real from fases where n_expedi_visared=:n_expedi_visared_importado;
		end if
		if not(f_es_vacio(id_expedi_real))  then 
			hay_exp=true
			select n_expedi into :n_exp_real from expedientes where id_expedi=:id_expedi_real;
		end if
	
		//Comprobamos si la fase existe
		if left(version,3)='FEW' then
			select id_fase, n_registro into :id_fase_real, :n_reg_real from fases where n_expedi=:n_expedi_visared_importado and  n_registro=:n_registro_visared_importado;
		else
			select id_fase, n_registro into :id_fase_real, :n_reg_real from fases where n_expedi_visared=:n_expedi_visared_importado and  n_registro_visared=:n_registro_visared_importado;
		end if
		if not(f_es_vacio(id_fase_real))  then hay_fase=true
	end if
	
	setpointer(Arrow!)
	
	i_opcion_importacion = ''
	
	if hay_exp then
		if hay_fase then
			// Dejamos al usuario elegir entre una importaci$$HEX1$$f300$$ENDHEX$$n de documentos o crear una fase nueva
			//le pasamos a la ventana 1estructura cn el n_reg y el n_exp
	
	
			openwithparm(w_visared_opcion_importacion, st_fase)
			
			//string subopcion_importacion
			st_importacion = message.powerobjectparm
			
			if st_importacion.tipo_importacion = 'NO' then // Fase nueva
				i_opcion_importacion = 'F'
			elseif st_importacion.tipo_importacion = 'AD' then // A$$HEX1$$f100$$ENDHEX$$adir documentos
				i_opcion_importacion='I'
			else // Cancelado
				return
			end if
			 
		else
			//Existe el expediente pero no la fase
			if messagebox('Importaci$$HEX1$$f300$$ENDHEX$$n Visared',i_mensaje_fase_nueva+cr+cr+'Expediente : ' + n_exp_real,Exclamation!,OkCancel!)=2 then
				return
			end if
			
			i_opcion_importacion='F'
		end if
	else
		// Expediente nuevo
		if messagebox('Importaci$$HEX1$$f300$$ENDHEX$$n Visared',i_mensaje_exp_nuevo,Exclamation!,OkCancel!) = 2 then return
		i_opcion_importacion='E'
	end if

// IMPORTAMOS EN EL EXPEDIENTE SELECCIONADO DE LA BUSQUEDA DE COINCIDENCIAS
elseif not(f_es_vacio(i_coincidencia)) then
	hay_exp=true
	hay_fase=false
	id_expedi_real=i_coincidencia
	select n_expedi into :n_exp_real from expedientes where id_expedi=:id_expedi_real;
	i_opcion_importacion='F'
// IMPORTAMOS EN LA FASE SELECCIONADA DE LA BUSQUEDA DE COINCIDENCIAS	
elseif not(f_es_vacio(i_coincidencia_fase)) then	
	hay_exp=true
	hay_fase=true
	id_fase_real=i_coincidencia_fase
	st_importacion.tipo_importacion = 'AD'
	st_importacion.id_fase = i_coincidencia_fase
	i_opcion_importacion='I'	
end if

st_datos.opcion_importacion = i_opcion_importacion
st_datos.fichero_importacion = fichero
st_datos.paquete_importacion = i_paquete

st_datos.id_expedi=id_expedi_real

//si ha seleccionado una fase en la ventana d opcion d importacion, se la pasamos
if not f_es_vacio(st_importacion.id_fase) and st_importacion.tipo_importacion='AD' then
	st_datos.id_fase = st_importacion.id_fase
else
	st_datos.id_fase=id_fase_real
end if
	

st_datos.visared = 'V'
destroy g_fase_visared.ds_incidencias
destroy g_fase_visared.ds_clientes_nuevos

//Invocamos el evento de importaci$$HEX1$$f300$$ENDHEX$$n pasandole la estructura de datos
// y cerramos la ventana
g_datos_fase = st_datos

//f_eimporta_mover_paquete_importado(g_directorio_importacion+i_paquete)
ib_importado=true
i_coincidencia=""
Close(parent)


end event

type st_2 from w_eimporta_detalle_base`st_2 within w_eimporta_detalle
end type

type st_1 from w_eimporta_detalle_base`st_1 within w_eimporta_detalle
end type

type p_logo from w_eimporta_detalle_base`p_logo within w_eimporta_detalle
integer x = 41
integer y = 1972
integer height = 144
end type

type gb_2 from w_eimporta_detalle_base`gb_2 within w_eimporta_detalle
end type

type dw_documentos from w_eimporta_detalle_base`dw_documentos within w_eimporta_detalle
end type

type gb_1 from w_eimporta_detalle_base`gb_1 within w_eimporta_detalle
end type

type tab_1 from w_eimporta_detalle_base`tab_1 within w_eimporta_detalle
end type

type tabpage_3 from w_eimporta_detalle_base`tabpage_3 within tab_1
end type

type cb_sel_fase from w_eimporta_detalle_base`cb_sel_fase within tabpage_3
end type

type cb_importar_fase from w_eimporta_detalle_base`cb_importar_fase within tabpage_3
end type

type cb_abrir from w_eimporta_detalle_base`cb_abrir within tabpage_3
end type

type cb_buscar_coinc from w_eimporta_detalle_base`cb_buscar_coinc within tabpage_3
end type

event cb_buscar_coinc::clicked;// SOBREESCRITA
// TIENE EN CUENTA LA BUSQUEDA DE COINCIDENCIAS POR EL PEM 


string sql_nuevo, sql_restaurar
int encontrados
boolean seleccionado = false

idw_coincidencias_consulta.accepttext()

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
//PEM
if idw_coincidencias_consulta.getitemstring(1,'check_pem') = 'S' then
	gnv_sql.of_sql('fases_usos.pem','=','pem',idw_coincidencias_consulta,sql_nuevo,g_tipo_base_datos,'')
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

type dw_coincidencias_lista from w_eimporta_detalle_base`dw_coincidencias_lista within tabpage_3
string dataobject = "d_visared_lista_coinc_importacion"
end type

type dw_coincidencias_consulta from w_eimporta_detalle_base`dw_coincidencias_consulta within tabpage_3
end type

type gb_4 from w_eimporta_detalle_base`gb_4 within tabpage_3
end type

type tabpage_2 from w_eimporta_detalle_base`tabpage_2 within tab_1
end type

type cb_sel_fase2 from w_eimporta_detalle_base`cb_sel_fase2 within tabpage_2
end type

type cb_abrir2 from w_eimporta_detalle_base`cb_abrir2 within tabpage_2
end type

type cb_importar_fase2 from w_eimporta_detalle_base`cb_importar_fase2 within tabpage_2
end type

type cb_buscar from w_eimporta_detalle_base`cb_buscar within tabpage_2
end type

type dw_busqueda_consulta from w_eimporta_detalle_base`dw_busqueda_consulta within tabpage_2
end type

type gb_3 from w_eimporta_detalle_base`gb_3 within tabpage_2
end type

type dw_busqueda_lista from w_eimporta_detalle_base`dw_busqueda_lista within tabpage_2
end type

type tabpage_1 from w_eimporta_detalle_base`tabpage_1 within tab_1
end type

type dw_subsanacion_incidencias from w_eimporta_detalle_base`dw_subsanacion_incidencias within tabpage_1
event type long csd_cliente_nuevo ( )
event type long csd_poblacion_nueva ( )
event type long csd_representante_nuevo ( )
event type long csd_representante_modif ( )
event type long csd_tipo_tercero_cliente ( )
end type

event type long dw_subsanacion_incidencias::csd_cliente_nuevo();st_clientes datos_cliente
string filtro ='',n_cliente,campo,nif,id_cliente
long modificado=0,cuantos
int fila,i


n_cliente = idw_subsanacion_incidencias.GetItemString(1,'codigo_anomalo')
datos_cliente.numero_cliente = RightA(idw_subsanacion_incidencias.GetItemString(idw_subsanacion_incidencias.GetRow(),"campo_anomalo"),1)

for i=1 to idw_incidencias.rowcount()
	campo=idw_incidencias.GetItemString(i,'campo_anomalo')
	if LeftA(campo,8)='clientes' then
		if RightA(campo,1)=datos_cliente.numero_cliente and idw_incidencias.GetItemString(i,'subsanado')='N' then
			if MessageBox("$$HEX1$$a100$$ENDHEX$$Atencion!","Se recomienda subsanar todas las incidencias medias del cliente "+datos_cliente.numero_cliente+ &
			" antes de darlo de alta. En caso contrario podr$$HEX1$$ed00$$ENDHEX$$a ser introducido con datos erroneos."+cr+ &
			"$$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)<>1 then
				Message.DoubleParm=0
				return 0
			end if
		end if
	end if
next



filtro = "nif='"+n_cliente+"'"

g_fase_visared.ds_clientes_nuevos.SetFilter(filtro)

cuantos=g_fase_visared.ds_clientes_nuevos.Filter()

if cuantos = 0 then return -2

datos_cliente.n_cliente 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'n_cliente')
datos_cliente.apellidos 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'apellidos')
datos_cliente.nombre 		= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'nombre')
datos_cliente.tipo_persona = g_fase_visared.ds_clientes_nuevos.GetItemString(1,'tipo_persona')
datos_cliente.sexo			= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'sexo')
datos_cliente.observaciones= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'observaciones')
datos_cliente.email			= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'email')
datos_cliente.url				= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'url')
datos_cliente.tipo_via		= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'tipo_via')
datos_cliente.nombre_via 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'nombre_via')


if f_es_vacio(g_campos_subsanados.cod_pob_clientes[long(datos_cliente.numero_cliente)]) then
	datos_cliente.cod_pob	 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'cod_pob')
	datos_cliente.cod_prov	 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'cod_prov')	
	datos_cliente.cp			 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'cp')
else
	datos_cliente.cod_pob	 	= g_campos_subsanados.cod_pob_clientes[long(datos_cliente.numero_cliente)]
	datos_cliente.cod_prov	 	= g_campos_subsanados.cod_prov_clientes[long(datos_cliente.numero_cliente)]
	datos_cliente.cp			 	= g_campos_subsanados.cod_pos_clientes[long(datos_cliente.numero_cliente)]
end if

if f_es_vacio(g_campos_subsanados.cli_nif[long(datos_cliente.numero_cliente)]) then
	datos_cliente.nif				= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'nif')		
else
	datos_cliente.nif				= g_campos_subsanados.cli_nif[long(datos_cliente.numero_cliente)]
end if

datos_cliente.pais		 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'pais')

datos_cliente.telefono	 	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'telefono')
datos_cliente.fax	 			= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'fax')

if not LeftA(g_colegio,5)='COAAT' then // los aparejadores no tienen $$HEX1$$e900$$ENDHEX$$sta opci$$HEX1$$f300$$ENDHEX$$n
	datos_cliente.cuenta_banco	= g_fase_visared.ds_clientes_nuevos.GetItemString(1,'cuenta_banco')
end if

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","$$HEX1$$bf00$$ENDHEX$$Quiere dar de alta el cliente? (Si selecciona NO, deber$$HEX2$$e1002000$$ENDHEX$$indicar un cliente ya existente)",Question!,YesNo!)=1 then
	OpenWithParm(w_visared_alta_clientes,datos_cliente)
	
	modificado = Message.DoubleParm
else
	g_busqueda.titulo="Selecci$$HEX1$$f300$$ENDHEX$$n de cliente"
	g_busqueda.dw="d_lista_busqueda_clientes"
	
	st_visared_busqueda st_datos_busqueda
	
	st_datos_busqueda.nif_cliente=datos_cliente.nif
	st_datos_busqueda.t_tercero='01'
	OpenWithParm(w_eimporta_busqueda_clientes,st_datos_busqueda)
	id_cliente=Message.StringParm
	//id_cliente=f_busqueda_clientes(datos_cliente.nif)

	if f_es_vacio(id_cliente) then
		Message.DoubleParm=0
		modificado=0
	else	
	
		select nif into :nif from clientes where id_cliente=:id_cliente;
		g_campos_subsanados.cli_nif[long(datos_cliente.numero_cliente)]=nif
		Message.DoubleParm=1
		modificado=1
	end if
end if

return modificado

end event

event type long dw_subsanacion_incidencias::csd_poblacion_nueva();st_visared_poblacion datos_poblacion
string filtro,cod_pos
long modificado=0,cuantos
int fila

cod_pos = idw_subsanacion_incidencias.GetItemString(1,'codigo_anomalo')

filtro = "cod_pos ='"+ cod_pos+"'"
g_fase_visared.poblacion.SetFilter(filtro)
cuantos = g_fase_visared.poblacion.Filter()

if cuantos = 0 then return -2

datos_poblacion.cod_pos = g_fase_visared.poblacion.getItemString(1,'cod_pos')
datos_poblacion.descripcion =g_fase_visared.poblacion.getItemString(1,'descripcion')
datos_poblacion.provincia =g_fase_visared.poblacion.getItemString(1,'provincia')

OpenWithParm(w_visared_alta_poblacion,datos_poblacion)

modificado = Message.DoubleParm

return modificado




end event

event type long dw_subsanacion_incidencias::csd_representante_nuevo();st_clientes datos_cliente
string filtro ='',n_cliente,campo,id_cliente,id,nif
long modificado=0,cuantos
int fila,i,num

n_cliente = idw_subsanacion_incidencias.GetItemString(1,'codigo_anomalo')

datos_cliente.numero_cliente = RightA(idw_subsanacion_incidencias.GetItemString(idw_subsanacion_incidencias.GetRow(),"campo_anomalo"),1)

for i=1 to idw_incidencias.rowcount()
	campo=idw_incidencias.GetItemString(i,'campo_anomalo')
	if LeftA(campo,3)='rep' then
		if RightA(campo,1)=datos_cliente.numero_cliente and idw_incidencias.GetItemString(i,'subsanado')='N' then
			if MessageBox("$$HEX1$$a100$$ENDHEX$$Atencion!","Se recomienda subsanar todas las incidencias medias del representante "+datos_cliente.numero_cliente+ &
			" antes de darlo de alta. En caso contrario podr$$HEX1$$ed00$$ENDHEX$$a ser introducido con datos erroneos."+cr+ &
			"$$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)<>1 then
				Message.DoubleParm=0
				return 0
			end if
		end if
	end if
next

/*
select id_cliente into :id_cliente from clientes where clientes.nif = :n_cliente;

if not(f_es_vacio(id_cliente)) then
	if MessageBox(g_titulo,"El cliente ya est$$HEX2$$e1002000$$ENDHEX$$dado de alta.$$HEX1$$bf00$$ENDHEX$$Quieres darlo de alta tambien como representante?",Question!,YesNo!)=1 then
		id=f_siguiente_numero('CLIENTES_TERCEROS',10)
		insert into clientes_terceros (id,id_cliente,c_tercero) values (:id,:id_cliente,'23');
		return 1
	end if
end if

*/
filtro = "nif='"+n_cliente+"'"

g_fase_visared.ds_representantes_nuevos.SetFilter(filtro)

cuantos=g_fase_visared.ds_representantes_nuevos.Filter()

if cuantos = 0 then return -2

datos_cliente.apellidos 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'apellidos')
datos_cliente.nombre 		= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'nombre')

//datos_cliente.tipo_persona = g_fase_visared.ds_representantes_nuevos.GetItemString(1,'tipo_persona')
//datos_cliente.sexo			= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'sexo')
//datos_cliente.observaciones= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'observaciones')
//datos_cliente.email			= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'email')
//datos_cliente.url				= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'url')
datos_cliente.tipo_via		= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'tipo_via')
datos_cliente.nombre_via 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'nombre_via')

if f_es_vacio(g_campos_subsanados.cod_pob_clientes[long(datos_cliente.numero_cliente)]) then
	datos_cliente.cod_pob	 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'cod_pob')
	datos_cliente.cod_prov	 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'cod_prov')	
	datos_cliente.cp			 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'cp')
	datos_cliente.nif				= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'nif')
else
	datos_cliente.cod_pob	 	= g_campos_subsanados.cod_pob_rep[long(datos_cliente.numero_cliente)]
	datos_cliente.cod_prov	 	= g_campos_subsanados.cod_prov_rep[long(datos_cliente.numero_cliente)]
	datos_cliente.cp			 	= g_campos_subsanados.cod_pos_rep[long(datos_cliente.numero_cliente)]
	datos_cliente.nif				= g_campos_subsanados.rep_nif[long(datos_cliente.numero_cliente)]
end if


datos_cliente.pais		 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'pais')

//datos_cliente.telefono	 	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'telefono')
//datos_cliente.fax	 			= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'fax')

if not LeftA(g_colegio,5)='COAAT' then // los aparejadores no tienen $$HEX1$$e900$$ENDHEX$$sta opci$$HEX1$$f300$$ENDHEX$$n
	datos_cliente.cuenta_banco	= g_fase_visared.ds_representantes_nuevos.GetItemString(1,'cuenta_banco')
end if

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","$$HEX1$$bf00$$ENDHEX$$Quiere dar de alta el cliente? (Si selecciona NO, deber$$HEX2$$e1002000$$ENDHEX$$indicar un cliente ya existente)",Question!,YesNo!)=1 then
	OpenWithParm(w_visared_alta_representantes,datos_cliente)
	
	modificado = Message.DoubleParm
else
	g_busqueda.titulo="Selecci$$HEX1$$f300$$ENDHEX$$n de representante"
	g_busqueda.dw="d_lista_busqueda_rep"
	id_cliente=f_busqueda_clientes(datos_cliente.nif)

	if f_es_vacio(id_cliente) then
		Message.DoubleParm=0
		modificado=0
	else
		select nif into :nif from clientes where id_cliente=:id_cliente;
	
		g_campos_subsanados.rep_nif[long(datos_cliente.numero_cliente)]=nif
		Message.DoubleParm=1
		modificado=1
	end if
end if




return modificado
end event

event type long dw_subsanacion_incidencias::csd_representante_modif();//g_terceros_codigos.representantes
string id_cliente,nif,id
long modificado=1

nif=g_fase_visared.ds_representantes_nuevos.GetItemString(1,'nif')
select clientes.id_cliente into :id_cliente from clientes where clientes.nif = :nif;

id=LeftA('R'+nif,10)
insert into clientes_terceros (id,id_cliente,c_tercero) values (:id,:id_cliente,:g_terceros_codigos.representantes);

IF SQLCA.SQLCode <> -1 THEN 
	MessageBox(g_titulo,"Se a$$HEX1$$f100$$ENDHEX$$adi$$HEX2$$f3002000$$ENDHEX$$el representante correctamente")
	Message.DoubleParm=1
else
	MessageBox(g_titulo,"Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al a$$HEX1$$f100$$ENDHEX$$adir el representante",StopSign!)
	modificado=0
	Message.DoubleParm=0
end if

return modificado
end event

event type long dw_subsanacion_incidencias::csd_tipo_tercero_cliente();string id_cliente,id_cli_ter

id_cliente = idw_subsanacion_incidencias.GetItemString(1,'codigo_anomalo')

id_cli_ter=f_siguiente_numero('CLIENTES_TERCEROS',10)

insert into  clientes_terceros (id,id_cliente,c_tercero) values (:id_cli_ter,:id_cliente,'01');


Message.DoubleParm=1


return 1

end event

type dw_incidencias from w_eimporta_detalle_base`dw_incidencias within tabpage_1
end type

type lb_1 from w_eimporta_detalle_base`lb_1 within w_eimporta_detalle
end type

type st_3 from w_eimporta_detalle_base`st_3 within w_eimporta_detalle
end type

type st_div from w_eimporta_detalle_base`st_div within w_eimporta_detalle
end type

type st_div2 from w_eimporta_detalle_base`st_div2 within w_eimporta_detalle
end type

type rb_otra_carpeta from w_eimporta_detalle_base`rb_otra_carpeta within w_eimporta_detalle
end type

type st_5 from w_eimporta_detalle_base`st_5 within w_eimporta_detalle
integer height = 228
end type

type cb_obs from w_eimporta_detalle_base`cb_obs within w_eimporta_detalle
end type

type cb_importar from commandbutton within w_eimporta_detalle
integer x = 1527
integer y = 756
integer width = 302
integer height = 72
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Importar"
end type

event clicked;if g_colegio='COAATNA' then
	open(w_importa_para_crear_ini)
else
	open(w_eimporta_xml_mca)
end if
end event

