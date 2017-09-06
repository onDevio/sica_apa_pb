HA$PBExportHeader$w_aparatos_tecnicos_detalle.srw
forward
global type w_aparatos_tecnicos_detalle from w_detalle
end type
type tab_1 from tab within w_aparatos_tecnicos_detalle
end type
type tabpage_1 from userobject within tab_1
end type
type dw_prestamos from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_prestamos dw_prestamos
end type
type tab_1 from tab within w_aparatos_tecnicos_detalle
tabpage_1 tabpage_1
end type
end forward

global type w_aparatos_tecnicos_detalle from w_detalle
integer width = 3465
integer height = 2012
string title = "Detalle de Aparatos T$$HEX1$$e900$$ENDHEX$$cnicos"
tab_1 tab_1
end type
global w_aparatos_tecnicos_detalle w_aparatos_tecnicos_detalle

type variables
u_dw idw_prestamos
end variables

on w_aparatos_tecnicos_detalle.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_aparatos_tecnicos_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event activate;call super::activate;g_dw_lista 	= g_dw_lista_aparatos_tecnicos
g_w_lista 	= g_lista_aparatos_tecnicos
g_w_detalle = g_detalle_aparatos_tecnicos
g_lista 		= 'w_aparatos_tecnicos_lista'
g_detalle 	= 'w_aparatos_tecnicos_detalle'
end event

event type integer csd_nuevo();call super::csd_nuevo;If AncestorReturnValue>0 then
	dw_1.SetItem(dw_1.GetRow(),'n_equipo',f_siguiente_numero('N_EQUIPO_APARATO',10))
	dw_1.SetItem(dw_1.GetRow(),'id_aparato',f_siguiente_numero('APARATOS_TECNICOS',10))
	Dw_1.setitem(1, 'f_entrada', datetime(Today()) )
	dw_1.SetFocus()
end if

return AncestorReturnValue

end event

event csd_anterior();call super::csd_anterior;if g_dw_lista.rowcount() > 0 then
	g_aparatos_tecnicos_consulta.id_aparato=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_aparato')
	dw_1.Event csd_retrieve()
end if
end event

event csd_primero();call super::csd_primero;if not isvalid(g_dw_lista) then return
if g_dw_lista.RowCount() > 0 then
	g_dw_lista.SetRow(1)
	g_dw_lista.ScrollToRow(1)
	g_aparatos_tecnicos_consulta.id_aparato=g_dw_lista.GetItemString(1,'id_aparato')
	dw_1.event csd_retrieve()
end if
end event

event csd_siguiente();call super::csd_siguiente;if g_dw_lista.rowcount() > 0 then
	g_aparatos_tecnicos_consulta.id_aparato=g_dw_lista.GetItemString(g_dw_lista.GetRow(),'id_aparato')
	dw_1.Event csd_retrieve()
end if
end event

event csd_ultimo();call super::csd_ultimo;if not isvalid(g_dw_lista) then return

if g_dw_lista.RowCount()>0 then
	g_dw_lista.SetRow(g_dw_lista.RowCount())
	g_dw_lista.ScrollToRow(g_dw_lista.RowCount())
	
	g_aparatos_tecnicos_consulta.id_aparato=g_dw_lista.GetItemString(g_dw_lista.RowCount(),'id_aparato')
	
	dw_1.event csd_retrieve()
end if
end event

event open;call super::open;idw_prestamos=tab_1.tabpage_1.dw_prestamos
f_enlaza_dw(dw_1,idw_prestamos,'id_aparato','id_aparato')

inv_resize.of_register (tab_1, "scaletoright&bottom")
inv_resize.of_register (tab_1.tabpage_1, "scaletoright&bottom")
inv_resize.of_Register (idw_prestamos, "scaletoright&bottom")

end event

event type integer pfc_preupdate();call super::pfc_preupdate;int i, retorno=1
datetime fecha
string mensaje=''

for i=1 to idw_prestamos.rowcount()
	fecha=idw_prestamos.getitemdatetime(idw_prestamos.getrow(),'f_devolucion_real')
	if isnull(fecha) then
		dw_1.setitem(dw_1.getrow(),'prestado','S')
	else 
		dw_1.setitem(dw_1.getrow(),'prestado','N')
	end if
next

mensaje=mensaje + f_valida(dw_1,'descripcion','NOVACIO','Debe especificar la descripci$$HEX1$$f300$$ENDHEX$$n del aparato')
mensaje=mensaje + f_valida(dw_1,'n_equipo','NOVACIO','Debe especificar un n$$HEX1$$fa00$$ENDHEX$$mero de equipo')
mensaje=mensaje + f_valida(dw_1,'f_entrada','NONULO','Debe especificar un valor en el campo fecha de entrada')


