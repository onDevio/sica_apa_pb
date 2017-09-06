HA$PBExportHeader$w_apuntes_lista.srw
forward
global type w_apuntes_lista from w_lista
end type
type cb_f19 from commandbutton within w_apuntes_lista
end type
type st_mensaje from statictext within w_apuntes_lista
end type
type dw_apuntes_dom from datawindow within w_apuntes_lista
end type
type em_1 from editmask within w_apuntes_lista
end type
type st_2 from statictext within w_apuntes_lista
end type
type em_2 from editmask within w_apuntes_lista
end type
type st_3 from statictext within w_apuntes_lista
end type
type cb_1 from commandbutton within w_apuntes_lista
end type
type sle_1 from singlelineedit within w_apuntes_lista
end type
type st_4 from statictext within w_apuntes_lista
end type
type cb_2 from commandbutton within w_apuntes_lista
end type
type cb_3 from commandbutton within w_apuntes_lista
end type
type cb_4 from commandbutton within w_apuntes_lista
end type
type cb_fichero from commandbutton within w_apuntes_lista
end type
type cb_domicilia from commandbutton within w_apuntes_lista
end type
type ejercicio_t from statictext within w_apuntes_lista
end type
end forward

global type w_apuntes_lista from w_lista
integer width = 3593
integer height = 2084
string title = "Domiciliaci$$HEX1$$f300$$ENDHEX$$n Saldos Deudores"
cb_f19 cb_f19
st_mensaje st_mensaje
dw_apuntes_dom dw_apuntes_dom
em_1 em_1
st_2 st_2
em_2 em_2
st_3 st_3
cb_1 cb_1
sle_1 sle_1
st_4 st_4
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_fichero cb_fichero
cb_domicilia cb_domicilia
ejercicio_t ejercicio_t
end type
global w_apuntes_lista w_apuntes_lista

type variables
string i_banco,in_banco
st_cobros_datos_remesa i_datos_remesa
datastore i_ds_domiciliaciones
string iult_ast
double iimporte_total

end variables

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_apuntes
g_lista     = 'w_apuntes_lista'

end event

on w_apuntes_lista.create
int iCurrent
call super::create
this.cb_f19=create cb_f19
this.st_mensaje=create st_mensaje
this.dw_apuntes_dom=create dw_apuntes_dom
this.em_1=create em_1
this.st_2=create st_2
this.em_2=create em_2
this.st_3=create st_3
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_4=create st_4
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_fichero=create cb_fichero
this.cb_domicilia=create cb_domicilia
this.ejercicio_t=create ejercicio_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_f19
this.Control[iCurrent+2]=this.st_mensaje
this.Control[iCurrent+3]=this.dw_apuntes_dom
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.sle_1
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.cb_4
this.Control[iCurrent+14]=this.cb_fichero
this.Control[iCurrent+15]=this.cb_domicilia
this.Control[iCurrent+16]=this.ejercicio_t
end on

on w_apuntes_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_f19)
destroy(this.st_mensaje)
destroy(this.dw_apuntes_dom)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_fichero)
destroy(this.cb_domicilia)
destroy(this.ejercicio_t)
end on

event csd_consulta;////Abrimos la ventana de consulta
//open(w_apuntes_consulta)
//if Message.DoubleParm = -1 then return
//dw_lista.Event csd_retrieve()
end event

event open;call super::open;em_1.text = string(Today())
em_2.text = string(Today())//string(Relativedate(date(em_1.text),1))

dw_lista.SetTransObject(bd_ejercicio)

inv_resize.of_Register (st_mensaje, "FixedtoBottom")
inv_resize.of_Register (cb_domicilia, "FixedtoBottom")
inv_resize.of_Register (cb_fichero, "FixedtoBottom")


end event

event pfc_postopen;//Asignamos valor a la variable global
g_dw_lista_apuntes = dw_lista
//dw_lista.Event csd_retrieve()
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_apuntes_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_apuntes_lista
end type

type st_1 from w_lista`st_1 within w_apuntes_lista
integer x = 96
integer y = 1748
end type

type dw_lista from w_lista`dw_lista within w_apuntes_lista
integer y = 256
integer width = 3278
integer height = 1452
integer taborder = 120
string dataobject = "d_apuntes_lista"
end type

event dw_lista::csd_retrieve;datetime fecha
fecha = datetime(relativedate(date(em_1.text),1),time('00:00'))
long lsaldo
double dsaldo
string id_col, iban, BIC
lsaldo = long(sle_1.text)
dsaldo = double(lsaldo)

