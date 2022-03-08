import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_table.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchFieldCtrl = TextEditingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => TextField(
                  // enabled: productsController.isDataLoading.value,
                  onChanged: (value) {
                    productsController.isEditingSearch(true);
                  },
                  onSubmitted: (searchInput) {
                    productsController.changeSearchFilter(searchInput);
                    productsController.changeIsEditingSearch(false);
                  },
                  controller: searchFieldCtrl,
                  decoration: InputDecoration(
                    label: const Text("Search by product"),
                    suffixIcon: (productsController.isEditingSearch.value ||
                            productsController.searchFilter.isEmpty)
                        ? IconButton(
                            icon: const Icon(Icons.search_rounded),
                            onPressed: () {
                              productsController
                                  .changeSearchFilter(searchFieldCtrl.text);
                              productsController.changeIsEditingSearch(false);
                            },
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!productsController.isDataLoading.value)
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: kBorderRadius,
                                    // color: kLightColor.withOpacity(0.5),
                                  ),
                                  child: Text(
                                    "${productsController.products.length.toString()} products",
                                    style: TextStyle(color: kLightGreyColor),
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(Icons.cancel_rounded),
                                onPressed: () {
                                  searchFieldCtrl.text = "";
                                  productsController.changeSearchFilter("");
                                },
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
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
                    // SizedBox(width: kSpacing),
                    IconButton(
                        splashRadius: kIconButtonSplashRadius,
                        color: kActiveColor,
                        onPressed: () {
                          productsController
                              .changeSearchFilter(searchFieldCtrl.text);
                          productsController.changeIsEditingSearch(false);
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
