import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';

typedef BackendCallback<T> = void Function({T? arguments});

enum BackendEvent {
  productUpdated,
  codeAdded,
  codeUpdated,
  codeRemoved,
}

abstract class Backend {
  static Backend instance = Get.find();

  void addListener<T>(
    BackendEvent event,
    BackendCallback<T> callback,
  );

  Future<Store> getCurrentStore();

  Future<List<Product>> loadProducts({
    bool showProductsHavingCodesOnly = true,
    Map<ProductStatus, bool>? statusFilter,
    List<String>? productTitleFilter,
    String? skuFilter,
    String? barcodeFilter,
    String? vendorFilter,
    String? productTypeFilter,
    RangeValues? inventoryRangeFilter,
  });

  Future<List<Code>> loadCodes({
    required Product product,
  });

  Future<List<CodeStyle>> loadCodeStyles();

  Future<void> createCode(
    ProductVariant variant,
    CodeStyle codeStyle, {
    String? description,
    DateTime? expirationDate,
    int blukSize = 1,
    Map<String, String> tags = const <String, String>{},
  });

  Future<void> deleteCode(Code code);
  Future<void> undeleteCode(Code code);

  Future<void> deleteCodes(List<Code> codes);
  Future<void> undeleteCodes(List<Code> codes);

  Future<String> printCode(Code code);
  Future<String> printCodes(List<Code> codes);
}
