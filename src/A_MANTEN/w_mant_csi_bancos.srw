HA$PBExportHeader$w_mant_csi_bancos.srw
$PBExportComments$domicilio,cliente,fases,registrosE/S,arquitectos, expedientes, formacion
forward
global type w_mant_csi_bancos from w_mant_simple
end type
type dw_busqueda from u_dw within w_mant_csi_bancos
end type
type dw_temporal from u_dw within w_mant_csi_bancos
end type
end forward

global type w_mant_csi_bancos from w_mant_simple
integer x = 214
integer y = 221
integer width = 3909
integer height = 1948
string title = "Mantenimiento de Bancos"
dw_busqueda dw_busqueda
dw_temporal dw_temporal
end type
global w_mant_csi_bancos w_mant_csi_bancos

type variables
string i_sql_nuevo

end variables

on w_mant_csi_bancos.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.dw_temporal=create dw_temporal
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.dw_temporal
end on

on w_mant_csi_bancos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_busqueda)
destroy(this.dw_temporal)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje, ls_codigo,cadenas[], ls_bic, ls_cuenta_cc,ls_cuenta_iban
int  res, retorno=1
long fila

boolean lb_bics_correctas, lb_cuentas_correctas

mensaje += f_valida(dw_1,'codigo','NOVACIO','Debe especificar un valor en el campo C$$HEX1$$f300$$ENDHEX$$digo.'+cr)
mensaje += f_valida(dw_1,'nombre', 'NOVACIO','Debe especificar un valor en el campo Nombre.'+cr)
mensaje += f_valida(dw_1,'cuenta_contable', 'NOVACIO','Debe especificar un valor en el campo Cuenta Contable.'+cr)
//mensaje += f_valida(dw_1,'bic', 'NOVACIO','Debe especificar un valor en el campo BIC.'+cr)
//mensaje += f_valida(dw_1,'cuenta_bancaria_iban', 'NOVACIO','Debe especificar un valor en el campo IBAN que se corresponde con la Cuenta Bancaria.'+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas


lb_bics_correctas = true
lb_cuentas_correctas = true

For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 

		ls_cuenta_iban = dw_1.GetItemString(fila, 'cuenta_bancaria_iban')
		if not f_es_vacio(ls_cuenta_iban) and lb_cuentas_correctas then			
			if not gnv_control_cuentas_bancarias.of_comprobar_iban(ls_cuenta_iban) then lb_cuentas_correctas = false
		end if	
		
		ls_bic = dw_1.GetItemString(fila, 'bic')
		if not f_es_vacio(ls_bic) and lb_bics_correctas then	
				if not gnv_control_cuentas_bancarias.of_comprobar_bic(ls_bic) then lb_bics_correctas = false
		end if	
		
		res = f_busca_duplicados_colum_dw (dw_1, 'codigo', fila)
		cadenas[1] = string(fila) 
		cadenas[2]= string(res)
		if res > 0 then mensaje += g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
				
	END IF
next

