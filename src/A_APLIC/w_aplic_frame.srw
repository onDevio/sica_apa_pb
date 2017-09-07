HA$PBExportHeader$w_aplic_frame.srw
forward
global type w_aplic_frame from w_frame
end type
end forward

global type w_aplic_frame from w_frame
integer x = 107
string menuname = "m_aplic_frame"
windowstate windowstate = maximized!
event csd_usuariosdetalle ( )
event csd_usuarioslista ( )
event csd_colegiadoslista ( )
event csd_colegiadosdetalle ( )
event csd_actaslista ( )
event csd_actasdetalle ( )
event csd_listas_lista ( )
event csd_colegiadosrapida ( )
event csd_listas_detalle ( )
event csd_certificadoslista ( )
event csd_registrosdetalle ( )
event csd_registroslista ( )
event csd_certificadosdetalle ( )
event csd_clienteslista ( )
event csd_clientesdetalle ( )
event csd_circulareslista ( )
event csd_circulares_detalle ( )
event csd_cambiocolegiadolista ( )
event csd_cambiocolegiadodetalle ( )
event csd_bolsa_trabajo_lista ( )
event csd_bolsa_trabajo_detalle ( )
event csd_expedientesdetalle ( )
event csd_expedienteslista ( )
event csd_expedientesrapida ( )
event csd_fasesdetalle ( )
event csd_fasesrapida ( )
event csd_faseslista ( )
event csd_reparoslista ( )
event csd_libroslista ( )
event csd_librosdetalle ( )
event csd_facturasemitidas_lista ( )
event csd_facturacion_emitida_detalle ( )
event csd_ctrlasistenciadetalle ( )
event csd_ctrlasistencialista ( )
event csd_cursos_formdetalle ( )
event csd_cursos_formlista ( )
event csd_formacionbancajadetalle ( )
event csd_ponentesdetalle ( )
event csd_ponenteslista ( )
event csd_asistentesdetalle ( )
event csd_asistenteslista ( )
event csd_srclista ( )
event csd_cobroslista ( )
event csd_musaat_detalle ( )
event csd_musaat_lista ( )
event csd_premaat_detalle ( )
event csd_premaat_lista ( )
event csd_apunteslista ( )
event csd_liquidacioneslista ( )
event csd_musaat_movimientos_lista ( )
event csd_premaat_liquid_lista ( )
event csd_liquidacionesdetalle ( )
event csd_movimientos_musaat_detalle ( )
event csd_reclamaciones_lista ( )
event csd_actividades_web_detalle ( )
event csd_ofertas_web_detalle ( )
event csd_noticias_web_detalle ( )
event csd_circulares_web_detalle ( )
event csd_selladovisared_lista ( )
event csd_siniestrosdetalle ( )
event csd_siniestroslista ( )
event csd_demandaslista ( )
event csd_demandasdetalle ( )
event csd_ofertasdetalle ( )
event csd_ofertaslista ( )
event csd_mensajesenviados ( )
event csd_mensajesrecibidos ( )
event csd_comprobar_mensajes ( )
event csd_mensajesdetalle ( )
event csd_jg_reunioneslista ( )
event csd_jg_reunionesdetalle ( )
event csd_as_juridica_detalle ( )
event csd_as_juridica_lista ( )
event csd_ad_judicial_lista ( )
event csd_ad_judicial_detalle ( )
event csd_final_obra_detalle ( )
event csd_final_obra_lista ( )
event csd_garantias_lista ( )
event csd_garantias_detalle ( )
event csd_garantias_liquidaciones ( )
event csd_ingretlista ( )
event csd_cobrosmultipleslista ( )
event csd_conceptosdomiciliableslr ( )
event csd_extraer_datos_colegiados ( )
event csd_cursos_extraer_informacion ( )
event csd_asistente ( )
event csd_importacion_facturas ( )
event csd_controlintegridad ( )
event csd_comprobacion_integridad ( )
event csd_aparatos_tecnicosdetalle ( )
event csd_aparatos_tecnicoslista ( )
event csd_comprobar_paquetes_visared ( )
event csd_caja_salidas ( )
event csd_grupos_lista ( )
event csd_almacenlista ( )
event csd_almacendetalle ( )
event csd_regsoc_lista ( )
event csd_regsoc_detalle ( )
event csd_comprobar_colegiados_mas_65 ( )
event csd_preferencias ( )
event csd_comprobar_avisos_pendientes ( )
event csd_comprobar_xml ( )
event csd_comprobar_sms_pendientes ( )
event csd_zurich_lista_integracion_contratos ( )
event csd_zurich_lista_integracion_asegurados ( )
end type
global w_aplic_frame w_aplic_frame

