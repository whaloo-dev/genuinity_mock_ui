import 'package:intl/intl.dart';

final NumberFormat numberFormat = NumberFormat("###,###", "en_US");
final NumberFormat compactNumberFormat = NumberFormat.compact(locale: "en_US");
final DateFormat dateTimeFormat = DateFormat.yMEd("en_US").add_Hms();
final DateFormat dateFormat = DateFormat.yMEd("en_US");
final DateFormat compactDateFormat = DateFormat("yyyy-MM-dd", "en_US");
final DateFormat compactDateTimeFormat =
    DateFormat("yyyy-MM-dd", "en_US").add_Hms();
final monthDayFormat = DateFormat.MMMd("en_US");
final hourMinuteFormat = DateFormat.Hm("en_US");

String dynamicDateTimeFormat(DateTime datetime) {
  final now = DateTime.now();
  if (datetime.year != now.year) {
    return compactDateFormat.format(datetime);
  }
  if (datetime.month != now.month && datetime.day != now.day) {
    return monthDayFormat.format(datetime);
  }
  return hourMinuteFormat.format(datetime);
}
