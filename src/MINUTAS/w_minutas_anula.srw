HA$PBExportHeader$w_minutas_anula.srw
forward
global type w_minutas_anula from w_response
end type
type st_2 from statictext within w_minutas_anula
end type
type sle_imprimir_originales from singlelineedit within w_minutas_anula
end type
type cb_aumentar_copias from commandbutton within w_minutas_anula
end type
type cb_disminuir_copias from commandbutton within w_minutas_anula
end type
type st_6 from statictext within w_minutas_anula
end type
type sle_imprimir_copias from singlelineedit within w_minutas_anula
end type
type cb_aumentar from commandbutton within w_minutas_anula
end type
type cb_disminuir from commandbutton within w_minutas_anula
end type
type st_5 from statictext within w_minutas_anula
end type
type cb_cancelar from commandbutton within w_minutas_anula
end type
type cb_aceptar from commandbutton within w_minutas_anula
end type
type dw_minuta from u_dw within w_minutas_anula
end type
type dw_liquidaciones from u_dw within w_minutas_anula
end type
type dw_movis_musaat from u_dw within w_minutas_anula
end type
type st_liquidaciones from statictext within w_minutas_anula
end type
type st_musaat from statictext within w_minutas_anula
end type
type st_facturas from statictext within w_minutas_anula
end type
type dw_facturas from u_dw within w_minutas_anula
end type
type st_1 from statictext within w_minutas_anula
end type
type dw_1 from u_dw within w_minutas_anula
end type
type dw_minutas_anula_parametrizacion from u_dw within w_minutas_anula
end type
type gb_1 from groupbox within w_minutas_anula
end type
end forward

global type w_minutas_anula from w_response
integer x = 214
integer y = 221
integer width = 3282
integer height = 1872
string title = "Despagar Aviso"
boolean controlmenu = false
st_2 st_2
sle_imprimir_originales sle_imprimir_originales
cb_aumentar_copias cb_aumentar_copias
cb_disminuir_copias cb_disminuir_copias
st_6 st_6
sle_imprimir_copias sle_imprimir_copias
cb_aumentar cb_aumentar
cb_disminuir cb_disminuir
st_5 st_5
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_minuta dw_minuta
dw_liquidaciones dw_liquidaciones
dw_movis_musaat dw_movis_musaat
st_liquidaciones st_liquidaciones
st_musaat st_musaat
st_facturas st_facturas
dw_facturas dw_facturas
st_1 st_1
dw_1 dw_1
dw_minutas_anula_parametrizacion dw_minutas_anula_parametrizacion
gb_1 gb_1
end type
global w_minutas_anula w_minutas_anula

type variables
string i_accion=''
end variables

on w_minutas_anula.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_imprimir_originales=create sle_imprimir_originales
this.cb_aumentar_copias=create cb_aumentar_copias
this.cb_disminuir_copias=create cb_disminuir_copias
this.st_6=create st_6
this.sle_imprimir_copias=create sle_imprimir_copias
this.cb_aumentar=create cb_aumentar
this.cb_disminuir=create cb_disminuir
this.st_5=create st_5
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_minuta=create dw_minuta
this.dw_liquidaciones=create dw_liquidaciones
this.dw_movis_musaat=create dw_movis_musaat
this.st_liquidaciones=create st_liquidaciones
this.st_musaat=create st_musaat
this.st_facturas=create st_facturas
this.dw_facturas=create dw_facturas
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_minutas_anula_parametrizacion=create dw_minutas_anula_parametrizacion
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_imprimir_originales
this.Control[iCurrent+3]=this.cb_aumentar_copias
this.Control[iCurrent+4]=this.cb_disminuir_copias
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.sle_imprimir_copias
this.Control[iCurrent+7]=this.cb_aumentar
this.Control[iCurrent+8]=this.cb_disminuir
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.cb_cancelar
this.Control[iCurrent+11]=this.cb_aceptar
this.Control[iCurrent+12]=this.dw_minuta
this.Control[iCurrent+13]=this.dw_liquidaciones
this.Control[iCurrent+14]=this.dw_movis_musaat
this.Control[iCurrent+15]=this.st_liquidaciones
this.Control[iCurrent+16]=this.st_musaat
this.Control[iCurrent+17]=this.st_facturas
this.Control[iCurrent+18]=this.dw_facturas
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.dw_1
this.Control[iCurrent+21]=this.dw_minutas_anula_parametrizacion
this.Control[iCurrent+22]=this.gb_1
end on

