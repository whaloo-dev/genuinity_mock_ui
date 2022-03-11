import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsSearchForm extends StatelessWidget {
  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final maxInventory = productsController.maxInventorySize.value;
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
                  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        const Text("Inventory Size :"),
                        Text(
                          "[${inventorySizeRange.start}, ${inventorySizeRange.end}]",
                          style: TextStyle(
                            color: kLightGreyColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: RangeSlider(
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
