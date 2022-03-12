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

  static const int _loadingStep = 10;

  //demo
  final _demoBackend = <Product>[].obs;

  final _isEditingSearch = false.obs;
  final _isFormVisible = false.obs;
  final _isLoadingData = true.obs;

  final _products = <Product>[].obs;
  final _maxInventorySize = 0.obs;
  final _totalProductsCount = 0.obs;
  final _visibleProductsCount = 0.obs;

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
    _maxInventorySize.value = 0;
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
      _maxInventorySize.value =
          max(_maxInventorySize.value, product.inventoryQuantity);
    }

    defaultInventoryRange = RangeValues(0, _maxInventorySize.value.toDouble());
    inventorySizeRange.value = defaultInventoryRange;
    _products.addAll(_demoBackend);
    _visibleProductsCount.value = min(_loadingStep, productsCount());
    _totalProductsCount.value = _demoBackend.length;
    _isLoadingData.value = false;
  }

  void applyFilter() {
    _isEditingSearch.value = false;
    _isFormVisible.value = false;
    searchKeywords.value = searchText.value.tokenize();
    _applyFilter();
  }

  Future<void> loadMore() async {
    // _isLoadingMoreData.value = true;
    //demo
    return Future.delayed(const Duration(seconds: 1), () {
      _visibleProductsCount.value =
          min(_visibleProductsCount.value + _loadingStep, productsCount());
    });
  }

  void resetFilters() {
    searchText.value = "";
    inventorySizeRange.value = defaultInventoryRange;
    applyFilter();
  }

  void changeIsEditingSearch(bool newValue) {
    _isEditingSearch.value = newValue;
  }

  void changeIsFormVisible(bool newValue) {
    _isFormVisible.value = newValue;
  }

  Product product(int index) {
    return _products[index];
  }

  int visibleProductsCount() {
    return _visibleProductsCount.value;
  }

  int productsCount() {
    return _products.length;
  }

  int maxInventorySize() {
    return _maxInventorySize.value;
  }

  bool isFiltered() {
    return productsCount() != _totalProductsCount.value;
  }

  bool isInventorySizeRangeSet() {
    return inventorySizeRange.value !=
        RangeValues(0, _maxInventorySize.toDouble());
  }

  bool isProductCatalogEmpty() {
    return _totalProductsCount.value == 0;
  }

  bool isEditingSearch() {
    return _isEditingSearch.value;
  }

  bool isFormVisible() {
    return _isFormVisible.value;
  }

  bool isLoadingData() {
    return _isLoadingData.value;
  }

  void resetInventorySizeRange() {
    inventorySizeRange.value = RangeValues(0, _maxInventorySize.toDouble());
    applyFilter();
  }

  Future<void> _applyFilter() async {
    _isLoadingData.value = true;
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

      _visibleProductsCount.value = min(_loadingStep, productsCount());

      _isLoadingData.value = false;
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
