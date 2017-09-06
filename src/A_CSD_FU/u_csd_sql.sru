HA$PBExportHeader$u_csd_sql.sru
$PBExportComments$Funciones de gesti$$HEX1$$f300$$ENDHEX$$n de SQLs~r~nIncluido por compatibilidad con c$$HEX1$$f300$$ENDHEX$$digo extra$$HEX1$$ed00$$ENDHEX$$do de aplicaciones que usan las nuevas PFCs
forward
global type u_csd_sql from nonvisualobject
end type
end forward

global type u_csd_sql from nonvisualobject
end type
global u_csd_sql u_csd_sql

type variables
string is_ultima_consulta = ''
boolean ib_acumular_resultados = false
end variables

forward prototypes
public function string of_string_permitir_comillas (ref string dato)
public function string of_sql (string as_sql_origen, string as_joins[])
public function string of_sql (string as_campo_en_tabla, string as_operador, string as_campo_en_dw, datawindow a_dw_consulta, ref string as_sql_orig, string as_bd, string as_parametro)
end prototypes

public function string of_string_permitir_comillas (ref string dato);return f_string_permitir_comillas(dato)
end function

public function string of_sql (string as_sql_origen, string as_joins[]);return f_sql_join(as_sql_origen, as_joins)
end function

public function string of_sql (string as_campo_en_tabla, string as_operador, string as_campo_en_dw, datawindow a_dw_consulta, ref string as_sql_orig, string as_bd, string as_parametro);return f_sql(as_campo_en_tabla, as_operador, as_campo_en_dw, a_dw_consulta, as_sql_orig, as_bd, as_parametro)

end function

on u_csd_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_csd_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

