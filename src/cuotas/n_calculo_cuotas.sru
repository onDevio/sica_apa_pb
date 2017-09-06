HA$PBExportHeader$n_calculo_cuotas.sru
forward
global type n_calculo_cuotas from n_calculo_formulas
end type
end forward

global type n_calculo_cuotas from n_calculo_formulas
end type
global n_calculo_cuotas n_calculo_cuotas

type variables
u_dw idw_fases_usos_formulas
u_dw idw_fases_detalle
//w_fases_detalle iw_fases_detalle

constant string VARIABLE_CUOTA = "Cv"
constant string VARIABLE_FASE = "Fase"
constant string VARIABLE_FASE_MIN = "Fase"
constant string VARIABLE_SUPERFICIE = "S"
constant string VARIABLE_PEM = "Pr"
constant string VARIABLE_Z = "Z"
constant string VARIABLE_PROY_EJEC = "proy_ejec"
constant string VARIABLE_PR_EDIF = "Pr_Edif"
constant string VARIABLE_PR_PISC = "Pr_Pisc"
constant string VARIABLE_PR_DERR = "Pr_Derr"
constant string VARIABLE_PR_VAR = "Pr_Var"
constant string VARIABLE_VOL_DERR = "Vol_Derr"
constant string VARIABLE_TIPO_FASE = "tipo_fase"
constant string VARIABLE_TRABAJO = "trabajo"
constant string VARIABLE_FECHAEJ = "FechaEj"
constant string VARIABLE_CV_USOS = "cv_usos"
constant string VARIABLE_PEM_REAL = "P_real"

constant string ID_FORMULA_CUOTA_MANUAL = "CUOTAMAN"

// Almeria
constant string TRABAJO_PISCINA = "OA1"
constant string TRABAJO_DERRIBO = "OA2"
constant string TRABAJO_INFR_ANEXA = "OA3"
constant string TRABAJO_OTROS_ANEXOS = "OA4"

// Malaga
constant string PREFIJO_VARIABLE_CBASE = "cbase_"
constant string PREFIJO_VARIABLE_CUOTA = "cuota_"
constant string PREFIJO_VARIABLE_REFORMA = "reforma_"

// C$$HEX1$$f300$$ENDHEX$$rdoba
constant string PREFIJO_VARIABLE_SUMACUOTA = "Sumacuota"

end variables

forward prototypes
public subroutine f_inicializar ()
public function boolean f_mostrar_ventana (ref any resultado)
public subroutine f_recargar_formula ()
public function boolean f_mostrar_ventana (ref any resultado, ref double honorarios, ref double derechos)
public function any f_calcular_resultado (ref double honorarios, ref double derechos)
public function any f_valor_variable_auto_proceso (string variable)
end prototypes

public subroutine f_inicializar ();super::f_inicializar()

i_ambito = "CU" // Cuotas
i_id_ambito = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'id_fase')

i_titulo_ventana = "C$$HEX1$$e100$$ENDHEX$$lculo Cuota Variable"

f_cargar_variables()
f_recargar_formula()

end subroutine

public function boolean f_mostrar_ventana (ref any resultado);i_aceptada_ventana = false

// Como esta PBL es la misma en SICA que en VISARED, si estamos en VISARED mostramos una ventana con el aspecto de las de VISARED
if g_titulo = "Front-end de Visado" then
	openwithparm(w_calculo_formulas_visared, this)
else
	openwithparm(w_calculo_formulas, this)
end if

if i_aceptada_ventana then
	resultado = f_get_valor_variable(i_variable_resultado)
	return true
else
	return false
end if

end function

public subroutine f_recargar_formula ();string tipo_trabajo, trabajo
string id_formula
long fila_var

f_establecer_variable_resultado(VARIABLE_CUOTA)

// En entre SICA y Visared los nombres de los campos son distintos
if idw_fases_detalle.describe("tipo_trabajo.ColType") <> "!" then
	tipo_trabajo = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'tipo_trabajo')
	trabajo = idw_fases_detalle.getItemString(idw_fases_detalle.getrow(),'trabajo')
else
	tipo_trabajo = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'tipo_obra')
	trabajo = idw_fases_detalle.getItemString(idw_fases_detalle.getrow(),'destino')
