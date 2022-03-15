import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var searchFieldController =
          textEditingController(text: productsController.searchText());

      return Column(
        children: [
          TextField(
            enableSuggestions: true,
            enabled: !productsController.isLoadingData(),
            onChanged: (value) {
              productsController.changeIsEditingSearch(true);
              productsController.changeSearchText(value);
            },
            onSubmitted: (value) {
              productsController.applyFilter();
            },
            controller: searchFieldController,
            decoration: InputDecoration(
              counter: (!productsController.isLoadingData() &&
                      !productsController.isEditingSearch() &&
                      productsController.isFiltered())
                  ? Wrap(
                      spacing: kSpacing,
                      runSpacing: kSpacing,
                      children: [
                        if (productsController.isInventorySizeRangeSet())
                          _inventoryRangeChip(),
                        if (productsController.sku().isNotEmpty) _skuChip(),
                        if (productsController.barcode().isNotEmpty)
                          _barcodeChip(),
                        if (productsController.productType().isNotEmpty)
                          _productTypeChip(),
                        if (productsController.vendor().isNotEmpty)
                          _vendorChip(),
                      ],
                    )
                  : null,
              label: const Text("Search by product title"),
              suffixIcon: _suffixWidget(searchFieldController),
            ),
          ),
        ],
      );
    });
  }

  Widget _inventoryRangeChip() {
    final inventoryRange = productsController.inventorySizeRange();
    final minInventory = productsController.minInventorySize();
    final maxInventory = productsController.maxInventorySize();
    return _chip(
      onDeleted: () {
        productsController.resetInventorySizeRange();
      },
      text: "Inventory ${inventoryRange.toText(minInventory, maxInventory)} ",
    );
  }

  Widget _skuChip() {
    final sku = productsController.sku();
    return _chip(
      onDeleted: () {
        productsController.resetSku();
      },
      text: "SKU = '$sku' ",
    );
  }

  Widget _barcodeChip() {
    final barcode = productsController.barcode();
    return _chip(
      onDeleted: () {
        productsController.resetBarcode();
      },
      text: "Barcode = '$barcode' ",
    );
  }

  Widget _vendorChip() {
    final vendor = productsController.vendor();
    return _chip(
      onDeleted: () {
        productsController.resetVendor();
      },
      text: "Vendor = '$vendor' ",
    );
  }

  Widget _productTypeChip() {
    final productType = productsController.productType();
    return _chip(
      onDeleted: () {
        productsController.resetProductType();
      },
      text: "Product Type = '$productType' ",
    );
  }

  Widget _chip({
    required void Function() onDeleted,
    required String text,
  }) {
    return Chip(
      elevation: kElevation,
      onDeleted: onDeleted,
      deleteIcon: const Icon(
        Icons.cancel,
        size: 14,
      ),
      label: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _suffixWidget(TextEditingController seachFieldController) {
    int productsCount = productsController.productsCount();
    bool showSearch = (productsController.isEditingSearch() ||
        !productsController.isFiltered());
    bool showResultsCount = !showSearch && !productsController.isLoadingData();
    bool showCancel =
        productsController.isFiltered() && !productsController.isLoadingData();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSearch)
          IconButton(
            splashRadius: kIconButtonSplashRadius,
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              productsController.applyFilter();
            },
          ),
        if (showResultsCount)
          Text(
            "${numberFormat.format(productsCount)} "
            "product${productsCount == 1 ? '' : 's'}",
            style: TextStyle(color: kLightGreyColor, fontSize: 12),
          ),
        if (showCancel)
          IconButton(
            splashRadius: kIconButtonSplashRadius,
            icon: const Icon(Icons.cancel_rounded),
            onPressed: () {
              productsController.resetFilters();
            },
          ),
        Visibility(
          visible: !productsController.isEditingSearch(),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            splashRadius: kIconButtonSplashRadius,
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
