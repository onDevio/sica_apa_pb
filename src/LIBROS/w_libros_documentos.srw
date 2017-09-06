HA$PBExportHeader$w_libros_documentos.srw
forward
global type w_libros_documentos from w_busqueda
end type
type dw_3 from u_dw within w_libros_documentos
end type
type cb_3 from commandbutton within w_libros_documentos
end type
end forward

global type w_libros_documentos from w_busqueda
integer width = 2706
integer height = 1696
dw_3 dw_3
cb_3 cb_3
end type
global w_libros_documentos w_libros_documentos

type variables
string is_sql, id_colegiado
end variables

on w_libros_documentos.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_3
end on

on w_libros_documentos.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_3)
end on

event open;call super::open;//is_sql = dw_1.describe("datawindow.table.select")
dw_3.SetFocus()


end event

type cb_recuperar_pantalla from w_busqueda`cb_recuperar_pantalla within w_libros_documentos
end type

type cb_guardar_pantalla from w_busqueda`cb_guardar_pantalla within w_libros_documentos
end type

type sle_1 from w_busqueda`sle_1 within w_libros_documentos
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_libros_documentos
boolean visible = false
end type

type st_1 from w_busqueda`st_1 within w_libros_documentos
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_libros_documentos
boolean visible = false
end type

type cb_1 from w_busqueda`cb_1 within w_libros_documentos
integer x = 457
integer y = 1412
string text = "&Aceptar"
end type

event cb_1::clicked;// **********************************		DECLARACION DE VARIABLES		*************************** 
int i, j
datastore ds_colegiados, ds_libros, ds_marcador
datetime f_prestamo
double insertadas
string id_col, codigo, ruta,email
st_retorno_seleccion retorno
n_csd_plantillas uo_plantillas

f_prestamo = dw_3.object.fecha[1]


// **********************************		SELECCIONAMOS LA PLANTILLA 		***************************
//Abrimos la ventana de selecci$$HEX1$$f300$$ENDHEX$$n de plantillas
st_plantillas_seleccion datos_plantillas
datos_plantillas.modulo='BIBLIOTECA'
if dw_1.rowcount() > 0 then
	datos_plantillas.mostrar_cbx_editar_plantilla=true
else
datos_plantillas.mostrar_cbx_editar_plantilla=false
end if
//if dw_3.getitemstring(1,'tipo')='C' then
	OpenwithParm(w_plantillas_seleccion,datos_plantillas)
	
	retorno = Message.powerobjectparm
	
	if retorno.ruta = '-1' then return
	
	retorno.ruta = g_directorio_rtf + retorno.ruta
	
	//messagebox("",retorno.ruta )
 
	if not fileexists(retorno.ruta) then
		messagebox(g_titulo_aplicacion,'La plantilla seleccionada no existe')
		return	
	end if

	//Creamos el datastore de Colegiados para las plantillas de colegiados
	ds_colegiados = create datastore
	ds_colegiados.dataobject = 'd_plantillas_libro'
		
	// Creamos el objeto de plantillas y rellenamos sus parametros
	uo_plantillas=create n_csd_plantillas
	uo_plantillas.ruta_plantilla = retorno.ruta
	uo_plantillas.mdb='libros.txt'
	uo_plantillas.ruta_mdb=g_directorio_rtf+'libros.txt'
	
	
	// **********************************		RECUPERAMOS LOS DATOS			***************************
		//Para cada colegiado... deberemos llamar a la funcion de f_colegiados_rellena_estructura
		//for i= 1 to dw_1.rowcount()
			id_col = dw_3.GetItemString(1,'id_colegiado')
			f_libros_rellena_estructura(id_col,f_prestamo, ds_colegiados)			
		//next
	
		setpointer(hourglass!)
		
	//	// **********************************		COMBINAMOS CON WORD			***************************
	
	ds_libros = create datastore
	ds_libros.dataobject = 'd_libros_plantilla'
	ds_libros.settransobject(SQLCA)
	ds_libros.retrieve(id_col)
		
	ds_marcador = create datastore
	ds_marcador.dataobject = 'd_plantillas_marcador'
	ds_marcador.settransobject(SQLCA)
	ds_marcador.retrieve(datos_plantillas.modulo)
	
	if ds_colegiados.rowcount() > 0 then
		uo_plantillas.nombre_plantilla = f_obtiene_nombre_plantilla(retorno.codigo)
		uo_plantillas.is_modulo_asociado = retorno.modulo
		uo_plantillas.is_colegiado = dw_3.GetItemString(1,'n_colegiado')
		uo_plantillas.is_codigo = retorno.codigo
//		uo_plantillas.is_registro = ds_colegiados.getitemstring(1, 'registro_salida')
		
		if dw_3.getitemstring(1,'tipo')='C' then
			uo_plantillas.f_combinar_plantilla_txt_y_tablas(ds_libros, ds_marcador)
		else
			uo_plantillas.f_combinar_plantilla_txt()
		end if
	
	else
		messagebox(g_titulo, "Imposible generar los documentos por un fallo en la captura de datos")
	end if
//else
//	messagebox(g_titulo, "No se encuentra plantilla")
//		
//	end if

end event

type cb_2 from w_busqueda`cb_2 within w_libros_documentos
integer x = 1504
integer y = 1412
end type

