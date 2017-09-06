HA$PBExportHeader$w_certificados_rtf.srw
forward
global type w_certificados_rtf from w_response
end type
type cb_5 from commandbutton within w_certificados_rtf
end type
type cb_8 from commandbutton within w_certificados_rtf
end type
type cb_6 from commandbutton within w_certificados_rtf
end type
type cb_4 from commandbutton within w_certificados_rtf
end type
type cb_3 from commandbutton within w_certificados_rtf
end type
type st_3 from statictext within w_certificados_rtf
end type
type sle_2 from singlelineedit within w_certificados_rtf
end type
type cb_9 from commandbutton within w_certificados_rtf
end type
type cb_10 from commandbutton within w_certificados_rtf
end type
type cb_7 from commandbutton within w_certificados_rtf
end type
type sle_3 from singlelineedit within w_certificados_rtf
end type
type cb_11 from commandbutton within w_certificados_rtf
end type
type cb_12 from commandbutton within w_certificados_rtf
end type
type sle_4 from singlelineedit within w_certificados_rtf
end type
type gb_1 from groupbox within w_certificados_rtf
end type
type cbx_1 from checkbox within w_certificados_rtf
end type
type dw_3 from datawindow within w_certificados_rtf
end type
type cb_mailing from commandbutton within w_certificados_rtf
end type
type dw_emails from datawindow within w_certificados_rtf
end type
type rte_1 from u_rte within w_certificados_rtf
end type
type dw_mailing from u_dw within w_certificados_rtf
end type
end forward

global type w_certificados_rtf from w_response
integer width = 3653
integer height = 2504
string title = "Gesti$$HEX1$$f300$$ENDHEX$$n de Escritos"
boolean controlmenu = false
windowstate windowstate = maximized!
event csd_imprimir ( )
event csd_cargar_etiquetas ( )
cb_5 cb_5
cb_8 cb_8
cb_6 cb_6
cb_4 cb_4
cb_3 cb_3
st_3 st_3
sle_2 sle_2
cb_9 cb_9
cb_10 cb_10
cb_7 cb_7
sle_3 sle_3
cb_11 cb_11
cb_12 cb_12
sle_4 sle_4
gb_1 gb_1
cbx_1 cbx_1
dw_3 dw_3
cb_mailing cb_mailing
dw_emails dw_emails
rte_1 rte_1
dw_mailing dw_mailing
end type
global w_certificados_rtf w_certificados_rtf

type variables
n_cst_filesrvwin32 dire
datastore ids_etiqueta

st_certificados_paso_param param

string i_apli,i_id_apli,i_cod_apli,i_n,i_v,i_tipo,i_anio,i_cadena,i_cod_escrito, i_ruta_generado,i_adjuntos_full
long i_i,i_j
boolean i_estadoa,i_grabado,i_grab,i_se_ha_grabado
integer i_pagina
end variables

event csd_imprimir;int i,j,pos
double datonum
datetime datofecha
string etiqueta, valor, cadena, dato, tipo, campo

printsetup()

