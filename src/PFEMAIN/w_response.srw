HA$PBExportHeader$w_response.srw
$PBExportComments$Extension Response Window class
forward
global type w_response from pfc_w_response
end type
type cb_recuperar_pantalla from commandbutton within w_response
end type
type cb_guardar_pantalla from commandbutton within w_response
end type
end forward

global type w_response from pfc_w_response
event csd_grabar_consulta ( string consulta )
event csd_recuperar_consulta ( string param )
cb_recuperar_pantalla cb_recuperar_pantalla
cb_guardar_pantalla cb_guardar_pantalla
end type
global w_response w_response

type variables
datastore i_ds_datos_consulta
end variables

forward prototypes
public function integer f_guarda_dw (datawindow dw_actual, string id_consulta)
public function string f_modulo_ventana (string ventana)
end prototypes

event csd_grabar_consulta(string consulta);int i,t,j,fila,cuantos,k,sobreescribir
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

i_ds_datos_consulta = create datastore
i_ds_datos_consulta.dataobject = 'd_consultas_datos'
i_ds_datos_consulta.SetTransObject(SQLCA)

ventana = this.classname()
if f_es_vacio(consulta) then
	Open(w_listas_nombre_lista)
	nombre_consulta = Message.Stringparm
else
	nombre_consulta = consulta
end if

//No hemos puesto ning$$HEX1$$fa00$$ENDHEX$$n nombre o hemos pulsado 'Cancelar'
if f_es_vacio(nombre_consulta) then return
//La lista ya EXISTE
select count(*) into :cuantos from consultas where descripcion=:nombre_consulta and ventana = :ventana;

if cuantos>0 then
	sobreescribir = 1
	if f_es_vacio(consulta)then 
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


//Recorremos todos los objetos de la ventana
for i = 1 to UpperBound(this.control[])
	//Si es DW guardamos todos los datos de ese DW
	if TypeOf(this.control[i])= Datawindow! then
		dw_actual = this.control[i]
		f_guarda_dw(dw_actual,id_consulta)
		continue
	end if
	//Si es TAB buscamos el dw dentro de ese tab
	if TypeOf(this.control[i])= Tab! then
		tab_actual = this.control[i]
		//Recorremos todos los tabpages del TAB
		for j= 1 to UpperBound(tab_actual.control[])
			tabpage_actual = tab_actual.control[j]
			//En cada tabpage buscamos los DW que posee...
			for k=1 to UpperBound(tabpage_actual.control[])
				if TypeOf(tabpage_actual.control[k])=Datawindow! then
					dw_actual = tabpage_actual.control[k]
					f_guarda_dw(dw_actual,id_consulta)
				end if
			next
		next
	end if
next

ds_consulta.Update()
i_ds_datos_consulta.Update()

SetPointer(Arrow!)
destroy ds_consulta			
destroy i_ds_datos_consulta
end event

event csd_recuperar_consulta(string param);string ventana,id_consulta,valor_string,dw,tipo_columna,dw_ant='',ventana1
datetime valor_datetime
double valor_double
int i,j,col,fila,k,l
tab tab_actual
userobject tabpage_actual
datastore ds_datos_consulta
datawindow dw_actual,dw_aux
 
SetPointer(HourGlass!)
ds_datos_consulta = create datastore
ds_datos_consulta.dataobject = 'd_consultas_datos'
ds_datos_consulta.SetTransObject(SQLCA)

ventana = this.classname()
//Queremos quitar del nombre de la ventana la parte final (la que va despues del gui$$HEX1$$f300$$ENDHEX$$n)
//Para que nos recupere las consultas realizadas para w_xx_consulta y w_xx_listados 
if param<>'INICIO' then ventana = f_modulo_ventana(ventana)

if f_es_vacio(param) THEN
	OpenWithParm(w_consulta_seleccion,ventana) 
	id_consulta = Message.StringParm
else
	select id_consulta into :id_consulta from consultas where ventana like :ventana and descripcion=:param;
end if

if f_es_vacio(id_consulta) then return

//Recorremos todos los objetos de la ventana
for i = 1 to UpperBound(this.control[])
	//RESETEAMOS todos los dw por si alguno ten$$HEX1$$ed00$$ENDHEX$$a alg$$HEX1$$fa00$$ENDHEX$$n dato anterior
	if TypeOf(this.control[i])= Datawindow! then
		dw_actual = this.control[i]
		dw_actual.resetupdate()
	end if
	if TypeOf(this.control[i])= Tab! then
		tab_actual = this.control[i]
		//Recorremos todos los tabpages del TAB
		for j= 1 to UpperBound(tab_actual.control[])
			tabpage_actual = tab_actual.control[j]
			//En cada tabpage buscamos los DW que posee...
			for k=1 to UpperBound(tabpage_actual.control[])
				if TypeOf(tabpage_actual.control[k])=Datawindow! then
					dw_actual = tabpage_actual.control[k]
					dw_actual.resetupdate()
				end if
			next
		next
	end if
	
