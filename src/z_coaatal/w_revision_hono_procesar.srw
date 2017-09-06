HA$PBExportHeader$w_revision_hono_procesar.srw
forward
global type w_revision_hono_procesar from w_response
end type
type dw_consulta from u_dw within w_revision_hono_procesar
end type
type dw_lista from u_dw within w_revision_hono_procesar
end type
type cb_procesar from commandbutton within w_revision_hono_procesar
end type
type st_1 from statictext within w_revision_hono_procesar
end type
type st_mensaje from statictext within w_revision_hono_procesar
end type
type cb_actualizar from commandbutton within w_revision_hono_procesar
end type
type cb_cerrar from commandbutton within w_revision_hono_procesar
end type
end forward

global type w_revision_hono_procesar from w_response
integer x = 214
integer y = 221
integer height = 1692
string title = "Actualizar Honorarios con el IPC"
dw_consulta dw_consulta
dw_lista dw_lista
cb_procesar cb_procesar
st_1 st_1
st_mensaje st_mensaje
cb_actualizar cb_actualizar
cb_cerrar cb_cerrar
end type
global w_revision_hono_procesar w_revision_hono_procesar

type variables
string i_sql_nuevo,i_sql_viejo
boolean ib_marcada
end variables

event open;call super::open;
dw_consulta.InsertRow(0)
end event

on w_revision_hono_procesar.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.dw_lista=create dw_lista
this.cb_procesar=create cb_procesar
this.st_1=create st_1
this.st_mensaje=create st_mensaje
this.cb_actualizar=create cb_actualizar
this.cb_cerrar=create cb_cerrar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.dw_lista
this.Control[iCurrent+3]=this.cb_procesar
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_mensaje
this.Control[iCurrent+6]=this.cb_actualizar
this.Control[iCurrent+7]=this.cb_cerrar
end on

on w_revision_hono_procesar.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.dw_lista)
destroy(this.cb_procesar)
destroy(this.st_1)
destroy(this.st_mensaje)
destroy(this.cb_actualizar)
destroy(this.cb_cerrar)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_revision_hono_procesar
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_revision_hono_procesar
end type

type dw_consulta from u_dw within w_revision_hono_procesar
integer x = 55
integer y = 140
integer width = 2359
integer height = 148
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_revision_hono_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

event buttonclicked;call super::buttonclicked;
choose case dwo.name
		
	case 'b_buscar'
		
		i_sql_viejo = dw_lista.describe("datawindow.table.select")	
		i_sql_nuevo = i_sql_viejo
		
		f_sql('fases.f_entrada','>=','f_desde',dw_consulta,i_sql_nuevo,'1','')
		f_sql('fases.f_entrada','<','f_hasta',dw_consulta,i_sql_nuevo,'1','')
		
		dw_lista.modify("datawindow.table.select= ~"" + i_sql_nuevo + "~"")
		dw_lista.retrieve()
		dw_lista.modify("datawindow.table.select= ~"" + i_sql_viejo + "~"")
		
end choose
end event

type dw_lista from u_dw within w_revision_hono_procesar
integer x = 55
integer y = 408
integer width = 2359
integer height = 992
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_revision_hono_lista"
end type

event clicked;call super::clicked;long i
if dwo.name = 't_marcado' then
	if dw_lista.Rowcount() > 0 then 
		
		if ib_marcada = true then
			for i = 1 to dw_lista.RowCount()
				dw_lista.SetItem(i,'marcado','N')
				ib_marcada = false
			next
			
		else
			for i = 1 to dw_lista.RowCount()
				dw_lista.SetItem(i,'marcado','S')
				ib_marcada = true
			next
			
		end if
		
	end if
end if
end event

type cb_procesar from commandbutton within w_revision_hono_procesar
integer x = 69
integer y = 1432
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Procesar"
end type

event clicked;double ipc,honorarios,rev_honorarios,revisio
string ejercicio_ant
long i,filas

//El Ejercicio del IPC se tomara el del a$$HEX1$$f100$$ENDHEX$$o anteior. ej: Enero 2008 --> ipc: 2007
ejercicio_ant = string(integer(g_ejercicio) - 1)
ipc = f_rev_honos_ipc(ejercicio_ant)/100

//Para cada obra seleccionada sin liquidar
SetPointer(Hourglass!)
filas = dw_lista.RowCount()
for i=1 to filas
	//Si no esta seleccionado pasamos al siguiente..
	if dw_lista.GetItemString(i,'marcado') <> 'S' then continue
	
	st_mensaje.Text = 'Procesando '+ string(i) + ' de ' + string(filas)+ 'Obras sin liquidar.'
	
	honorarios = dw_lista.GetItemNumber(i,'honorarios')
	rev_honorarios = dw_lista.GetItemNumber(i,'honorarios_iva')
	
	revisio = (honorarios + rev_honorarios) * ipc
	
	dw_lista.SetItem(i,'honorarios_iva',revisio)
	
next

SetPointer(Arrow!)

st_mensaje.Text = 'Ya puede Actualizar los datos.'
end event

type st_1 from statictext within w_revision_hono_procesar
integer x = 64
integer y = 36
integer width = 1317
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
string text = "Introduzca el intervalo de fechas para las obras sin liquidar:"
boolean focusrectangle = false
end type

type st_mensaje from statictext within w_revision_hono_procesar
integer x = 64
integer y = 332
integer width = 2327
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
boolean focusrectangle = false
end type

type cb_actualizar from commandbutton within w_revision_hono_procesar
integer x = 503
integer y = 1432
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Actualizar"
end type

event clicked;//Guarda los cambios en el datawindow

dw_lista.Update()
end event

type cb_cerrar from commandbutton within w_revision_hono_procesar
integer x = 1989
integer y = 1432
integer width = 343
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

