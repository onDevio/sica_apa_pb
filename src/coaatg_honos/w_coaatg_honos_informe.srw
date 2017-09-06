HA$PBExportHeader$w_coaatg_honos_informe.srw
forward
global type w_coaatg_honos_informe from w_response
end type
type dw_informe from u_csd_dw within w_coaatg_honos_informe
end type
type cb_1 from commandbutton within w_coaatg_honos_informe
end type
type cb_imprimir from commandbutton within w_coaatg_honos_informe
end type
end forward

global type w_coaatg_honos_informe from w_response
integer x = 214
integer y = 221
integer width = 3474
integer height = 1516
dw_informe dw_informe
cb_1 cb_1
cb_imprimir cb_imprimir
end type
global w_coaatg_honos_informe w_coaatg_honos_informe

type variables
u_csd_dw idw_capitulos, idw_variables


end variables

forward prototypes
public subroutine wf_rellenar_informe ()
end prototypes

public subroutine wf_rellenar_informe ();long i
string descripcion_coeficiente, codigo, valor, tipo, tipo_datos, id_formula, es_coeficiente_lista, grupo
string c_nivel1, c_nivel2, c_nivel3
long orden
double valor_numerico
string formula_tarifa, formula_minimo

c_nivel1 = idw_capitulos.GetItemString(1,'capitulo')
c_nivel2 = idw_capitulos.GetItemString(1,'capitulo_nivel2')
c_nivel3 = idw_capitulos.GetItemString(1,'capitulo_nivel3')

for i = 1 to idw_variables.rowcount()
	descripcion_coeficiente = idw_variables.GetItemString(i, 'descripcion_coeficiente')
	codigo = idw_variables.GetItemString(i, 'codigo')
	valor = idw_variables.GetItemString(i, 'valor')
	tipo = idw_variables.GetItemString(i, 'tipo')
	tipo_datos = idw_variables.GetItemString(i, 'tipo_datos')
	id_formula = idw_variables.GetItemString(i, 'id_formula')
	es_coeficiente_lista = idw_variables.GetItemString(i, 'es_coeficiente_lista')
	grupo = idw_variables.GetItemString(i, 'grupo')
	orden = idw_variables.GetItemNumber(i, 'orden')
	
	dw_informe.insertrow(0)
	dw_informe.setitem(i, 'descripcion_coeficiente', descripcion_coeficiente)
	dw_informe.setitem(i, 'codigo', codigo)
	dw_informe.setitem(i, 'valor', valor)
	if tipo_datos = 'N' then
		valor_numerico = double(valor)
		dw_informe.setitem(i, 'valor_numerico', valor_numerico)		
	end if
	dw_informe.setitem(i, 'tipo', tipo)
	dw_informe.setitem(i, 'tipo_datos', tipo_datos)
	dw_informe.setitem(i, 'id_formula', id_formula)
	dw_informe.setitem(i, 'es_coeficiente_lista', es_coeficiente_lista)
	dw_informe.setitem(i, 'grupo', grupo)	
	dw_informe.setitem(i, 'orden', orden)		
	dw_informe.setitem(i, 'capitulo_nivel1', c_nivel1)	
	dw_informe.setitem(i, 'capitulo_nivel2', c_nivel2)	
	dw_informe.setitem(i, 'capitulo_nivel3', c_nivel3)		
	
	// Si es honorarios guardamos la formula
	if codigo = 'H' then
		formula_tarifa = f_formulas_presentacion_formula ( f_formula_contenido ( id_formula ) )
	end if
	if f_coeficientes_presentacion(codigo) = '[M$$HEX1$$ed00$$ENDHEX$$nimo]' then
		formula_minimo = f_coeficiente_datos_adicionales(codigo, 'N', '')
	end if

next

for i = 1 to dw_informe.rowcount()
	dw_informe.setitem(i, 'formula_tarifa', formula_tarifa)	
	dw_informe.setitem(i, 'formula_minimo', formula_minimo)	
next

dw_informe.groupcalc()
dw_informe.sort()
end subroutine

on w_coaatg_honos_informe.create
int iCurrent
call super::create
this.dw_informe=create dw_informe
this.cb_1=create cb_1
this.cb_imprimir=create cb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_informe
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_imprimir
end on

on w_coaatg_honos_informe.destroy
call super::destroy
destroy(this.dw_informe)
destroy(this.cb_1)
destroy(this.cb_imprimir)
end on

event open;call super::open;idw_capitulos = g_dw_capitulos
idw_variables = g_dw_variables 

f_centrar_ventana(this)

wf_rellenar_informe()

dw_informe.of_setprintpreview(true)
dw_informe.event pfc_printpreview()


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_coaatg_honos_informe
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_coaatg_honos_informe
end type

type dw_informe from u_csd_dw within w_coaatg_honos_informe
integer x = 14
integer y = 12
integer width = 3424
integer height = 1248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_coaatg_honos_informe_external"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_coaatg_honos_informe
integer x = 2121
integer y = 1284
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_imprimir from commandbutton within w_coaatg_honos_informe
integer x = 1161
integer y = 1284
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_informe.print()
end event

