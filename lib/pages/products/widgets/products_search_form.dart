import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsSearchForm extends StatelessWidget {
  final kOptionsMaxHeight = 200.0;

  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Obx(() {
          final productType = productsController.productType();
          final vendor = productsController.vendor();
          final sku = productsController.sku();
          final barcode = productsController.barcode();
          return Column(
            children: [
              SizedBox(height: kSpacing * 2),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _searchButton(),
                  SizedBox(width: kSpacing),
                  _resetButton(),
                ],
              ),
              SizedBox(height: kSpacing * 2),
              const Divider(thickness: 1),
              _inventoryRangeField(),
              _skuField(sku),
              _barcodeField(barcode),
              if (productsController.vendors().length > 1) _vendorField(vendor),
              if (productsController.productTypes().length > 1)
                _productTypeField(productType),
              SizedBox(height: kOptionsMaxHeight),
            ],
          );
        }),
      ),
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
          children: [
            const Text("Search"),
            SizedBox(width: kSpacing),
            const Icon(Icons.search_rounded),
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
            backgroundColor: MaterialStateProperty.all(kLightGreyColor)),
        onPressed: () {
          productsController.resetFilters();
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Reset filters"),
            SizedBox(width: kSpacing),
            const Icon(Icons.cancel_rounded),
          ],
        ),
      ),
    );
  }

  Widget _inventoryRangeField() {
    final maxInventory = productsController.maxInventorySize();
    final minInventory = productsController.minInventorySize();
    final inventorySizeRange = productsController.inventorySizeRange();
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Inventory ${inventorySizeRange.toText(minInventory, maxInventory)}",
            style: TextStyle(
              color: kLightGreyColor,
            ),
          ),
          RangeSlider(
            divisions: maxInventory - minInventory,
            activeColor: kActiveColor,
            inactiveColor: kActiveColor.withOpacity(0.5),
            labels: RangeLabels(
              numberFormat.format(inventorySizeRange.start),
              numberFormat.format(inventorySizeRange.end),
            ),
            min: minInventory.toDouble(),
            max: maxInventory.toDouble(),
            values: inventorySizeRange,
            onChanged: (value) {
              productsController.changeInventorySizeRange(RangeValues(
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
      title: TextField(
        controller: controller,
        onChanged: (value) {
          productsController.changeSku(value);
        },
        decoration: InputDecoration(
          label: const Text("SKU"),
          suffixIcon: sku.isNotEmpty
              ? _clearTextFieldWidget(() {
                  productsController.changeSku("");
                })
              : null,
        ),
      ),
    );
  }

  Widget _barcodeField(String barcode) {
    TextEditingController controller = textEditingController(text: barcode);
    return ListTile(
      title: TextField(
        controller: controller,
        onChanged: (value) {
          productsController.changeBarcode(value);
        },
        decoration: InputDecoration(
          label: const Text("Barcode (ISBN, UPC, GTIN, etc.)"),
          suffixIcon: barcode.isNotEmpty
              ? _clearTextFieldWidget(() {
                  productsController.changeBarcode("");
                })
              : null,
        ),
      ),
    );
  }

  Widget _productTypeField(String productType) {
    return ListTile(
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
                productsController.changeProductType(value);
              }
            },
            decoration: InputDecoration(
              label: const Text("Product Type"),
              suffixIcon: productType.isNotEmpty
                  ? _clearTextFieldWidget(() {
                      productsController.changeProductType("");
                    })
                  : null,
            ),
          );
        },
        onSelected: (value) {
          productsController.changeProductType(value);
        },
        optionsBuilder: (textEditingValue) {
          var text = textEditingValue.text.trim().toUpperCase();
          return productsController
              .productTypes()
              .where((element) => element.trim().toUpperCase().contains(text))
              .toList()
            ..insert(0, "");
        },
      ),
    );
  }

  Widget _vendorField(String vendor) {
    return ListTile(
      title: Autocomplete<String>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = vendor;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (value) {
              if (value.trim().isEmpty) {
                productsController.changeVendor(value);
              }
            },
            decoration: InputDecoration(
              label: const Text("Vendor"),
              suffixIcon: vendor.isNotEmpty
                  ? _clearTextFieldWidget(() {
                      productsController.changeVendor("");
                    })
                  : null,
            ),
          );
        },
        onSelected: (value) {
          productsController.changeVendor(value);
        },
        optionsBuilder: (textEditingValue) {
          var text = textEditingValue.text.trim().toUpperCase();
          return productsController
              .vendors()
              .where((element) => element.trim().toUpperCase().contains(text))
              .toList()
            ..insert(0, "");
        },
      ),
    );
  }

  Widget _clearTextFieldWidget(void Function() handler) {
    return IconButton(
      splashRadius: kIconButtonSplashRadius,
      icon: const Icon(Icons.cancel_rounded),
      onPressed: () {
        handler();
      },
    );
  }
}
