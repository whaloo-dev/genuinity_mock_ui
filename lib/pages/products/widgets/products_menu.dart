import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/controllers/products_controller.dart';

Widget productsMenu(BuildContext context, Product product) {
  final _menuItems = <_ProductMenuItem>[
    // ProductMenuItem(
    //     text: "Hide this product",
    //     icon: Icons.visibility_off_rounded,
    //     handler: () {
    //       Get.closeAllSnackbars();
    //       productsController.hideProduct(product).then((value) {
    //         Get.showSnackbar(
    //           GetSnackBar(
    //             shouldIconPulse: true,
    //             duration: const Duration(seconds: 3),
    //             backgroundColor: kLightGreyColor.withOpacity(0.5),
    //             messageText: Row(
    //               children: [
    //                 Card(
    //                   elevation: 0,
    //                   clipBehavior: Clip.antiAlias,
    //                   child: Image.network(
    //                     product.image,
    //                     width: 100,
    //                     errorBuilder: (context, error, stackTrace) => Icon(
    //                       Icons.broken_image_rounded,
    //                       color: kLightGreyColor,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(width: kSpacing),
    //                 Text(
    //                   "Product hidden. ",
    //                   style: TextStyle(color: kDarkColor),
    //                 ),
    //                 SizedBox(width: kSpacing),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     Get.closeAllSnackbars();
    //                     Get.clearRouteTree();
    //                     productsController.unhideProduct(product);
    //                   },
    //                   child: Text(
    //                     "Cancel",
    //                     style: TextStyle(color: kLightColor),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    //     },
    //   ),
  ];

  return PopupMenuButton<_ProductMenuItem>(
    onSelected: (item) => item.handler(),
    elevation: kElevation,
    icon: const Icon(Icons.more_vert_rounded),
    itemBuilder: (context) => _menuItems
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

class _ProductMenuItem {
  final String text;
  final IconData icon;
  final void Function() handler;

  _ProductMenuItem({
    required this.text,
    required this.icon,
    required this.handler,
  });
}
