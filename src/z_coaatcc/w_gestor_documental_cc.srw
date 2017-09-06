HA$PBExportHeader$w_gestor_documental_cc.srw
forward
global type w_gestor_documental_cc from w_response
end type
type dw_1 from u_dw within w_gestor_documental_cc
end type
type cb_validar from commandbutton within w_gestor_documental_cc
end type
type cb_salir from commandbutton within w_gestor_documental_cc
end type
type tv_maestro from u_tvs within w_gestor_documental_cc
end type
type cb_1 from commandbutton within w_gestor_documental_cc
end type
type dw_2 from u_dw within w_gestor_documental_cc
end type
type cb_2 from commandbutton within w_gestor_documental_cc
end type
type dw_inc_tec from u_dw within w_gestor_documental_cc
end type
type dw_3 from u_dw within w_gestor_documental_cc
end type
type cb_imprimir from commandbutton within w_gestor_documental_cc
end type
type cb_borrar_adm from commandbutton within w_gestor_documental_cc
end type
type cb_borrar_tec from commandbutton within w_gestor_documental_cc
end type
type dw_impresion from u_dw within w_gestor_documental_cc
end type
end forward

global type w_gestor_documental_cc from w_response
integer width = 3680
integer height = 2932
string title = "Gestor Documental"
event csd_rellenar_arbol ( )
event csd_expandir ( string codigo,  integer nivel,  string descripcion,  long padre )
event csd_imprimir ( boolean visado )
dw_1 dw_1
cb_validar cb_validar
cb_salir cb_salir
tv_maestro tv_maestro
cb_1 cb_1
dw_2 dw_2
cb_2 cb_2
dw_inc_tec dw_inc_tec
dw_3 dw_3
cb_imprimir cb_imprimir
cb_borrar_adm cb_borrar_adm
cb_borrar_tec cb_borrar_tec
dw_impresion dw_impresion
end type
global w_gestor_documental_cc w_gestor_documental_cc

type variables
string i_nombre_dw,id_reparo_ficha,is_n_visado
st_gestor_doc ist_gestor_doc
boolean i_visar=false

string is_tarifa


// Variables de la ventana de reparos
long ii_index=1,ii_doc_tec_1
datastore ids_reparos_maestro
datastore ids_t_reparos

string is_fichero_generado,is_impresora
u_dw dw_ficha,idw_firma,idw_opciones,idw_sms,idw_email,idw_impresion

//w_reparos_detalle i_ventana



end variables

forward prototypes
public subroutine wf_anyadir_incidencia (boolean tecnica, string codigo)
end prototypes

event csd_rellenar_arbol();integer i, k,picture,j
long aux=1,handle,ind,nodo_base,nodos,nivel,fila
treeviewitem lvi
string grupo,grupo_ant,descripcion,nivel_sup,nivel_sup_ant,codigo
string filtro
long indexpicture,indice_grupo
datastore ds_reparos,ds_nodos

ids_t_reparos=create datastore
ids_t_reparos.Dataobject='ds_reparos_fases'
ids_t_reparos.SetTransObject(SQLCA)
ds_reparos=create datastore
ds_reparos.Dataobject='ds_reparos_fases'
ds_reparos.SetTransObject(SQLCA)

// Documentaci$$HEX1$$f300$$ENDHEX$$n Administrativa asociada
ds_reparos.retrieve("A"+ist_gestor_doc.tarifa)
ds_reparos.SetSort("orden a")
ds_reparos.sort()

if ist_gestor_doc.legalizacion='S' then
	//filtro="(pos(codigo,'L')>1)"
	filtro="impreso='L' or impreso='A'"
else
	//filtro="(pos(codigo,'A')>1)"
	filtro="impreso='N' or impreso='A'"
end if

ds_reparos.SetFilter(filtro)
ds_reparos.Filter()

ds_reparos.rowscopy(1,ds_reparos.rowcount(),Primary!,ids_t_reparos, 1, Primary!)

ds_reparos.SetFilter(filtro+" and nivel_sup='-'")
ds_reparos.Filter()
tv_maestro.SetRedraw(false)

grupo = ''

nivel_sup_ant='-1'
ind=0
ii_index=1
nodo_base = tv_maestro.InsertItemLast(0, upper("***** Documentaci$$HEX1$$f300$$ENDHEX$$n Administrativa asociada"),2)

nivel=1

for i = 1 to ds_reparos.rowcount()
	nivel_sup=ds_reparos.GetItemString(i,'nivel_sup')
	if nivel_sup<>'-' then continue
	//grupo =ds_reparos.getItemString(i,'grupo')
	descripcion = ds_reparos.getItemString(i,'descripcion')
	codigo = ds_reparos.getItemString(i,'codigo')
	this.event csd_expandir(codigo,nivel,descripcion,nodo_base)
next

tv_maestro.expandall(nodo_base)
//tv_maestro.expanditem(nodo_base)

// ****************************
// DOCUMENTACION TECNICA ASOCIADA
// ****************************

ds_reparos.SetFilter("")
ds_reparos.Filter()

ds_reparos.retrieve("T"+ist_gestor_doc.tarifa)
ds_reparos.SetSort("orden a")
ds_reparos.sort()

ds_reparos.rowscopy(1,ds_reparos.rowcount(),Primary!,ids_t_reparos, 1, Primary!)
ds_reparos.SetFilter("nivel_sup='-'")
ds_reparos.Filter()


grupo = ''
nivel_sup_ant='-1'
ind=0
ii_doc_tec_1=ii_index + 1
nodo_base = tv_maestro.InsertItemLast(0, upper("***** Documentaci$$HEX1$$f300$$ENDHEX$$n T$$HEX1$$e900$$ENDHEX$$cnica asociada"),2)

nivel=1

for i = 1 to ds_reparos.rowcount()
	nivel_sup=ds_reparos.GetItemString(i,'nivel_sup')
	if nivel_sup<>'-' then continue
	//grupo =ds_reparos.getItemString(i,'grupo')
	descripcion = ds_reparos.getItemString(i,'descripcion')
	codigo = ds_reparos.getItemString(i,'codigo')
	this.event csd_expandir(codigo,nivel,descripcion,nodo_base)
next	
	
