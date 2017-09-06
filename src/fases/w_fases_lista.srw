HA$PBExportHeader$w_fases_lista.srw
forward
global type w_fases_lista from w_lista
end type
type dw_fases_preasignadas from datawindow within w_fases_lista
end type
type dw_documentos from datawindow within w_fases_lista
end type
type cb_1 from commandbutton within w_fases_lista
end type
type dw_fases_lista_colegiados from u_dw within w_fases_lista
end type
type dw_fases_lista_promotores from u_dw within w_fases_lista
end type
type dw_fases_estadistica_ventana_lista from u_dw within w_fases_lista
end type
type dw_fases_minutas from u_dw within w_fases_lista
end type
type cb_borrar from commandbutton within w_fases_lista
end type
type dw_fases_observaciones from u_dw within w_fases_lista
end type
end forward

global type w_fases_lista from w_lista
integer width = 3671
integer height = 2072
string title = "Lista Previa de Contratos"
string menuname = "m_lista_fases"
event csd_preasignar_numero ( st_fases_consulta datos_fase )
event csd_preasignar_numero_fase ( st_fases_consulta datos_fase )
event csd_cambiar_registro ( )
event csd_visared ( )
event csd_borrar_fase ( )
event csd_importar_documentos ( st_fases_consulta datos_fase )
dw_fases_preasignadas dw_fases_preasignadas
dw_documentos dw_documentos
cb_1 cb_1
dw_fases_lista_colegiados dw_fases_lista_colegiados
dw_fases_lista_promotores dw_fases_lista_promotores
dw_fases_estadistica_ventana_lista dw_fases_estadistica_ventana_lista
dw_fases_minutas dw_fases_minutas
cb_borrar cb_borrar
dw_fases_observaciones dw_fases_observaciones
end type
global w_fases_lista w_fases_lista

type variables
boolean i_entrar,i_primera_vez=true
string i_sql_fijo, iid_colegiado,iid_fase
end variables

event csd_preasignar_numero(st_fases_consulta datos_fase);st_fases_consulta datos

if isnull(datos_fase)  then	
	g_fase_visared.opcion_importacion = 'N'
	datos.opcion_importacion='E' // Cambia la opcion de importacion
	datos_fase = datos
end if

OpenWithParm(w_fases_creacion_fases,datos_fase)


end event

event csd_preasignar_numero_fase(st_fases_consulta datos_fase);string id_expedi 
st_fases_consulta fases

if isnull(datos_fase) then 
	if dw_lista.rowcount()=0 then return
	datos_fase = fases
	g_fase_visared.opcion_importacion = 'N'
	datos_fase.opcion_importacion='F' // Cambia la opcion de importacion
	if g_dw_lista.RowCount()=0 and datos_fase.opcion_importacion='F' then
		MessageBox(g_titulo,g_idioma.of_getmsg('fases.entrada_lista','No existe ninguna entrada en la lista. Para preasignar un n$$HEX2$$ba002000$$ENDHEX$$de registro, es preciso partir de un expediente abierto.'))
		return
	end if
	datos_fase.id_expedi = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'fases_id_expedi')
end if
	

OpenWithParm(w_fases_creacion_fases,datos_fase)


end event

event csd_cambiar_registro;string id_fase
if dw_lista.RowCount() <= 0 then return

id_fase = dw_lista.GetItemString(dw_lista.GetRow(),'id_fase')

OpenWithParm(w_fases_cambio_registro,id_fase)
this.triggerevent ('csd_actualiza_listas')
end event

event csd_visared();//Visared

//Opensheet(w_importacion_expedientes_sheet,w_aplic_frame,0,Original!)
Opensheet(w_eimporta_detalle,w_aplic_frame,0,Original!)
g_visared_activo = true

do while g_visared_activo = true
	yield()
loop

if g_datos_fase.id_expedi = '-1' then return
g_fase_visared.opcion_importacion = 'S'

