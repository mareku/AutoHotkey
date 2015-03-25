;======================================================================
;アプリケーション設定
;======================================================================

;----------------------------------------------------------------------
; マーケットスピード
#IfWinActive, ahk_class MDIFrame
; 注文画面呼び出し
; ワラント買い
  ^Numpad0::
    SendPlay,{F12}
    ; ワラントコードのＫを入力
    Sleep,500
    SendPlay,{T}
  return
; ワラント売り
  ^Numpad1::
    SendPlay,{F11}
    ; 最初の保有銘柄を選択
    Sleep,500
    SendPlay,{Down}
  return
#IfWinActive

; ウィンドウ別操作
#IfWinActive, Market Speed - ＷＲ買い注文
  ^NumpadAdd::SendPlay,{TAB}
#IfWinActive

#IfWinActive, Market Speed - ＷＲ売り注文
  ^NumpadAdd::SendPlay,{TAB}
#IfWinActive

;----------------------------------------------------------------------
; コマンドプロンプトで貼り付けをCtrl+vで出来るようにする。
#IfWinActive ahk_class ConsoleWindowClass
  ^v::Send,!{Space}ep
#IfWinActive

;--------------------------------------------------------------------------------
; cygwin
#IfWinActive ahk_class mintty
  ~^v::Send,+{Insert}
#IfWinActive
; ----------------------------------------------------------------------
; firefox
#IfWinActive, ahk_class MozillaWindowClass
  ;!g::Yank("D:\bin\GoogleChromePortable\GoogleChromePortable.exe --incognito --new-window --app=", 2)
  ;!g::Yank("D:\bin\GoogleChromePortable\GoogleChromePortable.exe --incognito --new-window", 1)
  ;!e::Yank("C:\Program Files\Internet Explorer\IEXPLORE.EXE", 1)
  ;!m::Yank("C:\Program Files\mikurima\mikurima.exe -nolist", 1) ;再生
  ;!m::Yank("C:\Program Files\mikurima\mikurima.exe -later", 1) ;あとで見る


  !r::  ; 最小化でメモリ解放
    WinGetActiveTitle, title
    SendPlay,!{Space}{n}
    Sleep,1000
    WinRestore, %title%
  return

; 同時起動中のFirefoxにURLを渡す
; !w::UrlPass("WebDevelopmentFirefox")
; !2::UrlPass("2chFirefox")
#IfWinActive

; Modo 1=URLの前に空欄を入れる 2=URLを続けて送る
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
;; fenrir startkey:=Ctrl+\
^sc073::SplitPath_Run("E:\bin\fenrir\fenrir.exe", " /t")
;; UWSC タクスリストクリック startkey:=Ctrl+.
;^sc034::Run, "E:\bin\uwsc\UWSC.exe" "E:\00work\nemo\script\uwsc\00Frequently-used\EntrustedSoftware.uws"
;; Ctrl+Win 範囲指定スクリーンショット
^F13::Run, "E:\bin1\rapture-2.1.1\rapture.exe"
;; Ctrl+Alt+T cygwin起動
^!T::Run,"C:\cygwin\Cygwin.bat"


;;プロセスをチェックして存在していればアクティブなければ、ソフト起動
SplitPath_Run(FileSpec, StartupOptions) {
    ;渡されたフルパスからソフト名の部分を分割
    SplitPath, FileSpec, Name, Dir
    sleep,100
    ;プロセスがあるかチェック
    Process, Exist, %Name%
    if ErrorLevel <> 0
      ;あればアクティブ
      WinActivate, ahk_pid %ErrorLevel%
    else
      ;なければソフトを起動
      ;起動オプションチェック
      if (StartupOptions = ) {
         Run, %FileSpec%, %Dir%
      } else {
         StartupOptionsRun:= FileSpec . StartupOptions
         Run, %StartupOptionsRun%, %Dir%
      }
}



;----------------------------------------------------------------------
;; fenrirfs
#If WinActive("ahk_class TFenrirFSMainForm.UnicodeClass")
  ;Enter無効化
  Enter::Return
#If

;----------------------------------------------------------------------
;;; WhiteBrowser
#IfWinActive,,WhiteBrowser
  ControlGetFocus, cgf2, A
  if (cgf2 = Internet Explorer_Server1) {
     j::SendPlay,{Down}
     k::SendPlay,{Up}
  }

#IfWinActive

;----------------------------------------------------------------------
;アプリ再起動 Win+Shift+Q
#+Q::
  WinGet, exefullpath, ProcessPath, A
  WinGet, processpid, PID, A
  WinClose, ahk_pid %processpid%
  Process, WaitClose, %processpid%, 60 ;最大60秒待つ
  if ErrorLevel <> 0
    msgbox, プロセスが終了しなかったか、時間が掛かっています。スクリプトを終了します
  else
    Run, %exefullpath%
  return

;------------------------------------------------------------------------------
;; Everything
#IfWinActive, ahk_class EVERYTHING
  ;ポチエスに渡す(Shift+Enter)
  +Enter::
    ControlGetText, text, msctls_statusbar321, ahk_class EVERYTHING
    run, "E:\bin\esExt5\esExt5.exe" %text%
  return

  ;クリップボードにファイルパスをコピー(Ctrl+c
  ^c::
    ControlGetText, text, msctls_statusbar321, ahk_class EVERYTHING
    Clipboard = %text%
  return
  ;検索に移動
  /::
    ControlFocus, Edit1, ahk_class EVERYTHING
  return
#IfWinActive

;----------------------------------------------------------------------
;; PotPlayer
#If WinActive("ahk_class PotPlayer64") OR WinActive("ahk_class PotPlayer")
  Enter::Send,!{F4}
  j::Send,{Down}
  k::Send,{Up}
  i::Send,{Ctrl Down}{Left}{Ctrl Up}  ;10秒戻る
  o::Send,{Ctrl Down}{Right}{Ctrl Up}  ;10秒進む
  h::Send,{Left}       ;戻る
  l::Send,{Right}       ;進む
  n::Send,{Shift Down}{Left}{Shift Up}  ;1分戻る
  m::Send,{Shift Down}{Right}{Shift Up}  ;1分進む
#If

;----------------------------------------------------------------------
;; foobar2000
#IfWinActive, ahk_class {97E27FAA-C0B3-4b8e-A693-ED7881E99FC1}
    p::Run,E:\bin1\foobar2000\foobar2000.exe /play
    n::Run,E:\bin1\foobar2000\foobar2000.exe /next
    b::Run,E:\bin1\foobar2000\foobar2000.exe /prev
    Space::Run,E:\bin1\foobar2000\foobar2000.exe /pause
    s::Run,E:\bin1\foobar2000\foobar2000.exe /stop
    q::Run,E:\bin1\foobar2000\foobar2000.exe /exit
#IfWinActive

;------------------------------------------------------------------------------
;; MassiGra
#If WinActive("ahk_class TF811202_MassiGra_Main")

  Enter::Send,!{F4}
  j::Send,{PgDn}
  k::Send,{PgUp}
  l::Send,{Right}
  h::Send,{Left}
  u::Send,+{PgUp}
  i::Send,+{PgDn}
  ;フォルダ移動 n=前 m=次
  n::send,{up}
  m::Send,{down}
  ;拡大、縮小 ;=+ :=-
  sc027::Send,{+}
  sc028::Send,{-}

#If

;--------------------------------------------------------------------------------
;PageOne
#If WinActive("ahk_class WindowsForms10.Window.8.app.")
  j::Send,{Down}
  k::Send,{Up}
  h::Send,{Left}
  l::Send,{Right}
#If