//tv_maestro.expanditem(nodo_base)
tv_maestro.expandall(nodo_base)

tv_maestro.SetRedraw(true)
//ids_reparos_maestro.saveasformattedtext( "D:\ds_1.text")






//////////////////////////////////////////////////////////////////////////////////////////

//integer i, k,picture,j
//long aux=1,handle,ind,nodo_base,nodos,nivel,fila
//treeviewitem lvi
//string grupo,grupo_ant,descripcion,nivel_sup,nivel_sup_ant,codigo
//long indexpicture,indice_grupo
//datastore ds_reparos,ds_nodos
//
//ds_reparos=create datastore
//ds_reparos.Dataobject='ds_reparos_fases'
//ds_reparos.SetTransObject(SQLCA)
//
//ds_reparos.retrieve()
//
//ds_reparos.SetFilter("tipo=1041") //codigo+"'")
//ds_reparos.Filter()
//
//
//ds_reparos.SetSort("orden a")
//ds_reparos.sort()
//
//tv_maestro.SetRedraw(false)
//
//grupo = ''
//nivel_sup_ant='-1'
//ind=0
//ii_index=1
//nodo_base = tv_maestro.InsertItemLast(0,"REPAROS",2)
//
//nivel=1
//
//for i = 1 to ds_reparos.rowcount()
//	
//	nivel_sup=ds_reparos.GetItemString(i,'nivel_sup')
//	//grupo =ds_reparos.getItemString(i,'grupo')
//	descripcion = ds_reparos.getItemString(i,'descripcion')
//	codigo = ds_reparos.getItemString(i,'codigo')
//	if nivel_sup<>'-' or f_es_vacio(nivel_sup) then continue
//
//	this.event csd_expandir(codigo,nivel,descripcion,nodo_base)
//
//next	
//	
//tv_maestro.expanditem(nodo_base)	
//tv_maestro.SetRedraw(true)
////ids_reparos_maestro.saveasformattedtext( "D:\ds_1.text")
//
end event

event csd_expandir(string codigo, integer nivel, string descripcion, long padre);datastore ds_nodos
string descrip,cod,obs,tipo
long nodos,niv,i,handle,fila

ds_nodos=create datastore
ds_nodos.Dataobject='ds_reparos_fases'
ds_nodos.SetTransObject(SQLCA)


ids_t_reparos.SetFilter("nivel_sup='"+codigo+"'")
ids_t_reparos.Filter()
ids_t_reparos.rowscopy(1,ids_t_reparos.rowcount(),Primary!,ds_nodos,1,Primary!)
ids_t_reparos.SetFilter("")
ids_t_reparos.Filter()
//ds_nodos.retrieve(codigo)
//ds_nodos.retrieve()
fila=ids_t_reparos.Find("codigo='"+codigo+"'",1,ids_t_reparos.rowcount())
if fila>0 then
	obs=ids_t_reparos.GetItemString(fila,'observaciones')
	tipo=ids_t_reparos.GetItemString(fila,'tipo')	
end if

//ds_nodos.SetFilter("nivel_sup='"+codigo+"'")
//ds_nodos.Filter()
nodos=ds_nodos.rowcount()

//select observaciones,tipo into :obs,:tipo from t_reparos_fases where codigo=:codigo;

if nodos=0 then

	handle=tv_maestro.InsertItem(padre,1,descripcion,3)
	ii_index++

	fila= ids_reparos_maestro.insertrow(0)
	ids_reparos_maestro.SetItem(fila,'codigo',codigo)
	ids_reparos_maestro.SetItem(fila,'descripcion',descripcion)
	ids_reparos_maestro.SetItem(fila,'observaciones',obs)	
	ids_reparos_maestro.SetItem(fila,'tipo',tipo)		
	ids_reparos_maestro.SetItem(fila,'indice',handle)

else
	handle=tv_maestro.InsertItem(padre,1,descripcion,1)
	ii_index++
	fila= ids_reparos_maestro.insertrow(0)
	ids_reparos_maestro.SetItem(fila,'codigo',codigo)
	ids_reparos_maestro.SetItem(fila,'descripcion',descripcion)
	ids_reparos_maestro.SetItem(fila,'observaciones',obs)	
	ids_reparos_maestro.SetItem(fila,'tipo',tipo)		
	ids_reparos_maestro.SetItem(fila,'indice',handle)			
	
	niv=nivel + 1
	for i=1 to nodos 
		descrip = ds_nodos.getItemString(i,'descripcion')
		cod = ds_nodos.getItemString(i,'codigo')
		this.event csd_expandir(cod,niv,descrip,handle)
	next
end if
destroy ds_nodos



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//datastore ds_nodos
//string descrip,cod,obs,tipo
//long nodos,niv,i,handle,fila
//
//ds_nodos=create datastore
//ds_nodos.Dataobject='ds_reparos_fases'
//ds_nodos.SetTransObject(SQLCA)
//
//
//ds_nodos.retrieve()
//ds_nodos.SetFilter("nivel_sup='"+codigo+"'")
//ds_nodos.Filter()
//nodos=ds_nodos.rowcount()
//
//select observaciones,tipo into :obs,:tipo from t_reparos_fases where codigo=:codigo;
//
//if nodos=0 then
//
//	handle=tv_maestro.InsertItem(padre,1,descripcion,3)
//	ii_index++
//
//	fila= ids_reparos_maestro.insertrow(0)
//	ids_reparos_maestro.SetItem(fila,'codigo',codigo)
//	ids_reparos_maestro.SetItem(fila,'descripcion',descripcion)
//	ids_reparos_maestro.SetItem(fila,'observaciones',obs)	
//	ids_reparos_maestro.SetItem(fila,'tipo',tipo)		
//	ids_reparos_maestro.SetItem(fila,'indice',handle)		
//	
//else
//	handle=tv_maestro.InsertItem(padre,1,descripcion,1)
//	ii_index++
//	fila= ids_reparos_maestro.insertrow(0)
//	ids_reparos_maestro.SetItem(fila,'codigo',codigo)
//	ids_reparos_maestro.SetItem(fila,'descripcion',descripcion)
//	ids_reparos_maestro.SetItem(fila,'observaciones',obs)	
//	ids_reparos_maestro.SetItem(fila,'tipo',tipo)		
//	ids_reparos_maestro.SetItem(fila,'indice',handle)			
//	
//	niv=nivel + 1
//	for i=1 to nodos 
//		descrip = ds_nodos.getItemString(i,'descripcion')
//		cod = ds_nodos.getItemString(i,'codigo')
//		this.event csd_expandir(cod,niv,descrip,handle)
//	next
//end if
end event

