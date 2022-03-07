import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/controllers/codes_controller.dart';

class StoreController extends GetxController {
  static StoreController get instance => Get.find();

  var isStoreLoaded = false.obs;
  Store? store;

  @override
  void onReady() async {
    await loadDemoStoreData();
    super.onReady();
  }

  Future<void> loadDemoStoreData() async {
    var asset = "assets/demo/store.json";
    rootBundle.evict(asset);
    // print("loading : $asset");
    final String response = await rootBundle.loadString(asset);
    // print("loading : $response");
    final storeData = await json.decode(response);
    store = Store(
      id: storeData['id'],
      name: storeData['name'],
      imageUrl: storeData['icon'],
      website: storeData['url'],
    );

    // Loading products and codes :
    List products = storeData['products'];
    codesController.products.clear();

    for (var i = 0; i < products.length; i++) {
      var product = products[i];
      List codes = product['codes'];

      codesController.products.add(Product(
        id: ProductId(product['id']),
        title: product['title'],
        image: product['image'],
        codesCount: Random().nextInt(500000000), //codes.length,
      ));
    }
    isStoreLoaded.value = true;
  }
}

class Store {
  String id;
  String name;
  String imageUrl;
  String website;
  Store({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.website,
  }) : super();
}
