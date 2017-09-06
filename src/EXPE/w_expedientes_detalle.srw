HA$PBExportHeader$w_expedientes_detalle.srw
forward
global type w_expedientes_detalle from w_detalle
end type
type cb_anyadir from commandbutton within w_expedientes_detalle
end type
type st_1 from statictext within w_expedientes_detalle
end type
type cb_1 from commandbutton within w_expedientes_detalle
end type
type tab_1 from tab within w_expedientes_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_fases_lista_clientes from u_dw within tabpage_1
end type
type dw_fases_lista_colegiados from u_dw within tabpage_1
end type
type dw_expedientes_fases from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_fases_lista_clientes dw_fases_lista_clientes
dw_fases_lista_colegiados dw_fases_lista_colegiados
dw_expedientes_fases dw_expedientes_fases
end type
type tabpage_2 from userobject within tab_1
end type
type dw_expedientes_documentos from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_expedientes_documentos dw_expedientes_documentos
end type
type tabpage_3 from userobject within tab_1
end type
type dw_expediente_modificacion_datos from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_expediente_modificacion_datos dw_expediente_modificacion_datos
end type
type tab_1 from tab within w_expedientes_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_expedientes_detalle from w_detalle
integer x = 64
integer width = 3607
integer height = 1992
string title = "Detalle de Expedientes"
string menuname = "m_expedientes_detalle"
event csd_recupera_otros_datos ( )
event csd_busqueda_rapida ( )
event csd_refrescar_fases ( )
event csd_anular ( )
event csd_anyadir_fase ( )
cb_anyadir cb_anyadir
st_1 st_1
cb_1 cb_1
tab_1 tab_1
end type
global w_expedientes_detalle w_expedientes_detalle

type variables
u_dw idw_expedientes_fases
u_dw idw_expedientes_documentos
u_dw idw_expedientes_modificacion_datos

boolean i_cambio
long i_tab
end variables

event csd_busqueda_rapida;dw_1.TriggerEvent("csd_retrieve")
end event

event csd_refrescar_fases;idw_expedientes_fases.retrieve(dw_1.getitemstring(1,'id_expedi'))
end event

event csd_anular;string cod_est,id_exp,fases,fase
double i

this.TriggerEvent('csd_refrescar_fases')
id_exp=dw_1.getitemstring(1,'id_expedi')

for i=1 to idw_expedientes_fases.RowCount()
	fase=idw_expedientes_fases.GetItemString(i,'fases_fase')
	cod_est = idw_expedientes_fases.GetItemString(i,'fases_estado')

	if cod_est <> '08' then
		fases= fases + fase + ' - '
	end if
next
 
if fases <> '' then
	MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n!!! Este Expediente no se puede anular debido a que contiene las siguientes fases No anuladas.' + &
		cr+cr + fases + cr+cr + 'Todas las fases deben estar anuladas antes de poder anular el Expediente.')
else
	if MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n!!! La Anulaci$$HEX1$$f300$$ENDHEX$$n de un Expediente implica que no quedar$$HEX2$$e1002000$$ENDHEX$$reflejado en futuras operaciones.' + cr + &
				'Desea Anular el Expediente?',Question!,YesNo!,2)	= 1 then
      UPDATE expedientes SET anulado = 'S' WHERE expedientes.id_expedi = :id_exp ;
		m_expedientes_detalle.m_file.m_anular.enabled=false		
		st_1.visible=true		
	end if
end if
end event

event csd_anyadir_fase();st_fases_consulta datos_fase

datos_fase.opcion_importacion='F'
datos_fase.id_expedi = dw_1.GetItemString(1,'id_expedi')
OpenWithParm(w_fases_creacion_fases, datos_fase)

end event

event activate;call super::activate;g_dw_lista  = g_dw_lista_expedientes
g_w_lista   = g_lista_expedientes
g_w_detalle = g_detalle_expedientes
g_lista     = 'w_expedientes_lista'
g_detalle   = 'w_expedientes_detalle'

end event

on w_expedientes_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_expedientes_detalle" then this.MenuID = create m_expedientes_detalle
this.cb_anyadir=create cb_anyadir
this.st_1=create st_1
this.cb_1=create cb_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_anyadir
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.tab_1
end on

on w_expedientes_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_anyadir)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.tab_1)
end on

event open;call super::open;string titulo
g_recien_grabado_modificacion_exped=TRUE