on w_minutas_anula.destroy
call super::destroy
destroy(this.st_2)
destroy(this.sle_imprimir_originales)
destroy(this.cb_aumentar_copias)
destroy(this.cb_disminuir_copias)
destroy(this.st_6)
destroy(this.sle_imprimir_copias)
destroy(this.cb_aumentar)
destroy(this.cb_disminuir)
destroy(this.st_5)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_minuta)
destroy(this.dw_liquidaciones)
destroy(this.dw_movis_musaat)
destroy(this.st_liquidaciones)
destroy(this.st_musaat)
destroy(this.st_facturas)
destroy(this.dw_facturas)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_minutas_anula_parametrizacion)
destroy(this.gb_1)
end on

event open;call super::open;string aviso_entrada, id_minuta
boolean anulada = false , pendiente = false
long pos_pendiente, pos_anulada
id_minuta = Message.StringParm

pos_pendiente = PosA(id_minuta, 'PENDIENTE', 1)
pos_anulada = PosA(id_minuta, 'ANULADA', 1) 

if pos_pendiente > 0 then 
	id_minuta = MidA(id_minuta, 1, pos_pendiente -1 )
	pendiente = true
end if

if pos_anulada > 0 then 
	id_minuta = MidA(id_minuta, 1, pos_anulada -1 )	
	anulada = true
end if

dw_1.insertrow(0)
if not f_es_vacio(id_minuta) then
	aviso_entrada = f_minutas_n_aviso(id_minuta)
	dw_1.setitem(1, 'n_aviso', aviso_entrada)
	// Modificado Ricardo 04-02-02
	//dw_1.event itemchanged(1, dw_1.object.n_aviso, aviso_entrada) 
	dw_1.setitem(1, 'id_minuta', id_minuta)
	dw_1.post event csd_recuperar_datos()
	// FIN Modificado Ricardo 04-02-02
end if
dw_1.setitem(1, 'f_anul', datetime(today()))
dw_1.setfocus()
dw_1.post setcolumn("n_aviso")

// MODIFICADO RICARDO 04-06-17
dw_minutas_anula_parametrizacion.insertrow(0) // Ponemos una linea para que al menos est$$HEX2$$e9002000$$ENDHEX$$la parametrizaci$$HEX1$$f300$$ENDHEX$$n por defecto
// MODIFICADO RICARDO 04-06-17

end event

event pfc_postopen();call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_anula
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_anula
end type

type st_2 from statictext within w_minutas_anula
integer x = 37
integer y = 276
integer width = 2473
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Seleccione chequeando el campo ~"Anul~" cada documento que desee anular de cada uno de los siguientes tipos :"
boolean focusrectangle = false
end type

type sle_imprimir_originales from singlelineedit within w_minutas_anula
integer x = 439
integer y = 1608
integer width = 105
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "00"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_aumentar_copias from commandbutton within w_minutas_anula
integer x = 549
integer y = 1604
integer width = 64
integer height = 44
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_originales.text < '98' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) + 1 , '00')
end if
end event

type cb_disminuir_copias from commandbutton within w_minutas_anula
integer x = 549
integer y = 1648
integer width = 64
integer height = 44
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_originales.text > '00' then
	sle_imprimir_originales.text= string(integer(sle_imprimir_originales.text) - 1 , '00')
end if
end event

type st_6 from statictext within w_minutas_anula
integer x = 96
integer y = 1620
integer width = 325
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Originales :"
boolean focusrectangle = false
end type

type sle_imprimir_copias from singlelineedit within w_minutas_anula
integer x = 1033
integer y = 1608
integer width = 105
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "00"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;this.text= string(integer(this.text) , '00')

end event

type cb_aumentar from commandbutton within w_minutas_anula
integer x = 1143
integer y = 1604
integer width = 64
integer height = 44
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_imprimir_copias.text < '98' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) + 1 , '00')
end if
end event

type cb_disminuir from commandbutton within w_minutas_anula
integer x = 1143
integer y = 1648
integer width = 64
integer height = 44
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_imprimir_copias.text > '00' then
	sle_imprimir_copias.text= string(integer(sle_imprimir_copias.text) - 1 , '00')
