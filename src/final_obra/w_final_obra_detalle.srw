HA$PBExportHeader$w_final_obra_detalle.srw
forward
global type w_final_obra_detalle from w_detalle
end type
type tab_1 from tab within w_final_obra_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_final_obra_detalle_fase from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_final_obra_detalle_fase dw_final_obra_detalle_fase
end type
type tabpage_2 from userobject within tab_1
end type
type dw_final_obra_detalle_promotores from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_final_obra_detalle_promotores dw_final_obra_detalle_promotores
end type
type tabpage_3 from userobject within tab_1
end type
type dw_final_obra_detalle_coleg_asociados from u_dw within tabpage_3
end type
type dw_final_obra_detalle_colegiados from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_final_obra_detalle_coleg_asociados dw_final_obra_detalle_coleg_asociados
dw_final_obra_detalle_colegiados dw_final_obra_detalle_colegiados
end type
type tab_1 from tab within w_final_obra_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_final_obra_detalle from w_detalle
integer width = 3648
integer height = 1804
string title = "Detallle de Final de Obra"
tab_1 tab_1
end type
global w_final_obra_detalle w_final_obra_detalle

type variables
DataWindowChild i_dwc_colegiados_asociados
end variables

on w_final_obra_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_final_obra_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;call super::open;f_enlaza_dw(dw_1,tab_1.tabpage_1.dw_final_obra_detalle_fase,'id_fase','id_fase')
f_enlaza_dw(dw_1,tab_1.tabpage_2.dw_final_obra_detalle_promotores,'id_fase','id_fase')
f_enlaza_dw(dw_1,tab_1.tabpage_3.dw_final_obra_detalle_colegiados,'id_fase','id_fase')
f_enlaza_dw(tab_1.tabpage_3.dw_final_obra_detalle_colegiados,tab_1.tabpage_3.dw_final_obra_detalle_coleg_asociados,'id_fases_colegiados','id_fases_colegiados')

inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_final_obra_detalle_fase, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2.dw_final_obra_detalle_promotores, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_3.dw_final_obra_detalle_colegiados, "scaletobottom")
inv_resize.of_Register (tab_1.tabpage_3.dw_final_obra_detalle_coleg_asociados, "scaletoright&bottom")

end event

event activate;call super::activate;g_dw_lista	= g_dw_lista_final_obra
g_w_lista   = g_lista_final_obra
g_w_detalle = g_detalle_final_obra
g_lista     = 'w_final_obra_lista'
g_detalle   = 'w_final_obra_detalle'


end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_siniestro y el id_fase
	g_final_obra_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fase")
	g_final_obra_consulta.id_fases_final = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fases_final")
	dw_1.event csd_retrieve()
end if
end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	double sup_viv_res = 0, sup_garage_res = 0, sup_otros_res = 0, num_viv_res = 0, num_edif_res = 0, presupuesto_res = 0
	int i
	double sup_viv_exp = 0, sup_garage_exp = 0, sup_otros_exp = 0, num_viv_exp = 0, num_edif_exp = 0, presupuesto_exp = 0
	//Rellenamos los campos que queremos poner por defecto
	dw_1.Setitem(dw_1.GetRow(),'id_fases_final',f_siguiente_numero('FINALES_OBRA',10))
	dw_1.SetItem(dw_1.GetRow(),'fecha',today())
	dw_1.SetItem(dw_1.GetRow(),'f_intro',today())
	//donde "n" es un entero que indica la longitud en caracteres del contador
	dw_1.setfocus()
	
	dw_1.setitem(dw_1.GetRow(),'sup_viv',0)
	dw_1.setitem(dw_1.GetRow(),'sup_garage',0)
	dw_1.setitem(dw_1.GetRow(),'sup_otros',0)
	dw_1.setitem(dw_1.GetRow(),'num_viv',0)
	dw_1.setitem(dw_1.GetRow(),'num_edif',0)
	dw_1.setitem(dw_1.GetRow(),'presupuesto',0)
	
	
	
	//Vaciamos la variable global id_siniestro y de id_fase
	g_final_obra_consulta.id_fases_final=''
	g_final_obra_consulta.id_fase=''
	//Datawindows de colegiados
	tab_1.tabpage_1.dw_final_obra_detalle_fase.retrieve(g_final_obra_consulta.id_fase)
end if

return AncestorReturnValue
end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id_siniestro y el id_fase
	g_final_obra_consulta.id_fases_final = g_dw_lista.getitemstring(1,"id_fases_final")
	g_final_obra_consulta.id_fase = g_dw_lista.getitemstring(1,"id_fase")
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el id_siniestro y el id_fase
	g_final_obra_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fase")
	g_final_obra_consulta.id_fases_final = g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_fases_final")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id_fases_final y el id_fase
	g_final_obra_consulta.id_fases_final = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_fases_final")
	g_final_obra_consulta.id_fase = g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_fase")
	dw_1.event csd_retrieve()
