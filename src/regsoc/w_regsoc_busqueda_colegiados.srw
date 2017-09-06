HA$PBExportHeader$w_regsoc_busqueda_colegiados.srw
forward
global type w_regsoc_busqueda_colegiados from w_busqueda
end type
type dw_3 from u_dw within w_regsoc_busqueda_colegiados
end type
end forward

global type w_regsoc_busqueda_colegiados from w_busqueda
integer width = 2985
integer height = 2032
dw_3 dw_3
end type
global w_regsoc_busqueda_colegiados w_regsoc_busqueda_colegiados

type variables
string sql
string tabla,campo1,campo2,campo3,campo4,campo5
end variables

on w_regsoc_busqueda_colegiados.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_regsoc_busqueda_colegiados.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;string ls_parametro,errors

this.title  =g_busqueda.titulo

// Habra que crear dinamicamente el dw segun la variable global
//dw_1.DataObject=g_busqueda.dw
//dw_1.SetTransObject(SQLCA)
string sql_nueva,ls_error,ls_syntax

//CARGAMOS LOS DATOS
//select texto into :tabla from var_globales where nombre='regsoc_colegiado_tabla';
//select texto into :campo1 from var_globales where nombre='regsoc_colegiado_campo1';
//select texto into :campo2 from var_globales where nombre='regsoc_colegiado_campo2';
//select texto into :campo3 from var_globales where nombre='regsoc_colegiado_campo3';
//select texto into :campo4 from var_globales where nombre='regsoc_colegiado_campo4';
//select texto into :campo5 from var_globales where nombre='regsoc_colegiado_campo5';

if g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Sociedades" then
	//sql_nueva="SELECT DISTINCT " + tabla + "." + campo1 + ", " + tabla + "." + campo2 + ", " + tabla + "." + campo3 + ", " + tabla + "." + campo4 + ", " + tabla + "." + campo5 +" FROM " + tabla + " WHERE " +  tabla + "." + campo5 + "='S'"
   dw_1.dataobject='d_regsoc_busqueda_colegiados_soc'
else
	//sql_nueva="SELECT DISTINCT " + tabla + "." + campo1 + ", " + tabla + "." + campo2 + ", " + tabla + "." + campo3 + ", " + tabla + "." + campo4 + ", " + tabla + "." + campo5 +" FROM " + tabla + " WHERE " +  tabla + "." + campo5 + "<>'S'"
   dw_1.dataobject='d_regsoc_busqueda_colegiados'
end if
//dw_1.Object.DataWindow.Syntax.Describe("DataWindow.Table.Select") = sql_nueva
//dw_1.syntaxFromSQL(sql_nueva, "", errors)
//ls_syntax = sqlca.SyntaxFromSQL(sql_nueva, "Style(Type= Grid )",ls_error)
string prueba
//dw_1.create(ls_syntax,ls_error)
dw_1.SetTransObject(SQLCA)

//CAMBIAMOS EL TITULO DE LAS COLUMNAS
//dw_1.Modify("DataWindow.Header.Height='64'")
//dw_1.Modify("DataWindow.Detail.Height='68'")
//dw_1.Modify(campo1 + ".Visible = 0")
//dw_1.Modify(campo5 + ".Visible = 0")
//dw_1.Modify(campo2 + "_t.text='N$$HEX2$$ba002000$$ENDHEX$$Colegiado'")
//dw_1.Modify(campo3 + "_t.text='Apellidos'")
//dw_1.Modify(campo4 + "_t.text='Nombre'")
//dw_1.Modify(campo2 + "_t.Font.Face='MS Sans Serif'")
//dw_1.Modify(campo3 + "_t.Font.Face='MS Sans Serif'")
//dw_1.Modify(campo4 + "_t.Font.Face='MS Sans Serif'")
//dw_1.Modify(campo2 + "_t.Font.Height='-8'")
//dw_1.Modify(campo3 + "_t.Font.Height='-8'")
//dw_1.Modify(campo4 + "_t.Font.Height='-8'")
//dw_1.Modify(campo2 + ".Font.Face='MS Sans Serif'")
//dw_1.Modify(campo3 + ".Font.Face='MS Sans Serif'")
//dw_1.Modify(campo4 + ".Font.Face='MS Sans Serif'")
//dw_1.Modify(campo2 + ".Font.Height='-8'")
//dw_1.Modify(campo3 + ".Font.Height='-8'")
//dw_1.Modify(campo4 + ".Font.Height='-8'")
//dw_1.Modify(campo2 + ".TabSequence='0'")
//dw_1.Modify(campo3 + ".TabSequence='0'")
//dw_1.Modify(campo4 + ".TabSequence='0'")
//dw_1.Modify(campo3 + ".Width='1200'")
//dw_1.Modify("DataWindow.Header.Color= '67108864'")
//
sql = dw_1.describe("datawindow.table.select")
dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_regsoc_busqueda_colegiados
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_regsoc_busqueda_colegiados
end type

type sle_1 from w_busqueda`sle_1 within w_regsoc_busqueda_colegiados
end type

type dw_2 from w_busqueda`dw_2 within w_regsoc_busqueda_colegiados
integer x = 649
integer y = 544
integer width = 2213
integer height = 84
integer taborder = 50
end type

event dw_2::editchanged;call super::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')

end event

type st_1 from w_busqueda`st_1 within w_regsoc_busqueda_colegiados
end type

type st_2 from w_busqueda`st_2 within w_regsoc_busqueda_colegiados
integer y = 552
integer width = 571
string text = "Apellido activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_regsoc_busqueda_colegiados
integer y = 1776
integer taborder = 70
end type

event cb_1::clicked;

if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF NOT f_es_vacio(dw_3.GetItemString(1,'n_colegiado')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'apellido_nombresociedad')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre')) OR & 
		NOT f_es_vacio(dw_3.GetItemString(1,'calle')) THEN 		
				dw_3.TriggerEvent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
			parent.event pfc_close()
			return
	end if
	
end if

closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))

end event

type cb_2 from w_busqueda`cb_2 within w_regsoc_busqueda_colegiados
integer y = 1776
integer taborder = 80
end type

type dw_1 from w_busqueda`dw_1 within w_regsoc_busqueda_colegiados
integer x = 37
integer y = 684
integer width = 2894
integer height = 1040
integer taborder = 60
boolean ib_isupdateable = false
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type dw_3 from u_dw within w_regsoc_busqueda_colegiados
integer x = 14
integer width = 2853
integer height = 496
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_regsoc_colegiados_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string sql_nuevo, activa, sql_aux, sql_orig= ''

this.accepttext()
sql_orig = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_orig
// Estos campos tambien habra que cargarlos de la base de datos

f_sql('n_colegiado','LIKE','n_colegiado',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('apellidos','LIKE','apellido_nombresociedad',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre','LIKE','nombre',dw_3,sql_nuevo,g_tipo_base_datos,'')

if not isnull(sql_aux) then sql_nuevo += sql_aux

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_2.setitem(1,1,'')
dw_1.Retrieve('%')

dw_1.modify("datawindow.table.select= ~"" + sql_orig + "~"")


end event

event constructor;call super::constructor;this.insertrow(0)
end event

