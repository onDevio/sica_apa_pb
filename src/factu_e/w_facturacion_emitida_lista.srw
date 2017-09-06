HA$PBExportHeader$w_facturacion_emitida_lista.srw
forward
global type w_facturacion_emitida_lista from w_lista
end type
type st_serie from statictext within w_facturacion_emitida_lista
end type
type cb_emitir_facturas from commandbutton within w_facturacion_emitida_lista
end type
type cb_recibos_musaat from commandbutton within w_facturacion_emitida_lista
end type
type cb_eliminar from commandbutton within w_facturacion_emitida_lista
end type
end forward

global type w_facturacion_emitida_lista from w_lista
integer width = 3579
integer height = 1588
string title = "Lista Previa de Facturas Emitidas"
string menuname = "m_factu_e_lista"
boolean controlmenu = false
long backcolor = 80269524
event csd_emitir_facturas ( )
event csd_reclamacion ( )
st_serie st_serie
cb_emitir_facturas cb_emitir_facturas
cb_recibos_musaat cb_recibos_musaat
cb_eliminar cb_eliminar
end type
global w_facturacion_emitida_lista w_facturacion_emitida_lista

type variables
string i_id_factura
datetime f_fin
end variables

event csd_emitir_facturas();if dw_lista.rowcount()<1 then return

cb_emitir_facturas.triggerevent(clicked!)
end event

event csd_reclamacion();OpenSheet(g_detalle_reclamaciones,'w_reclamaciones_facturas_proformas',w_aplic_frame,0,original!)
/*if g_colegio = 'COAATLR' then
	// Almacenamos la consulta actual
	g_reclamaciones_facturas.consulta = i_sentencia_sql_lista
	OpenSheet(g_detalle_reclamaciones,'w_reclamaciones_facturas_generacion',w_aplic_frame,0,original!)
end if*///SCP-682

/*

datastore ds_reclamacion
string n_factura
datetime fecha
double importe,i,j,k
string  sl_copias
long ll_copias

// Si est$$HEX2$$e1002000$$ENDHEX$$vacio no hacemos nada
if f_es_vacio(g_factu_e_reclamacion) then return
// Si no hay lineas salimos
if dw_lista.rowcount()<1 then return

//creamos el dw din$$HEX1$$e100$$ENDHEX$$mico
ds_reclamacion=create datastore
ds_reclamacion.dataobject=g_factu_e_reclamacion

//recorremos toda la lista
for j=1 to dw_lista.rowcount()
	// Modificado Ricardo 04-03-10
	// Evitamos reclamar las pagadas
	if dw_lista.getitemstring(j,'pagado')='S' then continue
	// FIN Modificado Ricardo 04-03-10
	n_factura=dw_lista.getitemstring(j,'n_fact')
	fecha=dw_lista.getitemdatetime(j,'fecha')
	importe=dw_lista.getitemnumber(j,'total')
	//rellenamos los datos en el dataestore
	ds_reclamacion.insertrow(0)
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'n_fact',n_factura)
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'fecha',fecha)
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'importe_reten',importe)
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'nombre',dw_lista.getitemstring(j,'nombre'))
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'domicilio',dw_lista.getitemstring(j,'domicilio'))
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'poblacion',dw_lista.getitemstring(j,'poblacion'))
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'centro',dw_lista.getitemstring(j,'centro'))
	ds_reclamacion.setitem(ds_reclamacion.rowcount(),'tipo_persona',dw_lista.getitemstring(j,'tipo_persona'))
next

// Modificado Ricardo 04-05-10
if ds_reclamacion.rowCount()<1 then 
	Messagebox(g_titulo, "No hay facturas por reclamar")
	destroy ds_reclamacion
	return
end if
// Modificado Ricardo 04-05-10  

st_serie.text = ''
st_serie.textcolor = RGB(0,0,255)
st_serie.visible = true

// Preguntamos las copias que se quieren imprimir
openwithparm(w_n_copias, 'RECLAMACION')
sl_copias  = Message.StringParm
ll_copias = long(sl_copias)
// fin  copias

// Las recorremos para imprimirlas
for k = 1 to ll_copias
	ds_reclamacion.print()
	st_serie.text = 'Imprimiendo ' + string(k) + ' de ' + string(ll_copias)
next

st_serie.Textcolor = RGB(255,255,255)
st_serie.visible = false

destroy ds_reclamacion
*/
end event

