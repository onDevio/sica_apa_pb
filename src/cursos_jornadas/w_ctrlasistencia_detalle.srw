HA$PBExportHeader$w_ctrlasistencia_detalle.srw
forward
global type w_ctrlasistencia_detalle from w_detalle
end type
type tab_1 from tab within w_ctrlasistencia_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_ctrlasistencia_asistentes from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_ctrlasistencia_asistentes dw_ctrlasistencia_asistentes
end type
type tab_1 from tab within w_ctrlasistencia_detalle
tabpage_1 tabpage_1
end type
type cb_1 from commandbutton within w_ctrlasistencia_detalle
end type
type cb_2 from commandbutton within w_ctrlasistencia_detalle
end type
type dw_listado from u_dw within w_ctrlasistencia_detalle
end type
type cb_anyadir_asistentes from commandbutton within w_ctrlasistencia_detalle
end type
end forward

global type w_ctrlasistencia_detalle from w_detalle
integer width = 3227
integer height = 2296
string title = "Detalle de Control de Asistencia"
tab_1 tab_1
cb_1 cb_1
cb_2 cb_2
dw_listado dw_listado
cb_anyadir_asistentes cb_anyadir_asistentes
end type
global w_ctrlasistencia_detalle w_ctrlasistencia_detalle

type variables
u_dw idw_ctrlasistencia_asistentes 
datastore ds_asistentes
end variables

on w_ctrlasistencia_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_listado=create dw_listado
this.cb_anyadir_asistentes=create cb_anyadir_asistentes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.cb_anyadir_asistentes
end on

on w_ctrlasistencia_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_listado)
destroy(this.cb_anyadir_asistentes)
end on

event activate;call super::activate;g_dw_lista=g_dw_lista_ctrlasistencia
g_w_lista=g_lista_ctrlasistencia
g_w_detalle=g_detalle_ctrlasistencia
g_lista='w_ctrlasistencia_lista'
g_detalle='w_ctrlasistencia_detalle'
end event

event csd_anterior;call super::csd_anterior;if g_dw_lista.RowCount()>0 then
	g_ctrlasistencia_consulta.id_asistencia_fecha=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_asistencia_fecha')
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if g_dw_lista.RowCount()>0 then
	g_ctrlasistencia_consulta.id_asistencia_fecha=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_asistencia_fecha')
	dw_1.event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_ctrlasistencia_consulta.id_asistencia_fecha=g_dw_lista.GetItemString(1,'id_asistencia_fecha')
	
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
	g_ctrlasistencia_consulta.id_asistencia_fecha=g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_asistencia_fecha')
	
	dw_1.event csd_retrieve()
end if

end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje=''
integer p_l

if f_puedo_escribir(g_usuario,'0000000030')=-1 then return -1


//mensaje=mensaje + f_valida(dw_1,'id_curso','NONULO','Debe especificar el nombre del curso.')

int retorno=1

if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)

	retorno=-1

end if


return retorno
end event

event open;call super::open;//Enlazamos los dos datawindows.
idw_ctrlasistencia_asistentes=tab_1.tabpage_1.dw_ctrlasistencia_asistentes
f_enlaza_dw(dw_1,idw_ctrlasistencia_asistentes,'id_asistencia_fecha','id_asistencia_fecha')


inv_resize.of_Register (tab_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_ctrlasistencia_asistentes, "scaletoright&bottom")



end event

event csd_nuevo;call super::csd_nuevo;//Andr$$HEX1$$e900$$ENDHEX$$s 29/06/2005: Reactivamos el csd_nuevo
//Andr$$HEX1$$e900$$ENDHEX$$s 28/04/2005: Vac$$HEX1$$ed00$$ENDHEX$$o csd_nuevo porque en esta ventana no tiene sentido
//Las listas de control de asistencia se crean desde la ventana de detalle de cursos
If AncestorReturnValue>0 then
	dw_1.SetItem(dw_1.GetRow(),'id_asistencia_fecha',f_siguiente_numero('FORMACION_ASIS_FECHA',10))

	dw_1.SetItem(dw_1.GetRow(),'fecha',datetime(today()))

	cb_1.enabled=true
	cb_2.enabled=false
	idw_ctrlasistencia_asistentes.SetTabOrder('asiste',10)
	dw_1.SetTabOrder('id_curso',20)
end if

//A$$HEX1$$f100$$ENDHEX$$adimos a la lista los asistentes a este curso

return AncestorReturnValue

//return 1

end event

