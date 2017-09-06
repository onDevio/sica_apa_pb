HA$PBExportHeader$w_control_documentacion_tg.srw
forward
global type w_control_documentacion_tg from w_response
end type
type dw_1 from u_dw within w_control_documentacion_tg
end type
type cb_validar from commandbutton within w_control_documentacion_tg
end type
type cb_salir from commandbutton within w_control_documentacion_tg
end type
type dw_impresion from u_dw within w_control_documentacion_tg
end type
end forward

global type w_control_documentacion_tg from w_response
integer x = 214
integer y = 221
integer width = 2089
integer height = 2024
dw_1 dw_1
cb_validar cb_validar
cb_salir cb_salir
dw_impresion dw_impresion
end type
global w_control_documentacion_tg w_control_documentacion_tg

type variables
string i_nombre_dw
st_control_doc ist_control_doc
boolean i_visar=false


end variables

on w_control_documentacion_tg.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_validar=create cb_validar
this.cb_salir=create cb_salir
this.dw_impresion=create dw_impresion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_validar
this.Control[iCurrent+3]=this.cb_salir
this.Control[iCurrent+4]=this.dw_impresion
end on

on w_control_documentacion_tg.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_validar)
destroy(this.cb_salir)
destroy(this.dw_impresion)
end on

event open;call super::open;string modulo

f_centrar_ventana(this)

ist_control_doc=Message.PowerObjectParm

choose case ist_control_doc.modulo
	case 'CFO_OBRA_NUEVA'
		dw_1.dataobject='d_control_documentacion_cfo_obra_nueva_tg'	
		cb_validar.enabled=true
		dw_1.insertrow(0)		
	case 'CFO'
		dw_1.dataobject='d_control_documentacion_cfo_tg'	
		cb_validar.enabled=true
		dw_1.insertrow(0)		
	case else
		dw_1.insertrow(0)
		dw_1.SetItem(1,'tipo_intervencion',ist_control_doc.tipo_actuacion)		
		dw_1.post event buttonclicked(1,0,dw_1.object.b_ok)
end choose



end event

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_control_documentacion_tg
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_control_documentacion_tg
end type

type dw_1 from u_dw within w_control_documentacion_tg
event csd_rellenar_dw ( )
integer x = 41
integer y = 64
integer width = 1979
integer height = 1668
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_control_documentacion_tg"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event csd_rellenar_dw();string colegiados,nifs,n_cols

if lower(dw_impresion.describe("encargo.name")) = 'encargo' then	dw_impresion.setitem(1, 'encargo', ist_control_doc.encargo)
if lower(dw_impresion.describe("emplazamiento.name")) = 'emplazamiento' then	dw_impresion.setitem(1, 'emplazamiento', ist_control_doc.emplazamiento)

if lower(dw_impresion.describe("colegiados.name")) = 'colegiados' then	
	colegiados=ist_control_doc.nombre_col1
	if not(f_es_vacio(ist_control_doc.nombre_col2)) then colegiados += '; '+ist_control_doc.nombre_col2
	if not(f_es_vacio(ist_control_doc.nombre_col3)) then colegiados += '; '+ist_control_doc.nombre_col3	
	dw_impresion.setitem(1, 'colegiados', colegiados)	
end if

if lower(dw_impresion.describe("nifs.name")) = 'nifs' then	
	nifs=ist_control_doc.nif1
	if not(f_es_vacio(ist_control_doc.nif2)) then nifs += '; '+ist_control_doc.nif2
	if not(f_es_vacio(ist_control_doc.nif3)) then nifs += '; '+ist_control_doc.nif3	
	dw_impresion.setitem(1, 'nifs', nifs)	
end if

if lower(dw_impresion.describe("n_cols.name")) = 'n_cols' then	
	n_cols=ist_control_doc.n_col1
	if not(f_es_vacio(ist_control_doc.n_col2)) then n_cols += '; '+ist_control_doc.n_col2
	if not(f_es_vacio(ist_control_doc.n_col3)) then n_cols += '; '+ist_control_doc.n_col3	
	dw_impresion.setitem(1, 'n_cols', n_cols)	
end if
end event

event buttonclicked;call super::buttonclicked;string tipo_intervencion,mensaje
string texto
// Desactivamos los botones e inicializamos las variables
i_visar=false
cb_validar.enabled=false
texto=""
tipo_intervencion=dw_1.getItemString(1,'tipo_intervencion')
ist_control_doc.no_cte='N'
ist_control_doc.tipo_actuacion=tipo_intervencion
this.SetItem(1,'cte','N')
this.SetItem(1,'OK','N')


