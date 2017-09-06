HA$PBExportHeader$w_cursos_form_detalle.srw
forward
global type w_cursos_form_detalle from w_detalle
end type
type tab_1 from tab within w_cursos_form_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cursos_form_fechas from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cursos_form_fechas dw_cursos_form_fechas
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cursos_form_importes from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_cursos_form_importes dw_cursos_form_importes
end type
type tabpage_3 from userobject within tab_1
end type
type dw_cursos_form_ponentes from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_cursos_form_ponentes dw_cursos_form_ponentes
end type
type tabpage_4 from userobject within tab_1
end type
type dw_cursos_form_organizadores from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_cursos_form_organizadores dw_cursos_form_organizadores
end type
type tabpage_5 from userobject within tab_1
end type
type cb_facturar from commandbutton within tabpage_5
end type
type dw_cursos_form_asistentes from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_facturar cb_facturar
dw_cursos_form_asistentes dw_cursos_form_asistentes
end type
type tabpage_6 from userobject within tab_1
end type
type dw_cursos_form_espera from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_cursos_form_espera dw_cursos_form_espera
end type
type tabpage_7 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_7
end type
type dw_cursos_form_documentacion from u_dw within tabpage_7
end type
type tabpage_7 from userobject within tab_1
cb_5 cb_5
dw_cursos_form_documentacion dw_cursos_form_documentacion
end type
type tabpage_8 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_8
end type
type cb_encuesta from commandbutton within tabpage_8
end type
type dw_cursos_form_preguntas_test from u_dw within tabpage_8
end type
type tabpage_8 from userobject within tab_1
cb_1 cb_1
cb_encuesta cb_encuesta
dw_cursos_form_preguntas_test dw_cursos_form_preguntas_test
end type
type tabpage_9 from userobject within tab_1
end type
type cb_8 from commandbutton within tabpage_9
end type
type cb_7 from commandbutton within tabpage_9
end type
type dw_cursos_form_alumnos_test from u_dw within tabpage_9
end type
type tabpage_9 from userobject within tab_1
cb_8 cb_8
cb_7 cb_7
dw_cursos_form_alumnos_test dw_cursos_form_alumnos_test
end type
type tabpage_10 from userobject within tab_1
end type
type cb_9 from commandbutton within tabpage_10
end type
type dw_cursos_form_estadisticas from u_dw within tabpage_10
end type
type tabpage_10 from userobject within tab_1
cb_9 cb_9
dw_cursos_form_estadisticas dw_cursos_form_estadisticas
end type
type tabpage_11 from userobject within tab_1
end type
type dw_cursos_form_costes from u_dw within tabpage_11
end type
type tabpage_11 from userobject within tab_1
dw_cursos_form_costes dw_cursos_form_costes
end type
type tabpage_13 from userobject within tab_1
end type
type dw_cursos_form_areas_materias from u_dw within tabpage_13
end type
type tabpage_13 from userobject within tab_1
dw_cursos_form_areas_materias dw_cursos_form_areas_materias
end type
type tabpage_12 from userobject within tab_1
end type
type dw_cursos_form_ampliacion from u_dw within tabpage_12
end type
type tabpage_12 from userobject within tab_1
dw_cursos_form_ampliacion dw_cursos_form_ampliacion
end type
type tab_1 from tab within w_cursos_form_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_13 tabpage_13
tabpage_12 tabpage_12
end type
type dw_diplomas from u_dw within w_cursos_form_detalle
end type
type dw_recibos from u_dw within w_cursos_form_detalle
end type
type dw_encuesta from u_dw within w_cursos_form_detalle
end type
type dw_estadisticas from u_dw within w_cursos_form_detalle
end type
type cb_6 from commandbutton within w_cursos_form_detalle
end type
type dw_curso_botones from u_dw within w_cursos_form_detalle
end type
type dw_enc from u_dw within w_cursos_form_detalle
end type
end forward

global type w_cursos_form_detalle from w_detalle
integer width = 3534
integer height = 2104
string title = "Detalle de Convocatorias"
string menuname = "m_detalle_cursos_jornadas"
event csd_recalcular_porcentaje_asistencia ( )
event csd_inscribir_asistente ( )
event csd_generar_asistentes ( )
event csd_ampliar_curso ( )
event csd_imprimir_encuesta_word ( )
tab_1 tab_1
dw_diplomas dw_diplomas
dw_recibos dw_recibos
dw_encuesta dw_encuesta
dw_estadisticas dw_estadisticas
cb_6 cb_6
dw_curso_botones dw_curso_botones
dw_enc dw_enc
end type
global w_cursos_form_detalle w_cursos_form_detalle

type variables
u_dw idw_cursos_form_areas_materias
u_dw idw_cursos_form_fechas
u_dw idw_cursos_form_ampliacion
u_dw idw_cursos_form_importes
u_dw idw_cursos_form_ponentes
u_dw idw_cursos_form_organizadores
u_dw idw_cursos_form_asistentes
u_dw idw_cursos_form_espera
u_dw idw_cursos_form_documentacion
u_dw idw_cursos_form_preguntas_test
u_dw idw_cursos_form_alumnos_test
u_dw idw_cursos_form_estadisticas
u_dw idw_cursos_form_costes
datastore ds_diplomas
datastore ds_recibos
datastore ds_encuesta
datastore ds_borrados
boolean i_curso_ampliacion=false
string i_id_curso_ampliacion,i_titulo_curso
datawindowchild isub_convocatoria

string i_tipo_convocatoria,i_subtipo_convocatoria,i_anyo,i_codigo,i_domicilio,i_cod_pob
string i_cp,i_provincia,i_observaciones
string i_cod_delegacion


end variables

event csd_recalcular_porcentaje_asistencia();datastore ds_asistencias
double i,porcentaje,dias
string id_curso,n_cole,id_asistente

dw_1.AcceptText()

//Creamos el datastore para comprobar los alumnos y su asistencia

ds_asistencias=create datastore
ds_asistencias.DataObject='ds_alumnos_con_asistencia_superada'
ds_asistencias.SetTransObject(SQLCA)


//Cogemos el valor del curso actual 
id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')

//se cargan todos los alumnos, con este curso
ds_asistencias.retrieve(id_curso,0)

for i=1 to ds_asistencias.rowcount()
	//recalculamos porcentaje asistencia
	id_asistente=ds_asistencias.GetItemString(i,'id_asistente')
	
	SELECT COUNT(*)
	INTO :porcentaje
	FROM formacion_ctrl_asistencia,formacion_asist_fecha
	WHERE formacion_ctrl_asistencia.id_asistencia_fecha=formacion_asist_fecha.id_asistencia_fecha
	AND	formacion_ctrl_asistencia.id_curso=:id_curso
	AND	id_asistente=:id_asistente
	AND	asiste='S';
	
	dias=idw_cursos_form_fechas.RowCount()
	if isnull(dias) or dias=0 then 
		porcentaje=0
	else
		porcentaje=porcentaje/dias*100
	end if
	
	ds_asistencias.SetItem(i,'porcentaje_asistencia',porcentaje)


	//Actualizamos el porcentaje de asistencia
	UPDATE formacion_asistentes
	SET porcentaje_asistencia=:porcentaje
	WHERE id_asistente=:id_asistente;

next

//Por si existe alg$$HEX1$$fa00$$ENDHEX$$n problema en el update, debemos volver atras.
if sqlca.sqlcode=-1 then
	rollback;
else
	commit;
end if
end event

event csd_inscribir_asistente();//Este evento se ha creado para que se pueda aprovechar el codigo de la botonera, si pulsamos 
//para ver los objetos visibles, podemos observar que existe una botonera en la que se puede observar 
//que hace el funcionamiento de cuando pulsamos en el menu dl detalle

dwobject dwo

dwo=dw_curso_botones.object.b_insc_asis

dw_curso_botones.Trigger Event buttonclicked(1, 1, dwo)
end event

event csd_generar_asistentes();//Este evento se ha creado para que se pueda aprovechar el codigo de la botonera, si pulsamos 
//para ver los objetos visibles, podemos observar que existe una botonera en la que se puede observar 
//que hace el funcionamiento de cuando pulsamos en el menu dl detalle

dwobject dwo

dwo=dw_curso_botones.object.b_generar_asist

dw_curso_botones.Trigger Event buttonclicked(1, 1, dwo)
end event

event csd_ampliar_curso();//Este evento se ha creado para que se pueda aprovechar el codigo de la botonera, si pulsamos 
//para ver los objetos visibles, podemos observar que existe una botonera en la que se puede observar 
//que hace el funcionamiento de cuando pulsamos en el menu dl detalle

dwobject dwo

dwo=dw_curso_botones.object.b_ampliacion

dw_curso_botones.Trigger Event buttonclicked(1, 1, dwo)
end event

event csd_imprimir_encuesta_word();//
//Creamos el objeto Ole para manipular los datos del word
OleObject word
transaction trans
string titulo, fechas
datetime fecha_ini,fecha_fin		
string ruta_encuesta,fichero_encuesta

select ruta into :fichero_encuesta from plantillas where modulo='ENCUESTA CURSO';

ruta_encuesta=g_directorio_rtf+fichero_encuesta

//Comprobamos si el trayecto g_directorio_rtf es relativo (empieza con una '\')
//Mirar esto para futuras versiones a ver si se puede quitar
if LeftA(g_directorio_rtf,1)='\' and MidA(g_directorio_rtf,2,1)<>'\' then
	ruta_encuesta=g_dir_aplicacion+ruta_encuesta
end if

word = create OleObject
word.connecttonewobject("word.application")
//...
//Metemos los datos del curso en la bd
titulo=dw_1.getitemstring(1,'nombre')
fecha_ini=dw_1.getitemdatetime(1,'f_ini_curso')
fecha_fin=dw_1.getitemdatetime(1,'f_fin_curso')
fechas=f_intervalo_fechas_en_letras(fecha_ini,fecha_fin)

trans = CREATE transaction
trans.DBMS = "ODBC"
trans.AutoCommit = False
trans.DBParm = "ConnectString='DSN=correspondencias;UID=;PWD='"
connect using trans;
delete from cursos using trans;
			
insert into cursos (titulo,fechas) values (:titulo,:fechas) using trans;
			
commit;
disconnect using trans;
destroy trans
			
word.Documents.Open(ruta_encuesta)
word.ActiveDocument.MailMerge.Execute
word.ActiveDocument.PrintOut(False)
word.Documents.Close(0)
word.Quit(0)	
word.DisconnectObject()
destroy word
end event

