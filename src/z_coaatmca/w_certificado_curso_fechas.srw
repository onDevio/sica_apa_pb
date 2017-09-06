HA$PBExportHeader$w_certificado_curso_fechas.srw
forward
global type w_certificado_curso_fechas from w_response
end type
type cb_3 from commandbutton within w_certificado_curso_fechas
end type
type cb_devolver from commandbutton within w_certificado_curso_fechas
end type
type dw_1 from datawindow within w_certificado_curso_fechas
end type
type dw_2 from datawindow within w_certificado_curso_fechas
end type
end forward

global type w_certificado_curso_fechas from w_response
integer width = 2921
integer height = 3056
boolean ib_isupdateable = false
cb_3 cb_3
cb_devolver cb_devolver
dw_1 dw_1
dw_2 dw_2
end type
global w_certificado_curso_fechas w_certificado_curso_fechas

type variables
string is_n_reg_salida
end variables

on w_certificado_curso_fechas.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_devolver=create cb_devolver
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_devolver
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_certificado_curso_fechas.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_devolver)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;call super::open;long i, filas
st_certificado_fechas st_cert_fechas

this.Title = 'Certificado asistencia a curso entre dos fechas'

f_centrar_ventana(this)

st_cert_fechas = Message.PowerObjectparm
is_n_reg_salida = st_cert_fechas.n_reg_salida

dw_1.SetTransobject(sqlca)
dw_1.retrieve(st_cert_fechas.n_col,datetime(st_cert_fechas.f_desde), datetime(st_cert_fechas.f_hasta))

if isnull(st_cert_fechas.colegiado_nombre) then st_cert_fechas.colegiado_nombre = ''
if isnull(st_cert_fechas.f_reg_entrada) then st_cert_fechas.f_reg_entrada = ''
if isnull(st_cert_fechas.n_reg_entrada) then st_cert_fechas.n_reg_entrada = ''
if isnull(st_cert_fechas.n_reg_salida) then st_cert_fechas.n_reg_salida = ''
if isnull(st_cert_fechas.f_reg_salida) then st_cert_fechas.f_reg_salida = ''
if isnull(st_cert_fechas.fecha_letras_n) then st_cert_fechas.fecha_letras_n = ''


dw_1.setitem(1,'colegiado_nombre',st_cert_fechas.colegiado_nombre) 
dw_1.setitem(1,'f_reg_entrada',st_cert_fechas.f_reg_entrada)
dw_1.setitem(1,'n_reg_entrada',st_cert_fechas.n_reg_entrada)
dw_1.setitem(1,'f_reg_salida',st_cert_fechas.f_reg_salida) 
dw_1.setitem(1,'fecha_letras_n',st_cert_fechas.fecha_letras_n) 


dw_2.insertrow(0)
dw_2.setitem(1,'colegiado_nombre',st_cert_fechas.colegiado_nombre) 
dw_2.setitem(1,'f_reg_entrada',st_cert_fechas.f_reg_entrada)
dw_2.setitem(1,'n_reg_entrada',st_cert_fechas.n_reg_entrada)
dw_2.setitem(1,'n_reg_salida',st_cert_fechas.n_reg_salida)
dw_2.setitem(1,'f_reg_salida',st_cert_fechas.f_reg_salida) 
	
		
if(dw_1.rowcount() = 0)then
	MessageBox(g_titulo,'El colegiado '+st_cert_fechas.colegiado_nombre+' no ha asistitido a ningun curso entre estas fechas')
	close(this)
else
	filas = dw_1.rowcount()
	
	do while(filas > 1)
		dw_1.deleterow(filas)
		filas=filas -1
	loop
end if



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_certificado_curso_fechas
integer x = 530
integer y = 2848
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_certificado_curso_fechas
integer x = 530
integer y = 2720
end type

type cb_3 from commandbutton within w_certificado_curso_fechas
string tag = "texto=general.cancelar"
integer x = 1097
integer y = 2848
integer width = 453
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;if(dw_1.visible=true)then
	dw_1.print()
else 
	if(dw_2.visible = true)then
		dw_2.print()
	end if
end if
end event

type cb_devolver from commandbutton within w_certificado_curso_fechas
event type string csd_obtener_ruta_pdf ( string n_registro )
string tag = "texto=general.aceptar"
integer x = 384
integer y = 2848
integer width = 453
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
end type

