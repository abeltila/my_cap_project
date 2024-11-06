part of 'index.dart';
/// A utility class for formatting date and time.
class DateTimeUtils {
  /// Formats a [DateTime] object into a string representation.
  ///
  /// If the date is today, it returns the time as `HH:mm`.
  /// If the date is yesterday, it returns `Yesterday`.
  /// If the date is within the last 7 days, it returns the day of the week.
  /// Otherwise, it returns the date as `MM/dd/yyyy`.
  static String formatDateTime(DateTime dateTime) {
    final lastMessageAt = dateTime.toLocal();
    String stringDate;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    if (lastMessageAt.isAfter(startOfDay) || lastMessageAt.isAtSameMomentAs(startOfDay)) {
      // Display time as HH:mm
      final hour = lastMessageAt.hour.toString().padLeft(2, '0');
      final minutes = lastMessageAt.minute.toString().padLeft(2, '0');
      stringDate = '$hour:$minutes';
    } else if (lastMessageAt.isAfter(startOfDay.subtract(const Duration(days: 1))) ||
        lastMessageAt.isAtSameMomentAs(startOfDay.subtract(const Duration(days: 1)))) {
      // Display the day of the week
      stringDate = _getDayOfWeek(lastMessageAt.weekday);
    } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
      stringDate = _getDayOfWeek(lastMessageAt.weekday);
    } else {
      // Display date as MM/dd/yyyy
      final month = lastMessageAt.month.toString().padLeft(2, '0');
      final day = lastMessageAt.day.toString().padLeft(2, '0');
      final year = lastMessageAt.year;
      stringDate = '$month/$day/$year';
    }

    return stringDate;
  }

  static String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
