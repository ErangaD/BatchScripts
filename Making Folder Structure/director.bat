
@ECHO OFF
SET "admins="
SET "prev="
FOR /f "delims=" %%A IN ('net localgroup administrators') DO (
	
	call SET "admins=%%admins%% %%prev%%"
	SET "prev=%%A"
)
SET admins=%admins:*- =%
echo %admins%

for /f "tokens=1-2 delims= " %%i in ('echo %admins%') do (
	echo %%i
	pause
)

pause
GOTO :EOF