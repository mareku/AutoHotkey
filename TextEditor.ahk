#b::
  CoordMode, Menu, Screen
  menu, resizeMenu, add, &txt,txt
  menu, resizeMenu, add, &html,html
  menu, resizeMenu, add
  menu, resizeMenu, add, &Exit, GuiClose
  menu, resizeMenu, show
  return
  txt:
  	TextEditor("txt","D:\bin\vim\gvim.exe")
  return
  html:
  	TextEditor("html","D:\bin\vim\gvim.exe")
  return
  GuiClose:
  	Exit
  return
return

;TextEditor(拡張子,エディタフルパス)
TextEditor(Extension, TextEditorPas){
  FilePas=%A_Temp%\TextEditorAnywhere_%A_Hour%_%A_Min%_%A_Sec%.%Extension%
  ClipSaved:=ClipboardAll  ;クリップボードの内容を保存

  WinGetActiveTitle, atitle  ;アクティブウィンドウタイトル取得
  
  Clipboard:=  ;クリップボードを空にしておく
  SendPlay,{PgUp}{Home}{Shift Down}{PgDn}{End}{Shift Up}{Ctrl Down}{Insert}{Ctrl Up}  ;テキストを取得
  Text:=Clipboard  ;取得したテキストを変数に保存
    
  FileAppend, %Text%, %FilePas%  ;テキスト変数を保存

  ;RunWait, "D:\bin\vim\gvim.exe" "%FilePas%", Max ;テキストエディタで開く
  RunWait, %TextEditorPas% "%FilePas%", Max ;テキストエディタで開く
  ;Maxを設定していても最大化しないがアクティブ状態になるので設定している
  Sleep,1000

  WinActivate, %atitle%  ;貼り付け先ウィンドウをアクティブにする
  FileRead, OutputVar, %FilePas%  ;ファイルを読み込む
;  Sleep,100
  Clipboard:=OutputVar  ;読み込んだ内容をクリップボードに渡す
  SendPlay,{BS}^{v}  ;ウィンドウに渡す

  Clipboard:=ClipSaved  ;クリップボードの内容を復元
  
  ;変数解放
  Text:=
  ClipSaved:=
  atitle:=
  OutputVar:=
}
