HA$PBExportHeader$w_cip_sobre_pem.srw
forward
global type w_cip_sobre_pem from w_mant
end type
type st_1 from statictext within w_cip_sobre_pem
end type
type st_2 from statictext within w_cip_sobre_pem
end type
type sle_1 from u_sle within w_cip_sobre_pem
end type
type sle_2 from u_sle within w_cip_sobre_pem
end type
type cb_buscar from commandbutton within w_cip_sobre_pem
end type
type tab_1 from tab within w_cip_sobre_pem
end type
type tabpage_1 from userobject within tab_1
end type
type dw_cip_sobre_pem from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_cip_sobre_pem dw_cip_sobre_pem
end type
type tabpage_2 from userobject within tab_1
end type
type dw_cip_fijo from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_cip_fijo dw_cip_fijo
end type
type tab_1 from tab within w_cip_sobre_pem
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_cip_sobre_pem from w_mant
integer width = 3255
integer height = 1540
string menuname = "m_manteni"
st_1 st_1
st_2 st_2
sle_1 sle_1
sle_2 sle_2
cb_buscar cb_buscar
tab_1 tab_1
end type
global w_cip_sobre_pem w_cip_sobre_pem

type variables
u_dw idw_cip_sobre_pem , idw_cip_fijo
u_dw idw_activa
end variables

on w_cip_sobre_pem.create
int iCurrent
call super::create
if this.MenuName = "m_manteni" then this.MenuID = create m_manteni
this.st_1=create st_1
this.st_2=create st_2
this.sle_1=create sle_1
this.sle_2=create sle_2
this.cb_buscar=create cb_buscar
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.cb_buscar
this.Control[iCurrent+6]=this.tab_1
end on

on w_cip_sobre_pem.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.sle_2)
destroy(this.cb_buscar)
destroy(this.tab_1)
end on

event open;call super::open;if g_colegio = 'COAATGUI' then
	tab_1.tabpage_1.text = 'DIC sobre Presupuesto de Ejecuci$$HEX1$$f300$$ENDHEX$$n Material'
	tab_1.tabpage_2.text = 'DIC con Importe Fijo'
end if

//Por defecto, recuperaremos los datos desde dw_1.
ii_ayuda=60

idw_cip_sobre_pem = tab_1.tabpage_1.dw_cip_sobre_pem
idw_cip_fijo = tab_1.tabpage_2.dw_cip_fijo
idw_activa = idw_cip_sobre_pem

inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_cip_sobre_pem, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_cip_fijo, "ScaletoRight&Bottom")
end event

event pfc_postopen;call super::pfc_postopen;idw_cip_sobre_pem.event pfc_retrieve()
idw_cip_fijo.event pfc_retrieve()
end event

type dw_1 from w_mant`dw_1 within w_cip_sobre_pem
event csd_retrieve ( )
boolean visible = false
integer x = 1737
integer y = 1208
integer width = 146
integer height = 112
integer taborder = 80
string dataobject = "d_listados1"
end type

event dw_1::constructor;return 1
end event

type cb_anyadir from w_mant`cb_anyadir within w_cip_sobre_pem
integer x = 37
integer taborder = 50
end type

event cb_anyadir::clicked;//SOBREESCRITO
idw_activa.event pfc_addrow()

end event

type cb_borrar from w_mant`cb_borrar within w_cip_sobre_pem
integer x = 334
integer taborder = 60
end type

event cb_borrar::clicked;//SOBREESCRITO
idw_activa.event pfc_deleterow()
end event

type cb_ayuda from w_mant`cb_ayuda within w_cip_sobre_pem
boolean visible = false
integer taborder = 70
end type

type st_1 from statictext within w_cip_sobre_pem
integer x = 27
integer y = 24
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 82042848
boolean enabled = false
string text = "Tipo Actuaci$$HEX1$$f300$$ENDHEX$$n:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_cip_sobre_pem
integer x = 1573
integer y = 24
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 82042848
boolean enabled = false
string text = "Tipo de Obra:"
boolean focusrectangle = false
end type

type sle_1 from u_sle within w_cip_sobre_pem
string tag = "microhelp=Introduzca el par$$HEX1$$e100$$ENDHEX$$metro o principio del par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda"
integer x = 416
integer y = 24
integer width = 942
integer taborder = 10
textcase textcase = upper!
end type

