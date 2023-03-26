#include-once
#include <constants.au3>
;Global Const $PROCESS_ALL_ACCESS = 0x000F0000 + 0x00100000
;Global Const $MUTEX_ALL_ACCESS = 0x1F0001
;Global Const $DUPLICATE_CLOSE_SOURCE = 0x00000001
Global $hMutex

func _MutexCreate($mutex, byref $hMutex)
dim $ERROR_ALREADY_EXISTS = 183
dim $LastError, $closehandle
dim $retval
$hMutex = DllCall("kernel32.dll", "long", "CreateMutexA", "ptr", 0, "int", 1, "str", $mutex)
$LastError = DllCall("kernel32.dll", "long", "GetLastError")
if $LastError[0] = $ERROR_ALREADY_EXISTS then
$closehandle = DllCall("kernel32.dll", "int", "CloseHandle", "long", $hMutex[0])
$retval = 0
else
$retval = 1
endif
return $retval
endFunc
func ReleaseMutex($MutexName)

local $hMutexOpen = _MutexOpen($MutexName)
if $hMutexOpen = 0 then return SetError(1, 0, 0)
$hMutex = DllCall("kernel32.dll", "BOOL", "ReleaseMutex", "HWND", $hMutexOpen)
If IsArray($hMutex)Then Return $hMutex[0]
Return SetError(DllCall("kernel32.dll", "long", "GetLastError")[0], 0, 0)
endFunc
Func _MutexOpen($MutexName)
Local $hMutex = DllCall("kernel32.dll", "hwnd", "OpenMutex", "int", $MUTEX_ALL_ACCESS, "int", 0, "str", $MutexName)
If IsArray($hMutex) And $hMutex[0] Then Return $hMutex[0]
Return SetError(DllCall("kernel32.dll", "long", "GetLastError")[0], 0, 0)
EndFunc


Func _MutexExists($MutexName)
Local $hMutex = DllCall("Kernel32.dll", "hwnd", "OpenMutex", "int", 0x1F0001, "int", 1, "str", $MutexName)
Local $aGLE = DllCall("Kernel32.dll", "int", "GetLastError")
If IsArray($hMutex) And $hMutex[0] Then DllCall("Kernel32.dll", "int", "CloseHandle", "hwnd", $hMutex[0])
If IsArray($aGLE) And $aGLE[0] = 127 Then Return 1
Return SetError(DllCall("kernel32.dll", "long", "GetLastError")[0], 0, 0)
EndFunc
