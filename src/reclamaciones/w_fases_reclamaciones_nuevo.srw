HA$PBExportHeader$w_fases_reclamaciones_nuevo.srw
forward
global type w_fases_reclamaciones_nuevo from w_lista
end type
type rb_1 from radiobutton within w_fases_reclamaciones_nuevo
end type
type rb_2 from radiobutton within w_fases_reclamaciones_nuevo
end type
type cb_generar from commandbutton within w_fases_reclamaciones_nuevo
end type
type st_3 from statictext within w_fases_reclamaciones_nuevo
end type
type gb_consulta from groupbox within w_fases_reclamaciones_nuevo
end type
type gb_accion from groupbox within w_fases_reclamaciones_nuevo
end type
type cb_imprimir from commandbutton within w_fases_reclamaciones_nuevo
end type
type cb_grabar from commandbutton within w_fases_reclamaciones_nuevo
end type
type st_2 from statictext within w_fases_reclamaciones_nuevo
end type
type cb_anular_fases from u_cb within w_fases_reclamaciones_nuevo
end type
type dw_consulta from u_dw within w_fases_reclamaciones_nuevo
end type
type dw_genera_cartas from u_dw within w_fases_reclamaciones_nuevo
end type
type dw_remesa from u_dw within w_fases_reclamaciones_nuevo
end type
type dw_avisos_pendientes from u_dw within w_fases_reclamaciones_nuevo
end type
type dw_genera_cartas_historico from u_dw within w_fases_reclamaciones_nuevo
end type
type cb_actualizar_cartas_minutas from commandbutton within w_fases_reclamaciones_nuevo
end type
type cb_marcar from commandbutton within w_fases_reclamaciones_nuevo
end type
type cb_desmarcar from commandbutton within w_fases_reclamaciones_nuevo
end type
type cb_ocultar from commandbutton within w_fases_reclamaciones_nuevo
end type
type dw_preview_carta from u_dw within w_fases_reclamaciones_nuevo
end type
type cb_buscar from commandbutton within w_fases_reclamaciones_nuevo
end type
type cb_limpiar from commandbutton within w_fases_reclamaciones_nuevo
end type
end forward

global type w_fases_reclamaciones_nuevo from w_lista
integer width = 4599
integer height = 2284
string title = "Reclamaci$$HEX1$$f300$$ENDHEX$$n de Avisos"
event csd_configura_ventana ( )
event csd_imprimir_carta ( long fila,  boolean b_previsualizar )
event type double csd_detalle_cartas ( ref datastore ds_datos,  ref datastore ds_lineas )
event csd_opciones_impresion ( )
rb_1 rb_1
rb_2 rb_2
cb_generar cb_generar
st_3 st_3
gb_consulta gb_consulta
gb_accion gb_accion
cb_imprimir cb_imprimir
cb_grabar cb_grabar
st_2 st_2
cb_anular_fases cb_anular_fases
dw_consulta dw_consulta
dw_genera_cartas dw_genera_cartas
dw_remesa dw_remesa
dw_avisos_pendientes dw_avisos_pendientes
dw_genera_cartas_historico dw_genera_cartas_historico
cb_actualizar_cartas_minutas cb_actualizar_cartas_minutas
cb_marcar cb_marcar
cb_desmarcar cb_desmarcar
cb_ocultar cb_ocultar
dw_preview_carta dw_preview_carta
cb_buscar cb_buscar
cb_limpiar cb_limpiar
end type
global w_fases_reclamaciones_nuevo w_fases_reclamaciones_nuevo

type variables
// CONSTANTES
CONSTANT string is_delimitador = '.#.'



datawindowchild idwc_generaciones
// Variable de acci$$HEX1$$f300$$ENDHEX$$n : valores posibles : 	CONSULTA/GENERACION
string i_accion = 'CONSULTA' 
string is_tipo_carta
long il_cuantos_seleccionados = 0

st_tipo_carta_datos ist_tipo_carta_datos


long il_color
long il_n_reg_salida
string is_cobro_conjunto
n_csd_impresion_formato i_impresion_formato
end variables

forward prototypes
public function string wf_dame_n_remesa (ref datastore ds_remesas, string tipo_carta)
end prototypes

event csd_configura_ventana();datetime fecha_tope

CHOOSE CASE g_colegio
	CASE 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATTER'
		CHOOSE CASE g_estilo_carta 
			CASE 'MINUTAS'
//				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_min_za'
			CASE 'CONTRATOS'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_con_gu'
			CASE 'EXPEDIENTES'
//				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_exp_za'
		END CHOOSE
	CASE 'COAATNA'
		CHOOSE CASE g_estilo_carta 	
			CASE 'EXPEDIENTES'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_exp_na'
			CASE 'MINUTAS'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_min_za'
			CASE 'CONTRATOS'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_con_za'				
		END CHOOSE

	CASE ELSE
		CHOOSE CASE g_estilo_carta 
			CASE 'MINUTAS'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_min_za'
			CASE 'CONTRATOS'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_con_za'
			CASE 'EXPEDIENTES'
				dw_avisos_pendientes.dataobject = 'd_reclamaciones_avisos_pendientes_exp_za'
		END CHOOSE
END CHOOSE
dw_avisos_pendientes.SetTransObject(SQLCA)



choose case i_accion
	case 'GENERACION'
		if isnull(g_anyos_reclam_avisos) or g_anyos_reclam_avisos=0 then 
			fecha_tope = datetime(date('01/01/1900')) // No hay restricci$$HEX1$$f300$$ENDHEX$$n de a$$HEX1$$f100$$ENDHEX$$os
		else
			if day(today()) <> 29 and month(today()) <> 2 then 
				fecha_tope = datetime(date(string(day(today()))+"/"+string(month(today()))+"/"+string(year(today()) - g_anyos_reclam_avisos)), time("00:00"))
			else
				// usamos el dia 28 y punto!
				fecha_tope = datetime(date("28/02/"+string(year(today()) - g_anyos_reclam_avisos)), time("00:00"))
			end if
		end if
		
		cb_generar.visible = true
		cb_imprimir.visible = true
		cb_grabar.visible = true
		cb_actualizar_cartas_minutas.visible = true
		cb_ocultar.visible = false
		cb_marcar.visible = true
		cb_desmarcar.visible = true
		dw_consulta.dataobject = 'd_fases_reclamaciones_genera_consulta_nu'
		dw_lista.visible = false
		dw_avisos_pendientes.visible = true
		dw_remesa.visible = true
		dw_genera_cartas.visible = true	
		dw_genera_cartas_historico.visible = true
		gb_consulta.text = 'Generaci$$HEX1$$f300$$ENDHEX$$n de Remesa de Cartas, Generaci$$HEX1$$f300$$ENDHEX$$n Manual'			
		cb_anular_fases.visible=false
		dw_remesa.reset()
		dw_genera_cartas_historico.reset()
		dw_preview_carta.visible = false
	case else
		cb_generar.visible = false		
		cb_imprimir.visible = false
		cb_grabar.visible = false
		cb_actualizar_cartas_minutas.visible = false
		cb_ocultar.visible = false
		cb_marcar.visible = false
		cb_desmarcar.visible = false
		dw_consulta.dataobject = 'd_fases_reclamaciones_consulta_nuevo'
		dw_lista.visible = true	
		dw_avisos_pendientes.visible = false
		dw_remesa.visible = false
		dw_genera_cartas.visible = false	
		dw_genera_cartas_historico.visible = false
		gb_consulta.text = 'Consulta de Cartas de Reclamaci$$HEX1$$f300$$ENDHEX$$n, Reimpresiones, Hist$$HEX1$$f300$$ENDHEX$$rico'	
		cb_anular_fases.visible=false
		dw_preview_carta.visible = false
		
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

// Colocamos el valor de la fecha tope calculada
if dw_consulta.Describe("fecha_tope.Name")="fecha_tope" then dw_consulta.setitem(1, 'fecha_tope', fecha_tope)

// Colocamos como visibles los botones de imprimir
cb_imprimir.enabled=true
//cb_imprimir.visible=true

end event

event csd_imprimir_carta(long fila, boolean b_previsualizar);string tipo_carta, dataobject, id_carta,id_minuta
st_tipo_carta_datos st_tipo_carta_datos
long indice, fila_reclamacion
// Variables para pillar los datos del aviso
datastore ds_reclamaciones_datos_minuta, ds_lineas
string avisos_n_aviso, codpos, cod_provincia, provincia, descripcion_via, n_calle, n_registro_min,n_aviso_min, n_exp_min, n_visado_min
string tipo_act_min, tipo_obra_min, desc_min, observ_min, id_colegiado_min, id_cliente_min, id_repre, id_fase
string direccion_cliente, direccion_colegiado, poblacion_cliente, poblacion_colegiado, colegiado_min, direccion_obra
string poblacion_min,n_reg_salida, codpostal, n_colegiado
datetime fecha
double total_aviso, importe_irpf,base_irpf

// Variables para el rellenado de la carta
string n_exp, n_registro, tipo_act, tipo_obra, emplazamiento, descripcion, cliente, colegiado, lugar_fecha, destinatario
string direccion, poblacion, comunicado, n_aviso, observ, n_visado, destinatario_carta, direccion_carta, poblacion_carta
datetime f_ult_reclamacion, f_entrada, f_hoy
long pos_destinatario, pos_direccion, pos_poblacion, ll_iteracion_destinatario
double importe, irpf
long ll_iteraciones_cartas_distintas, ll_numero_cartas_distintas,copias
st_reg_es_series_rutas st_rutas

setpointer(hourglass!)


// Cogemos el tipo de carta de la lista
tipo_carta = dw_genera_cartas_historico.getitemstring(fila, 'tipo_reclamacion')
id_carta   = dw_genera_cartas_historico.getitemstring(fila, 'id_carta')

// Recuperamos la informaci$$HEX1$$f300$$ENDHEX$$n asociada a dicha carta
st_tipo_carta_datos = f_dame_datos_tipo_carta(tipo_carta)
dataobject = st_tipo_carta_datos.dataobject	

// GENERACION DE LA CARTA E IMPRESION!!!
dw_preview_carta.dataobject = dataobject
dw_preview_carta.insertrow(0)		
// Creamos un datastore para recuperar datos
ds_reclamaciones_datos_minuta = create datastore
ds_reclamaciones_datos_minuta.dataobject = 'd_reclamaciones_datos_minuta'
ds_reclamaciones_datos_minuta.SetTransObject(SQLCA)
// Creamos un datastore para tener los datos de las lineas
// Insertamos las lineas de los conceptos en el detalle de la carta
// En Zaragoza los conceptos son: Honorarios, Desplazamientos, DV y Libros. En Guadalajara es igual.
ds_lineas = create datastore
CHOOSE CASE g_colegio
	CASE 'COAATGU', 'COAATLE', 'COAATAVI','COAATNA', 'COAATTER'
		ds_lineas.dataobject = 'd_notif_detalle_gu'
	CASE 'COAATCC'
		ds_lineas.dataobject = 'd_notif_detalle_na'
	CASE ELSE
		ds_lineas.dataobject = 'd_notif_detalle_za'
END CHOOSE

// Inicializacion de las variables
n_exp 			= ''
n_registro 		= ''
tipo_act 		= ''
tipo_obra 		= ''
emplazamiento 	= ''
descripcion		= ''
cliente			= ''	
colegiado		= ''
n_aviso			= ''
observ			= ''
base_irpf = 0
ll_iteracion_destinatario = 0
long n_col
n_col=0

