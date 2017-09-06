HA$PBExportHeader$w_sellador_integridad_comprobacion.srw
forward
global type w_sellador_integridad_comprobacion from w_sheet
end type
type dw_consulta from u_dw within w_sellador_integridad_comprobacion
end type
type tab_1 from tab within w_sellador_integridad_comprobacion
end type
type tabpage_1 from userobject within tab_1
end type
type dw_log from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_log dw_log
end type
type tabpage_2 from userobject within tab_1
end type
type dw_incidencias from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_incidencias dw_incidencias
end type
type tab_1 from tab within w_sellador_integridad_comprobacion
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_parametros from u_dw within w_sellador_integridad_comprobacion
end type
type cb_comprobar from u_cb within w_sellador_integridad_comprobacion
end type
type cb_subsanar from u_cb within w_sellador_integridad_comprobacion
end type
type cb_salir from u_cb within w_sellador_integridad_comprobacion
end type
type dw_lista from u_dw within w_sellador_integridad_comprobacion
end type
type st_texto from statictext within w_sellador_integridad_comprobacion
end type
type cb_1 from u_cb within w_sellador_integridad_comprobacion
end type
end forward

global type w_sellador_integridad_comprobacion from w_sheet
integer width = 3653
integer height = 1620
windowstate windowstate = maximized!
event type integer csd_obtener_consulta ( )
event csd_comprobar ( )
dw_consulta dw_consulta
tab_1 tab_1
dw_parametros dw_parametros
cb_comprobar cb_comprobar
cb_subsanar cb_subsanar
cb_salir cb_salir
dw_lista dw_lista
st_texto st_texto
cb_1 cb_1
end type
global w_sellador_integridad_comprobacion w_sellador_integridad_comprobacion

type variables
u_dw idw_lista,idw_parametros,idw_incidencias,idw_log

boolean i_comprueba_tamano,i_comprueba_existencia,i_comprueba_entradas,i_comprueba_duplicados
end variables

forward prototypes
public subroutine wf_incidencia (integer inc, st_sellador_integridad st_datos)
end prototypes

event type integer csd_obtener_consulta();string sql_original,sql_nueva

dw_consulta.AcceptText()

sql_original = dw_lista.describe("datawindow.table.select")
sql_nueva=sql_original

f_sql('fases.n_registro','>=','n_reg_d',dw_consulta,sql_nueva,'1','')
f_sql('fases.n_registro','<=','n_reg_h',dw_consulta,sql_nueva,'1','')
f_sql('expedientes.n_expedi','>=','n_exp_d',dw_consulta,sql_nueva,'1','')
f_sql('expedientes.n_expedi','<=','n_exp_h',dw_consulta,sql_nueva,'1','')
f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_consulta,sql_nueva,'1','')
f_sql('fases.f_entrada','<=','fecha_entrada_h',dw_consulta,sql_nueva,'1','')
f_sql('fases.f_visado','>=','fecha_visado_d',dw_consulta,sql_nueva,'1','')
f_sql('fases.f_visado','<=','fecha_visado_h',dw_consulta,sql_nueva,'1','')

if sql_nueva=sql_original then 
	MessageBox(g_titulo,"Debe seleccionar por lo menos un parametro de consulta",StopSign!)
else
	dw_lista.modify("datawindow.table.select= ~"" + sql_nueva + "~"")
end if

dw_lista.retrieve()
dw_lista.modify("datawindow.table.select= ~"" + sql_original + "~"")

return dw_lista.rowcount()

end event

event csd_comprobar();
string tamano_kb,tamano_bd,ruta_base
double tamano
long i,j,log,num_ficheros,fila
datastore ds_doc_visared
n_cst_dirattrib lista_ficheros[]
st_sellador_integridad st_datos

ds_doc_visared=create datastore
ds_doc_visared.DataObject='d_sellador_integridad_doc_visared'
ds_doc_visared.SetTransObject(SQLCA)

