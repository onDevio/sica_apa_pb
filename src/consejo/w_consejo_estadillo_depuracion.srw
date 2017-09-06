HA$PBExportHeader$w_consejo_estadillo_depuracion.srw
forward
global type w_consejo_estadillo_depuracion from w_csd_sheet
end type
type cb_iniciar from commandbutton within w_consejo_estadillo_depuracion
end type
type cb_imprimir from commandbutton within w_consejo_estadillo_depuracion
end type
type cb_salir from commandbutton within w_consejo_estadillo_depuracion
end type
type dw_listado from u_csd_dw within w_consejo_estadillo_depuracion
end type
type st_1 from statictext within w_consejo_estadillo_depuracion
end type
type st_total from statictext within w_consejo_estadillo_depuracion
end type
end forward

global type w_consejo_estadillo_depuracion from w_csd_sheet
integer width = 1554
integer height = 1592
string title = "Depuraci$$HEX1$$f300$$ENDHEX$$n Altas/Bajas"
cb_iniciar cb_iniciar
cb_imprimir cb_imprimir
cb_salir cb_salir
dw_listado dw_listado
st_1 st_1
st_total st_total
end type
global w_consejo_estadillo_depuracion w_consejo_estadillo_depuracion

on w_consejo_estadillo_depuracion.create
int iCurrent
call super::create
this.cb_iniciar=create cb_iniciar
this.cb_imprimir=create cb_imprimir
this.cb_salir=create cb_salir
this.dw_listado=create dw_listado
this.st_1=create st_1
this.st_total=create st_total
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_iniciar
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.cb_salir
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_total
end on

on w_consejo_estadillo_depuracion.destroy
call super::destroy
destroy(this.cb_iniciar)
destroy(this.cb_imprimir)
destroy(this.cb_salir)
destroy(this.dw_listado)
destroy(this.st_1)
destroy(this.st_total)
end on

type cb_recuperar_pantalla from w_csd_sheet`cb_recuperar_pantalla within w_consejo_estadillo_depuracion
integer x = 1426
integer y = 708
end type

type cb_guardar_pantalla from w_csd_sheet`cb_guardar_pantalla within w_consejo_estadillo_depuracion
integer x = 1426
integer y = 588
end type

type cb_iniciar from commandbutton within w_consejo_estadillo_depuracion
integer x = 37
integer y = 1328
integer width = 608
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Iniciar Comprobaci$$HEX1$$f300$$ENDHEX$$n"
end type

event clicked;datastore ds_colegiados,ds_altas_bajas
long ll_i,ll_j,ll_pos
integer li_n_altas_bajas
string ls_id_colegiado,ls_estado,ls_ncol,ls_alta,ls_baja
boolean lb_hayAlta,lb_hayBaja

ds_colegiados = create Datastore
ds_colegiados.DataObject = 'd_colegiados_lista'
ds_colegiados.SetTransObject(SQLCA)
ds_colegiados.retrieve()

ds_altas_bajas = create Datastore
ds_altas_bajas.DataObject = 'ds_consejo_altas_bajas_situaciones'
ds_altas_bajas.SetTransObject(SQLCA)

dw_listado.reset()

//Por cada colegiado comprobamos el n$$HEX2$$ba002000$$ENDHEX$$de situaciones segun estado.
for ll_i=1 to ds_colegiados.Rowcount()
	
	ls_id_colegiado = ds_colegiados.GetItemString(ll_i,'id_colegiado')
	ls_ncol = ds_colegiados.GetItemString(ll_i,'n_colegiado')
	ls_estado = ds_colegiados.GetItemString(ll_i,'alta_baja')
	ds_altas_bajas.Retrieve(ls_id_colegiado)
	
	lb_hayAlta = false
	lb_hayBaja = false
	
	if ds_altas_bajas.RowCount() = 0  then
		if ls_estado = 'A' then
			ll_pos = dw_listado.InsertRow(0)
			dw_listado.SetItem(ll_pos,'ncolegiado',ls_ncol)
			dw_listado.SetItem(ll_pos,'alta_baja',ls_estado)
			dw_listado.SetItem(ll_pos,'n_alta_baja',0)
		end if
	else
		//Anotamos la diferencia entre altas y bajas (alta - baja)
		li_n_altas_bajas = 0
		for ll_j=1 to ds_altas_bajas.RowCount()
			ls_alta = ds_altas_bajas.GetItemString(ll_j,'alta')
			if ls_alta = 'S' then
				li_n_altas_bajas++
				lb_hayAlta = true
			else
				ls_baja = ds_altas_bajas.GetItemString(ll_j,'baja')
				if ls_baja = 'S' then 
					lb_hayBaja = true
					li_n_altas_bajas = li_n_altas_bajas -1
				end if
			end if
		next
		//Si el estado es alta entonces debe haber un alta mas q bajas (li_n_altas_bajas = 1)
		if ls_estado = 'S' then
			
			if (li_n_altas_bajas <> 1) or (not lb_hayAlta) then
				ll_pos = dw_listado.InsertRow(0)
				dw_listado.SetItem(ll_pos,'ncolegiado',ls_ncol)
				dw_listado.SetItem(ll_pos,'alta_baja',ls_estado)
				dw_listado.SetItem(ll_pos,'n_alta_baja',li_n_altas_bajas)
			end if
		else//Si el estado es baja deben haber las mismas altas que bajas (li_n_altas_bajas = 0)	
			if (li_n_altas_bajas <> 0) or (not lb_hayBaja) then
				ll_pos = dw_listado.InsertRow(0)
				dw_listado.SetItem(ll_pos,'ncolegiado',ls_ncol)
				dw_listado.SetItem(ll_pos,'alta_baja',ls_estado)
				dw_listado.SetItem(ll_pos,'n_alta_baja',li_n_altas_bajas)
			end if
		end if
		
	end if
next
st_total.text = string(dw_listado.RowCount())
destroy(ds_altas_bajas)
destroy(ds_colegiados)
end event

type cb_imprimir from commandbutton within w_consejo_estadillo_depuracion
integer x = 649
integer y = 1328
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir"
end type

event clicked;dw_listado.print()
end event

type cb_salir from commandbutton within w_consejo_estadillo_depuracion
integer x = 1056
integer y = 1328
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;close(parent)
end event

type dw_listado from u_csd_dw within w_consejo_estadillo_depuracion
integer x = 37
integer y = 32
integer width = 1422
integer height = 1184
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_consejo_estadillo_depuracion"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)
this.of_SetTransObject(SQLCA)


// Column header sort
inv_sort.of_SetColumnHeader (true)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)

// Enable printpreview service
of_SetPrintPreview (true)
end event

type st_1 from statictext within w_consejo_estadillo_depuracion
integer x = 997
integer y = 1244
integer width = 178
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_total from statictext within w_consejo_estadillo_depuracion
integer x = 1243
integer y = 1244
integer width = 210
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