event csd_imprimir(boolean visado);string n_reg,id_col,email,n_expedi,movil,n_col,nombre_fich,id_ficha, email_profesional
long i
datastore ds_imprime_hoja
string pdf,sms,papel,mail,lista_emails=''


select n_registro,n_expedi into :n_reg,:n_expedi from fases where id_fase=:ist_gestor_doc.id_fase;
datastore ds_colegiados,ds_clientes
ds_colegiados=create datastore
ds_colegiados.dataobject='d_fases_colegiados'
ds_colegiados.SetTransObject(SQLCA)
ds_colegiados.retrieve(ist_gestor_doc.id_fase)

ds_clientes=create datastore
ds_clientes.dataobject='d_fases_promotores'
ds_clientes.SetTransObject(SQLCA)
ds_clientes.retrieve(ist_gestor_doc.id_fase)


n_csd_impresion_formato uo_impresion
uo_impresion=create n_csd_impresion_formato
uo_impresion.copias=1

if visado then
	uo_impresion.asunto_email='Registro Visado '+n_reg
	uo_impresion.texto_sms="El encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+" ha sido visado ("+is_n_visado+")."
	uo_impresion.texto_email="El encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+" ha sido visado ("+is_n_visado+").Podr$$HEX1$$e100$$ENDHEX$$n pasar a retirarlo tr$$HEX1$$e100$$ENDHEX$$s el visado administrativo."
	uo_impresion.email = 'S'
	uo_impresion.pdf= 'X'
	uo_impresion.papel='X'
	uo_impresion.sms='S'	
	uo_impresion.nombre=""	
	
	// SI HAY MAS DE UN COLEGIADO 
	if ds_colegiados.rowcount()>1 then
		uo_impresion.masivo=true
		if uo_impresion.f_opciones_impresion()>0 then 		
			for i=1 to ds_colegiados.rowcount()	
				id_col=ds_colegiados.GetItemString(i,'id_col')
				select n_colegiado,email,telefono_3, email_profesional into :n_col,:email,:movil, :email_profesional from colegiados where id_colegiado=:id_col;
				email= email_profesional
				if f_es_vacio(email_profesional) then
					email= email
				end if
				if f_es_vacio(email) then
					lista_emails+=n_col+', '
					continue
				end if
				uo_impresion.direccion_email=email
				uo_impresion.moviles=movil
				//uo_impresion.nombre=nombre_fich+n_col
				uo_impresion.id_receptor=id_col
				uo_impresion.f_impresion()
			next	
			if not(f_es_vacio(lista_emails)) then
				lista_emails=left(lista_emails,len(lista_emails) - 2)
				MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Los siguientes colegiados no tenian email:"+cr+lista_emails)
			end if
		end if	
	else // SI SOLO HAY UN COLEGIADO 
		id_col=ds_colegiados.GetItemString(1,'id_col')
		select n_colegiado,email,telefono_3, email_profesional into :n_col,:email,:movil, :email_profesional from colegiados where id_colegiado=:id_col;
		email= email_profesional
		if f_es_vacio(email_profesional) then
			email= email
		end if
		if IsNull(n_col) then n_col=''
		uo_impresion.moviles=movil
		uo_impresion.direccion_email=email
		//uo_impresion.nombre=nombre_fich+n_col	
		uo_impresion.id_receptor=id_col
		if uo_impresion.f_opciones_impresion()>0 then uo_impresion.f_impresion()	
	end if
	
else
	uo_impresion.generar_registro='S' //g_formato_impresion.generar_registro
	uo_impresion.tipo_receptor='C'
	uo_impresion.asunto_email='Incidencias '+n_reg
	uo_impresion.asunto_registro='Incidencias '+n_reg
	uo_impresion.receptor=''
	uo_impresion.serie='INC'
	uo_impresion.texto_sms="Incidencia del encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+".Consulte su e-mail,Intranet o depto. de visado en horario de atenci$$HEX1$$f300$$ENDHEX$$n"
	uo_impresion.texto_email="Incidencia del encargo "+n_reg+" de su cliente "+ds_clientes.GetItemString(1,'cliente')+".Adjuntamos el documento informativo."
	uo_impresion.email = 'S'
	uo_impresion.pdf= 'S'
	uo_impresion.sms='S'

	uo_impresion.visualizar_web = 'N'
	uo_impresion.destino='F'
	uo_impresion.referencia=ist_gestor_doc.id_fase
	uo_impresion.ruta_automatica=true
	uo_impresion.ruta_relativa1=''
	uo_impresion.ruta_relativa2=''
	uo_impresion.ruta_relativa3=n_reg
	uo_impresion.n_expedi=ist_gestor_doc.id_fase
	uo_impresion.expediente=n_reg
	uo_impresion.nombre="Incidencia_Reg_"+n_reg + "_Col_"	
	
	
	nombre_fich=uo_impresion.nombre
	// SI HAY MAS DE UN COLEGIADO 
	if ds_colegiados.rowcount()>1 then
		uo_impresion.masivo=true
		if uo_impresion.f_opciones_impresion()>0 then 
		
			for i=1 to ds_colegiados.rowcount()
	
				ds_imprime_hoja = create datastore
				ds_imprime_hoja.dataobject = 'd_incidencias_gestor_documental_cc'			
				id_col=ds_colegiados.GetItemString(i,'id_col')
				select n_colegiado,email,telefono_3, email_profesional into :n_col,:email,:movil, :email_profesional from colegiados where id_colegiado=:id_col;
				email = email_profesional
				if f_es_vacio(email) then email= email
				
				uo_impresion.direccion_email=email
				uo_impresion.moviles=movil
				uo_impresion.nombre=nombre_fich+n_col
				uo_impresion.id_receptor=id_col
				if dw_inc_tec.rowcount()>0 then id_ficha=dw_inc_tec.GetItemString(1,'reparos_ficha_linea_id_reparo_ficha')
				if dw_2.rowcount()>0 then id_ficha=dw_2.GetItemString(1,'reparos_ficha_linea_id_reparo_ficha')
	//			f_rellenar_incid_gestor_docum_cc(ist_gestor_doc.id_fase,ds_imprime_hoja,dw_2,dw_inc_tec,id_col)
			f_rellenar_incid_gestor_docum_cc(ist_gestor_doc.id_fase,ds_imprime_hoja,id_ficha,id_col)
				uo_impresion.dw=ds_imprime_hoja
				uo_impresion.f_impresion()
			next			
		end if	
	else // SI SOLO HAY UN COLEGIADO 
		id_col=ds_colegiados.GetItemString(1,'id_col')
		select n_colegiado,email,telefono_3, email_profesional into :n_col,:email,:movil, :email_profesional from colegiados where id_colegiado=:id_col;
		email = email_profesional
		if f_es_vacio(email) then email= email
		if IsNull(n_col) then n_col=''
		uo_impresion.moviles=movil
		uo_impresion.direccion_email=email
		uo_impresion.nombre=nombre_fich+n_col	
		uo_impresion.id_receptor=id_col
		if uo_impresion.f_opciones_impresion()>0 then 	
			ds_imprime_hoja = create datastore
			ds_imprime_hoja.dataobject = 'd_incidencias_gestor_documental_cc'				
			if dw_inc_tec.rowcount()>0 then id_ficha=dw_inc_tec.GetItemString(1,'reparos_ficha_linea_id_reparo_ficha')
			if dw_2.rowcount()>0 then id_ficha=dw_2.GetItemString(1,'reparos_ficha_linea_id_reparo_ficha')
	//		f_rellenar_incid_gestor_docum_cc(ist_gestor_doc.id_fase,ds_imprime_hoja,dw_2,dw_inc_tec,id_col)
			f_rellenar_incid_gestor_docum_cc(ist_gestor_doc.id_fase,ds_imprime_hoja,id_ficha,id_col)
			uo_impresion.dw=ds_imprime_hoja
			uo_impresion.f_impresion()	
		end if
	end if
