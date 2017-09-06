HA$PBExportHeader$n_csd_netfocus.sru
forward
global type n_csd_netfocus from nonvisualobject
end type
end forward

global type n_csd_netfocus from nonvisualobject
end type
global n_csd_netfocus n_csd_netfocus

type variables
int value, numero								//Valor devuelto por la funci$$HEX1$$f300$$ENDHEX$$n de abrir fichero *.dvt que representa el n$$HEX1$$fa00$$ENDHEX$$mero de ficheros abiertos de este tipo 
string docname,named,extension, porcent, mensaje, campo_vacio, sin_campo, num_col, blanco		//Representan el nombre del fichero abierto y la extensi$$HEX1$$f300$$ENDHEX$$n del mismo
long nfile, ll_fila, posic 										//fila_insertada, i=1, dup	
string nivel, uso, n_calle, obra_oficial, codigo_solic, codigo_dato_orden, codigo_dato, codigo_regist, codigo_orden, datos, codio_dato_regis, descripcion, colegio, titulo, objeto_trabajo, libre,emplazamiento, calle_plaza_paseo, codigo_postal, municipio, provincia, codigo_municipio, moneda, sigla, piso, puerta, tipo_intervencion, tipo_obra, destino, promotor, edificio_medianerias, alquiler, venta, autouso, estudio_geotecnico, cdc_externo, seguro_promotor, segurorc_colegiado1, segurorc_colegiado2, segurorc_colegiado3, segurorc_colegiado4, cobro_colegio, tarifa_honorarios, tabtarifa_honorarios, cant_primerpago, porcent_primerpago, gastos_desplaz, num_visitas, cuota_interv_profesCIP, tabla_tarifaCIP, tarifaCIP_aplicada, visado_urgente, observaciones, nombre_promotor, domicilio_promotor, telefono, fax, codigo_colegio, nombre, primer_apellido, segundo_apellido, dni_nif, premaat, reta, sociedad_profesional, num_inscripcion_sociedad, sociedadCIF, domicilio_AT, nombre_representante, cargo, domicilio_representante, nif, colegio_prof, cometido_prof, total_num_clientes, total_num_colegiados, total_num_autor_proyecto, total_num_director_obra, total_registros, codigo_dato_regis, num_colegiado   
 // Campos de datos de los ficheros
string director, autor, tupla, id_fases, nif_cif,cod_postal									// Indica la fila del fichero que estamos leyendo
int num_edificios, num_viviendas, num_viviendas_vpo, superficie_total, superficie_viviendas, superficie_garaje, superficie_otros, plantas_sobrasante, plantas_bajorasante, superficie_sobrasante, superficie_bajorasante, altura, nivel_cdc
datetime fecha
double presupuesto, volumen, porcentaje
int porcent_partic[6],num_coleg[5], cod_post[5]
string facturado, renunciado, tipo_gestion, cobertura, otro_seguro, empresa
string observa, nombre_arq1, nombre_arq2, municipio_con
double coef_cm, porc_aut, porc_dir
double honorarios

//boolean obra_oficial
datastore ids_vacio

end variables

forward prototypes
public subroutine cod_nueve (ref datawindow dw_1)
public subroutine cod_tres (ref datawindow dw_1, ref datawindow dw_fases_estadistica)
public subroutine cargar_datos (integer valor, ref datawindow dw_1, ref datawindow dw_fases_datos_exp, ref datawindow dw_fases_promotores, ref datawindow dw_fases_estadistica, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos)
public subroutine cod_uno (ref datawindow dw_1, ref datawindow dw_fases_datos_exp)
public subroutine cod_cuatro (ref datawindow dw_1)
public subroutine cod_cinco_uno (ref datawindow dw_1, ref datawindow dw_fases_promotores, ref datawindow dw_fases_colegiados)
public subroutine cod_cinco_dos (ref datawindow dw_1, ref datawindow dw_fases_promotores)
public subroutine cod_seis (ref datawindow dw_1, ref datawindow dw_fases_promotores, ref datawindow dw_fases_colegiados)
public subroutine cod_siete (ref datawindow dw_1, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos)
public subroutine cod_ocho (ref datawindow dw_1, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos)
public function integer abrir_dvt ()
public subroutine cod_dos (ref datawindow dw_1, ref datawindow dw_fases_estadistica)
end prototypes

public subroutine cod_nueve (ref datawindow dw_1);				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 09:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				total_num_clientes=Trim(Mid(tupla,16,2))
				sin_campo='TOTAL NUM CLIENTES:'+total_num_clientes
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				total_num_colegiados=Trim(Mid(tupla,18,2))
				sin_campo='TOTAL NUM COLEGIADOS:'+total_num_colegiados
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				total_num_autor_proyecto=Trim(Mid(tupla,20,2))
				sin_campo='TOTAL NUM AUTOR PROYECTO:'+total_num_autor_proyecto
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				total_num_director_obra=Trim(Mid(tupla,22,2))
				sin_campo='TOTAL NUM DIRECTOR OBRA:'+total_num_director_obra
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				total_registros=Trim(Mid(tupla,24,3))
				sin_campo='TOTAL REGISTROS:'+total_registros
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				libre=Trim(Mid(tupla,27,228))
				sin_campo='LIBRE 09:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				mensaje+=campo_vacio
				MessageBox(g_titulo,mensaje)
				//MessageBox(g_titulo,sin_campo)
				OpenWithParm(w_csd_netfocus_incidencias,ids_vacio)
				
				
				
end subroutine

