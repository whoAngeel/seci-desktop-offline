import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:seci_desktop/app/router.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = GoRouterState.of(context).uri.path;
    return Container(
      width: 80,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              'SECI',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Expanded()
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  _buildNavButton(
                    context,
                    icon: Icons.table_chart,
                    tooltip: 'Contadores',
                    route: '/',
                    isActive: currentLocation == '/',
                  ),
                  _buildNavButton(
                    context,
                    icon: Icons.calendar_month,
                    tooltip: 'Calendario',
                    route: '/calendar',
                    isActive: currentLocation == '/calendar',
                  ),
                  _buildNavButton(
                    context,
                    icon: Icons.backup_table_sharp,
                    tooltip: 'Ver historial',
                    route: '/history',
                    isActive: currentLocation == '/history',
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Tooltip(
                  message: 'Sistema Activo',
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                Tooltip(
                  message: 'Elaborado por: Angel Jesus Zorrilla Cuevas',
                  child: Icon(Icons.info, color: Colors.blue, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required String route,
    required bool isActive,
  }) {
    return IconButton(
      onPressed: () => context.go(route),
      icon: Icon(
        icon,
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
      tooltip: tooltip,
      alignment: Alignment.center,
    );
  }
}
