HA$PBExportHeader$w_proceso_conversion_cuentas_bancarias.srw
forward
global type w_proceso_conversion_cuentas_bancarias from w_mant
end type
type cb_actualizar from u_cb within w_proceso_conversion_cuentas_bancarias
end type
type cb_cancelar from u_cb within w_proceso_conversion_cuentas_bancarias
end type
type sle_log from singlelineedit within w_proceso_conversion_cuentas_bancarias
end type
type mle_1 from multilineedit within w_proceso_conversion_cuentas_bancarias
end type
type cbx_calcula_iban from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_asignar_bic from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_bancos_propios from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_remesables from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_general_domiciliables from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_individuales_domiciliables from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_cuentas_personales from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type cbx_clientes from checkbox within w_proceso_conversion_cuentas_bancarias
end type
type gb_apartados from groupbox within w_proceso_conversion_cuentas_bancarias
end type
type gb_datos_actualizar from groupbox within w_proceso_conversion_cuentas_bancarias
end type
end forward

global type w_proceso_conversion_cuentas_bancarias from w_mant
integer width = 2816
integer height = 1660
cb_actualizar cb_actualizar
cb_cancelar cb_cancelar
sle_log sle_log
mle_1 mle_1
cbx_calcula_iban cbx_calcula_iban
cbx_asignar_bic cbx_asignar_bic
cbx_bancos_propios cbx_bancos_propios
cbx_remesables cbx_remesables
cbx_general_domiciliables cbx_general_domiciliables
cbx_individuales_domiciliables cbx_individuales_domiciliables
cbx_cuentas_personales cbx_cuentas_personales
cbx_clientes cbx_clientes
gb_apartados gb_apartados
gb_datos_actualizar gb_datos_actualizar
end type
global w_proceso_conversion_cuentas_bancarias w_proceso_conversion_cuentas_bancarias

type variables
string is_dir_aplicacion, is_archivo, is_ruta
end variables

forward prototypes
public function string wf_obtener_bic_por_defecto (string as_entidad)
end prototypes

public function string wf_obtener_bic_por_defecto (string as_entidad);string ls_bic

select csi_bancos_maestro_bic.codigo_bic into :ls_bic
from csi_bancos_maestro_bic, csi_bancos_maestro
where csi_bancos_maestro_bic.codigo_entidad =  csi_bancos_maestro.id
and csi_bancos_maestro.cod = :as_entidad and  csi_bancos_maestro.pais = 'ES' and csi_bancos_maestro_bic.codigo_por_defecto = 'S';

return ls_bic
end function

on w_proceso_conversion_cuentas_bancarias.create
int iCurrent
call super::create
this.cb_actualizar=create cb_actualizar
this.cb_cancelar=create cb_cancelar
this.sle_log=create sle_log
this.mle_1=create mle_1
this.cbx_calcula_iban=create cbx_calcula_iban
this.cbx_asignar_bic=create cbx_asignar_bic
this.cbx_bancos_propios=create cbx_bancos_propios
this.cbx_remesables=create cbx_remesables
this.cbx_general_domiciliables=create cbx_general_domiciliables
this.cbx_individuales_domiciliables=create cbx_individuales_domiciliables
this.cbx_cuentas_personales=create cbx_cuentas_personales
this.cbx_clientes=create cbx_clientes
this.gb_apartados=create gb_apartados
this.gb_datos_actualizar=create gb_datos_actualizar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_actualizar
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.sle_log
this.Control[iCurrent+4]=this.mle_1
this.Control[iCurrent+5]=this.cbx_calcula_iban
this.Control[iCurrent+6]=this.cbx_asignar_bic
this.Control[iCurrent+7]=this.cbx_bancos_propios
this.Control[iCurrent+8]=this.cbx_remesables
this.Control[iCurrent+9]=this.cbx_general_domiciliables
this.Control[iCurrent+10]=this.cbx_individuales_domiciliables
this.Control[iCurrent+11]=this.cbx_cuentas_personales
this.Control[iCurrent+12]=this.cbx_clientes
this.Control[iCurrent+13]=this.gb_apartados
this.Control[iCurrent+14]=this.gb_datos_actualizar
end on

