class Product {
  final ProductId id;
  final String title;
  final String image;
  int codesCount;
  int inventoryQuantity;
  final String type;
  final String vendor;
  final List<Variant> variants = <Variant>[];
  final List<Option> options = <Option>[];

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.type,
    required this.vendor,
    required this.codesCount,
    required this.inventoryQuantity,
  });
}

class ProductId implements Comparable<ProductId> {
  int value;
  ProductId(this.value);

  @override
  int compareTo(ProductId other) {
    return value.compareTo(other.value);
  }
}

class Option {
  String name;
  Option({
    required this.name,
  });
}

class Variant {
  String title;
  String sku;
  String barcode;
  int inventoryQuantity;
  int oldInventoryQuantity;
  String option1;
  String option2;
  String option3;

  Variant({
    required this.title,
    required this.sku,
    required this.barcode,
    required this.inventoryQuantity,
    required this.oldInventoryQuantity,
    required this.option1,
    required this.option2,
    required this.option3,
  });
}

class Code {
  final String shortCode;
  final String serial;
  final DateTime creationDate;

  const Code({
    required this.shortCode,
    required this.serial,
    required this.creationDate,
  });
}
