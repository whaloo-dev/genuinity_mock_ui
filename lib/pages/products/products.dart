import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_search_bar.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_table.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: ProductsSearchBar()),
            Row(
              children: [
                PopupMenuButton<Widget>(
                  // enabled: false,
                  elevation: kElevation,
                  shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
                  icon: const Icon(Icons.more_vert_rounded),
                  itemBuilder: (context) => <PopupMenuItem<Widget>>[
                    const PopupMenuItem(child: Text("Action1")),
                    const PopupMenuItem(child: Text("Action2")),
                    const PopupMenuItem(child: Text("Action3")),
                  ],
                ),
              ],
            ),
          ],
        ),
        //  SizedBox(height: kSpacing),
        Obx(() {
          if (productsController.isEditingSearch.value) {
            return SizedBox(
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Launch search "),
                    IconButton(
                        splashRadius: kIconButtonSplashRadius,
                        color: kActiveColor,
                        onPressed: () {
                          productsController.changeSearchFilter(
                              productsController.searchText.value);
                        },
                        icon: const Icon(Icons.search_rounded))
                  ],
                ),
              ),
            );
          }
          return const Expanded(child: ProductsTable());
        }),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
