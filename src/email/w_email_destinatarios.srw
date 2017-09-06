HA$PBExportHeader$w_email_destinatarios.srw
forward
global type w_email_destinatarios from w_response
end type
type dw_direcciones from u_dw within w_email_destinatarios
end type
type dw_destinatarios from u_dw within w_email_destinatarios
end type
type cb_1 from u_cb within w_email_destinatarios
end type
type cb_2 from u_cb within w_email_destinatarios
end type
type cb_3 from u_cb within w_email_destinatarios
end type
type cb_4 from u_cb within w_email_destinatarios
end type
type cb_aceptar from u_cb within w_email_destinatarios
end type
type cb_cancelar from u_cb within w_email_destinatarios
end type
type cb_colegiados from u_cb within w_email_destinatarios
end type
type cb_agenda from u_cb within w_email_destinatarios
end type
end forward

global type w_email_destinatarios from w_response
integer width = 3259
integer height = 1456
string title = "Selecci$$HEX1$$f300$$ENDHEX$$n de Destinatarios"
event csd_importar_direcciones ( )
dw_direcciones dw_direcciones
dw_destinatarios dw_destinatarios
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
cb_colegiados cb_colegiados
cb_agenda cb_agenda
end type
global w_email_destinatarios w_email_destinatarios

type variables
datastore ids_direcciones
u_dw idw_direcciones,idw_destinatarios
end variables

forward prototypes
public function boolean wf_parsea_fichero (string fichero)
public subroutine wf_quitar_anyadidos ()
end prototypes

event csd_importar_direcciones();string linea,linea_anterior,resta_linea,nombre,direccion
long fichero,posic_pyc,fila

// Abrimos el fichero
fichero=FileOpen(g_dir_aplicacion+'\libreta_direcciones.txt',linemode!,Read!)

// Ignoramos la linea de cabecera
FileRead(fichero,linea)
linea_anterior=linea

// Por cada linea leemos los dos primeros campos Nombre y Direccion
FileRead(fichero,linea)
do while linea_anterior<>linea
	resta_linea=linea
	fila=idw_direcciones.insertrow(0)
	posic_pyc=PosA(resta_linea,';')
	idw_direcciones.SetItem(fila,'nombre',MidA(linea,1,posic_pyc - 1))
	resta_linea=MidA(resta_linea,posic_pyc + 1)
	posic_pyc=PosA(resta_linea,';')
	idw_direcciones.SetItem(fila,'direccion',MidA(resta_linea,1,posic_pyc - 1))
	linea_anterior=linea
	FileRead(fichero,linea)
loop

FileClose(fichero)
end event

public function boolean wf_parsea_fichero (string fichero);// Funcion que comprueba si los nombres de ficheros tienen comas simples u otros simbolos reservados de PB y Windows
// Entrada:	Nombre del fichero
// Salida:	True - Nombre de fichero valido
//				False - Nombre de fichero invalido

long i,posicion
string caracteres_invalidos[2]={"'","+"}
string caracteres = '[\\/:*"$$HEX1$$bf00$$ENDHEX$$!$$HEX1$$a100$$ENDHEX$$?<>|]'
//Comprobamos los caracteres que dan error en PB
for i=1 to upperbound(caracteres_invalidos)
	posicion=PosA(fichero,caracteres_invalidos[i])	
	if posicion>0 then return false
next
//Comprobamos luego los caracteres reservados de Windows
if match(fichero,caracteres) = true then return false

return true
end function

public subroutine wf_quitar_anyadidos ();long i,res
string nombre

for i=dw_direcciones.rowcount() to 1 step -1
	nombre=dw_direcciones.GetItemString(i,'nombre')
	if not(wf_parsea_fichero(nombre)) then continue
	res=dw_destinatarios.find("nombre=~""+nombre+"~"",1,dw_destinatarios.rowcount())
	if res>0 then dw_direcciones.deleterow(i)
next
end subroutine

