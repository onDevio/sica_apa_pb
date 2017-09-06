HA$PBExportHeader$w_inggas_consulta.srw
$PBExportComments$Informe de ingresos y gastos
forward
global type w_inggas_consulta from w_response
end type
type hpb_1 from hprogressbar within w_inggas_consulta
end type
type cb_2 from commandbutton within w_inggas_consulta
end type
type cb_1 from commandbutton within w_inggas_consulta
end type
type dw_1 from u_dw within w_inggas_consulta
end type
type cb_3 from commandbutton within w_inggas_consulta
end type
type dw_2 from u_dw within w_inggas_consulta
end type
type dw_3 from u_dw within w_inggas_consulta
end type
end forward

global type w_inggas_consulta from w_response
integer width = 2281
integer height = 1288
string title = "Generaci$$HEX1$$f300$$ENDHEX$$n del disco de Hacienda 190"
boolean minbox = true
windowtype windowtype = popup!
event csd_avanza_progreso ( long posicion )
event type string csd_impresion ( )
hpb_1 hpb_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
cb_3 cb_3
dw_2 dw_2
dw_3 dw_3
end type
global w_inggas_consulta w_inggas_consulta

type variables

end variables

event csd_avanza_progreso;hpb_1.position = posicion

if posicion = 100 then hpb_1.position = 0

if hpb_1.position  >= 1 then 
	hpb_1.visible = true
else
	hpb_1.visible = false
end if
end event

event csd_impresion;return dw_1.getitemstring(1, 'impresion')
end event

on w_inggas_consulta.create
int iCurrent
call super::create
this.hpb_1=create hpb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
end on

