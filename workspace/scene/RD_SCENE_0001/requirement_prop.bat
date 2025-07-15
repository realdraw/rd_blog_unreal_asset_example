@echo off
pushd "%~dp0"
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File ".\requirements_prop.ps1"
pause
