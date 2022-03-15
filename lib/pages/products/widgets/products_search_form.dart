import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/custom.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsSearchForm extends StatelessWidget {
  const ProductsSearchForm({Key? key}) : super(key: key);

  final kOptionsMaxHeight = 200.0;

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
              SizedBox(height: kSpacing * 2),
              _inventoryRangeField(context),
              SizedBox(height: kSpacing),
              _skuField(context, sku),
              SizedBox(height: kSpacing),
              _barcodeField(context, barcode),
              SizedBox(height: kSpacing),
              _vendorField(context, vendor),
              SizedBox(height: kSpacing),
              _productTypeField(context, productType),
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

  Widget _inventoryRangeField(BuildContext context) {
    final maxInventory = productsController.maxInventorySize();
    final minInventory = productsController.minInventorySize();
    final inventorySizeRange = productsController.inventorySizeRange();
    return ListTile(
      // padding: EdgeInsets.symmetric(horizontal: kSpacing),
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
              productsController.changeIsEditingSearch(true);
            },
          ),
        ],
      ),
    );
  }

  Widget _skuField(BuildContext context, String sku) {
    final TextEditingController controller = textEditingController(text: sku);
    return ListTile(
      // padding: EdgeInsets.symmetric(horizontal: kSpacing),
      title: TextField(
        controller: controller,
        onChanged: (value) {
          productsController.changeSku(value);
          productsController.changeIsEditingSearch(true);
        },
        decoration: const InputDecoration(
          label: Text("SKU"),
        ),
      ),
    );
  }

  Widget _barcodeField(BuildContext context, String barcode) {
    TextEditingController controller = textEditingController(text: barcode);
    //to counter cursor reset due to obx refresh
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return ListTile(
      // padding: EdgeInsets.symmetric(horizontal: kSpacing),
      title: TextField(
        controller: controller,
        onChanged: (value) {
          productsController.changeBarcode(value);
          productsController.changeIsEditingSearch(true);
        },
        decoration: const InputDecoration(
          label: Text("Barcode (ISBN, UPC, GTIN, etc.)"),
        ),
      ),
    );
  }

  Widget _productTypeField(BuildContext context, String productType) {
    return ListTile(
      // padding: EdgeInsets.symmetric(horizontal: kSpacing),
      title: Autocomplete<String>(
        optionsMaxHeight: kOptionsMaxHeight,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = productType;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              label: Text("Product Type"),
            ),
          );
        },
        onSelected: (value) {
          productsController.changeProductType(value);
          productsController.changeIsEditingSearch(true);
        },
        optionsBuilder: (textEditingValue) {
          return productsController
              .productTypes()
              .where((element) => element.contains(textEditingValue.text));
        },
      ),
    );
  }

  Widget _vendorField(BuildContext context, String vendor) {
    return ListTile(
      // padding: EdgeInsets.symmetric(horizontal: kSpacing),
      title: Autocomplete<String>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = vendor;
          return TextField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: const InputDecoration(
              label: Text("Vendor"),
            ),
          );
        },
        onSelected: (value) {
          productsController.changeVendor(value);
          productsController.changeIsEditingSearch(true);
        },
        optionsBuilder: (textEditingValue) {
          return productsController.vendors().where((element) => element
              .tokenize()
              .startsWithAll(textEditingValue.text.tokenize()));
        },
      ),
    );
  }
}