public subroutine cod_tres (ref datawindow dw_1, ref datawindow dw_fases_estadistica);				int num
		      sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 03:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				tipo_intervencion=Trim(Mid(tupla,16,2))
				select count(*) into :num from t_fases where c_t_fase=:tipo_intervencion;
				if (num = 0)then tipo_intervencion='00'
				if (num = 0)then campo_vacio+='TIPO DE INTERVENCI$$HEX1$$d300$$ENDHEX$$N'+cr
				dw_1.setitem(1, 'fase', tipo_intervencion)
				tipo_obra=Trim(Mid(tupla,18,2))
				select count(*) into :num from trabajos where c_trabajo=:tipo_obra;
				if (num = 0)then tipo_obra='00' 
				if (num = 0)then campo_vacio+='TIPO DE OBRA'+cr 
				dw_1.setitem(1, 'tipo_trabajo', tipo_obra)
				destino=Trim(Mid(tupla,20,2))
				select count(*) into :num from tipos_trabajos where c_t_trabajo=:destino;
				if (num = 0)then destino='00'
				if (num = 0)then campo_vacio+='DESTINO'+cr
				dw_1.setitem(1, 'trabajo', destino)	
				promotor=Trim(Mid(tupla,22,1))
				dw_fases_estadistica.setitem(1, 't_promotor', promotor)	
				num_edificios=Integer(Trim(Mid(tupla,23,3)))
				dw_fases_estadistica.setitem(1, 'num_edif', num_edificios)	
				num_viviendas=Integer(Trim(Mid(tupla,26,4)))
				dw_fases_estadistica.setitem(1, 'num_viv', num_viviendas)
				num_viviendas_vpo=Integer(Trim(Mid(tupla,30,4)))
				dw_fases_estadistica.setitem(1, 'n_viv_vpo', num_viviendas_vpo)
				superficie_total=Integer(Trim(Mid(tupla,34,6)))
				dw_fases_estadistica.setitem(1, 'sup_total', superficie_total)
				superficie_viviendas=Integer(Trim(Mid(tupla,40,6)))
				dw_fases_estadistica.setitem(1, 'sup_viv', superficie_viviendas)
				superficie_garaje=Integer(Trim(Mid(tupla,46,6)))
				dw_fases_estadistica.setitem(1, 'sup_garage', superficie_garaje)
				superficie_otros=Integer(Trim(Mid(tupla,52,6)))
				dw_fases_estadistica.setitem(1, 'sup_otros', superficie_otros)
				plantas_sobrasante=Integer(Trim(Mid(tupla,58,3)))
				dw_fases_estadistica.setitem(1, 'plantas_sob', plantas_sobrasante)
				superficie_sobrasante=Integer(Trim(Mid(tupla,61,6)))
				dw_fases_estadistica.setitem(1, 'sup_sob', superficie_sobrasante)
				plantas_bajorasante=Integer(Trim(Mid(tupla,67,3)))
				dw_fases_estadistica.setitem(1, 'plantas_baj', plantas_bajorasante)
				superficie_bajorasante=Integer(Trim(Mid(tupla,70,6)))
				dw_fases_estadistica.setitem(1, 'sup_baj', superficie_bajorasante)
				altura=Integer(Trim(Mid(tupla,76,3)))
				dw_fases_estadistica.setitem(1, 'altura', altura)
				edificio_medianerias=Trim(Mid(tupla,79,1))
				if	(edificio_medianerias='0') then edificio_medianerias='No tiene' 
			   if (edificio_medianerias='1') then edificio_medianerias='Un lado' 
				if (edificio_medianerias='2') then edificio_medianerias='M$$HEX1$$e100$$ENDHEX$$s de un lado' 
				dw_fases_estadistica.setitem(1, 'colindantes', edificio_medianerias)
				alquiler=Trim(Mid(tupla,80,1))
				venta=Trim(Mid(tupla,81,1))
				autouso=Trim(Mid(tupla,82,1))
				if(alquiler='S')then uso='Alquiler'
				if(venta='S')then uso='Venta'
				if(autouso='S')then uso='AutoUso'
				dw_fases_estadistica.setitem(1, 'uso', uso)
				estudio_geotecnico=Trim(Mid(tupla,83,1))
				dw_fases_estadistica.setitem(1, 'estudio_geo', estudio_geotecnico)
				cdc_externo=Trim(Mid(tupla,84,1))
				dw_fases_estadistica.setitem(1, 'cc_externo', cdc_externo)
				nivel_cdc=Integer(Trim(Mid(tupla,85,1)))
				if(nivel_cdc=0)then nivel='No hay'
				dw_fases_estadistica.setitem(1, 'niv_cont', nivel)
				if(nivel_cdc=1)then nivel='R'
				dw_fases_estadistica.setitem(1, 'niv_cont', nivel)
				if(nivel_cdc=2)then nivel='N'
				dw_fases_estadistica.setitem(1, 'niv_cont', nivel)
				if(nivel_cdc=3)then nivel='A'
				dw_fases_estadistica.setitem(1, 'niv_cont', nivel)
				seguro_promotor=Trim(Mid(tupla,86,24))
				sin_campo='SEGURO PROMOTOR:'+seguro_promotor
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				segurorc_colegiado1=Trim(Mid(tupla,110,15))
				sin_campo='SEGURO COLEGIADO 1:'+segurorc_colegiado1
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				segurorc_colegiado2=Trim(Mid(tupla,125,15))
				sin_campo='SEGURO COLEGIADO 2:'+segurorc_colegiado2
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				segurorc_colegiado3=Trim(Mid(tupla,140,15))
				sin_campo='SEGURO COLEGIADO 3:'+segurorc_colegiado3
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				segurorc_colegiado4=Trim(Mid(tupla,155,15))
				sin_campo='SEGURO COLEGIADO 4:'+segurorc_colegiado4
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				libre=Trim(Mid(tupla,170,85))
				sin_campo='LIBRE 03:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				
				
end subroutine

public subroutine cargar_datos (integer valor, ref datawindow dw_1, ref datawindow dw_fases_datos_exp, ref datawindow dw_fases_promotores, ref datawindow dw_fases_estadistica, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos);

IF valor = 1 THEN
	
	nfile = FileOpen(docname, LineMode!, Read!, LockWrite!)
   valor = FileRead(nfile, tupla)
   mensaje=''		
	campo_vacio='Los siguientes campos est$$HEX1$$e100$$ENDHEX$$n vac$$HEX1$$ed00$$ENDHEX$$os:'+cr
	sin_campo='Los siguientes datos no se muestran en ning$$HEX1$$fa00$$ENDHEX$$n campo del formulario y tienen los siguientes valores:'
	ll_fila=ids_vacio.insertrow(0)
	ids_vacio.setitem(ll_fila,'titulo',sin_campo)
	blanco=''
	ll_fila=ids_vacio.insertrow(0)
	ids_vacio.setitem(ll_fila,'titulo',blanco)
	DO WHILE valor >= 0
		codigo_solic = Trim(Mid(tupla,1,9))
		codigo_dato =  Trim(Mid(tupla,10,2))
		codigo_regist = Trim(Mid(tupla,14,2))
		codigo_orden = Trim(Mid(tupla,12,2))
		datos = Trim(Mid(tupla,16,239))
		codigo_dato_regis=Trim(Mid(tupla,10,4))
		
		
		
		/*choose case codigo_dato_regis
			case '0101'
				descripcion = "Datos Generales"
				dw_1.setitem(1, 'descripcion', descripcion)

			case '0201'
				descripcion = "Localizaci$$HEX1$$f300$$ENDHEX$$n"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0301'
				descripcion = "Datos Estad$$HEX1$$ed00$$ENDHEX$$sticos"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0401'
				descripcion = "Datos Econ$$HEX1$$f300$$ENDHEX$$micos"
				dw_1.setitem(1, 'descripcion', descripcion)
				
			case '0501'
				descripcion = "Cliente. Titular"
				dw_1.setitem(1, 'descripcion', descripcion)
				
			case '0502'
				descripcion = "Cliente. Representante"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0601'
				descripcion = "Arquitecto T$$HEX1$$e900$$ENDHEX$$cnico"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0701'
				descripcion = "Autor de Proyecto"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0801'
				descripcion = "Director de Obra"
				dw_1.setitem(1, 'descripcion', descripcion)
			
			case '0901'
				descripcion = "Resumen"
				dw_1.setitem(1, 'descripcion', descripcion)

						
		end choose*/
		
	
		

		choose case codigo_dato
			case '01'
				cod_uno(dw_1,dw_fases_datos_exp)
								
			case '02'
				cod_dos(dw_1,dw_fases_estadistica)	
								
			case '03'
				cod_tres(dw_1,dw_fases_estadistica)	
								
			case '04'
				cod_cuatro(dw_1)		
				
			case '05'
				if(codigo_orden='01')then
					cod_cinco_uno(dw_1,dw_fases_promotores,dw_fases_colegiados)
				else
					cod_cinco_dos(dw_1,dw_fases_promotores)				
			end if
			
			case '06'
				cod_seis(dw_1,dw_fases_promotores, dw_fases_colegiados)
				
			case '07'
				cod_siete(dw_1, dw_fases_colegiados, dw_fases_arquitectos)
				
			case '08'
				cod_ocho(dw_1, dw_fases_colegiados, dw_fases_arquitectos)
				
			case '09'
				cod_nueve(dw_1)
				
		end choose
		
		valor = FileRead(nfile, tupla)
	LOOP
end if


FileClose(nfile)


end subroutine

public subroutine cod_uno (ref datawindow dw_1, ref datawindow dw_fases_datos_exp);				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 01:'	
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				colegio=Trim(Mid(tupla,16,2))
				string dia, mes, anyo
				dia = Trim(Mid(tupla,18,2))
				mes = Trim(Mid(tupla,20,2))
				anyo = Trim(Mid(tupla,22,4))
				fecha=datetime(date(dia+'/'+mes+'/'+anyo))
				dw_1.setitem(1, 'f_entrada', fecha)
				titulo=Trim(Mid(tupla,26,125))
				sin_campo='TITULO:'+titulo
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				objeto_trabajo=Trim(Mid(tupla,151,100))
				objeto_trabajo=Upper(objeto_trabajo)
				dw_1.setitem(1, 'descripcion', objeto_trabajo)
				dw_1.setitem(1,'e_mail', 'S')
				obra_oficial=Trim(Mid(tupla,251,1))
				dw_fases_datos_exp.setitem(1, 'administracion', obra_oficial)
				libre=Trim(Mid(tupla,252,3))
				sin_campo='LIBRE 01:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',blanco)
				
				