event csd_usuariosdetalle();if f_puedo_entrar(g_usuario,'0000000022')=1 then
	string ls_sheetname
	ls_sheetname = Message.StringParm
	OpenSheet(g_detalle_usuarios,ls_sheetname,this,0,original!)
end if

end event

event csd_usuarioslista();if f_puedo_entrar(g_usuario,'0000000022')=1 then
	string ls_sheetname
	ls_sheetname = Message.StringParm
	OpenSheet(g_lista_usuarios,ls_sheetname,this,0,original!)
end if

end event

event csd_colegiadoslista();if f_puedo_entrar(g_usuario,'0000000001')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_colegiados, ls_sheetname, this, 0, original!)
end if

end event

event csd_colegiadosdetalle();if f_puedo_entrar(g_usuario,'0000000001')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_colegiados, ls_sheetname, this, 0, original!)
end if

end event

event csd_actaslista();//if f_puedo_entrar(g_usuario,'0000000002')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_lista_actas, ls_sheetname, this, 0, original!)
//end if
//
//
end event

event csd_actasdetalle();//if f_puedo_entrar(g_usuario,'0000000002')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_detalle_actas, ls_sheetname, this, 0, original!)
//end if
end event

event csd_listas_lista();if f_puedo_entrar(g_usuario,'0000000023')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_listas, ls_sheetname, this, 0, original!)
end if

end event

event csd_colegiadosrapida();if f_puedo_entrar(g_usuario,'0000000001')=1 then

	string id_colegiado
	
	//Abrimos la ventana de consulta
	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
	g_busqueda.dw="d_lista_busqueda_colegiados"
	id_colegiado=f_busqueda_colegiados()
		
	if not f_es_vacio(id_colegiado) then
			
		g_colegiados_consulta.id_colegiado = id_colegiado
					
		//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
		if IsValid(g_detalle_colegiados) then
			g_detalle_colegiados.TriggerEvent("csd_busqueda_rapida")
		else
			message.stringparm = "w_colegiados_detalle"
			this.TriggerEvent("csd_colegiadosdetalle")
		end if
	end if

end if
end event

event csd_listas_detalle();if f_puedo_entrar(g_usuario,'0000000023')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_listas, ls_sheetname, this, 0, original!)
end if

end event

event csd_certificadoslista();//if f_puedo_entrar(g_usuario, '0000000005')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_lista_certificados, ls_sheetname, this, 0, original!)
//end if
//
end event

event csd_registrosdetalle();if f_puedo_entrar(g_usuario,'0000000003')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_registros, ls_sheetname, this, 0, original!)
end if

end event

event csd_registroslista();if f_puedo_entrar(g_usuario,'0000000003')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_registros, ls_sheetname, this, 0, original!)
end if

end event

event csd_certificadosdetalle();//if f_puedo_entrar(g_usuario, '0000000005')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_detalle_certificados, ls_sheetname, this, 0, original!)
//end if
//
end event

event csd_clienteslista();if f_puedo_entrar(g_usuario, '0000000006')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_clientes, ls_sheetname, this, 0, original!)
end if

end event

event csd_clientesdetalle();if f_puedo_entrar(g_usuario, '0000000006')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_clientes, ls_sheetname, this, 0, original!)
end if

end event

event csd_circulareslista();//if f_puedo_entrar(g_usuario, '0000000004')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_lista_circulares, ls_sheetname, this, 0, original!)
//end if
//
end event

event csd_circulares_detalle();//if f_puedo_entrar(g_usuario, '0000000004')=1 then
//	string ls_sheetname
//	ls_sheetname = message.stringparm
//	opensheet(g_detalle_circulares, ls_sheetname, this, 0, original!)
//end if
//
end event

event csd_cambiocolegiadolista;//if f_puedo_entrar(g_usuario,'0000000012')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_lista_cambio_colegiados, ls_sheetname, this, 0, original!)
//end if
//
////'002' es el codigo del modulo
end event