//control de seguridad para activar o desactivar boton historicos Modificacion Datos
//cb_1.enabled=false 
//if f_puedo_entrar_en_tab(g_usuario,'0000000009')=1 then
//	cb_1.enabled=True
//end if

idw_expedientes_fases              = tab_1.tabpage_1.dw_expedientes_fases
idw_expedientes_documentos         = tab_1.tabpage_2.dw_expedientes_documentos
idw_expedientes_modificacion_datos = tab_1.tabpage_3.dw_expediente_modificacion_datos

//A partir de este momento, cualquier referencia a las dw esclavas dentro de la 
//ventana se hara por idw_esclava1 o idw_esclava2
//dw_1.of_setlinkage(TRUE)  Esto se hace en la Ventana Padre

f_enlaza_dw(dw_1, idw_expedientes_fases, 'id_expedi', 'id_expedi')
f_enlaza_dw(dw_1, idw_expedientes_documentos, 'id_expedi', 'id_expedi')

//A partir de aqui se pueden introducir las funciones de cambios de tama#o y
//posicion de los controles de la ventana.

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright")
inv_resize.of_register (tab_1.tabpage_2, "scaletoright&bottom")
//inv_resize.of_register (cb_anyadir, "Fixedtobottom")

//inv_resize.of_register (tab_1.tabpage_1.dw_expedientes_fases, "scaletoright")
inv_resize.of_register (tab_1.tabpage_2.dw_expedientes_documentos, "scaletoright&bottom")

end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	st_control_eventos c_evento
	string exp
	
	//Variables de control de grabacion de modificacion
	g_recien_grabado_modificacion_exped=TRUE
	
	//Introducimos en el campo clave el valor obtenido desde el contador.
	dw_1.SetItem(dw_1.GetRow(),'id_expedi',f_siguiente_numero('EXPEDIENTES',10))
	
	c_evento.evento = 'NUMERO_EXP'
	f_control_eventos(c_evento)		
	exp  			= f_numera_expediente(c_evento.param1)// Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
	
	dw_1.SetItem(dw_1.GetRow(),'n_expedi',exp)
	
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	// Hay que vaciar los dw de lista del primer tab
	tab_1.tabpage_1.dw_fases_lista_colegiados.reset()
	tab_1.tabpage_1.dw_fases_lista_clientes.reset()
	
	//Inicializacion de campos
	Dw_1.setitem(1, 'f_inicio', datetime(Today()) )
	cb_anyadir.enabled=false
end if

return AncestorReturnValue

end event

event csd_anterior;call super::csd_anterior;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_expedientes_consulta.id_expediente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_expedi')
	dw_1.event csd_retrieve()
end if

end event

event csd_siguiente;call super::csd_siguiente;if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then
	g_expedientes_consulta.id_expediente = g_dw_lista.getitemstring(g_dw_lista.getrow(), 'id_expedi')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	g_expedientes_consulta.id_expediente = g_dw_lista.getitemstring(1,"id_expedi")
	
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;//Se comprueba que la ventana "lista previa" del modulo esta abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_expedientes_consulta.id_expediente = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_expedi")
	
	dw_1.event csd_retrieve()
end if
end event

event type integer pfc_preupdate();//control de permisos
if f_puedo_escribir(g_usuario, '0000000014')= -1 then return -1
string mensaje='', idexpedi, anulado

idexpedi = dw_1.GetItemString(1,'id_expedi')
anulado = 'N'
select anulado into :anulado from expedientes where id_expedi = :idexpedi;
if anulado = 'S' then 
	mensaje='No se grabar$$HEX2$$e1002000$$ENDHEX$$ninguna modificaci$$HEX1$$f300$$ENDHEX$$n ya que el expediente est$$HEX2$$e1002000$$ENDHEX$$ANULADO.'	
	dw_1.ResetUpdate()
	idw_expedientes_fases.ResetUpdate()
	idw_expedientes_documentos.ResetUpdate()
end if	

