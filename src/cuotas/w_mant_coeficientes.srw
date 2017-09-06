HA$PBExportHeader$w_mant_coeficientes.srw
$PBExportComments$objetos b$$HEX1$$e100$$ENDHEX$$sicos
forward
global type w_mant_coeficientes from w_mant_simple
end type
end forward

global type w_mant_coeficientes from w_mant_simple
integer x = 214
integer y = 221
integer width = 3739
integer height = 1504
windowstate windowstate = maximized!
end type
global w_mant_coeficientes w_mant_coeficientes

on w_mant_coeficientes.create
call super::create
end on

on w_mant_coeficientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

mensaje += f_valida(dw_1,'codigo','NOVACIO','Debe especificar un valor en el campo Variable.'+cr)
//mensaje += f_valida(dw_1,'descripcion','NOVACIO','Debe especificar un valor en el campo Tipo Trabajo.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_mant_coeficientes
integer y = 20
integer width = 3662
integer height = 1160
string title = "Mantenimiento de coeficientes"
string dataobject = "d_mant_coeficientes"
boolean ib_rmbmenu = false
end type

event dw_1::pfc_addrow;call super::pfc_addrow;this.setitem(ancestorreturnvalue,'id_coeficiente',f_siguiente_numero('COEFICIENTE', 10));
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue

end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;this.setitem(ancestorreturnvalue,'id_coeficiente',f_siguiente_numero('COEFICIENTE', 10));
this.setitem(ancestorreturnvalue,'colegio',f_colegio())
return ancestorreturnvalue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_coeficientes
end type

type cb_borrar from w_mant_simple`cb_borrar within w_mant_coeficientes
end type

