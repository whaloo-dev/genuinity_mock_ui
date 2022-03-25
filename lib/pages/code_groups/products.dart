import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/code_groups/widgets/products_search_form.dart';
import 'package:whaloo_genuinity/pages/code_groups/widgets/products_table.dart';
import 'package:whaloo_genuinity/pages/code_groups/widgets/products_table_empty.dart';

final controller = productsController;

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key) {
    controller.loadInit();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          //TODO replace search bar with a better tool bar focused on codes rather than products
          // if (controller.totalProductsCount() > 0) const ProductsSearchBar(),
          (controller.isFormVisible() || controller.isEditingFilters())
              ? const Expanded(child: ProductsSearchForm())
              : (controller.productsCount() == 0)
                  ? const Expanded(child: ProductsTableEmptyWidget())
                  : const Expanded(child: ProductsTable()),
          const SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}
