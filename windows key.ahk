#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
DetectHiddenWindows True

HandleWin(key) {
    ; fake keypress
    Send "{Blind}{vkE8}"

    ; only trigger when win key pressed by itself
    if (A_PriorKey = key) {
        ToggleTaskbar()
    }
}

ToggleTaskbar() {
    main := WinExist("ahk_class Shell_TrayWnd")
    if !main
        return

    ; bool
    visible := WinGetStyle("ahk_id " main) & 0x10000000 

    ; get all taskbars (all monitors)
    taskbars := []
    taskbars.Push(main)

    for hwnd in WinGetList("ahk_class Shell_SecondaryTrayWnd") {
        taskbars.Push(hwnd)
    }

    ; toggle
    if visible {
        for hwnd in taskbars {
            WinHide "ahk_id " hwnd
        }
    } else {
        for hwnd in taskbars {
            WinShow "ahk_id " hwnd
        }
    }
    
    ; focus taskbar when shown
    WinActivate "ahk_id " main
}