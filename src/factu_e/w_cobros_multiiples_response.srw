HA$PBExportHeader$w_cobros_multiiples_response.srw
forward
global type w_cobros_multiiples_response from w_response
end type
type dw_1 from u_csd_dw within w_cobros_multiiples_response
end type
type cb_anadir from commandbutton within w_cobros_multiiples_response
end type
type dw_2 from u_csd_dw within w_cobros_multiiples_response
end type
type cb_borrar from commandbutton within w_cobros_multiiples_response
end type
type cb_cerrar from commandbutton within w_cobros_multiiples_response
end type
end forward

global type w_cobros_multiiples_response from w_response
integer width = 3205
integer height = 1664
string title = "Cobros Compuestos"
dw_1 dw_1
cb_anadir cb_anadir
dw_2 dw_2
cb_borrar cb_borrar
cb_cerrar cb_cerrar
end type
global w_cobros_multiiples_response w_cobros_multiiples_response

type variables
string  id_factura
end variables

forward prototypes
public subroutine wf_ubicar_n_fact (string as_n_fact, ref string as_n_fact_obtenido, ref string as_nif, ref string as_nombre, ref double adb_base_imp, ref double adb_iva, ref double adb_total, ref string as_aviso, ref boolean ab_existe)
public subroutine wf_actualiza_cobros_facturas_adic (string id_pago, string as_id_factura, string n_fact, string id_cobro_multiple, datetime f_pago)
public subroutine wf_actualiza_borrar_factura (string id_pago, string as_id_factura, string n_fact, double total_factura)
public subroutine wf_actualiza_cobros_facturas (string id_pago, string as_id_factura, string n_fact, string id_cobro_multiple)
end prototypes

public subroutine wf_ubicar_n_fact (string as_n_fact, ref string as_n_fact_obtenido, ref string as_nif, ref string as_nombre, ref double adb_base_imp, ref double adb_iva, ref double adb_total, ref string as_aviso, ref boolean ab_existe);string ls_id_factura, as_id_fase
  
  SELECT csi_facturas_emitidas.id_factura  
    INTO :ls_id_factura  
    FROM csi_facturas_emitidas  
   WHERE csi_facturas_emitidas.n_fact = :as_n_fact   ;
	
if ls_id_factura <> "" and not isnull(ls_id_factura) then
	
	//Buscar los datos de la factura que se debe ingresar
	  SELECT csi_facturas_emitidas.n_fact,   
         csi_facturas_emitidas.nif,   
         csi_facturas_emitidas.nombre,   
         csi_facturas_emitidas.base_imp,   
         csi_facturas_emitidas.iva,   
         csi_facturas_emitidas.total,   
         csi_facturas_emitidas.id_fase  
    INTO :as_n_fact_obtenido,   
         :as_nif,   
         :as_nombre,   
         :adb_base_imp,   
         :adb_iva,   
         :adb_total,   
         :as_id_fase  
    FROM csi_facturas_emitidas  
   WHERE csi_facturas_emitidas.n_fact = :as_n_fact   ;
	
	//Buscar el Nro. Aviso en fases_minutas
	  SELECT fases_minutas.n_aviso  
    INTO :as_aviso  
    FROM fases_minutas  
   WHERE fases_minutas.id_minuta = :as_id_fase   ;

	ab_existe = TRUE
else
	ab_existe = false
end if

end subroutine

public subroutine wf_actualiza_cobros_facturas_adic (string id_pago, string as_id_factura, string n_fact, string id_cobro_multiple, datetime f_pago);  UPDATE csi_cobros  
     SET forma_pago = 'CM',   
         importe = 0,   
		pagado ='S',
		f_pago = :f_pago,
         id_cobro_multiple = :id_cobro_multiple  
   WHERE ( csi_cobros.id_pago = :id_pago ) AND  
         ( csi_cobros.id_factura = :as_id_factura ) ;

  UPDATE csi_facturas_emitidas  
     SET formadepago = 'CM',   
         pagado = 'S',
		f_pago = :f_pago
   WHERE ( csi_facturas_emitidas.id_factura = :as_id_factura ) AND  
         ( csi_facturas_emitidas.n_fact = :n_fact )  ;
			  
commit;		  
end subroutine

public subroutine wf_actualiza_borrar_factura (string id_pago, string as_id_factura, string n_fact, double total_factura);datetime   ldt_fecha
string       ls_id_cobro_multiple
  
