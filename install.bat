@echo off
set "source=%~dp0FS22_GeminiAddon"

echo Welcome to the FS22_GeminiAddon installer.
echo.
echo Please provide the path to your Farming Simulator 22 mods directory.
echo For example: C:\Users\YourUser\Documents\My Games\FarmingSimulator2022\mods
echo.
set /p target="Enter the path to your mods directory: "

if not exist "%target%" (
    echo Error: Target mods directory does not exist: "%target%"
    pause
    exit /b 1
)

xcopy /E /I /Y "%source%" "%target%\FS22_GeminiAddon"
echo Mod installed successfully. Please activate it in Farming Simulator 22.
pause
