HA$PBExportHeader$w_coaclp_previsualizacion_formularios.srw
$PBExportComments$PREVISUALIZACI$$HEX1$$d300$$ENDHEX$$N FORMULARIOS
forward
global type w_coaclp_previsualizacion_formularios from window
end type
type cb_finalizar from commandbutton within w_coaclp_previsualizacion_formularios
end type
type cb_siguiente from commandbutton within w_coaclp_previsualizacion_formularios
end type
type cb_retroceder from commandbutton within w_coaclp_previsualizacion_formularios
end type
type tab_1 from tab within w_coaclp_previsualizacion_formularios
end type
type tabpage_1 from userobject within tab_1
end type
type dw_trabajo from u_dw within tabpage_1
end type
type dw_tipo_fase from u_dw within tabpage_1
end type
type dw_encargo from datawindow within tabpage_1
end type
type dw_tipos_trabajo from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_trabajo dw_trabajo
dw_tipo_fase dw_tipo_fase
dw_encargo dw_encargo
dw_tipos_trabajo dw_tipos_trabajo
end type
type tabpage_2 from userobject within tab_1
end type
type cb_23 from commandbutton within tabpage_2
end type
type cb_22 from commandbutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_13 from commandbutton within tabpage_2
end type
type cb_12 from commandbutton within tabpage_2
end type
type cb_11 from commandbutton within tabpage_2
end type
type cb_10 from commandbutton within tabpage_2
end type
type cb_9 from commandbutton within tabpage_2
end type
type dw_clientes from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_23 cb_23
cb_22 cb_22
st_2 st_2
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
dw_clientes dw_clientes
end type
type tabpage_3 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type cb_8 from commandbutton within tabpage_3
end type
type cb_7 from commandbutton within tabpage_3
end type
type cb_6 from commandbutton within tabpage_3
end type
type cb_5 from commandbutton within tabpage_3
end type
type cb_4 from commandbutton within tabpage_3
end type
type cb_3 from commandbutton within tabpage_3
end type
type dw_arquitectos from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_1 cb_1
st_1 st_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_arquitectos dw_arquitectos
end type
type tabpage_4 from userobject within tab_1
end type
type cb_21 from commandbutton within tabpage_4
end type
type cb_20 from commandbutton within tabpage_4
end type
type st_3 from statictext within tabpage_4
end type
type cb_19 from commandbutton within tabpage_4
end type
type cb_18 from commandbutton within tabpage_4
end type
type cb_17 from commandbutton within tabpage_4
end type
type cb_16 from commandbutton within tabpage_4
end type
type cb_15 from commandbutton within tabpage_4
end type
type dw_aparejadores from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_21 cb_21
cb_20 cb_20
st_3 st_3
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
dw_aparejadores dw_aparejadores
end type
type tabpage_5 from userobject within tab_1
end type
type dw_datos_generales from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_datos_generales dw_datos_generales
end type
type tabpage_6 from userobject within tab_1
end type
type dw_trabajos from datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_trabajos dw_trabajos
end type
type tab_1 from tab within w_coaclp_previsualizacion_formularios
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
end forward

global type w_coaclp_previsualizacion_formularios from window
integer x = 334
integer y = 352
integer width = 3255
integer height = 1996
boolean titlebar = true
string title = "Previsualizaci$$HEX1$$f300$$ENDHEX$$n ficha de Formularios"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "canarias.ico"
cb_finalizar cb_finalizar
cb_siguiente cb_siguiente
cb_retroceder cb_retroceder
tab_1 tab_1
end type
global w_coaclp_previsualizacion_formularios w_coaclp_previsualizacion_formularios

type variables
//Declaro una datawindowchild para clientes
//para poder acceder a ella desde cualquier evento
   DataWindowChild dwc_clientes

//Declaro una datawindow para arquitectos
//para poder acceder a ella desde cualquier evento
   DataWindowChild dwc_arquitectos

//Declaro una datawindow para aparejadores
//para poder acceder a ella desde cualquier evento
   DataWindowChild dwc_aparejadores

//Variable para controlar el numero de arquitectos
//como maximo tienen que haber 4 arquitectos
   Integer Num_arquitectos,Num_promotores,Num_aparejadores

//Declaro una datawindowchild para los municipios
   DataWindowChild dwc_municipios
string i_fichero_ini
end variables

on w_coaclp_previsualizacion_formularios.create
this.cb_finalizar=create cb_finalizar
this.cb_siguiente=create cb_siguiente
this.cb_retroceder=create cb_retroceder
this.tab_1=create tab_1
this.Control[]={this.cb_finalizar,&
this.cb_siguiente,&
this.cb_retroceder,&
this.tab_1}
end on

on w_coaclp_previsualizacion_formularios.destroy
destroy(this.cb_finalizar)
destroy(this.cb_siguiente)
destroy(this.cb_retroceder)
destroy(this.tab_1)
end on

event open;
//Centro esta ventana 
  f_centrar_ventana(this)
  
//Pongo de nuevo la flecha como puntero  
  SetPointer(Arrow!)
 

  
//Inicializo las pesta$$HEX1$$f100$$ENDHEX$$as y los botonoes
 

tab_1.tabpage_1.Enabled=True
tab_1.tabpage_2.Enabled=True
tab_1.tabpage_3.Enabled=True
tab_1.tabpage_4.Enabled=True
tab_1.tabpage_5.Enabled=True
tab_1.tabpage_6.Enabled=True					

cb_Retroceder.Enabled=False
cb_finalizar.Enabled=True
  

   
  
end event

type cb_finalizar from commandbutton within w_coaclp_previsualizacion_formularios
integer x = 2418
integer y = 1772
integer width = 416
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;//Cierro la ventana
Close(parent)

end event

type cb_siguiente from commandbutton within w_coaclp_previsualizacion_formularios
boolean visible = false
integer x = 626
integer y = 1772
integer width = 416
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Siguiente"
end type

event clicked;//Declaracion de variables
Integer Index_tab

//Obtengo el numero del tabpage sobre el que se encuentra
Index_tab= tab_1.selectedtab


CHOOSE CASE Index_tab
  	    
		 CASE 1
           //Cuando este sobre el tabpage "encargo" pasar$$HEX2$$e1002000$$ENDHEX$$a de "cliente"  			
				 tab_1.tabpage_2.Enabled=True
			    tab_1.selecttab(2)
           //Activo el boton retroceder
             cb_retroceder.enabled=True
		 CASE 2
           //Cuando este sobre el tabpage "Cliente" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Arquitectos"  			
				 tab_1.tabpage_3.Enabled=True
			    tab_1.selecttab(3)				
		 CASE 3
           //Cuando este sobre el tabpage "Arquitectos" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Aparejadores"  			
				 tab_1.tabpage_4.Enabled=True
			    tab_1.selecttab(4)				
		 CASE 4
           //Cuando este sobre el tabpage "Aparejadores" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Datos Urbanisticos"  			
				 tab_1.tabpage_5.Enabled=True
			    tab_1.selecttab(5)				
		CASE 5
				tab_1.tabpage_6.Enabled=True
				tab_1.selecttab(6)
				//Activo el boton "Finalizar"
			    cb_finalizar.Enabled=True 
				 cb_siguiente.Enabled=False
				 

END CHOOSE				
end event

type cb_retroceder from commandbutton within w_coaclp_previsualizacion_formularios
boolean visible = false
integer x = 183
integer y = 1772
integer width = 416
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anterior"
end type

event clicked;//Declaracion de variables
Integer Index_tab

//Obtengo el numero del tabpage sobre el que se encuentra
Index_tab= tab_1.selectedtab

CHOOSE CASE Index_tab
  	    
		 CASE 2
           //Cuando este sobre el tabpage "cliente" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Encargo"  			
			    tab_1.selecttab(1)
				 cb_retroceder.Enabled=False
		 CASE 3
           //Cuando este sobre el tabpage "Arquitectos" pasar$$HEX2$$e1002000$$ENDHEX$$a de "cliente"  			
			    tab_1.selecttab(2)				
		 CASE 4
           //Cuando este sobre el tabpage "Aparejadores" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Arquitectos"  			
			    tab_1.selecttab(3)
		 CASE 5
           //Cuando este sobre el tabpage "Datos Urban$$HEX1$$ed00$$ENDHEX$$sticos" pasar$$HEX2$$e1002000$$ENDHEX$$a de "Aparejadores"  			
			    tab_1.selecttab(4)
 		CASE 6
				tab_1.selecttab(5)
				cb_siguiente.Enabled=True

END CHOOSE				
end event

type tab_1 from tab within w_coaclp_previsualizacion_formularios
integer x = 59
integer y = 20
integer width = 3141
integer height = 1716
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;if oldindex=6 then
	if tab_1.tabpage_6.dw_trabajos.GetItemString(1,"mision") = "PARCIAL" AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase1") = "" AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase2") ="" &
		AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase3")="" AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase4")="" AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase5") =""  &
		AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase6")="" AND  tab_1.tabpage_6.dw_trabajos.GetItemString(1,"fase7")="" then
			tab_1.SelectTab(6)
			messagebox("Aviso","No puede dejar todos los campos de fase vacios si la misi$$HEX1$$f300$$ENDHEX$$n es parcial.")
	end if
end if
end event

event constructor;//Obtengo el parametro que me pasan 
i_fichero_ini = Message.StringParm
  
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Encargo"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_trabajo dw_trabajo
dw_tipo_fase dw_tipo_fase
dw_encargo dw_encargo
dw_tipos_trabajo dw_tipos_trabajo
end type

on tabpage_1.create
this.dw_trabajo=create dw_trabajo
this.dw_tipo_fase=create dw_tipo_fase
this.dw_encargo=create dw_encargo
this.dw_tipos_trabajo=create dw_tipos_trabajo
this.Control[]={this.dw_trabajo,&
this.dw_tipo_fase,&
this.dw_encargo,&
this.dw_tipos_trabajo}
end on

on tabpage_1.destroy
destroy(this.dw_trabajo)
destroy(this.dw_tipo_fase)

destroy(this.dw_encargo)
destroy(this.dw_tipos_trabajo)
end on

type dw_trabajo from u_dw within tabpage_1
integer x = 1728
integer y = 240
integer width = 1280
integer height = 92
integer taborder = 40
string dataobject = "d_trabajos_bd"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;// SOBREESCRITO
settransobject(SQLCA)
insertrow(0)
SetItem(GetRow(), "trabajo", ProfileString(i_fichero_ini,"Expediente","trabajo_bd",""))
return 1

