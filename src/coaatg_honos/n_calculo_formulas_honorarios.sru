HA$PBExportHeader$n_calculo_formulas_honorarios.sru
forward
global type n_calculo_formulas_honorarios from n_calculo_formulas
end type
end forward

global type n_calculo_formulas_honorarios from n_calculo_formulas
end type
global n_calculo_formulas_honorarios n_calculo_formulas_honorarios

type variables
//u_csd_dw idw_parametros


constant string VARIABLE_H = "H"

end variables

forward prototypes
public function boolean f_mostrar_ventana (ref any resultado)
public subroutine f_recargar_formula ()
public subroutine f_inicializar ()
public function any f_valor_variable_auto_proceso (string variable)
end prototypes

public function boolean f_mostrar_ventana (ref any resultado);//SOBREESCRITO
// Abre la ventana que muestra las f$$HEX1$$f300$$ENDHEX$$rmulas y variables del objeto y que permite modificar
// los valores.

i_aceptada_ventana = false
//openwithparm(w_coaatg_honos_detalle, this)
OpenSheetWithParm(w_coaatg_honos_detalle,this,'w_coaatg_honos_detalle',w_aplic_frame,0,original!)
if i_aceptada_ventana then
	resultado = f_get_valor_variable(i_variable_resultado)
	return true
else
	return false
end if

end function

public subroutine f_recargar_formula ();//string c_trabajo
//string id_formula
//long fila_var
//string colegio
//colegio = f_colegio()
//
//f_establecer_variable_resultado("H")

//datawindowchild dwc_capitulo
//datawindowchild dwc_subcapitulo
//datawindowchild dwc_apartado
//
//idw_capitulos.getchild('capitulo', dwc_capitulo)
//idw_capitulos.getchild('capitulo_nivel2', dwc_subcapitulo)
//idw_capitulos.getchild('capitulo_nivel3', dwc_apartado)
//
//id_formula = dwc_apartado.getitemstring(dwc_apartado.getrow(), 'id_formula')
//messagebox('id_formula', id_formula)


//c_trabajo = idw_capitulosidw_fases_usos_formulas.GetItemString(f_fila_fases_usos_formulas(),'trabajo')

//// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
//SELECT usos_tasas.id_formula INTO :id_formula FROM usos_tasas WHERE usos_tasas.c_trabajo = :c_trabajo AND colegio = :colegio;
//if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
//	// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
//	SELECT usos_tasas.id_formula INTO :id_formula FROM usos_tasas WHERE usos_tasas.c_trabajo = :c_trabajo;
//end if
//	
//

//fila_var = i_calculo_formulas.f_fila_variable(i_calculo_formulas.VARIABLE_H)
//ds_variables.setitem(fila_var, 'id_formula', id_formula)
//
end subroutine

public subroutine f_inicializar ();i_ambito = "H"
i_id_ambito = '0000000000'
i_titulo_ventana = 'NADA'


f_establecer_variable_resultado("H")
i_titulo_ventana = 'Ventana general'
//f_cargar_variables()
//f_recargar_formula()
end subroutine

public function any f_valor_variable_auto_proceso (string variable);//choose case variable
//	case 'S'
//		if not isnull(idw_parametros) then return idw_parametros.getitemnumber(1,'superficie')
//	case 'P'
//		if not isnull(idw_parametros) then return idw_parametros.getitemnumber(1,'pem')
//end choose		
return 1
end function

on n_calculo_formulas_honorarios.create
call super::create
end on

on n_calculo_formulas_honorarios.destroy
call super::destroy
end on

