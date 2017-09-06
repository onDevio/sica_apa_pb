HA$PBExportHeader$w_plantillas_seleccion.srw
forward
global type w_plantillas_seleccion from w_response
end type
type dw_1 from u_dw within w_plantillas_seleccion
end type
type cb_1 from commandbutton within w_plantillas_seleccion
end type
type cb_2 from commandbutton within w_plantillas_seleccion
end type
type dw_texto_campos from u_dw within w_plantillas_seleccion
end type
type cbx_permitir_editar from checkbox within w_plantillas_seleccion
end type
end forward

global type w_plantillas_seleccion from w_response
integer width = 2149
integer height = 1816
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n Plantillas"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
dw_texto_campos dw_texto_campos
cbx_permitir_editar cbx_permitir_editar
end type
global w_plantillas_seleccion w_plantillas_seleccion

type variables
st_plantillas_seleccion i_datos
end variables

event open;call super::open;
st_retorno_seleccion retorno

i_datos=Message.Powerobjectparm


if i_datos.mostrar_cbx_editar_plantilla=true then cbx_permitir_editar.visible=true
dw_1.retrieve(i_datos.modulo)

///*** Se corrige el objeto de vuelta. Alexis. 
if dw_1.rowcount()=0 then 
	retorno.ruta = '-1'
	CloseWithReturn(this,retorno)
end if
	
	

end event

on w_plantillas_seleccion.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_texto_campos=create dw_texto_campos
this.cbx_permitir_editar=create cbx_permitir_editar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_texto_campos
this.Control[iCurrent+5]=this.cbx_permitir_editar
end on

on w_plantillas_seleccion.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_texto_campos)
destroy(this.cbx_permitir_editar)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_plantillas_seleccion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_plantillas_seleccion
end type

type dw_1 from u_dw within w_plantillas_seleccion
integer x = 37
integer y = 32
integer width = 2021
integer height = 908
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_plantillas_seleccion"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event rowfocuschanged;call super::rowfocuschanged;string codigo
int fila
string campo_1,campo_2,campo_3,campo_4,campo_5

if(dw_1.rowcount() = 0) then
	return
end if

codigo = dw_1.GetItemString(currentrow,'codigo')

select campo_interno into :campo_1 from plantillas_campos where modulo = :codigo and campo_formulario = "campo1";
select campo_interno into :campo_2 from plantillas_campos where modulo = :codigo and campo_formulario = "campo2";
select campo_interno into :campo_3 from plantillas_campos where modulo = :codigo and campo_formulario = "campo3";
select campo_interno into :campo_4 from plantillas_campos where modulo = :codigo and campo_formulario = "campo4";
select campo_interno into :campo_5 from plantillas_campos where modulo = :codigo and campo_formulario = "campo5";

dw_texto_campos.reset()

if (campo_1 <> '') then
	fila = dw_texto_campos.event pfc_addrow()
	dw_texto_campos.setitem(fila,'nombre_campo',campo_1 + ':')
	IF i_datos.modulo = 'FASES' then 	dw_texto_campos.setitem(fila,'valor_campo',i_datos.n_col1)
end if
	
if (campo_2 <> '') then
	fila = dw_texto_campos.event pfc_addrow()
	dw_texto_campos.setitem(fila,'nombre_campo',campo_2 + ':')
	IF i_datos.modulo = 'FASES' then 	dw_texto_campos.setitem(fila,'valor_campo',i_datos.cif_prom1)
end if

if (campo_3 <> '') then
	fila = dw_texto_campos.event pfc_addrow()
	dw_texto_campos.setitem(fila,'nombre_campo',campo_3 + ':')
end if

if (campo_4 <> '') then
	fila = dw_texto_campos.event pfc_addrow()
	dw_texto_campos.setitem(fila,'nombre_campo',campo_4 + ':')
end if

if (campo_5 <> '') then
	fila = dw_texto_campos.event pfc_addrow()
	dw_texto_campos.setitem(fila,'nombre_campo',campo_5 + ':')
end if
end event

type cb_1 from commandbutton within w_plantillas_seleccion
integer x = 581
integer y = 1528
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
string text = "&Aceptar"
boolean default = true
end type

event clicked;int filas
string respuesta
st_retorno_seleccion retorno

if f_puedo_escribir(g_usuario,'0000000018')=-1 then 
	retorno.ruta = '-1'
	closewithReturn(parent,retorno)
end if	

retorno.ruta   	 = dw_1.GetItemString(dw_1.GetRow(),'ruta')
retorno.codigo 	 = dw_1.GetItemString(dw_1.GetRow(),'codigo')
retorno.modulo 	 = dw_1.GetItemString(dw_1.GetRow(),'modulo')
retorno.individual = dw_1.GetItemString(dw_1.GetRow(),'individual')
retorno.permitir_editar_plantilla=cbx_permitir_editar.checked

dw_texto_campos.accepttext()
filas = dw_texto_campos.rowcount()

if filas >=1 then
	retorno.campo1=dw_texto_campos.getitemstring(1,'valor_campo')
end if

if filas >=2 then
	retorno.campo2=dw_texto_campos.getitemstring(2,'valor_campo')
end if

if filas >=3 then
	retorno.campo3=dw_texto_campos.getitemstring(3,'valor_campo')
end if	

if filas >=4 then
	retorno.campo4=dw_texto_campos.getitemstring(4,'valor_campo')
end if

if filas >=5 then
	retorno.campo5=dw_texto_campos.getitemstring(5,'valor_campo')
end if

closewithReturn(parent,retorno)

end event

type cb_2 from commandbutton within w_plantillas_seleccion
integer x = 1152
integer y = 1528
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
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;st_retorno_seleccion retorno

retorno.ruta = '-1'

CloseWithReturn(parent,retorno)
end event

type dw_texto_campos from u_dw within w_plantillas_seleccion
integer x = 37
integer y = 960
integer width = 2039
integer height = 432
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_plantillas_texto_campos"
boolean hscrollbar = true
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type cbx_permitir_editar from checkbox within w_plantillas_seleccion
boolean visible = false
integer x = 37
integer y = 1408
integer width = 544
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Permitir editar plantilla "
end type

