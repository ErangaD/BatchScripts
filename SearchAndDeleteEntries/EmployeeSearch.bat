@echo off

if not exist "C:\Company\employees.txt" (
	rem Prompt for Employee Creation if the file does not exist
	echo Create Employees First
	call human_resource.bat
)

rem Change working directory
CD /D C:\Company

echo ...................................................
echo 1 - Search by Employee ID
echo 2 - Search by Last name
echo 3 - Exit
echo ...................................................

:loop
echo.
echo Type 1, 2 or 3, then press ENTER:

set /p user_input=
if %user_input% == 1 (
	call :search_by_id
) else if %user_input% == 2 (
	call :search_by_last_name
) else if %user_input% == 3 (
	rem Exit the process
	call exit
)
set user_input=0
goto loop

:search_by_id
set /p employee_id="Enter ID: "
for /f "tokens=1,2,3,4,5 delims=, " %%a in (employees.txt) do (
	if %employee_id% == %%a (
		rem If there is a match, show the record
		echo Employee ID: %%a
		echo First Name: %%b
		echo Last Name: %%c
		echo Age: %%d
		echo Salary: %%e
	)
)
exit /b 0

:search_by_last_name
set /p employee_last_name="Enter Last Name: "
for /f "tokens=1,2,3,4,5 delims=, " %%a in (employees.txt) do (
	if %employee_last_name% == %%c (
		rem If there is a match, show the record
		echo Employee ID: %%a
		echo First Name: %%b
		echo Last Name: %%c
		echo Age: %%d
		echo Salary: %%e
	)
)
exit /b 0