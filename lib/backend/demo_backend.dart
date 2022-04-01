import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

//TODO loadProduct returns a structure containing agregates
class DemoBackend extends GetConnect implements Backend {
  // static const _demoStoreName = "halloweenmakeup";
  static const _demoStoreName = "ruesco";
  // static const _demoStoreName = "huel";
  // static const _demoStoreName = "signatureveda";
  // static const _demoStoreName = "locknloadairsoft";
  // static const _demoStoreName = "decathlon";
  // static const _demoStoreName = "thebookbundler";
  // static const _demoStoreName = "commonfarmflowers";
  // static const _demoStoreName = "atelierdubraceletparisien";
  // static const _demoStoreName = "nixon";
  // static const _demoStoreName = "seriouswatches";

  late String _basePath;

  DemoBackend() {
    _basePath = kReleaseMode ? "assets/assets" : "assets";
  }

  final _callbacks = <BackendEvent, List<BackendCallback>>{};
  Store? _demoStore;
  final _products = <Product>[];
  final _codes = <ProductId, List<Code>>{};
  final _deletedCodes = <Code>[];

  bool _isStoreDataInitialized = false;
  bool _isProductDataInitialized = false;

  Future<void> _initStoreData() async {
    if (_isStoreDataInitialized) {
      return;
    }
    Get.log("Backend : initializating store data...");

    var url = "$_basePath/demo/data/${_demoStoreName}_store.json";
    var response = await get(url);
    final storeData = await json.decode(response.bodyString!);
    _demoStore = Store(
      id: storeData['id'],
      name: storeData['name'],
      website: storeData['url'],
      imageUrl:
          (storeData as Map).containsKey('icon') ? storeData['icon'] : null,
    );

    _isStoreDataInitialized = true;
  }