on w_proceso_conversion_cuentas_bancarias.destroy
call super::destroy
destroy(this.cb_actualizar)
destroy(this.cb_cancelar)
destroy(this.sle_log)
destroy(this.mle_1)
destroy(this.cbx_calcula_iban)
destroy(this.cbx_asignar_bic)
destroy(this.cbx_bancos_propios)
destroy(this.cbx_remesables)
destroy(this.cbx_general_domiciliables)
destroy(this.cbx_individuales_domiciliables)
destroy(this.cbx_cuentas_personales)
destroy(this.cbx_clientes)
destroy(this.gb_apartados)
destroy(this.gb_datos_actualizar)
end on

event open;call super::open;if (f_var_global_sn('g_proceso_conversion_cuentas_realizado') = 'N') then 
	cb_actualizar.enabled = true
else
	messagebox(g_titulo, "El proceso de actualizaci$$HEX1$$f300$$ENDHEX$$n de cuentas bancarias ya fue lanzado con anterioridad." + CR + " Si requiere volver a lanzarlo, p$$HEX1$$f300$$ENDHEX$$ngase en contacto con el administrador de la aplicaci$$HEX1$$f300$$ENDHEX$$n.")
	close(this)
end if


end event

event pfc_postopen;call super::pfc_postopen;if (g_colegio = 'COAATA') then 
	this.cbx_cuentas_personales.visible=true
else 	
	this.cbx_cuentas_personales.checked = false
end if	
end event

type cb_recuperar_pantalla from w_mant`cb_recuperar_pantalla within w_proceso_conversion_cuentas_bancarias
integer x = 73
integer y = 1680
end type

type cb_guardar_pantalla from w_mant`cb_guardar_pantalla within w_proceso_conversion_cuentas_bancarias
integer x = 73
integer y = 1560
end type

type dw_1 from w_mant`dw_1 within w_proceso_conversion_cuentas_bancarias
boolean visible = false
integer x = 1024
integer y = 1388
integer width = 649
integer height = 100
integer taborder = 0
string dataobject = "d_mant_bancos"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

type cb_anyadir from w_mant`cb_anyadir within w_proceso_conversion_cuentas_bancarias
boolean visible = false
integer x = 64
integer y = 1600
integer taborder = 0
end type

type cb_borrar from w_mant`cb_borrar within w_proceso_conversion_cuentas_bancarias
boolean visible = false
integer x = 361
integer y = 1600
integer taborder = 0
end type

type cb_ayuda from w_mant`cb_ayuda within w_proceso_conversion_cuentas_bancarias
boolean visible = false
integer x = 759
integer y = 1600
integer taborder = 0
end type

type cb_actualizar from u_cb within w_proceso_conversion_cuentas_bancarias
integer x = 1961
integer y = 1392
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
string text = "Actualizar"
end type

event clicked;call super::clicked;int li_count, i, li_count_erroneos, fichero
string ls_cc, ls_iban, ls_dir_aplicacion, ls_temporal, ls_linea, ls_entidad, ls_sentencia, ls_sentencia2, ls_sucursal_banco, ls_dc_banco, ls_cuenta_banco
datastore ds_datos_colegiados, ds_datos_bancos, ds_datos_clientes

n_cst_filesrvwin32 file

pointer oldpointer
oldpointer = setpointer(hourglass!)

file = create n_cst_filesrvwin32
ls_dir_aplicacion = file.of_getcurrentdirectory()
ls_temporal = ls_dir_aplicacion + "\log_sepa.txt"

cb_cancelar.enabled = false
cb_actualizar.enabled = false

