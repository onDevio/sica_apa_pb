HA$PBExportHeader$w_libros_detalle.srw
forward
global type w_libros_detalle from w_detalle
end type
type tab_1 from tab within w_libros_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_prestamos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_prestamos dw_prestamos
end type
type tabpage_2 from userobject within tab_1
end type
type dw_historico from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_historico dw_historico
end type
type tab_1 from tab within w_libros_detalle
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_libros_detalle from w_detalle
integer width = 3465
integer height = 2032
string title = "Detalle de Biblioteca"
string menuname = "m_detalle_libro"
event csd_prestamo ( )
event csd_devolucion ( )
event csd_recibos ( )
tab_1 tab_1
end type
global w_libros_detalle w_libros_detalle

type variables
u_dw idw_prestamos, idw_historico

end variables

event csd_prestamo;st_libro_busqueda lst_parametros
datetime f_prestado, f_prevista, fecha
string  ls_tipo, ls_opcion ='1'
long ldl_tipo = 1

//Se valida que no este prestado y que tenga condici$$HEX1$$f300$$ENDHEX$$n de prestable
if dw_1.getitemstring(dw_1.getrow(),'prestable')='S'  then
	//if idw_prestamos.rowcount() = 0 then
			idw_prestamos.event pfc_addrow()
	//end if
		
//	if (not isnull(idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_prestamo'))  ) then
//		idw_prestamos.event pfc_insertrow()
//		
//	end if
		if dw_1.getitemstring(dw_1.getrow(),'prestado')='N'   then
			
			lst_parametros.opcion = ls_opcion
			OpenWithParm(w_libros_prestamo, lst_parametros)
					
			
			lst_parametros =  message.PowerObjectParm
	
			
			//if ls_opcion = '1' then
				f_prestado 		=	lst_parametros.f_prestamo_desde 
				f_prevista		=  lst_parametros.f_devolucion_real_desde 
				idw_prestamos.setitem(tab_1.tabpage_1.dw_prestamos.getrow(), "f_prestamo",f_prestado )
				idw_prestamos.setitem(tab_1.tabpage_1.dw_prestamos.getrow(), "f_devolucion_prevista",f_prevista )
				fecha=idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_devolucion_real')

				if isnull(fecha) then
					dw_1.setitem(dw_1.getrow(),'prestado','S')
				end if
//			else
//				idw_prestamos.event pfc_deleterow()
//			end if
			
		else
				
			messagebox(g_titulo_aplicacion,"El libro ya est$$HEX2$$e1002000$$ENDHEX$$prestado.")
		
		end if
	
end if


end event

event csd_devolucion;st_libro_busqueda lst_parametros
datetime f_devolucion, fecha, f_prevista
string tipo_dw, ls_opcion ='2'
long ll_found

//Se valida que no este prestado y que tenga condici$$HEX1$$f300$$ENDHEX$$n de prestable

if dw_1.getitemstring(dw_1.rowcount(),'prestable')='N'  then
	messagebox(g_titulo_aplicacion,"El libro no es prestable.")
end if
if dw_1.getitemstring(dw_1.rowcount(),'prestado')='N' then
	messagebox(g_titulo_aplicacion,"El libro no se ha prestado.")
end if		

if idw_prestamos.rowcount() > 0 then
				
	lst_parametros.opcion 				= ls_opcion
	lst_parametros.f_prestamo_desde 	= idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_devolucion_prevista')
	OpenWithParm(w_libros_prestamo, lst_parametros)
			
end if
		
lst_parametros =  message.PowerObjectParm

f_devolucion 		=	lst_parametros.f_devolucion_real_desde 
f_prevista 		=	lst_parametros.f_prestamo_desde 
idw_prestamos.setitem(tab_1.tabpage_1.dw_prestamos.getrow(), "f_devolucion_real",f_devolucion )
idw_prestamos.setitem(tab_1.tabpage_1.dw_prestamos.getrow(), "f_prestamo",f_prevista )			
				
fecha=idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_devolucion_real')

if isnull(fecha) then
	dw_1.setitem(dw_1.getrow(),'prestado','S')
	
