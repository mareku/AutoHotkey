; 使用キーの組み合わせ
; 無変換+kye

sc07B & 1::SendPlay,{Ctrl Down}{Home}{Ctrl Up}  ;1G

sc07B & q::SendPlay,!{F4} ;:q

sc07B & w::SendPlay,^{S}  ;:w

sc07B & e::Send,{Blind}{End}  ;$

sc07B & r::SendPlay,^{y}  ;ctrl+r

sc07B & t::SendPlay,{Shift Down}{End}{Shift Up}{Ctrl Down}{Insert}{Ctrl Up}  ;y$

sc07B & y::SendPlay,{Ctrl Down}{Insert}{Ctrl Up}  ;vy

sc07B & u::SendPlay,^{z}

sc07B & i::Send,{Blind}{Tab}

;sc07B & o::SendPlay,{End}{Enter}

sc07B & p::SendPlay,^{v}

sc07B & [::SendPlay,{Esc}

sc07B & a::Send,{Blind}{Home}

sc07B & s::SendPlay,+{End}+{Delete}  ;D

sc07B & d::SendPlay,{Home}+{End}+{Delete}  ;dd

sc07B & f::SendPlay,{PgDn}  ;^f

sc07B & g::SendPlay,^{End} ;G

;カーソル移動
;sc07B & h::modifierKey("Left")
;sc07B & j::modifierKey("Down")
;sc07B & k::modifierKey("Up")
;sc07B & l::modifierKey("Right")
sc07B & h::Send,{Blind}{Left}
sc07B & j::Send,{Blind}{Down}
sc07B & k::Send,{Blind}{Up}
sc07B & l::Send,{Blind}{Right}

;;2回入力しないと起動しない
sc07B & z::
    if(A_PriorHotkey == A_ThisHotkey)&&(A_TimeSincePriorHotkey < 500){
        SendPlay,^{S}!{F4} ;ZZ
    }
return

sc07B & x::SendPlay,{Delete}

sc07B & c::SendPlay,{BS} ;X

sc07B & b::SendPlay,{PgUp} ;^b

sc07B & m::SendPlay,{Blind}{Enter}

;sc070::SendPlay,{vkF3sc029}  ;カひロキー=半角/全角

sc07B & v::
    Send,+{Home}
    Backup := ClipbpardAll
    Send,^x
    Send,{vkF4sc029}
    Sleep,10
    Send,%Clipboard%
    Clipboard := Backup
return

; ローマ字入力をひらがなに変換
sc07B & Left::
    Send, ^+{Left}
    Backup:=ClipboardAll
    Send, ^x{vkF4sc029}
    Sleep, 10
    Send, %Clipboard%
    Clipboard:=Backup
return

;ビジュアルモード
; vimm=0
; sc07B & v::
;   if(vimm)
;     vimm=0
;   else
;     vimm=1
; return
; #IF (vimm)
; ;ビジュアル選択モードを切る
; Space::vimm=0
;
; sc07B & f::SendPlay,^+{PgDn}  ;^f
; sc07B & h::Send,+{Left}
; sc07B & j::Send,+{Down}
; sc07B & k::Send,+{Up}+
; sc07B & l::Send,+{Right}
; sc07B & b::SendPlay,^+{PgUp} ;^b
;
; #IF
