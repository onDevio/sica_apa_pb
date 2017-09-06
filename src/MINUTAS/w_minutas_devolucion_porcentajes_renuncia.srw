HA$PBExportHeader$w_minutas_devolucion_porcentajes_renuncia.srw
forward
global type w_minutas_devolucion_porcentajes_renuncia from w_response
end type
type dw_1 from u_dw within w_minutas_devolucion_porcentajes_renuncia
end type
type cb_1 from commandbutton within w_minutas_devolucion_porcentajes_renuncia
end type
type cb_2 from commandbutton within w_minutas_devolucion_porcentajes_renuncia
end type
type dw_2 from u_dw within w_minutas_devolucion_porcentajes_renuncia
end type
type st_lista_renuncias from statictext within w_minutas_devolucion_porcentajes_renuncia
end type
end forward

global type w_minutas_devolucion_porcentajes_renuncia from w_response
integer width = 2441
integer height = 968
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
st_lista_renuncias st_lista_renuncias
end type
global w_minutas_devolucion_porcentajes_renuncia w_minutas_devolucion_porcentajes_renuncia

type variables
st_minutas_devolucion_porcentajes_renuncia ist_minutas_devolucion_porcentajes_renuncia
end variables

on w_minutas_devolucion_porcentajes_renuncia.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.st_lista_renuncias=create st_lista_renuncias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.st_lista_renuncias
end on

on w_minutas_devolucion_porcentajes_renuncia.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.st_lista_renuncias)
end on

event open;call super::open;f_centrar_ventana(this)
ist_minutas_devolucion_porcentajes_renuncia = Message.PowerObjectParm

//messagebox('kk', string(st_minutas_devolucion_porcentajes_renuncia.id_fase))

dw_1.insertrow(0)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_minutas_devolucion_porcentajes_renuncia
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_minutas_devolucion_porcentajes_renuncia
end type

type dw_1 from u_dw within w_minutas_devolucion_porcentajes_renuncia
event csd_calcular_porcentajes ( )
integer x = 37
integer y = 32
integer width = 2304
integer height = 704
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_minutas_devolucion_desglose_porcentajes"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_calcular_porcentajes();double porc_obra_ejecutada = 0
double porc_participacion_sobre_ejec = 0
double porc_obra_pendiente = 0
double porc_renuncia_sobre_pte = 0 
double porc_participacion_sobre_pte = 0
double porc_final_sobre_total_obra = 0
double porc_renuncia = 0

porc_obra_ejecutada = this.getitemnumber(1, 'porc_obra_ejecutada')
porc_participacion_sobre_ejec = this.getitemnumber(1, 'porc_participacion_sobre_ejec')
porc_obra_pendiente = this.getitemnumber(1, 'porc_obra_pendiente')
porc_renuncia_sobre_pte = this.getitemnumber(1, 'porc_renuncia_sobre_pte')
porc_participacion_sobre_pte = this.getitemnumber(1, 'porc_participacion_sobre_pte')
porc_final_sobre_total_obra = this.getitemnumber(1, 'porc_final_sobre_total_obra')

if isnull(porc_obra_ejecutada) then porc_obra_ejecutada = 0
if isnull(porc_participacion_sobre_ejec) then porc_participacion_sobre_ejec = 0
if isnull(porc_obra_pendiente) then porc_obra_pendiente = 0
if isnull(porc_renuncia_sobre_pte) then porc_renuncia_sobre_pte = 100
if isnull(porc_participacion_sobre_pte) then porc_participacion_sobre_pte = 0
if isnull(porc_final_sobre_total_obra) then porc_final_sobre_total_obra = 0

this.setitem(1, 'porc_renuncia_sobre_pte', porc_renuncia_sobre_pte)

porc_participacion_sobre_ejec = f_fases_colegiados_porcen(ist_minutas_devolucion_porcentajes_renuncia.id_fase,ist_minutas_devolucion_porcentajes_renuncia.id_colegiado)
porc_obra_pendiente = round(100 - porc_obra_ejecutada, 2)
porc_participacion_sobre_pte = round(100 - porc_renuncia_sobre_pte, 2)

porc_final_sobre_total_obra= round((porc_obra_ejecutada*porc_participacion_sobre_ejec/100) + (porc_obra_pendiente*porc_participacion_sobre_pte/100), 2)

porc_renuncia = round(100 - porc_final_sobre_total_obra, 2)

this.setitem(1, 'porc_participacion_sobre_ejec', porc_participacion_sobre_ejec)
this.setitem(1, 'porc_obra_pendiente', porc_obra_pendiente)	
this.setitem(1, 'porc_participacion_sobre_pte', porc_participacion_sobre_pte)
this.setitem(1, 'porc_final_sobre_total_obra', porc_final_sobre_total_obra)
this.setitem(1, 'porc_renuncia', porc_renuncia)
end event

event itemchanged;call super::itemchanged;this.post event csd_calcular_porcentajes()
end event

type cb_1 from commandbutton within w_minutas_devolucion_porcentajes_renuncia
integer x = 1353
integer y = 768
integer width = 475
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;ist_minutas_devolucion_porcentajes_renuncia.porc_obra_ejecutada = dw_1.getitemnumber( 1, 'porc_obra_ejecutada')
ist_minutas_devolucion_porcentajes_renuncia.porc_participacion_sobre_ejec = dw_1.getitemnumber( 1, 'porc_participacion_sobre_ejec')
ist_minutas_devolucion_porcentajes_renuncia.porc_obra_pendiente = dw_1.getitemnumber( 1, 'porc_obra_pendiente')
ist_minutas_devolucion_porcentajes_renuncia.porc_renuncia_sobre_pte = dw_1.getitemnumber( 1, 'porc_renuncia_sobre_pte')
ist_minutas_devolucion_porcentajes_renuncia.porc_participacion_sobre_pte = dw_1.getitemnumber( 1, 'porc_participacion_sobre_pte')
ist_minutas_devolucion_porcentajes_renuncia.porc_final_sobre_total_obra = dw_1.getitemnumber( 1, 'porc_final_sobre_total_obra')
ist_minutas_devolucion_porcentajes_renuncia.porc_renuncia = dw_1.getitemnumber( 1, 'porc_renuncia')

//messagebox('kk', string(dw_1.getitemnumber( 1, 'porc_renuncia')))


closewithreturn(parent, ist_minutas_devolucion_porcentajes_renuncia)
end event

type cb_2 from commandbutton within w_minutas_devolucion_porcentajes_renuncia
integer x = 1865
integer y = 768
integer width = 475
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
end type

event clicked;
ist_minutas_devolucion_porcentajes_renuncia.porc_obra_ejecutada = dw_1.getitemnumber( 1, 'porc_obra_ejecutada')
ist_minutas_devolucion_porcentajes_renuncia.porc_renuncia_sobre_pte = dw_1.getitemnumber( 1, 'porc_renuncia_sobre_pte')
//close(parent)

closewithreturn(parent,ist_minutas_devolucion_porcentajes_renuncia )

end event

type dw_2 from u_dw within w_minutas_devolucion_porcentajes_renuncia
integer x = 78
integer y = 1192
integer width = 3323
integer height = 396
integer taborder = 10
boolean bringtotop = true
boolean ib_isupdateable = false
end type

type st_lista_renuncias from statictext within w_minutas_devolucion_porcentajes_renuncia
integer x = 69
integer y = 1076
integer width = 1175
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Lista de renuncias anteriores:"
boolean focusrectangle = false
end type

