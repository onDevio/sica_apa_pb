HA$PBExportHeader$n_sepa_ws_consumption.sru
forward
global type n_sepa_ws_consumption from nonvisualobject
end type
end forward

global type n_sepa_ws_consumption from nonvisualobject
end type
global n_sepa_ws_consumption n_sepa_ws_consumption

type variables

end variables

forward prototypes
public function integer of_get_adeudo_file (string as_ruta_fichero, string as_ruta_fichero_xml)
public function integer of_get_transf_file (string as_ruta_fichero, string as_ruta_fichero_xml)
end prototypes

public function integer of_get_adeudo_file (string as_ruta_fichero, string as_ruta_fichero_xml);adeudosrequest lst_ar
adeudosresponse lst_ad_resp
int li_fnum
long ll_valor
string connstring, ls_user, ls_pass
SoapConnection cnn	
sepaportservice px_sepa_ws

cnn=create SoapConnection

//connstring="http://192.168.6.37:8088/ws"
connstring=f_var_global('ruta_sepa_service')

li_fnum=fileopen(as_ruta_fichero,TextMode! )
if(li_fnum<0) then 
	messagebox("Error","Error leyendo el fichero: "+as_ruta_fichero,StopSign!)
	return -1
end if

FileReadEx(li_fnum, lst_ar.inputtext)
FileClose ( li_fnum )
	
ls_user = f_var_global('COLEGIO') + '.' + f_var_global('g_sepa_habilitado')
ls_pass = f_var_global('g_sepa_ISO20022_habilitado')	

cnn.setOptions("UserID='" + ls_user +"'")
cnn.setOptions("Password='" + ls_pass +"'")
cnn.setOptions("AuthenticationMode='basic'")

try
	ll_valor 	= cnn.CreateInstance(px_sepa_ws, "sepaportservice", connstring)	
catch (Throwable ex)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n")
	return -101
end try

choose case string(ll_valor)
	case '100'
		MessageBox("Error","Invalid Proxy name")
	return -100
	case '101'
		MessageBox("Error","Failed to create proxy")
	return -100	
	//case '0' //Succesful	
end choose

try
	lst_ad_resp = px_sepa_ws.adeudos(lst_ar)
Catch (Throwable ProcessError)
	MessageBox("Error","Consumiendo servicio transformaci$$HEX1$$f300$$ENDHEX$$n adeudos."+ProcessError.GetMessage(),StopSign!)
	return -1
end try


integer li_file_num_resp

li_file_num_resp = FileOpen(as_ruta_fichero_xml, TextMode!, Write!, LockWrite!, Append!)

if(li_file_num_resp<0) then 
	messagebox("Error","Error en la creaci$$HEX1$$f300$$ENDHEX$$n del fichero en formato XML: "+as_ruta_fichero,StopSign!)
	return -1
end if

try 
	FileWriteEx(li_file_num_resp, lst_ad_resp.outputxml)
Catch (Throwable ProcessError2)	
	messagebox("Error","Error en la escritura del fichero en formato XML: "+ProcessError2.GetMessage(),StopSign!)
return -1
end try

return 0	


end function

public function integer of_get_transf_file (string as_ruta_fichero, string as_ruta_fichero_xml);transferenciasrequest lst_tr
transferenciasresponse lst_transf_resp
int li_fnum
long ll_valor
string connstring, ls_user, ls_pass
SoapConnection cnn	
sepaportservice px_sepa_ws

cnn=create SoapConnection

//connstring="http://192.168.6.37:8088/ws"
connstring=f_var_global('ruta_sepa_service')

li_fnum=fileopen(as_ruta_fichero,TextMode! )
if(li_fnum<0) then 
	messagebox("Error","Error leyendo el fichero: "+as_ruta_fichero,StopSign!)
	return -1
end if

FileReadEx(li_fnum, lst_tr.inputtext)
	
ls_user = f_var_global('COLEGIO') + '.' + f_var_global('g_sepa_habilitado')
ls_pass = f_var_global('g_sepa_ISO20022_habilitado')	

//cnn.setOptions("UserID=~"user1~"")
//cnn.setOptions("Password~"user1~"")
cnn.setOptions("UserID=" + ls_user)
cnn.setOptions("Password=" + ls_pass)


try
	ll_valor 	= cnn.CreateInstance(px_sepa_ws, "sepaportservice", connstring)	
catch (Throwable ex)
	MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!","Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al crear la conexi$$HEX1$$f300$$ENDHEX$$n")
	return -101
end try

choose case string(ll_valor)
	case '100'
		MessageBox("Error","Invalid Proxy name")
	return -100
	case '101'
		MessageBox("Error","Failed to create proxy")
		return -100
	//case '0' //Succesful	
end choose

try
	lst_transf_resp = px_sepa_ws.transferencias(lst_tr)
Catch (Throwable ProcessError)
	MessageBox("Error","Consumiendo servicio transformaci$$HEX1$$f300$$ENDHEX$$n adeudos."+ProcessError.GetMessage(),StopSign!)
	return -1
end try


integer li_file_num_resp

li_file_num_resp = FileOpen(as_ruta_fichero_xml, TextMode!, Write!, LockWrite!, Append!)

if(li_file_num_resp<0) then 
	messagebox("Error","Error en la creaci$$HEX1$$f300$$ENDHEX$$n del fichero en formato XML: "+as_ruta_fichero,StopSign!)
	return -1
end if

try 
	FileWriteEx(li_file_num_resp, lst_transf_resp.outputxml)
Catch (Throwable ProcessError2)	
	messagebox("Error","Error en la escritura del fichero en formato XML: "+ProcessError2.GetMessage(),StopSign!)
return -1
end try

return 0	
end function

on n_sepa_ws_consumption.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_sepa_ws_consumption.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