if (cbx_bancos_propios.checked = true) then

	ds_datos_bancos=create datastore
	ds_datos_bancos.DataObject='d_mant_bancos'
	ds_datos_bancos.SetTransObject(SQLCA)
	
	ds_datos_bancos.Object.DataWindow.Table.Filter = ''
	
	ds_datos_bancos.retrieve()
	
	//BANCOS
	
	li_count = ds_datos_bancos.rowcount()
	li_count_erroneos = 0
	
	if li_count > 0 then 
		mle_1.text = "Se va a proceder a actualizar un total de " + string(li_count) + " bancos propios. ~r~n"
		
		sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"
		
		for i = 1 to li_count 
			setnull(ls_cc)
			setnull(ls_iban)
			ls_entidad = trim(ds_datos_bancos.getitemstring(i, 'entidad'))
			ls_sucursal_banco = trim(ds_datos_bancos.getitemstring(i, 'sucursal'))    
			ls_dc_banco = trim(ds_datos_bancos.getitemstring(i, 'cod_seg'))
			ls_cuenta_banco = trim(ds_datos_bancos.getitemstring(i, 'cuenta_banco'))
			if f_es_vacio (ls_entidad) then ls_entidad = ''
			if f_es_vacio (ls_sucursal_banco) then ls_sucursal_banco = ''
			if f_es_vacio (ls_dc_banco) then ls_dc_banco = ''
			if f_es_vacio (ls_cuenta_banco) then ls_cuenta_banco = ''
															
			ls_cc = ls_entidad + ls_sucursal_banco + ls_dc_banco + ls_cuenta_banco
			
			ls_iban =gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
			
			if not f_es_vacio(ls_iban) then 
				
				if (cbx_calcula_iban.checked = true) then ds_datos_bancos.setitem(i, 'cuenta_bancaria_iban', ls_iban + ls_cc)
				if (cbx_asignar_bic.checked = true) then ds_datos_bancos.setitem(i, 'bic', wf_obtener_bic_por_defecto(ls_entidad) )
				
			else 
				if not  f_es_vacio(ls_cc) then 
					li_count_erroneos ++
					if (li_count_erroneos = 1) then 
						if f_es_vacio(string(fichero)) or (fichero = 0) then 
							fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
						end if	
						FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de bancos propios')
						FileWrite(fichero, '-----------------------------------------------------')
					end if	
					
					ls_linea = "revise las cuentas del banco " + trim(ds_datos_bancos.getitemstring(i, 'nombre'))
					FileWrite(fichero, ls_linea)
				end if	
			end if 	
			
			sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
		next	
		
		ds_datos_bancos.update( )
		
		
		mle_1.text = mle_1.text + "Actualizados un total de " + string(i -1 - li_count_erroneos) + " bancos propios. ~r~n"
		if li_count_erroneos > 0 then 
		
			mle_1.text = mle_1.text + "Las cuentas de algunos bancos propios no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
			FileWrite(fichero, '-----------------------------------------------------')
			FileWrite(fichero, '')
			FileWrite(fichero, '')
		
			mle_1.text = mle_1.text +"Revise el fichero de log:" + ls_temporal + " ~r~n"
		end if	
	end if
	
	destroy ds_datos_bancos

end if

// COLEGIADOS - Conceptos Remesables

