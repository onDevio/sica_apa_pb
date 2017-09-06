HA$PBExportHeader$w_colegiados_consulta.srw
forward
global type w_colegiados_consulta from w_consulta
end type
type tab_1 from tab within w_colegiados_consulta
end type
type tabpage_1 from userobject within tab_1
end type
type dw_datos_personales from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_datos_personales dw_datos_personales
end type
type tabpage_2 from userobject within tab_1
end type
type dw_fechas from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_fechas dw_fechas
end type
type tabpage_3 from userobject within tab_1
end type
type dw_servicios from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_servicios dw_servicios
end type
type tabpage_4 from userobject within tab_1
end type
type dw_alta_si_no from u_dw within tabpage_4
end type
type dw_opcion_bajas from u_dw within tabpage_4
end type
type dw_opcion_altas from u_dw within tabpage_4
end type
type dw_opcion_situaciones from u_dw within tabpage_4
end type
type cb_borrar3 from commandbutton within tabpage_4
end type
type cb_todos3 from commandbutton within tabpage_4
end type
type cb_borrar2 from commandbutton within tabpage_4
end type
type cb_todos2 from commandbutton within tabpage_4
end type
type dw_t_baja from u_dw within tabpage_4
end type
type dw_situaciones from u_dw within tabpage_4
end type
type cb_todos1 from commandbutton within tabpage_4
end type
type cb_borrar1 from commandbutton within tabpage_4
end type
type gb_3 from groupbox within tabpage_4
end type
type gb_1 from groupbox within tabpage_4
end type
type dw_t_alta from u_dw within tabpage_4
end type
type gb_2 from groupbox within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_alta_si_no dw_alta_si_no
dw_opcion_bajas dw_opcion_bajas
dw_opcion_altas dw_opcion_altas
dw_opcion_situaciones dw_opcion_situaciones
cb_borrar3 cb_borrar3
cb_todos3 cb_todos3
cb_borrar2 cb_borrar2
cb_todos2 cb_todos2
dw_t_baja dw_t_baja
dw_situaciones dw_situaciones
cb_todos1 cb_todos1
cb_borrar1 cb_borrar1
gb_3 gb_3
gb_1 gb_1
dw_t_alta dw_t_alta
gb_2 gb_2
end type
type tabpage_5 from userobject within tab_1
end type
type dw_datos_sitprof from u_dw within tabpage_5
end type
type dw_datos_agrupacion from u_dw within tabpage_5
end type
type dw_opcion_incomp from u_dw within tabpage_5
end type
type dw_opcion_sit from u_dw within tabpage_5
end type
type dw_opcion_agr from u_dw within tabpage_5
end type
type rb_inc_si from radiobutton within tabpage_5
end type
type rb_sit_no from radiobutton within tabpage_5
end type
type rb_si from radiobutton within tabpage_5
end type
type cb_6 from commandbutton within tabpage_5
end type
type cb_5 from commandbutton within tabpage_5
end type
type cb_4 from commandbutton within tabpage_5
end type
type cb_3 from commandbutton within tabpage_5
end type
type dw_incompatibilidades from u_dw within tabpage_5
end type
type dw_sit_profesionales from u_dw within tabpage_5
end type
type cb_borrar4 from commandbutton within tabpage_5
end type
type cb_incluir4 from commandbutton within tabpage_5
end type
type gb_5 from groupbox within tabpage_5
end type
type gb_6 from groupbox within tabpage_5
end type
type dw_agrupaciones from u_dw within tabpage_5
end type
type gb_8 from groupbox within tabpage_5
end type
type gb_4 from groupbox within tabpage_5
end type
type gb_7 from groupbox within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_datos_sitprof dw_datos_sitprof
dw_datos_agrupacion dw_datos_agrupacion
dw_opcion_incomp dw_opcion_incomp
dw_opcion_sit dw_opcion_sit
dw_opcion_agr dw_opcion_agr
rb_inc_si rb_inc_si
rb_sit_no rb_sit_no
rb_si rb_si
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_incompatibilidades dw_incompatibilidades
dw_sit_profesionales dw_sit_profesionales
cb_borrar4 cb_borrar4
cb_incluir4 cb_incluir4
gb_5 gb_5
gb_6 gb_6
dw_agrupaciones dw_agrupaciones
gb_8 gb_8
gb_4 gb_4
gb_7 gb_7
end type
type tabpage_10 from userobject within tab_1
end type
type dw_ejerciente_si_no from u_dw within tabpage_10
end type
type dw_opcion_residente from u_dw within tabpage_10
end type
type dw_residente from u_dw within tabpage_10
end type
type cb_borrar5 from commandbutton within tabpage_10
end type
type cb_todos5 from commandbutton within tabpage_10
end type
type gb_15 from groupbox within tabpage_10
end type
type tabpage_10 from userobject within tab_1
dw_ejerciente_si_no dw_ejerciente_si_no
dw_opcion_residente dw_opcion_residente
dw_residente dw_residente
cb_borrar5 cb_borrar5
cb_todos5 cb_todos5
gb_15 gb_15
end type
type tabpage_6 from userobject within tab_1
end type
type dw_permiso_cesion_datos from u_dw within tabpage_6
end type
type gb_9 from groupbox within tabpage_6
end type
type cb_8 from commandbutton within tabpage_6
end type
type cb_7 from commandbutton within tabpage_6
end type
type dw_opciones_orientaciones from u_dw within tabpage_6
end type
type dw_consulta_orientaciones from u_dw within tabpage_6
end type
type gb_10 from groupbox within tabpage_6
end type
type dw_otros_datos from u_dw within tabpage_6
end type
type gb_11 from groupbox within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_permiso_cesion_datos dw_permiso_cesion_datos
gb_9 gb_9
cb_8 cb_8
cb_7 cb_7
dw_opciones_orientaciones dw_opciones_orientaciones
dw_consulta_orientaciones dw_consulta_orientaciones
gb_10 gb_10
dw_otros_datos dw_otros_datos
gb_11 gb_11
end type
type tabpage_7 from userobject within tab_1
end type
type dw_datos_musaat from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_datos_musaat dw_datos_musaat
end type
type tabpage_8 from userobject within tab_1
end type
type dw_datos_premaat from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
dw_datos_premaat dw_datos_premaat
end type
type tabpage_9 from userobject within tab_1
end type
type dw_contratos from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
dw_contratos dw_contratos
end type
type tab_1 from tab within w_colegiados_consulta
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_10 tabpage_10
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
end forward

global type w_colegiados_consulta from w_consulta
integer y = 80
integer width = 3287
integer height = 2296
string title = "Consulta de Colegiados"
event csd_consulta_general ( )
event csd_consulta_fechas ( )
event csd_consulta_servicios ( )
event csd_consulta_sit_colegial ( )
event csd_consulta_profesional ( )
event csd_consulta_otros_datos ( )
event csd_consulta_musaat ( )
event csd_consulta_premaat ( )
event csd_consulta_contratos ( )
event csd_consulta_residente ( )
event csd_oculta ( )
tab_1 tab_1
end type
global w_colegiados_consulta w_colegiados_consulta

type variables
u_dw idw_situaciones,idw_t_alta,idw_t_baja,idw_agrupaciones,idw_sit_profesionales
u_dw idw_incompatibilidades
u_dw idw_general,idw_fechas,idw_servicios
u_dw idw_opcion_sit,idw_opcion_altas,idw_opcion_bajas,idw_opcion_orientaciones
u_dw idw_opcion_agr,idw_opcion_sitprof,idw_opcion_incompat,idw_opcion_otros
u_dw idw_datos_agrupacion,idw_datos_sitprof
u_dw idw_otros_datos,idw_orientaciones,idw_alta_sn
u_dw idw_musaat,idw_premaat, idw_contratos, idw_opcion_residente, idw_residente
u_dw idw_permiso_cesion_datos, idw_ejerciente_sn
string i_sql_nuevo
string i_modulo = "colegiados"
end variables

forward prototypes
public function integer f_cambia_ididoma_usuario (window ventana, datawindow dw, string objeto, integer tiene_dw, string texto_objeto)
end prototypes

event csd_consulta_general();string sql_aux
  