if g_rtf_paso_param.id_lista_colegiados <> '' then
	dw_3.settransobject(SQLCA)
	dw_3.retrieve(g_rtf_paso_param.id_lista_colegiados)
	for i =1 to dw_3.rowcount()
		
		//cabecera			  
		rte_1.selecttext(1,1,0,0,header!)	
		if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
			rte_1.InputFieldInsert("pagina")
		end if
		if rte_1.find('[FECHA]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("fecha")
		end if
		if rte_1.find('[NREG]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("nreg")
		end if
		rte_1.showheadfoot(false)
		//detalle
		if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
			rte_1.InputFieldInsert("pagina")
		end if
		if rte_1.find('[FECHA]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("fecha")
		end if
		if rte_1.find('[NREG]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("nreg")
		end if
		//pie
		rte_1.selecttext(1,1,0,0,footer!)	
		if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
			rte_1.InputFieldInsert("pagina")
		end if
		if rte_1.find('[FECHA]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("fecha")
		end if
		if rte_1.find('[NREG]',true,true,false,false) > 0 then
			rte_1.replacetext('')
			rte_1.InputFieldInsert("nreg")
		end if
		rte_1.showheadfoot(false)		
		
		rte_1.selecttext(1,1,0,0,Detail!)	
		for j=1 to ids_etiqueta.rowcount()
			etiqueta=ids_etiqueta.getitemstring(j,'etiqueta')
			campo=ids_etiqueta.getitemstring(j,'campo')

			tipo=dw_3.Describe(campo+".ColType")

			CHOOSE CASE upper(LeftA(tipo ,2))
				CASE 'CH' 
					// El campo es de tipo string
					dato = dw_3.GetItemString(i, campo)
				CASE 'DA' 
					// El campo es de tipo datetime
					datofecha =  dw_3.GetItemDateTime(i, campo)
					if isnull(datofecha) then
						dato = ''
					else
						dato=string(datofecha,'dd/mm/yyyy')
					end if
				CASE 'NU'	,'RE', 'DE'
					//Campo de tipo num$$HEX1$$e900$$ENDHEX$$rico, posiblemente con decimales
					DatoNum = dw_3.GetItemNumber(i, campo)
					dato = string((DatoNum))
					// Reemplazamos las comas por puntos	
						long posicion
						posicion = 0
						DO
							posicion = PosA(dato,',',posicion+1)
							if isnull(posicion) then posicion = 0
							if posicion > 0 then
								dato=ReplaceA(dato,posicion, 1,".")
							end if	
						LOOP UNTIL posicion = 0
				CASE ELSE
					//Campo de tipo num$$HEX1$$e900$$ENDHEX$$rico
					DatoNum = dw_3.GetItemNumber(i, campo)
					dato = string(Long(DatoNum))
			END CHOOSE
			valor= dato //dw_3.getitemnumber(i,campo)
			if isnull(valor) then valor=' '
			if rte_1.Find('[' + etiqueta + ']', TRUE, TRUE, TRUE, FALSE) > 0 then
				rte_1.ReplaceText(valor)
				pos=rte_1.FindNext()
				do while pos > 0
					rte_1.ReplaceText(valor)
					pos=rte_1.FindNext()
				loop
			end if
		next
		rte_1.print(integer(sle_4.text),"", true, TRUE)
		rte_1.InsertDocument(i_ruta_generado, TRUE, FileTypeRichText!)
	next
else

	//cabecera			  
	rte_1.selecttext(1,1,0,0,header!)	
	if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
		rte_1.InputFieldInsert("pagina")
	end if
	if rte_1.find('[FECHA]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("fecha")
	end if
	if rte_1.find('[NREG]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("nreg")
	end if
	rte_1.showheadfoot(false)
	//detalle
	if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
		rte_1.InputFieldInsert("pagina")
	end if
	if rte_1.find('[FECHA]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("fecha")
	end if
	if rte_1.find('[NREG]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("nreg")
	end if
	//pie
	rte_1.selecttext(1,1,0,0,footer!)	
	if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
		rte_1.InputFieldInsert("pagina")
	end if
	if rte_1.find('[FECHA]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("fecha")
	end if
	if rte_1.find('[NREG]',true,true,false,false) > 0 then
		rte_1.replacetext('')
		rte_1.InputFieldInsert("nreg")
	end if
	rte_1.showheadfoot(false)	
	rte_1.print(integer(sle_4.text),"", true, TRUE)	
	rte_1.InsertDocument(i_ruta_generado, TRUE, FileTypeRichText!)
end if
rte_1.modified=false
end event

event csd_cargar_etiquetas;string s1,t1,s2,t2,n1,n2,f1,f2


ids_etiqueta = create datastore
ids_etiqueta.dataobject='d_etiquetas'
ids_etiqueta.settransobject(SQLCA)

ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','NUMERO')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','N$$HEX1$$fa00$$ENDHEX$$mero del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','numero')
ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','NOMBRE')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Nombre del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','nombre')
ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','APELLIDOS')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Apellidos del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','apellidos')
ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','DIRECCION')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Direcci$$HEX1$$f300$$ENDHEX$$n del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','direccion')
ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','COD-POST')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','C$$HEX1$$f300$$ENDHEX$$digo postal de la direcci$$HEX1$$f300$$ENDHEX$$n del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','cod_post')
ids_etiqueta.insertrow(0)
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta','POBLACION')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Poblacion y provincia de la direcci$$HEX1$$f300$$ENDHEX$$n del Colegiado')
ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','poblacion')

SELECT obs,textocorto2,princ_num,num2,princ_fecha,f2,princ_sn,sn2  
   INTO :t1,:t2,:n1,:n2,:f1,:f2,:s1,:s2 FROM listas_colegiados WHERE listas_colegiados.id_lista = :g_rtf_paso_param.id_lista_colegiados;

if not isnull(t1) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(t1))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l1')
end if
if not isnull(t2) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(t2))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l2')
end if
if not isnull(n1) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(n1))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l3')
end if
if not isnull(n2) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(n2))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l4')
end if
if not isnull(f1) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(f1))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l5')
end if
if not isnull(f2) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(f2))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l6')
end if
if not isnull(s1) then
	ids_etiqueta.insertrow(0)

	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(s1))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l7')
end if
if not isnull(s2) then
	ids_etiqueta.insertrow(0)
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'etiqueta',upper(s2))
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'descripcion','Campo de la lista de colegiados')
	ids_etiqueta.setitem(ids_etiqueta.rowcount(),'campo','l8')
end if
end event

on w_certificados_rtf.create
int iCurrent
call super::create
this.cb_5=create cb_5
this.cb_8=create cb_8
this.cb_6=create cb_6
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_3=create st_3
this.sle_2=create sle_2
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_7=create cb_7
this.sle_3=create sle_3
this.cb_11=create cb_11
this.cb_12=create cb_12
this.sle_4=create sle_4
this.gb_1=create gb_1
this.cbx_1=create cbx_1
this.dw_3=create dw_3
this.cb_mailing=create cb_mailing
this.dw_emails=create dw_emails
this.rte_1=create rte_1
this.dw_mailing=create dw_mailing
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.cb_8
this.Control[iCurrent+3]=this.cb_6
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_2
this.Control[iCurrent+8]=this.cb_9
this.Control[iCurrent+9]=this.cb_10
this.Control[iCurrent+10]=this.cb_7
this.Control[iCurrent+11]=this.sle_3
this.Control[iCurrent+12]=this.cb_11
this.Control[iCurrent+13]=this.cb_12
this.Control[iCurrent+14]=this.sle_4
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.cbx_1
this.Control[iCurrent+17]=this.dw_3
this.Control[iCurrent+18]=this.cb_mailing
this.Control[iCurrent+19]=this.dw_emails
this.Control[iCurrent+20]=this.rte_1
this.Control[iCurrent+21]=this.dw_mailing
end on

on w_certificados_rtf.destroy
call super::destroy
destroy(this.cb_5)
destroy(this.cb_8)
destroy(this.cb_6)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_7)
destroy(this.sle_3)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.sle_4)
destroy(this.gb_1)
destroy(this.cbx_1)
destroy(this.dw_3)
destroy(this.cb_mailing)
destroy(this.dw_emails)
destroy(this.rte_1)
destroy(this.dw_mailing)
end on