end event

type dw_tipo_fase from u_dw within tabpage_1
integer x = 1294
integer y = 140
integer width = 443
integer height = 88
integer taborder = 30
string dataobject = "d_fases_bd"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;// SOBREESCRITO
settransobject(SQLCA)
insertrow(0)
SetItem(GetRow(), "tipo_fase", ProfileString(i_fichero_ini,"Expediente","tipo_fase_bd",""))
return 1

end event

type dw_encargo from datawindow within tabpage_1
event guardar ( )
event csd_formato ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1300
integer taborder = 20
string dataobject = "d_encargo"
boolean border = false
boolean livescroll = true
end type

event guardar();//Para el caso de que se este sobre algun campo
  this.acceptText()
  dw_tipo_fase.accepttext()
  dw_tipos_trabajo.acceptText()
  dw_trabajo.acceptText()

// Guardo los campos modificados de la seccion [EXPEDIENTE]
   SetProfileString(i_fichero_ini,"EXPEDIENTE","n_expediente_colegial",GetItemString(GetRow(),"n_expediente_colegial"))	
   SetProfileString(i_fichero_ini,"EXPEDIENTE","n_expediente_personal",GetItemString(GetRow(),"n_expediente_personal"))	
   SetProfileString(i_fichero_ini,"EXPEDIENTE","Trabajo",f_convierte_retornos_carro(GetItemString(GetRow(),"Trabajo")))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","SuperficieTotalEdificableEstimada",String(GetItemDecimal(GetRow(),"SuperficieTotalEdificableEstimada")))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","Situacion",f_convierte_retornos_carro(GetItemString(GetRow(),"Situacion")))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","TMTrabajo",GetItemString(GetRow(),"TMTrabajo"))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","CPTrabajo",GetItemString(GetRow(),"CPTrabajo"))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","PRTrabajo",GetItemString(GetRow(),"PRTrabajo"))
   SetProfileString(i_fichero_ini,"EXPEDIENTE","Isla",GetItemString(GetRow(),"Isla"))
	SetProfileString(i_fichero_ini,"EXPEDIENTE","tipo_fase_bd",dw_tipo_fase.GetItemString(GetRow(),"tipo_fase"))
	SetProfileString(i_fichero_ini,"EXPEDIENTE","tipo_trabajo_bd",dw_tipos_trabajo.GetItemString(GetRow(),"tipo_trabajo"))
	SetProfileString(i_fichero_ini,"EXPEDIENTE","trabajo_bd",dw_trabajo.GetItemString(GetRow(),"trabajo"))
	SetProfileString(i_fichero_ini,"EXPEDIENTE","tipo_via_bd",GetItemString(GetRow(),"tipo_via_bd"))	

// En este punto guardo los datos generales Cp, IRPF, IGIC que los recupero del
// fichero form.ini
//   SetProfileString(i_fichero_ini,"OTROS","IGIC",ProfileString(sg_directorio + "form.ini", "PARAMETROS", "IGIC", ""))

  
end event

event csd_formato;SetItem(GetRow(), "n_expediente_colegial", string(long(this.GetItemString(GetRow(),'n_expediente_colegial')),'0000000000'))
end event

event constructor;string expediente_colegial=''

this.settransobject(SQLCA)

//Inserto una fila
   InsertRow(0) 


//creo la datawindow child para el campo "Poblacion"
  dw_encargo.GetChild("tmtrabajo", dwc_municipios)

//dwc_municipios.importfile(sg_directorio + "muni.dbf")



//Ordeno los Municipios
  dwc_municipios.SetSort("Nombre_Mun A")
  dwc_municipios.Sort()
// Inicializo los datos que aparecen en "Trabajo"
   expediente_colegial=ProfileString(i_fichero_ini,"Expediente","n_expediente_colegial","")
	if expediente_colegial='' then expediente_colegial=ProfileString(i_fichero_ini,"Expediente","expediente","")
	SetItem(GetRow(), "n_expediente_colegial",expediente_colegial )
	SetItem(GetRow(), "n_expediente_personal", ProfileString(i_fichero_ini,"Expediente","n_expediente_personal",""))
	SetItem(GetRow(), "Trabajo", f_convierte_retornos_carro(ProfileString(i_fichero_ini,"EXPEDIENTE","trabajo","")))
	SetItem(GetRow(), "SuperficieTotalEdificableEstimada",Dec(ProfileString(i_fichero_ini,"Expediente","SuperficieTotalEdificableEstimada","0")))
	SetItem(GetRow(), "Situacion", f_convierte_retornos_carro(ProfileString(i_fichero_ini,"EXPEDIENTE","situacion","")))
	SetItem(GetRow(), "TMTrabajo", ProfileString(i_fichero_ini,"Expediente","TMTrabajo",""))
	SetItem(GetRow(), "CPTrabajo", ProfileString(i_fichero_ini,"Expediente","CPTrabajo",""))
	SetItem(GetRow(), "PRTrabajo", ProfileString(i_fichero_ini,"Expediente","PRTrabajo",""))
	SetItem(GetRow(), "Isla", ProfileString(i_fichero_ini,"Expediente","Isla",""))
	SetItem(GetRow(), "tipo_via_bd", ProfileString(i_fichero_ini,"Expediente","tipo_via_bd",""))

end event

event itemerror;messagebox("Error","El campo no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n. Introduzca un valor correcto.")
return 1
end event

type dw_tipos_trabajo from u_dw within tabpage_1
integer x = 110
integer y = 240
integer width = 1618
integer height = 80
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_tipo_trabajo"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event constructor;// SOBREESCRITO
settransobject(SQLCA)
insertrow(0)
SetItem(GetRow(), "tipo_trabajo", ProfileString(i_fichero_ini,"Expediente","tipo_trabajo_bd",""))
return 1

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Clientes"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_23 cb_23
cb_22 cb_22
st_2 st_2
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
dw_clientes dw_clientes
end type

on tabpage_2.create
this.cb_23=create cb_23
this.cb_22=create cb_22
this.st_2=create st_2
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.dw_clientes=create dw_clientes
this.Control[]={this.cb_23,&
this.cb_22,&
this.st_2,&
this.cb_13,&
this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.dw_clientes}
end on

on tabpage_2.destroy
destroy(this.cb_23)
destroy(this.cb_22)
destroy(this.st_2)
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.dw_clientes)
end on

type cb_23 from commandbutton within tabpage_2
boolean visible = false
integer x = 439
integer y = 1456
integer width = 270
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;//Declaracion de variables
  Integer valor
  
//emito un mesaje de comprobacion
 valor=MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","$$HEX1$$bf00$$ENDHEX$$Desea eliminar el Promotor Actual?",Exclamation!,YesNo!)

 IF valor= 1 THEN
    //Eliminamos el Promotor de la Data Window 
      dw_clientes.DeleteRow(dw_clientes.GetRow())
	 //Decremento la variable "num_promotores"
	   num_promotores=num_promotores -1
    //Despues de borrar me voy al primer registro (Promotor)
      dw_clientes.ScrolltoRow(1)

END IF	 



//visualizo el total de promotores que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type cb_22 from commandbutton within tabpage_2
boolean visible = false
integer x = 142
integer y = 1456
integer width = 247
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;//Inserto una fila para introducir un nuevo Promotor
//pero compruebo antes si no a superado el limite de 4 Promotores

//IF num_promotores< 4 THEN
	//Inseto la nueva fila
     dw_clientes.InsertRow(0)

   //Me desplazo a esa nueva fila
     dw_clientes.ScrolltoRow(dw_clientes.RowCount())
	  
	//Incremento la varible num_Promotores
  	  num_promotores=num_promotores + 1
//END IF	

//visualizo el total de promotores que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type st_2 from statictext within tabpage_2
integer x = 2258
integer y = 1356
integer width = 439
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Promotor"
boolean focusrectangle = false
end type

type cb_13 from commandbutton within tabpage_2
integer x = 2619
integer y = 1456
integer width = 247
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ultimo"
end type

event clicked;//Inserta el Ultimo Arquitecto
   dw_clientes.ScrolltoRow(dw_clientes.RowCount())
//visualizo el total de arquitectos que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type cb_12 from commandbutton within tabpage_2
integer x = 2313
integer y = 1456
integer width = 302
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Siguiente"
end type

event clicked;//Inserta el Siguiente Arquitecto
   dw_clientes.ScrollNextRow()
//visualizo el total de arquitectos que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type cb_11 from commandbutton within tabpage_2
integer x = 2039
integer y = 1456
integer width = 261
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anterior"
end type

event clicked;//Inserta el Anterior Arquitecto
   dw_clientes.ScrollPriorRow()
//visualizo el total de arquitectos que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type cb_10 from commandbutton within tabpage_2
integer x = 1769
integer y = 1456
integer width = 261
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Primero"
end type

event clicked;//Inserta el Primer Arquitecto
   dw_clientes.ScrolltoRow(1)
//visualizo el total de promotores que hay
  st_2.text="Promotor "+String(dw_clientes.GetRow())+"/"+String(num_promotores)

end event

type cb_9 from commandbutton within tabpage_2
boolean visible = false
integer x = 1093
integer y = 1456
integer width = 480
integer height = 108
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!

fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar Agenda"
end type

type dw_clientes from datawindow within tabpage_2
event guardar ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1300
integer taborder = 30
boolean enabled = false
string dataobject = "d_generales_clientes"
boolean border = false
boolean livescroll = true
end type

event guardar;integer i

//Para el caso de que se este sobre algun campo
  this.acceptText()

//Guarda en el .INI el numero total de Arquitectos
num_promotores=dw_clientes.RowCount()
SetProfileString(i_fichero_ini,"CLIENTES","NumPromotores",String(num_promotores))


FOR i=1 TO dw_clientes.RowCount()

if i= 1 then
	
