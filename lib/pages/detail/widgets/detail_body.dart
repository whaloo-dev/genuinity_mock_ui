import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/code.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/helpers/services.dart';
import 'package:whaloo_genuinity/widgets/photo_widget.dart';

final controller = codeDetailController;

class DetailBody extends StatelessWidget {
  DetailBody({
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
    Code code = controller.code()!;
    return ListTile(
      title: Column(
        children: [
          _actionsWidget(),
          const SizedBox(height: kSpacing),
          Card(
            color: Colors.transparent,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: photoWidget(code.image, fixedSize: kLargeImage),
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
                    child: Text(" ${code.id.serial}"),
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
                    child: Text(" ${code.id.shortCode}"),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionsWidget() {
    Code code = controller.code()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: "Duplicate",
          splashRadius: kSplashRadius,
          icon: Icon(
            Icons.copy_rounded,
            color: Get.theme.hintColor,
          ),
          onPressed: () {
            codesCreationController.createFrom(code);
            navigationController.goBack();
          },
        ),
        IconButton(
          tooltip: "Delete",
          splashRadius: kSplashRadius,
          icon: Icon(
            Icons.delete_outline_rounded,
            color: Get.theme.hintColor,
          ),
          onPressed: () {
            codesController.deleteCode(code);
          },
        ),
        IconButton(
          tooltip: "Print",
          splashRadius: kSplashRadius,
          icon: Icon(
            Icons.print_outlined,
            color: Get.theme.hintColor,
          ),
          onPressed: () {
            codesController.printCode(code);
          },
        ),
      ],
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
            photoWidget(product.image),
            const SizedBox(width: kSpacing),
            Expanded(child: Text(product.title)),
          ]),
          Row(
            children: [
              childIndicator(),
              if (variant.image != null)
                photoWidget(variant.image!, fixedSize: kSmallImage),
              const SizedBox(width: kSpacing),
              Expanded(
                child: Column(
                  // alignment: WrapAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(variant.title),
                    // const SizedBox(width: kSpacing),
                    if (variant.sku.isNotEmpty)
                      Text(
                        "SKU : ${variant.sku}",
                        style: TextStyle(
                          color: Get.theme.hintColor,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
      if (code.exportDate != null)
        "${compactDateTimeFormat.format(code.creationDate)} Code exported",
      ...code.scans!.map(
        (codeScan) =>
            compactDateTimeFormat.format(codeScan.dateTime) +
            [
              " Code scanned",
              if (codeScan.isFailed) " (Scan failed)",
              if (!codeScan.isFailed) " (Scan succeed)",
            ].join(),
      ),
    ].join("\n");

    return _info(
      label: "Logs : ",
      toClipboard: toClipboard,
      info: Column(
        children: [
          _logLine(
            compactDateTimeFormat.format(code.creationDate),
            Row(children: const [
              Icon(Icons.add, size: 13),
              Text(
                " Code created",
                style: TextStyle(fontSize: 12),
              ),
            ]),
          ),
          if (code.exportDate != null)
            _logLine(
              compactDateTimeFormat.format(code.creationDate),
              Row(children: const [
                Icon(Icons.download_rounded, size: 13),
                Text(
                  " Code exported",
                  style: TextStyle(fontSize: 12),
                ),
              ]),
            ),
          ...code.scans!.map(
            (codeScan) => _logLine(
              compactDateTimeFormat.format(codeScan.dateTime),
              Row(
                children: [
                  if (codeScan.isFailed)
                    Icon(FontAwesomeIcons.exclamationCircle,
                        size: 12, color: kErrorColor),
                  if (!codeScan.isFailed)
                    const Icon(Icons.qr_code_scanner, size: 13),
                  const Text(
                    " Code scanned",
                    style: TextStyle(fontSize: 12),
                  ),
                  if (codeScan.isFailed)
                    Text(
                      " (Scan failed)",
                      style: TextStyle(fontSize: 12, color: kErrorColor),
                    ),
                  if (!codeScan.isFailed)
                    Text(
                      " (Scan succeed)",
                      style: TextStyle(fontSize: 12, color: kSuccessColor),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logLine(String header, Widget body) {
    return Container(
      margin: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: kSpacing),
          Expanded(
            child: body,
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
    final focusNode = FocusNode();
    return IconButton(
      focusNode: focusNode,
      icon: Icon(
        Icons.copy,
        size: 15,
        color: Get.theme.hintColor,
      ),
      splashRadius: kSplashRadius,
      onPressed: () {
        focusNode.requestFocus();
        copyToClipBoard(text);
      },
    );
  }
}
