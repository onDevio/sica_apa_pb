HA$PBExportHeader$w_vaciar_expediente_basura.srw
forward
global type w_vaciar_expediente_basura from w_response
end type
type cb_1 from commandbutton within w_vaciar_expediente_basura
end type
type dw_exped from u_dw within w_vaciar_expediente_basura
end type
type st_1 from statictext within w_vaciar_expediente_basura
end type
type cb_3 from commandbutton within w_vaciar_expediente_basura
end type
end forward

global type w_vaciar_expediente_basura from w_response
integer width = 3534
integer height = 1464
string title = "Vaciar Papelera"
boolean controlmenu = false
event csd_regularizar ( )
event csd_borrar_clientes ( )
event csd_borrar_colegiados ( )
event csd_borrar_reparos ( )
event csd_borrar_documentos ( )
event csd_borrar_estados ( )
event csd_borrar_finales_obra ( )
event csd_borrar_arquitectos ( )
event csd_borrar_garantias ( )
event csd_borrar_informes ( )
event csd_borrar_documentos_visared ( )
event csd_borrar_colegiados_asociados ( )
event csd_borrar_minutas ( )
event csd_borrar_liquidaciones ( )
cb_1 cb_1
dw_exped dw_exped
st_1 st_1
cb_3 cb_3
end type
global w_vaciar_expediente_basura w_vaciar_expediente_basura

type variables
string i_id_fase, i_mensaje=''

end variables

event csd_borrar_clientes;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_promotores'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de clientes" + cr

destroy ds_borra

end event

event csd_borrar_colegiados;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_colegiados'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de colegiados" + cr

destroy ds_borra

end event

event csd_borrar_reparos;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_reparos_impresion'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de reparos" + cr

destroy ds_borra

end event

event csd_borrar_documentos;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_documentos'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de documentos" + cr

destroy ds_borra

end event

event csd_borrar_estados;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_estados'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de estados" + cr

destroy ds_borra

end event

event csd_borrar_finales_obra;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_finales_obra'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de finales de obra" + cr

destroy ds_borra

end event

event csd_borrar_arquitectos;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_arquitectos'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de arquitectos" + cr

destroy ds_borra

end event

event csd_borrar_garantias;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_garantias'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de garantias" + cr

destroy ds_borra

end event

event csd_borrar_informes;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_informes'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de descuentos" + cr

destroy ds_borra

end event

event csd_borrar_documentos_visared;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_documentos_visared'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de documentos de visared" + cr

destroy ds_borra

end event

event csd_borrar_colegiados_asociados;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'ds_fases_colegiados_asoc_para_vaciar'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de colegiados" + cr

destroy ds_borra

end event

event csd_borrar_minutas;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'd_fases_minutas'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de minutas" + cr

destroy ds_borra

end event

event csd_borrar_liquidaciones;datastore ds_borra
ds_borra = create datastore
ds_borra.dataobject = 'ds_fases_liquidaciones'
ds_borra.settransobject(sqlca)
ds_borra.Retrieve(i_id_fase)

int i

for i=ds_borra.rowcount() to 1 step -1
	ds_borra.deleterow(i)
next

i = ds_borra.update()
if i <> 1 then i_mensaje += "Error en el borrado de liquidaciones" + cr

destroy ds_borra

end event

on w_vaciar_expediente_basura.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_exped=create dw_exped
this.st_1=create st_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_exped
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_3
end on

on w_vaciar_expediente_basura.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_exped)
destroy(this.st_1)
destroy(this.cb_3)
end on

event open;call super::open;f_centrar_ventana(this)

dw_exped.retrieve()
//int i
//for i=1 to dw_exped.rowcount()
//	dw_exped.selectrow(i, true)
//next

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_vaciar_expediente_basura
integer x = 2533
integer y = 1796
integer width = 46
integer taborder = 0
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_vaciar_expediente_basura
integer x = 2464
integer y = 1792
integer width = 46
integer taborder = 0
end type

type cb_1 from commandbutton within w_vaciar_expediente_basura
integer x = 1152
integer y = 1184
integer width = 402
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
end type

event clicked;long i, cuantos=0

for i=1 to dw_exped.rowcount()
	if dw_exped.isselected(i) then cuantos += 1
next

if cuantos > 0 then
	if messagebox(g_titulo, "Este proceso borrar$$HEX2$$e1002000$$ENDHEX$$los contratos seleccionados" + cr + &
		+	"y todos los datos asociados a estos, $$HEX1$$bf00$$ENDHEX$$est$$HEX2$$e1002000$$ENDHEX$$seguro?", exclamation!, yesno!) <> 1 then return
else
	messagebox(g_titulo, "No ha seleccionado ning$$HEX1$$fa00$$ENDHEX$$n contrato")
	return
end if


// *** Borrado ***
for i=dw_exped.rowcount() to 1 step -1
	if dw_exped.isselected(i) then 
		i_id_fase = dw_exped.getitemstring(i, 'id_fase')
		
		event csd_borrar_arquitectos()
		event csd_borrar_clientes()
		event csd_borrar_colegiados()
		event csd_borrar_colegiados_asociados()
		event csd_borrar_documentos()
		event csd_borrar_documentos_visared()
		event csd_borrar_estados()
		event csd_borrar_finales_obra()
		event csd_borrar_garantias()
		event csd_borrar_informes()
		event csd_borrar_liquidaciones()
		event csd_borrar_minutas()
		event csd_borrar_reparos()
		dw_exped.deleterow(i)
	end if
next

i = dw_exped.update()
if i <> 1 then i_mensaje += "Error en el borrado del contrato" + cr


if i_mensaje <> '' then 
	messagebox(g_titulo, i_mensaje, stopsign!)
else
	messagebox(g_titulo, "Proceso finalizado")
end if

close(parent)
end event

type dw_exped from u_dw within w_vaciar_expediente_basura
integer x = 37
integer y = 112
integer width = 3438
integer height = 980
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_fases_lista_expediente_basura"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;// Sobreescrito
end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
inv_rowselect.of_setstyle(inv_rowselect.multiple)



end event

type st_1 from statictext within w_vaciar_expediente_basura
integer x = 37
integer y = 32
integer width = 709
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
string text = "Seleccione el/los contrato/s :"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_vaciar_expediente_basura
integer x = 1952
integer y = 1184
integer width = 402
integer height = 112
integer taborder = 120
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

event clicked;close(parent)

end event