next

ds_datos_consulta.Retrieve(id_consulta)

for i= 1 to ds_datos_consulta.RowCount()
	dw = ds_datos_consulta.GetItemString(i,'datawindow')
	col = ds_datos_consulta.GetItemNumber(i,'columna')
	valor_double  = ds_datos_consulta.GetItemNumber(i,'valor_double')
	valor_datetime= ds_datos_consulta.GetItemDatetime(i,'valor_datetime')
	valor_string	= ds_datos_consulta.GetItemString(i,'valor_string')
	fila = ds_datos_consulta.GetItemNumber(i,'fila')
	if dw_ant <> dw then 
		SetNull(dw_actual)
		for j = 1 to UpperBound(this.control[])
			//Si es DW
			if TypeOf(this.control[j])= Datawindow! then
				dw_aux = this.control[j]
				if dw_aux.ClassName() = dw then dw_actual = dw_aux
			end if
			//Si es TAB
			if TypeOf(this.control[j])= Tab! then
			tab_actual = this.control[j]
			//Recorremos todos los tabpages del TAB
			for l= 1 to UpperBound(tab_actual.control[])
				tabpage_actual = tab_actual.control[l]
				//En cada tabpage buscamos los DW que posee...
				for k=1 to UpperBound(tabpage_actual.control[])
					if TypeOf(tabpage_actual.control[k])=Datawindow! then
						dw_aux = tabpage_actual.control[k]
						if dw_aux.ClassName() = dw then dw_actual = dw_aux
					end if
				next
			next
	end if
			
		next
	end if
	if IsNull(dw_actual) then continue
	tipo_columna = dw_actual.Describe('#'+string(col)+'.ColType')
	if dw_actual.rowcount()<fila then dw_actual.InsertRow(0)
	choose case tipo_columna
		case 'datetime'
			dw_actual.SetItem(fila,col,valor_datetime)
		case 'number'
			dw_actual.SetItem(fila,col,valor_double)
		case else
			dw_actual.SetItem(fila,col,valor_string)
	end choose
	dw_ant = dw
next
	
SetPointer(Arrow!)	

destroy ds_datos_consulta
end event

public function integer f_guarda_dw (datawindow dw_actual, string id_consulta);int t,j,num_columnas,fila
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
		fila = i_ds_datos_consulta.InsertRow(0)
		i_ds_datos_consulta.SetItem(fila,'id_consulta_datos',f_siguiente_numero('CONSULTAS_DATOS',10))
		i_ds_datos_consulta.SetItem(fila,'id_consulta',id_consulta)
		i_ds_datos_consulta.SetItem(fila,'datawindow',dw)
		i_ds_datos_consulta.SetItem(fila,'columna',j)
		i_ds_datos_consulta.SetItem(fila,'fila',t)
		i_ds_datos_consulta.SetItem(fila,'valor_datetime',valor_columna_datetime)
		i_ds_datos_consulta.SetItem(fila,'valor_double',valor_columna_double)
		i_ds_datos_consulta.SetItem(fila,'valor_string',valor_columna_string)
	next				
next


return 1







end function

public function string f_modulo_ventana (string ventana);//Nos devuelve en el caso de que una ventana sea de tipo consulta o listado,
//la primera parte del nombre

int pos
string retorno

pos = PosA(ventana,'consulta',1)
if pos = 0 then pos = PosA(ventana,'listado',1)

if pos = 0 then return ventana

retorno = LeftA(ventana,pos - 1)

retorno = retorno + '%'

return retorno
end function

on w_response.create
int iCurrent
call super::create
this.cb_recuperar_pantalla=create cb_recuperar_pantalla
this.cb_guardar_pantalla=create cb_guardar_pantalla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_recuperar_pantalla
this.Control[iCurrent+2]=this.cb_guardar_pantalla
end on

on w_response.destroy
call super::destroy
destroy(this.cb_recuperar_pantalla)
destroy(this.cb_guardar_pantalla)
end on

event pfc_postopen;call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from commandbutton within w_response
boolean visible = false
integer x = 590
integer y = 1192
integer width = 549
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Recuperar pantalla"
end type

event clicked;parent.event csd_recuperar_consulta('')
end event

type cb_guardar_pantalla from commandbutton within w_response
boolean visible = false
integer x = 590
integer y = 1064
integer width = 489
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Guardar pantalla"
end type

event clicked;parent.event csd_grabar_consulta('')
end event

