HA$PBExportHeader$w_eimporta_busqueda_poblacion.srw
forward
global type w_eimporta_busqueda_poblacion from w_response
end type
type dw_consulta from u_dw within w_eimporta_busqueda_poblacion
end type
type dw_lista from u_dw within w_eimporta_busqueda_poblacion
end type
type cb_aceptar from u_cb within w_eimporta_busqueda_poblacion
end type
type cb_cancelar from u_cb within w_eimporta_busqueda_poblacion
end type
end forward

global type w_eimporta_busqueda_poblacion from w_response
integer width = 2811
integer height = 1580
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda de Poblaciones"
event csd_modificar_poblacion_ini ( long cliente )
dw_consulta dw_consulta
dw_lista dw_lista
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_eimporta_busqueda_poblacion w_eimporta_busqueda_poblacion

type variables
string i_fichero_ini,i_fichero_zip
st_visared_poblacion datos_consulta
end variables

event csd_modificar_poblacion_ini(long cliente);n_oo_captura_errores zip
int retorno,existe
oleobject oFile,Files

zip = create n_oo_captura_errores

// Cambiamos el ini que hay en el directorio temporal...
if cliente<1 then
	SetProfileString(datos_consulta.fichero_ini,"CONTRATO","cod_pos",dw_lista.GetItemSTring(dw_lista.GetRow(),'cod_pos'))
	SetProfileString(datos_consulta.fichero_ini,"CONTRATO","desc_poblacion",dw_lista.GetItemSTring(dw_lista.GetRow(),'descripcion'))	
else
	SetProfileString(datos_consulta.fichero_ini,"CLIENTES","cod_pos_"+string(cliente),dw_lista.GetItemSTring(dw_lista.GetRow(),'cod_pos'))	
	SetProfileString(datos_consulta.fichero_ini,"CLIENTES","poblacion_"+string(cliente),dw_lista.GetItemSTring(dw_lista.GetRow(),'descripcion'))		
end if
// y lo comprimimos
retorno = zip.ConnectToNewObject("SAWZip.Archive")
if retorno < 0 then
	Messagebox(g_titulo, "No se puede acceder a la librer$$HEX1$$ed00$$ENDHEX$$a de manipulaci$$HEX1$$f300$$ENDHEX$$n de zips (SAWZip). Deber$$HEX2$$e1002000$$ENDHEX$$reinstalar la aplicaci$$HEX1$$f300$$ENDHEX$$n.")
	return
end if	

zip.of_capturar_errores(true) // Evita que la aplicaci$$HEX1$$f300$$ENDHEX$$n pete si el zip est$$HEX2$$e1002000$$ENDHEX$$corrupto
f_bloqueo_fichero(datos_consulta.fichero_zip,false)
zip.Open(datos_consulta.fichero_zip) 
if zip.i_resultcode <> 0 then
	MessageBox(g_titulo,"Error al abrir el zip. Es posible que el archivo est$$HEX2$$e9002000$$ENDHEX$$da$$HEX1$$f100$$ENDHEX$$ado.")
	return
end if
zip.of_capturar_errores(false)	

//A$$HEX1$$f100$$ENDHEX$$adimos el fichero
Files = create oleobject
Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

oFile = create oleobject
oFile.ConnectToNewObject("SAWZip.File")	
oFile.Name = datos_consulta.fichero_ini
Files.Add(oFile)
zip.close()

destroy zip


end event

on w_eimporta_busqueda_poblacion.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.dw_lista=create dw_lista
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_eimporta_busqueda_poblacion.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.dw_lista)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event open;call super::open;
dw_consulta.insertrow(0)


datos_consulta=Message.PowerObjectParm

dw_consulta.SetItem(1,'cod_pos',datos_consulta.cod_pos)


if not(f_es_vacio(datos_consulta.cod_pos)) then
	dw_consulta.event buttonclicked(1,1,dw_consulta.object.b_buscar)
end if

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_eimporta_busqueda_poblacion
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_eimporta_busqueda_poblacion
end type

type dw_consulta from u_dw within w_eimporta_busqueda_poblacion
integer x = 27
integer y = 44
integer width = 2752
integer height = 420
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_eimporta_busqueda_pob"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string sql_old = '', sql_nuevo = '', activa

this.accepttext()

sql_old = dw_lista.describe("datawindow.table.select")
sql_nuevo = sql_old

f_sql('cod_pos','LIKE','cod_pos',dw_consulta,sql_nuevo,g_tipo_base_datos,'')
f_sql('descripcion','LIKE','descripcion',dw_consulta,sql_nuevo,g_tipo_base_datos,'')

dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")

dw_lista.Retrieve()

// Restauramos la sql original
dw_lista.modify("datawindow.table.select= ~"" + sql_old + "~"")

end event

type dw_lista from u_dw within w_eimporta_busqueda_poblacion
integer x = 23
integer y = 496
integer width = 2747
integer height = 796
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_eimporta_lista_pob"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)
this.of_SetProperty(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (false)

// Extended filter style
//inv_filter.of_SetStyle (1)

// Set to simple sort style
inv_sort.of_SetStyle (2)
inv_sort.of_SetVisibleOnly(FALSE)

// Enable printpreview service
of_SetPrintPreview (true)



end event

event retrieveend;call super::retrieveend;if rowcount>0 then 
	cb_aceptar.enabled=true
else
	cb_aceptar.enabled=false
end if
end event

event doubleclicked;call super::doubleclicked;cb_aceptar.event clicked()
end event

type cb_aceptar from u_cb within w_eimporta_busqueda_poblacion
integer x = 914
integer y = 1336
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string text = "&Aceptar"
boolean default = true
end type

event clicked;call super::clicked;string cod_pob

st_visared_poblacion campos_subsanados

campos_subsanados.cod_pob='-1'

if dw_lista.GetRow()>0 then
	cod_pob=dw_lista.GetItemString(dw_lista.GetRow(),'cod_pob')
	campos_subsanados.cod_pos=dw_lista.GetItemString(dw_lista.GetRow(),'cod_pos')
	campos_subsanados.cod_pob=dw_lista.GetItemString(dw_lista.GetRow(),'cod_pob')	
	campos_subsanados.descripcion=dw_lista.GetItemString(dw_lista.GetRow(),'descripcion')			
	campos_subsanados.provincia=dw_lista.GetItemString(dw_lista.GetRow(),'provincia')	

	closewithreturn(parent,campos_subsanados)
end if

end event

type cb_cancelar from u_cb within w_eimporta_busqueda_poblacion
integer x = 1413
integer y = 1336
integer taborder = 21
boolean bringtotop = true
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;
close(parent)

end event

