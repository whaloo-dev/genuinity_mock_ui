import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class MockBackend extends GetConnect implements Backend {
  // static const _demoStore = "halloweenmakeup";
  // static const _demoStore = "ruesco";
  // static const _demoStore = "huel";
  // static const _demoStore = "signatureveda";
  // static const _demoStore = "locknloadairsoft";
  static const _demoStore = "decathlon";
  // static const _demoStore = "thebookbundler";
  // static const _demoStore = "commonfarmflowers";
  // static const _demoStore = "atelierdubraceletparisien";

  final _demoBackend = <Product>[];
  late String _basePath;

  MockBackend() {
    _basePath = kReleaseMode ? "assets/assets" : "assets";
  }

  @override
  Future<Store> getCurrentStore() async {
    var url = "$_basePath/demo/${_demoStore}_store.json";
    var response = await get(url);
    final storeData = await json.decode(response.bodyString!);
    var store = Store(
      id: storeData['id'],
      name: storeData['name'],
      website: storeData['url'],
      imageUrl:
          (storeData as Map).containsKey('icon') ? storeData['icon'] : null,
    );
    return Future<Store>(() => store);
  }

  @override
  Future<List<Product>> loadProducts({
    Map<ProductStatus, bool>? statusFilter,
    List<String>? productTitleFilter,
    String? skuFilter,
    String? barcodeFilter,
    String? vendorFilter,
    String? productTypeFilter,
    RangeValues? inventoryRangeFilter,
  }) async {
    if (_demoBackend.isEmpty) {
      var url = "$_basePath/demo/${_demoStore}_products.json";
      var response = await get(url);
      var productsData = await json.decode(response.bodyString!);
      productsData = productsData['products'];

      for (var i = 0; i < productsData.length; i++) {
        var mod3 = i % 3;
        var productData = productsData[i];
        var product = Product(
          id: ProductId(productData['id']),
          title: productData['title'],
          image: productData['image']['src'],
          type: productData['product_type'],
          vendor: productData['vendor'],
          codesCount: Random().nextInt(10000),
          inventoryQuantity: 0,
          status: mod3 == 0
              ? ProductStatus.active
              : mod3 == 1
                  ? ProductStatus.draft
                  : ProductStatus.archived,
        );
        var variantsData = productData['variants'];
        for (var i2 = 0; i2 < variantsData.length; i2++) {
          var variantData = variantsData[i2] as Map;
          var variant = Variant(
            title: variantData['title'],
            sku: variantData['sku'],
            barcode: variantData['barcode'],
            inventoryQuantity: variantData.containsKey('inventory_quantity')
                ? variantData['inventory_quantity']
                : 0,
            oldInventoryQuantity: 0,
            option1: variantData['option1'],
            option2: variantData['option2'],
            option3: variantData['option3'],
          );
          product.variants.add(variant);
          product.inventoryQuantity =
              product.inventoryQuantity + variant.inventoryQuantity;
        }
        _demoBackend.add(product);
      }
    }

    final _products = <Product>[];
    if (skuFilter != null) {
      skuFilter = skuFilter.trim().toUpperCase();
    }
    if (barcodeFilter != null) {
      barcodeFilter = barcodeFilter.trim().toUpperCase();
    }

    for (int i = 0; i < _demoBackend.length; i++) {
      final _product = _demoBackend[i];

      // Product status filter
      if (statusFilter != null && !statusFilter[_product.status]!) {
        continue;
      }

      //SKU filter
      if (skuFilter != null) {
        var skuOk = false;
        for (Variant v in _product.variants) {
          final variantSku = v.sku.trim().toUpperCase();
          if (variantSku == skuFilter) {
            skuOk = true;
            break;
          }
        }
        if (!skuOk) {
          continue;
        }
      }

      //Barecode filter
      if (barcodeFilter != null) {
        var barcodeOk = false;
        for (Variant v in _product.variants) {
          final variantBarcode = v.barcode.trim().toUpperCase();
          if (variantBarcode == barcodeFilter) {
            barcodeOk = true;
            break;
          }
        }
        if (!barcodeOk) {
          continue;
        }
      }

      //Vendor filter
      if (vendorFilter != null) {
        if (vendorFilter != _product.vendor) {
          continue;
        }
      }

      //ProductType filter
      if (productTypeFilter != null) {
        if (productTypeFilter != _product.type) {
          continue;
        }
      }

      // Inventory filter :
      if (inventoryRangeFilter != null) {
        bool inRange =
            _product.inventoryQuantity >= inventoryRangeFilter.start &&
                _product.inventoryQuantity <= inventoryRangeFilter.end;
        if (!inRange) {
          continue;
        }
      }

      //Product title filter
      var accepted = true;
      if (productTitleFilter != null) {
        final tokens = _product.title.tokenize();
        accepted = accepted && tokens.startsWithAll(productTitleFilter);
        if (!accepted) {
          continue;
        }
      }

      _products.add(_product);
    }

    return Future<List<Product>>(() => _products);
  }
}
