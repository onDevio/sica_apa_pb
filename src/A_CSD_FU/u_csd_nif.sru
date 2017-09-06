HA$PBExportHeader$u_csd_nif.sru
forward
global type u_csd_nif from nonvisualobject
end type
end forward

global type u_csd_nif from nonvisualobject autoinstantiate
end type

type variables
boolean mensajes=true
string i_letra
string i_nif
integer cod_error
end variables

forward prototypes
private function string of_calcula_letra_nif (string num_dni)
public function string of_obtener_tipo_doc (string nif)
public function string of_comprobar_documento (string nif, string tipo_documento)
public function string of_valida_nif (string nif_introducido)
public function integer old_of_comprobar_nif (string nif, string pais, string tipo_persona)
private function integer old_of_nif_ok (string nif)
public function string old_of_formatear_nif (string nif)
public function string of_valida_nie (string nif_introducido)
public function string of_valida_cif (string cif)
public function boolean of_valida_cif_modulo (string cadena, character letra, string tipo)
public subroutine of_error ()
end prototypes

private function string of_calcula_letra_nif (string num_dni);string dig

 dig=MidA("TRWAGMYFPDXBNJZSQVHLCKET",Mod(double(num_dni),23)+1,1)


return dig
end function

public function string of_obtener_tipo_doc (string nif);// Comprobamos que el nif tenga caracteres validos
string tipo_doc='DESCONOCIDO'
string numeros, letras, letras_per_fis
boolean no_reconocido,reconocido=true
long i,num,letra
string primer_digito_nif
string primer_digito_cif

numeros='1234567890'
letras='TRWAGMYFPDXBNJZSQVHLCKE'

primer_digito_nif='LKXYM'
primer_digito_cif='ABCDEFGHJPQRSUVNW'

letra=0
num=0


// Contamos las letras y numeros.
// Si hay un simbolo que no sea numero o letra, devolvemos error
for i=1 to LenA(nif)
	if PosA(numeros,MidA(nif,i,1))>0 then 
		num++
		continue
	end if
	if PosA(letras,MidA(nif,i,1))>0 then 
		letra++
		continue
	end if
	reconocido=false
	exit	
next

if reconocido=false then return 'DESCONOCIDO'

if num=8 and letra=0 then return 'NIF'
if num=8 and letra=1 and pos(letras,right(nif,1))>0 then return 'NIF'
if num=8 and letra=1 and pos(primer_digito_cif,left(nif,1))>0 then return 'CIF'
if num=7 and letra=2 and pos(primer_digito_nif,left(nif,1))>0 and pos(letras,right(nif,1))>0 then return 'NIE'
if num=7 and letra=2 and pos(primer_digito_cif,left(nif,1))>0 and pos(letras,right(nif,1))>0 then return 'CIF'
if num=7 and letra=1 and pos(primer_digito_cif,left(nif,1))>0 then return 'CIF'
if num=7 and letra=1 and pos(primer_digito_nif,left(nif,1))>0 then return 'NIE'


return 'DESCONOCIDO'
end function

public function string of_comprobar_documento (string nif, string tipo_documento);string nif_mod

cod_error=0
nif_mod=nif

if tipo_documento='' then tipo_documento=of_obtener_tipo_doc(nif)


choose case tipo_documento
	case 'NIF','DN'
		nif_mod= of_valida_nif(nif)
	case 'NIE','NE'
		 nif_mod= of_valida_nie(nif)
	case 'CIF','CI'
		 nif_mod= of_valida_cif(nif)
	case 'PASAPORTE','PA'
		
	case else
		cod_error=-3
end choose

of_error()

return nif_mod
	
	
end function

public function string of_valida_nif (string nif_introducido);// COMPROBACION NIFs
//		- Si no lleva letra, le calcula la letra y se la a$$HEX1$$f100$$ENDHEX$$ade
//		- Si lleva letra, comprueba que la letra es correcta


