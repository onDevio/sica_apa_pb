HA$PBExportHeader$u_zip.sru
forward
global type u_zip from nonvisualobject
end type
end forward

global type u_zip from nonvisualobject
event compress ( )
event uncompress ( )
end type
global u_zip u_zip

type variables
private:
oleobject zip, oFile, Files
public:
u_dw idw_1
string ruta_zip
string ruta_destino
end variables

event compress;long i
int retorno1, retorno2, retorno3
zip = create oleobject
retorno1 = zip.ConnectToNewObject("SAWZip.Archive")
zip.create(ruta_zip)

Files = create oleobject
retorno3 = Files.ConnectToNewObject("SAWZip.Files")
Files = zip.Files

for i = 1 to idw_1.rowcount()
	oFile = create oleobject
	retorno2 = oFile.ConnectToNewObject("SAWZip.File")	
	oFile.Name = idw_1.getitemstring(i, 'path')
	Files.Add(oFile)
next
zip.close()

destroy zip
destroy files
destroy oFile
end event

event uncompress;long i
int retorno1, retorno2, retorno3
zip = create oleobject
retorno1 = zip.ConnectToNewObject("SAWZip.Archive")

zip.Open(ruta_zip)

for i = 1 to zip.files.count
	zip.Files.Item(i -1).extract(ruta_destino)
next
zip.close()

destroy zip

end event

on u_zip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_zip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