// Averiguamos la fecha de la ultima reclamacion
fila_reclamacion = dw_genera_cartas.find("id_carta ='"+id_carta+"'", 1, dw_genera_cartas.RowCount())
f_ult_reclamacion = dw_genera_cartas.GetItemDateTime(fila_reclamacion, 'f_ultima_reclamacion')
//n_reg_salida = dw_genera_cartas.GetItemString(fila_reclamacion, 'n_registro')
//n_reg_salida = 'RECLAM-'+ f_siguiente_numero_registro_es('RECLAM_FAS',10)
// EL N$$HEX2$$ba002000$$ENDHEX$$de REGISTRO DE SALIDA SE CALCULA EN EL OBJETO n_impresion_formato.
n_reg_salida = 'REG-XXXXXXXXXX' 
f_entrada = datetime(date("01/01/3000"), time("00:00")) // Creo que es suficientemente lejana
FOR indice = 1 TO dw_genera_cartas_historico.RowCount()
	if id_carta = dw_genera_cartas_historico.getitemstring(indice, 'id_carta') then
		// Cogemos el id de la minuta
		id_minuta = dw_genera_cartas_historico.getitemstring(indice, 'id_minuta')
		
		// Si no recupera es que hay algun error
		if ds_reclamaciones_datos_minuta.retrieve(id_minuta)=0 then continue 

		// COAATGU - Excepci$$HEX1$$f300$$ENDHEX$$n
		// En las actas de aprobaci$$HEX1$$f300$$ENDHEX$$n el formato de la carta es el de SGC
		string concepto_honos
		concepto_honos = upper(ds_reclamaciones_datos_minuta.getitemstring(1, 'fases_minutas_concepto_honos'))
		//Andr$$HEX1$$e900$$ENDHEX$$s 10/10/2005: S$$HEX1$$f300$$ENDHEX$$lo para COAATGU
		if g_colegio='COAATGU' then
			if concepto_honos = 'APROBACI$$HEX1$$d300$$ENDHEX$$N DE PLAN'  or concepto_honos = 'APROBACION DE PLAN' or concepto_honos = 'APROBACION DEL PLAN'  or concepto_honos = 'APROBACION DEL PLAN'  then
				dw_preview_carta.dataobject = 'd_carta_reclamacion_1_sgc_gu'
				dw_preview_carta.insertrow(0)
				st_tipo_carta_datos.tipo_destinatario = 'C'
			end if			
		end if
		
		// Optamos por coger los datos desde el primer aviso... este criterio se puede cambiar....
		if indice = fila then
			// Rellenamos los datos b$$HEX1$$e100$$ENDHEX$$sicos de la carta. Paco dice de pillar la direcci$$HEX1$$f300$$ENDHEX$$n directamente de ese aviso
			direccion_obra = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_emplazamiento'); if isnull(direccion_obra) then direccion_obra = ''
			descripcion_via = f_devuelve_tipo_emplazamiento(ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_tipo_via_emplazamiento')); if isnull(descripcion_via) then descripcion_via = ''
			n_calle = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_n_calle'); if isnull(n_calle) then n_calle = ''
			codpos =  ds_reclamaciones_datos_minuta.getitemstring(1, 'fases_poblacion');if f_es_vacio(codpos) then codpos = ''			
			poblacion_min = f_poblacion_descripcion(codpos);if f_es_vacio(poblacion_min) then poblacion_min = ''
			codpostal = f_devuelve_cod_postal(codpos)			
			cod_provincia = f_devuelve_cod_provincia(codpos)
			provincia = f_provincia_descripcion(cod_provincia);if f_es_vacio(provincia) then provincia = ''			
			// Concatenamos la direccion
			emplazamiento = descripcion_via + ' ' + direccion_obra + ' ' + n_calle + ' ' + LeftA(codpostal,5) + ' ' + poblacion_min //+ ' ' + provincia
		end if
		
		// Cogemos el indicador de la fase
		id_fase = ds_reclamaciones_datos_minuta.getitemstring(1, 'fases_minutas_id_fase')

		// La fecha de entrada es la menor
		if ds_reclamaciones_datos_minuta.GetItemDateTime(1, 'fases_f_entrada')<f_entrada then f_entrada = ds_reclamaciones_datos_minuta.GetItemDateTime(1, 'fases_f_entrada')
		// Si la fecha de inicio del contrato no es nula, cogemos esa como fecha de entrada
		if not isnull(ds_reclamaciones_datos_minuta.GetItemDateTime(1, 'expedientes_f_inicio')) then f_entrada = ds_reclamaciones_datos_minuta.GetItemDateTime(1, 'expedientes_f_inicio')
		
		// Numero de expediente
		n_exp_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'expedientes_n_expedi')
		if PosA(n_exp, n_exp_min)=0 then
			if LenA(n_exp)>0 then n_exp = n_exp+is_delimitador
			n_exp += n_exp_min
		end if
		
		// Numero de registro
		n_registro_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_n_registro')
		if PosA(n_registro, n_registro_min)=0 then
			if LenA(n_registro)>0 then n_registro = n_registro+is_delimitador
			n_registro += n_registro_min
		end if

		// Numero de avisos
		n_aviso_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_minutas_n_aviso')
		if PosA(n_aviso, n_aviso_min)=0 then
			if LenA(n_aviso)>0 then n_aviso = n_aviso+is_delimitador
			n_aviso += n_aviso_min
		end if

		// Numero de visado
		n_visado_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_archivo')
		if PosA(n_visado, n_visado_min)=0 then
			if LenA(n_visado)>0 then n_visado = n_visado+is_delimitador
			n_visado += n_visado_min
		end if
		
		// Diferenciamos minutas iniciales y finales
		if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI' or g_colegio='COAATNA' or g_colegio='COAATTER' then
			string tipo_mta_min, tipo_mta
			tipo_mta_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_minutas_t_minuta')
			if PosA(tipo_mta, tipo_mta_min)=0 then
				if LenA(tipo_mta)>0 then tipo_mta = tipo_mta+is_delimitador
				tipo_mta += tipo_mta_min
			end if
		end if		
		
		// Tipo de actuacion
		tipo_act_min = f_dame_desc_tipo_actuacion(ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_fase'))
		if PosA(tipo_act, tipo_act_min)=0 then
			if LenA(tipo_act)>0 then tipo_act = tipo_act+is_delimitador
			tipo_act += tipo_act_min
		end if
		
		// Tipos de obra
		tipo_obra_min = f_dame_desc_tipo_obra(ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_tipo_trabajo'))
		if PosA(tipo_obra, tipo_obra_min)=0 then
			if LenA(tipo_act)>0 then tipo_obra = tipo_obra+is_delimitador
			tipo_obra += tipo_obra_min
		end if
		
		// Desripcion
		desc_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fase_desc')
		if not f_es_vacio(desc_min) then
			if PosA(descripcion, desc_min)=0 then
				if LenA(descripcion)>0 then descripcion = descripcion+is_delimitador
				descripcion += desc_min
			end if
		end if
		
		// observaciones
		observ_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'observaciones')
		if not f_es_vacio(observ_min) then
			if PosA(observ, observ_min)=0 then
				if LenA(observ)>0 then observ = observ+is_delimitador
				observ += observ_min
			end if
		end if
		
		// lista_avisos
		observ_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'observaciones')
		if not f_es_vacio(observ_min) then
			if PosA(observ, observ_min)=0 then
				if LenA(observ)>0 then observ = observ+is_delimitador
				observ += observ_min
			end if
		end if		
		
		// Colegiado
		string nif
		id_colegiado_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_minutas_id_colegiado')
		colegiado_min = f_colegiado_nombre_apellido(id_colegiado_min)
		direccion_colegiado = f_domicilio_activo(id_colegiado_min)
		poblacion_colegiado = f_poblacion_activa(id_colegiado_min)
		n_colegiado = f_colegiado_n_col(id_colegiado_min)
		
		if g_colegio = 'COAATLE' then colegiado_min += ' n$$HEX2$$ba002000$$ENDHEX$$' + f_colegiado_n_col(id_colegiado_min) 
		
		if PosA(colegiado, colegiado_min)= 0 then 
			if g_colegio = 'COAATNA' then
				select nif into :nif from colegiados where id_colegiado=:id_colegiado_min;
				direccion_colegiado = f_domicilio_fiscal(id_colegiado_min)
				poblacion_colegiado = f_poblacion_fiscal(id_colegiado_min)
				colegiado_min += '   '+nif+'~n'+direccion_colegiado+'   '+poblacion_colegiado+'~n'
				colegiado += colegiado_min+'~n'
				n_col++
			else
				colegiado += colegiado_min+is_delimitador
			end if
		end if


		
		// Cliente

			id_cliente_min = ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_minutas_id_cliente')
		SELECT fases_clientes.id_representante  INTO :id_repre FROM fases_clientes  WHERE ( fases_clientes.id_fase = :id_fase ) AND ( fases_clientes.id_cliente = :id_cliente_min ) AND ( fases_clientes.id_representante is not null ) AND ( fases_clientes.reclamar_representante = 'S' )   ;
		if not f_es_vacio(id_repre) then
			cliente = f_dame_cliente(id_repre)
			direccion_cliente = f_dame_domicilio(id_repre)
			poblacion_cliente = f_retorna_poblacion(id_repre)
		else
			cliente = f_dame_cliente(id_cliente_min)
			direccion_cliente = f_dame_domicilio(id_cliente_min)
			poblacion_cliente = f_retorna_poblacion(id_cliente_min)
		end if
		
		// Son cada una de las minutas que deben aparecer en esta carta
		if st_tipo_carta_datos.tiene_detalle = 'S' then
			// hay que rellenar los importes segun cada minura
			base_irpf += this.trigger event csd_detalle_cartas(ds_reclamaciones_datos_minuta, ds_lineas)
			if ds_lineas.rowcount()=0 then
				// Cuanod no hay detalle, saltamos a la siguiente iteracion
				continue
//				destroy dw_preview_carta
//				destroy ds_reclamaciones_datos_minuta
//				destroy ds_lineas
//				return
			else
				importe = ds_lineas.GetitemNumber(1, 'total_pagar')
				// Si el importe es 0 que no muestre el detalle
				if importe <> 0 then
					dw_preview_carta.object.dw_notif_detalle[1].Object.Data = ds_lineas.Object.data
				end if
			end if
		else
			// Tenemos que calcular el importe
			base_irpf += this.trigger event csd_detalle_cartas(ds_reclamaciones_datos_minuta, ds_lineas)
			importe = ds_lineas.GetitemNumber(1, 'total_pagar')
//			if ds_reclamaciones_datos_minuta.GetItemString(1, 'fases_minutas_tipo_gestion') = 'C' then
//				importe += ds_reclamaciones_datos_minuta.GetItemNumber(1, 'fases_minutas_total_cliente')
//			else
//				importe += ds_reclamaciones_datos_minuta.GetItemNumber(1, 'fases_minutas_total_colegiado')
//			end if
		end if

		if st_tipo_carta_datos.tipo_destinatario = 'P' then
			i_impresion_formato.direccion_email = ""
			i_impresion_formato.id_receptor=id_cliente_min
			i_impresion_formato.tipo_receptor='T'			
			// Meto el cliente como destinatario
			if PosA(destinatario, cliente)= 0 then
				destinatario += cliente + is_delimitador
				direccion += direccion_cliente + is_delimitador
				poblacion += poblacion_cliente + is_delimitador
			end if
		elseif st_tipo_carta_datos.tipo_destinatario = 'C' then
			i_impresion_formato.direccion_email = f_devuelve_mail(id_colegiado_min)
			i_impresion_formato.id_receptor=id_colegiado_min
			i_impresion_formato.tipo_receptor='C'
			// Meto el colegiado como destinatario
			if PosA(destinatario, colegiado_min)= 0 then
				// David 15/03/2006 - A partir del segundo colegiado a$$HEX1$$f100$$ENDHEX$$ado el punto al final porque luego lo recorta
				if destinatario = '' then 
					destinatario += colegiado_min + is_delimitador
					direccion += direccion_colegiado + is_delimitador
					poblacion += poblacion_colegiado + is_delimitador					
				else
					destinatario += colegiado_min + '.' + is_delimitador
					direccion += direccion_colegiado + '.' + is_delimitador
					poblacion += poblacion_colegiado + '.' + is_delimitador					
				end if				
			end if
		else
			
			// Se tratar$$HEX1$$ed00$$ENDHEX$$a de la cuarta carta y son destinatarios los clientes y los colegiados, a parte del abogado.
			string sl_destinatario_cliente_lista, sl_direccion_cliente_lista, sl_poblacion_cliente_lista
			string sl_destinatario_colegiado_lista, sl_direccion_colegiado_lista, sl_poblacion_colegiado_lista
			if PosA(sl_destinatario_cliente_lista, cliente)= 0 then
				sl_destinatario_cliente_lista += cliente + is_delimitador
				sl_direccion_cliente_lista += direccion_cliente + is_delimitador
				sl_poblacion_cliente_lista += poblacion_cliente + is_delimitador
			end if			
			if PosA(sl_destinatario_colegiado_lista, colegiado_min)= 0 then
				sl_destinatario_colegiado_lista += colegiado_min + is_delimitador
				sl_direccion_colegiado_lista += direccion_colegiado + is_delimitador
				sl_poblacion_colegiado_lista += poblacion_colegiado + is_delimitador
			end if			
			
		end if
	end if