string ult_caracter,letra_nif, primer_caracter,nif


nif=nif_introducido
ult_caracter = MidA(nif,LenA(nif),1)

if isnumber(ult_caracter)=false then
	nif =MidA(nif,1,LenA(nif)-1)
end if

letra_nif = of_calcula_letra_nif(nif)
i_nif=nif
i_letra=letra_nif
if not isnumber(ult_caracter) and letra_nif <> ult_caracter then 
	cod_error=-1
	//messagebox(g_titulo,"Letra del NIF incorrecta. La letra para el NIF "+nif+" es:"+upper(letra_nif),Information!)
else
	if LenA(nif_introducido)=8 then cod_error=-2 //messagebox(g_titulo,"La letra para el NIF "+nif_introducido+" es: "+upper(letra_nif))
end if
nif = nif + upper(letra_nif)

return nif
	
end function

public function integer old_of_comprobar_nif (string nif, string pais, string tipo_persona);/*
NIFs

  DNI 	Ocho n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	Espa$$HEX1$$f100$$ENDHEX$$oles con documento nacional de identidad asignado por el Ministerio del Interior
 NIF L 	L + 7 n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	Espa$$HEX1$$f100$$ENDHEX$$oles residentes en el extranjero sin DNI
 NIF K 	K + 7 n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	Espa$$HEX1$$f100$$ENDHEX$$oles menores de 14 a$$HEX1$$f100$$ENDHEX$$os
 NIF X 	X + 7 n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	Extranjeros identificados por la Polic$$HEX1$$ed00$$ENDHEX$$a con un n$$HEX1$$fa00$$ENDHEX$$mero de identidad de extranjero, NIE, asignado hasta el 15 de julio de 2008
 NIF Y 	Y + 7 n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	Extranjeros identificados por la Polic$$HEX1$$ed00$$ENDHEX$$a con un NIE, asignado desde el 16 de julio de 2008 (Orden INT/2058/2008, BOE del 15 de julio )
 NIF M 	M + 7 n$$HEX1$$fa00$$ENDHEX$$meros + d$$HEX1$$ed00$$ENDHEX$$gito de control 	NIF que otorga la Agencia Tributaria a extranjeros que no tienen NIE


 _ _ _ _ _ _ _ _   _
|_|_|_|_|_|_|_|_| |_|
 ^             ^   ^
 |__ N$$HEX1$$fa00$$ENDHEX$$meros __|    |
                              |
         Letra,una de las siguientes:
		 ( T,R,W,A,G,M,Y,F,P,D,X,B,N,J,Z,S,Q,V,H,L,C,K,E }
  
       _ _ _ _ _ _ _ _ 
|_| |_|_|_|_|_|_|_| |_|
 ^     ^                 ^    ^
  |     |_ N$$HEX1$$fa00$$ENDHEX$$meros _|     |
  |                               |
  |       Letra,una de las siguientes:
  |		 ( T,R,W,A,G,M,Y,F,P,D,X,B,N,J,Z,S,Q,V,H,L,C,K,E }
  |
  |		Letra,una de las siguientes:
  |----- L, K, X, Y, M
  
  
   
  
		 
CIFs

Letra 	Naturaleza jur$$HEX1$$ed00$$ENDHEX$$dica 	Comentario
A 	Sociedades an$$HEX1$$f300$$ENDHEX$$nimas		Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
B 	Sociedades de responsabilidad limitada 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
C 	Sociedades colectivas 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
D 	Sociedades comanditarias 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
E 	Comunidades de bienes y herencias yacentes 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
F 	Sociedades cooperativas 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
G 	Asociaciones 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
H 	Comunidades de propietarios en r$$HEX1$$e900$$ENDHEX$$gimen de propiedad horizontal 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
J 	Sociedades civiles, con o sin personalidad jur$$HEX1$$ed00$$ENDHEX$$dica 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
P 	Corporaciones Locales 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico
Q 	Organismos p$$HEX1$$fa00$$ENDHEX$$blicos 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico
R 	Congregaciones e instituciones religiosas 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico
S 	$$HEX1$$d300$$ENDHEX$$rganos de la Administraci$$HEX1$$f300$$ENDHEX$$n del Estado y de las Comunidades Aut$$HEX1$$f300$$ENDHEX$$nomas 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico
U 	Uniones Temporales de Empresas 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
V 	Otros tipos no definidos en el resto de claves 	Caracter de control: Num$$HEX1$$e900$$ENDHEX$$rico
N 	Entidades extranjeras 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico
W 	Establecimientos permanentes de entidades no residentes en Espa$$HEX1$$f100$$ENDHEX$$a 	Car$$HEX1$$e100$$ENDHEX$$cter de control: Alfab$$HEX1$$e900$$ENDHEX$$tico

 _   _ _ _ _ _ _ _   _
|_| |_|_|_|_|_|_|_| |_|
 ^   ^           ^   ^
 |   |_ N$$HEX1$$fa00$$ENDHEX$$meros _|   |
 |                   |
 |        D$$HEX1$$ed00$$ENDHEX$$gito de control,un n$$HEX1$$fa00$$ENDHEX$$mero $$HEX2$$f3002000$$ENDHEX$$letra:
 |        ( A $$HEX2$$f3002000$$ENDHEX$$1,B $$HEX2$$f3002000$$ENDHEX$$2,C $$HEX2$$f3002000$$ENDHEX$$3,D $$HEX2$$f3002000$$ENDHEX$$4,E $$HEX2$$f3002000$$ENDHEX$$5,F $$HEX2$$f3002000$$ENDHEX$$6,
 |          G $$HEX2$$f3002000$$ENDHEX$$7,H $$HEX2$$f3002000$$ENDHEX$$8,I $$HEX2$$f3002000$$ENDHEX$$9,J $$HEX2$$f3002000$$ENDHEX$$0 ]
 |
 Letra de tipo de Organizaci$$HEX1$$f300$$ENDHEX$$n,una de las siguientes:
 ( A,B,C,D,E,F,G,H,K,L,M,N,P,Q,S }

*/
// ********************************
// Eloy Brod$$HEX1$$ed00$$ENDHEX$$n 24/11/2006
// Funcion de comprobaci$$HEX1$$f300$$ENDHEX$$n de formatos de NIF
// ********************************

