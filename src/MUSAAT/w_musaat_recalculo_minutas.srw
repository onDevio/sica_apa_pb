HA$PBExportHeader$w_musaat_recalculo_minutas.srw
forward
global type w_musaat_recalculo_minutas from w_sheet
end type
type cb_listado from commandbutton within w_musaat_recalculo_minutas
end type
type cb_procesar from commandbutton within w_musaat_recalculo_minutas
end type
type st_proceso from statictext within w_musaat_recalculo_minutas
end type
type dw_consulta from u_dw within w_musaat_recalculo_minutas
end type
type cb_grabar from commandbutton within w_musaat_recalculo_minutas
end type
type tab_1 from tab within w_musaat_recalculo_minutas
end type
type tabpage_1 from userobject within tab_1
end type
type dw_3 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within w_musaat_recalculo_minutas
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_1 from u_dw within w_musaat_recalculo_minutas
end type
type st_1 from statictext within w_musaat_recalculo_minutas
end type
end forward

global type w_musaat_recalculo_minutas from w_sheet
integer width = 3703
integer height = 1772
string title = "Rec$$HEX1$$e100$$ENDHEX$$lculo de Musaat"
string menuname = "m_conceptos_domiciliables_lr"
windowstate windowstate = maximized!
event csd_preparar_consulta ( )
event csd_guardar_pantalla ( )
event csd_recuperar_pantalla ( )
cb_listado cb_listado
cb_procesar cb_procesar
st_proceso st_proceso
dw_consulta dw_consulta
cb_grabar cb_grabar
tab_1 tab_1
dw_1 dw_1
st_1 st_1
end type
global w_musaat_recalculo_minutas w_musaat_recalculo_minutas

type variables
string is_sql_consulta = ''
datastore ids_datos_consulta
string is_consulta = ''
end variables

forward prototypes
public function integer wf_guarda_dw (datawindow dw_actual, string id_consulta)
end prototypes

event csd_preparar_consulta();// Colocamos una linea en la consulta
dw_consulta.reset()
dw_consulta.insertrow(0)
end event

event csd_guardar_pantalla();int i,t,j,fila,cuantos,k,sobreescribir
double num_columnas
string ventana, dw, columna,valor,clase,valor_columna_string
string nombre_consulta,id_consulta,ruta
tab tab_actual
userobject tabpage_actual
datawindow dw_actual
datastore ds_consulta
SetPointer(HourGlass!)

ds_consulta = create datastore
ds_consulta.dataobject = 'd_consultas_grabacion'
ds_consulta.SetTransObject(SQLCA)

ids_datos_consulta = create datastore
ids_datos_consulta.dataobject = 'd_consultas_datos'
ids_datos_consulta.SetTransObject(SQLCA)

ventana = this.classname()
if f_es_vacio(is_consulta) then
	Open(w_listas_nombre_lista)
	nombre_consulta = Message.Stringparm
else
	nombre_consulta = is_consulta
end if

//No hemos puesto ning$$HEX1$$fa00$$ENDHEX$$n nombre o hemos pulsado 'Cancelar'
if f_es_vacio(nombre_consulta) then return
//La lista ya EXISTE
select count(*) into :cuantos from consultas where descripcion=:nombre_consulta and ventana = :ventana;

if cuantos>0 then
	sobreescribir = 1
	if f_es_vacio(is_consulta)then 
		sobreescribir = Messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.lista_existe_sobreescribir','La lista especificada ya existe actualmente,$$HEX1$$bf00$$ENDHEX$$desea sobreescribirla?'),StopSign!,YesNo!)
		if sobreescribir = 2 then return
	end if
	select id_consulta into :id_consulta from consultas where descripcion=:nombre_consulta and ventana = :ventana;
	delete from consultas where id_consulta = :id_consulta;
	delete from consultas_datos where id_consulta = :id_consulta;
end if

//Creamos la entrada en la tabla consultas
fila = ds_consulta.InsertRow(0)
id_consulta = f_siguiente_numero('CONSULTAS',10)
ds_consulta.SetItem(fila,'id_consulta',id_consulta)
ds_consulta.SetItem(fila,'descripcion',nombre_consulta)
ds_consulta.SetItem(fila,'ventana',ventana)
ds_consulta.SetItem(fila,'fecha',datetime(Today()))
ds_consulta.SetItem(fila,'usuario',g_usuario)


//Guardamos el dw de pantalla
wf_guarda_dw(dw_consulta,id_consulta)

