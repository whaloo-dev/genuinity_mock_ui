import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class NewCodesForm extends StatelessWidget {
  final Product product;
  const NewCodesForm({
    Key? key,
    required this.product,
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
                  _bulkSizeField(),
                  if (product.variants.length > 1) _variantField(),
                  // _expirationDateField(),
                  // _styleField(),
                  // _tagsField(),

                  const SizedBox(height: kSpacing * 2),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpacing * 2),
          const Divider(thickness: 1),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _cancelButton(),
              const SizedBox(width: kSpacing),
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
        newCodesController.submit(product);
      },
      child: const Text("Create"),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        newCodesController.cancel();
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(kHeaderColor)),
      child: const Text("Cancel", style: TextStyle(color: kDarkColor)),
    );
  }

  Widget _productField(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Product : ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      title: Row(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: Responsiveness.isScreenSmall(context) ? 50 : 70,
              height: Responsiveness.isScreenSmall(context) ? 50 : 70,
              child: Image.network(
                product.image,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported_rounded,
                  color: kLightGreyColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: kSpacing),
          Expanded(
            child: Text(
              product.title,
              style: TextStyle(color: kDarkColor.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _variantField() {
    return ListTile(
      leading: const Icon(Icons.collections_rounded),
      title: Autocomplete<ProductVariant>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return Obx(
            () => TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                label: const Text("Product Variant"),
                errorText: newCodesController.variantFieldError(),
              ),
              onChanged: (newValue) {
                newCodesController.changeVariantText(newValue);
              },
            ),
          );
        },
        onSelected: (newValue) {
          newCodesController.changeVariant(newValue);
        },
        displayStringForOption: (variant) => variant.title,
        optionsBuilder: (textEditingValue) {
          var text = textEditingValue.text.trim().toUpperCase();
          return product.variants.where((variant) {
            final e = variant.title.trim().toUpperCase();
            return e.contains(text) && e.isNotEmpty;
          }).toList();
        },
      ),
    );
  }

  Widget _bulkSizeField() {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.layerGroup),
      title: TextField(
        controller: newCodesController.bulkSizeController(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          label: const Text("Bulk Size"),
          errorText: newCodesController.bulkSizeFieldError(),
        ),
      ),
    );
  }

  Widget _clearFieldWidget(void Function() handler) {
    return IconButton(
      splashRadius: kIconButtonSplashRadius,
      icon: const Icon(Icons.cancel_rounded),
      onPressed: () {
        handler();
      },
    );
  }
}
