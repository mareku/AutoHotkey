count:=1
#b::
Loop {
 #IfWinActive ahk_class hspwnd0
  Sleep,100
  if getkeystate("Ctrl", "P")
    break
  
  SendPlay,{t}
  Sleep,100
  SendPlay,{Enter}
  Sleep,3000
  SendPlay,{g}
  Sleep,100
  SendPlay,{Enter}
  count++
  ;52
  if (count>52) {
    Sleep,100
    SendPlay,{e}
    Sleep,100
    SendPlay,{Enter}
    Sleep,3000
    count:=1
  }
 #IfWinActive
}
return
