HA$PBExportHeader$w_busqueda_registros.srw
forward
global type w_busqueda_registros from w_busqueda
end type
type st_nombre from statictext within w_busqueda_registros
end type
type dw_3 from u_dw within w_busqueda_registros
end type
end forward

global type w_busqueda_registros from w_busqueda
integer width = 2816
integer height = 1912
event csd_ocultar_campos ( )
st_nombre st_nombre
dw_3 dw_3
end type
global w_busqueda_registros w_busqueda_registros

type variables
string sql
string i_tipo='C'
end variables

event csd_ocultar_campos;//CHOOSE CASE i_tipo
//	CASE 'C'
//		dw_3.modify("n_colegiado.visible=true")
//		st_nombre.visible=false
//		st_2.visible=true
//		dw_3.modify("apellido_nombresociedad.visible=true")
//		dw_3.modify("n_colegiado_t.visible=true")
//		dw_3.modify("apellido_nombresociedad_t.visible=true")
//		dw_3.modify("login_t.visible=false")
//		dw_3.modify("login.visible=false")
//	CASE 'U'
//		dw_3.modify("n_colegiado.visible=false")
//		st_nombre.visible=true
//		st_2.visible=false
//		dw_3.modify("apellido_nombresociedad.visible=false")
//		dw_3.modify("apellido_nombresociedad_t.visible=false")
//		dw_3.modify("n_colegiado_t.visible=false")
//		dw_3.modify("login_t.visible=true")
//		dw_3.modify("login.visible=true")
//	CASE 'O'
//		dw_3.modify("n_colegiado.visible=false")
//		st_nombre.visible=true
//		st_2.visible=false
//		dw_3.modify("apellido_nombresociedad.visible=false")
//		dw_3.modify("apellido_nombresociedad_t.visible=false")
//		dw_3.modify("n_colegiado_t.visible=false")
//		dw_3.modify("login_t.visible=false")
//		dw_3.modify("login.visible=false")
//END CHOOSE
end event

on w_busqueda_registros.create
int iCurrent
call super::create
this.st_nombre=create st_nombre
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre
this.Control[iCurrent+2]=this.dw_3
end on

on w_busqueda_registros.destroy
call super::destroy
destroy(this.st_nombre)
destroy(this.dw_3)
end on

event open;call super::open;sql = dw_1.describe("datawindow.table.select")
//  i_tipo='C'
//  this.triggerevent("csd_ocultar_campos")
//dw_1.retrieve('%')

if not(f_es_vacio(g_busqueda.param1)) then
	dw_3.SetItem(1,'tipo',g_busqueda.param1)
end if
	
	
end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_registros
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_registros
string tag = "texto=general.guardar_pantalla"
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_registros
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_registros
integer x = 754
integer y = 444
integer width = 1961
integer height = 92
integer taborder = 50
end type

event dw_2::editchanged;string sql_nuevo,activa,sql_orig

