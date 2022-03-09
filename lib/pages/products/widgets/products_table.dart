import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/products/widgets/product_tile_large.dart';
import 'package:whaloo_genuinity/pages/products/widgets/product_tile_small.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_menu.dart';

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
            return ListTile(
              hoverColor: Colors.transparent,
              dense: false,
              title: ProductTile(product: product),
              contentPadding: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: kSpacing,
                right: kSpacing,
              ),
              trailing: ProductsMenu(product: product),
              onTap: () {
                Get.showSnackbar(
                  GetSnackBar(
                    snackPosition: SnackPosition.TOP,
                    titleText: Text(
                      product.title,
                      style: TextStyle(color: kLightColor),
                    ),
                    duration: const Duration(seconds: 1),
                    messageText: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        product.image,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.broken_image_rounded,
                          color: kLightGreyColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