event csd_cambiocolegiadodetalle;//if f_puedo_entrar(g_usuario, '0000000012')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_detalle_cambio_colegiados, ls_sheetname, this, 0, original!)
//end if
//
////'002' es el codigo del modulo
end event

event csd_bolsa_trabajo_lista();if f_puedo_entrar(g_usuario,'0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_bolsa_trabajo, ls_sheetname, this, 0, original!)
end if
end event

event csd_bolsa_trabajo_detalle();if f_puedo_entrar(g_usuario, '0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_bolsa_trabajo, ls_sheetname, this, 0, original!)
end if

end event

event csd_expedientesdetalle();if f_puedo_entrar(g_usuario,'0000000014')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_expedientes, ls_sheetname, this, 0, original!)
end if

end event

event csd_expedienteslista();if f_puedo_entrar(g_usuario,'0000000014')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_expedientes, ls_sheetname, this, 0, original!)
end if

end event

event csd_expedientesrapida();//if f_puedo_entrar(g_usuario,'0000000014')=1 then
//
//	string id_expediente
//	
//	//Abrimos la ventana de consulta
//	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Expedientes"
//	g_busqueda.dw="d_lista_busqueda_expedientes"
//	id_expediente=f_busqueda_expedientes()
//	
//	if not f_es_vacio(id_expediente) then
//		g_expedientes_consulta.id_expediente = id_expediente
//				
//		//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
//		if IsValid(g_detalle_expedientes) then
//			g_detalle_expedientes.TriggerEvent("csd_busqueda_rapida")
//		else
//	
//			message.stringparm = "w_expedientes_detalle"
//			this.TriggerEvent("csd_expedientesdetalle")
//		end if
//	end if
//
//end if
//
end event

event csd_fasesdetalle();if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_fases, ls_sheetname, this, 0, original!)
end if

end event

event csd_fasesrapida();if f_puedo_entrar(g_usuario,'0000000007')=1 then

	string id_fase
	
	//Abrimos la ventana de consulta
	g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Fases"
	g_busqueda.dw="d_lista_busqueda_fases"
	id_fase=f_busqueda_fases()
	
	if not f_es_vacio(id_fase) then
		g_fases_consulta.id_fase = id_fase
					
		//Leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
		if IsValid(g_detalle_fases) then
			g_detalle_fases.TriggerEvent("csd_busqueda_rapida")
		else
			message.stringparm = "w_fases_detalle"
			this.TriggerEvent("csd_fasesdetalle")
		end if
	end if

end if

end event

event csd_faseslista();if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_fases, ls_sheetname, this, 0, original!)
end if

end event

event csd_reparoslista();if f_puedo_entrar(g_usuario,'0000000017')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_reparos, ls_sheetname, this, 0, original!)
end if

end event

event csd_libroslista();if f_puedo_entrar(g_usuario,'0000000016')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_libros, ls_sheetname, this, 0, original!)
end if

end event

event csd_librosdetalle();if f_puedo_entrar(g_usuario,'0000000016')=1 then
	string ls_sheetname
	ls_sheetname=message.stringparm
	opensheet(g_detalle_libros,ls_sheetname,this,0,original!)
end if

end event

event csd_facturasemitidas_lista();if f_puedo_entrar(g_usuario,'0000000019')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_facturacion_emitida, ls_sheetname, this, 0, original!)
end if


end event

event csd_facturacion_emitida_detalle();if f_puedo_entrar(g_usuario,'0000000019')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_facturacion_emitida, ls_sheetname, this, 0, original!)
end if

end event

event csd_ctrlasistenciadetalle();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_detalle_ctrlasistencia,ls_sheetname,this,0,original!)
end if

end event

event csd_ctrlasistencialista();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_lista_ctrlasistencia,ls_sheetname,this,0,original!)
end if

end event

event csd_cursos_formdetalle();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_detalle_cursos_form,ls_sheetname,this,0,original!)
end if

end event

event csd_cursos_formlista();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_lista_cursos_form,ls_sheetname,this,0,original!)
end if

end event

event csd_formacionbancajadetalle();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_detalle_bancaja,ls_sheetname,this,0,original!)
end if

end event

event csd_ponentesdetalle();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_detalle_ponentes,ls_sheetname,this,0,original!)
end if

end event

event csd_ponenteslista();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_lista_ponentes,ls_sheetname,this,0,original!)
end if

end event