end if
end event

type st_5 from statictext within w_minutas_anula
integer x = 777
integer y = 1620
integer width = 270
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Copias :"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_minutas_anula
integer x = 2277
integer y = 1636
integer width = 398
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar : Salir"
boolean cancel = true
end type

event clicked;if i_accion = '' then i_accion = 'CANCELAR'

parent.ib_disableclosequery = true
closewithreturn(parent, i_accion)
end event

type cb_aceptar from commandbutton within w_minutas_anula
event csd_genera_fact_neg ( string id_cobro_multiple,  string id_cobro_multiple_new )
integer x = 1390
integer y = 1640
integer width = 622
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar : Realizar Acci$$HEX1$$f300$$ENDHEX$$n"
end type

event csd_genera_fact_neg(string id_cobro_multiple, string id_cobro_multiple_new);int i
string cadena_nula
double  num_originales, num_copias
datastore ds_fact_cobros_compuesto
datawindow dw_vacio
setnull(cadena_nula)


num_copias = double(sle_imprimir_copias.Text)
num_originales = double(sle_imprimir_originales.Text)

ds_fact_cobros_compuesto 					= create datastore
ds_fact_cobros_compuesto.dataobject 	= 'd_minutas_facturas_cm'
ds_fact_cobros_compuesto.settransobject(SQLCA)
ds_fact_cobros_compuesto.retrieve(id_cobro_multiple)


// SE GENERAN LAS FACTURAS NEGATIVAS	
for i = 1 to ds_fact_cobros_compuesto.Rowcount()
	
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.tipo = ds_fact_cobros_compuesto.GetItemString(i,'tipo_factura')
		st_imp_fact.id_persona = ds_fact_cobros_compuesto.GetItemString(i,'emisor')
		
		ds_fact_cobros_compuesto.setitem(i, 'anulada', 'S')
		ds_fact_cobros_compuesto.setitem(i, 'id_ingreso', cadena_nula)
		
		// Rellenamos la estructura que pasamos a la funci$$HEX1$$f300$$ENDHEX$$n que genera la factura negativa
		st_generar_facturas_minutas parametros_factura_minuta	
		parametros_factura_minuta.id_factura 	= ds_fact_cobros_compuesto.GetItemString(i,'id_factura')
		parametros_factura_minuta.serie	 		= g_facturas_negativas_serie
		parametros_factura_minuta.motivo_anul	= dw_1.getitemstring(1, 'motivo_anulacion')
		parametros_factura_minuta.f_anul		= dw_1.getitemdatetime(1, 'f_anul')
	
		parametros_factura_minuta.id_cobro_multiple	= id_cobro_multiple_new
		parametros_factura_minuta.tipo_cobro 			= 'M'
		//parametros_factura_minuta.formapago 			= parametros_cobro_multiple.formapago 
	
		
		st_imp_fact.id_factura = f_genera_factura_negativa(parametros_factura_minuta)

		st_imp_fact.copia = 'N'
		st_imp_fact.dw = dw_vacio
		
		// Modificado David 23/02/2006 - Utilizamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n para imprimir con la nueva funci$$HEX1$$f300$$ENDHEX$$n
		n_csd_impresion_formato l_uo_impresion_formato
		l_uo_impresion_formato = create n_csd_impresion_formato
		st_imp_fact.impresion_formato 				= l_uo_impresion_formato
		st_imp_fact.impresion_formato.copias		= num_originales
		st_imp_fact.impresion_formato.papel 		= 'S'
		  
		// Imprimimos originales
		if num_originales > 0 then  f_imprimir_factura_objeto_impr(st_imp_fact)
		
		// Imprimimos copias
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.copias = num_copias
		if num_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
			

next
end event

event clicked;string mensaje='', emisor, tipo_factura, filas_musaat_a_borrar[], centro, cadena_nula, id_liquidacion, id_linea, id_movimiento,id_fac
double i, num_originales, num_copias
boolean b_borrar_movimientos_musaat
datetime fecha_nula, f_notificacion
long indice_array = 1, fila_parametrizacion
int fila_nueva, total_filas, filas_insertadas = 0, j
datawindow dw_vacio
setnull(cadena_nula)
setnull(fecha_nula)

dw_1.accepttext()