string numeros, letras, letras_per_fis
boolean no_reconocido,reconocido
long i,num,letra

numeros='1234567890'
letras='TRWAGMYFPDXBNJZSQVHLCKE'
letras_per_fis='LKXYM'

reconocido=true
letra=0
num=0


// Contamos las letras y numeros.
// Si hay un simbolo que no sea numero o letra, devolvemos error
if reconocido=true then	
	for i=1 to LenA(nif)
		if PosA(numeros,MidA(nif,i,1))>0 then 
			num++
			continue
		end if
		if PosA(letras,MidA(nif,i,1))>0 then 
			letra++
			continue
		end if
		reconocido=false
		exit	
	next
	
end if

//Realizamos la comprobaci$$HEX1$$f300$$ENDHEX$$n para los NIFs espa$$HEX1$$f100$$ENDHEX$$oles
if (pais='00055' or pais='055' or pais='' or IsNull(pais)) and reconocido then	
	choose case tipo_persona
		case 'S' //SOCIEDAD
			// Si la primera no es una letra, ERROR EN EL NIF
			if PosA(letras,LeftA(nif,1))<=0 then reconocido=false 
			// El NIF debe tener 7 numeros y dos letras o  8 numeros y una letra
			if num<>7 and num<>8 then reconocido=false
			if num=7 and letra<>2 then reconocido=false
			if num=8 and letra<>1 then reconocido=false		

		case 'P' //PERSONA
			// Si la ultima no es una letra, ERROR EN EL NIF
			if PosA(letras,RightA(nif,1))<=0 then reconocido=false 
			// El NIF debe tener 8 numeros y una sola letra. Pemitimos introducir en NIF sin letra para recalcularla.
			if num<>7 and num<>8 then reconocido=false
			if num=8 and letra>1 then reconocido=false
			if num=7 then
				if letra<>2 then reconocido=false
				if PosA(letras,leftA(nif,1))<=0 then reconocido= false
			end if
			
	
	end choose
