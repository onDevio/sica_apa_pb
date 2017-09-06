HA$PBExportHeader$w_regenera_poblaciones.srw
$PBExportComments$col
forward
global type w_regenera_poblaciones from w_mant_simple
end type
type cb_regenerar from commandbutton within w_regenera_poblaciones
end type
type cb_cancelar from commandbutton within w_regenera_poblaciones
end type
type cbx_1 from checkbox within w_regenera_poblaciones
end type
end forward

global type w_regenera_poblaciones from w_mant_simple
integer x = 214
integer y = 221
integer width = 3291
integer height = 1448
string title = "Regenera Poblaci$$HEX1$$f300$$ENDHEX$$n y Direcci$$HEX1$$f300$$ENDHEX$$n Activa"
string menuname = ""
cb_regenerar cb_regenerar
cb_cancelar cb_cancelar
cbx_1 cbx_1
end type
global w_regenera_poblaciones w_regenera_poblaciones

type variables
n_csd_impresion_formato i_impresion_formato
end variables

on w_regenera_poblaciones.create
int iCurrent
call super::create
this.cb_regenerar=create cb_regenerar
this.cb_cancelar=create cb_cancelar
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_regenerar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cbx_1
end on

on w_regenera_poblaciones.destroy
call super::destroy
destroy(this.cb_regenerar)
destroy(this.cb_cancelar)
destroy(this.cbx_1)
end on

event open;call super::open;// Enable the resize service
of_SetResize (true)

// Specify how the window will be resized
//inv_resize.of_Register (dw_1, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_regenerar, "FixedtoBottom")
inv_resize.of_Register (cb_cancelar, "FixedtoBottom")
inv_resize.of_Register (cbx_1, "FixedtoBottom")

i_impresion_formato = create n_csd_impresion_formato

end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_regenera_poblaciones
integer x = 1074
integer y = 1232
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_regenera_poblaciones
end type

type dw_1 from w_mant_simple`dw_1 within w_regenera_poblaciones
event csd_actualiza_dom_pob_activa ( long row )
event csd_actualiza_dom_pob_fiscal_activa ( integer row )
integer y = 16
integer width = 3186
integer height = 1196
string dataobject = "d_regenera_poblacion_domicilio"
boolean hscrollbar = false
boolean livescroll = false
end type

event dw_1::csd_actualiza_dom_pob_activa(long row);string dom_activo, pob_activa
long linea

dom_activo= f_obtener_domicilio_activo(dw_1.getitemstring(row,'tipo_via'), &
													dw_1.getitemstring(row,'nom_via'))
													
pob_activa= f_obtener_poblacion_activa(dw_1.getitemstring(row,'cod_pob'), & 
													dw_1.getitemstring(row,'cod_prov'), &
													dw_1.getitemstring(row,'cp'))

dw_1.setitem(row,'colegiados_domicilio_activo',dom_activo)
dw_1.setitem(row,'colegiados_poblacion_activa',pob_activa)
	


end event

event dw_1::csd_actualiza_dom_pob_fiscal_activa(integer row);string dom_fiscal_activo, pob_fiscal_activa

dom_fiscal_activo= f_obtener_domicilio_activo(dw_1.getitemstring(row,'tipo_via'), &
													dw_1.getitemstring(row,'nom_via'))
													
pob_fiscal_activa= f_obtener_poblacion_activa(dw_1.getitemstring(row,'cod_pob'), & 
													dw_1.getitemstring(row,'cod_prov'), &
													dw_1.getitemstring(row,'cp'))

dw_1.setitem(row,'colegiados_domicilio_activo_fiscal',dom_fiscal_activo)
dw_1.setitem(row,'colegiados_poblacion_activa_fiscal',pob_fiscal_activa)
end event

event dw_1::pfc_predeleterow;call super::pfc_predeleterow;//pfc_predeleterow()

// return
//    0 previene el borrado
//    1 suprime el registro
//   -1 error

string codigo
long num_registros
long fila

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0

fila = dw_1.GetRow()
codigo = dw_1.GetItemString(fila, "cod_colegio")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    FROM colegiados  
   WHERE (colegiados.colegio = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("cod_colegio")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"), g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n") + &
		           g_idioma.of_getmsg('msg_codigo_colegio',"Existen colegiados con este c$$HEX1$$f300$$ENDHEX$$digo de Colegio.") , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::buttonclicked;call super::buttonclicked;string pob, cod_provincia,cod_postal,cod_pais

this.accepttext()



CHOOSE CASE dwo.name
	CASE 'b_poblacion'
		
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		
		if f_es_vacio(pob) then return
		
		this.SetItem(row,'cod_pob',pob)
		
		cod_provincia=f_devuelve_cod_provincia(pob)
		cod_postal=f_devuelve_cod_postal(pob)
		cod_pais=f_devuelve_cod_pais(pob)
		
		this.setitem(row,'cp',cod_postal)
		this.setitem(row,'cod_prov',cod_provincia)
		this.setitem(row,'pais',cod_pais)
	
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if this.getitemstring(row,'cambio_correspondencia') = 'S' then 
			this.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if this.getitemstring(row,'cambio_fiscal') = 'S' then 
			this.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if			
		
		this.setitem(row,"cambio_realizado",'S')

END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;string  cod_postal, cod_provincia, cod_pais
string  dom_activo, pob_activa
string  cod_via, nom_via, cod_pob, cod_prov
integer f

this.setitem(row,"cambio_realizado",'S')

CHOOSE CASE dwo.name
	//cuando se cambia la poblaci$$HEX1$$f300$$ENDHEX$$n actualizo los c$$HEX1$$f300$$ENDHEX$$digos de: cp, provincia y pais
	CASE 'cod_pob' 

		IF f_es_vacio(data) then
			this.setitem(row,'cp','')
			this.setitem(row,'cod_prov','')
			this.setitem(row,'pais','')
		else
			cod_provincia=f_devuelve_cod_provincia(data)
			cod_postal=f_devuelve_cod_postal(data)
			cod_pais=f_devuelve_cod_pais(data)
			
			this.setitem(row,'cod_pob',data)
			this.setitem(row,'cp',cod_postal)
			this.setitem(row,'cod_prov',cod_provincia)
			this.setitem(row,'pais',cod_pais)
		end if
		
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if this.getitemstring(row,'cambio_correspondencia') = 'S' then 
			this.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if this.getitemstring(row,'cambio_fiscal') = 'S' then 
			this.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
		// fin MODIFICADO RICARDO 03-10-30
		
		
	CASE 'tipo_via'
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if this.getitemstring(row,'cambio_correspondencia') = 'S' then 
			this.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if this.getitemstring(row,'cambio_fiscal') = 'S' then 
			this.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
		
	CASE 'nom_via', 'cp', 'cod_prov'
		// Si Correspondencia es 'S' se actualiza Dom. y pobl activa
		if this.getitemstring(row,'cambio_correspondencia') = 'S' then 
		//	messagebox(' comercial es S ',row)
			this.event csd_actualiza_dom_pob_activa(row)
		end if	
		// Si Fiscal es 'S' se actualiza Dom. y pobl fiscal activa
		if this.getitemstring(row,'cambio_fiscal') = 'S' then 
			this.event csd_actualiza_dom_pob_fiscal_activa(row)
		end if	
End choose	

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_regenera_poblaciones
boolean visible = false
end type

type cb_borrar from w_mant_simple`cb_borrar within w_regenera_poblaciones
boolean visible = false
integer x = 599
integer y = 1200
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_regenera_poblaciones
boolean visible = false
integer x = 1714
integer y = 1212
end type

