import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsTableEmptyWidget extends StatelessWidget {
  const ProductsTableEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => productsController.isDataLoading.value
          ? const Center(
              child: Text("Loading..."),
            )
          : productsController.searchFilter.isEmpty
              ? const Center(child: Text("Add Products"))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_rounded),
                      SizedBox(height: kSpacing),
                      const Text("No Results Found"),
                    ],
                  ),
                ),
    );
  }
}
