#Region ;**** ���������� ACNWrapper_GUI ****
#PRE_icon=C:\Windows\syswow64\SHELL32.dll|-288
#PRE_Res_requestedExecutionLevel=None
#EndRegion ;**** ���������� ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("�༭�ؿ�ʹ��", 350, 300, 300, 200)
$btnTop = GUICtrlCreateButton("top", 0, 0, 50, 20)
$xls2bin = GUICtrlCreateButton("ת��", 26, 32, 88, 40)
$btnOP1 = GUICtrlCreateButton("���Ŀ¼", 132, 32, 80, 40)
$cpbin2exe = GUICtrlCreateButton("��bit��EXEbin", 26, 92, 88, 40)
$btnOP2 = GUICtrlCreateButton("EXEbinĿ¼", 132, 92, 80, 40)
$Label1 = GUICtrlCreateLabel("@WorkingDir", 56, 0, 228, 17)
$openself = GUICtrlCreateButton("���Լ�", 224, 40, 81, 25)
$delBIN = GUICtrlCreateButton("delBIN", 224, 104, 81, 25)
$runexe = GUICtrlCreateButton("����EXE", 26, 192, 88, 40)
$btnOP3 = GUICtrlCreateButton("EXEĿ¼", 132, 192, 80, 40)
$btnClient = GUICtrlCreateButton("client", 32, 248, 57, 25)
$btnTmp = GUICtrlCreateButton("tmp", 136, 248, 57, 25)
$runEditor = GUICtrlCreateButton("����Editor", 24, 144, 81, 33)
$btnOP5 = GUICtrlCreateButton("EditiorĿ¼", 128, 144, 81, 33)
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
				WinSetOnTop("�༭�ؿ�ʹ��","���Ŀ¼",$top+1)
				$top=$top+1
				ControlSetText("","",$btnTop,"unTop")
			Else
				WinSetOnTop("�༭�ؿ�ʹ��","���Ŀ¼",$top-1)
				$top=$top-1
				ControlSetText("","",$btnTop,"Top")
			EndIf
				
		Case $GUI_EVENT_CLOSE
			Exit
		Case $xls2bin
			If(ProcessExists("ResCheck.exe")) Then
				WinActivate("��Դ���")
			Else
				$pid=Run($xlsmain&"ResCheck.exe",$xlsmain)
			EndIf
						
		Case $cpbin2exe
			$end=FileCopy($xlsbin&"*.bit",$exeTestbin,1)
			If($end=0) Then
				MsgBox(0, "GUI �¼�", "����ʧ��")
			ElseIf($end=1) Then
				MsgBox(0,"ok","���Ƴɹ�")
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
			$ok=MsgBox(1,"ɾ��","ɾ������")
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