event csd_grabar;call super::csd_grabar;string curs
string asistent
integer total, asistencias,i
double porcent

curs=dw_1.GetItemString(dw_1.GetRow(),'id_curso')

for i=1 to idw_ctrlasistencia_asistentes.RowCount() 
	asistent=idw_ctrlasistencia_asistentes.GetItemString(i,'id_asistente')
		
	SELECT COUNT(DISTINCT id_asistencia_fecha)
	INTO :total
	FROM formacion_ctrl_asistencia
	WHERE (id_asistente=:asistent) AND
			(id_curso=:curs);
			
	SELECT COUNT(DISTINCT id_asistencia_fecha)
	INTO :asistencias
	FROM formacion_ctrl_asistencia
	WHERE (id_asistente=:asistent) AND
			(id_curso=:curs) AND
			(asiste='S');
			
	porcent=(asistencias / total) * 100
	
	UPDATE formacion_asistentes
		SET porcentaje_asistencia = :porcent
		WHERE id_asistente  = :asistent; 
		
	
	
next


end event

type cb_nuevo from w_detalle`cb_nuevo within w_ctrlasistencia_detalle
integer taborder = 40
end type

type cb_ayuda from w_detalle`cb_ayuda within w_ctrlasistencia_detalle
integer taborder = 100
end type

type cb_grabar from w_detalle`cb_grabar within w_ctrlasistencia_detalle
integer taborder = 60
end type

type cb_ant from w_detalle`cb_ant within w_ctrlasistencia_detalle
integer taborder = 70
end type

type cb_sig from w_detalle`cb_sig within w_ctrlasistencia_detalle
integer taborder = 90
end type

type dw_1 from w_detalle`dw_1 within w_ctrlasistencia_detalle
integer width = 1966
integer height = 304
string dataobject = "d_ctrlasistencia_detalle"
boolean border = false
end type

event dw_1::csd_retrieve;call super::csd_retrieve;if g_ctrlasistencia_consulta.id_asistencia_fecha='' or isnull(g_ctrlasistencia_consulta.id_asistencia_fecha) then return
int retorno
retorno=parent.event closequery()
if retorno=1 then return
this.retrieve(g_ctrlasistencia_consulta.id_asistencia_fecha)
g_ctrlasistencia_consulta.id_asistencia_fecha=''
end event

event dw_1::itemchanged;datetime f
datetime esta
string curso

choose case dwo.name
	
//CURSO
	case 'id_curso'
		cb_2.enabled=false
		cb_1.enabled=false
		this.AcceptText()
		f=this.GetItemDateTime(this.GetRow(),'fecha')
		
//Si el curso no se imparte la fecha seleccionada
		SELECT fecha
		INTO :esta
		FROM formacion_fechas
		WHERE (id_curso=:data) AND
				(fecha=:f);
		
		if esta<>f then
			messagebox(G_TITULO,'Este curso no imparte clase la fecha indicada.')
		else
			cb_2.enabled=true
			cb_1.enabled=true
		end if	
		
//Si ya se ha generado la lista de asistencia para esta fecha
		esta=datetime('')
		
		SELECT fecha
		INTO :esta
		FROM formacion_asist_fecha
		WHERE (id_curso=:data) AND
				(fecha=:f);
		
		if esta=f then
			messagebox(G_TITULO,'Esta lista de asistencia ya ha sido dada de alta.')
		else
			cb_2.enabled=true
			cb_1.enabled=true
		end if	 

//FECHA

	case 'fecha'
		cb_2.enabled=false
		cb_1.enabled=false
		this.AcceptText()
		curso=this.GetItemString(this.GetRow(),'id_curso')
		f=this.GetItemDateTime(this.GetRow(),'fecha')
		if curso<>'' then
			
//Si el curso no se imparte la fecha seleccionada
			SELECT fecha
			INTO :esta
			FROM formacion_fechas
			WHERE (id_curso=:curso) AND
					(fecha=:f);
			
			if esta<>f then
				messagebox(G_TITULO,'Este curso no imparte clase la fecha indicada.')
			else
				cb_2.enabled=true
				cb_1.enabled=true
			end if
			
//Si ya se ha generado la lista de asistencia para esta fecha
			esta=datetime('')
			
			SELECT fecha
			INTO :esta
			FROM formacion_asist_fecha
			WHERE (id_curso=:curso) AND
					(fecha=:f);
			
			if esta=f then
				messagebox(G_TITULO,'Esta lista de asistencia ya ha sido dada de alta.')
			else
				cb_2.enabled=true
				cb_1.enabled=true
			end if	 
		end if
