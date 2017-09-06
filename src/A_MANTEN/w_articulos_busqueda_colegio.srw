HA$PBExportHeader$w_articulos_busqueda_colegio.srw
$PBExportComments$lineas_facturas_emitidas, colegiados
forward
global type w_articulos_busqueda_colegio from w_mant_simple
end type
type dw_2 from u_dw within w_articulos_busqueda_colegio
end type
type cb_aceptar from commandbutton within w_articulos_busqueda_colegio
end type
type cb_cancelar from commandbutton within w_articulos_busqueda_colegio
end type
end forward

global type w_articulos_busqueda_colegio from w_mant_simple
integer x = 214
integer y = 221
integer width = 3877
integer height = 1436
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
windowstate windowstate = normal!
boolean clientedge = true
boolean ib_isupdateable = false
boolean ib_closestatus = true
event pfc_actualizar ( )
event pfc_nuevo ( )
event pfc_detalle ( )
dw_2 dw_2
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
end type
global w_articulos_busqueda_colegio w_articulos_busqueda_colegio

type variables
integer i_fila
end variables

forward prototypes
public function integer wf_cargar_busqueda ()
end prototypes

event pfc_actualizar();wf_cargar_busqueda()
end event

event pfc_nuevo();g_colegiados_consulta.id_colegiado = ""
//open(w_contabil_articulos_detalle)
opensheet(w_contabil_articulos_detalle,this , 0, original!)

end event

event pfc_detalle();string codigo
long i, cont
long row

if dw_1.rowcount() > 0 then
		cont = dw_1.rowcount()
		for i = 1 to cont 
			if dw_1.isselected(i) then
				row = i
			end if
		next
		if row > 0 then
			codigo = dw_1.getitemstring(row,"codigo")
			if not f_es_vacio(codigo) and codigo <> "" then
				g_colegiados_consulta.id_colegiado = codigo
				opensheet(w_contabil_articulos_detalle,this, 0, original!)
			else
				messagebox(g_titulo,g_idioma.of_getmsg('general.abrir_registro_detalle',"No se puede abrir el registro en modo Detalle ya que el codigo de la linea no tiene valor"))
			end if
		end if

end if

end event

public function integer wf_cargar_busqueda ();string consulta, filtro, codigo, descripcion, cuenta, familia, activo, conceptocontabilidad,empresa
boolean anyadir_and
string cadena_where

