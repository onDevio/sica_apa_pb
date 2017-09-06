HA$PBExportHeader$w_busqueda_poblaciones.srw
forward
global type w_busqueda_poblaciones from w_busqueda
end type
end forward

global type w_busqueda_poblaciones from w_busqueda
integer width = 2985
integer height = 1820
end type
global w_busqueda_poblaciones w_busqueda_poblaciones

type variables
string sql
st_busqueda_poblaciones ist_busq_pob
end variables

on w_busqueda_poblaciones.create
call super::create
end on

on w_busqueda_poblaciones.destroy
call super::destroy
end on

event open;this.title  =g_busqueda.titulo

dw_1.DataObject=g_busqueda.dw
dw_1.SetTransObject(SQLCA)
sql = dw_1.describe("datawindow.table.select")

datawindowchild dw_prov
dw_2.getchild('provincia',dw_prov)
dw_prov.settransobject(sqlca)
dw_prov.retrieve()

////Insertamos una fila vac$$HEX1$$ed00$$ENDHEX$$a para que se pueda buscar en todas las provincias al mismo tiempo
//dw_prov.insertrow(0)

datawindowchild dw_zonas
dw_2.getchild('zona',dw_zonas)
dw_zonas.settransobject(sqlca)
dw_zonas.retrieve()


ist_busq_pob = Message.PowerObjectParm	

if isvalid(ist_busq_pob) then
	dw_2.setitem(1,'cp', ist_busq_pob.cod_postal)
	dw_2.setitem(1,'provincia',ist_busq_pob.cod_provincia)
	
	dwObject dwo_cp
	dwo_cp = dw_2.Object.cp
	dw_2.trigger event editchanged(1, dwo_cp, ist_busq_pob.cod_postal)
end if


end event

event pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_busqueda_poblaciones
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_busqueda_poblaciones
end type

