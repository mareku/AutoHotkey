;----------------------------------------------------------------------
;ボリューム
;----------------------------------------------------------------------

#w::Volume_Change("+5")
#q::Volume_Change("-5")

Volume_Change(delta) {
  ;元の設定
  SoundSet, %delta%
  SoundGet, volume
  Volume_OSD(Round(volume), 2000)

  ;VAを利用した設定
  ;dcurrentSound:=VA_GetMasterVolume()
  ;dcurrentSound+=%delta%
  ;VA_SetMasterVolume(currentSound)
  ;Volume_OSD(Round(currentSound), 2000)
}


Volume_OSD(value, dur, pos="BC", fc="Aqua", fs1=28, fs2=36){
  global Progress1
  static _fs1,_fs2,_fc,_pos, zh:=30

  if(pos != _pos || fc != _fc || f1 != _f1 || f2 != _f2)
    Progress1 := false
  if (!Progress1) {
    opt:=InStr(pos, "X") ? "C00" : "C10"
    w := Round(A_ScreenWidth / 2)
    h := fs2 + zh + 40
    x := InStr(pos, "L") ? 0 : InStr(pos, "R") ? (A_ScreenWidth - w) : Round((A_ScreenWidth - w) / 2)
    y := (InStr(pos, "B")) ? A_ScreenHeight - (h + 30) : 10
    Progress, 1:Hide b x%x% y%y% w%w% h%h% CW000001 CT%fc% CB%fc% ZH%zh% ZW0 ZX30 ZYO FS%fs2% WM1000 WS600 %opt%
    Progress1:=true
  }
  progress, 1:%value%, %value%`%
  progress, 1:Show
  _fc:=fc,_fs2:=fs2,_fs1:=fs1,_pos:=pos
  SetTimer, VolumeOSD_Off, %dur%
  return
  VolumeOSD_Off:
    Progress1:=false
    progress, off
    return

}
