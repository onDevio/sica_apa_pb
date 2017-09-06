HA$PBExportHeader$w_fases_reclamaciones.srw
forward
global type w_fases_reclamaciones from w_lista
end type
type dw_consulta from u_dw within w_fases_reclamaciones
end type
type cb_buscar from commandbutton within w_fases_reclamaciones
end type
type cb_limpiar from commandbutton within w_fases_reclamaciones
end type
type rb_1 from radiobutton within w_fases_reclamaciones
end type
type rb_2 from radiobutton within w_fases_reclamaciones
end type
type cb_generar from commandbutton within w_fases_reclamaciones
end type
type st_3 from statictext within w_fases_reclamaciones
end type
type gb_consulta from groupbox within w_fases_reclamaciones
end type
type gb_accion from groupbox within w_fases_reclamaciones
end type
type cb_imprimir2 from commandbutton within w_fases_reclamaciones
end type
type cb_grabar from commandbutton within w_fases_reclamaciones
end type
type st_2 from statictext within w_fases_reclamaciones
end type
type cb_imprimir from commandbutton within w_fases_reclamaciones
end type
type cb_anular_fases from u_cb within w_fases_reclamaciones
end type
type dw_remesa from u_dw within w_fases_reclamaciones
end type
type dw_genera_cartas from u_dw within w_fases_reclamaciones
end type
type dw_avisos_pendientes from u_dw within w_fases_reclamaciones
end type
end forward

global type w_fases_reclamaciones from w_lista
integer height = 2236
string title = "Reclamaci$$HEX1$$f300$$ENDHEX$$n de Avisos"
event csd_configura_ventana ( )
event csd_imprimir_carta ( integer fila )
event csd_anular_visado ( integer fila )
dw_consulta dw_consulta
cb_buscar cb_buscar
cb_limpiar cb_limpiar
rb_1 rb_1
rb_2 rb_2
cb_generar cb_generar
st_3 st_3
gb_consulta gb_consulta
gb_accion gb_accion
cb_imprimir2 cb_imprimir2
cb_grabar cb_grabar
st_2 st_2
cb_imprimir cb_imprimir
cb_anular_fases cb_anular_fases
dw_remesa dw_remesa
dw_genera_cartas dw_genera_cartas
dw_avisos_pendientes dw_avisos_pendientes
end type
global w_fases_reclamaciones w_fases_reclamaciones

type variables
datawindowchild idwc_generaciones
// Variable de acci$$HEX1$$f300$$ENDHEX$$n : valores posibles : 	CONSULTA/GENERACION
string i_accion = 'CONSULTA' 
string is_tipo_carta

st_tipo_carta_datos ist_tipo_carta_datos
end variables

event csd_configura_ventana();choose case i_accion
	case 'GENERACION'
		cb_imprimir.visible = false
		cb_generar.visible = true
		cb_imprimir2.visible = true
		cb_grabar.visible = true
		dw_consulta.dataobject = 'd_fases_reclamaciones_genera_consulta'
		dw_lista.visible = false
		dw_avisos_pendientes.visible = true
		dw_genera_cartas.visible = true	
		gb_consulta.text = 'Generaci$$HEX1$$f300$$ENDHEX$$n de remesa de Cartas , Generaci$$HEX1$$f300$$ENDHEX$$n Manual'			
		cb_anular_fases.visible=false
	case else
		cb_imprimir.visible = true
		cb_generar.visible = false		
		cb_imprimir2.visible = false
		cb_grabar.visible = false
		dw_consulta.dataobject = 'd_fases_reclamaciones_consulta'		
		dw_lista.visible = true	
		dw_avisos_pendientes.visible = false
		dw_genera_cartas.visible = false		
		gb_consulta.text = 'Consulta de Cartas de reclamaci$$HEX1$$f300$$ENDHEX$$n, Reimpresiones, Hist$$HEX1$$f300$$ENDHEX$$rico'	
		cb_anular_fases.visible=false
		
		dw_consulta.getchild('generacion', idwc_generaciones)
		idwc_generaciones.settransobject(sqlca)
		
end choose
dw_consulta.settransobject(sqlca)

dw_lista.reset()
dw_avisos_pendientes.reset()
dw_genera_cartas.reset()


dw_consulta.of_SetDropDownCalendar(False)

dw_consulta.of_SetDropDownCalendar(True)
dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_consulta.iuo_calendar.of_SetInitialValue(True)

dw_consulta.insertrow(0)

st_2.visible = false
st_3.visible = false

// Colocamos como visibles los botones de imprimir
cb_imprimir2.enabled=true
cb_imprimir.visible=true

end event

event csd_imprimir_carta(integer fila);string id_minuta, n_exp, n_registro, emplazamiento, tipo_act, tipo_obra, descripcion, recl_repr
string cliente, colegiado, nom_cli, ape_cli, nom_col, ape_col, tipo_carta, dataobject, destinatario
string t_via, direccion, codpos, poblacion, provincia, n_calle, cod_provincia, id_cliente
string tipo_via_cli, nombre_via_cli, cod_prov_cli, cp_cli, pobla_cli, prov_cli
string lugar_fecha = '', n_aviso, comunicado, id_fase, id_repre, descripcion_via
datetime f_entrada, f_minuta, f_ult_reclamacion
double importe = 0
st_tipo_carta_datos st_tipo_carta_datos
datastore ds_carta
datastore ds_lineas
string pagador

ds_carta = CREATE datastore