NEXT


long num,i
string cli	,otros_cli
datastore ds_cli_min
ds_cli_min=create datastore
ds_cli_min.dataobject='d_fases_minutas'
ds_cli_min.SetTransObject(SQLCA)
num=ds_cli_min.retrieve(id_fase)


for i=1 to num
	//if ds_cli_min.GetItemString(i,'id_cliente')=id_cliente_min then continue
	cli=ds_cli_min.GetItemString(i,'clientes_apellidos')
	if f_es_vacio(cli) then 
		cli=ds_cli_min.GetItemString(i,'clientes_nombre')
	else
		cli=cli	+', '+ds_cli_min.GetItemString(i,'clientes_nombre')
	end if
	if pos(otros_cli,cli)<=0 and pos(destinatario,cli)<=0 then	otros_cli=otros_cli+cli+'~n'
next						
				
				



// Otenemos el comunicado
comunicado = st_tipo_carta_datos.comunicado
f_hoy = datetime(today())
lugar_fecha = g_col_ciudad + ', ' + string(day(date(f_hoy))) + ' de ' + LeftA(f_obtener_mes(f_hoy),1) + lower(MidA(f_obtener_mes(f_hoy),2)) + ' de ' + string(year(date(f_hoy)))
descripcion = f_reemplaza_cadena(descripcion, is_delimitador, ',')
observ = f_reemplaza_cadena(observ, is_delimitador, ',')


choose case st_tipo_carta_datos.tipo_destinatario
	case 'P', 'C'
		ll_numero_cartas_distintas = 1
	case 'T'
		ll_numero_cartas_distintas = 3
	case 'D'
		ll_numero_cartas_distintas = 2
	case else
		ll_numero_cartas_distintas = 1
end choose

// Un mismo dw de carta se puede imprimir varias veces para distintos destinatarios si el tipo de carta es 'T'
FOR ll_iteraciones_cartas_distintas=1 to ll_numero_cartas_distintas
	CHOOSE CASE g_colegio
		CASE 'COAATGU', 'COAATLE', 'COAATAVI', 'COAATTER'
			// En cada iteraci$$HEX1$$f300$$ENDHEX$$n variamos el tipo de carta en el dw y el destinatario, tambi$$HEX1$$e900$$ENDHEX$$n podr$$HEX1$$ed00$$ENDHEX$$a cambiarse incluso el dw 
			CHOOSE CASE ll_iteraciones_cartas_distintas
				CASE 1
					if st_tipo_carta_datos.tipo_destinatario = 'T' or st_tipo_carta_datos.tipo_destinatario = 'D' then
						destinatario = sl_destinatario_cliente_lista
						direccion = sl_direccion_cliente_lista
						poblacion = sl_poblacion_cliente_lista
						if lower(dw_preview_carta.describe("tipo_carta.name")) = 'tipo_carta' then dw_preview_carta.setitem(1,'tipo_carta', 'A')
					end if
					// Cambio realizado por Luis 26/01/2009
					if st_tipo_carta_datos.tipo_destinatario = 'D' then
						i_impresion_formato.id_receptor=id_cliente_min
						i_impresion_formato.tipo_receptor='T'
					end if
					//fin cambio Luis
				CASE 2
					destinatario = sl_destinatario_colegiado_lista	+'.#.'		
					direccion = sl_direccion_colegiado_lista+'.#.'
					poblacion = sl_poblacion_colegiado_lista	+'.#.'			
					if lower(dw_preview_carta.describe("tipo_carta.name")) = 'tipo_carta' then dw_preview_carta.setitem(1,'tipo_carta', 'B')
					// Cambio realizado por Luis 26/01/2009
					if st_tipo_carta_datos.tipo_destinatario = 'D' then
						i_impresion_formato.id_receptor=id_colegiado_min
						i_impresion_formato.tipo_receptor='C'
					end if
					//fin cambio Luis
				CASE 3
					destinatario = f_nombre_abogado()+'.#.'		
					direccion = f_direccion_abogado()+'.#.'
					poblacion = f_poblacion_abogado()+'.#.'
					if lower(dw_preview_carta.describe("tipo_carta.name")) = 'tipo_carta' then dw_preview_carta.setitem(1,'tipo_carta', 'C')
			END CHOOSE
		CASE 'COAATCC'
				dw_preview_carta.setitem(1,"colegio",g_nombre_colegio_carta)
				dw_preview_carta.setitem(1,"colegio_direc",g_direc_colegio_carta)
				dw_preview_carta.setitem(1,"colegio_pob",g_pobla_colegio_carta)
				dw_preview_carta.setitem(1,"colegio_tlf",g_col_telefono)
				dw_preview_carta.setitem(1,"colegio_fax",g_col_fax)
				dw_preview_carta.setitem(1,"colegio_email",g_email_colegio_carta)
	END CHOOSE

	pos_destinatario = 0
	pos_direccion = 0
	pos_poblacion = 0
	ll_iteracion_destinatario = 0
	
	DO UNTIL PosA(destinatario, is_delimitador, pos_destinatario+1)=0 
		ll_iteracion_destinatario ++
		// Hallamos los datos de esta carta
		destinatario_carta = MidA(destinatario, pos_destinatario, PosA(destinatario, is_delimitador, pos_destinatario+1) - (pos_destinatario+1))
		pos_destinatario = PosA(destinatario, is_delimitador, pos_destinatario+1)+LenA(is_delimitador)
		direccion_carta = MidA(direccion, pos_direccion, PosA(direccion, is_delimitador, pos_direccion+1) - (pos_direccion+1))
		pos_direccion = PosA(direccion, is_delimitador, pos_direccion+1)+LenA(is_delimitador)
		poblacion_carta = MidA(poblacion, pos_poblacion, PosA(poblacion, is_delimitador, pos_poblacion+1) - (pos_poblacion+1))
		pos_poblacion = PosA(poblacion, is_delimitador, pos_poblacion+1)+LenA(is_delimitador)
		
		// Insertamos los datos en la carta
		if lower(dw_preview_carta.describe("n_expedi.name")) = 'n_expedi' then dw_preview_carta.setitem(1, 'n_expedi', f_reemplaza_cadena(n_exp, is_delimitador, ','))
		if lower(dw_preview_carta.describe("fecn.name")) = 'fecn' then dw_preview_carta.setitem(1, 'fecn', string(f_ult_reclamacion,'dd/mm/yyyy'))
		if lower(dw_preview_carta.describe("n_registro.name")) = 'n_registro' then dw_preview_carta.setitem(1, 'n_registro', f_reemplaza_cadena(n_registro, is_delimitador, ','))
		if lower(dw_preview_carta.describe("f_entrada.name")) = 'f_entrada' then dw_preview_carta.setitem(1, 'f_entrada', f_entrada)
		if lower(dw_preview_carta.describe("fase.name")) = 'fase' then dw_preview_carta.setitem(1, 'fase', f_dame_desc_tipo_actuacion(tipo_act))
		if lower(dw_preview_carta.describe("tipo_obra.name")) = 'tipo_obra' then dw_preview_carta.setitem(1, 'tipo_obra', f_dame_desc_tipo_obra(tipo_obra))
		if lower(dw_preview_carta.describe("emplazamiento.name")) = 'emplazamiento' then dw_preview_carta.setitem(1, 'emplazamiento', emplazamiento)
		if lower(dw_preview_carta.describe("descripcion.name")) = 'descripcion' then dw_preview_carta.setitem(1, 'descripcion', descripcion)
		if lower(dw_preview_carta.describe("clientes.name")) = 'clientes' then dw_preview_carta.setitem(1, 'clientes', cliente)
		if lower(dw_preview_carta.describe("colegiados.name")) = 'colegiados' then dw_preview_carta.setitem(1, 'colegiados', f_reemplaza_cadena(colegiado, is_delimitador, ', '))
		if lower(dw_preview_carta.describe("total_aviso.name")) = 'total_aviso' then dw_preview_carta.setitem(1, 'total_aviso', importe)
		if lower(dw_preview_carta.describe("lugar_fecha.name")) = 'lugar_fecha' then dw_preview_carta.setitem(1, 'lugar_fecha', lugar_fecha)
		if lower(dw_preview_carta.describe("destinatario.name")) = 'destinatario' then dw_preview_carta.setitem(1, 'destinatario', destinatario_carta)
		if lower(dw_preview_carta.describe("direccion.name")) = 'direccion' then dw_preview_carta.setitem(1, 'direccion', direccion_carta)
		if lower(dw_preview_carta.describe("poblacion.name")) = 'poblacion' then dw_preview_carta.setitem(1, 'poblacion', poblacion_carta)
		if lower(dw_preview_carta.describe("n_col.name")) = 'n_col' then dw_preview_carta.setitem(1, 'n_col', n_colegiado)
		if lower(dw_preview_carta.describe("comunicado.name")) = 'comunicado' then dw_preview_carta.setitem(1, 'comunicado', comunicado)
		if lower(dw_preview_carta.describe("n_aviso.name")) = 'n_aviso' then dw_preview_carta.setitem(1, 'n_aviso', f_reemplaza_cadena(n_aviso, is_delimitador, ','))
		if lower(dw_preview_carta.describe("observ.name")) = 'observ' then dw_preview_carta.setitem(1, 'observ', observ)
		if lower(dw_preview_carta.describe("lista_avisos.name")) = 'lista_avisos' then dw_preview_carta.setitem(1, 'lista_avisos', f_reemplaza_cadena(n_aviso, is_delimitador, ', '))
		if lower(dw_preview_carta.describe("irpf.name")) = 'irpf' then dw_preview_carta.setitem(1, 'irpf', base_irpf)
		if lower(dw_preview_carta.describe("reg_salida.name")) = 'reg_salida' then dw_preview_carta.setitem(1, 'reg_salida', n_reg_salida)		
		if lower(dw_preview_carta.describe("cobro_conjunto.name")) = 'cobro_conjunto' and is_cobro_conjunto='S' then dw_preview_carta.setitem(1, 'cobro_conjunto', is_cobro_conjunto)		
		if lower(dw_preview_carta.describe("resto_cli.name")) = 'resto_cli' and is_cobro_conjunto='S' then
			dw_preview_carta.setitem(1, 'resto_cli', otros_cli)		
		end if
			
		
		// Colocamos el numero de visado si este est$$HEX2$$e1002000$$ENDHEX$$en el documento a imprimir
		if lower(dw_preview_carta.describe("n_visado.name")) = 'n_visado' then	dw_preview_carta.setitem(1, 'n_visado', f_reemplaza_cadena(n_visado, is_delimitador, ','))
		// Colocamos el tipo de minuta si est$$HEX2$$e1002000$$ENDHEX$$en el documento a imprimir
		if lower(dw_preview_carta.describe("tipo_mta.name")) = 'tipo_mta' then	dw_preview_carta.setitem(1, 'tipo_mta', f_reemplaza_cadena(tipo_mta, is_delimitador, ','))
		// Fecha del aviso que se est$$HEX2$$e1002000$$ENDHEX$$reclamando
		if lower(dw_preview_carta.describe("f_minuta.name")) = 'f_minuta' then dw_preview_carta.setitem(1, 'f_minuta', ds_reclamaciones_datos_minuta.getitemdatetime(1, 'fases_minutas_fecha'))
	
		
		f_logo_empresa(g_empresa, dw_preview_carta, '006')
		
		if b_previsualizar then
			// Dejamos el zoom a 92 que queda bien en pantalla
			if dw_preview_carta.Describe("DataWindow.Nested") = "no" then
				// No tiene reports, hacer el printpreview, si hay varias cartas de distintos destinatarios hacerlo solo en la primera.
				if ll_iteracion_destinatario = 1 then dw_preview_carta.trigger event pfc_printpreview()
			end if
			dw_preview_carta.object.datawindow.print.preview.zoom = 80
			// Visualizamos  el dw
			dw_preview_carta.visible = true
		else
			string exp,reg
			exp= f_reemplaza_cadena(n_exp, is_delimitador, ',')
			reg= f_reemplaza_cadena(n_registro, is_delimitador, ',')
			i_impresion_formato.asunto_registro=exp
			

			if tipo_mta='I' then
				i_impresion_formato.serie='RECLAM_EXP'
				i_impresion_formato.asunto_email='EXP '+exp+' '+st_tipo_carta_datos.nombre
				i_impresion_formato.asunto_registro='REG '+reg+' '+st_tipo_carta_datos.nombre+'. COLEGIADO: '+f_reemplaza_cadena(colegiado, is_delimitador, ' ')
				i_impresion_formato.nombre=st_tipo_carta_datos.nombre
				i_impresion_formato.ruta_relativa3=exp

			else
	
				i_impresion_formato.serie='RECLAM_FAS'
				i_impresion_formato.asunto_email='REG '+reg+' '+st_tipo_carta_datos.nombre
				i_impresion_formato.asunto_registro='REG '+reg+' '+st_tipo_carta_datos.nombre+'. COLEGIADO: '+f_reemplaza_cadena(colegiado, is_delimitador, ' ')
				i_impresion_formato.nombre=st_tipo_carta_datos.nombre
				i_impresion_formato.ruta_relativa3=reg	
									
			end if
			
			if g_colegio='COAATNA' then i_impresion_formato.serie='RS'
			copias=i_impresion_formato.copias
			if g_debug = '1' then
				i_impresion_formato.copias = 1