f_sql('n_colegiado','LIKE','n_colegiado',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('n_colegiado','>=','n_cold',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('n_colegiado','<=','n_colh',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('nif','LIKE','nif_cif',idw_general,i_sql_nuevo,g_tipo_base_datos,'')
f_sql('apellidos','LIKE','apellido_nombresociedad',idw_general,i_sql_nuevo,'1','')
f_sql('nombre','LIKE','nombre',idw_general,i_sql_nuevo,'1','')
f_sql('tipo_persona','LIKE','tipo_persona',idw_general,i_sql_nuevo,'1','')
f_sql('colegiados.n_consejo','LIKE','n_consejo',idw_general,i_sql_nuevo,'1','')
f_sql('sexo','LIKE','sexo',idw_general,i_sql_nuevo,'1','')
//f_sql('colegiados.c_geografico','=','codigo_geografico',idw_general,i_sql_nuevo,'1','')
f_sql('colegiados.colegio','LIKE','colegio',idw_general,i_sql_nuevo,'1','')
f_sql('demarcacion','LIKE','colegio_territorial',idw_general,i_sql_nuevo,'1','')
f_sql('delegacion','LIKE','delegacion',idw_general,i_sql_nuevo,'1','')

// Modificado Ricardo 04-07-12
// Por familia de conceptos
if not f_es_vacio(idw_general.getitemstring(1,'familia')) then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux = " and "
	else
		sql_aux = " WHERE "
	end if	
	sql_aux += " colegiados.id_colegiado IN (SELECT id_colegiado FROM conceptos_domiciliables, csi_articulos_servicios WHERE conceptos_domiciliables.concepto= csi_articulos_servicios.codigo and familia = '"+idw_general.getitemstring(1,'familia')+"')"	
	i_sql_nuevo += sql_aux
	sql_aux = ''
end if
// FIN Modificado Ricardo 04-07-12

//Todos los colegiados que tengan el concepto domiciliable elegido
if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
	sql_aux = "and colegiados.id_colegiado IN (SELECT id_colegiado FROM conceptos_domiciliables WHERE concepto='"+idw_general.getitemstring(1,'conceptos_domiciliables')+"')"
else
	sql_aux = "WHERE colegiados.id_colegiado IN (SELECT id_colegiado FROM conceptos_domiciliables WHERE concepto='"+idw_general.getitemstring(1,'conceptos_domiciliables')+"')"
end if	
if not isnull(sql_aux) then i_sql_nuevo += sql_aux

// Todos los colegiados que pertenezcan a la lista de colegiados elegida..
// Pero comprobando si hay que incluirlos o incluirlos
string incl_excl, operador_not
operador_not = ''
incl_excl = idw_general.GetItemString(1,'incluir_lista')
if incl_excl = 'E' then operador_not = ' NOT '

if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
	sql_aux = "and colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_colegiados')+"')"
else
	sql_aux = "WHERE colegiados.id_colegiado " + operador_not + "IN (SELECT id_lista_miembro FROM listas_miembros WHERE id_lista='"+idw_general.getitemstring(1,'lista_colegiados')+"')"
end if	
if not isnull(sql_aux) then i_sql_nuevo += sql_aux

// Todos los colegiados que tengan un domicilio en la poblaci$$HEX1$$f300$$ENDHEX$$n elegida
if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
	sql_aux = "and colegiados.id_colegiado IN (SELECT id_colegiado FROM domicilios WHERE cod_pob='"+idw_general.getitemstring(1,'cod_pob')+"')"
else
	sql_aux = "WHERE colegiados.id_colegiado IN (SELECT id_colegiado FROM domicilios WHERE cod_pob='"+idw_general.getitemstring(1,'cod_pob')+"')"
end if	

// Julian Melero
if not isnull( idw_general.getitemstring(1,'desc_pob')) then
if PosA(upper(i_sql_nuevo), "WHERE") > 0 then

	sql_aux = "and colegiados.id_colegiado IN (SELECT dom.id_colegiado FROM domicilios dom, poblaciones pob WHERE dom.cod_pob = pob.cod_pob and pob.descripcion like '"+idw_general.getitemstring(1,'desc_pob')+"')"
else
	sql_aux = "WHERE colegiados.id_colegiado IN (SELECT dom.id_colegiado FROM domicilios dom, poblaciones pob WHERE dom.cod_pob = pob.cod_pob and pob.descripcion like '"+idw_general.getitemstring(1,'desc_pob')+"')"
end if	
end if

if not isnull(sql_aux) then i_sql_nuevo += sql_aux

//Los colegiados separados por comas...
if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
	if not isnull(idw_general.getitemstring(1,'otros_colegiados')) then
		i_sql_nuevo = i_sql_nuevo + "and colegiados.n_colegiado IN ("+f_coloca_comillas(idw_general.getitemstring(1,'otros_colegiados'))+")"
	end if
else
	if not isnull(idw_general.getitemstring(1,'otros_colegiados')) then
		i_sql_nuevo = i_sql_nuevo + "WHERE colegiados.n_colegiado IN ("+f_coloca_comillas(idw_general.getitemstring(1,'otros_colegiados'))+")"
	end if
end if

f_sql('aviso','LIKE INSIDE','avisos',idw_general,i_sql_nuevo,'1','')
f_sql('observaciones','LIKE INSIDE','observ',idw_general,i_sql_nuevo,'1','')
end event

event csd_consulta_fechas;f_sql('f_nacimiento','>=','f_nacimiento_desde',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_nacimiento','<','f_nacimiento_hasta',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_titulacion','>=','f_titulacion_desde',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_titulacion','<','f_titulacion_hasta',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_colegiacion','>=','f_colegiacion_desde',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_colegiacion','<','f_colegiacion_hasta',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_baja','>=','f_baja_desde',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_baja','<','f_baja_hasta',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_alta','>=','f_alta_desde',idw_fechas,i_sql_nuevo,'1','')
f_sql('f_alta','<','f_alta_hasta',idw_fechas,i_sql_nuevo,'1','')

end event

event csd_consulta_servicios();string foto,firma,operador,sql_aux

foto = idw_servicios.getitemstring(1,'foto')
firma= idw_servicios.getitemstring(1,'firma')
//Cesi$$HEX1$$f300$$ENDHEX$$n de datos:
f_sql('colegiados.per_todos_datos','LIKE','per_todos_datos',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.per_comer_notel','LIKE','per_comer_notel',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.per_comer_sitel','LIKE','per_comer_sitel',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.recibir_c_postales','LIKE','recibir_c_postales',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.recibir_c_email','LIKE','recibir_c_email',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.todos_servicios','LIKE','todos_servicios',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.embargo_hacienda','LIKE','embargo_hacienda',idw_servicios,i_sql_nuevo,'1','') // Modificado Ricardo 2005-03-15
f_sql('colegiados.moroso','LIKE','moroso',idw_servicios,i_sql_nuevo,'1','') 
f_sql('colegiados.visible_web','LIKE','visible_web',idw_servicios,i_sql_nuevo,'1','')
f_sql('colegiados.publicidad','LIKE','publicidad',idw_servicios,i_sql_nuevo,'1','')

//Comprobamos si el colegiado tiene foto
if foto<>'%' then
	if foto = 'N' then operador = 'NOT' else operador = ''
	if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
		sql_aux = "and colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from fotos_firmas_colegiados where tipo='O' and activa='S')"
	else
		sql_aux = "WHERE colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from fotos_firmas_colegiados where tipo='O' and activa='S')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux
end if

//Comprobamos si tienen firma
if firma<>'%' then
	if firma = 'N' then operador = 'NOT' else operador = ''
	if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
		sql_aux = "and colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from fotos_firmas_colegiados where tipo='I' and activa='S')"
	else
		sql_aux = "WHERE colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from fotos_firmas_colegiados where tipo='I' and activa='S')"
	end if	
	if not isnull(sql_aux) then i_sql_nuevo += sql_aux
end if
end event

event csd_consulta_sit_colegial();string codigos,sql_aux,opcion,operador,alta
boolean coma
int i
//Todos los colegiados que pertenezcan a la situaci$$HEX1$$f300$$ENDHEX$$nes elegidas, ya q se pueden elegir varias de una lista

opcion = idw_opcion_sit.GetItemString(1,'opcion')
alta = idw_alta_sn.GetItemString(1,'alta')
if alta<>'%' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = "and colegiados.alta_baja = '"+alta+"'"
		else
			sql_aux = "WHERE colegiados.alta_baja = '"+alta+"'"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
end if
if opcion<>'%'  then
	coma=false
	for i=1 to idw_situaciones.RowCount()
		if idw_situaciones.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_situaciones.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
	if opcion = 'S' then operador=''
	if opcion = 'N' then operador = 'NOT'
	
	if codigos<>'' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = "and colegiados.situacion "+operador+" IN ("+codigos+")"
		else
			sql_aux = "WHERE colegiados.situacion "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
	end if
end if

//Todos los colegiados que pertenezcan al tipo de alta elegido, ya q se pueden elegir varias de una lista
coma=false
codigos=''
opcion = 'S' //idw_opcion_altas.GetItemString(1,'opcion')

if opcion<>'%' and idw_alta_sn.GetItemString(1,'alta')='S' then
	for i=1 to idw_t_alta.RowCount()
		if idw_t_alta.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_t_alta.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
	if opcion = 'S' then operador=''
	if opcion = 'N' then operador = 'NOT'
	if codigos<>'' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = "and colegiados.t_alta "+operador+" IN ("+codigos+")"
		else
			sql_aux = "WHERE colegiados.t_alta "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
	end if
end if

//Todos los colegiados que pertenezcan al tipo de baja elegido, ya q se pueden elegir varias de una lista
coma=false
codigos=''
opcion = 'S' //idw_opcion_bajas.GetItemString(1,'opcion')

if opcion<>'%' and idw_alta_sn.GetItemString(1,'alta')='N' then
	for i=1 to idw_t_baja.RowCount()
		if idw_t_baja.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_t_baja.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
	if opcion = 'S' then operador=''
	if opcion = 'N' then operador = 'NOT'
	if codigos<>'' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = "and colegiados.t_baja "+operador+" IN ("+codigos+")"
		else
			sql_aux = "WHERE colegiados.t_baja "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
	end if
end if

end event

event csd_consulta_profesional();// Agrupaciones
boolean coma
string codigos = '',sql_aux,operador,opcion
string alta,sql_aux2=''
datetime df_inicio,hf_inicio,df_fin,hf_fin
int i

idw_datos_agrupacion.AcceptText()

df_inicio 	= idw_datos_agrupacion.GetItemDatetime(1,'df_inicio')
df_fin 		= idw_datos_agrupacion.GetItemDatetime(1,'df_fin')
hf_inicio 	= idw_datos_agrupacion.GetItemDatetime(1,'hf_inicio')
hf_fin 		= idw_datos_agrupacion.GetItemDatetime(1,'hf_fin')

if not isnull(df_inicio) then sql_aux= sql_aux + " and agrupaciones.f_inicio>='"+string(date(df_inicio),'yyyymmdd')+"'"
if not isnull(hf_inicio) then sql_aux= sql_aux + " and agrupaciones.f_inicio<'"+string(date(hf_inicio),'yyyymmdd')+"'"
if not isnull(df_fin) then sql_aux= sql_aux + " and agrupaciones.f_fin>='"+string(date(df_fin),'yyyymmdd')+"'"
if not isnull(hf_fin) then sql_aux= sql_aux + " and agrupaciones.f_fin<'"+string(date(hf_fin),'yyyymmdd')+"'"

//Todos los colegiados que pertenezcan a las agrupaciones elegidas, ya q se pueden elegir varias de una lista
coma=false
opcion = idw_opcion_agr.GetItemString(1,'opcion')
if opcion<>'%' then
	for i=1 to idw_agrupaciones.RowCount()
		if idw_agrupaciones.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_agrupaciones.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
end if

if sql_aux <> '' or codigos <> '' then
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'colegiados.id_colegiado = agrupaciones.id_colegiado'})
	i_sql_nuevo += sql_aux
	if codigos <> '' then i_sql_nuevo += ' and agrupaciones.agrupacion IN ( '+codigos+')'
end if

//Incompatibilidades
string pob,org
sql_aux=''
pob = idw_datos_sitprof.GetItemString(1,'poblacion')
org = idw_datos_sitprof.GetItemString(1,'organismo')
df_inicio 	= idw_datos_sitprof.GetItemDatetime(1,'df_inicio')
df_fin 		= idw_datos_sitprof.GetItemDatetime(1,'df_fin')
hf_inicio 	= idw_datos_sitprof.GetItemDatetime(1,'hf_inicio')
hf_fin 		= idw_datos_sitprof.GetItemDatetime(1,'hf_fin')

if not f_es_vacio(pob) then sql_aux= sql_aux + " and incompatibilidades.cod_pob like '"+pob+"%'"
if not f_es_vacio(org) then sql_aux= sql_aux + " and incompatibilidades.organismo like'"+org+"%'"
if not isnull(df_inicio) then sql_aux= sql_aux + " and incompatibilidades.fecha_inicio>='"+string(date(df_inicio),'yyyymmdd')+"'"
if not isnull(hf_inicio) then sql_aux= sql_aux + " and incompatibilidades.fecha_inicio<'"+string(date(hf_inicio),'yyyymmdd')+"'"
if not isnull(df_fin) then sql_aux= sql_aux + " and incompatibilidades.fecha_fin>='"+string(date(df_fin),'yyyymmdd')+"'"
if not isnull(hf_fin) then sql_aux= sql_aux + " and incompatibilidades.fecha_fin<'"+string(date(hf_fin),'yyyymmdd')+"'"

//Todos los colegiados que pertenezcan a las Situaciones Profesionales elegidas, ya q se pueden elegir varias de una lista
string codigos_sitprof
opcion = idw_opcion_sitprof.GetItemString(1,'opcion')
coma=false
if opcion<>'%' then
	for i=1 to idw_sit_profesionales.RowCount()
		if idw_sit_profesionales.GetItemString(i,'activo') = 'S' then
			if coma then codigos_sitprof= codigos_sitprof+','
			codigos_sitprof = codigos_sitprof+"'"+idw_sit_profesionales.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
end if

//Todos los colegiados que Tengan las Incompatibilidades elegidas, ya q se pueden elegir varias de una lista
string codigos_incomp
opcion = idw_opcion_incompat.GetItemString(1,'opcion')
if opcion<>'%' then
	coma=false
	for i=1 to idw_incompatibilidades.RowCount()
		if idw_incompatibilidades.GetItemString(i,'activo') = 'S' then
			if coma then codigos_incomp= codigos_incomp+','
			codigos_incomp = codigos_incomp+"'"+idw_incompatibilidades.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next
end if
if sql_aux <> '' or codigos_sitprof <> '' or codigos_incomp <> '' then
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'colegiados.id_colegiado = incompatibilidades.id_colegiado'})
	i_sql_nuevo += sql_aux
	if codigos_sitprof <> '' then i_sql_nuevo += ' and incompatibilidades.tipo_situacion IN ( '+codigos_sitprof+')'
	if codigos_incomp <> '' then i_sql_nuevo += ' and incompatibilidades.tipo_incompatibilidad IN ( '+codigos_incomp+')'	