choose case tipo_intervencion
	case '11','12','13'
		if tipo_intervencion='11' then
			mensaje='El Projecte i Direcci$$HEX2$$f3002000$$ENDHEX$$'
		elseif tipo_intervencion='12' then
			mensaje='El Projecte '				
		elseif tipo_intervencion='13' then	
			mensaje='La Direcci$$HEX2$$f3002000$$ENDHEX$$'					
		end if
		if MessageBox("Preguntar al col$$HEX1$$b700$$ENDHEX$$legiat", mensaje+" pertany al Codi T$$HEX1$$e800$$ENDHEX$$cnic de l'Edificaci$$HEX2$$f3002000$$ENDHEX$$?",Question!,YesNo!)=1 then
			if tipo_intervencion='11' or tipo_intervencion='12' then
				MessageBox("Gabinet","Passar pel Gabinet T$$HEX1$$e800$$ENDHEX$$cnic a donar OK.",Information!)
				this.SetItem(1,'cte','S')
				cb_validar.enabled=true
			elseif tipo_intervencion='13' then
				texto="L'Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic certifica que al projecte d'execuci$$HEX2$$f3002000$$ENDHEX$$li $$HEX1$$e900$$ENDHEX$$s d'aplicaci$$HEX2$$f3002000$$ENDHEX$$el Codi T$$HEX1$$e800$$ENDHEX$$cnic d'Edificaci$$HEX2$$f3002000$$ENDHEX$$(CTE)."
				i_nombre_dw='d_documentacion_CFO_tg'
				i_visar=true
			end if
		else		
			ist_control_doc.no_cte='S'
			i_nombre_dw='d_justificant_no_cfo_tg'						
			i_visar=true		
		end if			
		
	case '14'
		if MessageBox("Preguntar al col$$HEX1$$b700$$ENDHEX$$legiat", "S'ha demanat la llic$$HEX1$$e800$$ENDHEX$$ncia d'obres abans del 29/09/06 ?",Question!,YesNo!)=1 then
			i_nombre_dw='d_justificant_licencia_tg'
			ist_control_doc.no_cte='S'
		else
			i_nombre_dw='d_documentacion_CFO1_tg'
			texto="L'Arquitecte T$$HEX1$$e800$$ENDHEX$$cnic certifica que al projecte d'execuci$$HEX2$$f3002000$$ENDHEX$$li $$HEX1$$e900$$ENDHEX$$s d'aplicaci$$HEX2$$f3002000$$ENDHEX$$el Codi T$$HEX1$$e800$$ENDHEX$$cnic d'Edificaci$$HEX2$$f3002000$$ENDHEX$$(CTE)."
		end if
		i_visar=true
	case else
		i_visar=true
end choose 


if i_nombre_dw<>'' then 
	//MessageBox("DEBUG",i_nombre_dw)
	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir la informaci$$HEX2$$f3002000$$ENDHEX$$en paper?",Question!,YesNo!)=1 then
		dw_impresion.reset()
		dw_impresion.dataobject= i_nombre_dw
		dw_impresion.insertrow(0)	
		this.event csd_rellenar_dw()
		dw_impresion.SetItem(1,'texto',texto)
		dw_impresion.SetItem(1,'texto2',texto)	
		dw_impresion.print()
	end if
end if

if i_visar then	
	cb_validar.enabled=true
	cb_validar.event clicked()
end if

end event

type cb_validar from commandbutton within w_control_documentacion_tg
event csd_control_documentacion ( )
event csd_control_documentacion_cfo ( )
event csd_control_documentacion_cfo_obra_nueva ( )
integer x = 64
integer y = 1780
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Validar"
end type

event csd_control_documentacion();string tipo_intervencion,texto2="",texto=""

tipo_intervencion=dw_1.getItemString(1,'tipo_intervencion')

