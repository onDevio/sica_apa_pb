HA$PBExportHeader$w_expediente_impresiones.srw
forward
global type w_expediente_impresiones from w_listados
end type
end forward

global type w_expediente_impresiones from w_listados
end type
global w_expediente_impresiones w_expediente_impresiones

type variables
string id_fase, colegiado, id_fases_colegiados, tipo_persona
string nombre, apellidos, tipo_trabajo, trabajo,d_tipo_trabajo, d_trabajo,num_exp
string tipo_actuacion,d_tipo_actuacion, emplazamiento, descripcion, observaciones

string id_representante, reclamar, id_cliente = '', cliente = ''
int fila,fila_2, i, num_cli = 0
string facturado

int num_dw_1, num_dw_2

double porcent_a,porcent_b, honorarios, cip, total_honorarios, iva, musaat_total

st_expediente expediente
st_musaat_datos st_musaat_datos

datawindowchild colegiados, promotores, economicos, economicos_2, datos

string is_tipo_gestion
end variables

on w_expediente_impresiones.create
call super::create
end on

on w_expediente_impresiones.destroy
call super::destroy
end on

event open;call super::open;expediente = message.powerobjectparm

id_fase = expediente.id_fase
tipo_trabajo = expediente.tipo_trabajo
trabajo = expediente.trabajo
num_exp = expediente.num_exp
tipo_actuacion = expediente.tipo_actuacion
emplazamiento = expediente.emplazamiento
descripcion = expediente.descripcion
honorarios = expediente.honorarios
cip = expediente.cip
iva = expediente.iva
observaciones = expediente.observaciones
musaat_total = expediente.musaat_total


st_musaat_datos.n_visado = expediente.n_visado
st_musaat_datos.tipo_act = expediente.tipo_act
st_musaat_datos.tipo_obra = expediente.tipo_obra
st_musaat_datos.pem = expediente.pem
st_musaat_datos.pto_contrato = expediente.pto_contrato	
st_musaat_datos.administracion = expediente.administracion
st_musaat_datos.superficie = expediente.superficie
st_musaat_datos.volumen = expediente.volumen

st_musaat_datos.cobertura = 0


select d_t_trabajo into :d_tipo_trabajo from tipos_trabajos
where c_t_trabajo = :tipo_trabajo ;

select d_trabajo into :d_trabajo from trabajos 
where c_trabajo = :trabajo;

select d_t_descripcion into :d_tipo_actuacion from t_fases 
where  c_t_fase = :tipo_actuacion;



dw_listados_varios.settrans(sqlca)
dw_listados_varios.retrieve('w_expediente_impresiones')

// MODIFICADO RICARDO 2004-05-18
SELECT tipo_gestion into :is_tipo_gestion from fases where id_fase = :id_fase;

end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_expediente_impresiones
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_expediente_impresiones
end type

type cb_limpiar from w_listados`cb_limpiar within w_expediente_impresiones
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_expediente_impresiones
end type

type cb_ver from w_listados`cb_ver within w_expediente_impresiones
end type

event cb_ver::clicked;call super::clicked;string listado
int indice
double irpf

irpf = g_irpf_por_defecto

dw_1.of_SetPrintPreview(TRUE)

// Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
dw_1.dataobject = listado
indice = dw_listados_varios.GetRow()

dw_1.of_SetTransObject(SQLCA)

dw_1.settrans(sqlca)

