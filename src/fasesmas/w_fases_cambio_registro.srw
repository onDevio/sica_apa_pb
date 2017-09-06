HA$PBExportHeader$w_fases_cambio_registro.srw
forward
global type w_fases_cambio_registro from w_response
end type
type cb_cancelar from commandbutton within w_fases_cambio_registro
end type
type cb_aceptar from commandbutton within w_fases_cambio_registro
end type
type sle_destino from singlelineedit within w_fases_cambio_registro
end type
type st_1 from statictext within w_fases_cambio_registro
end type
type rb_1 from radiobutton within w_fases_cambio_registro
end type
type rb_2 from radiobutton within w_fases_cambio_registro
end type
type cbx_introducir from checkbox within w_fases_cambio_registro
end type
end forward

global type w_fases_cambio_registro from w_response
integer width = 1678
integer height = 724
string title = "Cambio de Expediente"
event csd_preasignar_expediente ( )
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
sle_destino sle_destino
st_1 st_1
rb_1 rb_1
rb_2 rb_2
cbx_introducir cbx_introducir
end type
global w_fases_cambio_registro w_fases_cambio_registro

type variables
string i_id_fase, i_n_expediente
end variables

event csd_preasignar_expediente();st_control_eventos c_evento
string id_expediente,exp,nreg
datetime fecha
int valor1, valor2

	i_id_fase  	= f_siguiente_numero('FASES',10)

	id_expediente 	= f_siguiente_numero('EXPEDIENTES',10)
	fecha			= datetime(Today())

	c_evento.evento = 'NUMERO_EXP'
	f_control_eventos(c_evento)		
	exp  			= f_numera_expediente(c_evento.param1) // Modificado Ricardo 2005-05-11 -> SE le pasa el formato directamente
//	c_evento.evento = 'NUMERO_REG'
//	f_control_eventos(c_evento)			
//	nreg 			= f_numera_registro(c_evento.param1)
//	exp 			= right(string(year(today())),2) + '-'+exp
				

//  INSERT INTO fases  
//         ( id_expedi,id_fase,n_registro,n_expedi,f_entrada,titulo,tipo_gestion,descripcion,   
//           f_visado,f_abono,estado,archivo,celda,modalidad,sello,r_catastral,e_mail,cambio_arqui,   
//           autorizo,observaciones,honorarios,t_iva,fase,honorarios_iva,nr_duplicado,   
//           tipo_fase,tipo_trabajo,trabajo,tipo_via_emplazamiento,emplazamiento,poblacion,   
//           n_calle,n_copias, usuario,aplicado_10 )  
//  VALUES ( :id_expediente,:i_id_fase,:nreg,:exp,:fecha,null,'P',null,null,null,:g_fases_estados.preasignado,null,null,null,null,null,   
//           'N','N','N',null,null,:g_t_iva_defecto,null,null,'N','01',null,null,null,null,null,null,'', :g_usuario, 'N') USING SQLCA;
		  

	
INSERT INTO expedientes  
         ( id_expedi,n_expedi,titulo,f_inicio,cerrado,f_cierre,ult_fase,tipo_trabajo,trabajo,   
           tipo_via_emplazamiento,emplazamiento,poblacion,f_contrato,anulado,   
           n_exp_blanco,r_catastral,archivo,celda,n_calle, sup_garage, sup_otros, 
		pem, plantas_sob, sup_sob, plantas_baj , sup_baj, altura, estudio_geo,
		cc_externo, niv_cont, volumen, sup_viv, administracion, longitud_per, volumen_tierras, 
		estructura, replan_deslin, valor_terreno, valor_tasacion, valoracion_estim )  
VALUES ( :id_expediente,:exp,null,:fecha,'N',null,null,null,null,null,null,null,null,   
           null,'N',null,null,null,null,0,0,0,0,0,0,0,0,'N','N','N',0,0, 'N',
			  0,0,'N','N',0,0,0) USING SQLCA ;
 

 
	INSERT INTO fases_estados  
		( id_fase,cod_estado,fecha,usuario )  
	VALUES ( :i_id_fase,:g_fases_estados.preasignado,:fecha,:g_usuario)USING SQLCA ;
	
	COMMIT;
	
	i_n_expediente=exp
	
