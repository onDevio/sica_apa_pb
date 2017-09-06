HA$PBExportHeader$n_csd_ivajulio2010.sru
forward
global type n_csd_ivajulio2010 from nonvisualobject
end type
end forward

global type n_csd_ivajulio2010 from nonvisualobject
end type
global n_csd_ivajulio2010 n_csd_ivajulio2010

type variables
//Al importar el objeto se deber$$HEX2$$e1002000$$ENDHEX$$modificar la variable is_producto

string is_version='10/06/2010 12:00'
string is_producto
string is_idioma
string is_colegio
string is_empresa
string is_pruebas
string is_existe_contabilidad
long il_file_log
datawindow id_dw_suceso
n_tr i_bd_ejercicio

				//GESFORM,FACTURAE,ICAV,PUBLIMEDIA,SERJUTECA,SICA,FRONTEND,GABINETE
				 //GIRSA,CLECE,FEW,GESTBUILD,SIGESCON,EDISAN,PRODLINE,UECOE,FEIM,SICAP,SICITT,VISARED,
				 //TEA,GIGA,SUBASTAS GAN.,CSD FACTURAS

end variables

forward prototypes
public function integer of_cambio_periodo_iva_fecha_factura (date data, datetime fecha)
public function string of_colegio ()
public function string of_empresa ()
public function boolean of_es_vacio (string valor_campo)
public function integer of_factura_rectificativa (datawindow dw_cabecera)
public function integer of_init (string aplicacion, string idioma, string colegio, string empresa)
public function integer of_obtener_num_digitos_cuenta ()
public function integer of_suceso_ivajulio2010 (datawindow dw_suceso, string descripcion, string bd_error)
public function integer of_validez_iva_documento (string ambito_factura, datawindow dw_cabecera, datawindow dw_conceptos)
public function integer of_iva_aplica_cambio_julio_2010 ()
public function integer of_sql_test (transaction bd_en_uso, string cadena_log, datawindow dw_suceso)
public function integer of_cambio_periodo_iva_fecha_factura (date data, datetime fecha, string mostrar_mensajes)
public function any of_iva_propiedad (string t_iva, string nombre_propiedad)
public function string of_iva_existe (string t_iva)
public function integer of_valida_iva_fecha (datetime fecha, string t_iva)
public function integer of_validez_iva_documento (string ambito_factura, datawindow dw_cabecera, datawindow dw_conceptos, string mostrar_mensajes)
public function integer of_bd_actualizar_cuentas_inserts (transaction bd_temporal, datawindow dw_suceso)
public function integer of_bd_actualizar_articulos (datawindow dw_suceso)
public function integer of_bd_actualizar_clientes_proveedores (datawindow dw_suceso)
public function integer of_bd_actualizar_cuentas (datawindow dw_suceso)
public function integer of_bd_actualizar_predefinidos (datawindow dw_suceso)
public function integer of_bd_actualizar_tipos_iva_defecto (datawindow dw_suceso)
public function integer of_bd_actualizar_tipos_iva_validez (datawindow dw_suceso)
public function integer of_bd_insertar_tipos_iva (datawindow dw_suceso)
public function integer of_actualizacion_correcta (string mensaje)
public function integer of_bd_actualizar ()
end prototypes

public function integer of_cambio_periodo_iva_fecha_factura (date data, datetime fecha);int retorno
retorno=this.of_cambio_periodo_iva_fecha_factura(data,fecha,'S')
return 1
end function

public function string of_colegio ();//SGC-272
//string ls_colegio
////choose case is_producto
//	//	case 'SIGESCON', 'GESFORM','FACTURAE','ICAV','PUBLIMEDIA','SERJUTECA','SICA','FRONTEND','GABINETE',&
//			'GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT','VISARED',&
//			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
		
			return is_colegio
//		case else
//			
//	end choose
end function

public function string of_empresa ();//SGC-273

//choose case is_producto
//		case 'SIGESCON', 'GESFORM','FACTURAE','ICAV','PUBLIMEDIA','SERJUTECA','SICA','FRONTEND','GABINETE',&
//			'GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT','VISARED',&
//			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
			return is_empresa

			
			
//			
//		case else
//			
//	end choose

end function

public function boolean of_es_vacio (string valor_campo);return isNull(valor_campo) OR trim(valor_campo) = ""
end function

public function integer of_factura_rectificativa (datawindow dw_cabecera);//SGC-258

constant int ES_RECTIFICATIVA=1
constant int NO_ES_RECTIFICATIVA=-1
constant int NO_CONTROLADO=0

string serie_abono,n_fact
string nombre_columna
nombre_columna = 'total'

	
	choose case is_producto
		case 'SIGESCON','FACTURAE','ICAV','PUBLIMEDIA','SERJUTECA','FRONTEND','GABINETE',&
			'GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICITT','VISARED',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'

			// S$$HEX1$$f300$$ENDHEX$$lo accedemos a la columna si hemos comprobado que existe en el dw
			IF lower(dw_cabecera.describe(nombre_columna + ".name")) = lower(nombre_columna) THEN
  				 IF dw_cabecera.GetItemNumber(1,'total') < 0 THEN 
              		 //Es rectificativa
               	return ES_RECTIFICATIVA
   			ELSE
                //No rectificativa
               	return NO_ES_RECTIFICATIVA
   			END IF
			END IF

			RETURN 0

		case 'SICA'
			
			select texto into :serie_abono from var_globales where nombre='g_serie_contrafactura';

			n_fact = dw_cabecera.GetItemString(dw_cabecera.GetRow(),'n_fact')
			
			if left(n_fact, len(serie_abono))=serie_abono then
				return ES_RECTIFICATIVA
			else
				return NO_ES_RECTIFICATIVA
			end if
		case 'SICAP'
			
			SELECT serie INTO :serie_abono FROM csi_series WHERE usuarios = 'neg';

			n_fact = dw_cabecera.GetItemString(dw_cabecera.GetRow(),'n_fact')
			
			if left(n_fact, len(serie_abono))=serie_abono then
				return ES_RECTIFICATIVA
			else
				return NO_ES_RECTIFICATIVA
			end if

		case 'GESFORM'
			return NO_ES_RECTIFICATIVA
		case else
			
	end choose
