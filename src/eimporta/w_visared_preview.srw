HA$PBExportHeader$w_visared_preview.srw
forward
global type w_visared_preview from w_response
end type
type dw_aux from u_dw within w_visared_preview
end type
type cb_1 from commandbutton within w_visared_preview
end type
type cb_2 from commandbutton within w_visared_preview
end type
type dw_preview from u_dw within w_visared_preview
end type
end forward

global type w_visared_preview from w_response
integer width = 3186
integer height = 1896
dw_aux dw_aux
cb_1 cb_1
cb_2 cb_2
dw_preview dw_preview
end type
global w_visared_preview w_visared_preview

forward prototypes
public subroutine f_traspasa_datastore (datastore ds)
end prototypes

public subroutine f_traspasa_datastore (datastore ds);dw_aux.dataobject = ds.dataobject
dw_aux.SetTransObject(SQLCA)

ds.RowsCopy(ds.GetRow(),ds.RowCount(), Primary!,dw_aux, 1, Primary!)


end subroutine

on w_visared_preview.create
int iCurrent
call super::create
this.dw_aux=create dw_aux
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_preview=create dw_preview
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_aux
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_preview
end on

on w_visared_preview.destroy
call super::destroy
destroy(this.dw_aux)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_preview)
end on

event open;////definimos las variables que necesitamos para hacer la recuperacion de los datos
////variable donde guardaremos la estructura de datos que tenemos los datastores
st_visared_importacion datos


int cogida
long cargar

cogida=0
cargar=0
//crearemos datawindowschild para guardar cada uno de los datastores asociados en la estructura
DataWindowChild dddc_fase,dddc_colegiados,dddc_estadistica,dddc_asociados
DataWindowChild dddc_arquitectos,dddc_honorarios,dddc_estadisticas,dddc_promotores


//recuperaremos los datos que se encuentran en el message del powerobjectparam por ser del tipo datastore
// es igual que cuando lo hacemos con cualquier string (stringparam....)
datos = message.powerobjectparm

dw_preview.SetTransObject(SQLCA)
dw_preview.InsertRow(0)
//datos.ds_colegiados.SetTransObject(SQLCA)


//Ponemos los datos dentro de cada datastor cown la funcion GetChild
//dw_preview.GetChild('d_fases_detalle_impresion',dddc_fase)
//dw_preview.GetChild('d_fases_colegiados_impresion',dddc_colegiados)
cogida=dw_preview.GetChild('dw_colegiados',dddc_colegiados)
//
datos.ds_colegiados.Rowscopy(1,datos.ds_colegiados.rowcount(),Primary!,dw_aux,1,Primary!)
//dw_preview.Object.dw_colegiados.InsertRow(0)

//dw_preview.Object.dw_colegiados.InsertRow(0)
dw_preview.Object.dw_colegiados.Object.Data = dw_aux.Object.Object.Data

//cogida=dw_preview.GetChild('dw_colegiados',dddc_colegiados)

//dddc_colegiados.SetTransObject(SQLCA)
//dddc_colegiados.insertrow(0)

//dw_preview.GetChild('d_fases_colegiados_asociados_impresion',dddc_asociados)
//dw_preview.GetChild('d_fases_promotores_impresion',dddc_promotores)
//dw_preview.GetChild('d_fases_arquitectos_impresion',dddc_arquitectos)
//dw_preview.GetChild('d_fases_honorarios_ext_impresion',dddc_honorarios)
//dw_preview.GetChild('d_fases_expedientes_estadisticas_impresion',dddc_estadisticas)
//
//Recuperamos todas las filas mediante una sola funcion, RowsCopy
//datos.ds_detalle_fase.RowsCopy(1,datos.ds_detalle_fase.Rowcount(),Primary!,dddc_fase,1,Primary!)
//cargar=datos.ds_colegiados.RowsCopy(1,datos.ds_colegiados.Rowcount(),Primary!,dddc_colegiados,1,Primary!)
//datos.ds_asociados.RowsCopy(1,datos.ds_asociados.Rowcount(),Primary!,dddc_asociados,1,Primary!)
//datos.ds_clientes.RowsCopy(1,datos.ds_clientes.Rowcount(),Primary!,dddc_promotores,1,Primary!)
//datos.ds_arquitectos.RowsCopy(1,datos.ds_arquitectos.Rowcount(),Primary!,dddc_honorarios,1,Primary!)
//datos.ds_estadisticas.RowsCopy(1,datos.ds_estadisticas.Rowcount(),Primary!,dddc_estadisticas,1,Primary!)


dw_preview.InsertRow(0)




end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_visared_preview
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_visared_preview
end type

type dw_aux from u_dw within w_visared_preview
boolean visible = false
integer x = 2194
integer y = 1192
integer taborder = 20
end type

type cb_1 from commandbutton within w_visared_preview
integer x = 1335
integer y = 1696
integer width = 343
integer height = 92
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

event clicked;dw_preview.print()
end event

type cb_2 from commandbutton within w_visared_preview
integer x = 2816
integer y = 1688
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
string text = "&Cerrar"
end type

event clicked;close(parent)
end event

type dw_preview from u_dw within w_visared_preview
integer x = 14
integer y = 16
integer width = 3150
integer height = 1648
integer taborder = 10
string dataobject = "d_visared_preview"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

