import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';

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
                  _qrCodeWidget(context),
                  const SizedBox(height: kSpacing),
                  _productField(context),
                  const SizedBox(height: kSpacing),
                  _variantField(),
                  const SizedBox(height: kSpacing),
                  // TODO add creationdate,
                  // TODO add export data
                  // TODO add scanning info,
                  const SizedBox(height: kSpacing),
                  _expirationDateField(),
                  const SizedBox(height: kSpacing),
                  _descriptionField(),
                  const SizedBox(height: kSpacing),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1, height: kSpacing),
          const SizedBox(height: kSpacing * 2),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _closeButton(),
            ],
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
    Product product = controller.code()!.variant.product;
    if (product.variants.length == 1) {
      return Container();
    }
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

  Widget _expirationDateField() {
    if (controller.code()!.expirationDate == null) {
      return Container();
    }
    return ListTile(
      leading: const Icon(Icons.recycling_rounded),
      title: TextField(
        controller: TextEditingController(
            text: dateFormat.format(controller.code()!.expirationDate!)),
        decoration: const InputDecoration(
          label: Text("Expires"),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _descriptionField() {
    if (controller.code()!.description == null ||
        controller.code()!.description!.isEmpty) {
      return Container();
    }
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

  Widget _qrCodeWidget(BuildContext context) {
    double size = kLargeImage;
    Code code = controller.code()!;
    TextStyle? textStyleLabel = Theme.of(context).textTheme.subtitle2;
    return ListTile(
      title: Column(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: size,
              height: size,
              child: Image.asset(
                  "assets/demo/images/qrcode${code.codeStyle!.id}.png"),
            ),
          ),
          const SizedBox(height: kSpacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Serial Number :",
                      textAlign: TextAlign.right,
                      style: textStyleLabel,
                    ),
                  ),
                  Expanded(
                    child: Text(" ${code.serial}"),
                  ),
                ],
              ),
              const SizedBox(height: kSpacing),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Short Code :",
                      textAlign: TextAlign.right,
                      style: textStyleLabel,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      " ${code.shortCode}",
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _closeButton() {
    return ElevatedButton(
      onPressed: () {
        controller.close();
      },
      child: const Text("Close"),
    );
  }
}