return NO_CONTROLADO
	
			

			
			
	
	
	
	
	
	
	
	
	
	
	
end function

public function integer of_init (string aplicacion, string idioma, string colegio, string empresa);//SGC-259
//i_bd_ejercicio=create n_tr
//i_bd_ejercicio=bd_transaction

is_producto=aplicacion
is_idioma=idioma
is_colegio=colegio
is_empresa=empresa
return 1
end function

public function integer of_obtener_num_digitos_cuenta ();//SGC-254

integer num_digitos

choose case is_producto
		case 'SIGESCON','GESFORM','FACTURAE','ICAV','SICA','FRONTEND','GABINETE',&
			'FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT','VISARED',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			SELECT valor_numerico INTO :num_digitos FROM csi_param_sigescon WHERE nombre = 'g_num_digitos';
			
		case 'GIRSA'
			return 7

		case else
			
	end choose

return num_digitos
end function

public function integer of_suceso_ivajulio2010 (datawindow dw_suceso, string descripcion, string bd_error);long fila

fila = dw_suceso.InsertRow(0)

dw_suceso.setitem(fila,'descripcion',descripcion)
dw_suceso.setitem(fila,'error',bd_error)

return 1
end function

public function integer of_validez_iva_documento (string ambito_factura, datawindow dw_cabecera, datawindow dw_conceptos);int retorno
//si utilizamos la funci$$HEX1$$f300$$ENDHEX$$n sin el parametro de mostrar mensaje, se llamar$$HEX2$$e1002000$$ENDHEX$$a la funci$$HEX1$$f300$$ENDHEX$$n con el parametro mostrar_mensajes='S' por defecto
retorno=this.of_validez_iva_documento(ambito_factura,dw_cabecera,dw_conceptos,'S')
return retorno
end function

public function integer of_iva_aplica_cambio_julio_2010 ();//SGC-251
constant int APLICA_VALIDACION=1
constant int NO_APLICA_VALIDACION=-1

string colegio

choose case is_producto
		
		case 'GESFORM','FACTURAE','ICAV','PUBLIMEDIA','SERJUTECA','GABINETE',&
			'GIRSA','FEW','PRODLINE','UECOE','FEIM','SICITT','TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
			return APLICA_VALIDACION
			
			
		case 'SICA','SICAP','SIGESCON'
			
			colegio=of_colegio()
			if colegio='COACTFE' or colegio='COAC' or colegio='COACE'or colegio='COAATTFE' or colegio='COAATGC' then
				return NO_APLICA_VALIDACION
			else
				return APLICA_VALIDACION
			end if
			
		case 'GESTBUILD','VISARED','FRONTEND'
			
			colegio=of_colegio()
			if colegio='35' or colegio='38' or colegio='51'or colegio='52' or colegio='61' or colegio='62' then
				// GRAN CANARIA, TENERIFE, LANZAROTE, FUERTEVENTURA
				return NO_APLICA_VALIDACION
			else 
				return APLICA_VALIDACION
			end if
			
		case else
			
	end choose
end function

public function integer of_sql_test (transaction bd_en_uso, string cadena_log, datawindow dw_suceso);string error_log,mensaje

if bd_en_uso.sqlcode=-1 then
	error_log="Error:"+SQLCA.sqlerrtext
	mensaje=cadena_log + error_log
	this.of_suceso_ivajulio2010(dw_suceso,cadena_log,error_log)
	filewrite(il_file_log,mensaje)
	fileclose(il_file_log)
	return -1
end if

return 1
end function

public function integer of_cambio_periodo_iva_fecha_factura (date data, datetime fecha, string mostrar_mensajes);//SGC-270
//Comprobamos si al cambiar la fecha de factura, cambiamos el periodo de validez de IVA. 
//(ejemplo: cambiamos de 05/05/2010 al 05/07/2010)
//Mostramos aviso permitiendo continuar.

constant int NO_IMPLICA_CAMBIOS=1
constant int IMPLICA_CAMBIOS=-1// mensaje: 'El cambio de fecha implica cambios en los tipos de IVA, revise el IVA asignado a los conceptos'

date fecha_nuevo_iva
date fecha_anterior
int retorno
string mensaje
if this.of_iva_aplica_cambio_julio_2010 ()=-1 then return NO_IMPLICA_CAMBIOS

fecha_nuevo_iva=date("2010/07/01")

choose case is_producto
		case 'SIGESCON','GESFORM','FACTURAE','ICAV','PUBLIMEDIA','SERJUTECA','SICA','FRONTEND','GABINETE',&
			'GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT','VISARED',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
				fecha_anterior=date(fecha)
				if fecha_anterior< fecha_nuevo_iva and data>fecha_nuevo_iva then
					retorno=IMPLICA_CAMBIOS
					//MessageBox(g_titulo,,Exclamation!,OK!)
				elseif fecha_anterior> fecha_nuevo_iva and data<fecha_nuevo_iva then
					//MessageBox(g_titulo,',Exclamation!,OK!)
					retorno=IMPLICA_CAMBIOS
				else 
					retorno=NO_IMPLICA_CAMBIOS
				end if
				
				IF retorno =IMPLICA_CAMBIOS THEN 
					
					IF mostrar_mensajes = 'S' THEN 
						mensaje = 'El cambio de fecha implica cambios en los tipos de IVA, revise el IVA asignado a los conceptos'
						messagebox(g_titulo,mensaje,Exclamation!, OK!,1)
						return retorno
					ELSE 
						return retorno
					END IF
					
				ELSE
					return NO_IMPLICA_CAMBIOS
						
				END IF


		case else
end choose
return NO_IMPLICA_CAMBIOS

end function

public function any of_iva_propiedad (string t_iva, string nombre_propiedad);//SGC-284

datetime fecha_inicio_validez
datetime fecha_fin_validez
double porcent
string codigo

CHOOSE CASE is_producto
	CASE 'SIGESCON', 'GESFORM','FACTURAE','ICAV','SICA','SICAP','FRONTEND','GABINETE',&
		'GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICITT','VISARED',&
		'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'

		select f_inicio_validez, f_fin_validez, porcent, t_iva into :fecha_inicio_validez, :fecha_fin_validez, :porcent, :codigo from csi_t_iva where t_iva=:t_iva;

	CASE 'SERJUTECA'

		select f_inicio_validez, f_fin_validez, porcentaje, tipo_iva into :fecha_inicio_validez, :fecha_fin_validez, :porcent, :codigo from cuentas_iva where tipo_iva=:t_iva;
	
	CASE 'PUBLIMEDIA'
		
		select f_inicio_validez, f_fin_validez, porcentaje, codigo into :fecha_inicio_validez, :fecha_fin_validez, :porcent, :codigo from tipos_impuestos where codigo=:t_iva;
