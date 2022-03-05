import 'package:whaloo_genuinity/constants/style.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ClientsTable extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ClientsTable();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 200,
        smRatio: 0.75,
        lmRatio: 1.5,
        columns: const [
          DataColumn2(size: ColumnSize.S, label: Text('Name')),
          DataColumn(label: Text('Location')),
          DataColumn(label: Text('Rating')),
          DataColumn(label: Text('Action')),
        ],
        rows: List<DataRow>.generate(
          20,
          (index) => DataRow(
            cells: [
              DataCell(Text("Client$index")),
              const DataCell(Text("Annaba")),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.deepOrange,
                      size: 18,
                    ),
                    SizedBox(width: kSpacing),
                    Text("4.$index")
                  ],
                ),
              ),
              DataCell(
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: kActiveColor, width: .5),
                    color: kLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Block Client",
                    style: TextStyle(
                      color: kActiveColor.withOpacity(.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
