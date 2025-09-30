class DateUtils {
  DateUtils._();

  static DateTime dateOnly(DateTime datetime) {
    return DateTime(datetime.year, datetime.month, datetime.day);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isAfterDay(DateTime date1, DateTime date2) {
    final d1 = dateOnly(date1);
    final d2 = dateOnly(date2);

    return d1.isAfter(d2);
  }

  static bool isBeforeDay(DateTime date1, DateTime date2) {
    final d1 = dateOnly(date1);
    final d2 = dateOnly(date2);
    return d1.isBefore(d2);
  }

  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static int daysBetween(DateTime date1, DateTime date2) {
    final d1 = dateOnly(date1);
    final d2 = dateOnly(date2);
    final difference = d1.difference(d2).inDays;
    return difference;
  }
}
