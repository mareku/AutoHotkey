#Persistent
;ウィンド移動関連
#Include WinNumpadPosition_v4.ahk
;マウス操作関連
#Include win_move_v2.ahk
;数字関連
#Include NumericMode.ahk
;編集関連
#Include NoConversion.ahk
;ボリューム調整
#Include Volume.ahk
;ソフトごとの設定
#Include Applications.ahk

;;AutoHotKeyリロード
#F5::
  Reload
  SLeep,500
  MsgBox,リロード失敗
return

;キー確認
#InstallKeybdHook
