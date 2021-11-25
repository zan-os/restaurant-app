import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final specificTime = '21:42:00';
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayAndTime = "$todayDate $specificTime";
    var resultToday = completeFormat.parseStrict(todayAndTime);

    var formatted = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $specificTime";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
