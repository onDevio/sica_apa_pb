HA$PBExportHeader$w_regsoc_lista.srw
forward
global type w_regsoc_lista from w_lista
end type
end forward

global type w_regsoc_lista from w_lista
string title = "Lista Registro Sociedades"
string menuname = "m_regsoc_lista"
event csd_plantillas ( )
end type
global w_regsoc_lista w_regsoc_lista

type variables
string is_ruta_plantillas
end variables

forward prototypes
public function string f_regsoc_razon (string id_regsoc)
end prototypes

event csd_plantillas();// **********************************		DECLARACION DE VARIABLES		*************************** 
int i, j
datastore ds_sociedades
double insertadas
string id_col, codigo, ruta,email, n_col, id_regsoc
st_retorno_seleccion retorno
n_csd_plantillas uo_plantillas

// **********************************		SELECCIONAMOS LA PLANTILLA 		***************************
//Abrimos la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de plantillas
st_plantillas_seleccion datos_plantillas
datos_plantillas.modulo='REGSOC'
if dw_lista.rowcount()=1 then
	datos_plantillas.mostrar_cbx_editar_plantilla=true
else
	datos_plantillas.mostrar_cbx_editar_plantilla=false
end if

OpenwithParm(w_plantillas_seleccion,datos_plantillas)

retorno = Message.powerobjectparm

if retorno.ruta = '-1' then return

retorno.ruta = is_ruta_plantillas + retorno.ruta

if not fileexists(retorno.ruta) then
	messagebox(g_titulo_aplicacion,g_idioma.of_getmsg('colegiados.plantilla','La plantilla seleccionada no existe'))
	return	
end if

//Valida que cuando la plantilla es de caracter individual debe haber solo un colegiado
if dw_lista.rowcount()>1 and retorno.individual = 'S' then
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.seleccion-colegiado',"Seleccione solo un colegiado para generar el documento"))
	return
end if

//Creamos el datastore de Colegiados para las plantillas de colegiados
ds_sociedades = create datastore
ds_sociedades.dataobject = 'd_regsoc_plantillas'

// Creamos el objeto de plantillas y rellenamos sus parametros
uo_plantillas=create n_csd_plantillas
uo_plantillas.ruta_plantilla = retorno.ruta
uo_plantillas.mdb='plantillas.txt'
uo_plantillas.ruta_mdb=is_ruta_plantillas+'plantillas.txt'

	//Para cada colegiado... deberemos llamar a la funcion de f_colegiados_rellena_estructura
	for i= 1 to dw_lista.rowcount()
		id_regsoc = dw_lista.GetItemString(i,'id_regsoc')
		
		f_regsoc_rellena_estructura(id_regsoc,ds_sociedades,retorno)	
	next
	
	setpointer(hourglass!)
	

if ds_sociedades.rowcount() > 0 then
	uo_plantillas.nombre_plantilla = f_obtiene_nombre_plantilla(retorno.codigo)
	uo_plantillas.is_modulo_asociado = retorno.modulo
	//Si la plantilla es masiva se selecciona el Colegiado Ficticio
	if retorno.individual = 'N' then
		uo_plantillas.is_colegiado = string(g_colegiado_comodin)
	else
		uo_plantillas.is_colegiado = n_col
	end if
	
	uo_plantillas.is_codigo = retorno.codigo
	uo_plantillas.is_registro = 'X' //ds_sociedades.getitemstring(1, 'registro_salida')
	uo_plantillas.f_combinar_plantilla_txt()

else
	messagebox(g_titulo,g_idioma.of_getmsg('colegiados.fallo_captura', "Imposible generar los documentos por un fallo en la captura de datos"))
end if


//Destruimos los datastores, el objeto ole y desconectamos.
destroy ds_sociedades

setpointer(arrow!)

end event

public function string f_regsoc_razon (string id_regsoc);//devuelve la razon
string devolver,id_colegiado

//if g_modo_funcionamiento='1' then	
	select id_colegiado_sociedad into :id_colegiado from regsoc where id_regsoc=:id_regsoc;
	if f_es_vacio(id_colegiado) then return ''
   select apellidos into :devolver from colegiados where id_colegiado=:id_colegiado;
//else
//	select razon_social into :devolver from regsoc where id_regsoc=:id_regsoc;
//end if
if f_es_vacio(devolver) then return ''

return devolver
end function

on w_regsoc_lista.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_regsoc_lista" then this.MenuID = create m_regsoc_lista
end on

on w_regsoc_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;i_sql_original = dw_lista.Describe("Datawindow.Table.Select")

of_SetResize (true)

inv_resize.of_Register (st_1, "FixedtoBottom")
inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_consulta, "FixedtoBottom")
inv_resize.of_Register (cb_detalle, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")

is_ruta_plantillas= Profilestring(gnv_app.of_getappinifile(),"Regsoc","path_plantillas","")
// De momento sin consulta, retrieveamos todo
//dw_lista.retrieve()
end event

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_regsoc
g_w_detalle = g_detalle_regsoc
g_lista     = 'w_regsoc_lista'
g_detalle   = 'w_regsoc_detalle'
end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return

//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_regsoc_consulta = dw_lista.getitemstring(dw_lista.getrow(),'id_regsoc')

message.stringparm = "w_regsoc_detalle"
w_aplic_frame.postevent("csd_regsoc_detalle")
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_regsoc = dw_lista
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_regsoc, g_detalle, w_aplic_frame, 0, original!)
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_regsoc_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_listados;call super::csd_listados;open(w_regsoc_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_regsoc_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_regsoc_lista
end type

type st_1 from w_lista`st_1 within w_regsoc_lista
end type

type dw_lista from w_lista`dw_lista within w_regsoc_lista
string dataobject = "d_regsoc_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_regsoc_lista
string facename = "Microsoft Sans Serif"
end type

type cb_detalle from w_lista`cb_detalle within w_regsoc_lista
string facename = "Microsoft Sans Serif"
end type

type cb_ayuda from w_lista`cb_ayuda within w_regsoc_lista
string facename = "Microsoft Sans Serif"
end type