if (cbx_remesables.checked = true) then
	
	ds_datos_colegiados=create datastore
	ds_datos_colegiados.DataObject = 'd_colegiados_conceptos_remesables'
	ds_datos_colegiados.SetTransObject(SQLCA)
	
	ls_sentencia = ds_datos_colegiados.Describe("DataWindow.Table.Select")
	
	ls_sentencia = MidA(ls_sentencia, 1, Pos(ls_sentencia, 'WHERE') - 1)
	
	ds_datos_colegiados.Modify("DataWindow.Table.Select= ~"" + ls_sentencia + "~"")
	ds_datos_colegiados.retrieve( '')
	
	ls_sentencia2 = ds_datos_colegiados.Describe("DataWindow.Table.Select")
	
	li_count = ds_datos_colegiados.rowcount()
	li_count_erroneos = 0

	if li_count > 0 then 
		
		mle_1.text = mle_1.text + "Se va a proceder a actualizar los datos bancarios de los conceptos remesables de un total de " + string(li_count) + " colegiados. ~r~n"
	
		sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"
	
		for i = 1 to li_count 
			setnull(ls_cc)
			setnull(ls_iban)
		
			ls_cc =  trim(ds_datos_colegiados.getitemstring(i, 'datos_bancarios'))
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
			ls_entidad = gnv_control_cuentas_bancarias.of_obtener_entidad_iban_es(ls_iban + ls_cc)
			
		
			if not f_es_vacio(ls_iban)  then 
				if (cbx_calcula_iban.checked = true) then ds_datos_colegiados.setitem(i, 'datos_bancarios_iban', ls_iban + ls_cc)
				if (cbx_asignar_bic.checked = true) then ds_datos_colegiados.setitem(i, 'bic', wf_obtener_bic_por_defecto(ls_entidad) )
			else	
				li_count_erroneos ++
				
				if (li_count_erroneos = 1) then 
					if f_es_vacio(string(fichero)) or (fichero = 0) then 
						fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
					end if	
					FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de la cuenta bancaria de los conceptos remesables de los colegiados. ')
					FileWrite(fichero, '-----------------------------------------------------')
				end if	
				
				ls_linea = "La cuenta bancaria de los conceptos remesables del colegiado " + f_colegiado_n_col(trim(ds_datos_colegiados.getitemstring(i, 'id_colegiado')))  + " es incorrecta. "  
	
				if f_es_vacio(ls_cc) then 
					ls_linea = ls_linea + " No se dispon$$HEX1$$ed00$$ENDHEX$$a de cuenta bancaria"   
				else 	
					ls_linea = ls_linea + " La cuenta que se dispon$$HEX1$$ed00$$ENDHEX$$a era: " + ls_cc   
				end if
				
				FileWrite(fichero, ls_linea)
				
			end if	
		
			sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
		next	
		
		ds_datos_colegiados.update( )
		
	
		mle_1.text = mle_1.text + "Revisados un total de" + string(i - 1) + " cuentas. ~r~n"
		if li_count_erroneos > 0 then 
	
			mle_1.text = mle_1.text + "Algunos datos bancarios de los conceptos remesables de los colegiados no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
			FileWrite(fichero, '-----------------------------------------------------')
			FileWrite(fichero, '')
			FileWrite(fichero, '')
			mle_1.text = mle_1.text + "Revise el fichero de log: " + ls_temporal + " ~r~n"
		end if	
	end if 

	destroy ds_datos_colegiados
end if	


// COLEGIADOS - Conceptos Domiciliables - Cuenta general. 

