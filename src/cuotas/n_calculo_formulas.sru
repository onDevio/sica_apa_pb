HA$PBExportHeader$n_calculo_formulas.sru
forward
global type n_calculo_formulas from nonvisualobject
end type
type ds_variables from n_ds within n_calculo_formulas
end type
end forward

global type n_calculo_formulas from nonvisualobject
ds_variables ds_variables
end type
global n_calculo_formulas n_calculo_formulas

type variables
public:

// i_ambito es un c$$HEX1$$f300$$ENDHEX$$digo de 2 caracteres que junto con i_id_ambito se utiliza para saber
// que variables de la tabla coeficientes_variables se deben utlizar para el calculo de las
// f$$HEX1$$f300$$ENDHEX$$rmulas.
//
// Por ejemplo, siendo:
//
// i_ambito = 'FA'
// i_id_ambito = id_fase
//
// cada fase podr$$HEX2$$e1002000$$ENDHEX$$tener unas variables propias para esa fase.
string i_ambito
string i_id_ambito

// existen variables cuyo valor va cambiando a lo largo del tiempo, i_fecha indica de que momento se deben tomar esos valores
datetime i_fecha

// Nombre de la variable cuyo valor se calcular$$HEX2$$e1002000$$ENDHEX$$al invocar a f_calcular_resultado
string i_variable_resultado

// T$$HEX1$$ed00$$ENDHEX$$tulo que tendr$$HEX2$$e1002000$$ENDHEX$$la ventana de f_mostrar_ventana
string i_titulo_ventana
// Si se aceptaron los cambios de la ventana de f_mostrar_ventana [para uso interno]
boolean i_aceptada_ventana

// Si se encuentra alguna condici$$HEX1$$f300$$ENDHEX$$n an$$HEX1$$f300$$ENDHEX$$mala al calcular las f$$HEX1$$f300$$ENDHEX$$rmulas, i_mostrar_errores indica si se mostrar$$HEX2$$e1002000$$ENDHEX$$un mensaje de error o no
boolean i_mostrar_errores = true


constant string TIPO_VARIABLE_FORMULA = 'F'
constant string TIPO_VARIABLE_CONSTANTE = 'C'
constant string TIPO_VARIABLE_RANGO = 'R'
constant string TIPO_VARIABLE_USUARIO = 'U'
constant string TIPO_VARIABLE_AUTO_PROCESO = 'A'

constant string TIPO_DATOS_NUMBER = 'N'
constant string TIPO_DATOS_DECIMAL = 'C'
constant string TIPO_DATOS_STRING = 'S'
constant string TIPO_DATOS_DATE = 'D'
constant string TIPO_DATOS_TIME = 'T'
constant string TIPO_DATOS_DATETIME = 'DT'
constant string TIPO_DATOS_BOOLEAN = 'B'


protected:
string i_colegio

end variables

forward prototypes
public subroutine f_inicializar ()
public function boolean f_compara_any_menor (any valor1, any valor2, boolean nulo_menor)
public function boolean f_mostrar_ventana (ref any resultado)
public subroutine f_reset_estado_calculado ()
public function any f_string_a_any (string valor, string tipo_datos)
public function boolean f_compara_any_igual (any valor1, any valor2)
public subroutine f_borrar_variables ()
public subroutine f_guardar_variables ()
public function string f_coeficientes_id_formula (string variable)
public subroutine f_coeficientes_parametros_rango (string variable, ref string parametro_rango_1, ref string parametro_rango_2, ref string parametro_rango_3)
public function any f_get_valor_variable_calculado (string variable)
public function long f_fila_variable (string variable)
public subroutine f_rellenar_dwc_valores_lista ()
public subroutine f_cargar_variables ()
public function any f_evaluar_rango (string variable, any parametro_rango_1, any parametro_rango_2, any parametro_rango_3)
public subroutine f_establecer_variable_resultado (string variable)
public subroutine f_coeficientes_datos (string variable, ref string tipo, ref string tipo_datos, ref string grupo, ref double orden, ref string descripcion)
public function any f_valor_variable_auto_proceso (string variable)
public function long f_fila_variable (string variable, boolean ignorar_mayusc)
public function any f_calcular_resultado ()
public function string f_coeficientes_valor (string variable)
public function string f_any_a_string_expression (any valor)
public function any f_calcular_variable (string variable)
public function any f_evaluar_formula (string formula)
public subroutine f_set_valor_variable (string variable, any valor, boolean solo_calculado, boolean solo_real)
public function string f_any_a_string (any valor, ref string tipo_datos)
public function any f_get_valor_variable (string variable)
end prototypes

public subroutine f_inicializar ();
end subroutine

