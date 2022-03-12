import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/main.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  //demo
  final _demoBackend = <Product>[].obs;

  var isEditingSearch = false.obs;
  var isFormVisible = false.obs;
  var isLoadingData = true.obs;

  final _products = <Product>[].obs;
  final maxInventorySize = 0.obs;
  final totalProductsCount = 0.obs;

  var searchKeywords = <String>[].obs;
  var inventorySizeRange = const RangeValues(0, 500.0).obs;
  RangeValues defaultInventoryRange = const RangeValues(0, 500.0);
  var searchText = "".obs;

  @override
  void onReady() async {
    await loadDemoProductsData();
    super.onReady();
  }

  //demo
  Future<void> loadDemoProductsData() async {
    const asset = "assets/demo/${demoStore}_products.json";
    String response = await rootBundle.loadString(asset);
    final productsData = await json.decode(response);

    // Loading products and codes :
    maxInventorySize.value = 0;
    final products = productsData['products'];
    for (var i = 0; i < products.length; i++) {
      var productData = products[i];
      var product = Product(
        id: ProductId(productData['id']),
        title: productData['title'],
        image: productData['image'],
        codesCount: Random().nextInt(5000),
        inventoryQuantity:
            Random().nextInt(10) == 0 ? 0 : Random().nextInt(5000),
      );
      _demoBackend.add(product);
      maxInventorySize.value =
          max(maxInventorySize.value, product.inventoryQuantity);
    }

    defaultInventoryRange = RangeValues(0, maxInventorySize.value.toDouble());
    inventorySizeRange.value = defaultInventoryRange;
    _products.addAll(_demoBackend);
    totalProductsCount.value = _demoBackend.length;
    isLoadingData.value = false;
  }

  void applyFilter() {
    isEditingSearch.value = false;
    isFormVisible.value = false;
    searchKeywords.value = searchText.value.tokenize();
    _applyFilter();
  }

  void resetFilters() {
    searchText.value = "";
    inventorySizeRange.value = defaultInventoryRange;
    applyFilter();
  }

  void changeIsEditingSearch(bool newValue) {
    isEditingSearch.value = newValue;
  }

  Product product(int index) {
    return _products[index];
  }

  int productsCount() {
    return _products.length;
  }

  bool isFiltered() {
    return productsCount() != totalProductsCount.value;
  }

  bool isInventorySizeRangeSet() {
    return inventorySizeRange.value !=
        RangeValues(0, maxInventorySize.toDouble());
  }

  void resetInventorySizeRange() {
    inventorySizeRange.value = RangeValues(0, maxInventorySize.toDouble());
    applyFilter();
  }

  Future<void> _applyFilter() async {
    isLoadingData.value = true;
    _products.clear();

    //demo
    Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < _demoBackend.length; i++) {
        final _product = _demoBackend[i];
        var accepted = true;

        //inventory filter :
        bool inRange =
            _product.inventoryQuantity >= inventorySizeRange.value.start &&
                _product.inventoryQuantity <= inventorySizeRange.value.end;
        if (!inRange) {
          continue;
        }

        //text filter
        final tokens = _product.title.tokenize();
        accepted = accepted && tokens.startsWithAll(searchKeywords);

        if (!accepted) {
          continue;
        }

        _products.add(_product);
      }
      isLoadingData.value = false;
    });
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
  final int inventoryQuantity;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.codesCount,
    required this.inventoryQuantity,
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
