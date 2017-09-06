HA$PBExportHeader$w_fases_expedientes_relacionados.srw
forward
global type w_fases_expedientes_relacionados from w_response
end type
type dw_1 from u_dw within w_fases_expedientes_relacionados
end type
type cb_1 from commandbutton within w_fases_expedientes_relacionados
end type
end forward

global type w_fases_expedientes_relacionados from w_response
integer x = 214
integer y = 221
integer width = 2779
string title = "Expedientes relacionados"
dw_1 dw_1
cb_1 cb_1
end type
global w_fases_expedientes_relacionados w_fases_expedientes_relacionados

type variables
string iid_expedi
end variables

on w_fases_expedientes_relacionados.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_fases_expedientes_relacionados.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;call super::open;f_centrar_ventana(this)
iid_expedi = message.stringparm
if f_es_vacio(iid_expedi) then return

if g_colegio = 'COAATMCA' then
	dw_1.dataobject = 'd_fases_expedientes_relacionados_mca'
	dw_1.settransobject(SQLCA)
end if

dw_1.retrieve(iid_expedi)
end event

event type integer pfc_preupdate();call super::pfc_preupdate;// Validar que las l$$HEX1$$ed00$$ENDHEX$$neas tengan id_expedi_relac
string mensaje = ''
int retorno = 1
mensaje+= f_valida(dw_1,'id_expedi_relac','NOVACIO','Debe especificar un n$$HEX1$$fa00$$ENDHEX$$mero de expediente que exista.')

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if
return retorno
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_expedientes_relacionados
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_expedientes_relacionados
end type

type dw_1 from u_dw within w_fases_expedientes_relacionados
integer x = 37
integer y = 76
integer width = 2693
integer height = 1152
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_expedientes_relacionados"
end type

event doubleclicked;call super::doubleclicked;string obser
CHOOSE CASE dwo.name
	// MODIFICADO RICARDO 04-06-11
	CASE 'n_expedi'
		// Al hacer un doble click abriremos la ventana de detalle, para que puedan seleccionar desde all$$HEX2$$ed002000$$ENDHEX$$el contrato que deseen
		if row < 1 or row > this.rowCount() then return
		string id_expedi
		// MODIFICADO RICARDO 04-07-22          
		id_expedi = this.getitemstring(row,'id_expedi')
		// Si es igual al de entrada es el otro el que se quiere ver
		if id_expedi = iid_expedi then id_expedi = this.getitemstring(row,'id_expedi_relac')
		// FIN MODIFICADO RICARDO 04-07-22
		closewithreturn(parent, id_expedi)
	// FIN MODIFICADO RICARDO 04-06-11
	CASE 'observaciones'
		g_busqueda.titulo="Observaciones"
		obser    =this.GetItemString(row, 'observaciones')
		openwithparm(w_observaciones, obser)
		if Message.Stringparm = '-1' then return
		obser = Message.Stringparm
		if not f_es_vacio(obser) then dw_1.SetItem(row,'observaciones',obser)
END CHOOSE

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'n_expedi'
		string id_expedi, titulo
		datetime f_inicio
		select id_expedi, f_inicio, titulo into :id_expedi, :f_inicio, :titulo from expedientes where n_expedi = :data;
		if f_es_vacio(id_expedi) then 
			messagebox(g_titulo, 'El expediente no existe')
			return 2
		else
			dw_1.setitem(row, 'id_expedi_relac', id_expedi)
			dw_1.setitem(row, 'f_inicio', f_inicio)
			dw_1.setitem(row, 'titulo', titulo)
		end if
		
end choose
end event

event type long pfc_addrow();call super::pfc_addrow;if ancestorreturnvalue <= 0 then return ancestorreturnvalue
dw_1.setitem(ancestorreturnvalue, 'id_expedi', iid_expedi)
return ancestorreturnvalue
end event

event type long pfc_insertrow();call super::pfc_insertrow;if ancestorreturnvalue <= 0 then return ancestorreturnvalue
dw_1.setitem(ancestorreturnvalue, 'id_expedi', iid_expedi)
return ancestorreturnvalue
end event

event retrieveend;call super::retrieveend;double i
string id_expedi, id_expedi_relac
string n_expedi, titulo, n_visado
datetime f_inicio
for i = 1 to dw_1.rowcount()
	id_expedi = dw_1.getitemstring(i, 'id_expedi')
	id_expedi_relac = dw_1.getitemstring(i, 'id_expedi_relac')
	
	if iid_expedi = id_expedi then id_expedi = id_expedi_relac
	
	select n_expedi,f_inicio,titulo into :n_expedi, :f_inicio, :titulo
	from expedientes 
	where id_expedi = :id_expedi;
	
	dw_1.setitem(i, 'n_expedi', n_expedi)
	dw_1.setitem(i, 'f_inicio', f_inicio)
	dw_1.setitem(i, 'titulo', titulo)	
	
	select archivo into :n_visado from fases where id_expedi = :id_expedi;
	
	if g_colegio = 'COAATMCA' then dw_1.setitem(i, 'n_visado', n_visado)	
next
dw_1.event pfc_resetupdate()
end event

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'buscar_fase'
		
end choose
end event

type cb_1 from commandbutton within w_fases_expedientes_relacionados
integer x = 2331
integer y = 1252
integer width = 402
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

