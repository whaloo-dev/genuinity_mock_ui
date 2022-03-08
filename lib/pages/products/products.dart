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
                  // enableSuggestions: true,
                  // autofillHints:
                  //     productsController.allProductsNames.reactive.value,
                  onSubmitted: (searchInput) {
                    productsController.changeSearchFilter(searchInput);
                  },
                  controller: searchFieldCtrl,
                  decoration: InputDecoration(
                    label: const Text("Search"),
                    suffixIcon: productsController.searchFilter.value.isEmpty
                        ? const Icon(Icons.search_rounded)
                        : IconButton(
                            icon: const Icon(Icons.cancel_rounded),
                            onPressed: () {
                              searchFieldCtrl.text = "";
                              productsController.changeSearchFilter("");
                            },
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
        const Expanded(child: ProductsTable()),
        SizedBox(height: kSpacing),
      ],
    );
  }
}
