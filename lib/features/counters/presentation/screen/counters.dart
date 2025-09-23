import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:seci_desktop/features/counters/presentation/providers/counter_provider.dart';
import 'package:seci_desktop/features/counters/presentation/widgets/counter_card.dart';
import 'package:seci_desktop/features/counters/presentation/widgets/system_info_card.dart';

class CountersScreen extends ConsumerWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);

    return Scaffold(
      body: Row(
        children: [
          _buildSideBar(context, ref),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (counterState.error != null)
                  _buildErrorBanner(context, ref, counterState.error!),

                Expanded(
                  child: counterState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _buildCountersGrid(counterState),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar(BuildContext context, WidgetRef ref) {
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

  Widget _buildHeader(BuildContext context, CounterState state) {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "CONTADORES DIARIOS - ${dateFormatter.format(state.currentDate)}",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'TOTAL:  ${state.totalCount}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
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
    return Center(
      // padding: const EdgeInsets.all(16),
      // child: ConstrainedBox(
      // constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1.5,
            // mainAxisExtent: 150,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            // mainAxisExtent: ,
          ),
          itemCount: state.counters.length + 1,
          itemBuilder: (context, index) {
            if (index == state.counters.length) {
              return SystemInfoCard();
            }
            return CounterCard(counter: state.counters[index]);
          },
        ),
      ),
      // ),
    );
  }
}
