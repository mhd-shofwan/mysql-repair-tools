@echo off

call data\app.bat
set vdata=%data%

:selectdir
echo Please select the "mysql" directory on your PC. "(Default = C:\xampp\mysql)"

REM Displaying a pop-up dialog to select a directory using a .vbs file.
for /f "delims=" %%d in ('cscript //nologo data\script\PathFinder.vbs') do set "source=%%d"

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

timeout /t 1

REM Set the date
for /f "tokens=2,3,4 delims=/ " %%d in ('echo %date%') do set "today=%%d-%%e-%%f"

REM Rename the "data" folder to "data - dd-mm-yyyy"
ren "%source%\data" "data - %today%"

echo current date: %today%
@REM echo %source%
echo Data has been updated with the date

timeout /t 1

REM Duplicate "backup" folder and rename it to "data" folder
xcopy "%source%\backup" "%source%\data" /e /i /h /k

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
timeout /t 1

REM Deleting "tmp-data" directory
rmdir /s /q "%source%\tmp-data"
echo.
echo. tmp-data has been deleted.

@REM Provide an option whether to perform Stage 2 Repair
cscript data\script\GrantDeny.vbs %source%

REM End of script
set MESSAGE_BOX_TITLE=Mysql Repair Tools v%vdata%
set MESSAGE_BOX_MESSAGE=Repair process has ended. Thank you for using our application

mshta vbscript:msgbox("%MESSAGE_BOX_MESSAGE%",vbOKOnly,"%MESSAGE_BOX_TITLE%")(window.close)