else 
	dw_1.setitem(dw_1.getrow(),'prestado','N')
	
end if
			
			
			



end event

event csd_recibos;g_busqueda.titulo="Documentos"
g_busqueda.dw="d_libros_recibos"

open(w_libros_documentos)
end event

on w_libros_detalle.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_detalle_libro" then this.MenuID = create m_detalle_libro
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_libros_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista=g_dw_lista_libros
g_w_lista=g_lista_libros
g_w_detalle=g_detalle_libros
g_lista='w_libros_lista'
g_detalle='w_libros_detalle'
end event

event open;call super::open;idw_prestamos=tab_1.tabpage_1.dw_prestamos
idw_historico = tab_1.tabpage_2.dw_historico


f_enlaza_dw(dw_1,idw_prestamos,'id_libro','id_libro')
f_enlaza_dw(dw_1,idw_historico,'id_libro','id_libro')

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register(idw_prestamos, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_2, "scaletoright&bottom")
inv_resize.of_Register(idw_historico, "scaletoright&bottom")

end event

event csd_nuevo;call super::csd_nuevo;If AncestorReturnValue>0 then
	if g_colegio<>'COAATAVI' then
		dw_1.SetItem(dw_1.GetRow(),'n_registro',f_siguiente_numero('N_REG_LIBRO',10))
	end if
	dw_1.SetItem(dw_1.GetRow(),'id_libro',f_siguiente_numero('LIBROS',10))
	Dw_1.setitem(1, 'f_entrada', datetime(Today()) )
	dw_1.SetFocus()
end if

return AncestorReturnValue
end event

event csd_anterior;call super::csd_anterior;if g_dw_lista.rowcount() > 0 then
	g_libros_consulta.id_libro=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_libro')
	dw_1.Event csd_retrieve()
end if
end event

event csd_siguiente;call super::csd_siguiente;if g_dw_lista.rowcount() > 0 then
	g_libros_consulta.id_libro=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_libro')
	dw_1.Event csd_retrieve()
end if
end event

event csd_primero;call super::csd_primero;if not isvalid(g_dw_lista) then return
if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_libros_consulta.id_libro=g_dw_lista.GetItemString(1,'id_libro')
	dw_1.event csd_retrieve()
end if
end event

event csd_ultimo;call super::csd_ultimo;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
	
	g_libros_consulta.id_libro=g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_libro')
	
	dw_1.event csd_retrieve()
end if
end event

event pfc_preupdate;call super::pfc_preupdate;integer i
datetime fecha
string mensaje='', ubicacion=''
int n_registro

if f_puedo_escribir(g_usuario,'0000000016')=-1 then return -1

mensaje=mensaje + f_valida(dw_1,'titulo','NOVACIO','Debe especificar el t$$HEX1$$ed00$$ENDHEX$$tulo del libro')
mensaje=mensaje + f_valida(dw_1,'autor','NOVACIO','Debe especificar el nombre del autor del libro')
mensaje=mensaje + f_valida(dw_1,'numero','NOVACIO','Debe especificar un n$$HEX1$$fa00$$ENDHEX$$mero')
mensaje=mensaje + f_valida(dw_1,'f_entrada','NONULO','Debe especificar un valor en el campo fecha de entrada')
mensaje=mensaje + f_valida(dw_1,'materias','NOVACIO','Debe especificar un valor en el campo materias')
mensaje=mensaje + f_valida(dw_1,'edicion','NOVACIO','Debe especificar un valor en el campo edicion')
mensaje=mensaje + f_valida(dw_1,'anyo_publicacion','NOCERO','Debe especificar un valor en el campo anyo de publicaci$$HEX1$$f300$$ENDHEX$$n')
mensaje=mensaje + f_valida(dw_1,'editorial','NOVACIO','Debe especificar un valor en el campo editorial')