end if

end event

event pfc_preupdate;call super::pfc_preupdate;string mensaje=''

if f_puedo_escribir(g_usuario,'0000000007')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'id_fase','NOVACIO',g_idioma.of_getmsg('msg_final_obra.asociar_contrato','Debe asociar un contrato a este final de obra'))
mensaje=mensaje + f_valida(dw_1,'id_fases_final','NOVACIO',g_idioma.of_getmsg('msg_final_obra.especificar_final_obra','Debe especificar el final de obra'))

int retorno=1
if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno = -1
end if
return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_final_obra_detalle
string tag = "texto=general.recuperar_pantalla"
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_final_obra_detalle
string tag = "texto=general.guardar_pantalla"
end type

type cb_nuevo from w_detalle`cb_nuevo within w_final_obra_detalle
string tag = "texto=general.nuevo"
end type

type cb_ayuda from w_detalle`cb_ayuda within w_final_obra_detalle
string tag = "texto=general.ayuda"
end type

type cb_grabar from w_detalle`cb_grabar within w_final_obra_detalle
string tag = "texto=general.grabar"
end type

type cb_ant from w_detalle`cb_ant within w_final_obra_detalle
end type

type cb_sig from w_detalle`cb_sig within w_final_obra_detalle
end type

type dw_1 from w_detalle`dw_1 within w_final_obra_detalle
integer x = 37
integer y = 32
integer width = 2263
integer height = 744
string dataobject = "d_final_obra_detalle"
boolean border = false
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_fase

//Buscamos las fases
g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_fases"
id_fase=f_busqueda_fases()  
if NOT f_es_vacio(id_fase) then
	//Ponemos para que se visualize el valor del expediente y del registro
	this.setitem(1,'n_registro',f_dame_n_reg(id_fase))	
	this.setitem(1,'n_expediente',f_dame_exp(id_fase))	
	//Ponemos el valor de la fase en el datawindow de 
	dw_1.setitem(1,'id_fase',id_fase)
	//Asignamos la id_fase a la variable global
	g_final_obra_consulta.id_fase=id_fase
	//Datawindows del Contrato
	tab_1.tabpage_1.dw_final_obra_detalle_fase.retrieve(g_final_obra_consulta.id_fase)
	//Datawindows del Clientes
	tab_1.tabpage_2.dw_final_obra_detalle_promotores.retrieve(g_final_obra_consulta.id_fase)
	//Datawindows del Colegiados
	tab_1.tabpage_3.dw_final_obra_detalle_colegiados.retrieve(g_final_obra_consulta.id_fase)
	//Datawindows del Colegiados asociados
	tab_1.tabpage_3.dw_final_obra_detalle_coleg_asociados.post event csd_dddw_retrieve()
	
end if


end event

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador del
if g_final_obra_consulta.id_fases_final ='' or isnull(g_final_obra_consulta.id_fases_final) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos del siniestro
this.retrieve(g_final_obra_consulta.id_fases_final)
//Datawindows de datos de la fase
tab_1.tabpage_1.dw_final_obra_detalle_fase.retrieve(g_final_obra_consulta.id_fase)
tab_1.tabpage_2.dw_final_obra_detalle_promotores.retrieve(g_final_obra_consulta.id_fase)
tab_1.tabpage_3.dw_final_obra_detalle_colegiados.retrieve(g_final_obra_consulta.id_fase)
tab_1.tabpage_3.dw_final_obra_detalle_coleg_asociados.post event csd_dddw_retrieve()

//Vaciamos la variable global id_fases_final y de id_fase
g_final_obra_consulta.id_fases_final=''
g_final_obra_consulta.id_fase=''
end event

type tab_1 from tab within w_final_obra_detalle
integer x = 9
integer y = 836
integer width = 3570
integer height = 768
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
string tag = "texto=final_obra.contrato"
integer x = 18
integer y = 112
integer width = 3534
integer height = 640
long backcolor = 79741120
string text = "Contrato"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Copy!"
long picturemaskcolor = 536870912
dw_final_obra_detalle_fase dw_final_obra_detalle_fase
end type

on tabpage_1.create
this.dw_final_obra_detalle_fase=create dw_final_obra_detalle_fase
this.Control[]={this.dw_final_obra_detalle_fase}
end on

on tabpage_1.destroy
destroy(this.dw_final_obra_detalle_fase)
end on