// Averiguamos el centro de la instalacion
centro = f_devuelve_centro(g_cod_delegacion)
fila_parametrizacion = dw_minutas_anula_parametrizacion.find("centro = '"+centro+"'", 1, dw_minutas_anula_parametrizacion.RowCount())
if fila_parametrizacion = 0 then
	// Buscamos la linea generica 
	fila_parametrizacion = dw_minutas_anula_parametrizacion.find("centro = '%'", 1, dw_minutas_anula_parametrizacion.RowCount())
end if
if fila_parametrizacion > 0 then
	b_borrar_movimientos_musaat = dw_minutas_anula_parametrizacion.getitemstring(fila_parametrizacion, 'borrar_movimiento') ='S'
else
	// Si no se ha indicado nada por consulta de inicio no dejamos hacerlo
	b_borrar_movimientos_musaat = false
end if

// 0 COMPROBACIONES
if dw_minuta.rowcount() <= 0 then
	messagebox(g_titulo, 'Aviso no encontrado')
	return
end if

// Inhabilitamos el bot$$HEX1$$f300$$ENDHEX$$n
this.enabled = false

// 1 ANULAMOS EL AVISO
choose case dw_1.getitemstring(1, 'accion')
	case 'D'
		dw_minuta.setitem(1, 'pendiente', 'S')
		dw_minuta.setitem(1, 'fecha_pago', fecha_nula)
		dw_minuta.setitem(1, 'forma_pago', cadena_nula)
		dw_minuta.setitem(1, 'banco', cadena_nula)
	case 'A'
		dw_minuta.setitem(1, 'anulada', 'S')
end choose
string id_cobro_multiple

// 2 - CREAMOS LAS FACTURAS NEGATIVAS
num_copias = double(sle_imprimir_copias.Text)
num_originales = double(sle_imprimir_originales.Text)

string tipo_cobro

//2.1 SE COMPRUEBA SI LAS FACTURAS SON CON COBRO COMPUESTO
//if  dw_facturas.GetItemnumber(1,'compute_1') > 0 then
//	st_generar_facturas_minutas parametros_cobro_multiple
//	boolean lb_genera_cobro_mutiple = true
//	// Se valida que si tiene mas de un aviso cobrado con el cobro compuesto
//	parametros_cobro_multiple = f_busca_cobro_multiple(dw_facturas.GetItemString(dw_facturas.GetItemnumber(1,'compute_2'),'id_factura'))
//	//Si solo tiene un aviso se pasa el parametro indicando 
//	if 	parametros_cobro_multiple.cant_avisos > 1 then
//		if Messagebox(g_titulo, "La factura esta asociada a un cobro compuesto, desea anular todas las facturas relacionadas? S/N", question!, yesno!) = 2 then
//			Messagebox(g_titulo, "Se gener$$HEX2$$e1002000$$ENDHEX$$un cobro por el importe de cada factura")
//			tipo_cobro = 'S'
//			lb_genera_cobro_mutiple = false
//		else
//			tipo_cobro = 'M'
//			lb_genera_cobro_mutiple = true
//			Messagebox(g_titulo, "Se anularan las facturas asociadas al cobro compuesto")
//			// SE DEJA EVENTO PARA DESPUES DE ANULAR LAS FACTURAS DE ESTE AVISO
//		
//		end if
//	end if
//	// Se genera el cobro Multiple
//	if lb_genera_cobro_mutiple then id_cobro_multiple = f_genera_cobro_multiple(parametros_cobro_multiple.id_cobro_multiple)
//end if

