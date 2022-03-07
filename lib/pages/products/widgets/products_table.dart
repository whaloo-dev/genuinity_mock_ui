import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DataTable2(
        columnSpacing: 10,
        showCheckboxColumn: true,
        showBottomBorder: true,
        headingRowHeight: 40,
        headingRowColor:
            MaterialStateProperty.all(kLightColor.withOpacity(0.4)),
        horizontalMargin: 12,
        minWidth: 200,
        smRatio: 0.75,
        lmRatio: 1.5,
        columns: const [
          DataColumn2(size: ColumnSize.S, label: Text('Product')),
          DataColumn(label: Text('Supplier')),
          DataColumn(label: Text('Date')),
          DataColumn2(label: SizedBox(), size: ColumnSize.S),
        ],
        rows: List<DataRow>.generate(
          50,
          (index) => DataRow(
            cells: [
              DataCell(Text("Product$index")),
              DataCell(Text("Supplier$index")),
              const DataCell(Text("01/04/2022")),
              DataCell(
                Container(),
                showEditIcon: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