event csd_asistentesdetalle();integer alert
if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	alert=g_detalle_cursos_form.dynamic event closequery()
	if(alert=0)then OpenSheet(g_detalle_asistentes,ls_sheetname,this,0,original!)
end if


end event

event csd_asistenteslista();if f_puedo_entrar(g_usuario,'0000000030')=1 then
	string ls_sheetname
	ls_sheetname=Message.StringParm
	OpenSheet(g_lista_asistentes,ls_sheetname,this,0,original!)
end if

end event

event csd_srclista();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_src, ls_sheetname, this, 0, original!)
end if

end event

event csd_cobroslista();if f_puedo_entrar(g_usuario,'0000000029')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_cobros, ls_sheetname, this, 0, original!)
end if

end event

event csd_musaat_detalle();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_musaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_musaat_lista();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_musaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_premaat_detalle();if f_puedo_entrar(g_usuario,'0000000024')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_premaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_premaat_lista();if f_puedo_entrar(g_usuario,'0000000024')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_premaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_apunteslista();//if f_puedo_entrar(g_usuario,'0000000035')=1 then
		string ls_sheetname
		ls_sheetname = message.stringparm
		opensheet(g_lista_apuntes, ls_sheetname, this, 0, original!)
//end if
end event

event csd_liquidacioneslista();if f_puedo_entrar(g_usuario,'0000000033')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_liquidaciones, ls_sheetname, this, 0, original!)
end if

end event

event csd_musaat_movimientos_lista();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_movimientos_musaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_premaat_liquid_lista();if f_puedo_entrar(g_usuario,'0000000024')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_cobros, ls_sheetname, this, 0, original!)
end if

end event

event csd_liquidacionesdetalle();if f_puedo_entrar(g_usuario,'0000000033')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_liquidaciones, ls_sheetname, this, 0, original!)
end if

end event

event csd_movimientos_musaat_detalle();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_movimientos_musaat, ls_sheetname, this, 0, original!)
end if

end event

event csd_reclamaciones_lista();if f_puedo_entrar(g_usuario,'0000000026')=0 then return

string ls_sheetname
ls_sheetname = message.stringparm
opensheet(g_lista_reclamaciones, ls_sheetname, this, 0, original!)

end event

event csd_actividades_web_detalle;////if f_puedo_entrar(g_usuario, '0000000004')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_actividades_web_detalle, ls_sheetname, this, 0, original!)
////end if
//
end event

event csd_ofertas_web_detalle;//////if f_puedo_entrar(g_usuario, '0000000004')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_ofertas_web_detalle, ls_sheetname, this, 0, original!)
//////end if
end event

event csd_noticias_web_detalle;////if f_puedo_entrar(g_usuario, '0000000004')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_noticias_web_detalle, ls_sheetname, this, 0, original!)
////end if
end event

event csd_circulares_web_detalle;//////if f_puedo_entrar(g_usuario, '0000000004')=1 then
//		string ls_sheetname
//		ls_sheetname = message.stringparm
//		opensheet(g_circulares_web_detalle, ls_sheetname, this, 0, original!)
//////end if
end event

event csd_selladovisared_lista();w_sheet ventana

//if f_puedo_entrar(g_usuario,'0000000027')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(ventana, ls_sheetname, this, 0, original!)
//end if

end event

event csd_siniestrosdetalle();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_siniestros, ls_sheetname, this, 0, original!)
end if

end event

event csd_siniestroslista();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_siniestros, ls_sheetname, this, 0, original!)
end if

end event

event csd_demandaslista();if f_puedo_entrar(g_usuario,'0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_demandas, ls_sheetname, this, 0, original!)
end if

end event

event csd_demandasdetalle();if f_puedo_entrar(g_usuario,'0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_demandas, ls_sheetname, this, 0, original!)
end if

end event

event csd_ofertasdetalle();if f_puedo_entrar(g_usuario,'0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_ofertas, ls_sheetname, this, 0, original!)
end if

end event

event csd_ofertaslista();if f_puedo_entrar(g_usuario,'0000000013')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_ofertas, ls_sheetname, this, 0, original!)
end if

end event

event csd_mensajesenviados();if f_puedo_entrar(g_usuario,'0000000015')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_mensajes_enviados, ls_sheetname, this, 0, original!)
end if

end event

event csd_mensajesrecibidos();if f_puedo_entrar(g_usuario,'0000000015')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_mensajes_recibidos, ls_sheetname, this, 0, original!)
end if

