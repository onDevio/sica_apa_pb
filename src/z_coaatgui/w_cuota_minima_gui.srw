HA$PBExportHeader$w_cuota_minima_gui.srw
forward
global type w_cuota_minima_gui from w_sheet
end type
type st_1 from statictext within w_cuota_minima_gui
end type
type dw_3 from u_dw within w_cuota_minima_gui
end type
type cb_3 from commandbutton within w_cuota_minima_gui
end type
type cb_2 from commandbutton within w_cuota_minima_gui
end type
type cb_1 from commandbutton within w_cuota_minima_gui
end type
type st_3 from statictext within w_cuota_minima_gui
end type
type dw_2 from u_dw within w_cuota_minima_gui
end type
type st_2 from statictext within w_cuota_minima_gui
end type
type dw_1 from u_dw within w_cuota_minima_gui
end type
end forward

global type w_cuota_minima_gui from w_sheet
integer x = 214
integer y = 221
integer width = 3749
integer height = 2128
string title = "C$$HEX1$$e100$$ENDHEX$$lculo de la Cuota M$$HEX1$$ed00$$ENDHEX$$nima"
string menuname = "m_cerrar"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
event csd_calcular_cuota_minima ( )
st_1 st_1
dw_3 dw_3
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_3 st_3
dw_2 dw_2
st_2 st_2
dw_1 dw_1
end type
global w_cuota_minima_gui w_cuota_minima_gui

event csd_calcular_cuota_minima();datetime f_desde, f_hasta, f_efecto, f_coleg
double i, fila_insertada, Ca, porc_cip, importe_cip, cuota, fila, importe_cip_soc, total_cip
double cuota_maxima=0, base_minima=0, cuota_maxima_no_seguro=0, base_minima_no_seguro=0
string mensaje='', lista_sociedades, id_col

dw_2.reset()
dw_3.accepttext()

f_desde = datetime(date(dw_3.getitemdatetime(1,'f_desde')), time('00:00:00'))
f_hasta = datetime(date(dw_3.getitemdatetime(1,'f_hasta')), time('23:59:59'))
f_efecto = dw_3.getitemdatetime(1,'f_efecto')

mensaje += f_valida(dw_3,'f_desde','NONULO','Debe especificar un valor en el campo fecha desde.')
mensaje += f_valida(dw_3,'f_hasta','NONULO','Debe especificar un valor en el campo fecha hasta.')

//if isnull(dw_3.getitemnumber(1,'cuota_maxima')) then mensaje+= cr+'Debe especificar un valor en el campo cuota m$$HEX1$$e100$$ENDHEX$$xima.'
//if isnull(dw_3.getitemnumber(1,'base_minima')) then mensaje += cr+'Debe especificar un valor en el campo base m$$HEX1$$ed00$$ENDHEX$$nima.'

//// Coeficiente Ca
//SELECT desc_gui_coefs.coef_a 
//INTO :Ca 
//FROM desc_gui_coefs  
//WHERE ( desc_gui_coefs.desde_fecha <= :f_efecto ) AND  
//		( desc_gui_coefs.hasta_fecha > :f_efecto )   ;
//
//if sqlca.sqlcode <> 0 then	
//	mensaje = cr+'No se encuentra el valor del coeficiente Ca'
//end if
	
if mensaje <> '' then
	messagebox(g_titulo, mensaje, stopsign!)
	return 
end if

//cuota_maxima = dw_3.getitemnumber(1,'cuota_maxima')
//base_minima = dw_3.getitemnumber(1,'base_minima')
//cuota_maxima_no_seguro = f_redondea(dw_3.getitemnumber(1,'cuota_maxima_no_seguro')*Ca)
//base_minima_no_seguro = dw_3.getitemnumber(1,'base_minima_no_seguro')

cuota_maxima = dw_3.getitemnumber(1,'cuota')

datastore ds_dic
ds_dic = create datastore
ds_dic.dataobject = 'ds_cuota_minima_importe_dic_gui'
ds_dic.settransobject(sqlca)
ds_dic.retrieve(f_desde, f_hasta)

datastore ds_dic_soc
ds_dic_soc = create datastore
ds_dic_soc.dataobject = 'ds_cuota_minima_importe_dic_socied_gui'
ds_dic_soc.settransobject(sqlca)
ds_dic_soc.retrieve(f_desde, f_hasta)

dw_1.retrieve()
for i = 1 to dw_1.rowcount()
	
