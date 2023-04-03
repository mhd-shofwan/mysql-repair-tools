@echo off

@REM Set Variable
set source=%1
set "file_source=%1\bin\my.ini"
set "section=[mysqld]"
set "line_data=skip-grant-tables"
findstr "%line_data%" "%file_source%" >nul

@REM Check if the my.ini file exist
if exist "%file_source%" (
    echo File Found

    if %errorlevel% equ 0 (
        echo File %file_source% already contains text "%line_data%".
        goto :end
    ) else (
        echo File %file_source% does not yet contain text "%line_data%".
        
        @REM Command to add text after [mysqld]
        (for /f "tokens=*" %%a in ('type "%file_source%"') do (
            echo %%a
            if "%%a"=="%section%" (
                echo %line_data%
            )
        )) > "%file_source%.new"
        move /y "%file_source%.new" "%file_source%"
    )

) else (
    echo File Not Found
    goto :end
)
:end
timeout /t 1