import 'package:flutter/cupertino.dart';
import 'package:seci_desktop/features/calendar/presentation/screen/calendar_screen.dart';
import 'package:seci_desktop/features/counters/presentation/screen/counters.dart';
import 'package:seci_desktop/features/history/presentation/screen/history_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String counters = "/";
  static const String history = "/history";
  static const String calendar = "/calendar";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      counters: (context) => const CountersScreen(),
      history: (context) => const HistoryScreen(),
      calendar: (context) => const CalendarScreen(),
    };
  }

  static Future<void> navigateTo(BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }
}
