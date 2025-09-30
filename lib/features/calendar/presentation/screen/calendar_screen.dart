import 'package:flutter/material.dart';
import 'package:seci_desktop/app/router.dart';
import 'package:seci_desktop/shared/layouts/main_layout.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✨ MainLayout incluye el Sidebar automáticamente
    return Column(
      // ← Marca esta ruta como activa
      children: [
        Center(
          // ← Solo defines el contenido específico
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Calendario',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Vista mensual con indicadores de conteos',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
