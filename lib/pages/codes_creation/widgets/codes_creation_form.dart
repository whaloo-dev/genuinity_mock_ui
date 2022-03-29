import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/product_selector/product_selector.dart';
import 'package:whaloo_genuinity/widgets/selector.dart';
import 'package:whaloo_genuinity/widgets/widget_with_overlay.dart';

final controller = codesCreationController;

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
                  _codeStyleField(),
                  // TODO add _expirationDateField(),
                  const SizedBox(height: kSpacing),
                  _descriptionField(),
                  const SizedBox(height: kSpacing),
                  const SizedBox(height: kOptionsMaxHeight),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: kSpacing),
          _bulkSizeField(),
          const SizedBox(height: kSpacing * 2),
          const Divider(thickness: 1, height: kSpacing),
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
      showSelector = true;
      key.currentState?.updateOverlay();
    }

    hideOverlay() {
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

    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: ListTile(
        key: GlobalKey(),
        title: WidgetWithOverlay(
          key: key,
          shouldShowOverlay: () => showSelector,
          onClickOutside: hideOverlay,
          maxOverlayHeight: MediaQuery.of(context).size.height - 22 * kSpacing,
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
                      splashRadius: kSplashRadius,
                      onPressed: showOverlay,
                    ),
            ),
            readOnly: true,
            controller: controller.product() != null
                ? TextEditingController(text: controller.product()!.title)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: kSmallImage,
        height: kSmallImage,
        child: controller.product() == null
            ? Container()
            : Image.network(
                controller.product()!.image,
                key: GlobalKey(),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_not_supported_rounded,
                ),
              ),
      ),
    );
  }

  Widget _variantField() {
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: (controller.product() == null ||
              controller.product()!.variants.length <= 1)
          ? Container()
          : ListTile(
              leading: const Icon(Icons.call_split_outlined),
              title: Obx(
                () => Selector<ProductVariant>(
                  optionWidgetBuilder: (option) => Text(option.title),
                  value: controller.variant(),
                  fieldLabel: const Text("Product Variant"),
                  fieldErrorText: controller.variantFieldError(),
                  options: controller.product()!.variants,
                  onSelected: controller.changeVariant,
                  optionToString: (option) => option.title,
                ),
              ),
            ),
    );
  }

  Widget _codeStyleField() {
    if (controller.codeStyles().isEmpty) {
      return Container();
    }
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: controller.product() == null
          ? Container()
          : ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: Obx(
                () => Selector<CodeStyle>(
                  optionWidgetBuilder: _codeStyleOptionWidget,
                  value: controller.codeStyle(),
                  fieldLabel: const Text("Style"),
                  prefixIcon: controller.codeStyle() == null
                      ? null
                      : _codeStyleOptionWidget(
                          controller.codeStyle()!,
                          showText: false,
                        ),
                  options: controller.codeStyles(),
                  onSelected: controller.changeCodeStyle,
                  optionToString: (codeStyle) => "Style N°${codeStyle.id}",
                ),
              ),
            ),
    );
  }

  Widget _codeStyleOptionWidget(CodeStyle codeStyle,
      {bool showText = true, double size = kSmallImage}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: size,
            height: size,
            child: Image.asset("assets/demo/images/qrcode${codeStyle.id}.png"),
          ),
        ),
        if (showText) Text("Style N°${codeStyle.id}"),
      ],
    );
  }

  Widget _descriptionField() {
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: controller.product() == null
          ? Container()
          : ListTile(
              leading: const Icon(Icons.info_outlined),
              title: TextField(
                controller: controller.descriptionController(),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text("More Information"),
                ),
              ),
            ),
    );
  }

  Widget _bulkSizeField() {
    return ListTile(
      // leading: const Icon(Icons.copy_all_rounded),
      title: TextField(
        controller: controller.bulkSizeController(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          label: const Text("Number Of Copies"),
          errorText: controller.bulkSizeFieldError(),
        ),
      ),
    );
  }
}
