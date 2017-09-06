HA$PBExportHeader$w_bancaja_detalle.srw
$PBExportComments$A eliminar v4
forward
global type w_bancaja_detalle from w_detalle
end type
type cb_1 from commandbutton within w_bancaja_detalle
end type
type cb_2 from commandbutton within w_bancaja_detalle
end type
type cb_3 from commandbutton within w_bancaja_detalle
end type
type cb_4 from commandbutton within w_bancaja_detalle
end type
end forward

global type w_bancaja_detalle from w_detalle
integer width = 3625
integer height = 2148
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_bancaja_detalle w_bancaja_detalle

type variables
datastore ds_bancaja
string i_path
integer i_num
end variables

event open;call super::open;integer longitud,num,col,asis,i,s
string colegiado,pr,dir
dw_1.reset()
//--------------

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

//SE MUESTRA LA VENTANA PARA SELECCIONAR LA LISTA DE BANCAJA

	string nombre
	integer valor
	valor=GetFileOpenName("Seleccione la Lista de BANCAJA",dir,nombre,"DOC", &
			+ "Text Files (*.TXT),*.TXT," &
			+ "Doc Files (*.DOC),*.DOC")
	if valor =1 then
			
//----------------

longitud = FileLength(dir)

//en num se guarda el identificador del fichero de texto
num = FileOpen(dir)

//En i_num se guarda el identificador del fichero para cerrarlo
//con el evento close()
i_num=num

//En asis se guarda el n$$HEX2$$ba002000$$ENDHEX$$de plazas libres
asis=g_n_plazas_libres

IF longitud < 32767 THEN

	//COLEGIADO
	col=FileRead(num, colegiado)
	//mientras no se llegue al final del fichero...
	do while col<>-100
		if col>285 then
			messagebox(G_TITULO,'Los datos del colegiado exceden la capacidad de la m$$HEX1$$e100$$ENDHEX$$quina.')
			col=-100
		else
			dw_1.event pfc_addrow()
			dw_1.accepttext()
			
			dw_1.SetItem(dw_1.Getrow(),'n_colegiado',MidA(colegiado,1,10))
			dw_1.SetItem(dw_1.Getrow(),'nombre',MidA(colegiado,11,10))
			dw_1.SetItem(dw_1.Getrow(),'apellidos',MidA(colegiado,21,20))
			dw_1.SetItem(dw_1.Getrow(),'nif',MidA(colegiado,41,10))
			dw_1.SetItem(dw_1.Getrow(),'sexo',MidA(colegiado,52,1))
			dw_1.SetItem(dw_1.Getrow(),'direccion',MidA(colegiado,54,30))
			dw_1.SetItem(dw_1.Getrow(),'cp',MidA(colegiado,85,5))
			dw_1.SetItem(dw_1.Getrow(),'poblacion',MidA(colegiado,91,20))
			dw_1.SetItem(dw_1.Getrow(),'provincia',MidA(colegiado,112,20))
			dw_1.SetItem(dw_1.Getrow(),'telefono',MidA(colegiado,133,15))
			dw_1.SetItem(dw_1.Getrow(),'pagado',MidA(colegiado,149,1))
			dw_1.SetItem(dw_1.Getrow(),'f_pago',datetime(date(MidA(colegiado,151,10))))
			dw_1.SetItem(dw_1.Getrow(),'n_recibo',MidA(colegiado,162,10))
			dw_1.SetItem(dw_1.Getrow(),'importe',double(MidA(colegiado,173,10)))
			dw_1.SetItem(dw_1.Getrow(),'a_nombre_de',MidA(colegiado,184,100))
			dw_1.SetItem(dw_1.Getrow(),'id_curso',g_id_curso)
			dw_1.SetItem(dw_1.GetRow(),'f_inscripcion',datetime(today()))
			dw_1.SetItem(dw_1.GetRow(),'escuela_practica_juridica',&
							f_escuela_practica_juridica(MidA(colegiado,1,10)))

		//Asignar lista de espera si fuera necesario...
 
				if asis>0 then
					dw_1.SetItem(dw_1.GetRow(),'n_lista_Espera',0)
					asis=asis - 1
				else
		//Si no quedan plazas se a$$HEX1$$f100$$ENDHEX$$ade a la lista de espera
					g_n_lista_espera=g_n_lista_espera + 1
					dw_1.SetItem(dw_1.GetRow(),'n_lista_Espera',g_n_lista_espera)
				end if




//---------------------------------------------------------------//
//SI SE QUIERE ORDENAR PARA DAR PRIORIDAD A LOS COLEGIADOS...
//
//
////Si se a$$HEX1$$f100$$ENDHEX$$ade un colegiado y quedan plazas libres en el curso
////este se inserta en asistentes, n$$HEX2$$ba002000$$ENDHEX$$lista espera=0
//			
//			if mid(colegiado,1,10)<>string('          ') then
//				if asis>0 then
//					dw_1.SetItem(dw_1.GetRow(),'n_lista_Espera',0)
//					asis=asis - 1
//				else
//	//Si no quedan plazas se a$$HEX1$$f100$$ENDHEX$$ade a la lista de espera
//					g_n_lista_espera=g_n_lista_espera + 1
//					dw_1.SetItem(dw_1.GetRow(),'n_lista_Espera',g_n_lista_espera)
//				end if
//			end if
			col=FileRead(num, colegiado)
		end if
	loop	
		
