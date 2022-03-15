import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';

abstract class Backend {
  static Backend instance = Get.find();

  Future<Store> getCurrentStore();
  Future<List<Product>> loadProducts({
    List<String>? searchKeywords,
    String? sku,
    String? barcode,
    String? vendor,
    String? productType,
    RangeValues? inventoryRange,
  });
}
