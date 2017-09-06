HA$PBExportHeader$w_caja_pagos.srw
forward
global type w_caja_pagos from w_response
end type
type cb_1 from commandbutton within w_caja_pagos
end type
type dw_minutas_detalle from u_dw within w_caja_pagos
end type
type cb_cancelar from commandbutton within w_caja_pagos
end type
type dw_fases_informes from u_dw within w_caja_pagos
end type
type dw_pagador from u_dw within w_caja_pagos
end type
type dw_caja_pago from u_dw within w_caja_pagos
end type
type dw_originales_copias_obj_impr from u_dw within w_caja_pagos
end type
end forward

global type w_caja_pagos from w_response
integer x = 214
integer y = 221
integer width = 1705
integer height = 1752
event csd_comprobar_todo_cobrado ( string modulo )
cb_1 cb_1
dw_minutas_detalle dw_minutas_detalle
cb_cancelar cb_cancelar
dw_fases_informes dw_fases_informes
dw_pagador dw_pagador
dw_caja_pago dw_caja_pago
dw_originales_copias_obj_impr dw_originales_copias_obj_impr
end type
global w_caja_pagos w_caja_pagos

type variables
st_caja_cobros i_parametros
u_dw idw_minutas_detalle
double idb_total
n_csd_impresion_formato i_impresion_formato
end variables

event csd_comprobar_todo_cobrado(string modulo);// El contrato pasa a abonado y retirado cuando est$$HEX2$$e1002000$$ENDHEX$$toda la CIP pagada
string id_fase = ''

// Ponemos el puntero a reloj
setpointer(hourglass!)
// Cogemos el idenfitificador de la fase
id_fase = idw_minutas_detalle.getitemstring(idw_minutas_detalle.RowCount(), 'id_fase')

// LLamamos a la funcion que realiza el cambio de estado y dem$$HEX1$$e100$$ENDHEX$$s
if f_fases_cambia_estado_fase_segun_pagado(id_fase, modulo)='-1' then
	Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
	return
end if
end event

on w_caja_pagos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_minutas_detalle=create dw_minutas_detalle
this.cb_cancelar=create cb_cancelar
this.dw_fases_informes=create dw_fases_informes
this.dw_pagador=create dw_pagador
this.dw_caja_pago=create dw_caja_pago
this.dw_originales_copias_obj_impr=create dw_originales_copias_obj_impr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_minutas_detalle
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.dw_fases_informes
this.Control[iCurrent+5]=this.dw_pagador
this.Control[iCurrent+6]=this.dw_caja_pago
this.Control[iCurrent+7]=this.dw_originales_copias_obj_impr
end on

on w_caja_pagos.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_minutas_detalle)
destroy(this.cb_cancelar)
destroy(this.dw_fases_informes)
destroy(this.dw_pagador)
destroy(this.dw_caja_pago)
destroy(this.dw_originales_copias_obj_impr)
end on

event open;call super::open;long fila
double cantidad_pagar
string tipo_gestion, tipo_carta_imprimir, id_col, activo_cp

idw_minutas_detalle = dw_minutas_detalle

// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
if isvalid(message.PowerObjectParm) Then
	i_parametros = message.PowerObjectParm	
else
	// Recogemos los par$$HEX1$$e100$$ENDHEX$$metros pasados
	if not isnull(message.StringParm) Then
		dw_minutas_detalle.retrieve(message.StringParm)
		i_parametros.tipo = 'FASES'
	end if
end if

f_centrar_ventana(this)


// Colocamos la fecha y los datos por defecto
dw_caja_pago.SetItem(1,'fecha_pago',DateTime(Today(),time("00:00")))
dw_caja_pago.SetItem(1,'fecha_factura',DateTime(Today(),time("00:00")))
if f_es_vacio(dw_caja_pago.getitemstring(1, 'forma_pago')) then dw_caja_pago.Setitem(1,'forma_pago',g_forma_pago_por_defecto)
if f_es_vacio(dw_caja_pago.getitemstring(1, 'banco')) then dw_caja_pago.SetItem(1,'banco',g_banco_por_defecto)

dw_originales_copias_obj_impr.insertrow(0)
i_impresion_formato = create n_csd_impresion_formato


tipo_gestion = '-1' // pongo un valor aleatorio

// Obtenemos importes seg$$HEX1$$fa00$$ENDHEX$$n el tipo
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		// Recorremos el datawindow para ver la cantidad a pagar
		cantidad_pagar = 0
		FOR fila =1 to i_parametros.dw.RowCount()
			if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
				cantidad_pagar += i_parametros.dw.getitemnumber(fila, 'total')
				// Si hay alguno que es de tipo 'C' lo ponemos
				if i_parametros.dw.GetItemString(fila, 'tipo_gestion') = 'C' then tipo_gestion = 'C'
				if (g_colegio = 'COAATA' or g_colegio = 'COAATTFE') and i_parametros.dw.GetItemString(fila, 'tipo_gestion') = 'A' then tipo_gestion = 'A'
			end if
		NEXT
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',cantidad_pagar)
		
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				dw_caja_pago.modify("tipo_carta_imprimir.visible = '1'")
				dw_caja_pago.modify("tipo_carta_imprimir_t.visible = '1'")
				dw_caja_pago.modify("copias.visible = '1'")
				dw_caja_pago.modify("copias_t.visible = '1'")
				tipo_carta_imprimir = "0#NINGUNA"
				FOR fila = 1 TO i_parametros.dw.rowcount()
					if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
						tipo_carta_imprimir = f_caja_tipo_carta_imprimir(i_parametros.dw.getitemstring(fila, 'tipo_registro'), i_parametros.dw.getitemstring(fila, 'fase'), tipo_carta_imprimir, true)
					end if
				NEXT
				dw_caja_pago.setitem(1, "tipo_carta_imprimir", MidA(tipo_carta_imprimir, PosA(tipo_carta_imprimir,"#")+1, LenA(tipo_carta_imprimir) - PosA(tipo_carta_imprimir,"#")))
		END CHOOSE

	CASE 'FACTURA_NUEVA'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',i_parametros.cantidad_pagar)		
		dw_caja_pago.SetItem(1,'fecha_pago',i_parametros.fecha_pago)
		// Quitamos la posibilidad de colocar la fecha en el pago
		dw_caja_pago.object.fecha_pago.TabSequence = 0
		dw_caja_pago.object.fecha_pago.Background.Color = f_color_gris_claro()
		
	CASE 'COBROS_FACTURAS'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.cantidad_pagar)
		dw_caja_pago.SetItem(1,'entregado',i_parametros.cantidad_pagar)

	CASE 'MINUTAS'
		// Cambiamos la referencia al dw apuntado
		idw_minutas_detalle = i_parametros.dw
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',i_parametros.dw.GetItemNumber(1, 'total'))
		dw_caja_pago.SetItem(1,'entregado',i_parametros.dw.GetItemNumber(1, 'total'))		
		id_col = f_minutas_id_col(i_parametros.dw.GetItemString(1,'id_minuta'))
		this.title = 'Datos del Pago  ' +f_colegiado_apellido(id_col)
		tipo_gestion = i_parametros.dw.getitemstring(1, 'tipo_gestion')
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				dw_caja_pago.modify("tipo_carta_imprimir.visible = '1'")
				dw_caja_pago.modify("tipo_carta_imprimir_t.visible = '1'")
				dw_caja_pago.modify("copias.visible = '1'")
				dw_caja_pago.modify("copias_t.visible = '1'")
				tipo_carta_imprimir = "0#NINGUNA"
				// FALTA AVERIGUAR EL TIPO DE CARTA PARA TENERIFE
