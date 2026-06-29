#Requires AutoHotkey v2.0
#SingleInstance Force

; Page Up / Page Down control system volume.
; Hold Shift with the key to send the original Page Up / Page Down action.
PgUp::SoundSetVolume "+5"
PgDn::SoundSetVolume "-5"

+PgUp::Send "{PgUp}"
+PgDn::Send "{PgDn}"
