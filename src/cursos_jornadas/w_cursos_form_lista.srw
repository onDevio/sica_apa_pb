HA$PBExportHeader$w_cursos_form_lista.srw
forward
global type w_cursos_form_lista from w_lista
end type
end forward

global type w_cursos_form_lista from w_lista
integer height = 1312
string title = "Lista Previa de Convocatorias"
end type
global w_cursos_form_lista w_cursos_form_lista

on w_cursos_form_lista.create
call super::create
end on

on w_cursos_form_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista=dw_lista
g_w_lista=g_lista_cursos_form
g_w_detalle=g_detalle_cursos_form
g_lista='w_cursos_form_lista'
g_detalle='w_cursos_form_detalle'
end event

event csd_consulta;call super::csd_consulta;//Abrimos la ventana de consulta

open(w_cursos_form_consulta)
if message.doubleparm=-1 then return
dw_lista.event csd_retrieve()

end event

event csd_detalle;call super::csd_detalle;//leemos el dato clave $$HEX1$$fa00$$ENDHEX$$nica de la fila seleccionada
string curso
if dw_lista.RowCount() = 0 then return 
g_cursos_form_consulta.id_curso=dw_lista.getitemstring(dw_lista.getrow(),'id_curso')
message.stringparm="w_cursos_form_detalle"
w_aplic_frame.postevent("csd_cursos_formdetalle")


end event

event pfc_postopen;call super::pfc_postopen;g_dw_lista_cursos_form=dw_lista
end event

event csd_nuevo();call super::csd_nuevo;OpenSheet(g_detalle_cursos_form,g_detalle,w_aplic_frame,0,original!)
end event

event csd_listados;call super::csd_listados;open(w_cursos_form_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_cursos_form_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_cursos_form_lista
end type

type st_1 from w_lista`st_1 within w_cursos_form_lista
integer x = 37
integer y = 1020
end type

type dw_lista from w_lista`dw_lista within w_cursos_form_lista
integer x = 37
integer y = 32
string dataobject = "d_cursos_form_lista"
end type

type cb_consulta from w_lista`cb_consulta within w_cursos_form_lista
end type

type cb_detalle from w_lista`cb_detalle within w_cursos_form_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_cursos_form_lista
end type

