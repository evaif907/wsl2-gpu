@echo off
SET "scriptDir=%~dp0"
SET "scriptDir=%scriptDir:~0,-1%"
SET "wslScriptPath=$(wsl wslpath '%scriptDir%')/export_system_info.sh"
wsl cp "%wslScriptPath%" /usr/local/share/export_system_info.sh
wsl chmod +x /usr/local/share/export_system_info.sh

pause