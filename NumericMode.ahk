;======================================================================
;数字&記号入力
; vk1Csc079 = 変換キー
;======================================================================
;;qwertyuiopキー
vk1Csc079 & q::SendPlay,{`!}
vk1Csc079 & w::
  if GetKeyState("Ctrl", "P")
    SendPlay,{`"}{`"}{Left}
  else
    SendPlay,{`"}
  return
vk1Csc079 & e::SendPlay,{`#}
vk1Csc079 & r::SendPlay,{`$}
vk1Csc079 & t::SendPlay,{`%}
vk1Csc079 & y::SendPlay,{`&}
vk1Csc079 & u::SendPlay,{`'}
vk1Csc079 & i::
  if GetKeyState("Ctrl", "P")
    SendPlay,{(}{)}{Left}
  else
    SendPlay,{(}
  return
vk1Csc079 & o::SendPlay,{)}
vk1Csc079 & p::SendPlay,{`-}

;;asdfghjkl;:]キー
vk1Csc079 & a::SendPlay,{1}
vk1Csc079 & s::SendPlay,{2}
vk1Csc079 & d::SendPlay,{3}
vk1Csc079 & f::SendPlay,{4}
vk1Csc079 & g::SendPlay,{5}
vk1Csc079 & h::SendPlay,{6}
vk1Csc079 & j::SendPlay,{7}
vk1Csc079 & k::SendPlay,{8}
vk1Csc079 & l::SendPlay,{9}
vk1Csc079 & vkBBsc027::SendPlay,{0}

;;zxcvbnm,./\キー
vk1Csc079 & x::SendPlay,{`=}
vk1Csc079 & c::SendPlay,{^}
vk1Csc079 & v::SendPlay,{`~}
vk1Csc079 & b::SendPlay,{`|}
vk1Csc079 & n::SendPlay,{`\}
vk1Csc079 & m::SendPlay,{`%}
vk1Csc079 & ,::SendPlay,{`#}
vk1Csc079 & .::SendPlay,{`'}

;; [{「キーまとめ
vk1Csc079 & [::
  if GetKeyState("Ctrl", "P")
    SendPlay,{{}{}}{Left}
  ;else if GetkeyState("Shift", "P")
    ;SendPlay,{「}{」}
  else
    SendPlay,{[}{]}{Left}
  return

