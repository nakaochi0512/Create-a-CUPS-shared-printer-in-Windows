@echo off
setlocal
rem INF�t�@�C���̏ꏊ
set InfFile=%~dp0\RICOH_Driver\IMC3000\disk1\oemsetup.inf
rem CSV�t�@�C���̏ꏊ
set CSVFile=%~dp0PrinterList.csv
rem INF�t�@�C���̃h���C�o��
set Device="RICOH IM C3000 PS"

rem ��INF�t�@�C�������邩�ǂ����̔���
:FileTF
if exist %InfFile% (goto True) else goto False

:True
echo "%InfFile%��������܂����B"
goto DriverInstall

:False
echo "%InfFile%��������܂���B"
goto End

rem �h���C�o�̃C���X�g�[��
:DriverInstall
if exist %CSVFile% (goto CSVTrue) else goto CSVFalse

:CSVTrue
echo "%CSVFile%��������܂����B"
goto Loop

:CSVFalse
echo "%CSVFile%"��������܂���ł����B"
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
rem �v�����^��
set PrinterName=%1
rem �|�[�g��
set PortName=%2

rem ##### process #####
rem �v�����^���쐬
rundll32 printui.dll,PrintUIEntry /if /b %PrinterName% /f %InfFile% /m %Device% /r %PortName%