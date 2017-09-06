HA$PBExportHeader$w_conceptos_domiciliables_lr.srw
forward
global type w_conceptos_domiciliables_lr from w_sheet
end type
type cb_grabar from commandbutton within w_conceptos_domiciliables_lr
end type
type cb_procesar from commandbutton within w_conceptos_domiciliables_lr
end type
type st_proceso from statictext within w_conceptos_domiciliables_lr
end type
type dw_actualizacion_domiciliaciones from u_dw within w_conceptos_domiciliables_lr
end type
type dw_consulta from u_dw within w_conceptos_domiciliables_lr
end type
end forward

global type w_conceptos_domiciliables_lr from w_sheet
integer x = 214
integer y = 221
integer width = 3145
integer height = 1864
string menuname = "m_conceptos_domiciliables_lr"
windowstate windowstate = maximized!
event csd_preparar_consulta ( )
event csd_guardar_pantalla ( )
event csd_recuperar_pantalla ( )
cb_grabar cb_grabar
cb_procesar cb_procesar
st_proceso st_proceso
dw_actualizacion_domiciliaciones dw_actualizacion_domiciliaciones
dw_consulta dw_consulta
end type
global w_conceptos_domiciliables_lr w_conceptos_domiciliables_lr

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
		sobreescribir = Messagebox(g_titulo,'La lista especificada ya existe actualmente,$$HEX1$$bf00$$ENDHEX$$desea sobreescribirla?',StopSign!,YesNo!)
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

on w_conceptos_domiciliables_lr.create
int iCurrent
call super::create
if this.MenuName = "m_conceptos_domiciliables_lr" then this.MenuID = create m_conceptos_domiciliables_lr
this.cb_grabar=create cb_grabar
this.cb_procesar=create cb_procesar
this.st_proceso=create st_proceso
this.dw_actualizacion_domiciliaciones=create dw_actualizacion_domiciliaciones
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_grabar
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_proceso
this.Control[iCurrent+4]=this.dw_actualizacion_domiciliaciones
this.Control[iCurrent+5]=this.dw_consulta
end on

on w_conceptos_domiciliables_lr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_grabar)
destroy(this.cb_procesar)
destroy(this.st_proceso)
destroy(this.dw_actualizacion_domiciliaciones)
destroy(this.dw_consulta)
end on

event open;call super::open;f_centrar_ventana(this)

// Preparamos el dw de consulta
this.trigger event csd_preparar_consulta()

// Preparamos el resiceado
of_SetResize (true)
inv_resize.of_Register (cb_procesar, "FixedtoRight")
inv_resize.of_Register (cb_grabar, "FixedtoRight")
inv_resize.of_Register (cb_guardar_pantalla, "FixedtoRight")
inv_resize.of_Register (cb_recuperar_pantalla, "FixedtoRight")
inv_resize.of_Register (dw_actualizacion_domiciliaciones, "ScaletoRight&Bottom")

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_conceptos_domiciliables_lr
boolean visible = true
integer x = 2619
integer y = 428
integer width = 425
integer height = 92
string text = "Recuperar Cons."
end type

event cb_recuperar_pantalla::clicked;parent.trigger event csd_preparar_consulta()
parent.trigger event csd_recuperar_pantalla()
end event

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_conceptos_domiciliables_lr
boolean visible = true
integer x = 2619
integer y = 336
integer width = 425
integer height = 92
string text = "&Guardar Consulta"
end type

event cb_guardar_pantalla::clicked;parent.trigger event csd_guardar_pantalla()
end event

type cb_grabar from commandbutton within w_conceptos_domiciliables_lr
integer x = 2619
integer y = 144
integer width = 425
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Grabar"
end type

event clicked;if f_puedo_escribir(g_usuario, '0000000037')= -1 then return -1 


string sql_original

// Forzamos el grabado
dw_actualizacion_domiciliaciones.update()
// retriveamos nuevamente
// Cogemos la sql
sql_original = dw_actualizacion_domiciliaciones.describe("datawindow.table.select")

// Colocamos otra vez la sql
dw_actualizacion_domiciliaciones.modify("datawindow.table.select= ~"" + is_sql_consulta + "~"")
dw_actualizacion_domiciliaciones.retrieve()
// Colocamos la sql original
dw_actualizacion_domiciliaciones.modify("datawindow.table.select= ~"" + sql_original + "~"")

end event

type cb_procesar from commandbutton within w_conceptos_domiciliables_lr
integer x = 2619
integer y = 44
integer width = 425
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Procesar"
end type

event clicked;// Procesamos lo que tenemos que hacer
string sql_nuevo, sql_original, mensaje='', proceso, concepto, forma_pago
long fila
double importe, porcentaje, importe_original
boolean b_modificado = true


// Aplicaremos la consulta sobre el datawindow
dw_consulta.trigger event pfc_accepttext(true)


// Obligamos a que pongan los valores en el concepto y en el valor a modificar
concepto = dw_consulta.getitemString(dw_consulta.getrow(), 'concepto')
if f_es_vacio(concepto) then mensaje += "Debe indicar el concepto para el que procesar los datos"
importe = dw_consulta.getitemNumber(dw_consulta.getrow(), 'valor')
porcentaje = dw_consulta.getitemNumber(dw_consulta.getrow(), 'porcentaje')
// Si no indican ni importe ni porcentaje es tonteria hacer nada
if isnull(importe) and isnull(porcentaje) then 
	if LenA(mensaje) >0 then mensaje += cr
	mensaje+= "Debe indicar un importe a colocar o un porcentaje"
end if
forma_pago = dw_consulta.getitemString(dw_consulta.getrow(), 'forma_pago')
if f_es_vacio(forma_pago) then 
	if LenA(mensaje) >0 then mensaje += cr
	mensaje += "Debe indicar la forma de pago por defecto"