if listado = 'd_expediente_colegiados_compuesto' then
	
	total_honorarios = 0
	num_cli = 0
	tipo_persona = ''
	id_cliente = ''
	reclamar = ''
	cliente = ''
	
	dw_1.settrans(sqlca)
	
	// Rellenamos la parte de los colegiados
	
	DECLARE colegiados CURSOR FOR
	
	SELECT fases_colegiados.id_col, fases_colegiados.id_fases_colegiados,
			 fases_colegiados.porcen_a, fases_colegiados.facturado,colegiados.nombre,
			 colegiados.apellidos, colegiados.tipo_persona
	FROM fases_colegiados, colegiados
	WHERE (fases_colegiados.id_fase = :id_fase) and 
			(fases_colegiados.id_col = colegiados.id_colegiado);
	
	OPEN colegiados;
	
	dw_1.getchild('dw_1',colegiados)
	
	do while sqlca.sqlcode = 0
	
	IF tipo_persona = 'P' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos + ', ' + nombre)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
	end if
	
	if tipo_persona = 'S' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
		
		declare asociados cursor for
		
		select fases_colegiados_asociados.id_col_per, fases_colegiados_asociados.porcent,
				 colegiados.nombre, colegiados.apellidos, colegiados.tipo_persona
		from	 fases_colegiados_asociados, colegiados
		where  fases_colegiados_asociados.id_fases_colegiados = id_fases_colegiados and
				 fases_colegiados_asociados.id_fase = :id_fase and
				 fases_colegiados_asociados.id_col_aso = :colegiado and
				 fases_colegiados_asociados.id_col_per = colegiados.id_colegiado;
		
		open asociados;
		
		do while sqlca.sqlcode = 0
		if tipo_persona = 'P' then
			colegiados.insertrow(0)
			colegiados.setitem(colegiados.rowcount(),'nombre','    ' + apellidos + ', ' + nombre)
			colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
			colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
			colegiados.setitem(colegiados.rowcount(),'principal','N')
		end if
			fetch asociados into :colegiado, :porcent_a, :nombre, :apellidos,:tipo_persona;
		loop
		close asociados;
	end if 
	FETCH colegiados INTO :colegiado, :id_fases_colegiados,:porcent_a,:facturado,
									:nombre,:apellidos,:tipo_persona;
	LOOP 
	CLOSE colegiados ;
	
	// Fin de rellenar los colegiados
	
	// Rellenamos la parte de los promotores y el pie de pagina --> cliente
		
		declare promotores cursor for
		
		select 	fases_clientes.id_cliente, fases_clientes.id_representante,
					fases_clientes.reclamar_representante
					from fases_clientes
					where fases_clientes.id_fase = :id_fase;
					
		open promotores;
		
		dw_1.getchild('dw_2',promotores)
		
		do while sqlca.sqlcode = 0
			
			if (id_cliente <> '') then
			
			fila = promotores.insertrow(0)
			
			if (reclamar = 'S') then
				promotores.setitem(fila,'tipo','Representante')
				promotores.setitem(fila,'NIF',f_dame_nif(id_representante))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_representante))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_representante) + ' ' + f_retorna_poblacion(id_representante))
				fila = promotores.insertrow(0)
			end if
			
			if (reclamar = 'S') then 
				promotores.setitem(fila,'tipo','Sociedad')
			else
				promotores.setitem(fila,'tipo','Cliente')
			end if
				promotores.setitem(fila,'NIF',f_dame_nif(id_cliente))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_cliente))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_cliente) + ' ' + f_retorna_poblacion(id_cliente))
		end if
		fetch promotores into :id_cliente, :id_representante, :reclamar;
		loop
		close promotores;
	
	num_dw_1 = colegiados.rowcount()
	num_dw_2 = promotores.rowcount()
	
	if(num_dw_1 < num_dw_2) then
		num_dw_1 = num_dw_2 - num_dw_1
		for i = 1 to num_dw_1
			colegiados.insertrow(0)
		next
	else
		num_dw_1 = num_dw_1 - num_dw_2
		for i = 1 to num_dw_1
			promotores.insertrow(0)
		next
	end if
	
	// Rellenamos los datos economicos
	// modify
	
	OPEN colegiados;
	
	tipo_persona = ''
	
	dw_1.getchild('dw_3',economicos)
	dw_1.getchild('dw_4',economicos_2)
	
	
	do while sqlca.sqlcode = 0
	
	st_musaat_datos.prima_comp = 0
	st_musaat_datos.id_col = colegiado
	st_musaat_datos.porcentaje = porcent_a
	
	IF tipo_persona = 'P' then
	
		fila = economicos.insertrow(0)
		fila_2 = economicos_2.insertrow(0)
		
		economicos.setitem(fila,'participante',apellidos + ', ' + nombre)
		economicos.setitem(fila,'tipo','P')
		economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a/100))
		economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a/10000))
		economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * iva /10000))
	
		economicos_2.setitem(fila_2,'participante',apellidos + ', ' + nombre)
		economicos_2.setitem(fila_2,'cip',f_redondea(cip*porcent_a/100))
		economicos_2.setitem(fila_2,'igic',f_redondea(cip*porcent_a * iva /10000))	
		st_musaat_datos.funcionario = facturado
		f_musaat_calcula_prima(st_musaat_datos)
		economicos_2.setitem(fila_2,'src', st_musaat_datos.prima_comp)
		st_musaat_datos.prima_comp = 0
	
	end if
	
	if tipo_persona = 'S' then
		fila = economicos.insertrow(0)
		fila_2 = economicos_2.insertrow(0)
		
		economicos.setitem(fila,'participante',apellidos)
		economicos.setitem(fila,'tipo','P')
		economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a/100))
		economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a/10000))
		economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * iva /10000))
		
		economicos_2.setitem(fila_2,'participante',apellidos)
		economicos_2.setitem(fila_2,'cip',f_redondea(cip*porcent_a/100))
		economicos_2.setitem(fila_2,'igic',f_redondea(cip*porcent_a * iva /10000))
		st_musaat_datos.funcionario = facturado
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		economicos_2.setitem(fila_2,'src',st_musaat_datos.prima_comp)	
		st_musaat_datos.prima_comp = 0
		porcent_b = porcent_a
		
		declare asociados_2 cursor for
		
		select fases_colegiados_asociados.id_col_per, fases_colegiados_asociados.porcent,
				 colegiados.nombre, colegiados.apellidos, colegiados.tipo_persona
		from	 fases_colegiados_asociados, colegiados
		where  fases_colegiados_asociados.id_fases_colegiados = id_fases_colegiados and
				 fases_colegiados_asociados.id_fase = :id_fase and
				 fases_colegiados_asociados.id_col_aso = :colegiado and
				 fases_colegiados_asociados.id_col_per = colegiados.id_colegiado;
		
		open asociados_2;
	
		do while sqlca.sqlcode = 0
		if tipo_persona = 'P' then
			fila = economicos.insertrow(0)
	//		fila_2 = economicos_2.insertrow(0)
			
			economicos.setitem(fila,'tipo','N')		
			economicos.setitem(fila,'participante','   ' + apellidos + ', ' + nombre)
			economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a*porcent_b/10000))	
			economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a * porcent_b/1000000))		
			economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * porcent_b * iva /1000000))
	
	//		economicos_2.setitem(fila_2,'participante','    ' + apellidos + ', ' + nombre)	
	//		economicos_2.setitem(fila_2,'cip',0)
	//		economicos_2.setitem(fila_2,'igic',0)			
	//		economicos_2.setitem(fila_2,'src',0)
		end if
			fetch asociados_2 into :colegiado, :porcent_a, :nombre, :apellidos,:tipo_persona;
		loop
		close asociados_2;
	end if 
	FETCH colegiados INTO :colegiado, :id_fases_colegiados,:porcent_a,:facturado,
									:nombre,:apellidos,:tipo_persona;
	LOOP 
	CLOSE colegiados ;
	
	economicos_2.setitem(fila,'observaciones',observaciones)
	
	// Fin de rellenar los economicos