end if

// La ordenaci$$HEX1$$f300$$ENDHEX$$n por colegio descendente hace que se devuelvan antes las filas que tengan un c$$HEX1$$f300$$ENDHEX$$digo de colegio que las que no
SELECT trabajos_formulas.formula INTO :id_formula
	FROM trabajos_formulas
	WHERE trabajos_formulas.tipo_trabajo = :tipo_trabajo AND
			trabajos_formulas.trabajo = :trabajo AND
			(trabajos_formulas.colegio = :i_colegio or trabajos_formulas.colegio = '' or trabajos_formulas.colegio is null) order by trabajos_formulas.colegio desc ;

if f_es_vacio(id_formula) then
	id_formula = ID_FORMULA_CUOTA_MANUAL
end if

fila_var = f_fila_variable(VARIABLE_CUOTA)
ds_variables.setitem(fila_var, 'id_formula', id_formula)

end subroutine

public function boolean f_mostrar_ventana (ref any resultado, ref double honorarios, ref double derechos);long i
string cod_var

if not f_mostrar_ventana(resultado) then return false

setnull(honorarios)
for i = 1 to ds_variables.rowcount()
	if LeftA(ds_variables.getitemstring(i, 'descripcion_coeficiente'), 5) = "Honor" then
		cod_var = ds_variables.getitemstring(i, 'codigo')
		honorarios = f_get_valor_variable(cod_var)
		exit
	end if
next

for i = 1 to ds_variables.rowcount()
	if LeftA(ds_variables.getitemstring(i, 'descripcion_coeficiente'), 5) = "Derec" then
		cod_var = ds_variables.getitemstring(i, 'codigo')
		derechos = f_get_valor_variable(cod_var)
		exit
	end if
next

return true
end function

public function any f_calcular_resultado (ref double honorarios, ref double derechos);long i
string cod_var
any result

result = f_calcular_resultado()

// Se asume que los honorarios estar$$HEX1$$e100$$ENDHEX$$n en el primer coeficiente cuyo nombre comience por "Honor"
// por lo que los nombres de los coeficientes debe ser tal que al ordenarlos por nombre quedar$$HEX2$$e1002000$$ENDHEX$$la
// f$$HEX1$$f300$$ENDHEX$$rmula de Honorarios delante de la de Honorarios M$$HEX1$$ed00$$ENDHEX$$nimos
for i = 1 to ds_variables.rowcount()
	if LeftA(ds_variables.getitemstring(i, 'descripcion_coeficiente'), 5) = "Honor" then
		cod_var = ds_variables.getitemstring(i, 'codigo')
		honorarios = f_get_valor_variable(cod_var)
		exit
	end if
next

// Se asume que los derechos de registro y visado estar$$HEX1$$e100$$ENDHEX$$n en el primer coeficiente cuyo nombre comience por "Derec"
for i = 1 to ds_variables.rowcount()
	if LeftA(ds_variables.getitemstring(i, 'descripcion_coeficiente'), 5) = "Derec" then
		cod_var = ds_variables.getitemstring(i, 'codigo')
		derechos = f_get_valor_variable(cod_var)
		exit
	end if
next


return result
end function

