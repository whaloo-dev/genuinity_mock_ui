import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';
import 'package:crypto/crypto.dart';

class DemoBackend extends GetConnect implements Backend {
  // static const _demoStore = "halloweenmakeup";
  // static const _demoStore = "ruesco";
  // static const _demoStore = "huel";
  // static const _demoStore = "signatureveda";
  // static const _demoStore = "locknloadairsoft";
  // static const _demoStore = "decathlon";
  // static const _demoStore = "thebookbundler";
  // static const _demoStore = "commonfarmflowers";
  // static const _demoStore = "atelierdubraceletparisien";
  static const _demoStoreName = "nixon";

  late String _basePath;

  DemoBackend() {
    _basePath = kReleaseMode ? "assets/assets" : "assets";
  }

  Store? _demoStore;
  final _products = <Product>[];
  final _codes = <ProductId, List<Code>>{};
  bool _isDemoDataInitialised = false;

  Future<void> initDemoData() async {
    if (_isDemoDataInitialised) {
      return;
    }
    print("loading demo data");
    //load store demo data:
    var url = "$_basePath/demo/${_demoStoreName}_store.json";
    var response = await get(url);
    final storeData = await json.decode(response.bodyString!);
    _demoStore = Store(
      id: storeData['id'],
      name: storeData['name'],
      website: storeData['url'],
      imageUrl:
          (storeData as Map).containsKey('icon') ? storeData['icon'] : null,
    );

    //loading products
    url = "$_basePath/demo/${_demoStoreName}_products.json";
    response = await get(url);
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
        codesCount: Random().nextInt(100),
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
        var variant = ProductVariant(
          product: product,
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

      _products.add(product);
    }
    _isDemoDataInitialised = true;
  }

  @override
  Future<Store> getCurrentStore() async {
    await initDemoData();
    return Future<Store>(() => _demoStore!);
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
    await initDemoData();

    final products = <Product>[];
    if (skuFilter != null) {
      skuFilter = skuFilter.trim().toUpperCase();
    }
    if (barcodeFilter != null) {
      barcodeFilter = barcodeFilter.trim().toUpperCase();
    }

    for (int i = 0; i < _products.length; i++) {
      final _product = _products[i];

      // Product status filter
      if (statusFilter != null && !statusFilter[_product.status]!) {
        continue;
      }

      //SKU filter
      if (skuFilter != null) {
        var skuOk = false;
        for (ProductVariant v in _product.variants) {
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
        for (ProductVariant v in _product.variants) {
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
        double start = inventoryRangeFilter.start;
        double end = inventoryRangeFilter.end;
        end = end == productsController.maxInventorySize()
            ? double.maxFinite
            : end;

        bool inRange = _product.inventoryQuantity >= start &&
            _product.inventoryQuantity <= end;
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

      products.add(_product);
    }

    return Future<List<Product>>(() => products);
  }

  @override
  Future<List<Code>> loadCodes({
    required Product product,
  }) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final codes = <Code>[];
      for (int i = 0; i < product.codesCount; i++) {
        final scanCount = Random().nextInt(3) == 0 ? Random().nextInt(1000) : 0;
        final creationDate = DateTime.utc(2022, 1, 1).add(
          Duration(
            days: Random().nextInt(30),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        );
        final exportDate = creationDate.add(
          Duration(
            days: Random().nextInt(30),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        );
        final scanDate = exportDate.add(
          Duration(
            days: Random().nextInt(30),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        );
        codes.add(
          Code(
            creationDate: creationDate,
            scanCount: scanCount,
            scanErrorsCount:
                scanCount == 0 ? 0 : Random().nextInt((scanCount / 10).round()),
            serial: Random().nextInt(99999999).toString(),
            shortCode: md5.convert(utf8.encode(product.title)).toString(),
            variant:
                product.variants[Random().nextInt(product.variants.length)],
            exportDate: scanCount != 0
                ? exportDate
                : Random().nextBool()
                    ? exportDate
                    : null,
            lastScanDate: scanCount == 0 ? null : scanDate,
          ),
        );
        _codes[product.id] = codes;
      }
      return codes;
    });
  }
}
