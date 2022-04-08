import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/pages/product_selector/product_selector.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';
import 'package:whaloo_genuinity/widgets/selector.dart';
import 'package:whaloo_genuinity/widgets/widget_with_overlay.dart';

final controller = codesCreationController;

class CreationForm extends StatelessWidget {
  const CreationForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  _productField(),
                  const SizedBox(height: kSpacing),
                  _variantField(),
                  const SizedBox(height: kSpacing),
                  _codeStyleField(),
                  //TODO Activate this when you add expiration date featue
                  //const SizedBox(height: kSpacing),
                  //_expirationDateField(context),
                  const SizedBox(height: kSpacing),
                  _descriptionField(),
                  const SizedBox(height: kOptionsMaxHeight),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: kSpacing),
          _bulkSizeField(),
          const SizedBox(height: kSpacing),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: kSpacing * 2),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _cancelButton(),
              const SizedBox(width: kSpacing),
              _submitButton(),
              const SizedBox(width: kSpacing * 2),
            ],
          ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return TextButton(
      onPressed: () {
        controller.submit();
      },
      child: const Text("OK"),
    );
  }

  Widget _cancelButton() {
    return TextButton(
      onPressed: () {
        controller.cancel();
      },
      child: const Text("CANCEL"),
    );
  }

  Widget _productField() {
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
          maxOverlayHeight: Get.mediaQuery.size.height - 22 * kSpacing,
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
              prefixIcon: photoWidget(controller.product()?.image),
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

  Widget _variantField() {
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: (controller.product() == null)
          ? Container()
          : ListTile(
              leading: childIndicator(),
              title: Obx(
                () => Selector<ProductVariant>(
                    optionLeadingBuilder: (option) => option.image != null
                        ? photoWidget(option.image, fixedSize: kSmallImage)
                        : null,
                    optionTitleBuilder: (option) => Row(
                          children: [
                            const SizedBox(width: kSpacing),
                            Flexible(
                              child: Text(option.title),
                            ),
                          ],
                        ),
                    optionSubtitleBuilder: (option) {
                      if (option.sku.isEmpty) {
                        return null;
                      }
                      return Row(
                        children: [
                          const SizedBox(width: kSpacing),
                          Flexible(
                            child: Text(
                              "SKU : ${option.sku}",
                              style: TextStyle(
                                color: Get.theme.hintColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    value: controller.variant(),
                    prefixIcon: controller.variant()?.image != null
                        ? photoWidget(controller.variant()?.image,
                            fixedSize: kSmallImage)
                        : null,
                    fieldLabel: const Text("Variant"),
                    fieldErrorText: controller.variantFieldError(),
                    options: controller.product()!.variants,
                    onSelected: controller.changeVariant,
                    optionToString: (option) {
                      return option.title;
                    }),
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
                  optionTitleBuilder: _codeStyleOptionWidget,
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
          child: photoWidget(codeStyle.image, fixedSize: kSmallImage),
        ),
        if (showText) Text("Style N°${codeStyle.id}"),
      ],
    );
  }

  // Widget _expirationDateField(BuildContext context) {
  //   selectDate() {
  //     showDatePicker(
  //       context: context,
  //       initialDate: controller.expirationDate() ??
  //           DateTime.now().add(const Duration(days: 30)),
  //       firstDate: DateTime.now().add(const Duration(days: 30)),
  //       lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
  //     ).then((newExpirationDate) =>
  //         controller.changeExpirationDate(newExpirationDate));
  //   }

  //   return AnimatedSwitcher(
  //     duration: kAnimationDuration,
  //     child: controller.product() == null
  //         ? Container()
  //         : ListTile(
  //             leading: const Icon(Icons.recycling_rounded),
  //             title: TextField(
  //               readOnly: true,
  //               onTap: selectDate,
  //               keyboardType: TextInputType.datetime,
  //               controller: controller.expirationDate() == null
  //                   ? TextEditingController()
  //                   : TextEditingController(
  //                       text: dateFormat.format(controller.expirationDate()!)),
  //               decoration: InputDecoration(
  //                 label: const Text("Expiration Date (Optional)"),
  //                 errorText: controller.expirationDateError(),
  //                 suffixIcon: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     if (controller.expirationDate() != null)
  //                       IconButton(
  //                           onPressed: () {
  //                             controller.changeExpirationDate(null);
  //                           },
  //                           icon: const Icon(Icons.cancel_rounded)),
  //                     IconButton(
  //                         onPressed: selectDate,
  //                         icon: const Icon(Icons.calendar_month_rounded)),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //   );
  // }

  Widget _descriptionField() {
    final descController = controller.descriptionController();
    return AnimatedSwitcher(
      duration: kAnimationDuration,
      child: controller.product() == null
          ? Container()
          : ListTile(
              leading: const Icon(Icons.info_outlined),
              title: TextField(
                textInputAction: TextInputAction.newline,
                controller: descController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text("More Information (Optional)"),
                ),
              ),
            ),
    );
  }

  Widget _bulkSizeField() {
    return ListTile(
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
