@echo off
setlocal enabledelayedexpansion
echo Folder, Last Accessed File > AccessedFiles.csv
for /D /r %%f in ("*") do (
	set /a count=0
	for /f %%i in ('dir "%%f" /b /TA /O-D /a-d') do (
		if !count! == 0 (
			echo %%f, %%i >> AccessedFiles.csv
			set /a count=1
		)
	)
	set /a count=0
)

exit /b 0