//			else
//
//				if g_colegio='COAATNA' and tipo_mta<>'I' then
//					i_impresion_formato.copias = 2+1*n_col   // Se imprime 1 copia al cliente, otra al colegio y 1 por cada colegiado
//				end if
			end if

				i_impresion_formato.f_impresion()
				i_impresion_formato.copias = copias  // Restauramos el numero de copias por si ha cambiado
			
			//dw_preview_carta.print()
			//if g_debug <> '1' or f_es_vacio(g_debug) then dw_preview_carta.print() // Modificado Ricardo 2005-03-07. Quieren 2 copias
		end if
	LOOP
NEXT
destroy ds_lineas
destroy ds_reclamaciones_datos_minuta

setpointer(arrow!)
end event

event type double csd_detalle_cartas(ref datastore ds_datos, ref datastore ds_lineas);// Rellenando las lineas de las reclamaciones!
string tipo_gestion
long fila_insert
// Para mantener datos
string aplica_honos, aplica_desplaza, aplica_cip, aplica_src, aplica_dv,aplica_libros, conc_honos, conc_desp, conc_lib,descrip, desc_acumulada
double base_honos, base_desplaza, base_cip, base_dv, base_src, base_libros, irpf, base_imponible_irpf,cobro_a_cuenta
double i

tipo_gestion = ds_datos.getitemstring(1, 'fases_minutas_tipo_gestion')
base_imponible_irpf = 0

CHOOSE CASE tipo_gestion
	CASE 'S'
		// Sin gestion de cobro
		aplica_cip = ds_datos.getitemstring(1, 'fases_minutas_aplica_cip')
		aplica_src = ds_datos.getitemstring(1, 'fases_minutas_aplica_musaat')
		aplica_dv = ds_datos.getitemstring(1, 'fases_minutas_aplica_dv')
		aplica_libros = ds_datos.getitemstring(1, 'fases_minutas_aplica_impresos')

		// DV
		base_dv = ds_datos.getitemnumber(1, 'fases_minutas_base_dv')
		if base_dv <> 0 and aplica_dv = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.dv+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.dv)
			ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.dv))
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_dv)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_dv'))
		end if
		
		// CIP
		base_cip = ds_datos.getitemnumber(1, 'fases_minutas_base_cip')
		if base_cip <> 0 and aplica_cip = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.cip+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.cip)
			ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.cip))
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_cip)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_cip'))
		end if
		
		// MUSAAT
		base_src = ds_datos.getitemnumber(1, 'fases_minutas_base_musaat')
		if base_src <> 0 and aplica_src = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.musaat_variable+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.musaat_variable)
			ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.musaat_variable))
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_src)
		end if

		// Libros
		base_libros = ds_datos.getitemnumber(1, 'fases_minutas_base_impresos')
		if base_libros <> 0 and aplica_libros = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.impresos+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
			conc_lib = ds_datos.getitemstring(1, 'fases_minutas_concepto_otros')
			if f_es_vacio(conc_lib) then  conc_lib = f_devuelve_desc_concepto(g_codigos_conceptos.impresos)
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.impresos)
			ds_lineas.setitem(fila_insert, 'descripcion', conc_lib)
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_libros)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_impresos'))
		end if
		
		// Insertamos una fila para que imprima la carta cuando no hay importes
		if (g_colegio = 'COAATGU' or g_colegio='COAATTER' ) and ds_lineas.rowcount() = 0 then fila_insert = ds_lineas.insertrow(0)
			
	CASE 'C'
		// Con gestion de cobro
		aplica_honos = ds_datos.getitemstring(1, 'fases_minutas_aplica_honos')
		aplica_desplaza = ds_datos.getitemstring(1, 'fases_minutas_aplica_desplaza')
		aplica_dv = ds_datos.getitemstring(1, 'fases_minutas_aplica_dv')
		aplica_libros = ds_datos.getitemstring(1, 'fases_minutas_aplica_impresos')
		irpf = ds_datos.getitemnumber(1, 'fases_minutas_importe_irpf')
		
		
		base_honos = ds_datos.getitemnumber(1, 'fases_minutas_base_honos')
		if base_honos <> 0 and aplica_honos = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.honorarios+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			descrip = ds_datos.getitemstring(1, 'fases_minutas_concepto_honos')
			desc_acumulada = ds_lineas.GetitemString(fila_insert, 'descripcion'); if isnull(desc_acumulada) then desc_acumulada = ''
			conc_honos = desc_acumulada
			if not f_es_vacio(descrip) then
				// Miramos si esa descripcion ya est$$HEX1$$e100$$ENDHEX$$
				if PosA(desc_acumulada, descrip)=0 then
					// a$$HEX1$$f100$$ENDHEX$$adimos la descripcion nueva
					if LenA(desc_acumulada)>0 then
						conc_honos = desc_acumulada+','+descrip
					else
						conc_honos = descrip
					end if
				end if
			else
				if f_es_vacio(desc_acumulada) then 
					conc_honos = f_devuelve_desc_concepto(g_codigos_conceptos.honorarios)
					if isnull(conc_honos) then conc_honos = 'HONORARIOS'
				end if
			end if
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.honorarios)
			ds_lineas.setitem(fila_insert, 'descripcion', conc_honos)
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_honos)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_honos'))
			// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
			ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
			if ds_datos.getitemnumber(1, 'fases_minutas_importe_irpf')>0 then base_imponible_irpf += base_honos
			irpf = 0
		end if
		
		// Desplazamientos 
		base_desplaza = ds_datos.getitemnumber(1, 'fases_minutas_base_desplaza')
		if base_desplaza <> 0 and aplica_desplaza = 'S' then
			
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.desplazamientos+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			conc_desp = ds_datos.getitemstring(1, 'fases_minutas_concepto_desplaza')
			if f_es_vacio(conc_desp) then  conc_desp = f_devuelve_desc_concepto(g_codigos_conceptos.desplazamientos)	
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.desplazamientos)
			ds_lineas.setitem(fila_insert, 'descripcion', conc_desp)
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_desplaza)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_desplaza'))
			// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
			ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
			if ds_datos.getitemnumber(1, 'fases_minutas_importe_irpf')>0 then base_imponible_irpf += base_desplaza
			irpf = 0
		end if
			
		// DV
		base_dv = ds_datos.getitemnumber(1, 'fases_minutas_base_dv')
		if base_dv <> 0 and aplica_dv = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.dv+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.dv)
			ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.dv))
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_dv)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_dv'))
			// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
			ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
			irpf = 0
		end if
			
		// Libros
		base_libros = ds_datos.getitemnumber(1, 'fases_minutas_base_impresos')
		if base_libros <> 0 and aplica_libros = 'S' then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.impresos+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
			conc_lib = ds_datos.getitemstring(1, 'fases_minutas_concepto_otros')
			if f_es_vacio(conc_lib) then  conc_lib = f_devuelve_desc_concepto(g_codigos_conceptos.impresos)
				
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.impresos)
			ds_lineas.setitem(fila_insert, 'descripcion', conc_lib)
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe')+base_libros)
			ds_lineas.setitem(fila_insert, 'iva_importe', ds_lineas.GetItemNumber(fila_insert, 'iva_importe')+ds_datos.getitemnumber(1, 'fases_minutas_iva_impresos'))
			// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
			ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
			irpf = 0
			
		end if
		
		// Cobro a cuenta
		cobro_a_cuenta = ds_datos.getitemnumber(1, 'fases_minutas_cobro_a_cuenta')
		if cobro_a_cuenta <> 0 then
			fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.cobro_a_cuenta+"'", 1, ds_lineas.Rowcount())
			if fila_insert = 0 then 
				fila_insert = ds_lineas.insertrow(0)
				ds_lineas.setitem(fila_insert, 'importe', 0)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				ds_lineas.setitem(fila_insert, 'irpf', 0)
			end if
			
			ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.cobro_a_cuenta)
			ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.cobro_a_cuenta))
			ds_lineas.setitem(fila_insert, 'importe', ds_lineas.GetitemNumber(fila_insert, 'importe') - cobro_a_cuenta)
			ds_lineas.setitem(fila_insert, 'iva_importe', 0)
			// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
			ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
			irpf = 0
		end if
		
		// Modificado Ricardo 2005-06-27
		// Prenda/Garant$$HEX1$$ed00$$ENDHEX$$a
		if g_colegio = 'COAATGU' or g_colegio = 'COAATZ' or g_colegio = 'COAATLE' or g_colegio='COAATTER' or g_colegio='COAATNA' then
			double garantia
			garantia = ds_datos.getitemnumber(1, 'fases_minutas_base_garantia')
			if garantia <> 0 then
				fila_insert = ds_lineas.find("codigo = '"+g_codigos_conceptos.dev_garantia+"'", 1, ds_lineas.Rowcount())
				if fila_insert = 0 then 
					fila_insert = ds_lineas.insertrow(0)
					ds_lineas.setitem(fila_insert, 'importe', 0)
					ds_lineas.setitem(fila_insert, 'iva_importe', 0)
					ds_lineas.setitem(fila_insert, 'irpf', 0)
				end if
				ds_lineas.setitem(fila_insert, 'codigo', g_codigos_conceptos.dev_garantia)
				ds_lineas.setitem(fila_insert, 'descripcion', f_devuelve_desc_concepto(g_codigos_conceptos.dev_garantia))
				// Modificaci$$HEX1$$f300$$ENDHEX$$n Paco 22/09/2005, La garant$$HEX1$$ed00$$ENDHEX$$a o prenda debe restar al importe total
				ds_lineas.setitem(fila_insert, 'importe', (-1) * garantia)
				ds_lineas.setitem(fila_insert, 'iva_importe', 0)
				// metemos el irpf en esta linea si no se ha metido ya (se pondr$$HEX2$$e1002000$$ENDHEX$$a 0)
				ds_lineas.setitem(fila_insert, 'irpf', ds_lineas.GetItemNumber(fila_insert, 'irpf')+irpf)
				irpf = 0
			end if			
		end if

		// Indicamos en la minuta final los honorarios totales y los minutados
		if (g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio='COAATTER') and ds_datos.GetItemString(1, 'fases_minutas_t_minuta') = 'F' and &
			upper(ds_datos.getitemstring(1, 'fases_minutas_concepto_honos')) <> 'ACTA DE APROBACI$$HEX1$$d300$$ENDHEX$$N' then
			string id_fase, id_col, id_cli
			double dl_total_cobrado_col_cli
			id_cli = ds_datos.GetItemString(1, 'fases_minutas_id_cliente')
			id_col = ds_datos.GetItemString(1, 'fases_minutas_id_colegiado')			
			id_fase = ds_datos.getitemstring(1, 'fases_minutas_id_fase')
			dl_total_cobrado_col_cli = f_total_cobrado_honos_col_cli(id_fase,id_col, id_cli)		
			if isnull(base_honos) then base_honos=0
			if isnull(dl_total_cobrado_col_cli) then dl_total_cobrado_col_cli = 0
			for i=1 to ds_lineas.rowcount()
				ds_lineas.setitem(i, 'desc_hon_finales', 'HONORARIOS FINALES............................................................................................................................................')
				ds_lineas.setitem(i, 'importe_hon_finales', base_honos+ dl_total_cobrado_col_cli)				
				ds_lineas.setitem(i, 'desc_hon_minutados', 'HONORARIOS MINUTADOS......................................................................................................................................')				
				ds_lineas.setitem(i, 'importe_hon_minutados',dl_total_cobrado_col_cli)								
			next
			