ds_consulta.Update()
ids_datos_consulta.Update()

SetPointer(Arrow!)
destroy ds_consulta			
destroy ids_datos_consulta

end event

event csd_recuperar_pantalla();// No utilizamos los procedimientos genericos porque el dw de abajo no tiene que ser almacenado

datastore ds_datos_consulta
string ventana, id_consulta, dw, valor_string, tipo_columna, nombre_columna
long i, col, fila
double valor_double
datetime valor_datetime
boolean b_fechas_alta =false
boolean b_fechas_colegiacion = false
dwobject dwo

SetPointer(HourGlass!)
ds_datos_consulta = create datastore
ds_datos_consulta.dataobject = 'd_consultas_datos'
ds_datos_consulta.SetTransObject(SQLCA)

ventana = this.classname()

OpenWithParm(w_consulta_seleccion,ventana) 
id_consulta = Message.StringParm

if f_es_vacio(id_consulta) then return

// VAciamos los datos anteriores de la consulta
dw_consulta.resetupdate()

//obtenemos la consulta realizada anteriormente
ds_datos_consulta.Retrieve(id_consulta)

// Colocamos la consulta en el valor correspondiente
for i= 1 to ds_datos_consulta.RowCount()
	dw = ds_datos_consulta.GetItemString(i,'datawindow')
	col = ds_datos_consulta.GetItemNumber(i,'columna')
	valor_double  = ds_datos_consulta.GetItemNumber(i,'valor_double')
	valor_datetime= ds_datos_consulta.GetItemDatetime(i,'valor_datetime')
	valor_string	= ds_datos_consulta.GetItemString(i,'valor_string')
	fila = ds_datos_consulta.GetItemNumber(i,'fila')
	
	
	tipo_columna = dw_consulta.Describe('#'+string(col)+'.ColType')
	nombre_columna = dw_consulta.Describe('#'+string(col)+'.Name')
	if dw_consulta.rowcount()<fila then dw_consulta.InsertRow(0)
	choose case tipo_columna
		case 'datetime'
			dw_consulta.SetItem(fila,col,valor_datetime)
		case 'number'
			dw_consulta.SetItem(fila,col,valor_double)
		case else
			dw_consulta.SetItem(fila,col,valor_string)
	end choose
	if (nombre_columna = 'anyo_actual_colegiacion' and valor_string = 'S') then b_fechas_colegiacion = true
	if (nombre_columna = 'anyo_actual_alta' and valor_string = 'S') then b_fechas_alta = true
next

// Lanzamos el itemchanged para que se refresquen las fechas
if b_fechas_alta then
	dwo = dw_consulta.object.anyo_actual_alta
	dw_consulta.trigger event itemchanged(1, dwo, 'S')
end if
if b_fechas_colegiacion then
	dwo = dw_consulta.object.anyo_actual_colegiacion
	dw_consulta.trigger event itemchanged(1, dwo, 'S')
end if


	
SetPointer(Arrow!)	

destroy ds_datos_consulta
end event

public function integer wf_guarda_dw (datawindow dw_actual, string id_consulta);int t,j,num_columnas,fila
string dw,valor_columna_string,desc_columna,tipo_columna
datetime valor_columna_datetime
double  valor_columna_double


dw_actual.AcceptText()
dw = dw_actual.ClassName()

//Recorremos todas las columnas del dw
num_columnas = double(dw_actual.Object.Datawindow.Column.Count)
//Recorremos todas las l$$HEX1$$ed00$$ENDHEX$$neas del dw
for t=1 to dw_actual.Rowcount()
	//Recorremos todos los valores
	for j=1 to num_columnas
		desc_columna = dw_actual.Describe('#'+string(j)+'.Name ')
		tipo_columna = dw_actual.Describe('#'+string(j)+'.ColType')
		if (LeftA(tipo_columna,7)='decimal') or tipo_columna ='double' or tipo_columna ='int'  then tipo_columna = 'number'
		choose case tipo_columna
			case 'datetime'
				valor_columna_datetime = dw_actual.GetItemDatetime(t,j)
				setnull(valor_columna_double)
				setnull(valor_columna_string)
				if isnull(valor_columna_datetime) then continue
			case 'number'
				valor_columna_double = dw_actual.GetItemNumber(t,j)
				setnull(valor_columna_datetime)
				setnull(valor_columna_string)
				if isnull(valor_columna_double) then continue
			case else
				valor_columna_string =dw_actual.GetItemString(t,j)
				setnull(valor_columna_double)
				setnull(valor_columna_datetime)
				if f_es_vacio(valor_columna_string) then continue
		end choose
		//Insertamos los valores en la tabla consulta
		fila = ids_datos_consulta.InsertRow(0)
		ids_datos_consulta.SetItem(fila,'id_consulta_datos',f_siguiente_numero('CONSULTAS_DATOS',10))
		ids_datos_consulta.SetItem(fila,'id_consulta',id_consulta)
		ids_datos_consulta.SetItem(fila,'datawindow',dw)
		ids_datos_consulta.SetItem(fila,'columna',j)
		ids_datos_consulta.SetItem(fila,'fila',t)
		ids_datos_consulta.SetItem(fila,'valor_datetime',valor_columna_datetime)
		ids_datos_consulta.SetItem(fila,'valor_double',valor_columna_double)
		ids_datos_consulta.SetItem(fila,'valor_string',valor_columna_string)
	next				
