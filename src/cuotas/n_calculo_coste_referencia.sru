HA$PBExportHeader$n_calculo_coste_referencia.sru
$PBExportComments$objetos b$$HEX1$$e100$$ENDHEX$$sicos
forward
global type n_calculo_coste_referencia from n_calculo_formulas
end type
end forward

global type n_calculo_coste_referencia from n_calculo_formulas
end type
global n_calculo_coste_referencia n_calculo_coste_referencia

type variables
u_dw idw_fases_usos_formulas
u_dw idw_fases_detalle


// Usadas en Granada
constant string VARIABLE_MC = "Mc"
constant string VARIABLE_MO = "Mo"
constant string VARIABLE_FL = "Fl"
constant string VARIABLE_FT = "Ft"
constant string VARIABLE_FC = "Fc"
constant string VARIABLE_MR = "Mr"

// Usadas en Almer$$HEX1$$ed00$$ENDHEX$$a
constant string VARIABLE_Z = "Z"
constant string VARIABLE_UT = "UT"
constant string VARIABLE_P = "P"
constant string VARIABLE_CP = "Cp"
constant string VARIABLE_SUPERFICIE = "S"

constant string VARIABLE_SUPERFICIE_LINEA = "Superf"

end variables

forward prototypes
public subroutine f_inicializar (long fila_fases_usos_formulas)
public subroutine f_recargar_formula ()
public function long f_fila_fases_usos_formulas ()
public function boolean f_mostrar_ventana (ref any resultado)
public function any f_valor_variable_auto_proceso (string variable)
end prototypes

public subroutine f_inicializar (long fila_fases_usos_formulas);f_inicializar()

i_ambito = "CR" // Coste referencia
i_id_ambito = idw_fases_usos_formulas.Getitemstring(fila_fases_usos_formulas,'id_uso')

i_titulo_ventana = "C$$HEX1$$e100$$ENDHEX$$lculo Coste Referencia"

f_cargar_variables()
f_recargar_formula()


end subroutine

public subroutine f_recargar_formula ();string c_trabajo
string id_formula
long fila_var
string colegio
colegio = f_colegio()

f_establecer_variable_resultado(VARIABLE_MC)

c_trabajo = idw_fases_usos_formulas.GetItemString(f_fila_fases_usos_formulas(),'trabajo')

// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
SELECT usos_tasas.id_formula INTO :id_formula FROM usos_tasas WHERE usos_tasas.c_trabajo = :c_trabajo AND colegio = :colegio;
if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
	// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
	SELECT usos_tasas.id_formula INTO :id_formula FROM usos_tasas WHERE usos_tasas.c_trabajo = :c_trabajo;
end if
	

fila_var = f_fila_variable(VARIABLE_MC)
ds_variables.setitem(fila_var, 'id_formula', id_formula)

end subroutine

public function long f_fila_fases_usos_formulas ();return idw_fases_usos_formulas.find('id_uso = "' + i_id_ambito + '"', 1, idw_fases_usos_formulas.rowcount())
end function

public function boolean f_mostrar_ventana (ref any resultado);i_aceptada_ventana = false

// Como esta PBL es la misma en SICA que en VISARED, si estamos en VISARED mostramos una ventana con el aspecto de las de VISARED
if g_titulo = "Front-end de Visado" then
	openwithparm(w_calculo_formulas_visared, this)
else
	openwithparm(w_calculo_formulas, this)
end if

if i_aceptada_ventana then
	resultado = f_get_valor_variable(i_variable_resultado)
	return true
else
	return false
end if

end function

public function any f_valor_variable_auto_proceso (string variable);long i, fila_uso


fila_uso = f_fila_fases_usos_formulas()

