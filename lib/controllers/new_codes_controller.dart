import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/backend.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/codes_creation_wizard/codes_creation_wizard.dart';

class NewCodesController extends GetxController {
  static NewCodesController instance = Get.find();

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final _product = Rx<Product?>(null);
  bool _isProductPreset = true;

  String _variantText = "";
  ProductVariant? _variant;
  final _variantFieldError = Rx<String?>(null);

  final TextEditingController _bulkSizeController =
      TextEditingController(text: "1");
  final _bulkSizeFieldError = Rx<String?>(null);

  NewCodesController() {
    _bulkSizeController.addListener(() {
      _bulkSizeFieldError.value = null;
    });
  }

  changeVariantText(String newValue) {
    _variantText = newValue;
    _variant = null;
    _variantFieldError.value = null;
  }

  changeVariant(ProductVariant newValue) {
    _variant = newValue;
    _variantFieldError.value = null;
  }

  String? variantFieldError() => _variantFieldError.value;
  TextEditingController bulkSizeController() => _bulkSizeController;
  String? bulkSizeFieldError() => _bulkSizeFieldError.value;
  Product? product() => _product.value;
  bool isProductPreset() => _isProductPreset;

  open({Product? product}) {
    _isProductPreset = product != null;
    _product.value = product;
    _variantFieldError.value = null;
    _variant = null;
    _variantText = "";
    _bulkSizeController.text = "1";
    _bulkSizeFieldError.value = null;
    Get.dialog(
      const CodesCreationWizard(),
    );
  }

  submit() {
    var isVariantValid = _validateVariantField(_product.value!);
    var isBulkSizeValid = _validateBulkSizeField();
    var isValid = isVariantValid && isBulkSizeValid;
    if (!isValid) {
      return;
    }

    final bulkSize = int.parse(_bulkSizeController.text.trim());
    Backend.instance
        .createCode(
          _variant!,
          blukSize: bulkSize,
        )
        .then(
          (value) =>
              showActionDoneNotification("${bulkSize == 1 ? 'A' : bulkSize} "
                  "new code${bulkSize == 1 ? '' : 's'} created."),
        );

    _closeForm();
  }

  cancel() {
    _closeForm();
  }

  bool _validateVariantField(Product product) {
    if (product.variants.length <= 1) {
      _variant = product.variants[0];
      return true;
    }

    if (_variantText.trim().isEmpty) {
      _variantFieldError.value = "This field is mandatory";
      return false;
    }

    for (ProductVariant variant in product.variants) {
      if (_variantText == variant.title) {
        _variant = variant;
        break;
      }
    }
    if (_variant == null) {
      _variantFieldError.value = "Incorrect input";
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

  _closeForm() {
    Get.back();
  }
}