end if

if listado = 'd_expediente_propiedad_compuesto' then

	total_honorarios = 0
	num_cli = 0
	tipo_persona = ''
	id_cliente = ''
	reclamar = ''
	cliente = ''
	
	// Rellenamos la parte de los colegiados
	
	DECLARE colegiados_p CURSOR FOR
	
	SELECT fases_colegiados.id_col, fases_colegiados.id_fases_colegiados,
			 fases_colegiados.porcen_a, colegiados.nombre,
			 colegiados.apellidos, colegiados.tipo_persona
	FROM fases_colegiados, colegiados
	WHERE (fases_colegiados.id_fase = :id_fase) and 
			(fases_colegiados.id_col = colegiados.id_colegiado);
	
	OPEN colegiados_p;
	
	dw_1.getchild('dw_1',colegiados)
	
	do while sqlca.sqlcode = 0
	
	IF tipo_persona = 'P' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos + ', ' + nombre)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
	end if
	
	if tipo_persona = 'S' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
		
		declare asociados_p cursor for
		
		select fases_colegiados_asociados.id_col_per, fases_colegiados_asociados.porcent,
				 colegiados.nombre, colegiados.apellidos, colegiados.tipo_persona
		from	 fases_colegiados_asociados, colegiados
		where  fases_colegiados_asociados.id_fases_colegiados = id_fases_colegiados and
				 fases_colegiados_asociados.id_fase = :id_fase and
				 fases_colegiados_asociados.id_col_aso = :colegiado and
				 fases_colegiados_asociados.id_col_per = colegiados.id_colegiado;
		
		open asociados_p;
		
		do while sqlca.sqlcode = 0
		if tipo_persona = 'P' then
			colegiados.insertrow(0)
			colegiados.setitem(colegiados.rowcount(),'nombre','    ' + apellidos + ', ' + nombre)
			colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
			colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
			colegiados.setitem(colegiados.rowcount(),'principal','N')
		end if
			fetch asociados_p into :colegiado, :porcent_a, :nombre, :apellidos,:tipo_persona;
		loop
		close asociados_p;
	end if 
	FETCH colegiados_p INTO :colegiado, :id_fases_colegiados,:porcent_a,:nombre,:apellidos,:tipo_persona;
	LOOP
	CLOSE colegiados_p ;
	
	// Fin de rellenar los colegiados
	
	// Rellenamos la parte de los promotores y el pie de pagina --> cliente
		
		declare promotores_p cursor for
		
		select 	fases_clientes.id_cliente, fases_clientes.id_representante,
					fases_clientes.reclamar_representante
					from fases_clientes
					where fases_clientes.id_fase = :id_fase;
					
		open promotores_p;
		
		dw_1.getchild('dw_2',promotores)
		
		do while sqlca.sqlcode = 0
			
			if (id_cliente <> '') then
			
			fila = promotores.insertrow(0)
			
			if (reclamar = 'S') then
				promotores.setitem(fila,'tipo','Representante')
				promotores.setitem(fila,'NIF',f_dame_nif(id_representante))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_representante))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_representante) + ' ' + f_retorna_poblacion(id_representante))
				fila = promotores.insertrow(0)
			end if
			
			if (reclamar = 'S') then 
				promotores.setitem(fila,'tipo','Sociedad')
			else
				promotores.setitem(fila,'tipo','Cliente')
			end if
				promotores.setitem(fila,'NIF',f_dame_nif(id_cliente))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_cliente))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_cliente) + ' ' + f_retorna_poblacion(id_cliente))
				
		end if
		fetch promotores_p into :id_cliente, :id_representante, :reclamar;
		loop
		close promotores_p;
	
	num_dw_1 = colegiados.rowcount()
	num_dw_2 = promotores.rowcount()
	
	if(num_dw_1 < num_dw_2) then
		num_dw_1 = num_dw_2 - num_dw_1
		for i = 1 to num_dw_1
			colegiados.insertrow(0)
		next
	else
		num_dw_1 = num_dw_1 - num_dw_2
		for i = 1 to num_dw_1
			promotores.insertrow(0)
		next
	end if
	
	// Rellenamos los datos economicos
	
	dw_1.getchild('dw_3',economicos)
	fila = economicos.insertrow(0)
	// Modificado Ricardo 2004-11-18
	if is_tipo_gestion = 'P' then
		// PAra los sin gestion de cobro, colocamos directamente un 0
		economicos.setitem(fila,'honorarios',0)
		economicos.setitem(fila,'irpf',0)
		economicos.setitem(fila,'igic',0)
	else
		economicos.setitem(fila,'honorarios',f_redondea(honorarios))
		economicos.setitem(fila,'irpf',f_redondea(honorarios*irpf/100))
		economicos.setitem(fila,'igic',f_redondea(honorarios*iva/100))
	end if
	// fin Modificado Ricardo 2004-11-18
	economicos.setitem(fila,'cip',f_redondea(cip))
	economicos.setitem(fila,'src',f_redondea(musaat_total))
	economicos.setitem(fila,'igic_gastos',f_redondea(cip*iva/100))
	//economicos.setitem(fila,'src',f_redondea(cip*porcent_a/100))
	economicos.setitem(fila,'expediente',num_exp)
	// Fin de rellenar los economicos
