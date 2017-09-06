HA$PBExportHeader$nca_folderbrowse.sru
$PBExportComments$Browse For Folder V1.2
forward
global type nca_folderbrowse from nonvisualobject
end type
type shitemid from structure within nca_folderbrowse
end type
type itemidlist from structure within nca_folderbrowse
end type
type browseinfo from structure within nca_folderbrowse
end type
end forward

type shitemid from structure
	unsignedint		cb
	character		abid
end type

type itemidlist from structure
	shitemid		mkid
end type

type browseinfo from structure
	unsignedlong		howner
	unsignedlong		pidlroot
	string		pszdisplayname
	string		lpsztitle
	unsignedint		ulflags
	unsignedlong		lpfn
	long		lparam
	integer		iimage
end type

global type nca_folderbrowse from nonvisualobject autoinstantiate
end type

type prototypes
Protected:
Function unsignedlong SHGetPathFromIDListA( unsignedlong pidl, ref string pszPath) Library 'shell32' alias for "SHGetPathFromIDListA;Ansi"
Function unsignedlong SHBrowseForFolderA( browseinfo lpbrowseinfo ) Library 'shell32' alias for "SHBrowseForFolderA;Ansi"
Subroutine CoTaskMemFree(ulong idlist) Library 'ole32'
end prototypes
type variables
Protected:
unsignedLong BIF_RETURNONLYFSDIRS =  1
end variables

forward prototypes
public function string browseforfolder (window awi_parent, string as_caption)
end prototypes

public function string browseforfolder (window awi_parent, string as_caption);
/********************************************************************
	BrowseForFolder
	
	<DESC>	Open the browse for folder dialog and return the
				selected directory.</DESC>
	
	<RETURN>	String: Folder Selected.</RETURN>

	<ACCESS>	Public

	<ARGS>	awi_Parent: Parent Window.
				as_Caption: Caption to display on dialog.</ARGS>

	<USAGE>	lnca_BFF.BrowseForFolder( parent, 'caption!' )</USAGE>
	
********************************************************************/
browseinfo lstr_bi
itemidlist lstr_idl
unsignedlong ll_pidl
unsignedlong ll_r
Integer li_pos
String ls_Path
unsignedlong ll_Null

SetNull( ll_Null )


lstr_bi.hOwner = Handle( awi_Parent )
lstr_bi.pidlRoot = 0
lstr_bi.lpszTitle = as_caption
lstr_bi.ulFlags = bif_ReturnOnlyFSDirs
lstr_bi.pszDisplayName = Space( 255 )
lstr_bi.lpfn = ll_Null

ll_pidl = SHBrowseForFolderA( lstr_bi )

ls_Path = Space( 255 )
ll_R = SHGetPathFromIDListA( ll_pidl, ls_Path )

CoTaskMemFree( ll_pidl )

//cambia_directorio.of_changedirectory(directorio)

RETURN ls_Path
end function

on nca_folderbrowse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nca_folderbrowse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
/********************************************************************
	nca_FolderBrowse: Display a folder selection dialog. <EXCLUDE>

	<OBJECT>	Access the win32 API and open the Browse For Folder
				Dialog. Then return the name of the folder selected.
				</OBJECT>

	<USAGE>	nca_browseforfolder lnca_BFF
	
				ls_Folder = lnca_BFF.BrowseForFolder( parent, 'Pick folder' )
				</USAGE>

	<AUTHOR>	<A HREF="mailto:khowe@pbdr.com">Ken Howe</A>

	  Date	Ref	Author			Comments
	07/16/98	1		Ken Howe			First Version
	08/24/98	1.1	Matthew Royle	Changed to work with PB5.0
	06/03/99 1.2	Ken Howe			Added CoTaskMemFree, based on a
											Discussion on the PB News group and
											also this ise used in many VB examples.
********************************************************************/
// This is a code example:
/*
nva_folderbrowse lnca_bff
String ls_A

ls_A = lnca_BFF.BrowseForFolder( parent, 'pick your folder' )
MessageBox( 'You Picked', ls_A )
*/

end event

