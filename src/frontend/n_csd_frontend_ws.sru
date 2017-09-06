HA$PBExportHeader$n_csd_frontend_ws.sru
forward
global type n_csd_frontend_ws from nonvisualobject
end type
end forward

global type n_csd_frontend_ws from nonvisualobject
end type
global n_csd_frontend_ws n_csd_frontend_ws

type variables
private SoapConnection cnn	
private fr_wsintegracionsicasoap px_frontend_ws
end variables

forward prototypes
public function integer of_actualizar_n_registro (string referencia_web, string n_registro)
public function integer of_actualizar_n_exp (string referencia_web, string n_exp)
public function integer of_actualizar_n_visado (string referencia_web, string n_visado)
public function integer of_actualizar_f_visado (string referencia_web, datetime f_visado)
public function integer of_actualizar_f_abono (string referencia_web, datetime f_abono)
public function integer of_actualizar_f_entrada (string referencia_web, datetime f_entrada)
public function integer of_actualizar_todo (string referencia_web, string n_reg, string n_exp, string n_visado, datetime f_entrada, datetime f_visado, datetime f_abono)
public function integer of_crear_conexion ()
end prototypes

public function integer of_actualizar_n_registro (string referencia_web, string n_registro);int res
datetime f_nula
datetime fecha
SetNull(f_nula)


fecha=datetime(date('06/01/2009'))
try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,n_registro,'','','','','')	
	//integracionsicafew ( string usuario, string password, string colegio, string referencia, string n_reg_entrada, string n_expediente, string n_visado, datetime f_entrada, datetime f_visado_tecnico, datetime f_visado_entrada )  returns long
	//res=px_frontend_ws.integracionsicafew('','','',referencia_web,n_registro,'8','9',string(fecha,'dd/mm/yyyy'),string(fecha,'dd/mm/yyyy'),string(fecha,'dd/mm/yyyy'))	
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_n_exp (string referencia_web, string n_exp);long ll_valor
int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,'',n_exp,'','','','')	
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_n_visado (string referencia_web, string n_visado);int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,'','',n_visado,'','','')	
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_f_visado (string referencia_web, datetime f_visado);long ll_valor
int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,'','','','',string(f_visado,'dd/mm/yyyy'),'')	
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_f_abono (string referencia_web, datetime f_abono);long ll_valor
int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,'','','','','',string(f_abono,'dd/mm/yyyy')	)
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_f_entrada (string referencia_web, datetime f_entrada);long ll_valor
int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,'','','',string(f_entrada,'dd/mm/yyyy'),'','')	
Catch (Throwable ProcessError)
	MessageBox("Error","Error al actualizar la referencia."+ProcessError.GetMessage(),StopSign!)
	return -1
end try

return res
end function

public function integer of_actualizar_todo (string referencia_web, string n_reg, string n_exp, string n_visado, datetime f_entrada, datetime f_visado, datetime f_abono);int res

try
	res=px_frontend_ws.integracionsicafew('','','',referencia_web,n_reg,n_exp,n_visado,string(f_entrada,'dd/mm/yyyy'),string(f_visado,'dd/mm/yyyy'),string(f_abono,'dd/mm/yyyy')	)

Catch (Throwable ProcessError)
	// Lo intentamos dos veces. La primera a veces falla
	try
		res=px_frontend_ws.integracionsicafew('','','',referencia_web,n_reg,n_exp,n_visado,string(f_entrada,'dd/mm/yyyy'),string(f_visado,'dd/mm/yyyy'),string(f_abono,'dd/mm/yyyy')	)
	catch (Throwable ProcessError2)
		MessageBox("Error","Error al actualizar la referencia."+ProcessError2.GetMessage(),StopSign!)
		return -1
	end try
end try

return res
end function

public function integer of_crear_conexion ();long ll_valor
string connstring

select texto into :connstring from var_globales where nombre='g_few_soap_url';

if f_es_vacio(connstring) then return -100

try
	ll_valor 	= cnn.CreateInstance(px_frontend_ws, "fr_wsintegracionsicasoap",connstring)
catch (Throwable ex)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n")
	return -101
end try

return 0
end function

on n_csd_frontend_ws.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_csd_frontend_ws.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;cnn=create SoapConnection
end event

