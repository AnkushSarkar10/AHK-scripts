; Block Tab key when taskbar is focused
$Tab::HandleTab()

HandleTab() {
    if WinActive("ahk_class Shell_TrayWnd")
        return
    Send "{Tab}"
}

#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
DetectHiddenWindows True

+LWin::return
+LWin UP::ToggleTaskbar()

HandleWinUp(key) {
    if (A_PriorKey = key)
        ToggleTaskbar()
}

; Shell_SecondaryTrayWnd
; Shell_TrayWnd
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
        ; Do not activate the taskbar to avoid auto-selecting tray icon
    }
}