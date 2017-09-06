HA$PBExportHeader$w_ctrlasistencia_lista.srw
forward
global type w_ctrlasistencia_lista from w_lista
end type
end forward

global type w_ctrlasistencia_lista from w_lista
string title = "Lista de Control de Asistencia"
event csd_consulta_curso ( )
end type
global w_ctrlasistencia_lista w_ctrlasistencia_lista

event csd_consulta_curso();//Andr$$HEX1$$e900$$ENDHEX$$s: Este evento realiza la consulta directamente tomando el valor de curso
//de g_ctrlasistencia_consulta.id_curso

string sql_nuevo

sql_nuevo=g_dw_lista.describe("datawindow.table.select")

sql_nuevo+=" where id_curso LIKE '"+g_ctrlasistencia_consulta.id_curso+"'"

g_dw_lista.modify("Datawindow.table.select=~""+sql_nuevo+"~"")

dw_lista.event csd_retrieve()

end event

on w_ctrlasistencia_lista.create
call super::create
end on

on w_ctrlasistencia_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event csd_nuevo;call super::csd_nuevo;
OpenSheet(g_detalle_ctrlasistencia,g_detalle,w_aplic_frame,0,original!)

end event

event activate;call super::activate;g_dw_lista=dw_lista
g_w_lista=g_lista_ctrlasistencia
g_w_detalle=g_detalle_ctrlasistencia
g_lista='w_ctrlasistencia_lista'
g_detalle='w_ctrlasistencia_detalle'
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta
  
open(w_ctrlasistencia_consulta)
if message.doubleparm=-1 then return
dw_lista.event csd_retrieve()


end event

event csd_detalle;//leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada

if dw_lista.RowCount() = 0 then return 

g_ctrlasistencia_consulta.id_asistencia_fecha=dw_lista.getitemstring(dw_lista.getrow(),'id_asistencia_fecha')

message.stringparm="w_ctrlasistencia_detalle"
w_aplic_frame.postevent("csd_ctrlasistenciadetalle")
end event

event pfc_postopen;g_dw_lista_ctrlasistencia=dw_lista

//Cuando g_ctrlasistencia_consulta.id_curso no es vac$$HEX1$$ed00$$ENDHEX$$o es que venimos de la ventana
//detalle de cursos y queremos que s$$HEX1$$f300$$ENDHEX$$lo se vean las listas de asistencia de ese curso
if f_es_vacio(g_ctrlasistencia_consulta.id_curso) then
  TriggerEvent('csd_consulta')
else
  TriggerEvent('csd_consulta_curso')
  g_ctrlasistencia_consulta.id_curso=""
end if

end event

event csd_listados;call super::csd_listados;open(w_ctrlasistencia_listados)
end event

type st_1 from w_lista`st_1 within w_ctrlasistencia_lista
end type

type dw_lista from w_lista`dw_lista within w_ctrlasistencia_lista
integer height = 956
string dataobject = "d_ctrlasistencia_lista"
end type

event dw_lista::retrieveend;call super::retrieveend;//Andr$$HEX1$$e900$$ENDHEX$$s 23/6/2005
//rellenamos la descripcion del curso manualmente
//estaba en un campo computado del dw y ralentizaba las cosas mucho

int i
string ls_descripcion_curso

for i=1 to dw_lista.rowcount()
	ls_descripcion_curso=f_curso(dw_lista.getitemstring(i,'id_curso'))
	dw_lista.setitem(i,'nombre_curso',ls_descripcion_curso)
next

dw_lista.resetupdate()
end event

type cb_consulta from w_lista`cb_consulta within w_ctrlasistencia_lista
end type

type cb_detalle from w_lista`cb_detalle within w_ctrlasistencia_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_ctrlasistencia_lista
end type

