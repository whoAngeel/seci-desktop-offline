import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seci_desktop/app/router.dart';

class Sidebar extends ConsumerWidget {
  final String currentRoute;

  const Sidebar({super.key, required this.currentRoute});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  _SidebarButton(
                    icon: Icons.table_chart,
                    tooltip: 'Contadores',
                    isActive: currentRoute == AppRoutes.counters,
                    onPressed: () =>
                        AppRoutes.navigateTo(context, AppRoutes.counters),
                  ),
                  _SidebarButton(
                    icon: Icons.calendar_month,
                    tooltip: 'Calendario',
                    isActive: currentRoute == AppRoutes.calendar,
                    onPressed: () =>
                        AppRoutes.navigateTo(context, AppRoutes.calendar),
                  ),
                  _SidebarButton(
                    icon: Icons.history,
                    tooltip: 'Historial',
                    isActive: currentRoute == AppRoutes.history,
                    onPressed: () =>
                        AppRoutes.navigateTo(context, AppRoutes.history),
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
}

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final bool isActive;
  final VoidCallback onPressed;

  const _SidebarButton({
    required this.icon,
    required this.tooltip,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          size: isActive ? 28 : 24,
        ),
        tooltip: tooltip,
        alignment: Alignment.center,
      ),
    );
  }
}