  Future<void> _initProductsData() async {
    if (_isProductDataInitialized) {
      return;
    }
    Get.log("Backend : initializing products data...");

    final url = "$_basePath/demo/data/${_demoStoreName}_products.json";
    final response = await get(url);
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
        codesCount: 0,
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
          image: variantData.containsKey('image')
              ? variantData['image']['src']
              : null,
        );
        product.variants.add(variant);
        product.inventoryQuantity =
            product.inventoryQuantity + variant.inventoryQuantity;
      }

      _products.add(product);
    }
    _isProductDataInitialized = true;
  }

  @override
  Future<Store> getCurrentStore() async {
    Get.log("Backend : getCurrentStore...");
    await _initStoreData();
    return Future<Store>(() => _demoStore!);
  }

  @override
  Future<List<Product>> loadProducts({
    bool showProductsHavingCodesOnly = true,
    Map<ProductStatus, bool>? statusFilter,
    List<String>? productTitleFilter,
    String? skuFilter,
    String? barcodeFilter,
    String? vendorFilter,
    String? productTypeFilter,
    RangeValues? inventoryRangeFilter,
  }) async {
    Get.log("Backend : loadProducts...");

    await _initProductsData();

    final products = <Product>[];
    if (skuFilter != null) {
      skuFilter = skuFilter.trim().toUpperCase();
    }
    if (barcodeFilter != null) {
      barcodeFilter = barcodeFilter.trim().toUpperCase();
    }

    for (int i = 0; i < _products.length; i++) {
      final _product = _products[i];
      if (showProductsHavingCodesOnly && _product.codesCount == 0) {
        continue;
      }

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
    Get.log("Backend : loadCodes...");

    return Future.delayed(const Duration(milliseconds: 100), () {
      if (!_codes.containsKey(product.id)) {
        return <Code>[];
      }
      final codes = _codes[product.id]!;
      codes.sort(
        (a, b) => -a.creationDate.compareTo(b.creationDate),
      );
      return codes;
    });
  }

  @override
  Future<void> createCode(
    ProductVariant variant,
    CodeStyle codeStyle, {
    String? description,
    DateTime? expirationDate,
    int blukSize = 1,
    Map<String, String> tags = const <String, String>{},
  }) async {
    Get.log("Backend : createCode...");

    return Future.delayed(
      Duration.zero,
      () {
        final product = variant.product;
        for (int i = 0; i < blukSize; i++) {
          final creationDate = DateTime.now();
          final serial =
              ("${variant.title} ${creationDate.microsecondsSinceEpoch} ${Random().nextInt(1000)}")
                  .hashCode
                  .toString();
          final code = Code(
            creationDate: creationDate,
            scanCount: 0,
            scanErrorsCount: 0,
            serial: serial,
            shortCode: _computeShortCode(serial, 7),
            variant: variant,
            image: "$_basePath/demo/images/qrcode${codeStyle.id}.png",
            codeStyle: codeStyle,
            description: description,
            expirationDate: expirationDate,
          );

          if (!_codes.containsKey(product.id)) {
            _codes[product.id] = <Code>[];
          }
          _codes[product.id]!.add(code);
        }
        _doCallbacks(BackendEvent.codeAdded);
        variant.product.codesCount = variant.product.codesCount + blukSize;
        _products[_products.indexOf(product)] = product;
        _doCallbacks(BackendEvent.productUpdated);
      },
    );
  }

  @override
  Future<List<CodeStyle>> loadCodeStyles() async {
    Get.log("Backend : loadCodeStyles...");

    return Future.delayed(
      Duration.zero,
      () => List.generate(
        7,
        (index) => CodeStyle(
          id: index + 1,
          image: "$_basePath/demo/images/qrcode${index + 1}.png",
        ),
      ),
    );
  }

  @override
  Future<void> deleteCode(Code code) async {
    Get.log("Backend : deleteCode...");
    return Future.delayed(Duration.zero, () {
      Product product = code.variant.product;
      product.codesCount = product.codesCount - 1;
      _codes[product.id]!.remove(code);
      _deletedCodes.add(code);
      _doCallbacks(BackendEvent.codeRemoved);
      _doCallbacks(BackendEvent.productUpdated);
    });
  }

  @override
  Future<void> undeleteCode(Code code) async {
    Get.log("Backend : undeleteCode...");
    return Future.delayed(Duration.zero, () {
      Product product = code.variant.product;
      product.codesCount = product.codesCount + 1;
      _codes[product.id]!.add(code);
      _deletedCodes.remove(code);
      _doCallbacks(BackendEvent.codeAdded);
      _doCallbacks(BackendEvent.productUpdated);
    });
  }

  @override
  Future<void> deleteCodes(List<Code> codes) async {
    Get.log("Backend : deleteCodes...");
    return Future.delayed(Duration.zero, () {
      for (Code code in codes) {
        Product product = code.variant.product;
        product.codesCount = product.codesCount - 1;
        _codes[product.id]!.remove(code);
        _deletedCodes.add(code);
      }
      _doCallbacks(BackendEvent.codeRemoved);
      _doCallbacks(BackendEvent.productUpdated);
    });
  }

  @override
  Future<void> undeleteCodes(List<Code> codes) async {
    Get.log("Backend : undeleteCodes...");
    return Future.delayed(Duration.zero, () {
      for (Code code in codes) {
        Product product = code.variant.product;
        product.codesCount = product.codesCount + 1;
        _codes[product.id]!.add(code);
        _deletedCodes.remove(code);
      }
      _doCallbacks(BackendEvent.codeAdded);
      _doCallbacks(BackendEvent.productUpdated);
    });
  }

  @override
  Future<String> exportCode(Code code) async {
    //TODO Codes add export code
    return Future.value("");
  }

  @override
  Future<String> exportCodes(List<Code> codes) async {
    //TODO Codes add bulk export code
    return Future.value("");
  }

  @override
  void addListener<T>(BackendEvent event, BackendCallback<T> callback) {
    if (!_callbacks.containsKey(event)) {
      _callbacks[event] = <BackendCallback>[];
    }
    _callbacks[event]!.add(callback as BackendCallback);
  }

  void _doCallbacks<T>(BackendEvent event, {T? argmuments}) {
    if (!_callbacks.containsKey(event)) {
      return;
    }
    for (BackendCallback callback in _callbacks[event]!) {
      callback(arguments: argmuments);
    }
  }

  String _computeShortCode(String serial, int codeLength) {
    final md5code = md5.convert(utf8.encode(serial)).toString();
    final start = (md5code.length - codeLength) % serial.hashCode;
    final shortCode = md5code.substring(start, start + codeLength);
    return shortCode;
  }
}
