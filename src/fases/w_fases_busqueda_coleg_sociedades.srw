HA$PBExportHeader$w_fases_busqueda_coleg_sociedades.srw
forward
global type w_fases_busqueda_coleg_sociedades from w_busqueda
end type
type dw_3 from u_dw within w_fases_busqueda_coleg_sociedades
end type
end forward

global type w_fases_busqueda_coleg_sociedades from w_busqueda
integer width = 2985
integer height = 2032
dw_3 dw_3
end type
global w_fases_busqueda_coleg_sociedades w_fases_busqueda_coleg_sociedades

type variables
string sql
string tabla,campo1,campo2,campo3,campo4,campo5

st_fases_colegiados_sociedades ist_fases_col_soc
end variables

on w_fases_busqueda_coleg_sociedades.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_fases_busqueda_coleg_sociedades.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;string ls_id_sociedad
this.title  =g_busqueda.titulo

ls_id_sociedad = message.StringParm
ist_fases_col_soc.id_sociedad = ls_id_sociedad 

if f_es_vacio(ls_id_sociedad) then
	
	return -1
else 
	
	dw_1.retrieve(ls_id_sociedad)
	
end if
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

event close;return -1

closewithreturn(this, ist_fases_col_soc)
end event

event pfc_close;call super::pfc_close;closewithreturn(this, ist_fases_col_soc)
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_fases_busqueda_coleg_sociedades
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_fases_busqueda_coleg_sociedades
end type

type sle_1 from w_busqueda`sle_1 within w_fases_busqueda_coleg_sociedades
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_fases_busqueda_coleg_sociedades
boolean visible = false
integer x = 649
integer y = 544
integer width = 2213
integer height = 84
integer taborder = 50
boolean enabled = false
end type

event dw_2::editchanged;call super::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')

end event

type st_1 from w_busqueda`st_1 within w_fases_busqueda_coleg_sociedades
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_fases_busqueda_coleg_sociedades
boolean visible = false
integer y = 552
integer width = 571
string text = "Apellido activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_fases_busqueda_coleg_sociedades
integer y = 1776
integer taborder = 70
end type

event cb_1::clicked;
long ll_i, ll_j
ll_j = 1

for ll_i=1 to dw_1.rowcount()
	if dw_1.GetItemString(ll_i,'seleccionado')='S' then
		ist_fases_col_soc.id_colegiados[ll_j] = dw_1.GetItemString(ll_i,'id_colegiado')
		ll_j += 1 
	end if	
next	

//if dw_1.Rowcount() < 1 then
//	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
//	dw_3.AcceptText()
//	IF NOT f_es_vacio(dw_3.GetItemString(1,'n_colegiado')) OR &
//		NOT f_es_vacio(dw_3.GetItemString(1,'apellido_nombresociedad')) OR &
//		NOT f_es_vacio(dw_3.GetItemString(1,'nombre')) OR & 
//		NOT f_es_vacio(dw_3.GetItemString(1,'calle')) THEN 		
//				dw_3.TriggerEvent("buttonclicked")
//	END IF
//	
//	// Si no ha encontrado ninguno, cerramos la ventana
//	if dw_1.Rowcount() < 1 then
//			parent.event pfc_close()
//			return
//	end if
//	
//end if

closewithreturn(parent, ist_fases_col_soc)

end event

type cb_2 from w_busqueda`cb_2 within w_fases_busqueda_coleg_sociedades
integer y = 1776
integer taborder = 80
end type

event cb_2::clicked;call super::clicked;return -1	

closewithreturn(parent, ist_fases_col_soc)
end event

type dw_1 from w_busqueda`dw_1 within w_fases_busqueda_coleg_sociedades
integer x = 37
integer y = 32
integer width = 2889
integer height = 1664
integer taborder = 60
string dataobject = "d_fases_seleccion_coleg_sociedades"
boolean ib_isupdateable = false
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type dw_3 from u_dw within w_fases_busqueda_coleg_sociedades
boolean visible = false
integer x = 14
integer width = 2853
integer height = 496
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
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