on w_cursos_form_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_cursos_jornadas" then this.MenuID = create m_detalle_cursos_jornadas
this.tab_1=create tab_1
this.dw_diplomas=create dw_diplomas
this.dw_recibos=create dw_recibos
this.dw_encuesta=create dw_encuesta
this.dw_estadisticas=create dw_estadisticas
this.cb_6=create cb_6
this.dw_curso_botones=create dw_curso_botones
this.dw_enc=create dw_enc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_diplomas
this.Control[iCurrent+3]=this.dw_recibos
this.Control[iCurrent+4]=this.dw_encuesta
this.Control[iCurrent+5]=this.dw_estadisticas
this.Control[iCurrent+6]=this.cb_6
this.Control[iCurrent+7]=this.dw_curso_botones
this.Control[iCurrent+8]=this.dw_enc
end on

on w_cursos_form_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_diplomas)
destroy(this.dw_recibos)
destroy(this.dw_encuesta)
destroy(this.dw_estadisticas)
destroy(this.cb_6)
destroy(this.dw_curso_botones)
destroy(this.dw_enc)
end on

event csd_nuevo;call super::csd_nuevo;if AncestorReturnValue>0 then
	string anyo,a,id_curso_ampliacion
	
	//Cogemos el anyo correspondiente
	a=f_contador_anyo()
	anyo=string(year(today()))
	
	//Ponemos el identificador de la tabla formaci$$HEX1$$f300$$ENDHEX$$n curso, con la ayuda del contador FORMACION_CURSOS
	dw_1.setitem(dw_1.GetRow(),'id_curso',f_siguiente_numero('FORMACION_CURSOS',10))	
	
	//Debe de coindicir el a$$HEX1$$f100$$ENDHEX$$o ( del ordenador) con el contador del a$$HEX1$$f100$$ENDHEX$$o.
	if anyo<>a then
		f_siguiente_numero('FORMACION_ANYO',4)
		f_inicializar_contador('FORMACION_CODIGO')
	end if
	
	//Ponemos el foco, ademas de rellenar los campos con valores iniciales.
	//Las fechas actuales,y el numero de plazas en principio 0.
	
	dw_1.SetFocus()
	dw_1.SetItem(dw_1.GetRow(),'f_ini_inscripcion',relativedate(today(),0))
	dw_1.SetItem(dw_1.GetRow(),'f_fin_inscripcion',relativedate(today(),1))
	dw_1.SetItem(dw_1.GetRow(),'f_ini_curso',relativedate(today(),0))
	dw_1.SetItem(dw_1.GetRow(),'f_fin_curso','01/01/00')
	dw_1.SetItem(dw_1.GetRow(),'n_plazas','0')
	dw_1.SetItem(dw_1.GetRow(),'n_plazas_libres','0')
	dw_1.SetItem(dw_1.GetRow(),'n_lista_espera','0')
	dw_1.SetItem(dw_1.GetRow(),'porcentaje_minimo',50)
	
	
	//Definimos las variables globales que utilizaremos para actualizar los valores de las plazas.
	g_n_lista_espera=0
	g_n_plazas=0
	g_n_plazas_libres=0
	
	//Cogemos el valor del curso, y lo guardamos en una variable global.
	g_id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
	
	//Debemos de diferenciar si es un nuevo curso o simplemente una ampliaci$$HEX1$$f300$$ENDHEX$$n para recoger los datos que teniamos.
	
	If i_curso_ampliacion=false then 
		//Curso nuevo
		dw_1.setitem(dw_1.GetRow(),'id_curso_interno',f_siguiente_numero('FORMACION_CURSO_INTE',10))
		dw_1.AcceptText()
		dw_1.SetItem(dw_1.GetRow(),'anyo',anyo)
		string cod
		cod=anyo
		cod+=f_siguiente_numero('FORMACION_CODIGO',6)
		//cod=anyo+f_siguiente_numero('FORMACION_CODIGO',6)
		dw_1.SetItem(dw_1.GetRow(),'codigo',cod)
		//dw_1.SetItem(dw_1.GetRow(),'codigo',string(anyo+f_siguiente_numero('FORMACION_CODIGO',6)))
		datawindowchild sub_conv
		dw_1.getchild('subtipo_convocatoria',sub_conv)
		sub_conv.retrieve(dw_1.getitemstring(dw_1.getrow(),'tipo_convocatoria'))
	else 
		//Curso ampliacion
		dw_1.setitem(dw_1.GetRow(),'id_curso_interno',i_id_curso_ampliacion)
		id_curso_ampliacion=dw_1.GetItemString(dw_1.GetRow(),'id_curso_interno')
		dw_1.setitem(dw_1.GetRow(),'nombre',i_titulo_curso)
		dw_1.SetItem(dw_1.GetRow(),'anyo',i_anyo)
		dw_1.SetItem(dw_1.GetRow(),'codigo',i_codigo)
		dw_1.SetItem(dw_1.GetRow(),'tipo_convocatoria',i_tipo_convocatoria)
		dw_1.SetItem(dw_1.GetRow(),'subtipo_convocatoria',i_subtipo_convocatoria)
		dw_1.SetItem(dw_1.GetRow(),'t_observaciones',i_observaciones)
		dw_1.SetItem(dw_1.GetRow(),'domicilio',i_domicilio)
		dw_1.SetItem(dw_1.GetRow(),'cod_pob',i_cod_pob)
		dw_1.SetItem(dw_1.GetRow(),'cp',i_cp)
		dw_1.SetItem(dw_1.GetRow(),'provincia',i_provincia)
		dw_1.SetItem(dw_1.GetRow(),'cod_delegacion',i_cod_delegacion)
		//Actualizamos los datawindows
		idw_cursos_form_fechas.retrieve(g_id_curso)
		idw_cursos_form_importes.retrieve(g_id_curso)
		idw_cursos_form_ponentes.retrieve(g_id_curso)
		idw_cursos_form_organizadores.retrieve(g_id_curso)
		idw_cursos_form_asistentes.retrieve(g_id_curso)
		idw_cursos_form_espera.retrieve(g_id_curso)
		idw_cursos_form_documentacion.retrieve(g_id_curso)
		idw_cursos_form_preguntas_test.retrieve(g_id_curso)
		idw_cursos_form_alumnos_test.retrieve(g_id_curso)
		idw_cursos_form_estadisticas.retrieve(g_id_curso)
		idw_cursos_form_costes.retrieve(g_id_curso)
		idw_cursos_form_ampliacion.retrieve(id_curso_ampliacion)
		idw_cursos_form_areas_materias.retrieve(g_id_curso)
		//Para sacar los datos de los cursos ampliados
		idw_cursos_form_ampliacion.SetFilter("id_curso <> '"+ g_id_curso+" '")
		idw_cursos_form_ampliacion.Filter()
	end if 
end if	

return AncestorReturnValue
end event

event activate;//Andr$$HEX1$$e900$$ENDHEX$$s.NO extiende el script del antecesor. No estoy seguro de porqu$$HEX2$$e9002000$$ENDHEX$$es as$$HEX2$$ed002000$$ENDHEX$$pero si se cambia no funciona bien
g_dw_lista=g_dw_lista_cursos_form
g_w_lista=g_lista_cursos_form
g_w_detalle=g_detalle_cursos_form
g_lista='w_cursos_form_lista'
g_detalle='w_cursos_form_detalle'

//Andr$$HEX1$$e900$$ENDHEX$$s
//Esto es necesario para que vayan los botones "siguiente" y "anterior"
//en el detalle de asistentes
g_dw_lista_asistentes=idw_cursos_form_asistentes




end event

event open;call super::open;string id_curso_ampliacion

/* ASIGNAMOS A CADA TAB UNA VARIABLE INSTANCIA*/

// FECHAS
idw_cursos_form_fechas=tab_1.tabpage_1.dw_cursos_form_fechas
f_enlaza_dw(dw_1,idw_cursos_form_fechas,'id_curso','id_curso')


// AMPLIACION
idw_cursos_form_ampliacion=tab_1.tabpage_12.dw_cursos_form_ampliacion
f_enlaza_dw(dw_1,idw_cursos_form_ampliacion,'id_curso_interno','id_curso_interno')

//IMPORTES
idw_cursos_form_importes=tab_1.tabpage_2.dw_cursos_form_importes
f_enlaza_dw(dw_1,idw_cursos_form_importes,'id_curso','id_curso')

	

//PONENTES
idw_cursos_form_ponentes=tab_1.tabpage_3.dw_cursos_form_ponentes
f_enlaza_dw(dw_1,idw_cursos_form_ponentes,'id_curso','id_curso')


//ORGANIZADORES
idw_cursos_form_organizadores=tab_1.tabpage_4.dw_cursos_form_organizadores
f_enlaza_dw(dw_1,idw_cursos_form_organizadores,'id_curso','id_curso')


//ASISTENTES
idw_cursos_form_asistentes=tab_1.tabpage_5.dw_cursos_form_asistentes
f_enlaza_dw(dw_1,idw_cursos_form_asistentes,'id_curso','id_curso')


//LISTA DE ESPERA
idw_cursos_form_espera=tab_1.tabpage_6.dw_cursos_form_espera
f_enlaza_dw(dw_1,idw_cursos_form_espera,'id_curso','id_curso')

//DOCUMENTACION
idw_cursos_form_documentacion=tab_1.tabpage_7.dw_cursos_form_documentacion
f_enlaza_dw(dw_1,idw_cursos_form_documentacion,'id_curso','id_curso')

//PREGUNTAS TEST
idw_cursos_form_preguntas_test=tab_1.tabpage_8.dw_cursos_form_preguntas_test
f_enlaza_dw(dw_1,idw_cursos_form_preguntas_test,'id_curso','id_curso')

// RESPUESTAS TEST
idw_cursos_form_alumnos_test=tab_1.tabpage_9.dw_cursos_form_alumnos_test
f_enlaza_dw(dw_1,idw_cursos_form_alumnos_test,'id_curso','formacion_asistentes_test_id_curso')

// ESTAD$$HEX1$$cd00$$ENDHEX$$STICAS TEST
idw_cursos_form_estadisticas=tab_1.tabpage_10.dw_cursos_form_estadisticas
f_enlaza_dw(dw_1,idw_cursos_form_estadisticas,'id_curso','id_curso')

// COSTES
idw_cursos_form_costes=tab_1.tabpage_11.dw_cursos_form_costes
f_enlaza_dw(dw_1,idw_cursos_form_costes,'id_curso','id_curso')


//Insertamos una fila para que salgan los botones. 
dw_curso_botones.InsertRow(0)

// Areas/Materias
idw_cursos_form_areas_materias=tab_1.tabpage_13.dw_cursos_form_areas_materias
f_enlaza_dw(dw_1,idw_cursos_form_areas_materias,'id_curso','id_curso')



//Redimensionamos los tabs  y las ventanas asociadas
inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_cursos_form_fechas, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2.dw_cursos_form_importes, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_3, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_3.dw_cursos_form_ponentes, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_4, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_4.dw_cursos_form_organizadores, "scaletoright&bottom")


inv_resize.of_Register (tab_1.tabpage_5, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_5.dw_cursos_form_asistentes, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_6, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_6.dw_cursos_form_espera, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_7, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_7.dw_cursos_form_documentacion, "scaletoright&bottom")


