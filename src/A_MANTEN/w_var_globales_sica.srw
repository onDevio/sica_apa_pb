HA$PBExportHeader$w_var_globales_sica.srw
forward
global type w_var_globales_sica from w_mant_simple
end type
type pb_1 from picturebutton within w_var_globales_sica
end type
end forward

global type w_var_globales_sica from w_mant_simple
integer width = 3511
integer height = 1520
string title = "Contadores generales de la Aplicaci$$HEX1$$f300$$ENDHEX$$n"
pb_1 pb_1
end type
global w_var_globales_sica w_var_globales_sica

type variables
string is_modif
end variables

on w_var_globales_sica.create
int iCurrent
call super::create
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on w_var_globales_sica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
end on

event type integer pfc_preupdate();call super::pfc_preupdate;string mensaje 
int fila, res, retorno=1

//mensaje += f_valida(dw_1,'texto','NOVACIO','Debe especificar un valor en el campo Valor.'+cr)

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno

end event

event pfc_postopen();call super::pfc_postopen;//Variables de control de grabacion de modificacion
g_recien_grabado_modificacion=FALSE

end event

event type integer pfc_postupdate(powerobject apo_control[]);call super::pfc_postupdate;string id_modif
datetime fecha

id_modif = f_siguiente_numero('MODIFICACIONES', 10)
fecha = datetime(today(),now())

INSERT INTO modificaciones  
( id_modificacion, modificacion, usuario, fecha, id_colegiado, tipo_modulo)  
VALUES ( :id_modif, :is_modif, :g_usuario, :fecha, '', 'VG')  ;

g_recien_grabado_modificacion=TRUE
return 1

end event

event open;call super::open;inv_resize.of_register (pb_1, "fixedtobottom")

// Para el usuario csd mostramos el bot$$HEX1$$f300$$ENDHEX$$n para ver el hist$$HEX1$$f300$$ENDHEX$$rico
if (g_usuario = '0000000001') or (f_es_superusuario() <> '-1') then pb_1.visible = true 

end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_var_globales_sica
integer x = 3415
integer y = 776
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_var_globales_sica
integer x = 3415
integer y = 656
end type

type dw_1 from w_mant_simple`dw_1 within w_var_globales_sica
event csd_modificacion_datos ( string id_colegiado,  u_dw dw,  string nombre_dw,  string campo,  long row )
integer x = 37
integer y = 32
integer width = 3387
string dataobject = "d_var_globales_sica"
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event dw_1::csd_modificacion_datos(string id_colegiado, u_dw dw, string nombre_dw, string campo, long row);// Actualiza los datos modificados en la tabla "modificaciones"
// ------------------------------------------------------------
string  data, tipo

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

if isnull(is_modif) then is_modif = ''	
// se concatenan las modificaciones con la anterior
is_modif += id_colegiado + /*' ' +  campo +*/ '=' + data + '; '

end event

event dw_1::itemchanged;call super::itemchanged;// Modificacion de Datos
dw_1.event csd_modificacion_datos(this.getitemstring(this.getrow(),'nombre'), this, '', dwo.name, row)

end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_var_globales_sica
boolean visible = false
integer x = 3122
integer y = 812
end type

type cb_borrar from w_mant_simple`cb_borrar within w_var_globales_sica
boolean visible = false
integer x = 3415
integer y = 812
boolean enabled = false
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_var_globales_sica
boolean visible = false
integer x = 3415
integer y = 900
end type

type pb_1 from picturebutton within w_var_globales_sica
boolean visible = false
integer x = 37
integer y = 1196
integer width = 261
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico"
boolean originalsize = true
vtextalign vtextalign = multiline!
end type

event clicked;openwithparm(w_historico, "%"+"VG")

end event

