HA$PBExportHeader$u_csd_string.sru
forward
global type u_csd_string from nonvisualobject
end type
end forward

global type u_csd_string from nonvisualobject
end type
global u_csd_string u_csd_string

forward prototypes
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase)
public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string)
public function string of_reemplaza (string principal, string vieja, string nueva, string modo)
end prototypes

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = Len(as_Delimiter)

ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = Mid (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  Pos(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = Mid (as_source, ll_start, Len (as_source))

// Update array and counter if necessary
if Len (ls_holder) > 0 then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

//Return the number of entries found
Return ll_Count

end function

public function long of_countoccurrences (string as_source, string as_target, boolean ab_ignorecase);Long	ll_Count, ll_Pos, ll_Len

//Check for parameters
If IsNull(as_source) or IsNull(as_target) or IsNull(ab_ignorecase) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Should function ignore case?
If ab_ignorecase Then
	as_source = Lower(as_source)
	as_target = Lower(as_target)
End If

ll_Len = Len(as_Target)
ll_Count = 0

ll_Pos = Pos(as_source, as_Target)

Do While ll_Pos > 0
	ll_Count ++
	ll_Pos = Pos(as_source, as_Target, (ll_Pos + ll_Len))
Loop

Return ll_Count

end function

public function long of_arraytostring (string as_source[], string as_delimiter, boolean ab_processempty, ref string as_ref_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ArrayToString
//
//	Access:  		public
//
//	Arguments:
//	as_source[]		 The array of string to be moved into a single string.
//	as_Delimiter	 The delimeter string.
//	ab_processempty Whether to process empty string as_source members.
//	as_ref_string	 The string to be filled with the array of strings,
//						 passed by reference.
//
//	Returns:  		long
//						1 for a successful transfer.
//						-1 if a problem was found.
//
//	Description:  	Create a single string from an array of strings separated by
//						the passed delimeter.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	7.0   Initial version
//			Overloaded an existing of_arraytostring to optionally allow processing 
//			of empty string arguments.
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

long		ll_Count, ll_ArrayUpBound

//Get the array size
ll_ArrayUpBound = UpperBound(as_source[])

//Check parameters
IF IsNull(as_delimiter) or (Not ll_ArrayUpBound>0) Then
	Return -1
End If

//Reset the Reference string
as_ref_string = ''

If Not ab_processempty Then
	For ll_Count = 1 to ll_ArrayUpBound
		// Do not include any entries that match an empty string 
		If as_source[ll_Count] <> '' Then
			If Len(as_ref_string) = 0 Then
				//Initialize string
				as_ref_string = as_source[ll_Count]
			else
				//Concatenate to string
				as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
			End If
		End If
	Next 
Else
	For ll_Count = 1 to ll_ArrayUpBound
		// Include any entries that match an empty string 
		If ll_Count = 1 Then
			//Initialize string
			as_ref_string = as_source[ll_Count]
		else
			//Concatenate to string
			as_ref_string = as_ref_string + as_delimiter + as_source[ll_Count]
		End If
	Next 
End If
return 1

end function

public function string of_reemplaza (string principal, string vieja, string nueva, string modo);//Esta funci$$HEX1$$f300$$ENDHEX$$n sustituye todas las ocurrencias de "vieja" por "nueva" dentro de "principal"
//	MODO => 'PRIMERA'   Si s$$HEX1$$f300$$ENDHEX$$lo queremos reemplazar la PRIMERA ocurrencia
//				  'TODAS'   Si queremos reemplazar TODAS las ocurrencias
// Ver f_reemplaza

long j, lprincipal, lvieja, i = 1
string cadena

cadena = principal
lprincipal = len(cadena)
lvieja = len(vieja)

if lprincipal = 0 or lvieja = 0 then return cadena

string aux1, aux2

DO WHILE i > 0
	i = pos(cadena, vieja, i)
	if i > 0 then
		aux1 = left(cadena,i - 1)
		aux2 = right(cadena,lprincipal - i - lvieja + 1)
		cadena = left(cadena,i - 1) + nueva + right(cadena,lprincipal - i - lvieja + 1)
		lprincipal = len(cadena)
		// Al colocar la nueva cadena hay que descontarla de la b$$HEX1$$fa00$$ENDHEX$$squeda
		i = i + len(nueva) - 1
	// Si s$$HEX1$$f300$$ENDHEX$$lo queremos reemplazar la PRIMERA ocurrencia, salimos...
		if modo = 'PRIMERA' THEN EXIT
	end if
LOOP

return cadena

end function

on u_csd_string.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_csd_string.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