end event

event csd_comprobar_mensajes();//comprobacion de mensajes
long cuantos=0
	
// Consultamos en la tabla de mensajes si hay mensajes no leidos
select count(*) into :cuantos from t_mensaje where destino = :g_usuario and f_lectura is null and borrado_dst = 'N';
// Si encontramos mensajes no leidos avisamos al usuario
if cuantos > 0 then 
	if not isvalid(w_alarma_mensajes) then open (w_alarma_mensajes)
end if

end event

event csd_mensajesdetalle();if f_puedo_entrar(g_usuario,'0000000015')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_mensajes_detalle, ls_sheetname, this, 0, original!)
end if

end event

event csd_jg_reunioneslista();if f_puedo_entrar(g_usuario,'0000000011')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_jgreuniones, ls_sheetname, this, 0, original!)
end if


end event

event csd_jg_reunionesdetalle();if f_puedo_entrar(g_usuario,'0000000011')=1 then
	string ls_sheetname
	ls_sheetname=message.stringparm
	opensheet(g_detalle_jgreuniones,ls_sheetname,this,0,original!)
end if

end event

event csd_as_juridica_detalle();if f_puedo_entrar(g_usuario,'0000000034')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_as_juridica, ls_sheetname, this, 0, original!)
end if

end event

event csd_as_juridica_lista();if f_puedo_entrar(g_usuario,'0000000034')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_as_juridica, ls_sheetname, this, 0, original!)
end if
	
end event

event csd_ad_judicial_lista();if f_puedo_entrar(g_usuario,'0000000035')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_ad_judicial, ls_sheetname, this, 0, original!)
end if

end event

event csd_ad_judicial_detalle();if f_puedo_entrar(g_usuario,'0000000035')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_ad_judicial, ls_sheetname, this, 0, original!)
end if
end event

event csd_final_obra_detalle();if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_detalle_final_obra, ls_sheetname, this, 0, original!)
end if

end event

event csd_final_obra_lista();if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_final_obra, ls_sheetname, this, 0, original!)
end if

end event

event csd_garantias_lista();string ls_sheetname
if f_puedo_entrar(g_usuario,'0000000007')=1 then
	ls_sheetname = message.stringparm
	opensheet(g_lista_garantias, ls_sheetname, this, 0, original!)
end if

end event

event csd_garantias_detalle();string ls_sheetname
if f_puedo_entrar(g_usuario,'0000000007')=1 then
	ls_sheetname = message.stringparm
	opensheet(g_detalle_garantias, ls_sheetname, this, 0, original!)
end if 

end event

event csd_garantias_liquidaciones();if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_garantias_liquidaciones, ls_sheetname, this, 0, original!)
end if

end event

event csd_ingretlista();//if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_ing_ret, ls_sheetname, this, 0, original!)
//end if

end event

event csd_cobrosmultipleslista();// Evento que abre la ventana de cobros multiples
if f_puedo_entrar(g_usuario,'0000000036')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_cobros_multiples, ls_sheetname, this, 0, original!)
end if

end event

event csd_conceptosdomiciliableslr();// Evento que abre la ventana de conceptos domiciliables masiva
if f_puedo_entrar(g_usuario,'0000000037')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_conceptos_domiciliables_lr, ls_sheetname, this, 0, original!)
end if

end event

event csd_extraer_datos_colegiados();// Llamamos a la funcion que hace la extracci$$HEX1$$f300$$ENDHEX$$n de datos
f_colegiados_extraer_datos()

end event

event csd_cursos_extraer_informacion();f_cursos_extraer_informacion()
end event

event csd_asistente();if not isvalid(w_asistente) then open(w_asistente)
end event

event csd_importacion_facturas();// Evento para abrir la nueva ventana

string ls_sheetname
ls_sheetname = message.stringparm
opensheet(g_importacion_facturas, ls_sheetname, this, 0, original!)

end event

event csd_controlintegridad();w_sheet ventana
string ls_sheetname

ls_sheetname = message.stringparm
opensheet(ventana, ls_sheetname, this, 0, original!)

end event

event csd_comprobacion_integridad();w_sheet ventana
string ls_sheetname
ls_sheetname = message.stringparm
opensheet(ventana, ls_sheetname, this, 0, original!)

end event