for i=1 to idw_lista.rowcount()
	st_datos.id_fase=idw_lista.GetItemString(i,'id_fase')
	st_datos.n_registro=idw_lista.GetItemString(i,'n_registro')
	st_texto.textcolor=rgb(255,0,0)
	st_texto.text='Procesando fase '+string(i)+ '/'+string(idw_lista.rowcount())
	ds_doc_visared.retrieve(st_datos.id_fase)
	
	for j=1 to ds_doc_visared.rowcount()
		log=idw_log.insertrow(0)

		st_datos.fichero=ds_doc_visared.GetItemString(j,'nombre_fichero')
		st_datos.ruta=ds_doc_visared.GetItemString(j,'ruta_fichero')
		ruta_base=f_obtener_ruta_base(left(st_datos.ruta,4))
		tamano_bd=ds_doc_visared.GetItemString(j,'tamano')
		st_datos.id_documento=ds_doc_visared.GetItemString(j,'id_fichero')
		idw_log.SetItem(log,'texto','Comprobando entrada '+st_datos.ruta+st_datos.fichero)
		idw_log.SetItem(log,'id_fase',st_datos.id_fase)
		idw_log.SetItem(log,'ruta',st_datos.ruta)		
				
		tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_base +st_datos.ruta+st_datos.fichero) / 1024)
		tamano_kb =string(tamano,"#,###,##0") + ' Kb'
		idw_log.SetItem(log,'estado','V')
		
		fila=ds_doc_visared.find("lower(nombre_fichero)='"+lower(st_datos.fichero)+"' and id_fichero<>'"+st_datos.id_documento+"'",1,ds_doc_visared.rowcount())
		//fila=ds_doc_visared.find("nombre_fichero='"+st_datos.fichero+"' and id_fichero<>'"+st_datos.id_documento+"'",1,ds_doc_visared.rowcount())
		
		
		// Comprueba si existen el fichero al que apunta la entrada de la BD
		if i_comprueba_existencia and Not(FileExists(ruta_base + st_datos.ruta + st_datos.fichero)) then 
			wf_incidencia(1,st_datos) //n_registro,ruta,nombre_fichero,id_fichero)
			idw_log.SetItem(log,'estado','X')
		
		// Comprueba si hay entradas de la BD duplicadas
		elseif i_comprueba_duplicados and fila>0 then
			idw_log.SetItem(log,'estado','X')
			wf_incidencia(4,st_datos) //n_registro,ruta,fichero,"")			
		
		// Comprueba que el tama$$HEX1$$f100$$ENDHEX$$o de la BD corresponde con el del fichero fisico
		elseif i_comprueba_tamano and tamano_bd<> tamano_kb then // Si existe comprobamos el tama$$HEX1$$f100$$ENDHEX$$o
				wf_incidencia(2,st_datos) // n_registro,ruta,nombre_fichero,id_fichero)
				idw_log.SetItem(log,'estado','X')
		
		end if
		
	next
	st_datos.ruta=ds_doc_visared.GetItemString(1,'ruta_fichero')
	num_ficheros = gnv_fichero.of_dirlist(ruta_base + st_datos.ruta + "*.*",0,lista_ficheros[])
	
	
	// Comprueba si cada fichero fisico tiene una entrada en la BD.
	// Si no tiene entrada, la crea. Si el nombre del fichero fisico tiene una longitud mayor de 100
	// se acorta, y se crea la entrada en la BD con la longitud maxima.
	if not(i_comprueba_entradas) then continue
	for j=1 to num_ficheros	
		st_datos.fichero_largo=lista_ficheros[j].is_FileName
		st_datos.fichero=f_acorta_nombre(st_datos.fichero_largo)
	//	st_datos.fichero=lista_ficheros[j].is_FileName
		log=idw_log.insertrow(0)
		idw_log.SetItem(log,'texto','Comprobando carpeta local '+st_datos.ruta+st_datos.fichero_largo)
		idw_log.SetItem(log,'id_fase',st_datos.id_fase)
		idw_log.SetItem(log,'ruta',st_datos.ruta)		
				
		fila=ds_doc_visared.find("lower(nombre_fichero)='"+lower(st_datos.fichero_largo)+"'",1,ds_doc_visared.rowcount())
		//fila=ds_doc_visared.find("nombre_fichero='"+st_datos.fichero_largo+"'",1,ds_doc_visared.rowcount())
		if fila <= 0 then
			idw_log.SetItem(log,'estado','X')
			wf_incidencia(3,st_datos) //n_registro,ruta,fichero,"")	
		else
			idw_log.SetItem(log,'estado','V')
		end if		
	next

next
idw_log.groupcalc()
st_texto.textcolor=rgb(0,192,0)
st_texto.text='Proceso completo'

end event

public subroutine wf_incidencia (integer inc, st_sellador_integridad st_datos);//
long fila
string incidencia,nivel,id_fase,situacion