end subroutine

public subroutine cod_cuatro (ref datawindow dw_1);				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 04:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				cobro_colegio=Trim(Mid(tupla,16,1))
				if(cobro_colegio='N')then cobro_colegio='P'
				if(cobro_colegio='S')then cobro_colegio='C'
				dw_1.setitem(1, 'tipo_gestion', cobro_colegio)
				
//				string ls_1
//				ls_1=Trim(Mid(tupla,17,12))
//				//messagebox('string',ls_1)
//				double ld_1, ld_2
//				ld_1 = double(ls_1)
//				ld_2 = ld_1/100
//				messagebox('do',string(ld_2))
				//messagebox('do',string(ld_1))
				honorarios=double(Trim(Mid(tupla,17,12)))
				honorarios=honorarios/100
				//messagebox('do',string(honorarios))
				if(honorarios=0)then campo_vacio+='HONORARIOS'+cr
				dw_1.setitem(1, 'honorarios', honorarios)
				tarifa_honorarios=Trim(Mid(tupla,29,10))
				sin_campo='TARIFA HONORARIOS:'+tarifa_honorarios
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				tabtarifa_honorarios=Trim(Mid(tupla,39,1))
				sin_campo='TABLA TARIFA HONORARIOS:'+tabtarifa_honorarios
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				cant_primerpago=Trim(Mid(tupla,40,12))
				sin_campo='CANTIDAD PRIMER PAGO:'+cant_primerpago
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				porcent_primerpago=Trim(Mid(tupla,52,5))
				sin_campo='PORCENTAJE PRIMER PAGO:'+porcent_primerpago
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				gastos_desplaz=Trim(Mid(tupla,57,10))
				sin_campo='GASTOS DESPLAZAMIENTO:'+gastos_desplaz
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				num_visitas=Trim(Mid(tupla,67,3))
				sin_campo='N$$HEX1$$da00$$ENDHEX$$MERO DE VISITAS:'+num_visitas
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				cuota_interv_profesCIP=Trim(Mid(tupla,70,12))
				sin_campo='CUOTA INTERVENC. PROF. C.I.P:'+cuota_interv_profesCIP
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				tabla_tarifaCIP=Trim(Mid(tupla,82,1))
				sin_campo='TABLA TARIFA C.I.P:'+tabla_tarifaCIP
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				tarifaCIP_aplicada=Trim(Mid(tupla,83,10))
				sin_campo='TARIFA C.I.P APLICADA:'+tarifaCIP_aplicada
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				visado_urgente=Trim(Mid(tupla,93,1))
				sin_campo='VISADO URGENTE:'+visado_urgente
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				observaciones=Trim(Mid(tupla,94,100))
				dw_1.setitem(1, 'observaciones', observaciones)
				libre=Trim(Mid(tupla,194,61))
				sin_campo='LIBRE 04:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				
					
end subroutine

public subroutine cod_cinco_uno (ref datawindow dw_1, ref datawindow dw_fases_promotores, ref datawindow dw_fases_colegiados);			int num_clientes, i, num
			string id_cli,p1,p2,p3,p4,p5,p6,cp1,cp2,cp3,cp4,cp5,cont1, clien
			cont1=''
			cod_postal=''		
			st_ficha_cliente datos_cliente
			
			
			nif_cif=Trim(Mid(tupla,152,10))
			if(Trim(Mid(tupla,102,1))='')then
					cp1=''
				else				
					cod_post[1]=Integer(Trim(Mid(tupla,102,1)))
					cp1=string(cod_post[1])
				end if
				if(Trim(Mid(tupla,103,1))='')then
					cp2=''
				else				
					cod_post[2]=Integer(Trim(Mid(tupla,103,1)))
					cp2=string(cod_post[2])
				end if
				if(Trim(Mid(tupla,104,1))='')then
					cp3=''
				else				
					cod_post[3]=Integer(Trim(Mid(tupla,104,1)))
					cp3=string(cod_post[3])
				end if
				if(Trim(Mid(tupla,105,1))='')then
					cp4=''
				else				
					cod_post[4]=Integer(Trim(Mid(tupla,105,1)))
					cp4=string(cod_post[4])
				end if
				if(Trim(Mid(tupla,106,1))='')then
					cp5=''
				else				
					cod_post[5]=Integer(Trim(Mid(tupla,106,1)))
					cp5=string(cod_post[5])
				end if
				
				if(cp1='')then 
					cont1+='0'
				else 
					cod_postal+=cp1
				end if
				
				if(cp2='')then 
					cont1+='0'
			   else 
					cod_postal+=cp2
				end if	
				
				if(cp3='')then 
					cont1+='0'
			   else 
					cod_postal+=cp3
				end if
				
				if(cp4='')then 
					cont1+='0'
			   else 
					cod_postal+=cp4
				end if
				
				if(cp5='')then 
					cont1+='0'
			   else 
					cod_postal+=cp5
				end if
				codigo_postal=cont1+cod_postal
			
			//codigo_postal=Trim(Mid(tupla,102,5))
			if(codigo_postal='')then campo_vacio+='C$$HEX1$$d300$$ENDHEX$$DIGO POSTAL 0501'+cr
			select count(*) into :num from poblaciones where cod_pos=:codigo_postal;
			if (num = 0)then municipio='00' 
			select cod_pob into :municipio from poblaciones where cod_pos=:codigo_postal;
			//dw_1.setitem(1, 'poblacion', codigo_postal)
			//dw_1.setitem(1, 'compute_2', municipio)
			nombre_promotor=Trim(Mid(tupla,22,45))
			nombre_promotor= Upper(nombre_promotor)
			domicilio_promotor=Trim(Mid(tupla,67,35))
			domicilio_promotor= Upper(domicilio_promotor)
			provincia=Trim(Mid(tupla,132,20))
			nif_cif=Trim(Mid(tupla,152,10))
			telefono=Trim(Mid(tupla,162,12))
			fax=Trim(Mid(tupla,174,12))
			sigla=Trim(Mid(tupla,186,2))
			n_calle=''
			if(sigla='')then 
				campo_vacio+='SIGLA 0501'+cr
				sigla = 'SC'
			end if
			dw_1.setitem(1, 'tipo_via_emplazamiento', sigla)
			calle_plaza_paseo=Trim(Mid(tupla,188,5))
			if(calle_plaza_paseo <> '')then 
			n_calle=string(calle_plaza_paseo)
			end if
			piso=Trim(Mid(tupla,193,2))
			if(piso <> '')then 
			n_calle=string(n_calle+','+piso)
			end if
			puerta=Trim(Mid(tupla,195,2))
			if(puerta <> '')then 
			n_calle=string(n_calle+','+puerta)
			end if
			//n_calle=string(calle_plaza_paseo+','+piso+','+puerta)
			dw_1.setitem(1, 'n_calle', n_calle)
			libre=Trim(Mid(tupla,197,58))
			porcent_partic[1]=Integer(Trim(Mid(tupla,16,1)))
				porcent_partic[2]=Integer(Trim(Mid(tupla,17,1)))
				porcent_partic[3]=Integer(Trim(Mid(tupla,18,1)))
				porcent_partic[4]=Integer(Trim(Mid(tupla,19,1)))
				porcent_partic[5]=Integer(Trim(Mid(tupla,20,1)))
				porcent_partic[6]=Integer(Trim(Mid(tupla,21,1)))
				p1=string(porcent_partic[1])
				p2=string(porcent_partic[2])
				p3=string(porcent_partic[3])
				p4=string(porcent_partic[4])
				p5=string(porcent_partic[5])
				p6=string(porcent_partic[6])
				porcent=p1+p2+p3+','+p4+p5+p6
				porcentaje=Integer(p1+p2+p3)
				dw_fases_promotores.setitem(1, 'porcen', porcentaje)
				dw_fases_colegiados.setitem(1, 'porcen_a', porcentaje)
				
				
				
		if (nif_cif="") then 
				mensaje+='El nif de un cliente titular est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o'+cr
				//MessageBox(g_titulo,'El nif del cliente titular est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o')