if not f_es_vacio(data) then 

	dw_3.acceptText()
	sql_orig = dw_1.describe("datawindow.table.select")
	sql_nuevo=sql_orig
	
	f_sql('n_registro','LIKE','n_registro',dw_3,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fecha','=','fecha',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
	f_sql('es','LIKE','tipo',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
	f_sql('nombre_o','LIKE','nombre_o',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
	f_sql('nombre_d','LIKE','nombre_d',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
	f_sql('tipo_persona_o','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
	
	dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	dw_1.Retrieve(data+'%')
	dw_1.modify("datawindow.table.select= ~"" + sql_orig + "~"")
end if


end event

type st_1 from w_busqueda`st_1 within w_busqueda_registros
string tag = "texto=reg_es.parametro_completo"
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_busqueda_registros
string tag = "texo=reg_es.apellido_sociedad_activo_teclear"
boolean visible = false
integer x = 46
integer y = 464
integer width = 777
string text = "Apellido/Sociedad activo al teclear:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_registros
integer x = 512
integer y = 1672
integer taborder = 70
end type

event cb_1::clicked;if dw_1.Rowcount() < 1 then
	parent.event pfc_close()
	return
end if
//g_certificados_busqueda.tipo_persona=i_tipo
g_certificados_busqueda.fecha=dw_1.GetItemdatetime(dw_1.GetRow(),3)
//if i_tipo='U' then
//	g_certificados_busqueda.departamento=dw_1.GetItemString(dw_1.GetRow(),5)
//end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),'id_registro'))

end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_registros
integer x = 1559
integer y = 1672
integer taborder = 80
end type

event cb_2::clicked;closewithreturn(parent,"")
end event

type dw_1 from w_busqueda`dw_1 within w_busqueda_registros
integer x = 41
integer y = 576
integer width = 2720
integer height = 1024
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

type st_nombre from statictext within w_busqueda_registros
string tag = "texto=reg_es.n_registro_activo_teclear"
integer x = 46
integer y = 444
integer width = 631
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$aa002000$$ENDHEX$$registro activo al teclear:"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_busqueda_registros
integer x = 27
integer width = 2711
integer height = 392
integer taborder = 10
string dataobject = "d_registros_consulta_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;string sql_nuevo,activa,sql_orig
dw_3.acceptText()
sql_orig = dw_1.describe("datawindow.table.select")
sql_nuevo=sql_orig

f_sql('n_registro','LIKE','n_registro',dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha','=','fecha',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('es','LIKE','tipo',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre_o','LIKE','nombre_o',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('nombre_d','LIKE','nombre_d',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')
f_sql('tipo_persona_o','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,g_tipo_base_datos,'')

if pos(upper(sql_nuevo),'WHERE')>0 then
		sql_nuevo+=" and empresa ='"+g_empresa+"'"
else
	sql_nuevo+=" WHERE empresa ='"+g_empresa+"'"
end if
	
dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_2.setitem(1,1,'%')
dw_1.Retrieve('%')
dw_1.modify("datawindow.table.select= ~"" + sql_orig + "~"")

//choose case i_tipo
//	case 'C'
//		f_sql('n_registro','LIKE','n_registro',dw_3,sql_nuevo,g_tipo_base_datos,'')
//		f_sql('fecha','LIKE','fecha',Parent.dw_3,sql_nuevo,'1','')
//		f_sql('nombre','LIKE','nombre',Parent.dw_3,sql_nuevo,'1','')
//		//f_sql('tipo_persona','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,'1','')
//	case 'O' 
//		f_sql('otras_personas.nombre','LIKE','nombre',Parent.dw_3,sql_nuevo,'1','')
//	case 'U'
//		f_sql('t_usuario.nombre_usuario','LIKE','nombre',Parent.dw_3,sql_nuevo,'1','')
//		f_sql('t_usuario.login','LIKE','login',Parent.dw_3,sql_nuevo,'1','')
//end choose
//
end event

event constructor;call super::constructor;this.insertrow(0)
this.setitem(1,'tipo','%')
this.setitem(1,'tipo_persona','C')

this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event itemchanged;//En funci$$HEX1$$f300$$ENDHEX$$n del tipo de usuario se asocia el dw correspondiente y se muestran los campos necesarios

//if  (dwo.name="tipo") then
//	CHOOSE CASE data
//		case 'C'
//			dw_1.DataObject="d_lista_busqueda_colegiados"			
//			dw_1.SetTransObject(SQLCA)
//			i_tipo='C'
//			parent.triggerevent("csd_ocultar_campos")
//		case 'U'
//			dw_1.DataObject="d_lista_busqueda_usuarios"			
//			dw_1.SetTransObject(SQLCA)
//			i_tipo='U'
//			parent.triggerevent("csd_ocultar_campos")
//		case 'O'
//			dw_1.DataObject="d_lista_busqueda_miembros"			
//			dw_1.SetTransObject(SQLCA)
//			i_tipo='O'
//			parent.triggerevent("csd_ocultar_campos")
//	end CHOOSE
//end if
//
end event

