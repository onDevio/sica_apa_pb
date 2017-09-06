HA$PBExportHeader$w_jg_reuniones_listados.srw
forward
global type w_jg_reuniones_listados from w_listados
end type
end forward

global type w_jg_reuniones_listados from w_listados
string title = "LISTADOS DE LA JUNTA DE GOBIERNO"
end type
global w_jg_reuniones_listados w_jg_reuniones_listados

forward prototypes
public function integer wf_generar_listado_voluminoso ()
end prototypes

public function integer wf_generar_listado_voluminoso ();//Esta funci$$HEX1$$f300$$ENDHEX$$n la utilizaremos para poder introducir los campos del datawindos 
//external 
datastore ds_jg_reuniones_ordinarias
datastore ds_jg_reuniones_ordinarias_horas
integer i,fila
double hora
datetime dia
string num_dia,sql,dia_s,sql_horas


// Creamos el datastore para tener 
ds_jg_reuniones_ordinarias_horas = create datastore
ds_jg_reuniones_ordinarias_horas.dataobject = 'ds_jg_reuniones_ordinarias_horas'
ds_jg_reuniones_ordinarias_horas.SetTransobject(sqlca)
sql_horas= ds_jg_reuniones_ordinarias_horas.describe("Datawindow.Table.Select")
//Completamos la consulta para q nos salgan los datos correctos.
f_sql('jg_reuniones.fecha','>','f_desde',dw_listados,sql_horas,'1','')
f_sql('jg_reuniones.fecha','<=','f_hasta',dw_listados,sql_horas,'1','')

ds_jg_reuniones_ordinarias_horas.modify("datawindow.table.select= ~"" + sql_horas+ "~"")

// Recuperamos
IF ds_jg_reuniones_ordinarias_horas.retrieve()<1 then 
	//Destrouimos el datastore y salimos
	destroy ds_jg_reuniones_ordinarias_horas
	return 0
END IF

// Creamos el datastore para tener 
ds_jg_reuniones_ordinarias = create datastore
ds_jg_reuniones_ordinarias.dataobject = 'ds_jg_reuniones_ordinarias'
ds_jg_reuniones_ordinarias.SetTransobject(sqlca)
sql= ds_jg_reuniones_ordinarias.describe("Datawindow.Table.Select")

//Completamos la consulta para q nos salgan los datos correctos.
f_sql('jg_reuniones.fecha','>','f_desde',dw_listados,sql,'1','')
f_sql('jg_reuniones.fecha','<=','f_hasta',dw_listados,sql,'1','')
//f_sql('jg_reuniones.tipo','LIKE','tipo',dw_listados,sql,'1','')
//f_sql('jg_reuniones.tema','LIKE','tema',dw_listados,sql,'1','')
//f_sql('jg_reuniones.lugar','LIKE','lugar',dw_listados,sql,'1','')
//
ds_jg_reuniones_ordinarias.modify("datawindow.table.select= ~"" + sql+ "~"")

// Recuperamos
IF ds_jg_reuniones_ordinarias.retrieve()<1 then 
	//Destrouimos el datastore y salimos
	destroy ds_jg_reuniones_ordinarias
	return 0
END IF

