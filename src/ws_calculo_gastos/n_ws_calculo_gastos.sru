HA$PBExportHeader$n_ws_calculo_gastos.sru
forward
global type n_ws_calculo_gastos from nonvisualobject
end type
end forward

global type n_ws_calculo_gastos from nonvisualobject
end type
global n_ws_calculo_gastos n_ws_calculo_gastos

type variables
SoapConnection i_cnn
calculateportservice i_service
end variables

forward prototypes
public function any of_calcular_gastos (calculaterequest as_datos_calculo)
public function integer of_crear_conexion ()
end prototypes

public function any of_calcular_gastos (calculaterequest as_datos_calculo);keyvalue l_key[]	


try 
	
l_key = i_service.calculate(as_datos_calculo)

Catch (Throwable ProcessError)
	//MessageBox("Error","Error en la llamada al servicio actualizaci$$HEX1$$f300$$ENDHEX$$n datos plataforma."+ProcessError.GetMessage(),StopSign!)
	//gnv_app.Event log_message("Web Service Calculo de Gastos", "Error en la llamada al servicio de Calculo de Gastos."+ProcessError.GetMessage())
	gnv_app.of_logmessage(1, "Web Service Calculo de Gastos", "Error en la llamada al servicio de Calculo de Gastos."+ProcessError.GetMessage())
end try

return l_key
end function

public function integer of_crear_conexion ();long ll_valor
string ls_connString, ls_user, ls_pass
i_cnn=create SoapConnection

//connstring="http://192.168.6.37:8088/ws"
ls_connString=f_var_global('ruta_WS_calculo_gastos')

ls_user = f_var_global('COLEGIO') + '.' + f_var_global('g_sepa_habilitado')
ls_pass = f_var_global('g_sepa_ISO20022_habilitado')	

//i_cnn.setOptions("UserID='user1'")
//i_cnn.setOptions("Password='user1'")
i_cnn.setOptions("UserID='" + ls_user +"'")
i_cnn.setOptions("Password='" + ls_pass +"'")
i_cnn.setOptions("AuthenticationMode='basic'")

try
	ll_valor 	= i_cnn.CreateInstance(i_service, "Calculateportservice", ls_connString)	
catch (Throwable ex)
		//MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n")
//		gnv_app.Event log_message("Web Service Calculo de Gastos", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n al WebService")
		gnv_app.of_logmessage(1, "Web Service Calculo de Gastos", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n al WebService")
	return -101
end try

choose case string(ll_valor)
	case '100'
		//MessageBox("Error","Invalid Proxy name")
		//gnv_app.Event log_message("Web Service Calculo de Gastos", "Invalid Proxy name")
		gnv_app.of_logmessage(1, "Web Service Calculo de Gastos", "Invalid Proxy name")
	return -100
	case '101'
		//MessageBox("Error","Failed to create proxy")
		//gnv_app.Event log_message("Web Service Calculo de Gastos", "Failed to create proxy")
		gnv_app.of_logmessage(1, "Web Service Calculo de Gastos", "Failed to create proxy")
	return -100	
	//case '0' //Succesful	
end choose

destroy i_cnn
return 0
end function

on n_ws_calculo_gastos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ws_calculo_gastos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

