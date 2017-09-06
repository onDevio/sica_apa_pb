HA$PBExportHeader$w_consejo.srw
forward
global type w_consejo from w_sheet
end type
type st_1 from statictext within w_consejo
end type
type cb_3 from commandbutton within w_consejo
end type
type cb_2 from commandbutton within w_consejo
end type
type cb_1 from commandbutton within w_consejo
end type
type dw_consulta from u_dw within w_consejo
end type
type dw_1 from u_dw within w_consejo
end type
end forward

global type w_consejo from w_sheet
integer width = 2935
integer height = 1560
string title = "Visados Consejo"
windowstate windowstate = maximized!
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_consulta dw_consulta
dw_1 dw_1
end type
global w_consejo w_consejo

on w_consejo.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_consulta=create dw_consulta
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.dw_1
end on

on w_consejo.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_consulta)
destroy(this.dw_1)
end on

event open;call super::open;this.of_setresize(true)
f_centrar_ventana(this)

inv_resize.of_Register (dw_1, "ScaleToRight&Bottom")

dw_consulta.InsertRow(0)
dw_consulta.SetFocus()

long mes,anyo
datetime f_desde
mes = Month(today())
anyo = Year(today())
f_desde = datetime(date("01/"+string(mes)+"/"+string(anyo)))

string m
if LenA(string(mes)) = 1 then 
	m = '0' + string(mes)
else
	m = string(mes)
end if

dw_consulta.setitem(1, 'mes', m)
dw_consulta.setitem(1, 'f_desde', f_desde)
dw_consulta.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
dw_consulta.setitem(1,'cod_colegio_dest', g_cod_colegio)

end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_consejo
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_consejo
end type

type st_1 from statictext within w_consejo
integer x = 32
integer y = 32
integer width = 1637
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 33554432
long backcolor = 79741120
string text = "Seleccione el periodo deseado de b$$HEX1$$fa00$$ENDHEX$$squeda y pulse Generar..."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_consejo
integer x = 2066
integer y = 128
integer width = 375
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_1.print()

end event

type cb_2 from commandbutton within w_consejo
integer x = 2469
integer y = 128
integer width = 375
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_consejo
integer x = 1669
integer y = 128
integer width = 375
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar"
boolean default = true
end type

event clicked;long filas,i
integer fichero
string linea
string NombreFichero
string sdireccion,snumero,spoblacion,sdespobla,sPresup,sTipoObra,sDestino,sPromotor,sNumEdif,sNumViv,snumvivvpo,stipovia
string snomcli,sdircli,scpcli,spobcli,sprovcli,sapell
double presup
long NumEdif,NumViv,numvivvpo
datastore ds_datos_obras
datetime f_desde, f_hasta

dw_consulta.accepttext()

f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = datetime(date(dw_consulta.getitemdatetime(1, 'f_hasta')), time('23:59:59'))

dw_1.reset()

ds_datos_obras = create datastore
ds_datos_obras.dataobject = 'ds_consejo'
ds_datos_obras.settransobject(SQLCA)

//ds_datos_obras.Retrieve(f_desde,f_hasta)
string sql
sql = ds_datos_obras.describe("Datawindow.Table.Select")

