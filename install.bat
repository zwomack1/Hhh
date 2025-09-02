@echo off
set "source=%~dp0FS22_GeminiAddon"
set "target=C:\Users\Shadow\Documents\Farming Simulator 22 - SteamGG.net\mods"

if not exist "%target%" (
    echo Error: Target mods directory does not exist
    pause
    exit /b 1
)

xcopy /E /I /Y "%source%" "%target%\FS22_GeminiAddon"
echo Mod installed successfully. Please activate it in Farming Simulator 22.
pause