end if

end event

event csd_consulta_otros_datos();int i
datetime fecha
double numero
string s_n,texto,codigo,sql_aux,operador='',codigos,visible_web
boolean coma, lb_join_otros = false

//Apartado de 'Otros Datos'
for i = 1 to idw_otros_datos.rowcount()
	setnull(fecha)
	setnull(numero)
	sql_aux=''
	codigo = idw_otros_datos.getItemString(i,'codigo')
	fecha = idw_otros_datos.GetItemDatetime(i,'fecha')
	s_n = idw_otros_datos.getItemString(i,'s_n')
	texto = idw_otros_datos.getItemString(i,'texto')
	numero = idw_otros_datos.getItemNumber(i,'numero')
	
	if not f_es_vacio(string(fecha)) then sql_aux = sql_aux + " and fecha = '"+string(fecha, 'mm/dd/yyyy')+"'"
	if not f_es_vacio(texto) then sql_aux = sql_aux + " and texto like '"+texto+"'"
	if not f_es_vacio(string(numero)) then sql_aux = sql_aux + " and numero ="+string(numero)
	if s_n<>'%' then sql_aux= sql_aux + " and s_n like '"+s_n+"'"
	operador=''
	if sql_aux<>'' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = " and colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from otros_datos_colegiado where cod_caracteristica='"+codigo+"'"+sql_aux+")"
		else
			sql_aux = " WHERE colegiados.id_colegiado "+operador+" IN (SELECT id_colegiado from otros_datos_colegiado where cod_caracteristica='"+codigo+"'"+sql_aux+")"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
	end if
next

//Apartado 'Orientaciones Profesionales'
operador = idw_opcion_orientaciones.GetItemString(1,'opcion')
if operador<>'%' then
	coma=false
	for i=1 to idw_orientaciones.RowCount()
		if idw_orientaciones.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_orientaciones.GetItemString(i,'codigo')+"'"
			coma = true
		end if
	next

end if
if codigos <> '' then
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'colegiados.id_colegiado = orientaciones_profesionales.id_colegiado'})
	if codigos <> '' then i_sql_nuevo += ' and orientaciones_profesionales.orientacion_profesional IN ( '+codigos+')'
end if

//Andr$$HEX1$$e900$$ENDHEX$$s 1/4/2005
//Apartado 'Permiso cesi$$HEX1$$f300$$ENDHEX$$n datos'
visible_web=idw_permiso_cesion_datos.getitemstring(1,'visible_web')
if visible_web<>'%' then
	f_sql('visible_web','LIKE','visible_web',idw_permiso_cesion_datos,i_sql_nuevo,'1','')
end if
string activo_cp
activo_cp=idw_permiso_cesion_datos.getitemstring(1,'activo_cp')
if activo_cp<>'%' then
	f_sql('activo_cp','LIKE','activo_cp',idw_permiso_cesion_datos,i_sql_nuevo,'1','')
end if

end event

event csd_consulta_musaat();string sql_aux, src_alta, src_cober, acci_alta, tasa_alta, tasa_cober, exc_alta, exc_cober,src_t_poliza
string exc_n_poliza, alta_otros_src, cia_otros_src,peritos_alta,peritos_n_poliza, peritos_cia
double src_bonus_d, src_bonus_h, src_importe_d, src_importe_h, acci_importe_d, acci_importe_h
double tasa_importe_d, tasa_importe_h

// Seguro Responsabilidad Civil
src_alta = idw_musaat.getItemString(1,'src_de_alta')
src_cober = idw_musaat.getItemString(1,'src_cober')
src_t_poliza = idw_musaat.getItemString(1,'src_t_poliza')
src_bonus_d = idw_musaat.getItemNumber(1,'src_bonus_malus_desde')
src_bonus_h = idw_musaat.getItemNumber(1,'src_bonus_malus_hasta')
exc_alta = idw_musaat.getItemString(1,'exceso_alta')
exc_cober = idw_musaat.getItemString(1,'exceso_cober')
exc_n_poliza = idw_musaat.getItemString(1,'exceso_n_poliza')

// Seguro Accidentes
acci_alta = idw_musaat.getItemString(1,'acci_de_alta')

// Seguro Tasaciones
tasa_alta = idw_musaat.getItemString(1,'tasa_de_alta')
tasa_cober = idw_musaat.getItemString(1,'tasa_cober')

alta_otros_src = idw_musaat.getItemString(1,'alta_otros_src')
cia_otros_src = idw_musaat.getItemString(1,'cia_otros_src')

// Seguro Peritos
peritos_alta = idw_musaat.getItemString(1,'peritos_alta')
peritos_n_poliza = idw_musaat.getItemString(1,'peritos_n_poliza')
peritos_cia = idw_musaat.getItemString(1,'peritos_cia')


if (src_alta <> '%') or (f_es_vacio(src_cober) = false) or (f_es_vacio(string(src_bonus_d)) = false ) &
or ( f_es_vacio(string(src_bonus_h)) = false ) or (acci_alta <> '%' ) or (tasa_alta <> '%') or (f_es_vacio(tasa_cober)= false) &
or (exc_alta <> '%') or (f_es_vacio(exc_cober) = false) or (f_es_vacio(exc_n_poliza) = false) or (alta_otros_src <> '%') or  (f_es_vacio(cia_otros_src)=false) &
or (f_es_vacio(peritos_n_poliza) = false) or (peritos_alta <> '%') or  (f_es_vacio(peritos_cia)=false) then
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'( colegiados.id_colegiado = musaat.id_col )'})
end if

// Seguro Responsabilidad Civil
if src_alta <> '%' then i_sql_nuevo += " and ( musaat.src_alta like'"+src_alta+"') "
if not f_es_vacio(src_cober) then i_sql_nuevo += " and ( musaat.src_cober like'"+src_cober+"') "
if not f_es_vacio(src_t_poliza) then i_sql_nuevo += " and ( musaat.src_t_poliza like'"+src_t_poliza+"') "
if not f_es_vacio(string(src_bonus_d)) then i_sql_nuevo += " and ( musaat.src_coef_cm>="+f_cambia_comas_decimales(src_bonus_d)+") "
if not f_es_vacio(string(src_bonus_h)) then i_sql_nuevo += " and ( musaat.src_coef_cm<="+f_cambia_comas_decimales(src_bonus_h)+") "
if exc_alta <> '%' then i_sql_nuevo += " and ( musaat.exceso like'"+exc_alta+"') "
if not f_es_vacio(exc_cober) then i_sql_nuevo += " and ( musaat.exceso_cobertura like'"+exc_cober+"') "
if not f_es_vacio(exc_n_poliza) then i_sql_nuevo += " and ( musaat.exceso_n_poliza like'"+exc_n_poliza+"') "