end if

if listado = 'd_expediente_ficha_compuesto' then

	total_honorarios = 0
	num_cli = 0
	tipo_persona = ''
	id_cliente = ''
	reclamar = ''
	cliente = ''
	
	dw_1.settrans(sqlca)
	
	// Rellenamos la parte de los colegiados
	
	DECLARE colegiados_f CURSOR FOR
	
	SELECT fases_colegiados.id_col, fases_colegiados.id_fases_colegiados,
			 fases_colegiados.porcen_a, fases_colegiados.facturado,colegiados.nombre,
			 colegiados.apellidos, colegiados.tipo_persona
	FROM fases_colegiados, colegiados
	WHERE (fases_colegiados.id_fase = :id_fase) and 
			(fases_colegiados.id_col = colegiados.id_colegiado);
	
	OPEN colegiados_f;
	
	dw_1.getchild('dw_1',colegiados)
	
	do while sqlca.sqlcode = 0
	
	IF tipo_persona = 'P' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos + ', ' + nombre)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
	end if
	
	if tipo_persona = 'S' then
		colegiados.insertrow(0)
		colegiados.setitem(colegiados.rowcount(),'nombre',apellidos)
		colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
		colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
		colegiados.setitem(colegiados.rowcount(),'principal','P')
		
		declare asociados_f cursor for
		
		select fases_colegiados_asociados.id_col_per, fases_colegiados_asociados.porcent,
				 colegiados.nombre, colegiados.apellidos, colegiados.tipo_persona
		from	 fases_colegiados_asociados, colegiados
		where  fases_colegiados_asociados.id_fases_colegiados = id_fases_colegiados and
				 fases_colegiados_asociados.id_fase = :id_fase and
				 fases_colegiados_asociados.id_col_aso = :colegiado and
				 fases_colegiados_asociados.id_col_per = colegiados.id_colegiado;
		
		open asociados_f;
		
		do while sqlca.sqlcode = 0
		if tipo_persona = 'P' then
			colegiados.insertrow(0)
			colegiados.setitem(colegiados.rowcount(),'nombre','    ' + apellidos + ', ' + nombre)
			colegiados.setitem(colegiados.rowcount(),'codigo',colegiado)
			colegiados.setitem(colegiados.rowcount(),'porcentaje',porcent_a)
			colegiados.setitem(colegiados.rowcount(),'principal','N')
		end if
			fetch asociados_f into :colegiado, :porcent_a, :nombre, :apellidos,:tipo_persona;
		loop
		close asociados_f;
	end if 
	FETCH colegiados_f INTO :colegiado, :id_fases_colegiados,:porcent_a,:facturado,
									:nombre,:apellidos,:tipo_persona;
	LOOP 
	CLOSE colegiados_f ;
	
	// Fin de rellenar los colegiados
	
	// Rellenamos la parte de los promotores y el pie de pagina --> cliente
		
		declare promotores_f cursor for
		
		select 	fases_clientes.id_cliente, fases_clientes.id_representante,
					fases_clientes.reclamar_representante
					from fases_clientes
					where fases_clientes.id_fase = :id_fase;
					
		open promotores_f;
		
		dw_1.getchild('dw_2',promotores)
		
		do while sqlca.sqlcode = 0
			
			if (id_cliente <> '') then
			
			fila = promotores.insertrow(0)
			
			if (reclamar = 'S') then
				promotores.setitem(fila,'tipo','Representante')
				promotores.setitem(fila,'NIF',f_dame_nif(id_representante))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_representante))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_representante) + ' ' + f_retorna_poblacion(id_representante))
				fila = promotores.insertrow(0)
			end if
			
			if (reclamar = 'S') then 
				promotores.setitem(fila,'tipo','Sociedad')
			else
				promotores.setitem(fila,'tipo','Cliente')
			end if
				promotores.setitem(fila,'NIF',f_dame_nif(id_cliente))
				promotores.setitem(fila,'nombre',f_dame_cliente(id_cliente))
				promotores.setitem(fila,'direccion',f_dame_domicilio(id_cliente) + ' ' + f_retorna_poblacion(id_cliente))
		end if
		fetch promotores_f into :id_cliente, :id_representante, :reclamar;
		loop
		close promotores_f;
	
	num_dw_1 = colegiados.rowcount()
	num_dw_2 = promotores.rowcount()
	
	if(num_dw_1 < num_dw_2) then
		num_dw_1 = num_dw_2 - num_dw_1
		for i = 1 to num_dw_1
			colegiados.insertrow(0)
		next
	else
		num_dw_1 = num_dw_1 - num_dw_2
		for i = 1 to num_dw_1
			promotores.insertrow(0)
		next
	end if
	
	// Rellenamos los datos economicos
	// modify
	
	OPEN colegiados_f;
	
	tipo_persona = ''
	
	dw_1.getchild('dw_3',economicos)
	dw_1.getchild('dw_4',economicos_2)
	
	
	do while sqlca.sqlcode = 0
	
	st_musaat_datos.prima_comp = 0
	st_musaat_datos.id_col = colegiado
	st_musaat_datos.porcentaje = porcent_a
	
	IF tipo_persona = 'P' then
	
		fila = economicos.insertrow(0)
		fila_2 = economicos_2.insertrow(0)
		
		economicos.setitem(fila,'participante',apellidos + ', ' + nombre)
		economicos.setitem(fila,'tipo','P')
		economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a/100))
		economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a/10000))
		economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * iva /10000))
	
		economicos_2.setitem(fila_2,'participante',apellidos + ', ' + nombre)
		economicos_2.setitem(fila_2,'cip',f_redondea(cip*porcent_a/100))
		economicos_2.setitem(fila_2,'igic',f_redondea(cip*porcent_a * iva /10000))	
		st_musaat_datos.funcionario = facturado
		f_musaat_calcula_prima(st_musaat_datos)
		economicos_2.setitem(fila_2,'src', st_musaat_datos.prima_comp)
		st_musaat_datos.prima_comp = 0
	
	end if
	
	if tipo_persona = 'S' then
		fila = economicos.insertrow(0)
		fila_2 = economicos_2.insertrow(0)
		
		economicos.setitem(fila,'participante',apellidos)
		economicos.setitem(fila,'tipo','P')
		economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a/100))
		economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a/10000))
		economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * iva /10000))
		
		economicos_2.setitem(fila_2,'participante',apellidos)
		economicos_2.setitem(fila_2,'cip',f_redondea(cip*porcent_a/100))
		economicos_2.setitem(fila_2,'igic',f_redondea(cip*porcent_a * iva /10000))
		st_musaat_datos.funcionario = facturado
		f_musaat_calcula_prima_sociedad(st_musaat_datos)
		economicos_2.setitem(fila_2,'src',st_musaat_datos.prima_comp)	
		st_musaat_datos.prima_comp = 0
		porcent_b = porcent_a
		
		declare asociados_f_2 cursor for
		
		select fases_colegiados_asociados.id_col_per, fases_colegiados_asociados.porcent,
				 colegiados.nombre, colegiados.apellidos, colegiados.tipo_persona
		from	 fases_colegiados_asociados, colegiados
		where  fases_colegiados_asociados.id_fases_colegiados = id_fases_colegiados and
				 fases_colegiados_asociados.id_fase = :id_fase and
				 fases_colegiados_asociados.id_col_aso = :colegiado and
				 fases_colegiados_asociados.id_col_per = colegiados.id_colegiado;
		
		open asociados_f_2;
		
		do while sqlca.sqlcode = 0
		if tipo_persona = 'P' then
			fila = economicos.insertrow(0)
	//		fila_2 = economicos_2.insertrow(0)
			
			economicos.setitem(fila,'tipo','N')		
			economicos.setitem(fila,'participante','   ' + apellidos + ', ' + nombre)
			economicos.setitem(fila,'honorarios',f_redondea(honorarios*porcent_a*porcent_b/10000))	
			economicos.setitem(fila,'irpf',f_redondea(honorarios * g_irpf_por_defecto * porcent_a * porcent_b/1000000))		
			economicos.setitem(fila,'igic',f_redondea(honorarios*porcent_a * porcent_b * iva /1000000))
	
	//		economicos_2.setitem(fila_2,'participante','    ' + apellidos + ', ' + nombre)	
	//		economicos_2.setitem(fila_2,'cip',0)
	//		economicos_2.setitem(fila_2,'igic',0)			
	//		economicos_2.setitem(fila_2,'src',0)
		end if
			fetch asociados_f_2 into :colegiado, :porcent_a, :nombre, :apellidos,:tipo_persona;
		loop
		close asociados_f_2;
	end if 
	FETCH colegiados_f INTO :colegiado, :id_fases_colegiados,:porcent_a,:facturado,
									:nombre,:apellidos,:tipo_persona;
	LOOP 
	CLOSE colegiados_f ;
	
	economicos_2.setitem(fila,'observaciones',observaciones)
	
	// Fin de rellenar los economicos