//				tipo_carta_imprimir = f_caja_tipo_carta_imprimir(i_parametros.dw.getitemstring(1, 'tipo_registro'), i_parametros.dw.getitemstring(fila, 'fase'), tipo_carta_imprimir, true)
				dw_caja_pago.setitem(1, "tipo_carta_imprimir", MidA(tipo_carta_imprimir, PosA(tipo_carta_imprimir,"#")+1, LenA(tipo_carta_imprimir) - PosA(tipo_carta_imprimir,"#")))
				
				// Juli$$HEX1$$e100$$ENDHEX$$n
			CASE  'COAATTZ' 
                       if tipo_gestion= 'C' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','03')
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','02')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				  end if
				   if tipo_gestion= 'S' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','03')
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','03')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				end if

                        if tipo_gestion= 'A' then
   					dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','03')
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','02')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				end if
				//Fin Juli$$HEX1$$e100$$ENDHEX$$n
			CASE 'COAATA'
				if tipo_gestion = 'A' then
					dw_caja_pago.modify("forma_pago.tabsequence = '0'")
					dw_caja_pago.modify("banco.tabsequence = '0'")
				end if
			///* CBI-127. Para casos con gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se imprimir$$HEX2$$e1002000$$ENDHEX$$por defecto copia de gastos. ALEXIS. 17/12/2009***/
			CASE 'COAATB'
					if tipo_gestion = 'C' then
						dw_originales_copias_obj_impr.setitem(1,'n_cop_gas', '00' )
					end if	
		END CHOOSE		
	
	CASE 'FASES'
		// Colocamos la cantidad a pagar en el datawindow                                             
		dw_caja_pago.SetItem(1,'total_pagar',idw_minutas_detalle.GetItemNumber(1, 'total'))
		dw_caja_pago.SetItem(1,'entregado',idw_minutas_detalle.GetItemNumber(1, 'total'))
		id_col = f_minutas_id_col(idw_minutas_detalle.GetItemString(1,'id_minuta'))
		this.title = 'Datos del Pago  ' +f_colegiado_apellido(id_col)
		tipo_gestion = idw_minutas_detalle.getitemstring(1, 'tipo_gestion')
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				dw_caja_pago.modify("tipo_carta_imprimir.visible = '1'")
				dw_caja_pago.modify("tipo_carta_imprimir_t.visible = '1'")
				dw_caja_pago.modify("copias.visible = '1'")
				dw_caja_pago.modify("copias_t.visible = '1'")
				tipo_carta_imprimir = "0#NINGUNA"
				// FALTA AVERIGUAR EL TIPO DE CARTA PARA TENERIFE
//				tipo_carta_imprimir = f_caja_tipo_carta_imprimir(i_parametros.dw.getitemstring(1, 'tipo_registro'), i_parametros.dw.getitemstring(fila, 'fase'), tipo_carta_imprimir, true)
				dw_caja_pago.setitem(1, "tipo_carta_imprimir", MidA(tipo_carta_imprimir, PosA(tipo_carta_imprimir,"#")+1, LenA(tipo_carta_imprimir) - PosA(tipo_carta_imprimir,"#")))
		END CHOOSE		
	// FIN MODIFICADO RICARDO 2004-08-12
END CHOOSE

	

// Obtenemos el correo del colegiado
string ls_postal, ls_email, ls_n_col
dw_originales_copias_obj_impr.setitem(1, 'direccion_email', f_devuelve_mail(id_col))
// Obtenemos si el colegiado quiere recibir los documentos impresos y por email
select recibir_c_postales,recibir_c_email into :ls_postal,:ls_email from colegiados where id_colegiado=:id_col;
if f_es_vacio(ls_postal) then ls_postal = 'N'
if f_es_vacio(ls_email) then ls_email = 'N'
dw_originales_copias_obj_impr.setitem(1, 'papel', ls_postal)
dw_originales_copias_obj_impr.setitem(1, 'email', ls_email)
// Si un colegiado no tiene marcado ning$$HEX1$$fa00$$ENDHEX$$n tipo de informe, marcar papel
if ls_postal='N' and ls_email='N' then dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')

// En Bizkaia piden que nunca est$$HEX2$$e9002000$$ENDHEX$$marcado email que lo tengan que marcar manualmente
///* En $$HEX1$$c100$$ENDHEX$$vila piden del mismo modo que no este marcado el env$$HEX1$$ed00$$ENDHEX$$o por correo electr$$HEX1$$f300$$ENDHEX$$nico. CBI-136. Alexis. 05/07/2010 *///
if g_colegio = 'COAATB' or g_colegio = 'COAATAVI' then 
	dw_originales_copias_obj_impr.setitem(1, 'email', 'N')
end if	

if tipo_gestion <> 'C' then
	// Solo dejamos la segunda
	dw_originales_copias_obj_impr.object.n_orig_hon_t.visible = false
	dw_originales_copias_obj_impr.object.n_orig_hon.visible = false
	dw_originales_copias_obj_impr.object.b_mas_oh.visible = false
	dw_originales_copias_obj_impr.object.b_men_oh.visible = false
	dw_originales_copias_obj_impr.object.n_cop_hon_t.visible = false
	dw_originales_copias_obj_impr.object.n_cop_hon.visible = false
	dw_originales_copias_obj_impr.object.b_mas_ch.visible = false
	dw_originales_copias_obj_impr.object.b_men_ch.visible = false
end if

if (g_colegio = 'COAATA' or g_colegio = 'COAATTFE') and tipo_gestion = 'A' then
	dw_originales_copias_obj_impr.object.n_orig_hon_t.visible = true
	dw_originales_copias_obj_impr.object.n_orig_hon.visible = true
	dw_originales_copias_obj_impr.object.b_mas_oh.visible = true
	dw_originales_copias_obj_impr.object.b_men_oh.visible = true
	dw_originales_copias_obj_impr.object.n_cop_hon_t.visible = true
	dw_originales_copias_obj_impr.object.n_cop_hon.visible = true
	dw_originales_copias_obj_impr.object.b_mas_ch.visible = true
	dw_originales_copias_obj_impr.object.b_men_ch.visible = true
end if


// Configuramos n$$HEX1$$fa00$$ENDHEX$$mero de originales y copias seg$$HEX1$$fa00$$ENDHEX$$n el tipo
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// Colocamos 2 copias de cada uno de los tipos de facturas
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				// Colocamos el foco en el campo de entregado
				dw_caja_pago.setcolumn("entregado")
			CASE 'COAATZ'
				tipo_gestion = i_parametros.dw.getitemstring(1, 'tipo_gestion')
				if tipo_gestion = 'C' then	dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				if tipo_gestion = 'S' then dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				if tipo_gestion = 'A' then dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATGU', 'COAATTER'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATLE'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','01')
			CASE 'COAATA'
				if tipo_gestion = 'C' or tipo_gestion = 'A' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				else
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','01')
				END IF
			CASE 'COAATGC'
				dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.metalico)
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
			CASE 'COAATNA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
			CASE 'COAATTGN', 'COAATLL'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			CASE 'COAATTEB', 'COAATMCA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			CASE 'COAATCC'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		END CHOOSE
		
	CASE 'FACTURA_NUEVA'
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
		
		dw_originales_copias_obj_impr.modify("n_orig_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Originales'")
		dw_originales_copias_obj_impr.modify("n_cop_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Copias'")
		dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')
		choose case g_colegio
		CASE 'COAATMCA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			case else
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','01')
		END CHOOSE
		
	CASE 'COBROS_FACTURAS'
		//MODIFICADO RICARDO 04-06-14
		// Incidencia 3272 : Pongo el n$$HEX2$$ba002000$$ENDHEX$$de orig. a 1 y cop. a 2, de gastos.
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','01')
		dw_originales_copias_obj_impr.modify("n_orig_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Originales'")
		dw_originales_copias_obj_impr.modify("n_cop_gas_t.text ='N$$HEX2$$ba002000$$ENDHEX$$Copias'")
		//FIN MODIFICADO RICARDO 04-06-14
		dw_originales_copias_obj_impr.setitem(1, 'papel', 'S')
		choose case g_colegio
		CASE 'COAATMCA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			case else
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		END CHOOSE
	CASE 'MINUTAS'
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				// Colocamos 2 copias de cada uno de los tipos de facturas
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				// Colocamos el foco en el campo de entregado
				dw_caja_pago.setcolumn("entregado")
			CASE 'COAATZ'
				if tipo_gestion = 'C' then	dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
				if tipo_gestion = 'S' then dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
				if tipo_gestion = 'A' then dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATGU', 'COAATTER'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','02')
			CASE 'COAATLE'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','01')
			CASE 'COAATGUI'
				if tipo_gestion = 'S' then
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.domiciliacion)
					dw_caja_pago.setitem(1, 'banco', '03')
				else
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.transferencia)
					dw_caja_pago.setitem(1, 'banco', '03')
				end if
			CASE 'COAATA'
				if tipo_gestion <> 'S' then
					dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
					dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				END IF
			CASE 'COAATGC'
				dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.metalico)				
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','02')
			CASE 'COAATNA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				if tipo_gestion = 'S' then
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.domiciliacion)
					dw_caja_pago.setitem(1, 'banco', '3008')
				else
					dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.transferencia)
					dw_caja_pago.setitem(1, 'banco', '3008')
				end if
			CASE 'COAATTGN', 'COAATLL'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			CASE 'COAATTEB', 'COAATMCA'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
			CASE 'COAATCC'
				dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
				dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		END CHOOSE
