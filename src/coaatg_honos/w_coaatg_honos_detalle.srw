HA$PBExportHeader$w_coaatg_honos_detalle.srw
forward
global type w_coaatg_honos_detalle from w_sheet
end type
type dw_capitulos from u_csd_dw within w_coaatg_honos_detalle
end type
type dw_parametros1 from u_csd_dw within w_coaatg_honos_detalle
end type
type dw_resultados1 from u_csd_dw within w_coaatg_honos_detalle
end type
type dw_variables from u_csd_dw_calculo_honos within w_coaatg_honos_detalle
end type
end forward

global type w_coaatg_honos_detalle from w_sheet
integer width = 3040
integer height = 1852
string menuname = "m_coaatg_honos_detalle"
windowstate windowstate = maximized!
event csd_limpiar_pantalla ( )
event csd_restaurar_variables ( )
event csd_salvar_variables ( )
event csd_imprimir ( )
dw_capitulos dw_capitulos
dw_parametros1 dw_parametros1
dw_resultados1 dw_resultados1
dw_variables dw_variables
end type
global w_coaatg_honos_detalle w_coaatg_honos_detalle

type variables
u_csd_dw idw_capitulos, idw_parametros, idw_variables, idw_resultados
datawindowchild idwc_capitulo, idwc_subcapitulo, idwc_apartado
//datawindowchild idw_capitulo, idw_capitulo_nivel2, idw_capitulo_nivel3


n_calculo_formulas_honorarios i_calculo_formulas

blob i_estado_variables_inicial
//
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
end prototypes

event csd_limpiar_pantalla();idw_capitulos.reset()
idw_variables.reset()
//idw_parametros.reset()
//idw_resultados.reset()

idw_capitulos.visible= true
idw_capitulos.event pfc_addrow()

idw_variables.visible= true

//idw_parametros.visible= true
//idw_parametros.event pfc_addrow()
//
//idw_resultados.visible= true
//idw_resultados.event pfc_addrow()
end event

event csd_restaurar_variables();i_calculo_formulas.ds_variables.setfullstate(i_estado_variables_inicial)
i_calculo_formulas.ds_variables.of_settransobject(SQLCA)

end event

event csd_salvar_variables();i_calculo_formulas.ds_variables.getfullstate(i_estado_variables_inicial)
end event

event csd_imprimir();g_dw_capitulos = dw_capitulos
g_dw_variables = dw_variables

open(w_coaatg_honos_informe)
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

on w_coaatg_honos_detalle.create
int iCurrent
call super::create
if this.MenuName = "m_coaatg_honos_detalle" then this.MenuID = create m_coaatg_honos_detalle
this.dw_capitulos=create dw_capitulos
this.dw_parametros1=create dw_parametros1
this.dw_resultados1=create dw_resultados1
this.dw_variables=create dw_variables
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_capitulos
this.Control[iCurrent+2]=this.dw_parametros1
this.Control[iCurrent+3]=this.dw_resultados1
this.Control[iCurrent+4]=this.dw_variables
end on

on w_coaatg_honos_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_capitulos)
destroy(this.dw_parametros1)
destroy(this.dw_resultados1)
destroy(this.dw_variables)
end on

event open;call super::open;idw_capitulos = dw_capitulos
idw_variables = dw_variables
//idw_parametros = dw_parametros
//idw_resultados = dw_resultados

this.BackColor = rgb(255,251,240)
idw_capitulos.object.datawindow.color = rgb(255,251,240)
idw_variables.object.datawindow.color = rgb(255,251,240)
//idw_parametros.object.datawindow.color = rgb(255,251,240)
//idw_resultados.object.datawindow.color = rgb(255,251,240)

of_SetResize (true)

inv_resize.of_Register (idw_capitulos, "ScaletoRight")
inv_resize.of_Register (idw_variables, "ScaletoRight&Bottom")


idw_capitulos.getchild('capitulo', idwc_capitulo)
idw_capitulos.getchild('capitulo_nivel2', idwc_subcapitulo)
idw_capitulos.getchild('capitulo_nivel3', idwc_apartado)

event csd_limpiar_pantalla()

i_calculo_formulas = create n_calculo_formulas_honorarios
dw_variables.i_calculo_formulas = i_calculo_formulas

dw_variables.idwc_coef_lista = idwc_coef_lista
dw_variables.i_restaura_dddw_coef_lista = i_restaura_dddw_coef_lista
dw_variables.i_filtro_coef_lista = i_filtro_coef_lista


i_calculo_formulas.f_inicializar()
any resultado
//i_calculo_formulas.f_mostrar_ventana(resultado)
//i_calculo_formulas = message.powerobjectparm

this.Title = i_calculo_formulas.i_titulo_ventana

i_calculo_formulas.i_aceptada_ventana = false

//i_calculo_formulas.idw_parametros = dw_parametros
i_calculo_formulas.f_establecer_variable_resultado(i_calculo_formulas.VARIABLE_H)