setnull(ldt_fecha)
setnull(ls_id_cobro_multiple)

  UPDATE csi_cobros  
     SET forma_pago = 'PE',   
         importe = :total_factura,   
		pagado ='N',
		f_pago = :ldt_fecha,
         id_cobro_multiple = :ls_id_cobro_multiple  
   WHERE ( csi_cobros.id_pago = :id_pago ) AND  
         ( csi_cobros.id_factura = :as_id_factura ) ;

  UPDATE csi_facturas_emitidas  
     SET formadepago = 'PE',   
         pagado = 'N',
		f_pago = :ldt_fecha
   WHERE ( csi_facturas_emitidas.id_factura = :as_id_factura ) AND  
         ( csi_facturas_emitidas.n_fact = :n_fact )  ;
			  
commit;		  
end subroutine

public subroutine wf_actualiza_cobros_facturas (string id_pago, string as_id_factura, string n_fact, string id_cobro_multiple);  UPDATE csi_cobros  
     SET forma_pago = 'CM',   
         importe = 0,   
         id_cobro_multiple = :id_cobro_multiple  
   WHERE ( csi_cobros.id_pago = :id_pago ) AND  
         ( csi_cobros.id_factura = :id_factura ) ;

  UPDATE csi_facturas_emitidas  
     SET formadepago = 'CM',   
         pagado = 'S'   
   WHERE ( csi_facturas_emitidas.id_factura = :as_id_factura ) AND  
         ( csi_facturas_emitidas.n_fact = :n_fact )  ;
			  
commit;		  
end subroutine

on w_cobros_multiiples_response.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_anadir=create cb_anadir
this.dw_2=create dw_2
this.cb_borrar=create cb_borrar
this.cb_cerrar=create cb_cerrar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_anadir
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_borrar
this.Control[iCurrent+5]=this.cb_cerrar
end on

on w_cobros_multiiples_response.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_anadir)
destroy(this.dw_2)
destroy(this.cb_borrar)
destroy(this.cb_cerrar)
end on

event open;call super::open;st_busqueda_facturas  lst_datos

lst_datos = message.powerobjectparm
id_factura = lst_datos.id_cobro_multiple // id_factura

f_centrar_ventana(this)
dw_1.SetTransObject(SQLCA)
dw_1.retrieve(id_factura)

dw_2.SetTransObject(SQLCA)
dw_2.retrieve(id_factura)


cb_borrar.enabled = false


if (lst_datos.cobro_contabilizado ='N' or lst_datos.cobro_contabilizado ="")  and (lst_datos.fact_contabilizada ='N' or lst_datos.fact_contabilizada ="") then
	cb_anadir.enabled = true
else
	cb_anadir.enabled = false
end if
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_cobros_multiiples_response
integer x = 489
integer y = 1008
integer taborder = 30
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_cobros_multiiples_response
end type

type dw_1 from u_csd_dw within w_cobros_multiiples_response
integer x = 50
integer y = 372
integer width = 3099
integer height = 1064
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_cobros_fmultiples_detalle"
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event clicked;//no hereda
string  ls_fac_contabilizada, ls_cobro_contabilizado

If row > 0 Then
	This.selectrow(0,False)
	This.selectrow(row,True)

	if this.isselected(row) then
		ls_fac_contabilizada = dw_1.getitemstring(row,"csi_facturas_emitidas_contabilizada")
		ls_cobro_contabilizado = dw_1.getitemstring(row,"csi_cobros_contabilizado")
		if ls_fac_contabilizada = 'N' and ls_cobro_contabilizado='N' then
			cb_borrar.enabled = true
		else
			cb_borrar.enabled = false
		end if
	else
		cb_borrar.enabled = false
	end if

else
	return
End If



end event

type cb_anadir from commandbutton within w_cobros_multiiples_response
integer x = 55
integer y = 1456
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;st_busqueda_facturas    lst_datos
long   ll_new_fila
string  ls_id_cobro_multiple
datetime ldt_fecha_pago
double    ldb_importe

g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda de Facturas"
g_busqueda.dw="d_busqueda_facturas_lista"
open(w_busqueda_facturas)

lst_datos = message.powerobjectparm

ls_id_cobro_multiple = dw_2.getitemstring(dw_2.getrow(),"csi_cobros_multiples_id_cobro_multiple")

