HA$PBExportHeader$w_fases_estadisticas.srw
$PBExportComments$Estad$$HEX1$$ed00$$ENDHEX$$sticas de Contratos para Murcia
forward
global type w_fases_estadisticas from w_listados
end type
end forward

global type w_fases_estadisticas from w_listados
string title = "Estad$$HEX1$$ed00$$ENDHEX$$sticas"
end type
global w_fases_estadisticas w_fases_estadisticas

type variables
datetime  idt_f_desde
end variables

forward prototypes
public subroutine of_recuento_mov (date f_visado_desde, date f_visado_hasta)
public function long of_visado (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_finales_obra (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_otros (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function integer of_visado_otros_all (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function integer of_visado_otros_proy (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_proyecto (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_renuncias (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_certificado (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
public function long of_visado_anexos (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select)
end prototypes

public subroutine of_recuento_mov (date f_visado_desde, date f_visado_hasta);long	ll_obra_nva_palma,ll_obra_nva_inca, ll_obra_nva_manacor, ll_obra_nva_remoto, &
		ll_obra_otro_palma, ll_obra_otro_inca, ll_obra_otro_manacor, ll_obra_otro_remoto, &
		ll_proy_palma, ll_proy_inca, ll_proy_manacor, ll_proy_remoto, &
		ll_proy_otro_palma,ll_proy_otro_inca, ll_proy_otro_manacor, ll_proy_otro_remoto, &
		ll_otros_palma, ll_otros_inca, ll_otros_manacor, ll_otros_remoto, &
		ll_finales_palma, ll_finales_inca, ll_finales_manacor, ll_finales_remoto, &
		ll_renuncia_palma,ll_renuncia_inca, ll_renuncia_manacor, ll_renuncia_remoto, &
		ll_cert_hab_palma, ll_cert_hab_inca, ll_cert_hab_manacor, ll_cert_hab_remoto, &
		ll_fila,ll_anexo_palma,ll_anexo_inca,ll_anexo_manacor,ll_anexo_remoto

string	ls_fase, ls_tipo_trab, ls_comilla
		
		
//Se hace el llamado a la funci$$HEX1$$f300$$ENDHEX$$n of_visados() pasandole cada uno de los argumentos, seg$$HEX1$$fa00$$ENDHEX$$n sea el caso para contar los registros
// que se encuentran en la tabla Fases en un tiempo desde - hasta

// Busca los registros para Direcci$$HEX1$$f300$$ENDHEX$$n obra y coord - obra nueva
ls_comilla = "'"

//****** DIRECC. OBRA Y COORD.
	// Obra Nueva
	ll_obra_nva_palma = of_visado(f_visado_desde, f_visado_hasta,  '01',1)
	ll_obra_nva_inca = of_visado(f_visado_desde, f_visado_hasta,  '03',1)
	ll_obra_nva_manacor = of_visado(f_visado_desde, f_visado_hasta,  '02',1)
	ll_obra_nva_remoto = of_visado(f_visado_desde, f_visado_hasta,  'V',2)
	
	//Otros
	ll_obra_otro_palma = of_visado_otros(f_visado_desde, f_visado_hasta,  '01',1)
	ll_obra_otro_inca = of_visado_otros(f_visado_desde, f_visado_hasta,  '03',1)
	ll_obra_otro_manacor = of_visado_otros(f_visado_desde, f_visado_hasta,  '02',1)
	ll_obra_otro_remoto = of_visado_otros(f_visado_desde, f_visado_hasta,  'V',2)

//******* PROYECTOS
	//Obra Nueva
	ll_proy_palma = of_visado_proyecto(f_visado_desde, f_visado_hasta,  '01',1)
	ll_proy_inca = of_visado_proyecto(f_visado_desde, f_visado_hasta,  '03',1)
	ll_proy_manacor = of_visado_proyecto(f_visado_desde, f_visado_hasta,  '02',1)
	ll_proy_remoto = of_visado_proyecto(f_visado_desde, f_visado_hasta,  'V',2)
	
	//Otros
	ll_proy_otro_palma = of_visado_otros_proy(f_visado_desde, f_visado_hasta,  '01', 1)
	ll_proy_otro_inca = of_visado_otros_proy(f_visado_desde, f_visado_hasta,  '03', 1)
	ll_proy_otro_manacor = of_visado_otros_proy(f_visado_desde, f_visado_hasta,  '02', 1)
	ll_proy_otro_remoto = of_visado_otros_proy(f_visado_desde, f_visado_hasta,  'V', 2)

//******* OTROS
ll_otros_palma = of_visado_otros_all(f_visado_desde, f_visado_hasta,  '01', 1)
ll_otros_inca = of_visado_otros_all(f_visado_desde, f_visado_hasta,  '03', 1)
ll_otros_manacor = of_visado_otros_all(f_visado_desde, f_visado_hasta,  '02', 1)
ll_otros_remoto = of_visado_otros_all(f_visado_desde, f_visado_hasta,  'V', 2)

//******* FINALES DE OBRA
ll_finales_palma = of_visado_finales_obra(f_visado_desde, f_visado_hasta,  '01', 1)
ll_finales_inca = of_visado_finales_obra(f_visado_desde, f_visado_hasta,  '03', 1)
ll_finales_manacor = of_visado_finales_obra(f_visado_desde, f_visado_hasta,  '02', 1)
ll_finales_remoto = of_visado_finales_obra(f_visado_desde, f_visado_hasta,  'V', 2)

//******* RENUNCIAS
ll_renuncia_palma = of_visado_renuncias(f_visado_desde, f_visado_hasta,  '01', 1)
ll_renuncia_inca = of_visado_renuncias(f_visado_desde, f_visado_hasta,  '03', 1)
ll_renuncia_manacor = of_visado_renuncias(f_visado_desde, f_visado_hasta,  '02', 1)
ll_renuncia_remoto = of_visado_renuncias(f_visado_desde, f_visado_hasta,  'V', 2)

//******* CERTIFICADO HABITABIL.
ll_cert_hab_palma = of_visado_certificado(f_visado_desde, f_visado_hasta,  '01', 1)
ll_cert_hab_inca = of_visado_certificado(f_visado_desde, f_visado_hasta,  '03', 1)
ll_cert_hab_manacor = of_visado_certificado(f_visado_desde, f_visado_hasta,  '02', 1)
ll_cert_hab_remoto = of_visado_certificado(f_visado_desde, f_visado_hasta,  'V', 2)


//************ ANEXO
ll_anexo_palma = of_visado_anexos(f_visado_desde, f_visado_hasta,  '01', 1)
ll_anexo_inca = of_visado_anexos(f_visado_desde, f_visado_hasta,  '03', 1)
ll_anexo_manacor = of_visado_anexos(f_visado_desde, f_visado_hasta,  '02', 1)
ll_anexo_remoto = of_visado_anexos(f_visado_desde, f_visado_hasta,  'V', 2)

if isnull(ll_anexo_palma) then ll_anexo_palma = 0
if isnull(ll_anexo_inca) then ll_anexo_inca = 0
if isnull(ll_anexo_manacor) then ll_anexo_manacor = 0
if isnull(ll_anexo_remoto) then ll_anexo_remoto = 0
if isnull(ll_obra_nva_palma) then ll_obra_nva_palma = 0
if isnull(ll_obra_nva_inca) then ll_obra_nva_inca = 0
if isnull(ll_obra_nva_manacor) then ll_obra_nva_manacor = 0
if isnull(ll_obra_nva_remoto) then ll_obra_nva_remoto = 0
if isnull(ll_obra_otro_palma) then ll_obra_otro_palma = 0
if isnull(ll_obra_otro_inca) then ll_obra_otro_inca = 0
if isnull(ll_obra_otro_manacor) then ll_obra_otro_manacor = 0
if isnull(ll_obra_otro_remoto) then ll_obra_otro_remoto = 0
if isnull(ll_proy_palma) then ll_proy_palma = 0
if isnull(ll_proy_inca) then ll_proy_inca = 0
if isnull(ll_proy_manacor) then ll_proy_manacor = 0
if isnull(ll_proy_remoto) then ll_proy_remoto = 0
if isnull(ll_proy_otro_palma) then ll_proy_otro_palma = 0
if isnull(ll_proy_otro_inca) then ll_proy_otro_inca = 0
if isnull(ll_proy_otro_manacor) then ll_proy_otro_manacor = 0
if isnull(ll_proy_otro_remoto) then ll_proy_otro_remoto = 0
if isnull(ll_otros_palma) then ll_otros_palma = 0
if isnull(ll_otros_inca) then ll_otros_inca = 0
if isnull(ll_otros_manacor) then ll_otros_manacor = 0
if isnull(ll_otros_remoto) then ll_otros_remoto = 0
if isnull(ll_finales_palma) then ll_finales_palma = 0
if isnull(ll_finales_inca) then ll_finales_inca = 0
if isnull(ll_finales_manacor) then ll_finales_manacor = 0
if isnull(ll_finales_remoto) then ll_finales_remoto = 0
if isnull(ll_renuncia_palma) then ll_renuncia_palma = 0
if isnull(ll_renuncia_inca) then ll_renuncia_inca = 0
if isnull(ll_renuncia_manacor) then ll_renuncia_manacor = 0
if isnull(ll_renuncia_remoto) then ll_renuncia_remoto = 0
if isnull(ll_cert_hab_palma) then ll_cert_hab_palma = 0
if isnull(ll_cert_hab_inca) then ll_cert_hab_inca = 0
if isnull(ll_cert_hab_manacor) then ll_cert_hab_manacor = 0
if isnull(ll_cert_hab_remoto) then ll_cert_hab_remoto = 0


// OBTENIDOS LOS VALORES SE PASAN AL DW
// Al final:
ll_fila =  dw_1.getrow()
dw_1.setitem(ll_fila,"obra_nueva_palma",ll_obra_nva_palma )
dw_1.setitem(ll_fila,"obra_nueva_inca",ll_obra_nva_inca )
dw_1.setitem(ll_fila,"obra_nueva_manacor",ll_obra_nva_manacor )
dw_1.setitem(ll_fila,"obra_nueva_remoto",ll_obra_nva_remoto )
dw_1.setitem(ll_fila,"otros_obra_palma",ll_obra_otro_palma )
dw_1.setitem(ll_fila,"otros_obra_inca",ll_obra_otro_inca )
dw_1.setitem(ll_fila,"otros_obra_manacor",ll_obra_otro_manacor )
dw_1.setitem(ll_fila,"otros_obra_remoto",ll_obra_otro_remoto )
dw_1.setitem(ll_fila,"obra_nueva_proy_palma",ll_proy_palma )
dw_1.setitem(ll_fila,"obra_nueva_proy_inca",ll_proy_inca )
dw_1.setitem(ll_fila,"obra_nueva_proy_manacor",ll_proy_manacor )
dw_1.setitem(ll_fila,"obra_nueva_proy_remoto",ll_proy_remoto )
dw_1.setitem(ll_fila,"otros_proy_palma",ll_proy_otro_palma )
dw_1.setitem(ll_fila,"otros_proy_inca",ll_proy_otro_inca )
dw_1.setitem(ll_fila,"otros_proy_manacor",ll_proy_otro_manacor )
dw_1.setitem(ll_fila,"otros_proy_remoto",ll_proy_otro_remoto )
dw_1.setitem(ll_fila,"otros_palma",ll_otros_palma )
dw_1.setitem(ll_fila,"otros_inca",ll_otros_inca )
dw_1.setitem(ll_fila,"otros_manacor",ll_otros_manacor )
dw_1.setitem(ll_fila,"otros_remoto",ll_otros_remoto )
dw_1.setitem(ll_fila,"finales_palma",ll_finales_palma )
dw_1.setitem(ll_fila,"finales_inca",ll_finales_inca )
dw_1.setitem(ll_fila,"finales_manacor",ll_finales_manacor )
dw_1.setitem(ll_fila,"finales_remoto",ll_finales_remoto )
dw_1.setitem(ll_fila,"renuncia_palma",ll_renuncia_palma )
dw_1.setitem(ll_fila,"renuncia_inca",ll_renuncia_inca )
dw_1.setitem(ll_fila,"renuncia_manacor",ll_renuncia_manacor )
dw_1.setitem(ll_fila,"renuncia_remoto",ll_renuncia_remoto )
dw_1.setitem(ll_fila,"cert_hab_palma",ll_cert_hab_palma )
dw_1.setitem(ll_fila,"cert_hab_inca",ll_cert_hab_inca )
dw_1.setitem(ll_fila,"cert_hab_manacor",ll_cert_hab_manacor )
dw_1.setitem(ll_fila,"cert_hab_remoto",ll_cert_hab_remoto )
dw_1.setitem(ll_fila,"anexos_palma",ll_anexo_palma )
dw_1.setitem(ll_fila,"anexos_inca",ll_anexo_inca )
dw_1.setitem(ll_fila,"anexos_manacor",ll_anexo_manacor )
dw_1.setitem(ll_fila,"anexos_remoto",ll_anexo_remoto )
dw_1.setitem(ll_fila,"desde",f_visado_desde )
dw_1.setitem(ll_fila,"hasta",f_visado_hasta )

dw_1.visible 		  = true
cb_ver.enabled        = false
dw_1.event pfc_printpreview()
cb_zoom.enabled     = true
cb_imprimir.enabled = true
cb_guardar.enabled  = true
cb_escala.enabled   = true
cb_ordenar.enabled  = false











end subroutine

public function long of_visado (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

 if ai_select = 1 then // BUSACA LOS DATOS PARA LA MODALIDAD SEGUN CADA UNA DE ELLAS: 01, 02, 03
 
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '13','14','16','17','03' ) ) AND  
				(  fases.tipo_trabajo like '1%' ) AND  
				( fases.archivo is not null ) and
			( fases.modalidad = :as_modalidad ) and
			( fases.e_mail <> 'V');
			
elseif ai_select = 2 then //BUSCA LOS DATOS PARA EL CAMPO EMAIL QUE CORRESPONDE CON REMOTO
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '13','14','16','17','03' ) ) AND  
				(  fases.tipo_trabajo like '1%' ) AND  
				( fases.archivo is not null ) and
		     	( fases.e_mail = :as_modalidad )	;	
	

end if

return ll_registros
end function

public function long of_visado_finales_obra (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

if ai_select = 1 then //BUSCA LOS DATOS PARA CADA UNA DE LAS MODALIDADES 01,02,03
  SELECT count(*)  
    INTO :ll_registros  
    FROM fases,   
         fases_finales  
   WHERE ( fases.id_fase = fases_finales.id_fase ) and  
         ( ( fases_finales.f_visado between :ad_desde and :f_final ) AND  
         ( fases.archivo is not null ) AND  
		( fases.e_mail <> 'V') and
         ( fases.modalidad = :as_modalidad ) )   ;
			
elseif ai_select = 2 then //BUSCA LOS DATOS PARA EL CAMPO EMAIL QUE CORRESPONDE CON REMOTO

	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases,   
				fases_finales  
		WHERE ( fases.id_fase = fases_finales.id_fase ) and  
				( ( fases_finales.f_visado between :ad_desde and :f_final ) AND  
				( fases.archivo is not null ) AND  
				( fases.e_mail = :as_modalidad ) )   ;	

end if	



return ll_registros			

end function

public function long of_visado_otros (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

 if ai_select = 1 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ('13','14','16','17','03' ) ) AND  
				(  fases.tipo_trabajo not like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail <> 'V') and
			( fases.modalidad = :as_modalidad )	;
			
elseif ai_select = 2 then // BUSCA LOS DATOS PARA EL EMAIL QUE ES REMOTO
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ('13','14','16','17','03' ) ) AND  
				(  fases.tipo_trabajo not like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail =:as_modalidad )	;	
	
	
end if

return ll_registros
end function

public function integer of_visado_otros_all (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

 if ai_select = 1 then //BUSCA LOS DATOS PARA LA MODALIDAD
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase not in ( '11','12','15','01','02','04','05','41','42','51','52','13','14','16','17','03','79' ) ) AND 
				( fases.archivo is not null ) and
				( fases.e_mail <> 'V') and
			( fases.modalidad = :as_modalidad )	;
			
elseif ai_select = 2 then //BUSCA LOS DATOS SEGUN EL CAMPO EMAIL QUE ES EL REMOTO
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase not in ( '11','12','15','01','02','04','05','41','42','51','52','13','14','16','17','03','79' ) ) AND 
				( fases.archivo is not null ) and
				( fases.e_mail = :as_modalidad )	;		
			
end if

return ll_registros
end function

public function integer of_visado_otros_proy (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

if ai_select = 1 then //BUSCA LOS DATOS SEGUN LA MODALIDAD

	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '11','12','15','01','02','04','05','41','42','51','52' ) ) AND  
				(  fases.tipo_trabajo not like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail <> 'V') and
			( fases.modalidad = :as_modalidad )	;
			
elseif ai_select = 2 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '11','12','15','01','02','04','05','41','42','51','52' ) ) AND  
				(  fases.tipo_trabajo not like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail = :as_modalidad )	;
end if			

return ll_registros
end function

public function long of_visado_proyecto (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

if ai_select = 1 then //BUSCA LOS DATOS SEGUN LA MODALIDAD 
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '11','12','15','01','02','04','05','41','42','51','52' ) ) AND  
				(  fases.tipo_trabajo like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail <> 'V') and
			( fases.modalidad = :as_modalidad )	;
			
