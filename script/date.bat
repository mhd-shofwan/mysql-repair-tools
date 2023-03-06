REM Accepting arguments and assigning them to the variable "source"
set "source=%~1"
echo %source%

REM Set the date
for /f "tokens=2,3,4 delims=/ " %%d in ('echo %date%') do set "today=%%d-%%e-%%f"

REM Rename the "data" folder to "data - dd/mm/yyyy"
ren "%source%\data" "data - %today%"

echo current date: %today%