inv_resize.of_Register (tab_1.tabpage_8, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_8.dw_cursos_form_preguntas_test, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_9, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_9.dw_cursos_form_alumnos_test, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_10, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_10.dw_cursos_form_estadisticas, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_11, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_11.dw_cursos_form_costes, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_12, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_12.dw_cursos_form_ampliacion, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_13, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_13.dw_cursos_form_areas_materias, "scaletoright&bottom")


end event

event csd_anterior;call super::csd_anterior;if g_dw_lista.RowCount()>0 then
	g_cursos_form_consulta.id_curso=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_curso')
	dw_1.event csd_retrieve()
end if

end event

event csd_siguiente;call super::csd_siguiente;if g_dw_lista.RowCount()>0 then
	g_cursos_form_consulta.id_curso=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_curso')
	dw_1.event csd_retrieve()
end if

end event

event csd_primero;call super::csd_primero;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_cursos_form_consulta.id_curso=g_dw_lista.GetItemString(1,'id_curso')
	
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
	g_cursos_form_consulta.id_curso=g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_curso')
	
	dw_1.event csd_retrieve()
end if

end event

event pfc_preupdate;call super::pfc_preupdate;integer i
int retorno=1
datetime fecha
string mensaje=''

if f_puedo_escribir(g_usuario,'0000000030')=-1 then return -1

//Validamos el codigo,anyo,nombre,tipo_convocatoria,subtipo_convocatoria

mensaje=mensaje + f_valida(dw_1,'codigo','NONULO','Debe especificar el c$$HEX1$$f300$$ENDHEX$$digo del curso.')
mensaje=mensaje + f_valida(dw_1,'anyo','NONULO','Debe especificar el a$$HEX1$$f100$$ENDHEX$$o del curso.')
mensaje=mensaje + f_valida(dw_1,'nombre','NOVACIO','Debe especificar el nombre del curso.')
mensaje=mensaje + f_valida(dw_1,'tipo_convocatoria','NOVACIO','Debe especificar el tipo de convocatoria.')
mensaje=mensaje + f_valida(dw_1,'subtipo_convocatoria','NOVACIO','Debe especificar el subtipo de convocatoria.')
//Areas/Materias
mensaje += f_valida(idw_cursos_form_areas_materias,'codigo','NOVACIO','Ha de seleccionar una $$HEX1$$c100$$ENDHEX$$rea/Materia.'+cr)

//Si existe alg$$HEX1$$fa00$$ENDHEX$$n mensaje
if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)

	retorno=-1

end if

//Se actualizan los porcentajes de asistencia
this.event csd_recalcular_porcentaje_asistencia()
	


return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_cursos_form_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_cursos_form_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_cursos_form_detalle
integer taborder = 60
end type

type cb_ayuda from w_detalle`cb_ayuda within w_cursos_form_detalle
integer taborder = 120
end type

type cb_grabar from w_detalle`cb_grabar within w_cursos_form_detalle
integer taborder = 80
end type

type cb_ant from w_detalle`cb_ant within w_cursos_form_detalle
integer taborder = 100
end type

type cb_sig from w_detalle`cb_sig within w_cursos_form_detalle
integer taborder = 110
end type