END CHOOSE

// Guardamos el total en una variable independientemente del tipo
idb_total = dw_caja_pago.getItemnumber(1,'total_pagar')


end event

event pfc_postopen;call super::pfc_postopen;dw_caja_pago.of_SetDropDownCalendar(True)
dw_caja_pago.iuo_calendar.of_register(dw_caja_pago.iuo_calendar.DDLB)
dw_caja_pago.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_caja_pago.iuo_calendar.of_SetInitialValue(True)

// Modificado David 11/02/2005
// Si el expediente es de visared, ponemos las copias a 0
string visared, id_fase, id_col
if idw_minutas_detalle.rowcount() > 0 then id_fase = idw_minutas_detalle.getitemstring(1, 'id_fase')
SELECT fases.e_mail INTO :visared FROM fases WHERE fases.id_fase = :id_fase   ;
if visared = 'V' then
	dw_originales_copias_obj_impr.setitem(1,'pdf','S')	
	if g_colegio <> 'COAATZ' then
		dw_originales_copias_obj_impr.setitem(1,'n_orig_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_orig_gas','00')
		dw_originales_copias_obj_impr.setitem(1,'n_cop_hon','00')
		dw_originales_copias_obj_impr.setitem(1,'n_cop_gas','00')
		dw_originales_copias_obj_impr.setitem(1,'papel','N')
	end if
	if g_colegio = 'COAATMU' then
		dw_caja_pago.setitem(1, 'forma_pago', g_formas_pago.domiciliacion)
		dw_caja_pago.setitem(1, 'banco', '03')
	end if	
else
	// El else vac$$HEX1$$ed00$$ENDHEX$$o lo pongo porque sino entra en el if cuando no toca
end if

// Se valida que si es tarragona se verifique que el colegiado tenga activo el campo de rebut bancario
if(g_colegio = 'COAATTGN' ) then
		//SCP-1998
		if lower(i_parametros.dw.describe("id_minuta.name")) = 'id_minuta' then
			id_col = f_minutas_id_col(i_parametros.dw.GetItemString(1,'id_minuta'))
		else
			if i_parametros.dw.GetItemString(1, 'tipo_factura') = '1' then 
				id_col = i_parametros.dw.GetItemString(1,'id_pagador')
			end if
		end if
		if g_forma_pago_por_defecto ='DB'  and not isnull(id_col) then
			
			if f_dame_otros_conceptos_colegiado(id_col, '04') = 'N' then
				Messagebox(g_titulo, 'No puede realizarse cobros por  rebut bancari.')
				dw_caja_pago.Setitem(1,'forma_pago','TR')
			end if
		end if
	
end if

//Modificado Jesus 25/11/09
//Poner el banco por defecto
if(g_colegio = 'COAATZ')then
	dw_caja_pago.SetItem(1,'banco',g_banco_por_defecto)
end if



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_caja_pagos
integer x = 1637
integer y = 1592
integer taborder = 70
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_caja_pagos
integer x = 1637
integer y = 1592
end type

type cb_1 from commandbutton within w_caja_pagos
event csd_generar_liquidacion ( datawindow dw_avisos )
integer x = 379
integer y = 1480
integer width = 402
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event csd_generar_liquidacion(datawindow dw_avisos);string tipo_min
double importe


//MODIFICACION YEXAIRA 23-05-08
//se valida que no se genere liquidaciones con forma de pago CP con importe negativo
if (dw_caja_pago.getitemstring(1,'forma_pago') = 'CP') and (dw_caja_pago.getitemnumber(1,'total_pagar')<0)then return  
//FIN MODIFICACION

// Primero determinamos si corresponde generar la liquidaci$$HEX1$$f300$$ENDHEX$$n
// En principio s$$HEX1$$f300$$ENDHEX$$lo para minutas de regularizaci$$HEX1$$f300$$ENDHEX$$n o devoluci$$HEX1$$f300$$ENDHEX$$n y negativas
tipo_min = LeftA(dw_avisos.getitemstring(1, 'tipo_minuta'),1)
importe = dw_avisos.getitemnumber(1, 'total_colegiado')

// Cuando no se devuelve musaat, el tipo de minuta es 00
if /*(tipo_min = '2' or tipo_min = '6') and*/ importe < 0 then
	// Pasamos los datos de la minuta a la liquidaci$$HEX1$$f300$$ENDHEX$$n
	st_liquidacion datos_liq
	datos_liq.id_fase 	= dw_avisos.getitemstring(1, 'id_minuta')
	datos_liq.id_col  	= dw_avisos.getitemstring(1, 'id_colegiado')
	datos_liq.importe		= importe * (-1)
	datos_liq.tipo	= '1'
	if tipo_min = '2' then 
		datos_liq.concepto = 'Regularizaci$$HEX1$$f300$$ENDHEX$$n '
		datos_liq.tipo	= '2'
	end if
	
	if tipo_min = '6' then
		datos_liq.concepto = 'Devoluci$$HEX1$$f300$$ENDHEX$$n '
		datos_liq.tipo	= '1'
	end if
	
	openwithparm(w_minutas_genera_liquidacion, datos_liq)
end if

end event

event clicked;this.enabled = false
dw_caja_pago.accepttext()
string mensaje, tipo_gestion, forma_pago, pagador, id_minuta, id_factura_ultima_generada, t_iva, aplica
string id_factura_ultima_generada_despues, orden_apunte, pagador_aviso, id_cliente, id_minuta_otra, id_fase
long fila, tipos_iva = 1, msg = 0, retorno
double saldo
datetime fecha_pag
w_fases_detalle w_ventana_fases
string id_expedi
st_liquidacion datos_liquidacion