ds_lineas = create datastore
ds_lineas.dataobject = 'd_notif_detalle'
ds_lineas.settransobject(sqlca)


	// recuperacion de datos
	choose case UPPER(i_accion)
		case 'CONSULTA'
			//Modificado Jesus 19/01/2010 cri-170
			// Cogemos el tipo de carta de la lista
			tipo_carta = dw_lista.getitemstring(fila, 'fases_reclamaciones_tipo_reclamacion')
			st_tipo_carta_datos = f_dame_datos_tipo_carta(tipo_carta)
			dataobject = st_tipo_carta_datos.dataobject	
			ds_carta.dataobject = dataobject
			if g_colegio='COAATLR' and tipo_carta='6' then
				f_entrada = dw_consulta.getitemdatetime(1, 'f_carta_desde')
				ds_carta.retrieve(Datetime(RelativeDate(Date(f_entrada), -180)))
				ds_carta.print()
			else
				ds_carta.insertrow(0)		
				comunicado = st_tipo_carta_datos.comunicado
				id_minuta =  dw_lista.getitemstring(fila, 'fases_reclamaciones_id_minuta')
				n_aviso = dw_lista.getitemstring(fila, 'fases_minutas_n_aviso')		
				f_minuta = dw_lista.getitemdatetime(fila, 'fases_minutas_fecha')
				n_exp =  dw_lista.getitemstring(fila, 'fases_n_expedi')
				n_registro = dw_lista.getitemstring(fila, 'fases_n_registro')
				// Emplazamiento
				t_via = dw_lista.getitemstring(fila, 'fases_tipo_via_emplazamiento')
				select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :t_via;
				if f_es_vacio(descripcion_via) then descripcion_via = ''
				n_calle = dw_lista.getitemstring(fila, 'fases_n_calle')		
				if f_es_vacio(n_calle) then n_calle = ''		
				direccion = dw_lista.getitemstring(fila, 'fases_emplazamiento')
				if f_es_vacio(direccion) then direccion = ''		
				codpos =  dw_lista.getitemstring(fila, 'fases_poblacion')
				if f_es_vacio(codpos) then codpos = ''			
				poblacion = f_poblacion_descripcion(codpos)
				if f_es_vacio(poblacion) then poblacion = ''			
				cod_provincia = f_devuelve_cod_provincia(codpos)
				provincia = f_provincia_descripcion(cod_provincia)	
				if f_es_vacio(provincia) then provincia = ''			
				emplazamiento = descripcion_via + ' ' + direccion + ' ' + n_calle + ' ' + codpos + ' ' + poblacion + ' ' + provincia
		
				tipo_act = dw_lista.getitemstring(fila, 'fases_fase')
				tipo_obra =  dw_lista.getitemstring(fila, 'fases_tipo_trabajo')
				descripcion = dw_lista.getitemstring(fila, 'fases_descripcion')
		//		recl_repr = dw_lista.getitemstring(fila, 'reclamar_representante')
				id_fase = dw_lista.getitemstring(fila, 'fases_id_fase')
				id_cliente = dw_lista.getitemstring(fila, 'clientes_id_cliente')
				
				SELECT fases_clientes.id_representante  
				INTO :id_repre
				FROM fases_clientes  
				WHERE ( fases_clientes.id_fase = :id_fase ) AND  
						( fases_clientes.id_cliente = :id_cliente ) AND  
						( fases_clientes.id_representante is not null ) AND  
						( fases_clientes.reclamar_representante = 'S' )   ;
		
				if f_es_vacio(id_repre) or recl_repr = 'N' then
					nom_cli = dw_lista.getitemstring(fila, 'clientes_nombre')
					if f_es_vacio(nom_cli) then nom_cli = '' 
					ape_cli = dw_lista.getitemstring(fila, 'clientes_apellidos')		
					if f_es_vacio(ape_cli) then ape_cli = '' 
					if (not f_es_vacio(ape_cli)) and  (not f_es_vacio(nom_cli)) then ape_cli += ', ' 
					cliente = ape_cli + nom_cli
				else
					SELECT clientes.apellidos, clientes.nombre  
					INTO :ape_cli, :nom_cli  
					FROM clientes  
					WHERE clientes.id_cliente = :id_repre   ;
					if f_es_vacio(nom_cli) then nom_cli = '' 
					if f_es_vacio(ape_cli) then ape_cli = '' 
					if (not f_es_vacio(ape_cli)) and  (not f_es_vacio(nom_cli)) then ape_cli += ', ' 
					cliente = ape_cli + nom_cli
				end if
					
				// colegiado
				nom_col = dw_lista.getitemstring(fila, 'colegiados_nombre')
				if f_es_vacio(nom_col) then nom_col = '' 	
				ape_col = dw_lista.getitemstring(fila, 'colegiados_apellidos')		
				if f_es_vacio(ape_col) then ape_col = '' 		
				if (not f_es_vacio(ape_col)) and (not f_es_vacio(nom_col)) then ape_col += ', '
				colegiado = ape_col + nom_col
		
				f_entrada = dw_lista.getitemdatetime(fila, 'fases_f_entrada')
				importe = dw_lista.getitemnumber(fila, 'total_aviso')	
		
				// MODIFICADO Ricardo 2004-10-28
				pagador = dw_lista.getitemstring(fila, 'fases_minutas_pagador')
				CHOOSE CASE g_colegio
					CASE 'COAATLR'
						// Para la 3 no va al cliente, va al colegiado :'(
						CHOOSE CASE st_tipo_carta_datos.dataobject
							CASE 'd_carta_reclamacion_3_lr', 'd_carta_reclamacion_4_lr'
								pagador = '1'
						END CHOOSE
					CASE 'COAATBU'
						// Para la 3 no va al cliente, va al colegiado :'(
						CHOOSE CASE st_tipo_carta_datos.dataobject
							CASE 'd_carta_reclamacion_3_burgos'
								pagador = '1'
						END CHOOSE				
				END CHOOSE
				// FIN MODIFICADO Ricardo 2004-10-28
				
				choose case pagador
					case '1' //colegiado
						destinatario = colegiado
						direccion = dw_lista.getitemstring(fila, 'colegiados_domicilio_activo_fiscal')
						poblacion = dw_lista.getitemstring(fila, 'colegiados_poblacion_activa_fiscal')
					case '3' // cliente, empresa
						destinatario = cliente
						// si hay representante, se coge el representante
						if f_es_vacio(id_repre) or recl_repr = 'N' then
							tipo_via_cli = dw_lista.getitemstring(fila, 'clientes_tipo_via')
							select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :tipo_via_cli;
							if f_es_vacio(descripcion_via) then descripcion_via = ''
							nombre_via_cli = dw_lista.getitemstring(fila, 'clientes_nombre_via')				
							if f_es_vacio(nombre_via_cli) then nombre_via_cli = ''				
							direccion = descripcion_via + ' ' + nombre_via_cli
							cod_prov_cli = dw_lista.getitemstring(fila, 'clientes_cod_prov')	
							cp_cli = dw_lista.getitemstring(fila, 'clientes_cp')	
							if f_es_vacio(cp_cli) then cp_cli = ''
							pobla_cli = f_poblacion_descripcion(cp_cli)
							if f_es_vacio(pobla_cli) then pobla_cli = ''				
							prov_cli = f_provincia_descripcion(cod_prov_cli)	
							if f_es_vacio(prov_cli) then prov_cli = ''						
							poblacion = cp_cli + ' ' + pobla_cli + ' ' + prov_cli
						else
							SELECT clientes.tipo_via, clientes.nombre_via, clientes.cod_prov, clientes.cp  
							INTO :tipo_via_cli, :nombre_via_cli, :cod_prov_cli, :cp_cli  
							FROM clientes  
							WHERE clientes.id_cliente = :id_repre   ;
							
							select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :tipo_via_cli;
							if f_es_vacio(descripcion_via) then descripcion_via = ''
							if f_es_vacio(nombre_via_cli) then nombre_via_cli = ''				
							direccion = descripcion_via + ' ' + nombre_via_cli
							if f_es_vacio(cp_cli) then cp_cli = ''
							pobla_cli = f_poblacion_descripcion(cp_cli)
							if f_es_vacio(pobla_cli) then pobla_cli = ''				
							prov_cli = f_provincia_descripcion(cod_prov_cli)	
							if f_es_vacio(prov_cli) then prov_cli = ''						
							poblacion = cp_cli + ' ' + pobla_cli + ' ' + prov_cli
						end if
						
					case else
						destinatario = colegiado
						direccion = dw_lista.getitemstring(fila, 'colegiados_domicilio_activo_fiscal')
						poblacion = dw_lista.getitemstring(fila, 'colegiados_poblacion_activa_fiscal')
						
				end choose
		//		// Si es la carta al abogado, se pone como destinatario
		//		if st_tipo_carta_datos.tipo_destinatario = 'A' then
		//			destinatario = f_nombre_abogado()
		//			direccion = f_direccion_abogado()
		//			poblacion = f_poblacion_abogado()
		//		end if
				
				// Lugar y Fecha
				f_ult_reclamacion = dw_lista.getitemdatetime(fila, 'f_reclamacion')
				lugar_fecha = g_col_ciudad + ', ' + string(day(date(f_ult_reclamacion))) + ' de ' + LeftA(f_obtener_mes(f_ult_reclamacion),1) + lower(MidA(f_obtener_mes(f_ult_reclamacion),2)) + ' de ' + string(year(date(f_ult_reclamacion)))
				ds_lineas = f_rellenar_lineas_aviso(id_minuta)
				if st_tipo_carta_datos.tiene_detalle = 'S' then ds_carta.object.dw_notif_detalle[1].Object.Data = ds_lineas.Object.data	
			end if
		case else //GENERACION
			// Cogemos el tipo de carta de la lista
			tipo_carta = dw_genera_cartas.getitemstring(fila, 'tipo_reclamacion')
			st_tipo_carta_datos = f_dame_datos_tipo_carta(tipo_carta)
			dataobject = st_tipo_carta_datos.dataobject	
	
			ds_carta.dataobject = dataobject
			ds_carta.insertrow(0)		
			
			comunicado = st_tipo_carta_datos.comunicado
			n_aviso = dw_avisos_pendientes.getitemstring(fila, 'n_aviso')
			id_minuta =  dw_avisos_pendientes.getitemstring(fila, 'fases_minutas_id_minuta')
			f_minuta = dw_avisos_pendientes.getitemdatetime(fila, 'fecha')
			n_exp =  dw_avisos_pendientes.getitemstring(fila, 'fases_n_expedi')
			n_registro = dw_avisos_pendientes.getitemstring(fila, 'fases_n_registro')
			// Emplazamiento
			t_via = dw_avisos_pendientes.getitemstring(fila, 'fases_tipo_via_emplazamiento')
			select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :t_via;
			if f_es_vacio(descripcion_via) then descripcion_via = ''
			n_calle = dw_avisos_pendientes.getitemstring(fila, 'fases_n_calle')		
			if f_es_vacio(n_calle) then n_calle = ''		
			direccion = dw_avisos_pendientes.getitemstring(fila, 'fases_emplazamiento')
			if f_es_vacio(direccion) then direccion = ''		
			codpos =  dw_avisos_pendientes.getitemstring(fila, 'fases_poblacion')
			if f_es_vacio(codpos) then codpos = ''			
			poblacion = f_poblacion_descripcion(codpos)
			if f_es_vacio(poblacion) then poblacion = ''			
			cod_provincia = f_devuelve_cod_provincia(codpos)
			provincia = f_provincia_descripcion(cod_provincia)	
			if f_es_vacio(provincia) then provincia = ''			
			emplazamiento = descripcion_via + ' ' + direccion + ' ' + n_calle + ' ' + codpos + ' ' + poblacion + ' ' + provincia
	
			tipo_act = dw_avisos_pendientes.getitemstring(fila, 'fases_fase')
			tipo_obra =  dw_avisos_pendientes.getitemstring(fila, 'fases_tipo_trabajo')
			descripcion = dw_avisos_pendientes.getitemstring(fila, 'fases_descripcion')
	//		recl_repr = dw_avisos_pendientes.getitemstring(fila, 'reclamar_representante')
			id_fase = dw_avisos_pendientes.getitemstring(fila, 'fases_id_fase')
			id_cliente = dw_avisos_pendientes.getitemstring(fila, 'clientes_id_cliente')
					
			SELECT fases_clientes.id_representante  
			INTO :id_repre
			FROM fases_clientes  
			WHERE ( fases_clientes.id_fase = :id_fase ) AND  
					( fases_clientes.id_cliente = :id_cliente ) AND  
					( fases_clientes.id_representante is not null ) AND  
					( fases_clientes.reclamar_representante = 'S' )   ;
	
			if f_es_vacio(id_repre) or recl_repr = 'N' then
				nom_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_nombre')
				if f_es_vacio(nom_cli) then nom_cli = '' 
				ape_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_apellidos')		
				if f_es_vacio(ape_cli) then ape_cli = '' 
				if (not f_es_vacio(ape_cli)) and  (not f_es_vacio(nom_cli)) then ape_cli += ', ' 
				cliente = ape_cli + nom_cli
			else
				SELECT clientes.apellidos, clientes.nombre  
				INTO :ape_cli, :nom_cli  
				FROM clientes  
				WHERE clientes.id_cliente = :id_repre   ;
				if f_es_vacio(nom_cli) then nom_cli = '' 
				if f_es_vacio(ape_cli) then ape_cli = '' 
				if (not f_es_vacio(ape_cli)) and  (not f_es_vacio(nom_cli)) then ape_cli += ', ' 
				cliente = ape_cli + nom_cli
			end if
			
			// colegiado
			nom_col = dw_avisos_pendientes.getitemstring(fila, 'colegiados_nombre')
			if f_es_vacio(nom_col) then nom_col = '' 	
			ape_col = dw_avisos_pendientes.getitemstring(fila, 'colegiados_apellidos')		
			if f_es_vacio(ape_col) then ape_col = '' 		
			if (not f_es_vacio(ape_col)) and  (not f_es_vacio(nom_col)) then ape_col += ', ' 		
			colegiado = ape_col + nom_col
	
			f_entrada = dw_avisos_pendientes.getitemdatetime(fila, 'fases_f_entrada')
			importe = dw_avisos_pendientes.getitemnumber(fila, 'compute_1')	
	
			
			// MODIFICADO Ricardo 2004-10-28
			pagador = dw_avisos_pendientes.getitemstring(fila, 'fases_minutas_pagador')
			CHOOSE CASE g_colegio
					CASE 'COAATLR'
					// Para la 3 no va al cliente, va al colegiado :'(
					CHOOSE CASE st_tipo_carta_datos.dataobject
						CASE 'd_carta_reclamacion_3_lr', 'd_carta_reclamacion_4_lr'
							pagador = '1'
					END CHOOSE
				CASE 'COAATBU'
					// Para la 3 no va al cliente, va al colegiado :'(
					CHOOSE CASE st_tipo_carta_datos.dataobject
						CASE 'd_carta_reclamacion_3_burgos'
							pagador = '1'
					END CHOOSE				
			END CHOOSE
			// FIN MODIFICADO Ricardo 2004-10-28
			
			
			choose case pagador
				case '1' //colegiado
					destinatario = colegiado
					direccion = dw_avisos_pendientes.getitemstring(fila, 'colegiados_domicilio_activo_fiscal')
					poblacion = dw_avisos_pendientes.getitemstring(fila, 'colegiados_poblacion_activa_fiscal')
				case '3' // cliente, empresa
					destinatario = cliente
					// si hay representante, se coge el representante
					if f_es_vacio(id_repre) or recl_repr = 'N' then
						tipo_via_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_tipo_via')
						select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :tipo_via_cli;
						if f_es_vacio(descripcion_via) then descripcion_via = ''
						nombre_via_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_nombre_via')				
						if f_es_vacio(nombre_via_cli) then nombre_via_cli = ''				
						direccion = descripcion_via + ' ' + nombre_via_cli
						cod_prov_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_cod_prov')	
						cp_cli = dw_avisos_pendientes.getitemstring(fila, 'clientes_cp')	
						if f_es_vacio(cp_cli) then cp_cli = ''
						pobla_cli = f_poblacion_descripcion(cp_cli)
						if f_es_vacio(pobla_cli) then pobla_cli = ''				
						prov_cli = f_provincia_descripcion(cod_prov_cli)	
						if f_es_vacio(prov_cli) then prov_cli = ''						
						poblacion = cp_cli + ' ' + pobla_cli + ' ' + prov_cli
					else
						SELECT clientes.tipo_via, clientes.nombre_via, clientes.cod_prov, clientes.cp  
						INTO :tipo_via_cli, :nombre_via_cli, :cod_prov_cli, :cp_cli  
						FROM clientes  
						WHERE clientes.id_cliente = :id_repre   ;
						
						select descripcion into :descripcion_via from tipos_via where cod_tipo_via = :tipo_via_cli;
						if f_es_vacio(descripcion_via) then descripcion_via = ''
						if f_es_vacio(nombre_via_cli) then nombre_via_cli = ''				
						direccion = descripcion_via + ' ' + nombre_via_cli
						if f_es_vacio(cp_cli) then cp_cli = ''
						pobla_cli = f_poblacion_descripcion(cp_cli)
						if f_es_vacio(pobla_cli) then pobla_cli = ''				
						prov_cli = f_provincia_descripcion(cod_prov_cli)	
						if f_es_vacio(prov_cli) then prov_cli = ''						
						poblacion = cp_cli + ' ' + pobla_cli + ' ' + prov_cli
					end if
					
				case else
					destinatario = colegiado
					direccion = dw_avisos_pendientes.getitemstring(fila, 'colegiados_domicilio_activo_fiscal')
					poblacion = dw_avisos_pendientes.getitemstring(fila, 'colegiados_poblacion_activa_fiscal')
					
			end choose
	//		// Si es la carta al abogado, se pone como destinatario
	//		if st_tipo_carta_datos.tipo_destinatario = 'A' then
	//			destinatario = f_nombre_abogado()
	//			direccion = f_direccion_abogado()
	//			poblacion = f_poblacion_abogado()
	//		end if
			// Lugar y Fecha
			f_ult_reclamacion = dw_genera_cartas.getitemdatetime(fila, 'f_reclamacion')
			lugar_fecha = g_col_ciudad + ', ' + string(day(date(f_ult_reclamacion))) + ' de ' + LeftA(f_obtener_mes(f_ult_reclamacion),1) + lower(MidA(f_obtener_mes(f_ult_reclamacion),2)) + ' de ' + string(year(date(f_ult_reclamacion)))
			ds_lineas = f_rellenar_lineas_aviso(id_minuta)
			if st_tipo_carta_datos.tiene_detalle = 'S' then ds_carta.object.dw_notif_detalle[1].Object.Data = ds_lineas.Object.data		
					
	end choose
	
	ds_carta.setitem(1, 'n_expedi', n_exp)
	if RightA(dataobject, 7) = 'euskera' then
		ds_carta.setitem(1, 'fecn', string(f_minuta,'yyyy/mm/dd'))
	else
		ds_carta.setitem(1, 'fecn', string(f_minuta,'dd/mm/yyyy'))
	end if
	ds_carta.setitem(1, 'n_registro', n_registro)
	ds_carta.setitem(1, 'f_entrada', f_entrada)
	ds_carta.setitem(1, 'fase', f_dame_desc_tipo_actuacion(tipo_act))
	ds_carta.setitem(1, 'tipo_obra', f_dame_desc_tipo_obra(tipo_obra))
	ds_carta.setitem(1, 'emplazamiento', emplazamiento)
	ds_carta.setitem(1, 'descripcion', descripcion)
	ds_carta.setitem(1, 'clientes', cliente)
	ds_carta.setitem(1, 'colegiados', colegiado)
	ds_carta.setitem(1, 'total_aviso', importe)
	if RightA(dataobject, 7) = 'euskera' then lugar_fecha = string(year(date(f_ult_reclamacion))) + ', ' + LeftA(f_obtener_mes_euskera(f_ult_reclamacion),1) + lower(MidA(f_obtener_mes_euskera(f_ult_reclamacion),2)) + ' ' + string(day(date(f_ult_reclamacion)))
	ds_carta.setitem(1, 'lugar_fecha', lugar_fecha)
	ds_carta.setitem(1, 'destinatario', destinatario)
	ds_carta.setitem(1, 'direccion', direccion)
	ds_carta.setitem(1, 'poblacion', poblacion)
	ds_carta.setitem(1, 'comunicado', comunicado)
	ds_carta.setitem(1, 'n_aviso', n_aviso)
	// MODIFICADO RICARDO 2004-10-28
	if lower(ds_carta.describe("f_visado.name")) = 'f_visado' then
		// Solo para el caso en que exista el campo, colocamos el valor de la fecha de visado
		datetime f_visado
		select f_visado into :f_visado from fases where id_fase = :id_fase;
		ds_carta.setitem(1, 'f_visado', string(f_visado, "dd/mm/yyyy"))
	end if
	// FIN MODIFICADO RICARDO 2004-10-28
	
	ds_carta.print()

