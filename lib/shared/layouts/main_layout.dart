import 'package:flutter/material.dart';
import 'package:seci_desktop/shared/widgets/sidebar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
