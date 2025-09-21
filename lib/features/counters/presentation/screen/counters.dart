import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:seci_desktop/features/counters/presentation/providers/counter_provider.dart';
import 'package:seci_desktop/features/counters/presentation/widgets/counter_card.dart';

class CountersScreen extends ConsumerWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);

    return Scaffold(
      body: Column(
        children: [
          // Header
          _buildHeader(context, counterState),

          // // Error message si existe
          if (counterState.error != null)
            // if (true)
            _buildErrorBanner(context, ref, counterState.error!),

          // // Content
          Expanded(
            child: counterState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCountersGrid(counterState),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: state.counters.length,
        itemBuilder: (context, index) {
          return CounterCard(counter: state.counters[index]);
        },
      ),
    );
  }
}