choose case inc
	case 1	
		incidencia="El fichero "+st_datos.fichero +" NO existe"
		situacion='L'
	case 2	
		incidencia="El tama$$HEX1$$f100$$ENDHEX$$o de "+st_datos.fichero+" es disinto al de la BD."
		situacion='B'
	case 3
		incidencia="No existe una entrada en la BD para "+st_datos.fichero_largo
		situacion='B'
	case 4
		incidencia="Existen dos entradas en la BD para "+st_datos.fichero
		situacion='B'
end choose

fila=idw_incidencias.insertrow(0)
idw_incidencias.SetItem(fila,'incidencia',incidencia)
idw_incidencias.SetItem(fila,'nivel_incidencia',nivel)
idw_incidencias.SetItem(fila,'valor_codigo',string(inc))
idw_incidencias.SetItem(fila,'id_documento',st_datos.id_documento)
idw_incidencias.SetItem(fila,'ruta',st_datos.ruta)
idw_incidencias.SetItem(fila,'fichero',st_datos.fichero)
idw_incidencias.SetItem(fila,'fichero_largo',st_datos.fichero_largo)
idw_incidencias.SetItem(fila,'id_fase',st_datos.id_fase)
idw_incidencias.SetItem(fila,'situacion',situacion)


end subroutine

on w_sellador_integridad_comprobacion.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.tab_1=create tab_1
this.dw_parametros=create dw_parametros
this.cb_comprobar=create cb_comprobar
this.cb_subsanar=create cb_subsanar
this.cb_salir=create cb_salir
this.dw_lista=create dw_lista
this.st_texto=create st_texto
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_parametros
this.Control[iCurrent+4]=this.cb_comprobar
this.Control[iCurrent+5]=this.cb_subsanar
this.Control[iCurrent+6]=this.cb_salir
this.Control[iCurrent+7]=this.dw_lista
this.Control[iCurrent+8]=this.st_texto
this.Control[iCurrent+9]=this.cb_1
end on

on w_sellador_integridad_comprobacion.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.tab_1)
destroy(this.dw_parametros)
destroy(this.cb_comprobar)
destroy(this.cb_subsanar)
destroy(this.cb_salir)
destroy(this.dw_lista)
destroy(this.st_texto)
destroy(this.cb_1)
end on

event open;call super::open;
idw_lista=dw_lista
idw_parametros=dw_parametros //tab_1.tabpage_1.dw_parametros2
idw_incidencias=tab_1.tabpage_2.dw_incidencias
idw_log=tab_1.tabpage_1.dw_log

dw_parametros.insertrow(0)
dw_consulta.insertrow(0)
idw_parametros.insertrow(0)
of_SetResize (true)
inv_resize.of_Register (tab_1, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_log, "ScaletoRight&Bottom")
inv_resize.of_Register (idw_incidencias, "ScaletoRight&Bottom")
inv_resize.of_Register (cb_comprobar, "FixedToBottom")
inv_resize.of_Register (cb_subsanar, "FixedToBottom")
inv_resize.of_Register (cb_salir, "FixedToBottom")
inv_resize.of_Register (st_texto, "FixedToBottom")


end event

type cb_recuperar_pantalla from w_sheet`cb_recuperar_pantalla within w_sellador_integridad_comprobacion
integer x = 18
integer y = 1480
integer taborder = 10
end type

type cb_guardar_pantalla from w_sheet`cb_guardar_pantalla within w_sellador_integridad_comprobacion
integer x = 2203
integer y = 1304
end type

type dw_consulta from u_dw within w_sellador_integridad_comprobacion
integer x = 27
integer y = 20
integer width = 1399
integer height = 580
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sellador_integridad_consulta"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar(True)
this.iuo_calendar.of_register(this.iuo_calendar.DDLB)
this.iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
this.iuo_calendar.of_SetInitialValue(True)
end event

type tab_1 from tab within w_sellador_integridad_comprobacion
event create ( )
event destroy ( )
integer x = 1435
integer y = 28
integer width = 2149
integer height = 1440
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2112
integer height = 1324
long backcolor = 79741120
string text = "Log"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_log dw_log
end type

on tabpage_1.create
this.dw_log=create dw_log
this.Control[]={this.dw_log}
end on

on tabpage_1.destroy
destroy(this.dw_log)
end on

