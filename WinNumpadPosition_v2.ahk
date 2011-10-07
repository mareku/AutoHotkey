count:=1

;クライアント領域サイズ
Top=0
Left=0
Right=0
Bottom=0

#Persistent

  SysGet, Monitor, MonitorWorkArea, 1 
  Top:=MonitorTop
  Left:=MonitorLeft
  Right:=MonitorRight
  Bottom:=MonitorBottom

return

;最前面
#Numpad0::
  WinSet, Topmost, TOGGLE, A
return
  

;最大化/元に戻す
#Numpad5::
  WinGet, t, MinMax, A
  if t=0
    WinMaximize,A
  else
    WinRestore,A
return

;x,y,w,h
;左上
#Numpad7::
  CountReset(7)

  WWidth:=SIZE_12_13_23_23_13(Right-Left, count)
  WHeight:=SIZE_12_13_13_23_23(Bottom-Top, count)
  
  WinMoveSiz(Left, Top, WWidth, WHeight)

  count++

return
;右上
#Numpad9::
  CountReset(7)
  
  WWidth:=SIZE_12_13_23_23_13(Right-Left, count)
  WHeight:=SIZE_12_13_13_23_23(Bottom-Top, count)
  
  WinMoveSiz(Right-WWidth, Top, WWidth, WHeight)

  count++

return
;左下
#Numpad1::
  CountReset(7)

  WWidth:=SIZE_12_13_23_23_13(Right-Left, count)
  WHeight:=SIZE_12_13_13_23_23(Bottom, count)
  
  WinMoveSiz(Left, Bottom-WHeight, WWidth, WHeight)

  count++
return
;右下
#Numpad3::
  CountReset(7)
  
  WWidth:=SIZE_12_13_23_23_13(Right-Left, count)
  WHeight:=SIZE_12_13_13_23_23(Bottom-Top, count)
  
  WinMoveSiz(Right-WWidth, Bottom-WHeight, WWidth, WHeight)

  count++

return
;上
#Numpad8::
;カウントリセット
  CountReset(3)
;割幅計算
  WHeight:=SIZE_12_13_23_23_13(Bottom-Top, count)
  
  WinMoveSiz(Left, Top, Right-Left, WHeight)

  ;カウントアップ
  count++

return
;下
#Numpad2::
  ;カウントリセット
  CountReset(3)
  ;割幅計算
  WHeight:=SIZE_12_13_23_23_13(Bottom-Top, count)
  
  WinMoveSiz(Left, Bottom-WHeight, Right-Left, WHeight)

  ;カウントアップ
  count++

return
;左
#Numpad4::
  ;カウントリセット
  CountReset(3)
;割幅計算
WWidth:=SIZE_12_13_23_23_13(Right-Left, count)

  WinMoveSiz(Left, Top, WWidth, Bottom-Top)

  ;カウントアップ
  count++

return
;右
#Numpad6::
  ;カウントリセット
  CountReset(3)

  ;割幅計算
  WWidth:=SIZE_12_13_23_23_13(Right-Left, count)

  ;移動とサイズを渡す
  WinMoveSiz(Right-WWidth, Top, WWidth, Bottom-Top)

  ;カウントアップ
  count++

return

;カウントリセット
CountReset(Reset){
  global count
  if(count>Reset){
    count=1
  }
}

SIZE_12_13_23_23_13(w, count){
  if(count=1)
  {
    return w*1//2
  }
  else if(count=2)
  {
    return w*1//3
  }
  else if(count=3)
  {
    return w*2//3
  }
  else if(count=4)
  {
    return w*2//3
  }
  else if(count=5)
  {
    return w*1//3
  }
  else if(count=6)
  {
    return w*1//2
  }
  else if(count=7)
  {
    return w*1//2
  }
}

SIZE_12_13_13_23_23(h, count){
  if(count=1)
  {
    return h*1//2
  }
  else if(count=2)
  {
    return h*1//3
  }
  else if(count=3)
  {
    return h*1//3
  }
  else if(count=4)
  {
    return h*2//3
  }
  else if(count=5)
  {
    return h*2//3
  }
  else if(count=6)
  {
    return h*1//3
  }
  else if(count=7)
  {
    return h*2//3
  }
}

WinMoveSiz(x, y, w, h){
;アクティブウィンドウを移動とサイズを変更する
WinGetActiveTitle, Title
WinMove,%Title%,,x,y,w,h
}
