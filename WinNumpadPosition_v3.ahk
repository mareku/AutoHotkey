;======================================================================
;テンキー(以降n)でウィンドウを移動&リサイズ
; +----+-----+----+
; | n7 |  n8 | n9 |
; +----|-----|----+
; | n4 |  n5 | n6 |
; +----|-----|----+
; | n1 |  n2 | n3 |
; +----+-----+----+
; | n0 |  n. | nE |
; +----+-----+----+
; u = Up, d = Down, l = Left, r = Right
; Top = 最前面, Max = 最大化, m = モニタ移動
; +----+-----+----+
; | lu |  u  | ru |
; +----|-----|----+
; | l  |  m  | r  |
; +----|-----|----+
; | ld |  d  | rd |
; +----+-----+----+
; |Top | Max | Ent|
; +----+-----+----+
;======================================================================
;変数
;今の変更可能数
SizeChangeCount:=1

;サイズ変更可能数
;上下
UpDownMaxCount:=3
;左右
LeftRightMaxCount:=3
;斜め側
SidesMaxCount:=8
;中央
MiddleMaxCount:=5

;ウィンドウカウント
CurrentMonitor:=1

;----------------------------------------------------------------------
;その他
;----------------------------------------------------------------------
;最前面
#Numpad0::
  WinSet, Topmost, TOGGLE, A
Return

;最大化/元に戻す
#NumpadDot::
  WinGet, t, MinMax, A
  if(t=0)
    WinMaximize, A
  else
    WinRestore, A
return

;半透明化
transparencyFlag:=0
#NumpadAdd::
  transparency:=
  if (1 != transparencyFlag) { 
    transparency:=200
    transparencyFlag:=1
  } else {
    transparency:=255
    transparencyFlag:=0
  } 
  WinSet, Transparent, %transparency%, A
return
;#NumpadAdd::
;  WinGet, trans, Transparent, A
;  if trans is number
;  {
;    trans := trans - 32
;    if trans > 0
;      WinSet, Transparent, %trans%, A
;    if trans < 0
;      WinSet, Transparent, OFF, A
;  } else
;  {
;    WinSet, Transparent, 200, A
;  }
;return

;----------------------------------------------------------------------
;移動キー
;----------------------------------------------------------------------
;Test
;#b::
;  GetMonitor(CurrentMonitor, mX, mY, mW, mH)
;  
;  CountReset(MiddleMaxCount, SizeChangeCount)
;
;  MiddleWidthReSize(mW, rW, SizeChangeCount)
;  MiddleHeightReSize(mH, rH, SizeChangeCount)
;
;  XPos:=(0>mX) ? mX-(rW-(rW*2)) : (mW/2)-(rW/2)
;  YPos:=(0>mY) ? mY-(rH-(rH*2)) : (mH/2)-(rH/2)
;  WinMove, A,, XPos, YPos, rW, rH
;  ;msgbox, %XPos% %YPos%
;  SizeChangeCount++
;  
;return
;モニタ移動
#Numpad5::
  SysGet, mCount, MonitorCount
  
  if (CurrentMonitor >= mCount){
    CurrentMonitor:=1
  }
  else{
    CurrentMonitor++
  }
return

;左上
#Numpad7::
  ;モニター
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)
  ;カウントリセット
  CountReset(SidesMaxCount, SizeChangeCount)
  
  WidthReSize(mW, rW, SizeChangeCount)
  HeightReSize(mH, rH, SizeChangeCount)

  WinMove, A,, mX, mY, rW, rH

  SizeChangeCount++

return

;右上
#Numpad9::
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)

  CountReset(SidesMaxCount, SizeChangeCount)

  WidthReSize(mW, rW, SizeChangeCount)
  HeightReSize(mH, rH, SizeChangeCount)
  
  mC:= (0 > mX) ? rW-(rW*2) : mW-rW

  WinMove, A,, mC, mY, rW, rH

  SizeChangeCount++
return

;左下
#Numpad1::
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)

  CountReset(SidesMaxCount, SizeChangeCount)

  WidthReSize(mW, rW, SizeChangeCount)
  HeightReSize(mH, rH, SizeChangeCount)
  
  mC:= (0 > mY) ? rH-(rH*2) : mH-rH

  WinMove, A,, mX, mC, rW, rH
  
  SizeChangeCount++
return