type dw_log from u_dw within tabpage_1
integer x = 5
integer y = 20
integer width = 2089
integer height = 1292
integer taborder = 10
string dataobject = "d_sellador_integridad_log"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;if row>0 then openwithparm(w_sellador_integridad_detalle,dw_log.GetItemString(row,'id_fase'))
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2112
integer height = 1324
long backcolor = 79741120
string text = "Incidencias"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_incidencias dw_incidencias
end type

on tabpage_2.create
this.dw_incidencias=create dw_incidencias
this.Control[]={this.dw_incidencias}
end on

on tabpage_2.destroy
destroy(this.dw_incidencias)
end on

type dw_incidencias from u_dw within tabpage_2
integer x = 5
integer y = 20
integer width = 2103
integer height = 1296
integer taborder = 10
string dataobject = "d_sellador_integridad_incidencias"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

type dw_parametros from u_dw within w_sellador_integridad_comprobacion
integer x = 32
integer y = 592
integer width = 1353
integer height = 648
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_sellador_integridad_parametros"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'filtrar_log'
		if data='S' then
			idw_log.SetFilter("estado='X'")
		else
			idw_log.SetFilter("")
		end if
		idw_log.Filter()
		idw_log.sort()		
		idw_log.groupcalc()
end choose
end event

type cb_comprobar from u_cb within w_sellador_integridad_comprobacion
integer x = 384
integer y = 1380
integer width = 338
integer taborder = 21
boolean bringtotop = true
string text = "Comprobar"
end type

event clicked;call super::clicked;tab_1.SelectTab(1)

idw_log.reset()
idw_incidencias.reset()

if parent.event csd_obtener_consulta() <= 0 then 
	MessageBox(g_titulo, 'No se encontr$$HEX2$$f3002000$$ENDHEX$$ningun documento en los intervalos especificados')
	return
end if

i_comprueba_tamano=(dw_parametros.GetItemString(1,'tamanyo')='S')
i_comprueba_existencia=(dw_parametros.GetItemString(1,'existe')='S')
i_comprueba_entradas=(dw_parametros.GetItemString(1,'entradas')='S')
i_comprueba_duplicados=(dw_parametros.GetItemString(1,'duplicados')='S')

//
idw_log.setredraw(false)
parent.event csd_comprobar()
idw_log.setredraw(true)

if idw_incidencias.rowcount()>0 then 
	idw_incidencias.groupcalc()
	tab_1.tabpage_2.visible=true
	tab_1.SelectTab(2)
	cb_subsanar.enabled=true
else
	tab_1.tabpage_2.visible=false
	cb_subsanar.enabled=false
end if


end event

type cb_subsanar from u_cb within w_sellador_integridad_comprobacion
event csd_comprobar ( )
integer x = 731
integer y = 1380
integer width = 338
integer taborder = 31
boolean bringtotop = true
boolean enabled = false
string text = "Subsanar"
end type

event clicked;call super::clicked;
long i,fila
string id_doc ,subsanado,ruta,nombre_fichero,tamano_kb,id_fase,fichero,accion,fichero_largo,ruta_base
double tamano
datastore ds_doc_visared

ds_doc_visared=create datastore

ds_doc_visared.dataobject='d_sellador_integridad_doc_visared'
ds_doc_visared.SetTransObject(SQLCA)


i_comprueba_tamano=(dw_parametros.GetItemString(1,'tamanyo')='S')
i_comprueba_existencia=(dw_parametros.GetItemString(1,'existe')='S')
i_comprueba_entradas=(dw_parametros.GetItemString(1,'entradas')='S')
accion=dw_parametros.GetItemString(1,'param')
if accion='X' then
	if (MessageBox(g_titulo,'$$HEX1$$a100$$ENDHEX$$Atencion! Esta opci$$HEX1$$f300$$ENDHEX$$n implicar$$HEX2$$e1002000$$ENDHEX$$el borrado f$$HEX1$$ed00$$ENDHEX$$sico de los ficheros que no tengan entrada en la BD. $$HEX1$$bf00$$ENDHEX$$Esta seguro?',StopSign!,YesNo!)<>1) then return
end if


