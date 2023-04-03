@echo off

set "myIniFile=conf\conf.ini"
set "version=Version"
set "date_app=Date"

for /f "tokens=2 delims==" %%a in ('type "%myIniFile%" ^| findstr /i "%version%"') do (
    set "data=%%a"
)
for /f "tokens=2 delims==" %%b in ('type "%myIniFile%" ^| findstr /i "%date_app%"') do (
    set "data_a=%%b"
)

echo ============= MYSQL REPAIR TOOLS FOR XAMPP ==================================
echo.
echo  __    __        __  __        _____    
echo /\ "-./  \      /\ \_\ \      /\  __-.  
echo \ \ \-./\ \     \ \  __ \     \ \ \/\ \ 
echo  \ \_\ \ \_\     \ \_\ \_\     \ \____- 
echo   \/_/  \/_/      \/_/\/_/      \/____/ 
echo.                                         
echo. ______   ______     ______       __     ______     ______     ______  
echo./\  == \ /\  == \   /\  __ \     /\ \   /\  ___\   /\  ___\   /\__  _\ 
echo.\ \  _-/ \ \  __/   \ \ \-\ \   _\_\ \  \ \  __\   \ \ \____  \/_/\ \/ 
echo  \ \_\    \ \_\ \_\  \ \_____\ /\_____\  \ \_____\  \ \_____\    \ \_\ 
echo   \/_/     \/_/ /_/   \/_____/ \/_____/   \/_____/   \/_____/     \/_/ 
echo. 
echo.
echo ============= MYSQL REPAIR TOOLS FOR XAMPP ==================================
echo.
echo Name           = Mysql Repair Tools For XAMPP (Windows)
echo Version        = %data%
echo Release date   = %data_a%
echo Developer      = MHD Project
echo.
echo Starting App...
pause
echo.
echo.