choose case g_datos_fase.opcion_importacion
	case 'F'  //Tenemos que preasignar una fase a un Expediente existente
		this.Event csd_preasignar_numero_fase(g_datos_fase)
	case 'E' //Tenemos que Crear un Expediente y una Fase...
		this.Event csd_preasignar_numero(g_datos_fase)
	case 'I' // Documentos
		this.Event csd_importar_documentos(g_datos_fase)
end choose

//st_fases_consulta datos_fase
//
//Open(w_importacion_expedientes)
//datos_fase= Message.PowerObjectParm
//if not(isvalid(datos_fase)) then return
//if isnull(datos_fase) then return
//if datos_fase.id_expedi = '-1' then return
//
//choose case datos_fase.opcion_importacion
//	case 'F'  //Tenemos que preasignar una fase a un Expediente existente
//		this.Event csd_preasignar_numero_fase(datos_fase)
//	case 'E' //Tenemos que Crear un Expediente y una Fase...
//		this.Event csd_preasignar_numero(datos_fase)
//	case 'I' // Documentos
//		this.Event csd_importar_documentos(datos_fase)
//end choose

end event

event csd_borrar_fase;st_control_eventos c_evento


//Llamamos al control de eventos
c_evento.evento = 'BORRAR_FASE'
c_evento.dw = dw_lista
if f_control_eventos(c_evento)=-1 then return

end event

event csd_importar_documentos(st_fases_consulta datos_fase);st_fases_consulta datos

if isnull(datos_fase)  then	
	g_fase_visared.opcion_importacion = 'N'
	datos.opcion_importacion='I' // Cambia la opcion de importacion
	datos_fase = datos
end if

OpenWithParm(w_fases_creacion_fases,datos_fase)

end event

event activate;call super::activate;g_dw_lista  = dw_lista 
g_w_lista   = g_lista_fases
g_w_detalle = g_detalle_fases
g_lista     = 'w_fases_lista'
g_detalle   = 'w_fases_detalle'

dw_lista.SetRedraw(true)
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
open(w_fases_consulta)
if Message.DoubleParm = -1 then return
//messagebox(g_titulo,string(Message.DoubleParm))
if Message.DoubleParm = 1 then dw_lista.Event csd_retrieve()

end event

on w_fases_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_lista_fases" then this.MenuID = create m_lista_fases
this.dw_fases_preasignadas=create dw_fases_preasignadas
this.dw_documentos=create dw_documentos
this.cb_1=create cb_1
this.dw_fases_lista_colegiados=create dw_fases_lista_colegiados
this.dw_fases_lista_promotores=create dw_fases_lista_promotores
this.dw_fases_estadistica_ventana_lista=create dw_fases_estadistica_ventana_lista
this.dw_fases_minutas=create dw_fases_minutas
this.cb_borrar=create cb_borrar
this.dw_fases_observaciones=create dw_fases_observaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fases_preasignadas
this.Control[iCurrent+2]=this.dw_documentos
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_fases_lista_colegiados
this.Control[iCurrent+5]=this.dw_fases_lista_promotores
this.Control[iCurrent+6]=this.dw_fases_estadistica_ventana_lista
this.Control[iCurrent+7]=this.dw_fases_minutas
this.Control[iCurrent+8]=this.cb_borrar
this.Control[iCurrent+9]=this.dw_fases_observaciones
end on

on w_fases_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fases_preasignadas)
destroy(this.dw_documentos)
destroy(this.cb_1)
destroy(this.dw_fases_lista_colegiados)
destroy(this.dw_fases_lista_promotores)
destroy(this.dw_fases_estadistica_ventana_lista)
destroy(this.dw_fases_minutas)
destroy(this.cb_borrar)
destroy(this.dw_fases_observaciones)
end on

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return

//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_fases_consulta.id_fase = dw_lista.getitemstring(dw_lista.getrow(),'id_fase')
g_fase_visared.opcion_importacion = 'N'
message.stringparm = "w_fases_detalle"
SetPointer(Hourglass!)