if dw_1.GetItemString(1,'cte')='S' then
	i_visar=true
	if dw_1.GetItemString(1,'memoria')<>'S' then
		i_visar=false
		texto2+=" Mem$$HEX1$$f200$$ENDHEX$$ria -"		
	else
		texto+=" Mem$$HEX1$$f200$$ENDHEX$$ria -"
	end if
	if dw_1.GetItemString(1,'planos')<>'S' then
		i_visar=false
		texto2+=" Pl$$HEX1$$e000$$ENDHEX$$nols -"		
	else		
		texto+=" Pl$$HEX1$$e000$$ENDHEX$$nols -"
	end if
	if dw_1.GetItemString(1,'pliego')<>'S' then 
		i_visar=false
		texto2+=" Plec de Condicions -"		
	else		
		texto+=" Plec de Condicions -"
	end if
	if dw_1.GetItemString(1,'medidas')<>'S' then
		i_visar=false
		texto2+=" Mesuraments -"		
	else				
		texto+=" Mesuraments -"
	end if
	if dw_1.GetItemString(1,'presupuesto')<>'S' then
		i_visar=false
		texto2+=" Pressupost -"		
	else			
		texto+=" Pressupost -"
	end if
	if dw_1.GetItemString(1,'ess')<>'S' then
		i_visar=false
		texto2+=" ES/EBSS -"		
	else				
		texto+=" ES/EBSS -"
	end if
	if len(texto)>0 then texto=left(texto,len(texto) - 2)+'.'
	if len(texto2)>0 then texto2=left(texto2,len(texto2) - 2)+'.'
end if


if not(i_visar) then	
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","El Projecte NO es pot VISAR")
	dw_1.SetItem(1,'OK','N')
	i_nombre_dw='d_documentacion_projecte_tg'
else
	MessageBox("OK!","El Projecte es pot VISAR. Documentaci$$HEX2$$f3002000$$ENDHEX$$correcta.")
	if tipo_intervencion='11' then
		i_nombre_dw='d_documentacion_cfo_tg'
	end if	
	dw_1.SetItem(1,'OK','S')		
	this.enabled=false
end if

if i_nombre_dw<>'' then 

	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir document informatiu en paper?",Question!,YesNo!)=1 then 
		dw_impresion.reset()
		dw_impresion.dataobject= i_nombre_dw
		
		dw_impresion.insertrow(0)
		dw_impresion.SetItem(1,'texto',texto)
		dw_impresion.SetItem(1,'texto2',texto2)	
		dw_impresion.print()
	end if
end if


if dw_1.GetItemString(1,'OK')='S' then	closeWithReturn(parent,ist_control_doc)

	


	
end event

event csd_control_documentacion_cfo();string tipo_intervencion,texto2="",texto=""

i_visar=true
if dw_1.GetItemString(1,'cfo')='S' then

	if dw_1.GetItemString(1,'licencia')<>'S' then
		i_visar=false
		texto2+=" Llic$$HEX1$$e800$$ENDHEX$$ncia d'obres -"		
	else
		texto+=" Llic$$HEX1$$e800$$ENDHEX$$ncia d'obres -"
	end if
	if dw_1.GetItemString(1,'libro_obra')<>'S' then
		i_visar=false
		texto2+=" Llibre d'obra -"		
	else		
		texto+=" Llibre d'obra -"
	end if
	if dw_1.GetItemString(1,'libro_inc')<>'S' then 
		i_visar=false
		texto2+=" Llibre d'Incid$$HEX1$$e800$$ENDHEX$$ncies -"		
	else		
		texto+=" Llibre d'Incid$$HEX1$$e800$$ENDHEX$$ncies -"
	end if
	
	if dw_1.GetItemString(1,'obertura')<>'S' then
		i_visar=false
		texto2+=" Obertura del centre de treball -"		
	else			
		texto+=" Obertura del centre de treball -"
	end if
	if dw_1.GetItemString(1,'modelb')<>'S' then
		i_visar=false
		texto2+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l'obra (CTE) -"		
	else				
		texto+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l'obra (CTE) -"
	end if
	
	if dw_1.GetItemString(1,'cc')<>'S' then
		i_visar=false
		texto2+="Programa i registre de resultats de control de qualitat -"	
	else				
		texto+=" Programa i registre de resultats de control de qualitat -"
	end if
	
	if dw_1.GetItemString(1,'anexo_modific')<>'S' then
		i_visar=false
		texto2+=" Annex de modificacions del projecte (model A col$$HEX1$$b700$$ENDHEX$$legial) -"	
	else				
		texto+=" Annex de modificacions del projecte (model A col$$HEX1$$b700$$ENDHEX$$legial) -"
	end if	
	
	if dw_1.GetItemString(1,'projecte')<>'S' then
		i_visar=false
		texto2+=" Projecte amb els seus annexes i modificacions -"		
	else				
		texto+=" Projecte amb els seus annexes i modificacions -"
	end if	
end if


if len(texto)>0 then texto=left(texto,len(texto) - 2)+'.'
if len(texto2)>0 then texto2=left(texto2,len(texto2) - 2)+'.'