end if

pdf=uo_impresion.pdf
sms=uo_impresion.sms
papel=uo_impresion.papel
email=uo_impresion.email


// No se hacen todos en el mismo update para que sea acumulativo y al darle varias veces al boton imprimir
// vaya acumulando los tipos de impresi$$HEX1$$f300$$ENDHEX$$n
if pdf='S' then 
	update reparos_ficha set web=:pdf where id_reparo_ficha=:id_reparo_ficha;
end if

if sms='S' then 
	update reparos_ficha set sms=:sms where id_reparo_ficha=:id_reparo_ficha;
end if

if papel='S' then 
	update reparos_ficha set carta=:papel where id_reparo_ficha=:id_reparo_ficha;
end if

if email='S' then 
	update reparos_ficha set email=:email where id_reparo_ficha=:id_reparo_ficha;
end if
	

end event

public subroutine wf_anyadir_incidencia (boolean tecnica, string codigo);string descripcion
long ll_found,fila
if tecnica then
	ll_found = dw_2.Find("reparos_ficha_linea_codigo_reparo = '" + codigo +"'", 1, dw_2.RowCount())
	if ll_found < 1 then
		select descripcion into :descripcion from t_reparos_fases where codigo=:codigo;	
		/* ESTE CODIGO CONSTRUYE RECURSIVAMENTE LA DESCRIPCION COMPLETA
		// Construimos la descripcion completa
		string cod,nivel_superior,descrip
		cod=codigo
		select nivel_sup into :nivel_superior from t_reparos_fases where codigo=:cod;			
		do while nivel_superior<>'-'
			select codigo,descripcion into :cod,:descrip from t_reparos_fases where codigo=:nivel_superior;
			descripcion=descrip + ' / '+descripcion
			select nivel_sup into :nivel_superior from t_reparos_fases where codigo=:cod;							
		loop 
		*/			
		fila=dw_2.insertrow(0)
		dw_2.SetItem(fila,'reparos_ficha_linea_codigo_reparo', codigo)
		dw_2.SetItem(fila,'reparos_ficha_linea_texto',descripcion)						
	else 		
	//	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No puede a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s de una vez el mismo reparo.')
	end if		
else
	
	ll_found =dw_inc_tec.Find("reparos_ficha_linea_codigo_reparo = '" + codigo +"'", 1, dw_inc_tec.RowCount())
	if ll_found < 1 then
		select descripcion into :descripcion from t_reparos_fases where codigo=:codigo;	
		/* ESTE CODIGO CONSTRUYE RECURSIVAMENTE LA DESCRIPCION COMPLETA
		// Construimos la descripcion completa
		cod=codigo
		select nivel_sup into :nivel_superior from t_reparos_fases where codigo=:cod;			
		do while nivel_superior<>'-'
			select codigo,descripcion into :cod,:descrip from t_reparos_fases where codigo=:nivel_superior;
			descripcion=descrip + ' / '+descripcion
			select nivel_sup into :nivel_superior from t_reparos_fases where codigo=:cod;							
		loop 
		*/
		
		fila=dw_inc_tec.insertrow(0)
		dw_inc_tec.SetItem(fila,'reparos_ficha_linea_codigo_reparo', codigo)
		dw_inc_tec.SetItem(fila,'reparos_ficha_linea_texto',descripcion)		
	else
	//	messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n', 'No puede a$$HEX1$$f100$$ENDHEX$$adir m$$HEX1$$e100$$ENDHEX$$s de una vez el mismo reparo.')
	end if			
end if
			
end subroutine

on w_gestor_documental_cc.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_validar=create cb_validar
this.cb_salir=create cb_salir
this.tv_maestro=create tv_maestro
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_inc_tec=create dw_inc_tec
this.dw_3=create dw_3
this.cb_imprimir=create cb_imprimir
this.cb_borrar_adm=create cb_borrar_adm
this.cb_borrar_tec=create cb_borrar_tec
this.dw_impresion=create dw_impresion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_validar
this.Control[iCurrent+3]=this.cb_salir
this.Control[iCurrent+4]=this.tv_maestro
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.dw_inc_tec
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.cb_imprimir
this.Control[iCurrent+11]=this.cb_borrar_adm
this.Control[iCurrent+12]=this.cb_borrar_tec
this.Control[iCurrent+13]=this.dw_impresion
end on

