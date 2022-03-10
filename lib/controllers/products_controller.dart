import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/main.dart';

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  static int maxProducsLoaded = 10000;

  final _allProducts = <Product>[].obs;

  var isEditingSearch = false.obs;
  var isLoadingData = true.obs;
  var isDataLoaded = false.obs;
  var hasMoreData = true.obs;

  var products = <Product>[].obs;
  var codes = <ProductId, List<Code>>{}.obs;
  var allProductsNames = <String>[].obs;
  var searchFilter = <String>[].obs;
  var searchText = "".obs;

  @override
  void onReady() async {
    await loadDemoProductsData();
    super.onReady();
  }

  Future<void> loadDemoProductsData() async {
    const asset = "assets/demo/${DEMO_STORE}_products.json";
    print("Loading '$asset' ...");
    String response = await rootBundle.loadString(asset);
    final productsData = await json.decode(response);

    // Loading products and codes :
    final products = productsData['products'];
    // this.products.clear();
    for (var i = 0; i < products.length; i++) {
      if (i >= maxProducsLoaded) break;
      var product = products[i];
      // List codes = product['codes'];
      allProductsNames.add(product['title']);
      _allProducts.add(
        Product(
          id: ProductId(product['id']),
          title: product['title'],
          image: product['image'],
          codesCount: Random().nextInt(5000), //codes.length,
          inventoryQuantity: Random().nextInt(100), //codes.length,
        ),
      );
    }

    this.products.addAll(_allProducts);
    isDataLoaded.value = true;
    isLoadingData.value = false;
  }

  Future<void> changeSearchFilter(String searchText) async {
    isEditingSearch.value = false;
    if (searchText.trim().isEmpty && searchFilter.isEmpty) {
      return;
    }
    this.searchText.value = searchText;
    isLoadingData.value = true;
    products.clear();
    searchFilter.clear();
    final searchTextSplitted = searchText.toLowerCase().split(' ');
    for (int i = 0; i < searchTextSplitted.length; i++) {
      final keyword = searchTextSplitted[i].trim();
      if (keyword.isNotEmpty) {
        searchFilter.add(keyword);
      }
    }
    Timer(const Duration(seconds: 1), () {
      for (int i = 0; i < _allProducts.length; i++) {
        final _product = _allProducts[i];
        var accepted = true;
        for (int i = 0; i < searchFilter.length; i++) {
          final keyword = searchFilter[i];
          accepted = accepted && _product.title.toLowerCase().contains(keyword);
        }
        if (accepted) {
          products.add(_product);
        }
      }
      isLoadingData.value = false;
    });
  }

  void changeIsEditingSearch(bool newValue) {
    isEditingSearch.value = newValue;
  }
}

class ProductId implements Comparable<ProductId> {
  String value;
  ProductId(this.value);

  @override
  int compareTo(ProductId other) {
    return value.compareTo(other.value);
  }
}

class Product {
  final ProductId id;
  final String title;
  final String image;
  final int codesCount;
  final int inventoryQuantity;

  const Product({
    required this.id,
    required this.title,
    required this.image,
    required this.codesCount,
    required this.inventoryQuantity,
  });
}

class Code {
  final String shortCode;
  final String serial;
  final DateTime creationDate;

  const Code({
    required this.shortCode,
    required this.serial,
    required this.creationDate,
  });
}
