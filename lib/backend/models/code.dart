import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';

enum CodeStatus {
  created,
  exported,
  scanned,
}

extension CodeStatusExtension on CodeStatus {
  String name() {
    switch (this) {
      case CodeStatus.created:
        return "New";
      case CodeStatus.exported:
        return "Exported";
      case CodeStatus.scanned:
        return "Scanned";
    }
  }

  Color color() {
    switch (this) {
      case CodeStatus.created:
        return const Color.fromARGB(255, 243, 245, 193);
      case CodeStatus.exported:
        return const Color.fromRGBO(164, 232, 242, 1);
      case CodeStatus.scanned:
        return const Color.fromRGBO(174, 233, 209, 1);
    }
  }

  Color onColor() {
    switch (this) {
      case CodeStatus.created:
      case CodeStatus.exported:
      case CodeStatus.scanned:
        return Colors.black;
    }
  }
}

class Code {
  final CodeId id;
  final DateTime creationDate;
  final ProductVariant variant;
  final String image;
  final DateTime? expirationDate;
  final CodeStyle codeStyle;
  final String? description;

  DateTime? exportDate;
  DateTime? lastScanDate;
  int scanCount;
  int scanErrorsCount;
  //TODO separate scans from code
  List<CodeScan>? scans = <CodeScan>[];

  Code({
    required this.id,
    required this.creationDate,
    required this.variant,
    required this.codeStyle,
    required this.image,
    this.scanCount = 0,
    this.scanErrorsCount = 0,
    this.exportDate,
    this.lastScanDate,
    this.expirationDate,
    this.description,
  });

  CodeStatus status() {
    return lastScanDate != null
        ? CodeStatus.scanned
        : exportDate != null
            ? CodeStatus.exported
            : CodeStatus.created;
  }

  DateTime lastModified() {
    return lastScanDate != null
        ? lastScanDate!
        : exportDate != null
            ? exportDate!
            : creationDate;
  }

  @override
  bool operator ==(other) {
    return other is Code && id == other.id;
  }

  @override
  int get hashCode => hash2(id.hashCode, id.hashCode);
}

class CodeId {
  final String serial;
  final String shortCode;

  CodeId({
    required this.shortCode,
    required this.serial,
  });

  @override
  bool operator ==(other) {
    return other is CodeId && serial == other.serial;
  }

  @override
  int get hashCode => hash2(serial.hashCode, serial.hashCode);
}

class CodeStyle {
  int id;
  final String image;

  CodeStyle({
    required this.id,
    required this.image,
  });
}

// TODO add location
class CodeScan {
  DateTime dateTime;
  bool isFailed;

  CodeScan({
    required this.dateTime,
    required this.isFailed,
  });
}

class Group {
  Product key;
  List<Code> codes;
  Group({required this.key, required this.codes});

  //agregates
  int codesCount() => codes.length;
  int scanCount() => codes.map((e) => e.scanCount).reduce((v1, v2) => v1 + v2);
  int scanErrorsCount() =>
      codes.map((e) => e.scanErrorsCount).reduce((v1, v2) => v1 + v2);
  DateTime lastModificationDate() => codes
      .map((e) => e.lastScanDate ?? (e.exportDate ?? e.creationDate))
      .reduce((v1, v2) => v1.isAfter(v2) ? v1 : v2);
}