mensaje=mensaje + f_valida(idw_prestamos,'n_col','NOVACIO','Debe especificar un valor en el campo n$$HEX2$$ba002000$$ENDHEX$$de colegiado')
mensaje=mensaje + f_valida(idw_prestamos,'f_prestamo','NONULO','Debe especificar un valor en el campo fecha pr$$HEX1$$e900$$ENDHEX$$stamo')
mensaje=mensaje + f_valida(idw_prestamos,'f_devolucion_prevista','NONULO','Debe especificar un valor en el campo fecha devoluci$$HEX1$$f300$$ENDHEX$$n prevista')

int retorno=1

if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)

	retorno=-1

end if

if retorno<> -1 then
	//CAV-126 JESUS 01-07-2010
	if g_colegio='COAATAVI' then
		if f_es_vacio(dw_1.GetItemString(1,'n_registro')) then
			ubicacion=dw_1.GetItemString(1,'ubicacion')
			
			select MAX(n_registro) into :n_registro 
			from libros
			where ubicacion = :ubicacion;
		
			if f_es_vacio(String(n_registro)) then
				n_registro=0
			end if
		
			dw_1.SetItem( 1, 'n_registro', RightA('0000'+String(n_registro+1),5) )
			
			f_siguiente_numero('N_REG_LIBRO',5)
		end if
	end if
	//for i=1 to idw_prestamos.rowcount()
//		fecha=idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_devolucion_real')
//		
//			if isnull(fecha) then
//				dw_1.setitem(dw_1.getrow(),'prestado','S')
//			//	messagebox(G_TITULO,"Se realizo el pr$$HEX1$$e900$$ENDHEX$$stamo del libro exitosamente")
//			else 
//				dw_1.setitem(dw_1.getrow(),'prestado','N')
//				//messagebox(G_TITULO,"Se realizo la devoluci$$HEX1$$f300$$ENDHEX$$n del libro exitosamente")
//			end if
		
	//next
	
end if
return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_libros_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_libros_detalle
end type

type cb_nuevo from w_detalle`cb_nuevo within w_libros_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_libros_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_libros_detalle
end type

type cb_ant from w_detalle`cb_ant within w_libros_detalle
end type

type cb_sig from w_detalle`cb_sig within w_libros_detalle
end type

type dw_1 from w_detalle`dw_1 within w_libros_detalle
integer x = 9
integer y = 28
integer width = 3401
integer height = 916
string dataobject = "d_libros_detalle"
boolean border = false
end type

event dw_1::csd_retrieve;if g_libros_consulta.id_libro='' or isnull(g_libros_consulta.id_libro) then return
int retorno
retorno=Parent.event closequery()
if retorno=1 then return
this.retrieve(g_libros_consulta.id_libro)
g_libros_consulta.id_libro=''


//if isnull(idw_prestamos.object.f_devolucion_real) then
//	this.setitem(this.getrow(),'prestado','S')
//end if

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser_situacion
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_resumen'
		g_busqueda.titulo="Observaciones"
		obser_situacion = this.GetItemString(row, 'resumen')
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then this.SetItem(row,'resumen',obser_situacion)
		end if
	CASE 't_tipo_libro'		
		g_busqueda.titulo="Tipo de Libro"
		obser_situacion = this.GetItemString(row, 'tipo_libro')
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then this.SetItem(row,'tipo_libro',obser_situacion)
		end if		
END CHOOSE
end event

event dw_1::retrieveend;call super::retrieveend;f_resetupdate_dws(getactivesheet())
end event