public function boolean f_compara_any_menor (any valor1, any valor2, boolean nulo_menor);// Devuelve true si de dos valores any, que se asume que tiene el mismo tipo, el primero
// es menor que el segundo. Con los valores nulos se considerar$$HEX2$$e1002000$$ENDHEX$$que un nulo es menor que
// cualquier otra cosa si nulo_menor es true, o que no hay nada menor que un nulo si
// nulo_menor es false.

if isnull(valor1) then return nulo_menor
if isnull(valor2) then return not nulo_menor
return valor1 < valor2

end function

public function boolean f_mostrar_ventana (ref any resultado);// Abre la ventana que muestra las f$$HEX1$$f300$$ENDHEX$$rmulas y variables del objeto y que permite modificar
// los valores.

i_aceptada_ventana = false
openwithparm(w_calculo_formulas, this)
if i_aceptada_ventana then
	resultado = f_get_valor_variable(i_variable_resultado)
	return true
else
	return false
end if

end function

public subroutine f_reset_estado_calculado ();// Para evitar calcular dos veces una misma variable existe una columna temporal 'calculado' que
// indica si ya se ha calculado esa variable anteriormente. Antes de empezar el c$$HEX1$$e100$$ENDHEX$$lculo de todas
// las variables hay que resetear el estado de esa columna llamando a f_reset_estado.

long i

for i = 1 to ds_variables.rowcount()
	ds_variables.setitem(i, 'calculado', 'N')
next

end subroutine

public function any f_string_a_any (string valor, string tipo_datos);/* Convierte un valor string a su tipo verdadero devolvi$$HEX1$$e900$$ENDHEX$$ndolo como any. si el string no es
convertible a ese tipo de datos devuelve nulo. */

choose case tipo_datos
	case TIPO_DATOS_NUMBER
		if isnull(valor) or not isnumber(valor) then
			double n
			setnull(n)
			return n
		else
			return double(valor)
		end if
		
	case TIPO_DATOS_DECIMAL
		if isnull(valor) or not isnumber(valor) then
			decimal c
			setnull(c)
			return c
		else
			return dec(valor)
		end if
		
	case TIPO_DATOS_STRING
		if isnull(valor) then
			string s
			setnull(s)
			return s
		else
			return string(valor)
		end if
		
	case TIPO_DATOS_DATE
		if isnull(valor) or not isdate(valor) then
			date d
			setnull(d)
			return d
		else
			return date(valor)
		end if
		
	case TIPO_DATOS_TIME
		if isnull(valor) or not istime(valor) then
			time t
			setnull(t)
			return t
		else
			return time(valor)
		end if
		
	case TIPO_DATOS_DATETIME
		boolean valido
		string valor_date
		string valor_time
		long p
		
		if isnull(valor) then
			valido = false
		else
			valor_date = trim(valor)
			p = PosA(valor_date, ' ')
			if p > 0 then
				valor_time = MidA(valor_date, p + 1)
				valor_date = LeftA(valor_date, p - 1)
				valido = isdate(valor_date) and istime(valor_time)
			else
				valido = false
			end if
		end if
		
		if not valido then
			datetime dt
			setnull(dt)
			return dt
		else
			return datetime(date(valor_date), time(valor_time))
		end if

	case TIPO_DATOS_BOOLEAN
		boolean b
		
		if isnull(valor) or (valor <> 'S' and valor <> 'N') then
			setnull(b)
			return b
		else
			b = valor = 'S'
			return b
		end if
		
	case else
		any a
		setnull(a)
		return a
		
end choose

end function

public function boolean f_compara_any_igual (any valor1, any valor2);// Devuelve true si dos valores any, que se asume que tiene el mismo tipo, son iguales. Con los
// valores nulos se considerar$$HEX2$$e1002000$$ENDHEX$$que un nulo es igual a otro nulo.

if isnull(valor1) then
	return isnull(valor2)
elseif isnull(valor2) then
	return false
end if
return valor1 = valor2

end function

public subroutine f_borrar_variables ();// Vac$$HEX1$$ed00$$ENDHEX$$a ds_variables

do while ds_variables.rowcount() > 0
	ds_variables.deleterow(1)
loop

end subroutine

public subroutine f_guardar_variables ();// Guarda el estado actual de las variables en la BD
ds_variables.update()
// Por alguna extra$$HEX1$$f100$$ENDHEX$$a razon despues de usar la funcion setfullstate sobre ds_variables (en
// w_calculo_formulas) si al hacer el update hay filas borradas, siguen quedando pendientes
// de borrar despues del update (aunque si que se borran realmente). Esto implica que si
// se repite el update dara error al volver a intentar borrar una fila de la BD que no existe.
// Para evitarlo nos deshacemos de las filas borradas.
ds_variables.rowsdiscard(1, ds_variables.deletedcount(), Delete!)

end subroutine

public function string f_coeficientes_id_formula (string variable);string id_formula

id_formula = ''

