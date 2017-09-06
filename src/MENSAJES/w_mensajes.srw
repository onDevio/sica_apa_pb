HA$PBExportHeader$w_mensajes.srw
forward
global type w_mensajes from w_detalle
end type
type dw_2 from u_dw within w_mensajes
end type
type dw_imprimir from u_dw within w_mensajes
end type
type cb_no_coleg from commandbutton within w_mensajes
end type
type dw_3 from u_dw within w_mensajes
end type
type cb_no_coleg2 from commandbutton within w_mensajes
end type
type cb_coleg from commandbutton within w_mensajes
end type
type cb_coleg2 from commandbutton within w_mensajes
end type
end forward

global type w_mensajes from w_detalle
integer width = 3877
integer height = 2044
string title = "Mesajer$$HEX1$$ed00$$ENDHEX$$a"
string menuname = "m_mensajes_detalle"
event csd_enviar ( )
event csd_responder ( )
event csd_imprimir ( )
dw_2 dw_2
dw_imprimir dw_imprimir
cb_no_coleg cb_no_coleg
dw_3 dw_3
cb_no_coleg2 cb_no_coleg2
cb_coleg cb_coleg
cb_coleg2 cb_coleg2
end type
global w_mensajes w_mensajes

event csd_enviar();//VEAMOS SI SE HAN PRODUCIDO CAMBIOS EN las dws actuales
int retorno
string destino,cod_usuario
string id_mensaje,mensaje,codigo_origen,s_o_c,asunto,leido
datetime f_lectura,fecha
integer i,j
long fila_colocado_colegiado = 0, fila_colocado_usuario = 0

// COLEGIADOS
for i=1 to dw_2.RowCount()
	if dw_2.IsSelected( i ) then
		destino=dw_2.GetItemString(i,'nombre_usuario')
		SELECT cod_usuario
		INTO :cod_usuario
		FROM t_usuario
		WHERE t_usuario.nombre_usuario= :destino;
		dw_1.SetItem(1,'destino',cod_usuario)
		fila_colocado_colegiado = i
		exit
	end if
next
// OTROS
if fila_colocado_colegiado = 0 then
	for i=1 to dw_3.RowCount()
		if dw_3.IsSelected( i ) then
			destino=dw_3.GetItemString(i,'nombre_usuario')
			SELECT cod_usuario
			INTO :cod_usuario
			FROM t_usuario
			WHERE t_usuario.nombre_usuario= :destino;
			dw_1.SetItem(1,'destino',cod_usuario)
			fila_colocado_usuario = i
			exit
		end if
	next
end if
retorno = This.trigger Event pfc_save()
if retorno <> 1 then return

// Si llegamos aqu$$HEX2$$ed002000$$ENDHEX$$es que se ha colocado alguien como destino
if fila_colocado_colegiado>0 then
	// Puede que hayan mas colegiados por meter mensajes, por lo que miramos desde el siguiente al que hemos metido hasta el final
	for j=fila_colocado_colegiado+1 to dw_2.RowCount()
		if dw_2.IsSelected( j ) then
			id_mensaje=f_siguiente_numero("MENSAJES",10)
			destino=dw_2.GetItemString(j,'nombre_usuario')
			SELECT cod_usuario
			INTO :cod_usuario
			FROM t_usuario
			WHERE t_usuario.nombre_usuario= :destino;
			mensaje=dw_1.GetItemString(1,'mensaje')
			codigo_origen=dw_1.GetItemString(1,'codigo_origen')
			asunto=dw_1.GetItemString(1,'asunto')
			s_o_c=dw_1.GetItemString(1,'s_o_c')
			fecha=dw_1.GetItemDatetime(1,'fecha')
			leido=dw_1.GetItemString(1,'leido')
			f_lectura=dw_1.GetItemDatetime(1,'f_lectura')
			
			INSERT INTO t_mensaje(id_mensaje,
											 destino,
											 mensaje,
											 codigo_origen,
											 s_o_c,
											 fecha,
											 asunto,
											 leido,
											 f_lectura,
											 borrado_orig,
											borrado_dst)
				 VALUES (:id_mensaje,
							:cod_usuario,
							:mensaje,
							:codigo_origen,
							:s_o_c,
							:fecha,
							:asunto,
							:leido,
							:f_lectura,
							'N',
							'N');
				IF sqlca.sqlcode <> 0 THEN
					messagebox("Error","Error al insertar "+ sqlca.sqlerrtext)
					ROLLBACK;
				ELSE
					COMMIT;
				END IF						
		end if
	next
