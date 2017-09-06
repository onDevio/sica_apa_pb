HA$PBExportHeader$w_minutas_actualiza_cip_le.srw
forward
global type w_minutas_actualiza_cip_le from w_sheet
end type
type cb_listado from commandbutton within w_minutas_actualiza_cip_le
end type
type cb_procesar from commandbutton within w_minutas_actualiza_cip_le
end type
type st_proceso from statictext within w_minutas_actualiza_cip_le
end type
type dw_1 from u_dw within w_minutas_actualiza_cip_le
end type
type dw_consulta from u_dw within w_minutas_actualiza_cip_le
end type
type cb_grabar from commandbutton within w_minutas_actualiza_cip_le
end type
end forward

global type w_minutas_actualiza_cip_le from w_sheet
integer x = 214
integer y = 221
integer width = 3433
integer height = 1716
string title = "Actualizaci$$HEX1$$f300$$ENDHEX$$n DIP"
string menuname = "m_conceptos_domiciliables_lr"
windowstate windowstate = maximized!
event csd_preparar_consulta ( )
event csd_guardar_pantalla ( )
event csd_recuperar_pantalla ( )
cb_listado cb_listado
cb_procesar cb_procesar
st_proceso st_proceso
dw_1 dw_1
dw_consulta dw_consulta
cb_grabar cb_grabar
end type
global w_minutas_actualiza_cip_le w_minutas_actualiza_cip_le

type variables
string is_sql_consulta = ''
datastore ids_datos_consulta
string is_consulta = ''
end variables

forward prototypes
public function integer wf_guarda_dw (datawindow dw_actual, string id_consulta)
public subroutine wf_actualizar_tab_descuentos (integer fila)
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

public subroutine wf_actualizar_tab_descuentos (integer fila);//Intento replicar el evento csd_calcular_descuentos del tab de descuentos
//de la pantalla de detalle de contratos
//Actualizamos el valor recalculado en fases_informes

double cip=0, fila_cip, cip_ant, fila_insertada
datastore ds_fases,ds_fases_usos,ds_fases_colegiados,ds_fases_informes, ds_fases_datos_exp
st_cip_datos st_cip_datos
st_csi_articulos_servicios st_csi_articulos_servicios
string ls_id_fase

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

ls_id_fase=dw_1.getitemstring(fila,'id_fase')

ds_fases.retrieve(ls_id_fase)
ds_fases_usos.retrieve(ls_id_fase)
ds_fases_colegiados.retrieve(ls_id_fase)
ds_fases_informes.retrieve(ls_id_fase)
ds_fases_datos_exp.retrieve(ds_fases.getitemstring(ds_fases.getrow(),'id_expedi'))		

// CIP
st_cip_datos.tipo_act = ds_fases.getitemstring(1, 'fase')
st_cip_datos.tipo_obra = ds_fases.getitemstring(1, 'tipo_trabajo')
st_cip_datos.superficie = ds_fases_usos.getitemnumber(1, 'superficie')
st_cip_datos.pem = ds_fases_usos.getitemnumber(1, 'pem')
st_cip_datos.t_terreno = ds_fases_usos.GetItemString(1,'t_terreno')
st_cip_datos.admon = ds_fases_datos_exp.getitemstring(1, 'administracion')
st_cip_datos.volumen = ds_fases_usos.GetItemNumber(1,'volumen')
st_cip_datos.altura = ds_fases_usos.GetItemNumber(1,'altura')
st_cip_datos.colindantes = ds_fases_usos.GetItemString(1,'colindantes')
st_cip_datos.tipo_gestion = ds_fases.GetItemString(1,'tipo_gestion')	
st_cip_datos.fecha = ds_fases.GetItemdatetime(1,'f_entrada')
st_cip_datos.long_per = ds_fases_usos.getitemnumber(1, 'longitud_per')	
st_cip_datos.vol_tierras = ds_fases_usos.getitemnumber(1, 'volumen_tierras')	
st_cip_datos.valor_terreno = ds_fases_usos.getitemnumber(1, 'valor_terreno')	
st_cip_datos.valor_tasacion = ds_fases_usos.getitemnumber(1, 'valor_tasacion')
st_cip_datos.valoracion_estim = ds_fases_usos.getitemnumber(1, 'valoracion_estim')
st_cip_datos.estructura = ds_fases_usos.GetItemString(1,'estructura')
st_cip_datos.t_medicion = ds_fases_usos.GetItemString(1,'t_medicion')
st_cip_datos.replan_deslin = ds_fases_usos.GetItemString(1,'replan_deslin')
st_cip_datos.visared = ds_fases.GetItemString(1,'e_mail') 
st_cip_datos.vol_edif = ds_fases_usos.GetItemnumber(1,'volumen')
st_cip_datos.tipo_registro = ds_fases.GetItemString(1,'tipo_registro')
st_cip_datos.id_fase = ds_fases.getitemstring(1, 'id_fase')
st_cip_datos.id_expedi = ds_fases_datos_exp.getitemstring(1, 'id_expedi')
st_cip_datos.porcentaje = 100 

