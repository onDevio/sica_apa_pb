HA$PBExportHeader$w_arte_cemento.srw
forward
global type w_arte_cemento from w_sheet
end type
type cb_3 from commandbutton within w_arte_cemento
end type
type cb_2 from commandbutton within w_arte_cemento
end type
type cb_1 from commandbutton within w_arte_cemento
end type
type dw_historico from u_dw within w_arte_cemento
end type
type dw_lista from u_dw within w_arte_cemento
end type
type dw_consulta from u_dw within w_arte_cemento
end type
end forward

global type w_arte_cemento from w_sheet
integer width = 3730
integer height = 1704
windowstate windowstate = maximized!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_historico dw_historico
dw_lista dw_lista
dw_consulta dw_consulta
end type
global w_arte_cemento w_arte_cemento

type variables
string isql_original
end variables

on w_arte_cemento.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_historico=create dw_historico
this.dw_lista=create dw_lista
this.dw_consulta=create dw_consulta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_historico
this.Control[iCurrent+5]=this.dw_lista
this.Control[iCurrent+6]=this.dw_consulta
end on

on w_arte_cemento.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_historico)
destroy(this.dw_lista)
destroy(this.dw_consulta)
end on

event open;call super::open;dw_consulta.insertrow(0)

this.of_setresize(true)

inv_resize.of_Register (cb_1, "FixedToBottom")
inv_resize.of_Register (cb_2, "FixedToRight&Bottom")
inv_resize.of_Register (cb_3, "FixedToBottom")

inv_resize.of_Register (dw_consulta, "ScaleToRight")
inv_resize.of_Register (dw_lista, "ScaleToRight&Bottom")
inv_resize.of_Register (dw_historico, "FixedToRight&ScaletoBottom")

isql_original = dw_lista.describe("datawindow.table.select")	

dw_historico.retrieve()
end event

type cb_3 from commandbutton within w_arte_cemento
integer x = 462
integer y = 1444
integer width = 416
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Actualizar datos"
end type

event clicked;parent.event pfc_save()
end event

type cb_2 from commandbutton within w_arte_cemento
integer x = 3269
integer y = 1444
integer width = 402
integer height = 112
integer taborder = 20
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

type cb_1 from commandbutton within w_arte_cemento
integer x = 50
integer y = 1444
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Imprimir listado"
end type

event clicked;double i, fila

If dw_lista.rowcount() <= 0 then
	messagebox(g_titulo, 'No ha seleccionado ninguna obra')
	return
end if

datastore ds_listado
ds_listado = create datastore
ds_listado.dataobject = 'd_arte_cemento_listado'

 for i = 1 to dw_lista.rowcount()

	fila = ds_listado.insertrow(0)
    ds_listado.setitem(fila,'fecha_visado',dw_lista.getitemdatetime(i,'fases_f_visado'))
    ds_listado.setitem(fila,'tipo_actuacion',f_dame_desc_tipo_actuacion(dw_lista.getitemstring(i,'fases_fase')))
    ds_listado.setitem(fila,'tipo_obra',f_dame_desc_tipo_obra(dw_lista.getitemstring(i,'fases_tipo_trabajo')))
    ds_listado.setitem(fila,'tipo_uso',f_dame_desc_destino_obra(dw_lista.getitemstring(i,'fases_trabajo')))
    ds_listado.setitem(fila,'calle',dw_lista.getitemstring(i,'fases_emplazamiento'))
    ds_listado.setitem(fila,'numero',dw_lista.getitemstring(i,'fases_n_calle'))
    ds_listado.setitem(fila,'poblacion',dw_lista.getitemstring(i,'poblaciones_descripcion'))
    ds_listado.setitem(fila,'cliente_nombre',dw_lista.getitemstring(i,'clientes_nombre'))
    ds_listado.setitem(fila,'cliente_apellidos',dw_lista.getitemstring(i,'clientes_apellidos'))
    ds_listado.setitem(fila,'presupuesto',dw_lista.getitemnumber(i,'fases_usos_pem'))
    ds_listado.setitem(fila,'num',dw_lista.getitemnumber(i,'fases_usos_num_viv'))
    ds_listado.setitem(fila,'expediente',dw_lista.getitemstring(i,'fases_n_expedi'))
next

