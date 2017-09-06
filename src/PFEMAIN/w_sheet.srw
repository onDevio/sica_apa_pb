HA$PBExportHeader$w_sheet.srw
$PBExportComments$Extension Sheet Window class
forward
global type w_sheet from pfc_w_sheet
end type
type cb_recuperar_pantalla from commandbutton within w_sheet
end type
type cb_guardar_pantalla from commandbutton within w_sheet
end type
end forward

global type w_sheet from pfc_w_sheet
integer x = 214
integer y = 221
integer width = 2486
integer height = 1485
event csd_recuperar_consulta ( string param )
event csd_grabar_consulta ( string consulta )
cb_recuperar_pantalla cb_recuperar_pantalla
cb_guardar_pantalla cb_guardar_pantalla
end type
global w_sheet w_sheet

event csd_recuperar_consulta(string param);SetPointer(HourGlass!)

if f_es_vacio(param) then return

f_recuperar_consulta_ventana(this, "", param)

SetPointer(Arrow!)
	

/*string ventana,id_consulta,valor_string,dw,tipo_columna,dw_ant='',ventana1
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
//if param<>'INICIO' then ventana = f_modulo_ventana(ventana)
 
if param<>'INICIO' THEN
 OpenWithParm(w_consulta_seleccion,ventana) 
 id_consulta = Message.StringParm
else
 select id_consulta into :id_consulta from consultas where ventana like :ventana and descripcion='INICIO';
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
 valor_string = ds_datos_consulta.GetItemString(i,'valor_string')
 fila = ds_datos_consulta.GetItemNumber(i,'fila')
 if dw_ant <> dw then 
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
 tipo_columna = dw_actual.Describe('#'+string(col)+'.ColType')
 if dw_actual.rowcount()<fila then dw_actual.InsertRow(0)
 // MODIFICADO RICARDO 04-03-15
 choose case tipo_columna
  	case 'datetime'
   	// SOLO SE CARGA EL VALOR SI HAY VALOR ALMACENADO EN LA CONSULTA A REALIZAR
   	//    if isnull(dw_actual.getitemdatetime(fila, col)) then dw_actual.SetItem(fila,col,valor_datetime)<-- CODIGO ANTIGUO
   	if not isnull(valor_datetime) then dw_actual.SetItem(fila,col,valor_datetime)
  	case 'number'
   	//   if isnull(dw_actual.getitemnumber(fila, col)) then dw_actual.SetItem(fila,col,valor_double)<-- CODIGO ANTIGUO
		if not isnull(valor_double) then dw_actual.SetItem(fila,col,valor_double)
	case else
		//   if f_es_vacio(dw_actual.getitemstring(fila, col)) then dw_actual.SetItem(fila,col,valor_string)<-- CODIGO ANTIGUO
		if not f_es_vacio(valor_string) then dw_actual.SetItem(fila,col,valor_string)
 end choose
 // FIN MODIFICADO RICARDO 04-03-15
 dw_ant = dw
next
 
SetPointer(Arrow!) 
 
destroy ds_datos_consulta*/

end event

event csd_grabar_consulta(string consulta);SetPointer(HourGlass!)

if f_es_vacio(consulta) then return

f_grabar_consulta_ventana(this, consulta)

SetPointer(Arrow!)

end event

on w_sheet.create
int iCurrent
call super::create
this.cb_recuperar_pantalla=create cb_recuperar_pantalla
this.cb_guardar_pantalla=create cb_guardar_pantalla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_recuperar_pantalla
this.Control[iCurrent+2]=this.cb_guardar_pantalla
end on

on w_sheet.destroy
call super::destroy
destroy(this.cb_recuperar_pantalla)
destroy(this.cb_guardar_pantalla)
end on

event open;call super::open;// Modificado Ricardo 03-11-03
// Hacemos que se configure el menu tal como nosotros queremos. De esta forma no hay problemas con los menus hijos
if not f_es_vacio(this.menuname) then
	f_configurar_menu()
	f_configurar_menu_1()
end if
// FIN Modificado Ricardo 03-11-03

end event

type cb_recuperar_pantalla from commandbutton within w_sheet
boolean visible = false
integer x = 32
integer y = 1288
integer width = 549
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Recuperar pantalla"
end type

event clicked;// CSD
parent.event csd_recuperar_consulta('')
end event

type cb_guardar_pantalla from commandbutton within w_sheet
boolean visible = false
integer x = 32
integer y = 1168
integer width = 549
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

event clicked;//CSD
parent.event csd_grabar_consulta('')
end event

