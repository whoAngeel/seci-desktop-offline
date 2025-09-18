import 'package:flutter/material.dart';

class CountersScreen extends StatelessWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("SECI", style: Theme.of(context).textTheme.titleLarge),
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
