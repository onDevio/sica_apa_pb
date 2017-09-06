HA$PBExportHeader$w_recibos_generar.srw
forward
global type w_recibos_generar from w_response
end type
type dw_recibos from u_dw within w_recibos_generar
end type
type st_1 from statictext within w_recibos_generar
end type
type st_2 from statictext within w_recibos_generar
end type
type dw_errores from u_dw within w_recibos_generar
end type
type cb_1 from commandbutton within w_recibos_generar
end type
type cb_2 from commandbutton within w_recibos_generar
end type
type cb_3 from commandbutton within w_recibos_generar
end type
end forward

global type w_recibos_generar from w_response
integer width = 3474
integer height = 2156
windowstate windowstate = maximized!
dw_recibos dw_recibos
st_1 st_1
st_2 st_2
dw_errores dw_errores
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_recibos_generar w_recibos_generar

type variables
st_datos_recibos i_datos


end variables

on w_recibos_generar.create
int iCurrent
call super::create
this.dw_recibos=create dw_recibos
this.st_1=create st_1
this.st_2=create st_2
this.dw_errores=create dw_errores
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_recibos
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_errores
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
end on

on w_recibos_generar.destroy
call super::destroy
destroy(this.dw_recibos)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_errores)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;i_datos = message.PowerObjectParm

i_datos.ds_recibos.RowsCopy(1,i_datos.ds_recibos.RowCount(),Primary!,dw_recibos,1,Primary!)

if i_datos.ds_errores.RowCount() > 0 then
	i_datos.ds_errores.RowsCopy(1,i_datos.ds_errores.RowCount(),Primary!,dw_errores,1,Primary!)
	cb_3.enabled = true
end if

of_SetResize (true)
inv_resize.of_Register (dw_recibos, "ScaleToRight&Bottom")
inv_resize.of_Register (cb_1, "FixedToRight&Bottom")
inv_resize.of_Register (cb_2, "FixedToRight&Bottom")
inv_resize.of_Register (st_2, "FixedToBottom")
inv_resize.of_Register (dw_errores, "FixedToBottom")
inv_resize.of_Register (cb_3, "FixedToBottom")



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_recibos_generar
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_recibos_generar
end type

type dw_recibos from u_dw within w_recibos_generar
integer x = 78
integer y = 160
integer width = 3337
integer height = 900
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_recibos_factu_e"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type st_1 from statictext within w_recibos_generar
integer x = 128
integer y = 80
integer width = 946
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recibos que se van a generar:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_recibos_generar
integer x = 114
integer y = 1196
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "ERRORES"
boolean focusrectangle = false
end type

type dw_errores from u_dw within w_recibos_generar
integer x = 55
integer y = 1284
integer width = 3337
integer height = 616
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_recibos_errores"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_recibos_generar
integer x = 2592
integer y = 1092
integer width = 402
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;long i
string n_recibo
int ret
st_facturas lst_facturas

if MessageBox(g_titulo,'Se van a generar ' + string(dw_recibos.RowCount()) + ' recibos. $$HEX1$$bf00$$ENDHEX$$Desea continuar?',Question!,YesNo!) = 2 then return

lst_facturas.cod_empresa = g_empresa
lst_facturas.tipo_factura = g_colegio_colegiado

FOR i = 1 to dw_recibos.RowCount()
	n_recibo = dw_recibos.GetItemString(i,'n_fact')
	
	if f_es_vacio(n_recibo) then
		n_recibo=f_siguiente_n_fact_emitida_empresa(lst_facturas,i_datos.serie,'',i_datos.fecha)  
		dw_recibos.SetItem(i,'n_fact',n_recibo)
		
	end if
	
NEXT

dw_recibos.Update()
i_datos.ds_lineas.Update()
i_datos.ds_cobros.Update()

this.enabled = false

string recibo_1,recibo_ultimo
recibo_1 = dw_recibos.GetItemString(1,'n_fact')
recibo_ultimo = dw_recibos.GetItemString(dw_recibos.RowCount(),'n_fact')

MessageBox(g_titulo,"Proceso finalizado, puede salir de esta ventana y comprobar los recibos creados desde " + recibo_1 + " hasta " + recibo_ultimo + " en facturaci$$HEX1$$f300$$ENDHEX$$n")
 
 
end event

type cb_2 from commandbutton within w_recibos_generar
integer x = 3013
integer y = 1092
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
boolean cancel = true
end type

event clicked;close(parent)

end event

type cb_3 from commandbutton within w_recibos_generar
integer x = 3013
integer y = 1924
integer width = 402
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;dw_errores.Print()

end event

