HA$PBExportHeader$w_fases_renuncias.srw
forward
global type w_fases_renuncias from w_response
end type
type dw_1 from u_dw within w_fases_renuncias
end type
type dw_historico from u_csd_dw within w_fases_renuncias
end type
end forward

global type w_fases_renuncias from w_response
integer width = 4521
integer height = 1096
string title = "Renuncias"
event csd_mostrar_liq_fase ( )
event csd_mostrar_liq_expedi ( )
dw_1 dw_1
dw_historico dw_historico
end type
global w_fases_renuncias w_fases_renuncias

type variables
st_w_fases_liquidaciones datos
u_dw idw_fases_modificacion_datos
string is_id_fase,is_id_expedi

end variables

event csd_mostrar_liq_fase();dw_1.retrieve(is_id_fase)
end event

on w_fases_renuncias.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_historico
end on

on w_fases_renuncias.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_historico)
end on

event open;call super::open;datos=message.powerobjectparm
is_id_fase=datos.id_fase
is_id_expedi=datos.id_expedi
idw_fases_modificacion_datos	= dw_historico
f_centrar_ventana(this)

event csd_mostrar_liq_fase()
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_renuncias
integer x = 3721
integer y = 596
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_renuncias
integer x = 3721
integer y = 468
end type

type dw_1 from u_dw within w_fases_renuncias
event csd_modificacion_datos ( string idfase,  u_dw dw,  string nombre_dw,  string campo,  long row )
integer x = 37
integer y = 32
integer width = 4425
integer height = 928
integer taborder = 10
string dataobject = "d_fases_renuncias_lista"
boolean hscrollbar = true
boolean righttoleft = true
end type

event csd_modificacion_datos(string idfase, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  fase, modificacion, data, tipo
integer fila

// Le quitamos el n$$HEX2$$ba002000$$ENDHEX$$de filas al nombre del tab que lo lleve
if PosA(nombre_dw, '(') > 0 then nombre_dw = LeftA(nombre_dw, PosA(nombre_dw, '(')-2)

// Se devuelve un valor campo de la DW segun sea el tipo de dato
tipo=dw.Describe(campo+".ColType")
if tipo='!' then return // Define un tipo constanste

data=''
CHOOSE CASE upper(LeftA(tipo ,2))
	CASE 'CH' // Tipo 'String'
		data=dw.getitemstring(row,campo)
	CASE 'DA' // Tipo 'DateTime'
		data=string(dw.getitemdatetime(row,campo),'dd/mm/yyyy')
	CASE ELSE // queda 'Number'
      data=string(dw.getitemnumber(row,campo))
END CHOOSE

if f_es_vacio(data) then data=''   // return

// David 13/03/2006 - Excepci$$HEX1$$f300$$ENDHEX$$n: Para Guadalajara, cuando se modifica el campo del texto de un reparo que obtenga 
// el valor anterior de la BD para que no coja el texto inicial que no ha introducido el usuario
if g_colegio = 'COAATGU' and nombre_dw = 'REPAROS' and campo = 'texto' then
	string id_reparo, texto
	id_reparo = dw.getitemstring(row,'id_reparo')
	SELECT fases_reparos.texto  INTO :texto FROM fases_reparos WHERE fases_reparos.id_reparo = :id_reparo  ;
	if isnull(texto) then texto = ''
	data = texto
end if


//se a$$HEX1$$f100$$ENDHEX$$ade un registro a modificaci$$HEX1$$f300$$ENDHEX$$n de datos
if g_recien_grabado_modificacion_fases=TRUE then
	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
end if

//Debido a que hay una DW que no es de Fases se coloca el tipo_modulo al que pertenece
//if nombre_dw = Upper('dw_fases_datos_exp') then
//	idw_fases_modificacion_datos.triggerevent("pfc_addrow")
//   idw_fases_modificacion_datos.setitem(idw_fases_modificacion_datos.rowcount(),'tipo_modulo','02')
//end if
//David - 22/11/2004 : Para que se muestren los cambios desde esta ventana

fila        =idw_fases_modificacion_datos.rowcount()
fase        =idfase
if fila>0 then
	modificacion=idw_fases_modificacion_datos.getitemstring(fila,'modificacion')
end if
// se concatenan las modificaciones con la anterior
if isnull(modificacion) then modificacion = ''
if LeftA(nombre_dw,6) = 'MUSAAT' or LeftA(nombre_dw,7) = 'DETALLE' or LeftA(nombre_dw,7) = 'EXPEDIE' then
	modificacion = modificacion + nombre_dw + ' ' + campo + '=' + data + '; '	
else
	modificacion = modificacion + nombre_dw + ' (' + string(row) + ') ' + campo + '=' + data + '; '
end if

// Se actualiza la dw de modificaciones oculta
idw_fases_modificacion_datos.setitem(fila,'id_colegiado',fase)
idw_fases_modificacion_datos.setitem(fila,'modificacion',modificacion)
idw_fases_modificacion_datos.setitem(fila,'fecha',datetime(today(),now()))
idw_fases_modificacion_datos.setitem(fila,'usuario',g_usuario)

g_recien_grabado_modificacion_fases=FALSE

this.TriggerEvent('csd_control_estados')

end event

event constructor;call super::constructor;this.of_SetRowSelect(TRUE)
this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)
// Set to simple sort style
inv_sort.of_SetStyle (2)

