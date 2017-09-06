HA$PBExportHeader$pfc_n_cst_sql.sru
$PBExportComments$PFC Base SQL service
forward
global type pfc_n_cst_sql from n_base
end type
end forward

global type pfc_n_cst_sql from n_base autoinstantiate
end type

forward prototypes
public function string of_assemble (n_cst_sqlattrib astr_sql[])
public function integer of_parse (string as_sql, ref n_cst_sqlattrib astr_sql[])
end prototypes

public function string of_assemble (n_cst_sqlattrib astr_sql[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Assemble
//
//	Access: 			public
//
//	Arguments:
//	astr_sql[]		Array of sql attributes, each element containing a
//						SQL statement that will be joined with an UNION.
//
//	Returns:  		String
//						The function returns an empty string if an error
//						was encountered.
//
//	Description:	Build a SQL statement from its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_NumStats, li_Cnt
String	ls_SQL

li_NumStats = UpperBound(astr_sql[])

For li_Cnt = 1 to li_NumStats

	// Check for valid data
	If Trim(astr_sql[li_Cnt].s_Verb) = "" Or &
		Trim(astr_sql[li_Cnt].s_Tables) = "" Then
		Return ""
	End if

	// If there is more than one statement in the array, they are SELECTs that
	// should be joined by a UNION
	If li_Cnt > 1 Then
		ls_SQL = ls_SQL + " UNION "
	End if

	ls_SQL = ls_SQL + astr_sql[li_Cnt].s_Verb

	If astr_sql[li_Cnt].s_Verb = "SELECT" Then
		If Trim(astr_sql[li_Cnt].s_Columns) = "" Then
			Return ""
		Else
			ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Columns + &
						" FROM " + astr_sql[li_Cnt].s_Tables
		End if

	Else
		ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Tables

		If astr_sql[li_Cnt].s_Verb = "UPDATE" Then
			ls_SQL = ls_SQL + " SET " + astr_sql[li_Cnt].s_Columns
		Elseif Trim(astr_sql[li_Cnt].s_Columns) <> "" Then
			ls_SQL = ls_SQL + " " + astr_sql[li_Cnt].s_Columns
		End if
	End if

	If Trim(astr_sql[li_Cnt].s_Values) <> "" Then
		ls_SQL = ls_SQL + " VALUES " + astr_sql[li_Cnt].s_Values
	End if

	If Trim(astr_sql[li_Cnt].s_Where) <> "" Then
		ls_SQL = ls_SQL + " WHERE " + astr_sql[li_Cnt].s_Where
	End if

	If Trim(astr_sql[li_Cnt].s_Group) <> "" Then
		ls_SQL = ls_SQL + " GROUP BY " + astr_sql[li_Cnt].s_Group
	End if

	If Trim(astr_sql[li_Cnt].s_Having) <> "" Then
		ls_SQL = ls_SQL + " HAVING " + astr_sql[li_Cnt].s_Having
	End if

	If Trim(astr_sql[li_Cnt].s_Order) <> "" Then
		ls_SQL = ls_SQL + " ORDER BY " + astr_sql[li_Cnt].s_Order
	End if
Next

Return ls_SQL

end function

public function integer of_parse (string as_sql, ref n_cst_sqlattrib astr_sql[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Parse
//
//	Access: 			public
//
//	Arguments:
//	as_SQL			The SQL statement to parse.
//	astr_sql[]		An array of sql attributes, passed by
//						reference, to be filled with the parsed SQL.
//
//	Returns:  		integer
//						The number of elements in the array.
//
//	Description:	Parse a SQL statement into its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Pos, li_KWNum, li_NumStats, li_Cnt
String	ls_UpperSQL, ls_Keyword[7], ls_Clause[7], ls_SQL[]

// Function requires the string service
n_cst_string  lnv_string

// Separate the statement into multiple statements separated by UNIONs
li_NumStats = lnv_string.of_ParseToArray(as_SQL, "UNION", ls_SQL)

For li_Cnt = 1 to li_NumStats
	// Remove Carriage returns, Newlines, and Tabs
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~r", " ")
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~n", " ")
	ls_SQL[li_Cnt] = lnv_string.of_GlobalReplace(ls_SQL[li_Cnt], "~t", " ")

	// Remove leading and trailing spaces
	ls_SQL[li_Cnt] = Trim(ls_SQL[li_Cnt])

	// Convet to upper case
	ls_UpperSQL = Upper(ls_SQL[li_Cnt])

	// Determine what type of SQL this is
	// and assign the appropriate kewords
	// for the corresponding type
	If LeftA(ls_UpperSQL, 7) = "SELECT " Then
		// Parse the SELECT statement
		ls_Keyword[1] = "SELECT "
		ls_Keyword[2] = " FROM "
		ls_Keyword[3] = " WHERE "
		ls_Keyword[4] = " GROUP BY "
		ls_Keyword[5] = " HAVING "
		ls_Keyword[6] = " ORDER BY "

	Elseif LeftA(ls_UpperSQL, 7) = "UPDATE " Then
		// Parse the UPDATE statement
		ls_Keyword[1] = "UPDATE "
		ls_Keyword[2] = " SET "
		ls_Keyword[3] = " WHERE "
		ls_Keyword[6] = " ORDER BY "

	Elseif LeftA(ls_UpperSQL, 12) = "INSERT INTO " Then
		// Parse the INSERT statement (test before 'insert')
		ls_Keyword[1] = "INSERT INTO "
		ls_Keyword[7] = " VALUES "
		
	Elseif LeftA(ls_UpperSQL, 7) = "INSERT " Then
		// Parse the INSERT statement (test after 'insert to')
		ls_Keyword[1] = "INSERT "
		ls_Keyword[7] = " VALUES "		

	Elseif LeftA(ls_UpperSQL, 12) = "DELETE FROM " Then
		// Parse the DELETE statement (test before 'delete')
		ls_Keyword[1] = "DELETE FROM "
		ls_Keyword[3] = " WHERE "

	Elseif LeftA(ls_UpperSQL, 7) = "DELETE " Then
		// Parse the DELETE statement (test after 'delete from')
		ls_Keyword[1] = "DELETE "
		ls_Keyword[3] = " WHERE "
		
	End if

	// There is a maximum of 7 keywords
	For li_KWNum = 7 To 1 Step -1
		If ls_Keyword[li_KWNum] <> "" Then
			// Find the position of the Keyword
			li_Pos = PosA(ls_UpperSQL, ls_Keyword[li_KWNum]) - 1

			If li_Pos >= 0 Then
				ls_Clause[li_KWNum] = RightA(ls_SQL[li_Cnt], &
													(LenA(ls_SQL[li_Cnt]) - &
														(li_Pos + LenA(ls_Keyword[li_KWNum]))))
				ls_SQL[li_Cnt] = LeftA(ls_SQL[li_Cnt], li_Pos)
			Else
				ls_Clause[li_KWNum] = ""
			End if
		End if
	Next

	astr_sql[li_Cnt].s_Verb = Trim(ls_Keyword[1])

	If PosA(astr_sql[li_Cnt].s_Verb, "SELECT") > 0 Then
		astr_sql[li_Cnt].s_Columns = Trim(ls_Clause[1])
		astr_sql[li_Cnt].s_Tables 	= Trim(ls_Clause[2])
	Else
		astr_sql[li_Cnt].s_Tables = Trim(ls_Clause[1])

		If PosA(astr_sql[li_Cnt].s_Verb, "INSERT") > 0 Then
			li_Pos = PosA(astr_sql[li_Cnt].s_Tables, " ")
			If li_Pos > 0 Then
				astr_sql[li_Cnt].s_Columns = Trim(RightA(astr_sql[li_Cnt].s_Tables, &
											(LenA(astr_sql[li_Cnt].s_Tables) - li_Pos)))
				astr_sql[li_Cnt].s_Tables = LeftA(astr_sql[li_Cnt].s_Tables, (li_Pos - 1))
			End if
		Else
			astr_sql[li_Cnt].s_Columns = Trim(ls_Clause[2])
		End if
	End if

	astr_sql[li_Cnt].s_Where 	= Trim(ls_Clause[3])
	astr_sql[li_Cnt].s_Group 	= Trim(ls_Clause[4])
	astr_sql[li_Cnt].s_Having 	= Trim(ls_Clause[5])
	astr_sql[li_Cnt].s_Order 	= Trim(ls_Clause[6])
	astr_sql[li_Cnt].s_Values 	= Trim(ls_Clause[7])
Next

Return li_NumStats

end function

on pfc_n_cst_sql.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_sql.destroy
TriggerEvent( this, "destructor" )
end on
