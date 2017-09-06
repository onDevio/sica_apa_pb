HA$PBExportHeader$w_demandas_detalle.srw
forward
global type w_demandas_detalle from w_detalle
end type
type tab_1 from tab within w_demandas_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_demandas_detalle_tipo_bolsa from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_demandas_detalle_tipo_bolsa dw_demandas_detalle_tipo_bolsa
end type
type tabpage_2 from userobject within tab_1
end type
type dw_demandas_detalle_ofertas from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_demandas_detalle_ofertas dw_demandas_detalle_ofertas
end type
type tabpage_3 from userobject within tab_1
end type
type dw_demandas_detalle_curriculum_idiomas from u_dw within tabpage_3
end type
type dw_demandas_detalle_curriculum from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_demandas_detalle_curriculum_idiomas dw_demandas_detalle_curriculum_idiomas
dw_demandas_detalle_curriculum dw_demandas_detalle_curriculum
end type
type tabpage_4 from userobject within tab_1
end type
type dw_demandas_detalle_cursos from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_demandas_detalle_cursos dw_demandas_detalle_cursos
end type
type tabpage_5 from userobject within tab_1
end type
type dw_demandas_detalle_experiencias from u_dw within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_demandas_detalle_experiencias dw_demandas_detalle_experiencias
end type
type tabpage_6 from userobject within tab_1
end type
type dw_demandas_detalle_otros from u_dw within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_demandas_detalle_otros dw_demandas_detalle_otros
end type
type tab_1 from tab within w_demandas_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
end forward

global type w_demandas_detalle from w_detalle
integer width = 3502
integer height = 1540
string title = "Detalle de Demandas"
tab_1 tab_1
end type
global w_demandas_detalle w_demandas_detalle

type variables

//string i_situacion_laboral,i_tipo_solicitud,i_carnet,i_coche

end variables

on w_demandas_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_demandas_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;call super::open;//Enlazamos los datawindows correspondientes para poder sacar la informacion q los relaciona.
f_enlaza_dw(dw_1,tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_2.dw_demandas_detalle_ofertas,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_3.dw_demandas_detalle_curriculum,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_3.dw_demandas_detalle_curriculum_idiomas,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_4.dw_demandas_detalle_cursos,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_5.dw_demandas_detalle_experiencias,'id_col','id_col')
f_enlaza_dw(dw_1,tab_1.tabpage_6.dw_demandas_detalle_otros,'id_col','id_col')

//Redimensionamos los tabs  y las ventanas asociadas

inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa, "scaletoright&bottom")

inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_2.dw_demandas_detalle_ofertas, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_3, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_3.dw_demandas_detalle_curriculum_idiomas, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_4, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_4.dw_demandas_detalle_cursos, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_5, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_5.dw_demandas_detalle_experiencias, "scaletoright&bottom")

inv_resize.of_Register (tab_1.tabpage_6, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_6.dw_demandas_detalle_otros, "scaletoright&bottom")
end event

event csd_anterior();call super::csd_anterior;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	//Cogemos el colegiado asociado a la demanda
	g_demandas_consulta.id_col= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_col")
	dw_1.event csd_retrieve()
end if
end event

event type integer csd_nuevo();call super::csd_nuevo;if AncestorReturnValue>0 then
	//Ponemos el foco dentro del datawindows principal.
	dw_1.setfocus()
	//Insertamos una fila nueva en el datawindows.
	//	tab_1.tabpage_3.dw_demandas_detalle_curriculum.insertrow(0)
	tab_1.tabpage_3.dw_demandas_detalle_curriculum.event pfc_addrow()
	tab_1.tabpage_6.dw_demandas_detalle_otros.event pfc_addrow()
	//Vaciamos la variable instancia, as$$HEX2$$ed002000$$ENDHEX$$obtenemos una ficha nueva.
	//g_demandas_consulta.id_col=''
end if

return AncestorReturnValue

end event

event csd_primero();call super::csd_primero;//Preguntamos si hay filas el datawindows de la lista
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(1)
	g_dw_lista.scrolltorow(1)
	//Cogemos el id_col
	g_demandas_consulta.id_col = g_dw_lista.getitemstring(1,"id_col")
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_demandas_consulta.id_col= g_dw_lista.getitemstring(g_dw_lista.getrow(),"id_col")
	dw_1.event csd_retrieve()
end if

end event

