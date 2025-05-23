echo off
cd /d "%~dp0"
GhostTask.exe localhost add GhostTask1 "cmd.exe" "/c calc.exe" %computername% daily logon