;右下
#Numpad3::
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)
  
  CountReset(SidesMaxCount, SizeChangeCount)

  WidthReSize(mW, rW, SizeChangeCount)
  HeightReSize(mH, rH, SizeChangeCount)

  mC:= (0 > mX) ? rW-(rW*2) : mW-rW

  cH:= (0 > mY) ? rH-(rH*2) : mH-rH

  WinMove, A,, mC, cH, rW, rH

  SizeChangeCount++
return

;上
#Numpad8::
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)

  CountReset(UpDownMaxCount, SizeChangeCount)
  
  SidesResize(mH, rH, SizeChangeCount)
  ;WidthReSize(mH, rH, SizeChangeCount)
  
  WinMove, A,, mX, mY, mW, rH

  SizeChangeCount++

return

;下
#Numpad2::
 GetMonitor(CurrentMonitor, mX, mY, mW, mH)

 CountReset(UpDownMaxCount, SizeChangeCount)
 
 SidesResize(mH, rH, SizeChangeCount)

 ;WidthReSize(mH, rH, SizeChangeCount)

 cY:= (0 > mY) ? rH-(rH*2) : mH-rH
 
 WinMove, A,, mX, cY, mW, rH

 SizeChangeCount++

return

;左
#Numpad4::
 GetMonitor(CurrentMonitor, mX, mY, mW, mH)

 CountReset(LeftRightMaxCount, SizeChangeCount)
 SidesResize(mW, rW, SizeChangeCount)
 ;WidthReSize(mW, rW, SizeChangeCount)

 WinMove, A,, mX, mY, rW, mH

 SizeChangeCount++

return

;右
#Numpad6::
  GetMonitor(CurrentMonitor, mX, mY, mW, mH)

  CountReset(LeftRightMaxCount, SizeChangeCount)
  SidesResize(mW, rS, SizeChangeCount)

  cX:=(0 > mX) ? rS-(rS*2) : mW-rS

  ;WidthReSize(mW, rW, SizeChangeCount)
  
  ;cX:= (0 > mX) ? rW-(rW*2) : mW-rW
  
  WinMove, A,, cX, mY, rW, mH

  SizeChangeCount++

return

;----------------------------------------------------------------------
;ウィンドウ移動関連関数
;----------------------------------------------------------------------
;現在のモニタのデータ
GetMonitor(monitorNo, ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
  SysGet, m, MonitorWorkArea, %monitorNo%
  mX := mLeft
  mY := mTop
  mW := mRight - mLeft
  mH := mBottom - mTop
}

;カウントリセット
CountReset(Reset, ByRef SizeChangeCount){
  if(SizeChangeCount > Reset){
    SizeChangeCount:=1
  }
}

;横のリサイズ計算
WidthReSize(w, ByRef rW, count){
  if(count=1) {
    rW := w*1/2
  } else if(count=2) {
    rW := w*1/3
  } else if(count=3) {
    rW := w*2/3
  } else if(count=4) {
    rW := w*2/3
  } else if(count=5) {
    rW := w*1/3
  } else if(count=6) {
    rW := w*1/2
  } else if(count=7) {
    rW := w*1/2
  } else if(count=8) {
    rW := w*2/3
  }
}

;高さのリサイズ計算
HeightReSize(h, ByRef rH, count){
  if(count=1) {
    rH := h*1/2
  } else if(count=2) {
    rH := h*1/3
  } else if(count=3) {
    rH := h*1/3
  } else if(count=4) {
    rH := h*2/3
  } else if(count=5) {
    rH := h*2/3
  } else if(count=6) {
    rH := h*1/3
  } else if(count=7) {
    rH := h*2/3
  } else if(count=8) {
    rH := h*1/2
  }
}

;上下左右リサイズ
SidesResize(s, ByRef rS, count){
  if(count=1){
    rS:=s*1/2
  } else if(count=2) {
    rS:=s*1/3
  } else if(count=3) {
    rS:=s*2/3
  }
}

;中央でのリサイズ
MiddleWidthReSize(w, ByRef rW, count){
  if(count=1) {
    rW:=w*1//3
  } else if(count=2) {
    rW:=w*1//2
  } else if(count=3) {
    rW:=w*2//3
  } else if(count=4) {
    rW:=w*1//3
  } else if(count=5) {
    rW:=w
  }
}

MiddleHeightReSize(h, ByRef rH, count){
  if(count=1) {
    rH:=h*1//3
  } else if(count=2) {
    rH:=h*1//2
  } else if(count=3) {
    rH:=h*2//3
  } else if(count=4) {
    rH:=h
  } else if(count=5) {
    rH:=h*1//3
  } 
}
