# Script de Verificación de Configuración - SECI Desktop
# Este script verifica que tienes la configuración correcta para el desarrollo

Write-Host "🔍 Verificando configuración de desarrollo..." -ForegroundColor Cyan
Write-Host ""

$errors = 0

# Verificar que fvm está instalado
Write-Host "1. Verificando FVM..." -ForegroundColor Yellow
try {
    $fvmVersion = fvm --version 2>$null
    if ($fvmVersion) {
        Write-Host "   ✅ FVM instalado: v$fvmVersion" -ForegroundColor Green
    } else {
        throw "FVM no encontrado"
    }
} catch {
    Write-Host "   ❌ FVM no está instalado o no está en el PATH" -ForegroundColor Red
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
            Write-Host "   ✅ Flutter versión correcta: $currentVersion" -ForegroundColor Green
        } else {
            Write-Host "   ⚠️  Flutter versión incorrecta: $currentVersion (esperado: 3.35.4)" -ForegroundColor Yellow
            Write-Host "      Ejecuta: fvm use 3.35.4" -ForegroundColor Gray
        }
    } else {
        throw "No se pudo obtener la versión de Flutter"
    }
} catch {
    Write-Host "   ❌ Error verificando Flutter" -ForegroundColor Red
    Write-Host "      Ejecuta: fvm install 3.35.4" -ForegroundColor Gray
    Write-Host "      Luego: fvm use 3.35.4" -ForegroundColor Gray
    $errors++
}

# Verificar Dart
Write-Host "3. Verificando Dart..." -ForegroundColor Yellow
try {
    $dartInfo = fvm flutter --version 2>$null
    if ($dartInfo -match "Dart (\d+\.\d+\.\d+)") {
        $dartVersion = $matches[1]
        Write-Host "   ✅ Dart versión: $dartVersion" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  No se pudo determinar la versión de Dart" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ❌ Error verificando Dart" -ForegroundColor Red
    $errors++
}

# Verificar archivo .fvmrc
Write-Host "4. Verificando configuración FVM..." -ForegroundColor Yellow
if (Test-Path ".fvmrc") {
    $fvmrcContent = Get-Content ".fvmrc" | ConvertFrom-Json
    if ($fvmrcContent.flutter -eq "3.35.4") {
        Write-Host "   ✅ .fvmrc configurado correctamente" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  .fvmrc tiene versión incorrecta: $($fvmrcContent.flutter)" -ForegroundColor Yellow
    }
} else {
    Write-Host "   ❌ Archivo .fvmrc no encontrado" -ForegroundColor Red
    $errors++
}

# Verificar dependencias
Write-Host "5. Verificando dependencias..." -ForegroundColor Yellow
try {
    if (Test-Path "pubspec.lock") {
        Write-Host "   ✅ pubspec.lock existe" -ForegroundColor Green
        Write-Host "      Ejecutando flutter pub get..." -ForegroundColor Gray
        fvm flutter pub get > $null 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   ✅ Dependencias instaladas correctamente" -ForegroundColor Green
        } else {
            Write-Host "   ⚠️  Error instalando dependencias" -ForegroundColor Yellow
        }
    } else {
        Write-Host "   ⚠️  pubspec.lock no existe, ejecutando flutter pub get..." -ForegroundColor Yellow
        fvm flutter pub get
    }
} catch {
    Write-Host "   ❌ Error verificando dependencias" -ForegroundColor Red
    $errors++
}

# Verificar plataformas disponibles
Write-Host "6. Verificando plataformas disponibles..." -ForegroundColor Yellow
try {
    $devices = fvm flutter devices 2>$null
    if ($devices -match "Windows \(desktop\)") {
        Write-Host "   ✅ Plataforma Windows disponible" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  Plataforma Windows no disponible" -ForegroundColor Yellow
    }
    
    if ($devices -match "Chrome \(web\)") {
        Write-Host "   ✅ Plataforma Web (Chrome) disponible" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️  Plataforma Web no disponible" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ❌ Error verificando plataformas" -ForegroundColor Red
    $errors++
}

Write-Host ""
if ($errors -eq 0) {
    Write-Host "🎉 ¡Configuración correcta! Estás listo para desarrollar." -ForegroundColor Green
    Write-Host ""
    Write-Host "Comandos útiles:" -ForegroundColor Cyan
    Write-Host "  fvm flutter run -d chrome    # Ejecutar en web" -ForegroundColor Gray
    Write-Host "  fvm flutter run -d windows   # Ejecutar en Windows" -ForegroundColor Gray
    Write-Host "  fvm flutter build web        # Compilar para web" -ForegroundColor Gray
    Write-Host "  fvm flutter build windows    # Compilar para Windows" -ForegroundColor Gray
} else {
    Write-Host "⚠️  Se encontraron $errors problema(s). Revisa los mensajes anteriores." -ForegroundColor Yellow
    Write-Host "📖 Consulta DEVELOPMENT_SETUP.md para mas detalles." -ForegroundColor Gray
}

Write-Host ""
