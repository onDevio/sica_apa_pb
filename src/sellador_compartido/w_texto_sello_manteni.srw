HA$PBExportHeader$w_texto_sello_manteni.srw
forward
global type w_texto_sello_manteni from w_mant_simple
end type
end forward

global type w_texto_sello_manteni from w_mant_simple
integer width = 4032
end type
global w_texto_sello_manteni w_texto_sello_manteni

on w_texto_sello_manteni.create
call super::create
end on

on w_texto_sello_manteni.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1
string id_texto

id_texto=f_siguiente_numero('TEXTO_SELLO',10)
dw_1.setitem(dw_1.getrow(),'id_texto',id_texto)

mensaje += f_valida(dw_1,'nombre','NOVACIO','Debe especificar un valor en el campo Nombre.'+cr)
mensaje += f_valida(dw_1,'texto','NOVACIO','Debe especificar un valor en el campo Texto.'+cr)
mensaje += f_valida(dw_1,'color','NOVACIO','Debe especificar un valor en el campo Color.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'nombre', fila)
			if res > 0 then mensaje += 'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

type dw_1 from w_mant_simple`dw_1 within w_texto_sello_manteni
integer width = 3931
string dataobject = "d_texto_sello_manteni"
end type

type cb_anyadir from w_mant_simple`cb_anyadir within w_texto_sello_manteni
end type

type cb_borrar from w_mant_simple`cb_borrar within w_texto_sello_manteni
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_texto_sello_manteni
end type

