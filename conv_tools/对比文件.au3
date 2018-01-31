#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_icon=C:\Windows\syswow64\SHELL32.dll|-67
#PRE_UseX64=n
#PRE_Res_requestedExecutionLevel=None
#endregion ;**** 参数创建于 ACNWrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#region ### START Koda GUI section ### Form=
$Form1_1_1 = GUICreate("文件校验", 502, 565, 234, 222)
$lblfilelist = GUICtrlCreateLabel("文件列表", 24, 16, 52, 17)
$editfilelist = GUICtrlCreateEdit("", 24, 32, 257, 265, BitOR($ES_AUTOVSCROLL, $ES_WANTRETURN, $WS_VSCROLL))

;~ GUICtrlSetData(1, "editfilelist")
$btnCalc = GUICtrlCreateButton("计算", 320, 56, 97, 33)
$updateios = GUICtrlCreateButton("updateios", 320, 104, 97, 33)
$updateandriod = GUICtrlCreateButton("updateandriod", 320, 144, 97, 33)
$openhotfix = GUICtrlCreateButton("openhotfix", 320, 192, 97, 33)


$Group1 = GUICtrlCreateGroup("选择文件", 8, 320, 481, 201)
$btnfilesvr = GUICtrlCreateButton("选择文件", 333, 344, 73, 25)
$txtsvr = GUICtrlCreateInput("", 24, 344, 305, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$btnCheck = GUICtrlCreateButton("校验", 407, 344, 73, 25)
$txtdebug = GUICtrlCreateInput("", 24, 377, 305, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$txtAndClient = GUICtrlCreateInput("", 24, 432, 305, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$Label1 = GUICtrlCreateLabel("前台安卓包", 24, 412, 64, 17)
$Label2 = GUICtrlCreateLabel("前台IOS包", 26, 464, 58, 17)
$txtIOSClient = GUICtrlCreateInput("", 23, 482, 305, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
$btnfileAnd = GUICtrlCreateButton("选择文件", 333, 432, 73, 25)
$btnCheckAnd = GUICtrlCreateButton("校验", 409, 432, 73, 25)
$btnCheckIOS = GUICtrlCreateButton("校验", 409, 480, 73, 25)
$btnfileIOS= GUICtrlCreateButton("选择文件", 333, 480, 73, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUISetState(@SW_SHOW)
#endregion ### END Koda GUI section ###




$IOS = IniRead("config.ini", "SVN", "IOS", "没有配置")
$Andriod = IniRead("config.ini", "SVN", "Andriod", "没有配置")
$IOSBin = $IOS & "bin"
$AndriodBin = $Andriod & "Bin"
$hotfix = IniRead("config.ini", "SVN", "hotfix", "没有配置")
$svn = IniRead("config.ini", "SVN", "torsvn", "没有配置")

$md5 = @WorkingDir & "\" & IniRead("config.ini", "MD5", "md5sum", "md5sums.exe")
$winmd5 = @WorkingDir & "\" & IniRead("config.ini", "MD5", "winmd5", "WinMD5.exe")

$rarexe='"'&IniRead("config.ini", "RAR", "rarexe", "C:\Program Files\WinRAR\Rar.exe")&'"'

$iosoutfileend=""
$andoutfileend=""
$time=""
$andfileover=0
$iosfileover=0

;~ $iosoutfile=@WorkingDir&"\"&@YEAR &"."&@MON&"."&@MDAY&"."&@MIN&"ios.md5"
;~ $andoutfile=@WorkingDir&"\"&@YEAR &"."&@MON&"."&@MDAY&"."&@MIN&"Andriod.md5"
;~ $inputfilename=GUICtrlRead($editfilelist)
;~ MsgBox(0,"",$md5 &" "&$inputfilename& " > "&$outputfile)
;~ Run(@ComSpec & " "& $md5 &" "&$inputfilename& " >"&$iosoutfile, $IOSBin)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $openhotfix
			ShellExecute($hotfix)
		Case $updateios
			Run($svn & " /command:update /path:" & $IOS & "  /closeonend:0")
		Case $updateandriod
			Run($svn & " /command:update /path:" & $Andriod & "  /closeonend:0")
			
			
		Case $btnfilesvr
			$message = "请选择文件"
			Local $varfile = FileOpenDialog($message, $hotfix, "所有文件 (*.*)", 1 + 2)
			GUICtrlSetData($txtsvr,$varfile)
		Case $btnfileIOS
			$message = "请选择文件"
			Local $varfile = FileOpenDialog($message, $hotfix, "所有文件 (*.*)", 1 + 2)
			GUICtrlSetData($txtIOSClient,$varfile)
		Case $btnfileAnd
			$message = "请选择文件"
			Local $varfile = FileOpenDialog($message, $hotfix, "所有文件 (*.*)", 1 + 2)
			GUICtrlSetData($txtAndClient,$varfile)
			
		Case $btnCheckAnd
				$selfile1='"'&GUICtrlRead($txtAndClient)&'"'
				Local $time1 = @YEAR & "." & @MON & "." & @MDAY & "." & @HOUR & @MIN
				Local $outf=$hotfix&"\"&$time&".out\"
				$cmd=$rarexe & " e " &$selfile1 & " "&$outf
				RunWait($cmd)
				Run($winmd5 &" "&$outf&" "&$andoutfileend )
				
			Case  $btnCheckIOS
				$selfile1='"'&GUICtrlRead($txtIOSClient)&'"'
				Local $time1 = @YEAR & "." & @MON & "." & @MDAY & "." & @HOUR & @MIN
				Local $outf=$hotfix&"\"&$time&".out\"
				$cmd=$rarexe & " e " &$selfile1 & " "&$outf
				RunWait($cmd)
				Run($winmd5 &" "&$outf&" "&$iosoutfileend )


		Case $btnCheck			
				$selfile1='"'&GUICtrlRead($txtsvr)&'"'
				Local $time1 = @YEAR & "." & @MON & "." & @MDAY & "." & @HOUR & @MIN
				Local $outf=$hotfix&"\"&$time&".out\"
				$cmd=$rarexe & " e " &$selfile1 & " "&$outf
				$svrmd5=RunWait(@ComSpec & " /c " & $md5 & " -u " & $selfile1 ,"",@SW_HIDE)
				GUICtrlSetData($txtdebug,$svrmd5)
;~ 				MsgBox(0,"cmd",$cmd)
				RunWait($cmd)
				Run($winmd5 &" "&$outf&" "&$iosoutfileend&" "&$andoutfileend )
;~ 				MsgBox(0,"shuchu",$ouid)
			
		Case $btnCalc
			$time = @YEAR & "." & @MON & "." & @MDAY & "." & @HOUR & @MIN
			$iosoutfile = @WorkingDir & "\" & $time & ".ios.md5"
			$andoutfile = @WorkingDir & "\" & $time & ".Andriod.md5"
			$inputlist = GUICtrlRead($editfilelist)
			$inputfilename = StringReplace($inputlist, @CRLF, " ")
;~ 			MsgBox(0, "", $inputfilename)

			RunWait(@ComSpec & " /c " & $md5 & " -u " & $inputfilename & " >" & $iosoutfile, $IOSBin,@SW_HIDE)
			RunWait(@ComSpec & " /c " & $md5 & " -u " & $inputfilename & " >" & $andoutfile, $AndriodBin,@SW_HIDE)
;~ 			MsgBox(0, "", $iosoutfile)
			Sleep(1000)
			Local $CountLines = _FileCountLines($iosoutfile)
			If $CountLines > 0 Then
				$iosmd5HW = FileOpen($iosoutfile, 0)
				If $iosmd5HW = -1 Then
					MsgBox(4096, "错误", "不能打开文件.")
					Exit
				EndIf
				
				$outstring = ""
				For $i = 1 To $CountLines Step 1
					Local $line = FileReadLine($iosmd5HW)
;~ 					MsgBox(0, "duqu", $line)
					If @error = -1 Then ExitLoop
					$line1 = StringReplace($line, Chr(42), " ")
;~ 					MsgBox(0,"line1",$line1)
					$outstring = $outstring & $line1 & @CRLF
;~ 					MsgBox(0, "out", $outstring)
				Next
				$iosoutfileend = $hotfix & $time & ".end.ios.md5"
				$iosfileover=FileWrite($iosoutfileend, $outstring)
				FileClose($iosmd5HW)
				FileDelete($iosoutfile)
			EndIf
			
			
			
			
			
			Local $CountLines = _FileCountLines($andoutfile)
			If $CountLines > 0 Then
				$andmd5HW = FileOpen($andoutfile, 0)
				If $andmd5HW = -1 Then
					MsgBox(4096, "错误", "不能打开文件.")
					Exit
				EndIf
				
				$outstring = ""
				For $i = 1 To $CountLines Step 1
					Local $line = FileReadLine($andmd5HW)
;~ 					MsgBox(0, "duqu", $line)
					If @error = -1 Then ExitLoop
					$line1 = StringReplace($line, Chr(42), " ")
;~ 					MsgBox(0,"line1",$line1)
					$outstring = $outstring & $line1 & @CRLF
;~ 					MsgBox(0, "out", $outstring)
				Next
				
				$andoutfileend = $hotfix & $time & ".end.Andriod.md5"
				$andfileover=FileWrite($andoutfileend, $outstring)
				FileClose($andmd5HW)
				FileDelete($andoutfile)
			EndIf
;~ 			MsgBox(0,"testiso",$iosfileover)
;~ 			MsgBox(0,"testand",$andfileover)
			If($andfileover==1 And $iosfileover==1) Then
				MsgBox(0,"MD5结果","计算MD5成功")
			Else
				MsgBox(0,"MD5结果","算完了，但是可能有错")
			EndIf
				
			
			
			
	EndSwitch
WEnd
