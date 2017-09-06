HA$PBExportHeader$w_visared_previsualizacion_hoja_resenya.srw
forward
global type w_visared_previsualizacion_hoja_resenya from w_response
end type
type cb_imprimir from commandbutton within w_visared_previsualizacion_hoja_resenya
end type
type cb_salir from commandbutton within w_visared_previsualizacion_hoja_resenya
end type
type tab_1 from tab within w_visared_previsualizacion_hoja_resenya
end type
type tabpage_1 from userobject within tab_1
end type
type dw_datos_generales from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_datos_generales dw_datos_generales
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tasas from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tasas dw_tasas
end type
type tab_1 from tab within w_visared_previsualizacion_hoja_resenya
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_visared_previsualizacion_hoja_resenya from w_response
integer width = 3497
integer height = 2536
string title = "Previsualizaci$$HEX1$$f300$$ENDHEX$$n Hoja de Rese$$HEX1$$f100$$ENDHEX$$a"
cb_imprimir cb_imprimir
cb_salir cb_salir
tab_1 tab_1
end type
global w_visared_previsualizacion_hoja_resenya w_visared_previsualizacion_hoja_resenya

type variables
u_dw idw_datos,idw_tasas
 
end variables

on w_visared_previsualizacion_hoja_resenya.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.cb_salir=create cb_salir
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.tab_1
end on

on w_visared_previsualizacion_hoja_resenya.destroy
call super::destroy
destroy(this.cb_imprimir)
destroy(this.cb_salir)
destroy(this.tab_1)
end on

event open;call super::open;string  fichero,nombre, partefichero, extension
int posi

fichero = Message.StringParm

posi = PosA(fichero,'.',1)

idw_datos = tab_1.tabpage_1.dw_datos_generales
idw_tasas = tab_1.tabpage_2.dw_tasas

extension = MidA(fichero,posi + 1,LenA(fichero))
if extension <> 'txt' then
  partefichero = MidA(fichero,1,posi - 1)
  //Cambio la extension del fichero. Paso a txt para poder importar los datos.
  f_copiarfichero(fichero,partefichero+'.txt')
  nombre = partefichero+'.txt'
  idw_datos.ImportFile(nombre)
  idw_tasas.ImportFile(nombre)
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_previsualizacion_hoja_resenya
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_previsualizacion_hoja_resenya
end type

type cb_imprimir from commandbutton within w_visared_previsualizacion_hoja_resenya
integer x = 2455
integer y = 2300
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
string text = "&Imprimir"
end type

event clicked;idw_datos.print()
idw_tasas.print()
end event

type cb_salir from commandbutton within w_visared_previsualizacion_hoja_resenya
integer x = 2921
integer y = 2300
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
string text = "&Salir"
end type

event clicked;close(parent)

end event

type tab_1 from tab within w_visared_previsualizacion_hoja_resenya
integer x = 46
integer y = 36
integer width = 3397
integer height = 2228
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3360
integer height = 2100
long backcolor = 79741120
string text = "Datos Generales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_generales dw_datos_generales
end type

on tabpage_1.create
this.dw_datos_generales=create dw_datos_generales
this.Control[]={this.dw_datos_generales}
end on

on tabpage_1.destroy
destroy(this.dw_datos_generales)
end on

type dw_datos_generales from u_dw within tabpage_1
integer y = 8
integer width = 3360
integer height = 2076
integer taborder = 20
string dataobject = "d_resenya_parte1"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3360
integer height = 2100
long backcolor = 79741120
string text = "Tasas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_tasas dw_tasas
end type

on tabpage_2.create
this.dw_tasas=create dw_tasas
this.Control[]={this.dw_tasas}
end on

on tabpage_2.destroy
destroy(this.dw_tasas)
end on

type dw_tasas from u_dw within tabpage_2
integer x = 14
integer y = 16
integer width = 3328
integer height = 2060
integer taborder = 11
string dataobject = "d_resenya_parte2"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