end if

if reconocido then 
	return letra
else
	return -1
end if




end function

private function integer old_of_nif_ok (string nif);//FUNCION DE VERIFICACION DE NIF/CIF
//
//RETORNO:
//
//  1:  CIF/NIF CORRECTO
//  0:  CIF/NIF INCORRECTO
//

double retorno,acum,nvalor,n,na,num_dni
string vble,dig

if (MidA(nif,1,1)='1')or(MidA(nif,1,1)='2')or(MidA(nif,1,1)='3')or(MidA(nif,1,1)='4')or(MidA(nif,1,1)='5')or(MidA(nif,1,1)='6')or(MidA(nif,1,1)='7')or(MidA(nif,1,1)='8')or(MidA(nif,1,1)='9')or(MidA(nif,1,1)='0') then

//CALCULO DE LA LETRA DEL DNI

		num_dni=double(trim(MidA(nif,1,LenA(nif) - 1)))
		if num_dni=0 then
		   dig=""
		else
		  dig=MidA("TRWAGMYFPDXBNJZSQVHLCKET",Mod(num_dni,23)+1,1)
		end if

  		 if dig<>RightA(nif,1) then
	       retorno=-1
       else
          retorno=1
   	 end if

else

//CALCULO DEL DIGITO DEL NIF

   if (MidA(nif,LenA(nif),1)='1')or(MidA(nif,LenA(nif),1)='2')or(MidA(nif,LenA(nif),1)='3')or(MidA(nif,LenA(nif),1)='4')or(MidA(nif,LenA(nif),1)='5')or(MidA(nif,LenA(nif),1)='6')or(MidA(nif,LenA(nif),1)='7')or(MidA(nif,LenA(nif),1)='8')or(MidA(nif,LenA(nif),1)='9')or(MidA(nif,LenA(nif),1)='0') then

   		acum=0

        nif=MidA(nif,2,LenA(nif))
		//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 1
		  vble=MidA(nif,1,1)
		  nvalor=long(vble)
		  nvalor=nvalor*2
		  if nvalor<10 then
			  acum=acum+nvalor
		  else
		     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
		  end if 

		//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 3
		  vble=MidA(nif,3,1)
		  nvalor=long(vble)
		  nvalor=nvalor*2
		  if nvalor<10 then
		     acum=acum+nvalor
		  else
		     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
		  end if 

		//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 5
		  vble=MidA(nif,5,1)
		  nvalor=long(vble)
		  nvalor=nvalor*2
		  if nvalor<10 then
		     acum=acum+nvalor
		  else
		     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
		  end if 
  
		//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 7
		  vble=MidA(nif,7,1)
		  nvalor=long(vble)
		  nvalor=nvalor*2
		  if nvalor<10 then
			  acum=acum+nvalor
		  else
		     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
		  end if 


		  //TOTAL
		  vble=MidA(nif,2,1)
		  nvalor=long(vble)
		  acum=acum+nvalor 

		  vble=MidA(nif,4,1)
		  nvalor=long(vble)
		  acum=acum+nvalor

		  vble=MidA(nif,6,1)
		  nvalor=long(vble)
		  acum=acum+nvalor

		  acum=mod(acum,10)
		  if acum<>0 then acum=10 - acum


        if string(acum)<>RightA(nif,1) then
   	     retorno=-1      
        else
           retorno=1 
   	end if
	else

        choose case MidA(nif,LenA(nif),1)
          case 'A'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '1'
          case 'B'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '2' 
          case 'C'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '3' 
          case 'D'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '4' 
          case 'E'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '5' 
          case 'F'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '6' 
          case 'G'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '7' 
          case 'H'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '8' 
          case 'I'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '9' 
          case 'J'
              nif=trim(MidA(nif,1,LenA(nif) - 1)) + '0' 

        end choose

			acum=0

          nif=MidA(nif,2,LenA(nif))   
			//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 1
			  vble=MidA(nif,1,1)
			  nvalor=long(vble)
			  nvalor=nvalor*2
			  if nvalor<10 then
			     acum=acum+nvalor
			  else
			     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
			  end if 

			//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 3
			  vble=MidA(nif,3,1)
			  nvalor=long(vble)
			  nvalor=nvalor*2
			  if nvalor<10 then
			     acum=acum+nvalor
			  else
			     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
			  end if 

			//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 5
			  vble=MidA(nif,5,1)
			  nvalor=long(vble)
			  nvalor=nvalor*2
			  if nvalor<10 then
			     acum=acum+nvalor
			  else
			     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
			  end if 
  
			//Tomamos el d$$HEX1$$ed00$$ENDHEX$$gito 7
			  vble=MidA(nif,7,1)
			  nvalor=long(vble)
			  nvalor=nvalor*2
			  if nvalor<10 then
			     acum=acum+nvalor
			  else
			     acum=acum+long(LeftA(string(nvalor),1))+long(RightA(string(nvalor),1))
			  end if 
	

		  //TOTAL
			  vble=MidA(nif,2,1)
			  nvalor=long(vble)
			  acum=acum+nvalor 
	
			  vble=MidA(nif,4,1)
			  nvalor=long(vble)
			  acum=acum+nvalor

			  vble=MidA(nif,6,1)
			  nvalor=long(vble)
			  acum=acum+nvalor

			  acum=mod(acum,10)
			  if acum<>0 then acum=10 - acum

	        if string(acum)<>RightA(nif,1) then
   		     retorno=-1      
	        else
   	        retorno=1 
		  	  end if

    end if 

