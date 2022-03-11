import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_search_bar.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_search_form.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_table.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_table_empty.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (productsController.totalProductsCount.value != 0)
            const ProductsSearchBar(),
          SizedBox(height: kSpacing),
          Obx(() {
            if (productsController.isFormVisible.value ||
                productsController.isEditingSearch.value) {
              return const Expanded(child: ProductsSearchForm());
            }
            if (productsController.productsCount() == 0) {
              return const Expanded(child: ProductsTableEmptyWidget());
            }
            return const Expanded(child: ProductsTable());
          }),
          SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}
