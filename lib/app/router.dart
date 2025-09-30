import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:seci_desktop/features/calendar/presentation/screen/calendar_screen.dart';
import 'package:seci_desktop/features/counters/presentation/screen/counters.dart';
import 'package:seci_desktop/features/history/presentation/screen/history_screen.dart';
import 'package:seci_desktop/shared/layouts/main_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => _buildPageWithSlideTransition(
            context,
            state,
            const CountersScreen(),
          ),
        ),
        GoRoute(
          path: '/history',
          pageBuilder: (context, state) => _buildPageWithSlideTransition(
            context,
            state,
            const HistoryScreen(),
          ),
        ),
        GoRoute(
          path: '/calendar',
          pageBuilder: (context, state) => _buildPageWithSlideTransition(
            context,
            state,
            const CalendarScreen(),
          ),
        ),
      ],
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
    ),
  ],
);

Page<void> _buildPageWithSlideTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.bounceIn)),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