end if

return retorno
end function

public function string old_of_formatear_nif (string nif);//Devuelve un NIF formateado: (SOLO SI ES PERSONA FISICA)
//		- Si no lleva letra, le calcula la letra y se la a$$HEX1$$f100$$ENDHEX$$ade
//		- Si lleva letra, comprueba que la letra es correcta




string ult_caracter,letra_nif, primer_caracter,caracter_quitado=''

//Si la long del NIF es mayor de 8 caracteres NO LO MODIFICAMOS
//pq el nif espa$$HEX1$$f100$$ENDHEX$$ol es de 8 caracteres + 1 n$$HEX1$$fa00$$ENDHEX$$mero
if LenA(nif)>9 or LenA(nif)<8 then return nif

primer_caracter = LeftA(nif,1)
if not isnumber(primer_caracter) then return nif
/*
// SI LA PRIMERA LETRA NO ES NUMERO LA QUITAMOS PARA CALCULARLO
primer_caracter = LeftA(nif,1)
if not isnumber(primer_caracter) then 
	//return nif
	nif=mid(nif,2)
    caracter_quitado=primer_caracter
end if
*/

ult_caracter = MidA(nif,LenA(nif),1)

//Si el $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$fa00$$ENDHEX$$mero es n$$HEX1$$fa00$$ENDHEX$$mero, entonces es un DNI sin n$$HEX1$$fa00$$ENDHEX$$mero, sino hay que hacer la comprobaci$$HEX1$$f300$$ENDHEX$$n de nif

if isnumber(ult_caracter)=false then
	if OLD_of_nif_ok(nif)=1 then return nif
  //Tomamos solo el n$$HEX1$$fa00$$ENDHEX$$mero y le quitamos la letra para volv$$HEX1$$e900$$ENDHEX$$rsela a calcular

	nif =MidA(nif,1,LenA(nif)-1)
