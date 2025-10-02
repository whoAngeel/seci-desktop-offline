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
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation.drive(
                      Tween(
                        begin: 0.95,
                        end: 1.0,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(child.runtimeType.toString()),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