event open;string fichero,cod,directorio,op,va,xx,select_,form_,where_,sql,id_fase,id_aplicacion
int i

rte_1.TopMargin = 1000
rte_1.BottomMargin = 1000
rte_1.LeftMargin = 1000
rte_1.RightMargin = 1000


if g_piedepagina=true then
	cb_10.enabled=true
else
	cb_10.enabled=false
end if
i_se_ha_grabado=false
i_grabado=false
i_grab=false

i_apli=g_rtf_paso_param.campo1	  // identificador del modulo que llama a la ventana	
i_id_apli=g_rtf_paso_param.campo2  // generado que se recupera. 8 caracteres
i_cod_apli=g_rtf_paso_param.campo3 // plantilla que se tiene que recuperar. 8 caracteres
i_tipo=g_rtf_paso_param.campo4
i_anio=g_rtf_paso_param.campo5
id_fase=g_rtf_paso_param.campo6
i_cod_escrito=g_rtf_paso_param.campo7 // codigo del documento generado y directorio. 3 caracteres

rte_1.event pfc_clear()

choose case i_apli
		
	case '0000000002' //Modulo de actas y circulares
		
		if i_tipo = '2' then
			op='Grabado'
			directorio=g_directorio_generados + i_cod_escrito + '\' + i_anio + '\'
			cb_3.text='Guardar como'
			cb_9.visible=false			
			rte_1.InsertDocument(directorio + i_id_apli + '.rtf', TRUE, FileTypeRichText!)
			i_ruta_generado=directorio + i_id_apli + '.rtf'
		else
			op='Normal' 
			cb_3.visible=false
			cb_9.visible=false			
			rte_1.InsertDocument(g_directorio_rtf + i_cod_apli + '.rtf', TRUE, FileTypeRichText!)
		end if
		
		i_grabado=true
		rte_1.modified=false			
		
	case '0000000005' // M$$HEX1$$f300$$ENDHEX$$dulo de certificados
		
		if i_tipo = '2' then
			
			op='Grabado'
			directorio=g_directorio_generados + i_cod_escrito + '\' + i_anio + '\'
			fichero=i_id_apli
			i_ruta_generado=directorio + fichero + '.rtf'
			cb_3.text='Guardar como'
			cb_9.visible=false		
			i_grab=false
		else
			op='Normal'
			directorio=g_directorio_rtf	
			fichero=i_cod_apli
		end if
			
		rte_1.event pfc_clear()

		if (rte_1.InsertDocument(directorio + fichero + '.rtf', false, FileTypeRichText!))=1 then
			
			if op='Normal' then
				
				id_aplicacion=f_rellenar_ceros(10,i_id_apli)
			
			  DECLARE variable CURSOR FOR  
			  SELECT escritos_variables.nombre,   
						escritos_variables.valor  
				 FROM escritos_variables  
				WHERE escritos_variables.id_escrito = :id_aplicacion ;
			
			  Open variable;
			  
			  DO WHILE sqlca.sqlcode = 0
				
					fetch variable into :i_n, :i_v ;
					
					if isnull(i_v) or i_v='' then
						if g_combino_vble_rtf=false then
							i_v=' '
						else
							i_v=i_n
						end if
					end if
					if rte_1.Find('[' + i_n + ']', TRUE, TRUE, TRUE, FALSE) > 0 then
						rte_1.ReplaceText(i_v)
						i_i=rte_1.FindNext()
						do while i_i > 0
							rte_1.ReplaceText(i_v)
							i_i=rte_1.FindNext()
						loop
					end if
			  loop
			  Close variable;
			  i_grabado=true
			else
				rte_1.modified=false			  
			end if
		end if
	case '0000000011' // Mantenimiento de escritos

		rte_1.event pfc_clear()
		fichero=i_id_apli + '.rtf'
		if i_tipo = '1' then
			if rte_1.InsertDocument(g_directorio_rtf + fichero, TRUE, FileTypeRichText!) = 1 then
				cb_9.visible=false //Ver plantilla
			end if
		end if
		rte_1.modified=false  
		cb_3.visible=false	//Combinar Datos
		cb_9.text='Importar'  
		cb_6.enabled=false //Grabar		
		i_grabado=false
		i_grab=true
		
	case '0000000012' // M$$HEX1$$f300$$ENDHEX$$dulo de Fases (INFORMES)
		if MidA(message.stringparm,11,1) = '*' then
			i_cod_apli=MidA(g_ruta_rtf,LenA(g_ruta_rtf) - 22,3)
			i_cod_apli='0000000' + i_cod_apli
			i_anio=MidA(g_ruta_rtf,LenA(g_ruta_rtf) - 18,4)
			i_id_apli=MidA(g_ruta_rtf,LenA(g_ruta_rtf) - 13,10)
			rte_1.InsertDocument(g_ruta_rtf, TRUE, FileTypeRichText!)
		else
			directorio=g_directorio_rtf
			fichero=i_cod_apli
			op='Grabado'
			cb_3.text='Guardar como'
			cb_9.visible=false		
			i_grab=false		
			rte_1.event pfc_clear()
			if (rte_1.InsertDocument(directorio + fichero + '.rtf', TRUE, FileTypeRichText!))=1 then	
				string val,tipo
				for i=1 to 50
					va=g_dw_impresos.describe("#" + string(i) + ".Name")
					tipo=g_dw_impresos.describe("#" + string(i) + ".ColType")
					IF g_dw_impresos.describe("#" + string(i) + ".ColType") = "number" THEN
						val=string(g_dw_impresos.getitemnumber(1,va))
					END IF	
					IF LeftA(g_dw_impresos.describe("#" + string(i) + ".ColType"),4) = "char" THEN
						val=g_dw_impresos.getitemstring(1,va)
					END IF	
					IF g_dw_impresos.describe("#" + string(i) + ".ColType") = "datetime" THEN
						val=string(g_dw_impresos.getitemdatetime(1,va),'dd/mm/yyyy')
					END IF															
					if rte_1.Find('[' + va + ']', TRUE, TRUE, TRUE, FALSE) > 0 then
						if upper(va) = 'FECHA_C' then val=string(today(),'dd/mm/yyyy')
						if upper(va) = 'FECHA_L' then val=string(today(),'d-mmm-yy')
						rte_1.ReplaceText(val)
						i_i=rte_1.FindNext()
						do while i_i > 0
							rte_1.ReplaceText(val)
							i_i=rte_1.FindNext()
						loop
					end if	
				next 
			end if
		end if
