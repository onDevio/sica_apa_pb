HA$PBExportHeader$n_coaattg_calculo_dip.sru
forward
global type n_coaattg_calculo_dip from nonvisualobject
end type
end forward

global type n_coaattg_calculo_dip from nonvisualobject
event csd_calcular_dip ( )
end type
global n_coaattg_calculo_dip n_coaattg_calculo_dip

type variables
// Parametros de Entrada
string i_tipo_intervencion,i_tipo_obra,i_destino_i
string i_tipo_reforma
double i_volumen,i_presupuesto,i_sup_viviendas,i_sup_otros, i_num_viv, i_sup_lim, i_sup_otros_lim
double i_porcentaje=100
string i_funcionario
string i_admon

// Parametros de Salida
double dip,dip_min,dip_total
string formula
string formula_sustituida

//
private double i_precio_m2,i_coef_re,i_coef_ti,i_coef_to,i_minimo,i_maximo
private double i_coef_K,i_coef_Ku,i_DIM,i_superficie,i_ca
private string form
end variables

forward prototypes
public subroutine of_obtener_precio_m2 ()
public subroutine of_obtener_coef_re ()
public subroutine of_obtener_ti ()
public subroutine of_obtener_to ()
public subroutine of_calcular_dip ()
public subroutine of_obtener_coef_urb ()
public subroutine of_obtener_precio_m3_derribo ()
public subroutine of_calcular_dip_instalaciones ()
public subroutine of_obtener_ca ()
end prototypes

public subroutine of_obtener_precio_m2 ();double sup_temp

if isnull(i_num_viv) then i_num_viv = 0 
if i_num_viv = 0 then
	//	i_num_viv =1
	sup_temp=0
else
	sup_temp = i_sup_viviendas / i_num_viv
end if
//sup_temp = i_superficie / i_num_viv
select valor into :i_precio_m2 from coaattg_pm2 where destino=:i_destino_i and rango_inf<:sup_temp and rango_sup>=:sup_temp;

end subroutine

public subroutine of_obtener_coef_re ();double valor, rango_sup, valor_limite
long caso_lim
select count(*) into :caso_lim from coaattg_re where 
rango_sup<=:i_superficie and limite>=:i_superficie;

if caso_lim>0 then
	select rango_sup,valor_limite into :rango_sup,:valor from coaattg_re where rango_inf<:i_superficie and limite>=:i_superficie;
	
	i_sup_lim = f_redondea(i_sup_viviendas / i_superficie * rango_sup )
	i_sup_otros_lim = f_redondea(i_sup_otros / i_superficie * rango_sup )
	
//	i_superficie=rango_sup
	i_coef_re=valor
else
	select valor into :valor from coaattg_re where rango_inf<:i_superficie and rango_sup>=:i_superficie;
	i_coef_re=valor
end if

end subroutine

public subroutine of_obtener_ti ();double sup_total

select coef_ti,minimo,maximo into :i_coef_ti,:i_minimo,:i_maximo from coaattg_ti where t_fase=:i_tipo_intervencion;

/*if i_tipo_intervencion='41' or i_tipo_intervencion = '42' then
	sup_total = i_sup_otros + i_sup_viviendas
	select valor into :i_coef_K from coaattg_K where rango_inf<:sup_total and rango_sup>=:sup_total;
	i_minimo=max(sup_total*i_coef_K, i_minimo)
end if
*/
if i_tipo_intervencion='76' then i_minimo=i_minimo*i_num_viv

end subroutine

public subroutine of_obtener_to ();string tipo

if isnull(i_tipo_obra) then i_tipo_obra = ''

tipo = left(i_tipo_obra, 1)

if tipo = '1' or tipo = '2' or tipo = '6' then i_tipo_reforma = "0"

if (tipo = '3' or tipo = '4' or tipo = '5') and f_es_vacio(i_tipo_reforma) then messagebox(g_titulo, "Manca el tipus de reforma")

select valor into :i_coef_to from coaattg_to where tipo_obra=:i_tipo_obra and tipo_reforma=:i_tipo_reforma;

end subroutine

public subroutine of_calcular_dip ();i_superficie=i_sup_otros+i_sup_viviendas
of_obtener_ti()
of_obtener_CA()