if not isnull(i_fecha) then
	select id_formula into :id_formula from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha >= :i_fecha)
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por fecha hace que se devuelva la fila con la fecha m$$HEX1$$e100$$ENDHEX$$s cercana a la de i_fecha
		order by colegio desc, fecha asc ;
end if
if isnull(i_fecha) or sqlca.sqlcode <> 0 then
	select id_formula into :id_formula from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha is null)
		order by colegio desc ;
end if

return id_formula
end function

public subroutine f_coeficientes_parametros_rango (string variable, ref string parametro_rango_1, ref string parametro_rango_2, ref string parametro_rango_3);parametro_rango_1 = ''
parametro_rango_2 = ''
parametro_rango_3 = ''

if not isnull(i_fecha) then
	select parametro_rango_1, parametro_rango_2, parametro_rango_3
		into :parametro_rango_1, :parametro_rango_2, :parametro_rango_3
		from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha >= :i_fecha)
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por fecha hace que se devuelva la fila con la fecha m$$HEX1$$e100$$ENDHEX$$s cercana a la de i_fecha
		order by colegio desc, fecha asc ;
end if
if isnull(i_fecha) or sqlca.sqlcode <> 0 then
	select parametro_rango_1, parametro_rango_2, parametro_rango_3
		into :parametro_rango_1, :parametro_rango_2, :parametro_rango_3
		from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha is null)
		order by colegio desc ;
end if

end subroutine

public function any f_get_valor_variable_calculado (string variable);// Obtiene el valor calculado de la variable indicada

long fila
any valor
string valor_str

fila = f_fila_variable(variable)
valor_str = ds_variables.getitemstring(fila, 'valor_calculado')
valor = f_string_a_any(valor_str, ds_variables.getitemstring(fila, 'tipo_datos'))

if isnull(valor) and not f_es_vacio(valor_str) then
	if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: el tipo de datos no coincide para la variable " + variable + ".")
end if

return valor
end function

public function long f_fila_variable (string variable);return f_fila_variable(variable, false)
end function

public subroutine f_rellenar_dwc_valores_lista ();// Hacemos el retrieve del dddw valor_lista con los retrieval arguments necesarios
datawindowchild dwc_lista
ds_variables.getchild('valor_lista', dwc_lista)
if dwc_lista.rowcount() = 0 then
	dwc_lista.SetTransObject(SQLCA)
	if dwc_lista.retrieve('%', f_colegio()) = 0 then
		dwc_lista.insertrow(0) // Esto es para que no saque la ventana pidiendo los retrieval arguments si no hay filas
	end if
end if
end subroutine

public subroutine f_cargar_variables ();// Carga el $$HEX1$$fa00$$ENDHEX$$ltimo estado de las variables guardado con f_guardar_variables en la BD


f_rellenar_dwc_valores_lista()

ds_variables.retrieve(i_ambito, i_id_ambito)

end subroutine

public function any f_evaluar_rango (string variable, any parametro_rango_1, any parametro_rango_2, any parametro_rango_3);/* Determina el valor de una variable de tipo rango en funci$$HEX1$$f300$$ENDHEX$$n del valor de los par$$HEX1$$e100$$ENDHEX$$metros. */

n_ds ds_rangos
any valor_rango
any rango_inferior_1[], rango_superior_1[], rango_inferior_2[], rango_superior_2[], rango_inferior_3[], rango_superior_3[]
long fila_rango[]
long num_rangos, min_rango
long i
any valor_nulo
setnull(valor_nulo)

// Obtenemos los rango de esta variable
ds_rangos = create n_ds
ds_rangos.dataobject = 'd_formulas_evaluar_rango'
ds_rangos.of_settransobject(SQLCA)
ds_rangos.retrieve(variable, i_colegio, i_fecha)


// Si alg$$HEX1$$fa00$$ENDHEX$$n rango es especifico para el colegio nos quedamos s$$HEX1$$f300$$ENDHEX$$lo con los rangos del colegio
if ds_rangos.find("colegio = '" + i_colegio + "'", 1, ds_rangos.rowcount()) > 0 then
	for i = 1 to ds_rangos.rowcount()
		if f_es_vacio(ds_rangos.getitemstring(i, 'colegio')) then
			ds_rangos.deleterow(i)
			i --
		end if
	next	
end if

// Si alg$$HEX1$$fa00$$ENDHEX$$n rango es especifico para una fecha nos quedamos s$$HEX1$$f300$$ENDHEX$$lo con los rangos de la fecha m$$HEX1$$e100$$ENDHEX$$s peque$$HEX1$$f100$$ENDHEX$$a (la m$$HEX1$$e100$$ENDHEX$$s cercana a i_fecha)
datetime fecha_min, fecha
setnull(fecha_min)
for i = 1 to ds_rangos.rowcount()
	fecha = ds_rangos.getitemdatetime(i, 'fecha') 
	if isnull(fecha_min) then
		fecha_min = fecha
	else
		if fecha < fecha_min then fecha_min = fecha
	end if
