import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  static const int _loadingStep = 10;

  final _isEditingSearch = false.obs;
  final _isFormVisible = false.obs;
  final _isLoadingData = true.obs;

  final _products = <Product>[].obs;
  final _maxInventorySize = 0.obs;
  final _minInventorySize = 0.obs;
  final _totalProductsCount = 0.obs;
  final _productTypes = <String>[].obs;
  final _vendors = <String>[].obs;
  final _visibleProductsCount = 0.obs;

  final _searchText = "".obs;
  final _searchKeywords = <String>[].obs;
  final _sku = "".obs;
  final _vendor = "".obs;
  final _productType = "".obs;
  final _barcode = "".obs;
  final _inventorySizeRange = const RangeValues(0, 500.0).obs;

  @override
  void onReady() async {
    await loadInit();
    super.onReady();
  }

  Future<void> loadInit() async {
    Backend.instance.loadProducts().then((products) {
      _maxInventorySize.value = 0;
      _minInventorySize.value = 0;

      for (var product in products) {
        _maxInventorySize.value =
            max(_maxInventorySize.value, product.inventoryQuantity);
        _minInventorySize.value =
            min(_minInventorySize.value, product.inventoryQuantity);
        if (!_productTypes.contains(product.type)) {
          _productTypes.add(product.type);
        }
        if (!_vendors.contains(product.vendor)) {
          _vendors.add(product.vendor);
        }
      }

      if (_maxInventorySize.value == _minInventorySize.value) {
        _maxInventorySize.value = _maxInventorySize.value + 1;
      }
      _products.addAll(products);
      _inventorySizeRange.value = RangeValues(
          _minInventorySize.value.toDouble(),
          _maxInventorySize.value.toDouble());
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
    _sku.value = "";
    _barcode.value = "";
    _vendor.value = "";
    _productType.value = "";
    _inventorySizeRange.value = RangeValues(
        _minInventorySize.value.toDouble(), _maxInventorySize.value.toDouble());
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
    changeIsEditingSearch(true);
  }

  void changeSearchText(String newValue) {
    _searchText.value = newValue.trim();
    changeIsEditingSearch(true);
  }

  void changeSku(String newValue) {
    _sku.value = newValue.trim();
    changeIsEditingSearch(true);
  }

  void changeProductType(String newValue) {
    _productType.value = newValue.trim();
    changeIsEditingSearch(true);
  }

  void changeVendor(String newValue) {
    _vendor.value = newValue.trim();
    changeIsEditingSearch(true);
  }

  void changeBarcode(String newValue) {
    _barcode.value = newValue.trim();
    changeIsEditingSearch(true);
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

  int minInventorySize() {
    return _minInventorySize.value;
  }

  RangeValues inventorySizeRange() {
    return _inventorySizeRange.value;
  }

  String searchText() {
    return _searchText.value;
  }

  String sku() {
    return _sku.value;
  }

  String productType() {
    return _productType.value;
  }

  String vendor() {
    return _vendor.value;
  }

  List<String> vendors() {
    return _vendors;
  }

  List<String> productTypes() {
    return _productTypes;
  }

  String barcode() {
    return _barcode.value;
  }

  bool isFiltered() {
    return productsCount() != _totalProductsCount.value;
  }

  bool isInventorySizeRangeSet() {
    return _inventorySizeRange.value !=
        RangeValues(_minInventorySize.toDouble(), _maxInventorySize.toDouble());
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
    _inventorySizeRange.value =
        RangeValues(_minInventorySize.toDouble(), _maxInventorySize.toDouble());
    applyFilter();
  }

  void resetSku() {
    _sku.value = "";
    applyFilter();
  }

  void resetProductType() {
    _productType.value = "";
    applyFilter();
  }

  void resetVendor() {
    _vendor.value = "";
    applyFilter();
  }

  void resetBarcode() {
    _barcode.value = "";
    applyFilter();
  }

  Future<void> _applyFilter() async {
    _isLoadingData.value = true;
    _products.clear();

    Backend.instance
        .loadProducts(
      searchKeywords: _searchKeywords.isNotEmpty ? _searchKeywords : null,
      sku: _sku.isNotEmpty ? _sku.value : null,
      barcode: _barcode.isNotEmpty ? _barcode.value : null,
      vendor: _vendor.isNotEmpty ? _vendor.value : null,
      productType: _productType.isNotEmpty ? _productType.value : null,
      inventoryRange:
          isInventorySizeRangeSet() ? _inventorySizeRange.value : null,
    )
        .then((products) {
      _products.addAll(products);
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _isLoadingData.value = false;
    });
  }
}