//			string id_fase, id_col, id_cli
//			st_csi_articulos_servicios st_csi_articulos_servicios
//			id_cli = ds_datos.GetItemString(1, 'fases_minutas_id_cliente')
//			id_col = ds_datos.GetItemString(1, 'fases_minutas_id_colegiado')			
//			id_fase = ds_datos.getitemstring(1, 'fases_minutas_id_fase')
//			st_csi_articulos_servicios.codigo = g_codigos_conceptos.honorarios
//			f_csi_articulos_servicios(st_csi_articulos_servicios)			
//			fila_insert = ds_lineas.find("descripcion = 'HONORARIOS FINALES'", 1, ds_lineas.Rowcount())
//			if fila_insert = 0 then
//				fila_insert = ds_lineas.insertrow(0)
//				ds_lineas.setitem(fila_insert, 'descripcion', 'HONORARIOS FINALES')
//				ds_lineas.setitem(fila_insert, 'importe', f_fases_honorarios_contrato(id_fase))
//				ds_lineas.setitem(fila_insert, 'iva_importe', f_aplica_t_iva(f_fases_honorarios_contrato(id_fase), st_csi_articulos_servicios.t_iva ))
//				ds_lineas.setitem(fila_insert, 'irpf', 0)
//			end if
//			fila_insert = ds_lineas.find("descripcion = 'HONORARIOS MINUTADOS'", 1, ds_lineas.Rowcount())
//			if fila_insert = 0 then			
//				fila_insert = ds_lineas.insertrow(0)
//				ds_lineas.setitem(fila_insert, 'descripcion', 'HONORARIOS MINUTADOS')
//				ds_lineas.setitem(fila_insert, 'importe', f_total_cobrado_honos_contrato(id_fase))
//				ds_lineas.setitem(fila_insert, 'iva_importe', f_aplica_t_iva(f_total_cobrado_honos_contrato(id_fase), st_csi_articulos_servicios.t_iva ))
//				ds_lineas.setitem(fila_insert, 'irpf', 0)			
//			end if
		end if		
END CHOOSE

return base_imponible_irpf
end event

event csd_opciones_impresion();// Ponemos por defecto las opciones de impresi$$HEX1$$f300$$ENDHEX$$n de documentos
// En este caso para la impresi$$HEX1$$f300$$ENDHEX$$n individual cuando se abre la ventana


f_logo_empresa(g_empresa, dw_preview_carta, '006')
//Datos de copias en papel
i_impresion_formato.papel = g_formato_impresion.papel
i_impresion_formato.copias 					= 2
i_impresion_formato.impresora_pag_desde 	= 1
i_impresion_formato.impresora_intervalo 	= 'T'
i_impresion_formato.impresora_intercalar 	= false

if g_colegio = 'COAATGU' and dw_lista.getitemstring(dw_lista.getrow(),'tipo_gestion') = 'SGC' then
	i_impresion_formato.copias 					= 1
end if

//Cambio Luis CGU-287
if g_colegio = 'COAATGU' then
	long copias = 1,i
	string reclamacion
	for i = 1 to dw_genera_cartas_historico.rowcount()
		reclamacion = dw_genera_cartas_historico.getitemstring(i,'tipo_reclamacion')
		if (reclamacion <> '5' and reclamacion <> '6' and reclamacion <> '7' and reclamacion <> '8')then
			copias = 2
		end if
	next
	i_impresion_formato.copias 					= copias
end if
//fin cambio

//Datos de copias en email
i_impresion_formato.email = g_formato_impresion.email	
i_impresion_formato.asunto_email = 'Notificaci$$HEX1$$f300$$ENDHEX$$n de Cobro'
i_impresion_formato.texto_email 	= ''
i_impresion_formato.direccion_email 	= ''
//i_impresion_formato.direccion_email = f_devuelve_mail(i_id_col)

//Datos de copias en pdf
i_impresion_formato.visualizar_web 		= 'N'
i_impresion_formato.pdf = g_formato_impresion.pdf
i_impresion_formato.ruta_base				= g_directorio_documentos_fases

//i_impresion_formato.ruta_relativa 		= g_ejercicio+'\'+idw_resumen.GetItemString(1,'n_colegiado')
i_impresion_formato.pdf_previsualizar 	= false	//No se muestra una previsualizaci$$HEX1$$f300$$ENDHEX$$n del pdf


//General
i_impresion_formato.destino 			= 'C'
i_impresion_formato.referencia 		= ''
i_impresion_formato.avisos 			= 0 		//Activamos los avisos pq no es masivo
i_impresion_formato.modo_creacion	= 2		//Avisamos si ya existe

//i_impresion_formato.id_receptor=i_id_col
if g_colegio='COAATNA' then
	i_impresion_formato.generar_registro='S'
	//i_impresion_formato.copias = 1
else
	i_impresion_formato.generar_registro='N'
end if
i_impresion_formato.tipo_receptor='C'
i_impresion_formato.asunto_registro=''
i_impresion_formato.serie='RECLAM_EXP'
i_impresion_formato.destino='MA'
i_impresion_formato.cambiar_serie=false
i_impresion_formato.ruta_automatica=true
i_impresion_formato.dw =dw_preview_carta
end event

public function string wf_dame_n_remesa (ref datastore ds_remesas, string tipo_carta);// FUNCION QUE DEVUELVE
string remesa
long fila

fila = ds_remesas.find("codigo = '"+tipo_carta+"'",1 ,ds_remesas.rowcount())
if fila < 1 then return string(fila)
remesa = ds_remesas.getitemstring(fila, 'id_remesa')
if f_es_vacio(remesa) then
	// Si no hay la creamos
	remesa = f_siguiente_numero('REMESA_RECLAMACION',10)
	ds_remesas.setitem(fila, 'id_remesa', remesa)
end if
// Incrementamos en 1
ds_remesas.SetItem(fila,'cuantas',ds_remesas.GetItemNumber(fila, 'cuantas')+1)



return remesa
end function

on w_fases_reclamaciones_nuevo.create
int iCurrent
call super::create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cb_generar=create cb_generar
this.st_3=create st_3
this.gb_consulta=create gb_consulta
this.gb_accion=create gb_accion
this.cb_imprimir=create cb_imprimir
this.cb_grabar=create cb_grabar
this.st_2=create st_2
this.cb_anular_fases=create cb_anular_fases
this.dw_consulta=create dw_consulta
this.dw_genera_cartas=create dw_genera_cartas
this.dw_remesa=create dw_remesa
this.dw_avisos_pendientes=create dw_avisos_pendientes
this.dw_genera_cartas_historico=create dw_genera_cartas_historico
this.cb_actualizar_cartas_minutas=create cb_actualizar_cartas_minutas
this.cb_marcar=create cb_marcar
this.cb_desmarcar=create cb_desmarcar
this.cb_ocultar=create cb_ocultar
this.dw_preview_carta=create dw_preview_carta
this.cb_buscar=create cb_buscar
this.cb_limpiar=create cb_limpiar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.cb_generar
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.gb_consulta
this.Control[iCurrent+6]=this.gb_accion
this.Control[iCurrent+7]=this.cb_imprimir
this.Control[iCurrent+8]=this.cb_grabar
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cb_anular_fases
this.Control[iCurrent+11]=this.dw_consulta
this.Control[iCurrent+12]=this.dw_genera_cartas
this.Control[iCurrent+13]=this.dw_remesa
this.Control[iCurrent+14]=this.dw_avisos_pendientes
this.Control[iCurrent+15]=this.dw_genera_cartas_historico
this.Control[iCurrent+16]=this.cb_actualizar_cartas_minutas
this.Control[iCurrent+17]=this.cb_marcar
this.Control[iCurrent+18]=this.cb_desmarcar
this.Control[iCurrent+19]=this.cb_ocultar
this.Control[iCurrent+20]=this.dw_preview_carta
this.Control[iCurrent+21]=this.cb_buscar
this.Control[iCurrent+22]=this.cb_limpiar
end on

on w_fases_reclamaciones_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cb_generar)
destroy(this.st_3)
destroy(this.gb_consulta)
destroy(this.gb_accion)
destroy(this.cb_imprimir)
destroy(this.cb_grabar)
destroy(this.st_2)
destroy(this.cb_anular_fases)
destroy(this.dw_consulta)
destroy(this.dw_genera_cartas)
destroy(this.dw_remesa)
destroy(this.dw_avisos_pendientes)
destroy(this.dw_genera_cartas_historico)
destroy(this.cb_actualizar_cartas_minutas)
destroy(this.cb_marcar)
destroy(this.cb_desmarcar)
destroy(this.cb_ocultar)
destroy(this.dw_preview_carta)
destroy(this.cb_buscar)
destroy(this.cb_limpiar)
end on

event open;call super::open;g_dw_lista_reclamaciones = dw_lista
dw_consulta.insertrow(0)

i_impresion_formato=create n_csd_impresion_formato
il_color = f_color_amarillo_claro()

inv_resize.of_Register (dw_remesa, "ScaletoRight")
inv_resize.of_Register (dw_genera_cartas, "ScaletoRight&Bottom")
inv_resize.of_Register (dw_genera_cartas_historico, "FixedToBottom&ScaleToRight")
inv_resize.of_Register (dw_avisos_pendientes, "ScaletoBottom")
inv_resize.of_unregister (dw_lista)
inv_resize.of_Register (dw_lista, "ScaletoBottom")
inv_resize.of_Register (dw_preview_carta, "ScaletoBottom")

inv_resize.of_Register (cb_generar, "FixedtoBottom")
inv_resize.of_Register (cb_imprimir, "FixedtoBottom")
inv_resize.of_Register (cb_grabar, "FixedtoBottom")
inv_resize.of_Register (cb_actualizar_cartas_minutas, "FixedtoBottom")
inv_resize.of_Register (cb_ocultar, "FixedtoBottom")
inv_resize.of_Register (cb_marcar, "FixedtoBottom")
inv_resize.of_Register (cb_desmarcar, "FixedtoBottom")

inv_resize.of_Register (st_2, "FixedtoBottom")
inv_resize.of_Register (st_3, "FixedtoBottom")