end choose
if g_rtf_paso_param.id_lista_colegiados <>''  then
	cbx_1.visible=true
	rte_1.popmenu=false	
	this.triggerevent ('csd_cargar_etiquetas')
end if
rte_1.setfocus()
end event

event close;call super::close;destroy ids_etiqueta
end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_certificados_rtf
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_certificados_rtf
end type

type cb_5 from commandbutton within w_certificados_rtf
integer x = 1573
integer y = 2228
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;long l1,c1,l2,c2,i
string  cadena, id_lista_colegiados
i_pagina=1

rte_1.SaveDocument(i_ruta_generado, FileTypeRichText!)
rte_1.InsertDocument(i_ruta_generado, TRUE, FileTypeRichText!)
//cabecera			  
rte_1.selecttext(1,1,0,0,header!)	
if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
	open(w_certificados_paginacion)
	i_pagina=double(message.stringparm)
end if
rte_1.showheadfoot(false)
//detalle
if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
	open(w_certificados_paginacion)
	i_pagina=double(message.stringparm)
end if
//pie
rte_1.selecttext(1,1,0,0,footer!)	
if rte_1.find('[PAGINA]',true,true,false,false) > 0 then
	open(w_certificados_paginacion)
	i_pagina=double(message.stringparm)
end if
parent.triggerevent ('csd_imprimir')

//rte_1.TopMargin = 2540
//rte_1.BottomMargin = 2540
//rte_1.LeftMargin = 3180
//rte_1.RightMargin = 3180

rte_1.modified=false

end event

type cb_8 from commandbutton within w_certificados_rtf
integer x = 3186
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Volver"
end type

event clicked;string val,fichero

choose case i_apli
	case '0000000002' 
		if i_grab=true then val='S' else val='N'
		if rte_1.modified=true then
			if MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n! Va a salir sin Grabar el nuevo documento', &
				Exclamation!, OKCancel!, 2) < 2 then
					closewithreturn(parent,val)
					return
			end if	
		else
			closewithreturn(parent,val)
			return
		end if
	case '0000000005' 
		if i_grab=true then 
			val='S' + i_cadena 
		else 
			val='N'
		end if
		if rte_1.modified=true then
			if MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n! Va a salir sin Grabar el nuevo documento', &
				Exclamation!, OKCancel!, 2) < 2 then
					closewithreturn(parent,val)
					return
			end if	
		else
			closewithreturn(parent,val)
			return
		end if
	case '0000000011' 
		if i_se_ha_grabado=true then val='S' + i_cadena else val='N'
		fichero=sle_2.text
		if rte_1.modified=true then
			if MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n! Va a salir sin Grabar el nuevo documento', &
				Exclamation!, OKCancel!, 2) < 2 then
					g_rtf_paso_param.campo1=val
					g_rtf_paso_param.campo2=fichero
					closewithreturn(parent,g_rtf_paso_param)
					return
			end if	
		else
			g_rtf_paso_param.campo1=val
			g_rtf_paso_param.campo2=fichero
			closewithreturn(parent,g_rtf_paso_param)
			return
		end if
	case  '0000000012'
		if i_grab=true then val='S' + g_directorio_generados + MidA(i_cod_apli,8) + '\' + i_anio + '\' + i_id_apli +'.rtf' else val='N'
		if rte_1.modified=true then
			if MessageBox(g_titulo, 'Atenci$$HEX1$$f300$$ENDHEX$$n! Va a salir sin Grabar el nuevo documento', &
				Exclamation!, OKCancel!, 2) < 2 then
					closewithreturn(parent,val)
					return
			end if	
		else
			closewithreturn(parent,val)
			return
		end if		

	case else	
end choose		



end event

type cb_6 from commandbutton within w_certificados_rtf
integer x = 2807
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;string anyo_string,ejecutable
int i,anyo,a,valor
dire = create n_cst_filesrvwin32

