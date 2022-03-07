import 'package:get/get.dart';

class CodesController extends GetxController {
  static CodesController instance = Get.find();

  var isDataLoaded = false.obs;
  var products = <Product>[].obs;
  var codes = <ProductId, List<Code>>{}.obs;

  List<E> generateFromProducts<E>(E Function(Product p) convert,
      {bool Function(Product p)? accept}) {
    var rows = <E>[];
    for (int i = 0; i < products.length; i++) {
      var product = products[i];
      if ((accept != null) ? accept(product) : true) {
        rows.add(convert(product));
      }
    }
    return rows;
  }
}

class ProductId implements Comparable<ProductId> {
  int value;
  ProductId(this.value);

  @override
  int compareTo(ProductId other) {
    return value.compareTo(other.value);
  }
}

class Product {
  final ProductId id;
  final String title;
  final String image;
  final int codesCount;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.codesCount,
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