event type string csd_obtener_ruta_pdf(string n_registro);string id_registro,anyo,ruta
datetime fecha
string ruta_base,id_tipo_modulo,id_modulo,nombre,is_serie

	is_serie = Mid(n_registro,1,2)

	select ruta_base into :ruta_base from registro_series where codigo=:is_serie and (cod_delegacion=:g_cod_delegacion or cod_delegacion='%');
	select id_registro,fecha into :id_modulo,:fecha from registro where n_registro=:n_registro;
	anyo=string(year(date(fecha)))
		
	//ruta=ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\'
	ruta=ruta_base+anyo+'\'+id_modulo+'\'
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+anyo+'\')
	if Not(DirectoryExists(ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\')) then CreateDirectory(ruta_base+id_tipo_modulo+'\'+anyo+'\'+id_modulo+'\')


return ruta
end event

event clicked;long fila,pos
string id_doc_modulo, id_reg_salida,plantilla,ruta_reg_es
datastore ds_reg_anexo, ds_doc_modulo

if(dw_1.visible = true)then
	select ruta into :plantilla from plantillas where codigo='ES00000005';
	pos = Pos(plantilla,'.',1)
	plantilla = trim(Mid(plantilla,1,pos - 1))
	plantilla = plantilla + '.pdf'
else
	if(dw_2.visible = true)then
		plantilla = 'carta_salida.pdf'
	end if
end if

//Insertamos el documento en la pesta$$HEX1$$f100$$ENDHEX$$a anexos del regsitro de salida
id_doc_modulo = f_siguiente_numero('ID_DOC_MODULO',20)
select id_registro into :id_reg_salida from registro where n_registro=:is_n_reg_salida;
ds_reg_anexo=create datastore
ds_reg_anexo.dataobject='d_registros_anexos'
ds_reg_anexo.SetTransObject(SQLCA)
fila=ds_reg_anexo.insertrow(0)

ds_reg_anexo.SetItem(fila,'id_registro_anexo',f_siguiente_numero('REGISTROS_ANEXOS',10))
ds_reg_anexo.SetItem(fila,'id_registro',id_reg_salida)
ds_reg_anexo.SetItem(fila,'ruta',plantilla)	
ds_reg_anexo.SetItem(fila,'id_documento_modulo',id_doc_modulo)	
ds_reg_anexo.update()	

ds_doc_modulo=create datastore
ds_doc_modulo.dataobject='d_csd_doc_modulo'
ds_doc_modulo.SetTransObject(SQLCA)
fila=ds_doc_modulo.insertrow(0)

ds_doc_modulo.SetItem(fila,'id_documento_modulo',id_doc_modulo)
ds_doc_modulo.SetItem(fila,'id_tipo_modulo','REG_ES')
ds_doc_modulo.SetItem(fila,'id_modulo',id_reg_salida)
ds_doc_modulo.SetItem(fila,'f_activacion',datetime(today(),now()))
ds_doc_modulo.SetItem(fila,'anyo',string(year(today())))
ds_doc_modulo.SetItem(fila,'nombre_fichero',plantilla)
ds_doc_modulo.SetItem(fila,'id_usuario',g_usuario)
ds_doc_modulo.SetItem(fila,'visible_web','S')
//ds_doc_modulo.SetItem(fila,'tamanyo',tamanyo)
ds_doc_modulo.update()


if(dw_1.visible = true)then
	dw_1.visible = false
	dw_2.visible = true	
	parent.title = 'Carta de salida'
	ruta_reg_es = this.event csd_obtener_ruta_pdf(is_n_reg_salida)
	dw_1.SaveAs(ruta_reg_es+plantilla, PDF!, false)
else
	ruta_reg_es = this.event csd_obtener_ruta_pdf(is_n_reg_salida)
	dw_2.SaveAs(ruta_reg_es+plantilla, PDF!, false)
	close(parent)
end if
end event

type dw_1 from datawindow within w_certificado_curso_fechas
integer x = 14
integer y = 8
integer width = 2843
integer height = 2688
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_listado_cursos_asistente_fechas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_certificado_curso_fechas
boolean visible = false
integer x = 14
integer y = 8
integer width = 2843
integer height = 2688
integer taborder = 20
string title = "none"
string dataobject = "d_listado_cursos_carta_salida"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