elseif ai_select = 2 then //BUSCA LOS DATOS SEGUN EL CAMPO EMAIL QUE ES EL REMOTO
	
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase in ( '11','12','15','01','02','04','05','41','42','51','52' ) ) AND  
				(  fases.tipo_trabajo like '1%' ) AND  
				( fases.archivo is not null ) and
				( fases.e_mail = :as_modalidad )	;	
			
end if

return ll_registros
end function

public function long of_visado_renuncias (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)


// CAMBIADO EL CRITERIO. SE HA COMUNICADO QUE LA CONSULTA DEBE HACERSE POR LA FECHA DE RENUNCIA

if ai_select = 1 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases,   
				fases_renuncias
		WHERE ( fases.id_fase = fases_renuncias.id_fase ) and  
				( ( fases_renuncias.fecha between :ad_desde and :f_final ) AND  
				( fases.archivo is not null ) AND 
				( fases.e_mail <> 'V') and
				( fases.modalidad = :as_modalidad ) )   ;
	
elseif  ai_select = 2 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases,   
				fases_renuncias  
		WHERE ( fases.id_fase = fases_renuncias.id_fase ) and  
				( ( fases_renuncias.fecha between :ad_desde and :f_final ) AND  
				( fases.archivo is not null ) AND  
				( fases.e_mail = :as_modalidad ) )   ;
		
