import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/widgets/selector.dart';

final controller = productSelectorController;

//TODO rework forms using TextEditingController
class ProductsSearchForm extends StatelessWidget {
  final kOptionsMaxHeight = 200.0;

  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final productType = controller.productTypeFilter();
      final vendor = controller.vendorFilter();
      final sku = controller.skuFilter();
      // final barcode = controller.barcodeFilter();
      final status = controller.statusFilter();
      return Column(
        children: [
          const SizedBox(height: kSpacing * 2),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _skuField(sku),
                  //TODO _barcodeField(barcode),
                  if (controller.productTypes().length > 1)
                    _productTypeField(productType),
                  if (controller.vendors().length > 1) _vendorField(vendor),
                  _statusField(status),
                  //TODO _inventoryRangeField(),
                  SizedBox(height: kOptionsMaxHeight),
                ],
              ),
            ),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: kSpacing),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (productSelectorController.isFiltered()) _resetButton(),
              _searchButton(),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
          const SizedBox(height: kSpacing),
        ],
      );
    });
  }

  Widget _searchButton() {
    return SizedBox(
      width: 150,
      child: TextButton(
        onPressed: () {
          controller.applyFilter();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("SEARCH"),
            SizedBox(width: kSpacing),
            Icon(Icons.search_rounded),
          ],
        ),
      ),
    );
  }

  Widget _resetButton() {
    return SizedBox(
      width: 150,
      child: TextButton(
        onPressed: () {
          controller.resetFilters();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("CANCEL"),
          ],
        ),
      ),
    );
  }

  // Widget _inventoryRangeField() {
  //   final maxInventory = controller.maxInventorySize();
  //   final minInventory = controller.minInventorySize();
  //   final inventorySizeRange = controller.inventorySizeRangeFilter();
  //   if (maxInventory == minInventory) {
  //     return Container();
  //   }
  //   return ListTile(
  //     leading: const Icon(FontAwesomeIcons.boxes),
  //     title: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Inventory ${inventorySizeRange.toText(minInventory, maxInventory)}",
  //         ),
  //         RangeSlider(
  //           divisions: maxInventory - minInventory,
  //           labels: RangeLabels(
  //             numberFormat.format(inventorySizeRange.start),
  //             inventorySizeRange.end == controller.maxInventorySize()
  //                 ? "∞"
  //                 : numberFormat.format(inventorySizeRange.end),
  //           ),
  //           min: minInventory.toDouble(),
  //           max: maxInventory.toDouble(),
  //           values: inventorySizeRange,
  //           onChanged: (value) {
  //             controller.changeInventorySizeRangeFilter(RangeValues(
  //                 value.start.roundToDouble(), value.end.roundToDouble()));
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _skuField(String sku) {
    final TextEditingController textController =
        textEditingController(text: sku);
    return ListTile(
      leading: Stack(
        children: [
          const Icon(FontAwesomeIcons.fingerprint),
          Positioned(
            right: 3,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              color: colorScheme.surface,
              child: const Text(
                "SKU",
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      title: TextField(
        controller: textController,
        onChanged: (value) {
          controller.changeSkuFilter(value);
        },
        decoration: InputDecoration(
          label: const Text("SKU"),
          suffixIcon: sku.isNotEmpty
              ? _clearFieldWidget(() {
                  controller.changeSkuFilter("");
                })
              : null,
        ),
      ),
    );
  }

  // Widget _barcodeField(String barcode) {
  //   TextEditingController textController = textEditingController(text: barcode);
  //   return ListTile(
  //     leading: const Icon(FontAwesomeIcons.barcode),
  //     title: TextField(
  //       controller: textController,
  //       onChanged: (value) {
  //         controller.changeBarcodeFilter(value);
  //       },
  //       decoration: InputDecoration(
  //         label: const Text("Barcode (ISBN, UPC, GTIN, etc.)"),
  //         suffixIcon: barcode.isNotEmpty
  //             ? _clearFieldWidget(() {
  //                 controller.changeBarcodeFilter("");
  //               })
  //             : null,
  //       ),
  //     ),
  //   );
  // }

  Widget _productTypeField(String productType) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.folder),
      title: Selector<String>(
        value: productType,
        fieldLabel: const Text("Product Type"),
        options: controller.productTypes(),
        onSelected: (value) {
          controller.changeProductTypeFilter(value);
        },
      ),
    );
  }

  Widget _vendorField(String vendor) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.store),
      title: Selector<String>(
        value: vendor,
        fieldLabel: const Text("Vendor"),
        options: controller.vendors(),
        onSelected: (value) {
          controller.changeVendorFilter(value);
        },
      ),
    );
  }

  Widget _statusField(Map<ProductStatus, bool> statusFilter) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.eye),
      title: Wrap(
        children: ProductStatus.values
            .map((status) => _statusChip(status, statusFilter[status]!))
            .toList(),
      ),
    );
  }

  Widget _statusChip(ProductStatus status, bool selected) {
    return Container(
      margin: const EdgeInsets.all(kSpacing),
      child: ChoiceChip(
        pressElevation: kElevation,
        selected: selected,
        backgroundColor: status.color().withOpacity(0.5),
        selectedColor: status.color(),
        onSelected: (newValue) {
          controller.changeStatusFilter(status, newValue);
        },
        label: Text(
          status.name(),
          style: TextStyle(
            color:
                selected ? status.onColor() : status.onColor().withOpacity(0.5),
            fontSize: 12,
            decoration: selected ? null : TextDecoration.lineThrough,
          ),
        ),
        avatar: selected
            ? Icon(
                FontAwesomeIcons.check,
                size: 10,
                color: status.onColor(),
              )
            : null,
      ),
    );
  }

  Widget _clearFieldWidget(void Function() handler) {
    return IconButton(
      splashRadius: kSplashRadius,
      icon: const Icon(Icons.cancel_rounded),
      onPressed: () {
        handler();
      },
    );
  }
}