SetProfileString(i_fichero_ini,"CLIENTE","Tratamiento",GetItemString(GetRow(),"Tratamiento"))
SetProfileString(i_fichero_ini,"CLIENTE","Cliente",GetItemString(GetRow(),"Cliente"))
SetProfileString(i_fichero_ini,"CLIENTE","Identificacion",GetItemString(GetRow(),"Identificacion"))
SetProfileString(i_fichero_ini,"CLIENTE","NumIdentificacion",GetItemString(GetRow(),"NumIdentificacion"))
SetProfileString(i_fichero_ini,"CLIENTE","Nacionalidad",GetItemString(GetRow(),"Nacionalidad"))
SetProfileString(i_fichero_ini,"CLIENTE","Domicilio",GetItemString(GetRow(),"Domicilio"))
SetProfileString(i_fichero_ini,"CLIENTE","Numero",GetItemString(GetRow(),"Numero"))
SetProfileString(i_fichero_ini,"CLIENTE","Poblacion",GetItemString(GetRow(),"Poblacion"))
SetProfileString(i_fichero_ini,"CLIENTE","CP",GetItemString(GetRow(),"CP"))
SetProfileString(i_fichero_ini,"CLIENTE","Provincia",GetItemString(GetRow(),"Provincia"))
SetProfileString(i_fichero_ini,"CLIENTE","Telefono1",GetItemString(GetRow(),"Telefono1"))
SetProfileString(i_fichero_ini,"CLIENTE","Fax",GetItemString(GetRow(),"Fax"))
SetProfileString(i_fichero_ini,"CLIENTE","Telefono2",GetItemString(GetRow(),"Telefono2"))
SetProfileString(i_fichero_ini,"CLIENTE","TelefonoMovil",GetItemString(GetRow(),"TelefonoMovil"))
SetProfileString(i_fichero_ini,"CLIENTE","Telefonoparticular",GetItemString(GetRow(),"Telefonoparticular"))
SetProfileString(i_fichero_ini,"CLIENTE","Representante",GetItemString(GetRow(),"Representante"))
SetProfileString(i_fichero_ini,"CLIENTE","NifRepresentante",GetItemString(GetRow(),"NifRepresentante"))
SetProfileString(i_fichero_ini,"CLIENTE","N_protocolo",GetItemString(GetRow(),"N_protocolo"))
SetProfileString(i_fichero_ini,"CLIENTE","NomNotario",GetItemString(GetRow(),"NomNotario"))
SetProfileString(i_fichero_ini,"CLIENTE","Fecha",GetItemString(GetRow(),"Fecha"))
SetProfileString(i_fichero_ini,"CLIENTE","intervencion",GetItemString(GetRow(),"intervencion"))
SetProfileString(i_fichero_ini,"CLIENTE","Calidad",GetItemString(GetRow(),"Calidad"))

end if	
	
	   Scrolltorow(i) 	
// Guardo los campos modificados de la seccion [CLIENTES]

SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Tratamiento",GetItemString(GetRow(),"Tratamiento"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Cliente",GetItemString(GetRow(),"Cliente"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Identificacion",GetItemString(GetRow(),"Identificacion"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"NumIdentificacion",GetItemString(GetRow(),"NumIdentificacion"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Nacionalidad",GetItemString(GetRow(),"Nacionalidad"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Domicilio",GetItemString(GetRow(),"Domicilio"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Numero",GetItemString(GetRow(),"Numero"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Poblacion",GetItemString(GetRow(),"Poblacion"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"CP",GetItemString(GetRow(),"CP"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Provincia",GetItemString(GetRow(),"Provincia"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Telefono1",GetItemString(GetRow(),"Telefono1"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Fax",GetItemString(GetRow(),"Fax"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Telefono2",GetItemString(GetRow(),"Telefono2"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"TelefonoMovil",GetItemString(GetRow(),"TelefonoMovil"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Telefonoparticular",GetItemString(GetRow(),"Telefonoparticular"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Representante",GetItemString(GetRow(),"Representante"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"NifRepresentante",GetItemString(GetRow(),"NifRepresentante"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"domiciliorepre",GetItemString(GetRow(),"domiciliorepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"numrepre",GetItemString(GetRow(),"numrepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"cprepre",GetItemString(GetRow(),"cprepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"poblacionrepre",GetItemString(GetRow(),"poblacionrepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"provinciarepre",GetItemString(GetRow(),"provinciarepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"N_protocolo",GetItemString(GetRow(),"N_protocolo"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"NomNotario",GetItemString(GetRow(),"NomNotario"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Fecha",GetItemString(GetRow(),"Fecha"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"intervencion",GetItemString(GetRow(),"intervencion"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"telefonorepre",GetItemString(GetRow(),"telefonorepre"))
SetProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Calidad",GetItemString(GetRow(),"Calidad"))

NEXT


end event

event constructor;datawindowchild dwc_muni_repre
this.settransobject(SQLCA)
////Inserto una columan para visualizar los campos
//  InsertRow(0)
//
//creo la datawindow child para el campo "clienteBusqueda"
  dw_clientes.GetChild("clientebusqueda", dwc_clientes)
//  dwc_clientes.importfile(sg_directorio + "clientes.dbf")
  
  
//creo la datawindow child para el campo "Poblacion"
  dw_clientes.GetChild("poblacion", dwc_municipios)
  
   // dwc_municipios.importfile(sg_directorio + "muni.dbf")



//Ordeno los Municipios
  dwc_municipios.SetSort("Nombre_Mun A")
  dwc_municipios.Sort()
  
    dw_clientes.GetChild("poblacionrepre", dwc_muni_repre)

 // dwc_muni_repre.importfile(sg_directorio + "muni.dbf")



//Ordeno los Municipios
  dwc_muni_repre.SetSort("Nombre_Mun A")
  dwc_muni_repre.Sort()

//Visualizo el campo de la datawindow Child
  dw_clientes.Object.cliente.Visible=False
  dw_clientes.Object.clientebusqueda.Visible=True  

 
  //Declaracion de Variables
  Integer i

//Obtengo el numero de Arquitectos
  Num_Promotores=ProfileInt(i_fichero_ini,"Clientes","NumPromotores",0)
  
//Si no existe ningun arquitecto inserto uno nuevo
IF Num_Promotores = 0  THEN
	InsertRow(0)
		SetItem(GetRow(), "Tratamiento", ProfileString(i_fichero_ini,"CLIENTE","Tratamiento","D."))
   	SetItem(GetRow(), "Cliente", ProfileString(i_fichero_ini,"CLIENTE","Cliente",""))
   	SetItem(GetRow(), "Clientebusqueda", ProfileString(i_fichero_ini,"CLIENTE","Cliente",""))
   	SetItem(GetRow(), "Identificacion", ProfileString(i_fichero_ini,"CLIENTE","Identificacion",""))
	SetItem(GetRow(), "NumIdentificacion", ProfileString(i_fichero_ini,"CLIENTE","NumIdentificacion",""))
	SetItem(GetRow(), "Nacionalidad", ProfileString(i_fichero_ini,"cliente","Nacionalidad",""))
	SetItem(GetRow(), "Domicilio", ProfileString(i_fichero_ini,"cliente","Domicilio",""))
	SetItem(GetRow(), "Numero", ProfileString(i_fichero_ini,"cliente","Numero",""))
	SetItem(GetRow(), "Poblacion", ProfileString(i_fichero_ini,"cliente","Poblacion",""))
	SetItem(GetRow(), "CP", ProfileString(i_fichero_ini,"cliente","CP",""))
	SetItem(GetRow(), "Provincia", ProfileString(i_fichero_ini,"cliente","Provincia",""))
	SetItem(GetRow(), "Telefono1", ProfileString(i_fichero_ini,"cliente","Telefono",""))
	SetItem(GetRow(), "Fax", ProfileString(i_fichero_ini,"cliente","Fax",""))
	SetItem(GetRow(), "Telefono2", ProfileString(i_fichero_ini,"cliente","Telefono2",""))
	SetItem(GetRow(), "TelefonoMovil", ProfileString(i_fichero_ini,"cliente","TelefonoMovil",""))
	SetItem(GetRow(), "TelefonoParticular", ProfileString(i_fichero_ini,"cliente","TelefonoParticular",""))
	SetItem(GetRow(), "Representante", ProfileString(i_fichero_ini,"cliente","Representante",""))
	SetItem(GetRow(), "NifRepresentante", ProfileString(i_fichero_ini,"cliente","NifRepresentante",""))
	SetItem(GetRow(), "n_protocolo", ProfileString(i_fichero_ini,"cliente","n_protocolo",""))
	SetItem(GetRow(), "NomNotario", ProfileString(i_fichero_ini,"cliente","NomNotario",""))
	SetItem(GetRow(), "Fecha", ProfileString(i_fichero_ini,"cliente","Fecha",""))
	SetItem(GetRow(), "intervencion", ProfileString(i_fichero_ini,"cliente","intervencion","S"))
	SetItem(GetRow(), "Calidad", ProfileString(i_fichero_ini,"cliente","Calidad",""))

ELSE
 //Sino Inserto todos los que haya	
   FOR i=1 TO Num_promotores
       IF ProfileString(i_fichero_ini,"Cliente_"+String(i),"Cliente","") <> "" THEN 
	    //Inserto una fila y me situo el la fila que acabo de insertar
      	InsertRow(0) 
		   Scrolltorow(RowCount()) 

//Inserto los datos de clientes del Expediente en uso
//si el expediente es Nuevo no cargar$$HEX2$$e9002000$$ENDHEX$$ning$$HEX1$$fa00$$ENDHEX$$n datos
	SetItem(GetRow(), "Tratamiento", ProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Tratamiento","D."))
   SetItem(GetRow(), "Cliente", ProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Cliente",""))
   SetItem(GetRow(), "Clientebusqueda", ProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Cliente",""))
   SetItem(GetRow(), "Identificacion", ProfileString(i_fichero_ini,"CLIENTE_"+String(i),"Identificacion",""))
	SetItem(GetRow(), "NumIdentificacion", ProfileString(i_fichero_ini,"CLIENTE_"+String(i),"NumIdentificacion",""))
	SetItem(GetRow(), "Nacionalidad", ProfileString(i_fichero_ini,"cliente_"+String(i),"Nacionalidad",""))
	SetItem(GetRow(), "Domicilio", ProfileString(i_fichero_ini,"cliente_"+String(i),"Domicilio",""))
	SetItem(GetRow(), "Numero", ProfileString(i_fichero_ini,"cliente_"+String(i),"Numero",""))
	SetItem(GetRow(), "Poblacion", ProfileString(i_fichero_ini,"cliente_"+String(i),"Poblacion",""))
	SetItem(GetRow(), "CP", ProfileString(i_fichero_ini,"cliente_"+String(i),"CP",""))
	SetItem(GetRow(), "Provincia", ProfileString(i_fichero_ini,"cliente_"+String(i),"Provincia",""))
	SetItem(GetRow(), "Telefono1", ProfileString(i_fichero_ini,"cliente_"+String(i),"Telefono1",""))
	SetItem(GetRow(), "Fax", ProfileString(i_fichero_ini,"cliente_"+String(i),"Fax",""))
	SetItem(GetRow(), "Telefono2", ProfileString(i_fichero_ini,"cliente_"+String(i),"Telefono2",""))
	SetItem(GetRow(), "TelefonoMovil", ProfileString(i_fichero_ini,"cliente_"+String(i),"TelefonoMovil",""))
	SetItem(GetRow(), "TelefonoParticular", ProfileString(i_fichero_ini,"cliente_"+String(i),"TelefonoParticular",""))
	SetItem(GetRow(), "Representante", ProfileString(i_fichero_ini,"cliente_"+String(i),"Representante",""))
	SetItem(GetRow(), "NifRepresentante", ProfileString(i_fichero_ini,"cliente_"+String(i),"NifRepresentante",""))
	SetItem(GetRow(), "domiciliorepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"domiciliorepre",""))
	SetItem(GetRow(), "numrepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"numrepre",""))
	SetItem(GetRow(), "cprepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"cprepre",""))
	SetItem(GetRow(), "poblacionrepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"poblacionrepre",""))	
	SetItem(GetRow(), "provinciarepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"provinciarepre",""))	
	SetItem(GetRow(), "n_protocolo", ProfileString(i_fichero_ini,"cliente_"+String(i),"n_protocolo",""))
	SetItem(GetRow(), "NomNotario", ProfileString(i_fichero_ini,"cliente_"+String(i),"NomNotario",""))
	SetItem(GetRow(), "Fecha", ProfileString(i_fichero_ini,"cliente_"+String(i),"Fecha",""))
	SetItem(GetRow(), "intervencion", ProfileString(i_fichero_ini,"cliente_"+String(i),"intervencion",""))
	SetItem(GetRow(), "telefonorepre", ProfileString(i_fichero_ini,"cliente_"+String(i),"telefonorepre",""))
	SetItem(GetRow(), "Calidad", ProfileString(i_fichero_ini,"cliente_"+String(i),"Calidad",""))
	
	
	
	
       END IF 		  
   NEXT	
END IF	

  num_promotores=dw_clientes.RowCount()

  



//Me posiciono en al primera fila
  ScrolltoRow(1)
  
//visualizo el total de arquitectos que hay
  st_2.text="Promotor "+String(GetRow())+"/"+String(num_promotores)
  


end event

event itemerror;messagebox("Error","El campo no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n. Introduzca un valor correcto.")
return 1
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Arquitectos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_1 cb_1
st_1 st_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_arquitectos dw_arquitectos
end type

on tabpage_3.create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_arquitectos=create dw_arquitectos
this.Control[]={this.cb_1,&
this.st_1,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_arquitectos}
end on

on tabpage_3.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_arquitectos)
end on

type cb_1 from commandbutton within tabpage_3
boolean visible = false
integer x = 1079
integer y = 1420
integer width = 480
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar Agenda"
end type

type st_1 from statictext within tabpage_3
integer x = 2258
integer y = 1340
integer width = 407
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Arquitecto"
boolean focusrectangle = false
end type

type cb_8 from commandbutton within tabpage_3
integer x = 2619
integer y = 1420
integer width = 247
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ultimo"
end type

event clicked;//Inserta el Ultimo Arquitecto
   dw_arquitectos.ScrolltoRow(dw_arquitectos.RowCount())
//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type cb_7 from commandbutton within tabpage_3
integer x = 2309
integer y = 1420
integer width = 302
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Siguiente"
end type

event clicked;//Inserta el Siguiente Arquitecto
   dw_arquitectos.ScrollNextRow()
//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type cb_6 from commandbutton within tabpage_3
integer x = 2039
integer y = 1420
integer width = 261
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anterior"
end type

event clicked;//Inserta el Anterior Arquitecto
   dw_arquitectos.ScrollPriorRow()
//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type cb_5 from commandbutton within tabpage_3
integer x = 1769
integer y = 1420
integer width = 261
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Primero"
end type

event clicked;//Inserta el Primer Arquitecto
   dw_arquitectos.ScrolltoRow(1)
//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type cb_4 from commandbutton within tabpage_3
boolean visible = false
integer x = 434
integer y = 1420
integer width = 270
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;//Declaracion de variables
  Integer valor
  
//emito un mesaje de comprobacion
 valor=MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","$$HEX1$$bf00$$ENDHEX$$Desea eliminar el Arquitecto Actual?",Exclamation!,YesNo!)

 IF valor= 1 THEN
    //Eliminamos el Arquitecto de la Data Window 
      dw_arquitectos.DeleteRow(dw_arquitectos.GetRow())
	 //Decremento la variable "num_arquitectos"
	   num_arquitectos=num_arquitectos -1
    //Despues de borrar me voy al primer registro (Arquitecto)
      dw_arquitectos.ScrolltoRow(1)

END IF	 



//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type cb_3 from commandbutton within tabpage_3
boolean visible = false
integer x = 142
integer y = 1420
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;//Inserto una fila para introducir un nuevo Arquitecto
//pero compruebo antes si no a superado el limite de 4 arquitectos

//IF num_arquitectos< 4 THEN
	//Inseto la nueva fila
     dw_arquitectos.InsertRow(0)

   //Me desplazo a esa nueva fila
     dw_arquitectos.ScrolltoRow(dw_arquitectos.RowCount())
	  
	//Incremento la varible num_arquitectos
  	  num_arquitectos=num_arquitectos + 1
//END IF	

//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(dw_arquitectos.GetRow())+"/"+String(num_arquitectos)

end event

type dw_arquitectos from datawindow within tabpage_3
event guardar ( )
event csd_formato ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1300
integer taborder = 10
string dataobject = "d_general_arquitectos"
boolean border = false
boolean livescroll = true
end type

event guardar;//Declaracion de variables
  Integer i
  
//Para el caso de que se este sobre algun campo
  this.acceptText()

//Guarda en el .INI el numero total de Arquitectos
num_arquitectos=dw_Arquitectos.RowCount()
SetProfileString(i_fichero_ini,"ARQUITECTOS","NumArquitectos",String(num_arquitectos))


FOR i=1 TO dw_arquitectos.RowCount()
if i= 1 then
// Guardo los campos modificados de la seccion [ARQUITECTO_N]
SetProfileString(i_fichero_ini,"ARQUITECTO","TratamientoArquitecto_"+String(i),GetItemString(i,"TratamientoArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","NombreArquitecto_"+String(i),GetItemString(i,"NombreArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","NumColegiado_"+String(i),GetItemString(i,"NumColegiado_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","IdentificacionArquitecto_"+String(i),GetItemString(i,"IdentificacionArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","NumIdentificacionArquitecto_"+String(i),GetItemString(i,"NumIdentificacionArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","DomicilioArquitecto_"+String(i),GetItemString(i,"DomicilioArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","TMArquitecto_"+String(i),GetItemString(i,"TMArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","CPArquitecto_"+String(i),GetItemString(i,"CPArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","TelefonoArquitecto_"+String(i),GetItemString(i,"TelefonoArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","FaxArquitecto_"+String(i),GetItemString(i,"FaxArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO","Email_"+String(i),GetItemString(i,"Email"))
SetProfileString(i_fichero_ini,"ARQUITECTO","PorcentajeProyectoArquitecto_"+String(i),String(GetItemDecimal(i,"PorcentajeProyectoArquitecto")))
SetProfileString(i_fichero_ini,"ARQUITECTO","PorcentajeDireccionArquitecto_"+String(i),String(GetItemDecimal(i,"PorcentajeDireccionArquitecto")))
SetProfileString(i_fichero_ini,"ARQUITECTO","Representante",GetItemString(i,"Representante"))
SetProfileString(i_fichero_ini,"ARQUITECTO","NifRepresentante",GetItemString(i,"NifRepresentante"))
SetProfileString(i_fichero_ini,"ARQUITECTO","domiciliorepre",GetItemString(i,"domiciliorepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","numrepre",GetItemString(i,"numrepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","poblacionrepre",GetItemString(i,"poblacionrepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","provinciarepre",GetItemString(i,"provinciarepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","cprepre",GetItemString(i,"cprepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","N_protocolo",GetItemString(i,"N_protocolo"))
SetProfileString(i_fichero_ini,"ARQUITECTO","NomNotario",GetItemString(i,"NomNotario"))
SetProfileString(i_fichero_ini,"ARQUITECTO","Fecha",GetItemString(i,"Fecha"))
SetProfileString(i_fichero_ini,"ARQUITECTO","intervencion",GetItemString(i,"intervencion"))
SetProfileString(i_fichero_ini,"ARQUITECTO","telefonorepre",GetItemString(i,"telefonorepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO","Calidad",GetItemString(i,"Calidad"))
end if
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"TratamientoArquitecto_"+String(i),GetItemString(i,"TratamientoArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"NombreArquitecto_"+String(i),GetItemString(i,"NombreArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"NumColegiado_"+String(i),GetItemString(i,"NumColegiado_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"IdentificacionArquitecto_"+String(i),GetItemString(i,"IdentificacionArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"NumIdentificacionArquitecto_"+String(i),GetItemString(i,"NumIdentificacionArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"DomicilioArquitecto_"+String(i),GetItemString(i,"DomicilioArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"TMArquitecto_"+String(i),GetItemString(i,"TMArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"CPArquitecto_"+String(i),GetItemString(i,"CPArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"TelefonoArquitecto_"+String(i),GetItemString(i,"TelefonoArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"FaxArquitecto_"+String(i),GetItemString(i,"FaxArquitecto_1"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"Email_"+String(i),GetItemString(i,"Email"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"PorcentajeProyectoArquitecto_"+String(i),String(GetItemDecimal(i,"PorcentajeProyectoArquitecto")))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"PorcentajeDireccionArquitecto_"+String(i),String(GetItemDecimal(i,"PorcentajeDireccionArquitecto")))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"Representante",GetItemString(i,"Representante"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"NifRepresentante",GetItemString(i,"NifRepresentante"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"domiciliorepre",GetItemString(i,"domiciliorepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"numrepre",GetItemString(i,"numrepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"poblacionrepre",GetItemString(i,"poblacionrepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"provinciarepre",GetItemString(i,"provinciarepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"cprepre",GetItemString(i,"cprepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"N_protocolo",GetItemString(i,"N_protocolo"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"NomNotario",GetItemString(i,"NomNotario"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"Fecha",GetItemString(i,"Fecha"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"intervencion",GetItemString(i,"intervencion"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"telefonorepre",GetItemString(i,"telefonorepre"))
SetProfileString(i_fichero_ini,"ARQUITECTO_"+String(i),"Calidad",GetItemString(i,"Calidad"))

NEXT




end event

event csd_formato;SetItem(GetRow(), "numcolegiado_1", string(long(this.GetItemString(GetRow(),'numcolegiado_1')),'00000'))
end event

event constructor;datawindowchild dwc_muni_repre
this.settransobject(SQLCA)
//Declaracion de Variables
  Integer i

//Obtengo el numero de Arquitectos
  Num_Arquitectos=ProfileInt(i_fichero_ini,"Arquitectos","NumArquitectos",0)
  
  //creo la datawindow child
  dw_arquitectos.GetChild("arquitectobuscar", dwc_arquitectos)
//  dwc_arquitectos.ImportFile(sg_directorio + "arquitec.dbf")
//Ordeno los arquitectos
  dwc_arquitectos.SetSort("Numcolegiado_1 A")
  dwc_arquitectos.Sort()
  

  dw_arquitectos.GetChild("tmarquitecto_1", dwc_municipios)
 // dwc_municipios.importfile(sg_directorio + "muni.dbf")



//Ordeno los Municipios
  dwc_municipios.SetSort("Nombre_Mun A")
  dwc_municipios.Sort()

  dw_arquitectos.GetChild("poblacionrepre", dwc_muni_repre)
  //dwc_muni_repre.importfile(sg_directorio + "muni.dbf")



//Ordeno los Municipios
  dwc_muni_repre.SetSort("Nombre_Mun A")
  dwc_muni_repre.Sort()
  
//Si no existe ningun arquitecto inserto uno nuevo
IF Num_Arquitectos = 0  THEN
	InsertRow(0)
		SetItem(GetRow(), "PorcentajeProyectoArquitecto", 100)
		SetItem(GetRow(), "PorcentajeDireccionArquitecto", 100)

ELSE
 //Sino Inserto todos los que haya	
   FOR i=1 TO Num_arquitectos
       IF ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NombreArquitecto_"+String(i),"") <> "" THEN 
	    //Inserto una fila y me situo el la fila que acabo de insertar
		InsertRow(0) 
		Scrolltorow(RowCount()) 
		SetItem(GetRow(), "TratamientoArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"TratamientoArquitecto_"+String(i),"D."))
		SetItem(GetRow(), "NombreArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NombreArquitecto_"+String(i),""))
		SetItem(GetRow(), "arquitectobuscar", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NombreArquitecto_"+String(i),""))
		SetItem(GetRow(), "NumColegiado_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NumColegiado_"+String(i),""))
		SetItem(GetRow(), "IdentificacionArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"IdentificacionArquitecto_"+String(i),"DNI"))
		SetItem(GetRow(), "NumIdentificacionArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NumIdentificacionArquitecto_"+String(i),""))
		SetItem(GetRow(), "DomicilioArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"DomicilioArquitecto_"+String(i),""))
		SetItem(GetRow(), "TMArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"TMArquitecto_"+String(i),""))
		SetItem(GetRow(), "CPArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"CPArquitecto_"+String(i),""))
		SetItem(GetRow(), "TelefonoArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"TelefonoArquitecto_"+String(i),""))
		SetItem(GetRow(), "FaxArquitecto_1", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"FaxArquitecto_"+String(i),""))
		SetItem(GetRow(), "Email", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"Email_"+String(i),""))
		SetItem(GetRow(), "PorcentajeProyectoArquitecto", Dec(ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"PorcentajeProyectoArquitecto_"+String(i),"0")))
		SetItem(GetRow(), "PorcentajeDireccionArquitecto", Dec(ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"PorcentajeDireccionArquitecto_"+String(i),"0")))
		SetItem(GetRow(), "Representante", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"Representante",""))
		SetItem(GetRow(), "NifRepresentante", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NifRepresentante",""))
		SetItem(GetRow(), "domiciliorepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"domiciliorepre",""))
		SetItem(GetRow(), "provinciarepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"provinciarepre",""))
		SetItem(GetRow(), "numrepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"numrepre",""))
		SetItem(GetRow(), "cprepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"cprepre",""))
		SetItem(GetRow(), "poblacionrepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"poblacionrepre",""))
		SetItem(GetRow(), "N_protocolo", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"N_protocolo",""))
		SetItem(GetRow(), "NomNotario", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"NomNotario",""))
		SetItem(GetRow(), "Fecha", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"Fecha",""))		
		SetItem(GetRow(), "intervencion", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"intervencion","S"))	
		SetItem(GetRow(), "telefonorepre", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"telefonorepre",""))	
		SetItem(GetRow(), "Calidad", ProfileString(i_fichero_ini,"Arquitecto_"+String(i),"Calidad",""))
		
       END IF 		  
   NEXT	
END IF	

  num_arquitectos=dw_arquitectos.RowCount()


//Visualizo el campo de la datawindow Child
  dw_arquitectos.Object.NombreArquitecto_1.Visible=False
  dw_arquitectos.Object.ArquitectoBuscar.Visible=True  
  

//Me posiciono en al primera fila
  ScrolltoRow(1)
  
//visualizo el total de arquitectos que hay
  st_1.text="Arquitecto "+String(GetRow())+"/"+String(num_arquitectos)
  

end event

event buttonclicked;// declaracion variable
string	boton_pulsado

// Obtengo el nombre del objeto seleccionado
boton_pulsado = String(dwo.name)


If boton_pulsado = "b_busqueda_nombre" Then
	
 
End If
end event

event itemerror;messagebox("Error","El campo no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n. Introduzca un valor correcto.")
return 1
end event

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Aparejadores"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_21 cb_21
cb_20 cb_20
st_3 st_3
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
dw_aparejadores dw_aparejadores
end type

on tabpage_4.create
this.cb_21=create cb_21
this.cb_20=create cb_20
this.st_3=create st_3
this.cb_19=create cb_19
this.cb_18=create cb_18
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_15=create cb_15
this.dw_aparejadores=create dw_aparejadores
this.Control[]={this.cb_21,&
this.cb_20,&
this.st_3,&
this.cb_19,&
this.cb_18,&
this.cb_17,&
this.cb_16,&
this.cb_15,&
this.dw_aparejadores}
end on

on tabpage_4.destroy
destroy(this.cb_21)
destroy(this.cb_20)
destroy(this.st_3)
destroy(this.cb_19)
destroy(this.cb_18)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.dw_aparejadores)
end on

type cb_21 from commandbutton within tabpage_4
integer x = 434
integer y = 1420
integer width = 270
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;//Declaracion de variables
  Integer valor
  

//emito un mesaje de comprobacion
 valor=MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","$$HEX1$$bf00$$ENDHEX$$Desea eliminar el Aparejador Actual?",Exclamation!,YesNo!)

 IF valor= 1 THEN
    //Eliminamos el Arquitecto de la Data Window 
      dw_aparejadores.DeleteRow(dw_aparejadores.GetRow())
	 //Decremento la variable "num_aparejadores"
	   num_aparejadores=num_aparejadores -1
    //Despues de borrar me voy al primer registro (Aparejador)
      dw_aparejadores.ScrolltoRow(1)

END IF	 



//visualizo el total de arquitectos que hay
  st_3.text="Aparejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type cb_20 from commandbutton within tabpage_4
integer x = 142
integer y = 1420
integer width = 247
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "A$$HEX1$$f100$$ENDHEX$$adir"
end type

event clicked;//Inserto una fila para introducir un nuevo aparejadores
//pero compruebo antes si no a superado el limite de 4 aparejadores

//IF num_aparejadores< 4 THEN
	//Inseto la nueva fila
     dw_aparejadores.InsertRow(0)

   //Me desplazo a esa nueva fila
     dw_aparejadores.ScrolltoRow(dw_aparejadores.RowCount())
	  
	//Incremento la varible num_arquitectos
  	  num_aparejadores=num_aparejadores + 1
//END IF	

//visualizo el total de arquitectos que hay
  st_3.text="Aparejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type st_3 from statictext within tabpage_4
integer x = 2258
integer y = 1336
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Aparejador"
boolean focusrectangle = false
end type

type cb_19 from commandbutton within tabpage_4
integer x = 2619
integer y = 1420
integer width = 247
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ultimo"
end type

event clicked;//Inserta el Ultimo Arquitecto
   dw_aparejadores.ScrolltoRow(dw_aparejadores.RowCount())
//visualizo el total de arquitectos que hay
  st_3.text="Aperejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type cb_18 from commandbutton within tabpage_4
integer x = 2309
integer y = 1420
integer width = 302
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Siguiente"
end type

event clicked;//Inserta el Siguiente Arquitecto
   dw_aparejadores.ScrollNextRow()
//visualizo el total de arquitectos que hay
  st_3.text="Aparejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type cb_17 from commandbutton within tabpage_4
integer x = 2039
integer y = 1420
integer width = 261
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anterior"
end type

event clicked;//Inserta el Anterior Arquitecto
   dw_aparejadores.ScrollPriorRow()
//visualizo el total de arquitectos que hay
  st_3.text="Aparejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type cb_16 from commandbutton within tabpage_4
integer x = 1769
integer y = 1420
integer width = 261
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Primero"
end type

event clicked;//Inserta el Primer Arquitecto
   dw_aparejadores.ScrolltoRow(1)
//visualizo el total de arquitectos que hay
  st_3.text="Aparejador "+String(dw_aparejadores.GetRow())+"/"+String(num_aparejadores)

end event

type cb_15 from commandbutton within tabpage_4
integer x = 1019
integer y = 1420
integer width = 480
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar Agenda"
end type

event clicked;   //Declaracion de variables    
	  Integer Num_Columnas,valor,i,Num_fila, fila_busqueda	   
	
	//Para el caso en el que esten introduciendo texto en ese momento
	  dw_aparejadores.Accepttext()	 
		 
	  //Calculo el numero de filas de fichero CLIENTES.DBF
	     Num_Fila=dwc_aparejadores.RowCount()
	  //Miro si existe algun cliente con el mismo DNI
		  fila_busqueda=dwc_aparejadores.Find("numidentificacion='"+dw_aparejadores.GetItemString(dw_aparejadores.GetRow(),"numidentificacion")+"'",1,Num_fila)
        
		  //si encuentro algun registro emito un mensaje 
		  IF fila_busqueda>0 THEN
			
			    MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","$$HEX1$$a100$$ENDHEX$$Este Aparejador ya Existe!")
			  
		  ELSE
			
          //Inserto una fila en la datawindowchild y me situo en ella
	            dwc_aparejadores.InsertRow(0)
	            Num_fila=dwc_aparejadores.RowCount()

	            Num_Columnas=integer(dwc_aparejadores.describe("datawindow.column.count"))
				
			  //almaceno los datos en la datawindowchild
   	       FOR i=1 to Num_Columnas
			        dwc_aparejadores.SetItem(Num_fila,i,dw_aparejadores.GetItemString(dw_aparejadores.GetRow(),i))
		       NEXT
				 
  	       //guardo la data child
         //  IF  dwc_aparejadores.SaveAs(sg_directorio + "APAREJA.DBF", dBASE3!, TRUE)= 1 THEN
				
	//			   MessageBox("Agregar Agenda","El Aparejador se ha agregado con exito.")
				
	//		  END IF	
	 
		  END IF	 

	  
	  
	  
end event

type dw_aparejadores from datawindow within tabpage_4
event guardar ( )
event csd_formato ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1300
integer taborder = 30
string dataobject = "d_mantenimiento_aparejadores"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Datos Urban$$HEX1$$ed00$$ENDHEX$$sticos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_datos_generales dw_datos_generales
end type

on tabpage_5.create
this.dw_datos_generales=create dw_datos_generales
this.Control[]={this.dw_datos_generales}
end on

on tabpage_5.destroy

destroy(this.dw_datos_generales)
end on

type dw_datos_generales from datawindow within tabpage_5
event guardar ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1300
integer taborder = 20
string dataobject = "d_datos_generales"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event guardar;//Para el caso de que se este sobre algun campo
  this.acceptText()

/////////////////////// Almaceno los Datos Generales /////////////////////////////////////////////////////////


// Guardo  los campos modificados del cuadro "1 Planeamiento de aplicacion"
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Planeamiento",GetItemString(GetRow(),"Planeamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","EstadoPlaneamiento",String(GetItemNumber(GetRow(),"EstadoPlaneamiento")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","EnFaseDe",GetItemString(GetRow(),"EnFaseDe"))

// Guardo los campos modificados del cuadro "2 Clasificacion del suelo"
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Clasificacion",GetItemString(GetRow(),"Clasificacion"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Calificacion",GetItemString(GetRow(),"Calificacion"))

// Guardo los datos modificados en el cuadro "3 Normativas basicas y sectoriales de aplicacion"
SetProfileString(i_fichero_ini,"PLANEAMIENTO","EspaciosNaturales",String(GetItemNumber(GetRow(),"EspaciosNaturales")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","PatrimonioHistoricoArtistico",String(GetItemNumber(GetRow(),"PatrimonioHistoricoArtistico")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","YacimientosArqueologicos",String(GetItemNumber(GetRow(),"YacimientosArqueologicos")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Costas",String(GetItemNumber(GetRow(),"Costas")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","ImpactoAmbiental",String(GetItemNumber(GetRow(),"ImpactoAmbiental")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Aguas",String(GetItemNumber(GetRow(),"Aguas")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Carreteras",String(GetItemNumber(GetRow(),"Carreteras")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Otras",String(GetItemNumber(GetRow(),"Otras")))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Observaciones",f_convierte_retornos_carro(GetItemString(GetRow(),"Observaciones")))
//SetProfileString(i_fichero_ini,"PLANEAMIENTO","Observaciones2",GetItemString(GetRow(),"Observaciones2"))


// Guardo los campos modificados en el cuadro "5 Adecuacion a la normativa urbanistica"
SetProfileString(i_fichero_ini,"PLANEAMIENTO","UsoPlaneamiento",GetItemString(GetRow(),"UsoPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","UsoProyecto",GetItemString(GetRow(),"UsoProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","SuperficieParcelaPlaneamiento",GetItemString(GetRow(),"SuperficieParcelaPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","SuperficieParcelaProyecto",GetItemString(GetRow(),"SuperficieParcelaProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","OcupacionPlaneamiento",GetItemString(GetRow(),"OcupacionPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","OcupacionProyecto",GetItemString(GetRow(),"OcupacionProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","CoefEdificabilidadPlaneamiento",GetItemString(GetRow(),"CoefEdificabilidadPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","CoefEdificabilidadProyecto",GetItemString(GetRow(),"CoefEdificabilidadProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","VolumenComputablePlaneamiento",GetItemString(GetRow(),"VolumenComputablePlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","VolumenComputableProyecto",GetItemString(GetRow(),"VolumenComputableProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","SuperficieTotalComputablePlaneamiento",GetItemString(GetRow(),"SuperficieTotalComputablePlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","SuperficieTotalComputableProyecto",GetItemString(GetRow(),"SuperficieTotalComputableProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","AlturaEdificacionPlaneamiento",GetItemString(GetRow(),"AlturaEdificacionPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","AlturaEdificacionProyecto",GetItemString(GetRow(),"AlturaEdificacionProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","NumMaxPlantasBRPlaneamiento",GetItemString(GetRow(),"NumMaxPlantasBRPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","NumMaxPlantasBRProyecto",GetItemString(GetRow(),"NumMaxPlantasBRProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","NumMaxPlantasSRPlaneamiento",GetItemString(GetRow(),"NumMaxPlantasSRPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","NumMaxPlantasSRProyecto",GetItemString(GetRow(),"NumMaxPlantasSRProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","RetranqueosPlaneamiento",GetItemString(GetRow(),"RetranqueosPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","RetranqueosProyecto",GetItemString(GetRow(),"RetranqueosProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","FondoMaximoPlaneamiento",GetItemString(GetRow(),"FondoMaximoPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","FondoMaximoProyecto",GetItemString(GetRow(),"FondoMaximoProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","RetranqueoAticosPlaneamiento",GetItemString(GetRow(),"RetranqueoAticosPlaneamiento"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","RetranqueoAticosProyecto",GetItemString(GetRow(),"RetranqueoAticosProyecto"))
SetProfileString(i_fichero_ini,"PLANEAMIENTO","Incumpleurbanistico",GetItemString(GetRow(),"Incumpleurbanistico"))



end event

event constructor;string suelo
 

InsertRow(0)

// Inicializo campos a los valores que aparecen en el fichero INI, sino hay ningun
// valor, inicializo el campo con un valor por defecto


	

	// Inicializo los datos que aparecen en "Planeamiento de Aplicacion"	
		SetItem(GetRow(), "Planeamiento", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento",""))
				
      IF ProfileInt(i_fichero_ini,"Planeamiento","EstadoPlaneamiento",0)=0 then
	        // En este caso el valor de la columna "EstadoPlanteamiento" sera "0" (equivale a seleccionar 
	        // "Vigente") con lo que tendremos que desabilitar el campo que se tendria que rellenar
		     // si seleccionaramos "En fase de"
           SetItem(GetRow(), "EstadoPlaneamiento",0)
           this.SetTabOrder ("EnFaseDe", 0)

         ELSE
	        // En este caso (equivale a seleccionar "En fase de"), tendremos que recuperar
	        // el valor del campo
               SetItem(GetRow(), "EstadoPlaneamiento",1)
		         SetItem(GetRow(), "EnFaseDe", ProfileString(i_fichero_ini,"Planeamiento","EnFaseDe",""))
			   
	      END IF

      //Obtengo los valores almacenados de "Clasificacion del suelo" 
		SetItem(GetRow(), "Clasificacion", ProfileString(i_fichero_ini,"Planeamiento","Clasificacion",""))
	//	SetItem(GetRow(), "Calificacion", ProfileString(i_fichero_ini,"Planeamiento","Calificacion",""))
		
		// Inicializo los datos que aparecen en "Planeamiento de Aplicacion"	
		SetItem(GetRow(), "Planeamiento_1", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_1",""))
		SetItem(GetRow(), "Planeamiento_2", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_2",""))
		SetItem(GetRow(), "Planeamiento_3", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_3",""))
		SetItem(GetRow(), "Planeamiento_4", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_4",""))
		SetItem(GetRow(), "Planeamiento_5", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_5",""))
		SetItem(GetRow(), "Planeamiento_6", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_6",""))
		SetItem(GetRow(), "Planeamiento_7", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_7",""))
		SetItem(GetRow(), "Planeamiento_8", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_8",""))
		SetItem(GetRow(), "Planeamiento_9", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_9",""))
		SetItem(GetRow(), "Planeamiento_10", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_10",""))
		SetItem(GetRow(), "Planeamiento_11", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_11",""))
		SetItem(GetRow(), "Planeamiento_12", ProfileString(i_fichero_ini,"Planeamiento","Planeamiento_12",""))

      //Obtengo los valores almacenados de "Clasificacion del suelo" 
		suelo = ProfileString(i_fichero_ini,"Planeamiento","class_urbano","")
		SetItem(GetRow(), "class_urbano", suelo)
		suelo = ProfileString(i_fichero_ini,"Planeamiento","class_urbanizable","")
		SetItem(GetRow(), "class_urbanizable", suelo) 
		suelo = ProfileString(i_fichero_ini,"Planeamiento","class_rustico","")
		SetItem(GetRow(), "class_rustico", suelo)


      //Obtengo los valores almacenados de "Normativas Basicas y Sectoriales de Aplicacion"
		SetItem(GetRow(), "EspaciosNaturales", ProfileInt(i_fichero_ini,"Planeamiento","EspaciosNaturales",0))
		SetItem(GetRow(), "PatrimonioHistoricoArtistico", ProfileInt(i_fichero_ini,"Planeamiento","PatrimonioHistoricoArtistico",0))
		SetItem(GetRow(), "YacimientosArqueologicos", ProfileInt(i_fichero_ini,"Planeamiento","YacimientosArqueologicos",0))
		SetItem(GetRow(), "Costas", ProfileInt(i_fichero_ini,"Planeamiento","Costas",0))
		SetItem(GetRow(), "ImpactoAmbiental", ProfileInt(i_fichero_ini,"Planeamiento","ImpactoAmbiental",0))
		SetItem(GetRow(), "Aguas", ProfileInt(i_fichero_ini,"Planeamiento","Aguas",0))
		SetItem(GetRow(), "Carreteras", ProfileInt(i_fichero_ini,"Planeamiento","Carreteras",0))
		SetItem(GetRow(), "Otras", ProfileInt(i_fichero_ini,"Planeamiento","Otras",0))
		SetItem(GetRow(), "Observaciones", f_convierte_retornos_carro(ProfileString(i_fichero_ini,"planeamiento","observaciones","")))
		//SetItem(GetRow(), "Observaciones2", ProfileString(i_fichero_ini,"Planeamiento","Observaciones2",""))


      
	 // Recupero los datos almacenados que aparecen en el cuadro de "Adecuacion a la Normativa" 
		SetItem(GetRow(), "UsoPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","UsoPlaneamiento",""))
		SetItem(GetRow(), "UsoProyecto", ProfileString(i_fichero_ini,"Planeamiento","UsoProyecto",""))
		SetItem(GetRow(), "SuperficieParcelaPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","SuperficieParcelaPlaneamiento",""))
		SetItem(GetRow(), "SuperficieParcelaProyecto", ProfileString(i_fichero_ini,"Planeamiento","SuperficieParcelaProyecto",""))
		SetItem(GetRow(), "OcupacionPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","OcupacionPlaneamiento",""))
		SetItem(GetRow(), "OcupacionProyecto", ProfileString(i_fichero_ini,"Planeamiento","OcupacionProyecto",""))
		SetItem(GetRow(), "CoefEdificabilidadPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","CoefEdificabilidadPlaneamiento",""))
		SetItem(GetRow(), "CoefEdificabilidadProyecto", ProfileString(i_fichero_ini,"Planeamiento","CoefEdificabilidadProyecto",""))
		SetItem(GetRow(), "VolumenComputablePlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","VolumenComputablePlaneamiento",""))
		SetItem(GetRow(), "VolumenComputableProyecto", ProfileString(i_fichero_ini,"Planeamiento","VolumenComputableProyecto",""))
		SetItem(GetRow(), "SuperficieTotalComputablePlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","SuperficieTotalComputablePlaneamiento",""))
		SetItem(GetRow(), "SuperficieTotalComputableProyecto", ProfileString(i_fichero_ini,"Planeamiento","SuperficieTotalComputableProyecto",""))
		SetItem(GetRow(), "AlturaEdificacionPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","AlturaEdificacionPlaneamiento",""))
		SetItem(GetRow(), "AlturaEdificacionProyecto", ProfileString(i_fichero_ini,"Planeamiento","AlturaEdificacionProyecto",""))
		SetItem(GetRow(), "NumMaxPlantasBRPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","NumMaxPlantasBRPlaneamiento",""))
		SetItem(GetRow(), "NumMaxPlantasBRProyecto", ProfileString(i_fichero_ini,"Planeamiento","NumMaxPlantasBRProyecto",""))
		SetItem(GetRow(), "NumMaxPlantasSRPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","NumMaxPlantasSRPlaneamiento",""))
		SetItem(GetRow(), "NumMaxPlantasSRProyecto", ProfileString(i_fichero_ini,"Planeamiento","NumMaxPlantasSRProyecto",""))
		SetItem(GetRow(), "RetranqueosPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","RetranqueosPlaneamiento",""))
		SetItem(GetRow(), "RetranqueosProyecto", ProfileString(i_fichero_ini,"Planeamiento","RetranqueosProyecto",""))
		SetItem(GetRow(), "FondoMaximoPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","FondoMaximoPlaneamiento",""))
		SetItem(GetRow(), "FondoMaximoProyecto", ProfileString(i_fichero_ini,"Planeamiento","FondoMaximoProyecto",""))
		SetItem(GetRow(), "RetranqueoAticosPlaneamiento", ProfileString(i_fichero_ini,"Planeamiento","RetranqueoAticosPlaneamiento",""))
		SetItem(GetRow(), "RetranqueoAticosProyecto", ProfileString(i_fichero_ini,"Planeamiento","RetranqueoAticosProyecto",""))
//		SetItem(GetRow(), "Incumpleurbanistico", ProfileString(i_fichero_ini,"Planeamiento","Incumpleurbanistico",""))

  // Recupero el numero de hojas anexas
		SetItem(GetRow(), "NumHojasAnexas", ProfileInt(i_fichero_ini,"Planeamiento","NumHojasAnexas",0))

end event

event itemerror;messagebox("Error","El campo no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n. Introduzca un valor correcto.")
return 1
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3104
integer height = 1588
long backcolor = 79741120
string text = "Datos Trabajos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_trabajos dw_trabajos
end type

on tabpage_6.create
this.dw_trabajos=create dw_trabajos
this.Control[]={this.dw_trabajos}
end on

on tabpage_6.destroy
destroy(this.dw_trabajos)
end on

type dw_trabajos from datawindow within tabpage_6
event guardar ( )
event csd_actualiza_honorarios ( )
integer x = 23
integer y = 32
integer width = 3058
integer height = 1532
integer taborder = 30
string dataobject = "d_trabajos"
boolean border = false
boolean livescroll = true
end type

event guardar;//Para el caso de que se este sobre algun campo
  this.acceptText()

/////////////////////// Almaceno los Datos Generales /////////////////////////////////////////////////////////

	 //Almaceno el valor del campo mision
		SetProfileString(i_fichero_ini,"Trabajos","Mision",GetItemString(GetRow(),"Mision"))

      //Almaceno los valores referentes a la descripcion de cada una de las fases
		SetProfileString(i_fichero_ini,"Trabajos","fase1",GetItemString(GetRow(),"fase1"))
		SetProfileString(i_fichero_ini,"Trabajos","fase2",GetItemString(GetRow(),"fase2"))
		SetProfileString(i_fichero_ini,"Trabajos","fase3",GetItemString(GetRow(),"fase3"))
		SetProfileString(i_fichero_ini,"Trabajos","fase4",GetItemString(GetRow(),"fase4"))
		SetProfileString(i_fichero_ini,"Trabajos","fase5",GetItemString(GetRow(),"fase5"))
		SetProfileString(i_fichero_ini,"Trabajos","fase6",GetItemString(GetRow(),"fase6"))
		SetProfileString(i_fichero_ini,"Trabajos","fase7",GetItemString(GetRow(),"fase7"))

      //Almaceno los valores relacionados con los honarios totales
		SetProfileString(i_fichero_ini,"Trabajos","fase_1_honorarios",string(GetItemNumber(GetRow(),"fase_1_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_2_honorarios",string(GetItemNumber(GetRow(),"fase_2_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_3_honorarios",string(GetItemNumber(GetRow(),"fase_3_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_4_honorarios",string(GetItemNumber(GetRow(),"fase_4_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_5_honorarios",string(GetItemNumber(GetRow(),"fase_5_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_6_honorarios",string(GetItemNumber(GetRow(),"fase_6_honorarios")))
		SetProfileString(i_fichero_ini,"Trabajos","fase_7_honorarios",string(GetItemNumber(GetRow(),"fase_7_honorarios")))
      
	 //Almaceno los valores relacionados con los plazos de ejecucion
		SetProfileString(i_fichero_ini,"Trabajos","fase_1_ejecucion",GetItemstring(GetRow(),"fase_1_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_2_ejecucion",GetItemstring(GetRow(),"fase_2_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_3_ejecucion",GetItemstring(GetRow(),"fase_3_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_4_ejecucion",GetItemstring(GetRow(),"fase_4_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_5_ejecucion",GetItemstring(GetRow(),"fase_5_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_6_ejecucion",GetItemstring(GetRow(),"fase_6_ejecucion"))
		SetProfileString(i_fichero_ini,"Trabajos","fase_7_ejecucion",GetItemstring(GetRow(),"fase_7_ejecucion"))
		
	//Almaceno otros valores del trabajo
		SetProfileString(i_fichero_ini,"Trabajos","honorarios_totales",string(GetItemNumber(GetRow(),"honorarios_totales")))
		SetProfileString(i_fichero_ini,"Trabajos","igic",string(GetItemNumber(GetRow(),"igic")))
		SetProfileString(i_fichero_ini,"Trabajos","ProvFondos",GetItemString(GetRow(),"ProvFondos"))
		SetProfileString(i_fichero_ini,"Trabajos","ProvCant",string(GetItemNumber(GetRow(),"ProvCant")))
		SetProfileString(i_fichero_ini,"Trabajos","ProvPorc",string(GetItemNumber(GetRow(),"ProvPorc")))
		
		SetProfileString(i_fichero_ini,"Trabajos","Encomendar",GetItemString(GetRow(),"Encomendar"))
		SetProfileString(i_fichero_ini,"Trabajos","Autorizar",GetItemString(GetRow(),"Autorizar"))

	

end event

event csd_actualiza_honorarios;long i
double h
h=0
For i= 1 to 7

if not isnull(this.getitemnumber(1,'fase_'+string(i)+'_honorarios')) then h += this.getitemnumber(1,'fase_'+string(i)+'_honorarios')

next

this. setitem(1,'honorarios_totales',h)
end event

event constructor;
InsertRow(0)

// Inicializo campos a los valores que aparecen en el fichero INI, sino hay ningun
// valor, inicializo el campo con un valor por defecto


	

	// Inicializo los datos que aparecen en "Planeamiento de Aplicacion"	
//		string estado_mision
//		estado_mision=ProfileString(i_fichero_ini,"Trabajos","Mision","")
//		if estado_mision="" then
//			SetItem(1,"Mision",ProfileString(i_fichero_ini,"EXPEDIENTE","Mision",""))
//		else
//			if estado_mision="COMPLETA" then
//				SetItem(1, "Mision", "Completa")
//			else 
//				if estado_mision="PARCIAL" then
//					SetItem(1, "Mision", "Parcial")
//				end if
//			end if
//		end if
	

				
//////      IF ProfileInt(i_fichero_ini,"Planeamiento","EstadoPlaneamiento",0)=0 then
//////	        // En este caso el valor de la columna "EstadoPlanteamiento" sera "0" (equivale a seleccionar 
//////	        // "Vigente") con lo que tendremos que desabilitar el campo que se tendria que rellenar
//////		     // si seleccionaramos "En fase de"
//////           SetItem(GetRow(), "EstadoPlaneamiento",0)
//////           this.SetTabOrder ("EnFaseDe", 0)
//////
//////         ELSE
//////	        // En este caso (equivale a seleccionar "En fase de"), tendremos que recuperar
//////	        // el valor del campo
//////               SetItem(GetRow(), "EstadoPlaneamiento",1)
//////		         SetItem(GetRow(), "EnFaseDe", ProfileString(i_fichero_ini,"Planeamiento","EnFaseDe",""))
//////			   
//////	      END IF

      //Obtengo los valores almacenados referentes a la descripcion de cada una de las fases
//		SetItem(GetRow(), "fase1", ProfileString(i_fichero_ini,"Trabajos","fase1",""))
//		SetItem(GetRow(), "fase2", ProfileString(i_fichero_ini,"Trabajos","fase2",""))
//		SetItem(GetRow(), "fase3", ProfileString(i_fichero_ini,"Trabajos","fase3",""))
//		SetItem(GetRow(), "fase4", ProfileString(i_fichero_ini,"Trabajos","fase4",""))

// si el expediente es antiguo (osea si los primeros valores de fases y honorarios no estan rellenos)
if ProfileString(i_fichero_ini,"Trabajos","fase1","") ="" and &
        ProfileString(i_fichero_ini,"Trabajos","fase_1_honorarios","") ="" and &
		  ProfileString(i_fichero_ini,"Trabajos","fase_1_ejecucion","")= "" and & 
		  ProfileString(i_fichero_ini,"Trabajos","honorarios_totales","") = ""		  then
		  
		if ProfileString(i_fichero_ini,"FASES","Fase_1","")<>"" then
			SetItem(1,"fase1",ProfileString(i_fichero_ini,"FASES","Fase_1",""))
			SetItem(1, "fase_1_honorarios", double(ProfileString(i_fichero_ini,"FASES","Honorarios_fase_1","")))
		   SetItem(1, "fase_1_ejecucion", ProfileString(i_fichero_ini,"FASES","PlazoEjecucion_1",''))
	   end if
		if ProfileString(i_fichero_ini,"FASES","Fase_2","")<>"" then
			SetItem(1,"fase2",ProfileString(i_fichero_ini,"FASES","Fase_2",""))
			SetItem(1, "fase_2_honorarios", double(ProfileString(i_fichero_ini,"FASES","Honorarios_fase_2","")))
		   SetItem(1, "fase_2_ejecucion", ProfileString(i_fichero_ini,"FASES","PlazoEjecucion_2",''))
	   end if
		if ProfileString(i_fichero_ini,"FASES","Fase_3","")<>"" then
			SetItem(1,"fase3",ProfileString(i_fichero_ini,"FASES","Fase_3",""))
			SetItem(1, "fase_3_honorarios", double(ProfileString(i_fichero_ini,"FASES","Honorarios_fase_3","")))
		   SetItem(1, "fase_3_ejecucion", ProfileString(i_fichero_ini,"FASES","PlazoEjecucion_3",''))
	   end if
		if ProfileString(i_fichero_ini,"FASES","Fase_4","")<>"" then
			SetItem(1,"fase4",ProfileString(i_fichero_ini,"FASES","Fase_4",""))
			SetItem(1, "fase_4_honorarios", double(ProfileString(i_fichero_ini,"FASES","Honorarios_fase_4","")))
		   SetItem(1, "fase_4_ejecucion", ProfileString(i_fichero_ini,"FASES","PlazoEjecucion_4",''))
	   end if
		
		if ProfileString(i_fichero_ini,"OTROS","IGIC","")<>"" then
	     	SetItem(1, "IGIC", double(ProfileString(i_fichero_ini,"OTROS","IGIC","0")))
	     end if		
		  
		SetItem(GetRow(), "Mision", ProfileString(i_fichero_ini,"EXPEDIENTE","Mision",""))
		SetItem(1, "ProvCant", double(ProfileString(i_fichero_ini,"Expediente","ProvisionFondoCantidad","0")))
		SetItem(1, "ProvPorc", Double(ProfileString(i_fichero_ini,"Expediente","ProvisionFondoPorcentaje","0")))
		
		string valor_provision_fondos
		valor_provision_fondos=ProfileString(i_fichero_ini,"Expediente","ProvisionFondos","")
		CHOOSE CASE valor_provision_fondos
	   CASE '0'
	   	SetItem(1, "ProvFondos",'1')
		CASE '1'
	   	SetItem(1, "ProvFondos",'2')
      END CHOOSE

		
     this.triggerEvent("csd_actualiza_honorarios")
ELSE// NO ES UN EXPEDIENTE VIEJO
	

 
SetItem(GetRow(), "Mision", ProfileString(i_fichero_ini,"Trabajos","Mision",""))

      if ProfileString(i_fichero_ini,"Trabajos","fase1","") <>"" then
			SetItem(1, "fase1", ProfileString(i_fichero_ini,"Trabajos","fase1",""))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase2","") <>"" then
			SetItem(1, "fase2", ProfileString(i_fichero_ini,"Trabajos","fase2",""))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase3","") <>"" then
			SetItem(1, "fase3", ProfileString(i_fichero_ini,"Trabajos","fase3",""))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase4","") <>"" then
			SetItem(1, "fase4", ProfileString(i_fichero_ini,"Trabajos","fase4",""))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase5","") <>"" then
			SetItem(1, "fase5", ProfileString(i_fichero_ini,"Trabajos","fase5",""))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase6","") <>"" then
			SetItem(1, "fase6", ProfileString(i_fichero_ini,"Trabajos","fase6",""))
		end if
		if ProfileString(i_fichero_ini,"Trabajos","fase7","") <>"" then
			SetItem(1, "fase7", ProfileString(i_fichero_ini,"Trabajos","fase7",""))
		end if



	  if ProfileString(i_fichero_ini,"Trabajos","fase_1_honorarios","") <>""  then 
			SetItem(1, "fase_1_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_1_honorarios","")))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_2_honorarios","") <>"" then
			SetItem(1, "fase_2_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_2_honorarios","")))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_3_honorarios","") <>"" then
			SetItem(1, "fase_3_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_3_honorarios","")))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_4_honorarios","") <>"" then
			SetItem(1, "fase_4_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_4_honorarios","")))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_5_honorarios","") <>"" then
			SetItem(1, "fase_5_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_5_honorarios","")))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_6_honorarios","") <>"" then
			SetItem(1, "fase_6_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_6_honorarios","")))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_7_honorarios","") <>"" then
			SetItem(1, "fase_7_honorarios", double(ProfileString(i_fichero_ini,"Trabajos","fase_7_honorarios","")))
		end if

	   
	 //Obtengo los valores relacionados con los plazos de ejecucion

		if ProfileString(i_fichero_ini,"Trabajos","fase_1_ejecucion","")<> "" then
			SetItem(1, "fase_1_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_1_ejecucion",''))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_2_ejecucion","")<>"" then
			SetItem(1, "fase_2_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_2_ejecucion",''))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_3_ejecucion","")<>"" then
			SetItem(1, "fase_3_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_3_ejecucion",''))
		end if
		
		if ProfileString(i_fichero_ini,"Trabajos","fase_4_ejecucion","")<>"" then
			SetItem(1, "fase_4_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_4_ejecucion",''))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_5_ejecucion","")<>"" then
			SetItem(1, "fase_5_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_5_ejecucion",''))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_6_ejecucion","")<>"" then
			SetItem(1, "fase_6_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_6_ejecucion",''))
		end if

		if ProfileString(i_fichero_ini,"Trabajos","fase_7_ejecucion","")<>"" then
			SetItem(1, "fase_7_ejecucion", ProfileString(i_fichero_ini,"Trabajos","fase_7_ejecucion",''))
		end if

	
	//Obtengo otros valores del trabajo
		if ProfileString(i_fichero_ini,"Trabajos","honorarios_totales","") = "" then
			SetItem(1, "honorarios_totales", double(ProfileString(i_fichero_ini,"Expediente","Precio","0")))
		else
			SetItem(1, "honorarios_totales", double(ProfileString(i_fichero_ini,"Trabajos","honorarios_totales","0")))
		end if
		if ProfileString(i_fichero_ini,"Trabajos","IGIC","") ="" then
	//		SetItem(1, "IGIC",double(ProfileString( sg_directorio+"form.ini","parametros","IGIC","0")))
		else
			SetItem(1, "IGIC", double(ProfileString(i_fichero_ini,"Trabajos","IGIC","0")))
		end if

	
	
//		if Long(ProfileString(i_fichero_ini,"Trabajos","ProvFondos","")) <> 1 or Long(ProfileString(i_fichero_ini,"Trabajos","ProvFondos","")) <> 2 then
//			SetItem(1, "ProvFondos", ProfileInt(i_fichero_ini,"Expediente","ProvisionFondos",0))
//			IF 	GetItemNumber(1,"ProvFondos")=0 THEN
//				SetItem(1, "ProvCant", Long(ProfileString(i_fichero_ini,"Expediente","ProvisionFondoCantidad","")))
//			ELSE
//				SetItem(1, "ProvPorc", Dec(ProfileString(i_fichero_ini,"Expediente","ProvisionFondoPorcentaje","0")))
//			END IF
//		else	
//			SetItem(1, "ProvFondos", Long(ProfileString(i_fichero_ini,"Trabajos","ProvFondos","")))
//			
//			IF 	GetItemNumber(1,"ProvFondos")=1 THEN
//				SetItem(1, "ProvCant", Long(ProfileString(i_fichero_ini,"Trabajos","ProvCant","")))
//			END IF
//			IF 	GetItemNumber(1,"ProvFondos")=2 THEN
//				SetItem(1, "ProvPorc", Double(ProfileString(i_fichero_ini,"Trabajos","ProvPorc","0")))
//			END IF
//		end if
		
//		SetItem(GetRow(), "honorarios_totales", Double(ProfileString(i_fichero_ini,"Trabajos","honorarios_totales","")))
//		SetItem(GetRow(), "igic", Double(ProfileString(i_fichero_ini,"Trabajos","igic","")))


			SetItem(GetRow(), "ProvCant", Double(ProfileString(i_fichero_ini,"Trabajos","ProvCant","0")))
	
		
		
			SetItem(GetRow(), "ProvPorc", Double(ProfileString(i_fichero_ini,"Trabajos","ProvPorc","0")))
	
		
		SetItem(GetRow(), "ProvFondos", ProfileString(i_fichero_ini,"Trabajos","ProvFondos",""))
		
		
	end if// de la recuperacion de las fases del expediente antiguo	
	
	
  	     if  ProfileString(i_fichero_ini,"Trabajos","Encomendar","") = "" then
			SetItem(1, "Autorizar",ProfileString(i_fichero_ini,"ARQUITECTOS","Autorizacion","N"))
		else
			SetItem(GetRow(), "Autorizar", ProfileString(i_fichero_ini,"Trabajos","Autorizar",""))
		end if
		SetItem(GetRow(), "Encomendar", ProfileString(i_fichero_ini,"Trabajos","Encomendar",""))

		
		
		
		
		
		
		
end event

event itemerror;messagebox("Error","El campo no pasa el test de validaci$$HEX1$$f300$$ENDHEX$$n. Introduzca un valor correcto.")
return 1
end event

