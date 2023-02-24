@echo off
setlocal
rem INFファイルの場所
set InfFile=%~dp0\RICOH_Driver\IMC3000\disk1\oemsetup.inf
rem CSVファイルの場所
set CSVFile=%~dp0PrinterList.csv
rem INFファイルのドライバ名
set Device="RICOH IM C3000 PS"

rem のINFファイルがあるかどうかの判定
:FileTF
if exist %InfFile% (goto True) else goto False

:True
echo "%InfFile%が見つかりました。"
goto DriverInstall

:False
echo "%InfFile%が見つかりません。"
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
rem プリンタ名
set PrinterName=%1
rem ポート名
set PortName=%2

rem ##### process #####
rem プリンタを作成
rundll32 printui.dll,PrintUIEntry /if /b %PrinterName% /f %InfFile% /m %Device% /r %PortName%