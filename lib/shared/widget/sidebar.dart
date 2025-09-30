import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({super.key});
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
                  // Text(
                  //   'Activo',
                  //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //     color: Theme.of(context).colorScheme.primary,
                  //   ),
                  // ),
                  // FloatingActionButton(onPressed: () {}),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.table_chart,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    tooltip: 'Datos de hoy',
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    tooltip: "Ver Calendario",
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.backup_table_sharp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    tooltip: "Ver todos los datos",
                    alignment: Alignment.center,
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
