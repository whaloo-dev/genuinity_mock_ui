import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/global.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/backend/models/store.dart';

typedef BackendCallback<T> = void Function({T? arguments});

enum BackendEvent {
  productUpdated,
  groupUpdated,
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
    Map<ProductStatus, bool>? statusFilter,
    List<String>? productTitleFilter,
    String? skuFilter,
    String? barcodeFilter,
    String? vendorFilter,
    String? productTypeFilter,
    RangeValues? inventoryRangeFilter,
  });

  Future<List<Group>> loadGroups({
    required Sorting sorting,
  });

  Future<List<Code>> loadCodes({
    required Product product,
    required Sorting sorting,
    CodeStatus? codeStatusFilter,
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
