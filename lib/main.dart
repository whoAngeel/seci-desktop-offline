import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:seci_desktop/app/app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows) {
    await _configureWindow();
    await _setupWindowListener();
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _configureWindow() async {
  try {
    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      size: const Size(1920, 1080),
      minimumSize: const Size(1920, 1080), // Tamaño mínimo más pequeño
      maximumSize: Size.infinite, // Sin límite máximo
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: true,
      title: 'Sistema de Entradas del Centroo de Información [SECI]',
      alwaysOnTop: false, // Cambiar a false
      fullScreen: false,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setResizable(true); // Permitir redimensionar
      await windowManager.setMinimizable(true);
      await windowManager.setMaximizable(true);

      // Maximizar la ventana
      await windowManager.maximize();

      await windowManager.setPreventClose(true);

      await windowManager.show();
      await windowManager.focus();
      _logWindowInfo();
    });
  } catch (e) {
    print('❌ Window: Error en configuración: $e');
  }
}

Future<void> _setupWindowListener() async {
  windowManager.addListener(_WindowListener());
  print('👂 Window: Listener de eventos configurado');
}

/// Listener para eventos de ventana
class _WindowListener extends WindowListener {
  @override
  void onWindowFocus() {
    print('👁️ Window: Ventana enfocada');
  }

  @override
  void onWindowBlur() {
    print('👁️ Window: Ventana desenfocada');
  }

  @override
  void onWindowMinimize() {
    print('📦 Window: Ventana minimizada');
  }

  @override
  void onWindowRestore() {
    print('📦 Window: Ventana restaurada');
  }

  @override
  void onWindowClose() async {
    final context = navigatorKey.currentContext;
    if (context == null) {
      await windowManager.destroy();
      return;
    }
    ;
    final bool shouldClose = await showDialog(
      context: context,
      barrierDismissible: false, // no permitir cerrar tocando fuera
      builder: (context) => AlertDialog(
        title: const Text('¿Cerrar aplicación?'),
        content: const Text(
          '¿Estás seguro de que quieres cerrar la aplicación?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );

    if (shouldClose == true) {
      await windowManager.destroy();
    }
  }

  @override
  void onWindowResize() {
    print('📐 Window: Intento de redimensionar (bloqueado)');
  }
}

/// Muestra información de la ventana en logs
void _logWindowInfo() {
  windowManager.getSize().then((size) {
    print('📐 Window: Tamaño actual = ${size.width}x${size.height}');
  });

  windowManager.getPosition().then((position) {
    print('📍 Window: Posición = (${position.dx}, ${position.dy})');
  });

  windowManager.isAlwaysOnTop().then((isOnTop) {
    print('📌 Window: Always On Top = $isOnTop');
  });

  windowManager.isFullScreen().then((isFullScreen) {
    print('🖥️ Window: Full Screen = $isFullScreen');
  });
}