//				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'id_cliente',f_cliente_id_cliente(nif_cif))
//				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif',nif_cif)
//				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'porcen',0)
		else
			select count(*) into :num_clientes from clientes where nif=:nif_cif;
			if num_clientes > 0 then
				mensaje+='El cliente ya existe'+cr
				//MessageBox(g_titulo,'El cliente ya existe')
				if num_clientes = 1 then
					SELECT clientes.id_cliente  INTO :clien  FROM clientes  WHERE clientes.nif = :nif_cif;
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'id_cliente',clien)
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif',nif_cif)
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'cliente',clien)
				
				else
					MessageBox(g_titulo,'Existe m$$HEX1$$e100$$ENDHEX$$s de un cliente titular con este NIF')
//					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif',nif_cif)
					g_busqueda.titulo="B$$HEX1$$fa00$$ENDHEX$$squeda r$$HEX1$$e100$$ENDHEX$$pida de clientes"
					g_busqueda.dw="d_lista_busqueda_clientes"
					string id_persona
					id_persona = f_busqueda_clientes(nif_cif)
					if not(f_es_vacio(id_persona)) then 
						select nif into :nif from clientes where id_cliente = :id_persona;
					end if
					if not(f_es_vacio(nif)) then dw_fases_promotores.setitem(dw_fases_promotores.Getrow(),'nif',nif_cif)
					if not(f_es_vacio(id_persona)) then dw_fases_promotores.setitem(dw_fases_promotores.Getrow(),'id_cliente',id_persona)
//					dw_fases_promotores.triggerevent ("csd_abrir_busqueda_cliente")		
//					OpenWithParm(w_busqueda_clientes,nif_cif)
				end if
			dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'porcen',100)
		
			else
				//Aqui va el c$$HEX1$$f300$$ENDHEX$$digo q abre la ventana
				mensaje+='El cliente no existe'+cr
				//MessageBox(g_titulo,'El cliente no existe')
				datos_cliente.nif=nif_cif
				datos_cliente.id_cliente=""
				datos_cliente.cp=codigo_postal
				datos_cliente.provincia=provincia
				datos_cliente.telefono=telefono
				datos_cliente.fax=fax
				datos_cliente.sigla=sigla
				datos_cliente.domic_prom=domicilio_promotor
				datos_cliente.nom_prom=nombre_promotor
				datos_cliente.tipo_tercero = g_terceros_codigos.codigo_cliente
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
				id_cli = Message.StringParm
				dw_fases_promotores.SetItem(dw_fases_promotores.getrow(),'id_cliente',id_cli)
				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif',nif_cif)
				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'cliente',f_cliente_id_cliente(nif_cif))
				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'porcen',porcent)
				
			
		end if
	end if
		
		
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,14,2))
				codigo_orden=Trim(Mid(tupla,12,2))
				
				
end subroutine

public subroutine cod_cinco_dos (ref datawindow dw_1, ref datawindow dw_fases_promotores);				int num, num_clientes
				st_ficha_cliente datos_cliente
				string id_rep,cp1,cp2,cp3,cp4,cp5,cont1
				cont1=''
				cod_postal=''				
				
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,14,2))
				codigo_orden=Trim(Mid(tupla,12,2))
				nombre_representante=Trim(Mid(tupla,16,30))
				cargo=Trim(Mid(tupla,46,30))
				domicilio_representante=Trim(Mid(tupla,76,35))
				if(Trim(Mid(tupla,111,1))='')then
					cp1=''
				else				
					cod_post[1]=Integer(Trim(Mid(tupla,111,1)))
					cp1=string(cod_post[1])
				end if
				if(Trim(Mid(tupla,112,1))='')then
					cp2=''
				else				
					cod_post[2]=Integer(Trim(Mid(tupla,112,1)))
					cp2=string(cod_post[2])
				end if
				if(Trim(Mid(tupla,113,1))='')then
					cp3=''
				else				
					cod_post[3]=Integer(Trim(Mid(tupla,113,1)))
					cp3=string(cod_post[3])
				end if
				if(Trim(Mid(tupla,114,1))='')then
					cp4=''
				else				
					cod_post[4]=Integer(Trim(Mid(tupla,114,1)))
					cp4=string(cod_post[4])
				end if
				if(Trim(Mid(tupla,115,1))='')then
					cp5=''
				else				
					cod_post[5]=Integer(Trim(Mid(tupla,115,1)))
					cp5=string(cod_post[5])
				end if
				
				if(cp1='')then 
					cont1+='0'
				else 
					cod_postal+=cp1
				end if
				
				if(cp2='')then 
					cont1+='0'
			   else 
					cod_postal+=cp2
				end if	
				
				if(cp3='')then 
					cont1+='0'
			   else 
					cod_postal+=cp3
				end if
				
				if(cp4='')then 
					cont1+='0'
			   else 
					cod_postal+=cp4
				end if
				
				if(cp5='')then 
					cont1+='0'
			   else 
					cod_postal+=cp5
				end if
				codigo_postal=cont1+cod_postal
				
				//codigo_postal=Trim(Mid(tupla,111,5))
				if(codigo_postal='')then campo_vacio+='C$$HEX1$$d300$$ENDHEX$$DIGO POSTAL 0502'+cr
				select count(*) into :num from poblaciones where cod_pos=:codigo_postal;
				if (num = 0)then municipio='00' 
			 	select cod_pob into :municipio from poblaciones where cod_pos=:codigo_postal;
				//dw_1.setitem(1, 'poblacion', codigo_postal)
				//dw_1.setitem(1, 'compute_2', municipio)
				provincia=Trim(Mid(tupla,141,20))
				nif=Trim(Mid(tupla,161,10))
				telefono=Trim(Mid(tupla,171,12))
				sigla=Trim(Mid(tupla,183,2))
				if(sigla='')then 
					campo_vacio+='SIGLA 0502'+cr
					sigla = 'SC'
				end if
				dw_1.setitem(1, 'tipo_via_emplazamiento', sigla)
				n_calle=''
			calle_plaza_paseo=Trim(Mid(tupla,185,5))
			if(calle_plaza_paseo <> '')then 
			n_calle=string(calle_plaza_paseo)
			end if
			piso=Trim(Mid(tupla,190,2))
			if(piso <> '')then 
			n_calle=string(n_calle+','+piso)
			end if
			puerta=Trim(Mid(tupla,192,2))
			if(puerta <> '')then 
			n_calle=string(n_calle+','+puerta)
			end if
				//n_calle=string(calle_plaza_paseo+','+piso+','+puerta)
				dw_1.setitem(1, 'n_calle', n_calle)
				libre=Trim(Mid(tupla,194,61))
				
		if (nif="")then
			mensaje+='El nif del cliente representante est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o'+cr
			//MessageBox(g_titulo,'El nif del cliente representante est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o')
			dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif_representante',nif)
			dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'id_representante',f_cliente_id_cliente(nif))
			dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'porcen',0)
					
		else
				select id_cliente into :id_rep from clientes where nif=:nif;
				select count(*) into :num_clientes from clientes_terceros where id_cliente=:id_rep and c_tercero='23';
			if num_clientes > 0 then 
				mensaje+='El cliente representante ya existe'+cr
				//MessageBox(g_titulo,'El cliente representante ya existe')
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif_representante',nif)
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'id_representante',f_cliente_id_cliente(nif))
					dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'porcen',100)
				
			else
				mensaje+='El cliente representante no existe'+cr
				//MessageBox(g_titulo,'El cliente representante no existe')
				datos_cliente.nif=nif
				datos_cliente.id_cliente=""
				datos_cliente.cp=codigo_postal
				datos_cliente.provincia=provincia
				datos_cliente.telefono=telefono
				datos_cliente.fax=fax
				datos_cliente.sigla=sigla
				datos_cliente.domic_prom=domicilio_representante
				datos_cliente.nom_prom=nombre_representante
				datos_cliente.tipo_tercero = g_terceros_codigos.representantes
				OpenWithParm(w_fases_ficha_cliente,datos_cliente)
				id_rep = Message.StringParm
				dw_fases_promotores.SetItem(dw_fases_promotores.getrow(),'id_representante',id_rep)
				dw_fases_promotores.setitem(dw_fases_promotores.getrow() ,'nif_representante',nif)
				
			
			end if
			
		end if		