on w_email_destinatarios.create
int iCurrent
call super::create
this.dw_direcciones=create dw_direcciones
this.dw_destinatarios=create dw_destinatarios
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.cb_colegiados=create cb_colegiados
this.cb_agenda=create cb_agenda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_direcciones
this.Control[iCurrent+2]=this.dw_destinatarios
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_aceptar
this.Control[iCurrent+8]=this.cb_cancelar
this.Control[iCurrent+9]=this.cb_colegiados
this.Control[iCurrent+10]=this.cb_agenda
end on

on w_email_destinatarios.destroy
call super::destroy
destroy(this.dw_direcciones)
destroy(this.dw_destinatarios)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.cb_colegiados)
destroy(this.cb_agenda)
end on

event open;call super::open;long res,i
f_centrar_ventana(this)

// En futuras versiones, quizas se a$$HEX1$$f100$$ENDHEX$$adan pesta$$HEX1$$f100$$ENDHEX$$as para destinatarios, CC y CCO
idw_direcciones=dw_direcciones
idw_destinatarios=dw_destinatarios

ids_direcciones=Message.PowerObjectParm

idw_direcciones.SetTransObject(SQLCA)


f_email_cargar_dw_destinatarios(idw_destinatarios,ids_direcciones)
f_email_importar_direcciones(dw_direcciones)

wf_quitar_anyadidos()
end event

event close;call super::close;CloseWithReturn(this,ids_direcciones)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_email_destinatarios
integer x = 1856
integer y = 944
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_email_destinatarios
integer x = 1902
integer y = 1076
end type

type dw_direcciones from u_dw within w_email_destinatarios
integer x = 5
integer y = 32
integer width = 1536
integer height = 1160
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_email_direcciones"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)

// Multiseleccion
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

event doubleclicked;call super::doubleclicked;cb_1.event clicked()
end event

type dw_destinatarios from u_dw within w_email_destinatarios
integer x = 1682
integer y = 40
integer width = 1536
integer height = 1160
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_email_direcciones"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;of_setrowselect(true)
of_setrowmanager(true)

// Multiseleccion
this.inv_rowselect.of_SetStyle (this.inv_rowselect.EXTENDED)
end event

event doubleclicked;call super::doubleclicked;cb_2.event clicked()
end event

type cb_1 from u_cb within w_email_destinatarios
integer x = 1563
integer y = 500
integer width = 101
integer height = 76
integer taborder = 11
boolean bringtotop = true
string text = ">"
end type

event clicked;call super::clicked;long fila_seleccionada,fila

fila_seleccionada = idw_direcciones.getselectedrow(0)
DO WHILE fila_seleccionada>0	
	if fila_seleccionada > 0 then
		fila=idw_destinatarios.insertrow(0)
		idw_destinatarios.SetItem(fila,'nombre',idw_direcciones.GetItemString(fila_seleccionada,'nombre'))
		idw_destinatarios.SetItem(fila,'direccion',idw_direcciones.GetItemString(fila_seleccionada,'direccion'))		
		idw_direcciones.deleterow(fila_seleccionada)
	end if
	fila_seleccionada = idw_direcciones.getselectedrow(0)
	
LOOP 

idw_destinatarios.Sort()
end event

type cb_2 from u_cb within w_email_destinatarios
integer x = 1563
integer y = 592
integer width = 101
integer height = 76
integer taborder = 21
boolean bringtotop = true
string text = "<"
end type

event clicked;call super::clicked;long fila_seleccionada,fila

fila_seleccionada = idw_destinatarios.getselectedrow(0)
DO WHILE fila_seleccionada>0	
	if fila_seleccionada > 0 then
		fila=idw_direcciones.insertrow(0)
		idw_direcciones.SetItem(fila,'nombre',idw_destinatarios.GetItemString(fila_seleccionada,'nombre'))
		idw_direcciones.SetItem(fila,'direccion',idw_destinatarios.GetItemString(fila_seleccionada,'direccion'))		
		idw_destinatarios.deleterow(fila_seleccionada)
	end if
	fila_seleccionada = idw_destinatarios.getselectedrow(0)	
LOOP 

idw_direcciones.Sort()
end event