type dw_1 from w_detalle`dw_1 within w_cursos_form_detalle
event csd_imprimir_encuesta_word ( )
integer x = 37
integer y = 32
integer width = 3209
integer height = 1096
string dataobject = "d_cursos_form_detalle"
boolean border = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_imprimir_encuesta_word();////
////Creamos el objeto Ole para manipular los datos del word
//OleObject word
//transaction trans
//string titulo, fechas
//datetime fecha_ini,fecha_fin		
////TODO: Esto hay que parametrizarlo
//string ruta_encuesta='C:\sicap v3\incidencias\i2862\Encuesta COAATB.DOC'
////string ruta_encuesta=g_directorio_plantilla_encuesta
//
//word = create OleObject
//word.connecttonewobject("word.application")
////...
////Metemos los datos del curso en la bd
//titulo=getitemstring(1,'nombre')
//fecha_ini=getitemdatetime(1,'f_ini_curso')
//fecha_fin=getitemdatetime(1,'f_fin_curso')
//fechas=f_intervalo_fechas_en_letras(fecha_ini,fecha_fin)
//
//trans = CREATE transaction
//trans.DBMS = "ODBC"
//trans.AutoCommit = False
//trans.DBParm = "ConnectString='DSN=cursos;UID=;PWD='"
//connect using trans;
//delete from cursos using trans;
//			
//insert into cursos (titulo,fechas) values (:titulo,:fechas) using trans;
//			
//commit;
//disconnect using trans;
//destroy trans
//			
//word.Documents.open(ruta_encuesta)
//word.ActiveDocument.MailMerge.Execute
//word.ActiveDocument.PrintOut()
//word.Documents.Close(0)
//	
//word.DisconnectObject()
//destroy word
end event

event dw_1::csd_retrieve;call super::csd_retrieve;if g_cursos_form_consulta.id_curso='' or isnull(g_cursos_form_consulta.id_curso) then return
int retorno
retorno=parent.event closequery()
if retorno=1 then return
this.retrieve(g_cursos_form_consulta.id_curso)
g_cursos_form_consulta.id_curso=''

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser_situacion
g_busqueda.solo_despliega_texto=False

//Cuando queremos escribir cualquier observaci$$HEX1$$f300$$ENDHEX$$n.

CHOOSE CASE dwo.name
	CASE 't_1'
		g_busqueda.titulo="Observaciones"
		obser_situacion = this.GetItemString(row, 't_observaciones')
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then this.SetItem(row,'t_observaciones',obser_situacion)
		end if

END CHOOSE
end event

event dw_1::itemchanged;integer p_l,i
string cod_provincia,cod_postal

choose case dwo.name
	//FECHA INICIO INSCRIPCION
	case 'f_ini_inscripcion'
		//i3542: Ahora comparamos fechas. Al comparar cadenas antes daba problemas.
		if date(data)>date(this.GetItemDateTime(this.GetRow(),'f_ini_curso')) then
			messagebox(G_TITULO,'La fecha de inicio del curso no puede ser anterior a la fecha de inicio de inscripciones.')
		end if
		if date(data)>date(this.GetItemDatetime(this.GetRow(),'f_fin_inscripcion')) then
			messagebox(G_TITULO,'La fecha de inicio de inscripci$$HEX1$$f300$$ENDHEX$$n no puede ser posterior a la fecha de fin.')
		end if

	//FECHA FIN INSCRIPCION
	case 'f_fin_inscripcion'
		if date(data)<date(this.GetItemDateTime(this.GetRow(),'f_ini_inscripcion')) then
			messagebox(G_TITULO,'La fecha de inicio de inscripci$$HEX1$$f300$$ENDHEX$$n no puede ser posterior a la fecha de fin.')
		end if

	//FECHA INICIO CURSO
	case 'f_ini_curso'
		if date(data)<date(this.GetItemDateTime(this.GetRow(),'f_ini_inscripcion')) then
			messagebox(G_TITULO,'La fecha de inicio del curso no puede ser anterior a la fecha de inicio de inscripciones.')
		end if
		if date(data)>date(this.GetItemDatetime(this.GetRow(),'f_fin_curso')) then
			messagebox(G_TITULO,'La fecha de inicio de curso no puede ser posterior a la fecha de fin.')
		end if
		
	//FECHA FIN CURSO
	case 'f_fin_curso'
		if date(data)<date(this.GetItemDatetime(this.GetRow(),'f_ini_curso')) then
			messagebox(G_TITULO,'La fecha de inicio de curso no puede ser posterior a la fecha de fin.')
		end if
		
	//N_PLAZAS
	case 'n_plazas'
		this.AcceptText()
		p_l=this.GetItemNumber(this.GetRow(),'n_plazas') - idw_cursos_form_asistentes.RowCount()
		g_n_plazas_libres=p_l
		g_n_plazas=integer(data)
		if p_l<0 then
			this.SetItem(this.GetRow(),'n_plazas_libres',0)
		else
			this.SetItem(this.GetRow(),'n_plazas_libres',p_l)
			for i=1 to p_l
				idw_cursos_form_espera.SetItem(i,'n_lista_espera',0)
			next
			idw_cursos_form_espera.update()
			idw_cursos_form_asistentes.retrieve(g_id_curso)
			idw_cursos_form_espera.retrieve(g_id_curso)
			
			//Llamamos al evento getfocus para que actualize.			
			dw_1.event getfocus() 	
	
		//Guardamos los contenidos		
			this.update()
	end if
		
		//N_PLAZAS_LIBRES
	case 'n_plazas_libres'
		dw_1.update()
	
	case 'tipo_convocatoria'
		isub_convocatoria.Reset()
		isub_convocatoria.Retrieve(data)
		this.SetItem(1,'subtipo_convocatoria',"")
		
	case 'subtipo_convocatoria'
		if f_es_vacio(this.GetItemString(this.GetRow(),'tipo_convocatoria')) then
		messagebox(G_TITULO,'Debe asignar primero el tipo de convocatoria al que pertenece el curso.')
		end if 
	case 'cod_pob'
		cod_provincia=f_devuelve_cod_provincia(data)
		cod_postal=f_devuelve_cod_postal(data)
		
		this.setitem(1,'cod_pob',data)
		this.setitem(1,'cp',cod_postal)
		this.setitem(1,'provincia',cod_provincia)
	
end choose	

end event

event dw_1::getfocus;dw_encuesta.visible=false
integer asis,p_l,a



//Actualizar el contador de lista en espera
	idw_cursos_form_asistentes.retrieve(g_id_curso)
	if g_n_lista_espera>0 then
		idw_cursos_form_espera.retrieve(g_id_curso)
	end if
//	Actualizar el contador de plazas libres
	p_l=g_n_plazas - idw_cursos_form_asistentes.RowCount()
	this.SetItem(this.GetRow(),'n_plazas_libres',p_l)

//Actualizar el contador de lista de espera
	this.SetItem(this.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())

	
	
//	this.update()
end event

event dw_1::retrieveend;call super::retrieveend;string id_curso,tipo_convocatoria

g_id_curso=this.GetItemString(this.GetRow(),'id_curso')
g_n_plazas=this.GetItemNumber(this.getRow(),'n_plazas')
g_n_plazas_libres=this.GetItemNumber(this.getRow(),'n_plazas_libres')
g_n_lista_espera=this.GetItemNumber(this.getRow(),'n_lista_espera')
tipo_convocatoria=this.GetItemString(this.getRow(),'tipo_convocatoria')

//Para sacar los datos de los cursos ampliados
id_curso=this.GetItemString(this.getRow(),'id_curso')
idw_cursos_form_ampliacion.SetFilter("id_curso <> '"+ id_curso +" '")
idw_cursos_form_ampliacion.Filter()


//Para que salga la descripcion de la convocatoria
isub_convocatoria.Reset()
isub_convocatoria.Retrieve(tipo_convocatoria)

//cb_0.enabled=true
dw_1.event getfocus()

this.resetupdate()
end event

event dw_1::constructor;call super::constructor;//Sirve para diferenciar el tipo de convocatoria
this.GetChild("subtipo_convocatoria",isub_convocatoria)
isub_convocatoria.settransObject(SQLCA)
isub_convocatoria.insertRow(0)
end event

event dw_1::buttonclicked;call super::buttonclicked;string pob,cod_postal,cod_provincia,id_curso


CHOOSE CASE dwo.name

	CASE 'b_poblaciones'
		//Si pulsamos el boton de  poblaciones
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'cod_pob',pob)
		cod_provincia=f_devuelve_cod_provincia(pob)
		cod_postal=f_devuelve_cod_postal(pob)
		this.setitem(row,'cp',cod_postal)
		this.setitem(row,'provincia',cod_provincia)

	CASE 'cb_encuesta'
	//Imprimimos la encuesta
		choose case g_colegio
			case 'COAATB'
			 parent.event csd_imprimir_encuesta_word()
			case else
			 id_curso=this.getitemstring(this.getrow(),'id_curso')
			 dw_enc.settransobject(sqlca)
			 dw_enc.retrieve(id_curso)
			 f_opciones_impresion(dw_enc)
		end choose
	CASE ELSE
END CHOOSE


return 1

end event

type tab_1 from tab within w_cursos_form_detalle
integer x = 37
integer y = 1176
integer width = 3424
integer height = 676
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
tabpage_10 tabpage_10
tabpage_11 tabpage_11
tabpage_13 tabpage_13
tabpage_12 tabpage_12
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.tabpage_13=create tabpage_13
this.tabpage_12=create tabpage_12
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11,&
this.tabpage_13,&
this.tabpage_12}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
destroy(this.tabpage_10)
destroy(this.tabpage_11)
destroy(this.tabpage_13)
destroy(this.tabpage_12)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Fechas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "ComputeToday5!"
long picturemaskcolor = 536870912
dw_cursos_form_fechas dw_cursos_form_fechas
end type

on tabpage_1.create
this.dw_cursos_form_fechas=create dw_cursos_form_fechas
this.Control[]={this.dw_cursos_form_fechas}
end on

on tabpage_1.destroy
destroy(this.dw_cursos_form_fechas)
end on

type dw_cursos_form_fechas from u_dw within tabpage_1
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_fechas"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_curso_fechas',f_siguiente_numero('FORMACION_FECHAS',10))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_curso_fechas',f_siguiente_numero('FORMACION_FECHAS',10))
return 1
end event

event itemchanged;datetime h_ini,h_fin,h_i,h_f,dia_s,f
integer i

choose case dwo.name
//		FECHA
	case 'fecha'	
	this.accepttext()
	f=this.GetItemDateTime(this.getRow(),'fecha')
	if dw_1.GetItemDateTime(dw_1.GetRow(),'f_ini_curso')>f then
		messagebox(G_TITULO,'La fecha debe pertenecer a las fechas del curso.')
	end if	
	//Andr$$HEX1$$e900$$ENDHEX$$s: He cambiado el <= por <, sino no se puede poner una sesi$$HEX1$$f300$$ENDHEX$$n el $$HEX1$$fa00$$ENDHEX$$ltimo d$$HEX1$$ed00$$ENDHEX$$a del curso
	if dw_1.GetItemDateTime(dw_1.GetRow(),'f_fin_curso')<f then
		messagebox(G_TITULO,'La fecha debe pertenecer a las fechas del curso.')
	end if	

//		HORA INI
	case 'hora_ini'
	this.AcceptText()
		h_ini = this.GetItemDateTime(this.GetRow(),'hora_ini')
		h_fin=this.GetItemDateTime(this.GetRow(),'hora_fin')
		dia_s=this.GetItemDateTime(this.GetRow(),'fecha')

		//Si la hora de fin es anterior a la inicial
		if datetime(time(h_fin)) <= datetime(time(h_ini)) then
			messagebox(g_titulo,'La hora de fin no puede ser anterior a la hora de inicio.')
		else	
		for i=1 to this.RowCount()
			if i<>this.GetRow() then
				//Si coincide con algun otro dia se comprueba q
				//no se solapen las horas
				if dia_s=this.GetItemDateTime(i,'fecha') then
					h_i=this.GetItemDateTime(i,'hora_ini')
					h_f=this.GetItemDateTime(i,'hora_fin')
					//Si el horario de una est$$HEX2$$e1002000$$ENDHEX$$dentro del de otra
					if (((h_ini<=h_i) AND (h_f<=h_fin)) OR ((h_i<=h_ini) AND (h_fin<=h_f))) then
						messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro.')
					else
						//Si se solapa por la hora de inicio
						if (h_i<=h_ini) AND (h_ini<h_f) then
							messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro, modifica la hora de inicio')
						end if
						//Si se solapa por la hora de fin
						if (h_i<=h_fin) AND (h_fin<=h_f) then
							messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro, modifica la hora de fin')
						end if
					end if
				end if
			end if
		next
	end if					
					
//		HORA FIN
	case 'hora_fin'
		this.AcceptText()
		h_ini = this.GetItemDateTime(this.GetRow(),'hora_ini')
		h_fin=this.GetItemDateTime(this.GetRow(),'hora_fin')
		dia_s=this.GetItemDateTime(this.GetRow(),'fecha')
		
		//Si la hora de fin es anterior a la inicial
		if datetime(time(h_fin)) <= datetime(time(h_ini)) then
			messagebox(g_titulo,'La hora de fin no puede ser anterior a la hora de inicio.')
		else	
		for i=1 to this.RowCount()
			if i<>this.GetRow() then
				//Si coincide con algun otro dia se comprueba q
				//no se solapen las horas
				if dia_s=this.GetItemDateTime(i,'fecha') then
					h_i=this.GetItemDateTime(i,'hora_ini')
					h_f=this.GetItemDateTime(i,'hora_fin')
					//Si el horario de una est$$HEX2$$e1002000$$ENDHEX$$dentro del de otra
					if (((h_ini<=h_i) AND (h_f<=h_fin)) OR ((h_i<=h_ini) AND (h_fin<=h_f))) then
						messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro.')
					else
						//Si se solapa por la hora de inicio
						if (h_i<=h_ini) AND (h_ini<h_f) then
							messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro, modifica la hora de inicio')
						end if
						//Si se solapa por la hora de fin
						if (h_i<=h_fin) AND (h_fin<=h_f) then
							messagebox(G_TITULO,'ATENCION: El horario para esta asignatura se solapa con otro, modifica la hora de fin')
						end if
					end if
				end if
			end if
		next
	end if					
		
end choose

	
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register('fecha',this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)



end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Importes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom048!"
long picturemaskcolor = 536870912
dw_cursos_form_importes dw_cursos_form_importes
end type

on tabpage_2.create
this.dw_cursos_form_importes=create dw_cursos_form_importes
this.Control[]={this.dw_cursos_form_importes}
end on

on tabpage_2.destroy
destroy(this.dw_cursos_form_importes)
end on

type dw_cursos_form_importes from u_dw within tabpage_2
boolean visible = false
integer x = 14
integer y = 20
integer width = 3337
integer height = 640
integer taborder = 11
boolean enabled = false
string dataobject = "d_cursos_form_importes"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_importe',f_siguiente_numero('FORMACION_IMPORTES',10))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_importe',f_siguiente_numero('FORMACION_IMPORTES',10))
return 1
end event

event itemchanged;choose case dwo.name
	case 'importe'
		if integer(data)<0 then
			messagebox(G_TITULO,'El Importe no puede ser negativo.')
		end if
end choose
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Ponentes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_cursos_form_ponentes dw_cursos_form_ponentes
end type

on tabpage_3.create
this.dw_cursos_form_ponentes=create dw_cursos_form_ponentes
this.Control[]={this.dw_cursos_form_ponentes}
end on

on tabpage_3.destroy
destroy(this.dw_cursos_form_ponentes)
end on

type dw_cursos_form_ponentes from u_dw within tabpage_3
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_ponentes"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_curso_ponente',f_siguiente_numero('FORMACION_PONENTES',10))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_curso_ponente',f_siguiente_numero('FORMACION_PONENTES',10))
return 1
end event

event buttonclicked;call super::buttonclicked;
string titulo,id_ponente


this.update()
this.AcceptText()

CHOOSE CASE dwo.name
	CASE 'b_ponente'
	//Abrimos la ventana de b$$HEX1$$fa00$$ENDHEX$$squeda de ofertantes
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Empresas"
		g_busqueda.dw="d_lista_busqueda_terceros"
		id_ponente=f_busqueda_terceros(g_terceros_codigos.ponente)
		if f_es_vacio(id_ponente) then return
		this.SetItem(this.GetRow(),'id_ponente',id_ponente)
END CHOOSE






end event

event itemchanged;call super::itemchanged;datetime f
choose case dwo.name
//		FECHA
	case 'f_intervencion'
		this.accepttext()
		f=this.GetItemDateTime(this.getRow(),'f_intervencion')
	if dw_1.GetItemDateTime(dw_1.GetRow(),'f_ini_curso')>f then
		messagebox(G_TITULO,'La fecha debe pertenecer a las fechas del curso.')
	end if	
	if dw_1.GetItemDateTime(dw_1.GetRow(),'f_fin_curso')<f then
		messagebox(G_TITULO,'La fecha debe pertenecer a las fechas del curso.')
	end if	
end choose
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register('f_intervencion',this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event doubleclicked;call super::doubleclicked;string obser
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_7'
		g_busqueda.titulo="Valoraci$$HEX1$$f300$$ENDHEX$$n"
		obser = this.GetItemString(row, 'valoracion')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then this.SetItem(row,'valoracion',obser)
		end if
END CHOOSE

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Organizadores"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom026!"
long picturemaskcolor = 536870912
dw_cursos_form_organizadores dw_cursos_form_organizadores
end type

on tabpage_4.create
this.dw_cursos_form_organizadores=create dw_cursos_form_organizadores
this.Control[]={this.dw_cursos_form_organizadores}
end on

on tabpage_4.destroy
destroy(this.dw_cursos_form_organizadores)
end on

type dw_cursos_form_organizadores from u_dw within tabpage_4
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_organizadores"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_organizador',f_siguiente_numero('FORMACION_ORG',10))
return 1
end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.GetRow(),'id_organizador',f_siguiente_numero('FORMACION_ORG',10))
return 1
end event

event buttonclicked;call super::buttonclicked;string cod_pob,cod_provincia
CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		cod_pob=f_busqueda_poblaciones()
		if f_es_vacio(cod_pob) then return
		this.SetItem(row,'poblacion',cod_pob)
		cod_provincia=f_devuelve_cod_provincia(cod_pob)
		this.setitem(row,'provincia',cod_provincia)
			
	
END CHOOSE

end event

event itemchanged;call super::itemchanged;string cod_provincia

cod_provincia=f_devuelve_cod_provincia(data)
this.setitem(row,'provincia',cod_provincia)
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Asistentes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Query!"
long picturemaskcolor = 536870912
cb_facturar cb_facturar
dw_cursos_form_asistentes dw_cursos_form_asistentes
end type

on tabpage_5.create
this.cb_facturar=create cb_facturar
this.dw_cursos_form_asistentes=create dw_cursos_form_asistentes
this.Control[]={this.cb_facturar,&
this.dw_cursos_form_asistentes}
end on

on tabpage_5.destroy
destroy(this.cb_facturar)
destroy(this.dw_cursos_form_asistentes)
end on

type cb_facturar from commandbutton within tabpage_5
integer x = 2674
integer y = 16
integer width = 645
integer height = 80
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Facturas"
end type

event clicked;// Pasamos a la ventana de facturas manuales un ds con el dw de los asistentes
datastore ds_asist
ds_asist = create datastore
ds_asist.dataobject = 'd_cursos_form_asistentes'
ds_asist.settransobject(sqlca)
ds_asist.retrieve(dw_1.getitemstring(1, 'id_curso'))


openwithparm(w_colegiados_factura_cualquier_concepto, ds_asist)

end event

type dw_cursos_form_asistentes from u_dw within tabpage_5
integer x = 5
integer y = 108
integer width = 3369
integer height = 332
integer taborder = 11
string dataobject = "d_cursos_form_asistentes"
end type

event type integer pfc_deleterow();call super::pfc_deleterow;integer p_l,i,n_l_e

if idw_cursos_form_espera.RowCount()>0 then

	for i=1 to idw_cursos_form_espera.RowCount()
		n_l_e=idw_cursos_form_espera.GetItemNumber(i,'n_lista_espera') - 1
		idw_cursos_form_espera.SetItem(i,'n_lista_espera',n_l_e)
	next
dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())	
idw_cursos_form_espera.update()
idw_cursos_form_espera.retrieve(g_id_curso)

//se actualiza el contador de n_lista_espera
dw_1.SetItem(dw_1.getRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())
g_n_lista_espera=dw_1.GetItemNumber(dw_1.GetRow(),'n_lista_espera')
else
	////Incrementar el n$$HEX2$$ba002000$$ENDHEX$$de plazas libres
g_n_plazas_libres=g_n_plazas - this.RowCount()
dw_1.SetItem(dw_1.getRow(),'n_plazas_libres',g_n_plazas_libres)
end if

return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_debug.enabled = False
if this.rowcount()=0 then
	am_dw.m_table.m_delete.enabled = false
else
	am_dw.m_table.m_delete.enabled = true
end if

end event

event doubleclicked;if this.RowCount()>0 then
	g_asistentes_consulta.id_asistente=this.getitemstring(this.getrow(),'id_asistente')
	g_n_lista_espera=idw_cursos_form_espera.Rowcount()
	message.stringparm="w_asistentes_detalle"
	w_aplic_frame.postevent("csd_asistentesdetalle")
end if

end event

event retrieveend;integer p_l
p_l=g_n_plazas - this.RowCount()
g_n_plazas_libres=p_l
dw_1.SetItem(dw_1.GetRow(),'n_plazas_libres',p_l)

//this.SetSort("apellidos A")
//this.Sort()

this.resetupdate()
end event

event type integer pfc_preupdate();call super::pfc_preupdate;string id_asistente, id_curso
double i
double fila

ds_borrados = create datastore
ds_borrados.dataobject = 'd_borrados'
ds_borrados.settrans(sqlca)

// Insertamos todos los colegiados que han sido borrados en el datastore
for i = 1 to idw_cursos_form_asistentes.deletedcount()
	id_asistente = idw_cursos_form_asistentes.getitemstring(i,'id_asistente',Delete!,true)
	id_curso = idw_cursos_form_asistentes.getitemstring(i,'id_curso',Delete!,true)
	fila = ds_borrados.insertrow(0)
	ds_borrados.setitem(fila,'id_asistente',id_asistente)
	ds_borrados.setitem(fila,'id_curso',id_curso)
next

return ancestorreturnvalue
end event

event type integer pfc_postupdate();call super::pfc_postupdate;string id_asistente, id_curso
int i

//Borramos tambien los colegiados de la lista de control de asistencias

for i = 1 to ds_borrados.rowcount()
	id_asistente = ds_borrados.getitemstring(i,'id_asistente')
	id_curso = ds_borrados.getitemstring(i,'id_curso')
	delete from formacion_ctrl_asistencia where id_asistente = :id_asistente and id_curso = :id_curso;
next

return ancestorreturnvalue
end event

event clicked;call super::clicked;//Andr$$HEX1$$e900$$ENDHEX$$s: Hacer que la l$$HEX1$$ed00$$ENDHEX$$nea se marque cuando el usuario hace click
this.selectRow(0,false)
this.selectRow(row,true)
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Lista de Espera"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Regenerate5!"
long picturemaskcolor = 536870912
dw_cursos_form_espera dw_cursos_form_espera
end type

on tabpage_6.create
this.dw_cursos_form_espera=create dw_cursos_form_espera
this.Control[]={this.dw_cursos_form_espera}
end on

on tabpage_6.destroy
destroy(this.dw_cursos_form_espera)
end on

type dw_cursos_form_espera from u_dw within tabpage_6
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_espera"
end type

event pfc_deleterow;call super::pfc_deleterow;integer n_l_e,i

if idw_cursos_form_espera.RowCount()>0 then
	if this.GetRow()=this.RowCount() then
//		if this.GetRow()=1 then this.SetItem(1,'n_lista_espera',1)
		this.SetItem(this.GetRow(),'n_lista_espera',this.GetRow())
	else
		for i=this.GetRow() to this.RowCount()
			n_l_e=idw_cursos_form_espera.GetItemNumber(i,'n_lista_espera') - 1
			idw_cursos_form_espera.SetItem(i,'n_lista_espera',n_l_e)
		next

	//se actualiza el contador de n_lista_espera
	dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())	
	idw_cursos_form_espera.update()
//	idw_cursos_form_espera.retrieve(g_id_curso)
	end if
end if
return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_debug.enabled = False

if this.rowcount()=0 then
	am_dw.m_table.m_delete.enabled = false
else
	am_dw.m_table.m_delete.enabled = true
end if
end event

event retrieveend;call super::retrieveend;//integer i,j,cont,n,s
//s=1
//n=1
//for i=1 to this.RowCount()
//	if this.GetItemString(i,'n_colegiado')<>'' then
//		this.SetItem(i,'n_lista_espera',s)
//		s=s+1
//		n=s
//	end if
//next
//for i=1 to this.RowCount()
//	if this.GetItemString(i,'n_colegiado')='' then
//		this.SetItem(i,'n_lista_espera',n)
//		n=n+1
//	end if
//next
//
//this.SetSort("n_lista_espera A")
//this.Sort()
//
//this.resetupdate()
end event

event doubleclicked;call super::doubleclicked;if this.RowCount()>0 then
	g_asistentes_consulta.id_asistente=this.getitemstring(this.getrow(),'id_asistente')
	g_n_lista_espera=this.Rowcount()
	message.stringparm="w_asistentes_detalle"
	w_aplic_frame.postevent("csd_asistentesdetalle")
end if
end event

event clicked;call super::clicked;//Andr$$HEX1$$e900$$ENDHEX$$s: Hacer que la l$$HEX1$$ed00$$ENDHEX$$nea se marque cuando el usuario hace click
this.selectRow(0,false)
this.selectRow(row,true)
end event

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Documentaci$$HEX1$$f300$$ENDHEX$$n"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Compile!"
long picturemaskcolor = 536870912
cb_5 cb_5
dw_cursos_form_documentacion dw_cursos_form_documentacion
end type

on tabpage_7.create
this.cb_5=create cb_5
this.dw_cursos_form_documentacion=create dw_cursos_form_documentacion
this.Control[]={this.cb_5,&
this.dw_cursos_form_documentacion}
end on

on tabpage_7.destroy
destroy(this.cb_5)
destroy(this.dw_cursos_form_documentacion)
end on

type cb_5 from commandbutton within tabpage_7
boolean visible = false
integer x = 2697
integer y = 4
integer width = 622
integer height = 92
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Asignar Documento"
end type

event clicked;string dir,nombre
integer valor

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02


idw_cursos_form_documentacion.event pfc_addrow()
valor=GetFileOpenName("Seleccione Documento",dir,nombre,"DOC", &
		+ "Text Files (*.TXT),*.TXT," &
		+ "Doc Files (*.DOC),*.DOC")



if valor=1 then
	idw_cursos_form_documentacion.SetItem(idw_cursos_form_documentacion.GetRow(),'Documento',dir)
else
	idw_cursos_form_documentacion.event pfc_deleterow()
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


end event

type dw_cursos_form_documentacion from u_dw within tabpage_7
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_documentacion"
end type

event pfc_addrow;call super::pfc_addrow;cb_5.enabled=true

string ls_numero

ls_numero=f_siguiente_numero('FORMACION_DOC',10)
this.SetItem(ancestorreturnvalue,'id_documento',ls_numero)
this.SetItem(ancestorreturnvalue,'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))
//string dir,nombre
//integer valor
//valor=GetFileOpenName("Seleccione el Logo del Organizador",dir,nombre,"DOC", &
//		+ "Text Files (*.TXT),*.TXT," &
//		+ "Doc Files (*.DOC),*.DOC")
//
//
////
////messagebox("",dir)
////messagebox("",nombre)
//
//if valor=1 then
//	this.SetItem(this.GetRow(),'Documento',dir)
//end if
//
return ancestorreturnvalue
end event

event doubleclicked;string doc,documento,extension_fichero,ruta
integer posicion,pos_anterior=0,i

doc=this.GetItemString(this.GetRow(),'documento')
		For i=1 to 80
			//Buscamos la posicion donde se encuentra la $$HEX1$$fa00$$ENDHEX$$ltima barra
			posicion=PosA(doc,'\',pos_anterior+1)
			pos_anterior=posicion
		next
		//Sacamos el nombre del documento
		documento=MidA(doc,pos_anterior+1)
		ruta=LeftA(doc,pos_anterior)
//Abrimos el fichero con su programa asociado en Windows
f_abrir_fichero(ruta,documento,"")



end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;//am_dw.m_table.m_insert.enabled = False
//am_dw.m_table.m_addrow.enabled = False
//am_dw.m_table.m_debug.enabled = False
//am_dw.m_table.m_delete.enabled = false

end event

event buttonclicked;call super::buttonclicked;string dir,nombre
integer valor


CHOOSE CASE dwo.name
	CASE 'b_busqueda_ruta'
		// MODIFICADO RICARDO 04-03-02
		n_cst_filesrvwin32 cambia_directorio
		string directorio
		cambia_directorio = create n_cst_filesrvwin32
		directorio = cambia_directorio.of_getcurrentdirectory()
		// FIN MODIFICADO RICARDO 04-03-02
		
	//	idw_cursos_form_documentacion.event pfc_addrow()
		valor=GetFileOpenName("Seleccione Documento",dir,nombre,"DOC", &
		+ "Todos los Archivos (*.*),*.*,")

	if valor=1 then
		idw_cursos_form_documentacion.SetItem(idw_cursos_form_documentacion.GetRow(),'Documento',dir)
	else
		idw_cursos_form_documentacion.event pfc_deleterow()
	end if


	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02

END CHOOSE






end event

event pfc_insertrow;call super::pfc_insertrow;string ls_numero

ls_numero=f_siguiente_numero('FORMACION_DOC',10)
this.SetItem(ancestorreturnvalue,'id_documento',ls_numero)
this.SetItem(ancestorreturnvalue,'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))

return ancestorreturnvalue
end event

event clicked;call super::clicked;this.selectRow(0,false)
this.selectRow(row,true)
end event

type tabpage_8 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Preguntas Encuesta"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Help!"
long picturemaskcolor = 536870912
cb_1 cb_1
cb_encuesta cb_encuesta
dw_cursos_form_preguntas_test dw_cursos_form_preguntas_test
end type

on tabpage_8.create
this.cb_1=create cb_1
this.cb_encuesta=create cb_encuesta
this.dw_cursos_form_preguntas_test=create dw_cursos_form_preguntas_test
this.Control[]={this.cb_1,&
this.cb_encuesta,&
this.dw_cursos_form_preguntas_test}
end on

on tabpage_8.destroy
destroy(this.cb_1)
destroy(this.cb_encuesta)
destroy(this.dw_cursos_form_preguntas_test)
end on

type cb_1 from commandbutton within tabpage_8
integer x = 2021
integer y = 16
integer width = 645
integer height = 80
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Copiar Encuesta"
end type

event clicked;integer i,fila,num
string codigo_curso


if(idw_cursos_form_preguntas_test.RowCount() > 0) then
	//Buscamos el curso destino de la copia
	open(w_cursos_form_lista_copia_encuesta)

	if (message.stringparm <> '-1') then
		//Si ha seleccionado alguno copiamos todas las preguntas
		codigo_curso = message.stringparm 

		ds_encuesta=CREATE datastore
		ds_encuesta.dataobject='d_cursos_form_preguntas_test'
		ds_encuesta.settransobject(SQLCA)

		select count(*) into :num from formacion_encuesta where id_curso = :codigo_curso;

		//Guardamos las filas de la encuesta en un datastore
		for i=1 to idw_cursos_form_preguntas_test.RowCount()
			fila = ds_encuesta.insertrow(0)

			ds_encuesta.SetItem(fila,'id_curso',codigo_curso)
			ds_encuesta.SetItem(fila,'id_pregunta',f_siguiente_numero('FORMACION_PREG',10))
			ds_encuesta.SetItem(fila,'pregunta',idw_cursos_form_preguntas_test.GetItemString(i,'pregunta'))
			ds_encuesta.SetItem(fila,'tipo_respuesta',idw_cursos_form_preguntas_test.GetItemString(i,'tipo_respuesta'))
			ds_encuesta.SetItem(fila,'n_pregunta',num+i)
		next

		ds_encuesta.update()

	end if
else
	messagebox(g_titulo,"No hay preguntas que copiar")
end if
end event

type cb_encuesta from commandbutton within tabpage_8
integer x = 2674
integer y = 16
integer width = 645
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Encuesta"
end type

event clicked;integer i,j,num
string res

ds_encuesta=CREATE datastore
ds_encuesta.dataobject='ds_encuesta_valores_test'
ds_encuesta.SetTransObject(SQLCA)
ds_encuesta.retrieve()
g_n_res=ds_encuesta.rowcount()

for i=1 to idw_cursos_form_preguntas_test.RowCount()
	dw_encuesta.event pfc_addrow()
	
	dw_encuesta.SetItem(i,'id_curso',idw_cursos_form_preguntas_test.GetItemString(idw_cursos_form_preguntas_test.GetRow(),'id_curso'))
	dw_encuesta.SetItem(i,'pregunta',idw_cursos_form_preguntas_test.GetItemString(i,'pregunta'))
	dw_encuesta.SetItem(i,'tipo_respuesta',idw_cursos_form_preguntas_test.GetItemString(i,'tipo_respuesta'))
	
	if idw_cursos_form_preguntas_test.GetItemString(i,'tipo_respuesta')='T' then

		for j=1 to ds_encuesta.RowCount()
			res=ds_encuesta.GetItemString(j,'respuesta_test')
			choose case j
				case 1
					dw_encuesta.object.t_text1.text=res
				case 2
					dw_encuesta.object.t_text2.text=res
				case 3
					dw_encuesta.object.t_text3.text=res
				case 4
					dw_encuesta.object.t_text4.text=res
				case 5
					dw_encuesta.object.t_text5.text=res
				case 6
					dw_encuesta.object.t_text6.text=res
			end choose
		next
	end if
next

//		dw_encuesta.visible=true
for i=1 to idw_cursos_form_asistentes.RowCount()
	dw_encuesta.print()
next
dw_encuesta.resetupdate()

end event

type dw_cursos_form_preguntas_test from u_dw within tabpage_8
integer x = 5
integer y = 108
integer width = 3369
integer height = 332
integer taborder = 10
string dataobject = "d_cursos_form_preguntas_test"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_pregunta',f_siguiente_numero('FORMACION_PREG',10))
this.SetItem(this.GetRow(),'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))
this.SetItem(this.GetRow(),'n_pregunta',this.GetRow())

RETURN 1
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False

end event

type tabpage_9 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Respuestas Encuesta"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom038!"
long picturemaskcolor = 536870912
cb_8 cb_8
cb_7 cb_7
dw_cursos_form_alumnos_test dw_cursos_form_alumnos_test
end type

on tabpage_9.create
this.cb_8=create cb_8
this.cb_7=create cb_7
this.dw_cursos_form_alumnos_test=create dw_cursos_form_alumnos_test
this.Control[]={this.cb_8,&
this.cb_7,&
this.dw_cursos_form_alumnos_test}
end on

on tabpage_9.destroy
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.dw_cursos_form_alumnos_test)
end on

type cb_8 from commandbutton within tabpage_9
integer x = 2021
integer y = 16
integer width = 645
integer height = 80
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Grabar Datos Encuesta"
end type

event clicked;dw_cursos_form_alumnos_test.update()
cb_8.enabled=false
//----------------------------
string id_curso,id_pregunta
integer n_preg,valor_total,valor_max,valor_max_tot,valor,i,existe_preg
integer n_encuestas
double porcent_preg

for i=1 to idw_cursos_form_alumnos_test.RowCount()
	if idw_cursos_form_alumnos_test.GetItemString(i,'tipo_respuesta')='T' then
		id_curso=idw_cursos_form_alumnos_test.GetItemString(i,'id_curso')
		id_pregunta=idw_cursos_form_alumnos_test.GetItemString(i,'id_pregunta')
		n_preg=idw_cursos_form_alumnos_test.GetItemNumber(i,'n_pregunta')
		
		//Se comprueba si se ha realizado alguna encuesta de este curso
		SELECT n_pregunta
		INTO :existe_preg
		FROM formacion_estadisticas
		WHERE (id_curso=:id_curso) AND
				(id_pregunta=:id_pregunta);
		
		//Se calcula el valor m$$HEX1$$e100$$ENDHEX$$ximo
		SELECT max(valor_respuesta)
		INTO :valor_max
		FROM formacion_mant_test;
		
		//Si no se han introducido datos de encuestas en este curso
		if existe_preg=0 or isnull(existe_preg) then
			idw_cursos_form_estadisticas.event pfc_addrow()
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'id_curso',id_curso)
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'id_pregunta',id_pregunta)	
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'n_pregunta',n_preg)	
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'n_encuestas',1)							

			//Se inserta el n_pregunta
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'n_pregunta',n_preg)		
	
			//Se inserta el valor total pregunta
			valor_total=idw_cursos_form_alumnos_test.GetItemNumber(i,'valor_respuesta')
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'valor_total_pregunta',valor_total)		
				
			//Se inserta el valor m$$HEX1$$e100$$ENDHEX$$ximo	
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'valor_maximo',valor_max)		
		
			//Se inserta el porcentaje 
			porcent_preg=(valor_total/valor_max)*100
			idw_cursos_form_estadisticas.SetItem(idw_cursos_form_estadisticas.GetRow(),'porcentaje_pregunta',porcent_preg)		
	
	//Si ya se ha introducido algun dato en las encuestas
		else
			
			valor=idw_cursos_form_alumnos_test.GetItemNumber(i,'valor_respuesta')
			valor_total=idw_cursos_form_estadisticas.GetItemNumber(i,'valor_total_pregunta')
			valor_total+=valor
			valor_max_tot=idw_cursos_form_estadisticas.GetItemNumber(i,'valor_maximo')
			valor_max_tot+=valor_max
			porcent_preg=(valor_total/valor_max_tot)*100

			n_encuestas=idw_cursos_form_estadisticas.GetItemNumber(i,'n_encuestas')
			n_encuestas++
			
			
			UPDATE formacion_estadisticas 
			SET valor_total_pregunta=:valor_total,valor_maximo=:valor_max_tot,porcentaje_pregunta=:porcent_preg,n_encuestas=:n_encuestas
			WHERE id_pregunta=:id_pregunta;
			commit ;
		end if
	end if
	idw_cursos_form_estadisticas.update()
next	
idw_cursos_form_estadisticas.retrieve(id_curso)
idw_cursos_form_alumnos_test.reset()

//----------------------------
end event

type cb_7 from commandbutton within tabpage_9
integer x = 2674
integer y = 16
integer width = 645
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Introducir Nueva Encuesta"
end type

event clicked;integer i,j
string res
cb_8.enabled=true
if dw_cursos_form_alumnos_test.RowCount()>0 then
	dw_cursos_form_alumnos_test.update()
end if

dw_cursos_form_alumnos_test.reset()
	
	ds_encuesta=CREATE datastore
	ds_encuesta.dataobject='ds_encuesta_valores_test'
	ds_encuesta.SetTransObject(SQLCA)
   ds_encuesta.retrieve()
	

for i=1 to idw_cursos_form_preguntas_test.RowCount()

	dw_cursos_form_alumnos_test.event pfc_addrow()
	
	dw_cursos_form_alumnos_test.SetItem(i,'n_pregunta',idw_cursos_form_preguntas_test.GetItemNumber(i,'n_pregunta'))
	dw_cursos_form_alumnos_test.SetItem(i,'tipo_respuesta',idw_cursos_form_preguntas_test.GetItemString(i,'tipo_respuesta'))
	dw_cursos_form_alumnos_test.SetItem(i,'pregunta',idw_cursos_form_preguntas_test.GetItemString(i,'pregunta'))
	dw_cursos_form_alumnos_test.SetItem(i,'id_pregunta',idw_cursos_form_preguntas_test.GetItemString(i,'id_pregunta'))

next

dw_cursos_form_alumnos_test.SetSort("id_encuesta A")
//dw_cursos_form_alumnos_test.Sort()
end event

type dw_cursos_form_alumnos_test from u_dw within tabpage_9
integer x = 5
integer y = 100
integer width = 3369
integer height = 336
integer taborder = 11
string dataobject = "d_cursos_form_respuesta_test"
boolean ib_rmbmenu = false
end type

event type long pfc_addrow();call super::pfc_addrow;this.SetItem(this.GetRow(),'id_encuesta',f_siguiente_numero('FORMACION_ENCUESTAS',10))
this.SetItem(this.GetRow(),'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))
this.SetItem(this.GetRow(),'n_pregunta',idw_cursos_form_preguntas_test.GetItemNumber(idw_cursos_form_preguntas_test.GetRow(),'n_pregunta'))

RETURN 1
end event

event itemchanged;integer valor

choose case dwo.name
	case 'id_respuesta_test'
		
		//En 'valor' se guarda el valor marcado
		SELECT valor_respuesta
		INTO :valor
		FROM formacion_mant_test
		WHERE id_respuesta_test=:data;
		
		this.SetItem(this.GetRow(),'valor_respuesta',valor)
		
		
		
end choose	
end event

event doubleclicked;string obser_situacion
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 'respuesta_t'
		g_busqueda.titulo="Observaciones"
		obser_situacion = this.GetItemString(row, 'respuesta')
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then this.SetItem(row,'respuesta',obser_situacion)
		end if

END CHOOSE
end event

type tabpage_10 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Estad$$HEX1$$ed00$$ENDHEX$$sticas Encuestas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom067!"
long picturemaskcolor = 536870912
cb_9 cb_9
dw_cursos_form_estadisticas dw_cursos_form_estadisticas
end type

on tabpage_10.create
this.cb_9=create cb_9
this.dw_cursos_form_estadisticas=create dw_cursos_form_estadisticas
this.Control[]={this.cb_9,&
this.dw_cursos_form_estadisticas}
end on

on tabpage_10.destroy
destroy(this.cb_9)
destroy(this.dw_cursos_form_estadisticas)
end on

type cb_9 from commandbutton within tabpage_10
integer x = 2674
integer y = 16
integer width = 645
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir Estad$$HEX1$$ed00$$ENDHEX$$sticas"
end type

event clicked;//		dw_estadisticas.event pfc_addrow()
string id_curso
id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
		dw_estadisticas.retrieve(id_curso)
//		dw_estadisticas.visible=true
		dw_estadisticas.print()
end event

type dw_cursos_form_estadisticas from u_dw within tabpage_10
integer x = 5
integer y = 108
integer width = 3369
integer height = 332
integer taborder = 11
string dataobject = "d_cursos_form_estadisticas2"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_estadistica',f_siguiente_numero('FORMACION_ESTADISTIC',10))
this.SetItem(this.GetRow(),'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))
//this.SetItem(this.GetRow(),'n_pregunta',this.GetRow())

RETURN 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_debug.enabled = False
am_dw.m_table.m_delete.enabled = false


end event

type tabpage_11 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Costes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "FormatDollar!"
long picturemaskcolor = 536870912
dw_cursos_form_costes dw_cursos_form_costes
end type

on tabpage_11.create
this.dw_cursos_form_costes=create dw_cursos_form_costes
this.Control[]={this.dw_cursos_form_costes}
end on

on tabpage_11.destroy
destroy(this.dw_cursos_form_costes)
end on

type dw_cursos_form_costes from u_dw within tabpage_11
boolean visible = false
integer x = 5
integer y = 24
integer width = 3328
integer height = 640
integer taborder = 11
boolean enabled = false
string dataobject = "d_cursos_form_costes"
end type

event pfc_addrow;call super::pfc_addrow;this.SetItem(this.GetRow(),'id_coste',f_siguiente_numero('FORMACION_COSTES',10))
this.SetItem(this.GetRow(),'id_curso',dw_1.GetItemString(dw_1.GetRow(),'id_curso'))
//this.SetItem(this.GetRow(),'n_pregunta',this.GetRow())

RETURN 1
end event

type tabpage_13 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "$$HEX1$$c100$$ENDHEX$$reas/Materias"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "CrossTab!"
long picturemaskcolor = 536870912
dw_cursos_form_areas_materias dw_cursos_form_areas_materias
end type

on tabpage_13.create
this.dw_cursos_form_areas_materias=create dw_cursos_form_areas_materias
this.Control[]={this.dw_cursos_form_areas_materias}
end on

on tabpage_13.destroy
destroy(this.dw_cursos_form_areas_materias)
end on

type dw_cursos_form_areas_materias from u_dw within tabpage_13
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_areas_materias"
end type

event pfc_preupdate;call super::pfc_preupdate;//
/*string mensaje
int retorno=1

mensaje += f_valida(dw_cursos_form_areas_materias,'codigo','NOVACIO','Ha de seleccionar una $$HEX1$$c100$$ENDHEX$$rea/Materia.'+cr)

if mensaje<>'' then
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
*/
return 0
end event

type tabpage_12 from userobject within tab_1
integer x = 18
integer y = 208
integer width = 3387
integer height = 452
long backcolor = 79741120
string text = "Ampliaciones"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Cascade!"
long picturemaskcolor = 536870912
dw_cursos_form_ampliacion dw_cursos_form_ampliacion
end type

on tabpage_12.create
this.dw_cursos_form_ampliacion=create dw_cursos_form_ampliacion
this.Control[]={this.dw_cursos_form_ampliacion}
end on

on tabpage_12.destroy
destroy(this.dw_cursos_form_ampliacion)
end on

type dw_cursos_form_ampliacion from u_dw within tabpage_12
integer x = 5
integer y = 16
integer width = 3369
integer height = 424
integer taborder = 11
string dataobject = "d_cursos_form_ampliacion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;if this.RowCount()>0 then
	g_cursos_form_consulta.id_curso=this.getitemstring(row,'id_curso')
	//Andr$$HEX1$$e900$$ENDHEX$$s: Llamamos directamente al evento dw_1.retrieve, llamar w_aplic_frame.postevent("csd_cursos_formdetalle") no funciona
	dw_1.event csd_retrieve()
end if

end event

event clicked;call super::clicked;//Andr$$HEX1$$e900$$ENDHEX$$s: Hacer que la l$$HEX1$$ed00$$ENDHEX$$nea se marque cuando el usuario hace click
this.selectRow(0,false)
this.selectRow(row,true)
end event

type dw_diplomas from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2875
integer y = 572
integer width = 398
integer height = 300
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_cursos_form_diplomas"
boolean ib_isupdateable = false
end type

type dw_recibos from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2875
integer y = 572
integer width = 398
integer height = 300
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_cursos_form_recibos"
boolean ib_isupdateable = false
end type

type dw_encuesta from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2875
integer y = 572
integer width = 398
integer height = 300
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_cursos_form_encuesta"
end type

type dw_estadisticas from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2875
integer y = 572
integer width = 398
integer height = 300
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_cursos_form_imprimir_estadisticas"
boolean ib_isupdateable = false
end type

type cb_6 from commandbutton within w_cursos_form_detalle
boolean visible = false
integer x = 2363
integer y = 24
integer width = 320
integer height = 76
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Opciones >>"
end type

event clicked;//if dw_curso_botones.visible then
//	dw_curso_botones.visible=false
//	this.Text = 'Opciones >>'
//else
//	dw_curso_botones.visible=true
//	this.Text = 'Opciones <<'
//end if
//

end event

type dw_curso_botones from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2706
integer y = 12
integer width = 498
integer height = 300
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_curso_botones"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean righttoleft = true
end type

event buttonclicked;call super::buttonclicked;string dir,nombre,id_curso,asis
string id_as_fecha,per,porcenta,id_asistente,por_min,id_asist

integer p_l
integer valor,i,num
string n_recibo,a_nom_de
datetime f_pago
double importe,porcent

CHOOSE CASE dwo.name
		
		CASE 'b_ampliacion'
		i_curso_ampliacion=true		
		//Se  cogen los datos que quieren q se quieren copiar.
		i_id_curso_ampliacion=dw_1.GetItemString(dw_1.GetRow(),'id_curso_interno')
		i_titulo_curso=dw_1.GetItemString(dw_1.GetRow(),'nombre')
		i_titulo_curso=i_titulo_curso+'_AMPLIACION'+'_'+string(idw_cursos_form_ampliacion.Rowcount())
		i_tipo_convocatoria=dw_1.GetItemString(dw_1.GetRow(),'tipo_convocatoria')
		i_subtipo_convocatoria=dw_1.GetItemString(dw_1.GetRow(),'subtipo_convocatoria')
		i_anyo=dw_1.GetItemString(dw_1.GetRow(),'anyo')
		i_codigo=dw_1.GetItemString(dw_1.GetRow(),'codigo')
		i_domicilio=dw_1.GetItemString(dw_1.GetRow(),'domicilio')
		i_cod_pob=dw_1.GetItemString(dw_1.GetRow(),'cod_pob')
		i_cp=dw_1.GetItemString(dw_1.GetRow(),'cp')
		i_provincia=dw_1.GetItemString(dw_1.GetRow(),'provincia')
		i_observaciones=dw_1.GetItemString(dw_1.GetRow(),'t_observaciones')
		i_cod_delegacion=dw_1.GetItemString(dw_1.GetRow(),'cod_delegacion')
		Parent.TriggerEvent("csd_nuevo")	

		
	CASE 'b_logo_org'
		// MODIFICADO RICARDO 04-03-02
		n_cst_filesrvwin32 cambia_directorio
		string directorio
		cambia_directorio = create n_cst_filesrvwin32
		directorio = cambia_directorio.of_getcurrentdirectory()
		// FIN MODIFICADO RICARDO 04-03-02		
		
		valor=GetFileOpenName("Seleccione el Logo del Organizador",dir,nombre,"BMP", &
		+ "BitMap (*.BMP),*.BMP," &
		+ "GIF (*.GIF),*.GIF," &
		+ "JPEG (*.JPEG),*.JPEG")
		if valor=1 then
			dw_1.SetItem(dw_1.GetRow(),'logo_org',dir)
		end if
		
		// MODIFICADO RICARDO 04-03-02
		// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
		cambia_directorio.of_changedirectory(directorio)
		destroy cambia_directorio
		// FIN MODIFICADO RICARDO 04-03-02
			
	CASE 'b_logo_emp'
		// MODIFICADO RICARDO 04-03-02
		cambia_directorio = create n_cst_filesrvwin32
		directorio = cambia_directorio.of_getcurrentdirectory()
		// FIN MODIFICADO RICARDO 04-03-02
		
		valor=GetFileOpenName("Seleccione el Logo del ICAV",dir,nombre,"BMP", &
				+ "BitMap (*.BMP),*.BMP," &
				+ "GIF (*.GIF),*.GIF," &
				+ "JPEG (*.JPEG),*.JPEG")
		if valor=1 then
			dw_1.SetItem(dw_1.GetRow(),'logo_icav',dir)
		end if
		// MODIFICADO RICARDO 04-03-02
		// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
		cambia_directorio.of_changedirectory(directorio)
		destroy cambia_directorio
		// FIN MODIFICADO RICARDO 04-03-02
		
	CASE 'b_impri_diplo'
		id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
		porcent=dw_1.GetItemNumber(dw_1.GetRow(),'porcentaje_minimo')
			ds_diplomas=CREATE datastore
			ds_diplomas.dataobject='ds_cursos_diplomas'
			ds_diplomas.SetTransObject(SQLCA)
			ds_diplomas.retrieve(id_curso,porcent)
			
			num=ds_diplomas.RowCount()
			for i=1 to num
				dw_diplomas.reset()
				asis=ds_diplomas.GetItemString(i,'id_asistente')
				dw_diplomas.SetItem(1,'id_asistente',asis)
				dw_diplomas.object.p_1.FileName=dw_1.GetItemString(dw_1.GetRow(),'logo_icav')
				dw_diplomas.object.p_2.FileName=dw_1.GetItemString(dw_1.GetRow(),'logo_org')
				dw_diplomas.SetItem(1,'id_curso',id_curso)
				dw_diplomas.retrieve(asis)
				//dw_diplomas.visible=true
				dw_diplomas.print()
			next
			
	CASE 'b_insc_asis'
		//dw_1.update()
		idw_cursos_form_espera.update()
		g_id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
		g_n_plazas=dw_1.GetItemNumber(dw_1.GetRow(),'n_plazas')
		//n_lista_espera
		dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())
		g_n_lista_espera=dw_1.GetItemNumber(dw_1.GetRow(),'n_lista_espera')
		//n_plazas_libres
		p_l=g_n_plazas - idw_cursos_form_asistentes.RowCount()
		dw_1.SetItem(dw_1.GetRow(),'n_plazas_libres',p_l)
		g_n_plazas_libres=dw_1.GetItemNumber(dw_1.GetRow(),'n_plazas_libres')
		
		//COGEMOS EL VALOR DEL IMPORTE DEL CURSO EN CASO QUE SEA UN CURSO.
		g_importe_col=dw_1.GetItemNumber(dw_1.GetRow(),'importe_col')
		g_importe_ncol=dw_1.GetItemNumber(dw_1.GetRow(),'importe_ncol')
		
		//ABRIR VENTANA DE ALTA ASISTENTES
		g_boton=true
		message.stringparm="w_asistentes_detalle"
		w_aplic_frame.postevent("csd_asistentesdetalle")
		
	CASE 'b_import_list_asist'
		dw_1.update()
		idw_cursos_form_espera.update()
		g_id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
		g_n_plazas=dw_1.GetItemNumber(dw_1.GetRow(),'n_plazas')
		
		//n_lista_espera
		dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())
		g_n_lista_espera=dw_1.GetItemNumber(dw_1.GetRow(),'n_lista_espera')
		
		//n_plazas_libres
		p_l=g_n_plazas - idw_cursos_form_asistentes.RowCount()
		dw_1.SetItem(dw_1.GetRow(),'n_plazas_libres',p_l)
		g_n_plazas_libres=dw_1.GetItemNumber(dw_1.GetRow(),'n_plazas_libres')
		
		//SE ABRE LA VENTANA DE DETALLE
			open(w_bancaja_detalle)
			idw_cursos_form_asistentes.retrieve(g_id_curso)
			if g_n_lista_espera>0 then
				idw_cursos_form_espera.retrieve(g_id_curso)
			end if
		//	Actualizar el contador de plazas libres
			p_l=g_n_plazas - idw_cursos_form_asistentes.RowCount()
			dw_1.SetItem(dw_1.GetRow(),'n_plazas_libres',p_l)
		
		//Actualizar el contador de lista de espera
			dw_1.SetItem(dw_1.GetRow(),'n_lista_espera',idw_cursos_form_espera.RowCount())
	CASE 'b_impri_recib'
		id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
		
		//En ds_recibos tenemos la gente que ha sido admitida en el
		//curso y que ya ha pagado, para generar su recibo
			ds_recibos=CREATE datastore
			ds_recibos.dataobject='ds_cursos_recibos'
			ds_recibos.SetTransObject(SQLCA)
			ds_recibos.retrieve(id_curso)
			
			num=ds_recibos.RowCount()
			for i=1 to num
				dw_recibos.reset()
				dw_recibos.event pfc_addrow()
				asis=ds_recibos.GetItemString(i,'id_asistente')
				dw_recibos.retrieve(asis)
				f_pago=ds_recibos.GetItemDateTime(i,'f_pago')
				n_recibo=string(ds_recibos.GetItemString(i,'codigo')+'/'+ds_recibos.GetItemString(i,'n_recibo'))
				importe=ds_recibos.GetItemNumber(i,'importe')
				a_nom_de=ds_recibos.GetItemString(i,'a_nombre_de')
				dw_recibos.object.p_1.FileName=dw_1.GetItemString(dw_1.GetRow(),'logo_icav')
		//		dw_recibos.object.p_2.FileName=dw_1.GetItemString(dw_1.GetRow(),'logo_org')
				dw_recibos.SetItem(1,'id_asistente',asis)
				dw_recibos.SetItem(1,'id_curso',id_curso)
				dw_recibos.SetItem(1,'f_pago',f_pago)
				dw_recibos.SetItem(1,'n_recibo',n_recibo)
				dw_recibos.SetItem(1,'importe',importe)
				dw_recibos.SetItem(1,'a_nombre_de',a_nom_de)
				
		//En el curso introducimos el valor del $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX2$$ba002000$$ENDHEX$$de recibo generado
				dw_1.SetItem(dw_1.GetRow(),'ultimo_n_recibo',ds_recibos.GetItemString(i,'n_recibo'))
						
		//		dw_recibos.visible=true
				dw_recibos.print()
				dw_recibos.resetupdate()
			next
				
				
		CASE 'b_generar_asist'
			
			String diploma
			long j
			datastore ds_asistentes
			datetime fecha,f_desde,f_hasta
			
			if idw_cursos_form_fechas.rowcount()=0 then 
				messagebox(G_TITULO,'El curso no tiene fechas.')
				return
			end if
			id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
			f_desde=idw_cursos_form_fechas.GetItemDateTime(1,'fecha')
			f_hasta=idw_cursos_form_fechas.GetItemDateTime(idw_cursos_form_fechas.RowCount(),'fecha')
			
			//Si ya se ha generado el control de asistencia, se visualiza
			//sino, se genera para todos los dias del curso
			if dw_1.GetItemString(dw_1.GetRow(),'asistencia_generada')='S' then
			
				//----------------------------------------//
				//Se abrir$$HEX2$$e1002000$$ENDHEX$$la lista de ctrl de asistencia//
				//con las asistencias para este curso     //
				//----------------------------------------//
			
				g_ctrlasistencia_consulta.id_curso=id_curso
				g_ctrlasistencia_consulta.fecha_desde=f_desde
				g_ctrlasistencia_consulta.fecha_hasta=f_hasta
				
				message.stringparm = "w_ctrlasistencia_lista"
				w_aplic_frame.postevent("csd_ctrlasistencialista")
		
			
			else
					
					ds_asistentes=CREATE datastore
					ds_asistentes.dataobject='ds_formacion_asistentes'
					ds_asistentes.SetTransObject(SQLCA)
					ds_asistentes.retrieve(id_curso)
					
							
					num=ds_asistentes.rowcount()
				
				
				
					if num=0 then
						messagebox(G_TITULO,'No hay matriculados en este curso.')
					else
					
					for i=1 to idw_cursos_form_fechas.rowcount()
						
						id_as_fecha=f_siguiente_numero('FORMACION_ASIS_FECHA',10)
						fecha=idw_cursos_form_fechas.GetItemDateTime(i,'fecha')
						//comentamos esta linea ya q en la tabla formacion_asist_fecha no hay periodo
						//per=idw_cursos_form_fechas.GetItemString(i,'periodo')
						
//						INSERT INTO formacion_asist_fecha (id_asistencia_fecha,id_curso,fecha,periodo) 
//						VALUES (:id_as_fecha,:id_curso,:fecha,:per);
//						
						INSERT INTO formacion_asist_fecha (id_asistencia_fecha,id_curso,fecha) 
						VALUES (:id_as_fecha,:id_curso,:fecha);
					
						
						IF SQLCA.SQLCode = -1 THEN 
							rollback;
							MessageBox("SQL error 1", SQLCA.SQLErrText)
						ELSE
							commit;
						END IF
						
						for j=1 to num
						
							id_asist=f_siguiente_numero('FORMACION_ASIS_PERS',10)
							id_asistente=ds_asistentes.GetItemString(j,'id_asistente')
						
							SELECT porcentaje_asistencia
							INTO :porcenta
							FROM formacion_asistentes
							WHERE id_asistente=:id_asistente;
							
							SELECT porcentaje_minimo
							INTO :por_min
							FROM formacion_cursos
							WHERE id_curso=:id_curso;
							
							if porcenta>=por_min then
								diploma='S'
							else
								diploma='N'
							end if
	
						// No hay diploma en la tabla formacion_ctrl_asistencia
	
//							INSERT INTO formacion_ctrl_asistencia(id_asistencia,id_asistente,id_curso,asiste,id_asistencia_fecha,diploma)
//							VALUES (:id_asist,:id_asistente,:id_curso,'S',:id_as_fecha,:diploma);
//							

							
							INSERT INTO formacion_ctrl_asistencia(id_asistencia,id_asistente,id_curso,asiste,id_asistencia_fecha)
							VALUES (:id_asist,:id_asistente,:id_curso,'S',:id_as_fecha);
							


							IF SQLCA.SQLCode = -1 THEN 
				
								MessageBox("SQL error", SQLCA.SQLErrText)
							ELSE
								commit;
							END IF
						
						next
						
						
					next
					
				end if
			
				MESSAGEBOX(G_TITULO,"Se han generado las listas de asistencia.")
				
				dw_1.SetItem(dw_1.GetRow(),'asistencia_generada','S')
				dw_1.update()
			end if
				
END CHOOSE
		
end event

type dw_enc from u_dw within w_cursos_form_detalle
boolean visible = false
integer x = 2921
integer y = 588
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_cursos_encuesta_murcia"
end type

