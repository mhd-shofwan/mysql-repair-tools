@echo off

set "config=conf\conf.ini"
set "version=Version"
set "status=data\script\status.vbs"

set repo_username=msashofwan123
set repo_name=mysql-repair-tools
set conn=

:: Retrieve the latest version from the conf.ini file.
for /f "tokens=2 delims==" %%v in ('type "%config%" ^| findstr /i "%version%"') do (
    set "vdata=v%%v"
)

:: Run VBS script to check internet connection and capture its value
for /f %%i in ('cscript //nologo data\script\status.vbs') do set conn=%%i

rem Retrieve data of the last release from GitHub repository
for /f "tokens=*" %%i in ('curl -s https://api.github.com/repos/%repo_username%/%repo_name%/releases/latest ^| findstr /C:"tag_name"' ) do set release=%%i

rem Get only the version from the last release data
for /f "tokens=2 delims=:, " %%i in ("%release%") do set vgithub=%%i


@REM Check if there is a my.ini file
if exist "%config%" (
    @REM Check if there is a status.vbs file
    if exist "%status%" (

        echo Your Internet Connection : %conn%
        echo .
        if "%conn%" == "online" ( echo The latest version of Mysql Repair Tools is %vgithub% ) else ( echo Failed to Connect to the Internet )
        echo Current Version : %vdata%
        echo .

        @REM Update Confirmation Alert
        if "%vdata%"=="%vgithub%" (
            echo Application is already up to date
        ) else (
            echo New Application Version Available
            cscript data\script\alert.vbs "Update Available" "New Application Version is available. Do you want to download it?" "  Download Cancelled" "data\Downloader.bat"
        )

    ) else (
        echo File %status% Not Found
        goto :end
    )

) else (
    echo File %config% Not Found
    goto :end
)

:end
pause