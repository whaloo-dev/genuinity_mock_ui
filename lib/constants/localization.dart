import 'package:intl/intl.dart';

final NumberFormat numberFormat = NumberFormat("###,###", "en_US");
final NumberFormat compactNumberFormat = NumberFormat.compact(locale: "en_US");
final DateFormat dateFormat = DateFormat.yMEd("en_US").add_Hms();
final DateFormat compactDateFormat = DateFormat("yyyy-MM-dd", "en_US");