type sle_1 from w_busqueda`sle_1 within w_busqueda_poblaciones
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_busqueda_poblaciones
integer x = 37
integer y = 32
integer width = 2153
integer height = 344
integer taborder = 50
string dataobject = "d_busqueda_poblaciones_cabecera"
end type

event dw_2::editchanged;//if not f_es_vacio(data) then dw_1.Retrieve(data+'%')
string ls_poblacion,ls_cod_provincia,ls_mopu, ls_cp, ls_zona, sql_nuevo,ls_bloqueo_zonas
choose case dwo.name
	case 'poblacion'
		ls_poblacion=data
		ls_cod_provincia=getitemstring(row,'provincia')
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=getitemstring(row,'zona')
		ls_cp=getitemstring(row,'cp')
	case 'provincia'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=data
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=getitemstring(row,'zona')
		ls_cp=getitemstring(row,'cp')
	case 'mopu'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=getitemstring(row,'provincia')
		ls_mopu=data
		ls_zona=getitemstring(row,'zona')
		ls_cp=getitemstring(row,'cp')
	case 'zona'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=getitemstring(row,'provincia')
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=data
		ls_cp=getitemstring(row,'cp')
	case 'cp'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=getitemstring(row,'provincia')
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=getitemstring(row,'zona')		
		ls_cp=data
end choose

if f_es_vacio(ls_poblacion) then ls_poblacion=''
if f_es_vacio(ls_cod_provincia) then ls_cod_provincia=''
if f_es_vacio(ls_mopu) then ls_mopu=''
if f_es_vacio(ls_zona) then ls_zona=''
if f_es_vacio(ls_cp) then ls_cp=''

if ls_poblacion='' and ls_cod_provincia='' and ls_mopu='' and ls_zona='' and ls_cp='' then ls_poblacion='NADA###'

////select texto into :ls_bloqueo from var_globales where nombre = 'g_bloqueo_poblaciones';
//ls_bloqueo = g_bloqueo_poblacion
//ls_bloqueo_pob = g_bloqueo_poblaciones
//
//if(ls_bloqueo_pob = 'S' and ls_bloqueo = 'S')then
//	select texto into :ls_bloqueo_zonas from var_globales where nombre = 'g_bloqueo_zonas';
//	sql_nuevo = dw_1.describe("datawindow.table.select")     
//	sql_nuevo += " and ( poblaciones.zona not in ("+ls_bloqueo_zonas+"))"
//	dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
//	dw_1.retrieve(ls_poblacion+'%',ls_cod_provincia+'%',ls_mopu+'%', ls_zona+'%', ls_cp+'%')
//else
//	dw_1.retrieve(ls_poblacion+'%',ls_cod_provincia+'%',ls_mopu+'%', ls_zona+'%', ls_cp+'%')
//end if

dw_1.retrieve(ls_poblacion+'%',ls_cod_provincia+'%',ls_mopu+'%', ls_zona+'%', ls_cp+'%')
end event

event dw_2::itemchanged;call super::itemchanged;string ls_poblacion, ls_cod_provincia, ls_mopu, ls_cp, ls_zona

choose case dwo.name
	case 'provincia'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=data
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=getitemstring(row,'zona')		
		ls_cp=getitemstring(row,'cp')
		
		if f_es_vacio(ls_poblacion) then ls_poblacion=''
		if f_es_vacio(ls_cod_provincia) then ls_cod_provincia=''
		if f_es_vacio(ls_mopu) then ls_mopu=''
		if f_es_vacio(ls_zona) then ls_zona=''		
		if f_es_vacio(ls_cp) then ls_cp=''
		
		if ls_poblacion='' and ls_cod_provincia='' and ls_mopu='' and ls_zona='' and ls_cp='' then ls_poblacion='NADA###'
		dw_1.retrieve(ls_poblacion+'%',ls_cod_provincia+'%',ls_mopu+'%', ls_zona+'%', ls_cp+'%')
		
	case 'zona'
		ls_poblacion=getitemstring(row,'poblacion')
		ls_cod_provincia=getitemstring(row,'provincia')
		ls_mopu=getitemstring(row,'mopu')
		ls_zona=data
		ls_cp=getitemstring(row,'cp')
		
		if f_es_vacio(ls_poblacion) then ls_poblacion=''
		if f_es_vacio(ls_cod_provincia) then ls_cod_provincia=''
		if f_es_vacio(ls_mopu) then ls_mopu=''
		if f_es_vacio(ls_zona) then ls_zona=''		
		if f_es_vacio(ls_cp) then ls_cp=''
		
		if ls_poblacion='' and ls_cod_provincia='' and ls_mopu='' and ls_zona='' and ls_cp='' then ls_poblacion='NADA###'
		dw_1.retrieve(ls_poblacion+'%',ls_cod_provincia+'%',ls_mopu+'%', ls_zona+'%', ls_cp+'%')
end choose

end event

event dw_2::constructor;call super::constructor;string ls_bloqueo_pob, ls_bloqueo

ls_bloqueo = g_bloqueo_poblacion
ls_bloqueo_pob = g_bloqueo_fases

if(ls_bloqueo_pob = 'S' and ls_bloqueo = 'S')then
	this.Modify("provincia.Protect=1")
else
	this.Modify("provincia.Protect=0")
end if
end event

type st_1 from w_busqueda`st_1 within w_busqueda_poblaciones
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_busqueda_poblaciones
boolean visible = false
integer y = 64
integer width = 777
string text = "Poblaci$$HEX1$$f300$$ENDHEX$$n:"
end type

type cb_1 from w_busqueda`cb_1 within w_busqueda_poblaciones
integer x = 553
integer y = 1552
integer taborder = 70
end type

event cb_1::clicked;//SOBREESCRITO
if dw_1.Rowcount() < 1 then
	//Lanzamos el Btn. Buscar si ha puesto valor en alguno de los campos de consulta
	
	// Si no ha encontrado ninguno, cerramos la ventana
	if dw_1.Rowcount() < 1 then
			parent.event pfc_close()
			return
	end if
	
end if
closewithreturn(parent,dw_1.GetItemString(dw_1.GetRow(),1))
end event

type cb_2 from w_busqueda`cb_2 within w_busqueda_poblaciones
integer x = 1600
integer y = 1552
integer taborder = 80
end type

type dw_1 from w_busqueda`dw_1 within w_busqueda_poblaciones
integer x = 37
integer y = 448
integer width = 2894
integer height = 1040
integer taborder = 60
end type

event dw_1::constructor;call super::constructor;// Column header sort
inv_sort.of_SetColumnHeader (true)

inv_sort.of_SetStyle (2)

end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = False
end event