consulta = " SELECT csi_articulos_servicios.codigo, " + &   
         	    " csi_articulos_servicios.cuenta,  " +& 
				" csi_articulos_servicios.cta_presupuestaria,  " +& 
				" csi_articulos_servicios.exp,   " +&
				" csi_articulos_servicios.general,   " +&
				" csi_articulos_servicios.importe,   " +&
				" csi_articulos_servicios.activo,   " +&
				" csi_articulos_servicios.es_informe,   " +&
				" csi_articulos_servicios.impuesto,   " +&
				" csi_articulos_servicios.orden,   " +&
				" csi_articulos_servicios.colegio,   " +&
				" csi_articulos_servicios.t_iva,   " +&
				" csi_articulos_servicios.descripcion, " +&  
				" csi_articulos_servicios.impreso,   " +&
				" csi_articulos_servicios.honorario,   " +&
				" csi_articulos_servicios.en_ficha_colegiado, " +&  
				" csi_articulos_servicios.concepto_conta,   " +&
				" csi_articulos_servicios.suplido,   " +&
				" csi_articulos_servicios.tiene_irpf,   " +&
				" csi_articulos_servicios.ing_gas,   " +&
				" csi_articulos_servicios.incluir_347,   " +&
				" csi_articulos_servicios.empresa,   " +&
				" csi_articulos_servicios.familia  " +&
				" FROM csi_articulos_servicios   "
		cadena_where = " WHERE "

		anyadir_and = false
		dw_2.accepttext( )
		codigo = dw_2.getitemstring(1,"codigo")
		descripcion = dw_2.getitemstring(1,"descripcion")
		cuenta = dw_2.getitemstring(1,"cuenta")
		conceptocontabilidad = dw_2.getitemstring(1,"conceptocontabilidad")
		familia = dw_2.getitemstring(1,"familia")
		activo = dw_2.getitemstring(1,"activo")
		empresa=dw_2.getitemstring(1,"empresa")
		filtro = ""
		



		if not f_es_vacio(codigo) and codigo <> "" then
			if len(codigo) <= 10 then
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro + " codigo like '%" + codigo + "%' "			
				else
					filtro = filtro +" and codigo like '%" + codigo + "%' "							
				end if
				cadena_where = cadena_where + filtro
				filtro = ""
			else
				messagebox(g_titulo,g_idioma.of_getmsg('general.exceso_codigo',"El campo Codigo no puede exceder los 10 caracteres"))
			end if
				
		end if
		if not f_es_vacio(descripcion) and descripcion <> "" then
			if anyadir_and = false then
				anyadir_and = true
				filtro = filtro +" descripcion like '%" + descripcion + "%' "			
			else
				filtro = filtro +" and descripcion like '%" + descripcion + "%' "							
			end if
			cadena_where = cadena_where + filtro
			filtro = ""
		end if
		if not f_es_vacio(cuenta) and cuenta <> "" then
			if len(cuenta) <= 10 then
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" cuenta like '%" + cuenta + "%' "			
				else
					filtro = filtro +" and cuenta like '%" + cuenta + "%' "							
				end if
				cadena_where = cadena_where + filtro
				filtro = ""
			else
				messagebox(g_titulo,g_idioma.of_getmsg('general.exceso_cuenta',"El campo Cuenta no puede exceder los 10 caracteres"))
			end if
			
		end if
		if not f_es_vacio(conceptocontabilidad) and conceptocontabilidad <> "" then
			if len(conceptocontabilidad) <= 60 then
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" concepto_conta like '%" + conceptocontabilidad + "%' "			
				else
					filtro = filtro +" and concepto_conta like '%" + conceptocontabilidad + "%' "							
				end if
				cadena_where = cadena_where + filtro
				filtro = ""
			else
				messagebox(g_titulo,g_idioma.of_getmsg('general.exceso_concepto_contabilidad',"El campo Concepto Contabilidad no puede exceder los 60 caracteres"))
			end if
			
		end if
		
		
		if not f_es_vacio(empresa) and empresa <> "" then
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" empresa like '%" + empresa + "%' "			
				else
					filtro = filtro +" and empresa like '%" + empresa + "%' "							
				end if
				cadena_where = cadena_where + filtro	
				filtro = ""
	
			end if
		
		
		if not f_es_vacio(familia) and familia <> "" then
			if len(familia) <= 2 then
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" familia like '%" + familia + "%' "			
				else
					filtro = filtro +" and familia like '%" + familia + "%' "							
				end if
				cadena_where = cadena_where + filtro	
				filtro = ""
			else
				messagebox(g_titulo,g_idioma.of_getmsg('general.exceder_familia',"El campo Familia no puede exceder los 2 caracteres"))
			end if
		
		end if
//		if not f_es_vacio(activo) and activo <> "" then
//			if anyadir_and = false then
//				anyadir_and = true
//				filtro = filtro +" activo = '" + activo + "' "			
//			else
//				filtro = filtro +" and activo = '" + activo + "' "							
//			end if
//			cadena_where = cadena_where + filtro
//			filtro = ""
//		end if
		choose case activo
			case 'A'
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" activo = 'S' "	
				else
					filtro = filtro +" and activo = 'S' "	
				end if
				cadena_where = cadena_where + filtro
				filtro = ""
			case 'I'
				if anyadir_and = false then
					anyadir_and = true
					filtro = filtro +" activo = 'N' "	
				else
					filtro = filtro +" and activo = 'N' "	
				end if
				cadena_where = cadena_where + filtro
				filtro = ""
			case 'T'
		end choose
	    //Magid. 03/05/2011
        //exp     	
	        if anyadir_and = false then
		        anyadir_and = true
		        filtro= filtro +" exp = 'S' "		  
	        else 
		        filtro= filtro +" and exp = 'S' "
	        end if
	      cadena_where = cadena_where + filtro
          filtro = ""	
	    //es_informe
     	
	        if anyadir_and = false then
		        anyadir_and = true
		        filtro= filtro +" es_informe = 'S' "		  
	        else 
		        filtro= filtro +" and es_informe = 'S' "
	        end if
	      cadena_where = cadena_where + filtro
          filtro = ""	
	   /// fin Magid	
		
		if anyadir_and then
			consulta = consulta + cadena_where
		end if
		
		
		dw_1.setsqlselect( consulta)
		//dw_1.setfilter( filtro)
		dw_1.retrieve()
		filtro = ""

