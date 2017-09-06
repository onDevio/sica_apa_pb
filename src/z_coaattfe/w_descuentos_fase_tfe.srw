HA$PBExportHeader$w_descuentos_fase_tfe.srw
forward
global type w_descuentos_fase_tfe from w_popup
end type
type cb_2 from commandbutton within w_descuentos_fase_tfe
end type
type cb_1 from commandbutton within w_descuentos_fase_tfe
end type
type dw_descuentos from u_dw within w_descuentos_fase_tfe
end type
end forward

global type w_descuentos_fase_tfe from w_popup
integer x = 214
integer y = 221
integer width = 2569
integer height = 1444
string title = "Informaci$$HEX1$$f300$$ENDHEX$$n econ$$HEX1$$f300$$ENDHEX$$mica"
boolean minbox = false
boolean maxbox = false
event csd_cargar_datos ( )
cb_2 cb_2
cb_1 cb_1
dw_descuentos dw_descuentos
end type
global w_descuentos_fase_tfe w_descuentos_fase_tfe

type variables
string i_id_fase
end variables

event csd_cargar_datos();if f_es_vacio(i_id_fase) then return

dw_descuentos.insertrow(0)

datastore ds_lista_minutas
ds_lista_minutas = create datastore
ds_lista_minutas.dataobject = 'd_descuentos_lista_minutas_tfe'
ds_lista_minutas.settransobject(sqlca)
ds_lista_minutas.retrieve(i_id_fase)

string n_registro, n_expedi, n_salida
datetime f_entrada

  SELECT fases.n_registro,   
         fases.n_expedi,   
         fases.f_entrada,   
         fases.archivo  
    INTO :n_registro,   
         :n_expedi,   
         :f_entrada,   
         :n_salida  
    FROM fases  
	 where id_fase = :i_id_fase;

dw_descuentos.setitem(1,'n_registro', n_registro)
dw_descuentos.setitem(1,'f_entrada', f_entrada)
dw_descuentos.setitem(1,'n_salida', n_salida)
dw_descuentos.setitem(1,'n_expedi', n_expedi)

double i
double base_honos = 0, igic_honos = 0, base_desplaza = 0, igic_desplaza = 0, irpf = 0
double base_cip = 0 , igic_cip = 0 , base_src = 0, cobro_cuenta = 0
double total_honos = 0, total_gastos = 0, total = 0

for i = 1 to ds_lista_minutas.rowcount()
	base_honos += ds_lista_minutas.getitemnumber(i, 'base_honos')
	igic_honos += ds_lista_minutas.getitemnumber(i, 'iva_honos')
	base_desplaza += ds_lista_minutas.getitemnumber(i, 'base_desplaza')
	igic_desplaza += ds_lista_minutas.getitemnumber(i, 'iva_desplaza')
	irpf += ds_lista_minutas.getitemnumber(i, 'importe_irpf')
	base_cip += ds_lista_minutas.getitemnumber(i, 'base_cip')
	igic_cip += ds_lista_minutas.getitemnumber(i, 'iva_cip')
	base_src += ds_lista_minutas.getitemnumber(i, 'base_musaat')
	cobro_cuenta += ds_lista_minutas.getitemnumber(i, 'cobro_a_cuenta')
next
base_honos = f_redondea(base_honos)
igic_honos = f_redondea(igic_honos)
base_desplaza = f_redondea(base_desplaza)
igic_desplaza = f_redondea(igic_desplaza)
irpf = f_redondea(irpf)
base_cip = f_redondea(base_cip)
igic_cip = f_redondea(igic_cip)
base_src = f_redondea(base_src)
cobro_cuenta = f_redondea(cobro_cuenta)

dw_descuentos.setitem(1, 'base_honos',base_honos)
dw_descuentos.setitem(1, 'iva_honos',igic_honos)
dw_descuentos.setitem(1, 'base_desplaza',base_desplaza)
dw_descuentos.setitem(1, 'iva_desplaza',igic_desplaza)
dw_descuentos.setitem(1, 'irpf',(-1)*irpf)
dw_descuentos.setitem(1, 'base_cip',base_cip)
dw_descuentos.setitem(1, 'iva_cip',igic_cip)
dw_descuentos.setitem(1, 'src',base_src)
dw_descuentos.setitem(1, 'pago_cuenta',(-1)*cobro_cuenta) // Signo negativo

total_honos = f_redondea(base_honos+igic_honos+base_desplaza+igic_desplaza - irpf - cobro_cuenta)
total_gastos = f_redondea(base_cip+igic_cip+base_src)
total = f_redondea(total_honos+total_gastos)

dw_descuentos.setitem(1, 'total_honos',total_honos)
dw_descuentos.setitem(1, 'total_gastos',total_gastos)
dw_descuentos.setitem(1, 'total',total)

end event

on w_descuentos_fase_tfe.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_descuentos=create dw_descuentos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_descuentos
end on

on w_descuentos_fase_tfe.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_descuentos)
end on

event open;call super::open;i_id_fase = message.stringparm

this.postevent('csd_cargar_datos')

end event

event pfc_preopen;call super::pfc_preopen;f_centrar_ventana(this)
end event

type cb_2 from commandbutton within w_descuentos_fase_tfe
integer x = 2085
integer y = 1136
integer width = 402
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
boolean default = true
end type

event clicked;dw_descuentos.print()
end event

type cb_1 from commandbutton within w_descuentos_fase_tfe
integer x = 1019
integer y = 1136
integer width = 402
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;close(parent)
end event

type dw_descuentos from u_dw within w_descuentos_fase_tfe
integer x = 37
integer y = 28
integer width = 2446
integer height = 1064
integer taborder = 0
string dataobject = "d_descuentos_fases_tfe"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