end if


/*
if ai_select = 1 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases,   
				fases_renuncias  
		WHERE ( fases.id_fase = fases_renuncias.id_fase ) and  
				( ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.archivo is not null ) AND 
				( fases.e_mail <> 'V') and
				( fases.modalidad = :as_modalidad ) )   ;
	
elseif  ai_select = 2 then
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases,   
				fases_renuncias  
		WHERE ( fases.id_fase = fases_renuncias.id_fase ) and  
				( ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.archivo is not null ) AND  
				( fases.e_mail = :as_modalidad ) )   ;
		
end if
*/
return ll_registros
end function

public function long of_visado_certificado (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

 if ai_select = 1 then //BUSCA LOS DATOS PARA LA MODALIDAD
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase = '79'  ) AND 
				( fases.archivo is not null ) and
				( fases.modalidad = :as_modalidad ) and
				( fases.e_mail <> 'V');
			
elseif ai_select = 2 then //BUSCA LOS DATOS SEGUN EL CAMPO EMAIL QUE ES EL REMOTO
	  SELECT count(*)  
		 INTO :ll_registros  
		 FROM fases  
		WHERE ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.fase = '79' ) AND 
				( fases.archivo is not null ) and
				( fases.e_mail = :as_modalidad )	;		
			
end if

return ll_registros
end function

public function long of_visado_anexos (date ad_desde, date ad_hasta, string as_modalidad, integer ai_select);long   ll_registros
datetime f_final
time t_final

t_final=time("23:59:59")
f_final=datetime(ad_hasta,t_final)