DESTROY ds_carta
DESTROY ds_lineas
end event

event csd_anular_visado(integer fila);string id_f,est,f_m_n_av,anul
int err
//informaci$$HEX1$$f300$$ENDHEX$$n que despu$$HEX1$$e900$$ENDHEX$$s utilizamos para saber d$$HEX1$$f300$$ENDHEX$$nde tenemos que cambiar el valor del estado
f_m_n_av=dw_lista.getitemstring(fila,'fases_minutas_n_aviso')
id_f = dw_lista.getitemstring(fila, 'fases_id_fase')
//averiguamos si ya est$$HEX2$$e1002000$$ENDHEX$$en el estado anulado
select estado into:est from fases where id_fase=:id_f ;
	if est='06' then 
		messagebox('g_titulo',"Ya est$$HEX2$$e1002000$$ENDHEX$$anulado el visado con n$$HEX2$$ba002000$$ENDHEX$$de aviso=" + f_m_n_av)
	else
		//si a$$HEX1$$fa00$$ENDHEX$$n no est$$HEX2$$e1002000$$ENDHEX$$anulado cambiamos 
		//el valor del estado de dicho id_fase a anulado
		update fases set estado = :g_fases_estados.anulado where id_fase=:id_f;
		//para poder controlar el color del commandbutton anular
		anul='S'
		dw_lista.setitem(fila,'anulado',anul)
		messagebox('g_titulo',"Anulado con $$HEX1$$e900$$ENDHEX$$xito")
		
		
	end if


		
