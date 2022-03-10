import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';

Widget productsMenu(BuildContext context, Product product) {
  final menuItems = <ProductMenuItem>[
    product.isHidden
        ? ProductMenuItem(
            text: "Unhide this product",
            icon: Icons.visibility_rounded,
            handler: () {
              productsController.unhideProduct(product);
            },
          )
        : ProductMenuItem(
            text: "Hide this product",
            icon: Icons.visibility_off_rounded,
            handler: () {
              productsController.hideProduct(product).then((value) {
                Get.showSnackbar(
                  GetSnackBar(
                    duration: const Duration(seconds: 4),
                    messageText: Row(
                      children: [
                        Text(
                          "Product hidden. ",
                          style: TextStyle(color: kLightColor),
                        ),
                        SizedBox(width: kSpacing),
                        ElevatedButton(
                          onPressed: () {
                            Get.closeCurrentSnackbar();
                            productsController.unhideProduct(product);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: kLightColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
  ];

  return PopupMenuButton<ProductMenuItem>(
    onSelected: (item) => item.handler(),
    elevation: kElevation,
    icon: const Icon(Icons.more_vert_rounded),
    itemBuilder: (context) => menuItems
        .map(
          (menuItem) => PopupMenuItem(
            value: menuItem,
            child: Row(
              children: [
                Icon(menuItem.icon),
                SizedBox(width: kSpacing),
                Text(menuItem.text),
              ],
            ),
          ),
        )
        .toList(),
  );
}

class ProductMenuItem {
  final String text;
  final IconData icon;
  final void Function() handler;

  ProductMenuItem({
    required this.text,
    required this.icon,
    required this.handler,
  });
}
