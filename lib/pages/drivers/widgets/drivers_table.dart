import 'dart:math';

import 'package:whaloo_genuinity/constants/style.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DriversTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DriversTable();

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
          DataColumn2(size: ColumnSize.S, label: Text('Name')),
          DataColumn(label: Text('Location')),
          DataColumn(label: Text('Rating')),
          DataColumn2(label: Text(''), size: ColumnSize.S),
        ],
        rows: List<DataRow>.generate(
          50,
          (index) => DataRow(
            cells: [
              DataCell(Text("Driver$index")),
              const DataCell(Text("Guelma")),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.deepOrange, size: 18),
                    SizedBox(width: kSpacing),
                    Text("${Random.secure().nextInt(50) / 10}")
                  ],
                ),
              ),
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