end event

on w_fases_reclamaciones.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_buscar=create cb_buscar
this.cb_limpiar=create cb_limpiar
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_generar=create cb_generar
this.st_3=create st_3
this.gb_consulta=create gb_consulta
this.gb_accion=create gb_accion
this.cb_imprimir2=create cb_imprimir2
this.cb_grabar=create cb_grabar
this.st_2=create st_2
this.cb_imprimir=create cb_imprimir
this.cb_anular_fases=create cb_anular_fases
this.dw_remesa=create dw_remesa
this.dw_genera_cartas=create dw_genera_cartas
this.dw_avisos_pendientes=create dw_avisos_pendientes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_buscar
this.Control[iCurrent+3]=this.cb_limpiar
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.cb_generar
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.gb_consulta
this.Control[iCurrent+9]=this.gb_accion
this.Control[iCurrent+10]=this.cb_imprimir2
this.Control[iCurrent+11]=this.cb_grabar
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.cb_imprimir
this.Control[iCurrent+14]=this.cb_anular_fases
this.Control[iCurrent+15]=this.dw_remesa
this.Control[iCurrent+16]=this.dw_genera_cartas
this.Control[iCurrent+17]=this.dw_avisos_pendientes
end on

on w_fases_reclamaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_consulta)
destroy(this.cb_buscar)
destroy(this.cb_limpiar)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_generar)
destroy(this.st_3)
destroy(this.gb_consulta)
destroy(this.gb_accion)
destroy(this.cb_imprimir2)
destroy(this.cb_grabar)
destroy(this.st_2)
destroy(this.cb_imprimir)
destroy(this.cb_anular_fases)
destroy(this.dw_remesa)
destroy(this.dw_genera_cartas)
destroy(this.dw_avisos_pendientes)
end on

