import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  static const int _loadingStep = 10;

  final _isEditingSearch = false.obs;
  final _isFormVisible = false.obs;
  final _isLoadingData = true.obs;

  final _products = <Product>[].obs;
  final _maxInventorySize = 0.obs;
  final _totalProductsCount = 0.obs;
  final _visibleProductsCount = 0.obs;

  final _searchText = "".obs;
  final _searchKeywords = <String>[].obs;
  final _inventorySizeRange = const RangeValues(0, 500.0).obs;
  var _defaultInventoryRange = const RangeValues(0, 500.0);

  @override
  void onReady() async {
    await loadInit();
    super.onReady();
  }

  Future<void> loadInit() async {
    Backend.instance.loadProducts().then((products) {
      _maxInventorySize.value = 0;
      for (var product in products) {
        _maxInventorySize.value =
            max(_maxInventorySize.value, product.inventoryQuantity);
      }

      _products.addAll(products);

      _defaultInventoryRange =
          RangeValues(0, _maxInventorySize.value.toDouble());
      _inventorySizeRange.value = _defaultInventoryRange;
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _totalProductsCount.value = _products.length;
      _isLoadingData.value = false;
    });
  }

  void applyFilter() {
    _isEditingSearch.value = false;
    _isFormVisible.value = false;
    _searchKeywords.value = _searchText.value.tokenize();
    _applyFilter();
  }

  Future<void> loadMore() async {
    return Future.delayed(const Duration(milliseconds: 1), () {
      _visibleProductsCount.value =
          min(_visibleProductsCount.value + _loadingStep, productsCount());
    });
  }

  void resetFilters() {
    _searchText.value = "";
    _inventorySizeRange.value = _defaultInventoryRange;
    applyFilter();
  }

  void changeIsEditingSearch(bool newValue) {
    _isEditingSearch.value = newValue;
  }

  void changeIsFormVisible(bool newValue) {
    _isFormVisible.value = newValue;
  }

  void changeInventorySizeRange(RangeValues newValue) {
    _inventorySizeRange.value = newValue;
  }

  void changeSearchText(String newValue) {
    _searchText.value = newValue;
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

  RangeValues inventorySizeRange() {
    return _inventorySizeRange.value;
  }

  String searchText() {
    return _searchText.value;
  }

  bool isFiltered() {
    return productsCount() != _totalProductsCount.value;
  }

  bool isInventorySizeRangeSet() {
    return _inventorySizeRange.value !=
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
    _inventorySizeRange.value = RangeValues(0, _maxInventorySize.toDouble());
    applyFilter();
  }

  Future<void> _applyFilter() async {
    _isLoadingData.value = true;
    _products.clear();

    Backend.instance
        .loadProducts(
      searchKeywords: _searchKeywords,
      inventoryRange: _inventorySizeRange.value,
    )
        .then((products) {
      _products.addAll(products);
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _isLoadingData.value = false;
    });
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
