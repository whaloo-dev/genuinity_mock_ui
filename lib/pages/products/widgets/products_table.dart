import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/helpers/responsiveness.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        child: DataTable2(
          empty: const Center(child: Text("Add Products")),
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
          columns: const [
            DataColumn2(
                label: Text('Codes'),
                size: ColumnSize.S,
                tooltip: "Number of codes generated for this product"),
            DataColumn2(
                label: Text('Product'),
                size: ColumnSize.L,
                tooltip: "Product's details"),
            DataColumn2(
              label: Text('Modified'),
              size: ColumnSize.S,
              tooltip: "Last update date",
            ),
          ],
          rows: codesController.generateFromProducts(
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
                DataCell(Text(Responsive.formatDate(context, DateTime.now()))),
              ],
            ),
            // accept: (p) => p.codesCount > 0,
          ),
          // List<DataRow>.generate(
          //   ,
          //   (index) => DataRow(
          //     cells: [
          //       DataCell(Text("Product$index")),
          //       DataCell(Text("Supplier$index")),
          //       const DataCell(Text("01/04/2022")),
          //       DataCell(
          //         Container(),
          //         showEditIcon: true,
          //         onTap: () {},
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
