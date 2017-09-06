HA$PBExportHeader$w_ing_ret_lista.srw
forward
global type w_ing_ret_lista from w_lista
end type
end forward

global type w_ing_ret_lista from w_lista
integer width = 3584
integer height = 1328
string title = "Lista Ingresa/Retira"
string menuname = "m_lista_ing_ret"
event csd_imprimir_recibo ( )
event csd_imprimir_talon ( )
event csd_transferencias ( )
event csd_eliminar ( )
end type
global w_ing_ret_lista w_ing_ret_lista

event csd_imprimir_recibo();datastore ds_recibo
string tipo

// Cogemos el tipo de la linea a imprimir
tipo=dw_lista.getitemstring(dw_lista.getrow(),'tipo')

// Creamos un datastore para imprimir el recibo. Seg$$HEX1$$fa00$$ENDHEX$$n el tipo ser$$HEX2$$e1002000$$ENDHEX$$de una forma u otra
ds_recibo=create datastore
if (tipo='I') then 
	ds_recibo.dataobject=g_ing_ret_ingresa
else
	ds_recibo.dataobject=g_ing_ret_retira
end if
// Colocamos los valores 
ds_recibo.insertrow(1)
ds_recibo.setitem(1,'importen',dw_lista.getitemnumber(dw_lista.getrow(),'importe'))
ds_recibo.setitem(1,'id_col',dw_lista.getitemstring(dw_lista.getrow(),'id_colegiado'))
messagebox(g_titulo,'Se va a imprimir el recibo')
ds_recibo.print()

// Destruimos el datastore
destroy ds_recibo

end event

event csd_imprimir_talon();datastore ds_talon
string tipo, formadepago

tipo=dw_lista.getitemstring(dw_lista.getrow(),'tipo')
formadepago=dw_lista.getitemstring(dw_lista.getrow(),'forma_pago')

// Creamos un datastore para poder imprimir
// Actuamos seg$$HEX1$$fa00$$ENDHEX$$n la forma de pago y el tipo
if not ((tipo='R') and (formadepago='TA')) then
	messagebox(g_titulo,'No existe tal$$HEX1$$f300$$ENDHEX$$n')
	return
end if

// Creamos un datastore para imprimir el tal$$HEX1$$f300$$ENDHEX$$n
ds_talon=create datastore
ds_talon.dataobject=g_ing_ret_talon
ds_talon.SettransObject(SQLCA)
ds_talon.retrieve(dw_lista.getitemstring(dw_lista.getrow(),'id_traspaso'))

// Imprimimos
messagebox(g_titulo,'Se va a imprimir el tal$$HEX1$$f300$$ENDHEX$$n n$$HEX1$$ba00$$ENDHEX$$: '+dw_lista.getitemstring(dw_lista.getrow(),'n_talon'))
ds_talon.print()

// Destruimos el datastore
destroy ds_talon

end event

event csd_transferencias();string lista_liquidaciones,nombre_ventana
st_cobros_datos_remesa datos_remesa

nombre_ventana = classname() // A fin de evitar Bad Runtime Reference
SetPointer(Hourglass!)
IF NOT gnv_control_cuentas_bancarias.of_validar_datos_bancarios_movimientos('P', dw_lista)  THEN RETURN
// Obtenemos los datos de la remesa
Openwithparm(w_premaat_datos_remesa, 'INGRET')
datos_remesa = Message.PowerObjectParm	
IF f_genera_csb34(dw_lista, datos_remesa, nombre_ventana, lista_liquidaciones) = -1 THEN RETURN
f_imprimir_listado_transferencias (nombre_ventana, lista_liquidaciones)
SetPointer(Arrow!)
end event

event csd_eliminar();// No se borran registros, s$$HEX1$$f300$$ENDHEX$$lo se marca el campo eliminar para que no aparezcan en ning$$HEX1$$fa00$$ENDHEX$$n sitio.
string num
int resp

num = dw_lista.getitemstring(dw_lista.getrow(), 'numero')

if messagebox(g_titulo, "Se va a eliminar el registro " + num + ". $$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro?", Exclamation!, yesno!) = 1 then
	dw_lista.setitem(dw_lista.getrow(), 'eliminar', 'S')
	dw_lista.update()
	event csd_actualiza_listas()
end if

end event

on w_ing_ret_lista.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_lista_ing_ret" then this.MenuID = create m_lista_ing_ret
end on

on w_ing_ret_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;g_dw_lista  = dw_lista
g_w_lista   = g_lista_ing_ret
//g_w_detalle = g_detalle_listas
g_lista     = 'w_ing_ret_lista'

end event

event csd_consulta();call super::csd_consulta;//Abrimos la ventana de consulta
open(w_ing_ret_consulta)
if Message.DoubleParm = -1 then return
dw_lista.Event csd_retrieve()
end event

event pfc_postopen();call super::pfc_postopen;// SOBREESCRITO

////cb_consulta.PostEvent(Clicked!)
//TriggerEvent('csd_nuevo')

//Asignamos valor a la variable global
g_dw_lista_ing_ret = dw_lista
end event

event open;call super::open;f_centrar_ventana(this) 
end event

event csd_nuevo();call super::csd_nuevo;// Abrimos la ventana para una nueva generaci$$HEX1$$f300$$ENDHEX$$n
open(w_ing_ret)
end event

type cb_recuperar_pantalla from w_lista`cb_recuperar_pantalla within w_ing_ret_lista
end type

type cb_guardar_pantalla from w_lista`cb_guardar_pantalla within w_ing_ret_lista
end type

type st_1 from w_lista`st_1 within w_ing_ret_lista
end type

type dw_lista from w_lista`dw_lista within w_ing_ret_lista
integer x = 32
integer y = 32
integer width = 3479
string dataobject = "d_ing_ret_lista"
boolean hscrollbar = true
boolean ib_rmbmenu = false
end type

type cb_consulta from w_lista`cb_consulta within w_ing_ret_lista
end type

type cb_detalle from w_lista`cb_detalle within w_ing_ret_lista
end type

type cb_ayuda from w_lista`cb_ayuda within w_ing_ret_lista
end type

