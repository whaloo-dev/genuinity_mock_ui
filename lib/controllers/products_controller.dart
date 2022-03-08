import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  final _allProducts = <Product>[].obs;

  var isDataLoaded = false.obs;
  var isDataLoading = true.obs;
  var products = <Product>[].obs;
  var codes = <ProductId, List<Code>>{}.obs;
  var allProductsNames = <String>[].obs;
  var searchFilter = <String>[].obs;

  @override
  void onReady() async {
    await loadDemoProductsData();
    super.onReady();
  }

  Future<void> loadDemoProductsData() async {
    const asset = "assets/demo/huel_products.json";
    print("Loading '$asset' ...");
    String response = await rootBundle.loadString(asset);
    final productsData = await json.decode(response);

    // Loading products and codes :
    final products = productsData['products'];
    // this.products.clear();
    for (var i = 0; i < products.length; i++) {
      var product = products[i];
      // List codes = product['codes'];
      allProductsNames.add(product['title']);
      _allProducts.add(
        Product(
          id: ProductId(product['id']),
          title: product['title'],
          image: product['image'],
          codesCount: Random().nextInt(10000), //codes.length,
        ),
      );
    }

    this.products.addAll(_allProducts);
    isDataLoaded.value = true;
    // isDataLoading.value = false;
  }

  Future<void> changeSearchFilter(String searchText) async {
    isDataLoading.value = true;
    products.clear();
    searchFilter.clear();
    final searchTextSplitted = searchText.toLowerCase().split(' ');
    for (int i = 0; i < searchTextSplitted.length; i++) {
      final keyword = searchTextSplitted[i].trim();
      if (keyword.isNotEmpty) {
        searchFilter.add(keyword);
      }
    }
    Timer(const Duration(seconds: 2), () {
      for (int i = 0; i < _allProducts.length; i++) {
        final _product = _allProducts[i];
        var accepted = true;
        for (int i = 0; i < searchFilter.length; i++) {
          final keyword = searchFilter[i];
          accepted = accepted && _product.title.toLowerCase().contains(keyword);
        }
        if (accepted) {
          products.add(_product);
        }
      }
      isDataLoading.value = false;
    });
  }

  List<E> generateFromProducts<E>(E Function(Product p) converter,
      {bool Function(Product p)? filter}) {
    var rows = <E>[];
    var _filter = filter ?? (Product p) => true;
    for (int i = 0; i < products.length; i++) {
      var product = products[i];
      if (_filter(product)) {
        rows.add(converter(product));
      }
    }
    return rows;
  }
}

class ProductId implements Comparable<ProductId> {
  String value;
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
