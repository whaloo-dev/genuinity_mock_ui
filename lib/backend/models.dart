import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

enum TimeSpan {
  sevenDays,
  thirtyDays,
  threeMonthes,
  twelveMonthes,
  all,
}

extension TimeSpanToText on TimeSpan {
  String name() {
    switch (this) {
      case TimeSpan.sevenDays:
        return "For the last 7 days";
      case TimeSpan.thirtyDays:
        return "For the last 30 days";
      case TimeSpan.threeMonthes:
        return "For the last 3 monthes";
      case TimeSpan.twelveMonthes:
        return "For the last 12 monthes";
      case TimeSpan.all:
        return "All";
    }
  }
}

class Store {
  String id;
  String name;
  String? imageUrl;
  String website;
  Store({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.website,
  }) : super();
}

class Product {
  final ProductId id;
  final String title;
  final String image;
  int inventoryQuantity;
  final String type;
  final String vendor;
  final ProductStatus status;
  final List<ProductVariant> variants = <ProductVariant>[];

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.type,
    required this.vendor,
    required this.inventoryQuantity,
    required this.status,
  });

  @override
  bool operator ==(other) {
    return other is Product && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ProductId implements Comparable<ProductId> {
  int value;
  ProductId(this.value);

  @override
  int compareTo(ProductId other) {
    return value.compareTo(other.value);
  }

  @override
  bool operator ==(other) {
    return other is ProductId && value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

enum ProductStatus {
  active,
  draft,
  archived,
}

extension ProductStatusExtension on ProductStatus {
  String name() {
    switch (this) {
      case ProductStatus.active:
        return "Active";
      case ProductStatus.draft:
        return "Draft";
      case ProductStatus.archived:
        return "Archived";
    }
  }

  Color color() {
    switch (this) {
      case ProductStatus.active:
        return const Color.fromRGBO(174, 233, 209, 1);
      case ProductStatus.draft:
        return const Color.fromRGBO(164, 232, 242, 1);
      case ProductStatus.archived:
        return const Color.fromRGBO(228, 229, 231, 1);
    }
  }

  Color onColor() {
    switch (this) {
      case ProductStatus.active:
      case ProductStatus.draft:
      case ProductStatus.archived:
        return Colors.black;
    }
  }
}

class ProductVariant {
  Product product;
  String title;
  String sku;
  String barcode;
  int inventoryQuantity;
  String? image;

  ProductVariant({
    required this.product,
    required this.title,
    required this.sku,
    required this.barcode,
    required this.inventoryQuantity,
    this.image,
  });

  @override
  bool operator ==(other) {
    return other is ProductVariant &&
        product == other.product &&
        title == other.title;
  }

  @override
  int get hashCode => hash2(product.hashCode, title.hashCode);
}

enum CodeStatus {
  created,
  exported,
  scanned,
  //expired,
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
      // case CodeStatus.expired:
      //   return "Expired";
    }
  }

  Color color() {
    switch (this) {
      case CodeStatus.created:
        return const Color.fromARGB(255, 234, 236, 172);
      case CodeStatus.exported:
        return const Color.fromRGBO(164, 232, 242, 1);
      case CodeStatus.scanned:
        return const Color.fromRGBO(174, 233, 209, 1);
      // case CodeStatus.expired:
      //   return const Color.fromARGB(255, 228, 171, 185);
    }
  }

  Color onColor() {
    switch (this) {
      case CodeStatus.created:
      case CodeStatus.exported:
      case CodeStatus.scanned:
        //case CodeStatus.expired:
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

enum Sorting {
  dateAsc,
  dateDesc,
  scansAsc,
  scansDesc,
  scanErrorsAsc,
  scanErrorsDesc,
}

extension SortingExt on Sorting {
  String name() {
    switch (this) {
      case Sorting.dateAsc:
      case Sorting.dateDesc:
        return "Date";
      case Sorting.scansAsc:
      case Sorting.scansDesc:
        return "Scans";
      case Sorting.scanErrorsAsc:
      case Sorting.scanErrorsDesc:
        return "Scan Errors";
    }
  }

  String nameExtension() {
    switch (this) {
      case Sorting.dateAsc:
        return "most old first";
      case Sorting.dateDesc:
        return "most recent first";
      case Sorting.scansAsc:
        return "ascending";
      case Sorting.scansDesc:
        return "descending";
      case Sorting.scanErrorsAsc:
        return "ascending";
      case Sorting.scanErrorsDesc:
        return "descending";
    }
  }
}
