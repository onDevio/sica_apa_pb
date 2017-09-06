HA$PBExportHeader$u_csd_dw_calculo_honos.sru
forward
global type u_csd_dw_calculo_honos from u_csd_dw
end type
end forward

global type u_csd_dw_calculo_honos from u_csd_dw
string dataobject = "d_calculo_formulas_variables"
event csd_post_itemchanged ( )
event dropdown pbm_dwndropdown
event ncpain pbm_ncpaint
end type
global u_csd_dw_calculo_honos u_csd_dw_calculo_honos

type variables
n_calculo_formulas i_calculo_formulas

//blob i_estado_variables_inicial

// Indica si dw_variables contiene un dw external cuyo contenido se rellena con f_poner_variables
// y f_extraer_variables.
boolean ib_dw_variables_personal = false


// dddw que contiene los valores de coeficientes_lista
datawindowchild idwc_coef_lista
// Para controlar la visualizaci$$HEX1$$f300$$ENDHEX$$n idwc_coef_lista
boolean i_restaura_dddw_coef_lista = false
// Filtro que oculta los coeficientes de idwc_coef_lista que no sean necesarios
string i_filtro_coef_lista
end variables

forward prototypes
public function string f_filtro_coef_lista ()
public subroutine f_poner_variables ()
public subroutine f_pasar_objeto_formulas (ref n_calculo_formulas calculo_formulas_honorarios)
public subroutine f_extraer_variables ()
end prototypes

event csd_post_itemchanged();i_calculo_formulas.ds_variables.sort()
i_calculo_formulas.ds_variables.groupcalc()

if ib_dw_variables_personal then
	f_poner_variables()
else
	long fila_actual
	fila_actual = this.getrow()
	// copio los datos en pantalla
	this.object.data = i_calculo_formulas.ds_variables.object.data
	// por alguna raz$$HEX1$$f300$$ENDHEX$$n al copiar los datos la secuencia l$$HEX1$$f300$$ENDHEX$$gica de tabulado se descontrola y por eso
	// a$$HEX1$$f100$$ENDHEX$$adimos estas sentencias que lo corrigen.
	this.setrow(fila_actual)
	this.setcolumn('valor_lista')
end if

end event

event dropdown;// En el dddw de valor_lista mostramos solo los valores de la variable activa poniendo para ello un filtro poniendo para ello un filtro
if this.getcolumnname() = 'valor_lista' then
	string valor
	long fila
	if idwc_coef_lista.rowcount() > 0 then
		valor = idwc_coef_lista.getitemstring(idwc_coef_lista.getrow(), 'valor')
	end if
	
	idwc_coef_lista.setfilter("codigo ='" + this.getitemstring(this.getrow(),'codigo') + "'")
	idwc_coef_lista.filter() // Post para que se redibuje el $$HEX1$$fa00$$ENDHEX$$ltimo elemento que tiene el foco antes de que se ponga el filtro
	
	fila=idwc_coef_lista.find("valor = '"+valor+"'", 1, idwc_coef_lista.rowcount())
	if fila > 0 then idwc_coef_lista.post setrow(fila)
	i_restaura_dddw_coef_lista = true // Quitaremos el filtro cuando se tenga que redibujar el dw, que ser$$HEX2$$e1002000$$ENDHEX$$justo despu$$HEX1$$e900$$ENDHEX$$s de que se cierre el desplegable
end if

end event

event ncpain;// En el evento dropdown se pone un filtro al dddw de valor_lista que aqui quitamos
if i_restaura_dddw_coef_lista then
	idwc_coef_lista.setfilter(i_filtro_coef_lista)		
	idwc_coef_lista.filter()
	i_restaura_dddw_coef_lista = false
	//this.setredraw(true) // Para redibujar todo el datawindow
end if

end event

public function string f_filtro_coef_lista ();// Genera un filtro para idwc_coef_lista que limita los posibles valores a los de aquellos coeficientes que
// se muestran en la ventana. Esto limita los posibles problemas de visualizaci$$HEX1$$f300$$ENDHEX$$n que se dan cuando se muestra
// una descripci$$HEX1$$f300$$ENDHEX$$n para un coeficiente que no le corresponde.

string filtro_coef_lista
long fila

if i_calculo_formulas.ds_variables.rowcount() > 0 then
	
	filtro_coef_lista = "codigo in ("
	
	for fila = 1 to i_calculo_formulas.ds_variables.rowcount()
		if fila > 1 then filtro_coef_lista += " , "
		filtro_coef_lista += "'" + i_calculo_formulas.ds_variables.getitemstring(fila,'codigo') + "'"
	next
	
	filtro_coef_lista += ")"

end if

return filtro_coef_lista

end function

