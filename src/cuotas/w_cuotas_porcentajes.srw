HA$PBExportHeader$w_cuotas_porcentajes.srw
forward
global type w_cuotas_porcentajes from w_response
end type
type dw_1 from u_dw within w_cuotas_porcentajes
end type
type dw_2 from u_dw within w_cuotas_porcentajes
end type
type sle_por_total from u_sle within w_cuotas_porcentajes
end type
type st_total from statictext within w_cuotas_porcentajes
end type
type cb_aceptar from picturebutton within w_cuotas_porcentajes
end type
type cb_cancelar from picturebutton within w_cuotas_porcentajes
end type
end forward

global type w_cuotas_porcentajes from w_response
integer width = 3168
integer height = 2176
dw_1 dw_1
dw_2 dw_2
sle_por_total sle_por_total
st_total st_total
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_cuotas_porcentajes w_cuotas_porcentajes

forward prototypes
public function string wf_cuotas_calcula_porcentaje ()
end prototypes

public function string wf_cuotas_calcula_porcentaje ();long i,ll_suma

dw_1.AcceptText()

ll_suma=0
for i=3 to 37 step 2
	ll_suma=ll_suma + dw_1.GetItemNumber(dw_1.GetRow(),i)
	
next

return string(ll_suma)
end function

on w_cuotas_porcentajes.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.sle_por_total=create sle_por_total
this.st_total=create st_total
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.sle_por_total
this.Control[iCurrent+4]=this.st_total
this.Control[iCurrent+5]=this.cb_aceptar
this.Control[iCurrent+6]=this.cb_cancelar
end on

on w_cuotas_porcentajes.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.sle_por_total)
destroy(this.st_total)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;//Modificado por Antonio 11/01/2005
long aux

st_total.backcolor = 30525110

//sle_por_total.text = Message.StringParm
Message.StringParm = ""

//asignamos los nombres de las ventanas de porcentajes y hacemos el retrieve
dw_1.Insertrow(0)
dw_1.object.t_titulo.text =('Proyectos reformados y obras de reforma')
dw_1.retrieve('reform',f_colegio())
dw_2.Insertrow(0)
dw_2.object.t_titulo.text =('Obras de Infraestructura y Urbanizaci$$HEX1$$f300$$ENDHEX$$n')

aux = dw_2.retrieve('infra',f_colegio())

if aux = 0 then
	dw_2.visible = false
	this.Width = 1701
	cb_aceptar.X = 763	
	cb_cancelar.X = 1225
	sle_por_total.X = 457
	st_total.X = 41
end if

f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cuotas_porcentajes
integer x = 2350
integer y = 1852
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cuotas_porcentajes
integer x = 1975
integer y = 1872
end type

type dw_1 from u_dw within w_cuotas_porcentajes
integer x = 27
integer y = 20
integer width = 1513
integer height = 1844
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cuotas_porcentajes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//Modificado por Antonio 11/01/2005
long ll_suma,i , ll_porc

//vaciamos los checks del dw_2
for i = 1 to dw_2.rowcount() 
	if dw_2.getitemstring(i,'aceptado') = 'S' then
		dw_2.setitem(i,'aceptado','N')
		sle_por_total.text = '0'
	end if
next

//asignamos el valor del porcentaje en funcion del campo seleccionado
if data='N' then
	//si vaciamos el check, restamos el valor al porcentaje total
	ll_porc = integer(dw_1.GetItemString(row,'valor'))
	ll_suma = integer(sle_por_total.text) - ll_porc	
else		
	//si seleccionamos el check, sumamos al total el valor escogido
	ll_porc = integer(dw_1.GetItemString(row,'valor'))
	ll_suma = integer(sle_por_total.text) + ll_porc
end if // FIN data='N'

//asignamos el total del porcentaje
sle_por_total.text=string(ll_suma)

		
		
end event

type dw_2 from u_dw within w_cuotas_porcentajes
integer x = 1595
integer y = 20
integer width = 1513
integer height = 1820
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cuotas_porcentajes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event itemchanged;call super::itemchanged;//Modificado por Antonio 11/01/2005
long ll_suma,i, ll_porc

//vaciamos los checks del dw_1
for i = 1 to dw_1.rowcount() 
	if dw_1.getitemstring(i,'aceptado') = 'S' then
		dw_1.setitem(i,'aceptado','N')
		sle_por_total.text = '0'
	end if
next

//asignamos el valor del porcentaje en funcion del campo seleccionado
if data='N' then
	//si vaciamos el check, restamos el valor al porcentaje total
	ll_porc = integer(dw_2.GetItemString(row,'valor'))
	ll_suma = integer(sle_por_total.text) - ll_porc	
else		
	//si seleccionamos el check, sumamos al total el valor escogido
	ll_porc = integer(dw_2.GetItemString(row,'valor'))
	ll_suma = integer(sle_por_total.text) + ll_porc
end if

//asignamos el total del porcentaje
sle_por_total.text=string(ll_suma)
		
		
end event

type sle_por_total from u_sle within w_cuotas_porcentajes
integer x = 1449
integer y = 1916
integer width = 206
integer taborder = 11
boolean bringtotop = true
string text = "0"
end type

type st_total from statictext within w_cuotas_porcentajes
integer x = 1033
integer y = 1924
integer width = 379
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Porcentaje Total:"
boolean focusrectangle = false
end type

type cb_aceptar from picturebutton within w_cuotas_porcentajes
integer x = 1952
integer y = 1916
integer width = 352
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = ".\Imagenes\Boton_aceptar.jpg"
alignment htextalign = left!
end type

event clicked;dw_1.AcceptText()
CloseWithReturn(parent,sle_por_total.text)
end event

type cb_cancelar from picturebutton within w_cuotas_porcentajes
integer x = 2514
integer y = 1916
integer width = 352
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = ".\Imagenes\Boton_cancelar.jpg"
alignment htextalign = left!
end type

event clicked;close(parent)
end event