on w_inggas_consulta.destroy
call super::destroy
destroy(this.hpb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;
f_centrar_ventana(this)
dw_1.insertrow(0)


string n_col_min, n_col_max
select min(n_colegiado), max(n_colegiado) into :n_col_min, :n_col_max from colegiados;

dw_1.setitem(1, 'col_desde', n_col_min)
dw_1.setitem(1, 'col_hasta', n_col_max)


string sl_f_desde, sl_f_hasta
datetime f_desde, f_hasta

sl_f_desde = '01/01/' + g_ejercicio 
sl_f_hasta = '31/12/' + g_ejercicio

f_desde = datetime(date(sl_f_desde), time('00:00:00'))
f_hasta = datetime(date(sl_f_hasta), time('00:00:00'))


dw_1.setitem(1, 'f_desde', f_desde)
dw_1.setitem(1, 'f_hasta', f_hasta)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_inggas_consulta
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_inggas_consulta
end type

type hpb_1 from hprogressbar within w_inggas_consulta
boolean visible = false
integer x = 55
integer y = 896
integer width = 2048
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 1
end type

type cb_2 from commandbutton within w_inggas_consulta
integer x = 1147
integer y = 1004
integer width = 361
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_inggas_consulta
integer x = 576
integer y = 1004
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;dw_1.accepttext()

dw_3.reset()
string n_col_desde, n_col_hasta
//string id_col_desde, id_col_hasta
datetime f_desde, f_hasta

Setpointer(Hourglass!)
n_col_desde = dw_1.getitemstring(1, 'col_desde')
if f_es_vacio(n_col_desde) then
	messagebox(g_titulo, 'Introduzca el colegiado inicial')
	return
end if
n_col_hasta = dw_1.getitemstring(1, 'col_hasta')
if f_es_vacio(n_col_hasta) then
	messagebox(g_titulo, 'Introduzca el colegiado final')
	return
end if
//id_col_desde = f_colegiado_id_col(n_col_desde)
//id_col_hasta = f_colegiado_id_col(n_col_hasta)

f_desde = dw_1.getitemdatetime(1, 'f_desde')
if isnull(f_desde) then
	messagebox(g_titulo, 'Introduzca la fecha inicial')
	return
end if
f_hasta = dw_1.getitemdatetime(1, 'f_hasta')
if isnull(f_hasta) then
	messagebox(g_titulo, 'Introduzca la fecha final')
	return
end if

f_desde = datetime(date(f_desde), time('00:00:00'))
f_hasta = datetime(date(f_hasta), time('23:59:59'))


f_disco_biz_190_lineas(f_desde, f_hasta, n_col_desde, n_col_hasta, parent, dw_3)
//dw_3.visible= true

end event

type dw_1 from u_dw within w_inggas_consulta
integer x = 59
integer y = 68
integer width = 2149
integer height = 792
integer taborder = 10
string dataobject = "d_inggas_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_3 from commandbutton within w_inggas_consulta
integer x = 1637
integer y = 1004
integer width = 517
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Comprobar el fichero"
boolean cancel = true
end type

event clicked;string nombrefichero, Ruta, linea
int i, pos_punto, j, longitud_cadena
string sl_base_sujeta_linea, sl_retenido_linea
double base_sujeta_suma = 0 , retenido_suma = 0, base_sujeta_linea = 0, retenido_linea = 0

string sl_base_total_cabecera, sl_retenido_cabecera
double base_total_cabecera = 0, retenido_cabecera = 0
double num_colegiados = 0

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02


dw_2.reset()

if GetFileOpenName('Seleccione el fich. de Hacienda a leer',Ruta,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return
dw_2.ImportFile(Ruta)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


// Leemos la cabecera
linea = dw_2.getitemstring(1, 'texto')
sl_base_total_cabecera = MidA(linea, 146, 15)
sl_retenido_cabecera = MidA(linea, 161, 15)
if not isnumber(sl_base_total_cabecera) or not isnumber(sl_retenido_cabecera) then
	messagebox(g_titulo, 'Proceso abortado, se est$$HEX1$$e100$$ENDHEX$$n leyendo campos no num$$HEX1$$e900$$ENDHEX$$ricos')
	return
end if
base_total_cabecera = f_redondea(double(sl_base_total_cabecera) / 100)
retenido_cabecera = f_redondea(double(sl_retenido_cabecera) / 100)

//Leemos las lineas de detalle
for i = 2 to dw_2.rowcount()
	num_colegiados ++
	linea = dw_2.getitemstring(i, 'texto')
	sl_base_sujeta_linea = MidA(linea, 82, 13)
	sl_retenido_linea = MidA(linea, 95, 13)
	if not isnumber(sl_base_sujeta_linea) or not isnumber(sl_retenido_linea) then
		messagebox(g_titulo, 'Proceso abortado, se est$$HEX1$$e100$$ENDHEX$$n leyendo campos no num$$HEX1$$e900$$ENDHEX$$ricos')
		return		
	end if	
	base_sujeta_linea = f_redondea(double(sl_base_sujeta_linea) / 100)
	retenido_linea = f_redondea(double(sl_retenido_linea) / 100)
	
	base_sujeta_suma  += base_sujeta_linea
	retenido_suma += retenido_linea
next

messagebox(g_titulo,'N$$HEX1$$fa00$$ENDHEX$$mero de colegiados ' + string(num_colegiados) + cr +&
'Total Base Cabecera ' + string(base_total_cabecera, '#,##0.00') + cr + 'Total Retenido Cabecera ' + string(retenido_cabecera, '#,##0.00') + cr + cr+&
' Suma Bases de colegiados ' + string(base_sujeta_suma, '#,##0.00') + cr + ' Suma Retenido a colegiados ' + string(retenido_suma, '#,##0.00')) 

end event

type dw_2 from u_dw within w_inggas_consulta
boolean visible = false
integer x = 1774
integer y = 244
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_musaat_comprueba_fichero"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

type dw_3 from u_dw within w_inggas_consulta
boolean visible = false
integer x = 5
integer width = 2222
integer height = 1144
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_inggas_listado_disco190"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;this.visible = false
end event

