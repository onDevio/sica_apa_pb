HA$PBExportHeader$w_morosidad_colegiado.srw
forward
global type w_morosidad_colegiado from w_response
end type
type cb_buscar from commandbutton within w_morosidad_colegiado
end type
type tab_mov from tab within w_morosidad_colegiado
end type
type tabpage_colegial from userobject within tab_mov
end type
type dw_cuota from u_dw within tabpage_colegial
end type
type tabpage_colegial from userobject within tab_mov
dw_cuota dw_cuota
end type
type tabpage_premaat from userobject within tab_mov
end type
type dw_premaat from u_dw within tabpage_premaat
end type
type tabpage_premaat from userobject within tab_mov
dw_premaat dw_premaat
end type
type tabpage_prima from userobject within tab_mov
end type
type dw_prima_fija from u_dw within tabpage_prima
end type
type tabpage_prima from userobject within tab_mov
dw_prima_fija dw_prima_fija
end type
type tabpage_primacomp from userobject within tab_mov
end type
type dw_prima_comp from u_dw within tabpage_primacomp
end type
type tabpage_primacomp from userobject within tab_mov
dw_prima_comp dw_prima_comp
end type
type tabpage_cip from userobject within tab_mov
end type
type dw_cip from u_dw within tabpage_cip
end type
type tabpage_cip from userobject within tab_mov
dw_cip dw_cip
end type
type tabpage_cvv from userobject within tab_mov
end type
type dw_cvv from u_dw within tabpage_cvv
end type
type tabpage_cvv from userobject within tab_mov
dw_cvv dw_cvv
end type
type tabpage_otros from userobject within tab_mov
end type
type dw_otros from u_dw within tabpage_otros
end type
type tabpage_otros from userobject within tab_mov
dw_otros dw_otros
end type
type tab_mov from tab within w_morosidad_colegiado
tabpage_colegial tabpage_colegial
tabpage_premaat tabpage_premaat
tabpage_prima tabpage_prima
tabpage_primacomp tabpage_primacomp
tabpage_cip tabpage_cip
tabpage_cvv tabpage_cvv
tabpage_otros tabpage_otros
end type
type cb_imprimir from commandbutton within w_morosidad_colegiado
end type
type cb_cerrar from commandbutton within w_morosidad_colegiado
end type
type dw_1 from u_dw within w_morosidad_colegiado
end type
end forward

global type w_morosidad_colegiado from w_response
integer x = 214
integer y = 221
integer width = 3378
integer height = 2084
string title = "Consulta de Movimientos"
cb_buscar cb_buscar
tab_mov tab_mov
cb_imprimir cb_imprimir
cb_cerrar cb_cerrar
dw_1 dw_1
end type
global w_morosidad_colegiado w_morosidad_colegiado

type variables
string   is_sql_original, is_musaat_fija,is_musaat_fija1,is_musaat_fija2, is_musaat, is_cip, is_dv, is_cuota_colegial, is_colegiado
n_csd_impresion_formato i_impresion_formato
//st_colegiado_defuncion ist_datos
end variables

on w_morosidad_colegiado.create
int iCurrent
call super::create
this.cb_buscar=create cb_buscar
this.tab_mov=create tab_mov
this.cb_imprimir=create cb_imprimir
this.cb_cerrar=create cb_cerrar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_buscar
this.Control[iCurrent+2]=this.tab_mov
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_cerrar
this.Control[iCurrent+5]=this.dw_1
end on

on w_morosidad_colegiado.destroy
call super::destroy
destroy(this.cb_buscar)
destroy(this.tab_mov)
destroy(this.cb_imprimir)
destroy(this.cb_cerrar)
destroy(this.dw_1)
end on

event open;call super::open;st_datos_morosidad  ist_datos

dw_1.event pfc_addrow()


ist_datos = Message.powerobjectparm


i_impresion_formato = create n_csd_impresion_formato


////Asigna los valores de las variables globales que se llenan en f_inicializar_globales para realizar los filtros de las b$$HEX1$$fa00$$ENDHEX$$squedas
is_cuota_colegial = g_codigos_conceptos.cuota_colegial

