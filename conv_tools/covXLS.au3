#Region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_icon=C:\Windows\syswow64\SHELL32.dll|-81
#PRE_Outfile_x64=表格工具.exe
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("转表", 356, 405, 270, 155)
$btnTop = GUICtrlCreateButton("top", 0, 0, 50, 20)
$xls2bin = GUICtrlCreateButton("转表", 26, 40, 88, 40)
$btnOP1 = GUICtrlCreateButton("表格目录", 132, 40, 80, 40)
$cpbin2exe = GUICtrlCreateButton("拷bit→EXEbin", 26, 100, 88, 40)
$btnOP2 = GUICtrlCreateButton("EXEbin目录", 132, 100, 80, 40)

$cpXls2editor = GUICtrlCreateButton("临时→Editor", 26, 236, 88, 40)
$btnOP4 = GUICtrlCreateButton("临时目录", 132, 280, 80, 40)
$runEditor = GUICtrlCreateButton("启动Editor", 26, 276, 88, 40)
$cpEditor2xls = GUICtrlCreateButton("Editor→临时", 26, 336, 88, 40)
$btnOP5 = GUICtrlCreateButton("Editor目录", 132, 236, 80, 40)
$updateEditor = GUICtrlCreateButton("updateEditor", 224, 240, 81, 25)

$Label1 = GUICtrlCreateLabel("@WorkingDir", 56, 0, 292, 17)

$updateXLS = GUICtrlCreateButton("updateXLS", 224, 32, 81, 25)
$updateBIN = GUICtrlCreateButton("updateBIN", 224, 56, 81, 25)
$delBIN = GUICtrlCreateButton("delBIN", 224, 80, 81, 25)
$updateRES = GUICtrlCreateButton("updateRES", 224, 104, 81, 25)
$comRES = GUICtrlCreateButton("comRES", 224, 128, 81, 25)
$revert = GUICtrlCreateButton("revert", 224, 152, 81, 25)


$runexe = GUICtrlCreateButton("启动EXE", 26, 152, 88, 40)
$btnOP3 = GUICtrlCreateButton("EXE目录", 132, 152, 80, 40)
$updateEXE = GUICtrlCreateButton("updateEXE", 139, 192, 81, 25)
;~ $updateEditor = GUICtrlCreateButton("updateEditor", 224, 240, 81, 25)
$btnClient = GUICtrlCreateButton("client", 8, 192, 57, 25)
$btnTmp = GUICtrlCreateButton("tmp", 72, 192, 57, 25)


$btnView = GUICtrlCreateButton("监控", 232, 304, 81, 25)
$runexe8 = GUICtrlCreateButton("runexe8", 232, 344, 89, 33)
$setID = GUICtrlCreateButton("setID",232,374,89,30)
$login = GUICtrlCreateButton("login",140,374,89,30)
$boxid=GUICtrlCreateInput("12000",132,340,100,30)


GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

ControlSetText("","",$Label1,@WorkingDir)

$xlseditor=@WorkingDir&"\Tools\Editor\xls\"
$editor=@WorkingDir&"\Tools\Editor\"
$xlsmain=@WorkingDir&"\ResConvert\"
$xls=@WorkingDir&"\ResConvert\xls\"
$xlsbin=@WorkingDir&"\ResConvert\bin\"
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
				WinSetOnTop("转表","表格目录",$top+1)
				$top=$top+1
				ControlSetText("","",$btnTop,"unTop")
			Else
				WinSetOnTop("转表","表格目录",$top-1)
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
		Case $cpXls2editor
			$end=FileCopy($xls&"*.xls*",$xlseditor,1)
			If($end=0) Then
				MsgBox(0, "GUI 事件", "拷贝失败")
			ElseIf($end=1) Then
				MsgBox(0,"ok","复制成功")
			EndIf
			
		Case $runEditor
			Run($editor&"Editor.exe",$editor)
		Case $cpEditor2xls
			$end=FileCopy($xlseditor&"*.xls*",$xls,1)
			
		Case $btnOP1
			ShellExecute($xlsmain)
		Case $btnOP2
			ShellExecute($exeTestbin)
		Case $btnOP3
			ShellExecute($exeTest)
		Case $btnOP4
			ShellExecute($xlsmain)
		Case $btnOP5
			ShellExecute($xlseditor)
			
			
		Case	$updateXLS
			Run($svn&" /command:update /path:"&$xls&"  /closeonend:0")
		Case	$updateBIN
			Run($svn&" /command:update /path:"&$xlsbin&"  /closeonend:0")
		Case	$delBIN
			$ok=MsgBox(1,"删除","删除掉？")
			If($ok==1) Then
				FileDelete($xlsbin)
			EndIf
		Case	$updateRES
			Run($svn&" /command:update /path:"&$xlsmain&"  /closeonend:0")
		Case	$comRES
			Run($svn&" /command:commit /path:"&$xlsmain&"  /closeonend:0")
			
		Case	$revert
			Run($svn&" /command:revert /path:"&$xlsmain&"  /closeonend:0")
		Case	$updateEXE
			While(ProcessExists("weshoothd.exe"))		
				ProcessClose("weshoothd.exe")
			WEnd
			Run($svn&" /command:update /path:"&$exeTest&"  /closeonend:0")
			
		Case $btnClient
			Run($note&" "&$exeTest&"\common\client.xml")
		Case $btnTmp
			Run($note&" "&$exeTest&"\common\tmp.xml")
			
		Case $updateEditor
;~ 			MsgBox(0,"editor",$editor)
			Run($svn&" /command:update /path:"&$editor&"  /closeonend:0")
			
		Case $runexe8
			For $i=1 To 8 Step 1
				$pidnew=Run($exeTest&"weshoothd.exe",$exeTest)
				Sleep(2500)
				$x1=(640*0.75+5)*($i-1)
			
				$y1=1080/5
				If $i=5 Then
					$x1=(640*0.75+5)*($i-5)+1920+5
				EndIf					
				WinMove("weshoothd - 640x960 - 0.70","",$x1,$y1)				
			Next	
		Case $setID
			For $k=1 To 8 Step 1
				$numA=GUICtrlRead($boxid)
				$x1=(640*0.75+5)*($k-1)		
				If $k=5 Then
					$x1=(640*0.75+5)*($k-5)+1920+5
				EndIf	
				MouseClick("left",80+$x1,882,1)
				WinWaitActive("Input","Enter value")
				ControlSetText("Input","Enter value","[CLASS:Edit; INSTANCE:1]",$numA+$k-1)
				Send("{ENTER}")				
				Sleep(1000)
			Next
			
			
		Case $login
			For $k=1 To 8 Step 1
				$x1=(640*0.75+5)*($k-1)		
				If $k=5 Then
					$x1=(640*0.75+5)*($k-5)+1920+5
				EndIf	
				MouseClick("left",364+$x1,786,1)
				Sleep(1000)
			Next
			
					
			
		Case $btnView
			$numA=GUICtrlRead($boxid)
			MsgBox(0,"",$numA)
			Run("Dbgview.exe")
		
	EndSwitch
WEnd
