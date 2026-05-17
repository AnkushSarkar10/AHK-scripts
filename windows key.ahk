#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
DetectHiddenWindows True

; On Win down: inject a no-op virtual key in the same input sequence so
; Windows treats Win as a modifier and doesn't open Start on release.
~LWin::Send "{Blind}{vkE8}"
~RWin::Send "{Blind}{vkE8}"

; On Win up: if nothing else was pressed in between, toggle.
~LWin Up::HandleWinUp("LWin")
~RWin Up::HandleWinUp("RWin")

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