i_accion = 'CONSULTA'
this.event csd_configura_ventana()
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_fases_reclamaciones_nuevo
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_fases_reclamaciones_nuevo
end type

type st_1 from w_lista`st_1 within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 32
integer y = 2108
end type

type dw_lista from w_lista`dw_lista within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 14
integer y = 604
integer width = 3136
integer height = 1348
integer taborder = 80
string dataobject = "d_fases_reclamaciones_lista_nuevo"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_lista::buttonclicked;call super::buttonclicked;string id_minuta, id_carta

choose case dwo.name
	case 'b_imprimir'
		dw_genera_cartas.visible = true
		dw_genera_cartas_historico.visible = true

		id_carta = this.GetItemString(row, 'fases_minutas_cartas_hist_id_carta')
		dw_genera_cartas.retrieve(id_carta)
		
		if dw_genera_cartas_historico.retrieve(id_carta)>0 then cb_imprimir.trigger event clicked()
	CASE 'b_previsualizar'
		dw_genera_cartas.visible = true
		dw_genera_cartas_historico.visible = true

		id_carta = this.GetItemString(row, 'fases_minutas_cartas_hist_id_carta')
		dw_genera_cartas.retrieve(id_carta)
		if dw_genera_cartas_historico.retrieve(id_carta)>0 then 
			// Como solo hay de una sola carta, decimos que pille el id_carta de la primera fila!
			cb_ocultar.visible = true
			parent.trigger event csd_imprimir_carta(1, true)
		end if
end choose
end event

type cb_consulta from w_lista`cb_consulta within w_fases_reclamaciones_nuevo
integer taborder = 90
end type

type cb_detalle from w_lista`cb_detalle within w_fases_reclamaciones_nuevo
integer taborder = 100
end type