end if

letra_nif = of_calcula_letra_nif(nif)

if not isnumber(ult_caracter) and letra_nif <> ult_caracter then 
	messagebox(g_titulo,"Letra del NIF incorrecta. La letra para el NIF "+caracter_quitado+nif+" es:"+upper(letra_nif),Information!)
else
	if LenA(caracter_quitado+nif)=8 then messagebox(g_titulo,"La letra para el NIF "+caracter_quitado+nif+" es: "+upper(letra_nif))
end if
nif = caracter_quitado+nif + upper(letra_nif)

return nif
	
end function

public function string of_valida_nie (string nif_introducido);// COMPROBACION NIEs
//		- Si no lleva letra, le calcula la letra y se la a$$HEX1$$f100$$ENDHEX$$ade
//		- Si lleva letra, comprueba que la letra es correcta


string ult_caracter,letra_nif, primer_caracter='',nif


nif=nif_introducido
ult_caracter = MidA(nif,LenA(nif),1)
primer_caracter = Left(nif,1)

if not(isnumber(primer_caracter)) then
	nif=MidA(nif,2)	
end if

if not(isnumber(ult_caracter)) then
	nif =MidA(nif,1,LenA(nif)-1)
end if

letra_nif = of_calcula_letra_nif(nif)
i_nif=primer_caracter+nif
i_letra=letra_nif


if not isnumber(ult_caracter) and letra_nif <> ult_caracter then 
	cod_error=-1
	//messagebox(g_titulo,"Letra del NIF incorrecta. La letra para el NIF "+primer_caracter+nif+" es:"+upper(letra_nif),Information!)
else
	if LenA(nif_introducido)=8 then cod_error=-2 //messagebox(g_titulo,"La letra para el NIF "+nif_introducido+" es: "+upper(letra_nif))
end if
nif = primer_caracter+nif + upper(letra_nif)

return nif
end function

public function string of_valida_cif (string cif);//
boolean valido
long ll_cont
string cad
char letra

i_nif=cif
choose case left(cif,1)

CASE 'A','B','C','D','E','F','G','H','J','U','V' // ACABA EN N$$HEX1$$da00$$ENDHEX$$MERO
	// CASO CIF ESPA$$HEX1$$d100$$ENDHEX$$OL
	for ll_cont=2 to 8//Comprobamos las posiciones intermedias
		if not IsNumber(mid(cif,ll_cont,1)) then 
			cod_error=-3
			return cif
		end if
	next// comprobados que son numeros
	cad = mid(cif,2,7) // Separamos las dos partes
	letra = char(mid(cif,9,1))
	if IsNumber(letra) then // comprobar que lo ultimo es un N$$HEX1$$da00$$ENDHEX$$MERO
		if of_valida_cif_modulo(cad,letra,'N') then return cif
	else
		cod_error=-3
	end if

CASE 'P','Q','R','S','N','W'                    // ACABA EN LETRA					
	// CASO CIF ORG.OFICIALES  'P','Q','R','S'
	// CASO EMPRESAS NO RESIDENTES  'N','W'
	// caso IGUAL al ANTERIOR, SALVO la validaci$$HEX1$$f300$$ENDHEX$$n de la $$HEX1$$da00$$ENDHEX$$LTIMA POSICI$$HEX1$$d300$$ENDHEX$$N 
	
	for ll_cont=2 to 8//Comprobamos las posiciones intermedias
		if not IsNumber(mid(cif,ll_cont,1)) then
			cod_error=-3
			return cif
		end if
	next// comprobados que son numeros
	cad = mid(cif,2,7) // Separamos las dos partes
	letra = char(mid(cif,9,1))
	if NOT IsNumber(letra) then // comprobar que lo ultimo es un CARACTER
		if of_valida_cif_modulo(cad,letra,'A') then return cif
	else
		cod_error=-3
	end if