END CHOOSE

CHOOSE CASE nombre_propiedad
	CASE 'fecha_inicio_validez'
		RETURN fecha_inicio_validez
	CASE 'fecha_fin_validez'
		RETURN fecha_fin_validez
	CASE 'porcent'
		RETURN porcent
	CASE 'codigo'
		RETURN codigo
			
END CHOOSE

// Para Evitar errores,devolvemos un valor por defecto
RETURN ''
end function

public function string of_iva_existe (string t_iva);string codigo

codigo=this.of_iva_propiedad(t_iva,'codigo')
if codigo=t_iva then 
	return 'S'
else 
	return 'N'
end if
end function

public function integer of_valida_iva_fecha (datetime fecha, string t_iva);//SGC-276

constant int FECHA_VALIDA=1
//constant int FECHA_NO_VALIDA_ANTERIOR=-1 // 18%, 8%  'El tipo de IVA al '+string(porcent)+'% s?lo es valido para fechas posteriores al '+string(date(fecha_inicio_validez))+'. ?Desea continuar?'
//constant int FECHA_NO_VALIDA_POSTERIOR=-2 // 16%, 7%  'El tipo de IVA al '+string(porcent)+'% s?lo es valido para fechas anteriores al '+string(date(fecha_fin_validez))+'. ?Desea continuar?'

constant int IVA_NO_VALIDO=-1
datetime fecha_inicio_validez_defecto

datetime fecha_inicio_validez
datetime fecha_fin_validez

if this.of_iva_aplica_cambio_julio_2010()=-1 then	return FECHA_VALIDA

//SGC-282
if this.of_es_vacio(t_iva) then return FECHA_VALIDA
//Fin SGC-282

//SGC-302
if this.of_iva_existe(t_iva)='N' then return FECHA_VALIDA
//Fin SGC-302


// Obtenemos los datos en funci?n del tipo de IVA y del Producto
fecha_inicio_validez = this.of_iva_propiedad ( t_iva, 'fecha_inicio_validez') 
fecha_fin_validez = this.of_iva_propiedad ( t_iva, 'fecha_fin_validez') 

//obtenemos la fecha de IVA que esta vigente, segun la fecha de inicio del iva por defecto

SELECT csi_t_iva.f_inicio_validez
INTO :fecha_inicio_validez_defecto
FROM csi_t_iva
WHERE csi_t_iva.t_iva = :g_t_iva_defecto;


//la variable "fecha" nos indica la fecha de la factura
// si la fecha de inicio o la fecha de fin de validez del iva es nula entoces el iva es valido
if isnull(date(fecha_fin_validez)) and isnull(date(fecha_inicio_validez)) then return FECHA_VALIDA 
	
	
//sino comprobamos las fechas
/*date('31/08/2012')*/ 
	if date(fecha) < date(fecha_inicio_validez_defecto) then 
		if isnull(date(fecha_fin_validez))  then
			return IVA_NO_VALIDO
		end if
	else
		
		
		
		
		if not isnull(date(fecha_fin_validez)) then
			return IVA_NO_VALIDO
		end if
	end if




end function

public function integer of_validez_iva_documento (string ambito_factura, datawindow dw_cabecera, datawindow dw_conceptos, string mostrar_mensajes);//SGC-257
constant int FECHA_VALIDA=1
//constant int FECHA_NO_VALIDA_ANTERIOR=-1 // 18%, 8%  'El tipo de IVA al '+string(porcent)+'% s?lo es valido para fechas posteriores al '+string(date(fecha_inicio_validez))+'. ?Desea continuar?'
//constant int FECHA_NO_VALIDA_POSTERIOR=-2 // 16%, 7%  'El tipo de IVA al '+string(porcent)+'% s?lo es valido para fechas anteriores al '+string(date(fecha_fin_validez))+'. ?Desea continuar?'

//constant int FECHA_NO_VALIDA_POSTERIOR2012=-3 // 21%, 10%  'El tipo de IVA al '+string(porcent)+'% s?lo es valido para fechas anteriores al '+string(date(fecha_fin_validez))+'. ?Desea continuar?'

constant int IVA_NO_VALIDO=-1

datetime fecha_factura
long i=0
int retorno,retorno_usuario
string t_iva
string mensaje
datetime fecha_inicio_validez,fecha_fin_validez
double porcent
string nombre_campo_fecha,nombre_campo_iva

// 26/05/10 Creada para reemplazara of_fecha_validez_iva
// Comprobamos si  debemos aplicar las validaciones de cambio de IVA
if this.of_iva_aplica_cambio_julio_2010 ()=-1 then return FECHA_VALIDA

//Si la factura es rectificativa no debemos aplicar las validaciones
if this.of_factura_rectificativa(dw_cabecera)=1 then return FECHA_VALIDA




// 26/05/10 Diferenciaci$$HEX1$$f300$$ENDHEX$$n por Producto: Establecemos el nombre del campo que almacena el tipo de IVA y la fecha
 
choose case is_producto
	case 'SIGESCON', 'GESFORM','FACTURAE','ICAV','SICA','FRONTEND','GABINETE',&
		'FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT','VISARED',&
		'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			nombre_campo_iva = 't_iva'
			nombre_campo_fecha = 'fecha'
		
	case 'SERJUTECA'
			nombre_campo_iva = 'tipo_iva'
			nombre_campo_fecha = 'fecha_emision'
			
	case  'GIRSA'
			nombre_campo_iva = 'iva'
			nombre_campo_fecha = 'fecha_emision'
			
	case  'PUBLIMEDIA'
			nombre_campo_iva = 'tipo_impuesto'
			nombre_campo_fecha = 'f_emision'
			
end choose