is_musaat_fija    = g_codigos_conceptos.musaat_fija
is_musaat_fija1  = g_codigos_conceptos.musaat_fija_plazo1
is_musaat_fija2  = g_codigos_conceptos.musaat_fija_plazo2

is_musaat    = g_codigos_conceptos.musaat_variable

is_cip    = g_codigos_conceptos.cip

is_dv    = g_codigos_conceptos.dv

IF IsValid(ist_datos) = FALSE THEN return

//Muestra los datos seg$$HEX1$$fa00$$ENDHEX$$n el n$$HEX1$$fa00$$ENDHEX$$mero de colegiado recibido en la ventana
if not(f_es_vacio(ist_datos.n_colegiado)) then
	dw_1.setitem(1,"n_col", ist_datos.n_colegiado)
	dw_1.setitem(1,'nombre_col',f_nombre_colegiado(f_colegiado_id_col(ist_datos.n_colegiado)))
	dw_1.setitem(1,'apellido_col',f_colegiado_apellidos(ist_datos.n_colegiado))
	if  not(isnull(dw_1.getitemdatetime(1, 'f_desde'))) and not(isnull(dw_1.getitemdatetime(1, 'f_hasta'))) then
		tab_mov.tabpage_colegial.dw_cuota.event csd_retrieve()
		tab_mov.tabpage_premaat.dw_premaat.event csd_retrieve()
		tab_mov.tabpage_prima.dw_prima_fija.event csd_retrieve()
		tab_mov.tabpage_primacomp.dw_prima_comp.event csd_retrieve()
		tab_mov.tabpage_cip.dw_cip.event csd_retrieve()
		tab_mov.tabpage_cvv.dw_cvv.event csd_retrieve()
		tab_mov.tabpage_otros.dw_otros.event csd_retrieve()
	end if
end if





end event

event close;//
end event

event closequery;//
end event

event pfc_postopen;call super::pfc_postopen;dw_1.of_SetDropDownCalendar(True)
dw_1.iuo_calendar.of_register(dw_1.iuo_calendar.DDLB)
dw_1.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
dw_1.iuo_calendar.of_SetInitialValue(True)
dw_1.setformat('f_desde','dd/mm/yyyy')
dw_1.setformat('f_hasta','dd/mm/yyyy')



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_morosidad_colegiado
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_morosidad_colegiado
end type

type cb_buscar from commandbutton within w_morosidad_colegiado
integer x = 2894
integer y = 200
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
string text = "Buscar"
end type

event clicked;datetime  ldt_f_desde, ldt_f_hasta
date ld_f_desde, ld_f_hasta

SetPointer(HourGlass!)

dw_1.accepttext()

ldt_f_desde=dw_1.getitemdatetime(1,'f_desde')
ldt_f_hasta=dw_1.getitemdatetime(1,'f_hasta')

ld_f_desde= date(ldt_f_desde)
ld_f_hasta= date(ldt_f_hasta)

if not isnull(ld_f_desde) and not isnull(ld_f_hasta) and ld_f_hasta < ld_f_desde then
	messagebox(g_titulo, 'La fecha Hasta  no debe ser menor que la fecha Desde.')
end if 	

//is_colegiado = ""

tab_mov.tabpage_colegial.dw_cuota.event csd_retrieve()
tab_mov.tabpage_premaat.dw_premaat.event csd_retrieve()
tab_mov.tabpage_prima.dw_prima_fija.event csd_retrieve()
tab_mov.tabpage_primacomp.dw_prima_comp.event csd_retrieve()
tab_mov.tabpage_cip.dw_cip.event csd_retrieve()
tab_mov.tabpage_cvv.dw_cvv.event csd_retrieve()
tab_mov.tabpage_otros.dw_otros.event csd_retrieve()



end event

type tab_mov from tab within w_morosidad_colegiado
integer x = 14
integer y = 340
integer width = 3291
integer height = 1464
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
tabpage_colegial tabpage_colegial
tabpage_premaat tabpage_premaat
tabpage_prima tabpage_prima
tabpage_primacomp tabpage_primacomp
tabpage_cip tabpage_cip
tabpage_cvv tabpage_cvv
tabpage_otros tabpage_otros
end type