if i_tipo_intervencion='41' or i_tipo_intervencion='42' then
	select valor into :i_coef_K from coaattg_K where rango_inf<:i_superficie and rango_sup>=:i_superficie;
	dip=i_superficie*i_coef_K
	dip_min = 0
	
else
	choose case i_tipo_obra
		case '71','72','73','74','75','76', '81', '82', '84' 	// URBANIZACION
			of_obtener_coef_urb()
			formula='max(P*Ku*Ti, DIM*Ti)'
			formula_sustituida='max('+string(i_presupuesto)+' x '+string(i_coef_Ku)+' x '+string(i_coef_Ti)+", "+string(i_DIM)+" x "+string(i_coef_ti)+")"
			
			dip=i_presupuesto*i_coef_Ku*i_coef_Ti
			dip_min= i_DIM*i_coef_Ti
	
		case '83' //'81','82','83','84'     					// INSTALACIONES
			of_calcular_dip_instalaciones()
			formula="dip"
			formula_sustituida=string(dip)
			dip_min= 0
			
		case '91','92','93'						// DERRIBOS
			of_obtener_precio_m3_derribo()
			formula='V*preu/m3*Ti'
			formula_sustituida=string(i_volumen)+' x '+string(i_precio_m2)+' x '+string(i_coef_Ti)
			
			dip=i_volumen*i_precio_m2*i_coef_Ti
			dip_min= 0
	
		case else									// EDIFICACION
			of_obtener_precio_m2()
			of_obtener_coef_re()		
			of_obtener_ti()
			of_obtener_to()		
			
			// Si el coeficiente Ti es 0, es porque pertenece a "otros trabajos" y solo tiene minimo
			if i_coef_Ti<>0 then
				// En viviendas unifamiliares (destino interno: 11, 15 y 16) si la superfice de garajes y otros supera el 30 % de la superficie total se aplica el coef. 0.6
				choose case i_destino_i
					case '12','13','14', '11'
						if i_superficie <> 0 then
							if i_sup_otros / i_superficie > 0.3 then
								dip=(i_sup_viviendas*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To)+(i_sup_otros*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To*0.6)
								formula='((Sup.Viviendas*preu/m2*Re*Ti*To) + (Sup.Otros*preu/m2*Re*Ti*To*0.6))'
								formula_sustituida=string(i_sup_viviendas)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)+ &
													 ' + '+string(i_sup_otros)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To) + ' x 0.6'
							else
								if i_sup_lim > 0 then i_superficie = i_sup_lim
								dip=(i_superficie*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To)
								formula='Sup.Viviendas*preu/m2*Re*Ti*To'
								formula_sustituida= string(i_superficie)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)						
							end if
						end if
					case '15','16'
						dip=(i_sup_viviendas*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To)+(i_sup_otros*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To*0.6)
						formula='((Sup.Viviendas*preu/m2*Re*Ti*To) + (Sup.Otros*preu/m2*Re*Ti*To*0.6))'
						formula_sustituida=string(i_sup_viviendas)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)+ &
											 ' + '+string(i_sup_otros)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To) + ' x 0.6'
					case else
						dip=(i_sup_viviendas*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To)+(i_sup_otros*i_precio_m2*i_coef_Re*i_coef_Ti*i_coef_To)
						formula='((Sup.Viviendas*preu/m2*Re*Ti*To) + (Sup.Otros*preu/m2*Re*Ti*To))'
						formula_sustituida=string(i_sup_viviendas)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)+ &
											 ' + '+string(i_sup_otros)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)
				end choose
	//			if i_sup_otros=0 then
	//				if dip > i_minimo then
	////					formula='Sup.Viviendas*preu/m2*Re*Ti*To'
	////					formula_sustituida= string(i_sup_viviendas)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)
	//				else 
	//					formula = 'minimo'
	//					formula_sustituida = 'Aplica m$$HEX1$$ed00$$ENDHEX$$nimo= ' + string(i_minimo)
	//				end if
	//			else
	//				if dip > i_minimo then
	//					formula='Sup.Viviendas*preu/m2*Re*Ti*To + Sup.Otros*preu/m2*Re*Ti*To'
	//					formula_sustituida=string(i_sup_viviendas)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To)+ &
	//											 ' + '+string(i_sup_otros)+' x '+string(i_precio_m2)+' x '+string(i_coef_Re)+' x '+string(i_coef_Ti)+' x '+string(i_coef_To) + form
	//				else 
	//					formula = 'minimo'
	//					formula_sustituida =  'Aplica m$$HEX1$$ed00$$ENDHEX$$nimo= ' + string(i_minimo)
	//				end if
	//			end if
				if dip < i_minimo then
					formula = 'M$$HEX1$$ed00$$ENDHEX$$nim'
					formula_sustituida = string(i_minimo)
				end if	
			else
				formula = 'M$$HEX1$$ed00$$ENDHEX$$nim'
				formula_sustituida = string(i_minimo)
				dip=i_minimo
			end if
	
			dip_min= i_minimo
	
	end choose