next


return 1







end function

on w_musaat_recalculo_minutas.create
int iCurrent
call super::create
if this.MenuName = "m_conceptos_domiciliables_lr" then this.MenuID = create m_conceptos_domiciliables_lr
this.cb_listado=create cb_listado
this.cb_procesar=create cb_procesar
this.st_proceso=create st_proceso
this.dw_consulta=create dw_consulta
this.cb_grabar=create cb_grabar
this.tab_1=create tab_1
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_listado
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_proceso
this.Control[iCurrent+4]=this.dw_consulta
this.Control[iCurrent+5]=this.cb_grabar
this.Control[iCurrent+6]=this.tab_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_1
end on

on w_musaat_recalculo_minutas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_listado)
destroy(this.cb_procesar)
destroy(this.st_proceso)
destroy(this.dw_consulta)
destroy(this.cb_grabar)
destroy(this.tab_1)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;call super::open;of_SetResize (true)
//inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_1.tabpage_1, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_1.tabpage_1.dw_3, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_1.tabpage_2, "ScaletoRight&Bottom")
inv_resize.of_Register (tab_1.tabpage_2.dw_2, "ScaletoRight&Bottom")

if g_colegio = 'COAATNA' then
	tab_1.tabpage_2.dw_2.dataobject = 'd_musaat_recalculo_minutas_detalle_na'
	tab_1.tabpage_2.dw_2.settransobject(sqlca)
end if

string id_col

id_col = message.stringparm

f_centrar_ventana(this)

dw_consulta.insertrow(0)

// Se ha modificado la cobertura o el coef. sin. del colegiado, abrimos la ventana para el rec$$HEX1$$e100$$ENDHEX$$lculo de los avisos
if id_col<>'' then
	dw_consulta.setitem(1, 'id_colegiado', id_col)
	dw_consulta.setitem(1, 'n_colegiado', f_colegiado_n_col(id_col))
	dw_consulta.setitem(1, 'f_desde', datetime(date('01/01/1900')))
	dw_consulta.setitem(1, 'f_hasta', datetime(today()))
	cb_procesar.event clicked()
	if tab_1.tabpage_2.dw_2.rowcount()=0 then close(this) // Si no tiene avisos pendientes no la mostramos
end if

end event

event pfc_postopen;call super::pfc_postopen;dw_consulta.of_SetDropDownCalendar(True)
dw_consulta.iuo_calendar.of_register(dw_consulta.iuo_calendar.DDLB)
dw_consulta.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_consulta.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_musaat_recalculo_minutas
string tag = "texto=general.recuperar_pantalla"
integer x = 2619
integer y = 404
integer width = 425
integer height = 92
end type

event cb_recuperar_pantalla::clicked;parent.trigger event csd_preparar_consulta()
parent.trigger event csd_recuperar_pantalla()
end event

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_musaat_recalculo_minutas
string tag = "texto=general.guardar_pantalla"
integer x = 2619
integer y = 312
integer width = 425
integer height = 92
end type

event cb_guardar_pantalla::clicked;parent.trigger event csd_guardar_pantalla()
end event

type cb_listado from commandbutton within w_musaat_recalculo_minutas
string tag = "texto=general.listado"
integer x = 2725
integer y = 32
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Listado"
end type

