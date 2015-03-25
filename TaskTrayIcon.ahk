/*
タスクトレイアイコン操作  by流行らせるページ管理人

Tray_GetCount()
  トレイアイコンの数を取得する
    返り値
      トレイアイコンの数

Tray_HideButton(hwnd,uid,hide=1)
  トレイアイコンを非表示にする
    引数
      hwnd
        Tray_GetInfoで取得されるhwndを指定
      uid
        Tray_GetInfoで取得されるuidを指定
      hide
        0にすると再表示、1にすると非表示

Tray_MoveIcon(from,to)
  トレイアイコンの順番を入れ替える
    引数
      from
        アイコンの位置を指定する。タスクトレイの一番左のアイコンが1
      to
        移動先の位置を指定する

Tray_GetText(idx)
  トレイアイコンのツールチップテキストを取得する
    引数
      idx
        アイコンの番号を指定する。タスクトレイの一番左のアイコンが1
    返り値
      ツールチップテキスト

Tray_GetInfo(idx,ByRef hwnd,ByRef uid,ByRef msg)
  トレイアイコンの情報を取得する
    引数
      idx
        アイコンの番号を指定する。タスクトレイの一番左のアイコンが1
      ByRef hwnd
        トレイアイコンに関連づけられたウィンドウのハンドルを格納する変数を指定する
      ByRef uid
        ウィンドウがアイコンを見分けるための固有IDを格納する変数を指定する
      ByRef msg
        トレイを操作したときにウィンドウに送るメッセージ番号を格納する変数を指定する
      ByRef hicon
        アイコンハンドルを格納する変数を指定する
  取得した情報を元に、アプリケーションにトレイアイコンを操作したかのように振る舞わせるには、
  以下のようにメッセージを送信する
  PostMessage,%msg%,%uid%,%act%,,ahk_id %hwnd%

  %act%には、以下のどれかを指定する
    0x200:カーソルが通過した
    0x201:左ボタンを押した
    0x202:左ボタンを放した
    0x203:左ダブルクリック
    0x204:右ボタンを押した
    0x205:右ボタンを放した
    0x206:右ダブルクリック
    0x207:中ボタンを押した
    0x208:中ボタンを放した
    0x209:中ダブルクリック

○使用上の注意
トレイアイコンに関連づけられたhwndのウィンドウは、多くの場合非表示になっているので、
「DetectHiddenWindows,On」で非表示ウィンドウを操作できるようにしておく必要がある

○使用例
;既に起動しているAutoHotkeyのトレイアイコンを(全て)ダブルクリックする
#NoTrayIcon
name=AutoHotkey.exe
action=0x203

cnt:=Tray_GetCount()
DetectHiddenWindows,On
Loop,%cnt%{
  Tray_GetInfo(A_Index,hwnd,uid,msg)
  WinGet,pn,ProcessName,ahk_id %hwnd%
  if(pn=name){
    PostMessage,%msg%,%uid%,%action%,,ahk_id %hwnd%
  }
}
DetectHiddenWindows,Off
*/

Tray_GetCount(){
  SendMessage,0x418,0,0,ToolbarWindow321,ahk_class Shell_TrayWnd
  return ErrorLevel
}
Tray_GetInfo(idx,ByRef hwnd,ByRef uid,ByRef msg,ByRef hicon){
  WinGet,pid,pid,ahk_class Shell_TrayWnd
  hp:=DllCall("OpenProcess",UInt,0x001F0FFF,UInt,0,UInt,pid,UInt)
  lpTB:=DllCall("VirtualAllocEx",UInt,hp,UInt,0,UInt,20,UInt,0x1000,UInt,0x4,UInt)
  SendMessage,0x417,% idx-1,%lpTB%,ToolbarWindow321,ahk_class Shell_TrayWnd

  DllCall("ReadProcessMemory",UInt,hp,UInt,lpTB+16,UIntP,dwData,UInt,4,UInt,0)
  DllCall("ReadProcessMemory",UInt,hp,UInt,dwData  ,UIntP,hwnd,UInt,8,UInt,0)
  DllCall("ReadProcessMemory",UInt,hp,UInt,dwData+8,UIntP,uid ,UInt,4,UInt,0)
  DllCall("ReadProcessMemory",UInt,hp,UInt,dwData+12,UIntP,msg ,UInt,4,UInt,0)
  DllCall("ReadProcessMemory",UInt,hp,UInt,dwData+24,UIntP,hicon ,UInt,4,UInt,0)

  DllCall("VirtualFreeEx", UInt,lpTB, UInt,0, UInt,0x8000)
  DllCall("psapi\CloseProcess",UInt,hp)
}
Tray_GetText(idx){
  WinGet,pid,pid,ahk_class Shell_TrayWnd
  hp:=DllCall("OpenProcess",UInt,0x001F0FFF,UInt,0,UInt,pid,UInt)
  lpStr:=DllCall("VirtualAllocEx",UInt,hp,UInt,0,UInt,512,UInt,0x1000,UInt,0x4,UInt)

  SendMessage,0x417,% idx-1,%lpStr%,ToolbarWindow321,ahk_class Shell_TrayWnd

  DllCall("ReadProcessMemory",UInt,hp,UInt,lpStr+4,UIntP,idButton,UInt,4,UInt,0)

  SendMessage,0x42D,%idButton%,%lpStr%,ToolbarWindow321,ahk_class Shell_TrayWnd
  length=%ErrorLevel%
  VarSetCapacity(res,length)
  DllCall("ReadProcessMemory",UInt,hp,UInt,lpStr,Str,res,UInt,length+1,UInt,0)

  DllCall("VirtualFreeEx", UInt,lpStr, UInt,0, UInt,0x8000)
  DllCall("psapi\CloseProcess",UInt,hp)
  return res
}
SAlloc(size){
  return DllCall("GlobalAlloc",UInt,0x40,UInt,size,UInt)
}
SFree(pStruct){
  DllCall("GlobalFree",UInt,pStruct,UInt)
}
SSetInt(pStruct,offset,val){
  DllCall("RtlMoveMemory", UInt,pStruct+offset, UIntP,val, Int,4)
}
Tray_HideButton(hwnd,uid,hide=1){
  pnid:=SAlloc(504)
  SSetInt(pnid,0,504)
  SSetInt(pnid,4,hwnd)
  SSetInt(pnid,8,uid)
  SSetInt(pnid,12,0x8)
  SSetInt(pnid,152,hide=1)
  SSetInt(pnid,156,0x1)
  DllCall("Shell32.dll\Shell_NotifyIcon",UInt,1,UInt,pnid,UInt)
  SFree(pnid)
}
Tray_MoveButton(from,to){
  PostMessage,0x452,% from-1,% to-1,ToolbarWindow321,ahk_class Shell_TrayWnd
}

