import 'package:intl/intl.dart';

class DateFormatter {
  // định giạng giờ
  static String formatHour(DateTime date) {
    if (DateTime.now().hour == date.hour) return 'Now';
    return DateFormat.Hm().format(date);
  }

  // định giạng ngày
  static String formatDay(DateTime date) {
    if (DateTime.now().day == date.day) return 'Today';
    return DateFormat.EEEE().format(date);
  }
}
