@echo off
setlocal
rem INFファイルの場所
set Inf3000=%~dp0\RICOH_Driver\IMC3000\disk1\oemsetup.inf
rem CSVファイルの場所
set CSVFile=%~dp0\PrinterList.csv
rem INFファイルのドライバ名
set Device3000="RICOH IM C3000 PS"

rem 3000のINFファイルがあるかどうかの判定
:FileTF3000
if exist %Inf3000% (goto True3000) else goto False3000

:True3000
echo "%Inf3000%が見つかりました。"
goto DriverInstall

:False3000
echo "%Inf3000%が見つかりません。"
goto End

rem ドライバのインストール
:DriverInstall
if exist %CSVFile% (goto CSVTrue) else goto CSVFalse

:CSVTrue
echo "%CSVFile%が見つかりました。"
goto Loop

:CSVFalse
echo "%CSVFile%"が見つかりませんでした。"
goto End

:Loop
for /f "skip=1 tokens=1-4 delims=," %%a in (%CSVFile%) do (
  CALL :PrSet "%%b" "%%c" "%%d"
 )
echo "Process was completed"
goto end

:End
pause
exit

:PrSet
rem ----- pr_setfunction ---------
rem ##### argument #####
rem プリンタ名(ポート名と同じ)
set PrinterName=%1
rem ポート名
set PortName=%2
rem ドライバ名
set DriverName=%3


rem ##### process #####
rem プリンタを作成
rundll32 printui.dll,PrintUIEntry /if /b %PrinterName% /f %Inf3000% /m %Device3000% /r %PortName%