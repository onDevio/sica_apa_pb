HA$PBExportHeader$w_calculo_formulas_bak.srw
forward
global type w_calculo_formulas_bak from w_response
end type
type dw_variables from u_dw within w_calculo_formulas_bak
end type
type cb_aceptar from u_cb within w_calculo_formulas_bak
end type
type cb_cancelar from u_cb within w_calculo_formulas_bak
end type
type cb_recalcular from u_cb within w_calculo_formulas_bak
end type
end forward

global type w_calculo_formulas_bak from w_response
integer width = 4014
integer height = 2120
event csd_salvar_variables ( )
event csd_restaurar_variables ( )
dw_variables dw_variables
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
cb_recalcular cb_recalcular
end type
global w_calculo_formulas_bak w_calculo_formulas_bak

type variables
n_calculo_formulas i_calculo_formulas

blob i_estado_variables_inicial

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
public subroutine f_poner_variables ()
public subroutine f_extraer_variables ()
public function string f_filtro_coef_lista ()
end prototypes

event csd_salvar_variables();i_calculo_formulas.ds_variables.getfullstate(i_estado_variables_inicial)

end event

event csd_restaurar_variables();i_calculo_formulas.ds_variables.setfullstate(i_estado_variables_inicial)
i_calculo_formulas.ds_variables.of_settransobject(SQLCA)

end event

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

dw_variables.reset()
dw_variables.insertrow(0)

for i = 1 to ds_var.rowcount()
	variable = ds_var.getitemstring(i, 'codigo')
	l_variable = lower(variable)
	
	if dw_variables.describe(l_variable + ".ColType") <> "!" then
		valor = i_calculo_formulas.f_get_valor_variable(variable)
		dw_variables.setitem(1, l_variable, valor)
	end if
	
	if dw_variables.describe(l_variable + "_descripcion.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_descripcion", ds_var.getitemstring(i, 'descripcion_coeficiente'))
	end if
	
	if ds_var.describe(l_variable + "_valor_calculado.ColType") <> "!" then
		valor = i_calculo_formulas.f_get_valor_variable_calculado(variable)
		dw_variables.setitem(1, l_variable + "_valor_calculado", valor)
	end if
	
	if dw_variables.describe(l_variable + "_modificado.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_modificado", ds_var.getitemstring(i, 'modificado'))
	end if
	
	if dw_variables.describe(l_variable + "_datos_adicionales.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_datos_adicionales", ds_var.getitemstring(i, 'datos_adicionales'))
	end if
	
	if dw_variables.describe(l_variable + "_tipo.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_tipo", ds_var.getitemstring(i, 'tipo'))
	end if
	
	if ds_var.describe(l_variable + "_tipo_datos.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_tipo_datos", ds_var.getitemstring(i, 'tipo_datos'))
	end if
	
	if dw_variables.describe(l_variable + "_formula.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_formula", ds_var.getitemstring(i, 'formula'))
	end if
	
	if dw_variables.describe(l_variable + "_id_formula.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_id_formula", ds_var.getitemstring(i, 'id_formula'))
	end if
	
	if dw_variables.describe(l_variable + "_existe.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_existe", 'S')
	end if
	
	if dw_variables.describe(l_variable + "_grupo.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_grupo", ds_var.getitemstring(i, 'grupo'))
	end if
	
	if dw_variables.describe(l_variable + "_orden.ColType") <> "!" then
		dw_variables.setitem(1, l_variable + "_orden", ds_var.getitemnumber(i, 'orden'))
	end if
next

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
	
	if dw_variables.describe(l_variable + ".ColType") <> "!" then
		valor = f_getitemany(dw_variables, 1, l_variable, Primary!, false)
		i_calculo_formulas.f_set_valor_variable(variable, valor, false, true)
	end if
	
	if dw_variables.describe(l_variable + "_modificado.ColType") <> "!" then
		ds_var.setitem(i, "modificado", dw_variables.getitemstring(1, l_variable + "_modificado"))
	end if
	
	if dw_variables.describe(l_variable + "_datos_adicionales.ColType") <> "!" then
		ds_var.setitem(i, "datos_adicionales", dw_variables.getitemstring(1, l_variable + "_datos_adicionales"))
	end if
next

end subroutine

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

on w_calculo_formulas_bak.create
int iCurrent
call super::create
this.dw_variables=create dw_variables
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.cb_recalcular=create cb_recalcular
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_variables
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_recalcular
end on

on w_calculo_formulas_bak.destroy
call super::destroy
destroy(this.dw_variables)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.cb_recalcular)
end on

event open;call super::open;f_centrar_ventana(this)

i_calculo_formulas = message.powerobjectparm

this.Title = i_calculo_formulas.i_titulo_ventana

i_calculo_formulas.i_aceptada_ventana = false

event csd_salvar_variables()

//i_calculo_formulas.f_calcular_resultado()


long fila
string dw, id_formula
string colegio
colegio = f_colegio()

