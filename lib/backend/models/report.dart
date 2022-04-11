import 'package:quiver/core.dart';

class Report {
  final ReportId id;
  final String message;
  final List<String> photos;

  const Report({
    required this.id,
    required this.message,
    required this.photos,
  });
}

class ReportId {
  final String value;

  const ReportId({
    required this.value,
  });

  @override
  bool operator ==(other) {
    return other is ReportId && value == other.value;
  }

  @override
  int get hashCode => hash2(value.hashCode, value.hashCode);
}