event dw_1::buttonclicked;call super::buttonclicked;string n_reg
integer i
int    retorno
retorno = parent.event closequery()
if retorno = 1 then return
open(w_libros_duplicado)
if message.stringparm <> '' then
	n_reg=message.stringparm
	datastore ds_libro
	ds_libro = create datastore
	ds_libro.DataObject = 'd_libros_detalle'
	ds_libro.SetTransObject(SQLCA)
	ds_libro.InsertRow(0)
	ds_libro.SetItem(1,'id_libro',f_siguiente_numero('LIBROS',10))
	ds_libro.SetItem(1,'n_registro',n_reg)
	ds_libro.SetItem(1,'f_entrada',dw_1.getitemdatetime(1,'f_entrada'))
	ds_libro.SetItem(1,'titulo',dw_1.getitemstring(1,'titulo'))
	ds_libro.SetItem(1,'autor',dw_1.getitemstring(1,'autor'))
	ds_libro.SetItem(1,'titulo',dw_1.getitemstring(1,'titulo'))
	ds_libro.SetItem(1,'cdu',dw_1.getitemstring(1,'cdu'))
	ds_libro.SetItem(1,'materias',dw_1.getitemstring(1,'materias'))
	ds_libro.SetItem(1,'isbn',dw_1.getitemstring(1,'isbn'))
	ds_libro.SetItem(1,'edicion',dw_1.getitemstring(1,'edicion'))
	ds_libro.SetItem(1,'anyo_publicacion',dw_1.getitemnumber(1,'anyo_publicacion'))
	ds_libro.SetItem(1,'editorial',dw_1.getitemstring(1,'editorial'))
	ds_libro.SetItem(1,'resumen',dw_1.getitemstring(1,'resumen'))
	ds_libro.SetItem(1,'prestado',dw_1.getitemstring(1,'prestado'))
	ds_libro.SetItem(1,'coleccion',dw_1.getitemstring(1,'coleccion'))	

	ds_libro.SetItem(1,'tipo_libro',dw_1.getitemstring(1,'tipo_libro'))
	ds_libro.SetItem(1,'prestable',dw_1.getitemstring(1,'prestable'))
	ds_libro.SetItem(1,'numero',dw_1.getitemstring(1,'numero'))
	ds_libro.SetItem(1,'ubicacion',dw_1.getitemstring(1,'ubicacion'))
	ds_libro.SetItem(1,'encuadernacion',dw_1.getitemstring(1,'encuadernacion'))
	ds_libro.SetItem(1,'sig',dw_1.getitemstring(1,'sig'))
	ds_libro.SetItem(1,'isbn_13',dw_1.getitemstring(1,'isbn_13'))
	ds_libro.SetItem(1,'num_paginas',dw_1.getitemstring(1,'num_paginas'))
	
	g_libros_consulta.id_libro=ds_libro.getitemstring(1,'id_libro')
	ds_libro.update()
	destroy ds_libro
	event csd_retrieve()
	
end if


end event

type tab_1 from tab within w_libros_detalle
integer x = 32
integer y = 952
integer width = 3369
integer height = 880
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3333
integer height = 752
long backcolor = 79741120
string text = "Pr$$HEX1$$e900$$ENDHEX$$stamos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Properties!"
long picturemaskcolor = 536870912
dw_prestamos dw_prestamos
end type

on tabpage_1.create
this.dw_prestamos=create dw_prestamos
this.Control[]={this.dw_prestamos}
end on

on tabpage_1.destroy
destroy(this.dw_prestamos)
end on

type dw_prestamos from u_dw within tabpage_1
integer x = 9
integer y = 8
integer width = 3314
integer height = 828
integer taborder = 11
string dataobject = "d_libros_prestamo"
end type

event pfc_addrow;call super::pfc_addrow;integer prestado

this.SetItem(this.getRow(),'id_prestamo',f_siguiente_numero('PRESTAMOS',10))
//this.setitem(this.GetRow(),'f_prestamo', datetime(Today()) )


if isnull(this.object.f_devolucion_real) then dw_1.setitem(dw_1.getrow(),'prestado','S')

if dw_1.getitemstring(dw_1.getrow(),'prestado')='S' then
	this.event pfc_deleterow()
	prestado=messagebox(g_titulo_aplicacion,"El libro ya est$$HEX2$$e1002000$$ENDHEX$$prestado.")
end if

return 1

end event

event pfc_insertrow;call super::pfc_insertrow;this.SetItem(this.getRow(),'id_prestamo',f_siguiente_numero('PRESTAMOS',10))
//this.setitem(this.GetRow(),'f_prestamo', datetime(Today()) )

//if isnull(this.object.f_devolucion_real) then dw_1.setitem(dw_1.getrow(),'prestado','S')

integer prestado