//		// Para Cuenca pasamos los datos de los honos minimos a la funci$$HEX1$$f300$$ENDHEX$$n de cip
//		if g_colegio = 'COAATCU' or g_colegio =  'COAATZ' or g_colegio =  'COAATAVI' then
//			st_cip_datos.tarifa = idw_fases_cip_tfe.getitemstring(1, 'tarifa')
//			st_cip_datos.hon_teor =  idw_fases_cip_tfe.getitemnumber(1, 'importe_ho')	
//		end if
//		
//		// En algunos colegios se calcula en la ventana de honorarios
//		if g_colegio = 'COAATTFE' or g_colegio = 'COAATGU' then
//			cip = idw_fases_cip_tfe.getitemnumber(1, 'importe_cip')
//		else
	f_calcular_cip(st_cip_datos)
	cip = st_cip_datos.cip
//		end if
if isnull(cip) then cip = 0

if cip > 0 then
	//Comprobar si ya se ha calculado la CIP anteriormente
	fila_cip = ds_fases_informes.Find("tipo_informe = '" + g_codigos_conceptos.cip + "'",0,ds_fases_informes.RowCount())
	if fila_cip > 0 Then
//		cip_ant = ds_fases_informes.GetItemNumber(fila_cip,'cuantia_colegiado')
//		if cip_ant = cip then 
//			ret = 0
//		else
//			ret = Messagebox(g_titulo,'$$HEX1$$bf00$$ENDHEX$$Desea recalcular '+ f_devuelve_desc_concepto(g_codigos_conceptos.cip)+ '?',Question!,YesNo!)
//		end if
//		if ret = 1 Then
			fila_insertada = fila_cip
//		Else
//			fila_insertada = 0
//		end If
	Else
		fila_insertada = ds_fases_informes.insertrow(0)
		ds_fases_informes.SetItem(fila_insertada,'id_informe',f_siguiente_numero('FASES-INFORMES',10))
		ds_fases_informes.SetItem(fila_insertada,'id_fase',ls_id_fase)
	End if
	if fila_insertada > 0 then
		ds_fases_informes.setitem(fila_insertada, 'tipo_informe', g_codigos_conceptos.cip)
		st_csi_articulos_servicios.codigo = g_codigos_conceptos.cip
		if f_csi_articulos_servicios(st_csi_articulos_servicios) = -1 then
			st_csi_articulos_servicios.t_iva = g_t_iva_defecto
		end if
		ds_fases_informes.setitem(fila_insertada, 't_iva', st_csi_articulos_servicios.t_iva)
		ds_fases_informes.setitem(fila_insertada, 'cuantia_colegiado', cip)
		ds_fases_informes.setitem(fila_insertada, 'impuesto_colegiado', f_aplica_t_iva(cip, st_csi_articulos_servicios.t_iva))
	end if
end if

ds_fases_informes.update()

destroy(ds_fases)
destroy(ds_fases_usos)
destroy(ds_fases_colegiados)
destroy(ds_fases_informes)
destroy(ds_fases_datos_exp)

end subroutine

on w_minutas_actualiza_cip_le.create
int iCurrent
call super::create
if this.MenuName = "m_conceptos_domiciliables_lr" then this.MenuID = create m_conceptos_domiciliables_lr
this.cb_listado=create cb_listado
this.cb_procesar=create cb_procesar
this.st_proceso=create st_proceso
this.dw_1=create dw_1
this.dw_consulta=create dw_consulta
this.cb_grabar=create cb_grabar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_listado
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_proceso
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.cb_grabar
end on

on w_minutas_actualiza_cip_le.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_listado)
destroy(this.cb_procesar)
destroy(this.st_proceso)
destroy(this.dw_1)
destroy(this.dw_consulta)
destroy(this.cb_grabar)
end on