end choose
end event

event dw_1::retrieveend;dw_1.AcceptText()
idw_ctrlasistencia_asistentes.retrieve(dw_1.GetItemString(dw_1.GetRow(),'id_asistencia_fecha'))

/* CODI QUE NI S'UTILITZA*/ 

//if idw_ctrlasistencia_asistentes.RowCount()=0 then
//	cb_1.enabled=true
//	idw_ctrlasistencia_asistentes.SetTabOrder('asiste',10)
//	this.SetTabOrder('id_curso',20)
//else
//	cb_1.enabled=false
//	idw_ctrlasistencia_asistentes.SetTabOrder('asiste',0)
//	this.SetTabOrder('id_curso',0)
//end if
end event

type tab_1 from tab within w_ctrlasistencia_detalle
integer x = 27
integer y = 360
integer width = 3072
integer height = 1740
integer taborder = 20
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
integer width = 3035
integer height = 1624
long backcolor = 79741120
string text = "Asistentes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_ctrlasistencia_asistentes dw_ctrlasistencia_asistentes
end type

on tabpage_1.create
this.dw_ctrlasistencia_asistentes=create dw_ctrlasistencia_asistentes
this.Control[]={this.dw_ctrlasistencia_asistentes}
end on

on tabpage_1.destroy
destroy(this.dw_ctrlasistencia_asistentes)
end on

type dw_ctrlasistencia_asistentes from u_dw within tabpage_1
integer x = 18
integer y = 16
integer width = 3003
integer height = 1572
integer taborder = 11
string dataobject = "d_ctrlasistencia_asistentes"
boolean livescroll = false
end type

event clicked;// SOBREESCRITO


//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	Description:  DataWindow clicked
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0 	Added Linkage service notification
// 6.0 	Introduced non zero return value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

// Check arguments
IF IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) THEN
	Return
END IF

//IF IsValid (inv_linkage) THEN
//	If inv_linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) <> &
//		inv_linkage.CONTINUE_ACTION Then
//		// The user or a service action prevents from going to the clicked row.
//		Return 1
//	End If
//END IF
//
//IF IsValid (inv_RowSelect) THEN
//	inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )
//END IF

IF IsValid (inv_Sort) THEN 
	inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 
END IF 


end event

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
//this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event pfc_deleterow;call super::pfc_deleterow;//Para que la pr$$HEX1$$f300$$ENDHEX$$xima vez que abramos la ventana de a$$HEX1$$f100$$ENDHEX$$adir asistentes salgan
//bien los que no est$$HEX1$$e100$$ENDHEX$$n en la lista
event csd_grabar()

return ancestorreturnvalue


end event

event rbuttondown;call super::rbuttondown;//para que se borre la fila donde el usuario active el men$$HEX2$$fa002000$$ENDHEX$$contextual
setrow(row)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_delete.enabled = true
am_dw.m_table.m_addrow.enabled = false
am_dw.m_table.m_insert.enabled = false
end event

type cb_1 from commandbutton within w_ctrlasistencia_detalle
boolean visible = false
integer x = 2578
integer y = 224
integer width = 507
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Lista"
end type

event clicked;//BOT$$HEX1$$d300$$ENDHEX$$N PARA GENERAR LA LISTA DE ASISTENCIA


string id_curso
integer num,i
	dw_1.AcceptText()
	id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
	idw_ctrlasistencia_asistentes.reset()
	
		ds_asistentes=CREATE datastore
		ds_asistentes.dataobject='ds_formacion_asistentes'
		ds_asistentes.SetTransObject(SQLCA)
   	ds_asistentes.retrieve(id_curso)
		
				
		num=ds_asistentes.rowcount()
		
		if num=0 then
			messagebox(G_TITULO,'No hay matriculados en este curso.')
		else
			cb_2.enabled=true
		
			for i=1 to num
			idw_ctrlasistencia_asistentes.event pfc_Addrow()
			idw_ctrlasistencia_asistentes.SetItem(i,'id_asistencia',f_siguiente_numero('FORMACION_ASIS_PERS',10))
			idw_ctrlasistencia_asistentes.SetItem(i,'id_asistente',ds_asistentes.GetItemString(i,'id_asistente'))
			idw_ctrlasistencia_asistentes.SetItem(i,'id_curso',id_curso)
			idw_ctrlasistencia_asistentes.SetItem(i,'asiste','S')
			idw_ctrlasistencia_asistentes.SetItem(i,'id_asistencia_fecha',dw_1.GetItemString(dw_1.GetRow(),'id_asistencia_fecha'))
			next
		idw_ctrlasistencia_asistentes.SetSort("apellidos A")
		idw_ctrlasistencia_asistentes.Sort()
		end if
		
		
