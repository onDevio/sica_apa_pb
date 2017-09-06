HA$PBExportHeader$w_fases_reposiciones.srw
forward
global type w_fases_reposiciones from w_response
end type
type dw_detalle from u_dw within w_fases_reposiciones
end type
type dw_renuncia from u_dw within w_fases_reposiciones
end type
type cb_grabar from u_cb within w_fases_reposiciones
end type
type cb_salir from u_cb within w_fases_reposiciones
end type
end forward

global type w_fases_reposiciones from w_response
integer x = 214
integer y = 221
integer width = 3886
integer height = 1060
string title = "Reposiciones"
dw_detalle dw_detalle
dw_renuncia dw_renuncia
cb_grabar cb_grabar
cb_salir cb_salir
end type
global w_fases_reposiciones w_fases_reposiciones

on w_fases_reposiciones.create
int iCurrent
call super::create
this.dw_detalle=create dw_detalle
this.dw_renuncia=create dw_renuncia
this.cb_grabar=create cb_grabar
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detalle
this.Control[iCurrent+2]=this.dw_renuncia
this.Control[iCurrent+3]=this.cb_grabar
this.Control[iCurrent+4]=this.cb_salir
end on

on w_fases_reposiciones.destroy
call super::destroy
destroy(this.dw_detalle)
destroy(this.dw_renuncia)
destroy(this.cb_grabar)
destroy(this.cb_salir)
end on

event open;call super::open;datawindowchild dwc_child
string id_fases_col,id_col,id_fase
w_fases_detalle ventana
ventana=g_detalle_fases
long i
double porcentaje=0

f_centrar_ventana(this)
id_fases_col=ventana.idw_fases_colegiados.GetItemString(ventana.idw_fases_colegiados.GetRow(),'id_fases_colegiados')
id_fase=ventana.idw_fases_colegiados.GetItemString(ventana.idw_fases_colegiados.GetRow(),'id_fase')
id_col=ventana.idw_fases_colegiados.GetItemString(ventana.idw_fases_colegiados.GetRow(),'id_col')
dw_detalle.retrieve(id_fases_col)

dw_detalle.GetChild('id_fases_colegiado',dwc_child)
dwc_child.SetTransObject(SQLCA)
dwc_child.retrieve(id_fases_col)

if dwc_child.rowcount()>0 then
	porcentaje=dwc_child.GetItemNumber(dwc_child.GetRow(),'fases_colegiados_porcen_a')
end if


dw_renuncia.retrieve(id_fase)

if dw_detalle.rowcount()>0 then
	for i=1 to dw_renuncia.rowcount()
		if dw_detalle.GetItemString(1,'id_renuncia')=dw_renuncia.GetItemString(i,'id_renuncia') then
			dw_renuncia.setitem(i,'seleccionado','S')
		end if
	next
	cb_grabar.visible=false
else
	dw_detalle.insertrow(0)
	dw_detalle.SetItem(1,'id_reposicion',f_siguiente_numero('ID_REPOSICION',10))
	dw_detalle.SetItem(1,'id_fases_colegiado',id_fases_col)
	dw_detalle.SetItem(1,'porcentaje',porcentaje)
	dw_detalle.SetItem(1,'f_reposicion',datetime(today()))
	cb_grabar.visible=true
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_reposiciones
integer x = 571
integer y = 1600
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_reposiciones
integer x = 571
integer y = 1472
end type

type dw_detalle from u_dw within w_fases_reposiciones
integer x = 32
integer y = 16
integer width = 2610
integer height = 304
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_reposiciones_detalle"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;
// Activamos el control calendario para los campos de tipo fecha
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type dw_renuncia from u_dw within w_fases_reposiciones
integer x = 32
integer y = 296
integer width = 3813
integer height = 524
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_reposicion_ren"
boolean hscrollbar = true
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;long i

for i=1 to this.rowcount()
	if i<> row then this.SetItem(i,'seleccionado','N')
next

dw_detalle.SetItem(1,'cambiado','S')
end event

type cb_grabar from u_cb within w_fases_reposiciones
integer x = 535
integer y = 872
integer width = 448
integer taborder = 11
boolean bringtotop = true
string text = "Grabar Reposici$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;call super::clicked;long i
string n_rep,anyo,num

for i=1 to dw_renuncia.rowcount()
	if dw_renuncia.GetItemString(i,'seleccionado')='S' then
		dw_detalle.SetItem(1,'id_renuncia',dw_renuncia.GetItemString(i,'id_renuncia'))
	end if
next

if f_es_vacio(dw_detalle.GetItemString(1,'id_renuncia')) then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Debe asociar la reposici$$HEX1$$f300$$ENDHEX$$n a una renuncia")
	return
end if

anyo=right(String(year(today())),2)
num=f_siguiente_numero('N_REPOS_'+f_delegacion_siglas(g_cod_delegacion),6)
n_rep='RP-'+anyo+'/'+num+'-'+f_delegacion_siglas(g_cod_delegacion)
dw_detalle.SetItem(1,'n_reposicion',n_rep)
if dw_detalle.update()=1 then this.visible=false

end event

type cb_salir from u_cb within w_fases_reposiciones
integer x = 41
integer y = 872
integer width = 448
integer taborder = 21
boolean bringtotop = true
string text = "Cancelar/Salir"
end type

event clicked;call super::clicked;dw_detalle.resetupdate()
close (parent)
end event