fecha_factura=dw_cabecera.getitemdatetime(1,nombre_campo_fecha)
FOR i = 1 TO dw_conceptos.rowCount()
	t_iva = dw_conceptos.GetItemString(i,nombre_campo_iva)
	// SGC-289 En el producto SIGESCON, M$$HEX1$$f300$$ENDHEX$$dulo de Facturas Emitidas, se debe evitar validar unas l$$HEX1$$ed00$$ENDHEX$$neas existentes a nivel informativo
	IF is_producto = 'SIGESCON' AND ambito_factura = 'E' THEN
		IF dw_conceptos.GetItemString(i,'procesar')<> 'S' THEN CONTINUE // pasamos a la siguiente l$$HEX1$$ed00$$ENDHEX$$nea
	END IF
	//FIN SGC-289
	
	//SGC-282
	if this.of_es_vacio(t_iva) then continue
	//Fin SGC-282
	
	//SGC-302
	if this.of_iva_existe(t_iva)='N' then continue
	//Fin SGC-302
	retorno = this.of_valida_iva_fecha (fecha_factura,t_iva)

	IF retorno < 0 THEN 
		IF mostrar_mensajes = 'S' THEN 
				// Si se va a mostrar 	el mensaje, obtenemos los datos a concatenar
				fecha_inicio_validez = this.of_iva_propiedad ( t_iva, 'fecha_inicio_validez') 
				fecha_fin_validez = this.of_iva_propiedad ( t_iva, 'fecha_fin_validez') 
				porcent = this.of_iva_propiedad ( t_iva, 'porcent') 

				// 16%, 7%
				//IF retorno = FECHA_NO_VALIDA_POSTERIOR THEN 
					//mensaje = 'El tipo de IVA al '+string(porcent)+'% s$$HEX1$$f300$$ENDHEX$$lo es v$$HEX1$$e100$$ENDHEX$$lido para fechas anteriores al '+string(date(fecha_fin_validez))+'. $$HEX1$$bf00$$ENDHEX$$Desea continuar?'
				// 18%, 8%
				//ELSEIF retorno = FECHA_NO_VALIDA_ANTERIOR THEN 
					//mensaje = 'El tipo de IVA al '+string(porcent)+'% s$$HEX1$$f300$$ENDHEX$$lo es v$$HEX1$$e100$$ENDHEX$$lido para fechas posteriores al '+string(date(fecha_inicio_validez))+'. $$HEX1$$bf00$$ENDHEX$$Desea continuar?'
				//iva no valido
				//elseif retorno =IVA_NO_VALIDO then 
				if retorno =IVA_NO_VALIDO then
 					mensaje = 'El tipo de IVA de alguno de los articulos es obsoleto.  $$HEX1$$bf00$$ENDHEX$$Desea continuar?'
				END IF
				retorno_usuario=messagebox(g_titulo,mensaje,Exclamation!, YesNo!,1)
				if(retorno_usuario=2) then 
					return retorno
				else	// Si el usuario indica que quiere continuar de todas formas, salimos de la ejecuci?n CORRECTAMENTE antes de pasar a la siguiente iteraci?n 
					RETURN FECHA_VALIDA
				end if
		// Si no muestra mensajes, retornamos que se ha encontrado problema para su tratamiento desde la funci?n que ha invocado a ?sta
		ELSE 
			return retorno
		END IF	
	END IF // Si la l$$HEX1$$ed00$$ENDHEX$$nea no tiene problemas, se continua con la siguiente iteraci$$HEX1$$f300$$ENDHEX$$n

NEXT

// Si no se han detectado datos anomalos, se finaliza retornando OK
return FECHA_VALIDA
		
end function

public function integer of_bd_actualizar_cuentas_inserts (transaction bd_temporal, datawindow dw_suceso);//SGC-254

int num_digitos
int retorno=1
string cadena_log,error_log,mensaje
string c_rep_16,c_rep_07,c_sop_16,c_sop_07
string c_rep_no_deven_16,c_rep_no_deven_07,c_sop_no_deven_16,c_sop_no_deven_07
string c_rep_no_deduc_16,c_rep_no_deduc_07,c_sop_no_deduc_16,c_sop_no_deduc_07
string c_inm_16,c_inm_07
string c_re_16,c_re_07
string c_rep_18,c_rep_08,c_sop_18,c_sop_08
string c_rep_no_deven_18,c_rep_no_deven_08,c_sop_no_deven_18,c_sop_no_deven_08
string c_rep_no_deduc_18,c_rep_no_deduc_08,c_sop_no_deduc_18,c_sop_no_deduc_08
string c_inm_18,c_inm_08


string ls_t_iva_16,ls_t_iva_07

//Obtenemos los digitos utilizados para las cuentas
num_digitos=this.of_obtener_num_digitos_cuenta()

//Obtenemos el codigo para los tipos de IVA para los que obtendremos las cuentas
select valor_texto into:ls_t_iva_16 from csi_param_sigescon where nombre='g_t_iva_16';
select valor_texto into:ls_t_iva_07 from csi_param_sigescon where nombre='g_t_iva_07';

//Obtenemos todas las posibles cuentas
select id_cuenta_re into:c_re_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select id_cuenta_re into:c_re_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select id_cuenta_repercutido into:c_rep_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select id_cuenta_repercutido into:c_rep_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select id_cuenta_soportado into:c_sop_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select id_cuenta_soportado into:c_sop_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select cuenta_repercutido_no_deven into:c_rep_no_deven_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select cuenta_repercutido_no_deven into:c_rep_no_deven_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select cuenta_soportado_no_deven into:c_sop_no_deven_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select cuenta_soportado_no_deven into:c_sop_no_deven_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select cuenta_repercutido_no_deduc into:c_rep_no_deduc_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select cuenta_repercutido_no_deduc into:c_rep_no_deduc_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select cuenta_soportado_no_deduc into:c_sop_no_deduc_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select cuenta_soportado_no_deduc into:c_sop_no_deduc_07 from csi_t_iva where t_iva=:ls_t_iva_07;
select id_cuenta_inmovilizado into:c_inm_16 from csi_t_iva where t_iva=:ls_t_iva_16;
select id_cuenta_inmovilizado into:c_inm_07 from csi_t_iva where t_iva=:ls_t_iva_07;