if ai_select = 1 then //BUSCA LOS DATOS PARA LA MODALIDAD
	SELECT count(*)  
	INTO :ll_registros  
	FROM fases,   
			incidencias_fases  
	WHERE ( fases.id_fase = incidencias_fases.id_fase ) and  				
				( ( incidencias_fases.fecha between :ad_desde and :f_final ) AND  
				( fases.e_mail <> 'V') and
				//( fases.archivo is not null ) AND  
				(incidencias_fases.codigo = '2') and 
				( fases.modalidad = :as_modalidad ) )   ;


elseif  ai_select = 2 then //BUSCA LOS DATOS SEGUN EL CAMPO EMAIL QUE ES EL REMOTO
	SELECT count(*)  
	INTO :ll_registros  
	FROM fases,   
			incidencias_fases  
	WHERE ( fases.id_fase = incidencias_fases.id_fase ) and  
				( ( incidencias_fases.fecha between :ad_desde and :f_final ) AND  
			//	( fases.archivo is not null ) AND  
				(incidencias_fases.codigo = '2' ) and 
				( fases.e_mail = :as_modalidad ) )   ;
		
end if

return ll_registros


// CAMBIADO EL CRITERIO
/*if ai_select = 1 then //BUSCA LOS DATOS PARA LA MODALIDAD
	SELECT count(*)  
	INTO :ll_registros  
	FROM fases,   
			incidencias_fases  
	WHERE ( fases.id_fase = incidencias_fases.id_fase ) and  
				( ( fases.f_visado between :ad_desde and :f_final ) AND  
				( fases.e_mail <> 'V') and
				//( fases.archivo is not null ) AND  
				(incidencias_fases.codigo = '2') and 
				( fases.modalidad = :as_modalidad ) )   ;


elseif  ai_select = 2 then //BUSCA LOS DATOS SEGUN EL CAMPO EMAIL QUE ES EL REMOTO
	SELECT count(*)  
	INTO :ll_registros  
	FROM fases,   
			incidencias_fases  
	WHERE ( fases.id_fase = incidencias_fases.id_fase ) and  
				( ( fases.f_visado between :ad_desde and :f_final ) AND  
			//	( fases.archivo is not null ) AND  
				(incidencias_fases.codigo = '2' ) and 
				( fases.e_mail = :as_modalidad ) )   ;
		
end if
*/
return ll_registros
end function

on w_fases_estadisticas.create
call super::create
end on

on w_fases_estadisticas.destroy
call super::destroy
end on

event open;call super::open;dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)

long mes,anyo
datetime f_desde
mes = Month(today())
anyo = Year(today())
f_desde = datetime(date("01/"+string(mes)+"/"+string(anyo)))

string m
if LenA(string(mes)) = 1 then 
	m = '0' + string(mes)
else
	m = string(mes)
end if

idt_f_desde = f_desde

dw_listados.setitem(1, 'mes', m)
dw_listados.setitem(1, 'fecha_entrada_d', f_desde)
dw_listados.setitem(1, 'fecha_entrada_h', f_ultimo_dia_mes(f_desde))
dw_listados.setitem(1, 'anyo', string(anyo - 1))

if g_colegio = 'COAATAL' then 
	dw_listados.setitem(1, 'visado', 'S')
end if	
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_fases_estadisticas
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_fases_estadisticas
end type

type cb_limpiar from w_listados`cb_limpiar within w_fases_estadisticas
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_fases_estadisticas
end type

type cb_ver from w_listados`cb_ver within w_fases_estadisticas
end type

event cb_ver::clicked;call super::clicked;string listado, sql='', sql_origen='', ls_orden,  ls_mes,ls_f_hasta, ls_anyo
date   ld_f_visado_d,ld_f_visado_h
long i, ll_anyo
datetime ld_f_hasta, ld_f_desde
long ll_on,ll_or,ll_vs,ll_ot,ll_ch, ll_ab, ll_tr, ll_ce

dw_listados.accepttext()
//dw_1.of_setprintpreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
 
// toma el dw en dw_listados para saber cual listado se va a visualizar, si el valor es  'd_listado_recuento_mov_mca'  no se debe pasar por la funci$$HEX1$$f300$$ENDHEX$$n sql
// ya que el dw a visualizar es un external, se deber$$HEX2$$e1002000$$ENDHEX$$ir a la funci$$HEX1$$f300$$ENDHEX$$n de ventana of_recuento_mov
			
			
			///*introducido por Javier Osuna 19/05/2010. ICN-427*/	
			if listado = 'd_fases_listado_estadistico_consejo_porcent' or listado = 'd_fases_listado_estadistico_consejo' then
				dw_1.SetTransObject(SQLCA)
				ls_anyo = dw_listados.getitemstring(dw_listados.getrow(),"anyo")
				ld_f_hasta = datetime('01/01/'+string(integer(ls_anyo)+1))
				ld_f_desde = datetime('01/01/'+string(integer(ls_anyo)))
			end if


if listado = 'd_listado_recuento_mov_mca' then
	ld_f_visado_d = date(dw_listados.getitemdatetime(dw_listados.getrow(),"fecha_visado_d"))
	ld_f_visado_h = date(dw_listados.getitemdatetime(dw_listados.getrow(),"fecha_visado_h"))
	
	if isnull(ld_f_visado_d) or isnull(ld_f_visado_h) then
		messagebox(g_titulo,'Debe indicar las Fechas de Visado.')
		return 1
	end if
	of_recuento_mov(ld_f_visado_d,ld_f_visado_h)
	
