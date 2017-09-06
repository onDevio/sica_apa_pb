HA$PBExportHeader$w_desglose_honos.srw
forward
global type w_desglose_honos from w_response
end type
type cb_2 from commandbutton within w_desglose_honos
end type
type cb_1 from commandbutton within w_desglose_honos
end type
type dw_1 from u_dw within w_desglose_honos
end type
type cb_3 from commandbutton within w_desglose_honos
end type
end forward

global type w_desglose_honos from w_response
integer width = 1728
integer height = 912
string title = "Desglose Honorarios"
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
cb_3 cb_3
end type
global w_desglose_honos w_desglose_honos

type variables
w_fases_detalle  i_w
datawindow idw_1
double i_honorarios
end variables

on w_desglose_honos.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_3
end on

on w_desglose_honos.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_3)
end on

event open;string id_fase, redac, coord, t_act

i_w = g_detalle_fases
idw_1 = i_w.dw_1

i_honorarios = idw_1.GetItemNumber(1,'honorarios')
t_act = idw_1.getitemstring(1, 'fase')
f_centrar_ventana(this)

//id_fase = i_w.dw_1.getitemstring(1, 'id_fase')
//if dw_1.retrieve(id_fase) <= 0 then return

//redac = dw_1.getitemstring(1, 'check_1')
//coord = dw_1.getitemstring(1, 'check_2')

dw_1.insertrow(0)

CHOOSE CASE t_act
	CASE '01','02'
		dw_1.setitem(1, 'check_1', 'S')
		dw_1.setitem(1, 'check_2', 'N')
		dw_1.event csd_redaccion()
	CASE '03'
		dw_1.setitem(1, 'check_1', 'N')
		dw_1.setitem(1, 'check_2', 'S')
		dw_1.event csd_coordinacion()
	CASE '04','05'
		dw_1.setitem(1, 'check_1', 'S')
		dw_1.setitem(1, 'check_2', 'S')
		dw_1.event csd_ambos()
	CASE '11'
		dw_1.setitem(1, 'check_1', 'N')
		dw_1.setitem(1, 'check_2', 'S')
		dw_1.event csd_coordinacion()
END CHOOSE

//dw_1.event csd_calcular_todo(redac, coord)

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_desglose_honos
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_desglose_honos
end type

type cb_2 from commandbutton within w_desglose_honos
boolean visible = false
integer x = 978
integer y = 592
integer width = 398
integer height = 100
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

type cb_1 from commandbutton within w_desglose_honos
boolean visible = false
integer x = 256
integer y = 592
integer width = 398
integer height = 100
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

type dw_1 from u_dw within w_desglose_honos
event csd_ambos ( )
event csd_redaccion ( )
event csd_ninguno ( )
event csd_coordinacion ( )
event csd_calcular_todo ( string redac,  string coord )
integer x = 59
integer y = 148
integer width = 1595
integer height = 452
integer taborder = 10
string dataobject = "d_desglose_honos"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_ambos;// Desglose: 30% proyecto, 21% aprob.plan, 49% control y seg

this.setitem(1, 'redaccion', i_honorarios * 0.30)
this.setitem(1, 'aprobacion', i_honorarios * 0.21)
this.setitem(1, 'control', i_honorarios * 0.49)

end event

event csd_redaccion;// Desglose: 100% redaccion

this.setitem(1, 'redaccion', i_honorarios)
this.setitem(1, 'aprobacion', 0)
this.setitem(1, 'control', 0)

end event

event csd_ninguno;this.setitem(1, 'redaccion', 0)
this.setitem(1, 'aprobacion', 0)
this.setitem(1, 'control', 0)

end event

event csd_coordinacion;// Desglose: 30% aprob.plan, 70% control y seg

this.setitem(1, 'redaccion', 0)
this.setitem(1, 'aprobacion', i_honorarios * 0.30)
this.setitem(1, 'control', i_honorarios * 0.70)

end event

event csd_calcular_todo;if coord = 'S' and redac = 'S' then event csd_ambos()
if coord = 'S' and redac = 'N' then event csd_coordinacion()
if coord = 'N' and redac = 'S' then event csd_redaccion()
if coord = 'N' and redac = 'N' then event csd_ninguno()
end event

event itemchanged;string coord, redac

CHOOSE CASE dwo.name
	CASE 'check_1'
		coord = this.getitemstring(1, 'check_2')
		redac = data
//		if data = 'S' and coord = 'S' then event csd_ambos()
//		if data = 'S' and coord = 'N' then event csd_redaccion()
//		if data = 'N' and coord = 'S' then event csd_coordinacion()
//		if data = 'N' and coord = 'N' then event csd_ninguno()
//			
	CASE 'check_2'
		coord = data
		redac = this.getitemstring(1, 'check_1')
//		if data = 'S' and redac = 'S' then event csd_ambos()
//		if data = 'S' and redac = 'N' then event csd_coordinacion()
//		if data = 'N' and redac = 'S' then event csd_redaccion()
//		if data = 'N' and redac = 'N' then event csd_ninguno()
END CHOOSE

this.event csd_calcular_todo(redac, coord)

end event

type cb_3 from commandbutton within w_desglose_honos
integer x = 635
integer y = 640
integer width = 402
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;//parent.event pfc_save()
close(parent)
end event

