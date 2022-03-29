import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/code_groups/widgets/product_tile.dart';
import 'package:whaloo_genuinity/routes/routes.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final visibleProductsCount = productsController.visibleProductsCount();
        final productsCount = productsController.productsCount();
        final vendorsCount = productsController.vendors().length;
        final productTypesCount = productsController.productTypes().length;
        return Stack(
          children: [
            ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1, height: 1),
              itemCount: min(visibleProductsCount + 1, productsCount),
              itemBuilder: (context, index) {
                if (index == visibleProductsCount) {
                  productsController.showMore();
                  return ListTile(
                    hoverColor: Colors.transparent,
                    dense: true,
                    contentPadding: const EdgeInsets.only(
                      top: 20,
                      left: kSpacing,
                      right: kSpacing,
                    ),
                    title: Center(
                      child: Container(
                        padding: const EdgeInsets.all(kSpacing),
                        child: Container(
                          padding: const EdgeInsets.all(kSpacing),
                          child: const Text("Loading..."),
                        ),
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    ProductTile(
                      product: productsController.product(index),
                      productIndex: index + 1,
                      productsCount: productsCount,
                      vendorsCount: vendorsCount,
                      productTypesCount: productTypesCount,
                      onSelected: (selectedProduct) {
                        navigationController.navigateTo(
                          codesPageRoute,
                          arguments: selectedProduct,
                        );
                      },
                    ),
                    //added space for the floating action button
                    if (index + 1 == productsCount)
                      const SizedBox(height: kSpacing * 11),
                  ],
                );
              },
            ),
            if (productsController.productsCount() != 0)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(kSpacing * 3),
                    child: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        codesCreationController.open();
                      },
                    ),
                  ),
                ),
              )
          ],
        );
      }),
    );
  }
}
