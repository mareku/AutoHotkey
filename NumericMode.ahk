;======================================================================
;数字&記号入力
; sc079 = 変換キー
;======================================================================
;;qwertyuiopキー
sc079 & q::SendPlay,{`!}
sc079 & w::
  if GetKeyState("Ctrl", "P")
    SendPlay,{`"}{`"}{Left}
  else
    SendPlay,{`"}
    return
sc079 & e::SendPlay,{`#}
sc079 & r::SendPlay,{`$}
sc079 & t::SendPlay,{`%}
sc079 & y::SendPlay,{`&}
sc079 & u::SendPlay,{`'}
sc079 & i::
  if GetKeyState("Ctrl", "P")
    SendPlay,{(}{)}{Left}
  else
    SendPlay,{(}
  return
sc079 & o::SendPlay,{)}
sc079 & p::SendPlay,{`-}

;;asdfghjkl;:]キー
sc079 & a::SendPlay,{1}
sc079 & s::SendPlay,{2}
sc079 & d::SendPlay,{3}
sc079 & f::SendPlay,{4}
sc079 & g::SendPlay,{5}
sc079 & h::SendPlay,{6}
sc079 & j::SendPlay,{7}
sc079 & k::SendPlay,{8}
sc079 & l::SendPlay,{9}
sc079 & sc027::SendPlay,{0}

;;zxcvbnm,./\キー
sc079 & x::SendPlay,{`=}
sc079 & c::SendPlay,{^}
sc079 & v::SendPlay,{`~}
sc079 & b::SendPlay,{`|}
sc079 & n::SendPlay,{`\}
sc079 & m::SendPlay,{`%}
sc079 & ,::SendPlay,{`#}
sc079 & .::SendPlay,{`'}

;; [{「キーまとめ
sc079 & [::
  if GetKeyState("Ctrl", "P")
    SendPlay,{{}{}}{Left}
  ;else if GetkeyState("Shift", "P")
    ;SendPlay,{「}{」}
  else
    SendPlay,{[}{]}{Left}
  return

