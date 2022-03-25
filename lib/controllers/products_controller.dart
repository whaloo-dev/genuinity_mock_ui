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
  static const int _absoluteMaxInventory = 1000;

  final bool showProductsHavingCodesOnly;

  ProductsController({this.showProductsHavingCodesOnly = true}) {
    Backend.instance.addListener(BackendEvent.productUpdated, ({arguments}) {
      applyFilter(showDataLoading: false);
    });
  }

  final _isEditingFilters = false.obs;
  final _isFormVisible = false.obs;
  final _isLoadingData = true.obs;

  final _products = <Product>[].obs;

  final _totalProductsCount = 0.obs;
  final _productTypes = <String>[].obs;
  final _vendors = <String>[].obs;
  final _visibleProductsCount = 0.obs;

  final _productTitleFilter = "".obs;
  final _skuFilter = "".obs;
  final _vendorFilter = "".obs;
  final _productTypeFilter = "".obs;
  final _barcodeFilter = "".obs;

  var _defaultInventorySizeRangeFilter = const RangeValues(0, 500.0);
  final _inventorySizeRangeFilter = const RangeValues(0, 500.0).obs;

  static const _defaultStatusFilter = <ProductStatus, bool>{
    ProductStatus.active: true,
    ProductStatus.draft: true,
    ProductStatus.archived: true,
  };
  final _statusFilter = _defaultStatusFilter.obs;

  Future<void> loadInit() async {
    Backend.instance
        .loadProducts(showProductsHavingCodesOnly: showProductsHavingCodesOnly)
        .then((products) {
      int _maxInventorySize = 0;
      int _minInventorySize = 0;
      for (var product in products) {
        _maxInventorySize = max(_maxInventorySize, product.inventoryQuantity);
        _minInventorySize = min(_minInventorySize, product.inventoryQuantity);
        if (!_productTypes.contains(product.type)) {
          _productTypes.add(product.type);
        }
        if (!_vendors.contains(product.vendor)) {
          _vendors.add(product.vendor);
        }
      }
      _vendors.sort();
      _productTypes.sort();
      _maxInventorySize = min(_maxInventorySize, _absoluteMaxInventory);
      _defaultInventorySizeRangeFilter = RangeValues(
          _minInventorySize.toDouble(), _maxInventorySize.toDouble());
      _products.addAll(products);
      _visibleProductsCount.value = min(_loadingStep, productsCount());
      _totalProductsCount.value = _products.length;
      _isLoadingData.value = false;

      resetFilters();
    });
  }

  void applyFilter({bool showDataLoading = true}) {
    _changeIsEditingFilters(false);
    _isFormVisible.value = false;
    _applyFilter(refresh: showDataLoading);
  }

  Future<void> showMore() async {
    return Future.delayed(const Duration(milliseconds: 1), () {
      _visibleProductsCount.value =
          min(_visibleProductsCount.value + _loadingStep, productsCount());
    });
  }

  void resetFilters() {
    resetProductTitleFilter(apply: false);
    resetStatusFilter(apply: false);
    resetSkuFilter(apply: false);
    resetBarcodeFilter(apply: false);
    resetVendorFilter(apply: false);
    resetProductTypeFilter(apply: false);
    resetInventorySizeRangeFilter(apply: false);
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

  void changeStatusFilter(ProductStatus status, bool enabled) {
    _statusFilter[status] = enabled;
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
    return _defaultInventorySizeRangeFilter.end.toInt();
  }

  int minInventorySize() {
    return _defaultInventorySizeRangeFilter.start.toInt();
  }

  RangeValues inventorySizeRangeFilter() {
    return _inventorySizeRangeFilter.value;
  }

  String productTitleFilter() {
    return _productTitleFilter.value;
  }

  Map<ProductStatus, bool> statusFilter() {
    return _statusFilter;
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
    return isInventorySizeRangeFilterSet() ||
        isProductTitleFilterSet() ||
        isSkuFilterSet() ||
        isProductTypeFilterSet() ||
        isVendorFilterSet() ||
        isBarcodeFilterSet() ||
        isStatusFilterSet();
  }

  bool isInventorySizeRangeFilterSet() {
    return _inventorySizeRangeFilter.value != _defaultInventorySizeRangeFilter;
  }

  bool isProductTitleFilterSet() {
    return _productTitleFilter.value.isNotEmpty;
  }

  bool isStatusFilterSet() {
    for (ProductStatus status in ProductStatus.values) {
      if (_statusFilter[status] != _defaultStatusFilter[status]) {
        return true;
      }
    }
    return false;
  }

  bool isSkuFilterSet() {
    return _skuFilter.value.isNotEmpty;
  }

  bool isProductTypeFilterSet() {
    return _productTypeFilter.value.isNotEmpty;
  }

  bool isVendorFilterSet() {
    return _vendorFilter.value.isNotEmpty;
  }

  bool isBarcodeFilterSet() {
    return _barcodeFilter.value.isNotEmpty;
  }

  int totalProductsCount() {
    return _totalProductsCount.value;
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

  void resetProductTitleFilter({bool apply = true}) {
    _productTitleFilter.value = "";
    if (apply) {
      applyFilter();
    }
  }

  void resetInventorySizeRangeFilter({bool apply = true}) {
    _inventorySizeRangeFilter.value = _defaultInventorySizeRangeFilter;
    if (apply) {
      applyFilter();
    }
  }

  void resetStatusFilter({ProductStatus? status, bool apply = true}) {
    if (status != null) {
      _statusFilter[status] = _defaultStatusFilter[status]!;
    } else {
      for (ProductStatus status in ProductStatus.values) {
        _statusFilter[status] = _defaultStatusFilter[status]!;
      }
    }
    if (apply) {
      applyFilter();
    }
  }

  bool defaultStatusFilter(ProductStatus status) {
    return _defaultStatusFilter[status]!;
  }

  void resetSkuFilter({bool apply = true}) {
    _skuFilter.value = "";
    if (apply) {
      applyFilter();
    }
  }

  void resetProductTypeFilter({bool apply = true}) {
    _productTypeFilter.value = "";
    if (apply) {
      applyFilter();
    }
  }

  void resetVendorFilter({bool apply = true}) {
    _vendorFilter.value = "";
    if (apply) {
      applyFilter();
    }
  }

  void resetBarcodeFilter({bool apply = true}) {
    _barcodeFilter.value = "";
    if (apply) {
      applyFilter();
    }
  }

  void _changeIsEditingFilters(bool newValue) {
    _isEditingFilters.value = newValue;
  }

  Future<void> _applyFilter({required bool refresh}) async {
    if (refresh) {
      _isLoadingData.value = true;
    }

    RangeValues? inventoryFilter;
    if (isInventorySizeRangeFilterSet()) {
      inventoryFilter = RangeValues(_inventorySizeRangeFilter.value.start,
          _inventorySizeRangeFilter.value.end);
      if (inventoryFilter.end == _defaultInventorySizeRangeFilter.end) {
        inventoryFilter = RangeValues(
            _inventorySizeRangeFilter.value.start, double.maxFinite);
      }
    }

    Backend.instance
        .loadProducts(
      showProductsHavingCodesOnly: showProductsHavingCodesOnly,
      statusFilter: statusFilter(),
      productTitleFilter: _productTitleFilter.isNotEmpty
          ? _productTitleFilter.value.tokenize()
          : null,
      skuFilter: skuFilter().isNotEmpty ? skuFilter() : null,
      barcodeFilter: barcodeFilter().isNotEmpty ? barcodeFilter() : null,
      vendorFilter: vendorFilter().isNotEmpty ? vendorFilter() : null,
      productTypeFilter:
          productTypeFilter().isNotEmpty ? productTypeFilter() : null,
      inventoryRangeFilter: inventoryFilter,
    )
        .then(
      (products) {
        _products.value = products;
        if (refresh) {
          _visibleProductsCount.value = min(_loadingStep, productsCount());
          _isLoadingData.value = false;
        } else {
          _visibleProductsCount.value =
              min(_visibleProductsCount.value, productsCount());
        }
      },
    );
  }
}
