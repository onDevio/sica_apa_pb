HA$PBExportHeader$w_articulo_por_tramite.srw
$PBExportComments$domicilio,provincia,cliente
forward
global type w_articulo_por_tramite from w_mant_simple
end type
type st_1 from statictext within w_articulo_por_tramite
end type
type st_2 from statictext within w_articulo_por_tramite
end type
type st_3 from statictext within w_articulo_por_tramite
end type
end forward

global type w_articulo_por_tramite from w_mant_simple
integer width = 3342
integer height = 1664
string title = "Art$$HEX1$$ed00$$ENDHEX$$culos por Tr$$HEX1$$e100$$ENDHEX$$mite"
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_articulo_por_tramite w_articulo_por_tramite

on w_articulo_por_tramite.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
end on

on w_articulo_por_tramite.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;call super::open;dw_1.SetTransObject(SQLCA)


//dw_1.retrieve(g_colegio )

end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_articulo_por_tramite
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_articulo_por_tramite
end type

type dw_1 from w_mant_simple`dw_1 within w_articulo_por_tramite
integer x = 0
integer y = 224
integer width = 3218
integer height = 1216
string dataobject = "d_manteni_tarifas_x_tramite"
end type

event dw_1::buttonclicked;call super::buttonclicked;st_csi_articulos_servicios lst_csi_articulos_servicios
double porcen

choose case dwo.name
      case 'b_informes'
		open(w_articulos_busqueda_colegio)
		lst_csi_articulos_servicios = Message.powerobjectparm
		if isvalid(lst_csi_articulos_servicios) then
			if lst_csi_articulos_servicios.codigo <> '-1' then
		     	long lineas_coincidentes
		         string colegio, empresa, codigo

				colegio= lst_csi_articulos_servicios.colegio
				empresa= lst_csi_articulos_servicios.empresa
				codigo= lst_csi_articulos_servicios.codigo 

//                  lineas_coincidentes=this.Find(	"id_informe = '"+codigo+"'and colegio = '"+colegio+"'and csi_articulos_servicios_empresa ='"+empresa+"'", 1, this.RowCount())
 				lineas_coincidentes=this.Find(	"id_informe = '"+codigo+"'and colegio = '"+colegio+"'and tipo_tramite ='"+this.getitemstring(row, 'tipo_tramite')+"'", 1, this.RowCount())
		      	if lineas_coincidentes>0 and lineas_coincidentes<>row then 	
//			     	Messagebox("Mensaje","No se puede seleccionar el mismo art$$HEX1$$ed00$$ENDHEX$$culo para tr$$HEX1$$e100$$ENDHEX$$mites diferentes.")
  					Messagebox("Mensaje","Ya se encuentra el art$$HEX1$$ed00$$ENDHEX$$culo seleccionado para el tipo de tramite indicado.")
					  this.event pfc_deleterow()
		         	else				
			     		this.setitem(row, 'id_informe', lst_csi_articulos_servicios.codigo)
			     end if    

               end if	
		end if
end choose
end event

event dw_1::pfc_addrow;call super::pfc_addrow;
this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('id_tarifas_informes', 10))
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)
this.SetItem(ancestorreturnvalue,'id_informe',this.GetItemString(this.GetRow(),'id_informe') )


return ancestorreturnvalue
end event

event dw_1::pfc_insertrow;call super::pfc_insertrow;
this.SetItem(ancestorreturnvalue,'id', f_siguiente_numero('id_tarifas_informes', 10))
this.SetItem(ancestorreturnvalue,'colegio',g_colegio)
this.SetItem(ancestorreturnvalue,'id_informe',this.GetItemString(this.GetRow(),'id_informe') )


return ancestorreturnvalue
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_articulo_por_tramite
boolean visible = false
end type

type cb_borrar from w_mant_simple`cb_borrar within w_articulo_por_tramite
boolean visible = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_articulo_por_tramite
boolean visible = false
integer x = 1385
integer y = 1212
end type

type st_1 from statictext within w_articulo_por_tramite
integer x = 73
integer y = 32
integer width = 5705
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importante: Los tr$$HEX1$$e100$$ENDHEX$$mites que comparten art$$HEX1$$ed00$$ENDHEX$$culo, el precio base ser$$HEX2$$e1002000$$ENDHEX$$el mismo por tipo de intervenci$$HEX1$$f300$$ENDHEX$$n. Si se requiere importes diferentes los art$$HEX1$$ed00$$ENDHEX$$culos deber$$HEX1$$e100$$ENDHEX$$n de ser diferentes c$$HEX1$$f300$$ENDHEX$$digos. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_articulo_por_tramite
integer x = 402
integer y = 96
integer width = 4379
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ejemplo: REDAP y VisadoVoluntatio comparten art$$HEX1$$ed00$$ENDHEX$$culo: ~'01~';  T.A (14)  art$$HEX1$$ed00$$ENDHEX$$culo: ~'01~', precio = 35 euros "
boolean focusrectangle = false
end type

type st_3 from statictext within w_articulo_por_tramite
integer x = 3109
integer y = 96
integer width = 416
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "  para ambos."
boolean focusrectangle = false
end type

