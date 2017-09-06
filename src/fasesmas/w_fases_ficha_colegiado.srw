HA$PBExportHeader$w_fases_ficha_colegiado.srw
forward
global type w_fases_ficha_colegiado from w_response
end type
type cb_1 from commandbutton within w_fases_ficha_colegiado
end type
type cb_aceptar from commandbutton within w_fases_ficha_colegiado
end type
type dw_3 from u_dw within w_fases_ficha_colegiado
end type
type dw_autorizados from u_dw within w_fases_ficha_colegiado
end type
type gb_1 from groupbox within w_fases_ficha_colegiado
end type
end forward

global type w_fases_ficha_colegiado from w_response
integer x = 214
integer y = 221
integer width = 2693
integer height = 2412
string title = "Informaci$$HEX1$$f300$$ENDHEX$$n Colegiado"
cb_1 cb_1
cb_aceptar cb_aceptar
dw_3 dw_3
dw_autorizados dw_autorizados
gb_1 gb_1
end type
global w_fases_ficha_colegiado w_fases_ficha_colegiado

type variables

end variables

event open;call super::open;string id_col

f_centrar_ventana(this)
id_col = message.stringParm
if not(f_es_vacio(id_col)) then
	dw_3.Retrieve(id_col)
	dw_3.Enabled = False
	dw_autorizados.Retrieve(id_col)
	dw_autorizados.Enabled = False	
end if
end event

on w_fases_ficha_colegiado.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_aceptar=create cb_aceptar
this.dw_3=create dw_3
this.dw_autorizados=create dw_autorizados
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_autorizados
this.Control[iCurrent+5]=this.gb_1
end on

on w_fases_ficha_colegiado.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_aceptar)
destroy(this.dw_3)
destroy(this.dw_autorizados)
destroy(this.gb_1)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_ficha_colegiado
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_ficha_colegiado
end type

type cb_1 from commandbutton within w_fases_ficha_colegiado
integer x = 1298
integer y = 2176
integer width = 462
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;dw_3.ResetUpdate()
Close(parent)
end event

type cb_aceptar from commandbutton within w_fases_ficha_colegiado
integer x = 741
integer y = 2176
integer width = 462
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;parent.TriggerEvent('pfc_save')
CloseWithReturn(parent,dw_3.GetItemString(1,'id_colegiado'))
end event

type dw_3 from u_dw within w_fases_ficha_colegiado
integer x = 50
integer y = 48
integer width = 2601
integer height = 1336
integer taborder = 10
string dataobject = "d_fases_colegiados_ficha"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;string pob
choose case dwo.name
	CASE 'b_pobla'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'cod_pob',pob)
		this.SetItem(1,'cp',f_devuelve_cod_postal(pob))
		this.SetItem(1,'cod_prov',f_devuelve_cod_provincia(pob))
		this.SetItem(1,'pais',f_devuelve_cod_pais(pob))
end choose
end event

event itemchanged;call super::itemchanged;string pob
choose case dwo.name
	CASE 'cod_pob'
		if f_es_vacio(data) then return
		this.SetItem(1,'cod_pob',data)
		this.SetItem(1,'cp',f_devuelve_cod_postal(data))
		this.SetItem(1,'cod_prov',f_devuelve_cod_provincia(data))
		this.SetItem(1,'pais',f_devuelve_cod_pais(data))
end choose
end event

type dw_autorizados from u_dw within w_fases_ficha_colegiado
integer x = 114
integer y = 1460
integer width = 2418
integer height = 612
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_colegiados_autorizados"
end type

type gb_1 from groupbox within w_fases_ficha_colegiado
integer x = 69
integer y = 1384
integer width = 2528
integer height = 732
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Personas Autorizadas"
end type

