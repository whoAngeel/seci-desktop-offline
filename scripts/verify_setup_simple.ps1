# Script de Verificacion de Configuracion - SECI Desktop

Write-Host "Verificando configuracion de desarrollo..." -ForegroundColor Cyan
Write-Host ""

$errors = 0

# Verificar FVM
Write-Host "1. Verificando FVM..." -ForegroundColor Yellow
try {
    $fvmVersion = fvm --version 2>$null
    if ($fvmVersion) {
        Write-Host "   OK - FVM instalado: v$fvmVersion" -ForegroundColor Green
    } else {
        throw "FVM no encontrado"
    }
} catch {
    Write-Host "   ERROR - FVM no esta instalado" -ForegroundColor Red
    Write-Host "      Instala con: dart pub global activate fvm" -ForegroundColor Gray
    $errors++
}

# Verificar Flutter
Write-Host "2. Verificando Flutter..." -ForegroundColor Yellow
try {
    $flutterInfo = fvm flutter --version 2>$null
    if ($flutterInfo -match "Flutter (\d+\.\d+\.\d+)") {
        $currentVersion = $matches[1]
        if ($currentVersion -eq "3.35.4") {
            Write-Host "   OK - Flutter version correcta: $currentVersion" -ForegroundColor Green
        } else {
            Write-Host "   WARN - Flutter version incorrecta: $currentVersion (esperado: 3.35.4)" -ForegroundColor Yellow
            Write-Host "      Ejecuta: fvm use 3.35.4" -ForegroundColor Gray
        }
    } else {
        throw "No se pudo obtener la version de Flutter"
    }
} catch {
    Write-Host "   ERROR - Error verificando Flutter" -ForegroundColor Red
    Write-Host "      Ejecuta: fvm install 3.35.4" -ForegroundColor Gray
    $errors++
}

# Verificar .fvmrc
Write-Host "3. Verificando configuracion FVM..." -ForegroundColor Yellow
if (Test-Path ".fvmrc") {
    $fvmrcContent = Get-Content ".fvmrc" | ConvertFrom-Json
    if ($fvmrcContent.flutter -eq "3.35.4") {
        Write-Host "   OK - .fvmrc configurado correctamente" -ForegroundColor Green
    } else {
        Write-Host "   WARN - .fvmrc tiene version incorrecta: $($fvmrcContent.flutter)" -ForegroundColor Yellow
    }
} else {
    Write-Host "   ERROR - Archivo .fvmrc no encontrado" -ForegroundColor Red
    $errors++
}

# Verificar plataformas
Write-Host "4. Verificando plataformas disponibles..." -ForegroundColor Yellow
try {
    $devices = fvm flutter devices 2>$null
    if ($devices -match "Windows \(desktop\)") {
        Write-Host "   OK - Plataforma Windows disponible" -ForegroundColor Green
    } else {
        Write-Host "   WARN - Plataforma Windows no disponible" -ForegroundColor Yellow
    }
    
    if ($devices -match "Chrome \(web\)") {
        Write-Host "   OK - Plataforma Web (Chrome) disponible" -ForegroundColor Green
    } else {
        Write-Host "   WARN - Plataforma Web no disponible" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ERROR - Error verificando plataformas" -ForegroundColor Red
    $errors++
}

Write-Host ""
if ($errors -eq 0) {
    Write-Host "EXITO - Configuracion correcta! Estas listo para desarrollar." -ForegroundColor Green
    Write-Host ""
    Write-Host "Comandos utiles:" -ForegroundColor Cyan
    Write-Host "  fvm flutter run -d chrome    # Ejecutar en web" -ForegroundColor Gray
    Write-Host "  fvm flutter run -d windows   # Ejecutar en Windows" -ForegroundColor Gray
    Write-Host "  fvm flutter build web        # Compilar para web" -ForegroundColor Gray
    Write-Host "  fvm flutter build windows    # Compilar para Windows" -ForegroundColor Gray
} else {
    Write-Host "ADVERTENCIA - Se encontraron $errors problema(s). Revisa los mensajes." -ForegroundColor Yellow
    Write-Host "Consulta DEVELOPMENT_SETUP.md para mas detalles." -ForegroundColor Gray
}

Write-Host ""
