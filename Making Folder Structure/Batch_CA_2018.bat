@echo off
rem For not outputting the command

echo ...................................................
echo PRESS 1, 2, 3 etc to select your task, or 8 to EXIT
echo ...................................................
echo 1 - Display User/PC Info
echo 2 - Create Directory Structure
echo 3 - Create Logfile
echo 4 - Backup Logfile
echo 5 - List Current User Processes
echo 6 - View Folder Permissions
echo 7 - Run Device Manager
echo 8 - EXIT

:loop
echo.
echo Type 1, 2, 3, 4, 5, 6, 7 or 8, then press ENTER:
rem -- get user inputs
set /p user_input=
if %user_input% == 1 (
	call :display_info
) else if %user_input% == 2 (
	call :create_directory
) else if %user_input% == 3 (
	call :create_log
) else if %user_input% == 4 (
	call :backup_log
) else if %user_input% == 5 (
	call :display_processes
) else if %user_input% == 6 (
	call :display_permissions
) else if %user_input% == 7 (
	call :run_dm
) else if %user_input% == 8 (
	rem -- if user selects 8, exit from the system
	exit
)
set user_input=0
rem -- go up again
goto loop


:display_info
rem -- ver command is used to get the version of the system
for /f "tokens=4-5 delims=[.] " %%i in ('ver') do (
	rem -- set the version to a variable
	set version=%%i.%%j
)
echo Hello %username%, you are currently logged into %computername%& echo.It is %time%,^
 on %date%& echo.You are using a PC that is running Microsoft Windows %version%
exit /b 0


:create_directory
if not exist "C:\backup\logs" (
	rem -- directory is created if it does not exist
	mkdir "C:\backup\logs"
)
if not exist "C:\batch\logs" (
	rem -- directory is created if it does not exist
	mkdir "C:\batch\logs"
)
exit /b 0

:create_log
rem -- if the directory is not yet created, create the directory
call :create_directory

for /f "tokens=4-5 delims=[.] " %%i in ('ver') do (
	set version=%%i.%%j
)
rem -- writing to the logfile.txt
rem -- (>>) is used since it is required to append when subsequently run
echo Hello %username%, you are currently logged into %computername%.^
 It is %time%,on %date%. You are using a PC that is running Microsoft Windows %version% >>"C:\batch\logs\logfile.txt"

exit /b 0

:backup_log
rem -- recursively copy all files in the C:\batch\logs to C:\backup\logs
rem -- overwrite has been set to true
xcopy /s "C:\batch\logs" "C:\backup\logs" /y
exit /b 0


:display_processes
rem -- this lists out the running processes of a single user's logon session
tasklist /fi "session eq 1" /fi "status eq running" /nh
exit /b 0

:display_permissions
rem -- cacls command is used to list the permissions on the folder
set target="C:\backup"
cacls "%target%"
exit /b 0

:run_dm
rem -- device manager is opened by the logged in user. If the user is a admin, the device manager can be run as administrator
runas /user:%username% devmgmt.msc
exit /b 0