next
if not isnull(fecha_min) then
	for i = 1 to ds_rangos.rowcount()
		if ds_rangos.getitemdatetime(i, 'fecha') <> fecha_min then
			ds_rangos.deleterow(i)
			i --
		end if
	next	
end if



// Determinamos que rangos satisfacen los par$$HEX1$$e100$$ENDHEX$$metros
num_rangos = 1
for i = 1 to ds_rangos.rowcount()
	if not isnull(parametro_rango_1) then
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_inferior'))
		if not isnull(valor_rango) then
			if not parametro_rango_1 >= valor_rango then continue
		end if
		rango_inferior_1[num_rangos] = valor_rango
		
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_superior'))
		if not isnull(valor_rango) then
			if not parametro_rango_1 <= valor_rango then continue
		end if
		rango_superior_1[num_rangos] = valor_rango
	else
		rango_inferior_1[num_rangos] = valor_nulo
		rango_superior_1[num_rangos] = valor_nulo
	end if

	if not isnull(parametro_rango_2) then
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_inferior_2'))
		if not isnull(valor_rango) then
			if not parametro_rango_2 >= valor_rango then continue
		end if
		rango_inferior_2[num_rangos] = valor_rango
		
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_superior_2'))
		if not isnull(valor_rango) then
			if not parametro_rango_2 <= valor_rango then continue
		end if
		rango_superior_2[num_rangos] = valor_rango
	else
		rango_inferior_2[num_rangos] = valor_nulo
		rango_superior_2[num_rangos] = valor_nulo
	end if

	if not isnull(parametro_rango_3) then
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_inferior_3'))
		if not isnull(valor_rango) then
			if not parametro_rango_3 >= valor_rango then continue
		end if
		rango_inferior_3[num_rangos] = valor_rango
		
		valor_rango = f_evaluar_formula(ds_rangos.GetItemString(i, 'rango_superior_3'))
		if not isnull(valor_rango) then
			if not parametro_rango_3 <= valor_rango then continue
		end if
		rango_superior_3[num_rangos] = valor_rango
	else
		rango_inferior_3[num_rangos] = valor_nulo
		rango_superior_3[num_rangos] = valor_nulo
	end if
	
	fila_rango[num_rangos] = i
	num_rangos++
next

num_rangos --

// Si ning$$HEX1$$fa00$$ENDHEX$$n rango satisface los par$$HEX1$$e100$$ENDHEX$$metros devolvemos el valor por defecto
if num_rangos = 0 then
	return f_evaluar_formula(f_coeficientes_valor(variable))
end if


// Si ha habido m$$HEX1$$e100$$ENDHEX$$s de un rango v$$HEX1$$e100$$ENDHEX$$lido buscamos aquel que tiene valores m$$HEX1$$e100$$ENDHEX$$s peque$$HEX1$$f100$$ENDHEX$$os de intervalos,
// as$$HEX2$$ed002000$$ENDHEX$$nos aseguramos de que siempre cojeremos el mismo rango independientemente del orden en el
// que hayan quedado almacenados en la BD.
min_rango = 1
for i = 2 to num_rangos
	
	if f_compara_any_menor(rango_inferior_1[i], rango_inferior_1[min_rango], true) then
		min_rango = i
	elseif f_compara_any_igual(rango_inferior_1[i], rango_inferior_1[min_rango]) then
		if f_compara_any_menor(rango_superior_1[i], rango_superior_1[min_rango], false) then
			min_rango = i
		elseif f_compara_any_igual(rango_superior_1[i], rango_superior_1[min_rango]) then
			
			if f_compara_any_menor(rango_inferior_2[i], rango_inferior_2[min_rango], true) then
				min_rango = i
			elseif f_compara_any_igual(rango_inferior_2[i], rango_inferior_2[min_rango]) then
				if f_compara_any_menor(rango_superior_2[i], rango_superior_2[min_rango], false) then
					min_rango = i
				elseif f_compara_any_igual(rango_superior_2[i], rango_superior_2[min_rango]) then
					
					if f_compara_any_menor(rango_inferior_3[i], rango_inferior_3[min_rango], true) then
						min_rango = i
					elseif f_compara_any_igual(rango_inferior_3[i], rango_inferior_3[min_rango]) then
						if f_compara_any_menor(rango_superior_3[i], rango_superior_3[min_rango], false) then
							min_rango = i
						end if
					end if
					
				end if
			end if
			
		end if
	end if
next

// Devolvemos el valor asociado al rango m$$HEX1$$e100$$ENDHEX$$s peque$$HEX1$$f100$$ENDHEX$$o
return f_evaluar_formula(ds_rangos.getitemstring(fila_rango[min_rango], 'valor'))

end function

public subroutine f_establecer_variable_resultado (string variable);// Establece el nombre de la variable que se considerar$$HEX2$$e1002000$$ENDHEX$$como la variable de resultado a
// la hora de llamar a f_calcular_resultado.

