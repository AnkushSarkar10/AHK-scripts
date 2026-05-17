#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
DetectHiddenWindows True


; Block the default action of the Win key to prevent the Start menu
LWin::return
RWin::return

LWin Up::HandleWinUp("LWin")
RWin Up::HandleWinUp("RWin")

HandleWinUp(key) {
    if (A_PriorKey = key)
        ToggleTaskbar()
}

ToggleTaskbar() {
    main := WinExist("ahk_class Shell_TrayWnd")
    if !main
        return

    visible := WinGetStyle("ahk_id " main) & 0x10000000

    taskbars := [main]
    for hwnd in WinGetList("ahk_class Shell_SecondaryTrayWnd")
        taskbars.Push(hwnd)

    if visible {
        for hwnd in taskbars
            WinHide "ahk_id " hwnd
    } else {
        for hwnd in taskbars
            WinShow "ahk_id " hwnd
        WinActivate "ahk_id " main
    }
}