//Calculamos nuevas cuentas
c_rep_18=replace(c_rep_16,num_digitos - 1,2,'18')
c_rep_08=replace(c_rep_07,num_digitos - 1,2,'08')
c_sop_18=replace(c_sop_16,num_digitos - 1,2,'18')
c_sop_08=replace(c_sop_07,num_digitos - 1,2,'08')

		insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_08,'H. P. I.V.A. soportado al 8%','', 'D','S') USING bd_temporal;
			cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_08+' En base de datos:'+bd_temporal.Database
			this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
				
		insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_18,'H. P. I.V.A. soportado al 18%','', 'D','S') USING bd_temporal;
			cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_18+' En base de datos:'+bd_temporal.Database
			this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
			
		insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_08,'H. P. I.V.A. repercutido al 8%','', 'D','S') USING bd_temporal;
			cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_08+' En base de datos:'+bd_temporal.Database
			this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
			
		insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_18,'H. P. I.V.A. repercutido al 18%','', 'D','S') USING bd_temporal;
			cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_18+' En base de datos:'+bd_temporal.Database
			this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
		
		
		//Insertamos nuevas cuentas en funci$$HEX1$$f300$$ENDHEX$$n de las cuentas existentes para los tipos de IVA 16% y 7%
		//Inmovilizado
		if not this.of_es_vacio(c_inm_07) then
			c_inm_08=replace(c_inm_07,num_digitos - 1,2,'08')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_inm_08,'H. P. I.V.A. inmovilizado al 8%','', 'D','S') USING bd_temporal; 
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_inm_08+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)		
		end if
		
		if not this.of_es_vacio(c_inm_16) then
			c_inm_18=replace(c_inm_16,num_digitos - 1,2,'18')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_inm_18,'H. P. I.V.A. inmovilizado al 18%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_inm_18+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		//No devengado
		if not this.of_es_vacio(c_rep_no_deven_07) then
			c_rep_no_deven_08=replace(c_rep_no_deven_07,num_digitos - 1,2,'08')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_no_deven_08,'H. P. I.V.A. repercutido pte de devengar al 8%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_no_deven_08+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		
		if not this.of_es_vacio(c_rep_no_deven_16) then
			c_rep_no_deven_18=replace(c_rep_no_deven_16,num_digitos - 1,2,'18')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_no_deven_18,'H. P. I.V.A. repercutido pte de devengar al 18%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_no_deven_18+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		if not this.of_es_vacio(c_sop_no_deven_07) then
			c_sop_no_deven_08=replace(c_sop_no_deven_07,num_digitos - 1,2,'08')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_no_deven_08,'H. P. I.V.A. soportado pte de devengar al 8%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_no_deven_08+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
		end if
		
		if not this.of_es_vacio(c_sop_no_deven_16) then
			c_sop_no_deven_18=replace(c_sop_no_deven_16,num_digitos - 1,2,'18')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_no_deven_18,'H. P. I.V.A. soportado pte de devengar al 18%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_no_deven_18+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if	
		//No deducible
		if not this.of_es_vacio(c_rep_no_deduc_07) then
			c_rep_no_deduc_08=replace(c_rep_no_deduc_07,num_digitos - 1,2,'08')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_no_deduc_08,'H. P. I.V.A. repercutido pte de devengar al 8%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_no_deduc_08+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		
		if not this.of_es_vacio(c_rep_no_deduc_16) then
			c_rep_no_deduc_18=replace(c_rep_no_deduc_16,num_digitos - 1,2,'18')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_rep_no_deduc_18,'H. P. I.V.A. repercutido pte de devengar al 18%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_rep_no_deduc_18+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)
		end if
		if not this.of_es_vacio(c_sop_no_deduc_07) then
			c_sop_no_deduc_08=replace(c_sop_no_deduc_07,num_digitos - 1,2,'08')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_no_deduc_08,'H. P. I.V.A. soportado pte de devengar al 8%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_no_deduc_08+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		if not this.of_es_vacio(c_sop_no_deduc_16) then
			c_sop_no_deduc_18=replace(c_sop_no_deduc_16,num_digitos - 1,2,'18')
			insert into cuentas( cuenta,titulo,resumen,final,empresa) values(:c_sop_no_deduc_18,'H. P. I.V.A. soportado pte de devengar al 18%','', 'D','S') USING bd_temporal;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$creaci$$HEX1$$f300$$ENDHEX$$n cuenta:"+c_sop_no_deduc_18+' En base de datos:'+bd_temporal.Database
				this.of_sql_test(bd_temporal,cadena_log,dw_suceso)	
		end if
		
		//Actualizamos las cuentas en la tabla csi_t_iva para cada tipo de IVA nuevo
		

update csi_t_iva set id_cuenta_repercutido=:c_rep_18,id_cuenta_re=:c_re_16,id_cuenta_soportado=:c_sop_18,cuenta_repercutido_no_deven=:c_rep_no_deven_18,cuenta_soportado_no_deven=:c_sop_no_deven_18,cuenta_repercutido_no_deduc=:c_rep_no_deduc_18, cuenta_soportado_no_deduc=:c_sop_no_deduc_18,id_cuenta_inmovilizado=:c_inm_18 where t_iva='Z8';
	cadena_log = '['+string(today())+'] FALL$$HEX2$$d3002000$$ENDHEX$$asignaci$$HEX1$$f300$$ENDHEX$$n de valor en los campos de cuentas para el tipo de IVA al 8%'
	this.of_sql_test(SQLCA,cadena_log,dw_suceso)
	
update csi_t_iva set id_cuenta_repercutido=:c_rep_08,id_cuenta_re=:c_re_07,id_cuenta_soportado=:c_sop_08,cuenta_repercutido_no_deven=:c_rep_no_deven_08,cuenta_soportado_no_deven=:c_sop_no_deven_08,cuenta_repercutido_no_deduc=:c_rep_no_deduc_08, cuenta_soportado_no_deduc=:c_sop_no_deduc_08,id_cuenta_inmovilizado=:c_inm_08 where t_iva='Z7';
	cadena_log = '['+string(today())+'] FALL$$HEX2$$d3002000$$ENDHEX$$asignaci$$HEX1$$f300$$ENDHEX$$n de valor en los campos de cuentas para el tipo de IVA al 18%'
	this.of_sql_test(SQLCA,cadena_log,dw_suceso)		

return 1
end function

public function integer of_bd_actualizar_articulos (datawindow dw_suceso);//SGC-256

