import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/extensions.dart';

class ProductsSearchForm extends StatelessWidget {
  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final maxInventory = productsController.maxInventorySize();
        final inventorySizeRange = productsController.inventorySizeRange.value;
        return Column(
          children: [
            SizedBox(height: kSpacing),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
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
                ),
                SizedBox(width: kSpacing),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kLightGreyColor)),
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
                ),
              ],
            ),
            SizedBox(height: kSpacing * 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacing),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 100,
                    child: Text("Inventory Size :\n "),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        RangeSlider(
                          divisions: maxInventory.toInt(),
                          activeColor: kActiveColor,
                          inactiveColor: kActiveColor.withOpacity(0.5),
                          labels: RangeLabels(
                            inventorySizeRange.start.toString(),
                            inventorySizeRange.end.toString(),
                          ),
                          min: 0,
                          max: maxInventory.toDouble(),
                          values: inventorySizeRange,
                          onChanged: (value) {
                            productsController.inventorySizeRange.value =
                                RangeValues(value.start.roundToDouble(),
                                    value.end.roundToDouble());
                            productsController.changeIsEditingSearch(true);
                          },
                        ),
                        Text(
                          inventorySizeRange.toText(),
                          style: TextStyle(
                            color: kLightGreyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4 * kSpacing),
          ],
        );
      }),
    );
  }
}
