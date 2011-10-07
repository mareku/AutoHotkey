mm=0
speed=0
;無変換+Space＝マウス操作モード
vk1Dsc07B & Space::
;vk1Csc079::
  if(mm)
    mm=0
  Else
    mm=1
  ;speedに初期値を設定
  if(!speed){
    speed=2
  }
  return


#If (mm)

;マウスモードOFF
$Space::mm=0

;マウス移動
;下
$j::MouseM(0, 10, speed)
;上
$k::MouseM(0, -10, speed)
;左
$h::MouseM(-10, 0, speed)
;右
$l::MouseM(10, 0, speed)
;左上
$u::MouseM(-10, -10, speed)
;右上
$i::MouseM(10, -10, speed)
;左下
$n::MouseM(-10, 10, speed)
;右下
$m::MouseM(10, 10, speed)

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
$f::MouseClick, WheelUp, , , 5
$v::MouseClick, WheelDown, , , 5

;マウスカーソルの移動量変更
$1::speed:=-10
$2::speed:=-20
$3::speed:=-30
$4::speed:=-40
$5::speed:=-50
$6::speed:=-60
$7::speed:=-70
$8::speed:=-80
$9::speed:=-90

#If

;マウスを何間隔で移動
MouseM(x, y, s) {
	MouseGetPos, xpos, ypos
	MouseMove, xpos+x, ypos+y, s
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

isDown(key){
  state := getkeystate(key, "P")
  return state
}
