import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/creation/creation.dart';

class CreationController extends GetxController {
  static CreationController instance = Get.find();

  final _product = Rx<Product?>(null);
  bool _isProductPreset = true;
  final _productFieldError = Rx<String?>(null);

  final _variant = Rx<ProductVariant?>(null);
  final _variantFieldError = Rx<String?>(null);

  final _codeStyle = Rx<CodeStyle?>(null);
  final _codeStyles = <CodeStyle>[].obs;

  final _expirationDate = Rx<DateTime?>(null);
  final _expirationDateError = Rx<String?>(null);

  final _descriptionController = TextEditingController();

  final TextEditingController _bulkSizeController =
      TextEditingController(text: "1");
  final _bulkSizeFieldError = Rx<String?>(null);

  CreationController() {
    _bulkSizeController.addListener(() {
      _bulkSizeFieldError.value = null;
    });
  }

  changeProduct(Product? product) {
    _product.value = product;
    _productFieldError.value = null;
    _variant.value = product == null
        ? null
        : product.variants.length != 1
            ? null
            : product.variants[0];
    _variantFieldError.value = null;
  }

  changeVariant(ProductVariant? newValue) {
    _variant.value = newValue;
    _variantFieldError.value = null;
  }

  changeCodeStyle(CodeStyle? codeStyle) {
    _codeStyle.value = codeStyle;
  }

  changeExpirationDate(DateTime? expirationDate) {
    _expirationDate.value = expirationDate;
    _expirationDateError.value = null;
  }

  String? variantFieldError() => _variantFieldError.value;
  ProductVariant? variant() => _variant.value;
  CodeStyle? codeStyle() => _codeStyle.value;
  List<CodeStyle> codeStyles() => _codeStyles;
  DateTime? expirationDate() => _expirationDate.value;

  TextEditingController descriptionController() => _descriptionController;
  TextEditingController bulkSizeController() => _bulkSizeController;
  String? bulkSizeFieldError() => _bulkSizeFieldError.value;
  Product? product() => _product.value;
  bool isProductPreset() => _isProductPreset;
  String? productFieldError() => _productFieldError.value;
  String? expirationDateError() => _expirationDateError.value;

  createNew({Product? product}) async {
    Get.back();
    _codeStyles.value = await Backend.instance.loadCodeStyles();
    _isProductPreset = product != null;

    changeCodeStyle(_codeStyles[0]);
    changeProduct(product);
    changeExpirationDate(null);
    _descriptionController.text = "";
    _bulkSizeController.text = "1";
    _bulkSizeFieldError.value = null;
    Get.dialog(
      const CodesCreationDialog(),
    );
  }

  createFrom(Code code) async {
    Get.back();
    _codeStyles.value = await Backend.instance.loadCodeStyles();
    _codeStyle.value = code.codeStyle;
    _isProductPreset = false;
    _product.value = code.variant.product;
    _productFieldError.value = null;
    _variantFieldError.value = null;
    _variant.value = code.variant;
    _expirationDate.value = code.expirationDate == null
        ? null
        : code.expirationDate!.isBefore(DateTime.now())
            ? null
            : code.expirationDate;
    _expirationDateError.value = null;
    _descriptionController.text = code.description ?? "";
    _bulkSizeController.text = "1";
    _bulkSizeFieldError.value = null;
    Get.dialog(
      const CodesCreationDialog(),
    );
  }

  submit() {
    final isProductValid = _validateProductField();
    final isVariantValid = _validateVariantField();
    final isBulkSizeValid = _validateBulkSizeField();
    final isExpirationDateValid = _validateExpirationDate();

    final isValid = isProductValid &&
        isVariantValid &&
        isExpirationDateValid &&
        isBulkSizeValid;

    if (!isValid) {
      return;
    }

    final bulkSize = int.parse(_bulkSizeController.text.trim());
    final description = _descriptionController.text.trim();

    Backend.instance
        .createCode(
          _variant.value!,
          _codeStyle.value!,
          expirationDate: _expirationDate.value,
          description: description.isEmpty ? null : description,
          blukSize: bulkSize,
        )
        .then(
          (value) => showActionDoneNotification(bulkSize == 1
              ? "New code created"
              : "$bulkSize new codes created."),
        );

    Get.back();

    if (!isProductPreset()) {
      Timer(kAnimationDuration, () {
        codesController.open(product()!);
      });
    }
  }

  cancel() {
    Get.back();
  }

  bool _validateProductField() {
    if (product() == null) {
      _productFieldError.value = "This field is mandatory";
      return false;
    }
    return true;
  }

  bool _validateVariantField() {
    if (product() == null) {
      return false;
    }

    if (product()!.variants.length <= 1) {
      _variant.value = product()!.variants[0];
      return true;
    }

    if (_variant.value == null) {
      _variantFieldError.value = "This field is mandatory";
      return false;
    }

    return true;
  }

  bool _validateExpirationDate() {
    if (_expirationDate.value == null) {
      return true;
    }

    if (_expirationDate.value!.isBefore(DateTime.now())) {
      _expirationDateError.value = "Expiration date cannot be in the past";
      return false;
    }

    return true;
  }

  bool _validateBulkSizeField() {
    final bulkSizeText = _bulkSizeController.text;
    if (bulkSizeText.trim().isEmpty) {
      _bulkSizeFieldError.value = "This field is mandatory";
      return false;
    }
    final bulkSize = int.tryParse(bulkSizeText);
    if (bulkSize == null) {
      _bulkSizeFieldError.value = "Incorrect input";
      return false;
    }
    if (bulkSize <= 0) {
      _bulkSizeFieldError.value = "Should be ≥ 1";
      return false;
    }
    return true;
  }
}