event csd_aparatos_tecnicosdetalle;string ls_sheetname
ls_sheetname=message.stringparm
opensheet(g_detalle_aparatos_tecnicos,ls_sheetname,this,0,original!)

end event

event csd_aparatos_tecnicoslista;string ls_sheetname
ls_sheetname = message.stringparm
opensheet(g_lista_aparatos_tecnicos, ls_sheetname, this, 0, original!)

end event

event csd_comprobar_paquetes_visared();//Solo se activa el evento si tenemos activado el gestor de avisos...
w_presentacion.st_1.text=''
w_presentacion.st_2.text=''
if g_aviso_paquetes_nuevos<>'S' then return

//El sistema busca si han entrado paquetes nuevos en la ruta especificada para visared
datetime f_ultima_revision,f_modificado_fichero,f_modificado
string fs_ultima_revision,hs_ultima_revision
integer num_ficheros,modificados=0
long indice
date dia
time hora
n_cst_filesrvwin32 ficheros

indice = 1
n_cst_dirattrib lista_ficheros[]


ficheros = create n_cst_filesrvwin32

RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision",fs_ultima_revision)
RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision",hs_ultima_revision)

if f_es_vacio(fs_ultima_revision) then
	f_ultima_revision = datetime(Today(),Now())
	RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision",RegString!,string(today()))
	RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision",RegString!,string(now()))
else
	f_ultima_revision = datetime(Date(fs_ultima_revision),Time(hs_ultima_revision))//,time(fs_ultima_revision))
end if

//Recuperamos la lista de ficheros en formato zip
//Modificado Jesus 29-06-2010 SCP-397
//Mascara = 55; 1+2+4+16+32=55 Para habilitar m$$HEX1$$e100$$ENDHEX$$s tipos de fichero y as$$HEX2$$ed002000$$ENDHEX$$no tener en cuenta los permisos.
num_ficheros = ficheros.of_dirlist(g_directorio_importacion + "*.zip",55,lista_ficheros[])

//Ordenamos la lista de ficheros (lista_ficheros) por fecha de escritura (3) en orden descendente(false)
ficheros.of_sortdirlist(lista_ficheros,3,false)

if num_ficheros>0 then
	
	
	w_presentacion.st_1.text=string(num_ficheros)+g_idioma.of_getmsg('msg_general.aviso_paquetes_texto',' archivos en bandeja de entrada')
	//ficheros.of_getlastwritedatetime(lista_ficheros[indice].is_filename,dia,hora)
	dia= lista_ficheros[indice].id_lastwritedate
	hora = lista_ficheros[indice].it_lastwritetime
	f_modificado = datetime(dia,hora)
	
	do while indice<num_ficheros and f_modificado>f_ultima_revision
		if f_modificado > f_ultima_revision then modificados++
		indice++
		dia= lista_ficheros[indice].id_lastwritedate
		hora = lista_ficheros[indice].it_lastwritetime
		f_modificado = datetime(dia,hora)
	loop
else
	w_presentacion.st_1.text=''
END IF

RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision",RegString!,string(today()))
RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision",RegString!,string(now()))

if modificados>0 then
	f_mensaje('ATENCI$$HEX1$$d300$$ENDHEX$$N',"Hay "+string(modificados)+" paquetes nuevos en la 'Bandeja de Entrada' de Proyectos Telem$$HEX1$$e100$$ENDHEX$$ticos")
end if

if g_colegio='COAATMCA' then post event csd_comprobar_xml() 


end event

event csd_caja_salidas();//if f_puedo_entrar(g_usuario,'0000000007')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_caja_salidas, ls_sheetname, this, 0, original!)
//end if

end event

event csd_grupos_lista();if f_puedo_entrar(g_usuario,'0000000022')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_usuarios, ls_sheetname, this, 0, original!)
end if

end event

event csd_almacenlista();//if f_puedo_entrar(g_usuario,'0000000017')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_lista_almacen, ls_sheetname, this, 0, original!)
//end if
end event

event csd_almacendetalle();string ls_sheetname
ls_sheetname=message.stringparm
opensheet(g_detalle_almacen,ls_sheetname,this,0,original!)
end event

event csd_regsoc_lista();string ls_sheetname

ls_sheetname = Message.StringParm
OpenSheet(g_lista_regsoc,ls_sheetname,this,0,original!)

end event

event csd_regsoc_detalle();string ls_sheetname

