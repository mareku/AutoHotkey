sc07B & 1::SendPlay,{Ctrl Down}{Home}{Ctrl Up}  ;1G

sc07B & q::SendPlay,!{F4} ;:q

sc07B & w::SendPlay,^{S}  ;:w

sc07B & e::Send,{Blind}{End}  ;$

sc07B & r::SendPlay,^{y}  ;ctrl+r

sc07B & t::SendPlay,{Shift Down}{End}{Shift Up}{Ctrl Down}{Insert}{Ctrl Up}  ;y$

sc07B & y::SendPlay,{Ctrl Down}{Insert}{Ctrl Up}  ;vy

sc07B & u::SendPlay,^{z}

sc07B & i::Send,{Blind}{Tab}

sc07B & o::SendPlay,{End}{Enter}

sc07B & p::SendPlay,^{v}

sc07B & [::SendPlay,{Esc}

sc07B & a::Send,{Blind}{Home}

sc07B & s::SendPlay,{Shift Down}{End}{Delete}{Shift Up}  ;D

sc07B & d::SendPlay,{Home}{Shift Down}{End}{Delete}{Shift Up}  ;dd

sc07B & f::SendPlay,{PgDn}  ;^f

sc07B & g::SendPlay,{Ctrl Down}{End}{Ctrl Up} ;G

;カーソル移動
;sc07B & h::modifierKey("Left")
;sc07B & j::modifierKey("Down")
;sc07B & k::modifierKey("Up")
;sc07B & l::modifierKey("Right")
sc07B & h::Send,{Blind}{Left}
sc07B & j::Send,{Blind}{Down}
sc07B & k::Send,{Blind}{Up}
sc07B & l::Send,{Blind}{Right}


sc07B & z::SendPlay,{Ctrl Down}{S}{Ctrl Up}{Alt Down}{F4}{Alt Up} ;ZZ

sc07B & x::SendPlay,{Delete}

sc07B & c::SendPlay,{BS} ;X

sc07B & b::SendPlay,{PgUp} ;^b

sc07B & m::Send,{Blind}{Enter}

vkF2sc070::SendPlay,{vkF3sc029}  ;カひロキー=半角/全角

vkFOscO3A::SendPlay,{Esc}  ;CapsLock=ESC
;ビジュアルモード
vimm=0
sc07B & v::
  if(vimm)
    vimm=0
  else
    vimm=1
return
#IF (vimm)
;ビジュアル選択モードを切る
Space::vimm=0

sc07B & f::SendPlay,{Ctrl Down}{Shift Down}{PgDn}{Shift Up}{Ctrl Up}  ;^f
sc07B & g::SendPlay,{Ctrl Down}{Shift Down}{End}{Shift Up}{Ctrl Up}
sc07B & h::Send,{Shift Down}{Left}{Shift Up}
sc07B & j::Send,{Shift Down}{Down}{Shift Up}
sc07B & k::Send,{Shift Down}{Up}{Shift Up}
sc07B & l::Send,{Shift Down}{Right}{Shift Up}
sc07B & b::SendPlay,{Shift Down}{PgUp}{Shift Up} ;^b

#IF
