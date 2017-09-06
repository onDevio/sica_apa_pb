HA$PBExportHeader$w_sellador.srw
forward
global type w_sellador from w_sellador_detalle_base
end type
end forward

global type w_sellador from w_sellador_detalle_base
integer width = 3776
event type string csd_sellar_lista_sin_firma ( st_sello sello )
event csd_visar ( )
event csd_control_visado ( )
end type
global w_sellador w_sellador

event csd_visar();//
if MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n","Con este bot$$HEX1$$f300$$ENDHEX$$n visar$$HEX2$$e1002000$$ENDHEX$$el contrato si no lo estaba. $$HEX1$$bf00$$ENDHEX$$Desea continuar?",Question!,YesNo!)=1 then
	if IsValid(g_detalle_fases) then g_detalle_fases.dynamic event csd_visar()
	event csd_control_visado()
end if
end event

event csd_control_visado();string estado,p_visar
boolean visar
w_fases_detalle detalle

detalle=g_detalle_fases

// Si no hemos cerrado la ventana del detalle de fases
// Si el expediente ya esta visado desactivamos el boton de visado
if IsValid(g_detalle_fases) then
   w_fases_detalle ventana
	ventana = g_detalle_fases
	estado = ventana.dw_1.GetItemString(ventana.dw_1.GetRow(),'estado')

	select p_visar into :p_visar
		from expedientes_estado
		where cod_estado = :estado;
		
	if p_visar 		= 'S' then visar =true
	
	m_sellador.m_file.m_visar.enabled= visar
	
	if IsNull(idw_datos_sello.GetItemDateTime(1,'f_visado')) then 
		idw_datos_sello.SetItem(1,'f_visado',detalle.dw_1.GetItemDateTime(detalle.dw_1.GetRow(),'f_visado'))
	end if		
	detalle.dw_1.update()
	dw_fase.SetItem(1,'f_visado',detalle.dw_1.GetItemDateTime(detalle.dw_1.GetRow(),'f_visado'))
end if


end event

on w_sellador.create
call super::create
end on

on w_sellador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event csd_datos_configuracion_sello;call super::csd_datos_configuracion_sello;//Esta funci$$HEX1$$f300$$ENDHEX$$n se utiliza para el nuevo m$$HEX1$$f300$$ENDHEX$$dulo de firma "VISIBLE"
//Rellena los datos de configuraci$$HEX1$$f300$$ENDHEX$$n del sello
int i,col,j
string colegiado,id_fase_col,tipo,tratamiento
datastore ds_fase_colegiados,ds_asociados

ds_fase_colegiados = create datastore
ds_fase_colegiados.dataobject ='d_fases_colegiados'
ds_fase_colegiados.setFilter("renunciado<>'S'") // INC.8894 No deben aparecer los colegiados que han renunciado
ds_fase_colegiados.settransobject(SQLCA)
ds_fase_colegiados.retrieve(i_id_fase)

ds_asociados = create datastore
ds_asociados.dataobject='d_fases_colegiados_asociados'
ds_asociados.SetTransObject(SQLCA)

// EN APAREJADOERS A$$HEX1$$d100$$ENDHEX$$ADIMOS TODOS LOS COLEGIADOS
// EN ARQUITECTOS A$$HEX1$$d100$$ENDHEX$$ADIMOS SOLAMENTE LOS AUTORES
col=0
for i = 1 to ds_fase_colegiados.rowcount()	

	colegiado = ds_fase_colegiados.getitemstring(i,'id_col')
	id_fase_col=ds_fase_colegiados.getitemstring(i,'id_fases_colegiados')
	select tipo_persona into :tipo from colegiados where id_colegiado=:colegiado;

	if tipo='S' and g_colegio='COAATA' then  
		// Alicante solicito que salieran los asociados en el sello (CAL-127)
		ds_asociados.retrieve(id_fase_col)
		for j=1 to ds_asociados.rowcount()
			col++					
			colegiado=ds_asociados.GetItemString(j,'id_col_per')
			colegiado = f_colegiado_ncol_nombre_apellido(colegiado)	
			select tratamiento into :tratamiento from colegiados where id_colegiado=:colegiado;
			if tratamiento='INGENIERO EDIFICACION' then
				//SetProfilestring(g_directorio_temporal + 'sello.ini','CLAUSULAS','clausula_10','')
				//SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_'+string(col),f_parseado_simbolos_xml(colegiado))							
			end if
			SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_'+string(col),f_parseado_simbolos_xml(colegiado))			
		next
	else
		col++
		colegiado = f_colegiado_ncol_nombre_apellido(colegiado)
		if f_es_vacio(colegiado) then colegiado = ''
		SetProfilestring(g_directorio_temporal + 'sello.ini','COLEGIADOS','colegiado_'+string(col),f_parseado_simbolos_xml(colegiado))
	end if	