end event

type cb_2 from commandbutton within w_ctrlasistencia_detalle
integer x = 2578
integer y = 100
integer width = 507
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir Lista"
end type

event clicked;//BOT$$HEX1$$d300$$ENDHEX$$N DE IMPRIMIR LISTA DE ASISTENCIA

//-------------------------------

string id_curso
integer num,i
datetime f


dw_listado.dataobject = g_cursos_control_asistentes
dw_listado.SetTransObject(SQLCA)


//Si no se ha generado la lista de asistencia...
if idw_ctrlasistencia_asistentes.Rowcount()=0 then
	dw_1.AcceptText()
	id_curso=dw_1.GetItemString(dw_1.GetRow(),'id_curso')
	f=dw_1.GetItemDateTime(dw_1.GetRow(),'fecha')
	dw_listado.reset()
	
		ds_asistentes=CREATE datastore
		ds_asistentes.dataobject='ds_formacion_asistentes'
		ds_asistentes.SetTransObject(SQLCA)
   	ds_asistentes.retrieve(id_curso)
	
	ds_asistentes.SetSort("apellidos A")
	ds_asistentes.Sort()
	num=ds_asistentes.rowcount()
		
		if num=0 then
			messagebox(G_TITULO,'No hay matriculados en este curso.')
		else
			cb_2.enabled=true
			
			for i=1 to num
			dw_listado.event pfc_Addrow()
			dw_listado.SetItem(i,'fecha',f)
			dw_listado.SetItem(i,'id_asistente',ds_asistentes.GetItemString(i,'id_asistente'))
			dw_listado.SetItem(i,'id_curso',id_curso)
			next
	
	
		end if
//Si ya se ha generado la lista de asistencia
	else
	string asis
	
	dw_1.AcceptText()
	asis=dw_1.GetItemString(dw_1.GetRow(),'id_asistencia_fecha')
	dw_listado.retrieve(asis)
	end if
	
	dw_listado.Print()
	
//	dw_listado.visible=true		
end event

type dw_listado from u_dw within w_ctrlasistencia_detalle
boolean visible = false
integer y = 104
integer width = 3365
integer height = 1116
integer taborder = 30
boolean bringtotop = true
end type

type cb_anyadir_asistentes from commandbutton within w_ctrlasistencia_detalle
integer x = 2578
integer y = 204
integer width = 507
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir Asistentes"
end type

event clicked;
string ls_id_asistencia_fecha,ls_id_curso
string ls_id_asistente[]
st_anyadir_asistente lst_resultado
long i,ll_filanueva

ls_id_asistencia_fecha=dw_1.getitemstring(dw_1.getrow(),'id_asistencia_fecha')
ls_id_curso=dw_1.getitemstring(dw_1.getrow(),'id_curso')

openwithparm(w_ctrlasistencia_anyadir_asistente,ls_id_asistencia_fecha)

lst_resultado=Message.powerobjectparm

ls_id_asistente=lst_resultado.asistentes

if upperbound(ls_id_asistente)<1 then
	return 
end if

for i=1 to upperbound(ls_id_asistente)
	ll_filanueva=idw_ctrlasistencia_asistentes.event pfc_addrow()
	idw_ctrlasistencia_asistentes.setitem(ll_filanueva,'id_asistente',ls_id_asistente[i])
	idw_ctrlasistencia_asistentes.setitem(ll_filanueva,'id_asistencia',f_siguiente_numero('FORMACION_ASIS_PERS',10))	
	idw_ctrlasistencia_asistentes.setitem(ll_filanueva,'asiste','S')			
	idw_ctrlasistencia_asistentes.setitem(ll_filanueva,'id_asistencia_fecha',ls_id_asistencia_fecha)
	idw_ctrlasistencia_asistentes.setitem(ll_filanueva,'id_curso',ls_id_curso)
next

//Para que la pr$$HEX1$$f300$$ENDHEX$$xima vez que abramos la ventana de a$$HEX1$$f100$$ENDHEX$$adir asistentes salgan
//bien los que no est$$HEX1$$e100$$ENDHEX$$n en la lista
event csd_grabar()

end event