// SE GENERAN LAS FACTURAS NEGATIVAS	
for i = 1 to dw_facturas.Rowcount()
	if dw_facturas.GetItemString(i,'anular')='S' then
		st_imprimir_factura_obj_impr st_imp_fact
		st_imp_fact.tipo = dw_facturas.GetItemString(i,'tipo_factura')
		st_imp_fact.id_persona = dw_facturas.GetItemString(i,'emisor')
		
		id_fac = dw_facturas.GetItemString(i,'id_factura')
		dw_facturas.setitem(i, 'anulada', 'S')
		dw_facturas.setitem(i, 'id_ingreso', cadena_nula)
		
		update csi_cobros set contabilizado='S' where id_factura=:id_fac;
		//st_generar_facturas_minutas parametros_cobro_multiple
		//parametros_cobro_multiple = f_busca_cobro_multiple(dw_facturas.GetItemString(dw_facturas.GetItemnumber(1,'compute_2'),'id_factura'))
		//parametros_cobro_multiple .formapago
		
		
		// Rellenamos la estructura que pasamos a la funci$$HEX1$$f300$$ENDHEX$$n que genera la factura negativa
		st_generar_facturas_minutas parametros_factura_minuta	
		parametros_factura_minuta.id_factura 	= dw_facturas.GetItemString(i,'id_factura')
		parametros_factura_minuta.serie	 		= g_facturas_negativas_serie
		parametros_factura_minuta.motivo_anul	= dw_1.getitemstring(1, 'motivo_anulacion')
		parametros_factura_minuta.f_anul		= dw_1.getitemdatetime(1, 'f_anul')
		parametros_factura_minuta.modulo		= 'MINUTAS_ANULA'
		
	//Agregado 13/08/08 Yexaira
	// Se busca la forma de pago asociado al CM
		if dw_facturas.getitemstring(i, 'formadepago') = 'CM' then
			parametros_factura_minuta.tipo_cobro = 'S'
			parametros_factura_minuta.formapago = f_forma_pago_cm(dw_facturas.getitemstring(i, 'id_factura'))
		end if
			parametros_factura_minuta.id_cobro_multiple	= ''
//			
//		else
//			parametros_factura_minuta.id_cobro_multiple	= id_cobro_multiple
//			parametros_factura_minuta.tipo_cobro 			= tipo_cobro
//			parametros_factura_minuta.formapago 			= parametros_cobro_multiple.formapago 
//		end if
		
		st_imp_fact.id_factura = f_genera_factura_negativa(parametros_factura_minuta)

		st_imp_fact.copia = 'N'
		st_imp_fact.dw = dw_vacio
		
		// Modificado David 23/02/2006 - Utilizamos el objeto de impresi$$HEX1$$f300$$ENDHEX$$n para imprimir con la nueva funci$$HEX1$$f300$$ENDHEX$$n
		n_csd_impresion_formato l_uo_impresion_formato
		l_uo_impresion_formato = create n_csd_impresion_formato
		st_imp_fact.impresion_formato 				= l_uo_impresion_formato
		st_imp_fact.impresion_formato.copias		= num_originales
		st_imp_fact.impresion_formato.papel 		= 'S'
		  
		// Imprimimos originales
		if num_originales > 0 then  f_imprimir_factura_objeto_impr(st_imp_fact)
		
		// Imprimimos copias
		st_imp_fact.copia = 'S'
		st_imp_fact.impresion_formato.copias = num_copias
		if num_copias > 0 then f_imprimir_factura_objeto_impr(st_imp_fact)
			
	end if
next

//3.- SE ANULAN LAS FACTURAS QUE ESTAN ASOCIADAS A COBROS COMPUESTOS 
// ESTO SE HACE SI HAN SELECCIONADO ANULAR TODAS LAS FACTURAS 
// if tipo_cobro = 'M' then
//	event csd_genera_fact_neg(parametros_cobro_multiple.id_cobro_multiple, id_cobro_multiple)
// end if



// 4 - LOS MOVIMIENTOS DE MUSAAT
// Se crean movimientos negativos.
total_filas = dw_movis_musaat.rowcount()
for i = 1 to total_filas
	if dw_movis_musaat.GetItemString(i,'anular')='S' then
		dw_movis_musaat.setitem(i, 'anulado', 'S')
		f_notificacion = dw_movis_musaat.getitemdatetime(i, "fecha_notificacion")
		if b_borrar_movimientos_musaat and isnull(f_notificacion) then
			indice_array = upperbound(filas_musaat_a_borrar[])
			indice_array ++
			filas_musaat_a_borrar[indice_array] = dw_movis_musaat.getitemstring(i, 'id_movimiento')
		else
			filas_insertadas ++
			dw_movis_musaat.RowsCopy ( i, i, Primary!, dw_movis_musaat, total_filas +filas_insertadas , Primary!)		
			id_movimiento = f_siguiente_numero('ID_MOV_MUSAAT', 10)
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'id_movimiento', id_movimiento)
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 't_visado', '6')
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'importe_vble', dw_movis_musaat.getitemnumber(dw_movis_musaat.rowcount(), 'importe_vble') * -1)
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'anular', 'N')
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'fecha_notificacion', fecha_nula)
//			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'fecha_calculo', datetime(today(), now()))

			// MODIFICADO RICARDO 04-06-17
			// Seg$$HEX1$$fa00$$ENDHEX$$n Bizkaia debe salir a fecha del dia
			// Como es un movimiento de anulacion ponemos la fecha del aviso