type cb_ayuda from w_lista`cb_ayuda within w_fases_reclamaciones_nuevo
integer taborder = 110
end type

type rb_1 from radiobutton within w_fases_reclamaciones_nuevo
integer x = 55
integer y = 68
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

type rb_2 from radiobutton within w_fases_reclamaciones_nuevo
integer x = 1669
integer y = 68
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
string text = "2 - Generaci$$HEX1$$f300$$ENDHEX$$n de Remesa de Cartas , Generaci$$HEX1$$f300$$ENDHEX$$n Manual"
boolean lefttext = true
end type

event clicked;i_accion = 'GENERACION'
parent.event csd_configura_ventana()
end event

type cb_generar from commandbutton within w_fases_reclamaciones_nuevo
integer x = 1376
integer y = 1960
integer width = 425
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar >>"
end type

event clicked;string manual, id_minuta, n_aviso, procesar, sig_carta, id_carta
datetime fecha_reclamacion, f_ultima_reclamacion
// Datastore para las remesas
datastore ds_remesas
// Iteradores
int i, fila_insertada, fila
// Variables para Cuando cambia el expediente o el cliente se genera una nueva carta
string n_exp='', pagador='', n_exp_ant='', pagador_ant='', tipo_carta='', tipo_carta_ant=''
string n_reg = '', n_reg_ant, tipo_mta='', tipo_mta_ant=''
string ls_conjunto
	
// miramos si tiene permiso
if f_puedo_escribir(g_usuario,'0000000026')=-1 then return -1

// Vaciamos los dw!
dw_remesa.reset()
dw_genera_cartas.reset()
dw_genera_cartas_historico.reset()


IF dw_avisos_pendientes.rowcount() = 0 then
	messagebox(g_titulo, "No existe ninguna carta para generar")
	return
end if

// Quitamos el otro bot$$HEX1$$f300$$ENDHEX$$n e impedimos que toquen este
cb_actualizar_cartas_minutas.visible = false
cb_generar.enabled = false


// Generamos las remesas temporalmente
ds_remesas = create datastore
ds_remesas.dataobject = 'd_reclamaciones_genera_cartas_remesas_nu'
ds_remesas.settransobject (SQLCA)
ds_remesas.retrieve()

//select valor into :il_n_reg_salida from contadores where contador='N_REG_MINUTAS';


for i = 1 to dw_avisos_pendientes.rowcount()
	procesar = dw_avisos_pendientes.getitemstring(i, 'procesar')
	if procesar = 'N' then continue
	sig_carta = dw_avisos_pendientes.getitemstring(i, 'siguiente_carta')
	if sig_carta = 'NO' then continue
	
	
	// Cogemos los datos que nos pueden ser necesarios
	id_minuta = dw_avisos_pendientes.getitemstring(i, 'fases_minutas_id_minuta')
	n_aviso = dw_avisos_pendientes.getitemstring(i, 'n_aviso')
	n_exp = dw_avisos_pendientes.getitemstring(i, 'fases_n_expedi')
	n_reg = dw_avisos_pendientes.getitemstring(i, 'fases_n_registro')
	pagador = dw_avisos_pendientes.getitemstring(i, 'nombre_pagador')	
	tipo_mta = dw_avisos_pendientes.getitemstring(i, 'fases_minutas_t_minuta')	
	tipo_carta = sig_carta

	// Colocamos los datos de esta carta en el sitio que le corresponde
	dw_avisos_pendientes.setitem(i, 'tipo_reclamacion', sig_carta)
	f_ultima_reclamacion = dw_avisos_pendientes.GetitemDatetime(i, 'f_reclamacion')
	dw_avisos_pendientes.setitem(i, 'f_reclamacion', datetime(today(),now()))	

	// Segun el estilo solicitado por el colegio se actua con la correspondiente carta
	CHOOSE CASE g_estilo_carta
		CASE 'EXPEDIENTES'
				if  is_cobro_conjunto='S' then 
					if n_exp <> n_exp_ant or tipo_carta <> tipo_carta_ant or tipo_mta <> tipo_mta_ant then 
					//MessageBox("DEBUG","Cobro conjunto")
						id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
						//fila_insertada = dw_genera_cartas.insertrow(0)
						fila_insertada = dw_genera_cartas.event pfc_insertrow()
						dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
						dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
						dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
						dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
						dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
						dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
						dw_genera_cartas.setitem(fila_insertada, 'f_ultima_reclamacion', f_ultima_reclamacion) // Nos lo guardamos pq sale en las cartas		
					end if					
			
			
				else
					if g_colegio='COAATNA' then
						// Para Navarra, agrupamos por tipo de minunta
						if  n_exp <> n_exp_ant or pagador <> pagador_ant or tipo_carta <> tipo_carta_ant or tipo_mta <> tipo_mta_ant then // or tipo_mta <> 'I' then
							id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
							//fila_insertada = dw_genera_cartas.insertrow(0)
							fila_insertada = dw_genera_cartas.event pfc_insertrow()
							dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
							dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
							dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
							dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
							dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
							dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
							dw_genera_cartas.setitem(fila_insertada, 'f_ultima_reclamacion', f_ultima_reclamacion) // Nos lo guardamos pq sale en las cartas
						end if						
					else					
						if n_exp <> n_exp_ant or pagador <> pagador_ant or tipo_carta <> tipo_carta_ant then
							id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
							//fila_insertada = dw_genera_cartas.insertrow(0)
							fila_insertada = dw_genera_cartas.event pfc_insertrow()					
							dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
							dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
							dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
							dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
							dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
							dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
							dw_genera_cartas.setitem(fila_insertada, 'f_ultima_reclamacion', f_ultima_reclamacion) // Nos lo guardamos pq sale en las cartas
						end if
					end if
				end if
//			// Para SGC no se agrupa por expediente
//			if ist_tipo_carta_datos.tipo_gestion = 'C' then
				n_exp_ant = n_exp
				pagador_ant = pagador
				tipo_carta_ant = tipo_carta
				tipo_mta_ant = tipo_mta				
//			end if

			// Metemos la carta en el historico
			fila_insertada = dw_genera_cartas_historico.insertrow(0)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id', f_siguiente_numero('RECLAM_CART_HIST', 10))
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_carta', id_carta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_minuta', id_minuta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
			
		CASE 'CONTRATOS'
			// Diferenciamos tambi$$HEX1$$e900$$ENDHEX$$n los avisos finales de los iniciales
			if g_colegio = 'COAATGU' or g_colegio = 'COAATLE' or g_colegio = 'COAATAVI'  or g_colegio='COAATTER' then
				// Para Guadalajara se agrupan los avisos iniciales y todos los cuartos reclamos de cualquier tipo de carta.
				// Modificado David - 08/11/2005 - Se agrupan siempre
				if n_reg <> n_reg_ant or pagador <> pagador_ant or tipo_carta <> tipo_carta_ant or tipo_mta <> tipo_mta_ant then
					id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
					//fila_insertada = dw_genera_cartas.insertrow(0)
					fila_insertada = dw_genera_cartas.event pfc_insertrow()
					dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
					dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
					dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
					dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
					dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
					dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
					// Modificado Paco: 31/10/2005, no sal$$HEX1$$ed00$$ENDHEX$$a la fecha de la anterior carta
					dw_genera_cartas.setitem(fila_insertada, 'f_ultima_reclamacion', f_ultima_reclamacion) // Nos lo guardamos pq sale en las cartas
				end if
			else			
				if n_reg <> n_reg_ant or pagador <> pagador_ant or tipo_carta <> tipo_carta_ant then
					id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
					//fila_insertada = dw_genera_cartas.insertrow(0)
					fila_insertada = dw_genera_cartas.event pfc_insertrow()					
					dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
					dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
					dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
					dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
					dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
					dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
				end if
			end if

//			// Para SGC no se agrupa por expediente
//			if ist_tipo_carta_datos.tipo_gestion = 'C' then
				n_reg_ant = n_reg
				pagador_ant = pagador
				tipo_carta_ant = tipo_carta
				tipo_mta_ant = tipo_mta
//			end if

			// Metemos la carta en el historico
			fila_insertada = dw_genera_cartas_historico.insertrow(0)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id', f_siguiente_numero('RECLAM_CART_HIST', 10))
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_carta', id_carta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_minuta', id_minuta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta)
			
			// Insertamos el tipo de minuta para luego ordenar por este campo
			if g_colegio = 'COAATAVI' then
				dw_genera_cartas_historico.setitem(fila_insertada, 'fases_minutas_t_minuta', tipo_mta)
			end if			
			
			
		CASE 'MINUTAS'
			// Cada minuta es una carta diferente
			id_carta = f_siguiente_numero('RECLAM_CARTA', 10)
			//fila_insertada = dw_genera_cartas.insertrow(0)
			fila_insertada = dw_genera_cartas.event pfc_insertrow()			
			dw_genera_cartas.setitem(fila_insertada, 'id_carta', id_carta)
			dw_genera_cartas.setitem(fila_insertada, 'id_referencia', id_minuta)
			dw_genera_cartas.setitem(fila_insertada, 'f_reclamacion', datetime(today(),now()))
			dw_genera_cartas.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 		
			dw_genera_cartas.setitem(fila_insertada, 'manual', manual)
			dw_genera_cartas.setitem(fila_insertada, 'id_remesas_reclamaciones', wf_dame_n_remesa(ds_remesas, tipo_carta))
			
			// Metemos la carta en el historico
			fila_insertada = dw_genera_cartas_historico.insertrow(0)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id', f_siguiente_numero('RECLAM_CART_HIST', 10))
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_carta', id_carta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'id_minuta', id_minuta)
			dw_genera_cartas_historico.setitem(fila_insertada, 'tipo_reclamacion', tipo_carta) 					
	END CHOOSE
next

for fila = 1 TO ds_remesas.rowCount()
	if ds_remesas.GetItemNumber(fila, 'cuantas')>0 then
		fila_insertada = dw_remesa.insertrow(0)
		dw_remesa.setitem(fila_insertada, 'id_remesas_reclamaciones', ds_remesas.GetItemString(fila, 'id_remesa'))
		dw_remesa.setitem(fila_insertada, 'n_remesa', f_quita_ceros(ds_remesas.GetItemString(fila, 'id_remesa')))
		dw_remesa.setitem(fila_insertada, 'fecha', datetime(today(), now()))
		dw_remesa.setitem(fila_insertada, 'tipo_reclamacion', ds_remesas.GetItemString(fila, 'codigo'))
		dw_remesa.setitem(fila_insertada, 'cuantas', ds_remesas.GetItemNumber(fila, 'cuantas'))
	end if
next
dw_remesa.sort()
// Destruimos el datastore usado
destroy ds_remesas
dw_genera_cartas.rowCount()
st_3.text = string(dw_genera_cartas.RowCount()) + ' registros.'
st_3.visible = true


end event

type st_3 from statictext within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3159
integer y = 1968
integer width = 375
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

type gb_consulta from groupbox within w_fases_reclamaciones_nuevo
integer x = 9
integer y = 176
integer width = 3840
integer height = 412
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

type gb_accion from groupbox within w_fases_reclamaciones_nuevo
integer x = 9
integer y = 16
integer width = 3451
integer height = 128
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

type cb_imprimir from commandbutton within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3552
integer y = 1960
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
string text = "&Imprimir Cartas"
end type

event clicked;long i
string carta = '', carta_old = ''


if dw_genera_cartas_historico.rowcount() <= 0 then
	messagebox(g_titulo, 'Primero debe generar las cartas por favor')
	return
end if

// Quieren que salgan impresas ordenadas por el tipo de carta
if g_colegio = 'COAATAVI' then 
	dw_genera_cartas_historico.setsort ( "compute_1 A")
	dw_genera_cartas_historico.sort ()
end if

event csd_opciones_impresion()

i_impresion_formato.masivo=true
if i_impresion_formato.f_opciones_impresion()<=0 then return



for i = 1 to dw_genera_cartas_historico.rowcount()
	carta = dw_genera_cartas_historico.GetItemString(i, 'id_carta')
	if carta_old<>carta then parent.trigger event csd_imprimir_carta(i, false)

	carta_old = carta
next

if i_accion = 'GENERACION' then messagebox(g_titulo, 'Impresi$$HEX1$$f300$$ENDHEX$$n Finalizada, Actualice los datos si todo sali$$HEX2$$f3002000$$ENDHEX$$correctamente por favor')

end event

type cb_grabar from commandbutton within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3977
integer y = 1960
integer width = 425
integer height = 92
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

//update contadores set valor=:il_n_reg_salida where contador='N_REG_MINUTAS';

end event

type st_2 from statictext within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 37
integer y = 1968
integer width = 887
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

type cb_anular_fases from u_cb within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3035
integer y = 500
integer width = 425
integer taborder = 11
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

type dw_consulta from u_dw within w_fases_reclamaciones_nuevo
event csd_rellenar_datos_carta ( )
integer x = 27
integer y = 232
integer width = 3794
integer height = 336
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_fases_reclamaciones_consulta_nuevo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_rellenar_datos_carta();string tipo_carta
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
			if upper(i_accion) = 'GENERACION' then cb_imprimir.enabled=false
		else
			if upper(i_accion) = 'GENERACION' then cb_imprimir.enabled=true
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

type dw_genera_cartas from u_dw within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3150
integer y = 1008
integer width = 1408
integer height = 536
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_reclamaciones_genera_cartas_nuevo"
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

event pfc_insertrow;call super::pfc_insertrow;string anyo,reg
anyo=right(string(year(today())),2)

reg=anyo+'-'+f_siguiente_numero('N_REG_MINUTAS',7)

/*
// Este  codigo asigna el n$$HEX2$$ba002000$$ENDHEX$$de registro por un contador que incrementamos internamente.
// Grabamos cuando le damos al boton actualizar

il_n_reg_salida++
reg=anyo+'-'+right('0000000'+string(il_n_reg_salida),7)
this.SetItem(ancestorreturnvalue,'n_registro',reg)
*/


this.SetItem(ancestorreturnvalue,'n_registro',reg)

return ancestorreturnvalue
end event

type dw_remesa from u_dw within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3150
integer y = 600
integer width = 1408
integer height = 408
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_remesas_reclamaciones"
end type

type dw_avisos_pendientes from u_dw within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 14
integer y = 600
integer width = 3136
integer height = 1348
integer taborder = 90
string dataobject = "d_reclamaciones_avisos_pendientes_exp_za"
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

event itemchanged;call super::itemchanged;string expedi, pagador, tipo_gestion, tipo_gestion_carta
long fila

CHOOSE CASE dwo.name
	CASE 'procesar'
		CHOOSE CASE g_estilo_carta
			CASE 'EXPEDIENTES'
				setpointer(hourglass!)
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n o desmarcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al grupo
				expedi = dw_avisos_pendientes.getitemString(row, 'fases_n_expedi')
				pagador = dw_avisos_pendientes.getitemString(row, 'nombre_pagador')
				
				// Marcamos para todos los de ese expediente
				FOR fila = 1 TO dw_avisos_pendientes.RowCount()
					if fila<>row then
						if expedi = dw_avisos_pendientes.getitemString(fila, 'fases_n_expedi') and pagador = dw_avisos_pendientes.getitemString(fila, 'nombre_pagador') then
							if not dw_avisos_pendientes.GetItemString(fila, 'manual' ) = 'S' then 
								dw_avisos_pendientes.Setitem(fila, 'procesar', string(data))
								dw_avisos_pendientes.Setitem(fila, 'manual', 'S')
								if data = 'S' then 
									dw_avisos_pendientes.setitem(fila,'color', il_color) 
									il_cuantos_seleccionados++ 
								else 
									dw_avisos_pendientes.setitem(fila,'color', 0)
									il_cuantos_seleccionados = il_cuantos_seleccionados - 1 
								end if
							end if
						end if
					else
						dw_avisos_pendientes.Setitem(fila, 'manual', 'S') // Nos apuntamos que ha sido tocado manualmente
						if data = 'S' then 
							dw_avisos_pendientes.setitem(fila,'color', il_color) 
							il_cuantos_seleccionados++
						else 
							dw_avisos_pendientes.setitem(fila,'color', 0)
							il_cuantos_seleccionados = il_cuantos_seleccionados - 1 
						end if
					end if

					dw_avisos_pendientes.setitemStatus(fila,'color', primary!, notmodified!)
					dw_avisos_pendientes.setitemStatus(fila,'manual', primary!, notmodified!)
					dw_avisos_pendientes.setitemStatus(fila,'procesar', primary!, notmodified!)
				NEXT
				// Ponemos los que hay marcados
				st_2.text = string(dw_avisos_pendientes.RowCount()) + ' registros - '+string(il_cuantos_seleccionados)+' seleccionados.'
				
				setpointer(arrow!)
			CASE 'CONTRATOS'
				setpointer(hourglass!)
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n o desmarcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al grupo
				expedi = dw_avisos_pendientes.getitemString(row, 'fases_n_registro')
				pagador = dw_avisos_pendientes.getitemString(row, 'nombre_pagador')
				
				// Marcamos para todos los de ese expediente
				FOR fila = 1 TO dw_avisos_pendientes.RowCount()
					if fila<>row then
						if expedi = dw_avisos_pendientes.getitemString(fila, 'fases_n_registro') and pagador = dw_avisos_pendientes.getitemString(fila, 'nombre_pagador') then
							if not dw_avisos_pendientes.GetItemString(fila, 'manual' ) = 'S' then 
								dw_avisos_pendientes.Setitem(fila, 'procesar', string(data))
								dw_avisos_pendientes.Setitem(fila, 'manual', 'S')
								if data = 'S' then 
									dw_avisos_pendientes.setitem(fila,'color', il_color) 
									il_cuantos_seleccionados++ 
								else 
									dw_avisos_pendientes.setitem(fila,'color', 0)
									il_cuantos_seleccionados = il_cuantos_seleccionados - 1 
								end if
							end if
						end if
					else
						dw_avisos_pendientes.Setitem(fila, 'manual', 'S') // Nos apuntamos que ha sido tocado manualmente
						if data = 'S' then 
							dw_avisos_pendientes.setitem(fila,'color', il_color) 
							il_cuantos_seleccionados++
						else 
							dw_avisos_pendientes.setitem(fila,'color', 0)
							il_cuantos_seleccionados = il_cuantos_seleccionados - 1 
						end if
					end if

					dw_avisos_pendientes.setitemStatus(fila,'color', primary!, notmodified!)
					dw_avisos_pendientes.setitemStatus(fila,'manual', primary!, notmodified!)
					dw_avisos_pendientes.setitemStatus(fila,'procesar', primary!, notmodified!)
				NEXT
				// Ponemos los que hay marcados
				st_2.text = string(dw_avisos_pendientes.RowCount()) + ' registros - '+string(il_cuantos_seleccionados)+' seleccionados.'
				
				setpointer(arrow!)
				
		END CHOOSE
	CASE 'tipo_reclamacion', 'siguiente_carta'
		// Cogemos el tipo de gestion y lo comprobamos con respecto a la carta elegida, para saber si son del mismo tipo o no
		tipo_gestion = dw_avisos_pendientes.GetItemString(row, 'fases_minutas_tipo_gestion')
		select tipo_gestion into :tipo_gestion_carta from notificaciones where codigo = :data;
		if not isnull(tipo_gestion_carta) then
			if tipo_gestion<>tipo_gestion_carta then
				post Messagebox(g_titulo, "El tipo de carta elegido no es compatible con el tipo de gesti$$HEX1$$f300$$ENDHEX$$n de la minuta", stopsign!)
				return 2
			end if
		end if
END CHOOSE

end event

type dw_genera_cartas_historico from u_dw within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 3150
integer y = 1544
integer width = 1408
integer height = 404
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reclamaciones_genera_cartas_hist_nuevo"
end type

event buttonclicked;call super::buttonclicked;CHOOSE CASE dwo.name
	CASE 'b_visualizar'
		cb_ocultar.visible = true
	//	event csd_opciones_impresion()

	//	i_impresion_formato.masivo=false
	//	if i_impresion_formato.f_opciones_impresion()<=0 then return
		
		parent.trigger event csd_imprimir_carta(row, true)
END CHOOSE

end event

type cb_actualizar_cartas_minutas from commandbutton within w_fases_reclamaciones_nuevo
integer x = 951
integer y = 1960
integer width = 425
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Act.minutas"
end type

event clicked;dw_avisos_pendientes.update()
end event

type cb_marcar from commandbutton within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 2290
integer y = 1960
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
string text = "Marcar Todos"
end type

event clicked;long fila
string carta_a_generar, carta_seleccionada

// Cogemos la carta
il_cuantos_seleccionados = 0
carta_seleccionada = dw_consulta.getitemstring(1, 'tipo_carta')
for fila = 1 TO dw_avisos_pendientes.rowcount()
	carta_a_generar =	dw_avisos_pendientes.GetItemString(fila, 'siguiente_carta')
	if carta_a_generar<>'NO' and carta_a_generar <>'@@' then
		if not f_es_vacio(carta_seleccionada) and carta_seleccionada <> carta_a_generar then
			dw_avisos_pendientes.setitem(fila, 'color', 0)
			dw_avisos_pendientes.setitem(fila, 'procesar', 'N')
		else
			dw_avisos_pendientes.setitem(fila, 'color', il_color)
			dw_avisos_pendientes.setitem(fila, 'procesar', 'S')
			il_cuantos_seleccionados++
		end if
	else
		dw_avisos_pendientes.setitem(fila, 'color', 0)
		dw_avisos_pendientes.setitem(fila, 'procesar', 'N')
	end if
	dw_avisos_pendientes.setitemStatus(fila, 'color', primary!, notmodified!)
	dw_avisos_pendientes.setitemStatus(fila, 'procesar', primary!, notmodified!)
	dw_avisos_pendientes.setitemStatus(fila, 0, primary!, notmodified!)
next

// Ponemos los que hay marcados
st_2.text = string(dw_avisos_pendientes.RowCount()) + ' registros - '+string(il_cuantos_seleccionados)+' seleccionados.'

end event

type cb_desmarcar from commandbutton within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 2715
integer y = 1960
integer width = 430
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Desmarcar Todos"
end type

event clicked;long fila

il_cuantos_seleccionados = 0
for fila = 1 TO dw_avisos_pendientes.rowcount()
	dw_avisos_pendientes.setitem(fila, 'color', 0)
	dw_avisos_pendientes.setitem(fila, 'procesar', 'N')
	dw_avisos_pendientes.setitemStatus(fila, 'color', primary!, notmodified!)
	dw_avisos_pendientes.setitemStatus(fila, 'procesar', primary!, notmodified!)
	dw_avisos_pendientes.setitemStatus(fila, 0, primary!, notmodified!)
next

// Ponemos los que hay marcados
st_2.text = string(dw_avisos_pendientes.RowCount()) + ' registros - '+string(il_cuantos_seleccionados)+' seleccionados.'

end event

type cb_ocultar from commandbutton within w_fases_reclamaciones_nuevo
integer x = 1801
integer y = 1960
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
string text = "Ocultar"
end type

event clicked;// Ocultamos la carta y el bot$$HEX1$$f300$$ENDHEX$$n
dw_preview_carta.visible = false
this.visible = false

end event

type dw_preview_carta from u_dw within w_fases_reclamaciones_nuevo
boolean visible = false
integer x = 14
integer y = 604
integer width = 3136
integer height = 1348
integer taborder = 11
end type

event type integer pfc_updatespending();call super::pfc_updatespending;return 0
end event

event constructor;call super::constructor;of_SetPrintPreview(TRUE)
end event

type cb_buscar from commandbutton within w_fases_reclamaciones_nuevo
integer x = 3269
integer y = 220
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

event clicked;string sql_nuevo,sql_original,c,cadena, sig_carta,n_expedi,t_min
integer comas,i, n_cartas_anteriores
datetime f_ini, f_fin
time hora_ini, hora_fin
u_dw dw_lista_aux

// Variables para averiguar la carta que hay que generar
long fila
string id_minuta, carta, tipo_gestion, carta_a_generar, carta_seleccionada
datetime fecha


choose case upper(i_accion)
	case 'CONSULTA'
		dw_lista_aux = g_dw_lista_reclamaciones
	case else
		dw_lista_aux = dw_avisos_pendientes

		is_cobro_conjunto=dw_consulta.GetItemString(1,'cobro_conjunto')
		if is_cobro_conjunto='S' then
			
			dw_lista_aux.DataObject='d_reclamaciones_avisos_pendientes_exp_conj_na'
			dw_lista_aux.SetTransObject(SQLCA)
		else
			dw_lista_aux.DataObject='d_reclamaciones_avisos_pendientes_exp_na'		
			dw_lista_aux.SetTransObject(SQLCA)
		end if
		
		
end choose

dw_lista_aux.accepttext()

sql_nuevo=dw_lista_aux.describe("datawindow.table.select")
sql_original = sql_nuevo

dw_consulta.AcceptText()

choose case upper(i_accion)
	case 'CONSULTA'
		f_sql('fases_minutas.n_aviso','LIKE','n_aviso',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas_cartas.f_reclamacion','>=','f_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas_cartas.f_reclamacion','<','f_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas_cartas.tipo_reclamacion','LIKE','tipo_carta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas_cartas.manual','LIKE','manual',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas_cartas.id_remesas_reclamaciones','LIKE','id_remesa',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
	case else
		f_sql('fases_minutas.fecha','>=','fecha_tope',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')//As$$HEX2$$ed002000$$ENDHEX$$no sacamos las que hayan prescrito
		
		f_sql('fases_minutas.id_minuta','=','id_minuta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.fecha','>=','f_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.fecha','<','f_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.f_reclamacion','>=','f_ult_carta_desde',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		f_sql('fases_minutas.f_reclamacion','<','f_ult_carta_hasta',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
		f_sql('fases.n_registro','=','n_registro',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
		f_sql('fases.n_expedi','=','n_expediente',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')				
		f_sql('fases_minutas.tipo_gestion','=','tipo_gestion',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
		
		select param1 into :n_expedi from t_control_eventos where evento = 'BORRAR_FASE' and activo = 'S';
		if not f_es_vacio(n_expedi) then
			sql_nuevo += " and fases.n_expedi <> '"+n_expedi+"' "
		end if
		
//		f_sql('fases_minutas.tipo_gestion','=','tipo_gestion',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')		
//		f_sql('fases_minutas.pagador','=','pagador',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
//		if ist_tipo_carta_datos.es_primera = 'N' then
//			sig_carta = dw_consulta.getitemString(1, 'tipo_carta')
//			select count(*) into :n_cartas_anteriores from notificaciones  where sig_carta = :sig_carta;
//			if n_cartas_anteriores > 1 then
//				// Si hay m$$HEX1$$e100$$ENDHEX$$s de una meto una subconsulta dentro de la select
//				sql_nuevo += " and fases_minutas.tipo_reclamacion in ( select codigo from notificaciones where sig_carta = '" + sig_carta +"') "
//			else
//				f_sql('fases_minutas.tipo_reclamacion','=','carta_anterior',parent.dw_consulta,sql_nuevo,g_tipo_base_datos,'')
//			end if
//		elseif ist_tipo_carta_datos.es_primera = 'S' then
//		// Si es carta primera entonces habria que sacar los que tienen nulo el campo tipo_reclammacion
//			sql_nuevo += ' and (fases_minutas.tipo_reclamacion = null or fases_minutas.tipo_reclamacion = ~'~') '
//		end if
		
	
end choose
//f_ini = dw_consulta.getitemdatetime(1, 'f_generacion')
//if not isnull(f_ini) then
//	hora_ini = relativetime(time(f_ini), -1)
//	hora_fin = relativetime(time(f_ini), 1)	
//	f_ini = datetime(date(f_ini), hora_ini)
//	f_fin = datetime(date(f_ini), hora_fin)	
//	sql_nuevo += ' and fases_reclamaciones.f_reclamacion between ~'' + string(f_ini, 'mm/dd/yyyy hh:mm:ss') + '~' and ~'' + string(f_fin, 'mm/dd/yyyy hh:mm:ss') + '~''
//end if

if g_debug = '1' then MessageBox(i_accion,sql_nuevo)

dw_lista_aux.setredraw(false)
dw_lista_aux.modify("Datawindow.table.select=~"" + sql_nuevo + "~"")
dw_lista_aux.retrieve()

dw_lista_aux.modify("Datawindow.table.select=~"" + sql_original + "~"")


// Vaciamos el datawindow de generaci$$HEX1$$f300$$ENDHEX$$n de cartas
if i_accion = 'GENERACION' then
	

	il_cuantos_seleccionados = 0
	
	carta_seleccionada = dw_consulta.getitemstring(1, 'tipo_carta')
	// Hay que hacer el proceso del rellenado de la siguiente carta a generar
	for fila =1 to dw_avisos_pendientes.RowCount()
		setnull(carta)
		// Pillamos los datos necesarios
		id_minuta = dw_avisos_pendientes.GetItemString(fila, 'fases_minutas_id_minuta')
		fecha = dw_avisos_pendientes.GetItemDateTime(fila, 'f_reclamacion')
		tipo_gestion = dw_avisos_pendientes.GetItemString(fila, 'fases_minutas_tipo_gestion')
		if isnull(fecha) then
			fecha = dw_avisos_pendientes.GetItemDateTime(fila, 'fecha')
		else
			carta = dw_avisos_pendientes.GetItemString(fila, 'tipo_reclamacion')
		end if
		t_min = dw_avisos_pendientes.GetItemString(fila, 'fases_minutas_t_minuta')
		carta_a_generar = f_dame_reclamacion_siguiente_minutas_ampliado(id_minuta, fecha,carta, tipo_gestion, 'NO',t_min)
		dw_avisos_pendientes.setitem(fila, 'siguiente_carta', carta_a_generar)
		if carta_a_generar<>'NO' and carta_a_generar <>'@@' then
			if not f_es_vacio(carta_seleccionada) and carta_seleccionada <> carta_a_generar then
				dw_avisos_pendientes.setitem(fila, 'color', 0)
				dw_avisos_pendientes.setitem(fila, 'procesar', 'N')
			else
				dw_avisos_pendientes.setitem(fila, 'color', il_color)
				dw_avisos_pendientes.setitem(fila, 'procesar', 'S')
				il_cuantos_seleccionados++
			end if
		else
			dw_avisos_pendientes.setitem(fila, 'color', 0)
			dw_avisos_pendientes.setitem(fila, 'procesar', 'N')
			if carta_a_generar = '@@' then 
				dw_avisos_pendientes.setitem(fila, 'filtrar', 'S') // No visualizamos las que ya se ha terminado el proceso de reclamacion
				dw_avisos_pendientes.setitem(fila, 'siguiente_carta', 'NO')
			end if
		end if
		
		if tipo_gestion = 'C' then
			// Van siempre a cliente
			dw_avisos_pendientes.setitem(fila, 'nombre_pagador', dw_avisos_pendientes.getitemString(fila, 'cliente'))
		else
			// Dependen de otras cosas
			if dw_avisos_pendientes.getitemString(fila, 'paga_asalariado')= 'S' or dw_avisos_pendientes.getitemString(fila, 'paga_externo')= 'S' then
				// Pagador cliente
				dw_avisos_pendientes.setitem(fila, 'nombre_pagador', dw_avisos_pendientes.getitemString(fila, 'cliente'))
			else
				// Pagador colegiado
				dw_avisos_pendientes.setitem(fila, 'nombre_pagador', dw_avisos_pendientes.getitemString(fila, 'colegiado'))
			end if
		end if
		
	next	
	// Hacemos que no se haya modificado nada
	dw_avisos_pendientes.resetupdate()
	// Aplicamos el filtro
	dw_avisos_pendientes.filter()
	// Hacemos que vuelva a calcular los grupos
	dw_avisos_pendientes.sort()
	dw_avisos_pendientes.groupcalc()

	// Vaciamos todas las cartas, las remesas y el historico	
	dw_genera_cartas.reset()
	dw_remesa.reset()
	dw_genera_cartas_historico.reset()

	// Visualizamos el bot$$HEX1$$f300$$ENDHEX$$n de grabar
	cb_actualizar_cartas_minutas.visible = true
	cb_generar.enabled = true
	
	// Ponemos los que hay marcados
	st_2.text = string(dw_lista_aux.RowCount()) + ' registros - '+string(il_cuantos_seleccionados)+' seleccionados.'
else
	st_2.text = string(dw_lista_aux.RowCount()) + ' registros.'
end if

dw_preview_carta.visible = false
cb_ocultar.visible = false

dw_lista_aux.setredraw(true)
st_2.visible = true
st_3.visible = false
end event

type cb_limpiar from commandbutton within w_fases_reclamaciones_nuevo
integer x = 3269
integer y = 324
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

event clicked;datetime fecha_tope

dw_consulta.reset()
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

choose case i_accion
	case 'GENERACION'
		if isnull(g_anyos_reclam_avisos) or g_anyos_reclam_avisos=0 then 
			fecha_tope = datetime(date('01/01/1900')) // No hay restricci$$HEX1$$f300$$ENDHEX$$n de a$$HEX1$$f100$$ENDHEX$$os
		else		
			if day(today()) <> 29 and month(today()) <> 2 then 
				fecha_tope = datetime(date(string(day(today()))+"/"+string(month(today()))+"/"+string(year(today()) - g_anyos_reclam_avisos)), time("00:00"))
			else
				// usamos el dia 28 y punto!
				fecha_tope = datetime(date("28/02/"+string(year(today()) - g_anyos_reclam_avisos)), time("00:00"))
			end if
		end if
		// Colocamos el valor de la fecha tope calculada
		if dw_consulta.Describe("fecha_tope.Name")="fecha_tope" then dw_consulta.setitem(1, 'fecha_tope', fecha_tope)
end choose
end event

