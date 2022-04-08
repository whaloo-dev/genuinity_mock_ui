import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models/product.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/product_tile.dart';

final controller = productSelectorController;

class ProductsTable extends StatelessWidget {
  final void Function(Product selectedProduct) onSelected;

  const ProductsTable({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final visibleProductsCount = controller.visibleProductsCount();
        final productsCount = controller.productsCount();
        final vendorsCount = controller.vendors().length;
        final productTypesCount = controller.productTypes().length;
        return ListView.separated(
          separatorBuilder: (context, index) =>
              const Divider(thickness: 1, height: 1),
          itemCount: min(visibleProductsCount + 1, productsCount),
          itemBuilder: (context, index) {
            if (index == visibleProductsCount) {
              controller.showMore();
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
            return ProductTile(
              product: controller.product(index),
              productIndex: index + 1,
              productsCount: productsCount,
              vendorsCount: vendorsCount,
              productTypesCount: productTypesCount,
              showMenu: false,
              onSelected: onSelected,
            );
          },
        );
      },
    );
  }
}
