import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/backend/models.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/products_search_bar.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/products_search_form.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/products_table.dart';
import 'package:whaloo_genuinity/pages/product_selector/widgets/products_table_empty.dart';

final controller = productSelectorController;

class ProductsSelector extends StatelessWidget {
  final void Function(Product selectedProduct) onSelected;
  final void Function() onCancel;

  ProductsSelector({
    Key? key,
    required this.onSelected,
    required this.onCancel,
  }) : super(key: key) {
    controller.loadInit();
  }

  // TODO cleaning
  //Widget _layout(BuildContext context, Widget content) {
  //   return Row(
  //     children: [
  //       Expanded(flex: 1, child: Container()),
  //       Expanded(
  //         flex: Responsiveness.isScreenSmall(context) ? 50 : 5,
  //         child: Column(
  //           children: [
  //             const SizedBox(height: kSpacing * 3),
  //             Expanded(
  //               child: content,
  //             ),
  //             const SizedBox(height: kSpacing * 3),
  //           ],
  //         ),
  //       ),
  //       Expanded(flex: 1, child: Container()),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        child: Column(
          children: [
            //ProductSelectorHeader(onCancel: onCancel),
            if (controller.totalProductsCount() > 0) const ProductsSearchBar(),
            (controller.isFormVisible() || controller.isEditingFilters())
                ? const Expanded(child: ProductsSearchForm())
                : (controller.productsCount() == 0)
                    ? const Expanded(child: ProductsTableEmptyWidget())
                    : Expanded(child: ProductsTable(onSelected: onSelected)),
            const SizedBox(height: kSpacing),
          ],
        ),
      ),
    );
  }
}