event open;call super::open;g_dw_lista_reclamaciones = dw_lista
dw_consulta.insertrow(0)

inv_resize.of_Register (dw_genera_cartas, "FixedtoRight&ScaletoBottom")
inv_resize.of_Register (dw_avisos_pendientes, "ScaletoRight&Bottom")

inv_resize.of_Register (cb_generar, "FixedtoBottom")
inv_resize.of_Register (cb_imprimir2, "FixedtoBottom")
inv_resize.of_Register (cb_grabar, "FixedtoBottom")

inv_resize.of_Register (st_2, "FixedtoBottom")
inv_resize.of_Register (st_3, "FixedtoBottom")

end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_fases_reclamaciones
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_fases_reclamaciones
end type

type st_1 from w_lista`st_1 within w_fases_reclamaciones
boolean visible = false
integer x = 32
integer y = 2108
end type

type dw_lista from w_lista`dw_lista within w_fases_reclamaciones
integer x = 32
integer y = 848
integer width = 3461
integer height = 1100
integer taborder = 80
string dataobject = "d_fases_reclamaciones_lista"
end type

event dw_lista::retrieveend;call super::retrieveend;if this.RowCount() > 0 then
	st_2.text = string(this.RowCount()) + ' registros.'
	st_2.visible = true
else
	st_2.visible = false
end if
end event

event dw_lista::buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_imprimir'
		parent.post event csd_imprimir_carta(row)
	case 'b_anular'
		parent.post event csd_anular_visado(row)
end choose
end event

type cb_consulta from w_lista`cb_consulta within w_fases_reclamaciones
integer taborder = 90
end type

type cb_detalle from w_lista`cb_detalle within w_fases_reclamaciones
integer taborder = 100
end type