long fila_var

i_variable_resultado = variable

fila_var = f_fila_variable(variable)
if fila_var <= 0 then
	fila_var = ds_variables.event csd_nueva_variable(variable)
end if

end subroutine

public subroutine f_coeficientes_datos (string variable, ref string tipo, ref string tipo_datos, ref string grupo, ref double orden, ref string descripcion);grupo = ''
orden = 0
tipo = ''
tipo_datos = ''
descripcion = ''

if not isnull(i_fecha) then
	select grupo, orden, tipo, tipo_datos, descripcion
	into :grupo, :orden, :tipo, :tipo_datos, :descripcion
	from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha >= :i_fecha)
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por fecha hace que se devuelva la fila con la fecha m$$HEX1$$e100$$ENDHEX$$s cercana a la de i_fecha
		order by colegio desc, fecha asc ;
end if
if isnull(i_fecha) or sqlca.sqlcode <> 0 then
	select grupo, orden, tipo, tipo_datos, descripcion
	into :grupo, :orden, :tipo, :tipo_datos, :descripcion
	from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha is null)
		order by colegio desc ;
end if


end subroutine

public function any f_valor_variable_auto_proceso (string variable);/* Las variables de tipo TIPO_VARIABLE_AUTO_PROCESO se calculan de manera especial por c$$HEX1$$f300$$ENDHEX$$digo.
Sin embargo estos c$$HEX1$$e100$$ENDHEX$$lculos no se hacen en el objeto gen$$HEX1$$e900$$ENDHEX$$rico n_caluclo_formulas sino que se deben
hacer en un objeto especializado que herede de n_caluclo_formulas y extendiendo esta funci$$HEX1$$f300$$ENDHEX$$n. */

any nulo
setnull(nulo)
return nulo

end function

public function long f_fila_variable (string variable, boolean ignorar_mayusc);if ignorar_mayusc then
	return ds_variables.find('lower(codigo) = "' + lower(variable) + '"', 1, ds_variables.rowcount())
else
	return ds_variables.find('codigo = "' + variable + '"', 1, ds_variables.rowcount())
end if

end function

public function any f_calcular_resultado ();// Determina el valor de la variable de resultado, es decir de la f$$HEX1$$f300$$ENDHEX$$rmula principal

any result
long i

f_reset_estado_calculado()
result = f_calcular_variable(i_variable_resultado)

// Borramos las variables que no se han calculado ya que no han intervenido en el
// c$$HEX1$$e100$$ENDHEX$$lculo de las f$$HEX1$$f300$$ENDHEX$$rmulas. Probablemente son los restos de alguna f$$HEX1$$f300$$ENDHEX$$rmula cuyo
// contenido ha cambiado desde la $$HEX1$$fa00$$ENDHEX$$ltima vez que se calcul$$HEX1$$f300$$ENDHEX$$.
for i = 1 to ds_variables.rowcount()
	if ds_variables.getitemstring(i, 'calculado') = 'N' then
		ds_variables.deleterow(i)
		i --
	end if
next

f_reset_estado_calculado()

return result


end function

public function string f_coeficientes_valor (string variable);string valor

valor = ''

if not isnull(i_fecha) then
	select valor into :valor from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha >= :i_fecha)
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por fecha hace que se devuelva la fila con la fecha m$$HEX1$$e100$$ENDHEX$$s cercana a la de i_fecha
		order by colegio desc, fecha asc ;
end if
if isnull(i_fecha) or sqlca.sqlcode <> 0 then
	select valor into :valor from coeficientes where codigo = :variable and
		(colegio = :i_colegio or colegio = '' or colegio is null) and
		(fecha is null)
		order by colegio desc ;
end if

return valor
end function

public function string f_any_a_string_expression (any valor);/* Convierte un valor de cualquier tipo en un string que puede ser utilizado en una
expresi$$HEX1$$f300$$ENDHEX$$n de un computed field para reflejar ese valor. */

string valor_str
date d
time t
datetime dt

if isnull(valor) then
	setnull(valor_str)
	return valor_str
end if

