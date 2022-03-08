import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Obx(
        () => DataTable2(
          empty: productsController.isDataLoading.value
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_download_rounded),
                      SizedBox(width: kSpacing),
                      const Text("Loading..."),
                    ],
                  ),
                )
              : (productsController.searchFilter.isEmpty
                  ? const Center(child: Text("Add Products"))
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.warning_rounded),
                          SizedBox(height: kSpacing),
                          const Text("No Results Found"),
                        ],
                      ),
                    )),
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
          rows: productsController.generateFromProducts(
            (p) => DataRow(
              cells: [
                DataCell(Text(Responsive.formatNumber(context, p.codesCount))),
                DataCell(
                  Row(
                    children: [
                      Expanded(child: Text(p.title)),
                      Container(
                        margin: const EdgeInsets.all(1),
                        child: Image.network(
                          p.image,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!Responsive.isScreenSmall(context))
                  DataCell(
                      Text(Responsive.formatDate(context, DateTime.now()))),
              ],
            ),
            filter: (p) => p.codesCount > 0,
          ),
        ),
      ),
    );
  }
}
