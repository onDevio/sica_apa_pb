HA$PBExportHeader$w_mensajes_enviados.srw
forward
global type w_mensajes_enviados from w_lista
end type
end forward

global type w_mensajes_enviados from w_lista
string title = "Lista de Mensajes Enviados"
string menuname = "m_mensajes_lista"
event csd_borrar ( )
event csd_actualizar ( )
end type
global w_mensajes_enviados w_mensajes_enviados

event csd_borrar;string id_mensaje
integer res

if dw_lista.RowCount() = 0 then return
//id_mensaje=dw_lista.getitemstring(dw_lista.getrow(),'id_mensaje')
//IF not f_es_vacio(id_mensaje) THEN
//	res = MessageBox(g_titulo,"$$HEX1$$bf00$$ENDHEX$$Esta seguro de borrar este mensaje?",Exclamation!, OKCancel!)
//	IF res = 1 THEN
//		DELETE FROM t_mensaje WHERE id_mensaje = :id_mensaje;
//		dw_lista.TriggerEvent("csd_retrieve")
//	END IF
//END IF

string origen, destino, borrado_orig, borrado_dst
boolean borrar

borrar = FALSE
origen = dw_lista.getitemstring(dw_lista.getrow(),'codigo_origen')
destino = dw_lista.getitemstring(dw_lista.getrow(),'destino')

// Si el mensaje es enviado
if origen = g_usuario then

	borrado_dst =  dw_lista.getitemstring(dw_lista.getrow(),'borrado_dst')
	if borrado_dst = 'S' or destino = g_usuario then 
		borrar = TRUE
	else
		dw_lista.SetItem(dw_lista.getrow(),'borrado_orig','S')
	end if
// Si el mensaje es recibido
else

	borrado_orig =  dw_lista.getitemstring(dw_lista.getrow(),'borrado_orig')
	if borrado_orig = 'S' then 
		borrar = TRUE
	else
		dw_lista.SetItem(dw_lista.getrow(),'borrado_dst','S')			
	end if
end if

if borrar then
	// Borramos el mensaje
	dw_lista.Event pfc_deleterow()
end if
// Actualizamos los cambios
TriggerEvent("pfc_save")
// Actualizamos la ventana de lista si est$$HEX2$$e1002000$$ENDHEX$$instanciada
dw_lista.retrieve(g_usuario)

	
end event

event csd_actualizar;dw_lista.TriggerEvent('csd_retrieve')
end event

on w_mensajes_enviados.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_mensajes_lista" then this.MenuID = create m_mensajes_lista
end on

on w_mensajes_enviados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_lista.Event csd_retrieve()
end event

event csd_detalle();call super::csd_detalle;// Leemos el datos clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
if dw_lista.RowCOunt() = 0 then return
g_mensajes_consulta.id_mensaje=dw_lista.getitemstring(dw_lista.getrow(),'id_mensaje')
message.stringparm="w_mensajes"
w_aplic_frame.postevent("csd_mensajesdetalle")
end event

event activate;call super::activate;// Inicializamos las variables globales de dw_lista, ventatana de lista y ventana de detalle
g_dw_lista = g_dw_lista_mensajes
g_w_lista = g_mensajes_enviados
g_w_detalle = g_mensajes_detalle
g_lista = 'w_mensajes_enviados'
g_detalle = 'w_mensajes'  
end event

event pfc_postopen;call super::pfc_postopen;//Asignamos valor a la variable global:
g_dw_lista_mensajes=dw_lista

end event

event csd_nuevo;call super::csd_nuevo;OpenSheet(g_mensajes_detalle, g_detalle,  w_aplic_frame, 0, original!)

end event

type st_1 from w_lista`st_1 within w_mensajes_enviados
boolean bringtotop = true
end type

type dw_lista from w_lista`dw_lista within w_mensajes_enviados
integer height = 980
string dataobject = "d_mensajes_enviados_lista"
end type

event dw_lista::csd_retrieve;this.Retrieve(g_usuario)
end event

type cb_consulta from w_lista`cb_consulta within w_mensajes_enviados
end type

type cb_detalle from w_lista`cb_detalle within w_mensajes_enviados
end type

type cb_ayuda from w_lista`cb_ayuda within w_mensajes_enviados
end type

