HA$PBExportHeader$w_contabil_articulos.srw
$PBExportComments$lineas_facturas_emitidas, colegiados
forward
global type w_contabil_articulos from w_mant_simple
end type
type dw_2 from u_dw within w_contabil_articulos
end type
end forward

global type w_contabil_articulos from w_mant_simple
integer x = 214
integer y = 221
integer width = 3680
integer height = 2080
string title = "Mantenimiento de Art$$HEX1$$ed00$$ENDHEX$$culos y Servicios"
string menuname = "m_manteni_articulo"
event pfc_actualizar ( )
event pfc_nuevo ( )
event pfc_detalle ( )
dw_2 dw_2
end type
global w_contabil_articulos w_contabil_articulos

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

public function integer wf_cargar_busqueda ();string consulta, filtro, codigo, descripcion, cuenta, familia, activo, conceptocontabilidad
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
		if anyadir_and then
			consulta = consulta + cadena_where
		end if
		dw_1.setsqlselect( consulta)
		//dw_1.setfilter( filtro)
		dw_1.retrieve()
		filtro = ""

return 1
end function

on w_contabil_articulos.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manteni_articulo" then this.MenuID = create m_manteni_articulo
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_contabil_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
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

event activate;call super::activate;g_w_lista   = g_lista_articulo
g_lista     = 'w_contabil_articulos'
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_contabil_articulos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_contabil_articulos
integer taborder = 20
end type

type dw_1 from w_mant_simple`dw_1 within w_contabil_articulos
integer x = 37
integer y = 520
integer width = 3547
integer height = 1328
integer taborder = 70
string dataobject = "d_mant_articulos"
boolean hsplitscroll = true
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

event dw_1::buttonclicked;string ruta,fichero
long cancelar
// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02
cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero',ruta, fichero,"Archivos (*.RTF),*.RTF")
if cancelar = 1 then
	this.setitem(row,'impreso',fichero)
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


//string fichero,code,cadena,fich,cod
//integer aux,i
//
//aux=row
//if not f_es_vacio(this.getitemstring(row,'codigo')) then
//	fichero=dw_1.getitemstring(row,'impreso')
//	fich=dw_1.getitemstring(row,'impreso')
//	if f_es_vacio(fichero) then
//		fichero='0'
//	else
//		fichero='1'
//	end if
//	cod= dw_1.getitemstring(row,'codigo')
//	for i=1 to 9
//		if len(cod) < 10 then
//			cod='0'+cod
//		end if
//	next
//	Openwithparm(w_certificados_rtf, '0000000011' + cod  + '0000000000' + fichero )	
//	if len(message.stringparm) = 1 then
//		cadena=Message.StringParm
//	else
//		fichero=left(Message.StringParm,len(Message.StringParm)-1)
//		cadena=right(Message.StringParm,1)
//		//cadena=mid(Message.StringParm,2)
//	end if
//	if cadena='S' then
//		//if isnull(dw_1.getitemstring(row,'ruta_rtf')) or dw_1.getitemstring(row,'ruta_rtf') <> fichero + '.rtf' then
//			cod=dw_1.getitemstring(row,'codigo')
//			for i=1 to 9
//				if len(cod) < 10 then
//					cod='0'+cod
//				end if
//			next
//			This.SetItem(row,'impreso', cod +'.rtf')
//			fichero=this.getitemstring(row,'impreso')
//			rte_1.event pfc_clear()
//			rte_1.InsertDocument(g_directorio_rtf + fichero , TRUE, FileTypeRichText!)			
//			i_fila=row		
//		//end if
//	else
//		rte_1.event pfc_clear()		
//		cod=dw_1.getitemstring(row,'codigo')
//		for i=1 to 9
//			if len(cod) < 10 then
//				cod='0'+cod
//			end if
//		next		
//		if isnull(fich) then
//			This.SetItem(row,'impreso', cod +'.rtf')
//			rte_1.InsertDocument(g_directorio_rtf + fichero , TRUE, FileTypeRichText!)						
//		else
//			rte_1.InsertDocument(g_directorio_rtf + cod +'.rtf' , TRUE, FileTypeRichText!)			
//		end if
//		i_fila=row	
//		rte_1.modified=false
//	end if
//else
//	MessageBox(g_titulo, 'El c$$HEX1$$f300$$ENDHEX$$digo de escrito debe tener un valor')
//	this.setcolumn(1)	
//	return
//end if
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

if row = 0 then return 

codigo = dw_1.getitemstring(row,"codigo")
g_colegiados_consulta.id_colegiado = codigo
opensheet(w_contabil_articulos_detalle,parent , 0, original!)

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_contabil_articulos
integer taborder = 50
end type

event cb_anyadir::clicked;call super::clicked;dw_1.setitem(dw_1.getrow(),'colegio',g_colegio)
dw_1.setitem(dw_1.getrow(),'empresa',g_empresa)
end event

type cb_borrar from w_mant_simple`cb_borrar within w_contabil_articulos
boolean visible = false
integer taborder = 60
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_contabil_articulos
boolean visible = false
integer taborder = 30
end type

type dw_2 from u_dw within w_contabil_articulos
integer x = 27
integer y = 40
integer width = 3566
integer height = 440
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_contabil_articulos_busqueda"
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

