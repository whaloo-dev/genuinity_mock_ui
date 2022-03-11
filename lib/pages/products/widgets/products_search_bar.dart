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
    return Obx(() {
      if (productsController.searchText.isEmpty) {
        searchFieldController =
            TextEditingController(text: productsController.searchText.value);
      }
      return Column(
        children: [
          TextField(
            enableSuggestions: true,
            enabled: !productsController.isLoadingData.value,
            onChanged: (value) {
              productsController.isEditingSearch(true);
              productsController.searchText.value = value;
            },
            onSubmitted: (value) {
              productsController.applyFilter();
            },
            controller: searchFieldController,
            decoration: InputDecoration(
              label: const Text("Search by product"),
              // prefixIcon: _prefixWidget(),
              suffixIcon: _suffixWidget(searchFieldController),
            ),
          ),
          const SizedBox(height: 2),
          if (!productsController.isEditingSearch.value)
            Row(
              children: [
                if (productsController.isInventorySizeRangeSet())
                  _inventoryRangeWidget(),
              ],
            ),
        ],
      );
    });
  }

  Widget _inventoryRangeWidget() {
    var start = productsController.inventorySizeRange.value.start;
    var end = productsController.inventorySizeRange.value.end;
    return Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: kLightGreyColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Inventory : [$start, $end]",
              style: TextStyle(
                color: kDarkColor.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                productsController.resetInventorySizeRange();
              },
              child: const Icon(
                Icons.cancel,
                size: 12,
              ),
            ),
          ],
        ));
  }

  Widget _suffixWidget(TextEditingController seachFieldController) {
    int productsCount = productsController.productsCount();
    bool showSearch = (productsController.isEditingSearch.value ||
        !productsController.isFiltered());
    bool showResultsCount =
        !showSearch && !productsController.isLoadingData.value;
    bool showCancel = productsController.isFiltered() &&
        !productsController.isLoadingData.value;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showSearch)
          IconButton(
            splashRadius: kIconButtonSplashRadius,
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              productsController.applyFilter();
            },
          ),
        if (showResultsCount)
          Text(
            "$productsCount "
            "product${productsCount == 1 ? '' : 's'}",
            style: TextStyle(color: kLightGreyColor, fontSize: 12),
          ),
        if (showCancel)
          IconButton(
            splashRadius: kIconButtonSplashRadius,
            icon: const Icon(Icons.cancel_rounded),
            onPressed: () {
              productsController.resetFilters();
            },
          ),
        Visibility(
          visible: !productsController.isEditingSearch.value,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            splashRadius: kIconButtonSplashRadius,
            icon: (productsController.isFormVisible.value)
                ? const Icon(Icons.arrow_drop_up_rounded)
                : const Icon(Icons.arrow_drop_down_rounded),
            onPressed: () {
              productsController.isFormVisible.value =
                  !productsController.isFormVisible.value;
            },
          ),
        ),
      ],
    );
  }
}