// Otros seguros SRC
if (alta_otros_src <> '%' or  (f_es_vacio(cia_otros_src) = false)) then
		i_sql_nuevo = f_sql_join(i_sql_nuevo, {'( musaat.id_col = src_colegiado.id_colegiado)'})
		i_sql_nuevo += " and ( src_colegiado.alta like '"+alta_otros_src+"') "
end if 
if (f_es_vacio(cia_otros_src) = false) then i_sql_nuevo += " and ( src_colegiado.src_cia = '" + cia_otros_src + "') "

// Seguro Accidentes
if acci_alta <> '%' then i_sql_nuevo += " and ( musaat.accidentes_alta like'"+acci_alta+"')"

// Seguro Tasaciones
if tasa_alta <> '%' then i_sql_nuevo += " and ( musaat.tasadores_alta like'"+tasa_alta+"')"
if not f_es_vacio(tasa_cober) then i_sql_nuevo += " and ( musaat.tasadores_cober like'"+tasa_cober+"')"

// Seguro Peritos
if peritos_alta <> '%' then i_sql_nuevo += " and ( musaat.peritos_alta like'"+peritos_alta+"')"
if not f_es_vacio(peritos_n_poliza) then i_sql_nuevo += " and ( musaat.peritos_n_poliza like'"+peritos_n_poliza+"')"
if not f_es_vacio(peritos_cia) then i_sql_nuevo += " and ( musaat.peritos_cia like'"+peritos_cia+"')"

end event

event csd_consulta_premaat();string sql_aux, alta, grupo, comple_1, comple_2,alta_reta
double importe_cobrar_d, importe_cobrar_h, importe_pagar_d, importe_pagar_h

alta = idw_premaat.getItemString(1,'alta_total')
grupo = idw_premaat.getItemString(1,'grupo')
comple_1 = idw_premaat.getItemString(1,'comple1')
comple_2 = idw_premaat.getItemString(1,'comple2')
importe_cobrar_d = idw_premaat.getItemNumber(1,'importe_cobrar_desde')
importe_cobrar_h = idw_premaat.getItemNumber(1,'importe_cobrar_hasta')

alta_reta = idw_premaat.getItemString(1,'alta_reta')

if ( alta <> '%' ) or ( alta_reta <> '%' ) or (f_es_vacio(grupo) = false) or (comple_1 <> '%') or (comple_2 <> '%') or (f_es_vacio(string(importe_cobrar_d)) = false) &
or (f_es_vacio(string(importe_cobrar_h)) = false) then
	i_sql_nuevo = f_sql_join(i_sql_nuevo, {'( colegiados.id_colegiado = premaat.id_col )'})
end if

if alta_reta <> '%' then i_sql_nuevo += " and ( premaat.alta_reta like'"+alta_reta+"')"
if alta <> '%' then i_sql_nuevo += " and ( premaat.alta like'"+alta+"')"
if not f_es_vacio(grupo) then i_sql_nuevo += " and ( premaat.grupo like'"+grupo+"')"
if comple_1 <> '%' then i_sql_nuevo += " and ( premaat.grupo_comple1 like'"+comple_1+"')"
if comple_2 <> '%' then i_sql_nuevo += " and ( premaat.grupo_comple2 like'"+comple_2+"')"
if not f_es_vacio(string(importe_cobrar_d)) then i_sql_nuevo += " and ( premaat.importe_cobrar>="+f_cambia_comas_decimales(importe_cobrar_d)+")"
if not f_es_vacio(string(importe_cobrar_h)) then i_sql_nuevo += " and ( premaat.importe_cobrar<="+f_cambia_comas_decimales(importe_cobrar_h)+")"
end event

event csd_consulta_contratos();string sql_aux2, sql_aux3, sql_aux, sql_aux4
datetime f_desde, f_hasta

f_desde = idw_contratos.GetItemDatetime(1, 'f_entrada_desde')
f_hasta = idw_contratos.getitemdatetime(1, 'f_entrada_hasta')

if not f_es_vacio(string(f_desde)) and not f_es_vacio(string(f_hasta)) then
	// Se excluyen los colegiados que han visado y los que pertenecen a una sociedad que a visado
	if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
		sql_aux2 = " and colegiados.id_colegiado NOT IN (SELECT fases_colegiados.id_col FROM fases_colegiados, fases WHERE ( fases_colegiados.id_fase = fases.id_fase ) and ( fases.f_entrada >= '"+string(f_desde, 'mm/dd/yyyy')+"') and ( fases.f_entrada <= '"+string(f_hasta, 'mm/dd/yyyy')+"') )"
		sql_aux3 = " and colegiados.situacion = '01' and colegiados.id_colegiado NOT IN (SELECT fases_colegiados_asociados.id_col_per FROM fases, fases_colegiados_asociados WHERE ( fases.id_fase = fases_colegiados_asociados.id_fase ) and ( fases.f_entrada >= '"+string(f_desde, 'mm/dd/yyyy')+"') and ( fases.f_entrada <= '"+string(f_hasta, 'mm/dd/yyyy')+"') )"
		//  sql_aux = "and colegiados.id_colegiado IN (SELECT fases_colegiados.id_col FROM fases, fases_colegiados WHERE (fases.id_fase=fases_colegiados.id_fase) and ((fases.f_entrada>="+"'"+string(f_desde, 'mm/dd/yyyy')+"'"+") AND  (fases.f_entrada<"+"'"+string(f_hasta, 'mm/dd/yyyy')+"'"+")))"
	else
		sql_aux2 = "WHERE colegiados.id_colegiado NOT IN (SELECT fases_colegiados.id_col FROM fases_colegiados, fases WHERE ( fases_colegiados.id_fase = fases.id_fase ) and ( fases.f_entrada >= '"+string(f_desde, 'mm/dd/yyyy')+"') and ( fases.f_entrada <= '"+string(f_hasta, 'mm/dd/yyyy')+"') )"
		sql_aux3 = " and colegiados.situacion = '01' and colegiados.id_colegiado NOT IN (SELECT fases_colegiados_asociados.id_col_per FROM fases, fases_colegiados_asociados WHERE ( fases.id_fase = fases_colegiados_asociados.id_fase ) and ( fases.f_entrada >= '"+string(f_desde, 'mm/dd/yyyy')+"') and ( fases.f_entrada <= '"+string(f_hasta, 'mm/dd/yyyy')+"') )"
	end if
	
	if not isnull(sql_aux2) then i_sql_nuevo += sql_aux2
	if not isnull(sql_aux3) then i_sql_nuevo += sql_aux3
end if

// Con el check marcado se controlan los que tengan cuenta bancaria
if idw_contratos.getitemstring(1, 'cuenta') = 'S' then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then 
		sql_aux4 = " and colegiados.datos_bancarios_iban BETWEEN '00000000000000000000' and '99999999999999999999'"
	else
		sql_aux4 = "WHERE colegiados.datos_bancarios_iban BETWEEN '00000000000000000000' and '99999999999999999999'"
	end if
end if

if idw_contratos.getitemstring(1, 'cuenta') = 'N' then
	if PosA(upper(i_sql_nuevo), "WHERE") > 0 then
		sql_aux4 = " and (colegiados.datos_bancarios_iban NOT BETWEEN '00000000000000000000' and '99999999999999999999' or datos_bancarios_iban = '' or datos_bancarios_iban is null) "
	else
		sql_aux4 = "WHERE (colegiados.datos_bancarios_iban NOT BETWEEN '00000000000000000000' and '99999999999999999999' or datos_bancarios_iban = '' or datos_bancarios_iban is null) "
	end if
end if

if not isnull(sql_aux4) then i_sql_nuevo += sql_aux4

end event

event csd_consulta_residente();boolean coma
string codigos,sql_aux,operador,opcion
string alta,sql_aux2=''
int i

//Todos los colegiados que Tengan el residente elegido, ya q se pueden elegir varias de una lista
opcion = idw_opcion_residente.GetItemString(1,'opcion')
if opcion<>'%' then
	if not f_es_vacio(sql_aux2) then sql_aux2 = 'and '+sql_aux2
	coma=false
	for i=1 to idw_residente.RowCount()
		if idw_residente.GetItemString(i,'activo') = 'S' then
			if coma then codigos= codigos+','
			codigos = codigos+"'"+idw_residente.GetItemString(i,'c_geografico')+"'"
			coma = true
		end if
	next
	if codigos<>'' then
		if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
			sql_aux = "and colegiados.c_geografico "+operador+" IN ("+codigos+")" 
		else
			sql_aux = "WHERE colegiados.c_geografico "+operador+" IN ("+codigos+")"
		end if	
		if not isnull(sql_aux) then i_sql_nuevo += sql_aux
	end if
end if


// Ejerciente
f_sql('ejerciente','like','ejerciente',idw_ejerciente_sn,i_sql_nuevo,'1','')
end event

event csd_oculta();boolean alta,baja,sit,agr,sitprof,incompat,orient, sitresi
string data
 
//situaciones = idw_opcion_situaciones
//agrupaciones = 
 
sit = (idw_opcion_sit.GetItemString(1,'opcion')='S')
agr = (idw_opcion_agr.GetItemString(1,'opcion')='S')
 
sitprof = (idw_opcion_sitprof.GetItemString(1,'opcion')='S')  
incompat = (idw_opcion_incompat.GetItemString(1,'opcion')='S')
orient = (idw_opcion_orientaciones.GetItemString(1,'opcion')='S') 
 