string cadena_log
int retorno
int porcent

if this.of_iva_aplica_cambio_julio_2010( )=-1 then	return 0
	
choose case is_producto
		case 'SIGESCON','ICAV','SICA','GABINETE','FEW','GESTBUILD','UECOE','FEIM','SICAP','SICITT',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
			update csi_articulos_servicios set t_iva='Z7' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_07');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los art$$HEX1$$ed00$$ENDHEX$$culos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
			update csi_articulos_servicios set t_iva='Z8' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_16');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 18% en los art$$HEX1$$ed00$$ENDHEX$$culos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			//SGC-319	
			select porcent into :porcent from csi_t_iva where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_08'); 
			
			UPDATE csi_articulos_servicios SET impuesto = round(importe * :porcent/100,2) WHERE t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_08');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo impuesto en la tabla de art$$HEX1$$ed00$$ENDHEX$$culos para el tipo de IVA al 8%"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			select porcent into :porcent from csi_t_iva where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_18');
			
			UPDATE csi_articulos_servicios SET impuesto = round(importe * :porcent/100,2) WHERE t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_18');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo impuesto en la tabla de art$$HEX1$$ed00$$ENDHEX$$culos para el tipo de IVA al 18%"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			//Fin SGC-319
				
		case 'PUBLIMEDIA'
			Update conceptos set iva ='18' where iva ='16';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los conceptos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
			Update conceptos set iva ='8' where iva ='7';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los conceptos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			//A parte de los art$$HEX1$$ed00$$ENDHEX$$culos se debe actualizar tambi$$HEX1$$e900$$ENDHEX$$n la tabla notas para introducir un tipo de nota que haga referencia al 18% de IVA. Se deja la entrada en tabla que hace referencia al tipo de IVA del 16%:
			
			Insert into notas(codigo, descripcion) select right('000'+ convert(varchar,convert(integer, max(codigo))+ 1), 3 ), '- 18% de IVA no incluido. - Producci$$HEX1$$f300$$ENDHEX$$n no incluida.' From notas;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n en la tabla notas"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
		case 'GIRSA','SERJUTECA','GESFORM','PRODLINE'
			return 0
			
		case else
			return 0	
		
end choose
return 1

end function

public function integer of_bd_actualizar_clientes_proveedores (datawindow dw_suceso);//SGC-267
string cadena_log
string error_log
string mensaje
int retorno

if this.of_iva_aplica_cambio_julio_2010( )=-1 then return 0	

choose case is_producto
	case 'SIGESCON','ICAV','SICA','GABINETE','FEW','GESTBUILD','UECOE','FEIM','SICAP','SICITT',&
		'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
		update csi_proveedores set t_iva='Z7' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_07');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los proveedores"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
		update csi_proveedores set t_iva='Z8' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_16');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 18% en los proveedores"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
	case 'PRODLINE'
		update csi_proveedores set t_iva='Z7' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_07');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los proveedores"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
		update csi_proveedores set t_iva='Z8' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_16');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 18% en los proveedores"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
		update clientes set t_iva='Z7' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_07');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los clientes"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
		update clientes set t_iva='Z8' where t_iva=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_16');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 18% en los clientes"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
	case 'PUBLIMEDIA'
		Update clientes set tipo_impuesto ='Z8' where tipo_impuesto ='03';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% en los clientes"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
	case 'GESFORM','GIRSA','SERJUTECA','FACTURAE'
			return 0
			
	case else
		return 0
		
end choose

return 1
end function

public function integer of_bd_actualizar_cuentas (datawindow dw_suceso);//SGC-254

DataStore ds_Ej_abiertos//Acumular empresas con ejercicio 2010 abierto
n_tr bd_temporal//Conexi$$HEX1$$f300$$ENDHEX$$n temporal.
n_tr bd_ejercicio_actual
string ls_inifile
string nombre_bd
string cadena_log
long j
int retorno=1


if this.of_iva_aplica_cambio_julio_2010( )=-1 then return 0

choose case is_producto
		case 'SIGESCON','SICA','PRODLINE','SICAP','SICITT'		
			
			//En caso de que NO tenga integraci$$HEX1$$f300$$ENDHEX$$n contable, NO seguiremos con el proceso.
			if is_existe_contabilidad='N' then return 1
			
			//Conectamos con base de datos del ejercicio actual
			
			ls_inifile =gnv_app.of_GetAppInifile()

			bd_ejercicio_actual=create n_tr
			If bd_ejercicio_actual.of_init(ls_inifile,"Database_ejer") = -1 then
				//Database_ejer es el nombre de la secci$$HEX1$$f300$$ENDHEX$$n de base de datos en "conta.ini"
				 MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n ha fallado con el fichero "+ ls_inifile,StopSign!)
			 	HALT
			end if
			if bd_ejercicio_actual.of_connect() = -1 then
					 
					MessageBox(g_titulo, "La conexi$$HEX1$$f300$$ENDHEX$$n con la Base de Datos del ejercicio ha fallado." +cr+ bd_ejercicio_actual.sqlerrtext,StopSign!) 
				HALT
			end if
			
			if is_pruebas='S' then
				//Si utlizamos la conexi$$HEX1$$f300$$ENDHEX$$n en pruebas, bd_ejercicio_actual ser$$HEX2$$e1002000$$ENDHEX$$la base de datos con nombre conta200xpru
				retorno=this.of_bd_actualizar_cuentas_inserts( bd_ejercicio_actual,dw_suceso)
		
			else
				
				ds_Ej_abiertos = create datastore
				ds_Ej_abiertos.dataobject = "d_ejercicios_abiertos"
				ds_Ej_abiertos.setTransObject(SQLCA)
				ds_Ej_abiertos.retrieve('2010')//obtener empresa
				for j=1 to ds_Ej_abiertos.rowcount( )
					nombre_bd = 'conta2010' + ds_Ej_abiertos.getItemString(j,'empresa')
					bd_temporal=CREATE n_tr
					bd_temporal.DBMS=bd_ejercicio_actual.DBMS
					bd_temporal.LogID=bd_ejercicio_actual.LogID
					bd_temporal.LogPass=bd_ejercicio_actual.LogPass
					bd_temporal.Autocommit=bd_ejercicio_actual.Autocommit
					bd_temporal.DBParm=bd_ejercicio_actual.DBParm
					bd_temporal.ServerName=bd_ejercicio_actual.ServerName
					bd_temporal.Database=nombre_bd
					CONNECT USING bd_temporal;
		
					//Realizamos inserts en funcion digitos cuenta y cuentas ya creadas
					retorno=this.of_bd_actualizar_cuentas_inserts( bd_temporal,dw_suceso)
					destroy (bd_temporal)
	
				next
			end if
			
			destroy(bd_ejercicio_actual)
			
			return retorno
			
		case 'GIRSA','PUBLIMEDIA','SERJUTECA','ICAV','GABINETE','FEW','GESTBUILD',&
			  'UECOE','FEIM','TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			return 0

		case else
			return 0
		 	