dw_lista.SetRedraw(false)

w_aplic_frame.postevent("csd_fasesdetalle")

end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana de listados
open(w_fases_listados)
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_fases = dw_lista



end event

event open;call super::open;This.Post Event pfc_postopen()

//dw_fases_lista_colegiados.SetTransObject(SQLCA)
//dw_fases_lista_promotores.SetTransObject(SQLCA)
dw_fases_preasignadas.SetTransObject(SQLCA)
dw_documentos.SetTransObject(SQLCA)
dw_fases_minutas.SetTransObject(SQLCA)
//dw_fases_observaciones.SetTransObject(SQLCA)

i_sql_original = dw_lista.Describe("Datawindow.Table.Select")
of_SetResize (true)
inv_resize.of_Register (st_1, "FixedtoBottom")
inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_consulta, "FixedtoBottom")
inv_resize.of_Register (cb_detalle, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")
inv_resize.of_Register (cb_borrar, "FixedtoBottom")
inv_resize.of_register (dw_fases_lista_colegiados,"FixedtoBottom")
inv_resize.of_register (dw_fases_lista_promotores,"FixedtoBottom")
inv_resize.of_register (dw_fases_estadistica_ventana_lista,"FixedtoBottom")
inv_resize.of_register (dw_fases_minutas,"FixedtoBottom")
inv_resize.of_register (dw_fases_preasignadas,"FixedtoBottom")
inv_resize.of_register (dw_documentos,"FixedtoBottom")
inv_resize.of_register (dw_fases_observaciones,"FixedtoBottom")

// Llamamos al control de eventos con el dw_honorarios
st_control_eventos c_evento
// MODIFICADO RICARDO 2005-09-20
// Llamamos al control de eventos evento 'ABRIR_LISTA_FASES' (aunque tambien sirve para lo de caja)
c_evento.evento = 'ABRIR_LISTA_FASES'
c_evento.dw = dw_lista
if f_control_eventos(c_evento)=-1 then return
// MODIFICADO RICARDO 2005-09-20

// Se vuelve a llamar a la funci$$HEX1$$f300$$ENDHEX$$n de traducci$$HEX1$$f300$$ENDHEX$$n porque se puede haber cambiado el dw por control de eventos	
if g_usar_idioma='S' then g_idioma.of_cambia_textos_dw(dw_lista)
end event

event pfc_preclose;call super::pfc_preclose;if  g_visared_activo = true then
	messagebox(g_titulo,g_idioma.of_getmsg('fases.ventana_importacion','La ventana de importacion de Visared est$$HEX2$$e1002000$$ENDHEX$$activa, cierrela para continuar'))
	return -1
end if

return ancestorreturnvalue

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_fases_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_fases_lista
end type

type st_1 from w_lista`st_1 within w_fases_lista
integer y = 1772
integer height = 76
end type

type dw_lista from w_lista`dw_lista within w_fases_lista
event type integer csd_borrar_fase ( string n_expedi )
integer y = 0
integer width = 3602
integer height = 1020
string dataobject = "d_fases_lista"
end type

event type integer dw_lista::csd_borrar_fase(string n_expedi);//Este evento NO borra una fase, sino que la asigna a un expediente que contiene
//todas las fases que se van borrando y que no tiene validez para otra cosa...

string id_fase, id_expedi, aviso=''

if dw_lista.RowCount() <= 0 then return -1

select id_expedi into :id_expedi from expedientes where n_expedi = :n_expedi;

if f_es_vacio(id_expedi) then 
	Messagebox(g_titulo,g_idioma.of_getmsg('fases.msg_asignado_exp_eventos','No tiene asignado ning$$HEX1$$fa00$$ENDHEX$$n expediente en la tabla Control de Eventos.')+cr+&
		g_idioma.of_getmsg('fases.msg_asignado_valor_contrato','Debe asignarle valor para poder borrar contratos.'),StopSign!)
	return 1
end if

double cuantos

id_fase = dw_lista.GetItemString(dw_lista.GetRow(),'id_fase')
string id_exp
id_exp = dw_lista.GetItemString(dw_lista.GetRow(),'fases_id_expedi')

// Avisamos que el contrato tiene minutas
if dw_fases_minutas.rowcount()>0 then aviso = "Este contrato tiene avisos, "

if MessageBox(g_titulo,g_idioma.of_getmsg('fases.msg_enviar_contrato','$$HEX2$$a100a100$$ENDHEX$$ATENCI$$HEX1$$d300$$ENDHEX$$N!!  Va a proceder a enviar el contrato seleccionado a un Expediente de Borrado.')+cr+aviso+g_idioma.of_getmsg('msg_cobros.desea_continuar','$$HEX1$$bf00$$ENDHEX$$Desea continuar?'),Exclamation!,YesNo!)=2 then return 1

UPDATE fases SET id_expedi = :id_expedi, n_expedi = :n_expedi WHERE id_fase = :id_fase ;
// Esto borraba el expediente entero, no el contrato solo
//UPDATE expedientes SET n_expedi = :n_expedi WHERE id_expedi = :id_exp ;
COMMIT;

parent.TriggerEvent('csd_actualiza_listas')

return 1

end event

event dw_lista::rowfocuschanged;call super::rowfocuschanged;dw_fases_minutas.reset() // Coloco esto para que no se queden los avisos de otro Ricardo 03-10-29

if this.rowcount() = 0 then return
dw_fases_lista_colegiados.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))
dw_fases_lista_promotores.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))
dw_fases_preasignadas.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'fases_id_expedi'))
dw_fases_estadistica_ventana_lista.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))
dw_documentos.Retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))
dw_fases_observaciones.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_fase'))