event open;call super::open;of_SetResize (true)
inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (st_proceso, "FixedtoBottom")

dw_consulta.insertrow(0)

if g_colegio = 'COAATNA' then 
	dw_1.dataobject = 'd_minutas_actualiza_cip_na'
	dw_1.settransobject(sqlca)
end if

end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_minutas_actualiza_cip_le
integer x = 2619
integer y = 404
integer width = 425
integer height = 92
end type

event cb_recuperar_pantalla::clicked;parent.trigger event csd_preparar_consulta()
parent.trigger event csd_recuperar_pantalla()
end event

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_minutas_actualiza_cip_le
integer x = 2619
integer y = 312
integer width = 425
integer height = 92
end type

event cb_guardar_pantalla::clicked;parent.trigger event csd_guardar_pantalla()
end event

type cb_listado from commandbutton within w_minutas_actualiza_cip_le
integer x = 2336
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

event clicked;if dw_1.rowcount() > 0 then dw_1.print()

end event

type cb_procesar from commandbutton within w_minutas_actualiza_cip_le
integer x = 1984
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

event clicked;string sql_nuevo, sql_original, id_col, id_fase
long fila
datetime f_desde, f_hasta
st_cip_datos st_cip_datos

dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = dw_consulta.getitemdatetime(1, 'f_hasta')

if f_es_vacio(string(f_desde)) or f_es_vacio(string(f_hasta)) then 
	MessageBox(g_titulo, "Debe indicar las fechas de consulta", stopsign!)
	return
end if

// Cogemos la sql
sql_nuevo = dw_1.describe("datawindow.table.select")
sql_original = sql_nuevo

