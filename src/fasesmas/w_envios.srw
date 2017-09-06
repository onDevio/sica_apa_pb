HA$PBExportHeader$w_envios.srw
forward
global type w_envios from w_response
end type
type cb_1 from commandbutton within w_envios
end type
type cbx_1 from checkbox within w_envios
end type
type cbx_2 from checkbox within w_envios
end type
type cbx_3 from checkbox within w_envios
end type
type cbx_4 from checkbox within w_envios
end type
type dw_fases_visado_notificacion from u_dw within w_envios
end type
type dw_colegiados from u_dw within w_envios
end type
end forward

global type w_envios from w_response
integer width = 2181
integer height = 984
string title = "Envios"
boolean ib_disableclosequery = true
event csd_enviar_email ( string id_colegiado )
event csd_enviar_sms ( string id_colegiado )
event csd_enviar_carta ( string id_colegiado )
event csd_enviar_mensaje ( string id_colegiado )
event csd_rellenar_dw_colegiados ( )
event csd_insertar_colegiado ( string id_col )
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
dw_fases_visado_notificacion dw_fases_visado_notificacion
dw_colegiados dw_colegiados
end type
global w_envios w_envios

type variables
string is_id_fase, isl_total_clientes
end variables

event csd_enviar_email(string id_colegiado);// Evento creado para enviar un email a los colegiados de forma que sepan cuando se les visa
string mail, texto
string n_registro, n_expedi, descripcion, t_via, nomvia, numero, poblacion, emplazamiento,des_via, pobla

mail = f_devuelve_mail(id_colegiado)
if not(f_es_vacio(mail)) then
	select fases.n_registro, expedientes.n_expedi, fases.descripcion, fases.tipo_via_emplazamiento, fases.emplazamiento, fases.n_calle, fases.poblacion
		into :n_registro, :n_expedi, :descripcion, :t_via, :nomvia,:numero, :poblacion
		from fases, expedientes
	where fases.id_expedi = expedientes.id_expedi and
			fases.id_fase = :is_id_fase;

	// Construimos la direccion
	emplazamiento = ''
	des_via = f_dame_desc_tipo_via(t_via)
	pobla = f_poblacion_descripcion(poblacion)
	if not f_es_vacio(des_via) then emplazamiento += des_via +" "
	if not f_es_vacio(nomvia) then emplazamiento += nomvia +" "
	if not f_es_vacio(numero) then emplazamiento += numero +" "
	if not f_es_vacio(pobla) then emplazamiento += poblacion +" "
			
	
	// Colocamos el numero de contrato y de expediente: 
	texto = 'N$$HEX2$$ba002000$$ENDHEX$$CONTRATO: ' + n_registro + ' N$$HEX2$$ba002000$$ENDHEX$$EXPEDIENTE: ' + n_expedi + cr
	// Colocamos la descripcion del contrato
	if not f_es_vacio(descripcion) then texto += 'TITULO CONTRATO: ' + cr + descripcion + cr
	// Colocamos el emplazamiento
	if not f_es_vacio(emplazamiento) then texto += 'Emplazamiento: ' + cr + emplazamiento + cr
	// Colocamos los clientes del contrato
	if not f_es_vacio(isl_total_clientes) then texto += 'PROMOTORES: ' + cr + isl_total_clientes

	// Enviamos el correo	
	f_enviar_email('Notificacion de VISADO',texto,mail,'csd','','')
end if
end event

event csd_enviar_sms(string id_colegiado);// Evento creado para envios de SMS
Messagebox(g_titulo, "No implementado")
end event

event csd_enviar_carta(string id_colegiado);// EVENTO CREADO PARA GENERAR LAS NOTIFICACIONES A LOS COLEGIADOS


// Recuperamos para este colegiado concreto
dw_fases_visado_notificacion.retrieve(is_id_fase, id_colegiado)
// Colocamos los promotores que hemos calculado previamente, e imprimimos
if dw_fases_visado_notificacion.rowCount()>0 then
	dw_fases_visado_notificacion.setitem(1, 'promotores',isl_total_clientes)
	// Imprimimos
	dw_fases_visado_notificacion.print()
end if

end event

event csd_enviar_mensaje(string id_colegiado);// Evento para enviar un mensaje por mensajeria interna
string id_usuario
string n_registro, n_expedi, descripcion, t_via, nomvia, numero, poblacion, emplazamiento, des_via, pobla, texto

select cod_usuario into :id_usuario from t_usuario where id_col = :id_colegiado;