choose case ClassName(valor)
	case 'any'
		setnull(valor_str)
		return valor_str
	case 'long', 'integer', 'unsignedlong', 'unsignedinteger', 'double', 'real', 'decimal'
		return " " + f_decimal_punto(valor) + " " // El espacio es porque sin $$HEX1$$e900$$ENDHEX$$l no se calculan bien los n$$HEX1$$fa00$$ENDHEX$$meros negativos
	case 'boolean'
		boolean b
		b = valor
		if b then
			return ("(1=1)") // Un expresi$$HEX1$$f300$$ENDHEX$$n cualquiera que se evalua siempre a true
		else
			return ("(1=0)") // Un expresi$$HEX1$$f300$$ENDHEX$$n cualquiera que se evalua siempre a false
		end if
	case 'date'
		d = valor
		return string(d, "yyyy-mm-dd")
	case 'time'
		t = valor
		return string(t, "hh:mm:ss.ffffff")
	case 'datetime'
		dt = valor
		d = date(dt)
		t = time(dt)
		return "datetime(" + string(d, "yyyy-mm-dd") + "," + string(t, "hh:mm:ss.ffffff") + ")"
				
	case else
		n_cst_string lnv_string
		
		valor_str = string(valor)
		valor_str = lnv_string.of_globalreplace(valor_str, "~t", "~~t")
		valor_str = lnv_string.of_globalreplace(valor_str, "~r", "~~r")
		valor_str = lnv_string.of_globalreplace(valor_str, "~n", "~~n")
		valor_str = lnv_string.of_globalreplace(valor_str, "~"", "~~~"")
		valor_str = lnv_string.of_globalreplace(valor_str, "~'", "~~~'")
		valor_str = lnv_string.of_globalreplace(valor_str, "~~", "~~~~")
		valor_str = "'" + string(valor_str) + "'"
		return valor_str
end choose

end function

public function any f_calcular_variable (string variable);// Calcula el valor la variable indicada y devuelve su valor. Tambi$$HEX1$$e900$$ENDHEX$$n deja establecido ese
// valor en ds_variables.

long fila
string tipo, formula
string valor
string parametro_rango_1, parametro_rango_2, parametro_rango_3
any valor_parametro_rango_1, valor_parametro_rango_2, valor_parametro_rango_3
any result
boolean modificado


fila = f_fila_variable(variable)
if fila <= 0 then
	// Las variables necesarias que no existan se a$$HEX1$$f100$$ENDHEX$$aden autom$$HEX1$$e100$$ENDHEX$$ticamente
	fila = ds_variables.event csd_nueva_variable(variable)
end if

// Evitamos calcular dos veces una misma variable
if ds_variables.getitemstring(fila, 'calculado') = 'S' then
	return f_get_valor_variable(variable)
end if
ds_variables.setitem(fila, 'calculado', 'S')

tipo = ds_variables.getitemstring(fila, 'tipo')

choose case tipo
	case TIPO_VARIABLE_FORMULA
		
		formula = ds_variables.getitemstring(fila, 'formula')
		result = f_evaluar_formula(formula)
		
	case TIPO_VARIABLE_CONSTANTE
		
		valor = f_coeficientes_valor(variable)
		result = f_evaluar_formula(valor)
		
	case TIPO_VARIABLE_RANGO
		
		// Obtenemos el valor de los par$$HEX1$$e100$$ENDHEX$$metros del rango
		f_coeficientes_parametros_rango(variable, parametro_rango_1, parametro_rango_2, parametro_rango_3)
		valor_parametro_rango_1 = f_evaluar_formula(parametro_rango_1)
		valor_parametro_rango_2 = f_evaluar_formula(parametro_rango_2)
		valor_parametro_rango_3 = f_evaluar_formula(parametro_rango_3)
		
		if not f_es_vacio(parametro_rango_1) and isnull(valor_parametro_rango_1) or &
			not f_es_vacio(parametro_rango_2) and isnull(valor_parametro_rango_2) or &
			not f_es_vacio(parametro_rango_3) and isnull(valor_parametro_rango_3) then
			//if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: uno de los par$$HEX1$$e100$$ENDHEX$$metros del rango " + variable + " se evalu$$HEX2$$f3002000$$ENDHEX$$a nulo.")
			setnull(result)
		else
			result = f_evaluar_rango(variable, &
				f_evaluar_formula(parametro_rango_1), &
				f_evaluar_formula(parametro_rango_2), &
				f_evaluar_formula(parametro_rango_3))
		end if
		
	case TIPO_VARIABLE_USUARIO
		// Cargamos un valor por defecto
		valor = f_coeficientes_valor(variable)
		result = f_evaluar_formula(valor)

	case TIPO_VARIABLE_AUTO_PROCESO
		result = f_valor_variable_auto_proceso(variable)
		
	case else
		
		setnull(result)
		
end choose

// Si una variable ha sido modificada por el usuario deberemos mantener siempre el valor manual
if ds_variables.getitemstring(fila, 'modificado') = 'S' then
	modificado = true
else
	modificado = false
end if

f_set_valor_variable(variable, result, modificado, false)

// Una variable de usuario siempre tendr$$HEX2$$e1002000$$ENDHEX$$el estado modificado
if tipo = TIPO_VARIABLE_USUARIO then
	ds_variables.setitem(fila, 'modificado', 'S')
end if

return f_get_valor_variable(variable)

end function

