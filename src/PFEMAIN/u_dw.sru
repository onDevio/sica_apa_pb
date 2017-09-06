HA$PBExportHeader$u_dw.sru
$PBExportComments$MODIFICADO.
forward
global type u_dw from pfc_u_dw
end type
end forward

global type u_dw from pfc_u_dw
event key pbm_dwnkey
event type integer pfc_scale ( )
event csd_tecla pbm_dwnkey
end type
global u_dw u_dw

event type integer pfc_scale();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_zoom
//
//	Arguments:  none
//
//	Returns:  integer
//	 zoom level chosen by the user
//	 0 = user cancelled from zoom dialog
//	-1 = error
//
//	Description:  Zooms the print preview level to the user-specified amount
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if this.rowcount()  <= 0 then return FAILURE

if IsValid (inv_printpreview) then
	if inv_printpreview.of_GetEnabled() then
		return inv_printpreview.of_SetScale()
	end if
end if

return FAILURE
end event

event csd_tecla;/////////////////////////////////////////////////////////////////////////////
/// Si cuando el usuario esta posicionado en un campo de tipo dddw o ddlb ///
/// presiona las teclas de suprimir se eliminar$$HEX2$$e1002000$$ENDHEX$$el contenido del campo   ///
/// y se disparar$$HEX2$$e1002000$$ENDHEX$$el itemchanged.    												  ///
/////////////////////////////////////////////////////////////////////////////
 
double fila, columna
string tipo_columna, tipo

if key = keydelete! then 
	fila = getrow()
	columna = getcolumn()

	if fila>0 and columna>0 then
		tipo_columna = this.Describe(("#" + string(columna)  + ".Edit.Style"))
		tipo = this.Describe(("#" + string(columna)  + ".ColType"))

		// Vaciamos los campos DDDW de tipo char y los campos DDLB que no sean datetime
		// Utilizamos el settext para que se dispare el itemchanged
		if tipo_columna = "dddw" and LeftA(tipo,4) = 'char' then settext('') //setitem(fila,columna,'')
		if tipo_columna = "ddlb" and tipo <> 'datetime' then settext('') //setitem(fila,columna,'')
	end if
end if

//if ib_CSD_borrar_dddws = false then return 
 
/*string ls_columna, ls_tipo_columna, ls_nulo
double ld_nulo
 
setnull(ld_nulo)
 
if keydown(KeyDelete!) or keydown(KeyBack!) then
 ls_columna=this.getcolumnname()
 ls_tipo_columna = this.Describe(ls_columna + ".Edit.Style")
 if ls_tipo_columna = "dddw"  or ls_tipo_columna = "ddlb" then 
   this.settext(ls_nulo)
   this.accepttext()
 end if
end if
 */

end event

event constructor;of_SetTransObject(SQLCA)
end event

event doubleclicked;call super::doubleclicked;// Modificado David - 31/01/2005
// En Bizkaia quieren seguir con esto
// Modificado David - 24/02/2005
// En Gran Canaria tambi$$HEX1$$e900$$ENDHEX$$n
if g_colegio = 'COAATB' or g_colegio = 'COAATGC' then
	string tipo
	//Lo primero, averiguamos el tipo del campo:
	tipo=this.Describe(dwo.name+".ColType")
	CHOOSE CASE upper(LeftA(tipo ,2))
	 CASE 'NU' 
	  // Llamamos a la conversion
		f_traducir_importe(this, dwo, row)
	END CHOOSE
end if

end event

on u_dw.create
call super::create
end on

on u_dw.destroy
call super::destroy
end on

event pfc_addrow;// Para los campos llamados cuenta% modifs. din$$HEX1$$e100$$ENDHEX$$micamente 
// el valor de limit a: 10
// Sobreescribimos el padre para no hacerlo dos veces
CALL SUPER::pfc_addrow
f_actualiza_limit_dw(this)
return ancestorreturnvalue
end event

event pfc_insertrow;// Para los campos llamados cuenta% modifs. din$$HEX1$$e100$$ENDHEX$$micamente 
// el valor de limit a: 10
// Sobreescribimos el padre para no hacerlo dos veces
CALL SUPER::pfc_insertrow
f_actualiza_limit_dw(this)
return ancestorreturnvalue
end event

event itemfocuschanged;call super::itemfocuschanged;//Para el asistente
f_asistente(this,dwo.name)

end event

event clicked;call super::clicked;/*************************************************************************************************
*       MODULO: TODOS                                                                                                                                                            *
*      PERTENECE A: MULTI-LENGUAJE                                                                                                                                     *
*      DESCRIPCION: En todos los dw csd al hacer clic sobre un label o sobre un group                                                          *
*		 se abre una ventana para poder introducir la traduccion de la/s palabra/s.                                                                 *
*		 Se le pasa una serie de parametros a un evento de una ventana como son el tag, y el modulo al que corresponde. *
*	   AUTOR: Juli$$HEX1$$e100$$ENDHEX$$n Melero                                                                                                                                                        *
*******************************************************************************************/

if g_ventana_traduccion = 'S' then 
	if g_usar_idioma = 'S' then
		string texto,texto2,i_modulo
		integer posicion,i, inserta
		long longitud
		CHOOSE CASE dwo.type
			case 'bitmap' 
			case 'button'
			case 'column'
			case 'compute'
			case 'graph'
			case 'groupbox'
				texto = dwo.tag
				posicion =Pos(Texto,"=")
				longitud = long(len(texto)) 
				texto2 =  mid(texto,posicion+1)
				texto2 = f_reemplaza_cadena(texto2,":","")
				posicion = Pos(texto2,".")
				i_modulo = left(texto2,posicion - 1)
				
				texto2 = texto2 + ',' + i_modulo
				if 	IsValid(w_idiomas_aux_popup) then
				w_idiomas_aux_popup.event inserta_traduccion(texto2,'', i_modulo,'')
			else
				Openwithparm(w_idiomas_aux_popup,texto2)
			end if		
			case 'line'
			case 'ole'
			case 'ellipse' 
			case 'rectangle'
			case 'roundrectangle'
			case 'report'
			case 'tableblob'
			case 'text'
				texto = dwo.tag
				posicion =Pos(Texto,"=")
				longitud = long(len(texto)) 
				texto2 =  mid(texto,posicion+1)
				texto2 = f_reemplaza_cadena(texto2,":","")
				posicion = Pos(texto2,".")
				i_modulo = left(texto2,posicion - 1)
				texto2 = texto2 + ',' + i_modulo
				 if 	IsValid(w_idiomas_aux_popup) then
				  w_idiomas_aux_popup.event inserta_traduccion(texto2,'', i_modulo,'')
				else
					Openwithparm(w_idiomas_aux_popup,texto2)
				end if
		end CHOOSE
	end if
end if

end event

