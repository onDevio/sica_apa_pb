HA$PBExportHeader$w_fases_liquidaciones.srw
forward
global type w_fases_liquidaciones from w_response
end type
type dw_1 from u_dw within w_fases_liquidaciones
end type
type st_liquidaciones_a_mostrar from statictext within w_fases_liquidaciones
end type
type rb_fase from radiobutton within w_fases_liquidaciones
end type
type rb_expediente from radiobutton within w_fases_liquidaciones
end type
type dw_2 from u_dw within w_fases_liquidaciones
end type
end forward

global type w_fases_liquidaciones from w_response
integer x = 214
integer y = 221
integer width = 3790
integer height = 1128
string title = "Liquidaciones"
event csd_mostrar_liq_fase ( )
event csd_mostrar_liq_expedi ( )
dw_1 dw_1
st_liquidaciones_a_mostrar st_liquidaciones_a_mostrar
rb_fase rb_fase
rb_expediente rb_expediente
dw_2 dw_2
end type
global w_fases_liquidaciones w_fases_liquidaciones

type variables
st_w_fases_liquidaciones datos

string is_id_fase,is_id_expedi
string is_consulta_liq_fase='SELECT fases_liquidaciones.id_liquidacion,&
         fases_liquidaciones.id_fase,&
         fases_liquidaciones.id_minuta,&
         fases_liquidaciones.f_liquidacion,&
         fases_liquidaciones.estado,&
         fases_liquidaciones.contabilizada,&
         fases_liquidaciones.forma_pago,&
         fases_liquidaciones.banco,&
         fases_liquidaciones.importe_suma,&
         fases_liquidaciones.importe_resta,&
         fases_liquidaciones.importe,&
         fases_liquidaciones.n_documento,&
         fases_liquidaciones.id_colegiado,&
         colegiados.n_colegiado,&
         colegiados.apellidos,&
         colegiados.nombre,&
         colegiados.nif,&
         fases_liquidaciones.saldo_deudor,&
         fases_liquidaciones.deuda_facturas,&
         fases_liquidaciones.cod_delegacion,&
         fases_liquidaciones.f_entrada,&
         fases_liquidaciones.tipo,&
         fases_liquidaciones.concepto,&
         fases_minutas.n_aviso,&
			fases_minutas.id_fase,&
         fases_liquidaciones.empresa&
    FROM fases_liquidaciones,&
         colegiados,&
         fases_minutas&
   WHERE ( fases_liquidaciones.id_colegiado = colegiados.id_colegiado ) and&
         ( fases_minutas.id_minuta = fases_liquidaciones.id_fase )' 

end variables

event csd_mostrar_liq_fase();//
string ls_consulta, ls_empresa
ls_consulta=is_consulta_liq_fase+" and fases_minutas.id_fase like '"+is_id_fase+"'"

ls_empresa = dw_2.getitemstring( dw_2.getrow( ), 'empresa')

if not f_es_vacio(ls_empresa) then
	ls_consulta = ls_consulta + " and fases_liquidaciones.empresa = '"+ ls_empresa +"'"
end if

dw_1.object.datawindow.table.select=ls_consulta
dw_1.retrieve()
end event

event csd_mostrar_liq_expedi();//
string ls_consulta, ls_empresa
ls_consulta=is_consulta_liq_fase+" and fases_minutas.id_fase in (select id_fase from fases f where f.id_expedi='"+is_id_expedi+"')"

ls_empresa = dw_2.getitemstring(dw_2.getrow(), 'empresa')

if not f_es_vacio(ls_empresa) then
	ls_consulta = ls_consulta + " and fases_liquidaciones.empresa = '"+ ls_empresa +"'"
end if


dw_1.object.datawindow.table.select=ls_consulta
dw_1.retrieve()
end event

on w_fases_liquidaciones.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_liquidaciones_a_mostrar=create st_liquidaciones_a_mostrar
this.rb_fase=create rb_fase
this.rb_expediente=create rb_expediente
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_liquidaciones_a_mostrar
this.Control[iCurrent+3]=this.rb_fase
this.Control[iCurrent+4]=this.rb_expediente
this.Control[iCurrent+5]=this.dw_2
end on