else
	dw_1.of_SetTransObject(SQLCA)
	sql = dw_1.describe("datawindow.table.select")
	sql_origen = sql

	if listado = 'd_fases_estadistica_obra_nueva_mca' or  listado = 'd_fases_estadistica_sup_parcela_mca' or listado = 'd_fases_estadistica_sup_municipio_mca' then
		
		if listado = 'd_fases_estadistica_obra_nueva_mca' then
			ld_f_visado_d = date(dw_listados.getitemdatetime(dw_listados.getrow(),"fecha_visado_d"))
			ll_anyo = year(today())
			ls_mes = dw_listados.getitemstring(dw_listados.getrow(),"mes")
			ls_f_hasta = '01' +'/'+ls_mes+'/'+string(ll_anyo)
			ld_f_hasta = datetime(date(ls_f_hasta))
			ld_f_visado_h = date(f_ultimo_dia_mes(ld_f_hasta))
			//dw_listados.setitem(1, 'fecha_visado_h', ld_f_visado_h)
		else
			ld_f_visado_d = date(dw_listados.getitemdatetime(dw_listados.getrow(),"fecha_visado_d"))
			ld_f_visado_h = date(dw_listados.getitemdatetime(dw_listados.getrow(),"fecha_visado_h"))	
		end if
		
		f_sql('fases.f_visado','>=','fecha_visado_d',dw_listados,sql,g_tipo_base_datos,'Fecha visado Desde :')
		f_sql('fases.f_visado','<','fecha_visado_h',dw_listados,sql,g_tipo_base_datos,'Fecha visado Hasta :')
		f_sql('fases.estado','like','estado',dw_listados,sql,g_tipo_base_datos,'Estado :')
		
	else
		
		if listado = 'd_fases_estadistica_listado_x_fecha_mca' then
			DataWindowChild dwc_on,dwc_or,dwc_vs,dwc_ot,dwc_ch
			integer rtncode,rtncod
			string sql_on,sql_or,sql_vs,sql_ot,sql_ch
			
			if isnull(dw_listados.GetItemDateTime(1,'fecha_entrada_d')) or isnull(dw_listados.GetItemDateTime(1,'fecha_entrada_h'))  then 
				MessageBox(g_titulo,'Ha de especificar el par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda Fecha Entrada')
				return
			end if
			
			rtncode = dw_1.GetChild("dw_on", dwc_on)
			IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_on.SetTransObject(SQLCA)
			sql_on = dwc_on.describe("Datawindow.Table.Select")
			
			rtncod = dw_1.GetChild("dw_or", dwc_or)
			IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_or.SetTransObject(SQLCA)
			sql_or = dwc_or.describe("Datawindow.Table.Select")
			
			rtncod = dw_1.GetChild("dw_vs", dwc_vs)
			IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_vs.SetTransObject(SQLCA)
			sql_vs = dwc_vs.describe("Datawindow.Table.Select")
			
			rtncod = dw_1.GetChild("dw_ot", dwc_ot)
			IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_ot.SetTransObject(SQLCA)
			sql_ot = dwc_ot.describe("Datawindow.Table.Select")
			
			rtncod = dw_1.GetChild("dw_ch", dwc_ch)
			IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
			dwc_ch.SetTransObject(SQLCA)
			sql_ch = dwc_ch.describe("Datawindow.Table.Select")
			
			
			f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql_on,g_tipo_base_datos,'Fecha entrada Desde :')
			f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql_on,g_tipo_base_datos,'Fecha entrada Hasta :')
			
			f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql_or,g_tipo_base_datos,'Fecha entrada Desde :')
			f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql_or,g_tipo_base_datos,'Fecha entrada Hasta :')
			
			f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql_vs,g_tipo_base_datos,'Fecha entrada Desde :')
			f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql_vs,g_tipo_base_datos,'Fecha entrada Hasta :')
			
			f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql_ot,g_tipo_base_datos,'Fecha entrada Desde :')
			f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql_ot,g_tipo_base_datos,'Fecha entrada Hasta :')
			
			f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql_ch,g_tipo_base_datos,'Fecha entrada Desde :')
			f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql_ch,g_tipo_base_datos,'Fecha entrada Hasta :')
			
			dwc_on.SetTransobject(sqlca)
			dwc_or.SetTransobject(sqlca)
			dwc_vs.SetTransobject(sqlca)
			dwc_ot.SetTransobject(sqlca)
			dwc_ch.SetTransobject(sqlca)
			/*Modify DW*/
			dwc_on.modify("datawindow.table.select= ~"" + sql_on+ "~"")
			dwc_or.modify("datawindow.table.select= ~"" + sql_or+ "~"")
			dwc_vs.modify("datawindow.table.select= ~"" + sql_vs+ "~"")
			dwc_ot.modify("datawindow.table.select= ~"" + sql_ot+ "~"")
			dwc_ch.modify("datawindow.table.select= ~"" + sql_ch+ "~"")
			
			ll_on = dwc_on.retrieve()
			ll_or = dwc_or.retrieve()
			ll_vs = dwc_vs.retrieve()
			ll_ot = dwc_ot.retrieve()
			ll_ch = dwc_ch.retrieve()			
		
		else
			
			//Modificado por Alexis. 26/03/2010. ICN-414. Se a$$HEX1$$f100$$ENDHEX$$aden unas estad$$HEX1$$ed00$$ENDHEX$$sticas para el consejo
			if  listado = 'd_fases_listado_estadistico_consejo' then
				DataWindowChild dwc_ab,dwc_tr,dwc_ce
				
				rtncode = dw_1.GetChild("dw_ab", dwc_ab)
				IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
				dwc_ab.SetTransObject(SQLCA)
							
				rtncod = dw_1.GetChild("dw_tr", dwc_tr)
				IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
				dwc_tr.SetTransObject(SQLCA)
							
				rtncod = dw_1.GetChild("dw_ce", dwc_ce)
				IF rtncod = -1 THEN MessageBox("Error", "Not a DataWindowChild")
				dwc_ce.SetTransObject(SQLCA)
								
				ll_ab = dwc_ab.retrieve(ld_f_desde, ld_f_hasta, ls_anyo)	
				ll_tr = dwc_tr.retrieve(ld_f_desde, ld_f_hasta, ls_anyo)	
				ll_ce = dwc_ce.retrieve(ld_f_desde, ld_f_hasta, ls_anyo)	
									
			else 
				
				
				if listado <> 'd_fases_listado_estadistico_consejo_porcent' then
				
				
					//Hacer f_sql de todos los campos de la dw_listados de forma analoga a la ventana de consulta
					//f_sql('fases.n_registro','LIKE','n_registro',dw_listados,sql,g_tipo_base_datos,'')
					f_sql('fases.f_entrada','>=','fecha_entrada_d',dw_listados,sql,g_tipo_base_datos,'Fecha entrada Desde :')
					f_sql('fases.f_entrada','<','fecha_entrada_h',dw_listados,sql,g_tipo_base_datos,'Fecha entrada Hasta :')
					f_sql('fases.poblacion','=','poblacion',dw_listados,sql,g_tipo_base_datos,'Poblaci$$HEX1$$f300$$ENDHEX$$n :')
					f_sql('fases.modalidad','=','centro',dw_listados,sql,g_tipo_base_datos,'Centro :')
					f_sql('fases.fase','like','tipo_act',dw_listados,sql,g_tipo_base_datos,'Tipo Actuaci$$HEX1$$f300$$ENDHEX$$n :')
					f_sql('fases.tipo_trabajo','like','tipo_obra',dw_listados,sql,g_tipo_base_datos,'Tipo Obra :')
					f_sql('fases.trabajo','like','destino',dw_listados,sql,g_tipo_base_datos,'Destino :')
					f_sql('fases.f_abono','>=','fecha_abono_d',dw_listados,sql,g_tipo_base_datos,'Fecha abono Desde :')
					f_sql('fases.f_abono','<','fecha_abono_h',dw_listados,sql,g_tipo_base_datos,'Fecha abono Hasta :')
					f_sql('poblaciones.zona','=','comarca',dw_listados,sql,g_tipo_base_datos,'Comarca :')
					f_sql('expedientes.f_cierre','>=','f_cfo_d',dw_listados,sql,g_tipo_base_datos,'Fecha CFO Desde :')
					f_sql('expedientes.f_cierre','<','f_cfo_h',dw_listados,sql,g_tipo_base_datos,'Fecha CFO Hasta :')
					
					///* Modificado por Alexis -18/10/2009. CAL-197 *****/
					if dw_listados.getitemstring(1,'visado') <> 'N' then
						f_sql('fases.f_visado','>=','fecha_visado_d',dw_listados,sql,g_tipo_base_datos,'Fecha visado Desde :')
						f_sql('fases.f_visado','<','fecha_visado_h',dw_listados,sql,g_tipo_base_datos,'Fecha visado Hasta :')
						if dw_listados.getitemstring(1,'visado') = 'S' then 
							sql = sql + " and not fases.archivo = '' and  fases.archivo is not null "
						end if
					end if
				
				else 
					///*introducido por Javier Osuna 19/05/2010. ICN-427*/
					  sql = sql + " and expedientes.f_cierre >= '"+ string(ld_f_desde, "YYYYMMDD") +"'"
					  sql = sql + " and expedientes.f_cierre < '"+ string(ld_f_hasta, "YYYYMMDD") +"'"
				end if	
			end if
		end if	
	end if





	
	if dw_1.Describe("DataWindow.Nested") = "no" then
		if sql=sql_origen then 
			MessageBox(g_titulo,'Ha de especificar al menos un par$$HEX1$$e100$$ENDHEX$$metro de b$$HEX1$$fa00$$ENDHEX$$squeda')
			return
		end if
		
		if listado <> 'd_fases_estadistica_listado_x_fecha_mca' then
			if listado = 'd_fases_estadistica_obra_nueva_mca' then
				dw_1.SetTransobject(sqlca)
				dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
				dw_1.retrieve(ld_f_visado_d)		
			else
				dw_1.SetTransobject(sqlca)
				dw_1.Modify("DataWindow.Table.Select= ~"" + sql + "~"")
				dw_1.retrieve()		
			end if
		end if
		
	
	// Al final:
	
		if dw_1.rowcount() > 0 then
			dw_1.groupcalc()
			dw_1.visible 		  = true
			this.enabled        = false
			dw_1.event pfc_printpreview()
			cb_zoom.enabled     = true
			cb_imprimir.enabled = true
			cb_guardar.enabled  = true
			cb_escala.enabled    = true
			cb_ordenar.enabled  = true
			
			
			if listado = 'd_fases_estadistica_obra_nueva_mca' or listado ='d_fases_estadistica_sup_parcela_mca'  then  //Adiciona los datos del Mes seleccionado y las fechas de visado al DW
				cb_ordenar.enabled  = false
				ls_mes = dw_listados.getitemstring(dw_listados.getrow(),"mes")
				for i = 1 to dw_1.rowcount()
					dw_1.setitem(i,"mes",long(ls_mes) ) 
				next
				dw_1.setitem(1,"desde",string(ld_f_visado_d) ) 
				dw_1.setitem(1,"hasta",string(ld_f_visado_h) ) 
			elseif  listado = 'd_fases_estadistica_sup_municipio_mca' then
				dw_1.setitem(1,"desde",string(ld_f_visado_d) ) 
				dw_1.setitem(1,"hasta",string(ld_f_visado_h) )			
			end if
			
		else
			messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
		end if
	else
		if listado = 'd_fases_listado_estadistico_consejo' then
				
			if dwc_ab.rowcount() > 0 or dwc_tr.rowcount() > 0 or dwc_ce.rowcount() > 0 then	
				dw_1.visible 		  = true
				this.enabled        = false
				cb_zoom.enabled     = true
				cb_imprimir.enabled = true
				cb_guardar.enabled  = true
				cb_escala.enabled    = true
				cb_ordenar.enabled  = true
			else
				messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
			end if
		else
	
			if dwc_on.rowcount() > 0 or dwc_or.rowcount() > 0 or dwc_vs.rowcount() > 0 or dwc_ot.rowcount() > 0 or dwc_ch.rowcount() > 0 then	
				dw_1.visible 		  = true
				this.enabled        = false			
				cb_zoom.enabled     = true
				cb_imprimir.enabled = true
				cb_guardar.enabled  = true
				cb_escala.enabled    = true
				cb_ordenar.enabled  = true
			else
				messagebox(g_titulo,'No se han encontrados registros segun las especificaciones.')
			end if
		end if	
	end if
