import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:seci_desktop/features/calendar/presentation/screen/calendar_screen.dart';
import 'package:seci_desktop/features/counters/presentation/screen/counters.dart';
import 'package:seci_desktop/features/history/presentation/screen/history_screen.dart';
import 'package:seci_desktop/shared/layouts/main_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
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
          path: '/calendar',
          pageBuilder: (context, state) => _buildPageWithSlideTransition(
            context,
            state,
            const CalendarScreen(),
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
      ],
    ),
  ],
);

Page<void> _buildPageWithSlideTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Transición suave desde la derecha
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInCirc)),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
