import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchFieldCtrl =
        TextEditingController(text: productsController.searchText.value);
    return Obx(
      () => TextField(
        enabled: !productsController.isDataLoading.value,
        onChanged: (value) {
          productsController.isEditingSearch(true);
          productsController.searchText.value = value;
        },
        onSubmitted: (searchInput) {
          productsController.changeSearchFilter(searchInput);
        },
        controller: searchFieldCtrl,
        decoration: InputDecoration(
          label: const Text("Search by product"),
          suffixIcon: (productsController.isEditingSearch.value ||
                  productsController.searchFilter.isEmpty)
              ? IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    productsController.changeSearchFilter(searchFieldCtrl.text);
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
    );
  }
}
