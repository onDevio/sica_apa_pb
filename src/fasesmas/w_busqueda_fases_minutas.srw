HA$PBExportHeader$w_busqueda_fases_minutas.srw
forward
global type w_busqueda_fases_minutas from w_response
end type
type dw_busqueda_avisos from u_dw within w_busqueda_fases_minutas
end type
type cb_buscar_avisos from commandbutton within w_busqueda_fases_minutas
end type
type dw_avisos from u_dw within w_busqueda_fases_minutas
end type
type cb_aceptar from commandbutton within w_busqueda_fases_minutas
end type
type cb_cancelar from commandbutton within w_busqueda_fases_minutas
end type
end forward

global type w_busqueda_fases_minutas from w_response
integer width = 3735
integer height = 1708
dw_busqueda_avisos dw_busqueda_avisos
cb_buscar_avisos cb_buscar_avisos
dw_avisos dw_avisos
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_busqueda_fases_minutas w_busqueda_fases_minutas

type variables
string isql_original_avisos,isql_aplicado_consulta_avisos
end variables

on w_busqueda_fases_minutas.create
int iCurrent
call super::create
this.dw_busqueda_avisos=create dw_busqueda_avisos
this.cb_buscar_avisos=create cb_buscar_avisos
this.dw_avisos=create dw_avisos
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda_avisos
this.Control[iCurrent+2]=this.cb_buscar_avisos
this.Control[iCurrent+3]=this.dw_avisos
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.cb_cancelar
end on

on w_busqueda_fases_minutas.destroy
call super::destroy
destroy(this.dw_busqueda_avisos)
destroy(this.cb_buscar_avisos)
destroy(this.dw_avisos)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;string id_col,n_col

id_col=Message.StringParm
f_centrar_ventana(this)
this.title=g_busqueda.titulo

dw_busqueda_avisos.insertrow(0)

select n_colegiado into :n_col from colegiados where id_colegiado=:id_col;

dw_busqueda_avisos.SetItem(1,'id_col',id_col)
dw_busqueda_avisos.SetItem(1,'n_col',n_col)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_busqueda_fases_minutas
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_busqueda_fases_minutas
end type

type dw_busqueda_avisos from u_dw within w_busqueda_fases_minutas
integer x = 55
integer y = 24
integer width = 3579
integer height = 188
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_caja_avisos_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event buttonclicked;call super::buttonclicked;string id_col

CHOOSE CASE dwo.name
	CASE 'b_1'
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		//Comprobamos que el colegiado existe
		if id_col="-1" then
			messagebox(g_titulo,'Debe introducir un n$$HEX1$$fa00$$ENDHEX$$mero de colegiado v$$HEX1$$e100$$ENDHEX$$lido.')
			this.setfocus()
			return -1
		else
			this.SetItem(1,'id_col',id_col)
			this.SetItem(1,'n_col',f_colegiado_n_col(id_col))				
		end if
END CHOOSE

end event

event itemchanged;call super::itemchanged;string id_col

CHOOSE CASE dwo.name
	CASE 'unico_n_salida'
		// No hacemos nada
	CASE 'n_col'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_col', id_col)		
	CASE ELSE
		// Lanzamos al evento del bot$$HEX1$$f300$$ENDHEX$$n
		cb_buscar_avisos.trigger event clicked()
END CHOOSE

end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

type cb_buscar_avisos from commandbutton within w_busqueda_fases_minutas
integer x = 2674
integer y = 80
integer width = 402
integer height = 96
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo

cb_aceptar.enabled=false

// Aceptamos el texto que ponga
dw_busqueda_avisos.trigger event pfc_accepttext(true)

if f_es_vacio(dw_busqueda_avisos.GetItemString(1,'n_col')) then dw_busqueda_avisos.SetItem(1,'id_col','')

// Pillamos la SQL
sql_nuevo = dw_avisos.describe("datawindow.table.select")

f_sql('expedientes.n_expedi','LIKE','n_expediente',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases.n_registro','LIKE','n_registro',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases_minutas.n_aviso','LIKE','n_aviso',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
f_sql('fases_minutas.id_colegiado','=','id_col',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')

if dw_busqueda_avisos.dataobject='d_caja_avisos_frac_busqueda' then
	f_sql('fases_minutas.forma_pago','LIKE','formapago',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
	f_sql('fases_minutas.fecha','<=','fecha_h',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')
else
	// Parametrizado para GC  CGC-96
//	if g_colegio<>'COAATGC' then f_sql('fases.modalidad','LIKE','centro',dw_busqueda_avisos,sql_nuevo,g_tipo_base_datos,'')	
end if

// Modificamos la SQL
dw_avisos.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_avisos.retrieve()
isql_aplicado_consulta_avisos = sql_nuevo

if dw_avisos.rowcount()>0 then cb_aceptar.enabled=true

end event

type dw_avisos from u_dw within w_busqueda_fases_minutas
integer x = 9
integer y = 220
integer width = 3666
integer height = 1268
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_fases_busqueda_minutas_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;// POnemos el gestor de lineas para que salga el azul al pinchar
this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)

// Cogemos la sql del dw
isql_original_avisos = dw_avisos.describe("datawindow.table.select")

end event

event itemchanged;call super::itemchanged;string pagador
long fila


CHOOSE CASE dwo.name
	CASE 'procesar'
		if string(data) = 'S' then
			setpointer(hourglass!)
			if dw_avisos.getitemString(row, 'desmarcado_manual') = 'S' then
				// Est$$HEX2$$e1002000$$ENDHEX$$volviendo a marcar una que hab$$HEX1$$ed00$$ENDHEX$$a desmarcado
				dw_avisos.Setitem(row, 'desmarcado_manual', 'N')
			else
				// Al pulsar procesar se marcar$$HEX1$$e100$$ENDHEX$$n todos los correspondientes al pagador
				pagador = dw_avisos.getitemString(row, 'nombre_pagador')
	
				FOR fila = 1 TO dw_avisos.RowCount()
					if fila<>row then
						if pagador = dw_avisos.getitemString(fila, 'nombre_pagador') and dw_avisos.getitemString(fila, 'desmarcado_manual') = 'N' then
							// Marcamos la linea para procesarla, siempre y cuando no hubiese sido desmarcada de forma manual
							dw_avisos.Setitem(fila, 'procesar', 'S')
						end if
					end if
				NEXT
			end if
			setpointer(arrow!)
		else
			// EStamos en el caso en que est$$HEX2$$e1002000$$ENDHEX$$desmarcando, por lo que indicamos que la desmarca de forma manual			
			dw_avisos.Setitem(row, 'desmarcado_manual', 'S')
		end if
		
END CHOOSE
end event

event retrieveend;call super::retrieveend;// REstauramos la sql
dw_avisos.modify("datawindow.table.select= ~"" + isql_original_avisos + "~"")
end event

event key;call super::key;// LLamamos al key de la ventana
parent.trigger event key(key, keyflags)

end event

event csd_tecla;call super::csd_tecla;parent.event key (key, keyflags)
end event

event doubleclicked;call super::doubleclicked;if row<=0 then return
CloseWithReturn(parent,dw_avisos.GetItemString(row,'id_minuta'))
end event

type cb_aceptar from commandbutton within w_busqueda_fases_minutas
integer x = 1088
integer y = 1524
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Devolver"
end type

event clicked;CloseWithReturn(parent,dw_avisos.GetItemString(dw_avisos.GetRow(),'id_minuta'))
end event

type cb_cancelar from commandbutton within w_busqueda_fases_minutas
integer x = 1481
integer y = 1524
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

