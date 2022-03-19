import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';

class CodesController extends GetxController {
  static CodesController instance = Get.find();

  static int loadingSteps = 10;

  final Rx<Product?> _currentProduct = Rx<Product?>(null);
  final _isLoadingData = true.obs;

  final _codes = <Code>[].obs;
  final _visibleCodes = 0.obs;

  Future<void> loadCodes(Product product) async {
    _codes.clear();
    _isLoadingData.value = true;
    _currentProduct.value = product;
    Backend.instance.loadCodes(product: product).then((codes) {
      _codes.addAll(codes);
      _visibleCodes.value = min(loadingSteps, _codes.length);
      _isLoadingData.value = false;
    });
  }

  Future<void> showMore() async {
    Future.delayed(Duration.zero, () {
      _visibleCodes.value =
          min(_visibleCodes.value + loadingSteps, _codes.length);
    });
  }

  Code code(Product product, int index) {
    return _codes[index];
  }

  void select(Code code) {
    code.isSelected = true;
    int index = _codes.indexOf(code);
    _codes[index] = code;
  }

  void unselect(Code code) {
    code.isSelected = false;
    int index = _codes.indexOf(code);
    _codes[index] = code;
  }

  bool isLoadingData() {
    return _isLoadingData.value;
  }

  int visibleCodesCount() {
    return _visibleCodes.value;
  }

  int codesCount() {
    return _codes.length;
  }
}
