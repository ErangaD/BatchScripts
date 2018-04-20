@echo off
if not exist "C:\Company" (
	rem Company directory is created, if it does not exist
	mkdir "C:\Company"
)

rem Changing the working directory to the Company
CD /D C:\Company

echo ...................................................
echo 1 - Create New Employee
echo 2 - EXIT
echo ...................................................

rem Loop to get user inputs
:loop
echo.
echo Type 1 or 2, then press ENTER:

set /p user_input=
if %user_input% == 1 (
	call :create_employee
	rem Calling the create_employee subroutine
) else if %user_input% == 2 (
	rem Exit the process
	call exit /b 0
)
set user_input=0
goto loop

:create_employee
:get_employee_id
set /p employee_id="Employee ID: "
echo %employee_id%| findstr /r "^[1-9][0-9]*$">nul
if not %errorlevel% equ 0 (
	rem Check whether the input is an integer
	echo Invalid Input
    goto :get_employee_id
	rem Giving the chance to input the value again
)

if exist "C:\Company\employees.txt" (
	rem Check for existing IDs to avoid duplications if the file exists
	for /f "tokens=1,2,3,4,5 delims=, " %%a in (employees.txt) do (
		if %employee_id% == %%a (
			echo ID already exists
			goto :get_employee_id
			rem Giving the chance to input the value again
		)
	)
)


set /p first_name="First Name: "
set /p last_name="Last Name: "
:get_age
set /p age="Age: "
echo %age%| findstr /r "^[1-9][0-9]*$">nul
if not %errorlevel% equ 0 (
	rem Check whether the input is an integer
	echo Invalid Input
    goto :get_age
	rem Giving the chance to input the value again
)
:get_salary
set /p salary="Salary: "
echo %salary%| findstr /r "^[1-9][0-9]*$">nul
if not %errorlevel% equ 0 (
	rem Check whether the input is an integer
	echo Invalid Input
    goto :get_salary
	rem Giving the chance to input the value again
)
rem Saving to the text file seperated by a comma
echo %employee_id%, %first_name%, %last_name%, %age%, %salary% >> employees.txt
exit /b 0
