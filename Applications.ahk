;======================================================================
;アプリケーション設定
;======================================================================

;マーケットスピード
#IfWinActive, ahk_class MDIFrame
;注文画面呼び出し
;ワラント買い
  ^Numpad0::
    SendPlay,{F12}
    ;ワラントコードのＫを入力
    Sleep,500
    SendPlay,{T}
  return
;ワラント売り
  ^Numpad1::
    SendPlay,{F11}
    ;最初の保有銘柄を選択
    Sleep,500
    SendPlay,{Down}
  return
#IfWinActive

;ウィンドウ別操作
#IfWinActive, Market Speed - ＷＲ買い注文
  ^NumpadAdd::SendPlay,{TAB}
#IfWinActive

#IfWinActive, Market Speed - ＷＲ売り注文
  ^NumpadAdd::SendPlay,{TAB}
#IfWinActive

;----------------------------------------------------------------------
;コマンドプロンプトで貼り付けをCtrl+vで出来るようにする。
#IfWinActive ahk_class ConsoleWindowClass
  ^v::Send,!{Space}ep
#IfWinActive

;----------------------------------------------------------------------
;firefox
#IfWinActive, ahk_class MozillaWindowClass
  !g::Yank("D:\bin\GoogleChromePortable\GoogleChromePortable.exe --incognito --new-window --app=", 2)
  ;!g::Yank("D:\bin\GoogleChromePortable\GoogleChromePortable.exe --incognito --new-window", 1)
  !e::Yank("C:\Program Files\Internet Explorer\IEXPLORE.EXE", 1)
 !m::Yank("C:\Program Files\mikurima\mikurima.exe -nolist", 1) ;再生
; !m::Yank("C:\Program Files\mikurima\mikurima.exe -later", 1) ;あとで見る

  !r::  ;最小化でメモリ解放
    WinGetActiveTitle, title
    SendPlay,!{Space}{n}
    Sleep,1000
    WinRestore, %title%
  return

;同時起動中のFirefoxにURLを渡す
  !w::UrlPass("WebDevelopment Firefox")
  !2::UrlPass("2ch Firefox")
#IfWinActive

;Modo 1=URLの前に空欄を入れる 2=URLを続けて送る
  Yank(EXEPath, Modo){
    ClipSaved:=ClipboardAll  ;クリップボードの内容を保存
      SendPlay,{y}  ;FirefoxURLをコピー
      Sleep,100
      ;SendPlay,{d}  ;今のタブを閉じる
      ;Sleep,100
    if(Modo=1){
      Run,%EXEPath% "%Clipboard%"  ;コマンドラインに空白を入れてURLを渡す
    } else {
      Run,%EXEPath%"%Clipboard%"  ;コマンドラインに続けてURLを渡す
    }

    Clipboard:=ClipSaved  ;クリップボードの内容を復元
    ClipSaved=  ;変数のメモリを解放
}
;起動中の別FirefoxにURLを渡す
UrlPass(Title){
    SetTitleMatchMode, RegEx ;ウィンド認識を正規表現で行う
    IfWinExist, %Title%  ;ウィンドウタイトルで判断
    {
      SendPlay,{y}  ;FirefoxURLをコピー
      Sleep,100
      WinActivate  ;ウィンドウをアクティブ
      Send,^{t}  ;Firefoxで新しいタブを作成
      sleep,100
      Send,^{v}{Enter}  ;URLバーにフィーカスがあるので張り付けて移動
    }
    else
    {
      Msgbox, %Title%が起動していません。
    }
    SetTitleMatchMode, 1  ;ウィンドウ認識をデフォルトに戻す
    Title=

}

;----------------------------------------------------------------------
;typict
#IfWinActive, ahk_class WindowsForms10.Window.8.app.0.378734a
	k::left
#IfWinActive

;----------------------------------------------------------------------
;wipefile


;----------------------------------------------------------------------
;その鉱山の名は。
#IfWinActive ahk_class TForm1
  $z::
    Loop
    {
      if !GetKeyState("z", "P")
        break
      Send,{LButton}
      sleep,1
    }
  return
  $x::Send,{RButton}
  $a::Send,{z}
#IfWinActive

;----------------------------------------------------------------------
;elona
#IfWinActive ahk_class hspwnd0
  sc07B & w::Send,{o}
  sc07B & e::Send,{i}
  sc07B & s::Send,{l}
  sc07B & f::Send,{j}
  ;テンキーにショートカット振り分け
  sc07B & NumpadIns::elona_pass_key("0")
  sc07B & NumpadEnd::elona_pass_key("1")
  sc07B & NumpadDown::elona_pass_key("2")
  sc07B & NumpadPgDn::elona_pass_key("3")
  sc07B & NumpadLeft::elona_pass_key("4")
  sc07B & NumpadClear::elona_pass_key("5")
  sc07B & NumpadHome::elona_pass_key("7")
  sc07B & NumpadRight::elona_pass_key("6")
  sc07B & NumpadUp::elona_pass_key("8")
  sc07B & NumpadPgUp::elona_pass_key("9")
  ;木の実収穫
  sc07B & b::
    While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
      if !GetKeyState("b", "P") ;bキーを離すと停止
        break
      
      Send,{Blind}{b}
      Sleep,25
      elona_pass_key("Up")
    }
  return   
  ;連続使用ターゲット確定が5
  sc07B & a::
    While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
      elona_pass_key("2")
      elona_pass_key("NumpadClear")
      if GetKeyState("Ctrl", "P")  ;Ctrlで停止
        break
   }
  return
  ;連続使用ターゲット確定がEnter
  sc07B & z::
    While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
      elona_pass_key("2")
      elona_pass_key("Enter")
      if GetKeyState("Ctrl", "P")  ;Ctrlで停止
        break
   }
  return
  ;魔法書連続読み
  sc07B & r::
  While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
    elona_pass_key("r")
    elona_pass_key("Enter")
    if GetKeyState("Ctrl", "P")  ;Ctrlで停止
      break
  }
  return
  ;右移動 
  !NumpadRight::
  While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
    elona_pass_key("Right")
    if GetKeyState("Ctrl", "P")  ;Ctrlで停止
      break
  }
  return
  ;足踏み
  !NumpadClear::
  Send,{Blind}{NumpadClear Down}
  While (WinActive(ahk_class hspwnd0)) { ;ウィンドウが非アクティブになったら停止
    if GetKeyState("Ctrl", "P")  ;Ctrlで停止
      break
    Sleep,25
  }
  Send,{Blind}{NumpadClear Up}
  return
#IfWinActive

elona_pass_key(key) {
  Send,{Blind}{%key% Down}
  Sleep,25
  Send,{Blind}{%key% Up}
  Sleep,25
}


