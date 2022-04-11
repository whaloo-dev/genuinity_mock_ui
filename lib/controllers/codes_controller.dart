import 'dart:math';

import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/url_launcher.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

//TODO Codes : add test verify code
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
      loadCodes();
    }
  }

  @override
  void onReady() {
    super.onReady();
    Backend.instance.addListener(BackendEvent.codeAdded, _callback);
    Backend.instance.addListener(BackendEvent.codeRemoved, _callback);
    filteringController.addFilteringListener(_callback);
  }

  Future<void> loadCodes() async {
    _isLoadingData.value = true;
    Future.delayed(Duration.zero, () {
      Backend.instance
          .loadCodes(
        product: _currentProduct.value!,
        sorting: filteringController.sorting(),
        timeSpan: filteringController.timeSpan(),
        codeStatusFilter: filteringController.codeStatus(),
      )
          .then((codes) {
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

  void selectAll() {
    _selectedCodes.clear();
    _selectedCodes.addAll(_codes);
  }

  void unselectAll() {
    _selectedCodes.clear();
  }

  bool isSelected(code) {
    return _selectedCodes.contains(code);
  }

  Set<Code> selection() {
    return _selectedCodes;
  }

  Future<void> deleteCode(Code code) async {
    Get.back();
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
    if (_currentProduct.value != null) loadCodes();
  }

  Future<void> deleteSelection() async {
    Get.back();
    if (_selectedCodes.isEmpty) {
      return;
    }
    if (_selectedCodes.length == 1) {
      deleteCode(_selectedCodes.first);
      return;
    }
    final codes = _selectedCodes.toList();
    await Backend.instance.deleteCodes(codes);
    _selectedCodes.removeAll(codes);
    showActionDoneNotification(
      "${codes.length} Codes deleted",
      onCancel: () {
        Get.closeCurrentSnackbar();
        Backend.instance.undeleteCodes(codes);
      },
    );
  }

  Future<void> printSelection() async {
    if (_selectedCodes.isEmpty) {
      return;
    }
    if (_selectedCodes.length == 1) {
      printCode(_selectedCodes.first);
      return;
    }
    final exportUrl =
        await Backend.instance.printCodes(_selectedCodes.toList());
    launchURL(exportUrl);
    if (_currentProduct.value != null) loadCodes();
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

  Product? product() => _currentProduct.value;

  open(Product product) {
    bool isSameProduct = _currentProduct.value != null &&
        _currentProduct.value!.id == product.id;
    if (!isSameProduct) {
      _selectedCodes.clear();
    }
    _currentProduct.value = product;

    loadCodes();
    navigationController.navigateTo(codesPageRoute);
  }

  close() {}
}
