;;無変換+hoge
;カーソル移動
vk1Dsc079 & h::withShiftKey("Left")
vk1Dsc079 & j::withShiftKey("Down")
vk1Dsc079 & k::withShiftKey("Up")
vk1Dsc079 & l::withShiftKey("Right")

;行頭へ移動
vk1Dsc079 & a::withShiftKey("Home")
;行末へ移動
vk1Dsc079 & e::withShiftKey("End")

;一画面移動
vk1Dsc079 & f::SendPlay,{PgDn}
vk1Dsc079 & b::SendPlay,{PgUp}

vk1Dsc079 & d::
  If GetKeyState("Ctrl", "P")
    SendPlay,{Delete}
  else
    SendPlay,{BS}
return

;切り取り
vk1Dsc079 & x::SendPlay,{Shift down}{Delete}{Shift up}  ;切り取り
;コピー
vk1Dsc079 & c::SendPlay,{Ctrl down}{Insert}{Ctrl up}  ;コピー
;貼り付け
vk1Dsc079 & v::SendPlay,{Shift down}{Insert}{Shift up}  ;貼り付け

;Enter
vk1Dsc079 & m::withShiftKey("Enter")

;Esc
vk1Dsc079 & [::SendPlay,{Esc}
;CapsLock=ESC
vkF0sc03A::SendPlay,{Esc}

;Tab
vk1Dsc079 & i::withShiftKey("TAB")

;ひらがな=半角/全角
vkF2sc070::Send,{vkF3sc029}

;無変換+ひらがな=再変換
vk1Dsc079 & z::SendPlay,{Ctrl Down}{BS}{Ctrl Up}

withShiftKey(keyName){
  modifier:=""
  GetKeyState, state, Ctrl
  if(state="D")
  	modifier:=modifier . "^"
  GetKeyState, state, Alt
  if(state="D")
  	modifier:=modifier . "!"
  GetKeyState, state, Shift
  if(state="D")
  	modifier:=modifier . "+"
  SendPlay, %modifier%{%keyName%}
  return
}


