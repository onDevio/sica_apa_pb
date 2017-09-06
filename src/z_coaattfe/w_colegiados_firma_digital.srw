HA$PBExportHeader$w_colegiados_firma_digital.srw
forward
global type w_colegiados_firma_digital from w_mant_busq
end type
type cb_salir from commandbutton within w_colegiados_firma_digital
end type
type cb_imprimir from commandbutton within w_colegiados_firma_digital
end type
type cb_borrar_todos from u_cb within w_colegiados_firma_digital
end type
type dw_consulta from u_dw within w_colegiados_firma_digital
end type
end forward

global type w_colegiados_firma_digital from w_mant_busq
integer width = 4073
integer height = 1844
string title = "Firmas Digitales"
cb_salir cb_salir
cb_imprimir cb_imprimir
cb_borrar_todos cb_borrar_todos
dw_consulta dw_consulta
end type
global w_colegiados_firma_digital w_colegiados_firma_digital

type variables
datastore  ids_print

end variables

on w_colegiados_firma_digital.create
int iCurrent
call super::create
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.cb_borrar_todos=create cb_borrar_todos
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salir
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.cb_borrar_todos
this.Control[iCurrent+4]=this.dw_consulta
end on

on w_colegiados_firma_digital.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.cb_borrar_todos)
destroy(this.dw_consulta)
end on

event open;call super::open;//Ponemos una nueva fila vacia.
dw_consulta.insertrow(0)
dw_1.retrieve()

inv_resize.of_Register (cb_imprimir, "FixedtoBottom")
inv_resize.of_Register (cb_salir, "FixedtoRight&Bottom")
inv_resize.of_Register (cb_borrar_todos, "FixedtoBottom")


//ids_print = create datastore
//ids_print.dataobject = 'd_conceptos_listado'
//
//dw_1.sharedata(ids_print)
//
end event

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje, ls_concepto, id_col, conc, existe, id_col_original, conc_original
int fila, retorno=1, ll_tamanyoarray, i
st_array_bd_pk_2 lst_retorno
dwitemstatus status

if f_puedo_escribir(g_usuario,'COLEGFIRMA')=-1 then return -1

//Se debe asignar un valor al colegiado, al concepto y a la forma de pago
mensaje += f_valida(dw_1,'id_colegiado','NOVACIO','Debe especificar un colegiado.')
mensaje += f_valida(dw_1,'estado','NOVACIO','Debe especificar un estado.')
mensaje += f_valida(dw_1,'f_estado','NONULO','Debe especificar una fecha de estado.')


//// Comprobamos que no hay duplicados para la clave primaria
//lst_retorno = f_buscar_duplicados_pk_2(dw_1, 'id_colegiado', 'concepto')
//ll_tamanyoarray = upperbound(lst_retorno.vector)
//if ll_tamanyoarray>0 then
//	mensaje='Los siguientes valores est$$HEX1$$e100$$ENDHEX$$n repetidos:'
//	for i=1 to ll_tamanyoarray
//		select descripcion into :ls_concepto from csi_articulos_servicios where codigo=:lst_retorno.vector[i].col2;
//		mensaje=mensaje+cr+f_colegiado_n_col(lst_retorno.vector[i].col1)+' - '+ls_concepto
//	next
//else
//	// Comprobamos que no existen en la bd las filas a$$HEX1$$f100$$ENDHEX$$adidas o modificadas
//	For fila = 1 to dw_1.RowCount()
//		status = dw_1.GetItemStatus(fila,0,Primary!)
//		IF status = NewModified! then
//			id_col=dw_1.GetItemString(fila,'id_colegiado')
//			conc=dw_1.GetItemString(fila,'concepto')
//			
//			SELECT id_colegiado  INTO :existe  FROM conceptos_domiciliables
//			WHERE ( id_colegiado = :id_col ) AND  ( concepto = :conc )   ;
//	
//			if not f_es_vacio(existe) then mensaje += cr + 'Los valores de la fila '+string(fila) + ' ya existen en la base de datos.'
//		END IF 
//		IF status = dataModified!  then
//			id_col=dw_1.GetItemString(fila,'id_colegiado')
//			conc=dw_1.GetItemString(fila,'concepto')
//			id_col_original=dw_1.GetItemString(fila,'id_colegiado', primary!, true)
//			conc_original=dw_1.GetItemString(fila,'concepto', primary!, true)
//			
//			if id_col <> id_col_original or conc <> conc_original then
//				SELECT id_colegiado  INTO :existe  FROM conceptos_domiciliables  
//				WHERE ( id_colegiado = :id_col ) AND ( concepto = :conc )   ;
//		
//				if not f_es_vacio(existe) then mensaje += cr + 'Los valores de la fila '+string(fila) + ' ya existen en la base de datos.'
//			end if
//		end if
//	Next
//end if

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno

end event

type cb_recuperar_pantalla from w_mant_busq`cb_recuperar_pantalla within w_colegiados_firma_digital
end type

type cb_guardar_pantalla from w_mant_busq`cb_guardar_pantalla within w_colegiados_firma_digital
end type

