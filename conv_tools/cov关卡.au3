#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_icon=C:\Windows\syswow64\SHELL32.dll|-288
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("编辑关卡使用", 350, 300, 300, 200)
$btnTop = GUICtrlCreateButton("top", 0, 0, 50, 20)
$xls2bin = GUICtrlCreateButton("转表", 26, 32, 88, 40)
$btnOP1 = GUICtrlCreateButton("表格目录", 132, 32, 80, 40)
$cpbin2exe = GUICtrlCreateButton("拷bit→EXEbin", 26, 92, 88, 40)
$btnOP2 = GUICtrlCreateButton("EXEbin目录", 132, 92, 80, 40)
$Label1 = GUICtrlCreateLabel("@WorkingDir", 56, 0, 228, 17)
$openself = GUICtrlCreateButton("打开自己", 224, 40, 81, 25)
$delBIN = GUICtrlCreateButton("delBIN", 224, 104, 81, 25)
$runexe = GUICtrlCreateButton("启动EXE", 26, 192, 88, 40)
$btnOP3 = GUICtrlCreateButton("EXE目录", 132, 192, 80, 40)
$btnClient = GUICtrlCreateButton("client", 32, 248, 57, 25)
$btnTmp = GUICtrlCreateButton("tmp", 136, 248, 57, 25)
$runEditor = GUICtrlCreateButton("启动Editor", 24, 144, 81, 33)
$btnOP5 = GUICtrlCreateButton("Editior目录", 128, 144, 81, 33)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


ControlSetText("","",$Label1,@WorkingDir)


$xlsmain=@WorkingDir&"\ResConvert\"
$xls=@WorkingDir&"\ResConvert\xls\"
$xlsbin=@WorkingDir&"\ResConvert\bin\"
$xlseditor=@WorkingDir&"\Editor\xls\"
$editor=@WorkingDir&"\Editor\"
$exeTest=@WorkingDir&"\ExeTest\"
$exeTestbin=@WorkingDir&"\ExeTest\config\"
$top=0

$svn="C:\Program Files\TortoiseSVN\bin\TortoiseProc.exe"
$note="C:\Program Files (x86)\Notepad++\notepad++.exe"


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $btnTop
			If($top=0) Then
				WinSetOnTop("编辑关卡使用","表格目录",$top+1)
				$top=$top+1
				ControlSetText("","",$btnTop,"unTop")
			Else
				WinSetOnTop("编辑关卡使用","表格目录",$top-1)
				$top=$top-1
				ControlSetText("","",$btnTop,"Top")
			EndIf
				
		Case $GUI_EVENT_CLOSE
			Exit
		Case $xls2bin
			If(ProcessExists("ResCheck.exe")) Then
				WinActivate("资源检查")
			Else
				$pid=Run($xlsmain&"ResCheck.exe",$xlsmain)
			EndIf
						
		Case $cpbin2exe
			$end=FileCopy($xlsbin&"*.bit",$exeTestbin,1)
			If($end=0) Then
				MsgBox(0, "GUI 事件", "拷贝失败")
			ElseIf($end=1) Then
				MsgBox(0,"ok","复制成功")
			EndIf
		Case $runexe
			Run($exeTest&"weshoothd.exe",$exeTest)

			
		Case $btnOP1
			ShellExecute($xlsmain)
		Case $btnOP2
			ShellExecute($exeTestbin)
		Case $btnOP3
			ShellExecute($exeTest)
		Case $btnOP5
			ShellExecute($xlseditor)

		Case $openself
			ShellExecute(@WorkingDir)
			
		Case	$delBIN
			$ok=MsgBox(1,"删除","删除掉？")
			If($ok==1) Then
				FileDelete($xlsbin)
			EndIf

			
		Case $btnClient
			Run($note&" "&$exeTest&"\common\client.xml")
		Case $btnTmp
			Run($note&" "&$exeTest&"\common\tmp.xml")

		Case $runEditor
			Run($editor&"Editor.exe",$editor)
		
		
		
		
		
	EndSwitch
WEnd
