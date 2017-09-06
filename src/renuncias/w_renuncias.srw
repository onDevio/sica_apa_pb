HA$PBExportHeader$w_renuncias.srw
forward
global type w_renuncias from w_sheet
end type
type st_4 from u_st within w_renuncias
end type
type st_3 from u_st within w_renuncias
end type
type cb_1 from u_cb within w_renuncias
end type
type cb_buscar_exp_destino from u_cb within w_renuncias
end type
type sle_2 from u_sle within w_renuncias
end type
type dw_colegiados_alta from u_dw within w_renuncias
end type
type st_2 from u_st within w_renuncias
end type
type st_1 from u_st within w_renuncias
end type
type dw_colegiados_baja from u_dw within w_renuncias
end type
type sle_1 from u_sle within w_renuncias
end type
type cb_buscar_exp_origen from u_cb within w_renuncias
end type
type dw_parametros from u_dw within w_renuncias
end type
end forward

global type w_renuncias from w_sheet
integer width = 3493
integer height = 1200
string title = "Impresi$$HEX1$$f300$$ENDHEX$$n de cartas de Renuncias"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
st_4 st_4
st_3 st_3
cb_1 cb_1
cb_buscar_exp_destino cb_buscar_exp_destino
sle_2 sle_2
dw_colegiados_alta dw_colegiados_alta
st_2 st_2
st_1 st_1
dw_colegiados_baja dw_colegiados_baja
sle_1 sle_1
cb_buscar_exp_origen cb_buscar_exp_origen
dw_parametros dw_parametros
end type
global w_renuncias w_renuncias

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

on w_renuncias.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_buscar_exp_destino=create cb_buscar_exp_destino
this.sle_2=create sle_2
this.dw_colegiados_alta=create dw_colegiados_alta
this.st_2=create st_2
this.st_1=create st_1
this.dw_colegiados_baja=create dw_colegiados_baja
this.sle_1=create sle_1
this.cb_buscar_exp_origen=create cb_buscar_exp_origen
this.dw_parametros=create dw_parametros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_buscar_exp_destino
this.Control[iCurrent+5]=this.sle_2
this.Control[iCurrent+6]=this.dw_colegiados_alta
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_colegiados_baja
this.Control[iCurrent+10]=this.sle_1
this.Control[iCurrent+11]=this.cb_buscar_exp_origen
this.Control[iCurrent+12]=this.dw_parametros
end on

on w_renuncias.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_buscar_exp_destino)
destroy(this.sle_2)
destroy(this.dw_colegiados_alta)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_colegiados_baja)
destroy(this.sle_1)
destroy(this.cb_buscar_exp_origen)
destroy(this.dw_parametros)
end on

type st_4 from u_st within w_renuncias
integer x = 1769
integer y = 164
integer width = 859
fontcharset fontcharset = ansi!
boolean italic = true
string text = "Chequee los colegiados a dar de alta"
end type

type st_3 from u_st within w_renuncias
integer x = 82
integer y = 164
integer width = 891
fontcharset fontcharset = ansi!
boolean italic = true
string text = "Chequee los colegiados a dar de baja"
end type

type cb_1 from u_cb within w_renuncias
integer x = 73
integer y = 952
integer width = 370
integer taborder = 80
string text = "Generar Cartas"
end type

event clicked;call super::clicked;int i
st_renuncias_impresion imprimir
string id_fase, id_fase_alta
boolean seleccion_alta = false,seleccion_baja = false
string mensaje = ''

id_fase = f_devuelve_id_fase_por_num(sle_1.text)
id_fase_alta = f_devuelve_id_fase_por_num(sle_2.text)

if (sle_1.text = '') then
	mensaje += 'Debe seleccionar un registro para seleccionar colegiados de baja' + '~r'
end if

if (sle_2.text = '') then
	mensaje += 'Debe seleccionar un registro para seleccionar colegiados de alta' + '~r'
end if

