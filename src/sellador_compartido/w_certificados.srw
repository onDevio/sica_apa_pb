HA$PBExportHeader$w_certificados.srw
forward
global type w_certificados from w_response
end type
type cb_3 from commandbutton within w_certificados
end type
type cb_4 from commandbutton within w_certificados
end type
type cb_aceptar from commandbutton within w_certificados
end type
type cb_2 from commandbutton within w_certificados
end type
type cb_1 from commandbutton within w_certificados
end type
type dw_1 from u_dw within w_certificados
end type
end forward

global type w_certificados from w_response
integer width = 2409
integer height = 1064
string title = "Seleccione el certificado que desee"
cb_3 cb_3
cb_4 cb_4
cb_aceptar cb_aceptar
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_certificados w_certificados

type variables
n_cst_dirattrib	inv_DirList[]
string i_certificado_defecto
end variables

forward prototypes
public subroutine of_marcar_defecto ()
public subroutine of_importar_certificados ()
end prototypes

public subroutine of_marcar_defecto ();double i
if dw_1.rowcount() <= 0 then return

for i = 1 to dw_1.rowcount()
	if dw_1.getitemstring(i, 'filename') = i_certificado_defecto then
		dw_1.setitem(i, 'default', 'S')
		return
	end if
next
return

end subroutine

public subroutine of_importar_certificados ();Integer		li_Cnt, li_Entries, li_Sort
String		ls_Import, ls_FileSpec

SetPointer(HourGlass!)

If RightA(g_directorio_certificados, 1) <> "\" Then
	ls_FileSpec = g_directorio_certificados + "\"
Else
	ls_FileSpec = g_directorio_certificados
End If
li_Entries = gnv_fichero.of_dirlist(ls_FileSPec + '*.pfx', 0, inv_DirList)

If li_Entries < 0 Then
//	MessageBox("File Services", "Directory not found", Exclamation!)
	dw_1.reset()
	Return
Elseif li_Entries = 0 Then
//	MessageBox("File Services", "No files found", Exclamation!)
	dw_1.reset()	
	Return
End if

dw_1.SetRedraw(False)
dw_1.Reset()

For li_Cnt = 1 To li_Entries
	ls_Import = ls_Import + inv_DirList[li_Cnt].is_FileName + "~t" + &
				inv_DirList[li_Cnt].is_AltFileName + "~t" + &
				String(inv_DirList[li_Cnt].idb_FileSize) + "~t" + &
				String(inv_DirList[li_Cnt].id_LastWriteDate) + "~t" + &
				String(inv_DirList[li_Cnt].it_LastWriteTime) + "~t" 
//				String(inv_DirList[li_Cnt].id_CreationDate) + "~t" + &
//				String(inv_DirList[li_Cnt].it_CreationTime) + "~t" + &
//				String(inv_DirList[li_Cnt].id_LastAccessDate) + "~t"
	if inv_DirList[li_Cnt].ib_SubDirectory Then ls_Import = ls_Import + "d"
	If inv_DirList[li_Cnt].ib_ReadOnly Then ls_Import = ls_Import + "r"
	If inv_DirList[li_Cnt].ib_Hidden Then ls_Import = ls_Import + "h"
	If inv_DirList[li_Cnt].ib_System Then ls_Import = ls_Import + "s"
	If inv_DirList[li_Cnt].ib_Archive Then ls_Import = ls_Import + "a"
	ls_Import = ls_Import + "~r~n"
Next

dw_1.ImportString(ls_Import)

//If is_CurrDir <> g_directorio_certificados Then
//	inv_Filesrv.of_changedirectory(g_directorio_certificados)
//	is_CurrDir = inv_Filesrv.of_getcurrentdirectory()
////	sle_dir.text = is_CurrDir
//End if

// Desseleccionar todo
//dw_1.event csd_unselectall()


dw_1.SetRedraw(True)
end subroutine

on w_certificados.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_aceptar=create cb_aceptar
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_1
end on

on w_certificados.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_aceptar)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;i_certificado_defecto=message.stringparm
of_importar_certificados()
of_marcar_defecto()
f_centrar_ventana(this)
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_certificados
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_certificados
end type

type cb_3 from commandbutton within w_certificados
integer x = 1897
integer y = 384
integer width = 411
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Predeterminado"
end type

event clicked;long fila_seleccionada
long i

fila_seleccionada = dw_1.getselectedrow(0)
if fila_seleccionada <= 0 then return

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i, 'default', 'N')
next

dw_1.setitem(fila_seleccionada, 'default', 'S')

i_certificado_defecto = dw_1.getitemstring(fila_seleccionada, 'filename')

  UPDATE var_globales  
     SET texto = :i_certificado_defecto  
   WHERE var_globales.nombre = 'g_certificado_defecto'
           ;

//messagebox(g_titulo, 'Esta opci$$HEX1$$f300$$ENDHEX$$n debe grabar el certificado por defecto')		
end event

type cb_4 from commandbutton within w_certificados
integer x = 1897
integer y = 788
integer width = 411
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_aceptar from commandbutton within w_certificados
integer x = 1897
integer y = 652
integer width = 411
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;double fila
string certificado = ''

fila = dw_1.getselectedrow(0)

if fila > 0 then certificado = dw_1.getitemstring(fila, 'filename')

closewithreturn(parent, certificado)
end event

type cb_2 from commandbutton within w_certificados
integer x = 1897
integer y = 252
integer width = 411
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Importar"
end type

event clicked;string docname, named
string directorio
integer value
long i, length_docname
integer err

value = GetFileOpenName("Selecciona un certificado", &
		+ docname, named, "", &
		+ "PFX Files (*.pfx),*.pfx," &
		+ "P12 Files (*.p12),*.p12")

if value <> 1 then return

// Nos aseguramos que el directorio del que importamos es distinto
// del directorio de certificados. Para ello extraemos primero el dir. de importaci$$HEX1$$f300$$ENDHEX$$n
length_docname = LenA(docname)
for i =  length_docname to 1 step -1
	if MidA(docname,i,1) = '\' then 
		exit
	end if
next
directorio = MidA(docname,1, i)

if directorio = g_directorio_certificados then return

// Copiar el fichero al directorio de certificados
gnv_fichero.of_filecopy(docname, g_directorio_certificados + named)

// refrescamos
of_importar_certificados()
of_marcar_defecto()

// A$$HEX1$$f100$$ENDHEX$$adido por Roberto Marco 22/03/2005
// Restauramos el directorio base de la aplicaci$$HEX1$$f300$$ENDHEX$$n
err=f_cambiar_directorio_activo(g_dir_aplicacion)




end event

type cb_1 from commandbutton within w_certificados
integer x = 1897
integer y = 124
integer width = 411
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Borrar"
end type

event clicked;string fichero
long fila_seleccionada = 0

fila_seleccionada = dw_1.getselectedrow(0)

if fila_seleccionada <= 0 then return

fichero = g_directorio_certificados + dw_1.getitemstring(fila_seleccionada, 'filename')
filedelete(fichero)

of_importar_certificados()
of_marcar_defecto()
end event

type dw_1 from u_dw within w_certificados
integer x = 37
integer y = 100
integer width = 1833
integer height = 804
integer taborder = 10
string dataobject = "d_certificados"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;of_setrowselect(true)
// Multiseleccion
//this.inv_rowselect.of_SetStyle (this.inv_rowselect.SIMPLE)

this.object.p_1.filename = g_directorio_imagenes + 'certificado.gif'
end event

event doubleclicked;call super::doubleclicked;cb_aceptar.event clicked()
end event