next

string n_reg_entrada,n_reg
datetime f_reg_entrada
n_reg=dw_fase.getitemstring(1,'fases_n_registro')

select n_registro,fecha into :n_reg_entrada,:f_reg_entrada from registro where n_expediente=:n_reg order by fecha asc;

SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','n_reg_entrada',f_parseado_simbolos_xml(n_reg_entrada))
SetProfilestring(g_directorio_temporal + 'sello.ini','SELLO','f_reg_entrada',string(f_reg_entrada,'dd/mm/yy'))


end event

event open;call super::open;event csd_control_visado()
end event

event csd_visa_ficheros_avanzado;call super::csd_visa_ficheros_avanzado;if i_generar_xml_alfresco then
	f_generar_xml_tg(i_id_fase,is_id_fichero)
	i_generar_xml_alfresco=false
end if
end event

type cb_recuperar_pantalla from w_sellador_detalle_base`cb_recuperar_pantalla within w_sellador
end type

type cb_guardar_pantalla from w_sellador_detalle_base`cb_guardar_pantalla within w_sellador
end type

type dw_fase from w_sellador_detalle_base`dw_fase within w_sellador
integer width = 2491
end type

event dw_fase::retrieveend;//Sobreescrito
//Parametrizamos para los colegios q utilizan la f_abono en lugar de la de visado

if rowcount>0 then
	
	///*Se modifica para introducir la fecha actual solicitada por el colegio de Bizcaia. Alexis - CBI-116. 14/12/2009 */
	// A$$HEX1$$f100$$ENDHEX$$adido Mallorca COAM-305
	if g_colegio = 'COAATB' or g_colegio='COAATMCA' then
		
		idw_datos_sello.setitem(1,'f_visado',datetime(today()))
		
	else 	
		if g_f_abono_es_visado='S' then
			idw_datos_sello.Object.t_7.text='F.Abono'
			idw_datos_sello.setitem(1,'f_visado',this.getitemdatetime(1,'fases_f_abono'))
		else
			idw_datos_sello.setitem(1,'f_visado',this.getitemdatetime(1,'f_visado'))
		end if
	end if	
end if





end event

type gb_opciones from w_sellador_detalle_base`gb_opciones within w_sellador
integer x = 2510
end type

type tab_dir from w_sellador_detalle_base`tab_dir within w_sellador
integer width = 3680
end type

type tabpage_tv from w_sellador_detalle_base`tabpage_tv within tab_dir
integer width = 3643
end type

type dw_docs from w_sellador_detalle_base`dw_docs within tabpage_tv
integer width = 3625
end type

event dw_docs::csd_tecla;call super::csd_tecla;if key = KeyDelete! then
	this.event csd_borrar()
end if

if key = KeyEnd! then
	this.ScrollToRow(this.rowcount())
	this.SetRow(this.rowcount())
end if

if key = KeyHome! then
	this.ScrollToRow(1)
	this.SetRow(1)
end if
end event

type tabpage_1 from w_sellador_detalle_base`tabpage_1 within tab_dir
integer width = 3643
end type

type dw_pos_sellos from w_sellador_detalle_base`dw_pos_sellos within tabpage_1
end type

type dw_opciones_sello from w_sellador_detalle_base`dw_opciones_sello within tabpage_1
end type

