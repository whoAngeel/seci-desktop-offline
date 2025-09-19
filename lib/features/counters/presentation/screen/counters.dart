import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:seci_desktop/features/counters/presentation/providers/counter_provider.dart';

class CountersScreen extends ConsumerWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final counterNotifier = ref.read(counterProvider.notifier);

    return const Scaffold(
      body: Column(
        children: [
          // Header
          // _buildHeader(context, counterState),

          // // Error message si existe
          // if (counterState.error != null)
          //   // _buildErrorBanner(context, ref, counterState.error!),

          // // Content
          // Expanded(
          //   child: counterState.isLoading
          //       ? const Center(child: CircularProgressIndicator())
          //       : _buildCountersGrid(counterState),
          // ),
          // Text(DateFormat('dd/MM/YYYY').format(counterState.currentDate)),
        ],
      ),
    );
  }
}
