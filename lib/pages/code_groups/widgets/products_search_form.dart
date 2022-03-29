import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/helpers/localization.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

//TODO rework forms using TextEditingController
class ProductsSearchForm extends StatelessWidget {
  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final productType = productsController.productTypeFilter();
        final vendor = productsController.vendorFilter();
        final sku = productsController.skuFilter();
        final barcode = productsController.barcodeFilter();
        final status = productsController.statusFilter();
        return Column(
          children: [
            const SizedBox(height: kSpacing * 2),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _skuField(sku),
                    _barcodeField(barcode),
                    if (productsController.productTypes().length > 1)
                      _productTypeField(productType),
                    if (productsController.vendors().length > 1)
                      _vendorField(vendor),
                    _statusField(status),
                    _inventoryRangeField(),
                    const SizedBox(height: kOptionsMaxHeight),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: kSpacing * 2),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _resetButton(),
                _searchButton(),
              ],
            ),
            const SizedBox(height: kSpacing * 2),
          ],
        );
      }),
    );
  }

  Widget _searchButton() {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          productsController.applyFilter();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Search"),
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
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(colorScheme.secondaryContainer),
        ),
        onPressed: () {
          productsController.resetFilters();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset filters",
              style: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inventoryRangeField() {
    final maxInventory = productsController.maxInventorySize();
    final minInventory = productsController.minInventorySize();
    final inventorySizeRange = productsController.inventorySizeRangeFilter();
    if (maxInventory == minInventory) {
      return Container();
    }
    return ListTile(
      leading: const Icon(FontAwesomeIcons.boxes),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Inventory ${inventorySizeRange.toText(minInventory, maxInventory)}",
          ),
          RangeSlider(
            divisions: maxInventory - minInventory,
            labels: RangeLabels(
              numberFormat.format(inventorySizeRange.start),
              inventorySizeRange.end == productsController.maxInventorySize()
                  ? "∞"
                  : numberFormat.format(inventorySizeRange.end),
            ),
            min: minInventory.toDouble(),
            max: maxInventory.toDouble(),
            values: inventorySizeRange,
            onChanged: (value) {
              productsController.changeInventorySizeRangeFilter(RangeValues(
                  value.start.roundToDouble(), value.end.roundToDouble()));
            },
          ),
        ],
      ),
    );
  }

  Widget _skuField(String sku) {
    final TextEditingController controller = textEditingController(text: sku);
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
        controller: controller,
        onChanged: (value) {
          productsController.changeSkuFilter(value);
        },
        decoration: InputDecoration(
          label: const Text("SKU"),
          suffixIcon: sku.isNotEmpty
              ? _clearFieldWidget(() {
                  productsController.changeSkuFilter("");
                })
              : null,
        ),
      ),
    );
  }

  Widget _barcodeField(String barcode) {
    TextEditingController controller = textEditingController(text: barcode);
    return ListTile(
      leading: const Icon(FontAwesomeIcons.barcode),
      title: TextField(
        controller: controller,
        onChanged: (value) {
          productsController.changeBarcodeFilter(value);
        },
        decoration: InputDecoration(
          label: const Text("Barcode (ISBN, UPC, GTIN, etc.)"),
          suffixIcon: barcode.isNotEmpty
              ? _clearFieldWidget(() {
                  productsController.changeBarcodeFilter("");
                })
              : null,
        ),
      ),
    );
  }

  Widget _productTypeField(String productType) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.folder),
      title: Autocomplete<String>(
        optionsMaxHeight: kOptionsMaxHeight,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = productType;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (value) {
              if (value.trim().isEmpty) {
                productsController.changeProductTypeFilter(value);
              }
            },
            decoration: InputDecoration(
              label: const Text("Product Type"),
              suffixIcon: productType.isNotEmpty
                  ? _clearFieldWidget(() {
                      productsController.changeProductTypeFilter("");
                    })
                  : null,
            ),
          );
        },
        onSelected: (value) {
          productsController.changeProductTypeFilter(value);
        },
        optionsBuilder: (textEditingValue) {
          var text = textEditingValue.text.trim().toUpperCase();
          return productsController.productTypes().where((element) {
            final e = element.trim().toUpperCase();
            return e.contains(text) && e.isNotEmpty;
          }).toList()
            ..insert(0, " ");
        },
      ),
    );
  }

  Widget _vendorField(String vendor) {
    return ListTile(
      leading: const Icon(FontAwesomeIcons.store),
      title: Autocomplete<String>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = vendor;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (value) {
              if (value.trim().isEmpty) {
                productsController.changeVendorFilter(value);
              }
            },
            decoration: InputDecoration(
              label: const Text("Vendor"),
              suffixIcon: vendor.isNotEmpty
                  ? _clearFieldWidget(() {
                      productsController.changeVendorFilter("");
                    })
                  : null,
            ),
          );
        },
        onSelected: (value) {
          productsController.changeVendorFilter(value);
        },
        optionsBuilder: (textEditingValue) {
          var text = textEditingValue.text.trim().toUpperCase();
          return productsController.vendors().where((element) {
            final e = element.trim().toUpperCase();
            return e.contains(text) && e.isNotEmpty;
          }).toList()
            ..insert(0, " ");
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
          productsController.changeStatusFilter(status, newValue);
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
