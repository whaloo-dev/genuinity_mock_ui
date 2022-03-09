import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';

class ProductsMenu extends StatelessWidget {
  final Product product;
  const ProductsMenu({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        Get.snackbar("", value);
      },
      // iconSize: 10,

      elevation: kElevation,
      // shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (context) => <PopupMenuItem<String>>[
        PopupMenuItem(
            value: "Action1 on ${product.title}", child: const Text("Action1")),
        PopupMenuItem(
            value: "Action2 on ${product.title}", child: const Text("Action2")),
        PopupMenuItem(
            value: "Action3 on ${product.title}", child: const Text("Action3")),
      ],
    );
  }
}
