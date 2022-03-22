import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/widgets/whaloo_autocomplet.dart';

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
        newCodesController.submit();
      },
      child: const Text("Create"),
    );
  }

  Widget _cancelButton() {
    return ElevatedButton(
      onPressed: () {
        newCodesController.cancel();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          colorScheme.secondaryContainer,
        ),
      ),
      child: Text("Cancel",
          style: TextStyle(
            color: colorScheme.onSecondaryContainer,
          )),
    );
  }

  Widget _productField(BuildContext context) {
    if (newCodesController.isProductPreset()) {
      return _productReadOnlyField(context);
    }
    return _productModifiableField(context);
  }

  Widget _productReadOnlyField(BuildContext context) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          prefixIcon: _productPhotoWidget(context),
          label: const Text("Product"),
        ),
        readOnly: true,
        controller:
            TextEditingController(text: newCodesController.product()!.title),
      ),
    );
  }

  Widget _productModifiableField(BuildContext context) {
    //TODO product field
    return Container();
  }

  Widget _productPhotoWidget(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: Responsiveness.isScreenSmall(context) ? 50 : 70,
        height: Responsiveness.isScreenSmall(context) ? 50 : 70,
        child: Image.network(
          newCodesController.product()!.image,
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
    if (newCodesController.product() != null &&
        newCodesController.product()!.variants.length > 1) {
      return ListTile(
        leading: const Icon(Icons.collections_rounded),
        title: Obx(
          () => WhalooAutoComplete<String>(
            label: const Text("Product Variant"),
            errorText: newCodesController.variantFieldError(),
            focusNode: focusNode,
            textEditingController: textEditingController,
            optionsBuilder: (TextEditingValue textEditingValue) {
              var text = textEditingValue.text.trim().toUpperCase();
              return newCodesController
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
              newCodesController.changeVariantText(newValue);
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _bulkSizeField() {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.layerGroup),
      title: TextField(
        controller: newCodesController.bulkSizeController(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          label: const Text("Number of codes to create"),
          errorText: newCodesController.bulkSizeFieldError(),
        ),
      ),
    );
  }
}
