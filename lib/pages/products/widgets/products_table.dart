import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/products/widgets/product_tile.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(() {
        final visibleProductsCount = productsController.visibleProductsCount();
        final productsCount = productsController.productsCount();
        final vendorsCount = productsController.vendors().length;
        final productTypesCount = productsController.productTypes().length;
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(thickness: 1),
          itemCount: min(visibleProductsCount + 1, productsCount),
          itemBuilder: (context, index) {
            if (index == visibleProductsCount) {
              productsController.loadMore();
              return ListTile(
                hoverColor: Colors.transparent,
                dense: true,
                title: Center(
                  child: Container(
                    padding: EdgeInsets.all(kSpacing),
                    child: Container(
                      padding: EdgeInsets.all(kSpacing),
                      child: const Text("Loading..."),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 20,
                  left: kSpacing,
                  right: kSpacing,
                ),
              );
            }
            return ProductTile(
              product: productsController.product(index),
              productIndex: index + 1,
              productsCount: productsCount,
              vendorsCount: vendorsCount,
              productTypesCount: productTypesCount,
            );
          },
        );
      }),
    );
  }
}
