import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class Product {
  final ProductId id;
  final String title;
  final String image;
  int codesCount;
  int inventoryQuantity;
  final String type;
  final String vendor;
  final ProductStatus status;
  final List<ProductVariant> variants = <ProductVariant>[];
  final List<Option> options = <Option>[];

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.type,
    required this.vendor,
    required this.codesCount,
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
      case ProductStatus.active: //rgba(228, 229, 231, 1)
        return const Color.fromRGBO(174, 233, 209, 1);
      case ProductStatus.draft:
        return const Color.fromRGBO(164, 232, 242, 1);
      case ProductStatus.archived:
        return const Color.fromRGBO(228, 229, 231, 1);
    }
  }
}

class Option {
  String name;
  Option({
    required this.name,
  });
}

class ProductVariant {
  Product product;
  String title;
  String sku;
  String barcode;
  int inventoryQuantity;
  int oldInventoryQuantity;
  String option1;
  String option2;
  String option3;

  ProductVariant({
    required this.product,
    required this.title,
    required this.sku,
    required this.barcode,
    required this.inventoryQuantity,
    required this.oldInventoryQuantity,
    required this.option1,
    required this.option2,
    required this.option3,
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

class Code {
  final String shortCode;
  final String serial;
  final DateTime creationDate;
  final int scanCount;
  final int scanErrorsCount;
  final ProductVariant variant;
  final DateTime? exportDate;
  final DateTime? lastScanDate;
  final DateTime? expirationDate;
  final List<String> tags;
  bool isSelected;

  Code({
    required this.shortCode,
    required this.serial,
    required this.creationDate,
    required this.variant,
    required this.scanCount,
    required this.scanErrorsCount,
    this.isSelected = false,
    this.tags = const <String>[],
    this.exportDate,
    this.lastScanDate,
    this.expirationDate,
  });
}
