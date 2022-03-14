import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';
import 'package:whaloo_genuinity/controllers/store_controller.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class MockBackend extends GetConnect implements Backend {
  // static const _demoStore = "halloweenmakeup";
  // static const _demoStore = "ruesco";
  // static const _demoStore = "huel";
  // static const _demoStore = "signatureveda";
  // static const _demoStore = "locknloadairsoft";
  static const _demoStore = "decathlon";

  final _demoBackend = <Product>[];

  @override
  Future<Store> getCurrentStore() async {
    const asset = "assets/demo/${_demoStore}_store.json";
    var response = await get(asset);
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
    List<String>? searchKeywords,
    RangeValues? inventoryRange,
  }) async {
    if (_demoBackend.isEmpty) {
      const url = "assets/demo/${_demoStore}_products.json";
      var response = await get(url);
      var productsData = await json.decode(response.bodyString!);
      productsData = productsData['products'];

      for (var i = 0; i < productsData.length; i++) {
        var productData = productsData[i];
        var product = Product(
          id: ProductId(productData['id']),
          title: productData['title'],
          image: productData['image'],
          codesCount: Random().nextInt(5000),
          inventoryQuantity:
              Random().nextInt(10) == 0 ? 0 : Random().nextInt(5000),
        );
        _demoBackend.add(product);
      }
    }

    final _products = <Product>[];
    for (int i = 0; i < _demoBackend.length; i++) {
      final _product = _demoBackend[i];
      var accepted = true;

      //inventory filter :
      if (inventoryRange != null) {
        bool inRange = _product.inventoryQuantity >= inventoryRange.start &&
            _product.inventoryQuantity <= inventoryRange.end;
        if (!inRange) {
          continue;
        }
      }

      //text filter
      if (searchKeywords != null) {
        final tokens = _product.title.tokenize();
        accepted = accepted && tokens.startsWithAll(searchKeywords);
        if (!accepted) {
          continue;
        }
      }

      _products.add(_product);
    }

    return Future<List<Product>>(() => _products);
  }
}