public subroutine f_poner_variables ();/* Cuando dw_variables contiene un dw personalizado, que es un dw external con un campo para cada
variable de la f$$HEX1$$f300$$ENDHEX$$rmula, pone en los campos el valor de las variables de
i_calculo_formulas.ds_variables. Adicionalmente para cada variable pone el valor de los siguientes
campos (si existen).

nombrevariable_descripcion = La descripci$$HEX1$$f300$$ENDHEX$$n de la variable.
nombrevariable_valor_calculado = El valor calculado que le corresponde a la variable.
nombrevariable_modificado = Si la variable ha sido modificada por el usuario.
nombrevariable_datos_adicionales = Lo que haya en la columna datos_adicionales de ds_variables.
nombrevariable_id_formula = Para las variables de tipo f$$HEX1$$f300$$ENDHEX$$rmula pone el id de la f$$HEX1$$f300$$ENDHEX$$rmula asociada.
nombrevariable_formula = Para las variables de tipo f$$HEX1$$f300$$ENDHEX$$rmula pone la expresi$$HEX1$$f300$$ENDHEX$$n de la f$$HEX1$$f300$$ENDHEX$$rmula asociada.
nombrevariable_tipo = El tipo de la variable (TIPO_VARIABLE_FORMULA, TIPO_VARIABLE_CONSTANTE...).
nombrevariable_tipo_datos = El tipo de datos de la variable (TIPO_DATOS_NUMBER, TIPO_DATOS_STRING...).
nombrevariable_existe = Se pone S. As$$HEX2$$ed002000$$ENDHEX$$es posible averiguar si una variable se ha usado en la
	f$$HEX1$$f300$$ENDHEX$$rmula. Si no se ha puesto a S es porque no se ha usado.
nombrevariable_grupo = El grupo de la variable.
nombrevariable_orden = El valor del orden de la variable.
*/

n_ds ds_var
string variable, l_variable
any valor
long i

ds_var = i_calculo_formulas.ds_variables

this.reset()
this.insertrow(0)

for i = 1 to ds_var.rowcount()
	variable = ds_var.getitemstring(i, 'codigo')
	l_variable = lower(variable)
	
	if this.describe(l_variable + ".ColType") <> "!" then
		valor = i_calculo_formulas.f_get_valor_variable(variable)
		this.setitem(1, l_variable, valor)
	end if
	
	if this.describe(l_variable + "_descripcion.ColType") <> "!" then
		this.setitem(1, l_variable + "_descripcion", ds_var.getitemstring(i, 'descripcion_coeficiente'))
	end if
	
	if ds_var.describe(l_variable + "_valor_calculado.ColType") <> "!" then
		valor = i_calculo_formulas.f_get_valor_variable_calculado(variable)
		this.setitem(1, l_variable + "_valor_calculado", valor)
	end if
	
	if this.describe(l_variable + "_modificado.ColType") <> "!" then
		this.setitem(1, l_variable + "_modificado", ds_var.getitemstring(i, 'modificado'))
	end if
	
	if this.describe(l_variable + "_datos_adicionales.ColType") <> "!" then
		this.setitem(1, l_variable + "_datos_adicionales", ds_var.getitemstring(i, 'datos_adicionales'))
	end if
	
	if this.describe(l_variable + "_tipo.ColType") <> "!" then
		this.setitem(1, l_variable + "_tipo", ds_var.getitemstring(i, 'tipo'))
	end if
	
	if ds_var.describe(l_variable + "_tipo_datos.ColType") <> "!" then
		this.setitem(1, l_variable + "_tipo_datos", ds_var.getitemstring(i, 'tipo_datos'))
	end if
	
	if this.describe(l_variable + "_formula.ColType") <> "!" then
		this.setitem(1, l_variable + "_formula", ds_var.getitemstring(i, 'formula'))
	end if
	
	if this.describe(l_variable + "_id_formula.ColType") <> "!" then
		this.setitem(1, l_variable + "_id_formula", ds_var.getitemstring(i, 'id_formula'))
	end if
	
	if this.describe(l_variable + "_existe.ColType") <> "!" then
		this.setitem(1, l_variable + "_existe", 'S')
	end if
	
	if this.describe(l_variable + "_grupo.ColType") <> "!" then
		this.setitem(1, l_variable + "_grupo", ds_var.getitemstring(i, 'grupo'))
	end if
	
	if this.describe(l_variable + "_orden.ColType") <> "!" then
		this.setitem(1, l_variable + "_orden", ds_var.getitemnumber(i, 'orden'))
	end if
next

end subroutine

public subroutine f_pasar_objeto_formulas (ref n_calculo_formulas calculo_formulas_honorarios);this.i_calculo_formulas = calculo_formulas_honorarios
end subroutine

public subroutine f_extraer_variables ();/* Cuando dw_variables contiene un dw personalizado, que es un dw external con un campo para cada
variable de la f$$HEX1$$f300$$ENDHEX$$rmula, mete en el valor de las variables de i_calculo_formulas.ds_variables el
valor que hay en los campos.

Adicionalmente para cada variable pone en el campo 'modificado' de ds_variables.i_calculo_formulas
lo que haya en el campo nombrevariable_modificado de dw_variables (si existe). Y los mismo con
respecto al campo 'datos_adicionales' de ds_variables.i_calculo_formulas y el campo
'nombrevariable_datos_adicionales' de dw_variables.
*/

