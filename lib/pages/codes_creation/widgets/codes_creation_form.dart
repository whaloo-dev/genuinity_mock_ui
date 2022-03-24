import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/product_selector/product_selector.dart';
import 'package:whaloo_genuinity/widgets/whaloo_autocomplet.dart';
import 'package:whaloo_genuinity/widgets/widget_with_overlay.dart';

final controller = newCodesController;

class CodesCreationForm extends StatelessWidget {
  const CodesCreationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: kSpacing * 3),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _productField(context),
                  const SizedBox(height: kSpacing),
                  _variantField(),
                  const SizedBox(height: kSpacing),
                  _bulkSizeField(),
                  // _expirationDateField(),
                  // _styleField(),
                  // _tagsField(),
                  const SizedBox(height: kSpacing * 10),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: kSpacing * 2),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cancelButton(),
              _submitButton(),
            ],
          ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        controller.submit();
      },
      child: const Text("Create"),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        controller.cancel();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          colorScheme.secondaryContainer,
        ),
      ),
      child: Text(
        "Cancel",
        style: TextStyle(
          color: colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }

  Widget _productField(BuildContext context) {
    var showSelector = false;
    var key = GlobalKey<WidgetWithOverlayState>();

    showOverlay() {
      print("show");

      showSelector = true;
      key.currentState?.updateOverlay();
    }

    hideOverlay() {
      print("hide");

      showSelector = false;
      key.currentState?.updateOverlay();
    }

    final FocusNode focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
        showOverlay();
      }
    });

    return ListTile(
      title: WidgetWithOverlay(
        key: key,
        shouldShowOverlay: () => showSelector,
        clickOutsideCallback: hideOverlay,
        maxOverlayHeight: MediaQuery.of(context).size.height - 22 * kSpacing,
        outsiedColor: colorScheme.shadow.withOpacity(0.1),
        overlay: ProductsSelector(
          onSelected: (selectedProduct) {
            controller.changeProduct(selectedProduct);
            hideOverlay();
          },
          onCancel: hideOverlay,
        ),
        child: TextField(
            focusNode: controller.isProductPreset() ? null : focusNode,
            decoration: InputDecoration(
              prefixIcon: _productPhotoWidget(context),
              label: const Text("Product"),
              errorText: controller.productFieldError(),
              suffixIcon: controller.isProductPreset()
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      onPressed: showOverlay,
                    ),
            ),
            readOnly: true,
            controller: controller.product() != null
                ? TextEditingController(text: controller.product()!.title)
                : null),
      ),
    );
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 50,
        height: 50,
        child: controller.product() == null
            ? Container()
            : Image.network(
                controller.product()!.image,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported_rounded,
                ),
              ),
      ),
    );
  }

  Widget _variantField() {
    final focusNode = FocusNode();
    final textEditingController = TextEditingController();
    if (controller.product() == null ||
        controller.product()!.variants.length <= 1) {
      return Container();
    }
    return ListTile(
      leading: const Icon(Icons.collections_rounded),
      title: Obx(
        () => WhalooAutoComplete<String>(
          label: const Text("Product Variant"),
          errorText: controller.variantFieldError(),
          focusNode: focusNode,
          textEditingController: textEditingController,
          optionsBuilder: (TextEditingValue textEditingValue) {
            var text = textEditingValue.text.trim().toUpperCase();
            return controller
                .product()!
                .variants
                .where((variant) {
                  final e = variant.title.trim().toUpperCase();
                  return e.contains(text) && e.isNotEmpty;
                })
                .map((e) => e.title)
                .toList();
          },
          onSelected: (newValue) {
            controller.changeVariantText(newValue);
          },
        ),
      ),
    );
  }

  Widget _bulkSizeField() {
    if (controller.product() == null) {
      return Container();
    }
    return ListTile(
      leading: const Icon(FontAwesomeIcons.layerGroup),
      title: TextField(
        controller: controller.bulkSizeController(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          label: const Text("Number of codes to create"),
          errorText: controller.bulkSizeFieldError(),
        ),
      ),
    );
  }
}