type sle_2 from u_sle within w_cip_sobre_pem
string tag = "microhelp=Introduzca el par$$HEX1$$e100$$ENDHEX$$metro o principio del par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda"
integer x = 1929
integer y = 24
integer width = 846
integer taborder = 20
end type

type cb_buscar from commandbutton within w_cip_sobre_pem
event clicked pbm_bnclicked
integer x = 2816
integer y = 20
integer width = 334
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Buscar"
end type

event clicked;//if (sle_1.text + sle_2.text = '') then
//	messagebox("B$$HEX1$$fa00$$ENDHEX$$squeda de datos","Debe especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda",StopSign!)
//	sle_1.SetFocus()
//	return
//end if
idw_cip_sobre_pem.event pfc_retrieve()
idw_cip_fijo.event pfc_retrieve()
end event

type tab_1 from tab within w_cip_sobre_pem
integer x = 32
integer y = 128
integer width = 3173
integer height = 1052
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;choose case newindex
	case 1
		idw_activa = idw_cip_sobre_pem
	case 2
		idw_activa = idw_cip_fijo
end choose

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3136
integer height = 936
long backcolor = 79741120
string text = "CIP sobre Presupuesto de Ejecuci$$HEX1$$f300$$ENDHEX$$n Material"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cip_sobre_pem dw_cip_sobre_pem
end type

on tabpage_1.create
this.dw_cip_sobre_pem=create dw_cip_sobre_pem
this.Control[]={this.dw_cip_sobre_pem}
end on

on tabpage_1.destroy
destroy(this.dw_cip_sobre_pem)
end on

type dw_cip_sobre_pem from u_dw within tabpage_1
event csd_situa_en_columna ( string columna )
integer width = 3141
integer height = 932
integer taborder = 10
string dataobject = "d_cip_sobre_pem_no_fijo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_situa_en_columna;this.setfocus()
this.setcolumn(columna)
end event

event pfc_retrieve;call super::pfc_retrieve;string parm1, parm2
parm1 = sle_1.text
parm2 = sle_2.text
if f_es_vacio(sle_1.text) then parm1 = '%'
if f_es_vacio(sle_2.text) then parm2 = '%'
return this.retrieve(parm1,parm2)
end event

event pfc_addrow;call super::pfc_addrow;int fila 
fila = ancestorreturnvalue
if fila <= 0 then return ancestorreturnvalue
this.scrolltorow(fila)
this.post event csd_situa_en_columna('tipo_actuacion')
this.setitem(fila, 'aplicar_fijo', 'N')
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(this.getrow(), 'aplicar_fijo', 'N')
return ancestorreturnvalue

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3136
integer height = 936
long backcolor = 79741120
string text = "CIP con Importe Fijo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cip_fijo dw_cip_fijo
end type

on tabpage_2.create
this.dw_cip_fijo=create dw_cip_fijo
this.Control[]={this.dw_cip_fijo}
end on

on tabpage_2.destroy
destroy(this.dw_cip_fijo)
end on

type dw_cip_fijo from u_dw within tabpage_2
event csd_situa_en_columna ( string columna )
integer width = 3136
integer height = 936
integer taborder = 11
string dataobject = "d_cip_sobre_pem_fijo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event csd_situa_en_columna;this.setfocus()
this.setcolumn(columna)
end event

event pfc_retrieve;call super::pfc_retrieve;string parm1, parm2
parm1 = sle_1.text
parm2 = sle_2.text
if f_es_vacio(sle_1.text) then parm1 = '%'
if f_es_vacio(sle_2.text) then parm2 = '%'
return this.retrieve(parm1,parm2)
end event

event pfc_addrow;call super::pfc_addrow;int fila 
fila = ancestorreturnvalue
if fila <= 0 then return ancestorreturnvalue
this.scrolltorow(fila)
this.post event csd_situa_en_columna('tipo_actuacion')
this.setitem(this.getrow(), 'aplicar_fijo', 'S')
return ancestorreturnvalue
end event

event pfc_insertrow;call super::pfc_insertrow;this.setitem(this.getrow(), 'aplicar_fijo', 'S')
return ancestorreturnvalue

end event