if (cbx_general_domiciliables.checked = true) then
	
	ds_datos_colegiados=create datastore
	ds_datos_colegiados.DataObject = 'd_colegiados_banco_cuenta_domic'
	ds_datos_colegiados.SetTransObject(SQLCA)
	
	ls_sentencia = ds_datos_colegiados.Describe("DataWindow.Table.Select")
	ls_sentencia = MidA(ls_sentencia, 1, Pos(ls_sentencia, 'WHERE') -1)
	
	ds_datos_colegiados.Modify("DataWindow.Table.Select= ~"" + ls_sentencia + "~"")
	ds_datos_colegiados.retrieve('' )

	ls_sentencia2 = ds_datos_colegiados.Describe("DataWindow.Table.Select")

	li_count = ds_datos_colegiados.rowcount()
	li_count_erroneos = 0

	if li_count > 0 then 
	
		mle_1.text = mle_1.text + "Se va a proceder a actualizar la cuenta bancaria gen$$HEX1$$e900$$ENDHEX$$rica de los conceptos domiciliables de un total de " + string(li_count) + " colegiados. ~r~n"
	
		sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"
	
		for i = 1 to li_count 
			setnull(ls_cc)
			setnull(ls_iban)
		
			ls_cc =  trim(ds_datos_colegiados.getitemstring(i, 'cuenta_domic'))
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
			ls_entidad = gnv_control_cuentas_bancarias.of_obtener_entidad_iban_es(ls_iban + ls_cc)
			
		
			if not f_es_vacio(ls_iban)  then 
				if (cbx_calcula_iban.checked = true) then ds_datos_colegiados.setitem(i, 'datos_bancarios_iban', ls_iban + ls_cc)
				if (cbx_asignar_bic.checked = true) then ds_datos_colegiados.setitem(i, 'bic', wf_obtener_bic_por_defecto(ls_entidad) )
			else	
				li_count_erroneos ++
				
				if (li_count_erroneos = 1) then 
					if f_es_vacio(string(fichero)) or (fichero = 0) then
						fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
					end if
					FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de la cuenta gen$$HEX1$$e900$$ENDHEX$$rica de los conceptos domiciliables de los colegiados. ')
					FileWrite(fichero, '-----------------------------------------------------')
				end if	
			
				ls_linea = "La cuenta bancaria gen$$HEX1$$e900$$ENDHEX$$rica de los conceptos domiciliables del colegiado " + f_colegiado_n_col(trim(ds_datos_colegiados.getitemstring(i, 'id_colegiado')))  + " es incorrecta. "  
	
				if f_es_vacio(ls_cc) then 
					ls_linea = ls_linea + " No se dispon$$HEX1$$ed00$$ENDHEX$$a de cuenta bancaria"   
				else 	
					ls_linea = ls_linea + " La cuenta que se dispon$$HEX1$$ed00$$ENDHEX$$a era: " + ls_cc   
				end if
	
				FileWrite(fichero, ls_linea)
	
			end if	
		
			sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
		next	
		
		ds_datos_colegiados.update( )
		
	
		mle_1.text = mle_1.text + "Revisados un total de" + string(i - 1) + "  cuentas. ~r~n"
		if li_count_erroneos > 0 then 
	
			mle_1.text = mle_1.text + "Algunas cuentas bancarias gen$$HEX1$$e900$$ENDHEX$$ricas de los conceptos domiciliables de los colegiados no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
			FileWrite(fichero, '-----------------------------------------------------')
			FileWrite(fichero, '')
			FileWrite(fichero, '')
			mle_1.text = mle_1.text + "Revise el fichero de log: " + ls_temporal + " ~r~n"
		end if	
	
	end if
	
	destroy ds_datos_colegiados
	
end if	

// COLEGIADOS - Conceptos Domiciliables - Cuentas individuales.  

