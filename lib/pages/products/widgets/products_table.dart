import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        child: DataTable2(
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
            DataColumn2(size: ColumnSize.S, label: Text('Number of codes')),
            DataColumn2(size: ColumnSize.S, label: Text('Last Update')),
            DataColumn2(size: ColumnSize.L, label: Text('Product')),
            // DataColumn(label: Text('Date')),
            // DataColumn2(size: ColumnSize.S, label: SizedBox()),
          ],
          rows: codesController.generateFromProducts(
            (p) => DataRow(
              cells: [
                DataCell(Text(numberFormat.format(p.codesCount))),
                DataCell(Text(dateFormat.format(DateTime.now()))),
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
                // DataCell(
                //   Container(),
                //   showEditIcon: true,
                //   onTap: () {},
                // ),
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