end if
end event

type cb_salir from w_listados`cb_salir within w_fases_estadisticas
end type

type dw_listados from w_listados`dw_listados within w_fases_estadisticas
integer y = 200
integer width = 2304
integer height = 1368
string dataobject = "d_fases_estadisticas"
boolean ib_isupdateable = false
end type

event dw_listados::buttonclicked;string pob
choose case dwo.name
	CASE 'bb_poblacion'
		g_busqueda.titulo='Poblaciones'
		g_busqueda.dw='d_poblaciones_lista_busqueda'
		pob=f_busqueda_poblaciones()
		if f_es_vacio(pob) then return
		this.SetItem(1,'poblacion',pob)

END CHOOSE
end event

event dw_listados::csd_oculta;call super::csd_oculta;string  dwactual, descactual, ls_f_enero, ls_f_enero_fin, ls_mes
long     ll_anyo
integer nro_opcion 
datetime ld_f_enero, ld_nulo, ld_f_enero_fin

dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')
descactual= dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'descripcion')
nro_opcion= dw_listados_varios.getrow()

//dw_listados.setredraw(false)
//dw_listados.reset()
//dw_listados.insertrow(0)
//dw_listados.setredraw(true)

setnull(ld_nulo) // Se realiza para limpiar la fecha de visado en caso que el reporte sea diferente a estadisticas de obra nueva

