HA$PBExportHeader$w_busqueda_colegiados_asignados_1.srw
forward
global type w_busqueda_colegiados_asignados_1 from w_busqueda
end type
type dw_3 from u_dw within w_busqueda_colegiados_asignados_1
end type
end forward

global type w_busqueda_colegiados_asignados_1 from w_busqueda
integer width = 2985
integer height = 2008
dw_3 dw_3
end type
global w_busqueda_colegiados_asignados_1 w_busqueda_colegiados_asignados_1

type variables
string sql, i_tipo_demanda
end variables

on w_busqueda_colegiados_asignados_1.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_busqueda_colegiados_asignados_1.destroy
call super::destroy
destroy(this.dw_3)
end on

event open;call super::open;i_tipo_demanda=message.stringparm
if i_tipo_demanda <> '' then
	dw_3.setitem(1,'tipo_demanda',i_tipo_demanda)
	dw_3.triggerevent ("buttonclicked")
end if

sql = dw_1.describe("datawindow.table.select")

dw_3.SetFocus()
//dw_1.retrieve('%')
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_colegiados_asignados_1
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_colegiados_asignados_1
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_colegiados_asignados_1
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_colegiados_asignados_1
integer x = 832
integer y = 544
integer width = 1975
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
end event

type st_1 from w_busqueda`st_1 within w_busqueda_colegiados_asignados_1
end type

type st_2 from w_busqueda`st_2 within w_busqueda_colegiados_asignados_1
integer y = 552
integer width = 777
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_colegiados_asignados_1
integer y = 1776
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	dw_3.AcceptText()
	IF NOT f_es_vacio(dw_3.GetItemString(1,'nif')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'apellido_nombresociedad')) OR &
		NOT f_es_vacio(dw_3.GetItemString(1,'nombre')) THEN 
				dw_3.TriggerEvent("buttonclicked")
	END IF
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
			parent.event pfc_close()
			return
	end if
	
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),'id_col'))
end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_colegiados_asignados_1
integer y = 1776
integer taborder = 80
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_colegiados_asignados_1
integer x = 37
integer y = 676
integer width = 2894
integer height = 1040
integer taborder = 60
boolean hscrollbar = true
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
end event

event dw_1::retrieveend;call super::retrieveend;long ll_i, ll_j

		for ll_i = 1 to this.rowcount()
			for ll_j = 1 to this.rowcount()
				 if ll_i = 0 or ll_j = 0 then
					continue;
				else
						if((dw_1.getitemstring(ll_i, 'id_col') = dw_1.getitemstring(ll_j, 'id_col'))and (ll_i <> ll_j)) then
							if(dw_1.getitemdatetime(ll_i, 'f_oferta') > dw_1.getitemdatetime(ll_j, 'f_oferta'))then
								dw_1.deleterow(ll_j)
								if(ll_i < ll_j)then
									ll_j = ll_j - 1
								else
									ll_i = ll_i - 1
									ll_j = ll_j - 1
								end if
							else
								string ls_fecha
								ls_fecha = string(dw_1.getitemdatetime(ll_i, 'f_oferta'))
								if(f_es_vacio(ls_fecha))then
									dw_1.deleterow(ll_i)
									if(ll_i < ll_j)then 		
										ll_i = ll_i - 1
										ll_j = ll_j - 1
									else
										ll_i = ll_i - 1
										end if
								end if
							end if
						end if
					end if
			next
		next
		

end event

type dw_3 from u_dw within w_busqueda_colegiados_asignados_1
integer x = 14
integer width = 2853
integer height = 448
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_asignados_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string sql_old = '', sql_nuevo = '', activa


this.accepttext()
sql_old = dw_1.describe("datawindow.table.select")
if sql_old='' then sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old

f_sql('colegiados.n_colegiado','LIKE INSIDE','num_colegiado',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.apellidos','LIKE INSIDE','apellido_nombresociedad',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.nombre','LIKE INSIDE','nombre',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('bt_demandas_tipo.tipo_demanda','LIKE','tipo_demanda',dw_3,sql_nuevo,g_tipo_base_datos,'')

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

dw_2.setitem(1,1,'')

dw_1.Retrieve(i_tipo_demanda)

// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")


//dw_1.setfilter("tipo_demanda = '" + i_tipo_demanda + "'")
//dw_1.filter()

end event

event constructor;call super::constructor;this.insertrow(0)
end event