sitresi = ( idw_opcion_residente.GetItemString(1,'opcion')='S')  

idw_situaciones.visible = sit
tab_1.tabpage_4.cb_todos1.visible = sit
tab_1.tabpage_4.cb_borrar1.visible = sit
 
idw_agrupaciones.visible = agr

tab_1.tabpage_5.cb_incluir4.visible = agr
tab_1.tabpage_5.cb_borrar4.visible = agr
 
idw_sit_profesionales.visible = sitprof
tab_1.tabpage_5.cb_3.visible = sitprof
tab_1.tabpage_5.cb_4.visible = sitprof
 
idw_incompatibilidades.visible = incompat
tab_1.tabpage_5.cb_5.visible = incompat
tab_1.tabpage_5.cb_6.visible = incompat
 
idw_orientaciones.visible = orient
tab_1.tabpage_6.cb_7.visible = orient
tab_1.tabpage_6.cb_8.visible = orient

idw_residente.visible = sitresi
tab_1.tabpage_10.cb_todos5.visible = sitresi
tab_1.tabpage_10.cb_borrar5.visible = sitresi

data = idw_alta_sn.GetItemString(1,'alta')
choose case data 
 case 'S' 
  alta = true
  baja = false
  //tab_1.tabpage_4.cb_todos2.TriggerEvent(Clicked!)
 case 'N'
  alta = false
  baja = true
  tab_1.tabpage_4.cb_todos3.TriggerEvent(Clicked!)
 case else
  alta = false
  baja = false
end choose
 
tab_1.tabpage_4.gb_3.visible= baja
tab_1.tabpage_4.cb_todos3.visible= baja
tab_1.tabpage_4.cb_borrar3.visible = baja
idw_t_baja.visible = baja
tab_1.tabpage_4.gb_2.visible=alta
tab_1.tabpage_4.cb_todos2.visible=alta
tab_1.tabpage_4.cb_borrar2.visible = alta
idw_t_alta.visible = alta
end event

public function integer f_cambia_ididoma_usuario (window ventana, datawindow dw, string objeto, integer tiene_dw, string texto_objeto);/*string Fichero,palabra,palabra_traducida

//Ubicamos el fichero

fichero = g_idioma.is_dir_ficheros +"\messages_"+g_idioma.catalan + ".txt"

//miramos si existe 

if NOT FileExists(fichero) then
	messagebox(g_titulo,'No se pudo encontrar el fichero del idioma.')
end if

// Abrir una ventana para coger el texto traducido

// Extraemos la palabra a traducir
if tiene_dw = 1  then
palabra = dw.getitemstring(1,objeto)
else
	palabra = texto_objeto
	end if
	*/
	
	
	
	
	
return 1
end function

on w_colegiados_consulta.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_colegiados_consulta.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;int i

f_centrar_ventana(this) 

//MessageBox('',g_idioma.of_getmsg( "general.texto_consulta" ))

idw_general = tab_1.tabpage_1.dw_datos_personales
idw_fechas = tab_1.tabpage_2.dw_fechas
idw_servicios =tab_1.tabpage_3.dw_servicios
idw_situaciones = tab_1.tabpage_4.dw_situaciones
idw_t_alta = tab_1.tabpage_4.dw_t_alta
idw_t_baja = tab_1.tabpage_4.dw_t_baja
idw_alta_sn = tab_1.tabpage_4.dw_alta_si_no
idw_agrupaciones = tab_1.tabpage_5.dw_agrupaciones
idw_datos_agrupacion = tab_1.tabpage_5.dw_datos_agrupacion
idw_sit_profesionales = tab_1.tabpage_5.dw_sit_profesionales 
idw_datos_sitprof = tab_1.tabpage_5.dw_datos_sitprof
idw_incompatibilidades = tab_1.tabpage_5.dw_incompatibilidades
idw_otros_datos = tab_1.tabpage_6.dw_otros_datos
idw_orientaciones = tab_1.tabpage_6.dw_consulta_orientaciones
idw_musaat = tab_1.tabpage_7.dw_datos_musaat
idw_premaat = tab_1.tabpage_8.dw_datos_premaat
idw_contratos = tab_1.tabpage_9.dw_contratos
idw_residente = tab_1.tabpage_10.dw_residente
idw_opcion_residente = tab_1.tabpage_10.dw_opcion_residente
idw_opcion_sit = tab_1.tabpage_4.dw_opcion_situaciones
idw_opcion_altas = tab_1.tabpage_4.dw_opcion_altas  
idw_opcion_bajas = tab_1.tabpage_4.dw_opcion_bajas
idw_opcion_agr	  = tab_1.tabpage_5.dw_opcion_agr
idw_opcion_sitprof   = tab_1.tabpage_5.dw_opcion_sit
idw_opcion_incompat = tab_1.tabpage_5.dw_opcion_incomp
idw_opcion_orientaciones = tab_1.tabpage_6.dw_opciones_orientaciones
idw_permiso_cesion_datos = tab_1.tabpage_6.dw_permiso_cesion_datos
idw_ejerciente_sn	= tab_1.tabpage_10.dw_ejerciente_si_no

idw_opcion_sit.insertrow(1)
idw_opcion_altas.insertrow(1)
idw_opcion_bajas.insertrow(1)
idw_opcion_agr.insertrow(1)
idw_opcion_sitprof.insertrow(1)
idw_opcion_incompat.insertrow(1)
idw_general.InsertRow(1)
idw_fechas.InsertRow(1)
idw_servicios.InsertRow(1)
idw_datos_agrupacion.InsertRow(1)
idw_datos_sitprof.InsertRow(1)
idw_opcion_orientaciones.InsertRow(1)
idw_alta_sn.InsertRow(1)
idw_musaat.InsertRow(1)
idw_premaat.InsertRow(1)
idw_contratos.InsertRow(1)
idw_opcion_residente.insertrow(1)
idw_permiso_cesion_datos.insertrow(1)
idw_ejerciente_sn.insertrow(1)

idw_residente.retrieve()
idw_situaciones.Retrieve()
idw_t_alta.Retrieve()
idw_t_baja.Retrieve()
idw_agrupaciones.retrieve()
idw_incompatibilidades.retrieve()
idw_sit_profesionales.retrieve()
idw_otros_datos.retrieve()
idw_orientaciones.retrieve()
idw_general.SetFocus()
idw_general.SetColumn('n_colegiado')



//// Modificado Ricardo 2005/02/22
//// Que salgan marcados los de alta por defecto
//idw_alta_sn.setitem(1, 'alta', 'S')
//idw_alta_sn.trigger event itemchanged(1,idw_alta_sn.object.alta,'S')
//// Modificado Ricardo 2005/02/22
end event

event csd_grabar_consulta;call super::csd_grabar_consulta;//
end event

event pfc_postopen;call super::pfc_postopen;this.post event csd_oculta()

end event

type cb_recuperar_pantalla from w_consulta`cb_recuperar_pantalla within w_colegiados_consulta
string tag = "texto=general.recuperar"
boolean visible = true
integer x = 2807
integer y = 748
integer width = 402
integer height = 80
integer taborder = 50
string text = "&Recuperar"
end type

event cb_recuperar_pantalla::clicked;call super::clicked;parent.event csd_oculta()
end event

type cb_guardar_pantalla from w_consulta`cb_guardar_pantalla within w_colegiados_consulta
string tag = "texto=general.guardar"
boolean visible = true
integer x = 2807
integer y = 644
integer width = 402
integer height = 80
integer taborder = 40
string text = "&Guardar"
end type

type cb_limpiar from w_consulta`cb_limpiar within w_colegiados_consulta
integer x = 3090
integer y = 2104
integer width = 55
integer taborder = 70
end type

type st_5 from w_consulta`st_5 within w_colegiados_consulta
integer x = 96
integer y = 16
end type

type cb_1 from w_consulta`cb_1 within w_colegiados_consulta
integer x = 2807
integer y = 544
integer width = 402
end type

event cb_1::clicked;SetPointer(HourGlass!)
dw_1.AcceptText()
i_sql_nuevo = g_dw_lista.describe("datawindow.table.select")
idw_general.AcceptText()
idw_fechas.AcceptText()
idw_servicios.AcceptText()

idw_situaciones.AcceptText()
idw_t_alta.AcceptText()
idw_t_baja.AcceptText()
idw_agrupaciones.AcceptText()
idw_datos_agrupacion.AcceptText()
idw_sit_profesionales.AcceptText()
idw_incompatibilidades.AcceptText()
idw_datos_sitprof.AcceptText()
idw_otros_datos.AcceptText()
idw_orientaciones.AcceptText()
idw_musaat.AcceptText()
idw_premaat.AcceptText()
idw_contratos.AcceptText()
idw_residente.AcceptText()

parent.TriggerEvent('csd_consulta_general')
parent.TriggerEvent('csd_consulta_fechas')
parent.TriggerEvent('csd_consulta_sit_colegial')
parent.TriggerEvent('csd_consulta_servicios')
parent.TriggerEvent('csd_consulta_profesional')
parent.TriggerEvent('csd_consulta_otros_datos')
parent.TriggerEvent('csd_consulta_musaat')
parent.TriggerEvent('csd_consulta_premaat')
parent.TriggerEvent('csd_consulta_contratos')
parent.TriggerEvent('csd_consulta_residente')

// Miramos el permiso para ver colegiados de baja (INC.8779)
// Si est$$HEX2$$e1002000$$ENDHEX$$como lectura (denegado) modificamos la sql, si no est$$HEX2$$e1002000$$ENDHEX$$en la lista o est$$HEX2$$e1002000$$ENDHEX$$como escritura no hacemos nada
int n_reg
select count(*) into :n_reg from t_permisos where cod_usuario = :g_usuario and cod_aplicacion = 'PCOLBAJA00' and permiso = 'L' ;
if n_reg > 0 then 
	if PosA(upper(i_sql_nuevo), "WHERE") > 0  then
		i_sql_nuevo += " AND colegiados.alta_baja = 'S'"
	else
		i_sql_nuevo += "WHERE colegiados.alta_baja = 'S'"
	end if
end if

//MESSAGEBOX('', i_sql_nuevo)
g_dw_lista.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")
Parent.event pfc_close()

end event

type cb_2 from w_consulta`cb_2 within w_colegiados_consulta
integer x = 2807
integer y = 856
integer width = 402
integer taborder = 60
end type