if lb_cuentas_correctas = false then messagebox(g_titulo, "Revise las cuentas introducidas en el campo IBAN. Alguna cuenta no es v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
if lb_bics_correctas = false then messagebox(g_titulo, "Revise los c$$HEX1$$f300$$ENDHEX$$digos BIC introducidos. Alg$$HEX1$$fa00$$ENDHEX$$n dato no dispone de un formato v$$HEX1$$e100$$ENDHEX$$lido", Exclamation!)

if mensaje<>'' then
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event open;call super::open;string ls_sql_old='',ls_sql_nuevo=''
dw_busqueda.SetTransObject(SQLCA)
dw_busqueda.insertrow(0)	

dw_busqueda.setitem(1, 'empresa', g_empresa)



end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_mant_csi_bancos
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_mant_csi_bancos
end type

type dw_1 from w_mant_simple`dw_1 within w_mant_csi_bancos
integer x = 37
integer y = 288
integer width = 3776
integer height = 1292
string dataobject = "d_mant_bancos"
boolean controlmenu = true
boolean ib_rmbmenu = false
end type

event dw_1::pfc_predeleterow;// return
//    0 previene el borrado
//    1 suprime el registro
//   -1 error

//Andr$$HEX1$$e900$$ENDHEX$$s: Borrado. Me parece que no hay que hacer ninguna comprobaci$$HEX1$$f300$$ENDHEX$$n antes de borrar una calle del callejero
//Si hay que comprobar algo siempre se puede copiar el proceso de w_poblaciones

// Si no hay filas para borrar detengo el proceso de borrado
if dw_1.RowCount() = 0 Then return 0


return 1 //continuamos con el borrado del registro

end event

event dw_1::itemchanged;call super::itemchanged;boolean comprueba_cuenta
string cuenta_iban

comprueba_cuenta = true

IF dwo.name = 'cuenta_bancaria_iban' THEN
	cuenta_iban = data
ELSE
	cuenta_iban = this.getitemstring(this.getrow(),'cuenta_bancaria_iban')
END IF

if not f_es_vacio(cuenta_iban) then
	comprueba_cuenta = gnv_control_cuentas_bancarias.of_comprobar_iban(cuenta_iban)								
end if

if comprueba_cuenta = false then
	this.setitem(row, 'cuenta_correcta', 0)
else
	this.setitem(row, 'cuenta_correcta', 1)
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;string ls_iban

ls_iban = this.getitemstring( row, 'Cuenta_Bancaria_Iban')

openwithparm(w_comprobacion_cuentas_bancarias, ls_iban )

ls_iban = message.stringparm

if not f_es_vacio(ls_iban) then
	this.setitem(row, 'Cuenta_Bancaria_Iban', ls_iban)	
	this.setitem(row, 'cuenta_correcta', 1)
end if
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//string ls_iban
//
//
//
//if dwo.name = 'cuenta_bancaria_iban' then
//		
//	ls_iban = this.getitemstring( row, 'cuenta_bancaria_iban')
//	
//	if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
//		this.setitem(row, 'cuenta_correcta', 1)	
//	else
//		this.setitem(row, 'cuenta_correcta', 0)	
//	end if		
//end if		
//
end event

event dw_1::losefocus;call super::losefocus;//string ls_iban
//
//this.accepttext()
//
//if this.getcolumnname( ) = 'cuenta_bancaria_iban' then
//	ls_iban = this.getitemstring( this.getrow(), 'cuenta_bancaria_iban')
//	
//	if control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
//		this.setitem(this.getrow(), 'cuenta_correcta', 1)	
//	else
//		this.setitem(this.getrow(), 'cuenta_correcta', 0)	
//	end if		
//
//end if
end event

event dw_1::retrieveend;call super::retrieveend;	string ls_iban
	int i 

if this.rowcount() > 0 then 
	
	for i=1 to this.rowcount()
		
		ls_iban = this.getitemstring( i, 'cuenta_bancaria_iban')
			
		if gnv_control_cuentas_bancarias.of_comprobar_iban(ls_iban) or f_es_vacio(ls_iban) then 
			this.setitem(i, 'cuenta_correcta', 1)	
		else
			this.setitem(i, 'cuenta_correcta', 0)	
		end if		
		this.SetItemStatus(i, 0, Primary!, NotModified!)
	next 
	
end if
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_mant_csi_bancos
integer y = 1604
end type

event cb_anyadir::clicked;
long ll_filanueva

ll_filanueva=dw_1.event pfc_addrow()

dw_1.setitem(ll_filanueva,"empresa", g_empresa)


end event

type cb_borrar from w_mant_simple`cb_borrar within w_mant_csi_bancos
integer y = 1604
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_mant_csi_bancos
integer y = 1604
end type

type dw_busqueda from u_dw within w_mant_csi_bancos
integer x = 37
integer y = 32
integer width = 3621
integer height = 224
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_csi_bancos_busqueda"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event buttonclicked;call super::buttonclicked;string ls_sql_old='',ls_sql_nuevo='', ls_nombre

this.accepttext()
dw_1.setfilter(" empresa like '" +dw_busqueda.getitemstring(dw_busqueda.getrow(),'empresa')+"%' " )
dw_1.filter()
if not f_es_vacio(dw_busqueda.getitemstring(dw_busqueda.getrow(),'nombre')) then
dw_1.setfilter("nombre like '"+dw_busqueda.getitemstring(dw_busqueda.getrow(),'nombre')+"%'  " )
end if
dw_1.filter()
	
// Restauramos la sql original
dw_1.setfilter("")
end event

type dw_temporal from u_dw within w_mant_csi_bancos
boolean visible = false
integer x = 2345
integer y = 548
integer taborder = 11
boolean bringtotop = true
end type