return 1
end function

on w_articulos_busqueda_colegio.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on w_articulos_busqueda_colegio.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO',g_idioma.of_getmsg('general.campo_codigo','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.')+cr)
mensaje += f_valida(dw_1,'cuenta','NOVACIO',g_idioma.of_getmsg('general.campo_cuenta','Debe especificar un valor en el campo Cuenta.')+cr)
//mensaje += f_valida(dw_1,'cta_presupuestaria','NOVACIO','Debe especificar un valor en el campo Cta. Presupuestaria.'+cr)
mensaje += f_valida(dw_1,'exp','NOVACIO',g_idioma.of_getmsg('general.campo_exp','Debe especificar un valor en el campo Exp.')+cr)
mensaje += f_valida(dw_1,'general','NOVACIO',g_idioma.of_getmsg('general.campo_general','Debe especificar un valor en el campo General.')+cr)
mensaje += f_valida(dw_1,'importe','NOCERO',g_idioma.of_getmsg('colegiados.valor_importe','Debe especificar un valor en el campo Importe.')+cr)
mensaje += f_valida(dw_1,'impuesto','NOCERO',g_idioma.of_getmsg('general.campo_impuesto','Debe especificar un valor en el campo Impuesto.')+cr)
mensaje += f_valida(dw_1,'activo','NOVACIO',g_idioma.of_getmsg('general.campo_activo','Debe especificar un valor en el campo Activo.')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
			cadenas[1]=string(fila)
			cadenas[2]= string(res)
			if res > 0 then mensaje += g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event pfc_postopen;call super::pfc_postopen;integer child
datawindowchild dwc


dw_2.insertrow(0)
dw_2.setitem(1,"activo",'A')
child = dw_2.getchild( "familia",dwc)
dwc.settransobject(SQLCA)
dwc.retrieve()

dw_1.of_SetRowSelect(TRUE)
dw_1.of_SetRowManager(TRUE)
dw_1.of_SetSort(TRUE)
dw_1.of_SetProperty(TRUE)


end event

event activate;call super::activate;//g_w_lista   = g_lista_articulo
//g_lista     = 'w_contabil_articulos'
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_articulos_busqueda_colegio
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_articulos_busqueda_colegio
integer x = 622
integer y = 1088
integer taborder = 20
end type

type dw_1 from w_mant_simple`dw_1 within w_articulos_busqueda_colegio
integer x = 37
integer y = 608
integer width = 3803
integer height = 512
integer taborder = 70
string dataobject = "d_articulos_consulta_por_colegio"
boolean hscrollbar = false
boolean hsplitscroll = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
string is_updatesallowed = ""
end type

event type long dw_1::pfc_addrow();call super::pfc_addrow;dw_1.setitem(dw_1.getrow(),'colegio',g_colegio)
dw_1.setitem(dw_1.getrow(),'empresa',g_empresa)
return 1
end event

event type long dw_1::pfc_insertrow();call super::pfc_insertrow;dw_1.setitem(dw_1.getrow(),'colegio',g_colegio)
dw_1.setitem(dw_1.getrow(),'empresa',g_empresa)
return 1
end event

event dw_1::itemchanged;double porcen
string t_iva

t_iva=this.getitemstring(row,'t_iva')
SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva  WHERE csi_t_iva.t_iva = :t_iva ;  
choose case dwo.name
	case 'importe'
		this.setitem(row,'impuesto',f_redondea(double(data)*porcen/100))		
	case 't_iva'
		SELECT csi_t_iva.porcent INTO :porcen  FROM csi_t_iva  WHERE csi_t_iva.t_iva = :data ;		
		this.setitem(row,'impuesto',f_redondea(this.getitemnumber(row,'importe')*porcen/100))		
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;// Solo permito que se modifique el codigo de la Nueva fila

IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.codigo.Edit.DisplayOnly = "No"
ELSE	
	Object.codigo.Edit.DisplayOnly = "Yes"
END IF	

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
codigo = dw_1.GetItemString(fila, "codigo")

// Si la fila es nueva la suprimimos
if dw_1.GetItemStatus(fila, 0, Primary!) = NewModified! or &
   dw_1.GetItemStatus(fila, 0, Primary!) = New! Then 
	return 1

else
// Comprobamos que no hayan colegiados que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    from conceptos_domiciliables  
   WHERE (conceptos_domiciliables.concepto = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"),  g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n")  + &
		           g_idioma.of_getmsg('general.msg_colegiados_tipo_servicio',"Existen colegiados con este tipo de Servicio.") , Exclamation!)
		return 0
	end if

// Comprobamos que no hayan lineas de facturas emitidas que utilicen este c$$HEX1$$f300$$ENDHEX$$digo
	SELECT Count(*)  
	 INTO :num_registros
    from csi_lineas_fact_emitidas 
   WHERE (csi_lineas_fact_emitidas.articulo = :codigo) ;  

	if num_registros > 0 then
		dw_1.ScrollToRow(fila)
		dw_1.SetColumn("codigo")
		messagebox(g_idioma.of_getmsg('general.suprimir',"Suprimir"),  g_idioma.of_getmsg('general.borrar_registro',"No se puede borrar el registro. ~n")  + &
		           g_idioma.of_getmsg('general.msg_facturas_tipo_servicio',"Existen lineas de facturas emitidas con este tipo de Servicio.") , Exclamation!)
		return 0
	end if

end if

return 1 //continuamos con el borrado del registro

end event

event dw_1::doubleclicked;call super::doubleclicked;string codigo
st_csi_articulos_servicios articulo

if dw_1.rowcount()>0  then 

    articulo.colegio = dw_1.getitemstring(dw_1.getrow(),"colegio")
	articulo.codigo = dw_1.getitemstring(dw_1.getrow(),"codigo")
	articulo.empresa=dw_1.getitemstring(dw_1.getrow(),"empresa")
	articulo.importe = dw_1.getitemnumber(dw_1.getrow( ),"importe")
	articulo.t_iva = dw_1.getitemstring( dw_1.getrow( ),"t_iva") 
	CloseWithReturn(parent,articulo)
else
	
	articulo.codigo = "-1"
	articulo.empresa=""
     articulo.colegio=""
	CloseWithReturn(parent,articulo)
end if

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_articulos_busqueda_colegio
boolean visible = false
integer taborder = 50
boolean enabled = false
end type

event cb_anyadir::clicked;call super::clicked;dw_1.setitem(dw_1.getrow(),'colegio',g_colegio)
dw_1.setitem(dw_1.getrow(),'empresa',g_empresa)
end event

type cb_borrar from w_mant_simple`cb_borrar within w_articulos_busqueda_colegio
boolean visible = false
integer taborder = 60
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_articulos_busqueda_colegio
boolean visible = false
integer taborder = 30
end type

type dw_2 from u_dw within w_articulos_busqueda_colegio
integer x = 37
integer y = 32
integer width = 3474
integer height = 512
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_contabil_articulos_busqueda_emp"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;choose case dwo.name
	case 	"b_1" //Buscar
		dw_1.retrieve()
		wf_cargar_busqueda()
end choose
end event

type cb_aceptar from commandbutton within w_articulos_busqueda_colegio
integer x = 3035
integer y = 1184
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event clicked;string codigo=''
st_csi_articulos_servicios articulo
if dw_1.rowcount()>0  then 


    articulo.colegio = dw_1.getitemstring(dw_1.getrow(),"colegio")
	articulo.codigo = dw_1.getitemstring(dw_1.getrow(),"codigo")
	articulo.empresa=dw_1.getitemstring(dw_1.getrow(),"empresa")
	articulo.importe = dw_1.getitemnumber(dw_1.getrow( ),"importe")
	articulo.t_iva = dw_1.getitemstring( dw_1.getrow( ),"t_iva") 
	CloseWithReturn(parent,articulo)
else
	
	articulo.codigo = "-1"
	articulo.empresa=""
	articulo.colegio=""
	CloseWithReturn(parent,articulo)
end if

end event

type cb_cancelar from commandbutton within w_articulos_busqueda_colegio
integer x = 3401
integer y = 1184
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
string text = "Cancelar"
end type

event clicked;st_csi_articulos_servicios articulo

	articulo.codigo = "-1"
	articulo.empresa=""
	CloseWithReturn(parent,articulo)
end event