END IF

////Una vez asignado el orden a los colegiados, se les asigna 
////a los no colegiados.
//
////Si quedan plazas libres se a$$HEX1$$f100$$ENDHEX$$aden al curso y si no se insertan
////en la lista de espera.
//s=dw_1.rowCount()
//for i=1 to dw_1.RowCount()
//	pr=dw_1.GetItemString(i,'n_colegiado')
//	if pr=string('          ') then
//		if asis>0 then
//			dw_1.SetItem(i,'n_lista_Espera',0)
//			asis=asis - 1
//		else
//			g_n_lista_espera=g_n_lista_espera + 1
//			dw_1.SetItem(i,'n_lista_Espera',g_n_lista_espera)
//		end if
//	end if
//next
//			
//			
//-------------------------------------------------------------//

else
	close(w_bancaja_detalle)
end if

if asis<=0 then
	messagebox(G_TITULO,'La lista seleccionada excede la capacidad del curso, algunos usuarios pasar$$HEX1$$e100$$ENDHEX$$n a la lista de espera.')
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02


end event

on w_bancaja_detalle.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
end on

on w_bancaja_detalle.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event close;call super::close;fileclose(i_num)
end event

type cb_nuevo from w_detalle`cb_nuevo within w_bancaja_detalle
end type

type cb_ayuda from w_detalle`cb_ayuda within w_bancaja_detalle
end type

type cb_grabar from w_detalle`cb_grabar within w_bancaja_detalle
end type

type cb_ant from w_detalle`cb_ant within w_bancaja_detalle
end type

type cb_sig from w_detalle`cb_sig within w_bancaja_detalle
end type

type dw_1 from w_detalle`dw_1 within w_bancaja_detalle
integer y = 160
integer width = 3525
integer height = 1876
string dataobject = "d_bancaja_detalle"
boolean vscrollbar = true
end type

event dw_1::pfc_preupdate;//integer i
//for i=1 to this.RowCount()
//	dw_1.SetItem(i,'id_asistente',f_siguiente_numero('FORMACION_ASISTENTES',10))
//next
return 1
end event

event dw_1::pfc_insertrow;dw_1.SetItem(dw_1.GetRow(),'id_asistente',f_siguiente_numero('FORMACION_ASISTENTES',10))
return 1
end event

event dw_1::pfc_addrow;call super::pfc_addrow;dw_1.SetItem(dw_1.GetRow(),'id_asistente',f_siguiente_numero('FORMACION_ASISTENTES',10))
return 1
end event

type cb_1 from commandbutton within w_bancaja_detalle
boolean visible = false
integer x = 23
integer y = 36
integer width = 494
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Buscar Lista"
end type

event clicked;string dir,nombre
integer valor

// MODIFICADO RICARDO 04-03-02
n_cst_filesrvwin32 cambia_directorio
string directorio
cambia_directorio = create n_cst_filesrvwin32
directorio = cambia_directorio.of_getcurrentdirectory()
// FIN MODIFICADO RICARDO 04-03-02

valor=GetFileOpenName("Seleccione la Lista de BANCAJA",dir,nombre,"DOC", &
		+ "Text Files (*.TXT),*.TXT," &
		+ "Doc Files (*.DOC),*.DOC")
if valor =1 then
	i_path=dir
integer longitud,num,i,tot
string nom

longitud = FileLength(i_path)

num = FileOpen(i_path, &
		LineMode!)

IF longitud < 32767 THEN
		FileRead(num, nom)
		
		messagebox("",nom)
		messagebox("",dir)
	
END IF
end if

// MODIFICADO RICARDO 04-03-02
// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
cambia_directorio.of_changedirectory(directorio)
destroy cambia_directorio
// FIN MODIFICADO RICARDO 04-03-02

end event

type cb_2 from commandbutton within w_bancaja_detalle
boolean visible = false
integer x = 539
integer y = 1556
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ordenar lista"
end type

event clicked;integer i,j,cont,n,s

s=1
//los ordenamos por n_colegiado
for i=1 to dw_1.RowCount()
	if dw_1.GetItemString(i,'n_colegiado')<>'' then
		dw_1.SetItem(i,'n_lista_espera',s)
		s=s+1
		n=s
	end if
next
for i=1 to dw_1.RowCount()
	if dw_1.GetItemString(i,'n_colegiado')='' then
		dw_1.SetItem(i,'n_lista_espera',n)
		n=n+1
	end if
next


dw_1.SetSort("n_lista_espera A")
dw_1.Sort()
//Asignamos n_lista_espera a 0 a los n_plazas primeros

dw_1.update()
dw_1.retrieve(g_id_curso)

for i=1 to g_n_plazas
	dw_1.SetItem(i,'n_lista_espera',0)
next

end event

type cb_3 from commandbutton within w_bancaja_detalle
integer x = 2377
integer y = 36
integer width = 494
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Importar Lista"
end type

event clicked;parent.event csd_grabar()
end event

type cb_4 from commandbutton within w_bancaja_detalle
integer x = 2930
integer y = 36
integer width = 494
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar Ventana"
end type

event clicked;close(w_bancaja_detalle)


end event

