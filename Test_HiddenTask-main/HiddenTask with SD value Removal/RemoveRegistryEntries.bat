@echo off
:: Definir las entradas de registro que se deben eliminar
set "registro1=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Calc_PS1"
set "registro2=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\GhostTask1"

:: Eliminar las entradas de registro
echo Eliminando entradas del registro...

reg delete "%registro1%" /f
if %errorlevel% neq 0 echo Error al eliminar la entrada de registro %registro1%

reg delete "%registro2%" /f
if %errorlevel% neq 0 echo Error al eliminar la entrada de registro %registro2%

:: Confirmar eliminación
echo Entradas de registro eliminadas correctamente.
pause