on w_gestor_documental_cc.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_validar)
destroy(this.cb_salir)
destroy(this.tv_maestro)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_inc_tec)
destroy(this.dw_3)
destroy(this.cb_imprimir)
destroy(this.cb_borrar_adm)
destroy(this.cb_borrar_tec)
destroy(this.dw_impresion)
end on

event open;call super::open;string modulo

f_centrar_ventana(this)

ist_gestor_doc=Message.PowerObjectParm

ids_reparos_maestro=create datastore
ids_reparos_maestro.dataobject='ds_reparos_fases'

event csd_rellenar_arbol()


dw_3.insertrow(0)

dw_3.event csd_ocultar_obs()

end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_gestor_documental_cc
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_gestor_documental_cc
end type

type dw_1 from u_dw within w_gestor_documental_cc
event csd_rellenar_dw ( )
boolean visible = false
integer x = 3584
integer y = 836
integer width = 750
integer height = 384
integer taborder = 10
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event buttonclicked;call super::buttonclicked;//string tipo_intervencion,mensaje
//string texto
//// Desactivamos los botones e inicializamos las variables
//i_visar=false
//cb_validar.enabled=false
//texto=""
//tipo_intervencion=dw_1.getItemString(1,'tipo_intervencion')
//ist_control_doc.no_cte='N'
//ist_control_doc.tipo_actuacion=tipo_intervencion
//this.SetItem(1,'cte','N')
//this.SetItem(1,'OK','N')
//
//
//choose case tipo_intervencion
//	case '11','12','13'
//		if tipo_intervencion='11' then
//			mensaje='El Projecte i Direcci$$HEX2$$f3002000$$ENDHEX$$'
//		elseif tipo_intervencion='12' then
//			mensaje='El Projecte '				
//		elseif tipo_intervencion='13' then	
//			mensaje='La Direcci$$HEX2$$f3002000$$ENDHEX$$'					
//		end if
//		if MessageBox("Preguntar al col$$HEX1$$b700$$ENDHEX$$legiat", mensaje+" pertany al Codi T$$HEX1$$e800$$ENDHEX$$cnic de l'Edificaci$$HEX2$$f3002000$$ENDHEX$$?",Question!,YesNo!)=1 then
//			if tipo_intervencion='11' or tipo_intervencion='12' then
//				MessageBox("Gabinet","Passar pel Gabinet T$$HEX1$$e800$$ENDHEX$$cnic a donar OK.",Information!)
//				this.SetItem(1,'cte','S')
//				cb_validar.enabled=true
//			elseif tipo_intervencion='13' then
//				texto="L'Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic certifica que al projecte d'execuci$$HEX2$$f3002000$$ENDHEX$$li $$HEX1$$e900$$ENDHEX$$s d'aplicaci$$HEX2$$f3002000$$ENDHEX$$el Codi T$$HEX1$$e800$$ENDHEX$$cnic d'Edificaci$$HEX2$$f3002000$$ENDHEX$$(CTE)."
//				i_nombre_dw='d_documentacion_CFO_tg'
//				i_visar=true
//			end if
//		else		
//			ist_control_doc.no_cte='S'
//			i_nombre_dw='d_justificant_no_cfo_tg'						
//			i_visar=true		
//		end if			
//		
//	case '14'
//		if MessageBox("Preguntar al col$$HEX1$$b700$$ENDHEX$$legiat", "S'ha demanat la llic$$HEX1$$e800$$ENDHEX$$ncia d'obres abans del 29/09/06 ?",Question!,YesNo!)=1 then
//			i_nombre_dw='d_justificant_licencia_tg'
//			ist_control_doc.no_cte='S'
//		else
//			i_nombre_dw='d_documentacion_CFO1_tg'
//			texto="L'Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic certifica que al projecte d'execuci$$HEX2$$f3002000$$ENDHEX$$li $$HEX1$$e900$$ENDHEX$$s d'aplicaci$$HEX2$$f3002000$$ENDHEX$$el Codi T$$HEX1$$e800$$ENDHEX$$cnic d'Edificaci$$HEX2$$f3002000$$ENDHEX$$(CTE)."
//		end if
//		i_visar=true
//	case else
//		i_visar=true
//end choose 
//
//
//if i_nombre_dw<>'' then 
//	//MessageBox("DEBUG",i_nombre_dw)
//	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir la informaci$$HEX2$$f3002000$$ENDHEX$$en paper?",Question!,YesNo!)=1 then
//		dw_impresion.reset()
//		dw_impresion.dataobject= i_nombre_dw
//		dw_impresion.insertrow(0)	
//		this.event csd_rellenar_dw()
//		dw_impresion.SetItem(1,'texto',texto)
//		dw_impresion.SetItem(1,'texto2',texto)	
//		dw_impresion.print()
//	end if
//end if
//
//if i_visar then	
//	cb_validar.enabled=true
//	cb_validar.event clicked()
//end if
//
end event

type cb_validar from commandbutton within w_gestor_documental_cc
event csd_control_documentacion ( )
event csd_control_documentacion_cfo ( )
integer x = 2802
integer y = 2728
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Visar"
end type

