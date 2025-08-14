#Requires AutoHotkey v2.0

; --- Встраиваем mp3 файлы ---
FileInstall "bhop_on.mp3", A_Temp "\bhop_on.mp3", 1
FileInstall "bhop_off.mp3", A_Temp "\bhop_off.mp3", 1

; --- Запуск CS2 через Steam ---
Run "steam://rungameid/730"

; --- Глобальная переменная ---
global bhop_enabled := false

; --- F1 включает/выключает bhop ---
F1::
{
    bhop_enabled := !bhop_enabled
    if bhop_enabled
    {
        SoundPlay A_Temp "\bhop_on.mp3"
        Send "{F7}"
    }
    else
    {
        SoundPlay A_Temp "\bhop_off.mp3"
        Send "{F8}"
    }
}

; --- Прокачка пробела ---
*Space::
{
    if !bhop_enabled
    {
        Send "{Space down}"
        KeyWait "Space"
        Send "{Space up}"
    }
    else
    {
        Send "{F5}" ; fps max 64
        while GetKeyState("Space", "P")
        {
            Send "{Space}"
            Sleep 20
        }
        Send "{F6}" ; fps max 0
    }
}
