global bhop_enabled := true ; 

; 
F1::
    bhop_enabled := !bhop_enabled ; 
    if (bhop_enabled) {
        ToolTip, ON 10, 10
    } else {
        ToolTip, OFF 10, 10
    }
    SetTimer, RemoveToolTip, -2000 ;
return

;
*space::
    ;
    if (!bhop_enabled)
    {
        Send, {Space}
        return
    }

    ;
    Send, {F5} ;
    
    Loop
    {
        GetKeyState, state, Space, P
        if (state = "U") ;
            break
        
        Send, {Space} ;
        Sleep, 20
    }
    
    Send, {F6} ;
return

RemoveToolTip:
    ToolTip
return
