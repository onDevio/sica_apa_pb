HA$PBExportHeader$w_listado_cegas.srw
forward
global type w_listado_cegas from w_sheet
end type
type dw_1 from u_dw within w_listado_cegas
end type
type cb_3 from commandbutton within w_listado_cegas
end type
type cb_1 from commandbutton within w_listado_cegas
end type
type cb_2 from commandbutton within w_listado_cegas
end type
type dw_consulta from u_dw within w_listado_cegas
end type
type st_3 from statictext within w_listado_cegas
end type
type cb_4 from commandbutton within w_listado_cegas
end type
end forward

global type w_listado_cegas from w_sheet
integer width = 3433
integer height = 1760
string title = "Listado Cegas"
windowstate windowstate = maximized!
boolean ib_isupdateable = false
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
dw_consulta dw_consulta
st_3 st_3
cb_4 cb_4
end type
global w_listado_cegas w_listado_cegas

type variables
boolean ib_printpreviewactivado=false
end variables

on w_listado_cegas.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_consulta=create dw_consulta
this.st_3=create st_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_consulta
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.cb_4
end on

on w_listado_cegas.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_consulta)
destroy(this.st_3)
destroy(this.cb_4)
end on

event open;this.of_setresize(true)
f_centrar_ventana(this)

inv_resize.of_Register (dw_1, "ScaleToRight&Bottom")
inv_resize.of_Register (st_3, "FixedToBottom")

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



end event

event pfc_postopen();call super::pfc_postopen;//Recuperamos la consulta de Inicio en caso de que exista
This.Event csd_recuperar_consulta('INICIO')
end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_listado_cegas
integer x = 3474
integer y = 1292
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_listado_cegas
integer x = 3474
integer y = 1172
integer taborder = 20
end type

type dw_1 from u_dw within w_listado_cegas
integer x = 37
integer y = 320
integer width = 3301
integer height = 1196
integer taborder = 0
string dataobject = "d_listado_cegas_exportar"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;dw_1.of_setprintpreview(TRUE)
end event

type cb_3 from commandbutton within w_listado_cegas
integer x = 2016
integer y = 64
integer width = 361
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Fichero"
boolean default = true
end type

event clicked;dw_1.SaveAs("", Excel!, TRUE)

end event

type cb_1 from commandbutton within w_listado_cegas
integer x = 1614
integer y = 64
integer width = 375
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar"
boolean default = true
end type

event clicked;call super::clicked;string t_promo, cliente, domicilio_cli, direccion_cli, poblacion_cli, emplazamiento, n_calle, tipo_via, emplaz
string desc_tipo_via, telefono_cli, cp, poblacion, sql, nif, id_cli
long filas,i,fila
datetime f_desde, f_hasta
datastore ds_lista

dw_consulta.accepttext()

// Validaciones
f_desde = dw_consulta.getitemdatetime(1, 'f_desde')
f_hasta = datetime(date(dw_consulta.getitemdatetime(1, 'f_hasta')), time('23:59:59'))

if isnull(f_desde) then
	messagebox(g_titulo, 'Introduzca la fecha inicial')
	return
end if

if isnull(f_hasta) then
	messagebox(g_titulo, 'Introduzca la fecha final')	
	return
end if

dw_1.reset()
setpointer(hourglass!)
// INICIOS DE OBRA
ds_lista = create datastore
ds_lista.dataObject = 'ds_listado_cegas_inicios_obra'  
ds_lista.SetTransObject(SQLCA)

