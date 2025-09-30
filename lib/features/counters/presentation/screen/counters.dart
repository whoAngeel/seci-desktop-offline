import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:seci_desktop/features/counters/presentation/providers/counter_provider.dart';
import 'package:seci_desktop/features/counters/presentation/widgets/counter_card.dart';
import 'package:seci_desktop/features/counters/presentation/widgets/system_info_card.dart';
import 'package:seci_desktop/shared/widget/sidebar.dart';

class CountersScreen extends ConsumerWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header con título
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Text(
                    "Sistema de Entradas del Centro de Información",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 38,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Banner de error si existe
                if (counterState.error != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: _buildErrorBanner(context, ref, counterState.error!),
                  ),

                // Contenido principal centrado
                Expanded(
                  child: Center(
                    child: counterState.isLoading
                        ? const CircularProgressIndicator()
                        : _buildCountersGrid(counterState),
                  ),
                ),

                // Footer con fecha
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "Fecha actual: ${DateFormat('dd/MM/yyyy').format(counterState.currentDate)}",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 48,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(BuildContext context, WidgetRef ref, String error) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.errorContainer,
      width: double.infinity,
      child: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              error,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
          IconButton(
            onPressed: () => ref.read(counterProvider.notifier).clearError(),
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountersGrid(CounterState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: state.counters.length + 1,
        itemBuilder: (context, index) {
          if (index == state.counters.length) {
            return SystemInfoCard();
          }
          return CounterCard(counter: state.counters[index]);
        },
      ),
    );
  }
}
