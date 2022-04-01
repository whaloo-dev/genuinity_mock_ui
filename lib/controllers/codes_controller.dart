import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';

//TODO Codes : add sorting
//TODO Codes : add search
//TODO Codes : add export code
//TODO Codes : add test verify code
//TODO Codes : add bulk delete
//TODO Codes : add bulk export
//TODO Codes : add bulk export
class CodesController extends GetxController {
  static CodesController instance = Get.find();

  static int loadingSteps = 10;

  final Rx<Product?> _currentProduct = Rx<Product?>(null);
  final _isLoadingData = true.obs;

  final _codes = <Code>[].obs;
  final _selectedCodes = <Code>{}.obs;
  final _visibleCodes = 0.obs;

  @override
  void onReady() async {
    super.onReady();
    Backend.instance.addListener(BackendEvent.codeAdded, ({arguments}) {
      if (_currentProduct.value != null) {
        loadCodes(_currentProduct.value!);
      }
    });
    Backend.instance.addListener(BackendEvent.codeRemoved, ({arguments}) {
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

  Code code(Product product, int index) {
    return _codes[index];
  }

  void select(Code code) {
    _selectedCodes.add(code);
  }

  void unselect(Code code) {
    _selectedCodes.remove(code);
  }

  bool isSelected(code) {
    return _selectedCodes.contains(code);
  }

  Future<void> deleteCode(Code code) async {
    await Backend.instance.deleteCode(code);
    showActionDoneNotification(
      "Code deleted",
      onCancel: () {
        Get.closeCurrentSnackbar();
        Backend.instance.undeleteCode(code);
      },
    );
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
