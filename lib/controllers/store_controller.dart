import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  static StoreController get instance => Get.find();

  var isStoreLoaded = false.obs;
  Store? store;

  Future<void> loadDemoStoreData() async {
    rootBundle.clear();

    var asset = "assets/demo/store.json";
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