//			string id_minuta
//			datetime fecha_calculo
//			id_minuta = dw_movis_musaat.getitemstring(i, 'id_minuta')
//			SELECT fases_minutas.fecha INTO :fecha_calculo FROM fases_minutas WHERE fases_minutas.id_minuta = :id_minuta   ;
			
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'fecha_calculo', datetime(today(), time("00:00"))) // Seg$$HEX1$$fa00$$ENDHEX$$n Bizkaia debe salir a fecha del dia
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'f_musaat', datetime(today(), time("00:00"))) // Seg$$HEX1$$fa00$$ENDHEX$$n Bizkaia debe salir a fecha del dia
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'anulado', 'S')
			// FIN MODIFICADO RICARDO 04-06-17
			
			// David 25/04/2007
			// Marcar los movimientos de musaat generados con la linea de la factura
			SELECT id_linea INTO :id_linea  FROM csi_lineas_fact_emitidas  
			WHERE ( id_factura = :st_imp_fact.id_factura ) AND  ( articulo = :g_codigos_conceptos.musaat_variable )   ;
			dw_movis_musaat.setitem(total_filas + filas_insertadas, 'id_factura', id_linea)
		end if			
	end if
next
// Borramos los movimientos no notificados
if b_borrar_movimientos_musaat then
	for i = 1 to upperbound(filas_musaat_a_borrar[])
		for j = dw_movis_musaat.rowcount() to 1 step -1
			if dw_movis_musaat.getitemstring(j, 'id_movimiento') = filas_musaat_a_borrar[i] then
				dw_movis_musaat.deleterow(j)
			end if
		next
	next
end if

// 5 - LA LIQUIDACION
// Si est$$HEX2$$e1002000$$ENDHEX$$liquidada avisamos
// Si est$$HEX2$$e1002000$$ENDHEX$$contabilizada avisamos
filas_insertadas = 0
total_filas = dw_liquidaciones.rowcount()
for i = 1 to dw_liquidaciones.rowcount()
	if dw_liquidaciones.GetItemString(i,'anular')='S' then
		if dw_liquidaciones.GetItemString(i,'estado')='L' then
			mensaje = 'La liquidaci$$HEX1$$f300$$ENDHEX$$n ' + string(i) + ' estaba ya pagada.' + cr
		end if
		if dw_liquidaciones.GetItemString(i,'contabilizada')='S' then
			mensaje += 'La liquidaci$$HEX1$$f300$$ENDHEX$$n ' + string(i) + ' estaba ya contabilizada.' + cr
		end if		
	end if
	if dw_liquidaciones.GetItemString(i,'estado')='L' then
		filas_insertadas ++
			dw_liquidaciones.RowsCopy ( i, i, Primary!, dw_liquidaciones, total_filas +filas_insertadas , Primary!)		
			id_liquidacion = f_siguiente_numero('LIQUIDACIONES', 10)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'id_liquidacion', id_liquidacion)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'f_liquidacion', fecha_nula)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'f_entrada', datetime(today(),now()))
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'importe_suma', dw_liquidaciones.getitemnumber(dw_liquidaciones.rowcount(), 'importe_suma') * -1)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'importe_resta', dw_liquidaciones.getitemnumber(dw_liquidaciones.rowcount(), 'importe_resta') * -1)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'importe', dw_liquidaciones.getitemnumber(dw_liquidaciones.rowcount(), 'importe') * -1)
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'anular', 'N')
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'estado', 'P')
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'contabilizada', 'N')
			dw_liquidaciones.setitem(total_filas + filas_insertadas, 'tipo', '2')
	else
		dw_liquidaciones.setitem(i, 'estado', 'A')
	end if
next

parent.event pfc_save()

if mensaje <> '' then messagebox('Incidencias producidas', mensaje)

dw_1.setitem(1, 'n_aviso', '')
dw_1.setitem(1, 'motivo_anulacion', '')
dw_facturas.reset()
dw_movis_musaat.reset()
dw_liquidaciones.reset()