on w_facturacion_emitida_lista.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_factu_e_lista" then this.MenuID = create m_factu_e_lista
this.st_serie=create st_serie
this.cb_emitir_facturas=create cb_emitir_facturas
this.cb_recibos_musaat=create cb_recibos_musaat
this.cb_eliminar=create cb_eliminar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_serie
this.Control[iCurrent+2]=this.cb_emitir_facturas
this.Control[iCurrent+3]=this.cb_recibos_musaat
this.Control[iCurrent+4]=this.cb_eliminar
end on

on w_facturacion_emitida_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_serie)
destroy(this.cb_emitir_facturas)
destroy(this.cb_recibos_musaat)
destroy(this.cb_eliminar)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_facturacion_emitida
g_w_detalle = g_detalle_facturacion_emitida
g_lista     = 'w_facturacion_emitida_lista'
g_detalle   = 'w_facturacion_emitida_detalle'

end event

event pfc_postopen();call super::pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_facturacion_emitida = dw_lista



end event

event csd_consulta;//Abrimos la ventana de consulta
open(w_facturacion_emitida_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event csd_nuevo;call super::csd_nuevo;opensheet(g_detalle_facturacion_emitida, g_detalle, w_aplic_frame, 0, original!)
end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
g_facturacion_emitida_consulta.id_factura = dw_lista.getitemstring(dw_lista.getrow(),'id_factura')
message.stringparm = "w_facturacion_emitida_detalle"
w_aplic_frame.postevent("csd_facturacion_emitida_detalle")


end event

event csd_listados;call super::csd_listados;open(w_facturacion_emitida_listados)
end event

event open;call super::open;i_sql_original = dw_lista.Describe("Datawindow.Table.Select")

of_SetResize (true)
inv_resize.of_Register (st_1, "FixedtoBottom")
inv_resize.of_Register (st_serie, "FixedtoBottom")
inv_resize.of_Register (dw_lista, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_consulta, "FixedtoBottom")
inv_resize.of_Register (cb_detalle, "FixedtoBottom")
inv_resize.of_Register (cb_ayuda, "FixedtoBottom")
inv_resize.of_Register (cb_emitir_facturas, "FixedtoBottom")
inv_resize.of_Register (cb_eliminar, "FixedtoBottom")

if g_colegio = 'COAATZ' or g_colegio = 'COAATGU' or g_colegio = 'COAATLR' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' then 
	cb_recibos_musaat.visible = true
end if
inv_resize.of_Register (cb_recibos_musaat, "FixedtoBottom")

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_facturacion_emitida_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_facturacion_emitida_lista
end type

type st_1 from w_lista`st_1 within w_facturacion_emitida_lista
integer x = 37
integer y = 1284
end type

type dw_lista from w_lista`dw_lista within w_facturacion_emitida_lista
integer x = 37
integer y = 32
integer height = 1204
string dataobject = "d_facturacion_emitida_lista"
boolean hscrollbar = true
end type

type cb_consulta from w_lista`cb_consulta within w_facturacion_emitida_lista
end type

type cb_detalle from w_lista`cb_detalle within w_facturacion_emitida_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_facturacion_emitida_lista
end type

type st_serie from statictext within w_facturacion_emitida_lista
integer x = 453
integer y = 1284
integer width = 859
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 16777215
long backcolor = 79741120
boolean focusrectangle = false
end type

type cb_emitir_facturas from commandbutton within w_facturacion_emitida_lista
integer x = 1454
integer y = 1264
integer width = 466
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Emitir Facturas"
end type

event clicked;string tipo_factura, emitida, emisor, n_factura, ls_valretorno, ls_valoremail, sl_originales, sl_copias, email,nif_cli,mensaje, ls_id_fase_aux
string paga_empresa,paga_externo,id_pagador,imprime_cta_banco_col, ls_destinatario_cc_todos, ls_destinatario_cc_particular, tipo_gestion, ls_nombre_fichero_log
double i, j, total
long ll_originales, ll_copias
datawindow dw
integer li_num_fichero

n_csd_impresion_formato l_uo_impresion_formato
l_uo_impresion_formato = create n_csd_impresion_formato

st_serie.textcolor = RGB(0,0,255)

l_uo_impresion_formato.pdf = g_formato_impresion_visared.pdf
l_uo_impresion_formato.papel = g_formato_impresion_visared.papel
l_uo_impresion_formato.email = g_formato_impresion_visared.email	
	
l_uo_impresion_formato.masivo = true

// Se crea fichero para kel logueo de posibles errores. 
ls_nombre_fichero_log = "Error_log_sellado_" + string(today(), "ddmmyyyy_hhmm") +".txt"
//li_num_fichero = FileOpen(g_directorio_temporal+ls_nombre_fichero_log, LineMode!, Write!, LockReadWrite!, Replace!,EncodingAnsi!)
//FileClose(li_num_fichero)
l_uo_impresion_formato.is_fichero_log_errores = g_directorio_temporal+ls_nombre_fichero_log

//li_num_fichero

l_uo_impresion_formato.avisos = 0
ls_valoremail = l_uo_impresion_formato.email

ll_originales = l_uo_impresion_formato.copias   //ORIGINALES
ll_copias = l_uo_impresion_formato.copias2		//COPIAS

total = dw_lista.RowCount()
string id_fase,id_minuta,id_colegiado,n_col,sin_email='', sin_email_cli=''
// Recorremos las facturas
for i = 1 to dw_lista.RowCount()
	l_uo_impresion_formato.cc_email = ''
	l_uo_impresion_formato.direccion_email=''
	l_uo_impresion_formato.email = ls_valoremail
	i_id_factura 	= dw_lista.GetItemString(i,'id_factura')
	tipo_factura	= dw_lista.GetItemString(i,'tipo_factura')
	emitida			= dw_lista.GetItemString(i,'emitida')
	emisor 			= dw_lista.GetItemString(i,'emisor')
	n_factura		= dw_lista.getitemstring(i,'n_fact')
	id_fase 			= dw_lista.getitemstring(i,'id_fase') 
	id_minuta		= dw_lista.getitemstring(i,'id_minuta') 	
	id_pagador		 = dw_lista.getitemstring(i,'id_cliente_pagador')
	paga_empresa =  dw_lista.getitemstring(i,'paga_empresa')
	paga_externo =  dw_lista.getitemstring(i,'paga_externo')
	imprime_cta_banco_col = dw_lista.getitemstring(i,'imprime_cta_banco_col')
	
	// Se utiliza funci$$HEX1$$f300$$ENDHEX$$n que permite seguir los mismos criterios desde diferentes apartados. 
	f_rellenar_destinatarios_email(i_id_factura, l_uo_impresion_formato)
	
	if tipo_factura=g_colegio_colegiado then // Si la factura es a colegiados (03)
		
		id_colegiado	 = dw_lista.getitemstring(i,'id_persona') 
		n_col = f_colegiado_n_col(id_colegiado)
	
		if f_es_vacio(l_uo_impresion_formato.direccion_email) then
			l_uo_impresion_formato.email='N'
			l_uo_impresion_formato.direccion_email=''
			sin_email+=n_col+', '
		end if
		
	else
		
		id_colegiado=dw_lista.getitemstring(i,'emisor')
		n_col = f_colegiado_n_col(id_colegiado)
		nif_cli=dw_lista.GetItemString(i,'nif')
		
		if 	tipo_factura=g_colegio_cliente then // Si la factura es a clientes (02)
				
			if f_es_vacio(l_uo_impresion_formato.direccion_email) then
				l_uo_impresion_formato.email='N'
				l_uo_impresion_formato.direccion_email=''
				sin_email_cli+=nif_cli+', '
			end if	
		
		elseif tipo_factura = g_colegiado_cliente then //factura de honorarios (04). 
			if not (f_es_vacio(id_minuta)) then 
				tipo_gestion = f_tipo_gestion_colegiado(id_minuta, id_colegiado)
			else 
				ls_id_fase_aux = f_devuelve_id_fase_minuta(id_fase)
				tipo_gestion = f_tipo_gestion_colegiado(ls_id_fase_aux, emisor)
			end if 
			
			if tipo_gestion = 'P' then //Sin gesti$$HEX1$$f300$$ENDHEX$$n de cobro
				if f_es_vacio(l_uo_impresion_formato.direccion_email) then
					l_uo_impresion_formato.email='N'
					l_uo_impresion_formato.direccion_email=''
					sin_email+=n_col+', '
				end if
			else // Tipo 'C', con gesti$$HEX1$$f300$$ENDHEX$$n de cobros. 
				if f_es_vacio(l_uo_impresion_formato.direccion_email) then
					l_uo_impresion_formato.email='N'
					l_uo_impresion_formato.direccion_email=''
					sin_email_cli+=nif_cli+', '
				end if	
				
				if f_es_vacio(l_uo_impresion_formato.cc_email) then
					l_uo_impresion_formato.cc_email=''
					sin_email+=n_col+', '
				end if
			end if	
				
		end if
	end if	
	
	//select email into :email from colegiados where id_colegiado=:id_colegiado;

	st_serie.text = 'Imprimiendo ' + string(i) + ' de ' + string(total)
	
	st_imprimir_factura_obj_impr st_imp_fact
	
	st_imp_fact.objeto_nuevo='S'
	st_imp_fact.id_factura 	= i_id_factura
	st_imp_fact.id_persona 	= emisor
	st_imp_fact.tipo 			= tipo_factura
	st_imp_fact.id_cliente_pagador = id_pagador
	st_imp_fact.paga_empresa = paga_empresa
	st_imp_fact.paga_externo = paga_externo
	st_imp_fact.imprime_cta_banco_col = imprime_cta_banco_col
	st_imp_fact.copia 		= 'X'
	st_imp_fact.dw 			= dw
	st_imp_fact.impresion_formato 				= l_uo_impresion_formato
	//st_imp_fact.impresion_formato.direccion_email			= email
	
	st_imp_fact.impresion_formato.id_factura=i_id_factura	
	if f_es_vacio(id_fase) and f_es_vacio(id_minuta) then
		st_imp_fact.impresion_formato.destino='TO'	
		st_imp_fact.impresion_formato.referencia=id_colegiado
		st_imp_fact.impresion_formato.referencia2=i_id_factura
	else
		st_imp_fact.impresion_formato.destino='T'
		st_imp_fact.impresion_formato.referencia=id_fase
		st_imp_fact.impresion_formato.referencia2=id_minuta
	end if	

	if st_imp_fact.impresion_formato.pdf='S' then
	 	dw_lista.setitem(i,'visared','V')
 	end if

 	choose case st_imp_fact.impresion_formato.destino
		case 'T'
			st_imp_fact.impresion_formato.f_ruta_facturas_fases()	
		case 'TO'
			st_imp_fact.impresion_formato.f_ruta_otras_facturas()				
	end choose
	
	if i = 1 then 
		// Se fuerza que se marque el env$$HEX1$$ed00$$ENDHEX$$o por email a pesar de que no sea una opci$$HEX1$$f300$$ENDHEX$$n por defecto en caso de que por configuraci$$HEX1$$f300$$ENDHEX$$n la variable "g_enviar_email_facturacion_clientes" indique que debemos enviar por correo electr$$HEX1$$f300$$ENDHEX$$nico las facturas de clientes. 
		// En caso de que por defecto ya se env$$HEX1$$ed00$$ENDHEX$$e por correo, no se activa la opci$$HEX1$$f300$$ENDHEX$$n pues impedir$$HEX1$$ed00$$ENDHEX$$a el env$$HEX1$$ed00$$ENDHEX$$o por correo de las facturas a colegiados. 
		if (l_uo_impresion_formato.email <> "S" or f_es_vacio(l_uo_impresion_formato.email)) then 
			if f_var_global_sn('g_enviar_email_facturacion_clientes') = "S" then 
				l_uo_impresion_formato.enviar_email_clientes = "S"
				l_uo_impresion_formato.email = "S"
			end if	
		end if 
	
		// Quitamos el contenido para que no aparezca en la ventana de impresi$$HEX1$$f300$$ENDHEX$$n 
		ls_destinatario_cc_particular = l_uo_impresion_formato.cc_email
		l_uo_impresion_formato.cc_email = ''
		// Abrimos ventana de impresi$$HEX1$$f300$$ENDHEX$$n para que el usuario confirme las opciones de impresi$$HEX1$$f300$$ENDHEX$$n. 
		 if st_imp_fact.impresion_formato.f_opciones_impresion()<> 1 then return
		 
		 // Si se ha introducido alguna direcci$$HEX1$$f300$$ENDHEX$$n en el campo "CC" se recoger$$HEX2$$e1002000$$ENDHEX$$y se enviar$$HEX2$$e1002000$$ENDHEX$$para todos los correos
		 if not f_es_vacio(l_uo_impresion_formato.cc_email) then
			ls_destinatario_cc_todos = l_uo_impresion_formato.cc_email 
			if ((rightA(trim(l_uo_impresion_formato.cc_email), 1) <> ';') and not(f_es_vacio(trim(l_uo_impresion_formato.cc_email)))) then
				l_uo_impresion_formato.cc_email = l_uo_impresion_formato.cc_email + ';'
			end if	
			
		end if
		 // Volvemos a a$$HEX1$$f100$$ENDHEX$$adir el destinatario "CC" de la primera factura que se trata en el bucle. 
		 l_uo_impresion_formato.cc_email = l_uo_impresion_formato.cc_email + ls_destinatario_cc_particular

	else
		if not(f_es_vacio(ls_destinatario_cc_todos)) then // el resto de ocasiones l_uo_impresion_formato.cc_email dispondr$$HEX2$$e1002000$$ENDHEX$$del destinatario "CC" de la factura que se est$$HEX2$$e9002000$$ENDHEX$$tratando y hay que a$$HEX1$$f100$$ENDHEX$$adir el destinatario "CC" que introdujera el usuario por defecto. 
			if ((rightA(trim(l_uo_impresion_formato.cc_email), 1) <> ';') and not(f_es_vacio(trim(l_uo_impresion_formato.cc_email)))) then
				l_uo_impresion_formato.cc_email = l_uo_impresion_formato.cc_email + ';'
			end if	
			
			l_uo_impresion_formato.cc_email = l_uo_impresion_formato.cc_email + ls_destinatario_cc_todos	
		end if 	
	end if
	
	// Se trasalda c$$HEX1$$f300$$ENDHEX$$digo despu$$HEX1$$e900$$ENDHEX$$s de la llamada a la ventana de impresi$$HEX1$$f300$$ENDHEX$$n para que no muestre los datos. 
	st_imp_fact.impresion_formato.nombre		= n_factura
	st_imp_fact.impresion_formato.asunto_email= 'Factura ' + n_factura

	 f_imprimir_factura_objeto_impr(st_imp_fact)
	
	// Se elimina cuerpo del mensaje si es el mismo que el asunto para que lo vuelva a recargar postriormente. 
	if ( trim(st_imp_fact.impresion_formato.texto_email) = trim(st_imp_fact.impresion_formato.asunto_email)) then 
		st_imp_fact.impresion_formato.texto_email = ''
	end if 	

	if ll_copias > 0 or ll_originales > 0 then
		if emitida='N' then 
			dw_lista.SetItem(i,'emitida','S')
		else
			dw_lista.SetItem(i,'reimpresa','S')
		end if
	end if

next

if (st_imp_fact.impresion_formato.ib_hay_errores_sellado) then 
	string ls_mensaje
	if fileexists(st_imp_fact.impresion_formato.is_fichero_log_errores ) then 
		ls_mensaje = "Se produjo errores durante el proceso de sellado de documentos." + cr 
		ls_mensaje = ls_mensaje + "Se ha guardado un fichero con los errores recogidos bajo la ruta: " + cr
		ls_mensaje = ls_mensaje + g_directorio_temporal+ls_nombre_fichero_log + cr
	else
		ls_mensaje = "Se produjo errores durante el proceso de sellado de documentos." + cr
		ls_mensaje = ls_mensaje + "No se ha podido generar un fichero de log que contenga los errores bajo la ruta: " +cr
		ls_mensaje = ls_mensaje + g_directorio_temporal+ls_nombre_fichero_log + cr
		ls_mensaje = ls_mensaje + "compruebe los permisos de escritura bajo la ruta indicada." + cr
	end if
	
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n",ls_mensaje)
end if 	

dw_lista.Update()

if not(f_es_vacio(sin_email)) then
	mensaje+="Los siguientes colegiados no tienen email:"+cr+sin_email+cr
end if
if not(f_es_vacio(sin_email_cli)) then
	mensaje+="Los siguientes clientes no tienen email:"+cr+left(sin_email_cli,len(sin_email_cli) - 2)+cr
end if
if not(f_es_vacio(mensaje)) then MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n",mensaje)

Parent.TriggerEvent('pfc_save')
st_serie.Textcolor = RGB(255,255,255)

end event

type cb_recibos_musaat from commandbutton within w_facturacion_emitida_lista
boolean visible = false
integer x = 1957
integer y = 1264
integer width = 466
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Recibos Musaat"
end type

event clicked;double i

st_serie.textcolor = RGB(0,0,255)
//// Preguntamos los originales y las copias
//string sl_imprimir, sl_originales, sl_copias
//long pos_#, ll_originales, ll_copias
//open(w_factu_e_imprimir)
//sl_imprimir = Message.StringParm
//pos_# = pos(sl_imprimir, '#')
//
//sl_originales = mid(sl_imprimir, 1, pos_# - 1)
//sl_copias = mid(sl_imprimir, pos_#  + 1, len(sl_imprimir))
//ll_originales = long(sl_originales)
//ll_copias = long(sl_copias)
//// fin originales y copias
//// Recorremos las facturas

datastore ds_recibo
ds_recibo = create datastore
CHOOSE CASE g_colegio
	CASE 'COAATZ'
		ds_recibo.dataobject = 'd_recibo_musaat_za'		
	CASE 'COAATGU'
		ds_recibo.dataobject = 'd_recibo_musaat_gu'
	CASE 'COAATLR'
		ds_recibo.dataobject = 'd_recibo_musaat_lr'
	CASE 'COAATLE'
		ds_recibo.dataobject = 'd_recibo_musaat_le'
	CASE 'COAATAVI'
		ds_recibo.dataobject = 'd_recibo_musaat_avi'		
END CHOOSE
ds_recibo.settransobject (sqlca)

// Recorremos las facturas e imprimimos las que tengan una linea de musaat
for i = 1 to dw_lista.RowCount()
	i_id_factura 	= dw_lista.GetItemString(i,'id_factura')
	st_serie.text = 'Imprimiendo ' + string(i) + ' de ' + string(dw_lista.rowcount())
	ds_recibo.retrieve(i_id_factura, 'N')
	if ds_recibo.rowcount() > 0 then ds_recibo.print()
next

st_serie.Textcolor = RGB(255,255,255)
destroy ds_recibo

end event

type cb_eliminar from commandbutton within w_facturacion_emitida_lista
integer x = 2459
integer y = 1264
integer width = 466
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Anular Rango"
end type

event clicked;long fila, fila_cobros
boolean b_continuar = false
datastore ds_cobros
string id_factura, lista_id_facturas, permiso

// Debe tener el permiso correspondiente
select permiso into :permiso from t_permisos where cod_usuario=:g_usuario and cod_aplicacion='ANFAC00001' and permiso='E';
if isnull(permiso) or permiso='' then 
	Messagebox(g_titulo,"No Tiene Permiso Para Realizar Este Proceso", StopSign!)
	return -1
end if

ds_cobros = create datastore
ds_cobros.dataobject = 'd_cobros_frecibidas'
ds_cobros.Settransobject(SQLCA)

// Verificamos que de todas las facturas de la lista, haya alguna a la que afecte el proceso
FOR fila = 1 to dw_lista.RowCount()
	// Tienen que ser facturas normales, no contabilizadas!
	if dw_lista.getitemstring(fila, "contabilizada")='N' and dw_lista.getitemstring(fila, "solo_pagos") = 'N' then 
		ds_cobros.retrieve(dw_lista.getitemstring(fila, "id_factura"))
		
		FOR fila_cobros = 1 TO ds_cobros.RowCount()
			// Los cobros no pueden pertenecer a una remesa ni a un cobro multiple
			if f_es_vacio(ds_cobros.getitemstring(fila_cobros, "n_remesa")) and f_es_vacio(ds_cobros.getitemstring(fila_cobros, "id_cobro_multiple")) then
				b_continuar = true
			end if
		NEXT
	end if
NEXT

if not b_continuar then
	Messagebox(g_titulo, "No hay posibilidad de anular ese rango de facturas")
	// Destruimos el datastore
	destroy ds_cobros
	return
end if

// Lo primero de todo preguntamos si est$$HEX2$$e1002000$$ENDHEX$$seguro de lo que va a hacer...
if MessageBox(g_titulo, "Va a convertir las facturas mostradas (s$$HEX1$$f300$$ENDHEX$$lo las no contabilizadas, no remesadas y que no sean de s$$HEX1$$f300$$ENDHEX$$lo pago) en facturas con importe a 0, contabilizadas y de s$$HEX1$$f300$$ENDHEX$$lo pago"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar?", question!, yesno!, 2) = 2 then 
	// Destruimos el datastore
	destroy ds_cobros
	return
end if

// Para las que se pueda hacer algo... 
FOR fila = 1 to dw_lista.RowCount()
	// Tienen que ser facturas normales, no contabilizadas!
	if dw_lista.getitemstring(fila, "contabilizada")='N' and dw_lista.getitemstring(fila, "solo_pagos") = 'N' then 
		id_factura = dw_lista.getitemstring(fila, "id_factura")
		ds_cobros.retrieve(id_factura)

		FOR fila_cobros = 1 TO ds_cobros.RowCount()
			// Los cobros no pueden pertenecer a una remesa ni a un cobro multiple
			if f_es_vacio(ds_cobros.getitemstring(fila_cobros, "n_remesa")) and f_es_vacio(ds_cobros.getitemstring(fila_cobros, "id_cobro_multiple")) then
				ds_cobros.setitem(fila_cobros,"contabilizado", 'S')
				ds_cobros.setitem(fila_cobros,"importe", 0)
			end if
		NEXT
		ds_cobros.update()
		dw_lista.setitem(fila, "contabilizada", 'S')
		dw_lista.setitem(fila, "solo_pagos", 'S')
		dw_lista.setitem(fila, "base_imp", 0)
		dw_lista.setitem(fila, "iva", 0)
		dw_lista.setitem(fila, "importe_reten", 0)
		dw_lista.setitem(fila, "subtotal", 0)
		dw_lista.setitem(fila, "total", 0)
		// Colocamos en las observaciones que ha sido anulada
		update csi_facturas_emitidas set notas = "ANULADA      "+notas where id_factura = :id_factura;
	end if
NEXT
dw_lista.update()

// Destruimos el datastore
destroy ds_cobros

end event

