import 'package:flutter/material.dart';

class CountersScreen extends StatelessWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SECI Desktop"),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Bienvenido al SECI Desktop"),
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