END CHOOSE





return cif
end function

public function boolean of_valida_cif_modulo (string cadena, character letra, string tipo);//RYC 4/1/05 f_valida_modulocif
// Funcion que valida si una letra es correcta en un nif 
// Parametros :   cadena:  numero para hacer el modulo
//                letra :  letra a comprobar
//                tipo  : numerico o alfanumerico  (N o A)

long acumulado,posicion,sumando
long contador,contadorsum,valor
long constante[]
character resultado
string validar
string aux
constante[1]=2
constante[2]=1
constante[3]=2
constante[4]=1
constante[5]=2
constante[6]=1
constante[7]=2

//// Recuperar CotextObject para acceso al Log de Jaguar
//errorlogging 	lerr_Log		
//GetContextService("ErrorLogging",lerr_Log)
//lerr_log.Log ( "----- Inicio de VALIDA MODULOCIF -------")
//lerr_log.Log ( "----- CADENA = "+cadena)
//lerr_log.Log ( "----- LETRA = "+letra)
//lerr_log.Log ( "----- TIPO = "+tipo)

if Len(cadena) <> 7 then return false // solo valido para cadenas de tama$$HEX1$$f100$$ENDHEX$$o 7
acumulado=0
//lerr_log.Log ( "----- MODULOCIF: Validamos caracter a caracter ")
// Recorremos los digitos para hacer el algoritmo
for contador=1 to 7
   valor = constante[contador] * long(mid(cadena,contador,1))
//lerr_log.Log ( "----- MODULOCIF: valor =  "+string(constante[contador])+" * "+ mid(cadena,contador,1) )		
	// sumamos las cifras
	sumando=0
	for contadorsum=1 to Len(string(valor))
		sumando=sumando + long(mid(string(valor),contadorsum,1))
	next
//lerr_log.Log ( "----- MODULOCIF: sumando = "+string(sumando))
	acumulado= acumulado + sumando
//lerr_log.Log ( "----- MODULOCIF: acumulado = "+string(acumulado))	
next
posicion=0   // tenemos que calcular las unidades hasta el proximo multiplo de 10
do while (mod(acumulado,10)<>0) 
posicion++
acumulado++
loop
CHOOSE CASE tipo   // Segun el tipo  
	CASE 'N'    //NUMERICO
		aux=letra
		if long(aux)=posicion then
			return true
		else
			//i_letra=letra
			//cod_error=-1
			//gnv_parametros.of_setparametro( 'tmp_num_cif', posicion)
		end if
   CASE 'A' 													 //ALFANUMERICO
		letra = Upper(letra)
		posicion++
      	validar = 'JABCDEFGHI'	
		
		resultado=mid(validar,posicion,1)
		if letra=resultado then
			return true
		else
		
			i_letra=resultado
			if trim(letra)='' then
				cod_error=-5
			else			
				cod_error=-4
			end if

		end if
END CHOOSE

return false
end function

public subroutine of_error ();string texto

choose case cod_error
	case -1
		texto="Letra del NIF incorrecta. La letra para el NIF "+i_nif+" es:"+upper(i_letra)
	case -2
		texto="La letra para el NIF "+i_nif+" es: "+upper(i_letra)
	case -3
		texto="El formato del NIF no es correcto. Compruebe que no tenga caracteres invalidos y que tenga la longitud correcta."
	case -4
		texto="Letra del CIF incorrecta. La letra para el CIF "+i_nif+" es:"+upper(i_letra)
	case -5
		texto="La letra para el CIF "+i_nif+" es: "+upper(i_letra)
		
end choose

if texto<>'' and not(IsNull(texto)) then
	if mensajes then
		MessageBox("Atenci$$HEX1$$f300$$ENDHEX$$n!",texto)
	end if
end if

end subroutine

on u_csd_nif.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_csd_nif.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

