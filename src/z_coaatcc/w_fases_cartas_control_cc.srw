HA$PBExportHeader$w_fases_cartas_control_cc.srw
forward
global type w_fases_cartas_control_cc from w_response
end type
type cb_2 from commandbutton within w_fases_cartas_control_cc
end type
type dw_lista from u_dw within w_fases_cartas_control_cc
end type
type dw_consulta from u_dw within w_fases_cartas_control_cc
end type
type cb_3 from commandbutton within w_fases_cartas_control_cc
end type
end forward

global type w_fases_cartas_control_cc from w_response
integer width = 3378
integer height = 1928
string title = "Carta aviso colegiados"
boolean ib_isupdateable = false
cb_2 cb_2
dw_lista dw_lista
dw_consulta dw_consulta
cb_3 cb_3
end type
global w_fases_cartas_control_cc w_fases_cartas_control_cc

type variables

end variables

on w_fases_cartas_control_cc.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_lista=create dw_lista
this.dw_consulta=create dw_consulta
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.dw_consulta
this.Control[iCurrent+4]=this.cb_3
end on

on w_fases_cartas_control_cc.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_lista)
destroy(this.dw_consulta)
destroy(this.cb_3)
end on

event open;call super::open;string mes, anyo, fecha

mes = string(month(today()))
anyo = string(year(today()))
fecha = '01/'+mes+'/'+anyo

f_centrar_ventana(this)

dw_consulta.insertrow(0)
dw_consulta.setitem(1, 'f_abono_desde', datetime(date(fecha)))
dw_consulta.setitem(1, 'f_abono_hasta', datetime(relativedate(today(),1)))

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_cartas_control_cc
integer x = 2080
integer y = 1420
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_cartas_control_cc
integer x = 2080
integer y = 1292
integer taborder = 0
end type

type cb_2 from commandbutton within w_fases_cartas_control_cc
integer x = 2912
integer y = 1644
integer width = 416
integer height = 112
integer taborder = 50
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

type dw_lista from u_dw within w_fases_cartas_control_cc
integer x = 37
integer y = 544
integer width = 3291
integer height = 1032
integer taborder = 20
string dataobject = "d_fases_cartas_control_lista_carta_src_cc"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type dw_consulta from u_dw within w_fases_cartas_control_cc
integer x = 37
integer y = 104
integer width = 2267
integer height = 292
integer taborder = 10
string dataobject = "d_fases_cartas_control_consulta_cc"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;datetime f_desde, f_hasta

CHOOSE CASE dwo.name
	CASE 'b_1'
		SetPointer(HourGlass!)
		dw_consulta.AcceptText()
		
		f_desde = dw_consulta.getitemdatetime(1, 'f_abono_desde')
		f_hasta = dw_consulta.getitemdatetime(1, 'f_abono_hasta')
		
		if isnull(f_desde) or isnull(f_hasta) then 
			messagebox(g_titulo, "Debe introducir las fechas de consulta", exclamation!)
			return
		else
			dw_lista.retrieve(f_desde, f_hasta)	
		end if
END CHOOSE


end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)

end event

event itemchanged;call super::itemchanged;datetime f_ini
double mes

CHOOSE CASE dwo.name
	CASE 'tipo_carta'
		CHOOSE CASE data
			CASE '1'
				dw_lista.dataobject = 'd_fases_cartas_control_lista_carta_src'
				dw_lista.settransobject(sqlca)
				// Ponemos las fechas para que las saque todas
				this.setitem(1, 'f_abono_desde', datetime(date('01/01/1900')))
				this.setitem(1, 'f_abono_hasta', datetime(relativedate(today(),1)))
			CASE '2'
				dw_lista.dataobject = 'd_fases_cartas_control_lista_carta_cfo'
				dw_lista.settransobject(sqlca)
				// Calculamos las fechas (hace 24 meses)
				f_ini = datetime(date('01/' + string(month(today())) + '/' + string(year(today())-2)))
				this.setitem(1, 'f_abono_desde', f_ini)
				this.setitem(1, 'f_abono_hasta', f_ultimo_dia_mes (f_ini))
			CASE '3'
				dw_lista.dataobject = 'd_fases_cartas_control_lista_carta_tr'
				dw_lista.settransobject(sqlca)
				// Calculamos las fechas (hace 3 meses)
				mes = month(today())
				mes = mes - 3
				if mes <= 0 then mes = mes + 12
				f_ini = datetime(date('01/' + string(mes) + '/' + string(year(today()))))
				this.setitem(1, 'f_abono_desde', f_ini)
				this.setitem(1, 'f_abono_hasta', f_ultimo_dia_mes (f_ini))
		END CHOOSE
END CHOOSE

end event

type cb_3 from commandbutton within w_fases_cartas_control_cc
integer x = 32
integer y = 1644
integer width = 416
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Generar Cartas"
end type

event clicked;string id_fase
long i

for i=1 to dw_lista.rowcount( )
	if(dw_lista.getitemstring(i,'seleccion') = 'S')then
		id_fase = dw_lista.getitemstring(i,'fases_id_fase')
		f_rellenar_carta_colegiados_cc(id_fase,'',1)
	end if
next
//string tipo_carta
//datetime f_desde, f_hasta
//n_csd_plantillas uo_plantillas
//
//// Si no hay datos no hacemos nada
//if dw_lista.rowcount() = 0 then return
//
//// Creamos el objeto de plantillas y rellenamos sus parametros
//uo_plantillas=create n_csd_plantillas
//uo_plantillas.mdb='cartas_control.txt'
//uo_plantillas.ruta_mdb=g_directorio_rtf+'cartas_control.txt'
//
//f_desde = dw_consulta.getitemdatetime(1, 'f_abono_desde')
//f_hasta = dw_consulta.getitemdatetime(1, 'f_abono_hasta')
//
//tipo_carta = dw_consulta.getitemstring(1, 'tipo_carta')
//
//dw_lista.setredraw(false)
//
//CHOOSE CASE tipo_carta
//	CASE '1'
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARTSSR.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '1') = 1 then uo_plantillas.f_combinar_plantilla_txt()		
//	CASE '2'
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARSS04.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '21') = 1 then uo_plantillas.f_combinar_plantilla_txt()
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARSS05.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '22') = 1 then uo_plantillas.f_combinar_plantilla_txt()
//	CASE '3'
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARSS01.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '31') = 1 then uo_plantillas.f_combinar_plantilla_txt()
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARSS02.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '32') = 1 then uo_plantillas.f_combinar_plantilla_txt()
//		uo_plantillas.ruta_plantilla = g_directorio_rtf+'CARSS03.doc'
//		if f_rellena_txt_plantillas(dw_lista, f_desde, f_hasta, '33') = 1 then uo_plantillas.f_combinar_plantilla_txt()
//END CHOOSE
//
//dw_lista.setfilter("")
//dw_lista.filter()
//dw_lista.setredraw(true)
//
end event