type dw_final_obra_detalle_fase from u_dw within tabpage_1
integer x = 18
integer y = 24
integer width = 3488
integer height = 592
integer taborder = 11
string dataobject = "d_final_obra_detalle_fase"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_2 from userobject within tab_1
string tag = "texto=final_obra.clientes"
integer x = 18
integer y = 112
integer width = 3534
integer height = 640
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
dw_final_obra_detalle_promotores dw_final_obra_detalle_promotores
end type

on tabpage_2.create
this.dw_final_obra_detalle_promotores=create dw_final_obra_detalle_promotores
this.Control[]={this.dw_final_obra_detalle_promotores}
end on

on tabpage_2.destroy
destroy(this.dw_final_obra_detalle_promotores)
end on

type dw_final_obra_detalle_promotores from u_dw within tabpage_2
integer x = 18
integer y = 24
integer width = 3493
integer height = 592
integer taborder = 11
string dataobject = "d_final_obra_detalle_promotores"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_3 from userobject within tab_1
string tag = "texto=final_obra.colegiados"
integer x = 18
integer y = 112
integer width = 3534
integer height = 640
long backcolor = 79741120
string text = "Colegiados"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Move!"
long picturemaskcolor = 536870912
dw_final_obra_detalle_coleg_asociados dw_final_obra_detalle_coleg_asociados
dw_final_obra_detalle_colegiados dw_final_obra_detalle_colegiados
end type

on tabpage_3.create
this.dw_final_obra_detalle_coleg_asociados=create dw_final_obra_detalle_coleg_asociados
this.dw_final_obra_detalle_colegiados=create dw_final_obra_detalle_colegiados
this.Control[]={this.dw_final_obra_detalle_coleg_asociados,&
this.dw_final_obra_detalle_colegiados}
end on

on tabpage_3.destroy
destroy(this.dw_final_obra_detalle_coleg_asociados)
destroy(this.dw_final_obra_detalle_colegiados)
end on

type dw_final_obra_detalle_coleg_asociados from u_dw within tabpage_3
event csd_dddw_retrieve ( )
integer x = 2149
integer y = 24
integer width = 1367
integer height = 592
integer taborder = 11
string dataobject = "d_final_obra_detalle_coleg_asociados"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event csd_dddw_retrieve();int filas
if tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getrow() <= 0 then return
if f_colegiado_tipopersona(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getitemstring(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getrow(), 'id_col')) = 'S' then
	this.visible = true
		if i_dwc_colegiados_asociados.rowcount() <= 0 then 
		this.visible = false	
			i_dwc_colegiados_asociados.insertrow(0)
	else 
		i_dwc_colegiados_asociados.retrieve(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getitemstring(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getrow(), 'id_col'))
	end if 
	if i_dwc_colegiados_asociados.rowcount() <= 0 then 
		this.visible = false	
		i_dwc_colegiados_asociados.insertrow(0)
	end if 
	this.filter()
else
	this.visible = false	
end if



end event

event type long pfc_addrow();call super::pfc_addrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_asociados.RowCount()<1 THEN i_dwc_colegiados_asociados.InsertRow(0)
this.setitem(ancestorreturnvalue, 'id_fase', dw_1.getitemstring(1, 'id_fase'))
this.setitem(ancestorreturnvalue, 'id_col_aso',tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getitemstring(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getrow(), 'id_col'))

return ancestorreturnvalue


end event

event type long pfc_insertrow();call super::pfc_insertrow;// Si no hay filas en el desplegable condicional colocamos una
IF i_dwc_colegiados_asociados.RowCount()<1 THEN i_dwc_colegiados_asociados.InsertRow(0)
this.setitem(ancestorreturnvalue, 'id_fase', dw_1.getitemstring(1, 'id_fase'))
this.setitem(ancestorreturnvalue, 'id_col_aso', tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getitemstring(tab_1.tabpage_3.dw_final_obra_detalle_colegiados.getrow(), 'id_col'))

return ancestorreturnvalue
end event

event constructor;call super::constructor;this.getchild('id_col_per',i_dwc_colegiados_asociados)

i_dwc_colegiados_asociados.settransobject(sqlca)
i_dwc_colegiados_asociados.InsertRow (0)
end event

type dw_final_obra_detalle_colegiados from u_dw within tabpage_3
integer x = 18
integer y = 24
integer width = 2103
integer height = 592
integer taborder = 11
string dataobject = "d_final_obra_detalle_colegiados"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event rowfocuschanged;call super::rowfocuschanged;tab_1.tabpage_3.dw_final_obra_detalle_coleg_asociados.post event csd_dddw_retrieve()
end event

