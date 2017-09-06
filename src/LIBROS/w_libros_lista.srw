HA$PBExportHeader$w_libros_lista.srw
forward
global type w_libros_lista from w_lista
end type
end forward

global type w_libros_lista from w_lista
integer width = 3904
string title = "Lista Previa de Biblioteca"
end type
global w_libros_lista w_libros_lista

type variables

end variables

on w_libros_lista.create
call super::create
end on

on w_libros_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_libros
g_w_detalle = g_detalle_libros
g_lista     = 'w_libros_lista'
g_detalle   = 'w_libros_detalle'
end event

event csd_consulta;call super::csd_consulta;open(w_libros_consulta)
if message.doubleparm=-1 then return
dw_lista.event csd_retrieve()



end event

event csd_detalle;call super::csd_detalle;if dw_lista.getrow() < 1 then return
g_libros_consulta.id_libro=dw_lista.GetItemString(dw_lista.GetRow(),'id_libro')
Message.StringParm="w_libros_detalle"
w_aplic_frame.PostEvent("csd_librosdetalle")
end event

event pfc_postopen;call super::pfc_postopen;g_dw_lista_libros=dw_lista
end event

event csd_nuevo;call super::csd_nuevo;OpenSheet(g_detalle_libros,g_detalle,w_aplic_frame,0,original!)
end event

event csd_listados;call super::csd_listados;//Llamamos a la ventana listados
open(w_libros_listados)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_libros_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_libros_lista
end type

type st_1 from w_lista`st_1 within w_libros_lista
end type

type dw_lista from w_lista`dw_lista within w_libros_lista
integer width = 3735
string dataobject = "d_libros_lista"
end type

event dw_lista::csd_retrieve;call super::csd_retrieve;int i,j,k
string f_pres
string f_pres_col_desde
string f_pres_col_hasta
string f_dev_real
string f_dev_real_desde
string f_dev_real_hasta
string coleg
string id_libro

//Introduce el n$$HEX2$$ba002000$$ENDHEX$$de colegiado en el campo computado n_col
//for k=1 to this.rowcount()
//		this.setitem(k,'n_col',f_colegiado_n_col(this.getitemstring(k,'prestamos_colegiado')))
//next
//-----------------------------------------------

if dw_lista.RowCount() > 0 then

	/*
	//fecha pr$$HEX1$$e900$$ENDHEX$$stamo
	if string(g_libros_consulta.f_prestamo_desde)<>"01/01/00 00:00:00" and string(g_libros_consulta.f_prestamo_hasta)<>"01/01/00 00:00:00" then

			f_pres_col_desde=string(date(g_libros_consulta.f_prestamo_desde))
			f_pres_col_hasta=string(date(g_libros_consulta.f_prestamo_hasta))
//			messagebox('filtro -si entra-',"prestamos_f_prestamo >='"+f_pres_col_desde+"' and prestamos_f_prestamo <='"+ f_pres_col_hasta +"'")
			this.SetFilter("string(prestamos_f_prestamo) >='"+f_pres_col_desde+"' and string(prestamos_f_prestamo) <='"+ f_pres_col_hasta +"'")
			this.Filter()
			this.setfilter("")
			
	end if
	
	//fecha devoluci$$HEX1$$f300$$ENDHEX$$n real
	if string(g_libros_consulta.f_devolucion_real_desde)<>"01/01/00 00:00:00" and string(g_libros_consulta.f_devolucion_real_hasta)<>"01/01/00 00:00:00" then
		
			f_dev_real_desde=string(date(g_libros_consulta.f_devolucion_real_desde))
			f_dev_real_hasta=string(date(g_libros_consulta.f_devolucion_real_hasta))
//			messagebox('filtro',"prestamos_f_devolucion_real >='"+f_dev_real_desde+"' and prestamos_f_devolucion_real <='"+ f_dev_real_hasta +"'")
			this.SetFilter("string(prestamos_f_devolucion_real) >='"+f_dev_real_desde+"' and string(prestamos_f_devolucion_real) <='"+ f_dev_real_hasta +"'")
			this.Filter()
			this.setfilter("")
			
	end if
	
	//colegiado
	if  g_libros_consulta.n_colegiado<>'' then
//			messagebox('filtro colegiado',"n_col='"+g_libros_consulta.n_colegiado+"'")
			coleg="n_col='"+g_libros_consulta.n_colegiado+"'"
			this.SetFilter(coleg)
			this.Filter()
			this.setfilter("")
	end if
*/
/*	for i=1 to dw_lista.rowcount()
		id_libro=dw_lista.getitemstring(i,'id_libro')
		for j=i+1 to dw_lista.rowcount()
			dw_lista.setrow(j)
			if id_libro=dw_lista.getitemstring(j,'id_libro') then
				dw_lista.deleterow(dw_lista.getrow())
				j=j - 1
			end if
		next
	next*/
	
else
	messagebox("",'No existen filas en la lista')
end if
	
	this.ResetUpdate() 
	

end event

event dw_lista::buttonclicked;call super::buttonclicked;st_libro_busqueda lst_parametros

lst_parametros.titulo   = this.getitemstring(this.getrow(), 'libros_cdu')+ '-' + this.getitemstring(this.getrow(), 'titulo')
lst_parametros.id_libro = this.getitemstring(this.getrow(),'id_libro')
openwithparm(w_busqueda_libros_consulta, lst_parametros )

end event

type cb_consulta from w_lista`cb_consulta within w_libros_lista
end type

type cb_detalle from w_lista`cb_detalle within w_libros_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_libros_lista
end type

