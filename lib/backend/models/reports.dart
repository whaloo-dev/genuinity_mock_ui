import 'package:quiver/core.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';

class Report {
  final ReportId id;
  final Reporter reporter;
  final DateTime timestamp;
  final String location;
  final String message;
  final Product? product;
  final String? salesChannel;
  bool isRead;

  Report({
    required this.id,
    required this.reporter,
    required this.timestamp,
    required this.location,
    required this.message,
    required this.isRead,
    this.product,
    this.salesChannel,
  });
}

class ReportId {
  final String value;

  const ReportId(this.value);

  @override
  bool operator ==(other) {
    return other is ReportId && value == other.value;
  }

  @override
  int get hashCode => hash2(value.hashCode, value.hashCode);

  @override
  String toString() => value;
}

class Reporter {
  final String name;
  final String email;
  final String? phone;

  Reporter({
    required this.name,
    required this.email,
    this.phone,
  });
}
