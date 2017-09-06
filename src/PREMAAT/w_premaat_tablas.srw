HA$PBExportHeader$w_premaat_tablas.srw
forward
global type w_premaat_tablas from w_mant_simple
end type
type cb_cargar from u_cb within w_premaat_tablas
end type
type cb_1 from pfc_u_cb within w_premaat_tablas
end type
end forward

global type w_premaat_tablas from w_mant_simple
integer x = 214
integer y = 221
integer width = 2363
integer height = 1760
string title = "Mantenimiento de Tablas de PREMAAT"
cb_cargar cb_cargar
cb_1 cb_1
end type
global w_premaat_tablas w_premaat_tablas

type variables

end variables

on w_premaat_tablas.create
int iCurrent
call super::create
this.cb_cargar=create cb_cargar
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cargar
this.Control[iCurrent+2]=this.cb_1
end on

on w_premaat_tablas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cargar)
destroy(this.cb_1)
end on

event pfc_preupdate;call super::pfc_preupdate;string mensaje,cadenas[] 
int fila, res, retorno=1
if f_puedo_escribir(g_usuario, '0000000024')= -1 then return -1
mensaje += f_valida(dw_1,'anyo','NOVACIO',g_idioma.of_getmsg('premaat.valor_anyo','Debe especificar un valor en el campo A$$HEX1$$f100$$ENDHEX$$o.')+cr)
mensaje += f_valida(dw_1,'basico','NONULO',g_idioma.of_getmsg('premaat.valor_gr_basico','Debe especificar un valor en el campo Gr. B$$HEX1$$e100$$ENDHEX$$sico')+cr)

mensaje += f_valida(dw_1,'hombre_2000','NONULO',g_idioma.of_getmsg('premaat.valor_gr_2000h','Debe especificar un valor en el campo Gr. 2000 Hombre')+cr)
mensaje += f_valida(dw_1,'mujer_2000','NONULO',g_idioma.of_getmsg('premaat.valor_gr_2000d','Debe especificar un valor en el campo Gr. 2000 Mujer')+cr)
mensaje += f_valida(dw_1,'ahorro_2000','NONULO',g_idioma.of_getmsg('premaat.valor_gr_2000_ahorro','Debe especificar un valor en el campo M$$HEX1$$f300$$ENDHEX$$d. Ahorro 2000 ')+cr)
mensaje += f_valida(dw_1,'comple_1','NONULO',g_idioma.of_getmsg('premaat.valor_gr_2000_comple','Debe especificar un valor en el campo Gr. Comple 1$$HEX1$$ba00$$ENDHEX$$')+cr)

// Controlamos si hay duplicados en las filas visualizadas, asegur$$HEX1$$e100$$ENDHEX$$ndonos que las filas 
// con modificaciones no est$$HEX1$$e100$$ENDHEX$$n duplicadas
For fila = 1 to dw_1.RowCount() 
	IF dw_1.GetItemStatus( fila,0, Primary!) <> NotModified! then 
			res = f_busca_duplicados_colum_dw (dw_1, 'anyo', fila)
			cadenas[1] = string(fila) 
			cadenas[2]= string(res)
if res > 0 then mensaje += g_idioma.of_getmsg('general.repetir_filas',cadenas[],'Hay un valor repetido en las filas '+string(fila)+ ' y '+string(res)) + cr
	END IF
next

if mensaje<>'' then 
	messagebox(g_titulo, mensaje, stopsign!)
	retorno=-1
end if

return retorno
end event

event open;call super::open;// Enable the resize service
of_SetResize (true)

// Specify how the window will be resized
inv_resize.of_Register (cb_1, "FixedtoBottom")
end event

type cb_recuperar_pantalla from w_mant_simple`cb_recuperar_pantalla within w_premaat_tablas
end type

type cb_guardar_pantalla from w_mant_simple`cb_guardar_pantalla within w_premaat_tablas
end type

type dw_1 from w_mant_simple`dw_1 within w_premaat_tablas
integer x = 37
integer y = 32
integer width = 2235
integer height = 1336
string dataobject = "d_PREMAAT_TABLAS"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;IF GetItemStatus(currentrow,0,Primary!)=New! or GetItemStatus(currentrow,0,Primary!)=NewModified! THEN
	Object.anyo.Edit.DisplayOnly = "No"
ELSE	
	Object.anyo.Edit.DisplayOnly = "Yes"
END IF	
end event

type cb_anyadir from w_mant_simple`cb_anyadir within w_premaat_tablas
integer x = 37
integer y = 1412
end type

type cb_borrar from w_mant_simple`cb_borrar within w_premaat_tablas
integer x = 329
integer y = 1412
end type

type cb_ayuda from w_mant_simple`cb_ayuda within w_premaat_tablas
integer y = 1412
end type

type cb_cargar from u_cb within w_premaat_tablas
boolean visible = false
integer x = 1723
integer y = 1412
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string text = "&Cargar"
end type

event clicked;call super::clicked;string nom_fich, directorio
n_cst_filesrvwin32 cambia_directorio

cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()  //para tener el directorio de trabajo

If GetFileSaveName('Seleccione el nombre del Fichero', nom_fich, nom_fich, &
   '.TXT', 'Ficheros de datos (*.TXT),*.TXT,') <> 1 Then return //no seleccionamos el fichero o da error
	dw_1.ImportFile(nom_fich)


// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
end event

type cb_1 from pfc_u_cb within w_premaat_tablas
string tag = "texto=general.cargar"
integer x = 955
integer y = 1412
integer taborder = 11
boolean bringtotop = true
string text = "&Cargar"
end type

event clicked;call super::clicked;string nom_fich, directorio
n_cst_filesrvwin32 cambia_directorio

cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()  //para tener el directorio de trabajo

do until dw_1.rowcount()=0  //borramos los datos anteriores
	dw_1.deleterow(1)
loop

If GetFileSaveName('Seleccione el nombre del Fichero', nom_fich, nom_fich, &
   '.TXT', 'Ficheros de datos (*.TXT),*.TXT,') <> 1 Then return 
	dw_1.ImportFile(nom_fich,1)  //empezamos en la 1$$HEX1$$aa00$$ENDHEX$$, fichero sin descripciones
	
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
end event

