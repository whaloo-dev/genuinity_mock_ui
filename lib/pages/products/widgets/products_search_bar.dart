import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchFieldController =
        TextEditingController(text: productsController.searchText.value);
    return Obx(
      () => TextField(
        enableSuggestions: true,
        enabled: !productsController.isLoadingData.value,
        onChanged: (value) {
          productsController.isEditingSearch(true);
          productsController.searchText.value = value;
        },
        onSubmitted: (value) {
          productsController.changeSearchFilter(value);
        },
        controller: searchFieldController,
        decoration: InputDecoration(
          label: const Text("Search by product"),
          suffixIcon: _suffixWidget(searchFieldController),
        ),
      ),
    );
  }

  Widget _suffixWidget(TextEditingController seachFieldController) {
    return (productsController.isEditingSearch.value ||
            productsController.searchFilter.isEmpty)
        ? IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              productsController.changeSearchFilter(seachFieldController.text);
            },
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!productsController.isLoadingData.value)
                Text(
                  "${productsController.products.length} "
                  "product${productsController.products.length == 1 ? '' : 's'}",
                  style: TextStyle(color: kLightGreyColor, fontSize: 12),
                ),
              IconButton(
                icon: const Icon(Icons.cancel_rounded),
                onPressed: () {
                  seachFieldController.text = "";
                  productsController.changeSearchFilter("");
                },
              ),
            ],
          );
  }
}
