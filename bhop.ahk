SetWorkingDir %A_ScriptDir%

; --- Встраиваем mp3 файлы ---
FileInstall, bhop_on.mp3, %A_Temp%\bhop_on.mp3, 1
FileInstall, bhop_off.mp3, %A_Temp%\bhop_off.mp3, 1

; --- Запуск CS2 через Steam ---
Run, steam://rungameid/730

; --- Ждем, пока CS2 реально запустится ---
Loop {
    Process, Exist, cs2.exe
    if (ErrorLevel)  ; процесс найден
        break
    Sleep, 1000
}

; --- Запуск таймера проверки процесса каждые 2 секунды ---
SetTimer, CheckGame, 2000

CheckGame:
Process, Exist, cs2.exe
if (!ErrorLevel)  ; процесс не найден — закрываем скрипт
{
    ExitApp
}
return

; --- Глобальная переменная для bhop ---
global bhop_enabled := false

; --- F1 включает/выключает bhop ---
F1::
{
    global bhop_enabled
    bhop_enabled := !bhop_enabled
    if (bhop_enabled) {
        SoundPlay, %A_Temp%\bhop_on.mp3
        Send, {F7}
    } else {
        SoundPlay, %A_Temp%\bhop_off.mp3
        Send, {F8}
    }
}
return

; --- Space для прыжка ---
*Space::
{
    global bhop_enabled

    if (!bhop_enabled) {
        Send, {Space down}
        KeyWait, Space
        Send, {Space up}
        return
    }

    Send, {F5} ; fps max 64
    Loop {
        ;
        if (!bhop_enabled) {
            Send, {Space up}
            break
        }

        GetKeyState, state, Space, P
        if (state = "U")
            break

        Send, {Space}
        Sleep, 20
    }
    Send, {F6} ; fps max 0
}
return