ds_listado.print()
//MODIFICADO RICARDO 04-03-02
if messageBox(g_titulo, "$$HEX1$$bf00$$ENDHEX$$Desea guardar el listado impreso en fichero?", question!, yesno!, 2)=1 then
	// Permitimos que el listado pueda ser guardado en fichero
	n_cst_filesrvwin32 cambia_directorio
	string directorio, nombrefichero
	cambia_directorio = create n_cst_filesrvwin32
	directorio = cambia_directorio.of_getcurrentdirectory()
	if GetFileSaveName('Seleccione nombre de fichero',NombreFichero,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then 
		// MODIFICADO RICARDO 04-03-02
		// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
		cambia_directorio.of_changedirectory(directorio)
		destroy cambia_directorio
		// FIN MODIFICADO RICARDO 04-03-02
		return
	end if	
	ds_listado.saveasascii(nombrefichero)
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
end if
//FIN MODIFICADO RICARDO 04-03-02
destroy ds_listado

// Insertar un registro en la tabla de envios (arte_cemento) como hist$$HEX1$$f300$$ENDHEX$$rico


datetime fecha_envio
double num_envio, fila_exp_max
string n_exp

fila_exp_max = dw_lista.rowcount()
fecha_envio = datetime(today(),now())
select max(codigo) into :num_envio from arte_cemento;
// Modificado Ricardo 04-03-02
if isnull(num_envio) then num_envio = 0
// FIN Modificado Ricardo 04-03-02
num_envio = num_envio + 1
n_exp = dw_lista.getitemstring(fila_exp_max,'fases_n_expedi')


dw_historico.insertrow(1)

dw_historico.setitem(1, 'codigo', num_envio)
dw_historico.setitem(1, 'fecha', fecha_envio)
dw_historico.setitem(1, 'obra', n_exp)
dw_historico.setitem(1, 'f_entrada_desde', dw_consulta.getitemdatetime(1,'f_entrada_desde'))
dw_historico.setitem(1, 'f_entrada_hasta', dw_consulta.getitemdatetime(1,'f_entrada_hasta'))
dw_historico.setitem(1, 'pem_desde', dw_consulta.getitemnumber(1,'pem_desde'))
dw_historico.setitem(1, 'pem_hasta', dw_consulta.getitemnumber(1,'pem_hasta'))
	  



end event

type dw_historico from u_dw within w_arte_cemento
integer x = 2368
integer y = 36
integer width = 1307
integer height = 1376
integer taborder = 10
boolean titlebar = true
string title = "Env$$HEX1$$ed00$$ENDHEX$$os anteriores"
string dataobject = "d_arte_cemento_envios"
boolean hscrollbar = true
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;// Modificado Ricardo 04-03-02
am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
// FIN Modificado Ricardo 04-03-02

end event

type dw_lista from u_dw within w_arte_cemento
integer x = 32
integer y = 376
integer width = 2327
integer height = 1032
integer taborder = 10
boolean titlebar = true
string title = "Borre con bot$$HEX1$$f300$$ENDHEX$$n derecho las obras que no desee que aparezcan el el listado"
string dataobject = "d_arte_cemento_lista"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetRowManager(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
inv_sort.of_SetStyle (2)

end event

type dw_consulta from u_dw within w_arte_cemento
integer x = 27
integer y = 40
integer width = 2327
integer height = 332
integer taborder = 10
string dataobject = "d_arte_cemento_consulta"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;string sql_nuevo
choose case dwo.name
	case 'b_1'

		SetPointer(HourGlass!)
		dw_consulta.AcceptText()
		sql_nuevo = dw_lista.describe("datawindow.table.select")		
				
		f_sql('fases.f_entrada','>=','f_entrada_desde',dw_consulta,sql_nuevo,'1','')
		f_sql('fases.f_entrada','<','f_entrada_hasta',dw_consulta,sql_nuevo,'1','')
		f_sql('fases_usos.pem','>=','pem_desde',dw_consulta,sql_nuevo,'1','')
		f_sql('fases_usos.pem','<','pem_hasta',dw_consulta,sql_nuevo,'1','')
		
		dw_lista.modify("datawindow.table.select= ~"" + sql_nuevo + "~"")
		
		dw_lista.retrieve()
		
		dw_lista.modify("datawindow.table.select= ~"" + isql_original + "~"")
end choose
end event

event constructor;call super::constructor;// MODIFICADO RICARDO 04-03-02
this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
// FIN MODIFICADO RICARDO 04-03-02

end event