end if

// Miramos los usuarios que hay. Teniendo en cuenta si habiamos seleccionado un usuario
for j=fila_colocado_usuario+1 to dw_3.RowCount()
	if dw_3.IsSelected( j ) then
		id_mensaje=f_siguiente_numero("MENSAJES",10)
		destino=dw_3.GetItemString(j,'nombre_usuario')
		SELECT cod_usuario
		INTO :cod_usuario
		FROM t_usuario
		WHERE t_usuario.nombre_usuario= :destino;
		mensaje=dw_1.GetItemString(1,'mensaje')
		codigo_origen=dw_1.GetItemString(1,'codigo_origen')
		asunto=dw_1.GetItemString(1,'asunto')
		s_o_c=dw_1.GetItemString(1,'s_o_c')
		fecha=dw_1.GetItemDatetime(1,'fecha')
		leido=dw_1.GetItemString(1,'leido')
		f_lectura=dw_1.GetItemDatetime(1,'f_lectura')
		
		INSERT INTO t_mensaje(id_mensaje,
									    destino,
									    mensaje,
									    codigo_origen,
									    s_o_c,
									    fecha,
									    asunto,
									    leido,
									    f_lectura,
									    borrado_orig,
										borrado_dst)
			 VALUES (:id_mensaje,
			 			:cod_usuario,
						:mensaje,
						:codigo_origen,
						:s_o_c,
						:fecha,
						:asunto,
						:leido,
						:f_lectura,
						'N',
						'N');
			IF sqlca.sqlcode <> 0 THEN
				messagebox("Error","Error al insertar "+ sqlca.sqlerrtext)
				ROLLBACK;
			ELSE
				COMMIT;
			END IF						
	end if
next

//dw_1.reset()
//dw_2.visible=false
if isvalid(m_mensajes_detalle) then	
	m_mensajes_detalle.m_file.m_new.m_mensajeria.m_enviar.enabled = FALSE
	m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = FALSE
	m_mensajes_detalle.m_file.m_delete.enabled = FALSE
	m_mensajes_detalle.m_file.m_print.enabled = TRUE
end if

end event

event csd_responder();string nom_usuario
integer i

g_mensajes_insercion.destino = dw_1.GetItemString(1,'codigo_origen')
g_mensajes_insercion.asunto  = dw_1.GetItemString(1,'asunto')
g_mensajes_insercion.id_mensaje = ''
This.Event csd_nuevo()

SELECT nombre_usuario INTO:nom_usuario FROM t_usuario WHERE cod_usuario = :g_mensajes_insercion.destino;


for i=1 to dw_2.RowCount() 
	if dw_2.GetItemString(i,'nombre_usuario')=nom_usuario then
		dw_2.SelectRow(i, TRUE)
	end if
next

for i=1 to dw_3.RowCount() 
	if dw_3.GetItemString(i,'nombre_usuario')=nom_usuario then
		dw_3.SelectRow(i, TRUE)
	end if
next

if isvalid(m_mensajes_detalle) then	m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = FALSE

end event

event csd_imprimir;//VEAMOS SI SE HAN PRODUCIDO CAMBIOS EN las dws actuales
int retorno
retorno = This.Event closequery()
if retorno = 1 then return

string id_mens

if dw_1.RowCOunt() = 0 then return

id_mens = dw_1.GetItemString(1,'id_mensaje')

dw_imprimir.Retrieve(id_mens)

if PrintSetup() = 1 then    dw_imprimir.Print()
end event

on w_mensajes.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_mensajes_detalle" then this.MenuID = create m_mensajes_detalle
this.dw_2=create dw_2
this.dw_imprimir=create dw_imprimir
this.cb_no_coleg=create cb_no_coleg
this.dw_3=create dw_3
this.cb_no_coleg2=create cb_no_coleg2
this.cb_coleg=create cb_coleg
this.cb_coleg2=create cb_coleg2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_imprimir
this.Control[iCurrent+3]=this.cb_no_coleg
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_no_coleg2
this.Control[iCurrent+6]=this.cb_coleg
this.Control[iCurrent+7]=this.cb_coleg2
end on

