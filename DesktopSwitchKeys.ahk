#Requires AutoHotkey v2.0
#SingleInstance Force

; Pause switches to the virtual desktop on the right.
; Scroll Lock switches to the virtual desktop on the left.
Pause::Send "^#{Right}"
ScrollLock::Send "^#{Left}"
