HA$PBExportHeader$w_recibi_singestion_colegiado_cu.srw
forward
global type w_recibi_singestion_colegiado_cu from w_response
end type
type cb_1 from commandbutton within w_recibi_singestion_colegiado_cu
end type
type dw_colegiados from u_dw within w_recibi_singestion_colegiado_cu
end type
type st_1 from statictext within w_recibi_singestion_colegiado_cu
end type
type dw_3 from u_dw within w_recibi_singestion_colegiado_cu
end type
type cb_3 from commandbutton within w_recibi_singestion_colegiado_cu
end type
end forward

global type w_recibi_singestion_colegiado_cu from w_response
integer width = 1883
integer height = 656
boolean controlmenu = false
event csd_regularizar ( )
event csd_actualizar_pem_sup ( )
event csd_calcular_descuentos ( )
cb_1 cb_1
dw_colegiados dw_colegiados
st_1 st_1
dw_3 dw_3
cb_3 cb_3
end type
global w_recibi_singestion_colegiado_cu w_recibi_singestion_colegiado_cu

type variables
datawindowchild i_dwc_colegiados
w_fases_detalle i_w
datawindow idw_clientes, idw_colegiados, idw_honorarios, idw_descuentos
datawindow idw_fases_datos_exp, idw_1, idw_fases_src, idw_estadistica, idw_historico
string i_id_col, reg

string is_tipo_gestion
end variables

on w_recibi_singestion_colegiado_cu.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_colegiados=create dw_colegiados
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_colegiados
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_3
end on

on w_recibi_singestion_colegiado_cu.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_colegiados)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_3)
end on

event open;call super::open;f_centrar_ventana(this)

dw_colegiados.retrieve(g_id_fase)
dw_colegiados.selectrow(1, true) //para marcar la primera linea
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_recibi_singestion_colegiado_cu
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_recibi_singestion_colegiado_cu
integer x = 242
integer y = 444
integer width = 46
integer taborder = 0
end type

type cb_1 from commandbutton within w_recibi_singestion_colegiado_cu
integer x = 507
integer y = 436
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
boolean default = true
end type

event clicked;string num_colegiado

num_colegiado = dw_colegiados.getitemstring(dw_colegiados.getrow(),'id_col')
closewithreturn(parent, num_colegiado)
end event

type dw_colegiados from u_dw within w_recibi_singestion_colegiado_cu
integer x = 37
integer y = 108
integer width = 1801
integer height = 228
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_recibi_singestion_colegiados_cu"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)


end event

event retrieveend;call super::retrieveend;this.PostEvent(Rowfocuschanged!)
end event

event rowfocuschanged;if this.rowcount() = 0 then return

i_id_col=dw_colegiados.getitemstring(dw_colegiados.getrow(),'id_col')
//dw_cip_musaat.post event csd_rellenar_cip_musaat()
end event

type st_1 from statictext within w_recibi_singestion_colegiado_cu
integer x = 37
integer y = 32
integer width = 690
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
string text = "Seleccione el colegiado :"
boolean focusrectangle = false
end type

type dw_3 from u_dw within w_recibi_singestion_colegiado_cu
boolean visible = false
integer x = 46
integer y = 340
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_factu_minutas_detalle"
end type

type cb_3 from commandbutton within w_recibi_singestion_colegiado_cu
integer x = 1010
integer y = 436
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 'CANCELAR')

end event

