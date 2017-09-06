HA$PBExportHeader$w_mant_arquitectos.srw
forward
global type w_mant_arquitectos from w_mant_simple
end type
type dw_busqueda from u_dw within w_mant_arquitectos
end type
type cb_1 from commandbutton within w_mant_arquitectos
end type
end forward

global type w_mant_arquitectos from w_mant_simple
integer width = 3520
integer height = 1720
string title = "Mantenimiento de Arquitectos"
string menuname = "m_manteni_arquitectos"
dw_busqueda dw_busqueda
cb_1 cb_1
end type
global w_mant_arquitectos w_mant_arquitectos

type variables
string i_accion = 'CONSULTA'
end variables

on w_mant_arquitectos.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manteni_arquitectos" then this.MenuID = create m_manteni_arquitectos
this.dw_busqueda=create dw_busqueda
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.cb_1
end on

on w_mant_arquitectos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.cb_1)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'apellidos','NOVACIO','Debe especificar un valor en el campo Apellidos.'+cr)
mensaje += f_valida(dw_1,'nombre','NOVACIO','Debe especificar un valor en el campo Nombre.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
//			res = f_busca_duplicados_colum_dw (dw_1, 'c_informe', fila)
//			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
//	END IF
//next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event open;call super::open;dw_busqueda.insertrow(0)

end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_arquitectos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_arquitectos
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_arquitectos
integer y = 228
integer width = 3401
string dataobject = "d_mant_arquitectos"
end type

event dw_1::pfc_addrow;call super::pfc_addrow;STRING ID
id = f_siguiente_numero('ID_ARQUITECTOS', 10)
dw_1.setitem(ancestorreturnvalue, 'id_arquitecto', id)
return ancestorreturnvalue
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;STRING ID
id = f_siguiente_numero('ID_ARQUITECTOS', 10)
dw_1.setitem(ancestorreturnvalue, 'id_arquitecto', id)
return ancestorreturnvalue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_arquitectos
integer y = 1396
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_arquitectos
integer y = 1396
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_arquitectos
integer y = 1396
end type

type dw_busqueda from u_dw within w_mant_arquitectos
integer x = 274
integer y = 24
integer width = 1920
integer height = 184
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mant_arquitectos_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_mant_arquitectos
integer x = 2263
integer y = 44
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar"
end type

event clicked;string sql_old = '', sql_nuevo = '', activa

dw_busqueda.accepttext()

sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old

f_sql('apellidos','LIKE','apellidos',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre','LIKE','nombre',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
//f_sql('tipo_persona','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,'1','')

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//dw_busqueda.setitem(1,1,'')
//dw_busqueda.setitem(1,2,'')

dw_1.Retrieve()//'%')

// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")

end event

