HA$PBExportHeader$w_pem_minimo_usos.srw
forward
global type w_pem_minimo_usos from w_response
end type
type dw_1 from u_dw within w_pem_minimo_usos
end type
type cb_1 from commandbutton within w_pem_minimo_usos
end type
type cb_2 from commandbutton within w_pem_minimo_usos
end type
end forward

global type w_pem_minimo_usos from w_response
integer width = 2235
integer height = 1316
boolean titlebar = false
boolean controlmenu = false
boolean ib_isupdateable = false
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_pem_minimo_usos w_pem_minimo_usos

type variables
string is_id_fase
end variables

on w_pem_minimo_usos.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_pem_minimo_usos.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;integer i,fila
string cod_uso
double sup

is_id_fase = message.stringparm

f_centrar_ventana(this)


dw_1.settransobject(sqlca)
dw_1.retrieve()

datastore ds_act
ds_act=create datastore
ds_act.dataobject='d_calculo_pem_min_usos_cc'
ds_act.SetTransObject(SQLCA)
ds_act.retrieve(is_id_fase)

for i=1 to ds_act.rowcount()
	
	cod_uso=ds_act.GetItemString(i,'cod_uso')
	sup=ds_act.GetItemNumber(i,'superficie')
	
	fila=dw_1.Find("cod_uso='"+cod_uso+"'",1,dw_1.rowcount())
	if fila>0 then dw_1.SetItem(fila,'superficie',sup)

next


end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_pem_minimo_usos
integer x = 2427
integer y = 1084
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_pem_minimo_usos
integer x = 2427
integer y = 956
end type

type dw_1 from u_dw within w_pem_minimo_usos
integer x = 37
integer y = 32
integer width = 2162
integer height = 1096
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_usos_tarifa_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_pem_minimo_usos
integer x = 946
integer y = 1192
integer width = 343
integer height = 92
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

event clicked;integer i,fila
double sup,tot_sup,sup_fase,sup_viv,sup_otros,sup_gar
string cod_uso

dw_1.AcceptText()

datastore ds_act
ds_act=create datastore
ds_act.dataobject='d_calculo_pem_min_usos_cc'
ds_act.SetTransObject(SQLCA)
ds_act.retrieve(is_id_fase)

for i=1 to dw_1.rowcount()

	cod_uso=dw_1.GetItemString(i,'cod_uso')
	sup=dw_1.GetItemNumber(i,'superficie')
	if IsNull(sup) then sup=0
	
	if sup>0 then
		fila=ds_act.Find("cod_uso='"+cod_uso+"'",1,ds_act.rowcount())
		if fila>0 then
			ds_act.SetItem(fila,'superficie',sup)
		else
			fila=ds_act.insertrow(0)
			ds_act.SetItem(fila,'id_fase',is_id_fase)
			ds_act.SetItem(fila,'cod_uso',cod_uso)		
			ds_act.SetItem(fila,'superficie',sup)		
		end if
		tot_sup+=sup
	end if
next

i=ds_act.update()

select sup_viv,sup_otros,sup_garage into :sup_viv,:sup_otros,:sup_gar from fases_usos where id_fase=:is_id_fase;
if IsNull(sup_fase) then sup_fase=0
if IsNull(sup_otros) then sup_otros=0
if IsNull(sup_gar) then sup_gar=0
sup_fase=sup_viv+sup_otros+sup_gar
if sup_fase<>tot_sup then
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","La superficie de los usos no coincide con la superficie total del contrato")
end if

closewithreturn(parent, dw_1.getitemnumber(1, 'resultado'))

end event

type cb_2 from commandbutton within w_pem_minimo_usos
integer x = 1819
integer y = 1184
integer width = 370
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Limpiar Valores"
end type

event clicked;integer i

for i=1 to dw_1.rowcount()
	dw_1.SetItem(i,'superficie',0)	
next
end event