fila = dw_1.insertRow(0)
FOR i = 1 TO ds_jg_reuniones_ordinarias_horas.RowCount()
	// Obtenemos el d$$HEX1$$ed00$$ENDHEX$$a 	
		dia=ds_jg_reuniones_ordinarias_horas.GetItemDateTime(i,'fecha')
		num_dia=string(day(date(dia)))
	// Aplicamos un filtro para que solo salgan los que tengan cargo de PRESIDENTE DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='01' and fecha=date('"+string(dia,'dd/mm/yy')+"')")
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then 
			dw_1.setItem(fila,'dia_p'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_p'+string(num_dia), hora)
		end if
	// Aplicamos un filtro para que solo salgan los que tengan cargo de SECRETARIOS DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='02' and fecha=date('"+string(dia,'dd/mm/yy')+"')")
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount()>0 then		
			dw_1.setItem(fila,'dia_s'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_s'+string(num_dia), hora)
		end if
		// Aplicamos un filtro para que solo salgan los que tengan cargo de TESOREROS DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='03' and fecha=date('"+string(dia,'dd/mm/yy')+"')")
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount()>0 then		
			dw_1.setItem(fila,'dia_t'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_t'+string(num_dia), hora)
		end if
	// Aplicamos un filtro para que solo salgan los que tengan cargo de LIBERALES DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='04' and fecha=date('"+string(dia,'dd/mm/yy')+"')")
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then		
			dw_1.setItem(fila,'dia_l'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_l'+string(num_dia), hora)
		end if			
	// Aplicamos un filtro para que solo salgan los que tengan cargo de ASALARIADOS DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='05' and	fecha=date('"+string(dia,'dd/mm/yy')+"')")	
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then		
			dw_1.setItem(fila,'dia_a'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_a'+string(num_dia), hora)
		end if			
	// Aplicamos un filtro para que solo salgan los que tengan cargo de MUTUA DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='06' and fecha=date('"+string(dia,'dd/mm/yy')+"')")	
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then		
			dw_1.setItem(fila,'dia_m'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_m'+string(num_dia), hora)
		end if 		
	// Aplicamos un filtro para que solo salgan los que tengan cargo de FUNCIONARIOS DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='07' and fecha=date('"+string(dia,'dd/mm/yy')+"')")	
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then		
			dw_1.setItem(fila,'dia_f'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_f'+string(num_dia), hora)
		end if 			
	// Aplicamos un filtro para que solo salgan los que tengan cargo de CONTADOR DE LA MISMA FECHA
		ds_jg_reuniones_ordinarias.setfilter("cargo='08' and fecha=date('"+string(dia,'dd/mm/yy')+"')")
		ds_jg_reuniones_ordinarias.filter()
		iF ds_jg_reuniones_ordinarias.rowcount() >0 then		
			dw_1.setItem(fila,'dia_c'+string(num_dia), num_dia)
			hora=ds_jg_reuniones_ordinarias.GetItemNumber(1,'total_horas')
			dw_1.setItem(fila,'hora_c'+string(num_dia), hora)
		end if





NEXT


return dw_1.rowcount()
end function

on w_jg_reuniones_listados.create
call super::create
end on

on w_jg_reuniones_listados.destroy
call super::destroy
end on

event open;call super::open;//Para relacionar los registros que se encuentran en la tabla de listados
dw_listados_varios.SetTrans(sqlca)
dw_listados_varios.retrieve(this.classname())
dw_listados_varios.SetRow(1)
end event

type cb_recuperar_pantalla from w_listados`cb_recuperar_pantalla within w_jg_reuniones_listados
end type

type cb_guardar_pantalla from w_listados`cb_guardar_pantalla within w_jg_reuniones_listados
end type

type cb_limpiar from w_listados`cb_limpiar within w_jg_reuniones_listados
end type

type dw_listados_varios from w_listados`dw_listados_varios within w_jg_reuniones_listados
end type

type cb_ver from w_listados`cb_ver within w_jg_reuniones_listados
fontcharset fontcharset = ansi!
end type

event cb_ver::clicked;call super::clicked;string sql
string listado, descripcion
date f_desde, f_hasta

dw_listados.Accepttext()
dw_1.of_SetPrintPreview(TRUE)

//Asignar objeto dw en funcion de la fila seleccionada de la dw dw_listados_varios
listado = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'dw')
descripcion = dw_listados_varios.GetItemString(dw_listados_varios.GetRow(),'descripcion')
dw_1.dataobject = listado

dw_1.of_settransobject(sqlca)
sql = dw_1.describe("Datawindow.Table.Select")

f_desde = date(dw_listados.getitemdatetime(1, 'f_desde'))
f_hasta = date(dw_listados.getitemdatetime(1, 'f_hasta'))
string cadena_arg = 'Fechas : '
if not isnull(f_desde) then cadena_arg += 'Desde ' + string(f_desde)
if not isnull(f_hasta) then cadena_arg += ' hasta ' + string(f_hasta)

CHOOSE CASE listado
	CASE 'd_jg_reuniones_ordinarias_listados'
		dw_1.object.mes_anyo.text = cadena_arg
		// Es un listado external, por lo que llamamos a una funci$$HEX1$$f300$$ENDHEX$$n para que haga los honores
		if wf_generar_listado_voluminoso()<0 then return
	
	CASE  'd_jg_reuniones_extraordinarias_listados'
		dw_1.object.mes_anyo.text = cadena_arg
	//	Completamos la consulta para q nos salgan los datos correctos.
		f_sql('jg_reuniones.fecha','>=','f_desde',dw_listados,sql,'1','')
		f_sql('jg_reuniones.fecha','<','f_hasta',dw_listados,sql,'1','')
		f_sql('jg_reuniones.tipo','LIKE','tipo',dw_listados,sql,'1','')
		f_sql('jg_reuniones.tema','LIKE','tema',dw_listados,sql,'1','')
		f_sql('jg_reuniones.lugar','LIKE','lugar',dw_listados,sql,'1','')
	
		dw_1.SetTransobject(sqlca)
		dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
		dw_1.retrieve()
	case 'd_jg_reuniones_listado_resumen'		
		dw_1.object.mes_anyo.text = cadena_arg
		dw_1.SetTransobject(sqlca)
		f_sql('jg_reuniones.fecha','>=','f_desde',dw_listados,sql,'1','')
		f_sql('jg_reuniones.fecha','<','f_hasta',dw_listados,sql,'1','')		
		dw_1.modify("datawindow.table.select= ~"" + sql+ "~"")
		dw_1.retrieve()		
		dw_1.groupcalc()
	
END CHOOSE


//Al final:
if dw_1.RowCount() > 0 then
	dw_1.event pfc_printpreview()
	dw_1.visible = true
	this.enabled = false
	cb_zoom.enabled = true
	cb_imprimir.enabled = true
	cb_guardar.enabled = true
	cb_escala.enabled  = true
	cb_ordenar.enabled  = true
else
	messagebox(g_titulo,'No se han encontrado registros seg$$HEX1$$fa00$$ENDHEX$$n las especificaciones.')
end if	

end event

type cb_salir from w_listados`cb_salir within w_jg_reuniones_listados
end type

type dw_listados from w_listados`dw_listados within w_jg_reuniones_listados
integer x = 64
integer y = 208
integer height = 616
string dataobject = "d_jg_reuniones_consulta"
end type

event dw_listados::csd_oculta();call super::csd_oculta;this.object.tipo.visible = false
this.object.lugar.visible = false		
this.object.lugar_t.visible = false			
this.object.tema.visible = false		
this.object.tema_t.visible = false			

end event

event dw_listados::itemchanged;call super::itemchanged;choose case dwo.name
	case 'mes'
		datetime f_desde
		string mes
		mes = data
		
		f_desde = datetime(date('01/'+mes+'/'+string(year(today()))), time('00:00:00'))
		this.setitem(1, 'f_desde', f_desde)
		this.setitem(1, 'f_hasta', f_ultimo_dia_mes(f_desde))
		
end choose
end event

type cb_imprimir from w_listados`cb_imprimir within w_jg_reuniones_listados
end type

type cb_zoom from w_listados`cb_zoom within w_jg_reuniones_listados
end type

type cb_esp from w_listados`cb_esp within w_jg_reuniones_listados
end type

type cb_guardar from w_listados`cb_guardar within w_jg_reuniones_listados
end type

type cb_escala from w_listados`cb_escala within w_jg_reuniones_listados
end type

type cb_ordenar from w_listados`cb_ordenar within w_jg_reuniones_listados
end type

type dw_listados_titulo from w_listados`dw_listados_titulo within w_jg_reuniones_listados
end type

type dw_1 from w_listados`dw_1 within w_jg_reuniones_listados
integer width = 3607
end type