type dw_1 from w_mant_busq`dw_1 within w_colegiados_firma_digital
integer x = 32
integer y = 608
integer width = 3963
integer height = 868
integer taborder = 120
string dataobject = "d_colegiados_firma_digital"
end type

event dw_1::constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yy")
this.iuo_calendar.of_SetInitialValue(True)

//this.of_SetRowSelect(TRUE)
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

event dw_1::buttonclicked;call super::buttonclicked;string id_col, delegacion, email
int cant

CHOOSE CASE dwo.name
	CASE 'b_busq_col'
		//Introducimos el c$$HEX1$$f300$$ENDHEX$$digo necesario para hacer una b$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida
		g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
		g_busqueda.dw="d_lista_busqueda_colegiados"
		id_col=f_busqueda_colegiados()
		if f_es_vacio(id_col) then return
		this.setitem(row,'id_colegiado',id_col)
		this.setitem(row,'n_colegiado',f_colegiado_n_col(id_col))
		SELECT delegaciones.descripcion  INTO :delegacion  FROM colegiados, delegaciones  
		WHERE ( colegiados.delegacion = delegaciones.cod_delegacion ) and  
				( ( colegiados.id_colegiado = :id_col ) )   ;
		this.SetItem(row,'delegacion', delegacion)
		select email into :email from colegiados where id_colegiado = :id_col ;
		this.SetItem(row,'email', email)		
END CHOOSE

end event

event type long dw_1::pfc_insertrow();call super::pfc_insertrow;dw_1.SetItem(getrow(),'f_estado',datetime(today()))
return ancestorreturnvalue
end event

event dw_1::pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_debug.enabled = false
end event

event dw_1::itemchanged;call super::itemchanged;string id_col, delegacion, email

choose case dwo.name
	case 'n_colegiado'
		id_col=f_colegiado_id_col(data)
		this.SetItem(row,'id_colegiado', f_colegiado_id_col(data))
		SELECT delegaciones.descripcion  INTO :delegacion  FROM colegiados, delegaciones  
		WHERE ( colegiados.delegacion = delegaciones.cod_delegacion ) and  
				( ( colegiados.id_colegiado = :id_col ) )   ;
		this.SetItem(row,'delegacion', delegacion)
		select email into :email from colegiados where id_colegiado = :id_col ;
		this.SetItem(row,'email', email)
end choose

end event

event type long dw_1::pfc_addrow();call super::pfc_addrow;dw_1.SetItem(getrow(),'f_estado',datetime(today()))
return ancestorreturnvalue

end event

type cb_anyadir from w_mant_busq`cb_anyadir within w_colegiados_firma_digital
integer x = 32
integer y = 1512
integer width = 325
integer taborder = 130
end type

event cb_anyadir::clicked;call super::clicked;dw_1.SetItem(dw_1.rowcount(),'f_estado',datetime(today()))

end event

type cb_borrar from w_mant_busq`cb_borrar within w_colegiados_firma_digital
integer x = 416
integer y = 1512
integer width = 325
integer taborder = 140
end type

type cb_ayuda from w_mant_busq`cb_ayuda within w_colegiados_firma_digital
boolean visible = false
integer taborder = 40
end type

type st_1 from w_mant_busq`st_1 within w_colegiados_firma_digital
boolean visible = false
integer taborder = 10
end type

type st_2 from w_mant_busq`st_2 within w_colegiados_firma_digital
boolean visible = false
integer taborder = 100
end type

type sle_1 from w_mant_busq`sle_1 within w_colegiados_firma_digital
boolean visible = false
integer taborder = 90
end type

type sle_2 from w_mant_busq`sle_2 within w_colegiados_firma_digital
boolean visible = false
integer taborder = 110
end type

type cb_buscar from w_mant_busq`cb_buscar within w_colegiados_firma_digital
integer x = 1696
integer y = 56
integer taborder = 30
end type

event cb_buscar::clicked;//SOBREESCRITO para que no aparezcan los botones q hemos heredado
//de w_mant_busq.
string sql_nuevo, sql_original

dw_consulta.accepttext()
dw_1.AcceptText()

SetPointer(HourGlass!)
sql_nuevo = DW_1.describe("datawindow.table.select")
sql_original = sql_nuevo

//Realizamos la consulta pertinente para que nos salgan los datos q buscamos
f_sql('colegiados.n_colegiado','=','num_colegiado',dw_consulta,sql_nuevo,'1','')
f_sql('colegiados.delegacion','=','delegacion',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados_firma_digital.estado','=','estado',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('colegiados_firma_digital.f_estado','>=','f_estado_ini',dw_consulta,sql_nuevo,'1','')
f_sql('colegiados_firma_digital.f_estado','<','f_estado_fin',dw_consulta,sql_nuevo,'1','')

//messagebox('',sql_nuevo)

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
dw_1.retrieve()
dw_1.modify("datawindow.table.select= ~"" + sql_original + "~"")

end event

type cb_salir from commandbutton within w_colegiados_firma_digital
integer x = 1568
integer y = 1512
integer width = 325
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;// cerramos la ventana.
close(parent)
end event

type cb_imprimir from commandbutton within w_colegiados_firma_digital
boolean visible = false
integer x = 1184
integer y = 1512
integer width = 325
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

event clicked;//ids_print.print()
end event

type cb_borrar_todos from u_cb within w_colegiados_firma_digital
boolean visible = false
integer x = 800
integer y = 1512
integer width = 325
integer taborder = 140
boolean bringtotop = true
string text = "Borrar &Todos"
end type

event clicked;call super::clicked;long fila
for fila = dw_1.rowCount() to 1 step -1
	dw_1.deleterow(1)	
next
end event

type dw_consulta from u_dw within w_colegiados_firma_digital
integer x = 37
integer y = 32
integer width = 1646
integer height = 456
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_colegiados_firma_digital_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yy")
this.iuo_calendar.of_SetInitialValue(True)
end event