type dw_1 from w_busqueda`dw_1 within w_libros_documentos
integer y = 404
integer width = 2606
integer height = 928
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type dw_3 from u_dw within w_libros_documentos
integer x = 69
integer y = 44
integer width = 2057
integer height = 332
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_libros_documentos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;string id_persona, n_col

choose case dwo.name
	case 'b_1'
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			id_persona=f_busqueda_colegiados()
			n_col = f_colegiado_n_col(id_persona)
			this.setitem(1,'n_colegiado',n_col)
			this.setitem(1,'id_colegiado',id_persona)
			
			
end choose
end event

event constructor;call super::constructor;this.insertrow(0)

this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type cb_3 from commandbutton within w_libros_documentos
integer x = 2158
integer y = 184
integer width = 343
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;call super::clicked;string sql_old = '', sql_nuevo = '', activa, mensaje =''
datetime ldt_fecha

dw_3.accepttext()

mensaje=mensaje + f_valida(dw_3,'n_colegiado','n_colegiado','Debe especificar el n$$HEX1$$fa00$$ENDHEX$$mero de colegiado ')
mensaje=mensaje + f_valida(dw_3,'tipo','tipo','Debe especificar el documento')



if mensaje<>'' then
	messagebox(G_TITULO,mensaje,StopSign!)
else
	sql_old = dw_1.describe("datawindow.table.select")
	sql_nuevo = sql_old
	//if if f_es_vacio(dw_3.getitemstring(1,'n_colegiado'))
	f_sql('prestamos.colegiado','=','id_colegiado',dw_3,sql_nuevo,g_tipo_base_datos,'')
	
	
	if dw_3.getitemstring(1,'tipo')='F' then
		mensaje=mensaje + f_valida(dw_3,'fecha','fecha','Debe especificar la fecha')
		if mensaje<>'' then
			messagebox(G_TITULO,mensaje,StopSign!)
			return
		else
			f_sql('prestamos.f_prestamo','=', 'fecha' ,dw_3,sql_nuevo,g_tipo_base_datos,'')
			dw_1.object.t_1.text ='Ficha Pr$$HEX1$$e900$$ENDHEX$$stamo'
			dw_1.object.f_prestamo.visible = true
		end if
	else
		//f_sql('prestamos.f_devolucion_prevista','=','fecha',dw_3,sql_nuevo,g_tipo_base_datos,'')
		sql_nuevo += 'and f_devolucion_real is null'
		dw_1.object.t_1.text ='Fecha Prevista'
		dw_1.object.f_devolucion_prevista.visible = true
	end if
	
	//messagebox("", sql_nuevo)
	dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
	
	
	dw_1.Retrieve('%')
	
	// Restauramos la sql original
	dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")
end if
end event

