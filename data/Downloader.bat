@echo off

set "config=conf\conf.ini"

set file_url=https://github.com/msashofwan123/mysql-repair-tools/archive/refs/heads/master.zip
set save_location=C:\Users\%USERNAME%\Downloads

rem Retrieve the last release data from the GitHub repository
for /f "tokens=*" %%i in ('curl -s https://api.github.com/repos/msashofwan123/mysql-repair-tools/releases/latest ^| findstr /C:"tag_name"' ) do set release=%%i

rem Get only the version from the last release data
for /f "tokens=2 delims=:, " %%i in ("%release%") do set vgithub=%%i

set file_name=Mysql-Repair-Tools %vgithub%.rar

set download_url=%file_url%

echo Downloading file from %download_url%
curl -o "%save_location%\%file_name%" -L %download_url%

@REM Confirm
set MESSAGE_BOX_TITLE=Mysql Repair Tools
set MESSAGE_BOX_MESSAGE=Mysql Repair Tools has been successfully downloaded

mshta vbscript:msgbox("%MESSAGE_BOX_MESSAGE%",vbOKOnly,"%MESSAGE_BOX_TITLE%")(window.close)

cd /d "%userprofile%\Downloads"
start .