end if

//dw_1.retrieve()

if listado = 'd_fases_impresion_detalle_tfe' then
	dw_1.retrieve(id_fase)
end if

// Al final:
if dw_1.rowcount() > 0 then
	dw_1.sort()
	dw_1.visible 		  = true
	//dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
else
	dw_1.insertrow(0)
	dw_1.visible 		  = true
//	dw_1.event pfc_printpreview()
	this.enabled        = false
	cb_zoom.enabled     = true
	cb_imprimir.enabled = true
	cb_guardar.enabled  = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
	messagebox(g_titulo,'No se han encontrado registros segun las especificaciones.')
end if

if listado <> 'd_fases_impresion_detalle_tfe' then
	dw_1.getchild('dw_5',datos)
	
	fila = datos.insertrow(0)
	
	datos.setitem(fila,'musaat_tipo_act',tipo_actuacion + ' ' + d_tipo_actuacion)
	datos.setitem(fila,'musaat_dest',trabajo + ' ' + d_trabajo)
	datos.setitem(fila,'musaat_tipo_ob',tipo_trabajo + ' ' + d_tipo_trabajo)
	datos.setitem(fila,'emplazamiento',emplazamiento)
	datos.setitem(fila,'descripcion',descripcion)
	
	dw_1.object.num_exp.text = num_exp
	dw_1.object.num_exp_2.text = num_exp
end if
end event

type cb_salir from w_listados`cb_salir within w_expediente_impresiones
end type

type dw_listados from w_listados`dw_listados within w_expediente_impresiones
boolean visible = false
string dataobject = ""
end type

event dw_listados::constructor;string pero
end event

type cb_imprimir from w_listados`cb_imprimir within w_expediente_impresiones
end type

event cb_imprimir::clicked;dw_1.print()
end event

type cb_zoom from w_listados`cb_zoom within w_expediente_impresiones
end type

type cb_esp from w_listados`cb_esp within w_expediente_impresiones
end type

type cb_guardar from w_listados`cb_guardar within w_expediente_impresiones
end type

type cb_escala from w_listados`cb_escala within w_expediente_impresiones
end type

type cb_ordenar from w_listados`cb_ordenar within w_expediente_impresiones
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_expediente_impresiones
end type

type dw_1 from w_listados`dw_1 within w_expediente_impresiones
integer y = 168
end type

