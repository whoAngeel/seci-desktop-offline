import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';
import 'package:seci_desktop/features/counters/presentation/providers/counter_provider.dart';

class CounterCard extends ConsumerWidget {
  final CounterEntity counter;

  const CounterCard({super.key, required this.counter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String shortName =
        Categories.shortNames[counter.category] ?? counter.category;
    final String name = Categories.all
        .where((element) => element == counter.category)
        .first;
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nombre de la categoria
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // contadores M y H
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // columan mujeres,
                _GenderCounter(
                  label: 'M',
                  count: counter.womenCount,
                  onIncrement: () => ref
                      .read(counterProvider.notifier)
                      .incrementCounter(counter.category, Gender.women),
                  onDecrement: () => ref
                      .read(counterProvider.notifier)
                      .decrementCounter(counter.category, Gender.women),
                ),

                // cloumna hombres
                _GenderCounter(
                  label: 'H',
                  count: counter.menCount,
                  onIncrement: () => ref
                      .read(counterProvider.notifier)
                      .incrementCounter(counter.category, Gender.men),
                  onDecrement: () => ref
                      .read(counterProvider.notifier)
                      .decrementCounter(counter.category, Gender.men),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // TOTAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${counter.total}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderCounter extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _GenderCounter({
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        SizedBox(
          width: 32,
          height: 24,
          child: IconButton(
            onPressed: count > 0 ? onDecrement : null,
            icon: const Icon(Icons.remove, size: 16),
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              backgroundColor: count > 0
                  ? Theme.of(context).colorScheme.errorContainer
                  : Theme.of(context).colorScheme.primary,
              foregroundColor: count > 0
                  ? Theme.of(context).colorScheme.onErrorContainer
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 4),

        // condator
        Container(
          width: 32,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '$count',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 4),
        // boton incrementar
        SizedBox(
          width: 32,
          height: 24,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