if not(i_visar) then	
	ist_control_doc.no_cte=''
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Documentaci$$HEX2$$f3002000$$ENDHEX$$Incorrecta. NO Es pot realitzar el CFO")
	dw_1.SetItem(1,'OK','N')
	i_nombre_dw='d_documentacion_cfo_cte_tg'
else
	ist_control_doc.no_cte='N'
	MessageBox("OK!","Documentaci$$HEX2$$f3002000$$ENDHEX$$correcta. Es pot realitzar el CFO.")
	dw_1.SetItem(1,'OK','S')		
	this.enabled=false
	i_nombre_dw=''
end if

if i_nombre_dw<>'' then 

	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir document informatiu en paper?",Question!,YesNo!)=1 then 
		dw_impresion.reset()
		dw_impresion.dataobject= i_nombre_dw
		
		dw_impresion.insertrow(0)
		dw_impresion.SetItem(1,'texto',texto)
		dw_impresion.SetItem(1,'texto2',texto2)	
		dw_impresion.print()
	end if
end if


if dw_1.GetItemString(1,'OK')='S' then	closeWithReturn(parent,ist_control_doc)

end event

event csd_control_documentacion_cfo_obra_nueva();string tipo_intervencion,texto2="",texto=""

i_visar=true
if dw_1.GetItemString(1,'cfo')='S' then

	if dw_1.GetItemString(1,'controles')<>'S' then
		i_visar=false
		texto2+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l$$HEX1$$1920$$ENDHEX$$obra (CTE) -"		
	else
		texto+=" Relaci$$HEX2$$f3002000$$ENDHEX$$de controls i resultats (model B col$$HEX1$$b700$$ENDHEX$$legial) i documentaci$$HEX2$$f3002000$$ENDHEX$$de control de l$$HEX1$$1920$$ENDHEX$$obra (CTE) -"
	end if
	if dw_1.GetItemString(1,'cq')<>'S' then
		i_visar=false
		texto2+=" Programa i registre de resultats de control de qualitat (Decret 375/1988) -"		
	else		
		texto+=" Programa i registre de resultats de control de qualitat (Decret 375/1988) -"
	end if
	if dw_1.GetItemString(1,'libro_ord')<>'S' then 
		i_visar=false
		texto2+=" Llibre d'Ordres -"		
	else		
		texto+=" Llibre d'Ordres -"
	end if
	
end if


if len(texto)>0 then texto=left(texto,len(texto) - 2)+'.'
if len(texto2)>0 then texto2=left(texto2,len(texto2) - 2)+'.'



if not(i_visar) then	
	ist_control_doc.no_cte=''
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Documentaci$$HEX2$$f3002000$$ENDHEX$$Incorrecta. NO Es pot realitzar el CFO")
	dw_1.SetItem(1,'OK','N')
	i_nombre_dw='d_documentacion_cfo_cte1_tg'
else
	ist_control_doc.no_cte='N'
	MessageBox("OK!","Documentaci$$HEX2$$f3002000$$ENDHEX$$correcta. Es pot realitzar el CFO.")
	dw_1.SetItem(1,'OK','S')		
	this.enabled=false
	i_nombre_dw=''
end if

if i_nombre_dw<>'' then 

	if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$!","Imprimir document informatiu en paper?",Question!,YesNo!)=1 then 
		dw_impresion.reset()
		dw_impresion.dataobject= i_nombre_dw
		
		dw_impresion.insertrow(0)
		dw_impresion.SetItem(1,'texto',texto)
		dw_impresion.SetItem(1,'texto2',texto2)	
		dw_impresion.print()
	end if
end if


if dw_1.GetItemString(1,'OK')='S' then	closeWithReturn(parent,ist_control_doc)

end event

event clicked;
choose case dw_1.dataobject
	case 'd_control_documentacion_tg'
		event csd_control_documentacion()
	case 'd_control_documentacion_cfo_tg'
		event csd_control_documentacion_cfo()
	case 'd_control_documentacion_cfo_obra_nueva_tg'
		event csd_control_documentacion_cfo_obra_nueva()		
end choose
end event

type cb_salir from commandbutton within w_control_documentacion_tg
integer x = 498
integer y = 1780
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

event clicked;long valor=0

if dw_1.GetItemString(1,'ok')<>'S' then 
	ist_control_doc.no_cte=''
	ist_control_doc.tipo_actuacion=''
end if
closeWithReturn(parent,ist_control_doc)
end event

type dw_impresion from u_dw within w_control_documentacion_tg
boolean visible = false
integer x = 1673
integer y = 1784
integer width = 315
integer height = 124
integer taborder = 11
boolean bringtotop = true
boolean ib_isupdateable = false
end type

