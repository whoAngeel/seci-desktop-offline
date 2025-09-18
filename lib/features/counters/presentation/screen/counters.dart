import 'package:flutter/material.dart';

class CountersScreen extends StatelessWidget {
  const CountersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SECI Desktop")),
      body: const Center(child: Column(children: [Text("Contadores")])),
    );
  }
}