if (cbx_individuales_domiciliables.checked = true) then
	
	ds_datos_colegiados=create datastore
	ds_datos_colegiados.DataObject = 'd_colegiados_conceptos_domiciliables'
	ds_datos_colegiados.SetTransObject(SQLCA)
	
	ls_sentencia = ds_datos_colegiados.Describe("DataWindow.Table.Select")
	ls_sentencia = MidA(ls_sentencia, 1, Pos(ls_sentencia, 'WHERE') - 1) + "where (datos_bancarios <> '' or datos_bancarios <> null) "

	ds_datos_colegiados.Modify("DataWindow.Table.Select= ~"" + ls_sentencia + "~"")
	ds_datos_colegiados.retrieve('' )

	li_count = ds_datos_colegiados.rowcount()
	li_count_erroneos = 0

	if li_count > 0 then 
		mle_1.text = mle_1.text + "Se va a proceder a actualizar un total de " + string(li_count) + " cuentas bancarias espec$$HEX1$$ed00$$ENDHEX$$ficas de los conceptos domiciliables de los colegiados. ~r~n"
	
		sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"
	
		for i = 1 to li_count 
			setnull(ls_cc)
			setnull(ls_iban)
		
			ls_cc =  trim(ds_datos_colegiados.getitemstring(i, 'datos_bancarios'))
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
			ls_entidad = gnv_control_cuentas_bancarias.of_obtener_entidad_iban_es(ls_iban + ls_cc)
			
		
			if not f_es_vacio(ls_iban)  then 
				if (cbx_calcula_iban.checked = true) then ds_datos_colegiados.setitem(i, 'datos_bancarios_iban', ls_iban + ls_cc)
				if (cbx_asignar_bic.checked = true) then ds_datos_colegiados.setitem(i, 'bic', wf_obtener_bic_por_defecto(ls_entidad) )
			else	
				if not f_es_vacio(ls_cc) then
					li_count_erroneos ++
					
					if (li_count_erroneos = 1) then 
						if f_es_vacio(string(fichero)) or (fichero = 0) then
							fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
						end if
						FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de las cuentas espec$$HEX1$$ed00$$ENDHEX$$ficas de los conceptos domiciliables de los colegiados. ')
						FileWrite(fichero, '-----------------------------------------------------')
					end if	
				
					ls_linea = "La cuenta bancaria del concepto domiciliable '" + f_devuelve_desc_concepto_empresa(trim(ds_datos_colegiados.getitemstring(i, 'concepto')), trim(ds_datos_colegiados.getitemstring(i, 'empresa'))) + "' del colegiado " + f_colegiado_n_col(trim(ds_datos_colegiados.getitemstring(i, 'id_colegiado')))  + " es incorrecta. "  
		
					ls_linea = ls_linea + " La cuenta que se dispon$$HEX1$$ed00$$ENDHEX$$a era: " + ls_cc   
			
					FileWrite(fichero, ls_linea)
				end if	
	
			end if	
		
			sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
		next	
		
		ds_datos_colegiados.update( )
		
	
		mle_1.text = mle_1.text + "Revisados un total de" + string(i - 1) + "  cuentas. ~r~n"
		if li_count_erroneos > 0 then 
	
			mle_1.text = mle_1.text + "Algunas cuentas bancarias espec$$HEX1$$ed00$$ENDHEX$$ficas de los conceptos domiciliables de los colegiados no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
			FileWrite(fichero, '-----------------------------------------------------')
			FileWrite(fichero, '')
			FileWrite(fichero, '')
			mle_1.text = mle_1.text + "Revise el fichero de log: " + ls_temporal + " ~r~n"
		end if	
	end if
	
	destroy ds_datos_colegiados
end if	


// COLEGIADOS - Cuentas Personales.  

if (cbx_cuentas_personales.checked = true) then
	
	ds_datos_colegiados=create datastore
	ds_datos_colegiados.DataObject = 'd_colegiados_cp'
	ds_datos_colegiados.SetTransObject(SQLCA)
	
	ls_sentencia = ds_datos_colegiados.Describe("DataWindow.Table.Select")
	ls_sentencia = MidA(ls_sentencia, 1, Pos(ls_sentencia, 'WHERE') - 1)  + "where (cuenta_bancaria_personal <> '' or cuenta_bancaria_personal <> null) "

	ds_datos_colegiados.Modify("DataWindow.Table.Select= ~"" + ls_sentencia + "~"")
	ds_datos_colegiados.retrieve('' )

	li_count = ds_datos_colegiados.rowcount()
	li_count_erroneos = 0
	
	if li_count > 0 then 
		mle_1.text = mle_1.text + "Se va a proceder a actualizar un total de " + string(li_count) + " cuentas personales de los colegiados. ~r~n"
	
		sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"
	
		for i = 1 to li_count 
			setnull(ls_cc)
			setnull(ls_iban)
		
			ls_cc =  trim(ds_datos_colegiados.getitemstring(i, 'cuenta_bancaria_personal'))
			ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
			ls_entidad = gnv_control_cuentas_bancarias.of_obtener_entidad_iban_es(ls_iban + ls_cc)
					
			if not f_es_vacio(ls_iban)  then 
				if (cbx_calcula_iban.checked = true) then ds_datos_colegiados.setitem(i, 'cuenta_personal_iban', ls_iban + ls_cc)
				if (cbx_asignar_bic.checked = true) then ds_datos_colegiados.setitem(i, 'cuenta_personal_bic', wf_obtener_bic_por_defecto(ls_entidad) )
			else	
				if not f_es_vacio(ls_cc) then
					li_count_erroneos ++
					
					if (li_count_erroneos = 1) then 
						if f_es_vacio(string(fichero)) or (fichero = 0) then 
							fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
						end if
						FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de las cuentas personales de los colegiados. ')
						FileWrite(fichero, '-----------------------------------------------------')
					end if	
				
					ls_linea = "La cuenta personal del colegiado " + f_colegiado_n_col(trim(ds_datos_colegiados.getitemstring(i, 'id_colegiado')))  + " es incorrecta. "  
		
					ls_linea = ls_linea + " La cuenta que se dispon$$HEX1$$ed00$$ENDHEX$$a era: " + ls_cc   
			
					FileWrite(fichero, ls_linea)
				end if	
	
			end if	
		
			sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
		next	
		
		ds_datos_colegiados.update( )
		
	
		mle_1.text = mle_1.text + "Revisados un total de" + string(i - 1) + "  cuentas. ~r~n"
		if li_count_erroneos > 0 then 
	
			mle_1.text = mle_1.text + "Algunas cuentas personales de los colegiados no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
			FileWrite(fichero, '-----------------------------------------------------')
			FileWrite(fichero, '')
			FileWrite(fichero, '')
			
			mle_1.text = mle_1.text + "Revise el fichero de log: " + ls_temporal + " ~r~n"
		end if	
	end if
	destroy ds_datos_colegiados
