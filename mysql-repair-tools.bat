@echo off

call script\app.bat

:selectdir
echo Please select the "mysql" directory on your PC. "(Default = c:\xampp\mysql)"

REM Displaying a pop-up dialog to select a directory using a .vbs file.
for /f "delims=" %%d in ('cscript //nologo script\selectdir.vbs') do set "source=%%d"

REM Display a message with the selected directory
echo .
echo You have selected the directory: %source%
echo .
echo Are you sure you have selected the correct directory? (Y/N)

set "userinput="
set /p userinput=

if /i "%userinput%"=="N" (
    goto selectdir
    )

REM Duplicate "data" folder to "tmp-data"
xcopy "%source%\data" "%source%\tmp-data" /e /i /h /k

timeout /t 2

call script\date.bat "%source%"

@REM echo %source%
echo Data has been updated with the date

timeout /t 2

REM Duplicate "backup" folder and rename it to "data" folder
xcopy "%source%\backup" "%source%\data" /e /i /h /k.

        REM Copying all folders from "tmp-data" MySQL except for 4 core folders.
        for /d %%f in ("%source%\tmp-data\*") do (
            if /i not "%%~nxf"=="mysql" (
                if /i not "%%~nxf"=="performance_schema" (
                    if /i not "%%~nxf"=="test" (
                        if /i not "%%~nxf"=="phpmyadmin" (
                            xcopy "%%f" "%source%\data\%%~nxf\" /E /I /H /Y
                        )
                    )
                )
            )
        )

REM Copy "ibdata1" database file
copy "%source%\tmp-data\ibdata1" "%source%\data" /Y
echo.
echo Deleting tmp-data
timeout /t 3

REM Deleting "tmp-data" directory
rmdir /s /q "%source%\tmp-data"
echo.
echo. tmp-data has been deleted.

REM End of script
echo.
echo ============= MYSQL REPAIR TOOLS FOR XAMPP ==================================
echo.
echo The process has ended. Thank you for trusting our program, MYSQL REPAIR TOOLS.
echo .
echo Program Version 1.1.0
echo .
echo Developed By [MHD Project]

timeout /t 5
