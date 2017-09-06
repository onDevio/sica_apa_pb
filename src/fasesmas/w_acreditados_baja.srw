HA$PBExportHeader$w_acreditados_baja.srw
forward
global type w_acreditados_baja from w_response
end type
type dw_consulta from u_dw within w_acreditados_baja
end type
type dw_lista from u_dw within w_acreditados_baja
end type
type cb_baja from commandbutton within w_acreditados_baja
end type
type cb_salir from commandbutton within w_acreditados_baja
end type
type dw_altas_bajas_sit from u_dw within w_acreditados_baja
end type
type st_1 from statictext within w_acreditados_baja
end type
type cb_guardar from commandbutton within w_acreditados_baja
end type
end forward

global type w_acreditados_baja from w_response
integer width = 3209
integer height = 1588
string title = "Baja de Acreditados"
dw_consulta dw_consulta
dw_lista dw_lista
cb_baja cb_baja
cb_salir cb_salir
dw_altas_bajas_sit dw_altas_bajas_sit
st_1 st_1
cb_guardar cb_guardar
end type
global w_acreditados_baja w_acreditados_baja

on w_acreditados_baja.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.dw_lista=create dw_lista
this.cb_baja=create cb_baja
this.cb_salir=create cb_salir
this.dw_altas_bajas_sit=create dw_altas_bajas_sit
this.st_1=create st_1
this.cb_guardar=create cb_guardar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.cb_baja
this.Control[iCurrent+4]=this.cb_salir
this.Control[iCurrent+5]=this.dw_altas_bajas_sit
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_guardar
end on

on w_acreditados_baja.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.dw_lista)
destroy(this.cb_baja)
destroy(this.cb_salir)
destroy(this.dw_altas_bajas_sit)
destroy(this.st_1)
destroy(this.cb_guardar)
end on

event open;call super::open;string estado,id_col
long i,num

dw_consulta.insertrow(0)
dw_lista.SetTransObject(SQLCA)


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_acreditados_baja
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_acreditados_baja
end type

type dw_consulta from u_dw within w_acreditados_baja
integer x = 55
integer y = 16
integer width = 1934
integer height = 312
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_acreditados_obras_consulta"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string id_col,estado
long i,num


SetPointer(Hourglass!)
dw_lista.retrieve(this.GetItemString(1,'c_geografico'),this.GetItemString(1,'alta_baja'))

for i=1 to dw_lista.rowcount()
	id_col=dw_lista.GetItemString(i,'id_colegiado')

	select count(distinct e.n_expedi)  into :num
	from fases f,fases_colegiados fc,expedientes e 
	where fc.id_col=:id_col and fc.id_fase=f.id_fase and f.id_expedi=e.id_expedi and e.cerrado like 'N';
		
	dw_lista.SetItem(i,'total_expedientes',num)
	if num=0 then
		dw_lista.SetItem(i,'seleccionado','S')
		cb_baja.enabled=true
	end if

next

SetPointer(Arrow!)
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'filtrar'		
		dw_lista.SetFilter("seleccionado='"+data+"'")
		if data='%' then dw_lista.SetFilter("")
		dw_lista.Filter()
		st_1.text=string(dw_lista.rowcount())+" Filas"
end choose
end event

type dw_lista from u_dw within w_acreditados_baja
integer x = 32
integer y = 352
integer width = 3118
integer height = 1020
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_acreditados_obras_final"
boolean ib_isupdateable = false
end type

event retrieveend;call super::retrieveend;st_1.text=string(rowcount) + ' Filas'
end event

type cb_baja from commandbutton within w_acreditados_baja
integer x = 1691
integer y = 1392
integer width = 507
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
string text = "Dar de Baja"
end type

event clicked;long i,fila
string ret,id_col

if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Se va a proceder a dar de baja los colegiados seleccionados. $$HEX1$$bf00$$ENDHEX$$Est$$HEX1$$e100$$ENDHEX$$s seguro?",Question!,YesNo!)<>1 then return

// Abrimos la ventana donde pondr$$HEX1$$e100$$ENDHEX$$n la fecha y el tipo
openwithparm(w_colegiados_alta_baja, 'N')

ret = message.stringparm
// Si han cancelado no modificamos el check
if ret = "-1" then return 2

for i=1 to dw_lista.rowcount()
	if dw_lista.GetItemString(i,'seleccionado')<>'S' then continue
	id_col=dw_lista.GetItemString(i,'id_colegiado')
	
	dw_lista.SetItem(i,'alta_baja','N')
	dw_lista.SetItem(i,'t_baja',g_colegiados_consulta.tipo)
	dw_lista.SetItem(i,'f_baja',g_colegiados_consulta.fecha)
	
	// Insertamos el registro en "altas, bajas y situaciones"
	dw_altas_bajas_sit.triggerevent("pfc_addrow")
	fila =dw_altas_bajas_sit.rowcount()
	dw_altas_bajas_sit.setitem(fila, 'id_altas_bajas_situaciones', f_siguiente_numero('ALTA_BAJA_SITUACION', 10))
	dw_altas_bajas_sit.setitem(fila,'id_colegiado',id_col)
	dw_altas_bajas_sit.setitem(fila,'codigo',g_colegiados_consulta.tipo)
	dw_altas_bajas_sit.setitem(fila,'campo_modificado','alta_baja')
	dw_altas_bajas_sit.setitem(fila,'fecha',g_colegiados_consulta.fecha)
	dw_altas_bajas_sit.setitem(fila,'baja','S')
	cb_guardar.enabled=true
next


end event

type cb_salir from commandbutton within w_acreditados_baja
integer x = 2711
integer y = 1392
integer width = 443
integer height = 92
integer taborder = 40
boolean bringtotop = true
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

type dw_altas_bajas_sit from u_dw within w_acreditados_baja
boolean visible = false
integer x = 37
integer y = 888
integer width = 3104
integer height = 492
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_altas_bajas_situaciones"
end type

type st_1 from statictext within w_acreditados_baja
integer x = 55
integer y = 1404
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "0 Filas"
boolean focusrectangle = false
end type

type cb_guardar from commandbutton within w_acreditados_baja
integer x = 2226
integer y = 1392
integer width = 443
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Actualizar"
end type

event clicked;int res
res=dw_lista.update()
if res<>-1 then res=dw_altas_bajas_sit.update()



if res= -1 then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al actualizar",StopSign!)
else
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Actualizaci$$HEX1$$f300$$ENDHEX$$n Correcta")
end if
end event