//if not isnull(lst_datos) then
IF IsValid(lst_datos) = FALSE THEN return
	
	if lst_datos.solo_actualiza_tablas = true and lst_datos.agregar_datos = 'Si' then
		wf_actualiza_cobros_facturas(lst_datos.id_pago,lst_datos.id_factura,lst_datos.n_fact,ls_id_cobro_multiple)
		dw_1.retrieve(id_factura)
		
		ldb_importe =  dw_1.getitemnumber(1,"total_facturas")
		dw_2.setitem(1,"csi_cobros_multiples_importe", ldb_importe)
		
	end if
	
	if  lst_datos.solo_actualiza_tablas = false and lst_datos.agregar_datos = 'Si' then
		ll_new_fila = dw_1.insertrow(0)
		
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_n_fact",lst_datos.n_fact)
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_nif",lst_datos.nif)
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_nombre",lst_datos.nombre)
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_base_imp",lst_datos.base_imp)
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_iva",lst_datos.iva)
		dw_1.setitem(ll_new_fila,"csi_facturas_emitidas_total",lst_datos.total)
		dw_1.setitem(ll_new_fila,"csi_cobros_id_factura",lst_datos.id_factura)
		dw_1.setitem(ll_new_fila,"fases_minutas_n_aviso",lst_datos.n_aviso)	
		
		ldt_fecha_pago = dw_2.getitemdatetime(dw_2.getrow(),"csi_cobros_multiples_fecha")

		wf_actualiza_cobros_facturas_adic(lst_datos.id_pago,lst_datos.id_factura,lst_datos.n_fact,ls_id_cobro_multiple, ldt_fecha_pago)
		
		ldb_importe =  dw_1.getitemnumber(1,"total_facturas")
		dw_2.setitem(1,"csi_cobros_multiples_importe", ldb_importe)
	end if

//end if
end event

type dw_2 from u_csd_dw within w_cobros_multiiples_response
integer x = 50
integer y = 28
integer width = 3099
integer height = 344
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cobros_fmultiples_lista_encabezado"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;double  ldb_total_facturas, ldb_importe

if dwo.name = "csi_cobros_multiples_importe" then
	ldb_total_facturas = dw_1.getitemnumber(1,"total_facturas")
	ldb_importe = double(data)
	
	if ldb_importe <> ldb_total_facturas then
		 Messagebox(g_titulo,'Existe Dieferencia entre el Importe y el Total del Detalle.',Information!)
	end if
end if
end event

type cb_borrar from commandbutton within w_cobros_multiiples_response
integer x = 507
integer y = 1456
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Borrar"
end type

event clicked;string  ls_fac_contabilizada, ls_cobro_contabilizado, ls_id_pago, ls_id_factura, ls_n_fact
double ldb_total_fact, ldb_importe

if dw_1.rowcount() > 0 then
	if dw_1.isselected(dw_1.getrow()) then
		if   Messagebox(g_titulo,'Va a borrar la factura del Cobro Compuesto y quedar$$HEX2$$e1002000$$ENDHEX$$como no cobrada, Est$$HEX2$$e1002000$$ENDHEX$$seguro..?',Question!, YesNo!)= 1 then
			ls_id_pago    = dw_1.getitemstring(dw_1.getrow(),"id_pago")
			ls_id_factura = dw_1.getitemstring(dw_1.getrow(),"csi_cobros_id_factura")
			ls_n_fact       = dw_1.getitemstring(dw_1.getrow(),"csi_facturas_emitidas_n_fact")
			ldb_total_fact = dw_1.getitemnumber(dw_1.getrow(),"csi_facturas_emitidas_total")
			
			wf_actualiza_borrar_factura(ls_id_pago,ls_id_factura, ls_n_fact,ldb_total_fact )
			dw_1.retrieve(id_factura)
			
			ldb_importe =  dw_1.getitemnumber(1,"total_facturas")
			dw_2.setitem(1,"csi_cobros_multiples_importe", ldb_importe)
			
		end if
	end if
end if


end event

type cb_cerrar from commandbutton within w_cobros_multiiples_response
integer x = 2752
integer y = 1456
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cerrar"
end type

event clicked;closewithreturn(parent,"Cerr$$HEX1$$f300$$ENDHEX$$")
end event