if not(f_es_vacio(id_usuario)) then
	select fases.n_registro, expedientes.n_expedi, fases.descripcion, fases.tipo_via_emplazamiento, fases.emplazamiento, fases.n_calle, fases.poblacion
		into :n_registro, :n_expedi, :descripcion, :t_via, :nomvia,:numero, :poblacion
		from fases, expedientes
	where fases.id_expedi = expedientes.id_expedi and
			fases.id_fase = :is_id_fase;
	
	// Construimos la direccion
	emplazamiento = ''
	des_via = f_dame_desc_tipo_via(t_via)
	pobla = f_poblacion_descripcion(poblacion)
	if not f_es_vacio(des_via) then emplazamiento += des_via +" "
	if not f_es_vacio(nomvia) then emplazamiento += nomvia +" "
	if not f_es_vacio(numero) then emplazamiento += numero +" "
	if not f_es_vacio(pobla) then emplazamiento += poblacion +" "
			
	
	// Colocamos el numero de contrato y de expediente: 
	texto = 'N$$HEX2$$ba002000$$ENDHEX$$CONTRATO: ' + n_registro + ' N$$HEX2$$ba002000$$ENDHEX$$EXPEDIENTE: ' + n_expedi + cr
	// Colocamos la descripcion del contrato
	if not f_es_vacio(descripcion) then texto += 'TITULO CONTRATO: ' + cr + descripcion + cr
	// Colocamos el emplazamiento
	if not f_es_vacio(emplazamiento) then texto += 'Emplazamiento: ' + cr + emplazamiento + cr
	// Colocamos los clientes del contrato
	if not f_es_vacio(isl_total_clientes) then texto += 'PROMOTORES: ' + cr + isl_total_clientes

	// Generamos los mensajes
	g_mensajes_insercion.destino = id_usuario
	g_mensajes_insercion.id_mensaje = f_siguiente_numero('MENSAJES',10)
	g_mensajes_insercion.s_o_c = 'S'
	g_mensajes_insercion.asunto = 'COMUNICACI$$HEX1$$d300$$ENDHEX$$N DE VISADO DE CONTRATO'
	g_mensajes_insercion.codigo_origen = 'SISTEMA'
	g_mensajes_insercion.fecha = datetime(today(), now())
	g_mensajes_insercion.mensaje = texto
	f_enviar_mensaje()
end if
end event

event csd_rellenar_dw_colegiados();//Rellenamos el dw_colegiados con los colegiados de la fase
//Este evento es casi identico al que hab$$HEX1$$ed00$$ENDHEX$$a en cb_1.clicked()
datastore ds_fases_colegiados, ds_cols_soc, ds_fases_promotores
long i, cols
string id_col, id_cliente, sl_cliente, nif

	// Hay que hacer el recorrido de los clientes buscando los promotores
	ds_fases_promotores = create datastore
	ds_fases_promotores.dataobject = 'd_fases_promotores'
	ds_fases_promotores.SetTransObject(SQLCA)
	ds_fases_promotores.retrieve(is_id_fase)
	
	for i = 1 to ds_fases_promotores.RowCount()
		if ds_fases_promotores.getitemstring(i,"promotor") = 'S' then 
			sl_cliente = ''
			string id_representante
			id_representante = ds_fases_promotores.getitemstring(i,"id_representante")
			if not f_es_vacio(id_representante) then
				sl_cliente = f_dame_cliente ( id_representante )
				nif = ds_fases_promotores.getitemstring(i,"nif_representante")
				if not f_es_vacio(nif) then sl_cliente += ' con N.I.F.  ' + nif 
				sl_cliente += " en representaci$$HEX1$$f300$$ENDHEX$$n de "
			end if		
			id_cliente = ds_fases_promotores.getitemstring(i,"id_cliente")
			sl_cliente += f_dame_cliente ( id_cliente )
			nif = ds_fases_promotores.getitemstring(i,"nif")
			 
			// nombre    N.I.F.: nif_cliente
			// Domicilio.: domicilio_cliente
			// Poblaci$$HEX1$$f300$$ENDHEX$$n.: poblacion_cliente
			if LenA(isl_total_clientes) = 0 then isl_total_clientes = "Sr.  "
			isl_total_clientes += sl_cliente
			if not f_es_vacio(nif) then isl_total_clientes += nif
			isl_total_clientes += cr + 'Domicilio.: ' + f_dame_domicilio(id_cliente)
			isl_total_clientes += cr + 'Poblaci$$HEX1$$f300$$ENDHEX$$n.: ' + f_retorna_poblacion (id_cliente)
			isl_total_clientes += cr 		
		end if
	next
	
	// Destruimos el datastore
	destroy ds_fases_promotores
	
	// Creamos un datastore para recuperar los colegiados del contrato
	ds_fases_colegiados = create datastore
	ds_fases_colegiados.dataobject = 'd_fases_colegiados'
	ds_fases_colegiados.Settransobject(SQLCA)
	ds_fases_colegiados.retrieve(is_id_fase)

	for i = 1 to ds_fases_colegiados.rowcount()
		id_col = ds_fases_colegiados.getitemstring(i,"id_col")
		if f_colegiado_tipopersona(id_col) <> 'S' then

			//Andr$$HEX1$$e900$$ENDHEX$$s 17/3/2005
			//A$$HEX1$$f100$$ENDHEX$$adimos el colegiado al dw
			dw_colegiados.event csd_insertar_colegiado(id_col)
		else
			// Creamos un dastastore para obtener todos los colegiados de esa sociedad
			if not isvalid(ds_cols_soc) then
				ds_cols_soc = create datastore
				ds_cols_soc.dataobject = 'ds_fases_colegiados_asociados'
				ds_cols_soc.settransobject(sqlca)
			end if
			ds_cols_soc.retrieve(ds_fases_colegiados.getitemstring(i, 'id_fases_colegiados'))
	
	
			for cols = 1 to ds_cols_soc.rowcount()
				id_col = ds_cols_soc.getitemstring(cols,"id_col_per")
				dw_colegiados.event csd_insertar_colegiado(id_col)
			next
		end if
	next
	// Destruimos le datastore 
	destroy ds_fases_colegiados
	// Destruimos el datastore de colegiados de sociedades si lo hemos creado
	if isvalid(ds_cols_soc) then destroy ds_cols_soc