choose case variable
	case VARIABLE_MO, VARIABLE_CP
		
		double Mo
		string c_trabajo

		c_trabajo = idw_fases_usos_formulas.GetItemString(fila_uso,'trabajo')
		
		setnull(Mo)
		
		// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
		SELECT modulo_base INTO :Mo FROM usos_tasas WHERE c_trabajo = :c_trabajo and colegio = :i_colegio;
		if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
			// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
			SELECT modulo_base INTO :Mo FROM usos_tasas WHERE c_trabajo = :c_trabajo;
		end if
		
		return Mo
		
	case VARIABLE_FL, VARIABLE_Z
		
		double Fl
		string poblacion
		
		// En entre SICA y Visared los nombres de los campos son distintos
		if idw_fases_detalle.describe("id_pob.ColType") <> "!" then
			poblacion = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'id_pob') // Visared
		else
			poblacion = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'poblacion') // SICA
		end if
		
		setnull(Fl)
		
		// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
		SELECT cantidad INTO :Fl FROM poblaciones, modulo_poblaciones WHERE poblaciones.modulo = modulo_poblaciones.modulo and poblaciones.cod_pob = :poblacion;
		if isnull(Fl) then
			// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED
			SELECT cantidad INTO :Fl FROM poblaciones, modulo_poblaciones WHERE poblaciones.modulo = modulo_poblaciones.modulo and poblaciones.id_pob = :poblacion;
		end if
		
		return Fl

	case VARIABLE_FT, VARIABLE_UT
		
		double Ft
		
		c_trabajo = idw_fases_usos_formulas.GetItemString(fila_uso,'trabajo')
		
		setnull(Ft)
		
		// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
		SELECT ct INTO :Ft FROM usos_tasas WHERE c_trabajo = :c_trabajo and colegio = :i_colegio;
		if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
			// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
			SELECT ct INTO :Ft FROM usos_tasas WHERE c_trabajo = :c_trabajo;
		end if
			
		return Ft
		
	case VARIABLE_FC, VARIABLE_P
		
		double Fc
		
		c_trabajo = idw_fases_usos_formulas.GetItemString(fila_uso,'trabajo')
		
		setnull(Fc)
		
		// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
		SELECT cc INTO :Fc FROM usos_tasas WHERE c_trabajo = :c_trabajo and colegio = :i_colegio;
		if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
			// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
			SELECT cc INTO :Fc FROM usos_tasas WHERE c_trabajo = :c_trabajo;
		end if
			
		return Fc
		
	case VARIABLE_MR
		
		double Mr, superf, max_superf
		long fila_max_superf
		string notas
		
		fila_max_superf = 0
		max_superf = 0
		
		for i = 1 to idw_fases_usos_formulas.RowCount()
			
			if i = fila_uso then continue
			
			c_trabajo = idw_fases_usos_formulas.GetItemString(i,'trabajo')
			notas = ''
			
			// S$$HEX1$$f300$$ENDHEX$$lo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED Multicolegio
			SELECT notas INTO :notas FROM usos_tasas WHERE c_trabajo = :c_trabajo and colegio = :i_colegio;
			if (SQLCA.SqlCode <> 0 and SQLCA.SqlCode <> 100) then
				// Funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
				SELECT notas INTO :notas FROM usos_tasas WHERE c_trabajo = :c_trabajo ;
			end if
			
			if notas = 'ANEX' then
				
				superf = idw_fases_usos_formulas.getitemnumber(i, 'superficie')
				if superf > max_superf then
					fila_max_superf = i
					max_superf = superf
				end if
				
			end if
		
		next
		
		if fila_max_superf > 0 then
			Mr = idw_fases_usos_formulas.getitemnumber(fila_max_superf, 'precio_m2')
		else
			setnull(Mr)
		end if
		return Mr
		
	case VARIABLE_SUPERFICIE
		if idw_fases_usos_formulas.rowcount() > 0 then
			return idw_fases_usos_formulas.GetItemNumber(idw_fases_usos_formulas.RowCount(),'suma_superficie')
		else
			return 0
		end if		
		
	case VARIABLE_SUPERFICIE_LINEA
		
		return idw_fases_usos_formulas.GetItemNumber(fila_uso,'superficie')

	case else
		
		return super::f_valor_variable_auto_proceso(variable)
			
end choose

end function

on n_calculo_coste_referencia.create
call super::create
end on

on n_calculo_coste_referencia.destroy
call super::destroy
end on