//	dw_1.SetItem(1,'n_expediente_asignado',exp)
//	dw_1.SetItem(1,'n_registro',nreg)
//
//	cb_asignar.enabled=false
//	dw_1.Object.gb_1.Visible=true
//	dw_1.Object.t_1.Visible=true
//	dw_1.Object.t_2.Visible=true
//	dw_1.Object.n_expediente_asignado.Visible=true
//	dw_1.Object.n_registro.Visible=true
//	dw_1.Object.b_ok.Visible=true


end event

on w_fases_cambio_registro.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.sle_destino=create sle_destino
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_introducir=create cbx_introducir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_aceptar
this.Control[iCurrent+3]=this.sle_destino
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.cbx_introducir
end on

on w_fases_cambio_registro.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.sle_destino)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_introducir)
end on

type cb_recuperar_pantalla from w_response`cb_recuperar_pantalla within w_fases_cambio_registro
integer taborder = 40
end type

type cb_guardar_pantalla from w_response`cb_guardar_pantalla within w_fases_cambio_registro
end type

type cb_cancelar from commandbutton within w_fases_cambio_registro
integer x = 873
integer y = 436
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Close(parent)


end event

type cb_aceptar from commandbutton within w_fases_cambio_registro
integer x = 384
integer y = 436
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;string id_fase, n_exp_destino,id_expedi
double cuantos

id_fase = Message.StringParm

if rb_1.checked=true then

	n_exp_destino = sle_destino.Text
	
	SELECT id_expedi  INTO :id_expedi FROM expedientes WHERE n_expedi=:n_exp_destino  ;
	
	if f_es_vacio(id_expedi) then
		Messagebox(g_titulo,'El expediente NO existe.')
		return
	end if

	UPDATE fases  
	SET id_expedi = :id_expedi ,n_expedi = :n_exp_destino 
	WHERE fases.id_fase = :id_fase ;

	COMMIT;
else
	// MODIFICADO RICARDO 04-10-15
	f_fases_cambio_registro(id_fase)
	/*
	parent.triggerevent ('csd_preasignar_expediente')        
	n_exp_destino=i_n_expediente        
	
	SELECT id_expedi  INTO :id_expedi FROM expedientes WHERE n_expedi=:n_exp_destino  ;
	
	if f_es_vacio(id_expedi) then
		Messagebox(g_titulo,'El expediente NO existe.')
		return
	end if

	UPDATE fases  
	SET id_expedi = :id_expedi ,n_expedi = :n_exp_destino 
	WHERE fases.id_fase = :id_fase ;

	COMMIT;
	
	messagebox(g_titulo, "El Registro se ha cambiado al Expediente N$$HEX1$$ba00$$ENDHEX$$: " + n_exp_destino)
	*/
	// FIN MODIFICADO RICARDO 04-10-15

	// Si elegimos introducir ahora la fase entonces la abrimos
	if cbx_introducir.checked then
		g_fases_consulta.id_fase = id_fase
// 	g_fases_consulta.opcion_importacion = i_opcion_importacion
//    g_fases_consulta.fichero_importacion =  i_datos_fase.fichero_importacion
//    g_fases_consulta.paquete_importacion =  i_datos_fase.paquete_importacion

		Close(Parent)        
		opensheet(g_detalle_fases, 'w_fases_detalle', w_aplic_frame, 0, original!)
		return
	end if
end if

Close(parent)

end event

type sle_destino from singlelineedit within w_fases_cambio_registro
integer x = 878
integer y = 244
integer width = 608
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fases_cambio_registro
integer x = 283
integer y = 260
integer width = 576
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N$$HEX2$$ba002000$$ENDHEX$$Expediente Destino :"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_fases_cambio_registro
integer x = 96
integer y = 44
integer width = 987
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mover a un expediente existente"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//sle_destino.enabled=true
st_1.visible=true
sle_destino.visible=true

cbx_introducir.visible = false
end event

type rb_2 from radiobutton within w_fases_cambio_registro
integer x = 96
integer y = 120
integer width = 1056
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Crear y mover a un expediente nuevo"
borderstyle borderstyle = stylelowered!
end type

event clicked;//sle_destino.enabled=false
st_1.visible=false
sle_destino.visible=false

cbx_introducir.visible = true
end event

type cbx_introducir from checkbox within w_fases_cambio_registro
boolean visible = false
integer x = 274
integer y = 260
integer width = 645
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Introducir ahora"
boolean lefttext = true
borderstyle borderstyle = stylelowered!
end type