end choose
return 1



end function

public function integer of_bd_actualizar_predefinidos (datawindow dw_suceso);//SGC-240
string cadena_log
int retorno

if this.of_iva_aplica_cambio_julio_2010( ) =-1 then return 0

choose case is_producto
	case 'SIGESCON','SICA','PRODLINE','SICAP','SICITT'
		update csi_lineas_asientos_prede set valor='Z8' where nombre='t_iva' and valor=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_16');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 18% de los asientos predefinidos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
		update csi_lineas_asientos_prede set valor='Z7' where nombre='t_iva' and valor=(select valor_texto FROM csi_param_sigescon WHERE nombre = 'g_t_iva_07');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA al 8% de los asientos predefinidos"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1	
	case else
		return 0
		
end choose
return 1
end function

public function integer of_bd_actualizar_tipos_iva_defecto (datawindow dw_suceso);//SGC-252
string cadena_log
string error_log
string mensaje
int retorno

if this.of_iva_aplica_cambio_julio_2010( ) =-1 then return 0

choose case is_producto
		case 'SIGESCON','ICAV','SICA','GABINETE','GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
				update csi_param_sigescon set valor_texto='Z8' where nombre="g_t_iva_por_defecto";
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA por defecto"
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				
				insert into csi_param_sigescon(nombre,valor_texto,descripcion) values ('g_t_iva_08','Z7','C$$HEX1$$f300$$ENDHEX$$d. en la tabla t_iva para el c$$HEX1$$e100$$ENDHEX$$lculo autom$$HEX1$$e100$$ENDHEX$$tico del tipo de IVA');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del parametro g_t_iva_08"
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
					
				insert into csi_param_sigescon(nombre,valor_texto,descripcion) values ('g_t_iva_18', 'Z8','C$$HEX1$$f300$$ENDHEX$$d. en la tabla t_iva para el c$$HEX1$$e100$$ENDHEX$$lculo autom$$HEX1$$e100$$ENDHEX$$tico del tipo de IVA');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del parametro g_t_iva_18"
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				update var_globales set texto='Z8' where nombre='g_t_iva_defecto';
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del tipo de IVA por defecto"
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
					
					
			
		case 'PUBLIMEDIA','SERJUTECA'
			return 0
				
		case else
			return 0
	end choose
return 1

end function

public function integer of_bd_actualizar_tipos_iva_validez (datawindow dw_suceso);//SGC-248
string cadena_log
string error_log
string mensaje
int retorno
choose case is_producto
		case 'SIGESCON','ICAV','SICA','GABINETE','GIRSA','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
			
			EXECUTE IMMEDIATE "alter table csi_t_iva add f_inicio_validez datetime null";
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_inicio_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			EXECUTE IMMEDIATE "alter table csi_t_iva add f_fin_validez datetime null";
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_fin_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
		case 'SERJUTECA'
			
			EXECUTE IMMEDIATE 'alter table cuentas_IVA add valido_empresa char(1) null';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1

			update cuentas_iva set valido_empresa = 'S';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1

			update cuentas_iva set valido_empresa = 'N' where porcentaje = 0.16 or porcentaje = 0.07;
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
							
			EXECUTE IMMEDIATE "alter table cuentas_iva add f_inicio_validez datetime null";
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_inicio_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
			EXECUTE IMMEDIATE "alter table cuentas_iva add f_fin_validez datetime null";
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_fin_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			Insert into var_globales (nombre,etiqueta,texto) values('g_t_iva_so_defecto', 'C$$HEX1$$f300$$ENDHEX$$digo IVA soportado por defecto', '0000000015');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n de la variable g_t_iva_so_defecto"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
			Insert into var_globales (nombre,etiqueta,texto) values('g_t_iva_re_defecto', 'C$$HEX1$$f300$$ENDHEX$$digo IVA repercutido por defecto', '0000000016');
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n de la variable g_t_iva_so_repercutido"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			update cuentas_iva set f_fin_validez = '20100630' where valido_empresa = 'N'; 
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo f_fin_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
		case 'PUBLIMEDIA'
			
			EXECUTE IMMEDIATE 'alter table tipos_impuestos add valido_empresa char(1) null';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			EXECUTE IMMEDIATE 'alter table tipos_impuestos add f_inicio_validez datetime null';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_inicio_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			EXECUTE IMMEDIATE 'alter table tipos_impuestos add f_fin_validez datetime null';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo f_fin_validez"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
			update tipos_impuestos set valido_empresa = 'S';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
				
			update tipos_impuestos set valido_empresa = 'N', f_fin_validez = '20100630' where codigo = '03';
				cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo valido_empresa"
				retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
				if retorno=-1 then return -1
			
		case else
			return 0
	end choose
return 1


end function

public function integer of_bd_insertar_tipos_iva (datawindow dw_suceso);//SGC-253

string cadena_log
int retorno


if this.of_iva_aplica_cambio_julio_2010( )=-1 then return 0	

