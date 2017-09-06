HA$PBExportHeader$w_plantillas_campos.srw
forward
global type w_plantillas_campos from w_response
end type
type dw_1 from u_dw within w_plantillas_campos
end type
type dw_2 from u_dw within w_plantillas_campos
end type
type st_2 from statictext within w_plantillas_campos
end type
type cb_1 from u_cb within w_plantillas_campos
end type
type cb_aceptar from commandbutton within w_plantillas_campos
end type
type st_1 from statictext within w_plantillas_campos
end type
end forward

global type w_plantillas_campos from w_response
integer x = 214
integer y = 221
integer width = 3337
integer height = 916
string title = "Campos de una Plantilla"
dw_1 dw_1
dw_2 dw_2
st_2 st_2
cb_1 cb_1
cb_aceptar cb_aceptar
st_1 st_1
end type
global w_plantillas_campos w_plantillas_campos

type variables
string i_codigo, i_cod_plant
end variables

on w_plantillas_campos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_aceptar
this.Control[iCurrent+6]=this.st_1
end on

on w_plantillas_campos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.st_1)
end on

event open;i_cod_plant = Message.StringParm

//Nos han pasado el coddigo de la plantilla
//Necesitamos tambi$$HEX1$$e900$$ENDHEX$$n el m$$HEX1$$f300$$ENDHEX$$dulo

//select modulo into :i_codigo from plantillas where codigo = :i_cod_plant;

i_codigo = i_cod_plant

dw_1.Retrieve(i_codigo)
dw_2.Retrieve(i_cod_plant)




end event

event activate;g_dw_lista = dw_1
//g_w_lista = g_plantillas_campos
//g_w_detalle = g_detalle_plantillas
g_lista = 'w_plantillas_campos'
//g_detalle = 'w_plantillas_detalle'
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

//dw_1
mensaje += f_valida(dw_1,'campo_formulario','NOVACIO','Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS DEL M$$HEX1$$d300$$ENDHEX$$DULO: Debe especificar un valor para el atributo CAMPO FORMULARIO.'+cr)
mensaje += f_valida(dw_1,'campo_interno','NOVACIO','Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS DEL M$$HEX1$$d300$$ENDHEX$$DULO: Debe especificar un valor en el campo CAMPO INTERNO.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'campo_formulario', fila)
			if res > 0 then mensaje += 'Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS DEL M$$HEX1$$d300$$ENDHEX$$DULO: Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next


//dw_2
mensaje += f_valida(dw_2,'campo_formulario','NOVACIO','Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS EXTRA: Debe especificar un valor para el atributo CAMPO FORMULARIO.'+cr)
mensaje += f_valida(dw_2,'nombre_etiqueta','NOVACIO','Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS EXTRA: Debe especificar un valor para el campo NOMBRE ETIQUETA.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_2.RowCount() 
	IF dw_2.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_2, 'campo_formulario', fila)
			if res > 0 then mensaje += 'Secci$$HEX1$$f300$$ENDHEX$$n CAMPOS EXTRA: Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_plantillas_campos
integer taborder = 60
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_plantillas_campos
end type

type dw_1 from u_dw within w_plantillas_campos
integer x = 37
integer y = 32
integer width = 3237
integer height = 588
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_plantillas_campos"
end type

event pfc_addrow;call super::pfc_addrow;if AncestorReturnValue>0 then
	//dw_1.setitem(AncestorReturnValue ,'cod_plantilla', i_codigo)
	dw_1.setitem(AncestorReturnValue ,'modulo', i_codigo)
	dw_1.setrow(AncestorReturnValue)
	//dw_1.setitem(dw_1.getrow() ,'cod_plantilla', i_codigo)
end if
return AncestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;if AncestorReturnValue>0 then
	//dw_1.setitem(AncestorReturnValue ,'cod_plantilla', i_codigo)
	dw_1.setitem(AncestorReturnValue ,'modulo', i_codigo)
	dw_1.setrow(AncestorReturnValue)
	//dw_1.setitem(dw_1.getrow() ,'cod_plantilla', i_codigo)
end if
return AncestorReturnValue
end event

type dw_2 from u_dw within w_plantillas_campos
boolean visible = false
integer x = 50
integer y = 820
integer width = 3273
integer height = 556
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_plantillas_campos_extra_manten"
end type

event pfc_insertrow;call super::pfc_insertrow;if AncestorReturnValue>0 then
	dw_2.setitem(AncestorReturnValue ,'cod_plant', i_cod_plant)
	dw_2.setrow(AncestorReturnValue)
	//dw_1.setitem(dw_1.getrow() ,'cod_plantilla', i_codigo)
end if
return AncestorReturnValue
end event

event pfc_addrow;call super::pfc_addrow;if AncestorReturnValue>0 then
	dw_2.setitem(AncestorReturnValue ,'cod_plant', i_cod_plant)
	dw_2.setrow(AncestorReturnValue)
	//dw_1.setitem(dw_1.getrow() ,'cod_plantilla', i_codigo)
end if
return AncestorReturnValue
end event

type st_2 from statictext within w_plantillas_campos
boolean visible = false
integer x = 73
integer y = 740
integer width = 1179
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
string text = "Campos Extra:"
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_plantillas_campos
integer x = 1797
integer y = 652
integer width = 361
integer height = 112
integer taborder = 50
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;close(parent)
end event

type cb_aceptar from commandbutton within w_plantillas_campos
integer x = 1193
integer y = 652
integer width = 361
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;close(w_plantillas_campos)
end event

type st_1 from statictext within w_plantillas_campos
boolean visible = false
integer x = 73
integer y = 36
integer width = 1179
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Campos del M$$HEX1$$f300$$ENDHEX$$dulo:"
boolean focusrectangle = false
end type