type cb_3 from u_cb within w_email_destinatarios
integer x = 1563
integer y = 672
integer width = 101
integer height = 76
integer taborder = 31
boolean bringtotop = true
string text = "<<"
end type

event clicked;call super::clicked;long fila_seleccionada,fila,i

for i=idw_destinatarios.rowcount() to 1 step -1
		fila=idw_direcciones.insertrow(0)
		idw_direcciones.SetItem(fila,'nombre',idw_destinatarios.GetItemString(i,'nombre'))
		idw_direcciones.SetItem(fila,'direccion',idw_destinatarios.GetItemString(i,'direccion'))		
		idw_destinatarios.deleterow(i)

next

idw_direcciones.Sort()
end event

type cb_4 from u_cb within w_email_destinatarios
integer x = 1563
integer y = 412
integer width = 101
integer height = 76
integer taborder = 21
boolean bringtotop = true
string text = ">>"
end type

event clicked;call super::clicked;long fila_seleccionada,fila,i

for i=idw_direcciones.rowcount() to 1 step -1
		fila=idw_destinatarios.insertrow(0)
		idw_destinatarios.SetItem(fila,'nombre',idw_direcciones.GetItemString(i,'nombre'))
		idw_destinatarios.SetItem(fila,'direccion',idw_direcciones.GetItemString(i,'direccion'))		
		idw_direcciones.deleterow(i)

next

idw_destinatarios.Sort()
end event

type cb_aceptar from u_cb within w_email_destinatarios
integer x = 1239
integer y = 1240
integer width = 421
integer height = 80
integer taborder = 31
boolean bringtotop = true
string text = "Aceptar"
end type

event clicked;call super::clicked;f_email_cargar_ds_direcciones(idw_destinatarios,ids_direcciones)

CloseWithReturn(parent,ids_direcciones)
end event

type cb_cancelar from u_cb within w_email_destinatarios
integer x = 1691
integer y = 1240
integer width = 421
integer height = 80
integer taborder = 41
boolean bringtotop = true
string text = "Cancelar"
end type

event clicked;call super::clicked;CloseWithReturn(parent,ids_direcciones)
end event

type cb_colegiados from u_cb within w_email_destinatarios
integer x = 727
integer y = 1240
integer width = 439
integer height = 80
integer taborder = 11
boolean bringtotop = true
string text = "Cargar Colegiados"
end type

event clicked;call super::clicked;long j,i
string email,nombre,apellidos,sql,nombre_completo
datastore ds_lista_col
ds_lista_col=create datastore

dw_direcciones.reset()
ds_lista_col.dataobject='d_colegiados_lista'
ds_lista_col.SetTransObject(SQLCA)
sql=ds_lista_col.GetSQLSelect()
sql+="where email<>null and rtrim(email)<>''"
ds_lista_col.SetSQLSelect(sql)

ds_lista_col.retrieve()
ds_lista_col.SetSort("apellidos A,nombre A")
ds_lista_col.sort()
for i=1 to ds_lista_col.rowcount()	

	nombre=ds_lista_col.GetITemString(i,'nombre')
	apellidos=ds_lista_col.GetITemString(i,'apellidos')	
	email=ds_lista_col.GetITemString(i,'email')
	if PosA(email,'@')<=0 then continue
	nombre_completo=apellidos+', '+nombre
	if f_es_vacio(nombre) then	nombre_completo=apellidos
	if f_es_vacio(apellidos) then	nombre_completo=nombre
	j=dw_direcciones.insertrow(0)
	dw_direcciones.SetItem(j,'nombre',nombre_completo)
	dw_direcciones.SetItem(j,'direccion',email)
next

this.visible=false
cb_agenda.visible=true
wf_quitar_anyadidos()
end event

type cb_agenda from u_cb within w_email_destinatarios
integer x = 727
integer y = 1240
integer width = 439
integer height = 80
integer taborder = 21
string text = "Cargar Agenda"
end type

event clicked;call super::clicked;dw_direcciones.reset()
f_email_importar_direcciones(dw_direcciones)

this.visible=false
cb_colegiados.visible=true
wf_quitar_anyadidos()
end event

