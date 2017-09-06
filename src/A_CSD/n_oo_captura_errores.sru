HA$PBExportHeader$n_oo_captura_errores.sru
$PBExportComments$Hereda de OLEObject y permite ignorar los errores producidos al acceder a las aplicaciones externas.
forward
global type n_oo_captura_errores from n_oo
end type
end forward

global type n_oo_captura_errores from n_oo
end type
global n_oo_captura_errores n_oo_captura_errores

type variables
private:
boolean i_capturar = false

public:
unsignedlong i_resultcode = 0
unsignedlong i_exceptioncode = 0
string i_source = ""
string i_description = ""

end variables

forward prototypes
public subroutine of_capturar_errores (boolean capturar)
public subroutine of_reset_error ()
end prototypes

public subroutine of_capturar_errores (boolean capturar);i_capturar = capturar

of_reset_error()

end subroutine

public subroutine of_reset_error ();i_resultcode = 0
i_exceptioncode = 0
i_source = ""
i_description = ""

end subroutine

on n_oo_captura_errores.create
call super::create
end on

on n_oo_captura_errores.destroy
call super::destroy
end on

event externalexception;call super::externalexception;if i_capturar then
	i_resultcode = resultcode
	i_exceptioncode = exceptioncode
	i_source = source
	i_description = description
	action = ExceptionIgnore!
end if

end event

