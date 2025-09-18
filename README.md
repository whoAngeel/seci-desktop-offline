# SECI Desktop

Aplicación de escritorio para SECI desarrollada con Flutter, con soporte para Web y Windows.

## 🚀 Configuración Rápida

> **⚠️ IMPORTANTE:** Este proyecto usa **fvm** para gestión de versiones. Lee la [guía completa](DEVELOPMENT_SETUP.md) antes de empezar.

### Versiones Requeridas
- Flutter: **3.35.4** (stable)
- Dart: **3.9.2**

### Setup Inicial
```bash
# 1. Clonar el proyecto
git clone <url-del-repo>
cd seci_desktop

# 2. Instalar versión de Flutter
fvm install 3.35.4
fvm use 3.35.4

# 3. Instalar dependencias
fvm flutter pub get

# 4. Verificar configuración
powershell -ExecutionPolicy Bypass -File scripts/verify_setup.ps1
```

## 🛠️ Comandos de Desarrollo

```bash
# Ejecutar en web
fvm flutter run -d chrome

# Ejecutar en Windows
fvm flutter run -d windows

# Compilar para producción
fvm flutter build web
fvm flutter build windows
```

## 🎯 Plataformas Soportadas

✅ **Web** (Chrome, Edge, Firefox)
✅ **Windows Desktop** (Windows 10/11)
❌ Android, iOS, Linux, macOS

## 📁 Estructura del Proyecto

```
seci_desktop/
├── lib/                    # Código fuente principal
├── web/                    # Configuración web
├── windows/                # Configuración Windows
├── scripts/                # Scripts de utilidad
├── .fvmrc                  # Configuración FVM
└── DEVELOPMENT_SETUP.md    # Guía detallada de setup
```

## 🔧 Solución de Problemas

Si tienes problemas:

1. **Ejecuta el script de verificación:**
   ```bash
   powershell -ExecutionPolicy Bypass -File scripts/verify_setup.ps1
   ```

2. **Consulta la [guía completa](DEVELOPMENT_SETUP.md)**

3. **Verifica que uses `fvm flutter` en lugar de `flutter`**

## 🤝 Contribuir

1. Asegúrate de tener la configuración correcta
2. Sigue las [reglas del equipo](DEVELOPMENT_SETUP.md#reglas-del-equipo)
3. Ejecuta `fvm flutter analyze` antes de hacer commit
4. Prueba en ambas plataformas (web y Windows)