if dw_1.getitemstring(dw_1.getrow(),'prestado')='S' then
	this.event pfc_deleterow()
	prestado=messagebox(g_titulo_aplicacion,"El libro ya est$$HEX2$$e1002000$$ENDHEX$$prestado.")
end if


return 1
end event

event itemchanged;call super::itemchanged;string  id_col, col
integer f
datetime fp, fpv

//choose case this.getcolumnname()
choose case dwo.name
	case 'n_col'
		// Se chequea que el codigo no este duplicado en la lista
		for f=1 to dw_prestamos.rowcount() 
			if dw_prestamos.getitemstring(f,'n_col')=data then 
				messagebox(g_titulo, 'Este N$$HEX1$$fa00$$ENDHEX$$mero de Colegiado ya existe en la lista')
				return no_action
			end if
		end for
		
		// se verifica que existe el colegiado en la tabla colegiados
		col=this.gettext()
		select id_colegiado into :id_col from colegiados where n_colegiado = :col;
		this.setitem(this.getrow(),'colegiado', id_col)
		
	case 'f_devolucion_prevista'
		fp = this.GetItemDatetime(this.GetRow(),'f_prestamo')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo.')
			return 1
		end if	
		
	case 'f_devolucion_real'
		fp = this.GetItemDatetime(this.GetRow(),'f_prestamo')
		if datetime(date(data)) < fp then
			messagebox(g_titulo,'La fecha de devoluci$$HEX1$$f300$$ENDHEX$$n real no puede ser anterior a la fecha de pr$$HEX1$$e900$$ENDHEX$$stamo.')
			return 1
		end if
		if isnull(data) and dw_1.getitemstring(1,'prestado') ='N' then
			dw_1.setitem(1,'prestado','S')
		end if
		
end choose
end event

event buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_colegiados()


if id_persona="-1" then
	this.deleterow(row)
else
	this.setitem(this.getrow(),'colegiado',id_persona)
	this.setitem(this.getrow(),'n_col',f_colegiado_n_col(id_persona))
//	this.setitem(this.getrow(),'tipo', f_colegiado_tipopersona(this.getitemstring(this.getrow(),'id_lista_miembro')))		
end if



	
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event doubleclicked;call super::doubleclicked;string obser_situacion
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser_situacion = this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser_situacion)
		if Message.Stringparm <> '-1' then
			obser_situacion = Message.Stringparm
			if not isnull(obser_situacion) then this.SetItem(row,'observaciones',obser_situacion)
		end if

END CHOOSE
end event

event retrieveend;call super::retrieveend;integer i
for i=1 to this.rowcount()
	this.setitem(i,'n_col', f_colegiado_n_col(this.getitemstring(i,'colegiado')))
	//this.setitem(i,'tipo', f_colegiado_tipopersona(this.getitemstring(i,'id_lista_miembro')))	
next	
this.ResetUpdate() 


end event

event itemerror;call super::itemerror;return 1
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;if dw_1.getitemstring(1,'prestable')='S' then
	am_dw.m_table.m_insert.enabled = true
	am_dw.m_table.m_addrow.enabled = true
	am_dw.m_table.m_delete.enabled = true
else
	am_dw.m_table.m_insert.enabled = false
	am_dw.m_table.m_addrow.enabled = false
	am_dw.m_table.m_delete.enabled = false
end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3333
integer height = 752
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$ricos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "Start!"
long picturemaskcolor = 536870912
dw_historico dw_historico
end type

on tabpage_2.create
this.dw_historico=create dw_historico
this.Control[]={this.dw_historico}
end on

on tabpage_2.destroy
destroy(this.dw_historico)
end on

type dw_historico from u_dw within tabpage_2
integer x = 18
integer y = 8
integer width = 3314
integer height = 828
integer taborder = 11
string dataobject = "d_libros_historico"
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;	am_dw.m_table.m_insert.enabled = false
	am_dw.m_table.m_addrow.enabled = false
	am_dw.m_table.m_delete.enabled = false
end event

event constructor;call super::constructor;//this.setitem(this.getrow(),'n_col',f_colegiado_n_col(id_persona))
end event

