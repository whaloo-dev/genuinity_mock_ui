import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';

//TODO Codes : add sorting
//TODO Codes : add search
//TODO Codes : add test verify code
//TODO Codes : add bulk delete
//TODO Codes : add bulk print
class CodesController extends GetxController {
  static CodesController instance = Get.find();

  static int loadingSteps = 10;

  final Rx<Product?> _currentProduct = Rx<Product?>(null);
  final _isLoadingData = true.obs;

  final _codes = <Code>[].obs;
  final _selectedCodes = <Code>{}.obs;
  final _visibleCodes = 0.obs;

  _callback({arguments}) {
    if (_currentProduct.value != null) {
      loadCodes(_currentProduct.value!);
    }
  }

  @override
  void onReady() async {
    super.onReady();
    Backend.instance.addListener(BackendEvent.codeAdded, _callback);
    Backend.instance.addListener(BackendEvent.codeRemoved, _callback);
    // Backend.instance.addListener(BackendEvent.codeUpdated, _callback);
  }

  Future<void> loadCodes(Product product) async {
    Future.delayed(Duration.zero, () {
      bool isSameProduct = _currentProduct.value != null &&
          _currentProduct.value!.id == product.id;
      if (!isSameProduct) {
        _selectedCodes.clear();
      }
      _isLoadingData.value = true;
      _currentProduct.value = product;
      if (!isSameProduct) {
        _selectedCodes.clear();
      }
      Backend.instance.loadCodes(product: product).then((codes) {
        _codes.value = codes;
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
    _selectedCodes.remove(code);
    showActionDoneNotification(
      "Code deleted",
      onCancel: () {
        Get.closeCurrentSnackbar();
        Backend.instance.undeleteCode(code);
      },
    );
  }

  Future<void> printCode(Code code) async {
    final exportUrl = await Backend.instance.printCode(code);
    launchURL(exportUrl);
    if (_currentProduct.value != null) loadCodes(_currentProduct.value!);
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