//// averiguar si tiene seguro de fallecimiento
//string id_colegiado, sl_tiene_seguro = 'S'
//int cuantos = 0 
//id_colegiado = dw_1.getitemstring(i, 'id_colegiado')
//
//  SELECT count(*) 
//    INTO :cuantos 
//    FROM otros_datos_colegiado  
//   WHERE ( otros_datos_colegiado.id_colegiado = :id_colegiado ) AND  
//         ( otros_datos_colegiado.cod_caracteristica = '03' ) AND
//			( otros_datos_colegiado.s_n = 'S' );
//						
//	if cuantos > 0 then 	sl_tiene_seguro = 'S' else sl_tiene_seguro = 'N'	
	
	id_col = dw_1.getitemstring(i, 'id_colegiado')
	
	fila_insertada = dw_2.insertrow(0)
	dw_2.setitem(fila_insertada, 'id_colegiado', id_col)
	dw_2.setitem(fila_insertada, 'n_colegiado', dw_1.getitemstring(i, 'n_colegiado'))
	dw_2.setitem(fila_insertada, 'nombre_colegiado', dw_1.getitemstring(i, 'compute_3'))
	dw_2.setitem(fila_insertada, 'concepto', '200')	
	dw_2.setitem(fila_insertada, 'forma_de_pago', g_formas_pago.domiciliacion) //dw_1.getitemstring(i, 'forma_de_pago'))	
//	dw_2.setitem(fila_insertada, 'seguro_fall', sl_tiene_seguro)	
//	if sl_tiene_seguro <> 'S' then
//		base_minima = base_minima_no_seguro
//		cuota_maxima = cuota_maxima_no_seguro
//	else
//		base_minima = dw_3.getitemnumber(1,'base_minima')
//		cuota_maxima = f_redondea(dw_3.getitemnumber(1,'cuota_maxima') * Ca)	
//	end if


//	// averiguar la CIP por colegiado de los que est$$HEX1$$e100$$ENDHEX$$n en la lista primera
//	// Excepciones:
//	// 1 - Si ha pasado menos de 2 a$$HEX1$$f100$$ENDHEX$$os desde su primera colegiaci$$HEX1$$f300$$ENDHEX$$n qudar$$HEX1$$ed00$$ENDHEX$$a exento de pago.
//	// 2 - si es un asociado hay que sumar la DIC de visados de su/s sociedades.
//	if DaysAfter ( date(dw_1.getitemdatetime(i, 'f_colegiacion')), date(dw_3.getitemdatetime(1, 'f_efecto')) ) < (365*2) then
//		dw_2.setitem(fila_insertada, 'exento', 'S')	
//	else
//		dw_2.setitem(fila_insertada, 'exento', 'N')	
//	end if
	

	fila = ds_dic.find ("id_colegiado = '" + id_col + "'", 1, ds_dic.rowcount()) 
	if fila > 0 then 
		importe_cip = ds_dic.getitemnumber(fila, 'importe_dic')
	else
		importe_cip = 0
	end if
	
	lista_sociedades = f_colegiados_ids_sociedades(id_col)
	importe_cip_soc= 0
	if not f_es_vacio(lista_sociedades) then 
		fila = ds_dic_soc.find ("id_colegiado = '" + id_col + "'", 1, ds_dic_soc.rowcount())
		if fila > 0 then 
			importe_cip_soc = ds_dic_soc.getitemnumber(fila, 'importe_dic')
		else
			importe_cip_soc = 0		
		end if
	end if
	
	total_cip = round(importe_cip + importe_cip_soc,2)
	
	dw_2.setitem(fila_insertada, 'cip', total_cip)
//	porc_cip = dw_2.getitemnumber(fila_insertada,'cip') / base_minima
//	if porc_cip < 1 then importe_cip = (1 -porc_cip) * cuota_maxima else importe_cip = 0
//	dw_2.setitem(fila_insertada, 'importe', f_redondea(importe_cip))

	if total_cip < (cuota_maxima/2) then
		cuota = (cuota_maxima - total_cip) / 4
	else
		cuota = cuota_maxima / 8
	end if
	if total_cip <= 0 then cuota = (cuota_maxima - 0) / 4

	// Altas del trimestre actual (pagan proporcionalmente, el mes de colegiaci$$HEX1$$f300$$ENDHEX$$n no se cobra)
	f_coleg =  dw_1.getitemdatetime (i, 'f_colegiacion')
	if year(date(f_coleg)) = year(date(f_efecto)) and month(date(f_efecto)) - month(date(f_coleg)) <= 3 then
		cuota = cuota * ((month(date(f_efecto)) - month(date(f_coleg))) / 3)
	end if


//	importe_cip = f_redondea(max(0,cuota_maxima - dw_2.getitemnumber(fila_insertada, 'cip')) / 2)
	dw_2.setitem(fila_insertada, 'importe', f_redondea(cuota))
next

destroy ds_dic
destroy ds_dic_soc
end event

