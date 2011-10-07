vk1Dsc079 & m::SendPlay,{Enter} ;改行
vk1Dsc079 & i::SendPlay,{TAB}
vk1Dsc079 & p::SendPlay,{Up}    ;上移動
vk1Dsc079 & n::SendPlay,{Down}  ;下移動
vk1Dsc079 & b::SendPlay,{Left}  ;左移動
vk1Dsc079 & f::SendPlay,{Right} ;右移動

vk1Dsc079 & a::SendPlay,{Home}  ;行頭へ移動
vk1Dsc079 & e::SendPlay,{End}   ;行末へ移動

vk1Dsc079 & v::SendPlay,{PgDn}  ;一ページ分スクロールダウン

vk1Dsc079 & h::SendPlay,{BS}    ;BackSpace

vk1Dsc079 & k::SendPlay,{Shift Down}{End}{Delete}{Shift Up}  ;カーソルから行末尾まで消す
vk1Dsc079 & d::SendPlay,{Shift Down}{Home}{Delete}{Shift Up}  ;カーソルから行頭までを消す

vk1Dsc079 & y::SendPlay,{Shift Down}{Insert}{Shift U}  ;貼り付け

vk1Dsc079 & t::SendPlay,{Shift Down}{End}{Delete}{Shift Up}{Home}{Shift Down}{Insert}{Shift Up}  ;カーソルの左側の文字と右側の文字を置き換え

vkF2sc070::SendPlay,{vkF3sc029}  ;カタ・ひら・ローマ=半角/全角

vk1Dsc079 & z::SendPlay,{Ctrl Down}{BS}{Ctrl Up}  ;再変換

vkF0sc03A::SendPlay,{Esc}  ;CapsLock=ESC