if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)
	retorno=-1
end if

return retorno

end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_aparatos_tecnicos_detalle
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_aparatos_tecnicos_detalle
integer taborder = 20
end type

type cb_nuevo from w_detalle`cb_nuevo within w_aparatos_tecnicos_detalle
integer taborder = 40
end type

type cb_ayuda from w_detalle`cb_ayuda within w_aparatos_tecnicos_detalle
integer taborder = 80
end type

type cb_grabar from w_detalle`cb_grabar within w_aparatos_tecnicos_detalle
integer taborder = 50
end type

type cb_ant from w_detalle`cb_ant within w_aparatos_tecnicos_detalle
integer taborder = 60
end type

type cb_sig from w_detalle`cb_sig within w_aparatos_tecnicos_detalle
integer taborder = 70
end type

type dw_1 from w_detalle`dw_1 within w_aparatos_tecnicos_detalle
integer x = 37
integer y = 32
integer width = 2798
integer height = 652
integer taborder = 30
string dataobject = "d_aparatos_tecnicos_detalle"
boolean border = false
borderstyle borderstyle = StyleLowered!
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_retrieve();call super::csd_retrieve;if g_aparatos_tecnicos_consulta.id_aparato='' or isnull(g_aparatos_tecnicos_consulta.id_aparato) then return
int retorno
retorno=Parent.event closequery()
if retorno=1 then return
this.retrieve(g_aparatos_tecnicos_consulta.id_aparato)
g_aparatos_tecnicos_consulta.id_aparato=''

end event

event dw_1::doubleclicked;call super::doubleclicked;string obser
g_busqueda.solo_despliega_texto=False

CHOOSE CASE dwo.name
	CASE 't_observaciones'
		g_busqueda.titulo="Observaciones"
		obser = this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm <> '-1' then
			obser = Message.Stringparm
			if not isnull(obser) then this.SetItem(row,'observaciones',obser)
		end if
END CHOOSE

end event

type tab_1 from tab within w_aparatos_tecnicos_detalle
integer x = 37
integer y = 800
integer width = 3369
integer height = 972
integer taborder = 90
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
integer y = 112
integer width = 3333
integer height = 844
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
integer x = 23
integer y = 24
integer width = 3273
integer height = 788
integer taborder = 10
string dataobject = "d_aparatos_tecnicos_prestamo"
end type

event buttonclicked;call super::buttonclicked;string id_persona

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
g_busqueda.dw="d_lista_busqueda_colegiados"
id_persona=f_busqueda_colegiados()
//this.setitem(this.getrow(),'id_col_per',id_persona)

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

event itemchanged;call super::itemchanged;string  id_col, col
integer f
datetime fp, fpv

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
		
end choose

end event

event itemerror;call super::itemerror;return 1
end event

event retrieveend;call super::retrieveend;integer i
for i=1 to this.rowcount()
	this.setitem(i,'n_col', f_colegiado_n_col(this.getitemstring(i,'colegiado')))
	//this.setitem(i,'tipo', f_colegiado_tipopersona(this.getitemstring(i,'id_lista_miembro')))	
next	
this.ResetUpdate() 

end event

event type long pfc_insertrow();call super::pfc_insertrow;this.SetItem(this.getRow(),'id_prestamo',f_siguiente_numero('PRESTAMOS',10))
this.setitem(this.GetRow(),'f_prestamo', datetime(Today()) )
this.setitem(this.GetRow(),'id_libro', 'X') // El campo no puede tener valor nulo

if isnull(this.object.f_devolucion_real) then dw_1.setitem(dw_1.getrow(),'prestado','S')

integer prestado

if dw_1.getitemstring(dw_1.getrow(),'prestado')='S' then
	this.event pfc_deleterow()
	prestado=messagebox(g_titulo_aplicacion,"El aparato ya est$$HEX2$$e1002000$$ENDHEX$$prestado.")
end if


return 1
end event

event type long pfc_addrow();call super::pfc_addrow;integer prestado

this.SetItem(this.getRow(),'id_prestamo',f_siguiente_numero('PRESTAMOS',10))
this.setitem(this.GetRow(),'f_prestamo', datetime(Today()))
this.setitem(this.GetRow(),'id_libro', 'X') // El campo no puede tener valor nulo


if isnull(this.object.f_devolucion_real) then dw_1.setitem(dw_1.getrow(),'prestado','S')

if dw_1.getitemstring(dw_1.getrow(),'prestado')='S' then
	this.event pfc_deleterow()
	prestado=messagebox(g_titulo_aplicacion,"El aparato ya est$$HEX2$$e1002000$$ENDHEX$$prestado.")
end if

return 1

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