// Se puede consultar por fecha abono o por fecha de visado
if dw_consulta.getitemstring(1, 'fecha') = 'V' then
	f_sql('fases.f_visado','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_visado','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
else
	f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
	f_sql('fases.f_abono','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
end if
//SCP-1367 Agregado filtrado por colegio destino
f_sql('fases.cod_colegio_dest','=','cod_colegio_dest', dw_consulta,sql,g_tipo_base_datos,'')

ds_datos_obras.modify("datawindow.table.select= ~"" + sql+ "~"")
ds_datos_obras.Retrieve()

filas = ds_datos_obras.RowCount()

NombreFichero = "CONSEJO.TXT"

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02
if GetFileSaveName('Seleccione nombre de fichero',nombrefichero,nombrefichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return

fichero = FileOpen(NombreFichero,LineMode!,Write!,LockWrite!,Replace!)

if fichero = -1 then 
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	
	Messagebox(g_titulo,'Ha habido un error accediendo al fichero.',StopSign!)
	return
end if

For i = 1 to filas
	dw_1.insertrow(i)
//sPromotor = Mid(ds_datos_obras.GetItemString(i,'clientes_nif'),1,1)
//if (sPromotor >= "0" and sPromotor <= "9") then sPromotor = "X"
//if spromotor = 'E' or spromotor ='H' or spromotor ='X' then goto salto

// N$$HEX2$$ba002000$$ENDHEX$$Resgistro (solo en el listado no en el fichero)
	dw_1.setitem(i, 'n_registro', ds_datos_obras.GetItemString(i,'fases_n_registro'))

// Direccion
   stipovia = ds_datos_obras.GetItemString(i,'tipos_via_descripcion')
   if isnull(stipovia) Then stipovia = ''
	sdireccion = stipovia + ' ' + ds_datos_obras.GetItemString(i,'fases_emplazamiento')
	if isnull(sdireccion) Then sdireccion = space(50)
	sdireccion = f_completar_con_caracteres(sdireccion,50,'D',' ')
	sdireccion = LeftA(sdireccion, 50)
	dw_1.setitem(i, 'direccion', sdireccion)
// Numero
   snumero = ds_datos_obras.GetItemString(i,'fases_n_calle')
	if isnull(snumero) Then snumero = space(5)
	snumero = f_completar_con_caracteres(snumero,5,'I',' ')
	snumero = LeftA(snumero, 5)
	dw_1.setitem(i, 'numero', snumero)
// Cpostal
   spoblacion = ds_datos_obras.GetItemString(i,'fases_poblacion')
	string tipo, cp_asoc
	SELECT tipo, cp_asociado   INTO :tipo, :cp_asoc FROM poblaciones WHERE poblaciones.cod_pob = :spoblacion   ;
	if tipo = 'M' then spoblacion = cp_asoc
	if isnull(spoblacion) Then spoblacion = space(5)
	spoblacion = f_completar_con_caracteres(spoblacion,5,'I',' ')
	spoblacion = LeftA(spoblacion, 5)
	dw_1.setitem(i, 'cp', spoblacion)
// Sdespobla
   sdespobla = ds_datos_obras.GetItemString(i,'poblaciones_descripcion')
	if isnull(sdespobla) Then sdespobla = space(200)
	sdespobla = f_completar_con_caracteres(sdespobla,200,'D',' ')
	sdespobla = LeftA(sdespobla, 200)
	dw_1.setitem(i, 'pobla', sdespobla)
// Presupuesto en MILES
   Presup = round((ds_datos_obras.GetItemnumber(i,'fases_usos_pem') * 100) ,0)
  	presup = round(presup / 100000,0)
	sPresup = string(Presup,'#######0')
	sPresup = RightA(f_completar_con_caracteres(sPresup,8,'I',' '),8)
	if isnull(sPresup) then sPresup = space(8)
	sPresup = LeftA(sPresup, 8)
	dw_1.setitem(i, 'presup', Presup)
// Tipo de Obra
	sTipoObra = ds_datos_obras.GetItemString(i,'fases_tipo_trabajo')
	if f_es_vacio(sTipoObra) Then sTipoObra = space(2)
	sTipoObra = LeftA(sTipoObra, 2)	
	dw_1.setitem(i, 'tipo_obra', sTipoObra)
// Destino
	sDestino = ds_datos_obras.GetItemString(i,'fases_trabajo')
	if f_es_vacio(sDestino) Then sDestino = space(2)
	sDestino = LeftA(sDestino, 2)
	dw_1.setitem(i, 'destino', sDestino)
// Nif Promotor
	sPromotor = ds_datos_obras.GetItemString(i,'t_promotor')
	if f_es_vacio(sPromotor) then sPromotor = ' '
	dw_1.setitem(i, 'nif_promo', sPromotor)
// Numero de Edificios
	NumEdif = ds_datos_obras.GetItemNumber(i,'fases_usos_num_edif')
  	if isnull(NumEdif) then NumEdif = 0
	sNumEdif = f_completar_con_caracteres(string(NumEdif),3,'I',' ')
	sNumEdif = LeftA(sNumEdif, 3)
	dw_1.setitem(i, 'n_edif', NumEdif)
// Numero de Viviendas
	NumViv = ds_datos_obras.GetItemNumber(i,'fases_usos_num_viv')
	if isnull(NumViv) then NumViv = 0
	sNumViv = f_completar_con_caracteres(string(NumViv),5,'I',' ')
	sNumViv = LeftA(sNumViv, 5)
	dw_1.setitem(i, 'n_viv', NumViv)
// V.P.O.
	if ds_datos_obras.GetItemString(i,'fases_usos_tipo_viv') = '0' then
		NumVivvpo = ds_datos_obras.GetItemNumber(i,'fases_usos_num_viv')
	  if isnull(NumVivvpo) then NumVivvpo = 0
	  sNumVivvpo = f_completar_con_caracteres(string(NumVivvpo),4,'I',' ')
	  sNumVivvpo = LeftA(sNumVivvpo, 4)
	  dw_1.setitem(i, 'vpo', NumVivvpo)
   else
		snumvivvpo = '   0'
		dw_1.setitem(i, 'vpo', 0)
	end if
//	Razon Social Promotor
   snomcli = ds_datos_obras.GetItemString(i,'clientes_apellidos')
	if isnull(snomcli) Then snomcli = space(50)
	snomcli = f_completar_con_caracteres(snomcli,50,'D',' ')
	snomcli = LeftA(snomcli, 50)
	dw_1.setitem(i, 'promo_rs', snomcli)	
//	Direccion Promotor
   stipovia = ds_datos_obras.GetItemString(i,'clientes_tipo_via')
   if isnull(stipovia) Then 
		stipovia = ''
	else
		stipovia = f_dame_desc_tipo_via(stipovia)
	end if
	sdircli = stipovia + ' ' + ds_datos_obras.GetItemString(i,'clientes_nombre_via')
	if isnull(sdircli) Then sdircli = space(50)
	sdircli = f_completar_con_caracteres(sdircli,50,'D',' ')
	sdircli = LeftA(sdircli, 50)
	dw_1.setitem(i, 'promo_dir', sdircli)	
// Cpostal Promotor
   scpcli = ds_datos_obras.GetItemString(i,'clientes_cp')
	SELECT tipo, cp_asociado   INTO :tipo, :cp_asoc FROM poblaciones WHERE poblaciones.cod_pob = :scpcli   ;
	if tipo = 'M' then scpcli = cp_asoc	
	if isnull(scpcli) Then scpcli = space(5)
	scpcli = f_completar_con_caracteres(scpcli,5,'I',' ')
	scpcli = LeftA(scpcli, 5)
	dw_1.setitem(i, 'promo_cp', scpcli)
// Poblacion Promotor
   spobcli = ds_datos_obras.GetItemString(i,'clientes_cod_pob')
	spobcli = f_dame_poblacion(spobcli)
	if f_es_vacio(spobcli) Then spobcli = space(50)
	spobcli = f_completar_con_caracteres(spobcli,50,'D',' ')
	spobcli = LeftA(spobcli, 50)
	dw_1.setitem(i, 'promo_pob', spobcli)
// Provincia Promotor
   sprovcli = ds_datos_obras.GetItemString(i,'clientes_cod_prov')
	sprovcli = f_devuelve_desc_provincia(sprovcli)
	if sprovcli = '-1' Then sprovcli = space(50)
	sprovcli = f_completar_con_caracteres(sprovcli,50,'D',' ')
	sprovcli = LeftA(sprovcli, 50)
	dw_1.setitem(i, 'promo_prov', sprovcli)	
		
		
	linea = sdireccion + snumero + spoblacion + sdespobla + spresup + stipoobra + sdestino + spromotor + snumedif + snumviv + snumvivvpo + snomcli + sdircli + scpcli + spobcli + sprovcli
  
	FileWrite(fichero,linea)
//salto:
Next

FileClose(fichero)
destroy ds_datos_obras

// Lo quito porque ralentiza la inserci$$HEX1$$f300$$ENDHEX$$n de filas
//dw_1.of_setprintpreview(TRUE)
//dw_1.event pfc_printpreview()

messagebox(g_titulo,'Fin del proceso, ya tienes el fichero generado como ' + nombrefichero)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type dw_consulta from u_dw within w_consejo
integer x = 37
integer y = 96
integer width = 1737
integer height = 396
integer taborder = 10
string dataobject = "d_consejo_consulta"
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

event itemchanged;call super::itemchanged;datetime f_desde

CHOOSE CASE dwo.name
	CASE 'mes'
		f_desde = datetime(date('01/'+data+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
END CHOOSE	

end event

type dw_1 from u_dw within w_consejo
integer x = 27
integer y = 512
integer width = 2811
integer height = 904
integer taborder = 0
string dataobject = "d_consejo_listado"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