choose case is_producto
		case 'SIGESCON','ICAV','SICA','GABINETE','FEW','GESTBUILD','PRODLINE','UECOE','FEIM','SICAP','SICITT',&
			'TEA','GIGA','SUBASTAS GAN.','CSD FACTURAS'
				
				insert into csi_t_iva(t_iva, descripcion, porcent,porcent_re,iva_incluido, valido_empresa, exento) values ('Z7','IVA 8%',8,1,'S','S','N');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 8%"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				insert into csi_t_iva(t_iva, descripcion, porcent,porcent_re,iva_incluido, valido_empresa, exento) values ('Z8','IVA 18%',18,4,'S','S','N');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 18%"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				update csi_t_iva set f_inicio_validez='2010/07/01' where porcent=18 or porcent=8;
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo fecha_inicio_validez"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				update csi_t_iva set f_fin_validez='2010/06/30' ,valido_empresa='N' where porcent=16 or porcent=7;
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo fecha_fin_validez"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
		case 'SERJUTECA'
			
				insert into cuentas_iva (cuenta, tipo_iva, iva, titulo_cuenta, porcentaje, id_cuenta_iva, valido_empresa, f_inicio_validez) values('47700008', 'R', '08%', 'HDA.PUBL.IVA REP. 8', 0.08, '0000000013', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 8% repercutido"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1

				insert into cuentas_iva (cuenta, tipo_iva, iva, titulo_cuenta, porcentaje, id_cuenta_iva, valido_empresa, f_inicio_validez) values('47200008', 'S', '08%', 'HDA.PUBL.IVA SOP. 8', 0.08, '0000000014', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 8% soportado"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1

				insert into cuentas_iva (cuenta, tipo_iva, iva, titulo_cuenta, porcentaje, id_cuenta_iva, valido_empresa, f_inicio_validez) values('47200018', 'S', '18%', 'HDA.PUBL.IVA SOP. 18', 0.18, '0000000015', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 18% soportado"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1

				insert into cuentas_iva (cuenta, tipo_iva, iva, titulo_cuenta, porcentaje, id_cuenta_iva, valido_empresa, f_inicio_validez) values('47700018', 'R', '18%', 'HDA.PUBL.IVA REP. 18', 0.18, '0000000016', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 18% repercutido"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
			
		Case 'PUBLIMEDIA'

				Insert into tipos_impuestos (codigo, descripcion, porcentaje, cuenta_contable, valido_empresa, f_inicio_validez) values('Z7','IVA 8%', 8,'4770', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 8% "
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				Insert into tipos_impuestos (codigo, descripcion, porcentaje, cuenta_contable, valido_empresa, f_inicio_validez) values('Z8','IVA 18%', 18,'4770', 'S', '20100701');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 18% "+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
			
		case 'GIRSA' 
				
				insert into csi_t_iva(t_iva, descripcion, porcent,iva_incluido, valido_empresa, exento) values ('Z7','IVA 8%',8,'S','S','N');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 8%"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				insert into csi_t_iva(t_iva, descripcion, porcent,iva_incluido, valido_empresa, exento) values ('Z8','IVA 18%',18,'S','S','N');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del nuevo tipo de IVA al 18%"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				update csi_t_iva set f_inicio_validez='2010/07/01' where porcent=18 or porcent=8;
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo fecha_inicio_validez"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				update csi_t_iva set f_fin_validez='2010/06/30' ,valido_empresa='N' where porcent=16 or porcent=7;
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la actualizaci$$HEX1$$f300$$ENDHEX$$n del campo fecha_fin_validez"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
				
				INSERT INTO var_globales (nombre,valor_texto) VALUES ('g_t_iva_defecto','08');
					cadena_log = "["+string(today())+"] FALL$$HEX2$$d3002000$$ENDHEX$$la creaci$$HEX1$$f300$$ENDHEX$$n del campo g_t_iva_defecto"+cr+"Error:"+SQLCA.sqlerrtext
					retorno=this.of_sql_test(SQLCA,cadena_log,dw_suceso)
					if retorno=-1 then return -1
			
		case else
			return 0
	end choose
return 1
end function

public function integer of_actualizacion_correcta (string mensaje);//SGC-321

string ls_estado

select estado into :ls_estado from ivajulio2010;
//No existe la tabla de control
if SQLCA.sqlcode=-1 then 
	return 0
	
//Existe la tabla de control pero no contenga el valor 'F' en el campo estado.
elseif SQLCA.sqlcode<>-1 and ls_estado <> 'F' then
	if mensaje='S' then messagebox(g_titulo,'La actualizaci$$HEX1$$f300$$ENDHEX$$n para los nuevos tipos de IVA 2010 no se realiz$$HEX2$$f3002000$$ENDHEX$$correctamente.'+cr+'Ponganse en contacto con CSD S.A',EXCLAMATION!,OK!)
	return -1 //Actualizaci$$HEX1$$f300$$ENDHEX$$n no termin$$HEX2$$f3002000$$ENDHEX$$correctamente
	
//Existe la tabla de control y contenga el valor 'F' en el campo estado.
else
	return 1 //Actualizaci$$HEX1$$f300$$ENDHEX$$n termino correctamente
end if
end function

public function integer of_bd_actualizar ();string ls_estado
int retorno
int valido

//SGC-281
if (is_producto='SIGESCON' AND is_colegio = 'PRODLINE') then return 1

if is_producto='GESFORM' OR is_producto='FACTURAE' OR is_producto='VISARED' OR is_producto='FRONTEND' then return 1
//Fin SGC-281


//PUBLIMEDIA siempre ejecutar$$HEX2$$e1002000$$ENDHEX$$este proceso para as$$HEX2$$ed002000$$ENDHEX$$modificar el .ini de todos los usuarios.
If is_producto = 'PUBLIMEDIA' then
   string ls_inifile
   ls_inifile = gnv_app.of_GetUserIniFile()

   if (ProfileString(ls_inifile,'Defecto','impuesto','03')='03') then 
       SetProfileString(ls_inifile,'Defecto','impuesto','Z8')
   End if
End if

//Comprobamos si se ha realizado la actualizaci$$HEX1$$f300$$ENDHEX$$n
valido=gnv_ivajulio2010.of_actualizacion_correcta('S')

if valido=0 then 
	//SGC-318
	retorno=messagebox(g_titulo,'Se va a realizar el proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n para activar los cambios en el IVA 2010 $$HEX1$$bf00$$ENDHEX$$Quiere continuar?',Exclamation!, YesNo!,1)
	if retorno=2 then 
		HALT
	end if
	il_file_log=fileopen("C:\log_ivajulio2010.txt",LineMode!,Write!,LockWrite!,Append!)
	
	open(w_actualizacion_ivajulio2010)
	
	return 1
end if

return 1

end function

on n_csd_ivajulio2010.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_ivajulio2010.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

