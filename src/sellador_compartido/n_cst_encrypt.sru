HA$PBExportHeader$n_cst_encrypt.sru
forward
global type n_cst_encrypt from nonvisualobject
end type
end forward

global type n_cst_encrypt from nonvisualobject
end type
global n_cst_encrypt n_cst_encrypt

type variables
string is_CRYPT_KEY="$%&?$%&/"
end variables

forward prototypes
public function string of_encrypt (string as_str)
public function string of_decrypt (string as_str)
public function string of_encrypt (string as_str, string as_crypt_key)
public function string of_decrypt (string as_str, string as_crypt_key)
end prototypes

public function string of_encrypt (string as_str);//////////////////////////////////////////////////////////////
//																				//
// Creado: Enrique Gordillo [26/05/2006]							//
//																				//
// Funcion of_encrypt(as_str)											//
// 																			//
// Argumentos: as_str -> cadena o texto a encriptar			//
//																				//
// Devuelve una cadena o texto encriptado con la clave		//
//		que se encuentra en g_CRYPT_KEY.								//
//																				//
//////////////////////////////////////////////////////////////

integer i, j
string ls_key, ls_enctext = ""
ls_key = is_CRYPT_KEY 

j = LenA(as_str)
FOR i = 1 TO j
    ls_enctext += MidA(ls_key , mod(i,5) + 1, 1)
    ls_enctext += String(CharA(255 - AscA(MidA(as_str, i, 1))))
NEXT

if ls_enctext='' then setnull(ls_enctext)

RETURN ls_enctext
end function

public function string of_decrypt (string as_str);//////////////////////////////////////////////////////////////
//																				//
// Creado: Enrique Gordillo [26/05/2006]							//
//																				//
// Funcion of_decrypt(as_tr)											//
// 																			//
// Argumentos: as_str -> cadena o texto a desencriptar		//
//																				//
// Devuelve una cadena o texto desencriptado con la clave	//
//		que se encuentra en g_CRYPT_KEY.								//
// Si ocurre un error, devuelve la cadena vac$$HEX1$$ed00$$ENDHEX$$a.				//
//																				//
//////////////////////////////////////////////////////////////

integer i, j
string ls_encchar, ls_dectext, ls_key
boolean lb_ok = true

ls_key = is_CRYPT_KEY 

j = LenA(as_str)

IF NOT Mod(j, 2) = 1 THEN
   ls_dectext = ""
   FOR i = 2 TO (j + 1) STEP 2
      ls_encchar = MidA(as_str, i - 1, 1)
      IF MidA(ls_key, Mod(i / 2, 5) + 1, 1) <> ls_encchar THEN
        lb_ok = FALSE
        EXIT
      END IF     
      ls_encchar = MidA(as_str, i, 1)
      ls_dectext += string(CharA(255 - AscA(ls_encchar)))
   NEXT
END IF

IF NOT lb_ok THEN 
	messagebox('ERROR', "** Encryption Error")
	RETURN ''
END IF

if ls_dectext='' then setnull(ls_dectext)

RETURN ls_dectext
end function

public function string of_encrypt (string as_str, string as_crypt_key);//////////////////////////////////////////////////////////////
//																			//
// Creado: Javier Boluda [30/05/2012]							//
//																			//
// Funcion of_encrypt(as_str, as_crypt_key)						//
// 																			//
// Argumentos: as_str -> cadena o texto a encriptar			//
//					as_crypt_key -> cadena de encriptaci$$HEX1$$f300$$ENDHEX$$n		//
// Devuelve una cadena o texto encriptado con la clave		//
//		facilitada.														//
//																			//
//////////////////////////////////////////////////////////////

integer i, j
string ls_key, ls_enctext = ""
ls_key = as_crypt_key 

j = LenA(as_str)
FOR i = 1 TO j
    ls_enctext += MidA(ls_key , mod(i,5) + 1, 1)
    ls_enctext += String(CharA(255 - AscA(MidA(as_str, i, 1))))
NEXT

if ls_enctext='' then setnull(ls_enctext)

RETURN ls_enctext
end function

public function string of_decrypt (string as_str, string as_crypt_key);//////////////////////////////////////////////////////////////
//																			//
// Creado: Javier Boluda [30/05/2012]							//
//																			//
// Funcion of_decrypt(as_str, as_crypt_key)						//
// 																			//
// Argumentos: as_str -> cadena o texto a encriptar			//
//					as_crypt_key -> cadena de encriptaci$$HEX1$$f300$$ENDHEX$$n		//
// Devuelve una cadena o texto desencriptado con la clave	//
//		facilitada.														//
//																			//
//////////////////////////////////////////////////////////////

integer i, j
string ls_encchar, ls_dectext, ls_key
boolean lb_ok = true

ls_key = as_crypt_key 

j = LenA(as_str)

IF NOT Mod(j, 2) = 1 THEN
   ls_dectext = ""
   FOR i = 2 TO (j + 1) STEP 2
      ls_encchar = MidA(as_str, i - 1, 1)
      IF MidA(ls_key, Mod(i / 2, 5) + 1, 1) <> ls_encchar THEN
        lb_ok = FALSE
        EXIT
      END IF     
      ls_encchar = MidA(as_str, i, 1)
      ls_dectext += string(CharA(255 - AscA(ls_encchar)))
   NEXT
END IF

IF NOT lb_ok THEN 
	messagebox('ERROR', "** Encryption Error")
	RETURN ''
END IF

if ls_dectext='' then setnull(ls_dectext)

RETURN ls_dectext
end function

on n_cst_encrypt.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_encrypt.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

