import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var searchFieldController =
          textEditingController(text: productsController.productTitleFilter());
      return Padding(
        padding: const EdgeInsets.all(kSpacing * 2),
        child: Column(
          children: [
            TextField(
              enabled: !productsController.isLoadingData(),
              onChanged: (value) {
                productsController.changeProductTitleFilter(value);
              },
              onSubmitted: (value) {
                productsController.applyFilter();
              },
              controller: searchFieldController,
              decoration: InputDecoration(
                counter: (!productsController.isLoadingData() &&
                        !productsController.isEditingFilters() &&
                        productsController.isFiltered())
                    ? Wrap(
                        spacing: kSpacing,
                        runSpacing: kSpacing,
                        children: [
                          if (productsController
                              .isInventorySizeRangeFilterSet())
                            _inventoryRangeChip(),
                          if (productsController.isSkuFilterSet()) _skuChip(),
                          if (productsController.isBarcodeFilterSet())
                            _barcodeChip(),
                          if (productsController.isProductTypeFilterSet())
                            _productTypeChip(),
                          if (productsController.isVendorFilterSet())
                            _vendorChip(),
                          if (productsController.isStatusFilterSet())
                            ...ProductStatus.values
                                .where((status) =>
                                    productsController.statusFilter()[status] !=
                                    productsController
                                        .defaultStatusFilter(status))
                                .map((status) => _statusChip(status,
                                    productsController.statusFilter()[status]!))
                                .toList()
                        ],
                      )
                    : null,
                label: const Text("Search by product title"),
                suffixIcon: _suffixWidget(searchFieldController),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _inventoryRangeChip() {
    final inventoryRange = productsController.inventorySizeRangeFilter();
    final minInventory = productsController.minInventorySize();
    final maxInventory = productsController.maxInventorySize();
    return _chip(
      onDeleted: () {
        productsController.resetInventorySizeRangeFilter();
      },
      text: "Inventory ${inventoryRange.toText(minInventory, maxInventory)} ",
    );
  }

  Widget _skuChip() {
    final sku = productsController.skuFilter();
    return _chip(
      onDeleted: () {
        productsController.resetSkuFilter();
      },
      text: "SKU = '$sku' ",
    );
  }

  Widget _barcodeChip() {
    final barcode = productsController.barcodeFilter();
    return _chip(
      onDeleted: () {
        productsController.resetBarcodeFilter();
      },
      text: "Barcode = '$barcode' ",
    );
  }

  Widget _vendorChip() {
    final vendor = productsController.vendorFilter();
    return _chip(
      onDeleted: () {
        productsController.resetVendorFilter();
      },
      text: "Vendor = '$vendor' ",
    );
  }

  Widget _productTypeChip() {
    final productType = productsController.productTypeFilter();
    return _chip(
      onDeleted: () {
        productsController.resetProductTypeFilter();
      },
      text: "Product Type = '$productType' ",
    );
  }

  Widget _statusChip(ProductStatus status, bool enabled) {
    return _chip(
      onDeleted: () {
        productsController.resetStatusFilter(status: status);
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
    int productsCount = productsController.productsCount();
    bool showSearch = (productsController.isEditingFilters() ||
        !productsController.isFiltered());
    bool showResultsCount = !showSearch && !productsController.isLoadingData();
    bool showCancel =
        productsController.isFiltered() && !productsController.isLoadingData();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSearch)
          IconButton(
            splashRadius: kSplashRadius,
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              productsController.applyFilter();
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
              productsController.resetFilters();
            },
          ),
        Visibility(
          visible: !productsController.isEditingFilters(),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            splashRadius: kSplashRadius,
            icon: (productsController.isFormVisible())
                ? const Icon(Icons.arrow_drop_up_rounded)
                : const Icon(Icons.arrow_drop_down_rounded),
            onPressed: () {
              productsController
                  .changeIsFormVisible(!productsController.isFormVisible());
            },
          ),
        ),
      ],
    );
  }
}
