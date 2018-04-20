@echo off
setlocal enabledelayedexpansion

if not exist "users2.csv" (
	rem Inform that the data file is not available
	echo No data available!
)

rem Protect using the password
:password_loop
echo.
echo ENTER PASSWORD :

set /p password=
for /f %%i in (password.txt) DO (
	echo %%i
	if not %password% == %%i (
		goto password_loop
	)
)


echo ...................................................
echo 1 - Search by User Name
echo 2 - Delete Entry
echo 3 - Exit
echo ...................................................

:loop
echo.
echo Type 1, 2 or 3, then press ENTER:

set /p user_input=
if %user_input% == 1 (
	call :search_by_user_name
) else if %user_input% == 2 (
	call :delete_entry
) else if %user_input% == 3 (
	rem Exit the process
	call exit
)
set user_input=0
goto loop

:search_by_user_name
set /p user_name="User Name: "
for /f "tokens=1,2,3,4,5,6,7 delims=, " %%a in (users2.csv) do (
	if %user_name% == %%b (
		rem If there is a match, show the record
		echo ID: %%a
		echo User Name: %%b
		echo First Name: %%c
		echo Last Name: %%d
		echo E-mail: %%e
		echo Password: %%f
		echo IP Address: %%g
	)
)
exit /b 0

:delete_entry

set /p id="Enter Line Number: "
echo %id%| findstr /r "^[1-9][0-9]*$">nul
if not %errorlevel% equ 0 (
	rem Check whether the input is an integer
	echo Invalid Input. Line number should be an integer
    exit /b 0
)
rem found is used to check the existence of the line number
set "found=0"
set /a count=0
for /f "tokens=1,2,3,4,5,6,7 delims=, " %%a in (users2.csv) do (
	if %id% == !count! (
		set "found=1"
	) else (
		echo %%a, %%b, %%c, %%d, %%e, %%f, %%g >> users2.csv
		if !count! == 0 (
			set /a count=1	
			rem Start writing to the file from the beginning
			echo %%a, %%b, %%c, %%d, %%e, %%f, %%g > users2.csv
		)
	)
	set /a count=count+1
)

if %found%==0 (
	echo No entry found!
)
exit /b 0
endlocal