public function any f_evaluar_formula (string formula);/* Calcula el valor de la f$$HEX1$$f300$$ENDHEX$$rmula especificada sustituyendo las variables encontradas entre
corchetes ([]) por su valor. Si alguna variable tiene un valor nulo, o si la f$$HEX1$$f300$$ENDHEX$$rmula no es
correcta el valor devuelto ser$$HEX2$$e1002000$$ENDHEX$$nulo. */

string formula_orig
long posicion_1, posicion_2
string variable
n_cst_string lnv_string
n_ds ds_formula
string valor
any result
boolean no_valida



if f_es_vacio(formula) then
	setnull(result)
	return result
end if

formula_orig = formula

posicion_1=PosA(formula,"[")
do while posicion_1>0
	posicion_1++
	posicion_2=PosA(formula,"]",posicion_1)
	variable=MidA(formula,posicion_1,posicion_2 - posicion_1)
	valor = f_any_a_string_expression(f_calcular_variable(variable))
	if isnull(valor) then
		no_valida = true
		valor = ""
	end if
	
	formula = lnv_string.of_GlobalReplace(formula, "[" + variable + "]", valor)
   
	posicion_1=PosA(formula,"[")
loop

if no_valida then
	setnull(result)
	return result
end if

ds_formula = create n_ds
ds_formula.dataobject='d_evaluar_formula'
ds_formula.insertrow(0)


//ds_formula.object.formula.Expression = formula // Provoca un error si la expresi$$HEX1$$f300$$ENDHEX$$n no es v$$HEX1$$e100$$ENDHEX$$lida
string expresion_tonta = "'_____'"
ds_formula.Modify('formula.Expression="' + expresion_tonta + '"')
//messagebox('formula', formula)
ds_formula.Modify('formula.Expression="' + formula + '"')
if ds_formula.describe('formula.Expression') = expresion_tonta then
	// Si la formula no ha cambiado es porque no es correcta
	if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: la siguiente f$$HEX1$$f300$$ENDHEX$$rmula no es correcta: " + formula_orig)
	setnull(result)
	return result
end if

result = f_getitemany_ds(ds_formula, 1, 'formula', Primary!, false)
destroy ds_formula

return result

end function

public subroutine f_set_valor_variable (string variable, any valor, boolean solo_calculado, boolean solo_real);// Deja establecido el valor de la variable indicada en ds_variables
// Si solo_calculado y solo_real son false se establecer$$HEX2$$e1002000$$ENDHEX$$el valor en las columnas valor y
// valor_calculado, sino s$$HEX1$$f300$$ENDHEX$$lo se establecer$$HEX2$$e1002000$$ENDHEX$$en valor_calculado cuando solo_calculado sea
// true o s$$HEX1$$f300$$ENDHEX$$lo en valor si solo_real es true.

long fila
string tipo_datos, tipo_datos_any
string valor_str

fila = f_fila_variable(variable)
tipo_datos = ds_variables.getitemstring(fila, 'tipo_datos')

// Cuando una f$$HEX1$$f300$$ENDHEX$$rmula de un computed field devuelve un booleano en realidad devuelve un
// string que puede ser 'TRUE' o 'FALSE'. A parte de los strings 'TRUE' y 'FALSE' tambi$$HEX1$$e900$$ENDHEX$$n
// aceptaremos como convertibles a boolean 'S' y 'N'.
if (tipo_datos = TIPO_DATOS_BOOLEAN) then
	if string(valor) = 'S' or string(valor) = 'TRUE' then
		valor = true
	elseif string(valor) = 'N' or string(valor) = 'FALSE' then
		valor = false
	end if
end if

valor_str = f_any_a_string(valor, tipo_datos_any)

if tipo_datos_any <> '' then
	if tipo_datos <> tipo_datos_any and &
		not ((tipo_datos = TIPO_DATOS_NUMBER and tipo_datos_any = TIPO_DATOS_DECIMAL) or &
			(tipo_datos = TIPO_DATOS_DECIMAL and tipo_datos_any = TIPO_DATOS_NUMBER)) then
		if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: el tipo de datos no coincide para la variable " + variable + ".")
		setnull(valor_str)
	end if
end if

if not solo_calculado then
	ds_variables.setitem(fila, 'valor', valor_str)
end if

if not solo_real then
	ds_variables.setitem(fila, 'valor_calculado', valor_str)
end if

end subroutine

public function string f_any_a_string (any valor, ref string tipo_datos);/* Convierte un valor any en un string devolviendo adem$$HEX1$$e100$$ENDHEX$$s en tipo_datos el tipo correspondiente
que se debe establecer en ds_variables. */

string valor_str

if isnull(valor) or ClassName(valor) = 'any' then
	tipo_datos = ''
	setnull(valor_str)
	return valor_str
end if