event clicked;if tab_1.tabpage_2.dw_2.rowcount() > 0 then tab_1.tabpage_2.dw_2.print()
if tab_1.tabpage_1.dw_3.rowcount() > 0 then tab_1.tabpage_1.dw_3.print()

end event

type cb_procesar from commandbutton within w_musaat_recalculo_minutas
event csd_recalcular_proformas ( )
string tag = "texto=general.recalcular"
integer x = 2373
integer y = 32
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Recalcular"
end type

event csd_recalcular_proformas();string sql_nuevo, sql_original, id_col, n_col
long fila
datetime f_desde, f_hasta
st_musaat_datos st_musaat

dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = dw_consulta.getitemdatetime(1, 'f_hasta')

//if f_es_vacio(string(f_desde)) or f_es_vacio(string(f_hasta)) then 
//	MessageBox(g_titulo, g_idioma.of_getmsg('msg_musaat.indicar_fechas_consulta',"Debe indicar las fechas de consulta"), stopsign!)
//	return
//end if

// Cogemos la sql
sql_nuevo = tab_1.tabpage_1.dw_3.describe("datawindow.table.select")
sql_original = sql_nuevo

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')

n_col = dw_consulta.getitemstring(1, 'n_colegiado')
if n_col <> '' then
	id_col = f_colegiado_id_col(n_col)
	f_sql('musaat_params_linea_fe.id_col','=','id_colegiado',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
end if

// Colocamos otra vez la sql
tab_1.tabpage_1.dw_3.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
st_proceso.visible = true
tab_1.tabpage_1.dw_3.retrieve()

// Colocamos la sql original
tab_1.tabpage_1.dw_3.modify("datawindow.table.select= ~"" + sql_original + "~"")

// Recalculamos el importe de musaat
FOR fila = 1 TO tab_1.tabpage_1.dw_3.RowCount()
	st_proceso.text = "Procesando... " + " "+string(fila) + " de "+string(tab_1.tabpage_1.dw_3.RowCount())
	
	id_col = tab_1.tabpage_1.dw_3.getitemstring(fila, 'id_colegiado')
	
	st_musaat.recuperar = true
	st_musaat.n_visado = tab_1.tabpage_1.dw_3.getitemstring(fila, 'id_fase')
	st_musaat.id_col = id_col
	st_musaat.cod_colegio = tab_1.tabpage_1.dw_3.getitemstring(fila, 'cod_colegio_dest')
	st_musaat.tipo_csd = tab_1.tabpage_1.dw_3.getitemstring(fila, 'tipo_csd')	
	st_musaat.cobertura = 0  // Si no coge la cobertura del colegiado anterior
	st_musaat.porcentaje = 0 // Si no coge el porcentaje del colegiado anterior
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		f_musaat_calcula_prima_sociedad(st_musaat)
	else
		f_musaat_calcula_prima(st_musaat)
	end if		
	
	tab_1.tabpage_1.dw_3.Setitem(fila, 'importe_nuevo', st_musaat.prima_comp)
NEXT

st_proceso.visible = false

end event

event clicked;string sql_nuevo, sql_original, id_col, n_col
long fila
datetime f_desde, f_hasta
st_musaat_datos st_musaat

dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = dw_consulta.getitemdatetime(1, 'f_hasta')

if f_es_vacio(string(f_desde)) or f_es_vacio(string(f_hasta)) then 
	MessageBox(g_titulo, g_idioma.of_getmsg('msg_musaat.indicar_fechas_consulta',"Debe indicar las fechas de consulta"), stopsign!)
	return
end if

if (MessageBox(g_titulo, "A partir de 2015, el importe de la prima complementaria pasa a ser 0. Por lo tanto, si contn$$HEX1$$fa00$$ENDHEX$$a, el importe de Musaat calculado previamente pasar$$HEX2$$e1002000$$ENDHEX$$a ser 0." + CR + "$$HEX1$$bf00$$ENDHEX$$Desea continuar?" , Question!, YesNo!, 2) = 2) then return -1 

// Cogemos la sql
sql_nuevo = tab_1.tabpage_2.dw_2.describe("datawindow.table.select")
sql_original = sql_nuevo

f_sql('fecha','>=','f_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha','<','f_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')

n_col = dw_consulta.getitemstring(1, 'n_colegiado')
if n_col <> '' then
	id_col = f_colegiado_id_col(n_col)
	f_sql('fases_minutas.id_colegiado','=','id_colegiado',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
end if

// Colocamos otra vez la sql
tab_1.tabpage_2.dw_2.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
st_proceso.visible = true
tab_1.tabpage_2.dw_2.retrieve()

// Colocamos la sql original
tab_1.tabpage_2.dw_2.modify("datawindow.table.select= ~"" + sql_original + "~"")

// Recalculamos el importe de musaat
FOR fila = 1 TO tab_1.tabpage_2.dw_2.RowCount()
	st_proceso.text = "Procesando... " + " "+string(fila) + " de "+string(tab_1.tabpage_2.dw_2.RowCount())
	
	id_col = tab_1.tabpage_2.dw_2.getitemstring(fila, 'id_colegiado')
	
	st_musaat.recuperar = true
	st_musaat.n_visado = tab_1.tabpage_2.dw_2.getitemstring(fila, 'id_fase')
	st_musaat.id_col = id_col
	st_musaat.tipo_csd = tab_1.tabpage_2.dw_2.getitemstring(fila, 'tipo_minuta')	
	st_musaat.cobertura = 0  // Si no coge la cobertura del colegiado anterior
	st_musaat.porcentaje = 0 // Si no coge el porcentaje del colegiado anterior
	
	if f_colegiado_tipopersona(id_col) = 'S' then
		f_musaat_calcula_prima_sociedad(st_musaat)
	else
		f_musaat_calcula_prima(st_musaat)
	end if		
	
	tab_1.tabpage_2.dw_2.Setitem(fila, 'importe_nuevo', st_musaat.prima_comp)
NEXT
event csd_recalcular_proformas()

st_proceso.visible = false

end event

type st_proceso from statictext within w_musaat_recalculo_minutas
string tag = "texto=general.procesando"
integer x = 37
integer y = 1464
integer width = 1234
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Procesando ...."
boolean focusrectangle = false
end type

event constructor;st_proceso.visible = false
end event

type dw_consulta from u_dw within w_musaat_recalculo_minutas
integer x = 37
integer y = 32
integer width = 1824
integer height = 232
integer taborder = 10
string dataobject = "d_musaat_recalculo_minutas_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string id_col

this.AcceptText()

CHOOSE CASE dwo.name
	CASE 'b_busq'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()   
		if NOT f_es_vacio(id_col) then 
			this.setitem(1,'id_colegiado', id_col)
			this.setitem(1,'n_colegiado', f_colegiado_n_col(id_col))
		end if
END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(1,'id_colegiado', id_col)
END CHOOSE

end event

type cb_grabar from commandbutton within w_musaat_recalculo_minutas
event csd_actualiza_proformas ( )
string tag = "texto=general.actualizar"
integer x = 3077
integer y = 32
integer width = 352
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar"
end type

event csd_actualiza_proformas();if tab_1.tabpage_1.dw_3.rowcount() <= 0 then return

datastore ds_fases_informes, ds_lineas_fact_emitidas, ds_musaat_param_lineas_fe
long ll_fila, fila_insertada,fila_musaat, j, i
double musaat_ant= 0, total_ant= 0, musaat, total_nuevo= 0, musaat_old=0
string id_col, id_fase_ant, id_factura, id_musaat

id_fase_ant = 'zz'

ds_fases_informes=create datastore
ds_fases_informes.dataobject='d_fases_informes'
ds_fases_informes.settransobject(sqlca)

ds_lineas_fact_emitidas=create datastore
ds_lineas_fact_emitidas.dataobject='d_lineas_fact_emitidas'
ds_lineas_fact_emitidas.settransobject(sqlca)


ds_musaat_param_lineas_fe=create datastore
ds_musaat_param_lineas_fe.dataobject='ds_musaat_params_linea_fe'
ds_musaat_param_lineas_fe.settransobject(sqlca)

// Actualizamos el importe de musaat con el nuevo si son diferentes
for i = 1 to tab_1.tabpage_1.dw_3.rowcount()
	
	if tab_1.tabpage_1.dw_3.getitemnumber(i, 'total') <> tab_1.tabpage_1.dw_3.getitemnumber(i, 'importe_nuevo') then

		double dif, total, total_col
		dif = tab_1.tabpage_1.dw_3.getitemnumber(i, 'importe_nuevo') - tab_1.tabpage_1.dw_3.getitemnumber(i, 'total')
		
		if tab_1.tabpage_1.dw_3.getitemstring(i, 'id_fase') = id_fase_ant then
			total_ant = tab_1.tabpage_1.dw_3.getitemnumber(i, 'importe_nuevo')
		end if
		id_fase_ant = tab_1.tabpage_1.dw_3.getitemstring(i, 'id_fase')
		total_nuevo = tab_1.tabpage_1.dw_3.getitemnumber(i, 'importe_nuevo') 
		total = tab_1.tabpage_1.dw_3.getitemnumber(i, 'total')
		
		tab_1.tabpage_1.dw_3.setitem(i, 'base_imp', total_nuevo)
		tab_1.tabpage_1.dw_3.setitem(i, 'subtotal', total_nuevo )
		tab_1.tabpage_1.dw_3.setitem(i, 'total_fact', total_nuevo )
		
		id_factura =  tab_1.tabpage_1.dw_3.getitemstring(i, 'id_factura')
		//Se actualiza la linea de la proforma
		ds_lineas_fact_emitidas.retrieve(id_factura)
		ll_fila = ds_lineas_fact_emitidas.Find(" id_linea = '" + tab_1.tabpage_1.dw_3.getitemstring(i, 'id_linea') + "'",0,ds_lineas_fact_emitidas.RowCount())
		if ll_fila > 0 Then 
			ds_lineas_fact_emitidas.setitem(ll_fila, 'precio',total_nuevo) 
			ds_lineas_fact_emitidas.setitem(ll_fila, 'total',total_nuevo) 
			ds_lineas_fact_emitidas.setitem(ll_fila, 'subtotal',total_nuevo)
		end if
		ds_lineas_fact_emitidas.update()
		id_musaat= tab_1.tabpage_1.dw_3.getitemstring(i, 'id_musaat')
	
	   // Se actualiza musaat_params_lineas_fe
		ds_musaat_param_lineas_fe.retrieve(id_fase_ant)
//		for j=1 to ds_musaat_param_lineas_fe.rowcount()
			
		//	if   ds_musaat_param_lineas_fe.getitemstring(j, "id_musaat") = id_musaat then
		ll_fila = ds_musaat_param_lineas_fe.Find(" id_musaat = '" + id_musaat+ "'",0,ds_musaat_param_lineas_fe.RowCount())
		if ll_fila > 0 Then 
				ds_musaat_param_lineas_fe.setitem(j, 'prima_total',total_nuevo) 
				ds_musaat_param_lineas_fe.setitem(j, 'base_musaat',total_nuevo) 
//			else
//				musaat_old = ds_musaat_param_lineas_fe.getitemnumber(j,'base_musaat')
			end if
//		next
			
		
		ds_musaat_param_lineas_fe.update()
	

		// Se actualiza el importe en fases informes
		ds_fases_informes.retrieve(id_fase_ant)
		fila_musaat = ds_fases_informes.Find(" tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,ds_fases_informes.RowCount())
		if fila_musaat > 0 Then 
				musaat_ant = ds_fases_informes.GetItemNumber(fila_musaat,'cuantia_colegiado')
				fila_insertada = fila_musaat
				
		End if
		if fila_insertada > 0 then
			if ((total_ant + total_nuevo) <> musaat_ant) then
				musaat = (total_ant + total_nuevo)+musaat_old
				ds_fases_informes.setitem(fila_insertada, 'cuantia_colegiado', musaat )
			end if
		end if
	//	ds_fases_informes.update()


	end if
next


	

destroy(ds_fases_informes)
destroy(ds_lineas_fact_emitidas)

tab_1.tabpage_1.dw_3.update()

// Reseteamos
tab_1.tabpage_1.dw_3.reset()

messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.proceso_finalizado','Proceso finalizado'))
end event

event clicked;event csd_actualiza_proformas()
if tab_1.tabpage_2.dw_2.rowcount() <= 0 then return

// Avisamos
int retorno, i
retorno = messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.actualiza_importe_musaat','Atenci$$HEX1$$f300$$ENDHEX$$n: este proceso actualiza el importe de musaat de los avisos  y proformas con el nuevo importe recalculado, $$HEX1$$bf00$$ENDHEX$$Desea continuar?'), Question!,YesNo!)
if retorno = 2 then return

// Actualizamos el importe de musaat con el nuevo si son diferentes
for i = 1 to tab_1.tabpage_2.dw_2.rowcount()
	if tab_1.tabpage_2.dw_2.getitemnumber(i, 'base_musaat') <> tab_1.tabpage_2.dw_2.getitemnumber(i, 'importe_nuevo') then
		// Modificado David 09/01/2006 Actualizamos los totales del aviso y del colegiado con la diferencia de musaat
		double dif, total, total_col
		dif = tab_1.tabpage_2.dw_2.getitemnumber(i, 'importe_nuevo') - tab_1.tabpage_2.dw_2.getitemnumber(i, 'base_musaat')
		
		total = tab_1.tabpage_2.dw_2.getitemnumber(i, 'total_aviso')
		total_col = tab_1.tabpage_2.dw_2.getitemnumber(i, 'total_colegiado')
		tab_1.tabpage_2.dw_2.setitem(i, 'total_aviso', total + dif)
		tab_1.tabpage_2.dw_2.setitem(i, 'total_colegiado', total_col + dif)
		//SCP-838. Jesus. Se cambia la base_musaat al final, sino se pierde la diferencia entre importe_nuevo y base_musaat, necesaria para el incremento de la minuta.
		tab_1.tabpage_2.dw_2.setitem(i, 'base_musaat', tab_1.tabpage_2.dw_2.getitemnumber(i, 'importe_nuevo'))
	end if
next



//Andres Incid 1541 17/1/05
//Intento replicar el evento csd_calcular_descuentos del tab de descuentos
//de la pantalla de detalle de contratos
//Actualizamos el valor recalculado en fases_informes

double porc_col = 0, porc_col_real = 0, suma_porc = 0, musaat=0
datastore ds_fases,ds_fases_usos,ds_fases_colegiados,ds_fases_informes
datastore ds_fases_datos_exp
st_musaat_datos st_musaat_datos
st_csi_articulos_servicios st_csi_articulos_servicios
string ls_fases_dw1
long ll_fila,ll_fase_fila,fila_insertada
string ls_id_fase_n,ls_id_fase_v
long j
string id_col


// Suma de la Musaat de todos los colegiado
// Si es una asociaci$$HEX1$$f300$$ENDHEX$$n, de todos los asociados
//utilizamos los mismos datawindows que en la ventana de detalle de fases
ds_fases=create datastore
ds_fases_usos=create datastore
ds_fases_colegiados=create datastore
ds_fases_informes=create datastore
ds_fases_datos_exp=create datastore

ds_fases.dataobject='d_fases_detalle'
ds_fases_usos.dataobject='d_fases_expedientes_estadistica'
ds_fases_colegiados.dataobject='d_fases_colegiados'
ds_fases_informes.dataobject='d_fases_informes'
ds_fases_datos_exp.dataobject='d_fases_datos_exp'

ds_fases.settransobject(sqlca)
ds_fases_usos.settransobject(sqlca)
ds_fases_colegiados.settransobject(sqlca)
ds_fases_informes.settransobject(sqlca)
ds_fases_datos_exp.settransobject(sqlca)

for ll_fila=1 to tab_1.tabpage_2.dw_2.rowcount()
	 //Inicializamos variables num$$HEX1$$e900$$ENDHEX$$ricas
	 porc_col = 0 
	 porc_col_real = 0 
	 suma_porc = 0 
	 musaat=0
	 ls_id_fase_n=tab_1.tabpage_2.dw_2.getitemstring(ll_fila,'id_fase')
	 if(ls_id_fase_n<>ls_id_fase_v) then
	  //ls_fases_dw1=ls_fases_dw1+",'"+ls_id_fase_v+"'"
	  ls_id_fase_v=ls_id_fase_n
		//obtenemos datos 
		ds_fases.retrieve(ls_id_fase_v)
		ds_fases_usos.retrieve(ls_id_fase_v)
		ds_fases_colegiados.retrieve(ls_id_fase_v)
		ds_fases_informes.retrieve(ls_id_fase_v)
		ds_fases_datos_exp.retrieve(ds_fases.getitemstring(ds_fases.getrow(),'id_expedi'))		
				
		st_musaat_datos.n_visado = ds_fases.getitemstring(1, 'id_fase')
		st_musaat_datos.tipo_act = ds_fases.getitemstring(1, 'fase')
		st_musaat_datos.tipo_obra = ds_fases.getitemstring(1, 'tipo_trabajo')
		st_musaat_datos.pem = ds_fases_usos.getitemnumber(1, 'pem')
		//st_musaat_datos.pto_contrato = ds_fases_usos.getitemnumber(1, 'pem')		
		st_musaat_datos.administracion = ds_fases_datos_exp.getitemstring(1, 'administracion')
		st_musaat_datos.superficie = ds_fases_usos.getitemnumber(1, 'superficie')
		st_musaat_datos.volumen = ds_fases_usos.getitemnumber(1, 'volumen')

		// Suma de los % de los colegiados
		for j = 1 to ds_fases_colegiados.rowcount()
			suma_porc +=  ds_fases_colegiados.getitemnumber(j, 'porcen_a')	
		next
		for i = 1 to ds_fases_colegiados.rowcount()
			porc_col =  ds_fases_colegiados.getitemnumber(i, 'porcen_a')	
			if isnull(suma_porc) or suma_porc = 0 then exit
			porc_col_real = porc_col / suma_porc * 100	
			st_musaat_datos.porcentaje = porc_col_real
			id_col = ds_fases_colegiados.getitemstring(i, 'id_col')
			st_musaat_datos.id_col = id_col
			st_musaat_datos.cobertura = 0
			// Le pasamos en la estructura si el colegiado es funcionario
			st_musaat_datos.funcionario = ds_fases_colegiados.getitemstring(i, 'facturado')	
			if f_colegiado_tipopersona(id_col) = 'S' then	
				f_musaat_calcula_prima_sociedad(st_musaat_datos)
				musaat += st_musaat_datos.prima_comp	
			else
				f_musaat_calcula_prima(st_musaat_datos)	
				musaat += st_musaat_datos.prima_comp
			end if
		next

		if isnull(musaat) then musaat = 0

		
		if musaat > 0 then
			//Comprobar si ya se ha calculado los DV anteriormente
			long fila_musaat
			double musaat_ant
			fila_musaat = ds_fases_informes.Find("tipo_informe = '" + g_codigos_conceptos.musaat_variable + "'",0,ds_fases_informes.RowCount())
			if fila_musaat > 0 Then 
				musaat_ant = ds_fases_informes.GetItemNumber(fila_musaat,'cuantia_colegiado')
				fila_insertada = fila_musaat
			Else
				//Esto no deber$$HEX1$$ed00$$ENDHEX$$a suceder
				//fila_insertada = this.event pfc_addrow()
			End if

			if fila_insertada > 0 then
				ds_fases_informes.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.musaat_variable)
				st_csi_articulos_servicios.codigo = g_codigos_conceptos.musaat_variable
				if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
					st_csi_articulos_servicios.t_iva = g_t_iva_defecto
				end if
				ds_fases_informes.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva )
				ds_fases_informes.setitem(fila_insertada, 'cuantia_colegiado', musaat )
				ds_fases_informes.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(musaat, st_csi_articulos_servicios.t_iva ))
			end if
		end if


		ds_fases_informes.update()


	end if
