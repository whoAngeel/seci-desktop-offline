import 'package:flutter/material.dart';
import 'package:seci_desktop/core/constants.dart';

class CountersScreen extends StatelessWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(Icons.photo_library, color: colors.primary, size: 26),
              Image.network(seciLogo, width: 26, height: 26),
              const SizedBox(width: 4),
              Text(
                "SECI",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 3,
        // foregroundColor: colors.error,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido al SECI Desktop",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                return;
              },
              child: const Text("Contadores"),
            ),
          ],
        ),
      ),
    );
  }
}