on w_mensajes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_imprimir)
destroy(this.cb_no_coleg)
destroy(this.dw_3)
destroy(this.cb_no_coleg2)
destroy(this.cb_coleg)
destroy(this.cb_coleg2)
end on

event open;call super::open;inv_resize.of_Register (dw_1, "FixedtoRight&Bottom")

end event

event pfc_preopen();dw_2.visible=false
dw_3.visible=false
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje
integer retorno=1
string destino,asunto

mensaje=''

if dw_1.getrow() <= 0 then return 1

destino=dw_1.getitemstring(dw_1.getrow(),'destino')
if isnull(destino) or destino='' then
	mensaje=mensaje+cr+'Es necesario un destino.'
end if

asunto=dw_1.getitemstring(dw_1.getrow(),'asunto')
if isnull(asunto) or asunto='' then
	mensaje=mensaje+cr+'Es necesario un asunto.'
end if

if mensaje<>'' then
	messagebox(g_titulo,mensaje,Stopsign!)
	Return -1
end if

if isnull(dw_1.GetItemDateTime(1,'fecha')) then	 	dw_1.SetItem(1,'fecha',DateTime(Today(),Now()))

return retorno
end event

event type integer csd_nuevo();call super::csd_nuevo;If AncestorReturnValue>0 then
	dw_1.SetItem(dw_1.GetRow(),'id_mensaje',f_siguiente_numero('MENSAJES',10))
	//el mensaje se inicializa a no leido
	dw_1.SetItem(dw_1.GetRow(),'leido','N')
	dw_1.setitem(dw_1.getrow(),'codigo_origen',g_usuario)
	dw_1.setitem(dw_1.getrow(),'destino',g_mensajes_insercion.destino)
	dw_1.setitem(dw_1.getrow(),'asunto',g_mensajes_insercion.asunto)
	dw_1.Object.codigo_origen.TabSequence = 0
	dw_1.Object.destino.TabSequence = 10
	dw_1.Object.asunto.TabSequence = 20
	dw_1.Object.mensaje.TabSequence = 30
	dw_1.Object.mensaje.edit.displayonly="no"
	if isvalid(m_mensajes_detalle) then
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_enviar.enabled = TRUE
		m_mensajes_detalle.m_file.m_print.enabled = TRUE
		m_mensajes_detalle.m_file.m_delete.enabled = FALSE
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = FALSE
	end if
	dw_2.visible=true
	dw_2.event csd_retrieve()
	dw_3.visible=true
	dw_3.event csd_retrieve()
	dw_1.Setfocus()
end if

Return AncestorReturnValue
end event

event csd_borrar();dw_2.visible = FALSE
dw_3.visible = FALSE
if isvalid(m_mensajes_detalle) then
	m_mensajes_detalle.m_file.m_new.m_mensajeria.m_enviar.enabled = FALSE
	m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = FALSE
	m_mensajes_detalle.m_file.m_print.enabled = FALSE
	m_mensajes_detalle.m_file.m_delete.enabled = FALSE
end if

string origen, destino, borrado_orig, borrado_dst
boolean borrar

borrar = FALSE
origen = dw_1.getitemstring(1,'codigo_origen')
destino = dw_1.getitemstring(1,'destino')

// Si el mensaje es enviado
if origen = g_usuario then

	borrado_dst =  dw_1.getitemstring(1,'borrado_dst')
	if borrado_dst = 'S' or destino = g_usuario then 
		borrar = TRUE
	else
		dw_1.SetItem(1,'borrado_orig','S')
	end if
// Si el mensaje es recibido
else

	borrado_orig =  dw_1.getitemstring(1,'borrado_orig')
	if borrado_orig = 'S' then 
		borrar = TRUE
	else
		dw_1.SetItem(1,'borrado_dst','S')			
	end if
end if

if borrar then
	// Borramos el mensaje
	dw_1.Event pfc_deleterow()
