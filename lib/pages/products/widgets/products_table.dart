import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: Obx(
  //       () => DataTable2(
  //         // empty: const ProductsTableEmptyWidget(),

  //         columnSpacing: 10,
  //         showCheckboxColumn: true,
  //         showBottomBorder: true,
  //         headingRowHeight: 40,
  //         headingRowColor:
  //             MaterialStateProperty.all(kLightColor.withOpacity(0.4)),
  //         horizontalMargin: 12,
  //         // minWidth: 200,
  //         dataRowHeight: 50,
  //         // smRatio: 0.35,
  //         // lmRatio: 1.5,
  //         columns: [
  //           DataColumn(
  //               onSort: (columnIndex, ascending) {},
  //               label: Text('Codes'),
  //               // size: ColumnSize.S,
  //               tooltip: "Number of codes generated for this product"),
  //           const DataColumn(
  //               label: Text('Product'),
  //               // size: ColumnSize.L,
  //               tooltip: "Product's details"),
  //           if (!Responsiveness.isScreenSmall(context))
  //             const DataColumn(
  //               label: Text('Modified'),
  //               // size: ColumnSize.S,
  //               tooltip: "Last update date",
  //             ),
  //         ],
  //         rows: productsController.products
  //             .map<DataRow>(
  //               (p) => DataRow(
  //                 cells: [
  //                   DataCell(
  //                     Container(
  //                         constraints: const BoxConstraints(
  //                           minWidth: 100,
  //                         ),
  //                         child: Text(
  //                           "${Responsiveness.formatNumber(context, p.codesCount)}"
  //                           " code${p.codesCount == 1 ? '' : 's'}",
  //                         )),
  //                   ),
  //                   DataCell(
  //                     Row(
  //                       children: [
  //                         Expanded(child: Text(p.title)),
  //                         Container(
  //                           margin: const EdgeInsets.all(1),
  //                           child: Image.network(
  //                             p.image,
  //                             errorBuilder: (context, error, stackTrace) =>
  //                                 Icon(
  //                               Icons.broken_image_rounded,
  //                               color: kLightGreyColor,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   if (!Responsiveness.isScreenSmall(context))
  //                     DataCell(
  //                       Text(
  //                         Responsiveness.formatDate(
  //                           context,
  //                           DateTime.now(),
  //                         ),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               // filter: (p) => p.codesCount > 0,
  //             )
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(
        () => ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: productsController.products.length,
          itemBuilder: (context, index) => ListTile(
            hoverColor: Colors.transparent,
            dense: false,
            // contentPadding: EdgeInsets.all(kSpacing),
            leading: Container(
              margin: const EdgeInsets.all(1),
              width: 100,
              height: 100,
              // constraints: const BoxConstraints(maxWidth: 200),
              child: Image.network(
                productsController.products[index].image,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_rounded,
                  color: kLightGreyColor,
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [Text(productsController.products[index].title)],
            ),
            subtitle: Text(
              "${Responsiveness.formatNumber(context, productsController.products[index].codesCount)}"
              " code${productsController.products[index].codesCount == 1 ? '' : 's'}",
            ),
            onTap: () {
              Get.showSnackbar(GetSnackBar(
                snackPosition: SnackPosition.TOP,
                titleText: Text(
                  productsController.products[index].title,
                  style: TextStyle(color: kLightColor),
                ),
                duration: const Duration(seconds: 1),
                messageText: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    productsController.products[index].image,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image_rounded,
                      color: kLightGreyColor,
                    ),
                  ),
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