end event

event doubleclicked;call super::doubleclicked;if row < 1 then return

string id_renuncia

id_renuncia = this.getitemstring(row, 'id_renuncia')

openwithparm(w_fases_renuncias_detalle, id_renuncia)

this.event csd_modificacion_datos(is_id_fase, this, 'RENUNCIA', dwo.name, row)
idw_fases_modificacion_datos.AcceptText()
idw_fases_modificacion_datos.update()

event csd_mostrar_liq_fase()
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;m_dw.m_table.m_insert.enabled = False
am_dw.m_table.m_addrow.enabled = False
am_dw.m_table.m_delete.enabled = True
end event

event pfc_deleterow;string id_cli,id_renuncia,mensaje_error
date fecha_hoy
id_cli = this.getitemstring(this.getrow(),'fases_renuncias_id_fase')
id_renuncia = this.getitemstring(this.getrow(),'id_renuncia')
fecha_hoy = today()

UPDATE fases_renuncias  
SET id_fase = '',   
usuario = :g_usuario,   
f_modificacion = :fecha_hoy  
WHERE ( fases_renuncias.id_fase = :id_cli ) AND  
( fases_renuncias.id_renuncia = :id_renuncia )    USING SQLCA;

IF SQLCA.SQLCode = -1 THEN 
	mensaje_error += SQLCA.SQLErrText
	ROLLBACK;
ELSE
	COMMIT;
END IF

this.event csd_modificacion_datos(is_id_fase, this, 'BORRAR RENUNCIA', 'id_renuncia',this.getrow())
idw_fases_modificacion_datos.AcceptText()
idw_fases_modificacion_datos.update()

event csd_mostrar_liq_fase()

return 1
end event

type dw_historico from u_csd_dw within w_fases_renuncias
boolean visible = false
integer x = 101
integer y = 1048
integer width = 2094
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_historico"
boolean ib_rmbmenu = false
end type

event pfc_insertrow;call super::pfc_insertrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', is_id_fase )
this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return 1
end event

event pfc_addrow;call super::pfc_addrow;//Se ingresa en el campo clave de la DW el valor obtenido desde el contador
this.setitem(this.rowcount(), 'id_modificacion', f_siguiente_numero('MODIFICACIONES', 10))
this.setitem(this.rowcount(), 'id_colegiado', is_id_fase)

this.setitem(this.rowcount(), 'tipo_modulo', '03')
//donde "n" es un entero que indica la longitud en caracteres del contador
return ancestorreturnvalue
end event