i_accion = 'ACEPTAR'

// Inhabilitamos el bot$$HEX1$$f300$$ENDHEX$$n
this.enabled = false

close (parent)

end event

type dw_minuta from u_dw within w_minutas_anula
boolean visible = false
integer x = 2510
integer y = 44
integer width = 713
integer height = 256
integer taborder = 20
string dataobject = "d_factu_minutas_detalle"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

type dw_liquidaciones from u_dw within w_minutas_anula
integer x = 37
integer y = 1232
integer width = 3186
integer height = 260
integer taborder = 20
string dataobject = "d_minuta_liquidaciones"
boolean livescroll = false
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;parent.ST_liquidaciones.text = ' Liquidaciones ( ' + string(this.rowcount()) + ' )'
end event

type dw_movis_musaat from u_dw within w_minutas_anula
integer x = 37
integer y = 876
integer width = 3186
integer height = 284
integer taborder = 20
string dataobject = "d_musaat_movimientos_minuta"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;parent.st_musaat.text = ' Movimientos de MUSAAT ( ' + string(this.rowcount()) + ' )'
end event

type st_liquidaciones from statictext within w_minutas_anula
integer x = 37
integer y = 1164
integer width = 1111
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Liquidaciones :"
boolean focusrectangle = false
end type

type st_musaat from statictext within w_minutas_anula
integer x = 37
integer y = 808
integer width = 1111
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Movimientos de MUSAAT :"
boolean focusrectangle = false
end type

type st_facturas from statictext within w_minutas_anula
integer x = 37
integer y = 360
integer width = 1111
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 67108864
string text = "Facturas asociadas :"
boolean focusrectangle = false
end type

type dw_facturas from u_dw within w_minutas_anula
integer x = 37
integer y = 428
integer width = 3186
integer height = 376
integer taborder = 10
string dataobject = "d_minutas_facturas"
boolean ib_rmbmenu = false
end type

event retrieveend;call super::retrieveend;parent.st_facturas.text = ' Facturas asociadas ( ' + string(this.rowcount()) + ' )'
end event

type st_1 from statictext within w_minutas_anula
integer x = 37
integer y = 32
integer width = 2190
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Introduzca el n$$HEX2$$ba002000$$ENDHEX$$de aviso a anular y si lo quiere dejar en estado anulado o despagarlo (recomendado):"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_minutas_anula
event csd_recuperar_datos ( )
integer x = 37
integer y = 92
integer width = 2245
integer height = 180
integer taborder = 10
string dataobject = "d_dame_n_aviso_anula"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_recuperar_datos;string id_minuta
int i

id_minuta = this.getitemstring(1, 'id_minuta')

dw_facturas.retrieve(id_minuta)
dw_movis_musaat.retrieve(id_minuta)
dw_liquidaciones.retrieve(id_minuta)
dw_minuta.retrieve(id_minuta)


for i = 1 to dw_facturas.rowcount()
	dw_facturas.setitem(i, 'anular', 'S')
next

for i = 1 to dw_movis_musaat.rowcount()
	dw_movis_musaat.setitem(i, 'anular', 'S')	
next

for i = 1 to dw_liquidaciones.rowcount()
	dw_liquidaciones.setitem(i, 'anular', 'S')		
next

dw_1.setfocus()
dw_1.post setcolumn("n_aviso")


end event

event itemchanged;call super::itemchanged;// Modificado Ricardo 04-04-02
string id_minuta
CHOOSE CASE dwo.name
	CASE 'n_aviso'
		if f_es_vacio(data) then
			this.setitem(row, 'id_minuta', '')
		else
			id_minuta = f_minutas_id_minuta( data )
			if f_es_vacio(id_minuta) then
				MessageBox(g_titulo, "El aviso indicado no se encuentra")
			else
				this.setitem(row, 'id_minuta', id_minuta)
			end if
		end if
		this.post event csd_recuperar_datos()		
END CHOOSE
// FIN Modificado Ricardo 04-04-02



end event

type dw_minutas_anula_parametrizacion from u_dw within w_minutas_anula
integer x = 2299
integer width = 955
integer height = 204
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_minutas_anula_parametrizacion"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

type gb_1 from groupbox within w_minutas_anula
integer x = 37
integer y = 1520
integer width = 1275
integer height = 216
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir Facturas Negativas"
end type

