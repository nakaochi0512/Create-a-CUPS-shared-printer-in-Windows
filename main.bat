@echo off
setlocal
rem INF�t�@�C���̏ꏊ
set Inf3000=%~dp0\RICOH_Driver\IMC3000\disk1\oemsetup.inf
rem CSV�t�@�C���̏ꏊ
set CSVFile=%~dp0\PrinterList.csv
rem INF�t�@�C���̃h���C�o��
set Device3000="RICOH IM C3000 PS"

rem 3000��INF�t�@�C�������邩�ǂ����̔���
:FileTF3000
if exist %Inf3000% (goto True3000) else goto False3000

:True3000
echo "%Inf3000%��������܂����B"
goto DriverInstall

:False3000
echo "%Inf3000%��������܂���B"
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
rem �v�����^��(�|�[�g���Ɠ���)
set PrinterName=%1
rem �|�[�g��
set PortName=%2
rem �h���C�o��
set DriverName=%3


rem ##### process #####
rem �v�����^���쐬
rundll32 printui.dll,PrintUIEntry /if /b %PrinterName% /f %Inf3000% /m %Device3000% /r %PortName%