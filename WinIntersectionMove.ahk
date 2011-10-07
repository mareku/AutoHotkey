;アクティブウィンドを4*4の格子に区切って、
;交点上にマウスカーソルを移動する
;上から1段目が始まるのでテンキーなどに設定する場合は、
;少しややこしい
Hs:=4
Ws:=4

!Numpad1::MMG(1,3,Hs,Ws)
!Numpad2::MMG(2,3,Hs,Ws)
!Numpad3::MMG(3,3,Hs,Ws)
!Numpad4::MMG(1,2,Hs,Ws)
!Numpad5::MMG(2,2,Hs,Ws)
!Numpad6::MMG(3,2,Hs,Ws)
!Numpad7::MMG(1,1,Hs,Ws)
!Numpad8::MMG(2,1,Hs,Ws)
!Numpad9::MMG(3,1,Hs,Ws)
;Google翻訳でMouseMovementGrid(マウス格子移動)の頭文字
MMG(x,y, Hs, Ws){
  WinGetPos, , , w, h, A
  intersection_x:=(w/Ws)*x
  intersection_y:=(h/Hs)*y
  CoordMode, Mouse, Relative
  MouseMove, intersection_x, intersection_y
}


