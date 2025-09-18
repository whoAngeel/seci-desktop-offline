import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seci_desktop/core/constants.dart';
import 'package:seci_desktop/features/counters/domain/entities/counter_entity.dart';

class CounterCard extends ConsumerWidget {
  final CounterEntity counter;

  const CounterCard({super.key, required this.counter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortName =
        Categories.shortNames[counter.category] ?? counter.category;

    return const Card(elevation: 3, child: Column(children: [Text("Hola")]));
  }
}