for i=1 to idw_incidencias.rowcount()
	subsanado='N'
	id_doc=idw_incidencias.GetItemString(i,'id_documento')
	id_fase=idw_incidencias.GetItemString(i,'id_fase')
	select ruta_fichero,nombre_fichero into :ruta,:nombre_fichero from fases_documentos_visared fv where fv.id_fichero=:id_doc;
	
	ruta_base=f_obtener_ruta_base(left(ruta,4))
	choose case idw_incidencias.GetItemString(i,'valor_codigo')

		case '1' // Borra las entradas si no existe el fichero fisico en la BD
			if not(i_comprueba_existencia) then continue
			delete fases_documentos_visared where id_fichero=:id_doc;
			subsanado='S'
		case '2' // Actualiza el tama$$HEX1$$f100$$ENDHEX$$o del fichero 
			if not(i_comprueba_tamano) then continue			
			tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_base +ruta+nombre_fichero) / 1024)
			tamano_kb =string(tamano,"#,###,##0") + ' Kb'
			update fases_documentos_visared set tamano=:tamano_kb where id_fichero=:id_doc;
			subsanado='S'
		case '3' // Subsana las incidencias con los ficheros
			if not(i_comprueba_entradas) then continue
			fichero=idw_incidencias.GetItemString(i,'fichero')
			fichero_largo=idw_incidencias.GetItemString(i,'fichero_largo')			
			ruta=idw_incidencias.GetItemString(i,'ruta')
			if accion='F' then
				fila=ds_doc_visared.insertrow(0)
				ds_doc_visared.setitem(fila, 'id_fichero', f_siguiente_numero('FASES_DOCU_VISARED', 10))
				ds_doc_visared.setitem(fila, 'id_fase', id_fase)
				ds_doc_visared.setitem(fila, 'nombre_fichero', fichero)
				ds_doc_visared.setitem(fila, 'ruta_fichero',ruta)
				ds_doc_visared.setitem(fila, 'sellado', 'N')
				ds_doc_visared.setitem(fila, 'fecha', today())
				ds_doc_visared.setitem(fila,'visualizar_web', 'N')
				tamano = Ceiling(gnv_fichero.of_GetFileSize(ruta_base + ruta + fichero_largo) / 1024)
				ds_doc_visared.SetItem(fila,'tamano',string(tamano,"#,###,##0") + ' Kb')			
				ds_doc_visared.update()
				gnv_fichero.of_filerename(ruta_base + ruta + fichero_largo,ruta_base + ruta + fichero)
				if FileExists(ruta_base + ruta + fichero) then
					subsanado='S'
				else
					subsanado='F'
				end if
			elseif accion='X' then
				FileDelete(ruta_base + ruta + fichero_largo)
				if FileExists(ruta_base + ruta + fichero_largo) then
					subsanado='F'
				else
					subsanado='S'
				end if				
			elseif accion='V' then
				subsanado='I'
			end if
			
			
	end choose
	tab_1.selecttab(2)
	idw_incidencias.SetItem(i,'subsanado',subsanado)
	
next


end event

type cb_salir from u_cb within w_sellador_integridad_comprobacion
integer x = 1079
integer y = 1380
integer width = 338
integer taborder = 21
boolean bringtotop = true
string text = "&Salir"
end type

event clicked;call super::clicked;close(parent)
end event

type dw_lista from u_dw within w_sellador_integridad_comprobacion
boolean visible = false
integer x = 1211
integer y = 1116
integer width = 178
integer height = 152
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_sellador_integridad_lista"
end type

type st_texto from statictext within w_sellador_integridad_comprobacion
integer x = 306
integer y = 1272
integer width = 741
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_sellador_integridad_comprobacion
integer x = 32
integer y = 1380
integer width = 338
integer taborder = 41
boolean bringtotop = true
string text = "&N_Doc."
end type

event clicked;call super::clicked;datastore ds_zips
long i,num
string n_doc


if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Esta opci$$HEX1$$f300$$ENDHEX$$n va a regenerar los numeros de documentos. El proceso puede tardar unos minutos" + &
                    "$$HEX1$$bf00$$ENDHEX$$Desea Continuar?",Question!,YesNo!)<> 1 then return

						  
dw_consulta.AcceptText()						  

ds_zips=create datastore
ds_zips.dataobject='d_sellador_documentos_lista_zips'

ds_zips.SetTransObject(SQLCA)
ds_zips.retrieve()

num=0
for i=1 to ds_zips.rowcount()
	n_doc=ds_zips.GetItemString(i,'n_documento')
	if f_es_vacio(n_doc) then
		n_doc=f_ps_generar_sig_num_doc_visared(ds_zips.GetItemString(i,'id_fase'),ds_zips.GetItemString(i,'fases_n_registro'))
		ds_zips.SetItem(i,'n_documento',n_doc)
		num++
	end if

next		

ds_zips.update()		

MessageBox(g_titulo,string(num) + " filas actualizadas")
						 
						 
end event