end if


dip=dip*i_porcentaje/100

// SI es funcionario y la obra es de administraci$$HEX1$$f300$$ENDHEX$$n se aplica el minimo
// Inc. CGN. 344
if i_funcionario='S' and i_admon='S' then  
	dip=i_minimo
end if

if dip <= i_minimo then
	formula = 'M$$HEX1$$ed00$$ENDHEX$$nim'
	formula_sustituida = string(i_minimo)
	dip_min= i_minimo
	
	dip_total=max(dip, dip_min)
ELSE
	dip_total=max(dip, dip_min)

	// En 2008 se aplica un 10%, excepto a las c$$HEX1$$e900$$ENDHEX$$dulas (tipo_int=76) y los derribos (tipo_obra=9x)
	// En 2009 se modifica ya no es un 10%, lo hacemos por variable global para poder modificarlo por BD
	// En 2010 se modifica dependiendo de la superficie para ciertos tipos de intervenci$$HEX1$$f300$$ENDHEX$$n
	if dip_total = dip then // Si se aplica el m$$HEX1$$ed00$$ENDHEX$$nimo no se vuelve a multiplicar el coeficiente
		if i_tipo_intervencion <> "76" and left(i_tipo_obra,1)<>'9' then 
			dip_total = f_redondea(dip_total * i_ca ) //1.1)
			formula += '* ' + string (i_ca) //1.1'
			formula_sustituida += ' x ' + string (i_ca) //1.1'
		end if
	end if
	
	if i_maximo<>0 and dip_total>i_maximo then
		dip_total= i_maximo
		formula = 'M$$HEX1$$e000$$ENDHEX$$xim'
		formula_sustituida = string(i_maximo)
	end if
	
end if	

end subroutine

public subroutine of_obtener_coef_urb ();select ku,dim into :i_coef_Ku,:i_dim from coaattg_coef_urb where pres_desde<:i_presupuesto and pres_hasta>=:i_presupuesto;
end subroutine

public subroutine of_obtener_precio_m3_derribo ();if i_tipo_obra = '91' then
	select valor into :i_precio_m2 from coaattg_derribos 
	where tipo_obra=:i_tipo_obra and destino=:i_destino_i and volumen_inf<:i_volumen and volumen_sup>=:i_volumen;
	if IsNull(i_precio_m2) or i_precio_m2=0 then
		select valor into :i_precio_m2 from coaattg_derribos 
		where tipo_obra=:i_tipo_obra and destino='%' and volumen_inf<:i_volumen and volumen_sup>=:i_volumen;
	end if
		
else
	select valor into :i_precio_m2 from coaattg_derribos 
	where tipo_obra=:i_tipo_obra and volumen_inf<:i_volumen and volumen_sup>=:i_volumen;
end if
end subroutine

public subroutine of_calcular_dip_instalaciones ();select valor into :dip from coaattg_instalaciones where  tipo_obra=:i_tipo_obra and rango_inf<=:i_superficie and rango_sup>=:i_superficie;
end subroutine

public subroutine of_obtener_ca ();// A partir del 2010 el CA se calcula en funci$$HEX1$$f300$$ENDHEX$$n de la superficie para ciertos tipos de intervenci$$HEX1$$f300$$ENDHEX$$n.

double superficie

superficie= i_sup_viviendas+i_sup_otros


choose case i_tipo_intervencion
	case '01','02','11','12','13','14','15','16','17','31','32','33'
		if superficie<=600 then
			i_ca=round(g_cc * 1.22,2)
		else
			i_ca=round(g_cc * 1.12,2)
		end if
	case else
		i_ca = g_cc
end choose
end subroutine

on n_coaattg_calculo_dip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_coaattg_calculo_dip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