//Validaciones del datawindows principal (dw_1)
//---------------------------------------------
mensaje=mensaje + f_valida(dw_1,'n_expedi','NOVACIO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de Expediente.')
mensaje=mensaje + f_valida(dw_1,'f_inicio','NONULO','Debe especificar un valor en el campo Fecha de inicio.')
mensaje=mensaje + f_valida(dw_1,'titulo','NOVACIO','Debe especificar un valor en el campo Titulo.')
//mensaje=mensaje + f_valida(dw_1,'tipo_trabajo','NOVACIO','Debe especificar un valor en el campo Tipo de Trabajo.')
//mensaje=mensaje + f_valida(dw_1,'trabajo','NOVACIO','Debe especificar un valor en el campo Trabajo.')
mensaje=mensaje + f_valida(dw_1,'tipo_via_emplazamiento','NOVACIO','Debe especificar un valor en el campo Emplazamiento Tipo de Via.')
mensaje=mensaje + f_valida(dw_1,'emplazamiento','NOVACIO','Debe especificar un valor en el campo Emplazamiento.')
mensaje=mensaje + f_valida(dw_1,'n_calle','NOVACIO','Debe especificar un valor en el campo N$$HEX2$$ba002000$$ENDHEX$$de calle.')
mensaje=mensaje + f_valida(dw_1,'poblacion','NOVACIO','Debe especificar un valor en el campo Poblaci$$HEX1$$f300$$ENDHEX$$n.')


//Validaciones de la tabla auxiliar documentos
//--------------------------------------------
mensaje=mensaje + f_valida(idw_expedientes_documentos,'f_entrada','NONULO','Debe especificar un valor en el campo fecha de entrada.')
mensaje=mensaje + f_valida(idw_expedientes_documentos,'titulo','NOVACIO','Debe especificar un valor en el campo titulo.')
mensaje=mensaje + f_valida(idw_expedientes_documentos,'tipo','NOVACIO','Debe especificar un valor en el campo tipo.')


//fin 
int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if


return retorno

end event

event pfc_postupdate;call super::pfc_postupdate;g_recien_grabado_modificacion_exped=TRUE
return 1
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_fases = idw_expedientes_fases
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_expedientes_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_expedientes_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_expedientes_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_expedientes_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_expedientes_detalle
end type

type cb_ant from w_detalle`cb_ant within w_expedientes_detalle
end type

type cb_sig from w_detalle`cb_sig within w_expedientes_detalle
end type

