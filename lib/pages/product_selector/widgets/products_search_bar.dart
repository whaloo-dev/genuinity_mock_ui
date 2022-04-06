import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

final controller = productSelectorController;

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacing * 2),
      child: Obx(() {
        var searchFieldController =
            textEditingController(text: controller.productTitleFilter());

        return Column(
          children: [
            TextField(
              enableSuggestions: true,
              enabled: !controller.isLoadingData(),
              onChanged: (value) {
                controller.changeProductTitleFilter(value);
              },
              onSubmitted: (value) {
                controller.applyFilter();
              },
              controller: searchFieldController,
              decoration: InputDecoration(
                counter: (!controller.isLoadingData() &&
                        !controller.isEditingFilters() &&
                        controller.isFiltered())
                    ? Wrap(
                        spacing: kSpacing,
                        runSpacing: kSpacing,
                        children: [
                          if (controller.isInventorySizeRangeFilterSet())
                            _inventoryRangeChip(),
                          if (controller.isSkuFilterSet()) _skuChip(),
                          if (controller.isBarcodeFilterSet()) _barcodeChip(),
                          if (controller.isProductTypeFilterSet())
                            _productTypeChip(),
                          if (controller.isVendorFilterSet()) _vendorChip(),
                          if (controller.isStatusFilterSet())
                            ...ProductStatus.values
                                .where((status) =>
                                    controller.statusFilter()[status] !=
                                    controller.defaultStatusFilter(status))
                                .map((status) => _statusChip(
                                    status, controller.statusFilter()[status]!))
                                .toList()
                        ],
                      )
                    : null,
                label: const Text("Search by product title"),
                suffixIcon: _suffixWidget(searchFieldController),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _inventoryRangeChip() {
    final inventoryRange = controller.inventorySizeRangeFilter();
    final minInventory = controller.minInventorySize();
    final maxInventory = controller.maxInventorySize();
    return _chip(
      onDeleted: () {
        controller.resetInventorySizeRangeFilter();
      },
      text: "Inventory ${inventoryRange.toText(minInventory, maxInventory)} ",
    );
  }

  Widget _skuChip() {
    final sku = controller.skuFilter();
    return _chip(
      onDeleted: () {
        controller.resetSkuFilter();
      },
      text: "SKU = '$sku' ",
    );
  }

  Widget _barcodeChip() {
    final barcode = controller.barcodeFilter();
    return _chip(
      onDeleted: () {
        controller.resetBarcodeFilter();
      },
      text: "Barcode = '$barcode' ",
    );
  }

  Widget _vendorChip() {
    final vendor = controller.vendorFilter();
    return _chip(
      onDeleted: () {
        controller.resetVendorFilter();
      },
      text: "Vendor = '$vendor' ",
    );
  }

  Widget _productTypeChip() {
    final productType = controller.productTypeFilter();
    return _chip(
      onDeleted: () {
        controller.resetProductTypeFilter();
      },
      text: "Product Type = '$productType' ",
    );
  }

  Widget _statusChip(ProductStatus status, bool enabled) {
    return _chip(
      onDeleted: () {
        controller.resetStatusFilter(status: status);
      },
      text: status.name(),
      textDecoration: enabled ? null : TextDecoration.lineThrough,
    );
  }

  Widget _chip({
    required void Function() onDeleted,
    required String text,
    TextDecoration? textDecoration,
    Color? textColor,
    Color? backgroundColor,
  }) {
    return Chip(
      backgroundColor: backgroundColor,
      elevation: kElevation,
      onDeleted: onDeleted,
      deleteIcon: const Icon(
        Icons.cancel,
        size: 14,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          decoration: textDecoration,
        ),
      ),
    );
  }

  Widget _suffixWidget(TextEditingController seachFieldController) {
    int productsCount = controller.productsCount();
    bool showSearch =
        (controller.isEditingFilters() || !controller.isFiltered());
    bool showResultsCount = !showSearch && !controller.isLoadingData();
    bool showCancel = controller.isFiltered() && !controller.isLoadingData();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSearch)
          IconButton(
            splashRadius: kSplashRadius,
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              controller.applyFilter();
            },
          ),
        if (showResultsCount)
          Text(
            "${numberFormat.format(productsCount)} "
            "product${productsCount == 1 ? '' : 's'}",
            style: const TextStyle(fontSize: 12),
          ),
        if (showCancel)
          IconButton(
            splashRadius: kSplashRadius,
            icon: const Icon(Icons.cancel_rounded),
            onPressed: () {
              controller.resetFilters();
            },
          ),
        Visibility(
          visible: !controller.isEditingFilters(),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            splashRadius: kSplashRadius,
            icon: Icon(controller.isFormVisible()
                ? Icons.filter_alt_rounded
                : Icons.filter_alt_outlined),
            onPressed: () {
              controller.changeIsFormVisible(!controller.isFormVisible());
            },
          ),
        ),
      ],
    );
  }
}
