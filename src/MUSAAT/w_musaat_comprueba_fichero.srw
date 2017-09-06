HA$PBExportHeader$w_musaat_comprueba_fichero.srw
$PBExportComments$Lee un fichero econ$$HEX1$$f300$$ENDHEX$$mico de MUSAAT y nos informa de los movimientos y los importes totales y parciales
forward
global type w_musaat_comprueba_fichero from w_popup
end type
type cb_1 from commandbutton within w_musaat_comprueba_fichero
end type
type dw_1 from u_dw within w_musaat_comprueba_fichero
end type
type hpb_1 from hprogressbar within w_musaat_comprueba_fichero
end type
end forward

global type w_musaat_comprueba_fichero from w_popup
integer x = 214
integer y = 221
integer width = 2752
integer height = 1572
string title = "Comprobaci$$HEX1$$f300$$ENDHEX$$n Fichero de MUSAAT"
cb_1 cb_1
dw_1 dw_1
hpb_1 hpb_1
end type
global w_musaat_comprueba_fichero w_musaat_comprueba_fichero

on w_musaat_comprueba_fichero.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.hpb_1=create hpb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.hpb_1
end on

on w_musaat_comprueba_fichero.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.hpb_1)
end on

type cb_1 from commandbutton within w_musaat_comprueba_fichero
string tag = "texto=general.iniciar_lectura"
integer x = 1102
integer y = 1276
integer width = 466
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Iniciar Lectura"
end type

event clicked;string nombrefichero, Ruta, linea
int i, pos_punto, j, longitud_cadena
string sl_prima_t, sl_prima_t_con_coma
double prima_t, total_prima = 0, total_en_negativo = 0

hpb_1.visible = true
dw_1.reset()

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02


if GetFileOpenName('Seleccione nombre de fichero',Ruta,NombreFichero,'.txt','Ficheros de datos (*.txt),*.txt')<> 1 Then return
dw_1.ImportFile(Ruta)

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


hpb_1.maxposition = dw_1.rowcount()
hpb_1.position = 0
for i = 1 to dw_1.rowcount()
	hpb_1.position ++
	linea = dw_1.getitemstring(i, 'texto')
	sl_prima_t = MidA(linea, 158,12 )
	pos_punto = PosA(sl_prima_t, '.', 1)
	if pos_punto > 0 then
		sl_prima_t_con_coma=ReplaceA(sl_prima_t,pos_punto, 1,",")
	else
		sl_prima_t_con_coma = sl_prima_t
	end if
	// Quitar ceros
	longitud_cadena = LenA(sl_prima_t_con_coma)
	for j = 1 to longitud_cadena
		if MidA(sl_prima_t_con_coma, 1, 1) = '0' then
			sl_prima_t_con_coma = MidA(sl_prima_t_con_coma, 2, LenA(sl_prima_t_con_coma))
//			messagebox('kk', sl_prima_t_con_coma)
		else
			exit
		end if
	next
	prima_t = double(sl_prima_t_con_coma)
	dw_1.setitem(i, 'prima', prima_t)
	prima_t = f_redondea(prima_t)
	if prima_t < 0 then
		total_en_negativo += prima_t
	end if
//	messagebox(string(i),sl_prima_t_con_coma + ' ' + string(prima_t))
	total_prima += prima_t
next
total_prima = f_redondea(total_prima)
messagebox(g_titulo,g_idioma.of_getmsg('msg_musaat.num_movimientos','N$$HEX1$$fa00$$ENDHEX$$mero de movimientos ') + string(dw_1.rowcount()) + cr +&
g_idioma.of_getmsg('msg_musaat.total_prima','Total Prima ') + string(total_prima) + cr + g_idioma.of_getmsg('msg_musaat.total_en_negativo','Total en negativo ') + string(total_en_negativo)) 
hpb_1.visible = false
end event

type dw_1 from u_dw within w_musaat_comprueba_fichero
integer x = 73
integer y = 68
integer width = 2569
integer height = 976
integer taborder = 10
string dataobject = "d_musaat_comprueba_fichero"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_SetSort(TRUE)

// Column header sort
inv_sort.of_SetColumnHeader (true)

inv_sort.of_SetStyle (2)
end event

type hpb_1 from hprogressbar within w_musaat_comprueba_fichero
boolean visible = false
integer x = 73
integer y = 1084
integer width = 2569
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 1
end type