end if	


// CLientes - Cuentas bancarias de clientes.  

if (cbx_clientes.checked = true) then
	
	ds_datos_clientes=create datastore
	ds_datos_clientes.DataObject = 'd_clientes_detalle'
	ds_datos_clientes.SetTransObject(SQLCA)
	
	ls_sentencia = ds_datos_clientes.Describe("DataWindow.Table.Select")
	ls_sentencia = MidA(ls_sentencia, 1, Pos(ls_sentencia, 'WHERE') - 1) + "where (cuenta_bancaria <> '' or cuenta_bancaria <> null) "

	ds_datos_clientes.Modify("DataWindow.Table.Select= ~"" + ls_sentencia + "~"")
	ds_datos_clientes.retrieve('')

	li_count = ds_datos_clientes.rowcount()
	li_count_erroneos = 0

	
	mle_1.text = mle_1.text + "Se va a proceder a actualizar un total de " + string(li_count) + " cuentas bancarias de clientes. ~r~n"

	sle_log.text = "Actualizados 0 de "+ string(li_count) + " registros"

	for i = 1 to li_count 
		setnull(ls_cc)
		setnull(ls_iban)
	
		ls_cc =  trim(ds_datos_clientes.getitemstring(i, 'cuenta_bancaria'))
		ls_iban = gnv_control_cuentas_bancarias.of_obtener_iban( ls_cc, 'ES')
		ls_entidad = gnv_control_cuentas_bancarias.of_obtener_entidad_iban_es(ls_iban + ls_cc)
		
		if not f_es_vacio(ls_iban)  then 
			if (cbx_calcula_iban.checked = true) then ds_datos_clientes.setitem(i, 'datos_bancarios_iban', ls_iban + ls_cc)
			if (cbx_asignar_bic.checked = true) then ds_datos_clientes.setitem(i, 'bic', wf_obtener_bic_por_defecto(ls_entidad) )			
		else	
			if not f_es_vacio(ls_cc) then
				li_count_erroneos ++
				
				if (li_count_erroneos = 1) then 
					if f_es_vacio(string(fichero)) or (fichero = 0) then
						fichero = FileOpen(ls_temporal,LineMode!,Write!,LockWrite!,Replace!)
					end if
					FileWrite(fichero, ' Errores de la actualizaci$$HEX1$$f300$$ENDHEX$$n de las cuentas bancarias de clientes. ')
					FileWrite(fichero, '-----------------------------------------------------')
				end if	
			
				ls_linea = "La cuenta bancaria del cliente" + trim(ds_datos_clientes.getitemstring(i, 'nombre')) + " " + trim(ds_datos_clientes.getitemstring(i, 'apellidos')) + " es incorrecta. "  
	
				ls_linea = ls_linea + " La cuenta que se dispon$$HEX1$$ed00$$ENDHEX$$a era: " + ls_cc   
		
				FileWrite(fichero, ls_linea)
			end if	

		end if	
	
		sle_log.text = "Revisados " + string(i) +" de "+ string(li_count) + " registros"
	next	
	
	ds_datos_clientes.update( )
	

	mle_1.text = mle_1.text + "Revisados un total de" + string(i - 1) + "  cuentas. ~r~n"
	if li_count_erroneos > 0 then 

		mle_1.text = mle_1.text + "Algunas cuentas bancarias de clientes no se actualizaron correctamente, es posible que la cuenta no fuera v$$HEX1$$e100$$ENDHEX$$lida. ~r~n"
		FileWrite(fichero, '-----------------------------------------------------')
		FileWrite(fichero, '')
		FileWrite(fichero, '')

		mle_1.text = mle_1.text + "Revise el fichero de log: " + ls_temporal + " ~r~n"
	end if	
	
	destroy ds_datos_clientes