next
//fin iteracion

//liberamos datastores
destroy(ds_fases)
destroy(ds_fases_usos)
destroy(ds_fases_colegiados)
destroy(ds_fases_informes)
destroy(ds_fases_datos_exp)

//Fin Andres 17/01/05

// Grabamos

tab_1.tabpage_2.dw_2.update()

// Reseteamos
tab_1.tabpage_2.dw_2.reset()

messagebox(g_titulo, g_idioma.of_getmsg('msg_musaat.proceso_finalizado','Proceso finalizado'))

end event

type tab_1 from tab within w_musaat_recalculo_minutas
integer x = 37
integer y = 256
integer width = 3584
integer height = 1184
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
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
integer width = 3547
integer height = 1056
long backcolor = 79741120
string text = "Proformas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_1.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_1.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_1
integer x = 18
integer y = 16
integer width = 3474
integer height = 992
integer taborder = 11
string dataobject = "d_musaat_recalculo_proformas_detalle"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3547
integer height = 1056
long backcolor = 79741120
string text = "Avisos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_2
integer x = 18
integer y = 16
integer width = 3474
integer height = 992
integer taborder = 21
string dataobject = "d_musaat_recalculo_minutas_detalle"
boolean righttoleft = true
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

type dw_1 from u_dw within w_musaat_recalculo_minutas
boolean visible = false
integer x = 1755
integer y = 416
integer width = 110
integer height = 128
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_musaat_recalculo_minutas_detalle"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

type st_1 from statictext within w_musaat_recalculo_minutas
integer x = 2194
integer y = 288
integer width = 1275
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "El rec$$HEX1$$e100$$ENDHEX$$lculo se realiza solo para los movimientos de alta 1.x"
boolean focusrectangle = false
end type