type cb_ayuda from w_consulta`cb_ayuda within w_colegiados_consulta
integer x = 3095
integer y = 2116
integer width = 41
integer taborder = 80
end type

type dw_1 from w_consulta`dw_1 within w_colegiados_consulta
event csd_oculta ( )
boolean visible = false
integer x = 2935
integer y = 56
integer width = 338
integer height = 172
integer taborder = 30
end type

type tab_1 from tab within w_colegiados_consulta
event create ( )
event destroy ( )
integer x = 50
integer y = 120
integer width = 2683
integer height = 1856
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_10 tabpage_10
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_10=create tabpage_10
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_10,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_10)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=general.general"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_personales dw_datos_personales
end type

on tabpage_1.create
this.dw_datos_personales=create dw_datos_personales
this.Control[]={this.dw_datos_personales}
end on

on tabpage_1.destroy
destroy(this.dw_datos_personales)
end on

type dw_datos_personales from u_dw within tabpage_1
integer x = 101
integer y = 16
integer width = 2181
integer height = 1712
integer taborder = 10
string dataobject = "d_colegiados_consulta_datos_personales"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;string pob,codigos=''
int i



CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'	
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
		
	case 'b_listas'
		Open(w_listas_seleccion)
		this.SetItem(1,'lista_colegiados',Message.Stringparm)

END CHOOSE




end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=general.fechas"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Fechas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_fechas dw_fechas
end type

on tabpage_2.create
this.dw_fechas=create dw_fechas
this.Control[]={this.dw_fechas}
end on

on tabpage_2.destroy
destroy(this.dw_fechas)
end on

type dw_fechas from u_dw within tabpage_2
integer x = 69
integer y = 140
integer width = 2139
integer height = 744
integer taborder = 11
string dataobject = "d_colegiados_consulta_fechas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)


this.setformat('f_alta_desde','dd/mm/yyyy')
this.setformat('f_baja_desde','dd/mm/yyyy')
this.setformat('f_colegiacion_desde','dd/mm/yyyy')
this.setformat('f_titulacion_desde','dd/mm/yyyy')
this.setformat('f_nacimiento_desde','dd/mm/yyyy')

this.setformat('f_alta_hasta','dd/mm/yyyy')
this.setformat('f_baja_hasta','dd/mm/yyyy')
this.setformat('f_colegiacion_hasta','dd/mm/yyyy')
this.setformat('f_titulacion_hasta','dd/mm/yyyy')
this.setformat('f_nacimiento_hasta','dd/mm/yyyy')
this.PostEvent('csd_oculta')
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
string tag = " texto=general.secretaria"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Secretar$$HEX1$$ed00$$ENDHEX$$a"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_servicios dw_servicios
end type

on tabpage_3.create
this.dw_servicios=create dw_servicios
this.Control[]={this.dw_servicios}
end on

on tabpage_3.destroy
destroy(this.dw_servicios)
end on

type dw_servicios from u_dw within tabpage_3
integer x = 41
integer y = 64
integer width = 2281
integer height = 1432
integer taborder = 11
string dataobject = "d_colegiados_consulta_otros_servicios"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
string tag = "texto=colegiados.sit_colegial"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Sit.Colegial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_alta_si_no dw_alta_si_no
dw_opcion_bajas dw_opcion_bajas
dw_opcion_altas dw_opcion_altas
dw_opcion_situaciones dw_opcion_situaciones
cb_borrar3 cb_borrar3
cb_todos3 cb_todos3
cb_borrar2 cb_borrar2
cb_todos2 cb_todos2
dw_t_baja dw_t_baja
dw_situaciones dw_situaciones
cb_todos1 cb_todos1
cb_borrar1 cb_borrar1
gb_3 gb_3
gb_1 gb_1
dw_t_alta dw_t_alta
gb_2 gb_2
end type

on tabpage_4.create
this.dw_alta_si_no=create dw_alta_si_no
this.dw_opcion_bajas=create dw_opcion_bajas
this.dw_opcion_altas=create dw_opcion_altas
this.dw_opcion_situaciones=create dw_opcion_situaciones
this.cb_borrar3=create cb_borrar3
this.cb_todos3=create cb_todos3
this.cb_borrar2=create cb_borrar2
this.cb_todos2=create cb_todos2
this.dw_t_baja=create dw_t_baja
this.dw_situaciones=create dw_situaciones
this.cb_todos1=create cb_todos1
this.cb_borrar1=create cb_borrar1
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_t_alta=create dw_t_alta
this.gb_2=create gb_2
this.Control[]={this.dw_alta_si_no,&
this.dw_opcion_bajas,&
this.dw_opcion_altas,&
this.dw_opcion_situaciones,&
this.cb_borrar3,&
this.cb_todos3,&
this.cb_borrar2,&
this.cb_todos2,&
this.dw_t_baja,&
this.dw_situaciones,&
this.cb_todos1,&
this.cb_borrar1,&
this.gb_3,&
this.gb_1,&
this.dw_t_alta,&
this.gb_2}
end on

on tabpage_4.destroy
destroy(this.dw_alta_si_no)
destroy(this.dw_opcion_bajas)
destroy(this.dw_opcion_altas)
destroy(this.dw_opcion_situaciones)
destroy(this.cb_borrar3)
destroy(this.cb_todos3)
destroy(this.cb_borrar2)
destroy(this.cb_todos2)
destroy(this.dw_t_baja)
destroy(this.dw_situaciones)
destroy(this.cb_todos1)
destroy(this.cb_borrar1)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_t_alta)
destroy(this.gb_2)
end on

type dw_alta_si_no from u_dw within tabpage_4
integer x = 878
integer y = 68
integer width = 955
integer height = 136
integer taborder = 11
string dataobject = "d_colegiados_consulta_alta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;boolean alta,baja

choose case data 
	case 'S' 
		alta = true
		baja = false
		cb_todos2.TriggerEvent(Clicked!)
	case 'N'
		alta = false
		baja = true
		cb_todos3.TriggerEvent(Clicked!)
	case else
		alta = false
		baja = false
end choose
gb_3.visible= baja
cb_todos3.visible= baja
cb_borrar3.visible = baja
idw_t_baja.visible = baja
gb_2.visible=alta
cb_todos2.visible=alta
cb_borrar2.visible = alta
idw_t_alta.visible = alta
		
end event

type dw_opcion_bajas from u_dw within tabpage_4
boolean visible = false
integer x = 1797
integer y = 280
integer width = 736
integer height = 112
integer taborder = 21
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos3.visible=true
	cb_borrar3.visible=true
	dw_t_baja.visible = true
else
	cb_todos3.visible=false
	cb_borrar3.visible=false
	dw_t_baja.visible=false
end if 
end event

type dw_opcion_altas from u_dw within tabpage_4
boolean visible = false
integer x = 946
integer y = 344
integer width = 736
integer height = 112
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos2.visible=true
	cb_borrar2.visible=true
	dw_t_alta.visible = true
else
	cb_todos2.visible=false
	cb_borrar2.visible=false
	dw_t_alta.visible=false
end if 
end event

type dw_opcion_situaciones from u_dw within tabpage_4
integer x = 78
integer y = 128
integer width = 736
integer height = 112
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos1.visible=true
	cb_borrar1.visible=true
	dw_situaciones.visible = true
else
	cb_todos1.visible=false
	cb_borrar1.visible=false
	dw_situaciones.visible=false
end if 
end event

type cb_borrar3 from commandbutton within tabpage_4
boolean visible = false
integer x = 2080
integer y = 1568
integer width = 325
integer height = 68
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_t_baja.rowcount() 
	idw_t_baja.SetItem(i,'activo','N')
next
end event

type cb_todos3 from commandbutton within tabpage_4
boolean visible = false
integer x = 1751
integer y = 1568
integer width = 325
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_t_baja.rowcount() 
	idw_t_baja.SetItem(i,'activo','S')
next
end event

type cb_borrar2 from commandbutton within tabpage_4
boolean visible = false
integer x = 1193
integer y = 1572
integer width = 325
integer height = 68
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_t_alta.SetItem(i,'activo','N')
next
end event

type cb_todos2 from commandbutton within tabpage_4
boolean visible = false
integer x = 864
integer y = 1572
integer width = 325
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_t_alta.SetItem(i,'activo','S')
next
end event

type dw_t_baja from u_dw within tabpage_4
boolean visible = false
integer x = 1765
integer y = 256
integer width = 823
integer height = 1288
integer taborder = 11
string dataobject = "d_colegiados_t_baja_consulta"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_bajas.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_bajas.SetItem(1,'opcion','S')
end event

type dw_situaciones from u_dw within tabpage_4
boolean visible = false
integer x = 41
integer y = 280
integer width = 800
integer height = 1256
integer taborder = 21
string dataobject = "d_colegiados_situaciones_consulta"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_sit.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_sit.SetItem(1,'opcion','S')
end event

type cb_todos1 from commandbutton within tabpage_4
string tag = "texto=colegiados.sel_todo"
boolean visible = false
integer x = 14
integer y = 1576
integer width = 325
integer height = 68
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_situaciones.SetItem(i,'activo','S')
next
end event

type cb_borrar1 from commandbutton within tabpage_4
boolean visible = false
integer x = 343
integer y = 1576
integer width = 325
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_situaciones.rowcount() 
	idw_situaciones.SetItem(i,'activo','N')
