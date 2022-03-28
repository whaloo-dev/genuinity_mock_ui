import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/codes_creation/codes_creation.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class CodesCreationController extends GetxController {
  static CodesCreationController instance = Get.find();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final _product = Rx<Product?>(null);
  bool _isProductPreset = true;
  final _productFieldError = Rx<String?>(null);

  final _variant = Rx<ProductVariant?>(null);
  final _variantFieldError = Rx<String?>(null);

  final _codeStyle = Rx<CodeStyle?>(null);
  final _codeStyles = <CodeStyle>[].obs;

  final TextEditingController _bulkSizeController =
      TextEditingController(text: "1");
  final _bulkSizeFieldError = Rx<String?>(null);

  CodesCreationController() {
    _bulkSizeController.addListener(() {
      _bulkSizeFieldError.value = null;
    });
  }

  changeProduct(Product? product) {
    _product.value = product;
    _productFieldError.value = null;
    _variant.value = null;
    _variantFieldError.value = null;
  }

  changeVariant(ProductVariant? newValue) {
    _variant.value = newValue;
    _variantFieldError.value = null;
  }

  changeCodeStyle(CodeStyle? codeStyle) {
    _codeStyle.value = codeStyle;
  }

  String? variantFieldError() => _variantFieldError.value;
  ProductVariant? variant() => _variant.value;
  CodeStyle? codeStyle() => _codeStyle.value;
  List<CodeStyle> codeStyles() => _codeStyles;

  TextEditingController bulkSizeController() => _bulkSizeController;
  String? bulkSizeFieldError() => _bulkSizeFieldError.value;
  Product? product() => _product.value;
  bool isProductPreset() => _isProductPreset;
  String? productFieldError() => _productFieldError.value;

  open({Product? product}) {
    Backend.instance.loadCodeStyles().then((codeStyles) {
      _codeStyles.value = codeStyles;
      _codeStyle.value = codeStyles[0];
      _isProductPreset = product != null;
      _product.value = product;
      _productFieldError.value = null;
      _variantFieldError.value = null;
      _variant.value = null;
      _bulkSizeController.text = "1";
      _bulkSizeFieldError.value = null;
      Get.dialog(
        const CodesCreationWizard(),
      );
    });
  }

  submit() {
    var isProductValid = _validateProductField();
    var isVariantValid = _validateVariantField();
    var isBulkSizeValid = _validateBulkSizeField();
    var isValid = isProductValid && isVariantValid && isBulkSizeValid;
    if (!isValid) {
      return;
    }

    final bulkSize = int.parse(_bulkSizeController.text.trim());
    Backend.instance
        .createCode(
          _variant.value!,
          _codeStyle.value!,
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
        navigationController.navigateTo(codesPageRoute, arguments: product());
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