end subroutine

public subroutine cod_seis (ref datawindow dw_1, ref datawindow dw_fases_promotores, ref datawindow dw_fases_colegiados);				string p1,p2,p3,p4,p5,p6,nc1,nc2,nc3,nc4,nc5,cont,cp1,cp2,cp3,cp4,cp5,cont1, ls_id_fase, id_coleg
				int num, cien
				cien=100
				cont=''
				cont1=''
				cod_postal=''
				num_col=''
				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 06:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				porcent_partic[1]=Integer(Trim(Mid(tupla,16,1)))
				porcent_partic[2]=Integer(Trim(Mid(tupla,17,1)))
				porcent_partic[3]=Integer(Trim(Mid(tupla,18,1)))
				porcent_partic[4]=Integer(Trim(Mid(tupla,19,1)))
				porcent_partic[5]=Integer(Trim(Mid(tupla,20,1)))
				porcent_partic[6]=Integer(Trim(Mid(tupla,21,1)))
				p1=string(porcent_partic[1])
				p2=string(porcent_partic[2])
				p3=string(porcent_partic[3])
				p4=string(porcent_partic[4])
				p5=string(porcent_partic[5])
				p6=string(porcent_partic[6])
				porcent=p1+p2+p3+','+p4+p5+p6
				porcentaje=Integer(p1+p2+p3)
				dw_fases_promotores.setitem(1, 'porcen', porcentaje)
				dw_fases_colegiados.setitem(1, 'porcen_a', porcentaje)
				codigo_colegio=Trim(Mid(tupla,22,2))
				sin_campo='C$$HEX1$$d300$$ENDHEX$$DIGO COLEGIADO:'+codigo_colegio
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				//num_colegiado=Trim(Mid(tupla,24,5))
				if(Trim(Mid(tupla,24,1))='')then
					nc1=''
				else				
					num_coleg[1]=Integer(Trim(Mid(tupla,24,1)))
					nc1=string(num_coleg[1])
				end if
				if(Trim(Mid(tupla,25,1))='')then
					nc2=''
				else				
					num_coleg[2]=Integer(Trim(Mid(tupla,25,1)))
					nc2=string(num_coleg[2])
				end if
				if(Trim(Mid(tupla,26,1))='')then
					nc3=''
				else				
					num_coleg[3]=Integer(Trim(Mid(tupla,26,1)))
					nc3=string(num_coleg[3])
				end if
				if(Trim(Mid(tupla,27,1))='')then
					nc4=''
				else				
					num_coleg[4]=Integer(Trim(Mid(tupla,27,1)))
					nc4=string(num_coleg[4])
				end if
				if(Trim(Mid(tupla,28,1))='')then
					nc5=''
				else				
					num_coleg[5]=Integer(Trim(Mid(tupla,28,1)))
					nc5=string(num_coleg[5])
				end if
				
				if(nc1='')then 
					cont+='0'
				else 
					num_col+=nc1
				end if
				
				if(nc2='')then 
					cont+='0'
			   else 
					num_col+=nc2
				end if	
				
				if(nc3='')then 
					cont+='0'
			   else 
					num_col+=nc3
				end if
				
				if(nc4='')then 
					cont+='0'
			   else 
					num_col+=nc4
				end if
				
				if(nc5='')then 
					cont+='0'
			   else 
					num_col+=nc5
				end if
				long ll_num_col
				num_colegiado=cont+num_col
				if(num_colegiado = '00000')then
					num_colegiado=''
				end if
				select id_colegiado into :id_coleg from colegiados where n_colegiado=:num_colegiado;
				select tipo_gestion into :tipo_gestion from fases_colegiados where id_col =:id_coleg;
				select facturado into :facturado from fases_colegiados where id_col =:id_coleg;
				select renunciado into :renunciado from fases_colegiados where id_col =:id_coleg;
				select observa into :observa from fases_colegiados where id_col =:id_coleg;
				select otro_seguro into :otro_seguro from fases_colegiados where id_col =:id_coleg;
				select empresa into :empresa from fases_colegiados where id_col =:id_coleg;
				select porc_aut into :porc_aut from fases_colegiados where id_col =:id_coleg;
				select porcen_d into :porc_dir from fases_colegiados where id_col =:id_coleg;
				SELECT musaat.src_cober, musaat.src_coef_cm INTO :cobertura, :coef_cm FROM musaat WHERE musaat.id_col = :id_coleg;
						
				select count(*) into :ll_num_col from colegiados where n_colegiado=:num_colegiado;
				long ll_ret
				//ll_ret = dw_fases_colegiados.insertrow(0)
				ll_ret = dw_fases_colegiados.deleterow(0)
				if ll_num_col > 0 then
					ll_ret = dw_fases_colegiados.insertrow(0)
					dw_fases_colegiados.setitem(ll_ret, 'id_col', id_coleg)
					
					dw_fases_colegiados.setitem(ll_ret, 'facturado', facturado)
					dw_fases_colegiados.setitem(ll_ret, 'renunciado', renunciado)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_gestion', tipo_gestion)
					dw_fases_colegiados.setitem(ll_ret, 'observaciones', observa)
					dw_fases_colegiados.setitem(ll_ret, 'cobertura', cobertura)
					dw_fases_colegiados.setitem(ll_ret, 'otro_seguro', otro_seguro)
					dw_fases_colegiados.setitem(ll_ret, 'coef_cm', coef_cm)
					dw_fases_colegiados.setitem(ll_ret, 'porc_aut', porc_aut)
					dw_fases_colegiados.setitem(ll_ret, 'porc_dir', porc_dir)
					
					ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
					dw_fases_colegiados.setitem(ll_ret,'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
					dw_fases_colegiados.setitem(ll_ret, 'id_fase', ls_id_fase)
					dw_fases_colegiados.setitem(ll_ret, 'n_col', num_colegiado)
					dw_fases_colegiados.setitem(ll_ret, 'porcen_a', cien)
				else
					if (cont <> '00000')then
							mensaje+='El colegiado con n$$HEX1$$fa00$$ENDHEX$$mero '+cont+' no existe'+cr
					else
							mensaje+='El colegiado con n$$HEX1$$fa00$$ENDHEX$$mero '+num_colegiado+' no existe'+cr
					end if	
				end if
				
				
				/*long ll_ret
				aut='S'
				ll_ret = dw_fases_arquitectos.insertrow(0)
				if not f_es_vacio(ls_id_arq) then
						
					dw_fases_arquitectos.setitem(ll_ret, 'id_arqui', ls_id_arq)					
				else
					mensaje+='El arquitecto no existe'+cr	
					
				end if	
				ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
				dw_fases_arquitectos.setitem(ll_ret,'id_fases_arquitectos',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))
				dw_fases_arquitectos.setitem(ll_ret, 'id_fase', ls_id_fase)
				dw_fases_arquitectos.setitem(ll_ret, 'nombre', nombre)
				dw_fases_arquitectos.setitem(ll_ret, 'tipo_a', aut)*/
				nombre=Trim(Mid(tupla,29,14))
				nombre=Upper(nombre)
				sin_campo+='NOMBRE:'+nombre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				primer_apellido=Trim(Mid(tupla,43,14))
				sin_campo='PRIMER APELLIDO:'+primer_apellido
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				segundo_apellido=Trim(Mid(tupla,57,14))
				sin_campo='SEGUNDO APELLIDO:'+segundo_apellido
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				dni_nif=Trim(Mid(tupla,71,10))
				sin_campo='DNI/NIF:'+dni_nif
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				premaat=Trim(Mid(tupla,81,1))
				sin_campo='PREMAAT:'+premaat
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				reta=Trim(Mid(tupla,82,1))
				sin_campo='RETA:'+reta
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				sociedad_profesional=Trim(Mid(tupla,83,30))
				sin_campo='SOCIEDAD PROFESIONAL:'+sociedad_profesional
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				num_inscripcion_sociedad=Trim(Mid(tupla,113,10))
				sin_campo='NUM INSCRIPCC. SOCIEDAD:'+num_inscripcion_sociedad
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				sociedadCIF=Trim(Mid(tupla,123,10))
				sin_campo='SOCIEDAD C.I.F:'+sociedadCIF
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				sigla=Trim(Mid(tupla,133,2))
				if(sigla='')then 
					campo_vacio+='SIGLA 06'
					sigla = 'SC'
				end if
				dw_1.setitem(1, 'tipo_via_emplazamiento', sigla)
				domicilio_AT=Trim(Mid(tupla,135,30))
				n_calle=''
				calle_plaza_paseo=Trim(Mid(tupla,165,5))
			if(calle_plaza_paseo <> '')then 
			n_calle=string(calle_plaza_paseo)
			end if
			piso=Trim(Mid(tupla,170,2))
			if(piso <> '')then 
			n_calle=string(n_calle+','+piso)
			end if
			puerta=Trim(Mid(tupla,172,2))
			if(puerta <> '')then 
			n_calle=string(n_calle+','+puerta)
			end if
				//n_calle=string(calle_plaza_paseo+','+piso+','+puerta)
				dw_1.setitem(1, 'n_calle', n_calle)
				if(Trim(Mid(tupla,174,1))='')then
					cp1=''
				else				
					cod_post[1]=Integer(Trim(Mid(tupla,174,1)))
					cp1=string(cod_post[1])
				end if
				if(Trim(Mid(tupla,175,1))='')then
					cp2=''
				else				
					cod_post[2]=Integer(Trim(Mid(tupla,175,1)))
					cp2=string(cod_post[2])
				end if
				if(Trim(Mid(tupla,176,1))='')then
					cp3=''
				else				
					cod_post[3]=Integer(Trim(Mid(tupla,176,1)))
					cp3=string(cod_post[3])
				end if
				if(Trim(Mid(tupla,177,1))='')then
					cp4=''
				else				
					cod_post[4]=Integer(Trim(Mid(tupla,177,1)))
					cp4=string(cod_post[4])
				end if
				if(Trim(Mid(tupla,178,1))='')then
					cp5=''
				else				
					cod_post[5]=Integer(Trim(Mid(tupla,178,1)))
					cp5=string(cod_post[5])
				end if
				
				if(cp1='')then 
					cont1+='0'
				else 
					cod_postal+=cp1
				end if
				
				if(cp2='')then 
					cont1+='0'
			   else 
					cod_postal+=cp2
				end if	
				
				if(cp3='')then 
					cont1+='0'
			   else 
					cod_postal+=cp3
				end if
				
				if(cp4='')then 
					cont1+='0'
			   else 
					cod_postal+=cp4
				end if
				
				if(cp5='')then 
					cont1+='0'
			   else 
					cod_postal+=cp5
				end if
				codigo_postal=cont1+cod_postal
				
							
				
				//codigo_postal=Trim(Mid(tupla,174,5))
				if(codigo_postal='')then campo_vacio+='C$$HEX1$$d300$$ENDHEX$$DIGO POSTAL 06'
				select count(*) into :num from poblaciones where cod_pos=:codigo_postal;
				if (num = 0)then municipio='00' 
			 	select cod_pob into :municipio from poblaciones where cod_pos=:codigo_postal;
				//dw_1.setitem(1, 'poblacion', codigo_postal)
				//dw_1.setitem(1, 'compute_2', municipio)
				provincia=Trim(Mid(tupla,204,20))
				sin_campo='PROVINCIA:'+provincia
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				libre=Trim(Mid(tupla,224,31))
				sin_campo='LIBRE 06:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				
end subroutine

public subroutine cod_siete (ref datawindow dw_1, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos);				int cien
				string aut, ls_id_arq, ls_fase_arquitecto, ls_id_fase, id_coleg
				cien=100
				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 07:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				string nc1,nc2,nc3,nc4,nc5,cont
				cont=''
				num_col=''
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				nombre_arq1=Trim(Mid(tupla,16,30))
				nombre_arq1=Upper(nombre_arq1)
				select id_arqui into :ls_id_arq from fases_arquitectos where nombre=:nombre_arq1 or apellidos=:nombre_arq1 ;
				select count(*) into :numero from fases_arquitectos where nombre=:nombre_arq1 or apellidos=:nombre_arq1 ;
				long ll_ret
				aut='S'
				ll_ret = dw_fases_arquitectos.insertrow(0)
				if numero > 0 then
					mensaje+='El Autor de la obra ya existe'+cr	
					dw_fases_arquitectos.setitem(ll_ret, 'id_arqui', ls_id_arq)					
				else
					mensaje+='El Autor de la obra no existe'+cr	
					
				end if	
				ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
				dw_fases_arquitectos.setitem(ll_ret,'id_fases_arquitectos',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))
				dw_fases_arquitectos.setitem(ll_ret, 'id_fase', ls_id_fase)
				dw_fases_arquitectos.setitem(ll_ret, 'apellidos', nombre_arq1)
				dw_fases_arquitectos.setitem(ll_ret, 'tipo_a', aut)
				posic=ll_ret
				
				sin_campo='NOMBRE:'+nombre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				titulo=Trim(Mid(tupla,46,20))
				sin_campo='T$$HEX1$$cd00$$ENDHEX$$TULO:'+titulo
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				nif=Trim(Mid(tupla,66,10))
				sin_campo='NIF:'+nif
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				colegio_prof=Trim(Mid(tupla,76,100))
				sin_campo='COLEGIO PROFESIONAL:'+colegio_prof
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				//num_colegiado=Trim(Mid(tupla,176,6))
				if(Trim(Mid(tupla,176,1))='')then
					nc1=''
				else				
					num_coleg[1]=Integer(Trim(Mid(tupla,176,1)))
					nc1=string(num_coleg[1])
				end if
				if(Trim(Mid(tupla,177,1))='')then
					nc2=''
				else				
					num_coleg[2]=Integer(Trim(Mid(tupla,177,1)))
					nc2=string(num_coleg[2])
				end if
				if(Trim(Mid(tupla,178,1))='')then
					nc3=''
				else				
					num_coleg[3]=Integer(Trim(Mid(tupla,178,1)))
					nc3=string(num_coleg[3])
				end if
				if(Trim(Mid(tupla,179,1))='')then
					nc4=''
				else				
					num_coleg[4]=Integer(Trim(Mid(tupla,179,1)))
					nc4=string(num_coleg[4])
				end if
				if(Trim(Mid(tupla,180,1))='')then
					nc5=''
				else				
					num_coleg[5]=Integer(Trim(Mid(tupla,180,1)))
					nc5=string(num_coleg[5])
				end if
				
				if(nc1='')then 
					cont+='0'
				else 
					num_col+=nc1
				end if
				
				if(nc2='')then 
					cont+='0'
			   else 
					num_col+=nc2
				end if	
				
				if(nc3='')then 
					cont+='0'
			   else 
					num_col+=nc3
				end if
				
				if(nc4='')then 
					cont+='0'
			   else 
					num_col+=nc4
				end if
				
				if(nc5='')then 
					cont+='0'
			   else 
					num_col+=nc5
				end if
				num_colegiado=cont+num_col
				if(num_colegiado = '00000')then
					num_colegiado=''
				end if
				select id_colegiado into :id_coleg from colegiados where n_colegiado=:num_colegiado;
				select tipo_gestion into :tipo_gestion from fases_colegiados where id_col =:id_coleg;
				select facturado into :facturado from fases_colegiados where id_col =:id_coleg;
				select renunciado into :renunciado from fases_colegiados where id_col =:id_coleg;
				select observa into :observa from fases_colegiados where id_col =:id_coleg;
				select otro_seguro into :otro_seguro from fases_colegiados where id_col =:id_coleg;
				select empresa into :empresa from fases_colegiados where id_col =:id_coleg;
				select porc_aut into :porc_aut from fases_colegiados where id_col =:id_coleg;
				select porcen_d into :porc_dir from fases_colegiados where id_col =:id_coleg;
				SELECT musaat.src_cober, musaat.src_coef_cm INTO :cobertura, :coef_cm FROM musaat WHERE musaat.id_col = :id_coleg;
				select count(*) into :numero from colegiados where n_colegiado=:num_colegiado;