on w_fases_liquidaciones.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_liquidaciones_a_mostrar)
destroy(this.rb_fase)
destroy(this.rb_expediente)
destroy(this.dw_2)
end on

event open;call super::open;datos=message.powerobjectparm
is_id_fase=datos.id_fase
is_id_expedi=datos.id_expedi

f_centrar_ventana(this)

dw_2.InsertRow(0)
dw_2.setitem(1,'empresa',g_empresa)
//Mostramos las liquidaciones de la fase al abrir la ventana
rb_fase.event clicked()

f_centrar_ventana(this)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_liquidaciones
integer x = 1975
integer y = 344
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_liquidaciones
integer x = 1975
integer y = 216
end type

type dw_1 from u_dw within w_fases_liquidaciones
integer x = 23
integer y = 228
integer width = 3712
integer height = 748
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_liquidaciones_contrato"
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event doubleclicked;call super::doubleclicked;string   ls_id_liquidacion

if this.rowcount() = 0 then return

///*** SCP-1060. Alexis. 02/03/2011. Se comenta el filtro para que habra la liquidaci$$HEX1$$f300$$ENDHEX$$n independientemente del lugar donde se pulse ***///
//if dwo.name = 'id_liquidacion' then
	//Con el n$$HEX1$$fa00$$ENDHEX$$mero de la liquidaci$$HEX1$$f300$$ENDHEX$$n, se debe abrir el detalle para verificar los datos de la misma
	///***SCP-1060. Alexis. 02/03/2011 S$$HEX1$$f300$$ENDHEX$$lo se ver$$HEX2$$e1002000$$ENDHEX$$el detalle de las liquidaciones de la empresa activa en el momento ***///
	if this.getitemstring(row,"empresa") = g_empresa then
		g_id_liquidacion =this.getitemstring(this.getrow(),"id_liquidacion")
		
		close(w_fases_liquidaciones)
		
		opensheet(w_liquidaciones_detalle, w_aplic_frame, 0, original!)
	else
		messagebox(g_titulo, 'No se puede tratar liquidaciones de otras empresas',StopSign!, OK! )
	end if
	
	
//end if
end event

type st_liquidaciones_a_mostrar from statictext within w_fases_liquidaciones
integer x = 50
integer y = 36
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Liquidaciones a mostrar"
boolean focusrectangle = false
end type

type rb_fase from radiobutton within w_fases_liquidaciones
integer x = 55
integer y = 124
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "De la fase"
boolean checked = true
end type

event clicked;event csd_mostrar_liq_fase()
end event

type rb_expediente from radiobutton within w_fases_liquidaciones
integer x = 416
integer y = 124
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Del expediente"
end type

event clicked;event csd_mostrar_liq_expedi()
end event

type dw_2 from u_dw within w_fases_liquidaciones
integer x = 987
integer y = 108
integer width = 1682
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_liq_contratos_empresas"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;
string ls_consulta, ls_empresa

if rb_expediente.checked then
	ls_consulta=is_consulta_liq_fase+" and fases_minutas.id_fase in (select id_fase from fases f where f.id_expedi='"+is_id_expedi+"')"
else
	ls_consulta=is_consulta_liq_fase+" and fases_minutas.id_fase like '"+is_id_fase+"'"
end if


if not f_es_vacio(data) then
	ls_consulta = ls_consulta + " and fases_liquidaciones.empresa = '"+ data +"'"
end if

dw_1.object.datawindow.table.select=ls_consulta
dw_1.retrieve()
end event

event buttonclicked;call super::buttonclicked;string ls_null 

setnull(ls_null)

if dwo.name = 'cb_anular_empresa' then
		dw_2.setitem(row, 'empresa', ls_null )
end if

this.event itemchanged(row, dw_2.object.empresa, ls_null)
end event

