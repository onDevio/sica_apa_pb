HA$PBExportHeader$w_contabil_articulos_detalle.srw
forward
global type w_contabil_articulos_detalle from w_detalle
end type
end forward

global type w_contabil_articulos_detalle from w_detalle
string title = "Detalle Art$$HEX1$$ed00$$ENDHEX$$culos y Servicios"
string menuname = "m_manteni_articulo_detalle"
event pfc_nuevo ( )
end type
global w_contabil_articulos_detalle w_contabil_articulos_detalle

event pfc_nuevo();integer cont
dw_1.reset()
dw_1.insertrow(0)
//estamos ante un registrio nuevo por lo que rellenamos valores de los checks para q no pete
cont = dw_1.rowcount()
dw_1.setitem(1,"honorario","N")
dw_1.setitem(1,"exp","N")
dw_1.setitem(1,"general","N")
dw_1.setitem(1,"activo","N")
dw_1.setitem(1,"tiene_irpf","N")
dw_1.setitem(1,"en_ficha_colegiado","N")
dw_1.setitem(1,"suplido","N")
dw_1.setitem(1,"es_informe","N")
dw_1.setitem(1,"ing_gas","N")
dw_1.setitem(1,"incluir_347","N")
dw_1.setitem(1,"colegio",g_colegio)
dw_1.setitem(1,"empresa",g_empresa)
dw_1.setitem(1,"codigo","")
dw_1.setitem(1,"descripcion","")
dw_1.setitem(1,"familia","")
dw_1.setitem(1,"cuenta","")
dw_1.setitem(1,"cta_presupuestaria","")
dw_1.setitem(1,"importe",0)
dw_1.setitem(1,"impuesto",0)
dw_1.setitem(1,"orden","")
dw_1.setitem(1,"t_iva","")
dw_1.setitem(1,"impreso","")
dw_1.setitem(1,"concepto_conta","")
dw_1.setitem(1,"grupo_gastos","")
dw_1.setitem(1,"activo",'S')





end event

on w_contabil_articulos_detalle.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_manteni_articulo_detalle" then this.MenuID = create m_manteni_articulo_detalle
end on

on w_contabil_articulos_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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
			if res > 0 then mensaje +=  g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
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


//dw_1.insertrow(0)


end event

type cb_recuperar_pantalla from w_detalle`cb_recuperar_pantalla within w_contabil_articulos_detalle
integer y = 1460
end type

type cb_guardar_pantalla from w_detalle`cb_guardar_pantalla within w_contabil_articulos_detalle
integer y = 1340
end type

type cb_nuevo from w_detalle`cb_nuevo within w_contabil_articulos_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_contabil_articulos_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_contabil_articulos_detalle
end type

type cb_ant from w_detalle`cb_ant within w_contabil_articulos_detalle
end type

type cb_sig from w_detalle`cb_sig within w_contabil_articulos_detalle
end type

type dw_1 from w_detalle`dw_1 within w_contabil_articulos_detalle
integer x = 37
integer y = 32
integer width = 2779
integer height = 1184
string dataobject = "d_contabil_articulos_detalle"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event dw_1::constructor;call super::constructor;string codigo
codigo = g_colegiados_consulta.id_colegiado 
if not f_es_vacio(codigo) and codigo <> "" then
	dw_1.retrieve(g_empresa,codigo)
else
	parent.trigger event pfc_nuevo()
end if

end event

event dw_1::itemchanged;call super::itemchanged;string codigo_iva, ls_cta_ingreso
double iva, importe,impuesto
long     ll_cta_gasto,cuantos

choose case dwo.name
	case 'importe'
		if string(data)<> "" and this.getitemstring(1,"t_iva")<> "" then
					codigo_iva = this.getitemstring(1,"t_iva")
					select porcent into :iva from csi_t_iva where t_iva = :codigo_iva using SQLCA;
					importe = double(data)
					impuesto = (importe*iva)/100
					this.setitem(1,"impuesto",impuesto)
		end if
	case  't_iva'
		if string(this.getitemnumber(1,"importe"))<> "" and string(data)<> "" then
					codigo_iva = data
					select porcent into :iva from csi_t_iva where t_iva = :codigo_iva using SQLCA;
					importe = this.getitemnumber(1,"importe")
					impuesto = (importe*iva)/100
					this.setitem(1,"impuesto",impuesto)
		end if
		
	case  'cta_gasto'
		
		ls_cta_ingreso = this.getitemstring(row,"cuenta")
		
		if ls_cta_ingreso ="" or isnull(ls_cta_ingreso) or ls_cta_ingreso ='XXXXXXXX' then //valida que exista cuenta de ingreso antes de incluir la de gastos
		   messagebox(g_titulo, "Debe tener Cuenta de Ingreso.", stopsign!)
		   this.setitem(row,"cta_gasto", "")
		   this.setcolumn("cuenta")
		   this.setfocus()
		   return 1
		end if
		
		ll_cta_gasto = len(data)
		
		if ll_cta_gasto <> g_num_digitos then //valida que la longitud de la cuenta sea la correcta
			
			messagebox(g_titulo, "La cuenta no contiene la Longitud Correcta...!", stopsign!)
			this.setitem(row,"cta_gasto", "")
			this.setcolumn("cta_gasto")
			this.setfocus()
			RETURN 	1

		end if
		
	case 'codigo'
		//Luis ICN-373
		select count(*) into :cuantos from csi_articulos_servicios where codigo = :data and empresa=:g_empresa;
		if(cuantos > 0)then
			MessageBox(g_titulo,'Este c$$HEX1$$f300$$ENDHEX$$digo ya existe, introduzca uno nuevo')	
			return
		end if
		
		
end choose
end event

event dw_1::pfc_preupdate;call super::pfc_preupdate;string mensaje
integer retorno 

retorno = 1

//1er campo a validar codigo
mensaje = mensaje + f_valida(dw_1,'codigo','NONULO',g_idioma.of_getmsg('general.msg_tener_codigo','Debe tener un codigo'))
//2$$HEX2$$ba002000$$ENDHEX$$campo a validar colegio
mensaje = mensaje + f_valida(dw_1,'colegio','NONULO',g_idioma.of_getmsg('general.msg_tener_colegio','Debe tener un colegio'))

if mensaje <> ''  then
	messagebox(g_titulo,mensaje,StopSign!)
	retorno = -1
end if

return retorno
end event

event dw_1::itemerror;call super::itemerror;return 1
end event