iid_fase=dw_lista.getitemstring(dw_lista.getrow(),'id_fase')

//if isnull(iid_fase) then iid_fase = 'fase'
//if isnull(iid_colegiado) then iid_colegiado = 'colegiado'
//messagebox('',iid_fase + ' -- ' + iid_colegiado)
//dw_fases_minutas.retrieve(iid_fase,iid_colegiado)

end event

event dw_lista::csd_retrieve;call super::csd_retrieve;dw_fases_lista_colegiados.reset()
dw_fases_lista_promotores.reset()
dw_fases_preasignadas.Reset()
dw_fases_estadistica_ventana_lista.reset()
dw_fases_minutas.reset()
dw_documentos.Reset()
dw_lista.setfocus()
dw_fases_observaciones.reset()

//for i=1 to  this.rowcount()
//	dw_lista.selectrow(i,false)
//next
//this.selectRow(1,true)
//ST_1.text = string(this.RowCount()) + ' registros.'
//


end event

event dw_lista::retrieveend;call super::retrieveend;this.PostEvent(Rowfocuschanged!)
end event

type cb_consulta from w_lista`cb_consulta within w_fases_lista
end type

type cb_detalle from w_lista`cb_detalle within w_fases_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_fases_lista
end type

type dw_fases_preasignadas from datawindow within w_fases_lista
integer x = 23
integer y = 1572
integer width = 1806
integer height = 172
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_preasignadas_mismo_expediente"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;call super::retrieveend;call super::retrieveend;
//this.visible = (this.RowCount() > 0)


end event

event doubleclicked;if this.RowCount() < 1 then return

//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_fases_consulta.id_fase = this.getitemstring(this.getrow(),'fases_id_fase')
message.stringparm = "w_fases_detalle"
w_aplic_frame.postevent("csd_fasesdetalle")

 
end event

type dw_documentos from datawindow within w_fases_lista
integer x = 1842
integer y = 1572
integer width = 1783
integer height = 172
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_fases_documentos_lista"
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;//this.visible = (this.RowCount() > 0)
end event