end if	



FileClose(fichero)	

update var_globales set sn = 'S' where nombre = 'g_proceso_conversion_cuentas_realizado';

cb_cancelar.text = "Cerrar"

setpointer(oldpointer)

destroy gnv_control_cuentas_bancarias
destroy file

cb_cancelar.enabled = true
end event

type cb_cancelar from u_cb within w_proceso_conversion_cuentas_bancarias
integer x = 2363
integer y = 1392
integer taborder = 20
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Cancelar"
end type

event clicked;call super::clicked;close(parent)
end event

type sle_log from singlelineedit within w_proceso_conversion_cuentas_bancarias
integer x = 64
integer y = 560
integer width = 2656
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type mle_1 from multilineedit within w_proceso_conversion_cuentas_bancarias
integer x = 64
integer y = 664
integer width = 2656
integer height = 664
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 100
borderstyle borderstyle = stylelowered!
end type

type cbx_calcula_iban from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 105
integer y = 100
integer width = 443
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calcular IBAN"
boolean checked = true
end type

type cbx_asignar_bic from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 850
integer y = 100
integer width = 530
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Asignar c$$HEX1$$f300$$ENDHEX$$digo BIC"
boolean checked = true
end type

type cbx_bancos_propios from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 105
integer y = 324
integer width = 443
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bancos Propios."
boolean checked = true
end type

type cbx_remesables from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 105
integer y = 412
integer width = 594
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Conceptos Remesables."
boolean checked = true
end type

type cbx_general_domiciliables from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 841
integer y = 324
integer width = 1029
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuenta General de Conceptos Domiciliables."
boolean checked = true
end type

type cbx_individuales_domiciliables from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 841
integer y = 412
integer width = 1134
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuentas individuales de Conceptos Domiciliables."
boolean checked = true
end type

type cbx_cuentas_personales from checkbox within w_proceso_conversion_cuentas_bancarias
boolean visible = false
integer x = 2098
integer y = 412
integer width = 553
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuentas Personales."
boolean checked = true
end type

type cbx_clientes from checkbox within w_proceso_conversion_cuentas_bancarias
integer x = 2098
integer y = 324
integer width = 553
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cuentas de Clientes."
boolean checked = true
end type

type gb_apartados from groupbox within w_proceso_conversion_cuentas_bancarias
integer x = 55
integer y = 256
integer width = 2656
integer height = 276
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Apartados"
end type

type gb_datos_actualizar from groupbox within w_proceso_conversion_cuentas_bancarias
integer x = 64
integer y = 36
integer width = 2656
integer height = 180
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Datos a Actualizar"
end type