event csd_control_documentacion();//string tipo_intervencion,texto2="",texto=""
//
//tipo_intervencion=dw_1.getItemString(1,'tipo_intervencion')
//
//if dw_1.GetItemString(1,'cte')='S' then
//	i_visar=true
//	if dw_1.GetItemString(1,'memoria')<>'S' then
//		i_visar=false
//		texto2+=" Mem$$HEX1$$f200$$ENDHEX$$ria -"		
//	else
//		texto+=" Mem$$HEX1$$f200$$ENDHEX$$ria -"
//	end if
//	if dw_1.GetItemString(1,'planos')<>'S' then
//		i_visar=false
//		texto2+=" Pl$$HEX1$$e000$$ENDHEX$$nols -"		
//	else		
//		texto+=" Pl$$HEX1$$e000$$ENDHEX$$nols -"
//	end if
//	if dw_1.GetItemString(1,'pliego')<>'S' then 
//		i_visar=false
//		texto2+=" Plec de Condicions -"		
//	else		
//		texto+=" Plec de Condicions -"
//	end if
//	if dw_1.GetItemString(1,'medidas')<>'S' then
//		i_visar=false
//		texto2+=" Mesuraments -"		
//	else				
//		texto+=" Mesuraments -"
//	end if
//	if dw_1.GetItemString(1,'presupuesto')<>'S' then
//		i_visar=false
//		texto2+=" Pressupost -"		
//	else			
//		texto+=" Pressupost -"
//	end if
//	if dw_1.GetItemString(1,'ess')<>'S' then
//		i_visar=false
//		texto2+=" ES/EBSS -"		
//	else				
//		texto+=" ES/EBSS -"
//	end if
//	if len(texto)>0 then texto=left(texto,len(texto) - 2)+'.'
//	if len(texto2)>0 then texto2=left(texto2,len(texto2) - 2)+'.'
//end if
//
//
//if not(i_visar) then	
//	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","El Projecte NO es pot VISAR")
//	dw_1.SetItem(1,'OK','N')
//	i_nombre_dw='d_documentacion_projecte_tg'
//else
//	MessageBox("OK!","El Projecte es pot VISAR. Documentaci$$HEX2$$f3002000$$ENDHEX$$correcta.")
//	if tipo_intervencion='11' then
//		i_nombre_dw='d_documentacion_cfo_tg'
//	end if	
//	dw_1.SetItem(1,'OK','S')		
//	this.enabled=false
//end if
//
//if i_nombre_dw<>'' then 
//
//	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir document informatiu en paper?",Question!,YesNo!)=1 then 
//		dw_impresion.reset()
//		dw_impresion.dataobject= i_nombre_dw
//		
//		dw_impresion.insertrow(0)
//		dw_impresion.SetItem(1,'texto',texto)
//		dw_impresion.SetItem(1,'texto2',texto2)	
//		dw_impresion.print()
//	end if
//end if
//
//
//if dw_1.GetItemString(1,'OK')='S' then	closeWithReturn(parent,ist_control_doc)
//
//	
//
//
//	
end event

event csd_control_documentacion_cfo();//string tipo_intervencion,texto2="",texto=""
//
//i_visar=true
//if dw_1.GetItemString(1,'cfo')='S' then
//
//	if dw_1.GetItemString(1,'licencia')<>'S' then
//		i_visar=false
//		texto2+=" Llic$$HEX1$$e800$$ENDHEX$$ncia d'obres -"		
//	else
//		texto+=" Llic$$HEX1$$e800$$ENDHEX$$ncia d'obres -"
//	end if
//	if dw_1.GetItemString(1,'libro_obra')<>'S' then
//		i_visar=false
//		texto2+=" Llibre d'obra -"		
//	else		
//		texto+=" Llibre d'obra -"
//	end if
//	if dw_1.GetItemString(1,'libro_inc')<>'S' then 
//		i_visar=false
//		texto2+=" Llibre d'Incid$$HEX1$$e800$$ENDHEX$$ncies -"		
//	else		
//		texto+=" Llibre d'Incid$$HEX1$$e800$$ENDHEX$$ncies -"
//	end if
//	
//	if dw_1.GetItemString(1,'obertura')<>'S' then
//		i_visar=false
//		texto2+=" Obertura del centre de treball -"		
//	else			
//		texto+=" Obertura del centre de treball -"
//	end if
//	if dw_1.GetItemString(1,'modelb')<>'S' then
//		i_visar=false
//		texto2+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l'obra (CTE) -"		
//	else				
//		texto+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l'obra (CTE) -"
//	end if
//	
//	if dw_1.GetItemString(1,'cc')<>'S' then
//		i_visar=false
//		texto2+="Programa i registre de resultats de control de qualitat -"	
//	else				
//		texto+=" Programa i registre de resultats de control de qualitat -"
//	end if
//	
//	if dw_1.GetItemString(1,'anexo_modific')<>'S' then
//		i_visar=false
//		texto2+=" Annex de modificacions del projecte (model A col$$HEX1$$b700$$ENDHEX$$legial) -"	
//	else				
//		texto+=" Annex de modificacions del projecte (model A col$$HEX1$$b700$$ENDHEX$$legial) -"
//	end if	
//	
//	if dw_1.GetItemString(1,'projecte')<>'S' then
//		i_visar=false
//		texto2+=" Projecte amb els seus annexes i modificacions -"		
//	else				
//		texto+=" Projecte amb els seus annexes i modificacions -"
//	end if	
//end if
//
//
//if len(texto)>0 then texto=left(texto,len(texto) - 2)+'.'
//if len(texto2)>0 then texto2=left(texto2,len(texto2) - 2)+'.'
//
//
//
//if not(i_visar) then	
//	ist_control_doc.no_cte=''
//	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Documentaci$$HEX2$$f3002000$$ENDHEX$$Incorrecta. NO Es pot realitzar el CFO")
//	dw_1.SetItem(1,'OK','N')
//	i_nombre_dw='d_documentacion_cfo_cte_tg'
//else
//	ist_control_doc.no_cte='N'
//	MessageBox("OK!","Documentaci$$HEX2$$f3002000$$ENDHEX$$correcta. Es pot realitzar el CFO.")
//	dw_1.SetItem(1,'OK','S')		
//	this.enabled=false
//	i_nombre_dw=''
//end if
//
//if i_nombre_dw<>'' then 
//
//	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir document informatiu en paper?",Question!,YesNo!)=1 then 
//		dw_impresion.reset()
//		dw_impresion.dataobject= i_nombre_dw
//		
//		dw_impresion.insertrow(0)
//		dw_impresion.SetItem(1,'texto',texto)
//		dw_impresion.SetItem(1,'texto2',texto2)	
//		dw_impresion.print()
//	end if
//end if
//
//
//if dw_1.GetItemString(1,'OK')='S' then	closeWithReturn(parent,ist_control_doc)
//
end event

event clicked;st_control_eventos c_evento
string tipo_gestion

if dw_2.rowcount()>0 or dw_inc_tec.rowcount()>0 then
	MessageBox("Atencion!","No puede visar con reparos")
	return
