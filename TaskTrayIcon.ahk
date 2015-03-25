/*
�^�X�N�g���C�A�C�R������  by���s�点��y�[�W�Ǘ��l

Tray_GetCount()
  �g���C�A�C�R���̐����擾����
    �Ԃ�l
      �g���C�A�C�R���̐�

Tray_HideButton(hwnd,uid,hide=1)
  �g���C�A�C�R�����\���ɂ���
    ����
      hwnd
        Tray_GetInfo�Ŏ擾�����hwnd���w��
      uid
        Tray_GetInfo�Ŏ擾�����uid���w��
      hide
        0�ɂ���ƍĕ\���A1�ɂ���Ɣ�\��

Tray_MoveIcon(from,to)
  �g���C�A�C�R���̏��Ԃ����ւ���
    ����
      from
        �A�C�R���̈ʒu���w�肷��B�^�X�N�g���C�̈�ԍ��̃A�C�R����1
      to
        �ړ���̈ʒu���w�肷��

Tray_GetText(idx)
  �g���C�A�C�R���̃c�[���`�b�v�e�L�X�g���擾����
    ����
      idx
        �A�C�R���̔ԍ����w�肷��B�^�X�N�g���C�̈�ԍ��̃A�C�R����1
    �Ԃ�l
      �c�[���`�b�v�e�L�X�g

Tray_GetInfo(idx,ByRef hwnd,ByRef uid,ByRef msg)
  �g���C�A�C�R���̏����擾����
    ����
      idx
        �A�C�R���̔ԍ����w�肷��B�^�X�N�g���C�̈�ԍ��̃A�C�R����1
      ByRef hwnd
        �g���C�A�C�R���Ɋ֘A�Â���ꂽ�E�B���h�E�̃n���h�����i�[����ϐ����w�肷��
      ByRef uid
        �E�B���h�E���A�C�R�����������邽�߂̌ŗLID���i�[����ϐ����w�肷��
      ByRef msg
        �g���C�𑀍삵���Ƃ��ɃE�B���h�E�ɑ��郁�b�Z�[�W�ԍ����i�[����ϐ����w�肷��
      ByRef hicon
        �A�C�R���n���h�����i�[����ϐ����w�肷��
  �擾�����������ɁA�A�v���P�[�V�����Ƀg���C�A�C�R���𑀍삵�����̂悤�ɐU�镑�킹��ɂ́A
  �ȉ��̂悤�Ƀ��b�Z�[�W�𑗐M����
  PostMessage,%msg%,%uid%,%act%,,ahk_id %hwnd%

  %act%�ɂ́A�ȉ��̂ǂꂩ���w�肷��
    0x200:�J�[�\�����ʉ߂���
    0x201:���{�^����������
    0x202:���{�^���������
    0x203:���_�u���N���b�N
    0x204:�E�{�^����������
    0x205:�E�{�^���������
    0x206:�E�_�u���N���b�N
    0x207:���{�^����������
    0x208:���{�^���������
    0x209:���_�u���N���b�N

���g�p��̒���
�g���C�A�C�R���Ɋ֘A�Â���ꂽhwnd�̃E�B���h�E�́A�����̏ꍇ��\���ɂȂ��Ă���̂ŁA
�uDetectHiddenWindows,On�v�Ŕ�\���E�B���h�E�𑀍�ł���悤�ɂ��Ă����K�v������

���g�p��
;���ɋN�����Ă���AutoHotkey�̃g���C�A�C�R����(�S��)�_�u���N���b�N����
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