n_ds ds_var
string variable, l_variable
any valor
long i


ds_var = i_calculo_formulas.ds_variables

for i = 1 to ds_var.rowcount()
	variable = ds_var.getitemstring(i, 'codigo')
	l_variable = lower(variable)
	
	if this.describe(l_variable + ".ColType") <> "!" then
		valor = f_getitemany(this, 1, l_variable, Primary!, false)
		i_calculo_formulas.f_set_valor_variable(variable, valor, false, true)
	end if
	
	if this.describe(l_variable + "_modificado.ColType") <> "!" then
		ds_var.setitem(i, "modificado", this.getitemstring(1, l_variable + "_modificado"))
	end if
	
	if this.describe(l_variable + "_datos_adicionales.ColType") <> "!" then
		ds_var.setitem(i, "datos_adicionales", this.getitemstring(1, l_variable + "_datos_adicionales"))
	end if
next

end subroutine

on u_csd_dw_calculo_honos.create
end on

on u_csd_dw_calculo_honos.destroy
end on

event itemchanged;call super::itemchanged;long fila

accepttext()

if not ib_dw_variables_personal then
	
	if dwo.name = 'valor' or dwo.name = 'valor_boolean' or dwo.name = 'valor_lista' then
		// Reproducimos el cambio de valor en la ventana en i_calculo_formulas.ds_variables
		fila = i_calculo_formulas.f_fila_variable(this.getitemstring(row, 'codigo'), true)
		i_calculo_formulas.ds_variables.setitem(fila, 'valor', data)
	
		// Cuando se modifica el valor de una variable manualmente se pone el campo modificado a 'S'
		// y cuando se borra uno manual se pone el campo a 'N'
		if f_es_vacio(data) and this.getitemstring(row, 'tipo') <> n_calculo_formulas.TIPO_VARIABLE_USUARIO then
			i_calculo_formulas.ds_variables.setitem(fila, 'modificado', 'N')
		else
			i_calculo_formulas.ds_variables.setitem(fila, 'modificado', 'S')
		end if
	end if
	
else
	
	// Miramos si se ha modificado una variable de la f$$HEX1$$f300$$ENDHEX$$rmula
	fila = i_calculo_formulas.f_fila_variable(dwo.name, true)
	if fila > 0 then
		if describe(dwo.name + "_modificado.ColType") <> "!" then
			// Si existe el campo nombrevariable_modificado lo ponemos a S o a no N dependiendo de si se est$$HEX2$$e1002000$$ENDHEX$$metiendo un valor manual o se est$$HEX2$$e1002000$$ENDHEX$$quitando
			if f_es_vacio(data) and i_calculo_formulas.ds_variables.getitemstring(fila, 'tipo') <> n_calculo_formulas.TIPO_VARIABLE_USUARIO then
				this.setitem(1, dwo.name + '_modificado', 'N')
			else
				this.setitem(1, dwo.name + '_modificado', 'S')
			end if
		else
			// Si no existe ponemos el flag de modificado directamente en ds_variables
			if f_es_vacio(data) and i_calculo_formulas.ds_variables.getitemstring(fila, 'tipo') <> n_calculo_formulas.TIPO_VARIABLE_USUARIO then
				i_calculo_formulas.ds_variables.setitem(fila, 'modificado', 'N')
			else
				i_calculo_formulas.ds_variables.setitem(fila, 'modificado', 'S')
			end if
		end if
	end if
	
	f_extraer_variables()
	
end if

i_calculo_formulas.f_calcular_resultado()
i_filtro_coef_lista = f_filtro_coef_lista()

// Dejamos que despu$$HEX1$$e900$$ENDHEX$$s del itemchanged PowerBuilder ponga el nuevo valor del campo modificado
// y despu$$HEX1$$e900$$ENDHEX$$s, cuando se ejecute csd_post_itemchanged, pasaremos a dw_variables el nuevo valor de
// todos los coeficientes
post event csd_post_itemchanged()

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_info'
		string codigo, tipo, id_formula, datos_adicionales
		codigo = this.getitemstring(row, 'codigo')
		tipo = this.getitemstring(row, 'tipo')
		id_formula = this.getitemstring(row, 'id_formula')
		datos_adicionales = f_coeficiente_datos_adicionales(codigo, tipo, id_formula)
//		messagebox('Datos adicionales', datos_adicionales)
		g_busqueda.titulo = 'Datos adicionales'
		g_busqueda.solo_despliega_texto = false
		openwithparm(w_coaatg_honos_datos_adicionales, datos_adicionales)
	case 'b_modulaje'
		string id_tabla_modulaje
		id_formula = this.getitemstring(row, 'id_formula')
		select id_tabla_modulaje into :id_tabla_modulaje from formulas_modulajes where id_formula = :id_formula;
		openwithparm(w_coaatg_honos_modulaje, id_tabla_modulaje)
end choose
end event