SetPointer(Hourglass!)
st_mensaje.text = 'Recuperando saldos...'
this.retrieve(g_prefijo_arqui+'%','%', fecha, dsaldo)
SetPointer(Hourglass!)
long i
for i=1 to this.RowCount() 
	st_mensaje.Text='Procesando fila '+string(i) + ' de ' + string(dw_lista.RowCount())
	id_col=dw_lista.GetItemString(i,'cuentas_id_col')
	select datos_bancarios_iban, bic into :iban, :bic from conceptos_domiciliables where id_colegiado = :id_col and forma_de_pago = :g_formas_pago.domiciliacion and concepto = :g_conta.concepto_exp;
	IF NOT( gnv_control_cuentas_bancarias.of_comprobar_iban(iban)) THEN
		// Si no es buena la del concepto de expedientes, cogemos la de la fila de colegiados
		select datos_bancarios_iban, :bic into :iban, :bic from colegiados where id_colegiado = :id_col;
	END IF

	IF NOT( gnv_control_cuentas_bancarias.of_comprobar_iban(iban)) THEN CONTINUE// Este colegiado no tiene una domiciliacion posible
	bic= gnv_control_cuentas_bancarias.of_bic(iban, bic) // asigna BIC por defecto desde Bancos Maestro para IBAN, si BIC actual no es v$$HEX1$$e100$$ENDHEX$$lido
	IF f_var_global_sn('SEPA_BIC_obligatorio')='S' AND NOT( gnv_control_cuentas_bancarias.of_comprobar_bic( bic)) THEN CONTINUE
	
	this.SetItem(i,'banco',Mid(iban,5,4))
	this.SetItem(i,'domic','S')
	this.SetItem(i,'procesar','N')
next

this.SetFilter("domic='S'")
this.Filter()

st_mensaje.text = string(this.RowCount()) + ' filas en lista.'

end event

event dw_lista::pfc_updatespending;call super::pfc_updatespending;return 0
end event

type cb_consulta from w_lista`cb_consulta within w_apuntes_lista
end type

type cb_detalle from w_lista`cb_detalle within w_apuntes_lista
integer taborder = 30
end type

