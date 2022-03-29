import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

final controller = codeDetailController;

class CodeDetailBody extends StatelessWidget {
  const CodeDetailBody({
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
                  //TODO add QR code widget here
                  _productField(context),
                  const SizedBox(height: kSpacing),
                  _variantField(),
                  const SizedBox(height: kSpacing),
                  // TODO add creationdate,
                  // TODO add expirationDateField(),
                  // TODO add export data
                  // TODO add scanning info,

                  const SizedBox(height: kSpacing),
                  _descriptionField(),
                  const SizedBox(height: kSpacing),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }

  Widget _productField(BuildContext context) {
    Product product = controller.code()!.variant.product;

    return ListTile(
      key: GlobalKey(),
      title: TextField(
        controller: TextEditingController(text: product.title),
        decoration: InputDecoration(
          prefixIcon: _productPhotoWidget(product),
          label: const Text("Product"),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _productPhotoWidget(Product product) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: kSmallImage,
        height: kSmallImage,
        child: Image.network(
          product.image,
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
    ProductVariant variant = controller.code()!.variant;

    return ListTile(
      leading: const Icon(Icons.call_split_outlined),
      title: TextField(
        controller: TextEditingController(text: variant.title),
        decoration: const InputDecoration(
          label: Text("Product Variant"),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _descriptionField() {
    return ListTile(
      leading: const Icon(Icons.info_outlined),
      title: TextField(
        controller:
            TextEditingController(text: controller.code()!.description ?? ""),
        keyboardType: TextInputType.multiline,
        minLines: 3,
        maxLines: null,
        readOnly: true,
        decoration: const InputDecoration(
          label: Text("More Information"),
        ),
      ),
    );
  }
}
