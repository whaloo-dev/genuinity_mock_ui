import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/helpers/services.dart';

final controller = codeDetailController;

//TODO add actions : remove code, export code, test verification code.
//TODO add more information to variant like SKU
class CodeDetailBody extends StatelessWidget {
  CodeDetailBody({
    Key? key,
  }) : super(key: key);

  final TextStyle? textStyleLabel = Get.theme.textTheme.subtitle2!
      .copyWith(color: Get.theme.hintColor, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(height: kSpacing),
          _qrCodeWidget(),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: kSpacing),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _productField(),
                  _expirationDateField(),
                  _descriptionField(),
                  _logField()
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }

  Widget _qrCodeWidget() {
    double size = kLargeImage;
    Code code = controller.code()!;
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
                    child: Text(" ${code.shortCode}"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _productField() {
    ProductVariant variant = controller.code()!.variant;
    Product product = variant.product;
    return _info(
      label: "Product : ",
      info: Column(
        children: [
          Row(children: [
            _photoWidget(product.image),
            const SizedBox(width: kSpacing),
            Expanded(child: Text(product.title)),
          ]),
          if (product.variants.length > 1)
            Row(
              children: [
                SizedBox(
                  height: kSmallImage,
                  width: kSmallImage,
                  child: Column(children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: Container(),
                              shape: Border(
                                left: BorderSide(
                                  style: BorderStyle.solid,
                                  color: colorScheme.outline.withOpacity(0.5),
                                ),
                                bottom: BorderSide(
                                  style: BorderStyle.solid,
                                  color: colorScheme.outline.withOpacity(0.5),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container())
                  ]),
                ),
                if (variant.image != null) _photoWidget(variant.image!),
                const SizedBox(width: kSpacing),
                Text(variant.title),
              ],
            ),
        ],
      ),
    );
  }

  Widget _photoWidget(String image) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: kSmallImage,
        height: kSmallImage,
        child: Image.network(
          image,
          isAntiAlias: true,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.image_not_supported_rounded,
          ),
        ),
      ),
    );
  }

  Widget _expirationDateField() {
    if (controller.code()!.expirationDate == null) {
      return Container();
    }
    return _info(
      label: "Expires : ",
      info: Text(dateFormat.format(controller.code()!.expirationDate!)),
    );
  }

  Widget _descriptionField() {
    if (controller.code()!.description == null ||
        controller.code()!.description!.isEmpty) {
      return Container();
    }
    Text text = Text(
      controller.code()!.description!,
      style: const TextStyle(fontSize: 12),
    );
    return _info(
      label: "More Information : ",
      toClipboard: controller.code()!.description!,
      info: text,
    );
  }

  Widget _logField() {
    final code = controller.code()!;

    final toClipboard = [
      "${compactDateTimeFormat.format(code.creationDate)} Code created",
      ...List.generate(
        10,
        (index) =>
            "${compactDateTimeFormat.format(code.creationDate)} Event$index",
      )
    ].join("\n");

    return _info(
      label: "Logs : ",
      toClipboard: toClipboard,
      info: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                compactDateTimeFormat.format(code.creationDate),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: kSpacing),
              const Expanded(
                child: Text(
                  "Code created",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          ...List.generate(
            10,
            (index) => Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  compactDateTimeFormat.format(code.creationDate),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: kSpacing),
                Expanded(
                  child: Text(
                    "Event $index",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info({
    required String label,
    required Widget info,
    String? toClipboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: kSpacing),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: textStyleLabel,
              ),
            ),
            if (toClipboard != null) _copyButton(toClipboard),
          ],
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(top: kSpacing),
          child: Row(
            children: [
              const SizedBox(width: kSpacing),
              Expanded(child: info),
            ],
          ),
        ),
      ),
    );
  }

  Widget _copyButton(String text) {
    return IconButton(
      icon: Icon(
        Icons.copy,
        size: 15,
        color: Get.theme.hintColor,
      ),
      splashRadius: kSplashRadius,
      onPressed: () {
        copyToClipBoard(text);
      },
    );
  }
}