type dw_1 from w_detalle`dw_1 within w_expedientes_detalle
event type long csd_borrar_codigo ( )
event csd_modificacion_datos ( string id_expediente,  u_dw dw,  string nombre_dw,  string campo,  long row )
integer y = 0
integer width = 3543
integer height = 536
string dataobject = "d_expedientes_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_borrar_codigo;dw_1.setitem(1,message.stringparm,'')
setcolumn(i_tab)
return 1
end event

event dw_1::csd_modificacion_datos;// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  expediente, modificacion, data, tipo
integer fila

// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

data=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		data=dw.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		data=string(dw.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
      data=string(dw.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(data) then data=''   // return

//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion_exped=TRUE then
	idw_expedientes_modificacion_datos.triggerevent("pfc_addrow")
end if

fila        =idw_expedientes_modificacion_datos.rowcount()
expediente  =id_expediente
modificacion=idw_expedientes_modificacion_datos.getitemstring(fila,'modificacion')

// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '

// Se actualiza la dw de modificaciones oculta
idw_expedientes_modificacion_datos.setitem(fila,'id_colegiado',expediente)
idw_expedientes_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_expedientes_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_expedientes_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion_exped=FALSE
end event

event dw_1::csd_retrieve;if g_expedientes_consulta.id_expediente = '' or isnull(g_expedientes_consulta.id_expediente) then return
int    retorno
double i
retorno = parent.event closequery()
if retorno = 1 then return

this.retrieve(g_expedientes_consulta.id_expediente)
g_expedientes_consulta.id_expediente=''

if dw_1.getitemstring(1,'anulado')='S' then
	st_1.visible=true
	cb_anyadir.enabled=false

else
	st_1.visible=false
	cb_anyadir.enabled=True

end if
end event

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event dw_1::itemchanged;// Verifica si se ha modificado la Situacion
//------------------------------------------
LONG   retonno
int    fila 
string cod
boolean sw
retonno = 0

// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_expedi'), this, 'DETALLE ', dwo.name, row)

i_cambio=true
cod='***'
sw=false
i_tab=getcolumn()
choose case dwo.name
	case 'tipo_trabajo'
		SELECT tipos_trabajos.c_t_trabajo INTO :cod FROM tipos_trabajos WHERE tipos_trabajos.c_t_trabajo = :data;
		sw=true
	case 'trabajo'	
		SELECT trabajos.c_trabajo INTO :cod FROM trabajos WHERE trabajos.c_trabajo = :data ;
		sw=true
	case 'tipo_via_emplazamiento'		
		data=upper(data)
		SELECT tipos_via.cod_tipo_via INTO :cod FROM tipos_via WHERE tipos_via.cod_tipo_via = :data ;
		sw=true
	case 'poblacion'
		SELECT poblaciones.cod_pob INTO :cod FROM poblaciones WHERE poblaciones.cod_pob = :data ;
		sw=true
end choose

// colocado en comentario por JD, ocurria en cualquier campo
if cod='***' and sw=true then
	MessageBox(g_titulo,'Este c$$HEX1$$f300$$ENDHEX$$digo no existe.')
	message.stringparm=string(dwo.name)
	postevent ("csd_borrar_codigo")
end if

RETURN retonno

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser
g_busqueda.solo_despliega_texto=False

end event

event dw_1::itemerror;call super::itemerror;return 1
end event

event dw_1::retrieveend;call super::retrieveend;SetPointer(Hourglass!)

// Comprobaci$$HEX1$$f300$$ENDHEX$$n de incidencias de Exp.
if f_comprueba_incidencias(3,dw_1) then
	dw_1.object.cb_incidencias.Background.color=f_color_rojo()
else
	dw_1.object.cb_incidencias.Background.color=f_color_gris_claro()
end if	

f_resetupdate_dws(getactivesheet())

SetPointer(Arrow!)
end event

event dw_1::buttonclicked;string pob
Choose case dwo.name
	case 'cb_incidencias'
		g_incidencias.id=dw_1.getitemstring(1,'id_expedi')
		open(w_incidencias_exp)
		if message.stringparm='S' then
			dw_1.object.cb_incidencias.Background.color=f_color_rojo()
		else
			dw_1.object.cb_incidencias.Background.color=f_color_gris_claro()
		end if	
	case 'cb_poblacion'			
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)
End Choose
end event

type cb_anyadir from commandbutton within w_expedientes_detalle
boolean visible = false
integer x = 1285
integer y = 596
integer width = 343
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Fase"
end type

event clicked;//integer retorno
//
//retorno = parent.event closequery()
//if retorno = 1 then return
//
//
//gb_nuevo=TRUE
//g_fases_consulta.id_expedi = dw_1.GetITemString(1,'id_expedi')
//opensheet(g_detalle_fases, "w_fases_detalle", w_aplic_frame, 0, original!)

end event

type st_1 from statictext within w_expedientes_detalle
boolean visible = false
integer x = 1691
integer y = 544
integer width = 827
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "ANULADO"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_expedientes_detalle
integer x = 2894
integer y = 540
integer width = 608
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Modificaciones"
end type

event clicked;openwithparm(w_historico, dw_1.getitemstring(1,'id_expedi')+"02")
end event

type tab_1 from tab within w_expedientes_detalle
integer x = 32
integer y = 580
integer width = 3543
integer height = 1212
integer taborder = 70
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
integer width = 3506
integer height = 1084
long backcolor = 79741120
string text = "Contratos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Continue!"
long picturemaskcolor = 536870912
dw_fases_lista_clientes dw_fases_lista_clientes
dw_fases_lista_colegiados dw_fases_lista_colegiados
dw_expedientes_fases dw_expedientes_fases
end type

on tabpage_1.create
this.dw_fases_lista_clientes=create dw_fases_lista_clientes
this.dw_fases_lista_colegiados=create dw_fases_lista_colegiados
this.dw_expedientes_fases=create dw_expedientes_fases
this.Control[]={this.dw_fases_lista_clientes,&
this.dw_fases_lista_colegiados,&
this.dw_expedientes_fases}
end on

on tabpage_1.destroy
destroy(this.dw_fases_lista_clientes)
destroy(this.dw_fases_lista_colegiados)
destroy(this.dw_expedientes_fases)
end on

type dw_fases_lista_clientes from u_dw within tabpage_1
integer x = 1765
integer y = 736
integer width = 1733
integer height = 336
integer taborder = 11
string dataobject = "d_fases_lista_promotores"
boolean ib_rmbmenu = false
end type

type dw_fases_lista_colegiados from u_dw within tabpage_1
integer x = 5
integer y = 736
integer width = 1755
integer height = 332
integer taborder = 11
string dataobject = "d_fases_lista_colegiados"
boolean ib_rmbmenu = false
end type

type dw_expedientes_fases from u_dw within tabpage_1
event csd_actualiza_dom_pob_activa ( long row )
event csd_actualiza_dom_pob_fiscal_activa ( long row )
integer x = 9
integer y = 8
integer width = 3483
integer height = 708
integer taborder = 11
string dataobject = "d_expedientes_fases"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;if this.rowcount() > 0  and row <> 0 then 
   Message.Stringparm = 'w_fases_detalle'
   g_fases_consulta.id_fase = this.GetItemString(row, 'id_fase' )
   w_aplic_frame.TriggerEvent("csd_fasesdetalle")
end if

end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_expedi'), this, Upper(Parent.text), dwo.name, row)
end event

event retrieveend;call super::retrieveend;if this.rowcount()=0 then 
   dw_fases_lista_colegiados.reset()
   dw_fases_lista_clientes.reset()
end if	
if this.rowcount()>0 then 
	dw_fases_lista_colegiados.SetTransObject(SQLCA)
	dw_fases_lista_clientes.SetTransObject(SQLCA)
	dw_fases_lista_colegiados.retrieve(this.getitemstring(this.getrow(),'id_fase'))	
	dw_fases_lista_clientes.retrieve(this.getitemstring(this.getrow(),'id_fase'))	
end if

end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() > 0 then
	dw_fases_lista_colegiados.SetTransObject(SQLCA)
	dw_fases_lista_colegiados.retrieve(this.getitemstring(this.getrow(),'id_fase'))

	dw_fases_lista_clientes.SetTransObject(SQLCA)
	dw_fases_lista_clientes.retrieve(this.getitemstring(this.getrow(),'id_fase'))
end if
end event

event constructor;call super::constructor;of_setRowSelect(TRUE)

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3506
integer height = 1084
long backcolor = 79741120
string text = "Documentos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom050!"
long picturemaskcolor = 536870912
dw_expedientes_documentos dw_expedientes_documentos
end type

on tabpage_2.create
this.dw_expedientes_documentos=create dw_expedientes_documentos
this.Control[]={this.dw_expedientes_documentos}
end on

on tabpage_2.destroy
destroy(this.dw_expedientes_documentos)
end on

type dw_expedientes_documentos from u_dw within tabpage_2
integer x = 9
integer y = 8
integer width = 3493
integer height = 1068
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_expedientes_documentos"
end type

event buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de expedientes"
g_busqueda.dw="d_expedientes_fases"
//g_busqueda.dw="d_lista_busqueda_expedientes"

// id_persona=f_busqueda_expedientes()
// this.setitem(this.getrow(),'id_col_per',id_persona)
	
end event

event itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'id_expedi'), this, Upper(Parent.text), dwo.name, row)

choose case this.getcolumnname()
	case 'n_col'
		
end choose
end event

event pfc_addrow;call super::pfc_addrow;datetime fecha

//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_docu', f_siguiente_numero('EXPEDIENTES_DOC', 10))
this.setitem(this.getrow(), 'id_expedi', dw_1.getitemstring(1,'id_expedi'))
//donde "n" es un entero que indica la longitud en caracteres del contador

//Insertamos la fecha del $$HEX1$$fa00$$ENDHEX$$ltimo registro
select valor_fecha into :fecha from datos_a_controlar where nombre='fecha_ult_registro';
this.setitem(this.getRow(),'f_entrada',fecha)

return 1
end event

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.getrow(), 'id_docu', f_siguiente_numero('EXPEDIENTES_DOC', 10))
this.setitem(this.getrow(), 'id_expedi', dw_1.getitemstring(1,'id_expedi'))
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

//Se filtra el tipo de documento
DataWindowChild cod_tipo
dw_expedientes_documentos.GetChild('tipo', cod_tipo)	
cod_tipo.setfilter(' expedi = "S" ')
cod_tipo.filter()

end event

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3506
integer height = 1084
long backcolor = 79741120
string text = "Historicos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_expediente_modificacion_datos dw_expediente_modificacion_datos
end type

on tabpage_3.create
this.dw_expediente_modificacion_datos=create dw_expediente_modificacion_datos
this.Control[]={this.dw_expediente_modificacion_datos}
end on

on tabpage_3.destroy
destroy(this.dw_expediente_modificacion_datos)
end on

type dw_expediente_modificacion_datos from u_dw within tabpage_3
integer x = 64
integer y = 64
integer width = 3342
integer height = 796
integer taborder = 11
string dataobject = "d_historico"
end type

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_expedi') )
this.setitem(this.rowcount(), 'tipo_modulo', '02')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', dw_1.GetItemString(1,'id_expedi') )
this.setitem(this.rowcount(), 'tipo_modulo', '02')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