SetPointer(HourGlass!)
mensaje = mensaje + f_valida(dw_caja_pago,'fecha_pago','NONULO','Debe especificar la fecha de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'forma_pago','NONULO','Debe especificar la forma de pago.')
mensaje = mensaje + f_valida(dw_caja_pago,'banco','NOVACIO','Debe especificar el banco.')

// Modificado Ricardo 04-03-10
double cambio
cambio = dw_caja_pago.getitemNumber(dw_caja_pago.getrow(), 'cambio') 
if cambio< -0.01 or isnull(cambio) then mensaje += "Debe indicar un importe suficientemente grande como para pagar la factura"
// FIN Modificado Ricardo 04-03-10

if mensaje<>'' Then
	Messagebox(g_titulo,mensaje,StopSign!)
	this.enabled = true
	return
End if

//Validaci$$HEX1$$f300$$ENDHEX$$n Cambio IVA Julio 2010
if(g_colegio <> 'COAATMCA' and g_colegio <> 'COAATCC')then
	fecha_pag = dw_caja_pago.GetItemDateTime(1,'fecha_pago')
else
	fecha_pag = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
end if
if IsValid(idw_minutas_detalle) then
	if idw_minutas_detalle.rowcount()>0 then
		DO
			CHOOSE CASE tipos_iva
				CASE 1
					t_iva	= idw_minutas_detalle.GetItemString(1, 't_iva_honos')
					aplica	= idw_minutas_detalle.GetItemString(1, 'aplica_honos')
					if(not(f_es_vacio(t_iva)) and aplica = 'S') then
						if gnv_ivajulio2010.of_valida_iva_fecha( fecha_pag, t_iva) < 0 then
							msg =  msg +1
						end if
					end if
				CASE 2
					t_iva	= idw_minutas_detalle.GetItemString(1, 't_iva_desplaza')
					aplica	= idw_minutas_detalle.GetItemString(1, 'aplica_desplaza')
					if(not(f_es_vacio(t_iva)) and aplica = 'S') then
						if gnv_ivajulio2010.of_valida_iva_fecha( fecha_pag, t_iva) < 0 then
							msg =  msg +1
						end if
					end if
				CASE 3
					t_iva	= idw_minutas_detalle.GetItemString(1, 't_iva_dv')
					aplica	= idw_minutas_detalle.GetItemString(1, 'aplica_dv')
					if(not(f_es_vacio(t_iva)) and aplica = 'S') then
						if gnv_ivajulio2010.of_valida_iva_fecha( fecha_pag, t_iva) < 0 then
							msg =  msg +1
						end if
					end if
				CASE 4
					t_iva	= idw_minutas_detalle.GetItemString(1, 't_iva_cip')
					aplica	= idw_minutas_detalle.GetItemString(1, 'aplica_cip')
					if(not(f_es_vacio(t_iva)) and aplica = 'S') then
						if gnv_ivajulio2010.of_valida_iva_fecha( fecha_pag, t_iva) < 0 then
							msg =  msg +1
						end if
					end if
				CASE 5
					t_iva	= idw_minutas_detalle.GetItemString(1, 't_iva_impresos')
					aplica	= idw_minutas_detalle.GetItemString(1, 'aplica_impresos')
					if(not(f_es_vacio(t_iva)) and aplica = 'S') then
						if gnv_ivajulio2010.of_valida_iva_fecha( fecha_pag, t_iva) < 0 then
							msg =  msg +1
						end if
					end if
			END CHOOSE
			tipos_iva++
		LOOP UNTIL tipos_iva > 5
	end if
end if
if(msg > 0)then
	retorno=messagebox(g_titulo,'El tipo de IVA de algunos conceptos del aviso no es v$$HEX1$$e100$$ENDHEX$$lido para esta fecha de pago. Desea continuar?',Exclamation!, YesNo!,1)
	if(retorno=2) then 
		return 
	end if
end if
//fin cambio

forma_pago = dw_caja_pago.getitemstring(1, 'forma_pago')

if dw_caja_pago.GetItemString(1,'incrementar')='N' then
	g_n_fact_automatico='N'
end if

// INC. 8583
string banco
banco = dw_caja_pago.GetItemString(1,'banco')
if g_colegio = "COAATA" and forma_pago = g_formas_pago.domiciliacion and banco = "09" then
	messagebox(g_titulo, "No se permite esta combinaci$$HEX1$$f300$$ENDHEX$$n de forma de pago y banco", stopsign!)
	this.enabled = true
	return
end if

// Modificado David 14/04/2005 - Deshabilitamos el dw para que no puedan modificar el banco, que seg$$HEX1$$fa00$$ENDHEX$$n dicen, genera facturas duplicadas
dw_caja_pago.enabled = false
// Modificado David 20/04/2005 - Deshabilitamos tambi$$HEX1$$e900$$ENDHEX$$n el bot$$HEX1$$f300$$ENDHEX$$n cancelar para que no puedan pinchar y dar error
cb_cancelar.enabled = false


dw_originales_copias_obj_impr.accepttext()
dw_originales_copias_obj_impr.Event csd_opciones_impresion()

// segun el tipo pasado procesamos
CHOOSE CASE i_parametros.tipo 
	CASE 'AVISOS'
		//	Caso en que hay que cobrar mas de una minuta (seg$$HEX1$$fa00$$ENDHEX$$n las marcadas por procesar)
		// Recorremos el datawindow para ver al cantidad a pagar
		FOR fila =1 to i_parametros.dw.RowCount()
			if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
				//Cogemos los par$$HEX1$$e100$$ENDHEX$$metros necesarios para realizar las validaciones
				dw_minutas_detalle.retrieve(i_parametros.dw.GetItemString(fila, 'id_minuta'))
				tipo_gestion = i_parametros.dw.GetItemString(fila, 'tipo_gestion')
				pagador = i_parametros.dw.GetItemString(fila, 'pagador')
				// ------------- Validaciones forma de pago
				if forma_pago = g_formas_pago.cargo then
					if tipo_gestion = 'C' then
						mensaje = cr + mensaje + 'Un Aviso Con Gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se puede cobrar por cuenta personal.' + cr + 'Cancele y cambie el tipo de gesti$$HEX1$$f300$$ENDHEX$$n si desea cobrar con cargo en cuenta del colegiado'
					elseif tipo_gestion = 'S'  then
						if pagador = '2' then // pagador es empresa
							mensaje = cr + mensaje + 'El pagador de este aviso es una empresa.' + cr + 'No puede cargarle al colegiado los gastos, paga la empresa.'
						end if
						if pagador = '3' then // pagador es cliente
							mensaje = cr + mensaje + 'El pagador de este aviso es un cliente.' + cr + 'No puede cargarle al colegiado los gastos, paga el cliente.'		
						end if		
					end if
				end if				
				if mensaje<>'' Then
					Messagebox(g_titulo,mensaje,StopSign!)
					this.enabled = true
					dw_caja_pago.enabled = true
					cb_cancelar.enabled = true
					return
				End if				
				// ------------- Fin validaciones Forma de Pago
				dw_minutas_detalle.SetItem(1,'fecha_pago',dw_caja_pago.GetItemDateTime(1,'fecha_pago'))
				dw_minutas_detalle.SetItem(1,'forma_pago',dw_caja_pago.GetItemString(1,'forma_pago'))
				dw_minutas_detalle.SetItem(1,'banco',dw_caja_pago.GetItemString(1,'banco'))
				string copias, origin
				// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro o autoliquidaci$$HEX1$$f300$$ENDHEX$$n separamos los originales y copias en las facturas de honos y gastos
				if tipo_gestion = 'S' then
					copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
				else
					copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
					origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
//					i_impresion_formato.copias = dw_originales_copias_obj_impr.GetItemstring(1, "n_orig_gas") + dw_originales_copias_obj_impr.GetItemstring(1, "n_orig_gas")
				end if

				// Tenemos que hacer esto antes para que salga el n$$HEX2$$ba002000$$ENDHEX$$de salida en las facturas
				CHOOSE CASE g_colegio
					CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA','COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER',  'COAATMCA', 'COAATLL'
						if f_fases_cambia_estado_fase_segun_pagado(idw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
							Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
							return
						end if
				END CHOOSE
				
				// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
				if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_caja_pago.getitemnumber(1, 'total_pagar')>0 then
					st_saldo_cuenta_bancaria_colegiado lst_entrada
					lst_entrada.id_colegiado = dw_minutas_detalle.getitemstring(1, 'id_colegiado')
					lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
					lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
				
					saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
				//	messagebox('', string(saldo))	
					if saldo < dw_caja_pago.getitemnumber(1, 'total_pagar') then
						openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
						return
					end if
				end if

				// Modificado Ricardo 2005-05-10
				st_generar_facturas_minutas parametros_factura_minuta

				// Modificado David 23/02/2006 - Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n a la funci$$HEX1$$f300$$ENDHEX$$n
				parametros_factura_minuta.impresion_formato 	= i_impresion_formato
				if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then		
					parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
				end if
				parametros_factura_minuta.dw_minuta 			= dw_minutas_detalle
				parametros_factura_minuta.num_orig 				= Integer(origin)
				parametros_factura_minuta.num_copias 			= Integer(copias)
				parametros_factura_minuta.regulariza_musaat	= false
				parametros_factura_minuta.movimiento_musaat	= true
				parametros_factura_minuta.tipo_movimiento_csd= dw_minutas_detalle.getitemstring(1, 'tipo_minuta')
				parametros_factura_minuta.tipo_prev				= ''
				parametros_factura_minuta.dw_factura			= dw_caja_pago
				// Para determinar la serie usamos el siguiente criterio:
				// -> Minutas SGC : Mirar el total colegiado. ES valido el 100% de las veces
				// -> Minutas CGC : Mirar el total colegiado. No es valido siempre, pero elegiremos este criterio por ser el mejor para el colegio (pueden salir mal las de colegiado)		
				// Modificado Paco 03/11/2005: Se amplia el criterio mirando tambi$$HEX1$$e900$$ENDHEX$$n el total_cliente cuando el total_colegiado = 0
				if (idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0) or &
				(idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')=0 and idw_minutas_detalle.GetItemNumber(1, 'total_cliente')<0) then
					parametros_factura_minuta.serie				= g_facturas_negativas_serie
				else
					parametros_factura_minuta.serie				= g_serie_fases
				end if
				// Modificado David 21/12/2005: Caso concreto de aviso CGC en que los honorarios son positivos y los gastos negativos
				if idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0 and &
					idw_minutas_detalle.GetItemNumber(1, 'total_cliente')>0 then
					parametros_factura_minuta.serie				= g_serie_fases
				end if
				
				// Modificado David 09/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
				if g_colegio = 'COAATTFE' then parametros_factura_minuta.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
				
				f_generar_facturas_minuta(parametros_factura_minuta)
//				f_generar_facturas_minuta(dw_minutas_detalle,Integer(origin),Integer(copias), false, true, dw_minutas_detalle.getitemstring(1, 'tipo_minuta'), '', dw_caja_pago)
				// FIN Modificado Ricardo 2005-05-10
				CHOOSE CASE dw_caja_pago.GetItemString(1,'forma_pago')
					CASE g_formas_pago.pendientes_abono
						// En este caso no lo colocamos como cobrado!
						dw_minutas_detalle.update()
					CASE ELSE
						dw_minutas_detalle.SetItem(1,'pendiente','N')
						dw_minutas_detalle.update()
				
						//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
						if dw_minutas_detalle.getitemstring(1, 'tipo_gestion') = 'C' then
							// VAciamos la estructura primero ya que sino no funciona correctamente :(
							setnull(datos_liquidacion.importe)
							// VAciamos el asunto
							setnull(datos_liquidacion.concepto)
							
							
							// Ahora ponemos lo que nos interesa
							datos_liquidacion.id_fase		= dw_minutas_detalle.getitemstring(1, 'id_minuta')
							datos_liquidacion.id_col		= dw_minutas_detalle.getitemstring(1, 'id_colegiado')
							datos_liquidacion.f_entrada	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
							datos_liquidacion.tipo			= '0'
							// Con estas formas de pago no se genera liquidaci$$HEX1$$f300$$ENDHEX$$n
							if forma_pago <> g_formas_pago.pendientes_abono and forma_pago <> g_formas_pago.otras_entidades then f_liquidacion(datos_liquidacion)
						end if
						// Lanzamos el ultimo evento
						parent.trigger event csd_comprobar_todo_cobrado('CAJA')
				END CHOOSE
				
				// Generaci$$HEX1$$f300$$ENDHEX$$n de liquidaciones para avisos con importe negativo
				event csd_generar_liquidacion(dw_minutas_detalle)
				
				// Marcar la prenda como pagada
				if dw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
					f_marcar_garantia_pagada(dw_minutas_detalle.getitemstring(1, 'id_fase'), dw_minutas_detalle.getitemstring(1, 'id_colegiado'), dw_minutas_detalle.getitemstring(1, 'id_cliente'))
				end if
			end if
		NEXT

		
		/* ESTA COPIADO DE LA OTRA VENTANA PERO LA VERDAD ES QUE NO SE PARA QUE SE UTILIZABA
		// Recuperar datos
		id_fase = dw_minuta.getitemstring(1, 'id_fase')
		id_col = dw_minuta.getitemstring(1, 'id_colegiado')
		id_cli = dw_minuta.getitemstring(1, 'id_cliente')
		nif_cli = f_dame_nif(id_cli)
		// Marcar la prenda como pagada
		if dw_minuta.getitemnumber(1, 'base_garantia') <> 0 then
			f_marcar_garantia_pagada(id_fase, id_col, nif_cli)
		end if
		// Movimiento funcionario para administraci$$HEX1$$f300$$ENDHEX$$n y no existen mas movimientos para este colegiado de este tipo
		if dw_minuta.getitemstring(1, 'tipo_minuta') = '14' then
			for i = 1 to idw_fases_src.rowcount()
				// Conque tenga un movimiento basta para no pasar el movimiento
				if idw_fases_src.getitemstring(i, 'id_col') = id_col then
					pasar_funcionario = false
					exit
				end if
			next
			if pasar_funcionario then
				// recuperar par$$HEX1$$e100$$ENDHEX$$metros de la base de datos
				datos_musaat.recuperar = true
				// Generar movimiento para MUSAAT
				datos_musaat.genera_movi = true
				datos_musaat.id_minuta = dw_minuta.getitemstring(1,'id_minuta')
				// NUEVO : tipo_csd
				datos_musaat.tipo_csd = dw_minuta.getitemstring(1,'tipo_minuta')
				datos_musaat.n_visado = dw_minuta.getitemstring(1, 'id_fase')
				datos_musaat.id_col = dw_minuta.getitemstring(1, 'id_colegiado')
				f_musaat_calcula_prima(datos_musaat)
			end if
		end if
		*/	
		
	CASE 'FACTURA_NUEVA'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
		// Modificado David 13/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then i_parametros.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
		i_parametros.impresion_formato = i_impresion_formato
		
	CASE 'COBROS_FACTURAS'
		// Devolvemos los datos que rellenados
		i_parametros.fecha_pago 	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')
		i_parametros.forma_pago 	= dw_caja_pago.getitemstring(1, 'forma_pago')
		i_parametros.banco 			= dw_caja_pago.GetItemString(1,'banco')
		i_parametros.concepto 		= dw_caja_pago.GetItemString(1,'asunto')
		i_parametros.n_originales	= dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		i_parametros.n_copias	 	= dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
		// Modificado David 13/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then i_parametros.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')
		i_parametros.impresion_formato = i_impresion_formato
		
	CASE 'MINUTAS', 'FASES'
		// Cobramos un aviso de factura
		// Validaciones forma de pago
		tipo_gestion = idw_minutas_detalle.getitemstring(1, 'tipo_gestion')
		pagador = idw_minutas_detalle.getitemstring(1, 'pagador')
		if forma_pago = g_formas_pago.cargo then
			if tipo_gestion = 'C' then
				mensaje = cr + mensaje + 'Un Aviso Con Gesti$$HEX1$$f300$$ENDHEX$$n de cobro no se puede cobrar por cuenta personal.' + cr + 'Cancele y cambie el tipo de gesti$$HEX1$$f300$$ENDHEX$$n si desea cobrar con cargo en cuenta del colegiado'
			elseif tipo_gestion = 'S'  then
				if pagador = '2' then // pagador es empresa
					mensaje = cr + mensaje + 'El pagador de este aviso es una empresa.' + cr + 'No puede cargarle al colegiado los gastos, paga la empresa.'
				end if
				if pagador = '3' then // pagador es cliente
					mensaje = cr + mensaje + 'El pagador de este aviso es un cliente.' + cr + 'No puede cargarle al colegiado los gastos, paga el cliente.'		
				end if		
			end if
		end if				
		if mensaje<>'' Then
			Messagebox(g_titulo,mensaje,StopSign!)
			this.enabled = true
			dw_caja_pago.enabled = true
			cb_cancelar.enabled = true
			return
		End if
		
		// ------------- Fin validaciones Forma de Pago		
		idw_minutas_detalle.SetItem(1,'fecha_pago',dw_caja_pago.GetItemDateTime(1,'fecha_pago'))
		idw_minutas_detalle.SetItem(1,'forma_pago',dw_caja_pago.GetItemString(1,'forma_pago'))
		idw_minutas_detalle.SetItem(1,'banco',dw_caja_pago.GetItemString(1,'banco'))

		
		// Si es con gesti$$HEX1$$f300$$ENDHEX$$n de cobro o autoliquidaci$$HEX1$$f300$$ENDHEX$$n separamos los originales y copias en las facturas de honos y gastos
		if tipo_gestion = 'S' then
			copias =  dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
			origin =  dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')
		else
			copias = dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_cop_gas')
			origin = dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_hon') + dw_originales_copias_obj_impr.getitemstring(1, 'n_orig_gas')			
		end if
		
		// Tenemos que hacer esto antes para que salga el n$$HEX2$$ba002000$$ENDHEX$$de salida en las facturas
		CHOOSE CASE g_colegio
			CASE 'COAATZ', 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATA', 'COAATGC', 'COAATNA', 'COAATTGN', 'COAATCC', 'COAATTEB', 'COAATTER',  'COAATMCA', 'COAATLL'
				if f_fases_cambia_estado_fase_segun_pagado(idw_minutas_detalle.getitemstring(1, 'id_fase'), 'MINUTAS')='-1' then
					Messagebox(g_titulo, "Error al actualizar el estado del contrato", stopsign!)
					return
				end if
		END CHOOSE		
		
		// Comprobamos el saldo de la cuenta del colegiado, si es negativo mostramos la ventana y no se deja cobrar
		if forma_pago = g_formas_pago.cuenta_personal and not f_es_vacio(g_prefijo_cuenta_bancaria_col) and dw_caja_pago.getitemnumber(1, 'total_pagar')>0 then
			lst_entrada.id_colegiado = idw_minutas_detalle.getitemstring(1, 'id_colegiado')
			lst_entrada.f_desde = datetime(date('01/01/'+g_ejercicio),time('00:00'))
			lst_entrada.f_hasta = datetime(Today(), time('23:59:59'))
		
			saldo = f_saldo_cuenta_bancaria_col(lst_entrada.id_colegiado, lst_entrada.f_desde, lst_entrada.f_hasta)
		//	messagebox('', string(saldo))	
			if saldo < dw_caja_pago.getitemnumber(1, 'total_pagar') then
				openwithparm(w_saldo_cuenta_bancaria_colegiado, lst_entrada)
				return
			end if
		end if

		id_factura_ultima_generada = f_siguiente_numero_informativo("FACTUEMI", 10)

		// Modificado David 23/02/2006 - Pasamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n a la funci$$HEX1$$f300$$ENDHEX$$n
		parametros_factura_minuta.impresion_formato 	= i_impresion_formato

		// Modificado Ricardo 2005-05-10
		if lower(dw_caja_pago.describe("fecha_factura.name")) = 'fecha_factura' then
			parametros_factura_minuta.fecha_factura = dw_caja_pago.GetItemDateTime(1,'fecha_factura')
		end if		
		parametros_factura_minuta.dw_minuta 				= idw_minutas_detalle
		parametros_factura_minuta.num_orig 				= Integer(origin)
		parametros_factura_minuta.num_copias 			= Integer(copias)
		parametros_factura_minuta.regulariza_musaat		= false
		parametros_factura_minuta.movimiento_musaat	= true
		parametros_factura_minuta.tipo_movimiento_csd	= idw_minutas_detalle.getitemstring(1, 'tipo_minuta')
		parametros_factura_minuta.tipo_prev				= ''
		parametros_factura_minuta.dw_factura				= dw_caja_pago
		// Para determinar la serie usamos el siguiente criterio:
		// -> Minutas SGC : Mirar el total colegiado. ES valido el 100% de las veces
		// -> Minutas CGC : Mirar el total colegiado. No es valido siempre, pero elegiremos este criterio por ser el mejor para el colegio (pueden salir mal las de colegiado)
		// Modificado Paco 03/11/2005: Se amplia el criterio mirando tambi$$HEX1$$e900$$ENDHEX$$n el total_cliente cuando el total_colegiado = 0
		if (idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0) or &
		(idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')=0 and idw_minutas_detalle.GetItemNumber(1, 'total_cliente')<0) then
			parametros_factura_minuta.serie				= g_facturas_negativas_serie
		else
			parametros_factura_minuta.serie				= g_serie_fases
		end if
		// Modificado David 21/12/2005: Caso concreto de aviso CGC en que los honorarios son positivos y los gastos negativos
		if idw_minutas_detalle.GetItemNumber(1, 'total_colegiado')<0 and &
			idw_minutas_detalle.GetItemNumber(1, 'total_cliente')>0 then
			parametros_factura_minuta.serie				= g_serie_fases
		end if

		// Modificado David 09/02/2006 - Pasamos los datos de la comisi$$HEX1$$f300$$ENDHEX$$n por pago con tarjeta
		if g_colegio = 'COAATTFE' then parametros_factura_minuta.comision_tarjeta = dw_caja_pago.GetItemNumber(1,'comision')

		f_generar_facturas_minuta(parametros_factura_minuta)
		//f_generar_facturas_minuta(idw_minutas_detalle,Integer(origin),Integer(copias), false, true, idw_minutas_detalle.getitemstring(1, 'tipo_minuta'), '', dw_caja_pago)
		// FIN Modificado Ricardo 2005-05-10
		
		// David 28/04/2006 - C$$HEX1$$f300$$ENDHEX$$digo extra$$HEX1$$ed00$$ENDHEX$$do y adaptado de la caja donde ya se rellena el campo orden_apunte
		id_factura_ultima_generada_despues = f_siguiente_numero_informativo("FACTUEMI", 10)
		if g_colegio = 'COAATGU' then
			// Para cada aviso ponemos el numero en las facturas generadas
			id_minuta = idw_minutas_detalle.GetItemString(1, 'id_minuta')
			pagador_aviso = idw_minutas_detalle.GetItemString(1, 'pagador')
			id_cliente = idw_minutas_detalle.GetItemString(1, 'id_cliente')
			id_fase = idw_minutas_detalle.GetItemString(1, 'id_fase')
			// Buscamos otro aviso de la fase con el mismo pagador para poner el mismo n$$HEX1$$fa00$$ENDHEX$$mero
			select id_minuta into :id_minuta_otra from fases_minutas where id_minuta <> :id_minuta and pagador = :pagador_aviso and id_cliente = :id_cliente and id_fase = :id_fase ;
			if not f_es_vacio (id_minuta_otra) then
				select orden_apunte into :orden_apunte from csi_facturas_emitidas where id_fase = :id_minuta_otra ;
			end if
			// Pillamos el siguiente numerito de cobros juntos
			if f_es_vacio(orden_apunte) then orden_apunte = f_siguiente_numero('ORDEN_APUNTE', 10)
			// Hacemos el update
			update csi_facturas_emitidas set orden_apunte = :orden_apunte where id_fase = :id_minuta and id_factura between :id_factura_ultima_generada and :id_factura_ultima_generada_despues ;
		end if
		// Fin David 28/04/2006		
		
		CHOOSE CASE dw_caja_pago.GetItemString(1,'forma_pago')
			CASE g_formas_pago.pendientes_abono
				// No hacemos nada
				idw_minutas_detalle.update()
			CASE ELSE
				idw_minutas_detalle.SetItem(1,'pendiente','N')
				idw_minutas_detalle.update()
				//Generar liquidaci$$HEX1$$f300$$ENDHEX$$n
				if idw_minutas_detalle.getitemstring(1, 'tipo_gestion') = 'C' then
					// VAciamos la estructura primero ya que sino no funciona correctamente :(
					setnull(datos_liquidacion.importe)
					// VAciamos el asunto
					setnull(datos_liquidacion.concepto)
					
					// Ahora ponemos lo que nos interesa
					datos_liquidacion.id_fase		= idw_minutas_detalle.getitemstring(1, 'id_minuta')
					datos_liquidacion.id_col		= idw_minutas_detalle.getitemstring(1, 'id_colegiado')
					if g_colegio='COAATCC' or g_colegio='COAATMCA' then
						datos_liquidacion.f_entrada	= dw_caja_pago.GetItemDateTime(1,'fecha_factura')
					else
						datos_liquidacion.f_entrada	= dw_caja_pago.GetItemDateTime(1,'fecha_pago')						
					end if
					datos_liquidacion.tipo			= '0'
					// Con estas formas de pago no se genera liquidaci$$HEX1$$f300$$ENDHEX$$n
					if forma_pago <> g_formas_pago.pendientes_abono and forma_pago <> g_formas_pago.otras_entidades then f_liquidacion(datos_liquidacion)
				end if
				// Lanzamos el ultimo evento
				parent.trigger event csd_comprobar_todo_cobrado('MINUTAS')
		END CHOOSE
		
		// Generaci$$HEX1$$f300$$ENDHEX$$n de liquidaciones para avisos con importe negativo
		event csd_generar_liquidacion(idw_minutas_detalle)

		// Marcar la prenda como pagada
		if idw_minutas_detalle.getitemnumber(1, 'base_garantia') <> 0 then
			f_marcar_garantia_pagada(idw_minutas_detalle.getitemstring(1, 'id_fase'), idw_minutas_detalle.getitemstring(1, 'id_colegiado'), idw_minutas_detalle.getitemstring(1, 'id_cliente'))
		end if		
		
		// Modificado David - 23/02/2005
		// En las regularizaciones el importe pagado es menor que el que figura en descuentos
		// y hay que pasar el contrato a abonado y retirado
		if g_colegio = 'COAATGC' then
			id_fase = idw_minutas_detalle.getitemstring(idw_minutas_detalle.RowCount(), 'id_fase')
			id_minuta = idw_minutas_detalle.getitemstring(1, 'id_minuta')
			f_fases_cambia_estado_regulariza_gc(id_fase,id_minuta)
		end if
		
		
END CHOOSE

datetime f_cierre,f_abono,f_tmp

///////////////////////////////////////////////////////////////////////////////////////////////////////
// NUEVO CRITERIO: ICN-19  1/10/2008
// Se cierra el expediente si no existe ninguna minuta en todo el expediente pendiente de cobro
///////////////////////////////////////////////////////////////////////////////////////////////////////		
if idw_minutas_detalle.describe("id_fase.name") = 'id_fase'  and idw_minutas_detalle.RowCount() > 0 then 
	id_fase = idw_minutas_detalle.getitemstring(idw_minutas_detalle.RowCount(), 'id_fase')
	tipo_gestion=idw_minutas_detalle.getitemstring(1, 'tipo_gestion')
	if g_cerrar_exp_minuta_final='S' and tipo_gestion='C' then
		f_fases_cierre_expedientes_congest(id_fase)		
	end if
end if




/*		////////////////////////////////////////////////////////////////////////////////////////
	//  Se cierra el expediente cuando se cobra una minuta final	(Agosto 2008)
	////////////////////////////////////////////////////////////////////////////////////////
	
	if g_cerrar_exp_minuta_final='S' and idw_minutas_detalle.getitemstring(idw_minutas_detalle.RowCount(), 't_minuta')='F' then

		id_fase = idw_minutas_detalle.getitemstring(idw_minutas_detalle.RowCount(), 'id_fase')		
		select id_expedi, f_abono into :id_expedi,:f_abono from fases where id_fase=:id_fase;			
		
		if idw_minutas_detalle.getitemstring(1, 'tipo_gestion')='C' then
			f_cierre= idw_minutas_detalle.GetItemDateTime(1,'fecha_pago')
		else
			f_cierre=f_abono
		end if
		
		//ACTUALIZAMOS SOLO SI LA FECHA NO TENIA VALOR
		select e.f_cierre into :f_tmp from fases f,expedientes e where f.id_fase=:id_fase and f.id_expedi=e.id_expedi;				
		if IsNull(f_tmp) then 
			update expedientes set cerrado='S',f_cierre=:f_cierre from fases f where f.id_fase=:id_fase and f.id_expedi=expedientes.id_expedi;
		end if				
		
		if (IsValid(g_detalle_fases)) then
			w_ventana_fases=g_detalle_fases 
			select id_expedi into :id_expedi from fases where id_fase=:id_fase;
			 w_ventana_fases.dw_fases_datos_exp.retrieve(id_expedi)
		end if
		
	end if	
*/		

post f_n_fact_automatico('S')


i_parametros.realizado = true
i_parametros.tipo_carta_imprimir = dw_caja_pago.getitemstring(1, 'tipo_carta_imprimir')
i_parametros.copias = dw_caja_pago.getitemnumber(1, 'copias')
closewithreturn(parent, i_parametros)

end event

type dw_minutas_detalle from u_dw within w_caja_pagos
integer x = 1637
integer y = 1592
integer width = 215
integer height = 164
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

event constructor;call super::constructor;this.visible = false
end event

type cb_cancelar from commandbutton within w_caja_pagos
integer x = 923
integer y = 1480
integer width = 402
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;// De momento
i_parametros.realizado = false
closewithreturn(parent, i_parametros)
end event

type dw_fases_informes from u_dw within w_caja_pagos
integer x = 1637
integer y = 1592
integer width = 215
integer height = 160
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_fases_informes"
end type

event constructor;call super::constructor;this.visible = false
end event

type dw_pagador from u_dw within w_caja_pagos
boolean visible = false
integer x = 1637
integer y = 348
integer width = 1413
integer height = 200
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_caja_pagador_cobro"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;// Buscamos la persona que se pretenda colocar como pagador

string id_persona, nulo
CHOOSE CASE dwo.name
	CASE 'b_buscar_colegiado'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			//Comprobamos que el colegiado existe
			if id_persona="-1" then
				messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
				this.setfocus()
				return -1
			else
				this.SetItem(1,'id_pagador',id_persona)
				this.SetItem(1,'nombre_pagador',f_colegiado_apellido(id_persona))				
				this.SetItem(1,'tipo_persona','C')				
			end if

	CASE 'b_buscar_cliente'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Clientes de Expedientes"
		g_busqueda.dw="d_lista_busqueda_clientes"
		id_persona=f_busqueda_clientes_exp()
	
		if id_persona="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de cliente v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_pagador',id_persona)
			this.SetItem(1,'nombre_pagador',f_dame_cliente(id_persona))				
			this.SetItem(1,'tipo_persona','P')				
		end if
		
	CASE 'b_borrar'
		setnull(nulo)
		this.SetItem(1,'id_pagador',nulo)
		this.SetItem(1,'nombre_pagador',nulo)
		this.SetItem(1,'tipo_persona',nulo)
END CHOOSE

end event

event constructor;call super::constructor;this.insertrow(0)
end event

type dw_caja_pago from u_dw within w_caja_pagos
event csd_comision_tarjeta ( )
event csd_aplicar_comision ( double comision )
integer x = 46
integer y = 28
integer width = 1577
integer height = 868
integer taborder = 20
string dataobject = "d_caja_pago"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_comision_tarjeta();// Por ahora s$$HEX1$$f300$$ENDHEX$$lo para el COAATTFE
if g_colegio <> 'COAATTFE' then return

// Si la forma de pago no es tarjeta no hacemos nada y reestablecemos importes
if this.getitemstring(1, 'forma_pago') <> 'TJ' then
	this.SetItem(1, 'total_pagar', idb_total)
	this.SetItem(1, 'entregado', idb_total)
	this.setitem(1, 'comision', 0)
	return
end if

// En funci$$HEX1$$f300$$ENDHEX$$n de los datos introducidos recuperamos la comisi$$HEX1$$f300$$ENDHEX$$n correspondiente
string banco, tipo
double comision

banco = this.getitemstring(1, 'banco')
tipo = this.getitemstring(1, 'tipo_tarjeta')

SELECT csi_bancos_comision_tarjeta.comision  
INTO :comision  
FROM csi_bancos_comision_tarjeta  
WHERE ( csi_bancos_comision_tarjeta.codigo = :banco ) AND  
		( csi_bancos_comision_tarjeta.tarjeta = :tipo )   ;

if isnull(comision) then comision = 0

this.setitem(1, 'comision', comision)

// Llamamos al evento que calcula el total despu$$HEX1$$e900$$ENDHEX$$s de la comisi$$HEX1$$f300$$ENDHEX$$n
event csd_aplicar_comision(comision)

end event

event csd_aplicar_comision(double comision);// Calculamos el total aplicando la comisi$$HEX1$$f300$$ENDHEX$$n y el iva de la comisi$$HEX1$$f300$$ENDHEX$$n y actualizamos importes
double total=0, imp_comision=0, iva=0

if i_parametros.tipo = 'AVISOS' then
	// Aplicamos la comision a cada uno de los totales para que no varien luego las cantidades
	double total_acum=0, imp_comision_acum=0, iva_acum=0, fila
	FOR fila =1 to i_parametros.dw.RowCount()
		if i_parametros.dw.GetItemString(fila, 'procesar') = 'S' then
			total = i_parametros.dw.getitemnumber(fila, 'total')
			
			imp_comision = f_redondea(total * comision / 100)
			imp_comision_acum += imp_comision
			iva = f_aplica_t_iva(imp_comision, f_csi_articulos_servicios_t_iva(g_codigos_conceptos.comision_tarjeta, g_empresa))
			iva_acum += iva
			total += imp_comision + iva
			total_acum += total
		end if
	NEXT
	this.SetItem(1,'total_pagar',total_acum)
	this.SetItem(1,'entregado',total_acum)
else		
	imp_comision = f_redondea(idb_total * comision / 100)
	iva = f_aplica_t_iva(imp_comision, f_csi_articulos_servicios_t_iva(g_codigos_conceptos.comision_tarjeta, g_empresa))
	total = idb_total + imp_comision + iva
	
	this.SetItem(1,'total_pagar',total)
	this.SetItem(1,'entregado',total)
end if

end event

event constructor;call super::constructor;this.insertrow(0)
datawindowchild dwc_forma_pago
// Capturamos el desplegable
this.getchild ('forma_pago', dwc_forma_pago)
dwc_forma_pago.settransobject (SQLCA)
dwc_forma_pago.setfilter("tipo_pago <>'CM'")
dwc_forma_pago.filter()

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE 'forma_pago'
		string tipo_pago, banco
		tipo_pago = string(data)
	   SELECT csi_formas_de_pago.banco_asociado  
		 INTO :banco  
		 FROM csi_formas_de_pago  
		WHERE csi_formas_de_pago.tipo_pago = :tipo_pago ;
		if(data ='ME' and (g_colegio = 'COAATTGN' or g_colegio = 'COAATTEB' or g_colegio='COAATLL'))then this.object.banco.protect = 1
		// Colocamos el banco
		this.setitem(row, 'banco', banco)
		
		CHOOSE CASE g_colegio
			CASE 'COAATTFE'
				CHOOSE CASE tipo_pago
					CASE 'TA', 'TJ', 'TR'
						// Si es talon o tarjeta le ponemos el total en importe a entregar
						this.setitem(row, 'entregado', this.GetItemNumber(row, 'total_pagar'))
				END CHOOSE
		END CHOOSE
		
		this.post event csd_comision_tarjeta()
		
	CASE 'banco', 'tipo_tarjeta'
		this.post event csd_comision_tarjeta()
		
	CASE 'comision'
		this.event csd_aplicar_comision(double(data))
		
	CASE 'copias'
		// No dejamos borrar
		if isnull(data) then return 2
		// No dejamos poner negativos
		if long(data)<0 then return 2
		
END CHOOSE



end event

type dw_originales_copias_obj_impr from u_dw within w_caja_pagos
event csd_opciones_impresion ( )
integer x = 37
integer y = 896
integer width = 1605
integer height = 476
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_caja_pagos_formato_impresion"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_opciones_impresion();// Se ocultan los campos del asunto email y del nombre del pdf porque a$$HEX1$$fa00$$ENDHEX$$n no hemos generado la factura
// y no sabemos cu$$HEX1$$e100$$ENDHEX$$l ser$$HEX2$$e1002000$$ENDHEX$$su n$$HEX1$$fa00$$ENDHEX$$mero. Se pasar$$HEX1$$e100$$ENDHEX$$n en la f_factura

//Datos de copias en papel
i_impresion_formato.papel	= GetItemstring(1, "papel")
i_impresion_formato.copias = long(GetItemstring(1, "n_orig_gas"))
//Datos de copias en email
i_impresion_formato.direccion_email=GetItemstring(1, "direccion_email")
i_impresion_formato.email 			= GetItemstring(1, "email")
i_impresion_formato.asunto_email = GetItemstring(1, "asunto_email")

if f_es_vacio(i_impresion_formato.asunto_email) then
	i_impresion_formato.asunto_email = 'Informaci$$HEX1$$f300$$ENDHEX$$n de facturas '
end if

i_impresion_formato.texto_email = ''

//Datos de copias en pdf
i_impresion_formato.visualizar_web 	= 'N'
i_impresion_formato.pdf = GetItemstring(1, "pdf") 
i_impresion_formato.nombre=getitemstring(1,'nombre')

if f_es_vacio(i_impresion_formato.nombre) then i_impresion_formato.nombre = 'Facturas'

i_impresion_formato.ruta_base 			= g_directorio_documentos_visared
i_impresion_formato.ruta_relativa 		= ''
i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf

//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
i_impresion_formato.modo_creacion	= 0		//Si el fichero ya existe, se sustituye

// INC. 8045 Se genera la factura en pdf como duplicado
i_impresion_formato.duplicado = 'N'
if long(GetItemstring(1, "n_orig_gas")) = 0 and long(GetItemstring(1, "n_cop_gas")) = 1 and (GetItemstring(1, "email") = 'S' or GetItemstring(1, "pdf") = 'S') then
	i_impresion_formato.duplicado = 'S'
	i_impresion_formato.copias = 1
end if

end event

event buttonclicked;call super::buttonclicked;string num

CHOOSE CASE dwo.name
	CASE 'b_mas_oh'
		num = this.getitemstring(1, 'n_orig_hon')
		if num < '98' then this.setitem(1, 'n_orig_hon', string(integer(num) + 1, '00'))
	CASE 'b_mas_ch'
		num = this.getitemstring(1, 'n_cop_hon')
		if num < '98' then this.setitem(1, 'n_cop_hon', string(integer(num) + 1, '00'))
	CASE 'b_mas_og'
		num = this.getitemstring(1, 'n_orig_gas')
		if num < '98' then this.setitem(1, 'n_orig_gas', string(integer(num) + 1, '00'))
	CASE 'b_mas_cg'
		num = this.getitemstring(1, 'n_cop_gas')
		if num < '98' then this.setitem(1, 'n_cop_gas', string(integer(num) + 1, '00'))
	CASE 'b_men_oh'
		num = this.getitemstring(1, 'n_orig_hon')
		if num > '00' then this.setitem(1, 'n_orig_hon', string(integer(num) - 1, '00'))
	CASE 'b_men_ch'
		num = this.getitemstring(1, 'n_cop_hon')
		if num > '00' then this.setitem(1, 'n_cop_hon', string(integer(num) - 1, '00'))
	CASE 'b_men_og'
		num = this.getitemstring(1, 'n_orig_gas')
		if num > '00' then this.setitem(1, 'n_orig_gas', string(integer(num) - 1, '00'))
	CASE 'b_men_cg'
		num = this.getitemstring(1, 'n_cop_gas')
		if num > '00' then this.setitem(1, 'n_cop_gas', string(integer(num) - 1, '00'))
END CHOOSE

end event

