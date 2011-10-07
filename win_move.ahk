mm=0
;無変換+変換＝マウス操作モード
vk1Dsc07B & Space::
;vk1Csc079::
  if(mm)
    mm=0
  Else
    mm=1
  return


#If (mm)
;マウスモードOFF
$Space::mm=0

;マウス移動
$j::MouseM(0, 10)
$k::MouseM(0, -10)
$h::MouseM(-10, 0)
$l::MouseM(10, 0)

$^j::MouseM(0, 1)
$^k::MouseM(0, -1)
$^h::MouseM(-1, 0)
$^l::MouseM(1, 0)

$!j::MouseM(0, 50)
$!k::MouseM(0, -50)
$!h::MouseM(-50, 0)
$!l::MouseM(50, 0)

$+j::MouseM(0, 100)
$+k::MouseM(0, -100)
$+h::MouseM(-100, 0)
$+l::MouseM(100, 0)



;クリック&ドラッグドロップ
$q::
    Send,{LButton Down}
    KeyWait,q
    Send,{LButton Up}
  Return
$w::MouseClick, middle
$e::
    Send,{RButton Down}
    KeyWait,e
    Send,{RButton Up}
    Return

;マウスホイール
$[::MouseClick, WheelUp, , , 5
$]::MouseClick, WheelDown, , , 5
;交点上にマウスカーソルを移動
$1::WinMouseM(1,1)
$2::WinMouseM(1,2)
$3::WinMouseM(1,3)
$4::WinMouseM(2,1)
$5::WinMouseM(2,2)
$6::WinMouseM(2,3)
#If

;マウスを何間隔で移動
MouseM(x, y) {
	MouseGetPos, xpos, ypos
	MouseMove, xpos+x, ypos+y, 0
}


WinMouseM(x,y){
  b:=""
  r:=""
  WinGetPos,,, w, h, A
  b:=(h/3)*x
  r:=(w/4)*y
  CoordMode, Mouse, Relative
  MouseMove, r, b, 0
}