type dw_datos_firma from w_sellador_detalle_base`dw_datos_firma within tabpage_1
end type

event dw_datos_firma::itemchanged;call super::itemchanged;//Esta funci$$HEX1$$f300$$ENDHEX$$n se utiliza para el nuevo m$$HEX1$$f300$$ENDHEX$$dulo de firma "VISIBLE"
//Rellena los datos de configuraci$$HEX1$$f300$$ENDHEX$$n del sello
int i,col,j
string colegiado,id_fase_col,tipo,tratamiento


choose case dwo.name
	case 'sello'
		// CAL-179
		// Para Alicante comprobamos si algun colegiado es INGENIERO DE EDIFICACION y activamos el check
		// para mostrar el texto
		if g_colegio='COAATA' then	
			datastore ds_fase_colegiados,ds_asociados
			
			ds_fase_colegiados = create datastore
			ds_fase_colegiados.dataobject ='d_fases_colegiados'
			ds_fase_colegiados.setFilter("renunciado<>'S'") // INC.8894 No deben aparecer los colegiados que han renunciado
			ds_fase_colegiados.settransobject(SQLCA)
			ds_fase_colegiados.retrieve(i_id_fase)
			
			ds_asociados = create datastore
			ds_asociados.dataobject='d_fases_colegiados_asociados'
			ds_asociados.SetTransObject(SQLCA)
				
			col=0
			for i = 1 to ds_fase_colegiados.rowcount()	
			
				colegiado = ds_fase_colegiados.getitemstring(i,'id_col')
				select tratamiento into :tratamiento from colegiados where id_colegiado=:colegiado;		
				if tratamiento='INGENIERO DE EDIFICACION' then idw_opciones_sello.SetItem(1,'activo','S')
				
				id_fase_col=ds_fase_colegiados.getitemstring(i,'id_fases_colegiados')
				select tipo_persona into :tipo from colegiados where id_colegiado=:colegiado;
			
				if tipo='S'  then  
					ds_asociados.retrieve(id_fase_col)
					for j=1 to ds_asociados.rowcount()
						col++					
						colegiado=ds_asociados.GetItemString(j,'id_col_per')
						select tratamiento into :tratamiento from colegiados where id_colegiado=:colegiado;
						if tratamiento='INGENIERO DE EDIFICACION' then idw_opciones_sello.SetItem(1,'activo','S')
					next
				end if				
			next
		end if
		
end choose
end event

type gb_1 from w_sellador_detalle_base`gb_1 within tabpage_1
end type

type gb_3 from w_sellador_detalle_base`gb_3 within tabpage_1
end type

type tabpage_2 from w_sellador_detalle_base`tabpage_2 within tab_dir
integer width = 3643
end type

type cb_anyadir_certificado from w_sellador_detalle_base`cb_anyadir_certificado within tabpage_2
end type

type dw_certificados from w_sellador_detalle_base`dw_certificados within tabpage_2
end type

type tabpage_3 from w_sellador_detalle_base`tabpage_3 within tab_dir
integer width = 3643
end type

type dw_configuracion_sello from w_sellador_detalle_base`dw_configuracion_sello within tabpage_3
end type

type tabpage_4 from w_sellador_detalle_base`tabpage_4 within tab_dir
integer width = 3643
end type

type dw_incidencias from w_sellador_detalle_base`dw_incidencias within tabpage_4
end type

type dw_opciones from w_sellador_detalle_base`dw_opciones within w_sellador
integer x = 2523
end type

type st_imagen_no_disponible from w_sellador_detalle_base`st_imagen_no_disponible within w_sellador
integer x = 2592
end type

type ole_visor_pdf from w_sellador_detalle_base`ole_visor_pdf within w_sellador
integer x = 2592
end type

type p_minist from w_sellador_detalle_base`p_minist within w_sellador
integer y = 2080
integer width = 2089
integer height = 164
end type

type st_rotacion from w_sellador_detalle_base`st_rotacion within w_sellador
integer x = 2203
end type

type cb_voltear_pdf from w_sellador_detalle_base`cb_voltear_pdf within w_sellador
integer x = 2203
end type

type gb_rotacion from w_sellador_detalle_base`gb_rotacion within w_sellador
integer x = 2153
end type

type sle_certificado from w_sellador_detalle_base`sle_certificado within w_sellador
boolean visible = false
end type

type st_estado_sellado from w_sellador_detalle_base`st_estado_sellado within w_sellador
end type

type sle_dir from w_sellador_detalle_base`sle_dir within w_sellador
end type

type gb_estado_sellado from w_sellador_detalle_base`gb_estado_sellado within w_sellador
end type

type gb_dir from w_sellador_detalle_base`gb_dir within w_sellador
end type

type gb_certificado from w_sellador_detalle_base`gb_certificado within w_sellador
boolean visible = false
end type