on tab_mov.create
this.tabpage_colegial=create tabpage_colegial
this.tabpage_premaat=create tabpage_premaat
this.tabpage_prima=create tabpage_prima
this.tabpage_primacomp=create tabpage_primacomp
this.tabpage_cip=create tabpage_cip
this.tabpage_cvv=create tabpage_cvv
this.tabpage_otros=create tabpage_otros
this.Control[]={this.tabpage_colegial,&
this.tabpage_premaat,&
this.tabpage_prima,&
this.tabpage_primacomp,&
this.tabpage_cip,&
this.tabpage_cvv,&
this.tabpage_otros}
end on

on tab_mov.destroy
destroy(this.tabpage_colegial)
destroy(this.tabpage_premaat)
destroy(this.tabpage_prima)
destroy(this.tabpage_primacomp)
destroy(this.tabpage_cip)
destroy(this.tabpage_cvv)
destroy(this.tabpage_otros)
end on

type tabpage_colegial from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "Cuota Colegial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cuota dw_cuota
end type

on tabpage_colegial.create
this.dw_cuota=create dw_cuota
this.Control[]={this.dw_cuota}
end on

on tabpage_colegial.destroy
destroy(this.dw_cuota)
end on

type dw_cuota from u_dw within tabpage_colegial
event csd_retrieve ( )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and ( csi_lineas_fact_emitidas.articulo in (select codigo from csi_articulos_servicios " &
			 + "where (familia='03' or familia='C')))"


this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")


end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type tabpage_premaat from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "Premaat"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_premaat dw_premaat
end type

on tabpage_premaat.create
this.dw_premaat=create dw_premaat
this.Control[]={this.dw_premaat}
end on

on tabpage_premaat.destroy
destroy(this.dw_premaat)
end on

type dw_premaat from u_dw within tabpage_premaat
event csd_retrieve ( )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and ( csi_lineas_fact_emitidas.articulo in (select codigo from csi_articulos_servicios " &
				 + "where familia='02'))"



this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")












/*
//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+=  " and  csi_facturas_emitidas.n_fact like 'PR%'" 


this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")


this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")
*/


end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)


end event

type tabpage_prima from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "Prima Fija"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prima_fija dw_prima_fija
end type

on tabpage_prima.create
this.dw_prima_fija=create dw_prima_fija
this.Control[]={this.dw_prima_fija}
end on

on tabpage_prima.destroy
destroy(this.dw_prima_fija)
end on

type dw_prima_fija from u_dw within tabpage_prima
event csd_retrieve ( )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and " +"( csi_lineas_fact_emitidas.articulo='"+is_musaat_fija+"' "
sql_nuevo+= " or csi_lineas_fact_emitidas.articulo='"+is_musaat_fija1+"' "
sql_nuevo+= " or csi_lineas_fact_emitidas.articulo='"+is_musaat_fija2+"' " + ")"


this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")


end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type tabpage_primacomp from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "Prima Complementaria"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prima_comp dw_prima_comp
end type

on tabpage_primacomp.create
this.dw_prima_comp=create dw_prima_comp
this.Control[]={this.dw_prima_comp}
end on

on tabpage_primacomp.destroy
destroy(this.dw_prima_comp)
end on

type dw_prima_comp from u_dw within tabpage_primacomp
event csd_retrieve ( )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if


//sql_nuevo+= " and csi_lineas_fact_emitidas.articulo='"+is_musaat+"' "
//sql_nuevo+= " and csi_facturas_emitidas.n_fact like 'PC%'"
//sql_nuevo+= " and csi_lineas_fact_emitidas.articulo in (select codigo from csi_articulos_servicios where familia='01') "
sql_nuevo+= " and csi_lineas_fact_emitidas.articulo = '"+is_musaat+"' "
this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type tabpage_cip from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "C.I.P."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cip dw_cip
end type

on tabpage_cip.create
this.dw_cip=create dw_cip
this.Control[]={this.dw_cip}
end on

on tabpage_cip.destroy
destroy(this.dw_cip)
end on

type dw_cip from u_dw within tabpage_cip
event csd_retrieve ( )
event csd_oculta_tab ( )
event csd_nombre_pestanya ( string nombre )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and (csi_lineas_fact_emitidas.articulo = '"+is_cip+"' "
sql_nuevo+= " or csi_lineas_fact_emitidas.articulo = '43') "
this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")


/*
//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
	
end if

//sql_nuevo+= " and csi_lineas_fact_emitidas.articulo='"+is_cip+"' "
sql_nuevo+= " and csi_facturas_emitidas.n_fact like 'CIP%' "

this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")
*/
end event

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanya(string nombre);parent.text=nombre
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Llamamos al control de eventos con el dw_principal
st_control_eventos c_evento
c_evento.evento = 'MOV_COLEGIADO_CIP'
c_evento.dw = tab_mov.tabpage_cip.dw_cip
if f_control_eventos(c_evento)=-1 then return
end event

type tabpage_cvv from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "C.C.V."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cvv dw_cvv
end type

on tabpage_cvv.create
this.dw_cvv=create dw_cvv
this.Control[]={this.dw_cvv}
end on

on tabpage_cvv.destroy
destroy(this.dw_cvv)
end on

type dw_cvv from u_dw within tabpage_cvv
event csd_retrieve ( )
event csd_oculta_tab ( )
event csd_nombre_pestanya ( string nombre )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle"
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and csi_lineas_fact_emitidas.articulo = '"+is_dv+"' "
this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")

/*
//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal, ls_msg

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')

end if

sql_nuevo+= " and csi_lineas_fact_emitidas.articulo='"+is_dv+"' "

this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")
*/
end event

event csd_oculta_tab();int opcion
opcion = Message.wordparm

if opcion=1 then parent.visible=true else parent.visible=false
end event

event csd_nombre_pestanya(string nombre);parent.text=nombre
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

// Llamamos al control de eventos con el dw_principal
st_control_eventos c_evento
c_evento.evento = 'MOV_COLEGIADO_DV'
c_evento.dw = this
if f_control_eventos(c_evento)=-1 then return

this.of_setrowselect(true)
end event

type tabpage_otros from userobject within tab_mov
integer x = 18
integer y = 100
integer width = 3255
integer height = 1348
long backcolor = 79741120
string text = "Otros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_otros dw_otros
end type

on tabpage_otros.create
this.dw_otros=create dw_otros
this.Control[]={this.dw_otros}
end on

on tabpage_otros.destroy
destroy(this.dw_otros)
end on

type dw_otros from u_dw within tabpage_otros
event csd_retrieve ( )
integer x = 23
integer y = 28
integer width = 3195
integer height = 1300
integer taborder = 11
string dataobject = "d_morosidad_detalle_otros"
boolean hscrollbar = true
end type

event csd_retrieve();//Hacemos la sql para hacer la consulta correspondiente
string sql_nuevo,sql_principal

dw_1.Accepttext()

sql_principal = this.describe("datawindow.table.select")
sql_nuevo = this.describe("datawindow.table.select")

f_sql('csi_facturas_emitidas.fecha','>=','f_desde',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.fecha','<','f_hasta',dw_1,sql_nuevo,'1','')
//f_sql('csi_cobros.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.pagado','LIKE','impagado',dw_1,sql_nuevo,'1','')
f_sql('csi_facturas_emitidas.anulada','LIKE','anulada',dw_1,sql_nuevo,'1','')

if not f_es_vacio(dw_1.getitemstring(1, 'n_col')) then
	f_sql('csi_facturas_emitidas.n_col','LIKE','n_col',dw_1,sql_nuevo,'1','')
end if

sql_nuevo+= " and ( csi_lineas_fact_emitidas.articulo not in (select codigo from csi_articulos_servicios " &
				 + "where familia='02' or familia='01' or familia='03' or familia='H' or familia='C'))"
sql_nuevo+= " and csi_lineas_fact_emitidas.articulo<>'"+is_cip+"' "
sql_nuevo+= " and csi_lineas_fact_emitidas.articulo<>'43' "   // CUOTA DE MANTENIMIENTO
sql_nuevo+= " and csi_lineas_fact_emitidas.articulo<>'"+is_dv+"' "

this.Modify("DataWindow.Table.Select= ~"" + sql_nuevo + "~"")

this.Retrieve()

this.modify("DataWindow.Table.Select= ~"" + sql_principal + "~"")
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

end event

type cb_imprimir from commandbutton within w_morosidad_colegiado
integer x = 2414
integer y = 1844
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;datastore ldst_listado
string           ls_listado
datetime     ldt_desde, ldt_hasta
string         ls_colegiado, ls_nb_colegiado

ldst_listado = create datastore
ldst_listado.dataobject = 'd_listado_morosidad_colegiado'
ldst_listado.settransobject(sqlca)

ldt_desde = dw_1.object.f_desde[1]
ldt_hasta = dw_1.object.f_hasta[1]

ls_colegiado = dw_1.object.n_col[1]
ls_nb_colegiado = dw_1.object.nombre_col[1]

choose case tab_mov.selectedtab
		case 1
			ls_listado ='Movimientos de Cuota Colegial'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_colegial.dw_cuota.RowsCopy(1, tab_mov.tabpage_colegial.dw_cuota.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 2
			ls_listado ='Movimientos de Premaat'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_premaat.dw_premaat.RowsCopy(1,tab_mov.tabpage_premaat.dw_premaat.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 3
			ls_listado ='Movimientos de Prima Fija'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_prima.dw_prima_fija.RowsCopy(1,tab_mov.tabpage_prima.dw_prima_fija.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 4
			ls_listado ='Movimientos de Prima Complementaria'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_primacomp.dw_prima_comp.RowsCopy(1, tab_mov.tabpage_primacomp.dw_prima_comp.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 5
			ls_listado ='Movimientos de C.I.P.'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_cip.dw_cip.RowsCopy(1,tab_mov.tabpage_cip.dw_cip.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 6
			ls_listado ='Movimientos de C.V.V.'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_cvv.dw_cvv.RowsCopy(1, tab_mov.tabpage_cvv.dw_cvv.RowCount(), Primary!, ldst_listado, 1, Primary!)
			
		case 7
			ls_listado ='Movimientos de Otros'
			ldst_listado.object.st_titulo_listado.text = ls_listado
			tab_mov.tabpage_otros.dw_otros.RowsCopy(1, tab_mov.tabpage_otros.dw_otros.RowCount(), Primary!, ldst_listado, 1, Primary!)
		
end choose

ldst_listado.object.t_fecha.text = 'Desde: ' + string(date(ldt_desde)) + ' ' + 'Hasta: ' + string(date(ldt_hasta))
ldst_listado.object.t_col.text = ls_colegiado + ' ' + ls_nb_colegiado

//if tab_mov.tabpage_colegial.dw_cuota.RowCount() = 0 then return

//Datos de copias en papel
i_impresion_formato.papel = g_formato_impresion.papel
i_impresion_formato.copias 					= 1
i_impresion_formato.impresora_pag_desde 	= 1
i_impresion_formato.impresora_intervalo 	= 'T'
i_impresion_formato.impresora_intercalar 	= false
i_impresion_formato.email ='X'
i_impresion_formato.pdf = 'X'

i_impresion_formato.dw = ldst_listado
//i_impresion_formato.nombre = ls_listado

if i_impresion_formato.f_opciones_impresion()>0 then
	i_impresion_formato.f_impresion()
end if

destroy ldst_listado
end event

type cb_cerrar from commandbutton within w_morosidad_colegiado
integer x = 2898
integer y = 1844
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_morosidad_colegiado
integer x = 18
integer width = 3264
integer height = 328
integer taborder = 70
string dataobject = "d_consulta_morosidad"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case "n_col"
		this.setitem(1,'nombre_col',f_nombre_colegiado(f_colegiado_id_col(data)))
		this.setitem(1,'apellido_col',f_colegiado_apellidos(data))
END CHOOSE
end event

event itemerror;call super::itemerror;return 3
end event

event buttonclicked;call super::buttonclicked;string ls_colegiado


choose case dwo.name

	
	case "b_busqueda_colegiado"
		//Buscamos los colegiados
			g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de Colegiados"
			g_busqueda.dw="d_lista_busqueda_colegiados"
			ls_colegiado=f_busqueda_colegiados()   
			if NOT f_es_vacio(ls_colegiado)  then
				this.setitem(1,'n_col',f_colegiado_n_col(ls_colegiado))
				this.setitem(1,'nombre_col',f_colegiado_nombre(ls_colegiado))
				this.setitem(1,'apellido_col',f_colegiado_apellidos(ls_colegiado))
			end if

END CHOOSE
end event