type cb_ayuda from w_lista`cb_ayuda within w_fases_reclamaciones
integer taborder = 110
end type

type dw_consulta from u_dw within w_fases_reclamaciones
event csd_rellenar_datos_carta ( )
integer x = 114
integer y = 236
integer width = 2885
integer height = 540
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_fases_reclamaciones_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_rellenar_datos_carta;string tipo_carta
date fecha_desde
int dias_ciclo
datetime fecha_nula
string cadena_nula
setnull(fecha_nula)
setnull(cadena_nula)

this.setitem(1, 'n_aviso', cadena_nula)
this.setitem(1, 'f_carta_desde', fecha_nula)
this.setitem(1, 'f_carta_hasta', fecha_nula)
this.setitem(1, 'f_ult_carta_desde', fecha_nula)
this.setitem(1, 'f_ult_carta_hasta', fecha_nula)
this.setitem(1, 'manual', 'N')
this.setitem(1, 'tipo_gestion', cadena_nula)
this.setitem(1, 'pagador', cadena_nula)

tipo_carta = this.getitemstring(1, 'tipo_carta')
ist_tipo_carta_datos = f_dame_datos_tipo_carta(tipo_carta)
if isnull(ist_tipo_carta_datos.ciclo) then ist_tipo_carta_datos.ciclo = 0
dias_ciclo = (-1) * (ist_tipo_carta_datos.ciclo + 1) 
fecha_desde = relativedate(today(), dias_ciclo)

if ist_tipo_carta_datos.es_primera = 'S' then
	dw_consulta.setitem(1, 'f_carta_hasta', fecha_desde)
else
	dw_consulta.setitem(1, 'f_ult_carta_hasta', fecha_desde)	
end if

if not f_es_vacio(ist_tipo_carta_datos.tipo_gestion) then
	dw_consulta.setitem(1, 'tipo_gestion', ist_tipo_carta_datos.tipo_gestion)	
end if

if not f_es_vacio(ist_tipo_carta_datos.pagador) then
	dw_consulta.setitem(1, 'pagador', ist_tipo_carta_datos.pagador)	
end if
end event

event constructor;call super::constructor;this.getchild('generacion', idwc_generaciones)
idwc_generaciones.settransobject(sqlca)
		
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;call super::itemchanged;datetime f_generacion
string id_remesa,t_carta



choose case dwo.name
	case 'generacion'
		f_generacion = idwc_generaciones.getitemdatetime(idwc_generaciones.getrow(), 'f_reclamacion')
		this.setitem(1, 'f_generacion', f_generacion)
	case 'tipo_carta'
		// Solo si se van a generar y en el caso de cartas de tipo denegaci$$HEX1$$f300$$ENDHEX$$n de visado, se dejar$$HEX1$$e100$$ENDHEX$$n 
		if data='z'then
			if upper(i_accion) = 'GENERACION' then cb_imprimir2.enabled=false
			parent.cb_imprimir.visible=false
//			parent.cb_cancelar.visible=true
		else
			if upper(i_accion) = 'GENERACION' then cb_imprimir2.enabled=true
			parent.cb_imprimir.visible=true
//			parent.cb_cancelar.visible=false
		end if

		if upper(i_accion) = 'GENERACION' then this.postevent('csd_rellenar_datos_carta')
			
		
case 'n_remesa'
		SELECT remesas_reclamaciones.id_remesas_reclamaciones  
    	INTO :id_remesa  
    	FROM remesas_reclamaciones  
   	WHERE remesas_reclamaciones.n_remesa = :data   ;
		
		if f_es_vacio(id_remesa) then 
			this.setitem(1, 'id_remesa', '')
		else
			this.setitem(1, 'id_remesa', id_remesa)
		end if

end choose

			

end event

event buttonclicked;call super::buttonclicked;string id_remesa, n_remesa

CHOOSE CASE dwo.name
	CASE 'b_remesa'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Remesas"
	  	g_busqueda.dw="d_lista_busqueda_remesas"
		id_remesa=f_busqueda_remesas()
		
		this.setitem(1, 'id_remesa', id_remesa)
		
		SELECT remesas_reclamaciones.n_remesa  
    	INTO :n_remesa  
    	FROM remesas_reclamaciones  
   	WHERE remesas_reclamaciones.id_remesas_reclamaciones = :id_remesa   ;
	
		this.setitem(1, 'n_remesa', n_remesa)
		
END CHOOSE

end event

type cb_buscar from commandbutton within w_fases_reclamaciones
integer x = 3031
integer y = 284
integer width = 425
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;string sql_nuevo,sql_original,c,cadena, sig_carta
integer comas,i, n_cartas_anteriores
datetime f_ini, f_fin
time hora_ini, hora_fin
u_dw dw_lista_aux

choose case upper(i_accion)
	case 'CONSULTA'
		dw_lista_aux = g_dw_lista_reclamaciones
		//Modificado Jesus 02/02/2010 cbi-147
		if(g_colegio='COAATB') then
			dw_lista_aux.DataObject = 'd_fases_reclamaciones_lista_bi'
			dw_lista_aux.SetTransObject(SQLCA)
		end if
	case else
		dw_lista_aux = dw_avisos_pendientes
end choose

dw_lista_aux.accepttext()

sql_nuevo=dw_lista_aux.describe("datawindow.table.select")
sql_original = sql_nuevo

dw_consulta.AcceptText()

//CGI-112 Jesus 29/04/2010
if (g_colegio='COAATGUI') then
	if parent.dw_consulta.getitemstring(1, 'tipo_carta') = '4' or parent.dw_consulta.getitemstring(1, 'tipo_carta') = '3' then
		dw_lista.SetTabOrder('f_reclamacion',10)
	else
		dw_lista.SetTabOrder('f_reclamacion',0)
	end if
end if

choose case upper(i_accion)
	case 'CONSULTA'
		//Modificado Jesus 19/01/2010 cri-170
		//Si se trata del listado de impagadas con m$$HEX1$$e100$$ENDHEX$$s de 180 d$$HEX1$$ed00$$ENDHEX$$as, se le a$$HEX1$$f100$$ENDHEX$$ade a la sql la sentencia... 
		//sino se deja como estaba
		if (g_colegio='COAATLR' AND parent.dw_consulta.getitemstring(1, 'tipo_carta') = '6') then
			f_ini = parent.dw_consulta.getitemdatetime(1, 'f_carta_desde')
			f_ini = Datetime(RelativeDate(Date(f_ini), -180))
			sql_nuevo += " and  (fases_reclamaciones.f_reclamacion <= '" + string(f_ini, 'mm/dd/yyyy hh:mm:ss') +"') and fases_minutas.pendiente='S' and fases_minutas.total_aviso > 0"
		else
			f_sql('fases_reclamaciones.f_reclamacion','>=','f_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases_reclamaciones.f_reclamacion','<','f_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
			f_sql('fases_reclamaciones.tipo_reclamacion','LIKE','tipo_carta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		end if
		f_sql('fases_minutas.n_aviso','LIKE','n_aviso',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_reclamaciones.manual','LIKE','manual',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_reclamaciones.id_remesas_reclamaciones','LIKE','id_remesa',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
	case else
		f_sql('fases_minutas.id_minuta','=','id_minuta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.fecha','>=','f_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.fecha','<','f_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.f_reclamacion','>=','f_ult_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.f_reclamacion','<','f_ult_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
		f_sql('fases_minutas.tipo_gestion','=','tipo_gestion',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
		f_sql('fases_minutas.pagador','=','pagador',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
		
		if ist_tipo_carta_datos.es_primera = 'N' then
			sig_carta = dw_consulta.getitemString(1, 'tipo_carta')
			select count(*) into :n_cartas_anteriores from notificaciones  where sig_carta = :sig_carta;
			if n_cartas_anteriores > 1 then
				// Si hay m$$HEX1$$e100$$ENDHEX$$s de una meto una subconsulta dentro de la select
				sql_nuevo += " and fases_minutas.tipo_reclamacion in ( select codigo from notificaciones where sig_carta = '" + sig_carta +"') "
			else
				f_sql('fases_minutas.tipo_reclamacion','=','carta_anterior',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
			end if
		elseif ist_tipo_carta_datos.es_primera = 'S' then
		// Si es carta primera entonces habria que sacar los que tienen nulo el campo tipo_reclammacion
			sql_nuevo += ' and (fases_minutas.tipo_reclamacion = null or fases_minutas.tipo_reclamacion = ~'~') '
		end if
	
end choose
f_ini = dw_consulta.getitemdatetime(1, 'f_generacion')
if not isnull(f_ini) then
	hora_ini = relativetime(time(f_ini), -1)
	hora_fin = relativetime(time(f_ini), 1)	
	f_ini = datetime(date(f_ini), hora_ini)
	f_fin = datetime(date(f_ini), hora_fin)	
	sql_nuevo += ' and fases_reclamaciones.f_reclamacion between ~'' + string(f_ini, 'mm/dd/yyyy hh:mm:ss') + '~' and ~'' + string(f_fin, 'mm/dd/yyyy hh:mm:ss') + '~''
end if

if g_debug = '1' then MessageBox('',sql_nuevo)

dw_lista_aux.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")
dw_lista_aux.retrieve()

dw_lista_aux.modify("Datawindow.table.select=~"" + sql_original + "~"")


// Vaciamos el datawindow de generaci$$HEX1$$f300$$ENDHEX$$n de cartas
if i_accion = 'GENERACION' then
	dw_genera_cartas.reset()
end if

end event

type cb_limpiar from commandbutton within w_fases_reclamaciones
integer x = 3031
integer y = 392
integer width = 425
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Limpiar Consulta"
end type

event clicked;dw_consulta.reset()
dw_consulta.insertrow(0)

setnull(ist_tipo_carta_datos.nombre)
setnull(ist_tipo_carta_datos.dataobject)
setnull(ist_tipo_carta_datos.tipo_destinatario)
setnull(ist_tipo_carta_datos.sig_carta)
setnull(ist_tipo_carta_datos.pagador)
setnull(ist_tipo_carta_datos.es_primera)
setnull(ist_tipo_carta_datos.ciclo)
setnull(ist_tipo_carta_datos.tipo_gestion)
setnull(ist_tipo_carta_datos.tiene_detalle)
setnull(ist_tipo_carta_datos.comunicado)
end event

type rb_1 from radiobutton within w_fases_reclamaciones
integer x = 78
integer y = 80
integer width = 1504
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
string text = "1 - Consulta de Cartas de Reclamaci$$HEX1$$f300$$ENDHEX$$n, Reimpresiones, Hist$$HEX1$$f300$$ENDHEX$$rico"
boolean checked = true
boolean lefttext = true
end type

event clicked;i_accion = 'CONSULTA'
parent.event csd_configura_ventana()
end event

type rb_2 from radiobutton within w_fases_reclamaciones
integer x = 1691
integer y = 80
integer width = 1504
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
string text = "2 - Generaci$$HEX1$$f300$$ENDHEX$$n de remesa de Cartas , Generaci$$HEX1$$f300$$ENDHEX$$n Manual"
boolean lefttext = true
end type

event clicked;i_accion = 'GENERACION'
parent.event csd_configura_ventana()
end event

type cb_generar from commandbutton within w_fases_reclamaciones
boolean visible = false
integer x = 430
integer y = 1968
integer width = 425
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar >>>"
end type

event clicked;string tipo_carta, manual, id_minuta, n_aviso, id_reclam
// La fecha de reclamacion tiene que ser igual dentro de una generacion $$HEX1$$bf00$$ENDHEX$$ok?
datetime fecha_reclamacion 
int i, fila_insertada, fila

if f_puedo_escribir(g_usuario,'0000000026')=-1 then return -1

dw_genera_cartas.reset()

tipo_carta = dw_consulta.getitemstring(1, 'tipo_carta')
if f_es_vacio(tipo_carta) then
	messagebox(g_titulo, 'Debe especificar el tipo de carta que desea generar, se generan s$$HEX1$$f300$$ENDHEX$$lo cartas de un tipo a la vez')
	return
end if
manual = dw_consulta.getitemstring(1, 'manual')
if f_es_vacio(manual) then
	messagebox(g_titulo, 'Debe especificar si desea marcar las cartas como manuales o no (autom$$HEX1$$e100$$ENDHEX$$ticas)')
	return	
end if

// Avisamos por si no est$$HEX2$$e1002000$$ENDHEX$$seguro de lo que va a hacer
if tipo_carta = 'z' then
	if MessageBox(g_titulo, "Se van a proceder a anular todas las fases"+cr+"$$HEX1$$bf00$$ENDHEX$$Desea continuar?", exclamation!, yesno!, 2) = 2 then
		return
	end if
end if
	
IF dw_avisos_pendientes.rowcount() = 0 then
	messagebox(g_titulo, "No existe ninguna carta para generar")
	return
end if

fecha_reclamacion = datetime(today(), now())

dw_remesa.reset()
fila = dw_remesa.insertrow(0)
id_reclam = f_siguiente_numero('REMESA_RECLAMACION',10)
dw_remesa.setitem(fila, 'id_remesas_reclamaciones', id_reclam)
dw_remesa.setitem(fila, 'n_remesa', f_quita_ceros(id_reclam))
dw_remesa.setitem(fila, 'fecha', fecha_reclamacion)
dw_remesa.setitem(fila, 'tipo_reclamacion', dw_consulta.getitemstring(1, 'tipo_carta'))


for i = 1 to dw_avisos_pendientes.rowcount()
	dw_avisos_pendientes.setitem(i, 'f_reclamacion', datetime(today(),now()))
	dw_avisos_pendientes.setitem(i, 'tipo_reclamacion', tipo_carta)	
//	dw_avisos_pendientes.setitem(i, 'reclamar_representante', dw_consulta.getitemstring(1, 'reclamar_representante'))	
	id_minuta = dw_avisos_pendientes.getitemstring(i, 'fases_minutas_id_minuta')
	n_aviso = dw_avisos_pendientes.getitemstring(i, 'n_aviso')
	
	fila_insertada = dw_genera_cartas.insertrow(0)
	dw_genera_cartas.setitem(i, 'fases_minutas_n_aviso', n_aviso)
	dw_genera_cartas.setitem(i, 'id_minuta', id_minuta)	
	dw_genera_cartas.setitem(i, 'tipo_reclamacion', tipo_carta)	
	dw_genera_cartas.setitem(i, 'f_reclamacion', fecha_reclamacion)
	dw_genera_cartas.setitem(i, 'manual', manual)	
	dw_genera_cartas.setitem(i, 'id_remesas_reclamaciones', id_reclam)
	// Me es necesario para la anulacion de las fases
	dw_genera_cartas.setitem(i, 'fases_minutas_id_fase', dw_avisos_pendientes.getitemstring(i, 'fases_id_fase'))
next

// Nos guardamos el tipo de carta
is_tipo_carta = tipo_carta

end event

type st_3 from statictext within w_fases_reclamaciones
boolean visible = false
integer x = 3173
integer y = 1968
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 255
string text = "0 registros"
boolean focusrectangle = false
end type

type gb_consulta from groupbox within w_fases_reclamaciones
integer x = 37
integer y = 176
integer width = 3465
integer height = 640
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 79741120
string text = "Consulta de Cartas de reclamaci$$HEX1$$f300$$ENDHEX$$n, Reimpresiones, Hist$$HEX1$$f300$$ENDHEX$$rico"
end type

type gb_accion from groupbox within w_fases_reclamaciones
integer x = 32
integer y = 16
integer width = 3451
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15780518
string text = "Selecione la Acci$$HEX1$$f300$$ENDHEX$$n a realizar"
end type

type cb_imprimir2 from commandbutton within w_fases_reclamaciones
boolean visible = false
integer x = 869
integer y = 1968
integer width = 425
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Cartas"
end type

event clicked;
if dw_genera_cartas.rowcount() <= 0 then
	messagebox(g_titulo, 'Primero debe generar las cartas por favor')
	return
end if
int i
for i = 1 to dw_avisos_pendientes.rowcount()
	parent.event csd_imprimir_carta(i)
next
messagebox(g_titulo, 'Impresi$$HEX1$$f300$$ENDHEX$$n Finalizada, Actualice los datos si todo sali$$HEX2$$f3002000$$ENDHEX$$correctamente por favor')

end event

type cb_grabar from commandbutton within w_fases_reclamaciones
boolean visible = false
integer x = 1307
integer y = 1968
integer width = 425
integer height = 72
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualizar Datos"
end type

event clicked;long retorno

IF dw_avisos_pendientes.rowcount() = 0 then return

retorno = parent.event pfc_save()

if retorno >= 0 then
	// Si ha grabado bien, cambiamos los estados 
	if is_tipo_carta = 'z' then
		// Procesamos a cambiar los estados de los contratos
		cb_anular_fases.trigger event clicked()
	end if
end if
end event

type st_2 from statictext within w_fases_reclamaciones
boolean visible = false
integer x = 37
integer y = 1968
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 255
string text = "0 registros"
boolean focusrectangle = false
end type

type cb_imprimir from commandbutton within w_fases_reclamaciones
integer x = 3031
integer y = 500
integer width = 425
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir Todas"
end type

event clicked;int i
for i = 1 to dw_lista.rowcount()
	parent.event csd_imprimir_carta(i)
next
end event

type cb_anular_fases from u_cb within w_fases_reclamaciones
boolean visible = false
integer x = 3035
integer y = 500
integer width = 425
integer taborder = 11
boolean bringtotop = true
string text = "&Anular Todas"
end type

event clicked;call super::clicked;string id_f,est,f_m_n_av,anul
long i
int err
datetime fecha_hoy

fecha_hoy = datetime(today(), now())

if upper(i_accion) = 'GENERACION' then 
	//recorremos toda la lista seleccionada
	for i=1 to dw_genera_cartas.rowcount()
		//sacamos el id_fase para cambiar el estado en dicho id_fase
		id_f = dw_genera_cartas.getitemstring(i, 'fases_minutas_id_fase')
		//sacamos el numero de aviso para informaci$$HEX1$$f300$$ENDHEX$$n
		f_m_n_av=dw_genera_cartas.getitemstring(i,'fases_minutas_n_aviso')
		// Cogemos el estado de la fase
		select estado into:est from fases where id_fase=:id_f ;
		if est<>g_fases_estados.anulado then 
			//si a$$HEX1$$fa00$$ENDHEX$$n no est$$HEX2$$e1002000$$ENDHEX$$anulado cambiamos 
			//el valor del estado de dicho id_fase a anulado
			update fases set estado = :g_fases_estados.anulado where id_fase=:id_f;
			// Intentamos colocar en el historico de estados (no hago control de errores porque no vale la pena pa eso)
			INSERT INTO fases_estados (id_fase,cod_estado,fecha,usuario) VALUES (:id_f,:g_fases_estados.anulado,:fecha_hoy,:g_usuario)  ;
			// Confirmamos el grabado
			commit;
		end if
	next
end if  

end event

type dw_remesa from u_dw within w_fases_reclamaciones
boolean visible = false
integer x = 3104
integer y = 616
integer width = 311
integer height = 136
integer taborder = 11
string dataobject = "d_remesas_reclamaciones"
end type

type dw_genera_cartas from u_dw within w_fases_reclamaciones
boolean visible = false
integer x = 1998
integer y = 848
integer width = 1499
integer height = 1100
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_reclamaciones_genera_cartas"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;st_3.text = string(this.RowCount()) + ' registros.'
st_3.visible = true
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type dw_avisos_pendientes from u_dw within w_fases_reclamaciones
boolean visible = false
integer x = 32
integer y = 848
integer width = 1984
integer height = 1100
integer taborder = 90
string dataobject = "d_reclamaciones_avisos_pendientes"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

event retrieveend;call super::retrieveend;st_2.text = string(this.RowCount()) + ' registros.'
st_2.visible = true
end event