on w_cuota_minima_gui.create
int iCurrent
call super::create
if this.MenuName = "m_cerrar" then this.MenuID = create m_cerrar
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.dw_2=create dw_2
this.st_2=create st_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.dw_1
end on

on w_cuota_minima_gui.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;call super::open;double Ca
dw_3.insertrow(0)

dw_3.setitem(1, 'f_efecto', today())
dw_3.setitem(1, 'f_desde', date('01/01/'+ string(integer(g_ejercicio)-1)))
dw_3.setitem(1, 'f_hasta', date('31/12/'+ string(integer(g_ejercicio)-1)))

// Coeficiente Ca
SELECT desc_gui_coefs.coef_a 
INTO :Ca 
FROM desc_gui_coefs  
WHERE ( desc_gui_coefs.desde_fecha <= getdate() ) AND  
		( desc_gui_coefs.hasta_fecha > getdate() )   ;


dw_3.setitem(1, 'ca', Ca)

of_SetResize (true)
inv_resize.of_Register(dw_2, "scaletobottom")
end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_cuota_minima_gui
integer taborder = 60
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_cuota_minima_gui
integer taborder = 80
end type

type st_1 from statictext within w_cuota_minima_gui
boolean visible = false
integer x = 2766
integer y = 128
integer width = 873
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean italic = true
long textcolor = 255
long backcolor = 80269524
string text = "Las cuotas m$$HEX1$$e100$$ENDHEX$$ximas se multiplicar$$HEX1$$e100$$ENDHEX$$n por Ca en el c$$HEX1$$e100$$ENDHEX$$lculo final al colegiado"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_cuota_minima_gui
integer x = 37
integer y = 32
integer width = 1838
integer height = 324
integer taborder = 10
string dataobject = "d_cuota_minima_parametros_gui"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_3 from commandbutton within w_cuota_minima_gui
integer x = 2752
integer y = 28
integer width = 302
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inicio"
end type

event clicked;setpointer(hourglass!)
parent.trigger event csd_calcular_cuota_minima()
setpointer(arrow!)

end event

type cb_2 from commandbutton within w_cuota_minima_gui
integer x = 3355
integer y = 28
integer width = 302
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Actualizar "
end type

event clicked;integer retorno
double i

if dw_2.rowcount() <= 0 then 
	messagebox(g_titulo, 'No hay datos que actualizar o no se han calculado las cuotas a$$HEX1$$fa00$$ENDHEX$$n')
	return
end if
retorno = messagebox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n: este proceso elimina las cuotas colegiales anteriores y establece las nuevas, $$HEX1$$bf00$$ENDHEX$$Desea continuar?', Question!,YesNo!)

if retorno = 2 then return
	// Primero borramos las antiguas domiciliaciones de Cuota anual 
	delete from conceptos_domiciliables where concepto = '201';
	delete from conceptos_domiciliables where concepto = '200';
commit;

// Eliminamos los que sean 0
for i = dw_2.rowcount() to 1 step -1
	if dw_2.getitemnumber(i, 'importe') = 0 /*or dw_2.getitemstring(i, 'exento') = 'S'*/ then dw_2.setitemstatus(i, 0, Primary!, NotModified!)
next

// Actualizamos las nuevas Cuotas
dw_2.update()
commit;

// Reseteamos el dw y los flags
dw_2.reset()

end event

type cb_1 from commandbutton within w_cuota_minima_gui
integer x = 3054
integer y = 28
integer width = 302
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Listado Prev."
end type

event clicked;if dw_2.rowcount() <= 0 then
	messagebox(g_titulo, 'No existen datos todav$$HEX1$$ed00$$ENDHEX$$a, pulse el bot$$HEX1$$f300$$ENDHEX$$n de inicio')
	return
end if

dw_2.print()

end event

type st_3 from statictext within w_cuota_minima_gui
integer x = 37
integer y = 1132
integer width = 869
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuotas colegiales"
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_cuota_minima_gui
integer x = 37
integer y = 1204
integer width = 3625
integer height = 660
integer taborder = 70
string dataobject = "d_lista_cuota_minima_gui"
boolean hscrollbar = true
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

// Enable printpreview service
of_SetPrintPreview (true)


end event

type st_2 from statictext within w_cuota_minima_gui
integer x = 37
integer y = 384
integer width = 1019
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Colegiados"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_cuota_minima_gui
integer x = 37
integer y = 460
integer width = 3625
integer height = 652
integer taborder = 50
string dataobject = "d_lista_cuota_colegial_gui"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event dw_1::constructor;call super::constructor;//this.of_SetRowSelect(TRUE)
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

// Enable printpreview service
of_SetPrintPreview (true)


end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = false
end event