end if
// Actualizamos los cambios
TriggerEvent("pfc_save")
// Actualizamos la ventana de lista si est$$HEX2$$e1002000$$ENDHEX$$instanciada
if isvalid(g_dw_lista) then g_dw_lista.retrieve(g_usuario)
// Cerramos la ventana
close(this)

end event

event activate;call super::activate;// Inicializamos las variables globales de dw_lista, ventatana de lista y ventana de detalle
g_dw_lista = g_dw_lista_mensajes
g_w_lista = g_mensajes_enviados
g_w_detalle = g_mensajes_detalle
g_lista = 'w_mensajes_enviados'
g_detalle = 'w_mensajes'

// Comprobamos si se ha pinchado en nuevo desde la ventana de lista previa
if gb_nuevo then
	triggerevent("csd_nuevo")
	gb_nuevo=false
end if
end event

event csd_anterior;call super::csd_anterior;if dw_1.RowCount() > 0 then
	g_mensajes_consulta.id_mensaje = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_mensaje')
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if dw_1.RowCount() > 0 then
	g_mensajes_consulta.id_mensaje = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_mensaje')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_mensajes_consulta.id_mensaje = g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_mensaje')	
	dw_1.event csd_retrieve()
end if


end event

event csd_ultimo;// Comprobamos que la ventana "lista previa" del m$$HEX1$$f300$$ENDHEX$$dulo est$$HEX2$$e1002000$$ENDHEX$$abierta
if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_mensajes_consulta.id_mensaje = g_dw_lista.GetItemString(1,'id_mensaje')	
	dw_1.event csd_retrieve()
end if


end event

event pfc_preclose;call super::pfc_preclose;// Actualizamos la ventana de lista si est$$HEX2$$e1002000$$ENDHEX$$instanciada
if isvalid(g_dw_lista) then g_dw_lista.retrieve(g_usuario)
return 1
end event

type cb_nuevo from w_detalle`cb_nuevo within w_mensajes
integer taborder = 30
end type

type cb_ayuda from w_detalle`cb_ayuda within w_mensajes
integer taborder = 70
end type

type cb_grabar from w_detalle`cb_grabar within w_mensajes
integer taborder = 40
end type

type cb_ant from w_detalle`cb_ant within w_mensajes
integer taborder = 50
end type

type cb_sig from w_detalle`cb_sig within w_mensajes
integer taborder = 60
end type

type dw_1 from w_detalle`dw_1 within w_mensajes
integer x = 55
integer y = 24
integer width = 3387
integer height = 1692
string dataobject = "d_mensaje"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;if g_mensajes_consulta.id_mensaje='' or isnull(g_mensajes_consulta.id_mensaje) then  return
int retorno

retorno=parent.event closequery()
if retorno=1 then return
this.retrieve(g_mensajes_consulta.id_mensaje)
g_mensajes_consulta.id_mensaje=''
end event

event dw_1::retrieveend;call super::retrieveend;if this.RowCount() = 0 then return

string receptor, emisor
datetime f_lec

This.Object.codigo_origen.TabSequence = 0
This.Object.destino.TabSequence = 0
This.Object.asunto.TabSequence = 0
This.Object.mensaje.TabSequence = 30
This.Object.mensaje.edit.displayonly="yes"

receptor = this.GetITemString(1,'destino')
emisor  = this.GetITemString(1,'codigo_origen')

f_lec = This.GetItemDateTime(1,'f_lectura')
if receptor = g_usuario and isnull(f_lec) then
	This.SetItem(1,'f_lectura',DateTime(Today(),Now()))
	This.SetItem(1,'leido','S')
	Parent.Event pfc_save()
end if

if isvalid(m_mensajes_detalle) then
	if emisor = g_usuario then
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_enviar.enabled = FALSE
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = FALSE	
	else
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_enviar.enabled = FALSE
		m_mensajes_detalle.m_file.m_new.m_mensajeria.m_responder.enabled = TRUE			
	end if
end if

end event

event dw_1::csd_enter;return 0
end event

type dw_2 from u_dw within w_mensajes
event csd_retrieve ( )
integer x = 453
integer y = 252
integer width = 2848
integer height = 312
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mensaje_usuarios_coleg"
end type

event csd_retrieve;this.retrieve()
end event

event clicked;call super::clicked;this.selectrow(row,not(this.isselected(row)))
end event