type cb_regenerar from commandbutton within w_regenera_poblaciones
integer x = 2501
integer y = 1232
integer width = 343
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Regenerar"
end type

event clicked;datastore  ldst_listado
integer i
string a, ls_n_colegiado, ls_apellido, ls_nombre, ls_domicilio_activo, ls_poblacion_activa, ls_domicilio_fiscal, ls_poblacion_fiscal
long    ll_fila


IF Messagebox(g_titulo, 'Seguro de Regenerar los Domicilios Modificados..?', question!, yesno!) = 1 THEN

	
	ldst_listado = create datastore
	ldst_listado.dataobject = 'd_ext_listado_regenera_poblacion'
	ldst_listado.settransobject(sqlca)
	
	if dw_1.rowcount() > 0 then
		if dw_1.update() = 1 then
			commit;
			Messagebox(g_titulo, 'Domicilios Regenerados')
		else
			rollback;
		end if
		
		if cbx_1.checked = true then 
			for i = 1 to dw_1.rowcount()
				if dw_1.getitemstring(i,"cambio_realizado") = 'S' then
					ls_n_colegiado =dw_1.getitemstring(i,"colegiados_n_colegiado")
					ls_apellido =dw_1.getitemstring(i,"colegiados_apellidos")
					ls_nombre =dw_1.getitemstring(i,"colegiados_nombre")
					ls_domicilio_activo =dw_1.getitemstring(i,"colegiados_domicilio_activo")
					ls_poblacion_activa =dw_1.getitemstring(i,"colegiados_poblacion_activa")
					ls_domicilio_fiscal =dw_1.getitemstring(i,"colegiados_domicilio_activo_fiscal")
					ls_poblacion_fiscal =dw_1.getitemstring(i,"colegiados_poblacion_activa_fiscal")
	
					ll_fila = ldst_listado.insertrow(0)
					ldst_listado.setitem(ll_fila,"n_colegiado",ls_n_colegiado)
					ldst_listado.setitem(ll_fila,"apellido",ls_apellido)
					ldst_listado.setitem(ll_fila,"nombre",ls_nombre)
					ldst_listado.setitem(ll_fila,"domicilio_activo",ls_domicilio_activo)
					ldst_listado.setitem(ll_fila,"poblacion_activa",ls_poblacion_activa)
					ldst_listado.setitem(ll_fila,"domicilio_fiscal_activo",ls_domicilio_fiscal)
					ldst_listado.setitem(ll_fila,"poblacion_fiscal_activa",ls_poblacion_fiscal)
				end if
			next
			dw_1.event pfc_retrieve()
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
		else
			dw_1.event pfc_retrieve()
		end if
	end if
	destroy ldst_listado		
END IF


end event

type cb_cancelar from commandbutton within w_regenera_poblaciones
integer x = 2862
integer y = 1232
integer width = 343
integer height = 92
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cbx_1 from checkbox within w_regenera_poblaciones
integer x = 41
integer y = 1244
integer width = 782
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Informe de domicilios procesados"
end type

