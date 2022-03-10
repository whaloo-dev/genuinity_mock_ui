import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/pages/products/widgets/product_tile.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) => const Divider(thickness: 1),
          itemCount: productsController.products.length,
          itemBuilder: (context, index) {
            print("ListView asking for product N°$index ");
            final product = productsController.products[index];
            return ProductTile(
              product: product,
              productIndex: index + 1,
              productsCount: productsController.products.length,
            );
          },
        ),
      ),
    );
  }
}