event csd_ultimo();call super::csd_ultimo;//Preguntamos si hay filas el datawindows de la lista
if not isvalid(g_dw_lista) then return
if g_dw_lista.rowcount() > 0 then 
	g_dw_lista.setrow(g_dw_lista.rowcount())
	g_dw_lista.scrolltorow(g_dw_lista.rowcount())
	//Cogemos el id_siniestro y el id_fase
	g_demandas_consulta.id_col= g_dw_lista.getitemstring(g_dw_lista.rowcount(),"id_col")
	dw_1.event csd_retrieve()
end if

end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

//PERMISOS
if f_puedo_escribir(g_usuario,'0000000013')=-1 then return -1

//Comprobacion que haya valor en el colegiado
mensaje += f_valida(dw_1,'id_col','NOVACIO','Debe especificar un Colegiado'+cr)

//Se debe de asociar una bolsa de trabajo al colegiado.
If tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa.rowcount()<=0 then 
	mensaje += 'Debe asociar una bolsa de trabajo a este colegiado'+ cr
End if 

/***************** Comprobacion del primer TAB *************************/
mensaje += f_valida(tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa,'tipo_demanda','NOVACIO','Debe especificar un valor en el tipo de bolsa'+cr)
// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa.RowCount() 
	IF tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (tab_1.tabpage_1.dw_demandas_detalle_tipo_bolsa, 'tipo_demanda', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + ' en Bolsas Asociadas' + cr
	END IF
next

/***************** Comprobacion del TAB CURSOS *************************/
mensaje += f_valida(tab_1.tabpage_4.dw_demandas_detalle_cursos,'curso','NOVACIO','Debe especificar un valor en el campo de Curso.'+cr)
// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to tab_1.tabpage_4.dw_demandas_detalle_cursos.RowCount() 
	IF tab_1.tabpage_4.dw_demandas_detalle_cursos.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (tab_1.tabpage_4.dw_demandas_detalle_cursos, 'curso', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + ' en Cursos' + cr
	END IF
next

/***************** Comprobacion del TAB EXPERIENCIA *************************/
mensaje += f_valida(tab_1.tabpage_5.dw_demandas_detalle_experiencias,'empresa','NOVACIO','Debe especificar un valor en el campo de Empresa.'+cr)
// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to tab_1.tabpage_5.dw_demandas_detalle_experiencias.RowCount() 
	IF tab_1.tabpage_5.dw_demandas_detalle_experiencias.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (tab_1.tabpage_5.dw_demandas_detalle_experiencias, 'empresa', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + ' en Experiencia' + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event activate;call super::activate;g_dw_lista	= g_dw_lista_demandas
g_w_lista   = g_lista_demandas
g_w_detalle = g_detalle_demandas
g_lista     = 'w_demandas_lista'
g_detalle   = 'w_demandas_detalle'
end event

event type integer pfc_postupdate(powerobject apo_control[]);call super::pfc_postupdate;string carnet,coche, viajar, sit_lab, tipo_sol, id_col, otros

id_col = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'id_col')

//messagebox("id_col",id_col)
carnet = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'carnet')
coche = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'coche')
sit_lab = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'situacion_laboral')
tipo_sol = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'tipo_solicitud')
viajar = tab_1.tabpage_3.dw_demandas_detalle_curriculum.getitemstring(1,'viajar')
otros = tab_1.tabpage_6.dw_demandas_detalle_otros.getitemstring(1,'otros')

update bt_demandas 
set 
	situacion_laboral = :sit_lab,
	tipo_solicitud = :tipo_sol,
	carnet = :carnet,
	coche = :coche,
	viajar = :viajar,
	otros = :otros
where
	id_col = :id_col;


return ancestorreturnvalue
end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_demandas_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_demandas_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_demandas_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_demandas_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_demandas_detalle
end type

type cb_ant from w_detalle`cb_ant within w_demandas_detalle
end type

type cb_sig from w_detalle`cb_sig within w_demandas_detalle
end type

