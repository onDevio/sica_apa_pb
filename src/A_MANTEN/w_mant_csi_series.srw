HA$PBExportHeader$w_mant_csi_series.srw
forward
global type w_mant_csi_series from w_mant_simple
end type
type dw_busqueda from u_dw within w_mant_csi_series
end type
type cb_1 from commandbutton within w_mant_csi_series
end type
end forward

global type w_mant_csi_series from w_mant_simple
integer width = 3520
integer height = 1740
string title = "Mantenimiento de Series de Facturas"
dw_busqueda dw_busqueda
cb_1 cb_1
end type
global w_mant_csi_series w_mant_csi_series

type variables
string i_accion = 'CONSULTA'
end variables

on w_mant_csi_series.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.cb_1
end on

on w_mant_csi_series.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.cb_1)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje
int fila, res, retorno=1
double cont
dw_1.accepttext()

mensaje += f_valida(dw_1,'serie','NOVACIO','Debe especificar un valor en el campo Serie.')
mensaje += f_valida(dw_1,'anyo','NOVACIO','Debe especificar un valor en el campo A$$HEX1$$f100$$ENDHEX$$o.')
mensaje += f_valida(dw_1,'empresa','NOVACIO','Debe especificar un valor en el campo Empresa.')
if mensaje <> '' then mensaje += cr
for fila=1 to dw_1.rowcount()
	cont = dw_1.getitemnumber(fila, 'contador')
	if f_es_vacio(string(cont)) then mensaje += 'Debe especificar un valor en el campo Contador.' + ' (fila '+string(fila)+')' +cr
next


//// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
//// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
//For fila = 1 to dw_1.RowCount() 
//	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
//			res = f_busca_duplicados_colum_dw (dw_1, 'serie', fila)
//			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
//	END IF
//next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event open;call super::open;dw_busqueda.insertrow(0)
dw_busqueda.setitem(1, 'anyo', string(year(today())))
dw_busqueda.setitem(1, 'empresa', g_empresa)

cb_1.event clicked()

end event

event pfc_postopen();// Sobreescrito para que no haga el retrieve
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_csi_series
integer taborder = 20
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_csi_series
integer taborder = 30
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_csi_series
integer x = 37
integer y = 228
integer width = 3401
integer taborder = 80
string dataobject = "d_mant_csi_series"
end type

event type long dw_1::pfc_addrow();call super::pfc_addrow;this.setitem(ancestorreturnvalue, 'anyo', string(year(today())))
this.setitem(ancestorreturnvalue, 'empresa', g_empresa)
return ancestorreturnvalue
end event

event type long dw_1::pfc_insertrow();call super::pfc_insertrow;this.setitem(ancestorreturnvalue, 'anyo', string(year(today())))
this.setitem(ancestorreturnvalue, 'empresa', g_empresa)
return ancestorreturnvalue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_csi_series
integer x = 37
integer y = 1408
integer taborder = 56
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_csi_series
integer x = 329
integer y = 1408
integer taborder = 60
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_csi_series
boolean visible = false
integer y = 1408
integer taborder = 10
end type

type dw_busqueda from u_dw within w_mant_csi_series
integer x = 37
integer y = 64
integer width = 2615
integer height = 104
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_mant_csi_series_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type cb_1 from commandbutton within w_mant_csi_series
integer x = 2775
integer y = 72
integer width = 343
integer height = 92
integer taborder = 55
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar"
end type

event clicked;string sql_old = '', sql_nuevo = '', activa

dw_busqueda.accepttext()

sql_old = dw_1.describe("datawindow.table.select")
sql_nuevo = sql_old

f_sql('anyo','LIKE','anyo',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
f_sql('empresa','LIKE','empresa',dw_busqueda,sql_nuevo,g_tipo_base_datos,'')
//f_sql('tipo_persona','LIKE','tipo_persona',Parent.dw_3,sql_nuevo,'1','')

dw_1.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

//dw_busqueda.setitem(1,1,'')
//dw_busqueda.setitem(1,2,'')

dw_1.Retrieve()//'%')

// Restauramos la sql original
dw_1.modify("datawindow.table.select= ~"" + sql_old + "~"")

end event

