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

  final _isEditingFilters = false.obs;
  final _isFormVisible = false.obs;
  final _isLoadingData = true.obs;

  final _products = <Product>[].obs;
  final _maxInventorySize = 0.obs;
  final _minInventorySize = 0.obs;
  final _totalProductsCount = 0.obs;
  final _productTypes = <String>[].obs;
  final _vendors = <String>[].obs;
  final _visibleProductsCount = 0.obs;

  final _productTitleFilter = "".obs;
  final _skuFilter = "".obs;
  final _vendorFilter = "".obs;
  final _productTypeFilter = "".obs;
  final _barcodeFilter = "".obs;
  final _inventorySizeRangeFilter = const RangeValues(0, 500.0).obs;

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
      _products.addAll(products);
      _inventorySizeRangeFilter.value = RangeValues(
          _minInventorySize.value.toDouble(),
          _maxInventorySize.value.toDouble());
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _totalProductsCount.value = _products.length;
      _isLoadingData.value = false;
    });
  }

  void applyFilter() {
    _changeIsEditingFilters(false);
    _isFormVisible.value = false;
    _applyFilter();
  }

  Future<void> loadMore() async {
    return Future.delayed(const Duration(milliseconds: 1), () {
      _visibleProductsCount.value =
          min(_visibleProductsCount.value + _loadingStep, productsCount());
    });
  }

  void resetFilters() {
    _productTitleFilter.value = "";
    _skuFilter.value = "";
    _barcodeFilter.value = "";
    _vendorFilter.value = "";
    _productTypeFilter.value = "";
    _inventorySizeRangeFilter.value = RangeValues(
        _minInventorySize.value.toDouble(), _maxInventorySize.value.toDouble());
    applyFilter();
  }

  void changeIsFormVisible(bool newValue) {
    _isFormVisible.value = newValue;
  }

  void changeInventorySizeRangeFilter(RangeValues newValue) {
    _inventorySizeRangeFilter.value = newValue;
    _changeIsEditingFilters(true);
  }

  void changeProductTitleFilter(String newValue) {
    _productTitleFilter.value = newValue.trim();
    _changeIsEditingFilters(true);
  }

  void changeSkuFilter(String newValue) {
    _skuFilter.value = newValue.trim();
    _changeIsEditingFilters(true);
  }

  void changeProductTypeFilter(String newValue) {
    _productTypeFilter.value = newValue.trim();
    _changeIsEditingFilters(true);
  }

  void changeVendorFilter(String newValue) {
    _vendorFilter.value = newValue.trim();
    _changeIsEditingFilters(true);
  }

  void changeBarcodeFilter(String newValue) {
    _barcodeFilter.value = newValue.trim();
    _changeIsEditingFilters(true);
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
    return _inventorySizeRangeFilter.value;
  }

  String productTitleFilter() {
    return _productTitleFilter.value;
  }

  String skuFilter() {
    return _skuFilter.value;
  }

  String productTypeFilter() {
    return _productTypeFilter.value;
  }

  String vendorFilter() {
    return _vendorFilter.value;
  }

  List<String> vendors() {
    return _vendors;
  }

  List<String> productTypes() {
    return _productTypes;
  }

  String barcodeFilter() {
    return _barcodeFilter.value;
  }

  bool isFiltered() {
    return productsCount() != _totalProductsCount.value;
  }

  bool isInventorySizeRangeFilterSet() {
    return _inventorySizeRangeFilter.value !=
        RangeValues(_minInventorySize.toDouble(), _maxInventorySize.toDouble());
  }

  bool isProductCatalogEmpty() {
    return _totalProductsCount.value == 0;
  }

  bool isEditingFilters() {
    return _isEditingFilters.value;
  }

  bool isFormVisible() {
    return _isFormVisible.value;
  }

  bool isLoadingData() {
    return _isLoadingData.value;
  }

  void resetInventorySizeRangeFilter() {
    _inventorySizeRangeFilter.value =
        RangeValues(_minInventorySize.toDouble(), _maxInventorySize.toDouble());
    applyFilter();
  }

  void resetSkuFilter() {
    _skuFilter.value = "";
    applyFilter();
  }

  void resetProductTypeFilter() {
    _productTypeFilter.value = "";
    applyFilter();
  }

  void resetVendorFilter() {
    _vendorFilter.value = "";
    applyFilter();
  }

  void resetBarcodeFilter() {
    _barcodeFilter.value = "";
    applyFilter();
  }

  void _changeIsEditingFilters(bool newValue) {
    _isEditingFilters.value = newValue;
  }

  Future<void> _applyFilter() async {
    _isLoadingData.value = true;
    _products.clear();

    Backend.instance
        .loadProducts(
      searchKeywords: _productTitleFilter.isNotEmpty
          ? _productTitleFilter.value.tokenize()
          : null,
      sku: _skuFilter.isNotEmpty ? _skuFilter.value : null,
      barcode: _barcodeFilter.isNotEmpty ? _barcodeFilter.value : null,
      vendor: _vendorFilter.isNotEmpty ? _vendorFilter.value : null,
      productType:
          _productTypeFilter.isNotEmpty ? _productTypeFilter.value : null,
      inventoryRange: isInventorySizeRangeFilterSet()
          ? _inventorySizeRangeFilter.value
          : null,
    )
        .then((products) {
      _products.addAll(products);
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _isLoadingData.value = false;
    });
  }
}