next
end event

type gb_3 from groupbox within tabpage_4
string tag = "texto=colegiados.bajas"
integer x = 1751
integer y = 216
integer width = 850
integer height = 1340
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Bajas"
end type

type gb_1 from groupbox within tabpage_4
string tag = "texto=colegiados.situaciones"
integer x = 9
integer y = 48
integer width = 846
integer height = 1508
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Situaciones"
end type

type dw_t_alta from u_dw within tabpage_4
boolean visible = false
integer x = 901
integer y = 260
integer width = 800
integer height = 1260
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_t_alta_consulta"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_altas.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_altas.SetItem(1,'opcion','S')
end event

type gb_2 from groupbox within tabpage_4
string tag = "texto=colegiados.altas"
integer x = 878
integer y = 216
integer width = 850
integer height = 1340
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 79741120
string text = "Altas"
end type

type tabpage_5 from userobject within tab_1
string tag = "texto=colegiados.sit_profesional"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Sit.Profesional"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_sitprof dw_datos_sitprof
dw_datos_agrupacion dw_datos_agrupacion
dw_opcion_incomp dw_opcion_incomp
dw_opcion_sit dw_opcion_sit
dw_opcion_agr dw_opcion_agr
rb_inc_si rb_inc_si
rb_sit_no rb_sit_no
rb_si rb_si
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_incompatibilidades dw_incompatibilidades
dw_sit_profesionales dw_sit_profesionales
cb_borrar4 cb_borrar4
cb_incluir4 cb_incluir4
gb_5 gb_5
gb_6 gb_6
dw_agrupaciones dw_agrupaciones
gb_8 gb_8
gb_4 gb_4
gb_7 gb_7
end type

on tabpage_5.create
this.dw_datos_sitprof=create dw_datos_sitprof
this.dw_datos_agrupacion=create dw_datos_agrupacion
this.dw_opcion_incomp=create dw_opcion_incomp
this.dw_opcion_sit=create dw_opcion_sit
this.dw_opcion_agr=create dw_opcion_agr
this.rb_inc_si=create rb_inc_si
this.rb_sit_no=create rb_sit_no
this.rb_si=create rb_si
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_incompatibilidades=create dw_incompatibilidades
this.dw_sit_profesionales=create dw_sit_profesionales
this.cb_borrar4=create cb_borrar4
this.cb_incluir4=create cb_incluir4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.dw_agrupaciones=create dw_agrupaciones
this.gb_8=create gb_8
this.gb_4=create gb_4
this.gb_7=create gb_7
this.Control[]={this.dw_datos_sitprof,&
this.dw_datos_agrupacion,&
this.dw_opcion_incomp,&
this.dw_opcion_sit,&
this.dw_opcion_agr,&
this.rb_inc_si,&
this.rb_sit_no,&
this.rb_si,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_incompatibilidades,&
this.dw_sit_profesionales,&
this.cb_borrar4,&
this.cb_incluir4,&
this.gb_5,&
this.gb_6,&
this.dw_agrupaciones,&
this.gb_8,&
this.gb_4,&
this.gb_7}
end on

on tabpage_5.destroy
destroy(this.dw_datos_sitprof)
destroy(this.dw_datos_agrupacion)
destroy(this.dw_opcion_incomp)
destroy(this.dw_opcion_sit)
destroy(this.dw_opcion_agr)
destroy(this.rb_inc_si)
destroy(this.rb_sit_no)
destroy(this.rb_si)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_incompatibilidades)
destroy(this.dw_sit_profesionales)
destroy(this.cb_borrar4)
destroy(this.cb_incluir4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.dw_agrupaciones)
destroy(this.gb_8)
destroy(this.gb_4)
destroy(this.gb_7)
end on

type dw_datos_sitprof from u_dw within tabpage_5
integer x = 1189
integer y = 68
integer width = 1271
integer height = 348
integer taborder = 11
string dataobject = "d_colegiados_consulta_datos_sitprof"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;string pob 

g_busqueda.titulo='Poblaciones'
g_busqueda.dw='d_poblaciones_lista_busqueda'
pob=f_busqueda_poblaciones()
if f_es_vacio(pob) then return
this.SetItem(1,'poblacion',pob)

end event

type dw_datos_agrupacion from u_dw within tabpage_5
integer x = 78
integer y = 72
integer width = 1047
integer height = 332
integer taborder = 11
string dataobject = "d_colegiados_consulta_datos_agrupacion"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type dw_opcion_incomp from u_dw within tabpage_5
integer x = 1806
integer y = 520
integer width = 727
integer height = 112
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_5.visible=true
	cb_6.visible=true
	dw_incompatibilidades.visible = true
else
	cb_5.visible=false
	cb_6.visible=false
	dw_incompatibilidades.visible=false
end if 
end event

type dw_opcion_sit from u_dw within tabpage_5
integer x = 951
integer y = 520
integer width = 727
integer height = 112
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_3.visible=true
	cb_4.visible=true
	dw_sit_profesionales.visible = true
else
	cb_3.visible=false
	cb_4.visible=false
	dw_sit_profesionales.visible=false
end if 
end event

type dw_opcion_agr from u_dw within tabpage_5
integer x = 105
integer y = 520
integer width = 727
integer height = 128
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_incluir4.visible=true
	cb_borrar4.visible=true
	dw_agrupaciones.visible = true
else
	cb_incluir4.visible=false
	cb_borrar4.visible=false
	dw_agrupaciones.visible=false
end if 

// Cambiamos el idioma de ventana
if g_usar_idioma = "S" then g_idioma.of_cambia_textos( this)
end event

type rb_inc_si from radiobutton within tabpage_5
integer x = 2958
integer y = 56
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Si"
boolean checked = true
end type

type rb_sit_no from radiobutton within tabpage_5
integer x = 2811
integer y = 44
integer width = 187
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "No"
end type

type rb_si from radiobutton within tabpage_5
integer x = 3077
integer y = 68
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Si"
boolean checked = true
end type

type cb_6 from commandbutton within tabpage_5
boolean visible = false
integer x = 2107
integer y = 1520
integer width = 325
integer height = 68
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "BorrarTodos"
end type

event clicked;int i

for i=1 to idw_incompatibilidades.rowcount() 
	idw_incompatibilidades.SetItem(i,'activo','N')
next
end event

type cb_5 from commandbutton within tabpage_5
boolean visible = false
integer x = 1778
integer y = 1520
integer width = 325
integer height = 68
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel.Todos"
end type

event clicked;int i

for i=1 to idw_incompatibilidades.rowcount() 
	idw_incompatibilidades.SetItem(i,'activo','S')
next
end event

type cb_4 from commandbutton within tabpage_5
boolean visible = false
integer x = 1239
integer y = 1520
integer width = 325
integer height = 68
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "BorrarTodos"
end type

event clicked;int i

for i=1 to idw_sit_profesionales.rowcount() 
	idw_sit_profesionales.SetItem(i,'activo','N')
next
end event

type cb_3 from commandbutton within tabpage_5
boolean visible = false
integer x = 910
integer y = 1520
integer width = 325
integer height = 68
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel.Todos"
end type

event clicked;int i

for i=1 to idw_sit_profesionales.rowcount() 
	idw_sit_profesionales.SetItem(i,'activo','S')
next
end event

type dw_incompatibilidades from u_dw within tabpage_5
boolean visible = false
integer x = 1797
integer y = 656
integer width = 777
integer height = 848
integer taborder = 11
string dataobject = "d_colegiados_consulta_incompatibilidades"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_incompat.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_incompat.SetItem(1,'opcion','S')
end event

type dw_sit_profesionales from u_dw within tabpage_5
boolean visible = false
integer x = 928
integer y = 656
integer width = 763
integer height = 848
integer taborder = 11
string dataobject = "d_colegiados_consulta_sit_profesional"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;string opcion

opcion = idw_opcion_sitprof.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_sitprof.SetItem(1,'opcion','S')
end event

type cb_borrar4 from commandbutton within tabpage_5
boolean visible = false
integer x = 375
integer y = 1524
integer width = 325
integer height = 68
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "BorrarTodos"
end type

event clicked;int i

for i=1 to idw_agrupaciones.rowcount() 
	idw_agrupaciones.SetItem(i,'activo','N')
next
end event

type cb_incluir4 from commandbutton within tabpage_5
boolean visible = false
integer x = 46
integer y = 1524
integer width = 325
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel.Todos"
end type

event clicked;int i

for i=1 to idw_agrupaciones.rowcount() 
	idw_agrupaciones.SetItem(i,'activo','S')
next
end event

type gb_5 from groupbox within tabpage_5
string tag = "texto=colegiados.sit_profesional"
integer x = 910
integer y = 452
integer width = 800
integer height = 1060
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Situaciones Profesionales"
end type

type gb_6 from groupbox within tabpage_5
string tag = "texto=colegiados.incompatibilidades"
integer x = 1783
integer y = 452
integer width = 800
integer height = 1060
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Incompatibilidades"
end type

type dw_agrupaciones from u_dw within tabpage_5
boolean visible = false
integer x = 87
integer y = 656
integer width = 773
integer height = 848
integer taborder = 20
string dataobject = "d_colegiados_consulta_agrupaciones"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;string opcion

opcion = idw_opcion_agr.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_agr.SetItem(1,'opcion','S')
end event

type gb_8 from groupbox within tabpage_5
string tag = "texto=colegiados.situaciones_incompat"
integer x = 1166
integer y = 12
integer width = 1417
integer height = 428
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Datos Situaciones,Incompatibilidades"
end type

type gb_4 from groupbox within tabpage_5
string tag = "texto=colegiados.agrupaciones"
integer x = 46
integer y = 452
integer width = 827
integer height = 1060
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Agrupaciones"
end type

type gb_7 from groupbox within tabpage_5
string tag = "texto=colegiados.datos_agrup"
integer x = 46
integer y = 12
integer width = 1102
integer height = 428
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Datos Agrupaci$$HEX1$$f300$$ENDHEX$$n"
end type

