import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:seci_desktop/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuración para desktop
  await windowManager.ensureInitialized();

  final WindowOptions windowOptions = const WindowOptions(
    // Elimina las propiedades de tamaño fijo para permitir el modo de pantalla completa
    center: true,
    backgroundColor: Colors.transparent,
    // skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,

    title: 'Sistema de Entradas del Centroo de Información [SECI]',
    alwaysOnTop: false,
    // fullScreen: true, // Se inicia en pantalla completa
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Configurar propiedades de la ventana
    // await windowManager.setPreventClose(false);
    // await windowManager.setResizable(false); // No redimensionable
    await windowManager.setMinimizable(true);
    await windowManager.setMaximizable(true); // Permitir fullscreen
    await windowManager.setSize(const Size(1920, 1080)); // Forzar tamaño exacto
    await windowManager.center(animate: true);
    // await windowManager.
    // Mostrar la ventana
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const ProviderScope(child: MyApp()));
}