end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

event close;call super::close;if not i_calculo_formulas.i_aceptada_ventana then
	event csd_restaurar_variables()
end if

end event

type dw_capitulos from u_csd_dw within w_coaatg_honos_detalle
integer x = 32
integer y = 24
integer width = 2880
integer height = 320
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_coaatg_honos_capitulos"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string id_formula, id_formula_nivel2, id_formula_nivel3, cadena_nula
setnull(cadena_nula)

// Filtramos los dddws
this.setredraw(false)
choose case dwo.name
	case 'capitulo'
		idwc_subcapitulo.setfilter("id_capitulo='"+data+"'")
		idwc_subcapitulo.filter()
		if idwc_subcapitulo.rowcount() > 0 then
			this.object.capitulo_nivel2_t.visible = true
			this.object.capitulo_nivel2.visible = true
			this.object.capitulo_nivel3_t.visible = false
			this.object.capitulo_nivel3.visible = false				
		else
			this.object.capitulo_nivel2_t.visible = false
			this.object.capitulo_nivel2.visible = false
			this.object.capitulo_nivel3_t.visible = false
			this.object.capitulo_nivel3.visible = false				
		end if
		this.setitem(1, 'capitulo_nivel2', cadena_nula)
		this.setitem(1, 'capitulo_nivel3', cadena_nula)		
	case 'capitulo_nivel2'
		idwc_apartado.setfilter("id_capitulo_nivel2='"+data+"'")
		idwc_apartado.filter()	
		if idwc_apartado.rowcount() > 0 then
			this.object.capitulo_nivel3_t.visible = true
			this.object.capitulo_nivel3.visible = true
		else
			this.object.capitulo_nivel3_t.visible = false
			this.object.capitulo_nivel3.visible = false		
		end if		
		this.setitem(1, 'capitulo_nivel3', cadena_nula)		
	case 'capitulo_nivel3'
end choose
this.setredraw(true)

// Averiguamos la f$$HEX1$$f300$$ENDHEX$$rmula a aplicar
choose case dwo.name
	case 'capitulo'
		id_formula = cadena_nula
	case 'capitulo_nivel2'
		
		id_formula_nivel2 = idwc_subcapitulo.getitemstring(idwc_subcapitulo.getrow(), 'id_formula')
	case 'capitulo_nivel3'
		id_formula_nivel3 = idwc_apartado.getitemstring(idwc_apartado.getrow(), 'id_formula')
end choose

// Escoger la f$$HEX1$$f300$$ENDHEX$$rmula entre las dos posible, la del nivel 2 y el 3, por defecto la del 3 antes
id_formula = id_formula_nivel2
if not f_es_vacio(id_formula_nivel3) then id_formula = id_formula_nivel3
long fila_var
fila_var = i_calculo_formulas.f_fila_variable(i_calculo_formulas.VARIABLE_H)
i_calculo_formulas.ds_variables.setitem(fila_var, 'id_formula', id_formula)

// Calculamos resultados
i_calculo_formulas.f_calcular_resultado()

// Cargamos los dddw de listas
if dw_variables.getchild('valor_lista', idwc_coef_lista) = 1 then
	idwc_coef_lista.SetTransObject(SQLCA)
	
	i_filtro_coef_lista = f_filtro_coef_lista()
	idwc_coef_lista.setfilter(i_filtro_coef_lista)
	
	if idwc_coef_lista.retrieve('%', f_colegio()) = 0 then
		idwc_coef_lista.insertrow(0) // Esto es para que no saque la ventana pidiendo los retrieval arguments si no hay filas
	end if
end if

dw_variables.idwc_coef_lista = idwc_coef_lista

// Una vez calculado lo mostramos en pantalla
i_calculo_formulas.ds_variables.sort()
i_calculo_formulas.ds_variables.groupcalc()
dw_variables.object.data = i_calculo_formulas.ds_variables.object.data
dw_variables.sort()
dw_variables.groupcalc()





end event

type dw_parametros1 from u_csd_dw within w_coaatg_honos_detalle
event csd_post_itemchanged ( )
boolean visible = false
integer x = 2930
integer y = 40
integer width = 448
integer height = 124
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_coaatg_honos_parametros"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_post_itemchanged();//i_calculo_formulas.f_calcular_resultado()
//	dw_variables.object.data = i_calculo_formulas.ds_variables.object.data
//	dw_variables.sort()
//	dw_variables.groupcalc()

end event

event itemchanged;call super::itemchanged;this.post event csd_post_itemchanged()
	
end event

type dw_resultados1 from u_csd_dw within w_coaatg_honos_detalle
boolean visible = false
integer x = 2935
integer y = 180
integer width = 361
integer height = 172
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_coaatg_honos_resultados"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_variables from u_csd_dw_calculo_honos within w_coaatg_honos_detalle
integer x = 32
integer y = 368
integer width = 2885
integer height = 1252
integer taborder = 20
boolean bringtotop = true
end type

