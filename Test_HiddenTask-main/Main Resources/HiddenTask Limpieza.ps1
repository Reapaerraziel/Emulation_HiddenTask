try {
    Clear-Host
    Write-Host "[Iniciando limpieza de la emulación HiddenTask]" -ForegroundColor Green

    # Ruta base del directorio usado en la emulación
    $rutaBase = Join-Path -Path $env:HOMEPATH -ChildPath "HiddenTask"

    # Ruta del archivo .bat que eliminará las entradas de registro
    $batPath = Join-Path -Path $rutaBase -ChildPath "RemoveRegistryEntries.bat"

    # Ruta de PsExec.exe dentro de la carpeta HiddenTask
    $psExecPath = Join-Path -Path $rutaBase -ChildPath "PsExec.exe"

    # Verificar si el archivo .bat existe
    if (Test-Path $batPath) {
        Write-Host "[+] Ejecutando RemoveRegistryEntries.bat usando PsExec..." -ForegroundColor Yellow

        # Usar PsExec para ejecutar el .bat con privilegios elevados
        Start-Process -FilePath $psExecPath -ArgumentList "-accepteula", "-s", "cmd.exe", "/c", $batPath -Wait

        Write-Host "[✓] Entradas de registro eliminadas correctamente." -ForegroundColor Cyan
    } else {
        Write-Host "[!] El archivo RemoveRegistryEntries.bat no se encontró." -ForegroundColor Red
    }

    # Eliminar los archivos y directorios creados
    if (Test-Path -Path $rutaBase) {
        Write-Host "[+] Eliminando directorio temporal: $rutaBase" -ForegroundColor Yellow
        Remove-Item -Path $rutaBase -Recurse -Force
        Write-Host "[✓] Directorio eliminado correctamente." -ForegroundColor Cyan
    }
    else {
        Write-Host "[!] Directorio temporal no encontrado, puede que ya se haya eliminado." -ForegroundColor DarkGray
    }

    # **Eliminación de PsExec.exe al final**
    if (Test-Path -Path $psExecPath) {
        Write-Host "[+] Eliminando PsExec.exe..." -ForegroundColor Yellow
        Remove-Item -Path $psExecPath -Force
        Write-Host "[✓] PsExec.exe eliminado correctamente." -ForegroundColor Cyan
    }

    # Confirmación final
    Write-Host "`n✔ Limpieza completada." -ForegroundColor Green
    Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
catch {
    Write-Host "[X] Error durante el proceso de limpieza: $_" -ForegroundColor Red
    Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