ls_sheetname =Message.StringParm
OpenSheet(g_detalle_regsoc,ls_sheetname,this,0,original!)

end event

event csd_comprobar_colegiados_mas_65();string concepto
long num_col
string mensaje

select count(*) into :num_col from conceptos_domiciliables 
where id_colegiado in (
	select id_colegiado 
	from colegiados 
	where datediff(yy,f_nacimiento,getdate())>=65) and concepto=:g_codigos_conceptos.cuota_colegial;
	
if num_col>0 then 
	mensaje = "Existen colegiados de m$$HEX1$$e100$$ENDHEX$$s de 65 a$$HEX1$$f100$$ENDHEX$$os que todav$$HEX1$$ed00$$ENDHEX$$a tienen las cuotas colegiales pendientes"
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "colegiados.+65",mensaje)
	end if
	MessageBox(g_titulo, mensaje)
end if

end event

event csd_preferencias();open(w_preferencias)
end event

event csd_comprobar_avisos_pendientes();datetime hoy
long num
string mensaje

hoy=datetime(today())

select count(*) into :num from fases_minutas where forma_pago='FR' and pendiente='S' and anulada='N' and facturado='N' and fecha<=:hoy;

if num>0 then
	mensaje = "Existen avisos que han sobrepasado la fecha de vencimiento y todav$$HEX1$$ed00$$ENDHEX$$a no han sido cobrados.$$HEX1$$bf00$$ENDHEX$$Cobrar ahora?"
	if g_usar_idioma = "S" then
		mensaje = g_idioma.of_getmsg( "avisos.pasados_no_cobrados", mensaje)
	end if
	if MessageBox(g_titulo,mensaje,Question!,YesNo!)=1 then
		OpenWithParm(w_caja,'AVISOS')		
	end if
end if
		
end event

event csd_comprobar_xml();//Solo se activa el evento si tenemos activado el gestor de avisos...
w_presentacion.st_2.text=''
if g_aviso_paquetes_nuevos<>'S' then return

//El sistema busca si han entrado paquetes nuevos en la ruta especificada para visared
datetime f_ultima_revision,f_modificado_fichero,f_modificado,f_vacia
string fs_ultima_revision,hs_ultima_revision
integer num_ficheros,modificados=0
long indice,i,total_ficheros
date dia
time hora
n_cst_filesrvwin32 ficheros
n_cst_dirattrib lista_ficheros[]
string is_directorio_xml,direc_parcial

is_directorio_xml=ProfileString("sica.ini","COAATMCA","XML",'')
direc_parcial='envios\pendientes\'
if right(is_directorio_xml,1)<>'\' then is_directorio_xml+='\'


ficheros = create n_cst_filesrvwin32

RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision_xml",fs_ultima_revision)
RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision_xml",hs_ultima_revision)

if f_es_vacio(fs_ultima_revision) then
	//f_ultima_revision = datetime(Today(),Now())
	f_ultima_revision=datetime('1/1/1900')
	RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision_xml",RegString!,string(today()))
	RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision_xml",RegString!,string(now()))
else
	f_ultima_revision = datetime(Date(fs_ultima_revision),Time(hs_ultima_revision))
end if

