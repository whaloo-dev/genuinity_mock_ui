import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/main.dart';

class StoreController extends GetxController {
  static StoreController get instance => Get.find();

  var isDataLoaded = false.obs;
  Store? store;

  @override
  void onReady() async {
    await loadDemoStoreData();
    super.onReady();
  }

  Future<void> loadDemoStoreData() async {
    const asset = "assets/demo/${DEMO_STORE}_store.json";
    print("loading : $asset");
    final String response = await rootBundle.loadString(asset);
    final storeData = await json.decode(response);
    store = Store(
      id: storeData['id'],
      name: storeData['name'],
      imageUrl: storeData['icon'],
      website: storeData['url'],
    );
    isDataLoaded.value = true;
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