end event

on w_envios.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.dw_fases_visado_notificacion=create dw_fases_visado_notificacion
this.dw_colegiados=create dw_colegiados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.cbx_2
this.Control[iCurrent+4]=this.cbx_3
this.Control[iCurrent+5]=this.cbx_4
this.Control[iCurrent+6]=this.dw_fases_visado_notificacion
this.Control[iCurrent+7]=this.dw_colegiados
end on

on w_envios.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.dw_fases_visado_notificacion)
destroy(this.dw_colegiados)
end on

event open;call super::open;// Recogemos el id de la fase que nos pasan como parametro
is_id_fase = message.stringparm

f_centrar_ventana(this)

/*cbx_1.checked = f_envio_activo ('ENVIAR_SMS')
cbx_2.checked = f_envio_activo ('ENVIAR_EMAIL')
cbx_3.checked = f_envio_activo ('ENVIAR_CARTA')
cbx_4.checked = f_envio_activo ('ENVIAR_MENSAJE')
*/
end event

event pfc_postopen;call super::pfc_postopen;event csd_rellenar_dw_colegiados()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_envios
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_envios
integer taborder = 0
end type

type cb_1 from commandbutton within w_envios
integer x = 919
integer y = 728
integer width = 325
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;long i
string ls_sms,ls_email,ls_web,ls_postal,id_col

for i=1 to dw_colegiados.rowcount()
	ls_sms=dw_colegiados.getitemstring(i,'recibir_c_sms')	
	ls_email=dw_colegiados.getitemstring(i,'recibir_c_email')
	ls_postal=dw_colegiados.getitemstring(i,'recibir_c_postales')
	ls_web=dw_colegiados.getitemstring(i,'recibir_c_web')
	id_col=dw_colegiados.getitemstring(i,'id_col')
	if ls_postal='S' then
		event csd_enviar_carta(id_col)
	end if
	if ls_email='S' then
		event csd_enviar_email(id_col)
	end if
	if ls_sms='S' then
		event csd_enviar_sms(id_col)
	end if
	if ls_web='S' then
		event csd_enviar_mensaje(id_col)
	end if
next



close(parent)

end event

type cbx_1 from checkbox within w_envios
boolean visible = false
integer x = 366
integer y = 124
integer width = 325
integer height = 60
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "SMS"
borderstyle borderstyle = stylelowered!
end type

type cbx_2 from checkbox within w_envios
boolean visible = false
integer x = 366
integer y = 220
integer width = 325
integer height = 60
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "EMAIL"
borderstyle borderstyle = stylelowered!
end type

type cbx_3 from checkbox within w_envios
boolean visible = false
integer x = 366
integer y = 316
integer width = 325
integer height = 60
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "CARTA"
borderstyle borderstyle = stylelowered!
end type

type cbx_4 from checkbox within w_envios
boolean visible = false
integer x = 366
integer y = 412
integer width = 389
integer height = 60
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "MENSAJE"
borderstyle borderstyle = stylelowered!
end type

type dw_fases_visado_notificacion from u_dw within w_envios
boolean visible = false
integer x = 791
integer y = 128
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_fases_visado_notificacion"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_colegiados from u_dw within w_envios
event csd_insertar_colegiado ( string id_col )
integer x = 37
integer y = 32
integer width = 2089
integer height = 656
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_envios_colegiados"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_insertar_colegiado(string id_col);string ls_sms,ls_email,ls_web,ls_postal,ls_nombrecolegiado
long ll_fila

select recibir_c_postales,recibir_c_email,recibir_c_sms,recibir_c_web into :ls_postal,:ls_email,:ls_sms,:ls_web from colegiados where id_colegiado=:id_col;

ls_nombrecolegiado=f_colegiado_apellido(id_col)

ll_fila=this.insertrow(0)

this.setitem(ll_fila,'colegiado',ls_nombrecolegiado)
this.setitem(ll_fila,'recibir_c_sms',ls_sms)
this.setitem(ll_fila,'recibir_c_email',ls_email)
this.setitem(ll_fila,'recibir_c_postales',ls_postal)
this.setitem(ll_fila,'recibir_c_web',ls_web)
this.setitem(ll_fila,'id_col',id_col)

end event