end if

// Se da n$$HEX1$$fa00$$ENDHEX$$mero de visado si no ten$$HEX1$$ed00$$ENDHEX$$a
string n_visado
select fases.archivo,fases.tipo_gestion into :n_visado,:tipo_gestion from fases where id_fase = :ist_gestor_doc.id_fase;

is_n_visado=n_visado

// COMENTADO POR LA INCIDENCIA  	 ICC-206
//if tipo_gestion='C' then
	parent.event csd_imprimir(true)
//end if

CloseWithReturn(parent,is_n_visado)
end event

type cb_salir from commandbutton within w_gestor_documental_cc
integer x = 3223
integer y = 2728
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Salir"
end type

event clicked;//long valor=0
//
//if dw_1.GetItemString(1,'ok')<>'S' then 
//	ist_control_doc.no_cte=''
//	ist_control_doc.tipo_actuacion=''
//end if
//closeWithReturn(parent,ist_control_doc)
dw_2.resetupdate()
dw_inc_tec.resetupdate()
closewithreturn(parent,'-1')
end event

type tv_maestro from u_tvs within w_gestor_documental_cc
integer x = 37
integer y = 32
integer width = 3589
integer height = 1392
integer taborder = 11
boolean bringtotop = true
integer weight = 700
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;cb_1.event clicked()
end event

type cb_1 from commandbutton within w_gestor_documental_cc
event csd_expandir_rama ( string codigo,  integer nivel,  string tipo_incidencia )
boolean visible = false
integer x = 69
integer y = 2716
integer width = 434
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "A$$HEX1$$f100$$ENDHEX$$adir"
end type

event csd_expandir_rama(string codigo, integer nivel, string tipo_incidencia);datastore ds_nodos
string descrip,cod,obs,tipo
long nodos,niv,i,handle,fila

ds_nodos=create datastore
ds_nodos.Dataobject='ds_reparos_fases'
ds_nodos.SetTransObject(SQLCA)

// Usamos el datawindow maestro de reparos para no volver a hacer retrieve
ids_t_reparos.SetFilter("nivel_sup='"+codigo+"'")
ids_t_reparos.Filter()
// Copiamos las filas a un nuevo datawindow para trabajar con $$HEX1$$e900$$ENDHEX$$l.
ids_t_reparos.rowscopy(1,ids_t_reparos.rowcount(),Primary!,ds_nodos,1,Primary!)
ids_t_reparos.SetFilter("")
ids_t_reparos.Filter()

fila=ids_t_reparos.Find("codigo='"+codigo+"'",1,ids_t_reparos.rowcount())
if fila>0 then
	descrip=ids_t_reparos.GetItemString(fila,'descripcion')
	obs=ids_t_reparos.GetItemString(fila,'observaciones')
	tipo=ids_t_reparos.GetItemString(fila,'tipo')	
end if

nodos=ds_nodos.rowcount()


// Usamos un datawindow u otro dependiendo si son incidencias administrativas o tecnicas
if tipo_incidencia = 'A' then
	// Concatenamos espacios en blanco delante para identar dependiendo del nivel.
	descrip=Fill(" ",4*nivel)+descrip
	fila= dw_2.insertrow(0)
	dw_2.SetItem(fila,'reparos_ficha_linea_texto',descrip)	
	dw_2.SetItem(fila,'t_reparos_fases_codigo',codigo)	
	
	// Si tiene hijos expandimos el nodo tambi$$HEX1$$e900$$ENDHEX$$n
	if nodos<>0 then	
		niv=nivel + 1
		for i=1 to nodos 
			descrip = ds_nodos.getItemString(i,'descripcion')
			cod = ds_nodos.getItemString(i,'codigo')
			this.event csd_expandir_rama(cod,niv,tipo_incidencia)
		next
	end if
else
	// Concatenamos espacios en blanco delante para identar dependiendo del nivel.
	descrip=Fill(" ",4*nivel)+descrip
	fila= dw_inc_tec.insertrow(0)
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_texto',descrip)	
	dw_inc_tec.SetItem(fila,'t_reparos_fases_codigo',codigo)		
	
	// Si tiene hijos expandimos el nodo tambi$$HEX1$$e900$$ENDHEX$$n
	if nodos<>0 then	
		niv=nivel + 1
		for i=1 to nodos 
			descrip = ds_nodos.getItemString(i,'descripcion')
			cod = ds_nodos.getItemString(i,'codigo')
			this.event csd_expandir_rama(cod,niv,tipo_incidencia)
		next
	end if	
	
end if
destroy ds_nodos

end event

event clicked;int i,j,n_documentos,encontrado,n_copias
long fila,ll_found, nivel,k
string codigo,activo,plantilla,tipo,descripcion,observaciones
integer aux
treeviewitem lvi

datastore ds_nodos
ds_nodos=create datastore
ds_nodos.Dataobject='ds_reparos_nodos_fases'
ds_nodos.SetTransObject(SQLCA)

for j=2 to ii_index + 1
   tv_maestro.getitem(j,lvi)
	if lvi.hasfocus then
	
		for i=1 to ids_reparos_maestro.rowcount()		
			aux = ids_reparos_maestro.getitemNumber(i,'indice')
			if aux = j then				
				codigo =ids_reparos_maestro.GetItemString(i,'codigo')
				
				
				if j<ii_doc_tec_1 then
					this.event csd_expandir_rama(codigo,nivel,'A')
				else
					this.event csd_expandir_rama(codigo,nivel,'T')
				end if		
				
				
			end if
		next
		
		/*
		if j<ii_doc_tec_1 then
			wf_anyadir_incidencia(true,codigo)
		else
			wf_anyadir_incidencia(false,codigo)						
		end if
		*/
	end if
next


dw_3.event csd_ocultar_obs()
end event

type dw_2 from u_dw within w_gestor_documental_cc
integer x = 32
integer y = 1564
integer width = 3589
integer height = 520
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_reparos_linea"
end type

event doubleclicked;call super::doubleclicked;if row>0 then this.deleterow(row)

dw_3.event csd_ocultar_obs()
end event

type cb_2 from commandbutton within w_gestor_documental_cc
integer x = 1641
integer y = 2728
integer width = 402
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;long i,fila
string observaciones