CHOOSE CASE dwactual
	CASE 'd_fases_estadistica_tipos_interv_obra', 'd_fases_estadistica_tipos_interv_obra_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = true
		dw_listados.object.tipo_obra_t.visible    = true
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false	
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)		
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false				

		
	CASE 'd_fases_estadistica_tipos_interv_obra_mu', 'd_fases_estadistica_tipos_int_obra_mu_lr', 'd_fases_estadistica_tipos_int_obra_mu_al'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = true
		dw_listados.object.tipo_obra_t.visible    = true
		dw_listados.object.poblacion.visible      = true
		dw_listados.object.poblacion_t.visible    = true
		dw_listados.object.comarca.visible      = true
		dw_listados.object.comarca_t.visible    = true		
		dw_listados.object.bb_poblacion.visible   = true
		dw_listados.object.descripcion_pob.visible= true
		dw_listados.object.destino.visible    = true
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.destino_t.visible    = true
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false	
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false				
		
	CASE 'd_fases_estadistica_tipos_interv_prof', 'd_fases_estadistica_tipos_interv_prof_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false				
		
	CASE 'd_fases_estadistica_tipos_interv_prof_g', 'd_fases_estadistica_tipos_int_prof_g_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = true
		dw_listados.object.centro_t.visible    = true
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false				
		
	CASE 'd_fases_estadistica_tipos_interv_seg', 'd_fases_estadistica_tipos_interv_seg_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false		
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false				
		
	CASE 'd_fases_estadistica_tipos_obra', 'd_fases_estadistica_tipos_obra_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = false
		dw_listados.object.tipo_act_t.visible    = false
		dw_listados.object.tipo_obra.visible      = true
		dw_listados.object.tipo_obra_t.visible    = true
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)		
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false		
		
	CASE 'd_fases_estadistica_tipos_obra_g', 'd_fases_estadistica_tipos_obra_g_lr'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = false
		dw_listados.object.tipo_act_t.visible    = false
		dw_listados.object.tipo_obra.visible      = true
		dw_listados.object.tipo_obra_t.visible    = true
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = true
		dw_listados.object.centro_t.visible    = true
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false
		
	CASE 'd_fases_estadistica_tipos_obra_g_tipoact', 'd_fases_estadistica_tipos_obra_g_tact_lr', 'd_fases_estadistica_tipos_obra_g_tact_uv', 'd_fases_estadistica_tipos_obra_g_tact_mv'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = true
		dw_listados.object.tipo_act_t.visible    = true
		dw_listados.object.tipo_obra.visible      = true
		dw_listados.object.tipo_obra_t.visible    = true
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = true
		dw_listados.object.centro_t.visible    = true	
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		if dwactual = 'd_fases_estadistica_tipos_obra_g_tact_lr' then
			dw_listados.object.destino_t.visible    = true
			dw_listados.object.destino.visible    = true
		end if
		dw_listados.object.fecha_entrada_d.visible    = true	
		dw_listados.object.fecha_entrada_h.visible    = true	
		dw_listados.object.fecha_entrada_d_t.visible = true	
		dw_listados.object.fecha_abono_d.visible      = true	
		dw_listados.object.fecha_abono_h.visible      = true	
		dw_listados.object.t_3.visible                       = true	
		dw_listados.object.f_cfo_d.visible                 = true	
		dw_listados.object.f_cfo_h.visible                 = true	
		dw_listados.object.t_5.visible                       = true	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)		
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false
		
	CASE  'd_listado_recuento_mov_mca'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = false
		dw_listados.object.tipo_act_t.visible    = false
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false		
		dw_listados.object.fecha_entrada_d.visible    = false	
		dw_listados.object.fecha_entrada_h.visible    = false	
		dw_listados.object.fecha_entrada_d_t.visible = false	
		dw_listados.object.fecha_abono_d.visible      = false	
		dw_listados.object.fecha_abono_h.visible      = false	
		dw_listados.object.t_3.visible                       = false	
		dw_listados.object.f_cfo_d.visible                 = false	
		dw_listados.object.f_cfo_h.visible                 = false	
		dw_listados.object.t_5.visible                       = false	
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false
		dw_listados.object.mes.visible                     = false
		dw_listados.object.t_4.visible                      = false
		dw_listados.object.t_1.visible                     = TRUE
		dw_listados.object.fecha_visado_h.visible                     = TRUE
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false
		
	CASE  'd_fases_estadistica_obra_nueva_mca','d_fases_estadistica_sup_municipio_mca','d_fases_estadistica_sup_parcela_mca'
		dw_listados.object.fecha_visado_d.visible = true
		dw_listados.object.t_2.visible	= true
		dw_listados.object.tipo_act.visible      = false
		dw_listados.object.tipo_act_t.visible    = false
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false		
		dw_listados.object.fecha_entrada_d.visible    = false	
		dw_listados.object.fecha_entrada_h.visible    = false	
		dw_listados.object.fecha_entrada_d_t.visible = false	
		dw_listados.object.fecha_abono_d.visible      = false	
		dw_listados.object.fecha_abono_h.visible      = false	
		dw_listados.object.t_3.visible                       = false	
		dw_listados.object.f_cfo_d.visible                 = false	
		dw_listados.object.f_cfo_h.visible                 = false	
		dw_listados.object.t_5.visible                       = false
		dw_listados.object.estado.visible                  = true	
		dw_listados.object.t_estado.visible               = true
		dw_listados.object.mes.visible                     = true
		dw_listados.object.t_4.visible                      = true
		dw_listados.object.anyo.visible                     = false
		dw_listados.object.t_anyo.visible                      = false

		if dwactual ='d_fases_estadistica_sup_municipio_mca' then
			dw_listados.object.estado.visible                  = false	
			dw_listados.object.t_estado.visible               = false
			dw_listados.object.t_1.visible                     = TRUE
			dw_listados.object.fecha_visado_h.visible                     = TRUE
			dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)
			dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
			dw_listados.object.fecha_visado_d.protect = 0
			dw_listados.object.mes.visible                     = false
			dw_listados.object.t_4.visible                      = false
			
		elseif dwactual ='d_fases_estadistica_sup_parcela_mca' then
			dw_listados.object.estado.visible                  = false	
			dw_listados.object.t_estado.visible               = false
			
			//se debe indicar la fecha desde visado como enero del a$$HEX1$$f100$$ENDHEX$$o en curso
			ll_anyo = year(today())
			ls_f_enero = '01' +'/'+'01'+'/'+string(ll_anyo)
			ld_f_enero = datetime(date(ls_f_enero))
			dw_listados.object.t_1.visible                     = TRUE
			dw_listados.object.fecha_visado_h.visible                     = TRUE
			dw_listados.setitem(1, 'fecha_visado_d', ld_f_enero)
			dw_listados.setitem(1, 'fecha_visado_h',f_ultimo_dia_mes(idt_f_desde))	
			
		elseif dwactual ='d_fases_estadistica_obra_nueva_mca' then
			ll_anyo = year(today())
			ls_f_enero = '01' +'/'+'01'+'/'+string(ll_anyo)
			ld_f_enero = datetime(date(ls_f_enero))
			
			dw_listados.setitem(1, 'fecha_visado_d', ld_f_enero)
		//	dw_listados.setitem(1, 'mes','')
			dw_listados.object.fecha_visado_h.visible                     = false
			dw_listados.object.t_1.visible                     = false
			
		else
			
			//se debe indicar la fecha desde visado como enero del a$$HEX1$$f100$$ENDHEX$$o en curso
			ll_anyo = year(today())
			ls_f_enero = '01' +'/'+'01'+'/'+string(ll_anyo)
			ld_f_enero = datetime(date(ls_f_enero))
			dw_listados.object.fecha_visado_h.visible                     = TRUE
			dw_listados.object.t_1.visible                     = TRUE
			dw_listados.setitem(1, 'fecha_visado_d', ld_f_enero)
			
		
		end if

	CASE 'd_fases_listado_estadistico_consejo','d_fases_list_est_consejo_fases_abiertas','d_fases_listado_estadistico_consejo_porcent'
		dw_listados.object.tipo_act.visible      = false
		dw_listados.object.tipo_act_t.visible    = false
		dw_listados.object.tipo_obra.visible      = false
		dw_listados.object.tipo_obra_t.visible    = false
		dw_listados.object.poblacion.visible      = false
		dw_listados.object.poblacion_t.visible    = false
		dw_listados.object.bb_poblacion.visible   = false
		dw_listados.object.descripcion_pob.visible= false
		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
		dw_listados.object.centro.visible      = false
		dw_listados.object.centro_t.visible    = false
		dw_listados.object.comarca.visible      = false
		dw_listados.object.comarca_t.visible    = false	
		dw_listados.object.destino.visible    = false
		dw_listados.object.destino_t.visible    = false
		dw_listados.object.fecha_entrada_d.visible    = false
		dw_listados.object.fecha_entrada_h.visible    = false
		dw_listados.object.fecha_entrada_d_t.visible = false
		dw_listados.object.fecha_abono_d.visible      = false
		dw_listados.object.fecha_abono_h.visible      = false
		dw_listados.object.t_3.visible                       = false
		dw_listados.object.f_cfo_d.visible                 = false
		dw_listados.object.f_cfo_h.visible                 = false
		dw_listados.object.t_5.visible                       = false
		dw_listados.object.estado.visible                  = false	
		dw_listados.object.t_estado.visible               = false	
		dw_listados.object.t_1.visible                     = false
		dw_listados.object.fecha_visado_h.visible    = false
		dw_listados.setitem(1, 'fecha_visado_d', ld_nulo)		
		dw_listados.setitem(1, 'fecha_visado_h', ld_nulo)
		dw_listados.object.fecha_visado_d.protect = 0		
		dw_listados.object.mes.visible                     = false
		dw_listados.object.t_4.visible                      = false
		dw_listados.object.fecha_visado_d.visible = false
		dw_listados.object.t_2.visible                      = false
		dw_listados.object.fecha_entrada_h_t.visible = false
		dw_listados.object.anyo.visible                     = true
		dw_listados.object.t_anyo.visible                      = true

		