type dw_1 from w_detalle`dw_1 within w_demandas_detalle
integer x = 27
integer y = 24
integer width = 2505
integer height = 388
string dataobject = "d_demandas_detalle"
boolean border = false
end type

event dw_1::buttonclicked;call super::buttonclicked;string id_col,n_col,desc_pob
string pob
integer rep_col
choose case dwo.name
	case "b_busca_colegiado"
  		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col)  then
			SELECT COUNT(*) INTO:rep_col FROM bt_demandas WHERE bt_demandas.id_col = :id_col;
			If rep_col>0 then 
				MessageBox(g_titulo,"El colegiado escogido ya existe debe cambiarlo",StopSign!)
			else
				this.setitem(1,'id_col',id_col)
				tab_1.tabpage_3.dw_demandas_detalle_curriculum.setitem(1,'id_col',id_col)
				tab_1.tabpage_6.dw_demandas_detalle_otros.setitem(1,'id_col',id_col)
			end if 
		end if
END CHOOSE

end event

event dw_1::csd_retrieve();call super::csd_retrieve;//Comprobamos que la variabe que le pasamos, en este caso el identificador del siniestro
if g_demandas_consulta.id_col= '' or isnull(g_demandas_consulta.id_col) then return
int    retorno
double i
//Cerramos la consulta
retorno = parent.event closequery()
if retorno = 1 then return
//Retriveamos los datos de la demanda
this.retrieve(g_demandas_consulta.id_col)


//Vaciamos la variable instancia del colegiado
g_demandas_consulta.id_col=''

end event

event dw_1::csd_enter;// Sobreescrito

end event

type tab_1 from tab within w_demandas_detalle
integer x = 23
integer y = 416
integer width = 3410
integer height = 900
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
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Bolsas Asociadas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom048!"
long picturemaskcolor = 536870912
dw_demandas_detalle_tipo_bolsa dw_demandas_detalle_tipo_bolsa
end type

on tabpage_1.create
this.dw_demandas_detalle_tipo_bolsa=create dw_demandas_detalle_tipo_bolsa
this.Control[]={this.dw_demandas_detalle_tipo_bolsa}
end on

on tabpage_1.destroy
destroy(this.dw_demandas_detalle_tipo_bolsa)
end on

type dw_demandas_detalle_tipo_bolsa from u_dw within tabpage_1
integer x = 23
integer y = 32
integer width = 3310
integer height = 724
integer taborder = 11
string dataobject = "d_demandas_detalle_tipo_bolsa"
boolean ib_rmbfocuschange = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Ofertas Candidatas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Count!"
long picturemaskcolor = 536870912
dw_demandas_detalle_ofertas dw_demandas_detalle_ofertas
end type

on tabpage_2.create
this.dw_demandas_detalle_ofertas=create dw_demandas_detalle_ofertas
this.Control[]={this.dw_demandas_detalle_ofertas}
end on

on tabpage_2.destroy
destroy(this.dw_demandas_detalle_ofertas)
end on

type dw_demandas_detalle_ofertas from u_dw within tabpage_2
integer x = 23
integer y = 32
integer width = 3310
integer height = 724
integer taborder = 11
string dataobject = "d_demandas_detalle_ofertas_candidatas"
boolean hscrollbar = true
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Curr$$HEX1$$ed00$$ENDHEX$$culum"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom004!"
long picturemaskcolor = 536870912
dw_demandas_detalle_curriculum_idiomas dw_demandas_detalle_curriculum_idiomas
dw_demandas_detalle_curriculum dw_demandas_detalle_curriculum
end type

on tabpage_3.create
this.dw_demandas_detalle_curriculum_idiomas=create dw_demandas_detalle_curriculum_idiomas
this.dw_demandas_detalle_curriculum=create dw_demandas_detalle_curriculum
this.Control[]={this.dw_demandas_detalle_curriculum_idiomas,&
this.dw_demandas_detalle_curriculum}
end on

on tabpage_3.destroy
destroy(this.dw_demandas_detalle_curriculum_idiomas)
destroy(this.dw_demandas_detalle_curriculum)
end on

type dw_demandas_detalle_curriculum_idiomas from u_dw within tabpage_3
integer x = 23
integer y = 300
integer width = 3314
integer height = 456
integer taborder = 11
string dataobject = "d_demandas_detalle_curriculum_idiomas"
end type

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1


mensaje += f_valida(tab_1.tabpage_3.dw_demandas_detalle_curriculum_idiomas,'idioma','NOVACIO','Debe especificar un valor en el campo de Idioma.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to this.RowCount() 
	IF this.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (this, 'idioma', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return Ancestorreturnvalue
end event

type dw_demandas_detalle_curriculum from u_dw within tabpage_3
integer x = 14
integer y = 56
integer width = 3305
integer height = 260
integer taborder = 11
string dataobject = "d_demandas_detalle_curriculum"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_rmbmenu = false
string is_updatesallowed = "UD"
end type

event buttonclicked;call super::buttonclicked;n_cst_filesrvwin32 lnv_filesrv
string ls_ruta_doc, ls_nom_doc, directorio
int li_valor
n_file_dialogs lnv_file_dialog
boolean lb_existe

lnv_filesrv = create n_cst_filesrvwin32
directorio = lnv_filesrv.of_getcurrentdirectory()
		
//Comprobamos que existe la carpeta de la ruta de g_directorio_bt
lb_existe=lnv_filesrv.of_directoryexists(g_directorio_bt)
if not lb_existe then
	li_valor=lnv_filesrv.of_createdirectory(g_directorio_bt)
end if

if li_valor=-1 then 
	Messagebox('Error','Error al crear el directorio donde se copiar$$HEX1$$e100$$ENDHEX$$n los curr$$HEX1$$ed00$$ENDHEX$$culums.'&
	+cr+'Aseg$$HEX1$$fa00$$ENDHEX$$rese de que el directorio '+g_directorio_bt+' existe.',StopSign!)
	return
end if

//S$$HEX1$$f300$$ENDHEX$$lo permitimos seleccionar un fichero
lnv_file_dialog.ib_allowmultiselect = false

//Seleccionamos el fichero y lo copiamos al directorio adecuado
li_valor = lnv_file_dialog.of_getopenfilename("Seleccionar Documento", ls_ruta_doc, ls_nom_doc,"", "Archivos (*.PDF), *.PDF, Archivos (*.DOC), *.DOC")
if li_valor = 1 then
	f_copiarfichero(ls_ruta_doc+ "\" + ls_nom_doc,g_directorio_bt+ls_nom_doc)
	//guardamos el nombre del fichero
	This.SetItem(1,'curriculum',ls_nom_doc)
end if 

// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
lnv_filesrv.of_changedirectory(directorio)
destroy lnv_filesrv

end event

event doubleclicked;call super::doubleclicked;string ls_nombre_fichero

ls_nombre_fichero=this.GetItemString(1,'curriculum')

if f_es_vacio(ls_nombre_fichero) then return

//Abrimos el fichero con su programa asociado en Windows
f_abrir_fichero(g_directorio_bt,ls_nombre_fichero,"")

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Cursos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "CrossTab!"
long picturemaskcolor = 536870912
dw_demandas_detalle_cursos dw_demandas_detalle_cursos
end type

on tabpage_4.create
this.dw_demandas_detalle_cursos=create dw_demandas_detalle_cursos
this.Control[]={this.dw_demandas_detalle_cursos}
end on

on tabpage_4.destroy
destroy(this.dw_demandas_detalle_cursos)
end on

type dw_demandas_detalle_cursos from u_dw within tabpage_4
integer x = 23
integer y = 32
integer width = 3310
integer height = 724
integer taborder = 11
string dataobject = "d_demandas_detalle_cursos"
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Experiencia "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom073!"
long picturemaskcolor = 536870912
dw_demandas_detalle_experiencias dw_demandas_detalle_experiencias
end type

on tabpage_5.create
this.dw_demandas_detalle_experiencias=create dw_demandas_detalle_experiencias
this.Control[]={this.dw_demandas_detalle_experiencias}
end on

on tabpage_5.destroy
destroy(this.dw_demandas_detalle_experiencias)
end on

type dw_demandas_detalle_experiencias from u_dw within tabpage_5
integer x = 23
integer y = 32
integer width = 3310
integer height = 724
integer taborder = 11
string dataobject = "d_demandas_detalle_experiencias"
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3374
integer height = 772
long backcolor = 79741120
string text = "Otros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom072!"
long picturemaskcolor = 536870912
dw_demandas_detalle_otros dw_demandas_detalle_otros
end type

on tabpage_6.create
this.dw_demandas_detalle_otros=create dw_demandas_detalle_otros
this.Control[]={this.dw_demandas_detalle_otros}
end on

on tabpage_6.destroy
destroy(this.dw_demandas_detalle_otros)
end on

type dw_demandas_detalle_otros from u_dw within tabpage_6
integer x = 23
integer y = 28
integer width = 3323
integer height = 720
integer taborder = 21
string dataobject = "d_demandas_detalle_otros"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_rmbmenu = false
string is_updatesallowed = "UD"
end type

event resize;call super::resize;this.object.otros.width=this.width - 20
this.object.otros.height=this.height - 20

end event