type tabpage_10 from userobject within tab_1
event create ( )
event destroy ( )
string tag = " texto=colegiados.sit_resid_ejer"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Sit.Resid. Ejerc."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_ejerciente_si_no dw_ejerciente_si_no
dw_opcion_residente dw_opcion_residente
dw_residente dw_residente
cb_borrar5 cb_borrar5
cb_todos5 cb_todos5
gb_15 gb_15
end type

on tabpage_10.create
this.dw_ejerciente_si_no=create dw_ejerciente_si_no
this.dw_opcion_residente=create dw_opcion_residente
this.dw_residente=create dw_residente
this.cb_borrar5=create cb_borrar5
this.cb_todos5=create cb_todos5
this.gb_15=create gb_15
this.Control[]={this.dw_ejerciente_si_no,&
this.dw_opcion_residente,&
this.dw_residente,&
this.cb_borrar5,&
this.cb_todos5,&
this.gb_15}
end on

on tabpage_10.destroy
destroy(this.dw_ejerciente_si_no)
destroy(this.dw_opcion_residente)
destroy(this.dw_residente)
destroy(this.cb_borrar5)
destroy(this.cb_todos5)
destroy(this.gb_15)
end on

type dw_ejerciente_si_no from u_dw within tabpage_10
integer x = 978
integer y = 72
integer width = 1111
integer height = 136
integer taborder = 21
string dataobject = "d_colegiados_consulta_ejerciente"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_opcion_residente from u_dw within tabpage_10
integer x = 78
integer y = 128
integer width = 736
integer height = 112
integer taborder = 10
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;if data ='S' then
	cb_todos5.visible=true
	cb_borrar5.visible=true
	dw_residente.visible = true
else
	cb_todos5.visible=false
	cb_borrar5.visible=false
	dw_residente.visible=false
end if 
end event

type dw_residente from u_dw within tabpage_10
boolean visible = false
integer x = 41
integer y = 280
integer width = 800
integer height = 1256
integer taborder = 31
string dataobject = "d_colegiados_consulta_residente"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;string opcion

opcion = idw_opcion_residente.GetItemString(1,'opcion')
if opcion='%' then idw_opcion_residente.SetItem(1,'opcion','S')
end event

type cb_borrar5 from commandbutton within tabpage_10
string tag = " texto=colegiados.borrar_todos"
boolean visible = false
integer x = 343
integer y = 1576
integer width = 325
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i=1 to idw_residente.rowcount() 
	idw_residente.SetItem(i,'activo','N')
next
end event

type cb_todos5 from commandbutton within tabpage_10
string tag = " texto=colegiados.sel_todos"
boolean visible = false
integer x = 14
integer y = 1576
integer width = 325
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sel. Todos"
end type

event clicked;int i

for i=1 to idw_residente.rowcount() 
	idw_residente.SetItem(i,'activo','S')
next
end event

type gb_15 from groupbox within tabpage_10
string tag = "texto=colegiados.residente"
integer x = 9
integer y = 48
integer width = 846
integer height = 1508
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Residente"
end type

type tabpage_6 from userobject within tab_1
string tag = " texto=colegiados.otros_datos"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Otros Datos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_permiso_cesion_datos dw_permiso_cesion_datos
gb_9 gb_9
cb_8 cb_8
cb_7 cb_7
dw_opciones_orientaciones dw_opciones_orientaciones
dw_consulta_orientaciones dw_consulta_orientaciones
gb_10 gb_10
dw_otros_datos dw_otros_datos
gb_11 gb_11
end type

on tabpage_6.create
this.dw_permiso_cesion_datos=create dw_permiso_cesion_datos
this.gb_9=create gb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.dw_opciones_orientaciones=create dw_opciones_orientaciones
this.dw_consulta_orientaciones=create dw_consulta_orientaciones
this.gb_10=create gb_10
this.dw_otros_datos=create dw_otros_datos
this.gb_11=create gb_11
this.Control[]={this.dw_permiso_cesion_datos,&
this.gb_9,&
this.cb_8,&
this.cb_7,&
this.dw_opciones_orientaciones,&
this.dw_consulta_orientaciones,&
this.gb_10,&
this.dw_otros_datos,&
this.gb_11}
end on

on tabpage_6.destroy
destroy(this.dw_permiso_cesion_datos)
destroy(this.gb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.dw_opciones_orientaciones)
destroy(this.dw_consulta_orientaciones)
destroy(this.gb_10)
destroy(this.dw_otros_datos)
destroy(this.gb_11)
end on

type dw_permiso_cesion_datos from u_dw within tabpage_6
integer x = 91
integer y = 952
integer width = 1330
integer taborder = 11
string dataobject = "d_colegiados_consulta_per_cesion_datos"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_9 from groupbox within tabpage_6
string tag = "texto=colegiados.otros_datos"
integer x = 32
integer y = 28
integer width = 1431
integer height = 864
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Otros Datos"
end type

type cb_8 from commandbutton within tabpage_6
string tag = " texto=colegiados.borrar_todos"
boolean visible = false
integer x = 1874
integer y = 1504
integer width = 329
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Todos"
end type

event clicked;int i

for i = 1 to idw_orientaciones.rowcount()
	idw_orientaciones.SetItem(i,'activo','N')
next

end event

type cb_7 from commandbutton within tabpage_6
string tag = " texto=colegiados.sel_todos"
boolean visible = false
integer x = 1536
integer y = 1504
integer width = 329
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Selecc.Todos"
end type

event clicked;int i

for i = 1 to idw_orientaciones.rowcount()
	idw_orientaciones.SetItem(i,'activo','S')
next

end event

type dw_opciones_orientaciones from u_dw within tabpage_6
integer x = 1646
integer y = 96
integer width = 837
integer height = 132
integer taborder = 11
string dataobject = "d_colegiados_consulta_opciones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;if data ='S' then
	cb_7.visible=true
	cb_8.visible=true
	dw_consulta_orientaciones.visible = true
else
	cb_7.visible=false
	cb_8.visible=false
	dw_consulta_orientaciones.visible=false
end if 
end event

type dw_consulta_orientaciones from u_dw within tabpage_6
boolean visible = false
integer x = 1586
integer y = 284
integer width = 928
integer height = 1168
integer taborder = 11
string dataobject = "d_colegiados_consulta_orientaciones"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type gb_10 from groupbox within tabpage_6
string tag = " texto=colegiados.orientaciones_profesionales"
integer x = 1536
integer y = 32
integer width = 1019
integer height = 1460
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Orientaciones Profesionales"
end type

type dw_otros_datos from u_dw within tabpage_6
integer x = 91
integer y = 112
integer width = 1330
integer height = 748
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_consulta_otros_datos"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type gb_11 from groupbox within tabpage_6
string tag = "texto=colegiados.permiso_concesion"
integer x = 32
integer y = 904
integer width = 1431
integer height = 580
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Permisos de Cesi$$HEX1$$f300$$ENDHEX$$n de Datos"
end type

type tabpage_7 from userobject within tab_1
string tag = " texto=colegiados.seguros"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "SEGUROS"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_musaat dw_datos_musaat
end type

on tabpage_7.create
this.dw_datos_musaat=create dw_datos_musaat
this.Control[]={this.dw_datos_musaat}
end on

on tabpage_7.destroy
destroy(this.dw_datos_musaat)
end on

type dw_datos_musaat from u_dw within tabpage_7
integer x = 46
integer y = 84
integer width = 2446
integer height = 1608
integer taborder = 20
string dataobject = "d_colegiados_consulta_musaat"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;string pob,codigos=''
int i

CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
	case 'b_listas'
		Open(w_listas_seleccion)
		this.SetItem(row,'lista_colegiados',Message.Stringparm)
		
END CHOOSE

end event

event clicked;call super::clicked;string t_poliza

// Filtramos las coberturas seg$$HEX1$$fa00$$ENDHEX$$n el tipo de poliza
CHOOSE CASE dwo.name
	CASE 'src_cober'
		t_poliza = this.getitemstring(1, 'src_t_poliza')
		if isnull(t_poliza) then t_poliza = ''
		DataWindowChild dwc_cober_src
		this.GetChild('src_cober', dwc_cober_src)
		dwc_cober_src.setfilter("t_poliza = '" + t_poliza + "'")		
		dwc_cober_src.filter()
END CHOOSE

end event

type tabpage_8 from userobject within tab_1
string tag = " texto=colegiados.pestanya_premaat"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "PREMAAT"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_premaat dw_datos_premaat
end type

on tabpage_8.create
this.dw_datos_premaat=create dw_datos_premaat
this.Control[]={this.dw_datos_premaat}
end on

on tabpage_8.destroy
destroy(this.dw_datos_premaat)
end on

type dw_datos_premaat from u_dw within tabpage_8
integer x = 69
integer y = 84
integer width = 1746
integer height = 992
integer taborder = 20
string dataobject = "d_colegiados_consulta_premaat"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;string pob,codigos=''
int i

CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(row,'cod_pob',pob)
	case 'b_listas'
		Open(w_listas_seleccion)		
		this.SetItem(1,'lista_colegiados',Message.Stringparm)
		
END CHOOSE

end event

type tabpage_9 from userobject within tab_1
string tag = "texto=colegiados.contratos"
integer x = 18
integer y = 100
integer width = 2647
integer height = 1740
long backcolor = 79741120
string text = "Contratos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_contratos dw_contratos
end type

on tabpage_9.create
this.dw_contratos=create dw_contratos
this.Control[]={this.dw_contratos}
end on

on tabpage_9.destroy
destroy(this.dw_contratos)
end on

type dw_contratos from u_dw within tabpage_9
integer x = 64
integer y = 68
integer width = 2322
integer height = 400
integer taborder = 21
string dataobject = "d_colegiados_consulta_contratos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