type cb_ayuda from w_lista`cb_ayuda within w_apuntes_lista
integer taborder = 60
end type

type cb_f19 from commandbutton within w_apuntes_lista
boolean visible = false
integer x = 2551
integer y = 1728
integer width = 571
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar domiciliaciones "
end type

event clicked;//call super::clicked;call super::clicked;call super::clicked;call super::clicked;call super::clicked;call super::clicked;call super::clicked;double i
//datetime fecha_conta
//string id_col
//st_apunte datos_apunte
//int mal
//
//i_ds_domiciliaciones= create datastore	
//i_ds_domiciliaciones.dataobject = 'd_cobros_domiciliaciones'
//i_ds_domiciliaciones.SetTransObject(SQLCA)
//
//dw_apuntes_dom.SetTransObject(bd_ejercicio)
//
//Open(w_cobros_datos_remesa)
//i_datos_remesa = Message.PowerObjectParm	
//if isnull(i_datos_remesa.banco) then return
//cb_fichero.enabled = true
//SetPointer(HourGlass!)
//IF f_es_vacio(g_diario_domiciliaciones) then g_diario_domiciliaciones='RE'
//
//iult_ast = f_ver_siguiente_numero_bd_ejercicio(g_diario_domiciliaciones,7) 
//iimporte_total = 0
//g_apunte.n_apunte = '0'
//fecha_conta = datetime(date(em_2.text),time('00:00'))
//dw_apuntes_dom.reset()
//
//for i=1 to dw_lista.RowCount()
//	if dw_lista.GetItemString(i,'procesar') = 'S' then
//	       st_mensaje.Text='Procesando fila '+string(i) + ' de ' + string(dw_lista.RowCount())
//		id_col=dw_lista.GetItemString(i,'cuentas_id_col')
//		if f_facturas_formapago(id_col,'EXP')=g_formas_pago.domiciliacion then
//    		SELECT datos_bancarios into :i_banco FROM conceptos_domiciliables WHERE id_colegiado = :id_col;
//			in_banco= i_datos_remesa.banco
//		   Parent.Event csd_generar_domiciliaciones(i)
//		end if
//	end if		
//next
//
//string cuenta2
//select cuenta_contable into :cuenta2 from csi_bancos where codigo = : i_datos_remesa.banco;
////Apunte banco
//datos_apunte.diario = g_diario_domiciliaciones
//datos_apunte.n_asiento = iult_ast
//datos_apunte.n_apunte = g_apunte.n_apunte
//datos_apunte.cuenta = cuenta2
//datos_apunte.fecha = fecha_conta
//datos_apunte.t_doc = ''
//datos_apunte.concepto = 'REMESA RECIBOS'
//datos_apunte.debe = iimporte_total
//datos_apunte.haber = 0
//datos_apunte.proyecto = g_explotacion_por_defecto
//datos_apunte.n_doc = ''
//datos_apunte.centro = g_centro_por_defecto
//datos_apunte.t_asiento = g_t_asiento_apuntes_automaticos
//
//f_apunte_dw(datos_apunte,dw_apuntes_dom,'E')
//
//mal = dw_apuntes_dom.Update()
//if mal<>-1 then
//	// Actualizamos el n$$HEX2$$ba002000$$ENDHEX$$de asiento en la tabla de contador  
//	f_actualiza_numero_bd_ejercicio (g_diario_domiciliaciones, long(iult_ast) )
//  	MessageBox("ACTUALIZACION DE APUNTES","Actualizados con $$HEX1$$e900$$ENDHEX$$xito.")
//  else
//  	MessageBox("ACTUALIZACION DE APUNTES","NO han sido actualizados.",StopSign!)
//end if
//
////st_texto.Text='Generando fichero F19'
////f_apuntes_genera_fichero19(i_datos_remesa)
////st_texto.Text='Proceso Finalizado'
//destroy i_ds_domiciliaciones		
//	
	

end event

type st_mensaje from statictext within w_apuntes_lista
integer x = 731
integer y = 1748
integer width = 869
integer height = 52
boolean bringtotop = true
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

type dw_apuntes_dom from datawindow within w_apuntes_lista
boolean visible = false
integer y = 1252
integer width = 3922
integer height = 448
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_apuntes_traspasos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_apuntes_dom.SetTransObject(bd_ejercicio)
end event

type em_1 from editmask within w_apuntes_lista
integer x = 704
integer y = 24
integer width = 402
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_apuntes_lista
integer x = 23
integer y = 44
integer width = 649
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Saldos deudores a la fecha:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_apuntes_lista
integer x = 1746
integer y = 24
integer width = 402
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_3 from statictext within w_apuntes_lista
integer x = 1166
integer y = 44
integer width = 507
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de los apuntes:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_apuntes_lista
integer x = 3099
integer y = 24
integer width = 343
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;date f1, f2
long saldo
saldo = long(sle_1.text)
f1 = date(em_1.text)
f2 = date(em_2.text)

if not isdate(em_1.text) or not isdate(em_2.text) then
	messagebox(g_titulo,"Alguna de las fechas es incorrecta",Stopsign!)
	return
end if

if f2 < f1 then
	messagebox(g_titulo,"La fecha de cargo no puede ser anterior al c$$HEX1$$e100$$ENDHEX$$lculo del saldo",Stopsign!)
	return
end if

dw_lista.SetFilter('')
dw_lista.event csd_retrieve()

// Modificado Ricardo 2005-05-09
// Veamos si estamos en un a$$HEX1$$f100$$ENDHEX$$o correcto
ejercicio_t.visible = (f_ejercicio_ya_abierto(g_ejercicio)<0)
// Modificado Ricardo 2005-05-09

end event

type sle_1 from singlelineedit within w_apuntes_lista
integer x = 2761
integer y = 24
integer width = 187
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "3"
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_apuntes_lista
integer x = 2258
integer y = 44
integer width = 485
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Saldo m$$HEX1$$ed00$$ENDHEX$$nimo ($$HEX1$$ac20$$ENDHEX$$):"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_apuntes_lista
integer x = 1522
integer y = 152
integer width = 402
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Marcar todos"
end type

event clicked;long i
for i=1 to dw_lista.RowCount() 
	dw_lista.SetItem(i,'procesar','S')
next
end event

type cb_3 from commandbutton within w_apuntes_lista
integer x = 1966
integer y = 152
integer width = 411
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Desmarcar todos"
end type

event clicked;long i
for i=1 to dw_lista.RowCount() 
	dw_lista.SetItem(i,'procesar','N')
next
end event

type cb_4 from commandbutton within w_apuntes_lista
integer x = 2423
integer y = 152
integer width = 549
integer height = 80
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Marcar hasta selecci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;long i
for i=1 to dw_lista.GetRow() 
	dw_lista.SetItem(i,'procesar','S')
next
end event

type cb_fichero from commandbutton within w_apuntes_lista
boolean visible = false
integer x = 2391
integer y = 1740
integer width = 1051
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Generar fichero de domiciliaciones pendientes"
end type

event clicked;//st_mensaje.text='Generando fichero F19'
//f_apuntes_genera_fichero19(i_datos_remesa)
//st_mensaje.Text='Proceso Finalizado'
end event

type cb_domicilia from commandbutton within w_apuntes_lista
integer x = 1714
integer y = 1740
integer width = 571
integer height = 112
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Domiciliar"
end type

event clicked;if f_puedo_escribir(g_usuario,'0000000032')=-1 then return -1

// Modificado Ricardo 2005-05-09
// Veamos si estamos en un a$$HEX1$$f100$$ENDHEX$$o correcto, no se puede domiciliar
if (f_ejercicio_ya_abierto(g_ejercicio)<0) then return
// Modificado Ricardo 2005-05-09


st_cobros_datos_pre_remesa datos_pre_remesa

datos_pre_remesa.dw_lista = dw_lista
datos_pre_remesa.modulo = 'SALDOS'
datos_pre_remesa.fecha_apuntes = datetime(date(em_2.text),time('00:00'))

OpenWithParm(w_cobros_pre_remesa,datos_pre_remesa)
end event

type ejercicio_t from statictext within w_apuntes_lista
boolean visible = false
integer x = 96
integer y = 160
integer width = 1262
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
string text = "Informaci$$HEX1$$f300$$ENDHEX$$n no v$$HEX1$$e100$$ENDHEX$$lida por estar en un ejercicio no abierto"
boolean focusrectangle = false
end type