public function any f_valor_variable_auto_proceso (string variable);//
//choose case variable			
//	case VARIABLE_FASE,VARIABLE_FASE_MIN
//		
//		string fase, c_t_trabajo, c_trabajo
//		double porcentaje
//		
//		// En entre SICA y Visared los nombres de los campos son distintos
//		if idw_fases_detalle.describe("fase.ColType") <> "!" then
//			fase = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'fase')
//			c_t_trabajo = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'tipo_trabajo')
//			c_trabajo = idw_fases_detalle.getItemString(idw_fases_detalle.getrow(),'trabajo')
//		else
//			fase = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'tipo_actuacion')
//			c_t_trabajo = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'tipo_obra')
//			c_trabajo = idw_fases_detalle.getItemString(idw_fases_detalle.getrow(),'destino')
//		end if
//
//		//select t_fase into :porcentaje from t_fases where c_t_fase=:fase;
//		
//		//setnull(porcentaje)
//		porcentaje = 100
//		
//		  /*SELECT t_fases_porcentaje.porcentaje  
//			 INTO :porcentaje  
//			 FROM t_fases_porcentaje  
//			WHERE ( t_fases_porcentaje.c_t_trabajo = :c_t_trabajo ) AND  
//					(( t_fases_porcentaje.c_trabajo = :c_trabajo ) or ( t_fases_porcentaje.c_trabajo is null ) or ( t_fases_porcentaje.c_trabajo = '' )) AND  
//					( t_fases_porcentaje.c_t_fase = :fase ) AND (colegio = :i_colegio or colegio = '' or colegio is null) order by colegio desc ;*/
//		  SELECT t_fases_porcentaje.porcentaje  
//			 INTO :porcentaje  
//			 FROM t_fases_porcentaje  
//			WHERE (( t_fases_porcentaje.c_t_trabajo = :c_t_trabajo ) or ( t_fases_porcentaje.c_t_trabajo is null ) or ( t_fases_porcentaje.c_t_trabajo = '' )) AND
//					(( t_fases_porcentaje.c_trabajo = :c_trabajo ) or ( t_fases_porcentaje.c_trabajo is null ) or ( t_fases_porcentaje.c_trabajo = '' )) AND  
//					( t_fases_porcentaje.c_t_fase = :fase ) AND (colegio = :i_colegio or colegio = '' or colegio is null) order by colegio desc ;
//					
//		return porcentaje
//
//		
//	case VARIABLE_SUPERFICIE
//		if idw_fases_usos_formulas.rowcount() > 0 then
//			return idw_fases_usos_formulas.GetItemNumber(idw_fases_usos_formulas.RowCount(),'suma_superficie')
//		else
//			return 0
//		end if		
//
//
//	case VARIABLE_PEM_REAL
//		if idw_fases_usos_formulas.rowcount() > 0 then
//			return idw_fases_usos_formulas.GetItemNumber(idw_fases_usos_formulas.RowCount(),'suma_base_real')
//		else
//			return 0
//		end if	
//
//	case VARIABLE_PEM
//		if idw_fases_usos_formulas.rowcount() > 0 then
//			return idw_fases_usos_formulas.getitemnumber(idw_fases_usos_formulas.rowcount(),'pem')
//		else
//			return 0
//		end if
//		
//	case VARIABLE_Z
//		
//		string poblacion
//		double Fl
//		
//		// En entre SICA y Visared los nombres de los campos son distintos
//		if idw_fases_detalle.describe("id_pob.ColType") <> "!" then
//			poblacion = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'id_pob') // Visared
//		else
//			poblacion = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'poblacion') // SICA
//		end if
//		
//		setnull(Fl)
//		
//		// Solo funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
//		SELECT cantidad INTO :Fl FROM poblaciones, modulo_poblaciones WHERE poblaciones.modulo = modulo_poblaciones.modulo and poblaciones.cod_pob = :poblacion;
//		
//		if isnull(Fl) then
//			// Solo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED
//			SELECT cantidad INTO :Fl FROM poblaciones, modulo_poblaciones WHERE poblaciones.modulo = modulo_poblaciones.modulo and poblaciones.id_pob = :poblacion;
//		end if
//		
//		return Fl
//		
//	case VARIABLE_PROY_EJEC
//		
//		string id_expedi
//		double cv_ejec
//		
//		id_expedi = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'id_expedi')
//		
//		setnull(cv_ejec)
//		
//		fase = ''
//		
//		// Solo funcionar$$HEX2$$e1002000$$ENDHEX$$en SICA
//		SELECT texto INTO :fase FROM var_globales WHERE nombre = 'fase_proyecto_ejecucion' ;
//		
//		if f_es_vacio(fase) then
//			// Solo funcionar$$HEX2$$e1002000$$ENDHEX$$en VISARED
//			SELECT texto INTO :fase FROM coeficientes_calculo_gastos WHERE nombre = 'fase_proyecto_ejecucion' and colegio = :i_colegio;
//		
//			if f_es_vacio(fase) then
//				messagebox(g_titulo, "Falta la variable global fase_proyecto_ejecucion con el c$$HEX1$$f300$$ENDHEX$$digo de la fase del Proyecto de Ejecuci$$HEX1$$f300$$ENDHEX$$n.")
//				return cv_ejec
//			end if
//		end if
//		
//		SELECT fases_informes.cuantia_colegiado
//		INTO :cv_ejec
//		FROM fases, fases_informes
//		WHERE fases.id_fase = fases_informes.id_fase AND
//			fases.fase = :fase AND
//			fases.id_expedi = :id_expedi AND
//			fases_informes.tipo_informe = 'CV' ;
//			
//		return cv_ejec
//	
//	// TODO
//	/*case VARIABLE_AMPLIACION
//	
//		c_trabajo = idw_fases_detalle.getItemString(1,'trabajo')
//		if c_trabajo = TRABAJO_AMPLIACION then
//
//			id_expedi = idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'id_expedi')
//			fase = FASE_PROY_EJECUCION;
//			cv_ejec = 0
//			id_fase = ''
//			SELECT fases_informes.cuantia_colegiado, fases.id_fase
//			INTO :cv_ejec, :id_fase
//			FROM fases, fases_informes
//			WHERE fases.id_fase = fases_informes.id_fase AND
//				fases.fase = :fase AND
//				fases.id_expedi = :id_expedi AND
//				fases_informes.tipo_informe = 'CV' ;
//			
//
//			// TODO: Tendr$$HEX1$$ed00$$ENDHEX$$a que ser u_dw
//			n_ds ds_fases_detalle
//			ds_fases_detalle = create n_ds
//			ds_fases_detalle.dataobject = 'fases_detalle'
//			ds_fases_detalle.of_settransobject(SQLCA)
//			ds_fases_detalle.retrieve(id_fase)
//			
//			// TODO: Tendr$$HEX1$$ed00$$ENDHEX$$a que ser u_dw
//			n_ds ds_fases_usos
//			ds_fases_usos = create n_ds
//			ds_fases_usos.dataobject = 'fases_usos'
//			ds_fases_usos.of_settransobject(SQLCA)
//			ds_fases_usos.retrieve(id_fase)
//			
//			n_calculo_cuotas calculo_cuotas_ejec
//			calculo_cuotas_ejec = create n_calculo_cuotas
//			calculo_cuotas_ejec.idw_fases_detalle = ds_fases_detalle
//			calculo_cuotas_ejec.idw_fases_usos_formulas = ds_fases_usos
//			calculo_cuotas_ejec.f_inicializar()
//			// TODO: Poner % fase a 100%
//			cv_ejec_100 = calculo_cuotas_ejec.f_calcular_resultado()
//			
//			return cv_ejec_100 - cv_ejec 
//
//
//		else
//			return 0
//		end if
//	*/
//	
//	case VARIABLE_PR_EDIF
//		
//		double pr, pr_parcial
//		long i
//		
//		pr = 0
//		
//		for i = 1 to idw_fases_usos_formulas.RowCount()
//			
//			c_trabajo = idw_fases_usos_formulas.GetItemString(i, 'trabajo');
//			
//			// Los usos pertenecientes a la parte de edificaci$$HEX1$$f300$$ENDHEX$$n se incluyen en la superficie total del proyecto
//			if idw_fases_usos_formulas.GetItemString(i, 'totsuper') = 'N' then continue
//			
//			// Las piscinas y los derribos tienen un c$$HEX1$$e100$$ENDHEX$$lculo de presupuesto especial
//			if c_trabajo = TRABAJO_PISCINA or &
//				c_trabajo = TRABAJO_DERRIBO then continue
//				
//				
//			pr_parcial = idw_fases_usos_formulas.GetItemNumber(i, 'parcial')
//			if not isnull(pr_parcial) then pr += pr_parcial
//			
//		next
//		
//		return pr
//		
//	case VARIABLE_PR_PISC
//		
//		pr = 0
//		
//		for i = 1 to idw_fases_usos_formulas.RowCount()
//			if idw_fases_usos_formulas.GetItemString(i, 'trabajo') = TRABAJO_PISCINA then
//				pr_parcial = idw_fases_usos_formulas.GetItemNumber(i, 'parcial')
//				if not isnull(pr_parcial) then pr += pr_parcial
//			end if
//		next
//		
//		return pr
//		
//	case VARIABLE_PR_DERR
//
//		pr = 0
//		
//		for i = 1 to idw_fases_usos_formulas.RowCount()
//			if idw_fases_usos_formulas.GetItemString(i, 'trabajo') = TRABAJO_DERRIBO then
//				pr_parcial = idw_fases_usos_formulas.GetItemNumber(i, 'parcial')
//				if not isnull(pr_parcial) then pr += pr_parcial
//			end if
//		next
//		
//		return pr
//		
//	case VARIABLE_PR_VAR
//		
//		pr = 0
//		
//		for i = 1 to idw_fases_usos_formulas.RowCount()
//			
//			c_trabajo = idw_fases_usos_formulas.GetItemString(i, 'trabajo');
//			
//			// El presupuesto de los usos que no repercuten en la superficie total del proyecto no forman parte del presupuesto de edificaci$$HEX1$$f300$$ENDHEX$$n (VARIABLE_PR_EDIF)
//			if not idw_fases_usos_formulas.GetItemString(i, 'totsuper') = 'N' then continue
//			
//			// Las piscinas y los derribos tienen un c$$HEX1$$e100$$ENDHEX$$lculo de presupuesto especial
//			if c_trabajo = TRABAJO_PISCINA or &
//				c_trabajo = TRABAJO_DERRIBO then continue
//			
//			pr_parcial = idw_fases_usos_formulas.GetItemNumber(i, 'parcial')
//			if not isnull(pr_parcial) then pr += pr_parcial
//			
//		next
//		
//		return pr
//		
//	case VARIABLE_VOL_DERR
//		
//		double sup, sup_parcial
//		sup = 0
//		
//		for i = 1 to idw_fases_usos_formulas.RowCount()
//			if idw_fases_usos_formulas.GetItemString(i, 'trabajo') = TRABAJO_DERRIBO then
//				sup_parcial = idw_fases_usos_formulas.GetItemNumber(i, 'superficie')
//				if not isnull(sup_parcial) then sup += sup_parcial
//			end if
//		next
//		
//		return sup
//		
//	case VARIABLE_TIPO_FASE
//
//		// En entre SICA y Visared los nombres de los campos son distintos
//		if idw_fases_detalle.describe("fase.ColType") <> "!" then
//			return idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'fase')
//		else
//			return idw_fases_detalle.getitemstring(idw_fases_detalle.getrow(), 'tipo_actuacion')
//		end if			
//		
//		
//	case VARIABLE_TRABAJO
//
//		string trabajo		
//		trabajo=idw_fases_detalle.GetItemString(1,'destino')
//
//		return trabajo
//		
//	case VARIABLE_FECHAEJ
//		
//		// Devuelve la fecha de la fase de "proyecto de ejecuci$$HEX1$$f300$$ENDHEX$$n" del expediente actual
//		// La fecha es preferentemente la fecha de visado, pero si todav$$HEX1$$ed00$$ENDHEX$$a no se ha visado ser$$HEX2$$e1002000$$ENDHEX$$la fecha de entrada
//		
//		datetime fecha, f_entrada
//		string n_expedi
//		
//		n_expedi = idw_fases_detalle.Getitemstring(idw_fases_detalle.getrow(),'n_expedi')
//		
//		setnull(fecha)
//		setnull(f_entrada)
//		
//		// S$$HEX1$$f300$$ENDHEX$$lo es necesario para Visared de Ja$$HEX1$$e900$$ENDHEX$$n
//	  SELECT fases.f_entrada,   
//				fases.f_visado  
//		 INTO :f_entrada,   
//				:fecha  
//		 FROM fases  
//		WHERE ( fases.n_expedi = :n_expedi ) AND  
//				( fases.tipo_actuacion in ('4', '5', '11') ) ;
//
//		
//		if isnull(fecha) then fecha = f_entrada
//		if isnull(fecha) then
//			return today()
//		else
//			return date(fecha)
//		end if
//
//	// ANTIGUA VERSION, SIN DESGLOSE
//	
//	/*case VARIABLE_CV_USOS	// MALAGA
//		string ls_coduso,ls_id_uso,ls_grupo,ls_comp_sup
//		double ld_superficie,cbase,cuota,cmin,c_acum,reforma,cv_uso,espec
//		long j
//
//		string nulo
//		setnull(nulo)
//		
//
//		c_acum=0
//		for i=1 to idw_fases_usos_formulas.rowcount()
//			ls_id_uso=idw_fases_usos_formulas.GetItemString(i,'id_uso')
//			ld_superficie=idw_fases_usos_formulas.GetItemNumber(i,'superficie')
//			if isnull(ld_superficie) then continue
//			ls_coduso=idw_fases_usos_formulas.GetItemString(i,'trabajo')
//			if f_es_vacio(ls_coduso) then continue
//			ls_grupo=string(f_evaluar_rango('grupos',ls_coduso,nulo,nulo))
//			if f_es_vacio(ls_grupo) then continue
//			cbase=0
//			cbase=double(f_evaluar_rango('cb_pedif',ld_superficie,ls_grupo,ls_coduso))
//			if isnull(cbase) then cbase = 0
//			// Para algunos trabajos, la cuota NO se calcula a partir de la superficie
//			ls_comp_sup=''
//			SELECT notas into :ls_comp_sup from usos_tasas 
//			where colegio=:i_colegio and c_trabajo=:ls_coduso	;
//			if ls_comp_sup='NOSUP' then
//				cuota=cbase
//			else
//				cuota=cbase*ld_superficie
//			end if
//			
//			// Obtenemos el minimo especifico para el uso especificado
//			// Si no hay minimo, usamos el minimo comun a todos los proyectos de edificacion
//			cmin=double(f_evaluar_rango('otro_min',ls_coduso,nulo,nulo))
//			if cmin=0 then cmin=double(f_evaluar_rango('cm_pedif',ld_superficie,ls_grupo,ls_coduso))				
//			if isnull(cmin) then cmin = 0
//			
//			// Entre la lista de i_calculo_coste_referencia buscamos aquel que est$$HEX2$$e1002000$$ENDHEX$$asociado a la fila i
//			setnull(reforma)
//			for j = 1 to upperbound(i_calculo_coste_referencia)
//				if isvalid(i_calculo_coste_referencia[j]) and not isnull(i_calculo_coste_referencia[j]) then
//					if i_calculo_coste_referencia[j].i_id_ambito = ls_id_uso then
//						//reforma=i_calculo_coste_referencia[j].f_get_valor_variable('PAplic')
//						espec=double(f_evaluar_rango('coef_ref',ls_coduso,nulo,nulo))
//						reforma=double(i_calculo_coste_referencia[j].f_get_valor_variable('PAplic'))
//						exit
//					end if
//				end if
//			next
//			if isnull(reforma) then reforma = 100
//			if isnull(espec) then espec=1
//			cuota=cuota*espec
//			
//				// Si la cuota calculada es inferior al minimo utilizamos el minimo
//				if cuota>cmin then
//					cv_uso=cuota*(reforma/100)
//				else
//					cv_uso=cmin*(reforma/100)
//				end if	
//
//			//Acumulamos la suma de las cuotas
//			//MessageBox("",string(cuota)+" * "+string(reforma)+" = "+string(cv_uso))
//			c_acum=c_acum+cv_uso
//		
//		next
//		//MessageBox("acum",string(c_acum))
//		
//		// Devolvemos SUM(Cuota*REFORMA) de los usos
//		return c_acum*/
//		
//		
//	// NUEVA VERSION, CON DESGLOSE
//	
//	case VARIABLE_CV_USOS	// MALAGA
//		string ls_coduso,ls_id_uso,ls_grupo,ls_tipoadap,ls_comp_sup,sub_var,desc_uso
//		double ld_superficie,cbase,cuota,cmin,c_acum,reforma,espec
//		long fila, indice_uso
//
//		string nulo
//		setnull(nulo)
//		
//
//		c_acum=0
//		for i=1 to idw_fases_usos_formulas.rowcount()
//			
//			ls_id_uso=idw_fases_usos_formulas.GetItemString(i,'id_uso')
//			ld_superficie=idw_fases_usos_formulas.GetItemNumber(i,'superficie')
//			if isnull(ld_superficie) then continue
//			ls_coduso=idw_fases_usos_formulas.GetItemString(i,'trabajo')
//			if f_es_vacio(ls_coduso) then continue
//			
//			// Entre la lista de i_calculo_coste_referencia buscamos aquel que est$$HEX2$$e1002000$$ENDHEX$$asociado a la fila i
//			for indice_uso = 1 to upperbound(iw_fases_detalle.i_calculo_coste_referencia)
//				if isvalid(iw_fases_detalle.i_calculo_coste_referencia[indice_uso]) and not isnull(iw_fases_detalle.i_calculo_coste_referencia[indice_uso]) then
//					if iw_fases_detalle.i_calculo_coste_referencia[indice_uso].i_id_ambito = ls_id_uso then exit
//				end if
//			next
//			if indice_uso > upperbound(iw_fases_detalle.i_calculo_coste_referencia) then indice_uso = 0
//			
//			ls_grupo=string(f_evaluar_rango('grupos',ls_coduso,nulo,nulo))
//			if ls_grupo = 'ADAP' then
//				if indice_uso = 0 then
//					ls_tipoadap = ''
//				  SELECT coeficientes_valores.valor  
//					 INTO :ls_tipoadap
//					 FROM coeficientes_valores  
//					WHERE ( coeficientes_valores.codigo = 'tipo_adap' ) AND  
//							( coeficientes_valores.ambito = 'CR' ) AND  
//							( coeficientes_valores.id_ambito = :ls_id_uso )   ;
//				else
//					ls_tipoadap=string(iw_fases_detalle.i_calculo_coste_referencia[indice_uso].f_get_valor_variable('tipo_adap'))
//				end if
//				if f_es_vacio(ls_tipoadap) then continue
//				ls_grupo=string(f_evaluar_rango('gr_adap',ls_tipoadap,nulo,nulo))
//			end if
//			if f_es_vacio(ls_grupo) then continue
//			
//			select descripcion into :desc_uso from usos_tasas where c_trabajo = :ls_coduso and colegio = :i_colegio ;
//			
//			// Variable cuota base
//			sub_var = PREFIJO_VARIABLE_CBASE + string(i)
//			cbase = double(f_calcular_variable(sub_var))
//			fila = f_fila_variable(sub_var)
//			if ds_variables.getitemstring(fila, 'modificado') = 'S' then
//			else
//				cbase=0
//				cbase=double(f_evaluar_rango('cb_pedif',ld_superficie,ls_grupo,ls_coduso))
//				if isnull(cbase) then cbase = 0
//				f_set_valor_variable(sub_var, cbase, false, false)
//			end if
//			ds_variables.setitem(fila, 'descripcion_coeficiente', 'Cuota base "' + desc_uso + '"')
//			ds_variables.setitem(fila, 'datos_adicionales', ls_id_uso) // Para que al imprimir documentos sea m$$HEX1$$e100$$ENDHEX$$s facil obtener la l$$HEX1$$ed00$$ENDHEX$$nea asociada a cada uso
//			
//			// Variable porcentaje reforma
//			sub_var = PREFIJO_VARIABLE_REFORMA + string(i)
//			reforma = double(f_calcular_variable(sub_var))
//			fila = f_fila_variable(sub_var)
//			if ds_variables.getitemstring(fila, 'modificado') = 'S' then
//			else
//				if indice_uso = 0 then
//					string reforma_s
//					reforma_s = ''
//				  SELECT coeficientes_valores.valor  
//					 INTO :reforma_s
//					 FROM coeficientes_valores  
//					WHERE ( coeficientes_valores.codigo = 'PAplic' ) AND  
//							( coeficientes_valores.ambito = 'CR' ) AND  
//							( coeficientes_valores.id_ambito = :ls_id_uso )   ;
//					if isnumber(reforma_s) then
//						reforma = double(reforma_s)
//					else
//						setnull(reforma)
//					end if
//				else
//					reforma=double(iw_fases_detalle.i_calculo_coste_referencia[indice_uso].f_get_valor_variable('PAplic'))
//				end if
//				//if isnull(reforma) then reforma = 100
//				f_set_valor_variable(sub_var, reforma, false, false)
//			end if
//			ds_variables.setitem(fila, 'descripcion_coeficiente', '% Reforma "' + desc_uso + '"')
//			ds_variables.setitem(fila, 'datos_adicionales', ls_id_uso) // Para que al imprimir documentos sea m$$HEX1$$e100$$ENDHEX$$s facil obtener la l$$HEX1$$ed00$$ENDHEX$$nea asociada a cada uso
//			
//			// Variable cuota
//			sub_var = PREFIJO_VARIABLE_CUOTA + string(i)
//			cuota = double(f_calcular_variable(sub_var))
//			fila = f_fila_variable(sub_var)
//			if ds_variables.getitemstring(fila, 'modificado') = 'S' then
//			else
//				// Para algunos trabajos, la cuota NO se calcula a partir de la superficie
//				ls_comp_sup=''
//				SELECT notas into :ls_comp_sup from usos_tasas 
//					where colegio=:i_colegio and c_trabajo=:ls_coduso	;
//				if ls_comp_sup='NOSUP' then
//					cuota=cbase
//				else
//					cuota=cbase*ld_superficie
//				end if
//				
//				espec=double(f_evaluar_rango('coef_ref',ls_coduso,nulo,nulo))
//				if isnull(espec) then espec=1
//				cuota=cuota*espec
//				
//				// Obtenemos el minimo especifico para el uso especificado
//				// Si no hay minimo, usamos el minimo comun a todos los proyectos de edificacion
//				cmin=double(f_evaluar_rango('otro_min',ls_coduso,nulo,nulo))
//				if cmin=0 then cmin=double(f_evaluar_rango('cm_pedif',ld_superficie,ls_grupo,ls_coduso))				
//				if isnull(cmin) then cmin = 0
//				
//				// Si la cuota calculada es inferior al minimo utilizamos el minimo
//				if cuota<=cmin then cuota = cmin
//				
//				f_set_valor_variable(sub_var, cuota, false, false)
//			end if
//			ds_variables.setitem(fila, 'descripcion_coeficiente', 'Cuota "' + desc_uso + '"')
//			ds_variables.setitem(fila, 'datos_adicionales', ls_id_uso) // Para que al imprimir documentos sea m$$HEX1$$e100$$ENDHEX$$s facil obtener la l$$HEX1$$ed00$$ENDHEX$$nea asociada a cada uso
//			
//			//Acumulamos la suma de las cuotas
//			//MessageBox("",string(cuota)+" * "+string(reforma)+" = "+string(cv_uso))
//			c_acum=c_acum+cuota*(reforma/100)
//		
//		next
//		//MessageBox("acum",string(c_acum))
//		
//		// Devolvemos SUM(Cuota*REFORMA) de los usos
//		return c_acum		
//	
//	
//	case PREFIJO_VARIABLE_SUMACUOTA // C$$HEX1$$d300$$ENDHEX$$RDOBA
//		
//		// En C$$HEX1$$f300$$ENDHEX$$rdoba no tienen usos y la tabla de usos se ha reutilizado y contiene trabajos. De esta manera
//		// se pueden establecer varios trabajos para un mismo expediente, agregandolos todos ellos en la pesta$$HEX1$$f100$$ENDHEX$$a
//		// de usos. Para sacar el valor definitivo de la cuota del expediente hay que sumar la cuota de cada trabajo.
//		// La cuota de cada trabajo se almacena pu$$HEX1$$e900$$ENDHEX$$s en el campo de precio_m2 del dw de usos.
//		
//		double sumacuota = 0
//		
//		for i = 1 to idw_fases_usos_formulas.rowcount()
//			cuota = idw_fases_usos_formulas.getitemnumber(i, 'precio_m2')
//			if not isnull(cuota) then sumacuota += cuota
//		next
//		
//		return sumacuota
//		
//	case else
//		
//		return super::f_valor_variable_auto_proceso(variable)
//
//end choose
return -1
end function

on n_calculo_cuotas.create
call super::create
end on

on n_calculo_cuotas.destroy
call super::destroy
end on

type ds_variables from n_calculo_formulas`ds_variables within n_calculo_cuotas
string dataobject = "d_calculo_formulas_variables"
end type