sql = ds_lista.describe("Datawindow.Table.Select")
f_sql('fases.f_abono','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
f_sql('fases.f_abono','<','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
ds_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
st_3.text='Recuperando inicios de obra...'
ds_lista.Retrieve()

filas = ds_lista.RowCount()
For i = 1 to filas
	// Los datos relativos al promotor y a la direcci$$HEX1$$f300$$ENDHEX$$n de la obra s$$HEX1$$f300$$ENDHEX$$lo se incluir$$HEX1$$e100$$ENDHEX$$n cuando el promotor sea persona jur$$HEX1$$ed00$$ENDHEX$$dica y no cuando sean
	// particulares, comunidades de bienes o comunidades de propietarios. El resto de datos s$$HEX2$$ed002000$$ENDHEX$$deben enviarse.
	t_promo = ds_lista.GetItemString(i,'t_promotor')
	if (t_promo = 'A' or t_promo = 'B' or t_promo = 'C' or t_promo = 'D' or t_promo = 'F' &
		or t_promo = 'S' or t_promo = 'P' or t_promo = 'G' or t_promo = 'Q') then	
		// Datos Cliente
		id_cli = ds_lista.GetItemString(i,'clientes_id_cliente')
		cliente = f_dame_cliente (id_cli)
		nif = f_dame_nif (id_cli)
		direccion_cli = f_dame_domicilio (id_cli)
		poblacion_cli = f_retorna_poblacion (id_cli)
		domicilio_cli = direccion_cli + ' - ' + poblacion_cli
		telefono_cli = ds_lista.GetItemString(i,'clientes_telefono')
		
		// Datos Obra
		tipo_via = ds_lista.GetItemString(i,'fases_tipo_via_emplazamiento')
		desc_tipo_via = f_dame_desc_tipo_via(tipo_via)
		emplaz = ds_lista.GetItemString(i,'fases_emplazamiento')
		n_calle = ds_lista.GetItemString(i,'fases_n_calle')
		
		if f_es_vacio(desc_tipo_via) then desc_tipo_via = ''
		if f_es_vacio(emplaz) then emplaz = ''
		if f_es_vacio(n_calle) then n_calle = ''

		emplazamiento = desc_tipo_via + ' ' + emplaz + ', ' + n_calle
	else
		// Si no se deben enviar los datos, vaciamos
		cliente = ''
		nif = ''
		domicilio_cli = ''
		telefono_cli = ''
		emplazamiento = ''
	end if
	
	fila = dw_1.InsertRow(0)
	dw_1.SetItem(fila,'inicio_final','I')
	dw_1.SetItem(fila,'num_viv',ds_lista.GetItemNumber(i,'fases_usos_num_viv'))
	dw_1.SetItem(fila,'f_visado',ds_lista.GetItemDateTime(i,'fases_f_abono'))	
	dw_1.SetItem(fila,'emplazamiento',emplazamiento)	
	dw_1.SetItem(fila,'cp',LeftA(ds_lista.GetItemString(i,'fases_poblacion'), 5))
	dw_1.SetItem(fila,'poblacion',ds_lista.GetItemString(i,'poblaciones_descripcion'))
	dw_1.SetItem(fila,'nif_cli',nif)
	dw_1.SetItem(fila,'cliente',cliente)
	dw_1.SetItem(fila,'domicilio_cli',domicilio_cli)
	dw_1.SetItem(fila,'telefono_cli',telefono_cli)
Next
destroy ds_lista

// FINALES DE OBRA
ds_lista = create datastore
ds_lista.dataobject = 'ds_listado_cegas_finales_obra'
ds_lista.settransobject(SQLCA)

sql = ds_lista.describe("Datawindow.Table.Select")
f_sql('fases_finales.f_intro','>=','f_desde',dw_consulta,sql,g_tipo_base_datos,'')
f_sql('fases_finales.f_intro','<=','f_hasta',dw_consulta,sql,g_tipo_base_datos,'')
ds_lista.modify("datawindow.table.select= ~"" + sql+ "~"")
st_3.text='Recuperando finales de obra...'
ds_lista.retrieve()

filas = ds_lista.RowCount()
For i = 1 to filas
	// Los datos relativos al promotor y a la direcci$$HEX1$$f300$$ENDHEX$$n de la obra s$$HEX1$$f300$$ENDHEX$$lo se incluir$$HEX1$$e100$$ENDHEX$$n cuando el promotor sea persona jur$$HEX1$$ed00$$ENDHEX$$dica y no cuando sean
	// particulares, comunidades de bienes o comunidades de propietarios. El resto de datos s$$HEX2$$ed002000$$ENDHEX$$deben enviarse.
	t_promo = ds_lista.GetItemString(i,'t_promotor')
	if (t_promo = 'A' or t_promo = 'B' or t_promo = 'C' or t_promo = 'D' or t_promo = 'F' &
		or t_promo = 'S' or t_promo = 'P' or t_promo = 'G' or t_promo = 'Q') then	
		// Datos Cliente
		id_cli = ds_lista.GetItemString(i,'clientes_id_cliente')
		cliente = f_dame_cliente (id_cli)
		nif = f_dame_nif (id_cli)
		direccion_cli = f_dame_domicilio (id_cli)
		poblacion_cli = f_retorna_poblacion (id_cli)
		domicilio_cli = direccion_cli + ' - ' + poblacion_cli
		telefono_cli = ds_lista.GetItemString(i,'clientes_telefono')
		
		// Datos Obra
		tipo_via = ds_lista.GetItemString(i,'fases_tipo_via_emplazamiento')
		desc_tipo_via = f_dame_desc_tipo_via(tipo_via)
		emplaz = ds_lista.GetItemString(i,'fases_emplazamiento')
		n_calle = ds_lista.GetItemString(i,'fases_n_calle')
		
		if f_es_vacio(desc_tipo_via) then desc_tipo_via = ''
		if f_es_vacio(emplaz) then emplaz = ''
		if f_es_vacio(n_calle) then n_calle = ''

		emplazamiento = desc_tipo_via + ' ' + emplaz + ', ' + n_calle
	else
		// Si no se deben enviar los datos, vaciamos
		cliente = ''
		nif = ''
		domicilio_cli = ''
		telefono_cli = ''
		emplazamiento = ''
	end if
	
	fila = dw_1.InsertRow(0)
	dw_1.SetItem(fila,'inicio_final','F')
	dw_1.SetItem(fila,'num_viv',ds_lista.GetItemNumber(i,'fases_usos_num_viv'))
	dw_1.SetItem(fila,'f_visado',ds_lista.GetItemDateTime(i,'fases_finales_fecha'))	
	dw_1.SetItem(fila,'emplazamiento',emplazamiento)	
	dw_1.SetItem(fila,'cp',LeftA(ds_lista.GetItemString(i,'fases_poblacion'), 5))
	dw_1.SetItem(fila,'poblacion',ds_lista.GetItemString(i,'poblaciones_descripcion'))
	dw_1.SetItem(fila,'nif_cli',nif)
	dw_1.SetItem(fila,'cliente',cliente)
	dw_1.SetItem(fila,'domicilio_cli',domicilio_cli)
	dw_1.SetItem(fila,'telefono_cli',telefono_cli)
Next
setpointer(arrow!)
st_3.text='Proceso finalizado'
//S$$HEX1$$f300$$ENDHEX$$lo llamamos a pfc_printpreview() una vez
if ib_printpreviewactivado=false then
	ib_printpreviewactivado=true
	dw_1.event pfc_printpreview()
end if
destroy ds_lista

end event

type cb_2 from commandbutton within w_listado_cegas
integer x = 2807
integer y = 64
integer width = 361
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_consulta from u_dw within w_listado_cegas
integer x = 37
integer y = 32
integer width = 1531
integer taborder = 30
string dataobject = "d_listado_cegas_consulta"
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

type st_3 from statictext within w_listado_cegas
integer x = 37
integer y = 1540
integer width = 974
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_listado_cegas
integer x = 2405
integer y = 64
integer width = 375
integer height = 92
integer taborder = 60
boolean bringtotop = true
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

