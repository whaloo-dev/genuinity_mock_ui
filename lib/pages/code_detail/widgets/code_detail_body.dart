import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/helpers/services.dart';

final controller = codeDetailController;

//TODO add actions : remove code, export code, test verification code.
class CodeDetailBody extends StatelessWidget {
  CodeDetailBody({
    Key? key,
  }) : super(key: key);

  final TextStyle? textStyleLabel = Get.theme.textTheme.subtitle2!
      .copyWith(color: colorScheme.onSurface.withOpacity(0.9), fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: kSpacing),
                _qrCodeWidget(context),
                _productField(context),
                _variantField(),
                _expirationDateField(),
                _descriptionField(),
                Expanded(child: _logField())
              ],
            ),
          ),
          const SizedBox(height: kSpacing * 2),
        ],
      ),
    );
  }

  Widget _qrCodeWidget(BuildContext context) {
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
      // ),
    );
  }

  Widget _productField(BuildContext context) {
    Product product = controller.code()!.variant.product;
    return ListTile(
      title: _readOnlyTextField(
        label: "Product",
        value: product.title,
        prefixIcon: _productPhotoWidget(product),
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
      leading: const Icon(Icons.call_split_rounded),
      title: _readOnlyTextField(
        label: "Product Variant",
        value: variant.title,
      ),
    );
  }

  Widget _expirationDateField() {
    if (controller.code()!.expirationDate == null) {
      return Container();
    }
    return ListTile(
      leading: const Icon(Icons.recycling_rounded),
      title: _readOnlyTextField(
        label: "Expires",
        value: dateFormat.format(controller.code()!.expirationDate!),
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
      title: _readOnlyTextField(
        label: "More Information",
        value: controller.code()!.description ?? "",
        keyboardType: TextInputType.multiline,
        minLines: null,
        maxLines: 3,
        canCopy: true,
      ),
    );
  }

  Widget _logField() {
    final code = controller.code()!;
    return ListTile(
      leading: const Icon(Icons.watch_later_outlined),
      title: Container(
        // padding: const EdgeInsets.only(top: kSpacing),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: kSpacing),
              child: DataTable2(
                decoration: BoxDecoration(
                  borderRadius: kBorderRadius,
                  border: Border.all(
                    color: colorScheme.outline.withOpacity(.8),
                  ),
                ),
                sortColumnIndex: 0,
                columnSpacing: 0,
                columns: const [
                  DataColumn2(label: Text("Date"), size: ColumnSize.S),
                  DataColumn2(label: Text("Event"), size: ColumnSize.M)
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text(
                      compactDateTimeFormat.format(code.creationDate),
                      style: const TextStyle(fontSize: 12),
                    )),
                    const DataCell(
                      Text(
                        "Code created",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ]),
                  ...List.generate(
                    10,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(
                          compactDateTimeFormat.format(code.creationDate),
                          style: const TextStyle(fontSize: 12),
                        )),
                        DataCell(
                          Text(
                            "Event $index",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: kSpacing,
              child: Container(
                color: colorScheme.background,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  "Logs",
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.outline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // title: _readOnlyTextField(
      //   label: "Logs",
      //   value: logs,
      //   keyboardType: TextInputType.multiline,
      //   minLines: null,
      //   maxLines: null,
      //   expands: true,
      //   canCopy: true,
      // ),
    );
  }

  Widget _readOnlyTextField({
    required String label,
    required String value,
    bool canCopy = false,
    Widget? prefixIcon,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    TextStyle? textStyle,
    int? minLines,
    int? maxLines,
    bool expands = false,
  }) {
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    });

    return Padding(
      padding: const EdgeInsets.only(top: kSpacing),
      child: TextField(
        textInputAction: textInputAction,
        focusNode: focusNode,
        controller: TextEditingController(text: value),
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        expands: expands,
        readOnly: true,
        style: textStyle,
        decoration: InputDecoration(
          // floatingLabelStyle: TextStyle(color: Colors.red),
          suffixIcon: canCopy
              ? IconButton(
                  splashRadius: kSplashRadius,
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    copyToClipBoard(value);
                  },
                )
              : null,
          label: Text(label),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