//				ll_ret = dw_fases_colegiados.insertrow(0)
				if numero > 0 then
					ll_ret = dw_fases_colegiados.insertrow(0)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_a', 'N')
					dw_fases_colegiados.setitem(ll_ret, 'tipo_d', 'N')
					dw_fases_colegiados.setitem(ll_ret, 'id_col', id_coleg)
					
					dw_fases_colegiados.setitem(ll_ret, 'facturado', facturado)
					dw_fases_colegiados.setitem(ll_ret, 'renunciado', renunciado)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_gestion', tipo_gestion)
					dw_fases_colegiados.setitem(ll_ret, 'observaciones', observa)
					dw_fases_colegiados.setitem(ll_ret, 'cobertura', cobertura)
					dw_fases_colegiados.setitem(ll_ret, 'otro_seguro', otro_seguro)
					dw_fases_colegiados.setitem(ll_ret, 'coef_cm', coef_cm)
					dw_fases_colegiados.setitem(ll_ret, 'porc_aut', porc_aut)
					dw_fases_colegiados.setitem(ll_ret, 'porc_dir', porc_dir)
					
					ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
					dw_fases_colegiados.setitem(ll_ret,'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
					dw_fases_colegiados.setitem(ll_ret, 'id_fase', ls_id_fase)
					dw_fases_colegiados.setitem(ll_ret, 'n_col', num_colegiado)
					dw_fases_colegiados.setitem(ll_ret, 'porcen_a', cien)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_a', 'S')
								
				end if
				
				cometido_prof=Trim(Mid(tupla,182,20))
				sin_campo='COMETIDO PROFESIONAL:'+cometido_prof
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				libre=Trim(Mid(tupla,202,53))
				sin_campo='LIBRE 07:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
//				if(codigo_orden <> "") then autor="S"
//				dw_fases_colegiados.setitem(1, 'tipo_a', autor)
				
end subroutine

public subroutine cod_ocho (ref datawindow dw_1, ref datawindow dw_fases_colegiados, ref datawindow dw_fases_arquitectos);				string id_colegiado, direc, ls_id_arq, ls_id_fase, id_coleg
				string nc1,nc2,nc3,nc4,nc5,cont
				int cien
				long i
				cien=100
				cont=''
				num_col=''
				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 08:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				nombre_arq2=Trim(Mid(tupla,16,30))
				nombre_arq2=Upper(nombre_arq2)
				select id_arqui into :ls_id_arq from fases_arquitectos where nombre=:nombre_arq2 or apellidos=:nombre_arq2 ;
				select count(*) into :numero from fases_arquitectos where nombre=:nombre_arq2 or apellidos=:nombre_arq2 ;
				long ll_ret
				direc='S'
				if(nombre_arq1 <> nombre_arq2)then
				ll_ret = dw_fases_arquitectos.insertrow(0)
				if numero > 0 then
					mensaje+='El Director de la obra ya existe'+cr	
					dw_fases_arquitectos.setitem(ll_ret, 'id_arqui', ls_id_arq)					
				else
					mensaje+='El Director de la obra no existe'+cr	
					
				end if	
				ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
				dw_fases_arquitectos.setitem(ll_ret,'id_fases_arquitectos',f_siguiente_numero('ID_FASES_ARQUITECTOS',10))
				dw_fases_arquitectos.setitem(ll_ret, 'id_fase', ls_id_fase)
				dw_fases_arquitectos.setitem(ll_ret, 'apellidos', nombre_arq2)
				dw_fases_arquitectos.setitem(ll_ret, 'tipo_d', direc)
				else
					dw_fases_arquitectos.setitem(posic, 'tipo_d', direc)
				end if
				
				sin_campo='NOMBRE:'+nombre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				titulo=Trim(Mid(tupla,46,20))
				sin_campo='T$$HEX1$$cd00$$ENDHEX$$TULO:'+titulo
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				nif=Trim(Mid(tupla,66,10))
				sin_campo='NIF:'+nif
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				colegio_prof=Trim(Mid(tupla,76,100))
				sin_campo='COLEGIO PROFESIONAL:'+colegio_prof
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				//num_colegiado=Trim(Mid(tupla,176,6))
				if(Trim(Mid(tupla,176,1))='')then
					nc1=''
				else				
					num_coleg[1]=Integer(Trim(Mid(tupla,176,1)))
					nc1=string(num_coleg[1])
				end if
				if(Trim(Mid(tupla,177,1))='')then
					nc2=''
				else				
					num_coleg[2]=Integer(Trim(Mid(tupla,177,1)))
					nc2=string(num_coleg[2])
				end if
				if(Trim(Mid(tupla,178,1))='')then
					nc3=''
				else				
					num_coleg[3]=Integer(Trim(Mid(tupla,178,1)))
					nc3=string(num_coleg[3])
				end if
				if(Trim(Mid(tupla,179,1))='')then
					nc4=''
				else				
					num_coleg[4]=Integer(Trim(Mid(tupla,179,1)))
					nc4=string(num_coleg[4])
				end if
				if(Trim(Mid(tupla,180,1))='')then
					nc5=''
				else				
					num_coleg[5]=Integer(Trim(Mid(tupla,180,1)))
					nc5=string(num_coleg[5])
				end if
				
				if(nc1='')then 
					cont+='0'
				else 
					num_col+=nc1
				end if
				
				if(nc2='')then 
					cont+='0'
			   else 
					num_col+=nc2
				end if	
				
				if(nc3='')then 
					cont+='0'
			   else 
					num_col+=nc3
				end if
				
				if(nc4='')then 
					cont+='0'
			   else 
					num_col+=nc4
				end if
				
				if(nc5='')then 
					cont+='0'
			   else 
					num_col+=nc5
				end if
				num_colegiado=cont+num_col
				if(num_colegiado = '00000')then
					num_colegiado=''
				end if
				select id_colegiado into :id_coleg from colegiados where n_colegiado=:num_colegiado;
				select tipo_gestion into :tipo_gestion from fases_colegiados where id_col =:id_coleg;
				select facturado into :facturado from fases_colegiados where id_col =:id_coleg;
				select renunciado into :renunciado from fases_colegiados where id_col =:id_coleg;
				select observa into :observa from fases_colegiados where id_col =:id_coleg;
				select otro_seguro into :otro_seguro from fases_colegiados where id_col =:id_coleg;
				select empresa into :empresa from fases_colegiados where id_col =:id_coleg;
				select porc_aut into :porc_aut from fases_colegiados where id_col =:id_coleg;
				select porcen_d into :porc_dir from fases_colegiados where id_col =:id_coleg;
				SELECT musaat.src_cober, musaat.src_coef_cm INTO :cobertura, :coef_cm FROM musaat WHERE musaat.id_col = :id_coleg;
				select count(*) into :numero from colegiados where n_colegiado=:num_colegiado;
//				ll_ret = dw_fases_colegiados.insertrow(0)
				if numero > 0 then
					ll_ret = dw_fases_colegiados.insertrow(0)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_a', 'N')
					dw_fases_colegiados.setitem(ll_ret, 'tipo_d', 'N')
					dw_fases_colegiados.setitem(ll_ret, 'id_col', id_coleg)
					
					dw_fases_colegiados.setitem(ll_ret, 'facturado', facturado)
					dw_fases_colegiados.setitem(ll_ret, 'renunciado', renunciado)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_gestion', tipo_gestion)
					dw_fases_colegiados.setitem(ll_ret, 'observaciones', observa)
					dw_fases_colegiados.setitem(ll_ret, 'cobertura', cobertura)
					dw_fases_colegiados.setitem(ll_ret, 'otro_seguro', otro_seguro)
					dw_fases_colegiados.setitem(ll_ret, 'coef_cm', coef_cm)
					dw_fases_colegiados.setitem(ll_ret, 'porc_aut', porc_aut)
					dw_fases_colegiados.setitem(ll_ret, 'porc_dir', porc_dir)
					
					ls_id_fase = dw_1.getitemstring(dw_1.getrow(),'id_fase')
					dw_fases_colegiados.setitem(ll_ret,'id_fases_colegiados',f_siguiente_numero('ID_FASES_COLEGIADOS',10))
					dw_fases_colegiados.setitem(ll_ret, 'id_fase', ls_id_fase)
					dw_fases_colegiados.setitem(ll_ret, 'n_col', num_colegiado)
					dw_fases_colegiados.setitem(ll_ret, 'porcen_a', cien)
					dw_fases_colegiados.setitem(ll_ret, 'tipo_d', 'S')
				else
					
				end if
				
				cometido_prof=Trim(Mid(tupla,182,20))
				sin_campo='COMETIDO PROFESIONAL:'+cometido_prof
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				libre=Trim(Mid(tupla,202,53))
				sin_campo='LIBRE 08:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
//				if(codigo_orden <> "") then director="S"
//				dw_fases_colegiados.setitem(1, 'tipo_d', director)
end subroutine

public function integer abrir_dvt ();value = GetFileOpenName("Selecione Fichero", &
		+ docname, named, "TXT,XLS" , &
		+ "Dvt Files (*.DVT),*.DVT")
		
extension = Right(named,3)
return value
end function

public subroutine cod_dos (ref datawindow dw_1, ref datawindow dw_fases_estadistica);				int num
				string cp1,cp2,cp3,cp4,cp5,cont1
				cont1=''
				cod_postal=''				
				sin_campo='C$$HEX1$$f300$$ENDHEX$$digo de dato 02:'
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',sin_campo)
				blanco=''
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				codigo_solic=Trim(Mid(tupla,1,9))
				codigo_dato=Trim(Mid(tupla,10,2))
				codigo_regist=Trim(Mid(tupla,12,2))
				codigo_orden=Trim(Mid(tupla,14,2))
				emplazamiento=Trim(Mid(tupla,16,30))
				emplazamiento=Upper(emplazamiento)
				dw_1.setitem(1, 'emplazamiento', emplazamiento)
				calle_plaza_paseo=Trim(Mid(tupla,46,5))
				piso=Trim(Mid(tupla,140,2))
				puerta=Trim(Mid(tupla,142,2))
				n_calle=string(calle_plaza_paseo+','+piso+','+puerta)
				dw_1.setitem(1, 'n_calle', n_calle)
				if(Trim(Mid(tupla,51,1))='')then
					cp1=''
				else				
					cod_post[1]=Integer(Trim(Mid(tupla,51,1)))
					cp1=string(cod_post[1])
				end if
				if(Trim(Mid(tupla,52,1))='')then
					cp2=''
				else				
					cod_post[2]=Integer(Trim(Mid(tupla,52,1)))
					cp2=string(cod_post[2])
				end if
				if(Trim(Mid(tupla,53,1))='')then
					cp3=''
				else				
					cod_post[3]=Integer(Trim(Mid(tupla,53,1)))
					cp3=string(cod_post[3])
				end if
				if(Trim(Mid(tupla,54,1))='')then
					cp4=''
				else				
					cod_post[4]=Integer(Trim(Mid(tupla,54,1)))
					cp4=string(cod_post[4])
				end if
				if(Trim(Mid(tupla,55,1))='')then
					cp5=''
				else				
					cod_post[5]=Integer(Trim(Mid(tupla,55,1)))
					cp5=string(cod_post[5])
				end if
				
				if(cp1='')then 
					cont1+='0'
				else 
					cod_postal+=cp1
				end if
				
				if(cp2='')then 
					cont1+='0'
			   else 
					cod_postal+=cp2
				end if	
				
				if(cp3='')then 
					cont1+='0'
			   else 
					cod_postal+=cp3
				end if
				
				if(cp4='')then 
					cont1+='0'
			   else 
					cod_postal+=cp4
				end if
				
				if(cp5='')then 
					cont1+='0'
			   else 
					cod_postal+=cp5
				end if
				codigo_postal=cont1+cod_postal
				
				municipio_con=Trim(Mid(tupla,56,30))
				municipio_con=Upper(municipio_con)
				select count(*) into :num from poblaciones where cod_pos=:codigo_postal;
				//if (num = 0)then municipio='00' 
			 	select cod_pob into :municipio from poblaciones where cod_pos=:codigo_postal and descripcion=:municipio_con;
				//dw_1.setitem(1, 'poblacion', codigo_postal)
				dw_1.setitem(1, 'poblacion', municipio)
				provincia=Trim(Mid(tupla,86,20))
				sin_campo='PROVINCIA:'+provincia
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				codigo_municipio=Trim(Mid(tupla,106,4))
				sin_campo='C$$HEX1$$d300$$ENDHEX$$DIGO DE MUNICIPIO:'+codigo_municipio
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				presupuesto=double(Trim(Mid(tupla,110,14)))
				presupuesto=presupuesto/100
				dw_fases_estadistica.setitem(1, 'pem', presupuesto)
				moneda=Trim(Mid(tupla,124,5))
				sin_campo='MONEDA:'+moneda
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				volumen=double(Trim(Mid(tupla,129,9)))
				dw_fases_estadistica.setitem(1, 'volumen', volumen)
				sigla=Trim(Mid(tupla,138,2))
				if sigla='' then
					sigla = 'SC'
				end if
				dw_1.setitem(1, 'tipo_via_emplazamiento', sigla)	
				libre=Trim(Mid(tupla,144,111))
				sin_campo='LIBRE 02:'+libre
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'linea',sin_campo)
				ll_fila=ids_vacio.insertrow(0)
				ids_vacio.setitem(ll_fila,'codigo_dato',blanco)
				
				
end subroutine

on n_csd_netfocus.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_netfocus.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_vacio = create Datastore
ids_vacio.dataobject = "d_csd_netfocus2" 
ids_vacio.SetTransObject(SQLCA)
end event

