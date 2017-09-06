HA$PBExportHeader$w_almacen_detalle.srw
forward
global type w_almacen_detalle from w_detalle
end type
type tab_1 from tab within w_almacen_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_visados from u_csd_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_visados dw_visados
end type
type tab_1 from tab within w_almacen_detalle
tabpage_1 tabpage_1
end type
end forward

global type w_almacen_detalle from w_detalle
integer width = 3415
integer height = 2076
tab_1 tab_1
end type
global w_almacen_detalle w_almacen_detalle

type variables
u_csd_dw idw_visados
end variables

on w_almacen_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_almacen_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista	= g_dw_lista_almacen
g_w_lista   = g_lista_almacen
g_w_detalle = g_detalle_almacen

g_lista     = 'w_almacen_lista'
g_detalle   = 'w_almacen_detalle'
end event

event csd_anterior;call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_almacen_consulta = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_almacen")
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id de la reunion
		g_almacen_consulta = g_dw_lista.getitemstring(1,"id_almacen")
		dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_almacen_consulta= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_almacen")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo;call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	g_almacen_consulta= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_almacen")
		dw_1.event csd_retrieve()
end if

end event

event csd_nuevo;call super::csd_nuevo;if AncestorReturnValue>0 then
	
	string tipo
	//Ponemos el foco dentro del datawindows principal.
	dw_1.setfocus()
	
	//Ponemos un valor al identificador   ID_ALMACEN
	dw_1.SetItem(dw_1.GetRow(),'id_almacen',f_siguiente_numero('ID_ALMACEN',10))
	
	//Ponemos las variables instancia a vacio, ya que creamos una reunion nueva
	g_almacen_consulta=''

end if

return AncestorReturnValue
end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje=''

//PERMISOS
if f_puedo_escribir(g_usuario,'0000000179')=-1 then return -1

//mensaje=mensaje + f_valida(dw_1,'n_asesoria','NOVACIO','Debe especificar un valor en numero de asesoria')
//mensaje=mensaje + f_valida(dw_1,'id_col','NOVACIO','Debe especificar un colegiado')


// Validamos en la pesta$$HEX1$$f100$$ENDHEX$$a de visados si hay alguno que no coincide
int retorno=1
string cadena,n_visado,compute_1,estado
long i
boolean errores=false
for i=1 to idw_visados.rowcount() 
	
	n_visado=idw_visados.getitemstring(i,'n_visado')
	compute_1=idw_visados.getitemstring(i,'compute_1')
	estado=idw_visados.getitemstring(i,'estado')
	
	if( not f_es_vacio(n_visado) and f_es_vacio(compute_1)) or (estado<>'S') then
		errores=true
	end if
next
if errores=true then mensaje=mensaje + ' Hay n$$HEX1$$fa00$$ENDHEX$$meros de visado err$$HEX1$$f300$$ENDHEX$$neos reviselos '
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno

end event

event open;call super::open;idw_visados 			= tab_1.tabpage_1.dw_visados


f_enlaza_dw(dw_1, idw_visados, 'id_almacen', 'id_almacen')

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (idw_visados, "scaletoright&bottom")
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_almacen_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_almacen_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_almacen_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_almacen_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_almacen_detalle
end type

type cb_ant from w_detalle`cb_ant within w_almacen_detalle
end type

type cb_sig from w_detalle`cb_sig within w_almacen_detalle
end type

type dw_1 from w_detalle`dw_1 within w_almacen_detalle
integer x = 37
integer y = 32
integer width = 3310
integer height = 936
string title = "Detalle de Almac$$HEX1$$e900$$ENDHEX$$n"
string dataobject = "d_almacen_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::csd_retrieve;call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador de la asesoria
if g_almacen_consulta='' or isnull(g_almacen_consulta) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos 
this.retrieve(g_almacen_consulta)

//Vaciamos la variable instancia 
g_almacen_consulta=''

if idw_visados.rowcount()=0 then return 

string id_fase,visado
for i=1 to idw_visados.rowcount()
	id_fase=idw_visados.getitemstring(i,'id_fase')
	visado=f_devuelve_visado_fase(id_fase)
	if idw_visados.getitemstring(i,'n_visado')<>visado then
		idw_visados.setitem(i,'estado','N')
	end if
next
end event

type tab_1 from tab within w_almacen_detalle
integer x = 37
integer y = 1040
integer width = 3301
integer height = 776
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3264
integer height = 660
long backcolor = 79741120
string text = "Visados"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_visados dw_visados
end type

on tabpage_1.create
this.dw_visados=create dw_visados
this.Control[]={this.dw_visados}
end on

on tabpage_1.destroy
destroy(this.dw_visados)
end on

type dw_visados from u_csd_dw within tabpage_1
integer x = 23
integer y = 24
integer width = 3205
integer height = 616
integer taborder = 11
string dataobject = "d_almacen_visados"
end type

event pfc_addrow;call super::pfc_addrow;this.setitem(GetRow(),'id_almacen_visados',f_siguiente_numero('ID_ALMACEN_VISADOS',10))

return ancestorReturnValue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(GetRow(),'id_almacen_visados',f_siguiente_numero('ID_ALMACEN_VISADOS',10))

return ancestorReturnValue
end event

event itemchanged;call super::itemchanged;// si cambiamos el texto, y es correcto metemos el id_fase
this.setitem(row,'n_visado',data)
if not f_es_vacio(this.getitemstring(row,'compute_1')) then
	this.setitem(row,'id_fase',this.getitemstring(row,'compute_1'))
else
	this.setitem(row,'id_fase','')
end if
end event

event clicked;call super::clicked;string id_fase
CHOOSE CASE dwo.name
	CASE 'b_fase'
 		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Fase"
 		g_busqueda.dw="d_lista_busqueda_fases"
 		id_fase=f_busqueda_fases()
 		if id_fase="-1" then
			  this.deleterow(row)
		 else
			  //this.setitem(this.getrow(),'id_col',id_persona)
			  this.setitem(row,'n_visado',f_devuelve_visado_fase(id_fase))
			  this.setitem(row,'id_fase',id_fase)
 		end if	
		 
END CHOOSE
end event