END CHOOSE

// Modificado Jesus 08/04/2010 SCP-330 .
// Como ningun listado gasta la fecha CFO salvo 'd_fases_estad_tipos_int_obra_mu_gui', se oculta para no poder consultarse
if dwactual <> 'd_fases_estad_tipos_int_obra_mu_gui' then
	dw_listados.object.f_cfo_d.visible                 = false	
	dw_listados.object.f_cfo_h.visible                 = false	
	dw_listados.object.t_5.visible                       = false	
end if

///*Modificado para que en el colegio de Alicante se muestre la fecha de visado rellena. Alexis - 18/10/2009. CAL-197 */

//if g_colegio = 'CAATAL' then

////	if f_es_vacio(string(dw_listados.getitemdatetime(1, 'fecha_visado_d'))) and not f_es_vacio(dw_listados.getitemstring(1, 'mes')) then
////	dw_listados.setitem(1, 'fecha_visado_d',datetime(date("01/"+dw_listados.getitemstring(1, 'mes')+"/"+string(Year(today())))))
////	end if
	//dw_listados.object.visado.visible = true	
	//dw_listados.object.t_visado.visible = true
	if dw_listados.getitemstring(1, 'visado') = 'N' then
		dw_listados.object.fecha_visado_d.protect = 1
		dw_listados.object.fecha_visado_h.protect = 1
	else
		dw_listados.object.fecha_visado_d.protect = 0
		dw_listados.object.fecha_visado_h.protect = 0
	end if	
//else 	
//	dw_listados.object.visado.visible = false	
//	dw_listados.object.t_visado.visible = false
//end if

///************** Fin modificado por ALEXIS - 18/10/2009. CAL-197 ***************/


//CHOOSE CASE nro_opcion
//	CASE 2
//		dw_listados.object.poblacion.visible      = true
//		dw_listados.object.poblacion_t.visible    = true
//		dw_listados.object.bb_poblacion.visible   = true
//		dw_listados.object.descripcion_pob.visible= true		
//	CASE ELSE
//		dw_listados.object.poblacion.visible      = false
//		dw_listados.object.poblacion_t.visible    = false
//		dw_listados.object.bb_poblacion.visible   = false
//		dw_listados.object.descripcion_pob.visible= false	
//		dw_listados.setitem(1,'poblacion','') // borramos la consulta de poblaciones.
//end choose

end event

event dw_listados::itemchanged;call super::itemchanged;datetime f_desde, f_hasta
string      dwactual
long       ll_anyo

dwactual  = dw_listados_varios.getitemstring(dw_listados_varios.getrow(),'dw')

CHOOSE CASE dwo.name
	CASE 'mes'
		if data = '' then return
		f_desde = datetime(date('01/'+data+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'fecha_entrada_d', f_desde)
		this.setitem(1, 'fecha_entrada_h', f_ultimo_dia_mes(f_desde))
		
		if dwactual ='d_fases_estadistica_sup_parcela_mca' then
			this.setitem(1, 'fecha_visado_h', f_ultimo_dia_mes(f_desde))
		end if
		
		///* Se introduce con motivo de que los listados ofrec$$HEX1$$ed00$$ENDHEX$$an los datos de todos los contratos aunque no 
		// estuviesen visados. ALEXIS - 13/10/2009. CAL-197  ************************************************/
//		this.setitem(1, 'fecha_visado_d', f_desde)
		
	CASE 'visado'	
		dw_listados.accepttext()
		if data = 'N' then
			dw_listados.object.fecha_visado_d.protect = 1
			dw_listados.object.fecha_visado_h.protect = 1
		else
			dw_listados.object.fecha_visado_d.protect = 0
			dw_listados.object.fecha_visado_h.protect = 0
		end if	
		
		///* Fin modifcado por ALEXIS 18-10-2009. CAL-197 **********/	
		
	CASE 'fecha_visado_h'
		
		f_hasta  = datetime(date(data))
		f_desde = this.object.fecha_visado_d[1]
		ll_anyo  = year(date(f_hasta))
		
		if dwactual ='d_fases_estadistica_sup_parcela_mca' then
			if ll_anyo < year(date(f_desde)) then
				this.setitem(1, 'fecha_visado_d',datetime(date('01/'+'01/'+string(ll_anyo))))
			end if
		end if
			
				
END CHOOSE	

end event

type cb_imprimir from w_listados`cb_imprimir within w_fases_estadisticas
end type

type cb_zoom from w_listados`cb_zoom within w_fases_estadisticas
end type

type cb_esp from w_listados`cb_esp within w_fases_estadisticas
end type

type cb_guardar from w_listados`cb_guardar within w_fases_estadisticas
end type

type cb_escala from w_listados`cb_escala within w_fases_estadisticas
end type

type cb_ordenar from w_listados`cb_ordenar within w_fases_estadisticas
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_fases_estadisticas
end type

type dw_1 from w_listados`dw_1 within w_fases_estadisticas
integer x = 23
integer width = 3621
end type