for i=1 to 3
	indice = 1
	choose case i
		case 1
			num_ficheros = ficheros.of_dirlist(is_directorio_xml + "VISADOS\"+direc_parcial+"*.*",16,lista_ficheros[])
		case 2
			num_ficheros = ficheros.of_dirlist(is_directorio_xml + "CH\"+direc_parcial+"*.*",16,lista_ficheros[])
		case 3
			num_ficheros = ficheros.of_dirlist(is_directorio_xml + "RECIBOS_PAGADOS\"+direc_parcial+"*.*",16,lista_ficheros[])
	end choose
	
	//Ordenamos la lista de ficheros (lista_ficheros) por fecha de escritura (3) en orden descendente(false)
	ficheros.of_sortdirlist(lista_ficheros,3,false)
	
	if num_ficheros>0 then


		//ficheros.of_getlastwritedatetime(lista_ficheros[indice].is_filename,dia,hora)
		dia= lista_ficheros[indice].id_lastwritedate
		hora = lista_ficheros[indice].it_lastwritetime
		f_modificado = datetime(dia,hora)
		
		do while indice<num_ficheros and f_modificado>f_ultima_revision
			if not(lista_ficheros[indice].ib_subdirectory) or lista_ficheros[indice].is_filename='[..]' then
				indice ++
				continue
			end if
			if f_modificado > f_ultima_revision then modificados++
			indice++
			dia= lista_ficheros[indice].id_lastwritedate
			hora = lista_ficheros[indice].it_lastwritetime
			f_modificado = datetime(dia,hora)
		loop
		total_ficheros+= (num_ficheros - 1)
	END IF	
next
if total_ficheros>0 then
	w_presentacion.st_2.text=string(total_ficheros)+g_idioma.of_getmsg('msg_general.aviso_paquetes_texto2',' archivos XML')
else
	w_presentacion.st_2.text=''
end if

RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","f_revision_xml",RegString!,string(today()))
RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Visared","h_revision_xml",RegString!,string(now()))

if modificados>0 then
	f_mensaje('ATENCI$$HEX1$$d300$$ENDHEX$$N',cr+"Hay "+string(modificados)+" ficheros XML a importar")
end if



end event

event csd_comprobar_sms_pendientes();datetime ayer
long num


ayer=datetime(RelativeDate(today(),-1))

select count(*) into :num from csd_sms_enviados where envio_mensaje='N' and f_envio<=:ayer;

if num>0 then
	MessageBox("$$HEX1$$a100$$ENDHEX$$Atenci$$HEX1$$f300$$ENDHEX$$n!","Existen sms pendientes de enviar de d$$HEX1$$ed00$$ENDHEX$$as anteriores. Revise que el gestor de avisos funcione correctamente en el servidor.")
end if

end event

event csd_zurich_lista_integracion_contratos();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_zurich_lista_integracion_contratos, ls_sheetname, this, 0, original!)
end if

end event

event csd_zurich_lista_integracion_asegurados();if f_puedo_entrar(g_usuario,'0000000010')=1 then
	string ls_sheetname
	ls_sheetname = message.stringparm
	opensheet(g_zurich_lista_integracion_asegurados, ls_sheetname, this, 0, original!)
end if

end event

on w_aplic_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_aplic_frame" then this.MenuID = create m_aplic_frame
end on

on w_aplic_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_postopen;call super::pfc_postopen;opensheet(w_presentacion,w_aplic_frame,0,Original!)
if g_pruebas then this.title = '[PRUEBAS]' + ' ' + this.title

if (g_titulo_anyo_ejer) = 'S' then 
	this.title = g_ejercicio + ' - ' + this.title
end if	

if g_activa_multiempresa = 'S' then	 this.title = '['+g_nombre_empresa+']' + ' - ' + this.title

end event

event pfc_open;call super::pfc_open;string   ls_sheet
w_sheet   lw_sheet
ls_sheet = Message.StringParm
OpenSheet(lw_sheet,ls_sheet,this,0,Original!)
end event

event open;call super::open;gnv_ivajulio2010.of_bd_actualizar()
f_configurar_menu()
f_configurar_menu_1()
post event csd_comprobar_mensajes()
if g_comprobar_vencimiento_avisos='S' then post event csd_comprobar_avisos_pendientes()
if g_envio_sms='S' then post event csd_comprobar_sms_pendientes()
//post event csd_comprobar_agenda()
post event csd_extraer_datos_colegiados() // Modificado Ricardo 2005-03-14
post event csd_cursos_extraer_informacion() // Modificado Ricardo 2005-03-15
post event csd_comprobar_paquetes_visared() 

if g_comprobar_mas_65='S' then post event csd_comprobar_colegiados_mas_65() 
f_colegiados_cumpleanyos_avi()

if g_temporizador>0 then
	timer(g_temporizador,this)  // 600 = 10 Minutos
end if

if g_usar_idioma= 'S' then g_idioma.of_cambia_textos( this)
end event

event timer;call super::timer;event csd_comprobar_mensajes()
//event csd_comprobar_agenda()
post event csd_comprobar_paquetes_visared()
if g_colegio<>'COAATNA' then post event csd_extraer_datos_colegiados() // Modificado Ricardo 2005-03-14
post event csd_cursos_extraer_informacion() // Modificado Ricardo 2005-03-15

end event

event activate;call super::activate;// Aqu$$HEX2$$ed002000$$ENDHEX$$reestablecer la ruta por defecto de la aplicaci$$HEX1$$f300$$ENDHEX$$n
end event

