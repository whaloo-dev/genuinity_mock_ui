import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/main.dart';

enum HiddenFilterMode {
  showAll,
  showHidenOnly,
  showVisibleOnly,
}

class ProductsController extends GetxController {
  static ProductsController instance = Get.find();

  final _demoBackend = <Product>[].obs;

  var isEditingSearch = false.obs;
  var isLoadingData = true.obs;
  var isDataLoaded = false.obs;

  final _products = <Product>[].obs;
  final _visibleProducts = <Product>[].obs;
  // final _codes = <ProductId, List<Code>>{}.obs;

  var textFilter = <String>[].obs;
  var hiddenFilter = HiddenFilterMode.showVisibleOnly.obs;
  var searchText = "".obs;

  @override
  void onReady() async {
    await loadDemoProductsData();
    super.onReady();
  }

  Future<void> loadDemoProductsData() async {
    const asset = "assets/demo/${demoStore}_products.json";
    String response = await rootBundle.loadString(asset);
    final productsData = await json.decode(response);

    // Loading products and codes :
    final products = productsData['products'];
    for (var i = 0; i < products.length; i++) {
      var product = products[i];
      _demoBackend.add(
        Product(
          id: ProductId(product['id']),
          title: product['title'],
          image: product['image'],
          isHidden: false,
          codesCount: Random().nextInt(5000),
          inventoryQuantity: Random().nextInt(100),
        ),
      );
    }

    _products.addAll(_demoBackend);
    _updateVisibleProducts();

    isDataLoaded.value = true;
    isLoadingData.value = false;
  }

  void changeSearchFilter(String searchText) {
    this.searchText.value = searchText;
    isEditingSearch.value = false;
    textFilter.clear();
    final _searchTextSplitted = searchText.toLowerCase().split(' ');
    for (int i = 0; i < _searchTextSplitted.length; i++) {
      final keyword = _searchTextSplitted[i].trim();
      if (keyword.isNotEmpty) {
        textFilter.add(keyword);
      }
    }
    _applyFilter();
  }

  void changeIsEditingSearch(bool newValue) {
    isEditingSearch.value = newValue;
  }

  Product product(int index) {
    return _visibleProducts[index];
  }

  int productsCount() {
    return _visibleProducts.length;
  }

  Future<void> hideProduct(Product product) async {
    return Future.delayed(Duration(milliseconds: _randomInt()), () {
      //backend modification
      product.isHidden = true;
      //local modification
      _products[_products.indexOf(product)] = product;
      _updateVisibleProducts();
    });
  }

  Future<void> unhideProduct(Product product, {int? index}) async {
    return Future.delayed(Duration(milliseconds: _randomInt()), () {
      //backend modification
      product.isHidden = false;
      //local modification
      _products[_products.indexOf(product)] = product;
      _updateVisibleProducts();
    });
  }

  void _updateVisibleProducts() {
    _visibleProducts.clear();
    _visibleProducts.addAll(_products.where((p) {
      // var visible =
      // hiddenFilter.value == HiddenFilterMode.showAll ? true : false;
      return !p.isHidden;
    }));
  }

  int _randomInt() {
    return Random.secure().nextInt(1000);
  }

  Future<void> _applyFilter() async {
    isLoadingData.value = true;
    _products.clear();
    _updateVisibleProducts();

    Timer(const Duration(seconds: 1), () {
      for (int i = 0; i < _demoBackend.length; i++) {
        final _product = _demoBackend[i];
        var accepted = true;
        for (int i = 0; i < textFilter.length; i++) {
          final keyword = textFilter[i];
          accepted = accepted && _product.title.toLowerCase().contains(keyword);
        }
        if (accepted) {
          _products.add(_product);
        }
      }
      _updateVisibleProducts();
      isLoadingData.value = false;
    });
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
  bool isHidden;
  final int codesCount;
  final int inventoryQuantity;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.isHidden,
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
