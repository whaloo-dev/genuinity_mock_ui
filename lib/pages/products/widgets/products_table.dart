import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';
import 'package:whaloo_genuinity/pages/products/widgets/products_table_empty.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(
        () => DataTable2(
          empty: const ProductsTableEmptyWidget(),
          columnSpacing: 10,
          showCheckboxColumn: true,
          showBottomBorder: true,
          headingRowHeight: 40,
          headingRowColor:
              MaterialStateProperty.all(kLightColor.withOpacity(0.4)),
          horizontalMargin: 12,
          minWidth: 200,
          dataRowHeight: 50,
          smRatio: 0.75,
          lmRatio: 1.5,
          columns: [
            const DataColumn2(
                label: Text('Codes'),
                size: ColumnSize.S,
                tooltip: "Number of codes generated for this product"),
            const DataColumn2(
                label: Text('Product'),
                size: ColumnSize.L,
                tooltip: "Product's details"),
            if (!Responsive.isScreenSmall(context))
              const DataColumn2(
                label: Text('Modified'),
                size: ColumnSize.S,
                tooltip: "Last update date",
              ),
          ],
          rows: productsController.products
              .map<DataRow>(
                (p) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        Responsive.formatNumber(context, p.codesCount),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          Expanded(child: Text(p.title)),
                          Container(
                            margin: const EdgeInsets.all(1),
                            child: Image.network(
                              p.image,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.broken_image_rounded,
                                color: kLightGreyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!Responsive.isScreenSmall(context))
                      DataCell(
                        Text(
                          Responsive.formatDate(
                            context,
                            DateTime.now(),
                          ),
                        ),
                      ),
                  ],
                ),
                // filter: (p) => p.codesCount > 0,
              )
              .toList(),
        ),
      ),
    );
  }
}