type cb_1 from commandbutton within w_fases_lista
boolean visible = false
integer x = 795
integer y = 1768
integer width = 402
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "chequea"
end type

event clicked;open(w_chequea_musaat)
end event

type dw_fases_lista_colegiados from u_dw within w_fases_lista
integer x = 23
integer y = 1024
integer width = 1806
integer height = 292
integer taborder = 11
string dataobject = "d_fases_lista_colegiados"
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
end event

event retrieveend;call super::retrieveend;this.PostEvent(Rowfocuschanged!)
end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return

//iid_colegiado=this.getitemstring(dw_lista.getrow(),'id_col')
iid_colegiado=this.getitemstring(this.getrow(),'id_col')

//if isnull(iid_fase) then iid_fase = 'fase'
//if isnull(iid_colegiado) then iid_colegiado = 'colegiado'
//messagebox('',iid_fase + ' -- ' + iid_colegiado)
dw_fases_minutas.retrieve(iid_fase,iid_colegiado)
end event

event doubleclicked;call super::doubleclicked;IF row <= 0 then return
SetPointer(HourGlass!)
g_colegiados_consulta.id_colegiado = this.GetItemString(this.GetRow(), 'id_col')
Message.StringParm = "w_colegiados_detalle"
w_aplic_frame.Post Event csd_colegiadosdetalle()

end event

type dw_fases_lista_promotores from u_dw within w_fases_lista
integer x = 23
integer y = 1320
integer width = 1806
integer height = 248
integer taborder = 11
string dataobject = "d_fases_lista_promotores"
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;IF row <= 0 then return
SetPointer(HourGlass!)
g_clientes_consulta.id_cliente = this.GetItemString(this.GetRow(), 'id_cliente')
Message.StringParm = "w_clientes_detalle"
w_aplic_frame.Post Event csd_clientesdetalle()

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
end event

type dw_fases_estadistica_ventana_lista from u_dw within w_fases_lista
integer x = 1842
integer y = 1024
integer width = 1783
integer height = 248
integer taborder = 21
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_fases_estadistica_ventana_lista"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

type dw_fases_minutas from u_dw within w_fases_lista
integer x = 1842
integer y = 1276
integer width = 1783
integer height = 292
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_fases_minutas_ventana_lista"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

type cb_borrar from commandbutton within w_fases_lista
boolean visible = false
integer x = 1678
integer y = 1772
integer width = 402
integer height = 68
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " Borrar"
end type

event clicked;string id_fase, n_exp_destino, id_expedi
double cuantos

if dw_lista.RowCount() <= 0 then return

id_fase = dw_lista.GetItemString(dw_lista.GetRow(),'id_fase')

// Avisamos que el contrato tiene minutas
if dw_fases_minutas.rowcount()>0 then
	if messagebox(g_titulo, g_idioma.of_getmsg('fases.msg_contrato_borrar_con_avisos',"El contrato que va a borrar tiene avisos, $$HEX1$$bf00$$ENDHEX$$desea borrarlo?"), exclamation!, yesno!)<>1 then return
end if

//n_exp_destino = g_expediente_basura
n_exp_destino = '99-99999'
 
SELECT id_expedi  INTO :id_expedi FROM expedientes WHERE n_expedi=:n_exp_destino  ;
 
UPDATE fases SET id_expedi = :id_expedi ,n_expedi = :n_exp_destino WHERE fases.id_fase = :id_fase ;
parent.triggerevent ('csd_actualiza_listas')
end event

type dw_fases_observaciones from u_dw within w_fases_lista
integer x = 453
integer y = 1748
integer width = 3173
integer height = 128
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_fases_observaciones"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;IF row <= 0 then return

string obser
g_busqueda.titulo="Observaciones"
obser    =this.GetItemString(row, 'observaciones')
openwithparm(w_observaciones, obser)

end event