// Miramos si hay un dw personalizado para la formula visualizada
fila = i_calculo_formulas.f_fila_variable(i_calculo_formulas.i_variable_resultado)
if fila > 0 then
	id_formula = i_calculo_formulas.ds_variables.getitemstring(fila, 'id_formula')
	
	dw = ''
	select dw into :dw from formulas where id_formula = :id_formula and
		// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
		(colegio = :colegio or colegio = '' or colegio is null) order by colegio desc ;
		
	if not f_es_vacio(dw) then
		ib_dw_variables_personal = true
		dw_variables.dataobject = dw
	end if
end if

// Si se usa un dw personalizado para dw_variables hay que transferir las variables desde i_calculo_formulas.ds_variables hasta dw_variables
if ib_dw_variables_personal then
	
	// Aunque el dw personal sea external tenemos que hacer un retrive para los dddw
	dw_variables.SetTransObject(SQLCA)
	dw_variables.retrieve()
	
	f_poner_variables()
else
	if dw_variables.getchild('valor_lista', idwc_coef_lista) = 1 then
		idwc_coef_lista.SetTransObject(SQLCA)
		
		i_filtro_coef_lista = f_filtro_coef_lista()
		idwc_coef_lista.setfilter(i_filtro_coef_lista)
		
		if idwc_coef_lista.retrieve('%', f_colegio()) = 0 then
			idwc_coef_lista.insertrow(0) // Esto es para que no saque la ventana pidiendo los retrieval arguments si no hay filas
		end if
	end if
	
	// Si no, con sharedata se edita directamente el contenido de i_calculo_formulas.ds_variables
	//i_calculo_formulas.ds_variables.sharedata(dw_variables) // Sharedata da problemas porque se reordenan las filas cuando no deber$$HEX1$$ed00$$ENDHEX$$an
	dw_variables.object.data = i_calculo_formulas.ds_variables.object.data
	dw_variables.sort()
	dw_variables.groupcalc()
	
end if

end event

event type integer pfc_updatespending(powerobject apo_control[]);call super::pfc_updatespending;return 0
end event

event close;call super::close;if not i_calculo_formulas.i_aceptada_ventana then
	event csd_restaurar_variables()
end if

//if not ib_dw_variables_personal then
//	dw_variables.sharedataoff()
//end if	
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_calculo_formulas_bak
integer taborder = 50
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_calculo_formulas_bak
end type

type dw_variables from u_dw within w_calculo_formulas_bak
event ncpain pbm_ncpaint
event csd_post_itemchanged ( )
integer x = 32
integer y = 28
integer width = 3936
integer height = 1820
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_calculo_formulas_variables"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event ncpain;// En el evento dropdown se pone un filtro al dddw de valor_lista que aqui quitamos
if i_restaura_dddw_coef_lista then
	idwc_coef_lista.setfilter(i_filtro_coef_lista)		
	idwc_coef_lista.filter()
	i_restaura_dddw_coef_lista = false
	//this.setredraw(true) // Para redibujar todo el datawindow
end if

end event

event csd_post_itemchanged();i_calculo_formulas.ds_variables.sort()
i_calculo_formulas.ds_variables.groupcalc()

if ib_dw_variables_personal then
	f_poner_variables()
else
	dw_variables.object.data = i_calculo_formulas.ds_variables.object.data
end if

end event

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

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = False
end event

event dropdown;call super::dropdown;// En el dddw de valor_lista mostramos solo los valores de la variable activa poniendo para ello un filtro poniendo para ello un filtro
if this.getcolumnname() = 'valor_lista' then
	idwc_coef_lista.setfilter("codigo ='" + this.getitemstring(this.getrow(),'codigo') + "'")
	idwc_coef_lista.post filter() // Post para que se redibuje el $$HEX1$$fa00$$ENDHEX$$ltimo elmento que tiene el foco antes de que se ponga el filtro
	i_restaura_dddw_coef_lista = true // Quitaremos el filtro cuando se tenga que redibujar el dw, que ser$$HEX2$$e1002000$$ENDHEX$$justo despu$$HEX1$$e900$$ENDHEX$$s de que se cierre el desplegable
end if

end event

type cb_aceptar from u_cb within w_calculo_formulas_bak
integer x = 32
integer y = 1876
integer width = 425
integer height = 108
integer taborder = 20
boolean bringtotop = true
string text = "Aceptar"
boolean default = true
end type

event clicked;call super::clicked;if of_accepttext(true) < 0 then return

i_calculo_formulas.i_aceptada_ventana = true
if close(parent) <> 1 then
	i_calculo_formulas.i_aceptada_ventana = false
end if

end event

type cb_cancelar from u_cb within w_calculo_formulas_bak
integer x = 480
integer y = 1876
integer width = 425
integer height = 108
integer taborder = 11
boolean bringtotop = true
string text = "Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)

end event

type cb_recalcular from u_cb within w_calculo_formulas_bak
integer x = 933
integer y = 1876
integer width = 425
integer height = 108
integer taborder = 11
boolean bringtotop = true
string text = "Recalcular"
end type

event clicked;call super::clicked;if ib_dw_variables_personal then f_extraer_variables()

i_calculo_formulas.f_calcular_resultado()

dw_variables.event csd_post_itemchanged()

end event