if i_apli='0000000005' or i_apli='0000000002' or i_apli='0000000012'  then
		
	if fileexists(g_directorio_generados + i_cod_escrito + '\' + i_anio)=false then
		//ejecutable = 'command.com /C md'
		//Run(ejecutable+' ' + g_directorio_generados + i_cod_escrito, Minimized!)
		valor=dire.of_createdirectory(g_directorio_generados + i_cod_escrito)
		anyo = integer(i_anio)
		for i= 1 to 5
		// Creamos los subdirectorios para los anyos dentro de ese c$$HEX1$$f300$$ENDHEX$$digo de la Plantilla 
			anyo_string = '\'+string(anyo)
			//Run(ejecutable+' '+g_directorio_generados + i_cod_escrito + anyo_string, Minimized!)
			valor=dire.of_createdirectory(g_directorio_generados + i_cod_escrito + anyo_string)
			anyo++
		next 
		MessageBox(g_titulo,'Directorio :' + g_directorio_generados + i_cod_escrito + + '\' + i_anio + ' creado')			
	end if
	rte_1.SaveDocument(g_directorio_generados + i_cod_escrito + '\' + i_anio + '\' + i_id_apli +'.rtf', FileTypeRichText!)
	rte_1.SelectTextAll()
	i_cadena=rte_1.selectedtext()
	rte_1.SelectText(1,1,1,1)
	i_grabado=true
	i_grab=true
	rte_1.modified=false
end if
if i_apli='0000000011' then
	rte_1.SaveDocument(g_directorio_RTF + i_id_apli +'.rtf', FileTypeRichText!)
	rte_1.modified=false
	i_grab=true
	i_se_ha_grabado=true
end if
cb_6.enabled=false
cb_8.enabled=true
end event

type cb_4 from commandbutton within w_certificados_rtf
event csd_numero_paginas pbm_renprintheader
integer x = 2030
integer y = 2228
integer width = 389
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Presentaci$$HEX1$$f300$$ENDHEX$$n P."
end type

event clicked;int ml,mr,mt,mb
string faux
faux=sle_2.text
if cb_4.text='Presentaci$$HEX1$$f300$$ENDHEX$$n P.' then
	cb_3.enabled=false
	cb_4.text='Volver'
	cb_5.enabled=false
	cb_7.enabled=false
	cb_8.enabled=false
	cb_10.enabled=false
	cb_mailing.enabled=false
	i_estadoa=cb_9.enabled
	cb_9.enabled=false

	rte_1.preview(True)
	rte_1.modified=false	
	cb_6.enabled=false			
else
	cb_3.enabled=true
	cb_4.text='Presentaci$$HEX1$$f300$$ENDHEX$$n P.'

	cb_5.enabled=true
	cb_6.enabled=true
	cb_7.enabled=true
	cb_8.enabled=true
	cb_9.enabled=i_estadoa
	cb_mailing.enabled=true
	rte_1.preview(false)
	rte_1.modified=false	
	if i_apli <> '0000000005' then
		cb_6.enabled=false	
	end if
	if g_piedepagina=true then
		cb_10.enabled=true
	else
		cb_10.enabled=false
	end if	
	i_grabado=true
end if
sle_2.text=faux
end event

type cb_3 from commandbutton within w_certificados_rtf
integer x = 59
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Combinar Datos"
end type

event clicked;int i
string id_aplicacion

if cb_3.text='Combinar Datos' then
	if (MessageBox(g_titulo, &
	'Esto provocar$$HEX2$$e1002000$$ENDHEX$$la perdida de su documento actual si no lo ha Guardado, desea continuar?', &
		Exclamation!, OKCancel!, 2)) < 2 then
		
		rte_1.event pfc_clear()
		if (rte_1.InsertDocument(g_directorio_rtf + i_cod_apli + '.rtf', TRUE, FileTypeRichText!))=1 then
			
			id_aplicacion=f_rellenar_ceros(10,i_id_apli)
			
			  DECLARE variable CURSOR FOR  
			  SELECT escritos_variables.nombre,   
						escritos_variables.valor  
				 FROM escritos_variables  
				WHERE escritos_variables.id_escrito = :id_aplicacion ;
			
			  Open variable;
			  
			  DO WHILE sqlca.sqlcode = 0
				
					fetch variable into :i_n, :i_v ;
					
					if rte_1.Find('[' + i_n + ']', TRUE, TRUE, TRUE, FALSE) > 0 then
						rte_1.ReplaceText(i_v)
						i_i=rte_1.FindNext()
						do while i_i > 0
							rte_1.ReplaceText(i_v)
							i_i=rte_1.FindNext()
						loop
					end if
			  loop
			  Close variable;
	
		end if
		rte_1.modified=false	
		cb_9.enabled=true
		if i_apli <> '0000000005' then
			cb_6.enabled=false	
		end if
	end if
else
	long cancelar
	string fichero,fichero2
	n_cst_filesrvwin32 cambia_directorio
	string directorio
	cambia_directorio = create n_cst_filesrvwin32
	directorio = cambia_directorio.of_getcurrentdirectory()
	// FIN MODIFICADO RICARDO 04-03-02	
	cancelar=getfilesavename('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero', fichero2, fichero, "rtf", "Archivos (*.RTF),*.RTF")
	rte_1.savedocument(fichero,FileTypeRichText! )
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	
end if
end event

type st_3 from statictext within w_certificados_rtf
integer x = 64
integer y = 2108
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
string text = "Documento :"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_certificados_rtf
boolean visible = false
integer x = 498
integer y = 1992
integer width = 146
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_9 from commandbutton within w_certificados_rtf
integer x = 434
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ver Plantilla"
end type

event clicked;if cb_9.text='Ver Plantilla' then
	if (MessageBox(g_titulo, &
	'Esto provocar$$HEX2$$e1002000$$ENDHEX$$la perdida de su documento actual si no lo ha Guardado, desea continuar?', &
		Exclamation!, OKCancel!, 2)) < 2 then
		
		rte_1.event pfc_clear()
		rte_1.InsertDocument(g_directorio_rtf + i_cod_apli + '.rtf', TRUE, FileTypeRichText!)
		cb_9.enabled=false
	end if
else
	string ruta,fichero
	long cancelar

	n_cst_filesrvwin32 cambia_directorio
	string directorio
	cambia_directorio = create n_cst_filesrvwin32
	directorio = cambia_directorio.of_getcurrentdirectory()
	// FIN MODIFICADO RICARDO 04-03-02
	
	cancelar=getfileopenname('Selecci$$HEX1$$f300$$ENDHEX$$n del fichero',ruta, fichero,"Archivos (*.RTF),*.RTF")
	if cancelar = 1 then
		//messagebox('',g_directorio_rtf + fichero + ' -- ' + ruta)
		rte_1.event pfc_clear()
		rte_1.InsertDocument(g_directorio_rtf + fichero, TRUE, FileTypeRichText!)		
		sle_2.text=fichero
		rte_1.modified=false
		cb_6.enabled=true
	end if
	
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
	
end if
end event

type cb_10 from commandbutton within w_certificados_rtf
integer x = 2432
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cabecera/Pie"
end type

event clicked;if cb_10.text = 'Cabecera/Pie' then
	cb_3.enabled=false
	cb_4.enabled=false
	cb_5.enabled=false
	cb_6.enabled=false
	cb_7.enabled=false
	cb_8.enabled=false
	cb_mailing.enabled=false
	i_estadoa=cb_9.enabled
	cb_9.enabled=false	
	
	rte_1.ShowHeadFoot(true)
	cb_10.text = 'Detalle'
else
	cb_3.enabled=true
	cb_4.enabled=true
	cb_5.enabled=true
	cb_6.enabled=true
	cb_7.enabled=true
	cb_8.enabled=true
	cb_9.enabled=i_estadoa
	cb_mailing.enabled=true	
	rte_1.ShowHeadFoot(false)
	cb_10.text = 'Cabecera/Pie'	
end if
end event

type cb_7 from commandbutton within w_certificados_rtf
integer x = 814
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ortograf$$HEX1$$ed00$$ENDHEX$$a"
end type

event clicked;oleobject ole_object
boolean lb_booleanval,seguir_comprobando
any anyval
string ls_holdtype
string ls_holdtext,boton
double ls_doubleval
datetime datetimeval
//This will copy the contents of the mle to a cell in the excel spreadsheet .
//After the spreadsheet has been spellchecked, its contents will be copied back
//to the mle.

integer lin,c,i,j
string cadena,caracter,p

this.enabled=false

//create a local ole object
Ole_object = create oleobject

//connect the ole object to excel
If ole_object.ConnectToNewObject("excel.application") <> 0 Then
	Messagebox("OLE Error","Could not connect to Excel")
	Return
End If

//Insert a new book into the spreadsheet
ole_object.workbooks.add()

seguir_comprobando=true
lin=rte_1.linecount()
for i=1 to lin
	if LenA(cadena) > 0 then
		rte_1.selecttext(i,j - LenA(cadena),i,j - LenA(cadena))
		rte_1.find(cadena,TRUE, TRUE, true, false)
		sle_3.text= cadena

										setpointer(hourglass!)
									
										//set the first cell to the contents of the mle
										ole_object.activesheet.cells(1,1).value = sle_3.text
										
										//invoke the spellchecker
										seguir_comprobando =	ole_object.activesheet.checkspelling

										//get the results of the spellchecker back
										anyval = ole_object.activesheet.cells(1,1).value
										
										//identify the type of data returned. Data returned may be string, numeric, or date
										//Find out which one it was and then assign it to a string
										ls_holdtype = classname(anyval)
										choose case ls_holdtype
											 case "boolean"
													lb_booleanval = anyval
													if lb_booleanval then
													  ls_holdtext = "TRUE"
													else
													  ls_holdtext = "FALSE"
													end if
												case "integer", "long", "float", "double", "decimal", "time"
													ls_doubleval   =  anyval
													ls_holdtext = string(ls_doubleval)
												case "string"
													ls_holdtext = anyval
												case "date", "datetime"
													datetimeval = anyval
													ls_holdtext = string(datetimeval)
										end choose
										
										//copy the string to the mle
										sle_3.text = ls_holdtext
										
										//set the workbook status to saved so you can quit without prompting to save
										ole_object.activeworkbook.saved=true
										
				rte_1.ReplaceText(sle_3.text)
				cadena=''	
	end if
	rte_1.selecttext(i,1,i,1)
	c=rte_1.LineLength()
	cadena=''
	for j=1 to c
		rte_1.selecttext(i,j,i,j)
		caracter=rte_1.selectedtext()
		if caracter <> '.' and caracter <> ',' and caracter <> ';' and caracter <> ' ' and caracter <> cr and not isnull(caracter) then
			cadena=cadena + caracter
			if caracter=p then
				caracter=caracter
			end if
		else
			rte_1.selecttext(i,j - LenA(cadena),i,j - LenA(cadena))
			rte_1.find(cadena,TRUE, TRUE, true, false)
			if caracter = ' ' and LenA(cadena) > 0 then
				sle_3.text= cadena
				
										setpointer(hourglass!)
				
										//set the first cell to the contents of the mle
										ole_object.activesheet.cells(1,1).value = sle_3.text
										
										//invoke the spellchecker
										seguir_comprobando =	ole_object.activesheet.checkspelling
										
										//get the results of the spellchecker back
										anyval = ole_object.activesheet.cells(1,1).value
										
										//identify the type of data returned. Data returned may be string, numeric, or date
										//Find out which one it was and then assign it to a string
										ls_holdtype = classname(anyval)
										choose case ls_holdtype
											 case "boolean"
												lb_booleanval = anyval
												if lb_booleanval then
												  ls_holdtext = "TRUE"
												else
												  ls_holdtext = "FALSE"
												end if
												
												case "integer", "long", "float", "double", "decimal", "time"
												ls_doubleval   =  anyval
												ls_holdtext = string(ls_doubleval)
										
												case "string"
												ls_holdtext = anyval
										
												case "date", "datetime"
												datetimeval = anyval
												ls_holdtext = string(datetimeval)
										
										end choose
										
										//copy the string to the mle
										sle_3.text = ls_holdtext
										
										//set the workbook status to saved so you can quit without prompting to save
										ole_object.activeworkbook.saved=true
				rte_1.ReplaceText(sle_3.text)
			end if
			cadena=''
		end if
		if seguir_comprobando=false then
			j=c+1
			i=lin+1
		end if
	next
next	
//quit excel
ole_object.application.quit()

//disconnect the object
ole_object.disconnectobject()

//free the memory
destroy ole_object	

rte_1.selecttext(1,1,1,1)
this.enabled=true


end event

type sle_3 from singlelineedit within w_certificados_rtf
boolean visible = false
integer x = 713
integer y = 1992
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_11 from commandbutton within w_certificados_rtf
integer x = 1947
integer y = 2228
integer width = 64
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;if sle_4.text < '99' then
	sle_4.text= string(integer(sle_4.text) + 1 , '00')
end if
end event

type cb_12 from commandbutton within w_certificados_rtf
integer x = 1947
integer y = 2272
integer width = 64
integer height = 44
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "-"
end type

event clicked;if sle_4.text > '01' then
	sle_4.text= string(integer(sle_4.text) - 1 , '00')
end if
end event

type sle_4 from singlelineedit within w_certificados_rtf
integer x = 1842
integer y = 2228
integer width = 105
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "01"
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

event losefocus;sle_4.text= string(integer(sle_4.text) , '00')

end event

type gb_1 from groupbox within w_certificados_rtf
integer x = 41
integer y = 2160
integer width = 3575
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_certificados_rtf
boolean visible = false
integer x = 3186
integer y = 2052
integer width = 402
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 67108864
string text = "Etiquetas"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if cbx_1.checked=true then
	rte_1.popmenu=false	
else
	rte_1.popmenu=true
end if

end event

type dw_3 from datawindow within w_certificados_rtf
boolean visible = false
integer x = 1335
integer y = 1992
integer width = 411
integer height = 64
boolean bringtotop = true
string title = "none"
string dataobject = "d_certificados_recuperacion_datos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_mailing from commandbutton within w_certificados_rtf
integer x = 1193
integer y = 2228
integer width = 366
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Mailing"
end type

event clicked;string para,asunto,mail,adjuntos
string destinatarios, email_col
int i

if cb_mailing.text='Mailing' then
	
	cb_3.enabled=false
	cb_4.enabled=false
	cb_5.enabled=false
	cb_6.enabled=false
	cb_7.enabled=false
	cb_8.enabled=false
	cb_9.enabled=false		
	cb_10.enabled=false

	cb_mailing.text='Volver' 	
	if g_rtf_paso_param.id_lista_colegiados <> '' then
		dw_emails.settransobject(SQLCA)
		dw_emails.retrieve(g_rtf_paso_param.id_lista_colegiados)
		for i=1 to dw_emails.rowcount()
			email_col=dw_emails.getitemstring(i,'email')
			if not isnull(email_col) and email_col <> '' then
				email_col=email_col+';'
				destinatarios = destinatarios + email_col
			end if
		next
		if RightA(destinatarios,1)=';' then destinatarios=LeftA(destinatarios,LenA(destinatarios)-1)
		if destinatarios='' then
			messagebox('','Ninguno de los colegiados tiene direcci$$HEX1$$f300$$ENDHEX$$n e-mai, no se puede mandar.')
			cb_mailing.event clicked()
			return
		end if
		dw_mailing.insertrow(0)
		dw_mailing.setitem(1,'destinatario',destinatarios)
		dw_mailing.setitem(1,'ficheros_adjuntos',RightA(i_ruta_generado,12))
		i_adjuntos_full=i_ruta_generado
		dw_mailing.visible=true
		dw_mailing.setfocus()
	end if
		
else
	cb_mailing.text='Mailing'
	dw_mailing.visible=false
	dw_mailing.reset()
	cb_3.enabled=true
	cb_4.enabled=true
	cb_5.enabled=true
	cb_6.enabled=true
	cb_7.enabled=true
	cb_8.enabled=true
	cb_9.enabled=true		
	cb_10.enabled=true		
end if
end event

type dw_emails from datawindow within w_certificados_rtf
boolean visible = false
integer x = 1120
integer y = 2008
integer width = 475
integer height = 104
boolean bringtotop = true
string title = "none"
string dataobject = "d_certificados_mailing_emails"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rte_1 from u_rte within w_certificados_rtf
integer x = 32
integer y = 40
integer width = 3566
integer height = 1908
integer taborder = 40
boolean bringtotop = true
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_inputfieldsvisible = true
boolean init_inputfieldnamesvisible = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_headerfooter = true
boolean init_popmenu = true
long init_leftmargin = 10
long init_topmargin = 10
long init_rightmargin = 10
long init_bottommargin = 10
boolean ib_ignorefileexists = true
end type

event modified;i_grabado=false
cb_6.enabled=true
if cb_9.text <> 'Importar' then
	sle_2.text=''
end if
end event

event printfooter;if i_pagina <= currentpage then 
	rte_1.InputFieldChangeData ("pagina", string(currentpage) )
else
	rte_1.InputFieldChangeData ("pagina", ' ')
end if
rte_1.InputFieldChangeData ("fecha", string(today(),'dd/mm/yyyy'))
if isnull(g_rtf_paso_param.n_registro_es) then g_rtf_paso_param.n_registro_es=' '
rte_1.InputFieldChangeData ("nreg", g_rtf_paso_param.n_registro_es)
end event

event rbuttondown;long xx,xy
string texto
st_certificados_etiquetas etiquetas

if cbx_1.checked=true then
	
	etiquetas.ds_etiquetas=ids_etiqueta
	etiquetas.posx=rte_1.PointerX()	+ 50
	etiquetas.posy=rte_1.PointerY()	+ 100
	openwithparm(w_etiquetas,etiquetas)

	texto=rte_1.SelectedText( )
	if texto='' then
		rte_1.Position(xx, xy)
		rte_1.SelectText(xx,xy, xx,xy+1)
	end if
	if g_rtf_paso_param.etiqueta <> '' then rte_1.ReplaceText('[' + g_rtf_paso_param.etiqueta + ']')
		
end if

end event

event printheader;call super::printheader;if i_pagina <= currentpage then 
	rte_1.InputFieldChangeData ("pagina", string(currentpage) )
else
	rte_1.InputFieldChangeData ("pagina", ' ')
end if
rte_1.InputFieldChangeData ("fecha", string(today(),'dd/mm/yyyy'))
if isnull(g_rtf_paso_param.n_registro_es) then g_rtf_paso_param.n_registro_es=' '
rte_1.InputFieldChangeData ("nreg", g_rtf_paso_param.n_registro_es)
end event

type dw_mailing from u_dw within w_certificados_rtf
event csd_enter pbm_dwnprocessenter
boolean visible = false
integer x = 32
integer y = 40
integer width = 3566
integer height = 1916
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_lista_mailing"
boolean vscrollbar = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event csd_enter;choose case this.getcolumnname() 
	case 'texto_mail' 
	case else
		//Procesamiento de la tecla intro como tab
		Post( Handle(this),256,9,0 )
		Return 1
end choose
end event

event buttonclicked;string para,asunto,mail
string fichero,origen,adjuntos,adjuntos_full

if dwo.name = 'b_adjuntar' then
	// MODIFICADO RICARDO 04-03-02
	n_cst_filesrvwin32 cambia_directorio
	string directorio
	cambia_directorio = create n_cst_filesrvwin32
	directorio = cambia_directorio.of_getcurrentdirectory()
	// FIN MODIFICADO RICARDO 04-03-02
	
	if getfileopenname('Seleccione el fichero a adjuntar...', origen, fichero) <> 0 then
		adjuntos = dw_mailing.getitemstring(1,'ficheros_adjuntos')
		if f_es_vacio(adjuntos) then 
			adjuntos = fichero
			i_adjuntos_full = origen
		else
			adjuntos = adjuntos + ';' + fichero
			i_adjuntos_full = i_adjuntos_full + ';' +origen
		end if
		dw_mailing.setitem(1,'ficheros_adjuntos',adjuntos)
	end if
	
	// MODIFICADO RICARDO 04-03-02
	// Cambiamos al directorio raiz de la aplicacion, como corresponde estar para que todas las imagenes sigan funcionando
	cambia_directorio.of_changedirectory(directorio)
	destroy cambia_directorio
	// FIN MODIFICADO RICARDO 04-03-02
end if

if dwo.name = 'b_enviar' then

	if MessageBox('ATENCI$$HEX1$$d300$$ENDHEX$$N', 'Se enviar$$HEX2$$e1002000$$ENDHEX$$el mailing con la cuenta que tenga establecida como predeterminada.'+cr &
	+' 	                       $$HEX1$$bf00$$ENDHEX$$Desea continuar?', Question!, YesNo!, 1) = 1 then
		dw_mailing.accepttext()
		para = dw_mailing.getitemstring(dw_mailing.getrow(),'destinatario') + ';'
		if f_es_vacio(para) then
			messagebox(g_titulo,'Debe indicar al menos un destinatario.')
			return
		end if
		asunto = dw_mailing.getitemstring(dw_mailing.getrow(),'asunto')
		mail = dw_mailing.getitemstring(dw_mailing.getrow(),'texto_mail')
		//Enviamos la direccion absoluta de los ficheros y la relativa por si hubiese
		//borrado algun fichero tras introducirlo
		adjuntos = dw_mailing.getitemstring(dw_mailing.getrow(),'ficheros_adjuntos')
		f_mailing(para,i_adjuntos_full+';',asunto,mail,adjuntos)
		cb_mailing.event clicked()
	else
		cb_mailing.event clicked()	
	end if

end if
end event

type sle_1 from w_busqueda`sle_1 within w_certificados_rtf
boolean visible = false
end type

type dw_2 from w_busqueda`dw_2 within w_certificados_rtf
end type

type st_1 from w_busqueda`st_1 within w_certificados_rtf
boolean visible = false
end type

type st_2 from w_busqueda`st_2 within w_certificados_rtf
boolean visible = false
end type

type cb_1 from w_busqueda`cb_1 within w_certificados_rtf
integer taborder = 0
end type

type cb_2 from w_busqueda`cb_2 within w_certificados_rtf
integer taborder = 0
end type

type dw_1 from w_busqueda`dw_1 within w_certificados_rtf
boolean visible = false
integer taborder = 0
end type

