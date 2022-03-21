import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';

//TODO Codes : add sorting
//TODO Codes : add search
//TODO Codes : add delete code
class CodesController extends GetxController {
  static CodesController instance = Get.find();

  static int loadingSteps = 10;

  final Rx<Product?> _currentProduct = Rx<Product?>(null);
  final _isLoadingData = true.obs;

  final _codes = <Code>[].obs;
  final _visibleCodes = 0.obs;

  @override
  void onReady() async {
    super.onReady();
    Backend.instance.addListener(BackendEvent.codeAdded, ({arguments}) {
      if (_currentProduct.value != null) {
        loadCodes(_currentProduct.value!);
      }
    });
  }

  Future<void> loadCodes(Product product) async {
    Future.delayed(Duration.zero, () {
      _codes.clear();
      _isLoadingData.value = true;
      _currentProduct.value = product;
      Backend.instance.loadCodes(product: product).then((codes) {
        _codes.addAll(codes);
        _visibleCodes.value = min(loadingSteps, _codes.length);
        _isLoadingData.value = false;
      });
    });
  }

  Future<void> showMore() async {
    Future.delayed(Duration.zero, () {
      _visibleCodes.value =
          min(_visibleCodes.value + loadingSteps, _codes.length);
    });
  }

  Future<void> addCode(Code code) async {
    //TODO Codes : add validation
    Future.delayed(Duration.zero, () {
      _codes.add(code);
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
