@echo off
setlocal enabledelayedexpansion

if not exist "C:\Company\employees.txt" (
	rem Prompt for Employee Creation if the file does not exist
	echo Create Employees First
	call human_resource.bat
)

rem Change working directory
CD /D C:\Company

echo ...................................................
echo 1 - Give Payraise
echo 2 - Exit
echo ...................................................

rem Loop to get user inputs
:loop
echo.
echo Type 1 or 2, then press ENTER:

set /p user_input=
if %user_input% == 1 (
	call :give_payraise
) else if %user_input% == 2 (
	rem Exit the process
	call exit /b 0
)
set user_input=0
goto loop

:give_payraise
set /p employee_id="Enter ID: "
set /p increment="Increment: "
rem found is used to check the existence of the employee ID
set "found=0"
set /a count=0
for /f "tokens=1,2,3,4,5 delims=, " %%a in (employees.txt) do (
	set /a salary=%%e
	if %employee_id% == %%a (
		rem If employee_id is found the salary is increased and the found flag is set to 1
		set "found=1"
		set /a salary=%%e+!increment!
	)
	echo %%a, %%b, %%c, %%d, !salary! >> employees.txt
	if !count! == 0 (
		set /a count=1	
		rem Start writing to the file from the beginning
		echo %%a, %%b, %%c, %%d, !salary! > employees.txt
	)
)

if %found%==0 (
	echo No Employees found!
)
exit /b 0

endlocal