end if

if mensaje<>'' then
	MessageBox(g_titulo, mensaje, stopsign!)
	return
end if

// Cogemos la sql
sql_nuevo = dw_actualizacion_domiciliaciones.describe("datawindow.table.select")
sql_original = sql_nuevo

// Modificamos la sql
f_sql('colegiados.f_colegiacion','>=','fecha_colegiacion_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.f_colegiacion','<','fecha_colegiacion_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.f_alta','>=','fecha_alta_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.f_alta','<','fecha_alta_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.alta_baja','LIKE','alta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.t_alta','LIKE','t_alta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.tipo_persona','LIKE','tipo_persona',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.sexo','LIKE','sexo',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.c_geografico','LIKE','c_geografico',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('conceptos_domiciliables.concepto','LIKE','concepto',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.situacion','LIKE','situacion',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados.ejerciente','LIKE','ejerciente',dw_consulta,sql_nuevo,g_tipo_base_datos,'')

// Colocamos otra vez la sql
dw_actualizacion_domiciliaciones.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
is_sql_consulta = sql_nuevo
dw_actualizacion_domiciliaciones.retrieve()
// Colocamos la sql original
dw_actualizacion_domiciliaciones.modify("datawindow.table.select= ~"" + sql_original + "~"")


// Hay que procesar los datos
proceso = st_proceso.text
st_proceso.visible = true
FOR fila = 1 TO dw_actualizacion_domiciliaciones.RowCount()
	b_modificado = false
	// Colocamos la etiqueta
	st_proceso.text = proceso + " "+string(fila) + " de "+string(dw_actualizacion_domiciliaciones.RowCount())
	dw_actualizacion_domiciliaciones.scrolltorow(fila)
	// Cogemos el valor del importe en ese campo y lo modificamos si han colocado un importe o un porcentaje
	if not isnull(importe) then
		// colocamos seguro el valor del importe
		dw_actualizacion_domiciliaciones.SetItem(fila, 'conceptos_domiciliables_importe', importe)
		b_modificado = true
	end if
	
	// Si no han indicado importe y han indicado porcentaje
	if not isnull(porcentaje) then
		importe_original = dw_actualizacion_domiciliaciones.getitemNumber(fila, 'conceptos_domiciliables_valor_original')
		// colocamos seguro el valor del importe
		dw_actualizacion_domiciliaciones.SetItem(fila, 'conceptos_domiciliables_importe', round((importe_original * porcentaje/100), 2))
		b_modificado = true
	end if
	
	if b_modificado then
		// Acciones para la modificacion de filas
		// colocamos los valores necesarios en el caso de que la fila no existiese en conceptos domiciliables
		if isnull(dw_actualizacion_domiciliaciones.getitemString(fila, 'conceptos_domiciliables_id_colegiado')) then
			dw_actualizacion_domiciliaciones.Setitem(fila, 'conceptos_domiciliables_id_colegiado', dw_actualizacion_domiciliaciones.getitemString(fila, 'id_colegiado'))
			dw_actualizacion_domiciliaciones.Setitem(fila, 'conceptos_domiciliables_concepto', concepto)
			dw_actualizacion_domiciliaciones.Setitem(fila, 'conceptos_domiciliables_forma_de_pago', forma_pago)
			// Le decimos que esta fila es nueva, para que haga correctamente el grabado en la BBDD
			dw_actualizacion_domiciliaciones.SetitemStatus(fila, 0, primary!, newmodified!)
		end if
	end if
NEXT

// ocultamos la etiquetita
st_proceso.visible = false
st_proceso.text = proceso
this.setredraw(true) // forzamos a que redibuje
end event

type st_proceso from statictext within w_conceptos_domiciliables_lr
integer x = 1925
integer y = 180
integer width = 690
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
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

type dw_actualizacion_domiciliaciones from u_dw within w_conceptos_domiciliables_lr
integer x = 37
integer y = 896
integer width = 3022
integer height = 712
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_conceptos_domiciliables_lr_lista"
end type

type dw_consulta from u_dw within w_conceptos_domiciliables_lr
integer x = 37
integer y = 32
integer width = 3022
integer height = 804
integer taborder = 10
string dataobject = "d_conceptos_domiciliables_lr_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;string concepto
double importe, nulo
date fecha

CHOOSE CASE dwo.name
	CASE 'concepto'
		concepto = string(data)
		
		if not f_es_vacio(concepto) then
			// Cuando coloquen el concepto ponemos el valor asociado en importe a colocar
			SELECT csi_articulos_servicios.importe INTO :importe FROM csi_articulos_servicios WHERE csi_articulos_servicios.codigo = :concepto;
			this.setitem(row, 'valor', importe)
		end if
	CASE 'porcentaje'
		// Vaciamos el importe
		setnull(nulo)
		this.setitem(row, 'valor', nulo)
		
	CASE 'anyo_actual_colegiacion'
		// Ponemos las fechas
		fecha = today()
		this.setitem(row, 'fecha_colegiacion_hasta', fecha)
		this.setitem(row, 'fecha_colegiacion_desde', date(string(day(fecha))+"/"+string(month(fecha))+"/"+string(year(fecha) - 1)))
	CASE 'anyo_actual_alta'
		fecha = today()
		this.setitem(row, 'fecha_alta_hasta', fecha)
		this.setitem(row, 'fecha_alta_desde', date(string(day(fecha))+"/"+string(month(fecha))+"/"+string(year(fecha) - 1)))

	CASE 'tipo_persona'
		// ponemos el sexo a sociedad
		this.setitem(row, 'sexo', 'S')
END CHOOSE
end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

