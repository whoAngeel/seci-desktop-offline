# Configuración de Desarrollo - SECI Desktop

## Versiones Requeridas

Este proyecto utiliza **Flutter Version Management (fvm)** para garantizar que todo el equipo use las mismas versiones.

### Versiones Actuales:
- **Flutter:** 3.35.4 (stable)
- **Dart:** 3.9.2
- **Channel:** stable

## Configuración Inicial

### 1. Instalar Dart (si no lo tienes)
```bash
# Windows (usando Chocolatey)
choco install dart-sdk

# O descargar desde: https://dart.dev/get-dart
```

### 2. Instalar FVM
```bash
dart pub global activate fvm
```

### 3. Configurar PATH
Asegúrate de que `C:\Users\<tu-usuario>\AppData\Local\Pub\Cache\bin` esté en tu PATH.

### 4. Clonar el Proyecto
```bash
git clone <url-del-repo>
cd seci_desktop
```

### 5. Instalar la Versión de Flutter del Proyecto
```bash
# FVM automáticamente leerá el archivo .fvmrc y usará la versión correcta
fvm install
fvm use stable
```

### 6. Instalar Dependencias
```bash
fvm flutter pub get
```

## Comandos de Desarrollo

### Ejecutar la Aplicación
```bash
# Web
fvm flutter run -d chrome

# Windows Desktop
fvm flutter run -d windows
```

### Compilar
```bash
# Web
fvm flutter build web

# Windows
fvm flutter build windows
```

### Análisis de Código
```bash
fvm flutter analyze
```

### Tests
```bash
fvm flutter test
```

## Plataformas Soportadas

✅ **Web** - Chrome, Edge, Firefox  
✅ **Windows Desktop** - Windows 10/11  
❌ Android, iOS, Linux, macOS (no soportadas)

## Verificar Configuración

Para verificar que tienes la configuración correcta:

```bash
# Verificar versión de Flutter
fvm flutter --version

# Verificar dispositivos disponibles
fvm flutter devices

# Verificar configuración general
fvm flutter doctor
```

## Troubleshooting

### Problema: "fvm no se reconoce como comando"
**Solución:** Agregar `C:\Users\<tu-usuario>\AppData\Local\Pub\Cache\bin` al PATH del sistema.

### Problema: Versión incorrecta de Flutter
**Solución:** 
```bash
fvm use stable
fvm flutter --version
```

### Problema: Dependencias desactualizadas
**Solución:**
```bash
fvm flutter clean
fvm flutter pub get
```

## Estructura del Proyecto

```
seci_desktop/
├── lib/                 # Código fuente principal
├── web/                 # Archivos web específicos
├── windows/             # Archivos Windows específicos
├── test/                # Tests
├── .fvmrc              # Configuración de versión Flutter
├── pubspec.yaml        # Dependencias
└── DEVELOPMENT_SETUP.md # Esta guía
```

## Reglas del Equipo

1. **NUNCA** usar `flutter` directamente, siempre usar `fvm flutter`
2. **SIEMPRE** verificar la versión antes de hacer commits importantes
3. **ACTUALIZAR** este documento cuando cambien las versiones
4. **COMUNICAR** cambios de versión al equipo antes de hacer push

## Contacto

Si tienes problemas con la configuración, contacta al lead del proyecto.
