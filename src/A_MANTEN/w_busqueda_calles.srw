HA$PBExportHeader$w_busqueda_calles.srw
forward
global type w_busqueda_calles from w_busqueda
end type
type st_provincia from st_2 within w_busqueda_calles
end type
type st_provincia_valor from statictext within w_busqueda_calles
end type
type dw_parametros_busqueda from u_dw within w_busqueda_calles
end type
end forward

global type w_busqueda_calles from w_busqueda
integer width = 3387
integer height = 1780
st_provincia st_provincia
st_provincia_valor st_provincia_valor
dw_parametros_busqueda dw_parametros_busqueda
end type
global w_busqueda_calles w_busqueda_calles

type variables
st_busqueda_calles_llamada ist_param_llamada
string is_nombre_provincia,is_cod_provincia

end variables

on w_busqueda_calles.create
int iCurrent
call super::create
this.st_provincia=create st_provincia
this.st_provincia_valor=create st_provincia_valor
this.dw_parametros_busqueda=create dw_parametros_busqueda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_provincia
this.Control[iCurrent+2]=this.st_provincia_valor
this.Control[iCurrent+3]=this.dw_parametros_busqueda
end on

on w_busqueda_calles.destroy
call super::destroy
destroy(this.st_provincia)
destroy(this.st_provincia_valor)
destroy(this.dw_parametros_busqueda)
end on

event open;call super::open;
//Extendemos el script del antecesor
ist_param_llamada=Message.PowerObjectParm	
is_cod_provincia=ist_param_llamada.cod_provincia

dw_parametros_busqueda.insertrow(0)
//dw_parametros_busqueda.setitemstatus(1,0,Primary!,NotModified!)

//obtenemos la provincia que se corresponde con el c$$HEX1$$f300$$ENDHEX$$digo de provincia pasado

////si nos pasan un valor de provincia fijarlo en el dddw
if not f_es_vacio(is_cod_provincia) then
	dw_parametros_busqueda.setitem(1,'provincia',is_cod_provincia)
//	dw_parametros_busqueda.modify('provincia.tabsequence=0')
//	dw_parametros_busqueda.modify('provincia.background.mode=1')
end if



end event

event type integer pfc_updatespending(powerobject apo_control[]);call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_calles
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_calles
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_calles
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_calles
boolean visible = false
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(is_cod_provincia , data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_calles
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_busqueda_calles
boolean visible = false
string text = "Calle"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_calles
integer y = 1540
end type

event cb_1::clicked;st_busqueda_calles_retorno lst_retorno

if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_parametros_busqueda.AcceptText()
	IF NOT f_es_vacio(dw_parametros_busqueda.GetItemString(1,'provincia')) OR &
		NOT f_es_vacio(dw_parametros_busqueda.GetItemString(1,'calle')) OR &
		NOT f_es_vacio(dw_parametros_busqueda.GetItemString(1,'cp')) /*OR &
		NOT f_es_vacio(dw_parametros_busqueda.GetItemString(1,'poblacion'))*/ THEN 
				dw_parametros_busqueda.TriggerEvent("buttonclicked")
	END IF
	if dw_1.Rowcount() < 1 then
		parent.event pfc_close()
		return
	end if
end if

lst_retorno.calle=dw_1.getitemstring(dw_1.getrow(),'calle')
lst_retorno.cod_pos=dw_1.getitemstring(dw_1.getrow(),'cod_pos')
lst_retorno.cod_poblacion=dw_1.getitemstring(dw_1.getrow(),'cod_pob')

closewithreturn(parent,lst_retorno)

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_calles
integer y = 1540
end type

event cb_2::clicked;call super::clicked;//Si el usuario pulsa cancelar se devuelve una estructura que no es v$$HEX1$$e100$$ENDHEX$$lida
//Quien llame a esta ventana ha de comprobar la condicion isvalid(estructura devuelta)


end event

type dw_1 from w_busqueda`dw_1 within w_busqueda_calles
integer x = 37
integer y = 576
integer width = 3287
integer height = 900
string dataobject = "d_calles_busqueda"
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)

inv_sort.of_SetStyle (2)

end event

type st_provincia from st_2 within w_busqueda_calles
integer y = 64
string text = "Provincia"
end type

type st_provincia_valor from statictext within w_busqueda_calles
boolean visible = false
integer x = 805
integer y = 64
integer width = 1335
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_parametros_busqueda from u_dw within w_busqueda_calles
integer x = 37
integer y = 32
integer width = 2647
integer height = 508
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_calles_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
end type

event buttonclicked;call super::buttonclicked;string ls_sql_old='',ls_sql_nuevo=''
integer li_numero_calle,li_resto

this.accepttext()

ls_sql_old = dw_1.describe("datawindow.table.select")
ls_sql_nuevo=ls_sql_old

li_numero_calle=this.getitemnumber(row,'numero')

if not isnull(li_numero_calle) and li_numero_calle<>0 then

	li_resto=mod(li_numero_calle,2)

	//si el n$$HEX1$$fa00$$ENDHEX$$mero es impar...
	if li_resto=1 then
		f_sql('n_impar_desde','<=','numero',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
		f_sql('n_impar_hasta','>=','numero',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	else //el n$$HEX1$$fa00$$ENDHEX$$mero es par
		f_sql('n_par_desde','<=','numero',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
		f_sql('n_par_hasta','>=','numero',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
	end if
	
end if

f_sql('callejero.provincia','LIKE','provincia',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('calle','LIKE INSIDE','calle',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
//f_sql('poblaciones.descripcion','LIKE','poblacion',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('callejero.cod_pos','LIKE','cp',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')
f_sql('callejero.cod_ciudad','LIKE','ciudad',dw_parametros_busqueda,ls_sql_nuevo,g_tipo_base_datos,'')

dw_1.modify("datawindow.table.select= ~"" + ls_sql_nuevo + "~"")

//mmm, tal vez seria mejor modficar el datawindow (d_calles_busqueda)
dw_1.Retrieve('%','%')
	
// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + ls_sql_old + "~"")
end event

event itemerror;call super::itemerror;if dwo.name='numero' then
	return 2
end if
end event