for i=1 to dw_colegiados_baja.rowcount()
	if (dw_colegiados_baja.getitemstring(i,'renunciado') = 'S') then
		seleccion_baja = true
		exit
	end if
next

for i=1 to dw_colegiados_alta.rowcount()
	if (dw_colegiados_alta.getitemstring(i,'renunciado') = 'S') then
		seleccion_alta = true
		exit
	end if
next	

if(seleccion_alta = false) then
		mensaje += 'Debe seleccionar por lo menos un colegiado dado de alta' + '~r'
end if
if (seleccion_baja = false) then
	mensaje += 'Debe seleccionar por lo menos un colegiado dado de baja'
end if

if(mensaje = '') then
	openwithparm(w_renuncias_impresion, id_fase)
else
	messagebox(g_titulo,mensaje)
end if

if isvalid(message.powerobjectparm) then
	imprimir = message.powerobjectparm
	f_rellenar_renuncias_tfe(id_fase,id_fase_alta,imprimir.tipo_carta,imprimir.destinatario,integer(imprimir.copias),dw_colegiados_baja,dw_colegiados_alta)
end if
end event

type cb_buscar_exp_destino from u_cb within w_renuncias
integer x = 2761
integer y = 60
integer width = 101
integer height = 80
integer taborder = 50
string text = "..."
end type

event clicked;call super::clicked;string id_fase

//Buscamos las fases
g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_fases"
id_fase=f_busqueda_fases()  
if NOT f_es_vacio(id_fase) then
	sle_2.text = f_dame_n_reg(id_fase)
	dw_colegiados_alta.retrieve(id_fase)
end if
end event

type sle_2 from u_sle within w_renuncias
integer x = 2286
integer y = 64
integer taborder = 40
end type

event modified;call super::modified;string id_fase

id_fase = f_devuelve_id_fase_por_num(this.text)

dw_colegiados_alta.retrieve(id_fase)
end event

type dw_colegiados_alta from u_dw within w_renuncias
integer x = 1760
integer y = 244
integer width = 1637
integer height = 656
integer taborder = 70
string dataobject = "d_renuncias_colegiados_alta"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

this.modify("renunciado_t.text = 'Sustituto'")
end event

type st_2 from u_st within w_renuncias
integer x = 1769
integer y = 72
integer width = 498
string text = "N$$HEX2$$ba002000$$ENDHEX$$Registro Destino"
end type

type st_1 from u_st within w_renuncias
integer x = 82
integer y = 72
integer width = 475
string text = "N$$HEX2$$ba002000$$ENDHEX$$Registro Origen"
end type

type dw_colegiados_baja from u_dw within w_renuncias
integer x = 73
integer y = 244
integer width = 1637
integer height = 656
integer taborder = 60
string dataobject = "d_renuncias_colegiados_baja"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)
end event

event itemchanged;call super::itemchanged;this.accepttext()
end event

type sle_1 from u_sle within w_renuncias
integer x = 571
integer y = 64
integer taborder = 10
end type

event modified;call super::modified;string id_fase

id_fase = f_devuelve_id_fase_por_num(this.text)

dw_colegiados_baja.retrieve(id_fase)
end event

type cb_buscar_exp_origen from u_cb within w_renuncias
integer x = 1047
integer y = 60
integer width = 101
integer height = 80
integer taborder = 30
string text = "..."
end type

event clicked;call super::clicked;string id_fase

//Buscamos las fases
g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida"
g_busqueda.dw="d_lista_busqueda_fases"
id_fase=f_busqueda_fases()  
if NOT f_es_vacio(id_fase) then
	sle_1.text = f_dame_n_reg(id_fase)
	dw_colegiados_baja.retrieve(id_fase)
end if
end event

type dw_parametros from u_dw within w_renuncias
boolean visible = false
integer x = 3150
integer y = 36
integer width = 238
integer height = 104
integer taborder = 20
string dataobject = "d_renuncias_listados_defecto"
end type