choose case ClassName(valor)
	case 'long', 'integer', 'unsignedlong', 'unsignedinteger', 'double', 'real'
		tipo_datos = TIPO_DATOS_NUMBER
	case 'decimal'
		tipo_datos = TIPO_DATOS_DECIMAL
	case 'date'
		tipo_datos = TIPO_DATOS_DATE
	case 'time'
		tipo_datos = TIPO_DATOS_TIME
	case 'datetime'
		tipo_datos = TIPO_DATOS_DATETIME
	case 'boolean'
		
		tipo_datos = TIPO_DATOS_BOOLEAN
		boolean b
		b = valor
		if b then
			return 'S'
		else
			return 'N'
		end if
	case else
		tipo_datos = TIPO_DATOS_STRING
end choose

return string(valor)

end function

public function any f_get_valor_variable (string variable);// Obtiene el valor actual de la variable indicada pero no lo recalcula

long fila
any valor
string valor_str

fila = f_fila_variable(variable)

valor_str = ds_variables.getitemstring(fila, 'valor')
valor = f_string_a_any(valor_str, ds_variables.getitemstring(fila, 'tipo_datos'))


if isnull(valor) and not f_es_vacio(valor_str) then
	if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: el tipo de datos no coincide para la variable " + variable + ".")
end if

return valor
end function

on n_calculo_formulas.create
call super::create
this.ds_variables=create ds_variables
TriggerEvent( this, "constructor" )
end on

on n_calculo_formulas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
destroy(this.ds_variables)
end on

event constructor;setnull(i_fecha)
i_colegio = f_colegio()

end event

type ds_variables from n_ds within n_calculo_formulas descriptor "pb_nvo" = "true" 
event type long csd_nueva_variable ( string variable )
string dataobject = "d_calculo_formulas_variables"
end type

event type long csd_nueva_variable(string variable);// Inserta una nueva variable en ds_variables asoci$$HEX1$$e100$$ENDHEX$$ndole la informaci$$HEX1$$f300$$ENDHEX$$n relevante de esa
// variable desde la tabla coeficientes.

long fila
string tipo, tipo_datos, es_coeficiente_lista, grupo, descripcion
double orden
string id_formula


if this.rowcount() = 0 then f_rellenar_dwc_valores_lista()

fila = this.InsertRow(0)
this.SetItem(fila, 'codigo', variable)

f_coeficientes_datos(variable, tipo, tipo_datos, grupo, orden, descripcion)
this.SetItem(fila, 'tipo', tipo)
this.SetItem(fila, 'tipo_datos', tipo_datos)
this.SetItem(fila, 'grupo', grupo)
this.SetItem(fila, 'orden', orden)
this.SetItem(fila, 'descripcion_coeficiente', descripcion)

if f_es_vacio(tipo) then
	if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: la variable " + variable + " no tiene tipo.")
end if

if f_es_vacio(tipo_datos) then
	if i_mostrar_errores then messagebox(g_titulo, "Error al evaluar la f$$HEX1$$f300$$ENDHEX$$rmula: la variable " + variable + " no tiene tipo de datos.")
end if

if f_formulas_es_coeficiente_lista(variable) then
	es_coeficiente_lista = 'S'
else
	es_coeficiente_lista = 'N'
end if
this.SetItem(fila, 'es_coeficiente_lista', es_coeficiente_lista)

if tipo = TIPO_VARIABLE_FORMULA then
	id_formula = f_coeficientes_id_formula(variable)
	ds_variables.setitem(fila, 'id_formula', id_formula)
end if


this.SetItem(fila, 'ambito', i_ambito)
this.SetItem(fila, 'id_ambito', i_id_ambito)

//this.sort()
//this.groupcalc()

return fila

end event

event constructor;call super::constructor;of_settransobject(SQLCA)
end event

on ds_variables.create
call super::create
end on

on ds_variables.destroy
call super::destroy
end on

event retrieveend;call super::retrieveend;string variable
string tipo, tipo_datos, es_coeficiente_lista, grupo, descripcion
double orden
string id_formula
long fila


// Restablecemos las variables temporales que no se guardan en la BD
for fila = 1 to this.rowcount()

	variable =  this.GetItemString(fila, 'codigo')
	
	f_coeficientes_datos(variable, tipo, tipo_datos, grupo, orden, descripcion)
	this.SetItem(fila, 'tipo', tipo)
	this.SetItem(fila, 'tipo_datos', tipo_datos)
	this.SetItem(fila, 'grupo', grupo)
	this.SetItem(fila, 'orden', orden)
	this.SetItem(fila, 'descripcion_coeficiente', descripcion)
	
	if f_formulas_es_coeficiente_lista(variable) then
		es_coeficiente_lista = 'S'
	else
		es_coeficiente_lista = 'N'
	end if
	this.SetItem(fila, 'es_coeficiente_lista', es_coeficiente_lista)
	
	if tipo = TIPO_VARIABLE_FORMULA then
		id_formula = f_coeficientes_id_formula(variable)
		ds_variables.setitem(fila, 'id_formula', id_formula)
	end if

next

end event