event constructor;call super::constructor;// Indicamos que el dw no se necesita grabar
This.of_Setupdateable(FALSE)
of_setrowselect(false)
end event

type dw_imprimir from u_dw within w_mensajes
boolean visible = false
integer x = 3291
integer y = 844
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_mensaje_imprimir"
end type

type cb_no_coleg from commandbutton within w_mensajes
integer x = 3314
integer y = 576
integer width = 361
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Todos"
end type

event clicked;long fila
string cod_usuario, id_col

// MArcamos todos los no colegiados excepto a nosotros mismos
FOR fila = 1 TO dw_3.RowCount()
	cod_usuario = dw_3.getitemstring(fila, 'cod_usuario')
	// Si somos nosotros nos lo saltamos
	if g_usuario = cod_usuario then continue
	id_col = ''
	select id_col into :id_col from t_usuario where cod_usuario = :cod_usuario;

	if f_es_vacio(id_col) then
		// Seleccionamos esa fila
		dw_3.selectrow(fila, true)
	end if
NEXT

end event

event constructor;//long n_reg
//
//select count(*) into :n_reg from t_permisos where cod_aplicacion = 'E' and cod_usuario = :g_usuario;
//if n_reg>0 then
//	this.visible = true
//else
//	this.visible = false
//end if
//
end event

type dw_3 from u_dw within w_mensajes
event csd_retrieve ( )
integer x = 453
integer y = 576
integer width = 2848
integer height = 312
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mensaje_usuarios_otros"
end type

event csd_retrieve;this.retrieve()
end event

event clicked;call super::clicked;this.selectrow(row,not(this.isselected(row)))
end event

event constructor;call super::constructor;// Indicamos que el dw no se necesita grabar
This.of_Setupdateable(FALSE)
of_setrowselect(false)
end event

type cb_no_coleg2 from commandbutton within w_mensajes
integer x = 3314
integer y = 668
integer width = 361
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "QuitarTodos"
end type

event clicked;long fila
string cod_usuario, id_col

// MArcamos todos los no colegiados excepto a nosotros mismos
FOR fila = 1 TO dw_3.RowCount()
	cod_usuario = dw_3.getitemstring(fila, 'cod_usuario')
	// Si somos nosotros nos lo saltamos
	if g_usuario = cod_usuario then continue
	id_col = ''
	select id_col into :id_col from t_usuario where cod_usuario = :cod_usuario;

	if f_es_vacio(id_col) then
		// Deseleccionamos esa fila
		dw_3.selectrow(fila, false)
	end if
NEXT

end event

event constructor;//long n_reg
//
//select count(*) into :n_reg from t_permisos where cod_aplicacion = 'E' and cod_usuario = :g_usuario;
//if n_reg>0 then
//	this.visible = true
//else
//	this.visible = false
//end if
//
end event

type cb_coleg from commandbutton within w_mensajes
integer x = 3314
integer y = 252
integer width = 361
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Todos"
end type

event clicked;long fila
string cod_usuario, id_col

// Marcamos todos los colegiados
FOR fila = 1 TO dw_2.RowCount()
	cod_usuario = dw_2.getitemstring(fila, 'cod_usuario')
	dw_2.selectrow(fila, true)
NEXT

end event

event constructor;//long n_reg
//
//select count(*) into :n_reg from t_permisos where cod_aplicacion = 'E' and cod_usuario = :g_usuario;
//if n_reg>0 then
//	this.visible = true
//else
//	this.visible = false
//end if
//
end event

type cb_coleg2 from commandbutton within w_mensajes
integer x = 3314
integer y = 344
integer width = 361
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "QuitarTodos"
end type

event clicked;long fila
string cod_usuario, id_col

// Desmarcamos todos los colegiados
FOR fila = 1 TO dw_2.RowCount()
	cod_usuario = dw_2.getitemstring(fila, 'cod_usuario')
	dw_2.selectrow(fila, false)
NEXT

end event

event constructor;//long n_reg
//
//select count(*) into :n_reg from t_permisos where cod_aplicacion = 'E' and cod_usuario = :g_usuario;
//if n_reg>0 then
//	this.visible = true
//else
//	this.visible = false
//end if
//
end event