id_reparo_ficha = f_reparos_ficha_insertar(ist_gestor_doc.id_fase)
observaciones=dw_3.GetItemString(1,'obs_doc_admin')

for i=1 to dw_2.rowcount()
	dw_2.SetItem(i,'reparos_ficha_linea_id_reparo_linea',f_siguiente_numero('ID_REPARO_LINEA',10))
	dw_2.SetItem(i,'reparos_ficha_linea_id_reparo_ficha',id_reparo_ficha)
	dw_2.SetItem(i,'reparos_ficha_linea_observaciones',observaciones)		
	dw_2.SetItem(i,'reparos_ficha_linea_codigo_reparo','ADM')	
next

// METEMOS LAS OBSERVACIONES COMO UNA NUEVA LINEA
if not(f_es_vacio(observaciones)) then
	fila=dw_2.insertrow(0)
	dw_2.SetItem(fila,'reparos_ficha_linea_id_reparo_linea',f_siguiente_numero('ID_REPARO_LINEA',10))
	dw_2.SetItem(fila,'reparos_ficha_linea_id_reparo_ficha',id_reparo_ficha)
	dw_2.SetItem(fila,'reparos_ficha_linea_codigo_reparo', 'OBS_AD')
	dw_2.SetItem(fila,'reparos_ficha_linea_texto',observaciones)			
	dw_2.SetItem(fila,'reparos_ficha_linea_observaciones','')			
end if

observaciones=dw_3.GetItemString(1,'obs_doc_tecnic')
for i=1 to dw_inc_tec.rowcount()
	dw_inc_tec.SetItem(i,'reparos_ficha_linea_id_reparo_linea',f_siguiente_numero('ID_REPARO_LINEA',10))
	dw_inc_tec.SetItem(i,'reparos_ficha_linea_id_reparo_ficha',id_reparo_ficha)
	dw_inc_tec.SetItem(i,'reparos_ficha_linea_observaciones',observaciones)
	dw_inc_tec.SetItem(i,'reparos_ficha_linea_codigo_reparo','TEC')

next

// METEMOS LAS OBSERVACIONES COMO UNA NUEVA LINEA
if not(f_es_vacio(observaciones)) then
	fila=dw_inc_tec.insertrow(0)
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_id_reparo_linea',f_siguiente_numero('ID_REPARO_LINEA',10))
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_id_reparo_ficha',id_reparo_ficha)
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_codigo_reparo', 'OBS_TEC')
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_texto',observaciones)						
	dw_inc_tec.SetItem(fila,'reparos_ficha_linea_observaciones','')			
end if

if dw_2.rowcount()=0 and dw_inc_tec.rowcount()=0 then
	MessageBox("Atencion!","No se han insertado reparos")
	return
end if

if dw_2.rowcount()>0 then dw_2.update()
if dw_inc_tec.rowcount()>0 then dw_inc_tec.update()

this.enabled=false
cb_imprimir.enabled=true
//dw_2.SetItem(fila,'reparos_ficha_linea_id_reparo_ficha', id_reparo_ficha)) //  dw_ficha.Getitemstring(dw_ficha.getrow(),'id_reparo_ficha'))


end event

type dw_inc_tec from u_dw within w_gestor_documental_cc
integer x = 32
integer y = 2184
integer width = 3589
integer height = 520
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_reparos_linea"
end type

event doubleclicked;call super::doubleclicked;if row>0 then this.deleterow(row)

dw_3.event csd_ocultar_obs()
end event

type dw_3 from u_dw within w_gestor_documental_cc
event csd_ocultar_obs ( )
integer x = 14
integer y = 1460
integer width = 1705
integer height = 772
integer taborder = 21
string dataobject = "d_gestor_documental_obs"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event csd_ocultar_obs();// COMENTADO.
// Se realiz$$HEX2$$f3002000$$ENDHEX$$por la Incidencia ICC-31 y m$$HEX1$$e100$$ENDHEX$$s tarde se volvi$$HEX2$$f3002000$$ENDHEX$$a pedir que se mostrara

/*
if dw_2.rowcount()>0 then
	this.object.t_1.visible=true
	this.object.t_obs_adm.visible=true
else
	this.object.t_1.visible=false
	this.object.t_obs_adm.visible=false	
end if
if dw_inc_tec.rowcount()>0 then
	this.object.obs_doc_admin_t.visible=true
	this.object.t_obs_tec.visible=true
else
	this.object.obs_doc_admin_t.visible=false
	this.object.t_obs_tec.visible=false	
end if
*/
end event

event doubleclicked;call super::doubleclicked;string obser, columna
choose case dwo.name
	case 't_obs_tec'
		columna='obs_doc_tecnic'
	case 't_obs_adm'
		columna='obs_doc_admin'
end choose

if dwo.name='t_obs_tec' or dwo.name='t_obs_adm' then
	g_busqueda.titulo="Observaciones"
	obser    =this.GetItemString(1, columna)
	openwithparm(w_observaciones, obser)
	if Message.Stringparm <> '-1' then
		obser = Message.Stringparm
		if not isnull(obser) then dw_3.SetItem(1,columna,obser)
	end if		
end if
end event

type cb_imprimir from commandbutton within w_gestor_documental_cc
integer x = 2203
integer y = 2728
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;parent.event csd_imprimir(false)

end event

type cb_borrar_adm from commandbutton within w_gestor_documental_cc
integer x = 3319
integer y = 1472
integer width = 297
integer height = 92
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Inc."
end type

event clicked;long i

for i=dw_2.rowcount() to 1 step -1
	dw_2.deleterow(i)
next
end event

type cb_borrar_tec from commandbutton within w_gestor_documental_cc
integer x = 3323
integer y = 2096
integer width = 293
integer height = 92
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar Inc."
end type

event clicked;long i

for i=dw_inc_tec.rowcount() to 1 step -1
	dw_inc_tec.deleterow(i)
next
end event

type dw_impresion from u_dw within w_gestor_documental_cc
boolean visible = false
integer x = 1358
integer y = 128
integer width = 2016
integer height = 1212
integer taborder = 11
boolean bringtotop = true
boolean ib_isupdateable = false
end type

