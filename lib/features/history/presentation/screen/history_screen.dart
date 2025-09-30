import 'package:flutter/material.dart';
import 'package:seci_desktop/app/router.dart';
import 'package:seci_desktop/shared/layouts/main_layout.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✨ MainLayout incluye el Sidebar automáticamente
    return Column(
      children: [
        Center(
          // ← Solo defines el contenido específico
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Historial de Conteos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Aquí se mostrarán los conteos de días anteriores',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