f_sql('fecha','>=','f_desde',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('fecha','<','f_hasta',dw_consulta,sql_nuevo,g_tipo_base_datos,'')

// Colocamos otra vez la sql
dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
st_proceso.visible = true
dw_1.retrieve()

// Colocamos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_original + "~"")

// Recalculamos el importe de CIP
FOR fila = 1 TO dw_1.RowCount()
	st_proceso.text = "Procesando... " + " "+string(fila) + " de "+string(dw_1.RowCount())
	
	id_col = dw_1.getitemstring(fila, 'id_colegiado')
	id_fase = dw_1.getitemstring(fila, 'id_fase')
	
	// CIP
	st_cip_datos.tipo_act 			= dw_1.getitemstring(fila, 'fase')
	st_cip_datos.tipo_obra 			= dw_1.getitemstring(fila, 'tipo_trabajo')
	st_cip_datos.superficie 			= f_fases_usos_suma_superficies(id_fase)
	st_cip_datos.pem 					= dw_1.getitemnumber(fila, 'pem')
	st_cip_datos.t_terreno 			= dw_1.GetItemString(fila,'t_terreno')
	st_cip_datos.admon 				= dw_1.getitemstring(fila, 'administracion')
	st_cip_datos.volumen 			= dw_1.GetItemNumber(fila,'volumen')
	st_cip_datos.altura 				= dw_1.GetItemNumber(fila,'altura')
	st_cip_datos.colindantes 		= dw_1.GetItemString(fila,'colindantes')
	st_cip_datos.tipo_gestion 		= dw_1.GetItemString(fila,'tipo_gestion')	
	st_cip_datos.fecha 				= datetime(today()) //dw_1.GetItemdatetime(fila,'f_entrada')
	st_cip_datos.long_per 			= dw_1.getitemnumber(fila, 'longitud_per')	
	st_cip_datos.vol_tierras 			= dw_1.getitemnumber(fila, 'volumen_tierras')	
	st_cip_datos.valor_terreno 		= dw_1.getitemnumber(fila, 'valor_terreno')	
	st_cip_datos.valor_tasacion 	= dw_1.getitemnumber(fila, 'valor_tasacion')
	st_cip_datos.valoracion_estim = dw_1.getitemnumber(fila, 'valoracion_estim')
	st_cip_datos.estructura 			= dw_1.GetItemString(fila,'estructura')
	st_cip_datos.t_medicion 			= dw_1.GetItemString(fila,'t_medicion')
	st_cip_datos.replan_deslin 		= dw_1.GetItemString(fila,'replan_deslin')
	st_cip_datos.visared 				= dw_1.GetItemString(fila,'e_mail') 
	st_cip_datos.vol_edif				= dw_1.GetItemnumber(fila,'volumen')
	st_cip_datos.tipo_registro 		= dw_1.GetItemString(fila,'tipo_registro')
	st_cip_datos.id_fase 				= dw_1.getitemstring(fila, 'id_fase')
//	st_cip_datos.porcentaje 		= f_fases_colegiados_porcen(id_fase, id_col) 
	st_cip_datos.porcentaje 		= 100

	f_calcular_cip(st_cip_datos)
	
	double importe_nuevo
	importe_nuevo = f_redondea(st_cip_datos.cip * f_fases_colegiados_porcen(id_fase, id_col) / 100)

	if g_colegio = 'COAATNA' then
		string id_cliente
		id_cliente = dw_1.getitemstring(fila, 'id_cliente')				
		if dw_1.GetItemString(fila,'tipo_gestion')	 = 'C' then
//			if dw_1.getitemnumber(fila, 'porc_honos') <> 100 then
//				importe_nuevo = f_redondea(st_cip_datos.cip * f_fases_colegiados_porcen(id_fase, id_col) / 100 * f_fases_clientes_porcen(id_fase, id_cliente) / 100)
//			else
				importe_nuevo = f_redondea(st_cip_datos.cip * f_fases_colegiados_porcen(id_fase, id_col) / 100 *dw_1.getitemnumber(fila, 'porc_honos') / 100 * f_fases_clientes_porcen(id_fase, id_cliente) / 100)
//			end if
		end if
	end if

	dw_1.Setitem(fila, 'importe_nuevo', importe_nuevo)
NEXT

st_proceso.visible = false

end event

type st_proceso from statictext within w_minutas_actualiza_cip_le
integer x = 37
integer y = 1404
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

type dw_1 from u_dw within w_minutas_actualiza_cip_le
integer x = 37
integer y = 316
integer width = 3305
integer height = 1056
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_minutas_actualiza_cip"
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

type dw_consulta from u_dw within w_minutas_actualiza_cip_le
integer x = 37
integer y = 32
integer width = 1824
integer height = 272
integer taborder = 10
string dataobject = "d_musaat_recalculo_minutas_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

type cb_grabar from commandbutton within w_minutas_actualiza_cip_le
integer x = 2688
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

event clicked;if dw_1.rowcount() <= 0 then return

// Avisamos
int retorno, i
retorno = messagebox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n: este proceso actualiza el importe de DIP de los avisos con el nuevo importe recalculado, $$HEX1$$bf00$$ENDHEX$$Desea continuar?', Question!,YesNo!)
if retorno = 2 then return

double iva_cip, porcent_iva_cip
// Actualizamos el importe de cip con el nuevo si son diferentes
for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i, 'base_cip') <> dw_1.getitemnumber(i, 'importe_nuevo') then
		// Se calcula el iva
		porcent_iva_cip = f_dame_porcent_iva(dw_1.getitemstring(i, 't_iva_cip'))
		iva_cip = f_redondea(dw_1.getitemnumber(i, 'importe_nuevo') * porcent_iva_cip / 100)
		dw_1.setitem(i, 'iva_nuevo', iva_cip)
		
		
		// Modificado David 09/01/2006 Actualizamos los totales del aviso y del colegiado con la diferencia de cip
		double dif, total, total_col, dif_iva
		
		dif = dw_1.getitemnumber(i, 'importe_nuevo') - dw_1.getitemnumber(i, 'base_cip')
		dif_iva = dw_1.getitemnumber(i, 'iva_nuevo') - dw_1.getitemnumber(i, 'iva_cip')
		
		dw_1.setitem(i, 'base_cip', dw_1.getitemnumber(i, 'importe_nuevo'))
		dw_1.setitem(i, 'iva_cip', dw_1.getitemnumber(i, 'iva_nuevo'))
		
		total = dw_1.getitemnumber(i, 'total_aviso')
		total_col = dw_1.getitemnumber(i, 'total_colegiado')
		dw_1.setitem(i, 'total_aviso', total + dif + dif_iva)
		dw_1.setitem(i, 'total_colegiado', total_col + dif + dif_iva)
		
		wf_actualizar_tab_descuentos(i)
	end if
next

// Grabamos
dw_1.update()

// Reseteamos
dw_1.reset()

messagebox(g_titulo, 'Proceso Finalizado')

end event

